Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CD4C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DC620757
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GLBIxEou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DC620757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0576E0E1;
	Fri,  3 Apr 2020 10:55:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B296E0E1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHyA/q1VogoMitWGwzF0qY38QnuTs+ejO0jWi2De+edD1SBdJnY+ZPh4k4Lmuqi9l7RBwLEyGqSZycXKuCbq2EjUW0WQy/WeslVTOvNfzrGSSPmkO/UW5wg0H+J/gY9XPyO4X61yFb/PBhulq8zbwO7L8RLH6q9Rg90EQOqCrz3uUjpLxrPtT1y9c6viMiSzNGaPTlKaHuJdPRE5vkce5SphHR6eeLdzHfYzqdqKH1DsPUCdxCLuuRsS5B73gK++V1tPMjyC9xcRoRHXVsF/rMP+ne4IbNGHLZl5/L9YfdaCertg6rnRFbaf9IdnwyilBhW3kIKhacPBRcMds+uuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7R6Pi9NnGyesk0W2hqMQ8guAi8RrVXwRmTIGAqYDbE=;
 b=ExVLtWwQLK/K3AvDoXYeGkuOHx35zo7vJajVu05DWg1/Wg0jJ0BZ/s7w2pMd0l3L6Pu+yEADbxo7i0nJI83g/xaq5JuQzWT8neulTn7X1omLTyfaDDRtzs9PsZE37UE2Mu7ix4VNR4FO3ZI7msP8aXCIBEA2ln0LqlO+DtpBte45pMjzg5hTaF2QYW9yE8wsJn3OQbjUHIhBVY4bWOe6dYZQ0zlkdprB3svw9PbfifCfdSM0riAPO42MFBYtYBGD9eas8PVFjv+pzYPM4T4jpIomDASUAaHTfpAOTrVzbTs/+qzCAqOzGszw6CkScuF6z3oUWjkBx5AxjbSwWbob4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7R6Pi9NnGyesk0W2hqMQ8guAi8RrVXwRmTIGAqYDbE=;
 b=GLBIxEouY4mVjkMcwlztnVDxq0kAVnrUZ+g65Z7rCnrm6STMLUmHmMASam3WrpA3tlk1pdcFIQS45DHiEQFEVGEAi86UGi+ds65qx1WTTZVeT9+iNFXYIscfW0Ss/fNpoae9YVdmnY7nNKI/SVHJmH+L6LSmuh+F5GgTSoHesNY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 10:55:53 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 10:55:53 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu: replace indirect mmio access in non-dc code
 path
Date: Fri,  3 Apr 2020 18:55:26 +0800
Message-Id: <1585911330-27664-3-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
References: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 10:55:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90086dcd-f147-4905-f818-08d7d7bd944e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:|DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38334BFABB2F6B822CF15E61FCC70@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(8936002)(36756003)(7696005)(66556008)(66946007)(5660300002)(81156014)(66476007)(52116002)(8676002)(81166006)(186003)(4326008)(2616005)(956004)(26005)(16526019)(86362001)(6666004)(478600001)(6916009)(6486002)(2906002)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DOxnvlP2LgfQXAM2H2l5LGgcN0eXgpNHI7gt7qRCIZedoG+QHqhSy6PLI4NOCHxzLPX2yRvVk1vqXjNN1bsTQ8zfdGjX9q9rv0WtQGJJjsm2hH7AwDkNvfgszRxoJLmwFJmdzrqmRhH80BiWXnU2zbM6gx6H9Ju93KzbwuNW7jRR7wZNsbGFliiugmYhDYq98C0/wCHUSeVLH9U5ay5cyCXig5VqrOZ2xD4suGjYmzd9xXjDcJXhor+r8PnPgKCJ7n7c5nBbfWlR02jkczLg3oiE4QaZx5H8cPy5kmNlamV+MrL9K4QUgzHWccxLnYvP1RxhE7e4OY/AjEDmTbGVrpW/t95yheR+Grv/HT+xHIAhxeeXwOT5vT7AzPRwQmns8s4bMrgwcWgkV0W/NEIFxlp5ew7hmSHzd3JX47plq+AihlxY7uKPWaSS0x7hXV3
X-MS-Exchange-AntiSpam-MessageData: Zb+xMTJLQhdV5CIZT3gUYC/Edtr4qUcD6PMsBbhDlhIfIFevgZv8kyDC9vdtvroPq22w9P3Hse5mtDFeLbZssDVOhFsrw+dj1biGtxA3cf20LT7tQaNkBzQsySEjvGhhL4PhEFayDkkmE1+iAN5hmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90086dcd-f147-4905-f818-08d7d7bd944e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:55:53.6135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9MZPgqRmPT67onrwVL0aJNNCXc88V6g1bxXxWk3on4NihW084m3oUfwKijSJohec48J6xhWFzLbdAyHHlGwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

