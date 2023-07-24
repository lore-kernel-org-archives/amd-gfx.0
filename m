Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ADFC001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA5310E2FC;
	Mon, 24 Jul 2023 12:58:56 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C8B10E28B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 08:44:04 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R8Yc24vtbzBRx5C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 16:44:02 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690188242; x=1692780243; bh=GSjQh+24fDmg268C3FAmWe759o+
 e7JqjQBA0Ouu1xsQ=; b=LOuLu5N3qJAUG+I53obzAL1Noiw+URzi25qlxflJmnM
 xwlZwQp4s13ZM5OGa+A1C5SWe0hG7pqJ9r/3gEgBsvtMkjFJtjiB2e46RoVNChTw
 GyHyria8Xz/yYLYExUiDzvw8TFt2lT9miSDretauoyUdJsV2fcdpaDKQIg1beqhv
 v9CFV8pwzsW2F0d5QCeTiBgtkbtzOz6lyjnh/a4zTu/OM070b8Ok6tLCdf0J9R0W
 WUrojCGYlhSSmPgyXhWWOEIKNg5RZRF4FmFXy7hmFEv2SCiUuIryheAznOE5dCWS
 io2+XHCDyy+vnQG8w4NP+CFx0kSbMBACfxvcW9OGezQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 6wqlALlLoYfb for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jul 2023 16:44:02 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R8Yc23Y15zB7Bvn;
 Mon, 24 Jul 2023 16:44:02 +0800 (CST)
MIME-Version: 1.0
Date: Mon, 24 Jul 2023 16:44:02 +0800
From: sunran001@208suo.com
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: open brace '{' following function definitions go
 on the next line
In-Reply-To: <be6d6605aa504964eba3476910f7140a@208suo.com>
References: <20230724071121.8710-1-xujianghui@cdjrlc.com>
 <be6d6605aa504964eba3476910f7140a@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <a026386d6759911afbb1446a9145bdec@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:34 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index c788aa7a99a9..5e408a195860 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -205,7 +205,8 @@ int smu_v12_0_set_default_dpm_tables(struct 
smu_context *smu)
  	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, 
smu_table->clocks_table, false);
  }

-int smu_v12_0_mode2_reset(struct smu_context *smu){
+int smu_v12_0_mode2_reset(struct smu_context *smu)
+{
  	return smu_cmn_send_smc_msg_with_param(smu, 
SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
  }
