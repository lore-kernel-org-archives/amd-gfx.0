Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEB8C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 22:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB7910E33E;
	Mon, 14 Nov 2022 22:21:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D25F10E33E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668464463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DEzbZbxMDVtgKO4mt4UPz1wY8+F4/UNYjVn0w1tPxSA=;
 b=JmwekxHYxJ8D7kkOcFQj6QT+NNer2PWgPIj1R02bzDEugAzlfqZqQz70hznB/+GWLDNiFA
 7QToQHR9JbPxdNB7CAgQEW6tLLGsLEqQjwAaieP4DM2PDw3oTjKOekP0mhB8GO0PyHML1N
 jRqLaP8eWCtCqxe8fXhhcNTwEcrtXI8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-6FMgJgeyP1ayoZEDfjKcwA-1; Mon, 14 Nov 2022 17:20:59 -0500
X-MC-Unique: 6FMgJgeyP1ayoZEDfjKcwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80D9138012D2;
 Mon, 14 Nov 2022 22:20:58 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CDD22166B46;
 Mon, 14 Nov 2022 22:20:57 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/dc/dce120: Fix audio register mapping,
 stop triggering KASAN
Date: Mon, 14 Nov 2022 17:20:45 -0500
Message-Id: <20221114222046.386560-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alan Liu <HaoPing.Liu@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There's been a very long running bug that seems to have been neglected for
a while, where amdgpu consistently triggers a KASAN error at start:

  BUG: KASAN: global-out-of-bounds in read_indirect_azalia_reg+0x1d4/0x2a0 [amdgpu]
  Read of size 4 at addr ffffffffc2274b28 by task modprobe/1889

After digging through amd's rather creative method for accessing registers,
I eventually discovered the problem likely has to do with the fact that on
my dce120 GPU there are supposedly 7 sets of audio registers. But we only
define a register mapping for 6 sets.

So, fix this and fix the KASAN warning finally.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
Sending this one separately from the rest of my fixes since:

* It's definitely completely unrelated to the Gitlab 2171 issue
* I'm not sure if this is the correct fix since it's in DC

 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 1b70b78e2fa15..af631085e88c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -359,7 +359,8 @@ static const struct dce_audio_registers audio_regs[] = {
 	audio_regs(2),
 	audio_regs(3),
 	audio_regs(4),
-	audio_regs(5)
+	audio_regs(5),
+	audio_regs(6),
 };
 
 #define DCE120_AUD_COMMON_MASK_SH_LIST(mask_sh)\
-- 
2.37.3