all the mmCUR_CONTROL instances are in mmr range and
can be accessd directly by using RREG32/WREG32

Change-Id: I156f760276bddf6dec8936952a371c0255ab1b42
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 14 +++++++-------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 40d2ac7..a777240 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2303,9 +2303,9 @@ static void dce_v10_0_hide_cursor(struct drm_crtc *crtc)
 	struct amdgpu_device *adev = crtc->dev->dev_private;
 	u32 tmp;
 
-	tmp = RREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
+	tmp = RREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
 	tmp = REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_EN, 0);
-	WREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
+	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
 }
 
 static void dce_v10_0_show_cursor(struct drm_crtc *crtc)
@@ -2319,10 +2319,10 @@ static void dce_v10_0_show_cursor(struct drm_crtc *crtc)
 	WREG32(mmCUR_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
 	       lower_32_bits(amdgpu_crtc->cursor_addr));
 
-	tmp = RREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
+	tmp = RREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
 	tmp = REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_MODE, 2);
-	WREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
+	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
 }
 
 static int dce_v10_0_cursor_move_locked(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 898ef72..fb3961d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2382,9 +2382,9 @@ static void dce_v11_0_hide_cursor(struct drm_crtc *crtc)
 	struct amdgpu_device *adev = crtc->dev->dev_private;
 	u32 tmp;
 
-	tmp = RREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
+	tmp = RREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
 	tmp = REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_EN, 0);
-	WREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
+	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
 }
 
 static void dce_v11_0_show_cursor(struct drm_crtc *crtc)
@@ -2398,10 +2398,10 @@ static void dce_v11_0_show_cursor(struct drm_crtc *crtc)
 	WREG32(mmCUR_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
 	       lower_32_bits(amdgpu_crtc->cursor_addr));
 
-	tmp = RREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
+	tmp = RREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
 	tmp = REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_MODE, 2);
-	WREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
+	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
 }
 
 static int dce_v11_0_cursor_move_locked(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index db15a11..36933e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2194,9 +2194,9 @@ static void dce_v6_0_hide_cursor(struct drm_crtc *crtc)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = crtc->dev->dev_private;
 
-	WREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
-		   (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
-		   (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
+	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
+	       (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
+	       (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
 
 
 }
@@ -2211,10 +2211,10 @@ static void dce_v6_0_show_cursor(struct drm_crtc *crtc)
 	WREG32(mmCUR_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
 	       lower_32_bits(amdgpu_crtc->cursor_addr));
 
-	WREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
-		   CUR_CONTROL__CURSOR_EN_MASK |
-		   (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
-		   (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
+	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
+	       CUR_CONTROL__CURSOR_EN_MASK |
+	       (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
+	       (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index f06c902..8399021 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2205,9 +2205,9 @@ static void dce_v8_0_hide_cursor(struct drm_crtc *crtc)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = crtc->dev->dev_private;
 
-	WREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
-		   (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
-		   (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
+	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
+	       (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
+	       (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
 }
 
 static void dce_v8_0_show_cursor(struct drm_crtc *crtc)
@@ -2220,10 +2220,10 @@ static void dce_v8_0_show_cursor(struct drm_crtc *crtc)
 	WREG32(mmCUR_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
 	       lower_32_bits(amdgpu_crtc->cursor_addr));
 
-	WREG32_IDX(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
-		   CUR_CONTROL__CURSOR_EN_MASK |
-		   (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
-		   (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
+	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
+	       CUR_CONTROL__CURSOR_EN_MASK |
+	       (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
+	       (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
 }
 
 static int dce_v8_0_cursor_move_locked(struct drm_crtc *crtc,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
