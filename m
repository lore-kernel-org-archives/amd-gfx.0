Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E27C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BF62073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBilRGm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BF62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BD989E5B;
	Mon,  1 Jun 2020 18:22:56 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABD48931E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:55 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id j32so8461341qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P3abu5elcIkI0jRcEMnQlaFlO0PYwnNBNKmd6q+JqEQ=;
 b=eBilRGm/Qtp86UJQxZuIaqswS5WntLRIq+VK4gaTyufFCJNoQOh4vnBrbJ5xHoVZJL
 y2JV8U08d/6KhzrS2mKU8zMjV/74HIz9d+ZkOXmA0QZ65rCNrJsdHsQI/h7198mTxPLm
 cDuYX+90SksuHE4eW8qkxhJiuV++qweiySEEIKNHYOkK0IgZV6hktdlSV+n/mDZPbfMe
 boWYIjVO3fUqkwSlMv7/AvL0AQ+z9O2gQJbd+LNPOnxRKIcF7HX0ipXV+Kv5rmjssPLy
 Sx/+xMDwBA90BGs+vNf6uugNb8HDlI54wSMbCut5Ink5IbEX/YJiJmX4ZVv9mvv+sZn8
 cr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P3abu5elcIkI0jRcEMnQlaFlO0PYwnNBNKmd6q+JqEQ=;
 b=eWK1YUjeyTAzZyQW0DneR0J0OZiS1qJuKbJlbx+eCIG564Vi69qccXX/CxpqtIoFN9
 NpSiGYIcVkUORmH6pr26GpbkaFC1KtxOCA2g+m3YTUznZhniBKQiLqxlRjSKRUYWWOQh
 DtPBNBJVSNI2AQvGxCzOdn2lpRXWUcq1ap9f0OfeeDKfbwzqYwKS/+hvTMuGQzzu9LVZ
 1Gl9QxDDRrNyMEHK6kc629P9hr1SM9ru/mMqYuBcNrXcAn3pFgUIWF8WJzX4W5LOw5EY
 p/Y0wComuKzMGlIXOWTGWK6KhYWFqfxr45u8O6X18PuwtDd/sOukGKiUY/wdRmXqF5hN
 gt1A==
X-Gm-Message-State: AOAM532SfzE536Qn1k95mJiqVIVctgJNBeIEhTmk3jKYwYARwkB+ufBe
 pTIYBbsAVDzgv98I6ERescMeJ7tm
X-Google-Smtp-Source: ABdhPJwQyichd1bZYYvC76Oh/m7lV/kKC7CqE1ipX/XeuI/jf6lSHh7q5Br33231JjDMyzghGG8eWA==
X-Received: by 2002:ac8:67d7:: with SMTP id r23mr24109097qtp.110.1591035774465; 
 Mon, 01 Jun 2020 11:22:54 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 173/207] drm/amd/powerplay: drop sienna_cichlid hardcode of
 using pptable
Date: Mon,  1 Jun 2020 14:20:20 -0400
Message-Id: <20200601182054.1267858-84-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Drop the hardcode of sienna_cichlid which will force to use softpptable,
so that it can use pptable on vbios once the value of pp_table_id get
from vbios is 0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 560f78a805b9..06b376a1396d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -366,8 +366,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 	version_major = le16_to_cpu(hdr->header.header_version_major);
 	version_minor = le16_to_cpu(hdr->header.header_version_minor);
-	if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
-	    adev->asic_type == CHIP_SIENNA_CICHLID) {
+	if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
 		pr_info("use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 		switch (version_minor) {
 		case 0:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
