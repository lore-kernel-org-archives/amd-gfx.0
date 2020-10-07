Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C858C4727E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB332064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSVcAtHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB332064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D0D6E95F;
	Wed,  7 Oct 2020 16:32:26 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06B96E95D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:24 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id c23so2429051qtp.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7zJVQheShy5dw6iCWywSITm9BmSTnVhO5Rzhppn5TVc=;
 b=YSVcAtHX3AIbswojml6XdCRJuNUnemBS3eGKkLahkolxsb5ZAciFHEEODr3ArmiwZB
 c2FOAd0WT1O9R5jD0BZSvhqNHRBNZoL26qa8FK+iBc5RpNEW7TRnb9H0v/VqwFdGQGOh
 nrMn/5HaSUGiKYj116+kDAGGnqGKjuQ0QB57EFclDdb/JBa5GdNv+1rlb5ZxW4X+eYKI
 IS202sm3mjirO3Qwo5Vkh7YpUok1EKJaSHGsoYYK8iheYzS0fg7SmXHv62LVVtjH5hrb
 tJB53rGZePvK6qSrYIlwe3FE/DMKzHEyFdF4SktshuQsNmaZtSFX38gvYRT2juqN2CFE
 7T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7zJVQheShy5dw6iCWywSITm9BmSTnVhO5Rzhppn5TVc=;
 b=Yd0pNUCPWkSehxp47cxM09N7CG/L/rbyEZ1KKlA7EfKkPhYuf11feGo9Sw8WvT9lOZ
 UjA39uTWAfLJbBsbIO4n1LJ9D9btJgozUJgH9Xx6hxx9izQMdRxSvyQL2tXV+/co7M0o
 A2hMvFwAMWGSer2duGQX8wvitCpFro09xEDUALD0Hnft8MAMB67VhNVw+axMZE/tvqof
 qW7v+SfuFglU7j8mhMepIt+hfsDjEnkRuKaqyt/ZANy3nGsI8Dj4PC9+CgzihdlcrZDP
 7Z3yaNBY8v5kKGYg7YuTrsVuEhDqHQucg4UdvRhyKvErCxUsmWIuek//nlZ2ARwYElpK
 ybrg==
X-Gm-Message-State: AOAM532eHHrndXrJ2YtSlsml9EXVUbpmQHXkXZIxsQ0FvYlUn44N6LSE
 7xkjHcQ6X/YsZ+9sitgDRiBkL7aUVqs=
X-Google-Smtp-Source: ABdhPJxU8RHFC18Ize0XF7Orw+qUb3yJQDPMBNhnJsct3vZGO+g6uoWNLfwo6eH7yzbhMEgmqhvcQg==
X-Received: by 2002:ac8:5c55:: with SMTP id j21mr3912093qtj.210.1602088343907; 
 Wed, 07 Oct 2020 09:32:23 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/50] drm/amdgpu: increase size of psp fw_name string(v2)
Date: Wed,  7 Oct 2020 12:31:09 -0400
Message-Id: <20201007163135.1944186-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Increase fw_name string size so longer chip name can be stored.

v2: define macro for the length of psp fw name.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1cc3cf85b20e..d91d951d018e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2384,7 +2384,7 @@ int psp_init_asd_microcode(struct psp_context *psp,
 			   const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[30];
+	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *asd_hdr;
 	int err = 0;
 
@@ -2456,7 +2456,7 @@ int psp_init_sos_microcode(struct psp_context *psp,
 			   const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[30];
+	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *sos_hdr;
 	const struct psp_firmware_header_v1_1 *sos_hdr_v1_1;
 	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 13f56618660a..06e03851d9c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -41,6 +41,7 @@
 #define PSP_DTM_SHARED_MEM_SIZE	0x4000
 #define PSP_RAP_SHARED_MEM_SIZE	0x4000
 #define PSP_SHARED_MEM_SIZE		0x4000
+#define PSP_FW_NAME_LEN		0x24
 
 struct psp_context;
 struct psp_xgmi_node_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index d6ba6ea9a8fc..1d417367ffac 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -79,7 +79,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 	const char *chip_name;
-	char fw_name[30];
+	char fw_name[PSP_FW_NAME_LEN];
 	int err = 0;
 	const struct ta_firmware_header_v1_0 *ta_hdr;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
