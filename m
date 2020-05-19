Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E7FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA7620657
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/0CBLiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA7620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8DD6E35D;
	Tue, 19 May 2020 15:44:48 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AF36E35D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 15:44:46 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id z9so6694379qvi.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YRutuulz+e3pQe7Dl0nFWcti//PFSbcU+4dVRYu888s=;
 b=K/0CBLiUuXTXv0V91Mc1oHQ5EHsJpsjRIpzbmVC2C5FYK757sAoY0dwBks//wwcB4B
 YVuipydzSfWRtRygINMCcZGPlR/nC5kyffEX5/6zeNJ1NDRHDPt12377JMsz8589BCXR
 RH5JiexYg5cBW4ZtiCQWsx0hEt4rhBTBDUvI2Tfg3sJcevVnArI3x3SkDQ0Yd/BCBsHc
 6/bPVH8gLD45Ynaa8b0H/+xFwAgKZBt9oo4lOesUTMJCdz39OJQrqb8pAMS/q4n8rprO
 2CwbutcLf2CR/9IUm16D8x0SLwzhzo9LXg091puj4VEAmfEttsA+JU28/neG2/PPBLUI
 WLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YRutuulz+e3pQe7Dl0nFWcti//PFSbcU+4dVRYu888s=;
 b=i8gQfckPxUXDrXG3h4fWmLvmC4aXVDWoS5e9xuso8FB+pBWiTWdbji9qUz/AmH7H6Q
 Qq5/7/gGfTBeNylPBumpBqoq8oc5MMeLkG3NSeVhhHgYenPY6b4R5S7xNgpLiX9yjPTy
 2rOq9nk7Bp3bDMOqM3/TFXwyxk/DgWH2b+l53WjkUkExf1Zp5MvMJmyYqMeyp1BItpRl
 I5C+34ToluAZK9VNkz6ddf9x49d2zgGZhCF9VNlMQFPOt7c9r8z9qK0jV4VXgfcflgeG
 nwd1LZBCofEt7xFvAhPp0voaFEkOn+x7LZZQSD++Ab6p6kSi9wLUwCL2IDBDlrnz8qFv
 128Q==
X-Gm-Message-State: AOAM531pRDQrLimjAa10D8L60ty8Z58mv3HKIIV5pJQ0jP4IR3D+UuVn
 2sox6c5EywRU8V3gEKdGFUybbzNi
X-Google-Smtp-Source: ABdhPJyXqOlZgYJ1sS02TWoIjBEIKGcs/8QyWyqkRMDgWivean0YuXrWDIrcUU6GR263gCZkO8vEPg==
X-Received: by 2002:a0c:ab19:: with SMTP id h25mr207902qvb.108.1589903085177; 
 Tue, 19 May 2020 08:44:45 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id l133sm10819975qke.105.2020.05.19.08.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 08:44:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu: simplify mec2 fw check
Date: Tue, 19 May 2020 11:44:24 -0400
Message-Id: <20200519154426.1752937-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200519154426.1752937-1-alexander.deucher@amd.com>
References: <20200519154426.1752937-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check if mec2 fw exists rather than checking asic types.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4e4c9550dcf8..4d0bd149e1b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1339,8 +1339,7 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
 		   fw_info.feature, fw_info.ver);
 
 	/* MEC2 */
-	if (adev->asic_type == CHIP_KAVERI ||
-	    (adev->asic_type > CHIP_TOPAZ && adev->asic_type != CHIP_STONEY)) {
+	if (adev->gfx.mec2_fw) {
 		query_fw.index = 1;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
