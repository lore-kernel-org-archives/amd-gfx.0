Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DBDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 11:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F37F10E574;
	Mon, 28 Feb 2022 11:46:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB0810E2A0
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645891142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Grhy4tvGVEY5R3BS2D+G2b4sVPmyn1TwoVnElYjF3HA=;
 b=VVlLZ2/L2e9QHw/4ounWs/4wakqDF1pkem8jssw2jrnZjHKjk346XelSb2guA5M/KDAWOU
 p3bZrYAcghbIbqAvgKkGx8Z3Hyu9z5ixCe9dlAHjlidhF5AMazGp7kISQRgOlddyRkQw5y
 /ZTA5eSCwz7UEqTTB+R+IitN2cmDdhg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-rjHyqOyLMreAQUSnpqGfFw-1; Sat, 26 Feb 2022 10:59:01 -0500
X-MC-Unique: rjHyqOyLMreAQUSnpqGfFw-1
Received: by mail-qk1-f200.google.com with SMTP id
 q24-20020a05620a0c9800b0060d5d0b7a90so7548386qki.11
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 07:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Grhy4tvGVEY5R3BS2D+G2b4sVPmyn1TwoVnElYjF3HA=;
 b=dryzGsVjrx2tBwNjfEit+3a+EZSCpGX9lgLCANlpbws6mvPZknSWON3ZBN0B56vBcq
 zOzRQEOEfy8Gq0sIphT+rzPzSYiuTIv2/8au2cP5CqTmgLh2oPW5JqqVtLquOQoDvXuA
 JtB6bxKn7HfcKpDM0MaH9r1GaaOQZ3mEES+fRqFAi6PK+Iq7iAEsIwvbmp+O21RB/khz
 fKhdLzOU/6IBdwWQyM0xeEkfbsM10WPNkz2xuO6YJSkhuST5WVL+qWrPaJnX8vKSNcRW
 HoFjSZccHDhhrZu/LOgfPseytdPazbYOwpQeD/ERWDy5rZhMxDrCYkXOzYUB9SADi7sV
 t8lA==
X-Gm-Message-State: AOAM531F0+zykg5o9jgFs0lqSI5JNqq656LYTERvYtOWY73kC/CiaA/x
 YZUv56ok7MRk5tHBzpMxgXPpbV4cN8gIsRYiLYzOV4rNW1Z+2PXGVcLz4Hsc854uGYQSpz35U/h
 Z32hjzSQbbnhWripguz0vMa1isg==
X-Received: by 2002:a05:620a:122c:b0:47e:1445:15e8 with SMTP id
 v12-20020a05620a122c00b0047e144515e8mr7667259qkj.200.1645891141103; 
 Sat, 26 Feb 2022 07:59:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyep784W30LsjYckoKZZTZAqrxmyuQo5OmviyaAolfcaSK5XfS1laivNCE0UKTxjerrO/TlHg==
X-Received: by 2002:a05:620a:122c:b0:47e:1445:15e8 with SMTP id
 v12-20020a05620a122c00b0047e144515e8mr7667237qkj.200.1645891140834; 
 Sat, 26 Feb 2022 07:59:00 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113]) by smtp.gmail.com with ESMTPSA id
 w9-20020a05620a148900b005f188f755adsm2640064qkj.32.2022.02.26.07.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Feb 2022 07:59:00 -0800 (PST)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, nirmoy.das@amd.com, lijo.lazar@amd.com,
 tom.stdenis@amd.com, evan.quan@amd.com, kevin1.wang@amd.com,
 Amaranath.Somalapuram@amd.com
Subject: [PATCH] drm/amdgpu: Fix realloc of ptr
Date: Sat, 26 Feb 2022 07:58:51 -0800
Message-Id: <20220226155851.4176109-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 28 Feb 2022 11:46:19 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error
amdgpu_debugfs.c:1690:9: warning: 1st function call
  argument is an uninitialized value
  tmp = krealloc_array(tmp, i + 1,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~

realloc will free tmp, so tmp can not be garbage.
And the return needs to be checked.

Fixes: 5ce5a584cb82 ("drm/amdgpu: add debugfs for reset registers list")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 9eb9b440bd438..159b97c0b4ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1676,7 +1676,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
-	uint32_t *tmp;
+	uint32_t *tmp = NULL;
 	int ret, i = 0, len = 0;
 
 	do {
@@ -1688,6 +1688,10 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 		}
 
 		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto error_free;
+		}
 		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
 			ret = -EINVAL;
 			goto error_free;
-- 
2.26.3

