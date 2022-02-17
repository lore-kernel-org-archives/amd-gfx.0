Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEB0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB6210E902;
	Thu, 17 Feb 2022 14:51:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4A810E158
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3r7sf/Ssj8FdDTc3SfdfDue+AOpcCm2MWn+uHgiKrL9fjQEMD3TyUSxMGzs4WfLd92u116jBKTcV4m0lW2cPvtmKJod23obezApKbWYzJug54BxgbM3BneHFSlomhjTS46jCIK+H8OdWcFGoeh1PLasLPqcWm3z3JlHNVTcrtSFxDesWwzEDAd9N2LMJmvs/p20hoHEpqQxBDtvG5YPzLlUJ3vnAx722AMH8j95hG5gbkLqfnUAvflLGb0BK8wuq4tUvCeXFI1sQ8HTSxpNTebKs6HloG1CbEfGwxIDP4gdSBuL3DQ37RvM2752SB6j+kZnRQeZeWuOd8aGmnuJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvTLrB3rktzGggx2VH8qqdGE0Q5geuwl3Z7ZnEle/1c=;
 b=G7yKXrAtN/X4t4/LHx5m9q84CAb67be7Z7mVTnd4VlHMw86YX7LSIGFcyEfVa+lfy9ElmUpPCQeYrBuYoxmXUdRZQUHeWT7LN9ek8htNA2S0F92jOJn0j3Hy4wOpATS0R6kko7N4jRaT8XeAIqogd6kT+28upo8whg2bESIuCHJwnMOl0LaW/tnUlai6NIsMcwQNj3Cjb2xYCBbJbcmBO6K1H/gwJgds29HLKJt1hrjNzLIfdcTALEMvCXlcRlfItvoagDkFrHpS742wPNYUBjTffXOAjIsmrW2rn5FWlV4SUBH7SZjPkSCWPgBgpB0Kg7cszhHbEgfwM8kXAf6bVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvTLrB3rktzGggx2VH8qqdGE0Q5geuwl3Z7ZnEle/1c=;
 b=yu21kKfSTmz1ZMppEyJwOAtNfX0aXNZ9LLPcegw/Aer1GYJLa4OUm89zro5lbMjTKziYwCm9v0/f2jA9CqHHZ452alRSRSAUvHrp6oj3U8BIlkIcHSm9W4d0koLzIlyXTN4VRZCHXA44A/TKjTCwN2XK23lt5C1zse2m3AxywCI=
Received: from DM6PR17CA0001.namprd17.prod.outlook.com (2603:10b6:5:1b3::14)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 14:51:11 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::a4) by DM6PR17CA0001.outlook.office365.com
 (2603:10b6:5:1b3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Thu, 17 Feb 2022 14:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 14:51:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 08:51:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support for sdma 5.2.6
Date: Thu, 17 Feb 2022 09:50:58 -0500
Message-ID: <20220217145058.11956-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 453c77ce-dc31-4134-eb0f-08d9f224f031
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5501:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB55017C08CDFE8DE920089FDDF7369@SJ0PR12MB5501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4S0IfGTZFwCjdJ9ZgyQR6YAedVLsTxx42K5rSSvFK4DfSYARHSrAhP6mldpbRty3jTvWQJYe3WEKrr12Dg7C2+wAAg8O2u278UIiSGep1fgxKVUwji6bLZ4ed13dUBHUXQ1R6T/6IsaB8AxENWMHk6YYcmMRU/EXhiIPPqTJzQrCC8AxyM3WSA2Br4Vb+Y6qupW00+iNOkFTMWwqcnrCRL8SEAbCNvc8y88Uechgo1yFCAFJXHK7pTo7nL8Vipg4Ct3gGjTpUVwvYdGDK/QsTRRs9/zfUY0IjWLL5x9j/RRzbp13K9AQBJPDK1NRB4yv2kIlseGm3JnjcMZOxXkVJG90kiJ03v1nbqsf6FvDfe2iEvgt0xvGv3q5wgEX1FRWdUuv/rzMVlGN7esLR5ON60Qm+1l9suDQcbEvNbrOTKJ79gr4VPR2m+zDUSVIqLPf8saX3/z5TjbfS7lAxeUo3qw6BD7tJK0z1lNCkZoO/9noF7wfTfpS4V1eqoAWcWtTN9HfGMKmYuVsAsXuzM+ewCijEmFL+icAOLcGs3jfQlWVMHbmx+BXDrmVGhug1vJ3GPHq1FPi1fzCY6rtBEvY2z7Z1uPUIgUTQSh08GxPphp/j/0j376zKPUR9Nn5fAft00eUTZPrTNFltG11e1h315xiuB0KPYLsigoUvQum9Bjke9DDmK/1VPLtX1s9ZlyzFE1KWKLdivnk9K89yccDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(16526019)(47076005)(1076003)(4326008)(7696005)(186003)(36860700001)(316002)(336012)(6666004)(54906003)(6916009)(83380400001)(82310400004)(70206006)(8936002)(508600001)(356005)(86362001)(40460700003)(81166007)(36756003)(2906002)(70586007)(2616005)(8676002)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:51:11.0933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453c77ce-dc31-4134-eb0f-08d9f224f031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch adds support for sdma 5.2.6.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5cd812cac052..955d8d674b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1463,6 +1463,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(5, 2, 2):
 	case IP_VERSION(5, 2, 4):
 	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 6):
 	case IP_VERSION(5, 2, 3):
 	case IP_VERSION(5, 2, 1):
 	case IP_VERSION(5, 2, 7):
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 0ca365006399..dcc622e18d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -51,6 +51,7 @@ MODULE_FIRMWARE("amdgpu/beige_goby_sdma.bin");
 
 MODULE_FIRMWARE("amdgpu/vangogh_sdma.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_sdma.bin");
+MODULE_FIRMWARE("amdgpu/sdma_5_2_6.bin");
 MODULE_FIRMWARE("amdgpu/sdma_5_2_7.bin");
 
 #define SDMA1_REG_OFFSET 0x600
@@ -156,10 +157,12 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(5, 2, 3):
 		chip_name = "yellow_carp_sdma";
 		break;
+	case IP_VERSION(5, 2, 6):
+		chip_name = "sdma_5_2_6";
+		break;
 	case IP_VERSION(5, 2, 7):
 		chip_name = "sdma_5_2_7";
 		break;
-
 	default:
 		BUG();
 	}
@@ -1622,6 +1625,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	case IP_VERSION(5, 2, 1):
 	case IP_VERSION(5, 2, 4):
 	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 6):
 	case IP_VERSION(5, 2, 3):
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1649,6 +1653,11 @@ static void sdma_v5_2_get_clockgating_state(void *handle, u32 *flags)
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
+	/* AMD_CG_SUPPORT_SDMA_MGCG */
+	data = RREG32(sdma_v5_2_get_reg_offset(adev, 0, mmSDMA0_CLK_CTRL));
+	if (!(data & SDMA0_CLK_CTRL__CGCG_EN_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_SDMA_MGCG;
+
 	/* AMD_CG_SUPPORT_SDMA_LS */
 	data = RREG32_KIQ(sdma_v5_2_get_reg_offset(adev, 0, mmSDMA0_POWER_CNTL));
 	if (data & SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK)
-- 
2.35.1

