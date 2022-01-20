Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5819C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1D710E5F1;
	Thu, 20 Jan 2022 11:19:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5AC910E5E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9IpJIaelhSnCN2BQbNBeD1NmbD9Di25K6Wi95mlr10iaIDopUM2THiG8I021jpkqJhEniuNgpeCYiRFox0R8sMHHnMQeLOTqMQrQg5VPGraKMXIgNfbxQIqf1ztWpPjhHN4RV+1HdDi5HbptbXIhmMWd9R7+BsmueY2UKBV0fCSqr8G4Icu5YeXsjKS68r/IGWksv5Fgqvo/ZhnipGmEdLgw7T6FWUYr+rIvvrOVkJenNvB37HSE8uSq/Eoky6FFUJdHmJs1wkRqy7e2mLnVhj7vImWRI5Lqe1dFS5KhjUhESDO9jlhwKqWpFgqanuZXbi7wAkUUcuyNJPCunD9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7i6CuwH2bhCynFfP7CNXIAOa0/q/Pc/V+pkk+I4rUI=;
 b=E2FdZ1v1AEVgvsgX4DS5UwBEngimxrQrBgzGhUJpqaJKFEpAOmCtLInGPWWUCo5Ois65V+xIx6N1fQ+VLy7554ewmlvSYbYfGK8a+xoPJVrR67jajZxuCuQAp+iU9ncE21OFw2RShE2+I/VyP+lHZT+A5NCgUgz5g1rn93WvlQzZ5GL6UaA8zRSMmKhGQw305tejYpn2XDVZ3BzqDKOIj9FQ4WE06tL/vHT56gaLWDj5q6fjN9k873567yhHPIIilH0YZCIt7sjZ/WfaxjUZv5s5HYR1OSv4iWmO+GVLroTTkECjByob55ZBfuF5sNvTUXd9DTpKMFsRXQfmX/o/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7i6CuwH2bhCynFfP7CNXIAOa0/q/Pc/V+pkk+I4rUI=;
 b=jQmGw5yyoLVD+3oZNVav1jjWTnJ2ch+xp3y/UyPrCSc1UMzvugNPgpXHyj8+QOyuopy694mdf1CvqrIBWVzdpwdMoumCJgc0ACMr7IP/7OQgJOE4gDjRQUYliDjplpo/VTs0A/WREL6he9zVGnnzBRlGCBH1vGRGS3OWT0dpIwg=
