Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0EC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 14:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700C5613FF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 14:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700C5613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162CA6E0FF;
	Fri,  4 Jun 2021 14:50:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E746E0FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 14:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoWJdD3cP4ASzupJBmvmUrsPHk1a2jDaMHPR8jGTA4WwD83BcgLLjNwUoJzYQSR5VnWmLTpdJKXYd1KMoBtgBKB+jCzx+HLZGnT6kOwNupl1ZiYIbkgHEheJt9lN+Rtyc8NUk29igK9kpnbTBF7nox2gG6GdxZ1VHquHaUYDsTEgcCRp43lM5I1xEOMNhYkoNz23fSnPMoi8dRYtU/WVIjbsdC7lSsJPHGSrwfVbHP9m8wFOW3akl0wK8/WJV/rWivOG3vfyYJGTYVlV/c2smGmcBUSvMEJljcPOAxVJEcsImnTWZxnWwuRo8VKPBkrXQlfinSod+8hvgU2mRo75iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCLA77vdRyFrvU0hgkhaQ0eyx10NMHb46o/Nh2IysWo=;
 b=iMCR1NBi5fu1jQE6TewRTszXmiAa524i5aa2RQe5463TgdhaweZ7GqEFWzqdIFmEJDUdZVRlFWR+BmbIYT9AgsM1ESqdpgB7RpQ4ZmxXZNJ39ffYuQ1U3BZLKnUuZ+seQVEX47gMTFBFLVU8oEXpZXDGq0lbDzNUMeqWyK7IwsCkAmT2Mmoy0C/Q384rDHZ0Z3gbOB1SXHlXsYAnWoimpIAKvZdcZ5lQuXt8q2hDFLo4pKtzx+m5PvQwJ3OZW/mJubZXkO2OqTiXrgfg7TFrjqLiJyH395YrRM1aiVlv4js2ZXPQt5zSiQSpLwOmw3mbIWk9E1JpdJuz2HcfG898rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCLA77vdRyFrvU0hgkhaQ0eyx10NMHb46o/Nh2IysWo=;
 b=DWjwXwFfSmwdlJjISUPI8wwIzOr2YRg3vN1jk1KQXQ0PHIvodtprH4Q3iamP0J1Gf1p+1TN+OCOU82QFsSJVt8IPeM/iPuj1wnkaMtopBUAPiYMpZd56k9YL4OVrPhz+ZSoVQGHHYPYQg20AgxLCiXLHzeua8X2CAnqn41HSnNo=
Received: from MW2PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:302:1::31)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 14:50:03 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::9d) by MW2PR2101CA0018.outlook.office365.com
 (2603:10b6:302:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.3 via Frontend
 Transport; Fri, 4 Jun 2021 14:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 14:50:03 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 09:50:01 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alexander Deucher
 <Alexander.Deucher@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Emily
 Deng" <Emily.Deng@amd.com>, Monk Liu <Monk.Liu@amd.com>, Peng Ju Zhou
 <PengJu.Zhou@amd.com>, Horace Chen <Horace.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: Fix incorrect register offsets for Sienna Cichlid
Date: Fri, 4 Jun 2021 10:49:21 -0400
Message-ID: <20210604144921.14764-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41c13521-d179-421c-24d9-08d92768096b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4193:
X-Microsoft-Antispam-PRVS: <BY5PR12MB419334CE72FAED35A790121B873B9@BY5PR12MB4193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jE2S4ohSLYOLaIU66GpG/6BQFNdGU9yBQsVnyMf5HxvAnF1LmrVTckbjdNdlZnDEZzF/j/PlP0ste4I8zlpfxz7VTdJyFtGJNM/cVs+UO8aYhMRpsfkuBID2vVIoMlHCIAsUcyagR/3jD3ZYqICV4V9OZiwhht95mESJS/Nda3HO/YAGdSiASln75eYLsixTRzMqJWcOa8Iq0BwsUGSeEzNdTW+t5FLCHQtLfjyHDNkPTyxeBN11gjmUSFogGQ15PvS0duQ50S9pzARmpnoVZ4Cav4f8X61KddS5mQzJQD1C8rkB2PzKXfBc7Ha5WmOXiO6FGexhrfGCTMjz89tw/UmxpK9I9t5i6doD6rru97rH7P3n8mlkUe8V7YJv5jfMmkB/IyqbOg3ybosUve/21KsJiXB1uJigRiNThhwRZJcoJJjvL7/wzNM2/h/5Lz8UvgXgmhybq/U4W2qlpIkZvMUa4OYA4cvs2nNY/w1GJqmtBbcwvBzkHE7DU2yWPZ/DR0wsbPbuUcn4W3FReS/bSDwTVDbldJ+n/mxIWf2iPHt11LkLEL1+MQVv933gyYef6lpbL3UE5z1CaGgpEGqcTE/aMytWcSPBRavRmwvl//DBH/DL/83BgPP0L0T9KD3D19sUO22MJMtSnCX8Hxn3w5hCgk4g8GhWDz33TEwFvpme27O0fqaZEk9P6JkO7PDs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(36840700001)(46966006)(426003)(86362001)(70586007)(8676002)(70206006)(81166007)(110136005)(54906003)(2906002)(7696005)(8936002)(316002)(6636002)(478600001)(26005)(19627235002)(36756003)(5660300002)(36860700001)(2616005)(336012)(4326008)(47076005)(6666004)(44832011)(1076003)(16526019)(82740400003)(186003)(356005)(82310400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 14:50:03.6175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c13521-d179-421c-24d9-08d92768096b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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
Cc: Davis Ming <Davis.Ming@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RLC_CP_SCHEDULERS and RLC_SPARE_INT0 have different
offsets for Sienna Cichlid

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 11a64ca8a5ec..1e1ce1e49c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -177,6 +177,9 @@
 #define mmGC_THROTTLE_CTRL_Sienna_Cichlid              0x2030
 #define mmGC_THROTTLE_CTRL_Sienna_Cichlid_BASE_IDX     0
 
+#define mmRLC_SPARE_INT_0_Sienna_Cichlid               0x4ca5
+#define mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX      1
+
 #define GFX_RLCG_GC_WRITE_OLD	(0x8 << 28)
 #define GFX_RLCG_GC_WRITE	(0x0 << 28)
 #define GFX_RLCG_GC_READ	(0x1 << 28)
@@ -1489,8 +1492,15 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG2) * 4;
 	scratch_reg3 = adev->rmmio +
 		       (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3) * 4;
-	spare_int = adev->rmmio +
-		    (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT) * 4;
+
+	if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+		spare_int = adev->rmmio +
+			    (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX]
+			     + mmRLC_SPARE_INT_0_Sienna_Cichlid) * 4;
+	} else {
+		spare_int = adev->rmmio +
+			    (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT) * 4;
+	}
 
 	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
 	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
@@ -7410,9 +7420,15 @@ static int gfx_v10_0_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
-		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
-		tmp &= 0xffffff00;
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+			tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
+			tmp &= 0xffffff00;
+			WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
+		} else {
+			tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+			tmp &= 0xffffff00;
+			WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		}
 
 		return 0;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
