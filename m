Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3C0C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141B461164
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141B461164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79AF96EA7A;
	Thu,  8 Apr 2021 10:22:27 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750050.outbound.protection.outlook.com [40.107.75.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AABE6EA75
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 10:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSyEWOtkojeJ3AtaexgNAujFsUlMV2t3EOOH7QePJLPrGQBlHKYEDtecjM/waI3nDjMegbj8Yuh7oSK5tFQO0Ise/NeChGxoSsbtYG32ixE9YtYjS8hV156uqzC0Gh/jKOXQCVBq6iTFD5Ogr1u9UvH2F2U7Ad/bWGCzD/0NqAOsrySFmrlDg15cvUUxgyMzF5A5yyeBOHbY/O6FTSKtV6sjhjJppWV6gcf54KXsCXfiKqQQsPNaYNT1lZHrv1ShUw2RbTAScNN49LwyHpNIFCflOdcQWhi1pkCqt1bWM1yWZzODZXqG/ZarExTw3ApiebyLzmL6bHPWTRzekEIEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCbkgNlGZLDDc8v17tpLg//VVRt2uKSXTMaoVR8wqLc=;
 b=errQhNGF8Ulq7V/66iIgt27W6bUDO2U0QsoKiB1sJrdSecfPzmJovMN8MXLJuQ68DhcFs7pKkvTiZJG+9bbu43zdImiVNUehLEQ+aH4VP4hcGqJZqgJr3FO2apONWgUbjGBdkSJBIXCQmFY7ug7uoGIyOW2VqNkKg1mg5DgLcINj5WbyBg1c28euqwUPIimjte0gMT6DcWnkNSBkMGRHxSYYwta0G79HScpMwmgL4FWLbr7k3nppthN/TYRR4TGQnjoujUlG61jiZNviFmuzOvuZlQvw6XvK4eq/6/saeA8r+JRUlDBCk6rcofpIghX3WHVV2a9Em8ZO20Z2gBNnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCbkgNlGZLDDc8v17tpLg//VVRt2uKSXTMaoVR8wqLc=;
 b=qHFbX9QAcKecJG+vBX73euUa2Aq3CQbgjPHFjIqWNSy1L2AkAiHtK6Yj9xnj/ILdczrpMLGJ15eUX3jSkQqw2AZ3ZqZOMDgGwOMoiOIpxV1Zarv+hB0P4mSHGH0531qtDQN9/A4OhKGW6vWfVgavZ185emC8tUAd8PG/xNCNmL8=
Received: from BN8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:ac::36)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 10:22:22 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::4e) by BN8PR07CA0023.outlook.office365.com
 (2603:10b6:408:ac::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 10:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:22:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 05:22:21 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 8 Apr 2021 05:22:20 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: Change GC(GFX) register access from MMIO to
 RLCG
Date: Thu, 8 Apr 2021 18:22:04 +0800
Message-ID: <20210408102205.911-7-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408102205.911-1-PengJu.Zhou@amd.com>
References: <20210408102205.911-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca8f4e3-977a-482e-43cd-08d8fa78326e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5332:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5332406A367412E5EBFABFE1F8749@CH0PR12MB5332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZqsZd2zBmN6lirNQL74dEf2gbG+Ua24Plz5lyLQPnVv1I3g3GoXCS6frxfq87poamgKekHCIH9jMIX9RFEAyQ9xnBPcV5DSryZsKljP6+x6SgddsQwlUz4lDjZ8D6YGeRmV0BNOK9m//fnAsti4IYJTcbrEOcjazq2hKpM+rqWAY03PXtVO9oNc/pM2OpowaItxOC2Uy2+aZZTzTeYKzAASBuF3Dd6y01G+kNHn8NE2Mh07utsmVISl9Wwx7x26BOmRCEbGJQj1lS18WZ7q7yJuElvd6zXEH/w48ZYI4Dot1QL3IXtcexl4f0ysdUjJ+Qt4OunMXqIr38r1U5inkh/TevGs8X6JphRkzoTRlOom0538YczM0F6BOPeJSQQiKqxKr3iBMpJspMgQFz6pJTsXY+wCLMy7G00cMpUwLCpUeYQ9z1oMLYlCzFYQRiBJ6GRKthgCZJRwttdnE8sY3/eLWUHpdkA3uuq/rV4o/4O2c6YZY2pW5fveuRU5gaxFFrlhKFVC/k0e07lvHzVJCIpZaD9PueA56p0pXEAh0wSv6f9Ev0lZ8fGCpi6z9NvnazR/EHqZZlH5Byrs2AaYITSKOFrVNZd9yuHupqmcObnxr7bf7MZVuL/0lnJVRhRVMPBQVyKYSz5l2K+MX0vl8RUORGuMj6x1v5IPpiruN/iXge4wsfgoU6ImR9xMlGv4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(356005)(186003)(2616005)(7696005)(8936002)(478600001)(81166007)(2906002)(36860700001)(82740400003)(36756003)(6666004)(83380400001)(8676002)(70586007)(86362001)(47076005)(1076003)(5660300002)(316002)(26005)(6916009)(4326008)(82310400003)(70206006)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:22:22.1252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca8f4e3-977a-482e-43cd-08d8fa78326e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Change GC register access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b1d5b08e4f06..0265a082d791 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5016,17 +5016,17 @@ static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
 					}
 				}
 