Received: from CO2PR04CA0144.namprd04.prod.outlook.com (2603:10b6:104::22) by
 MWHPR12MB1136.namprd12.prod.outlook.com (2603:10b6:300:f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Thu, 20 Jan 2022 11:19:03 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::1f) by CO2PR04CA0144.outlook.office365.com
 (2603:10b6:104::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 11:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:19:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:02 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:19:01
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx10
Date: Thu, 20 Jan 2022 19:18:47 +0800
Message-ID: <20220120111853.11674-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d20ad9-a485-4afa-ada3-08d9dc06aa8c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1136:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1136991B25A9916F5F138345FC5A9@MWHPR12MB1136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gsWiDOiSZUOern0hKKBHXG6bJrGZbppmawLXNUssRtx3nAdIkmqu91Box4hk+AZ0yRtgKX2Uc515c0JdgsIKS0IEbAzaX9KNYL/lTxoqEbmXCKRtFaSeKVFSntJZ3xPyu7ZrN5mo89S45EhdV/fCAIkhq8vdU2hwhv8HLudbI+YGG6D28y7lEtOq30BPeub+j0Cn/3hsEcshJF0hLWlf7mJScl2/qiMXgcFRR3LUTpEPHzXlQzZtFu/LXl5pTdMQ7Uhoa8yHDEm/OcogTNg1ZmfV/d1IlCFNrgYZQOOYlm7Wz9vKyH5sl5iTxrfJ0ram9S8XCkMsD7Hd2v60v5EIDnhK+8i3wROrIphh6URY17rFSZVpETcbYctAthLlJYG/DdK881/jureSpE2khDo5R8qWVzdiMhyAUon7/wvlvz4CBeuqXbz9wvnyKhF551cvSDUCS1e8jNERZ0XUUS9eOG/94Qo+Y1r+tBPMWHvCdCSObQhD6SSTzFYWeQNkgbwjc3hCEwTWy8JhOx0qNxJRj8t0rWhQfytTCAXO+AhQ1XNHpWalBHRkmS9loM4T+u6k7wUYri+vJP/BuG+QXuOcPsBjGLNG8vtd+NZ5zYbD46qlL3sYmOoqk5oGPMOTwispkxR0vRiKgRh5gstMmWRh+VIITFQz1WrhkOHuroSbUBqwkULPjBm/1YDHZy0+MY6vlRK6kqZ44iyGLqd4gg12pkQbINXXJTViu31cWH+iKPekxU+iFhhVaQWxwuiFn37XaxsD3+4aGIoyJMRHOf4vB80WWiZCO26KZzIzicaWec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(426003)(19627235002)(8936002)(70586007)(66574015)(8676002)(4326008)(6636002)(83380400001)(356005)(2616005)(70206006)(316002)(40460700001)(110136005)(36756003)(2906002)(47076005)(508600001)(82310400004)(336012)(36860700001)(1076003)(26005)(7696005)(186003)(5660300002)(81166007)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:19:03.7334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d20ad9-a485-4afa-ada3-08d9dc06aa8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1136
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch to common helper to query rlcg access flag
specified by sriov host driver for gfx10

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 41 ++------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dbe7442fb25c..588c922573e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -180,11 +180,6 @@
 #define mmRLC_SPARE_INT_0_Sienna_Cichlid               0x4ca5
 #define mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX      1
 
-#define GFX_RLCG_GC_WRITE_OLD	(0x8 << 28)
-#define GFX_RLCG_GC_WRITE	(0x0 << 28)
-#define GFX_RLCG_GC_READ	(0x1 << 28)
-#define GFX_RLCG_MMHUB_WRITE	(0x2 << 28)
-
 #define RLCG_ERROR_REPORT_ENABLED(adev) \
 	(amdgpu_sriov_reg_indirect_mmhub(adev) || amdgpu_sriov_reg_indirect_gc(adev))
 
@@ -1463,38 +1458,6 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00c00000)
 };
 
-static bool gfx_v10_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_flags, u32 hwip,
-				 int write, u32 *rlcg_flag)
-{
-	switch (hwip) {
-	case GC_HWIP:
-		if (amdgpu_sriov_reg_indirect_gc(adev)) {
-			*rlcg_flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
-
-			return true;
-		/* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_RLC enabled simultaneously */
-		} else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
-			*rlcg_flag = GFX_RLCG_GC_WRITE_OLD;
-
-			return true;
-		}
-
-		break;
-	case MMHUB_HWIP:
-		if (amdgpu_sriov_reg_indirect_mmhub(adev) &&
-		    (acc_flags & AMDGPU_REGS_RLC) && write) {
-			*rlcg_flag = GFX_RLCG_MMHUB_WRITE;
-			return true;
-		}
-
-		break;
-	default:
-		DRM_DEBUG("Not program register by RLCG\n");
-	}
-
-	return false;
-}
-
 static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32_t flag)
 {
 	static void *scratch_reg0;
@@ -1575,7 +1538,7 @@ static void gfx_v10_sriov_wreg(struct amdgpu_device *adev, u32 offset, u32 value
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
-	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 1, &rlcg_flag)) {
+	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
 		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
 		return;
 	}
@@ -1591,7 +1554,7 @@ static u32 gfx_v10_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_fl
 	u32 rlcg_flag;
 
 	if (!amdgpu_sriov_runtime(adev) &&
-	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 0, &rlcg_flag))
+	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
 		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
 
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
-- 
2.17.1