-				tmp = RREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
+				tmp = RREG32_SOC15_RLC(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
 				/* only override TCP & SQC bits */
 				tmp &= 0xffffffff << (4 * max_wgp_per_sh);
 				tmp |= (utcl_invreq_disable & utcl_invreq_disable_mask);
-				WREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
+				WREG32_SOC15_RLC(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
 
-				tmp = RREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
+				tmp = RREG32_SOC15_RLC(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
 				/* only override TCP bits */
 				tmp &= 0xffffffff << (2 * max_wgp_per_sh);
 				tmp |= (gcrd_targets_disable_tcp & gcrd_targets_disable_mask);
-				WREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
+				WREG32_SOC15_RLC(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
 			}
 		}
 
@@ -5044,8 +5044,8 @@ static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)
 		tcc_disable = RREG32_SOC15_RLC(GC, 0, mmCGTS_TCC_DISABLE_gc_10_3) |
 			      RREG32_SOC15_RLC(GC, 0, mmCGTS_USER_TCC_DISABLE_gc_10_3);
 	} else {
-		tcc_disable = RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABLE) |
-			      RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DISABLE);
+		tcc_disable = RREG32_SOC15_RLC(GC, 0, mmCGTS_TCC_DISABLE) |
+			      RREG32_SOC15_RLC(GC, 0, mmCGTS_USER_TCC_DISABLE);
 	}
 
 	adev->gfx.config.tcc_disabled_mask =
@@ -5058,7 +5058,7 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	u32 tmp;
 	int i;
 
-	WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
 
 	gfx_v10_0_setup_rb(adev);
 	gfx_v10_0_get_cu_info(adev, &adev->gfx.cu_info);
@@ -6794,10 +6794,10 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 
 	/* inactivate the queue */
 	if (amdgpu_sriov_vf(adev))
-		WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
 
 	/* disable wptr polling */
-	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
+	WREG32_FIELD15_RLC(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
 
 	/* write the EOP addr */
 	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_EOP_BASE_ADDR,
@@ -7103,15 +7103,15 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 		return true;
 	default:
-		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE);
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, 0);
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
+		data = RREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE);
+		WREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
 
-		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE) == pattern) {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
+		if (RREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE) == pattern) {
+			WREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
 			return true;
 		} else {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, data);
+			WREG32_SOC15_RLC(GC, 0, mmVGT_ESGS_RING_SIZE, data);
 			return false;
 		}
 		break;
@@ -7358,9 +7358,9 @@ static int gfx_v10_0_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
-		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+		tmp = RREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
-		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 
 		return 0;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
