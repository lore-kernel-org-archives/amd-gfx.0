Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F404D637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFC210E89A;
	Tue, 16 Dec 2025 21:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JdK/3LGa";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2461910E89A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FofPEIKryMV+BW1id22wCP0Gqt40/HV6R4R1/UmuX5h13yCqnunfpQ6VOgD7LE3Pq7eWKBKH//2LevQqbtkjHsGM6a8O4n95R225Rdv5sWOI9/JsNTw3tYdLfiD2ADhxBgFbWEZV+GwD9ClL5zgpu2zNx/Al+Jd0NoyaonOK1CTBx/conYiiJp1i3ig/hRJTdW9NrS9hWv9liqTVIgKmmfq6cJOmmyek0WQyRxH6svaC3SJujxlpa0O1V0ee+FWtIQshYuFcCDXn9mVVkBa7BK04SoHVKpWn9qys6JBQKNnkzcm4DZSEzzrzSdGzRRsnjASAoXwQ9RXABBqI/7sJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQMWE+xERvfUETb9kw6C7ks0w112ZX89pPd6LPWJ9qY=;
 b=I1KORbBLxx8bMuEqRrtmDmwd+hb9mu3P6DsuuknsH6XiIsl3WLyuoFZiFByM2BQWbPqTxJoJqT1yoJ3M5rJW9dq75iB62svUu7ZE6pRsVrkT3pW+cPNt3VZDw+akcVv4EKWFefXAl6mSSa1uBOc5/2zfu1SECtILVq9YGbn+ceNcZZAjL9hc/vntGk2XnlUqxddw1aS6stfeOo0WMtX6Ts2Ukp87vlxTKrEkPDdbVNEBjSS+CxT0u8XLXaLLe555pHd+cHrAor41Qnw2BzkhTr+5SDkHhDJiQyXagDSBCIC6LdpCCCKZwqjnb/MN/yqQp96sS6p6PKAB6BXsFWHEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQMWE+xERvfUETb9kw6C7ks0w112ZX89pPd6LPWJ9qY=;
 b=JdK/3LGaEvc3PMXZr2i1bewXajVifLVvIhT6F7yDz/I5TNN6CCC0Zg0gb+xF0YjqePO5nn6HNV/KqCTdoy7kvQfAXX+sV2/hMe1hE48FtDYHQU9X3kjd8qa/2omisEAGjElDsZbAZ25AYXYwGk6PNUkzI3Er+wkrinXPpDxyVZo=
Received: from BN0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:e4::13)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:10:30 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::8c) by BN0PR02CA0008.outlook.office365.com
 (2603:10b6:408:e4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:10:29 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:10:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tim Huang <tim.huang@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add support for NBIO IP version 7.11.4
Date: Tue, 16 Dec 2025 16:10:06 -0500
Message-ID: <20251216211009.1963990-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216211009.1963990-1-alexander.deucher@amd.com>
References: <20251216211009.1963990-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3b3903-97d6-4acb-c42f-08de3ce78aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lrXMY4fqne0Ogua6slmHTPGuLdWmt9If1o6I4MBtO0SloeFQjPMnKDDosVMk?=
 =?us-ascii?Q?oLtaKgf2qPOJ02KFMBTcNzV8xwGReGbVHg6iVjtm/J5S0DTG31a1JdXdu4V4?=
 =?us-ascii?Q?OT+AcLs3puzthzDaI5vM7cvsVMuVWVHd20InJCxKss5i8Yyfwv1A/JhunUYN?=
 =?us-ascii?Q?vMtzFiFszGoOYRga9cCKbectCTYrWEi26qCWC/MhlZHRVi3LabRN+tFlR2PV?=
 =?us-ascii?Q?JF43FLbglx3E6H/y/f8PAX66V2Y8cEZ0v/O2FzX3XTfcByRofxjLjrb4jxc1?=
 =?us-ascii?Q?0AmFJxtvqa3s/GSZMobhKGqUuewe3GiNTQrNCn/YWRou7scdUdJkghUWfD4O?=
 =?us-ascii?Q?SEwlgTXPS976H9kJEOYkfL0uXyqB7SLveTnsyZYXoAGp+tyLBiPmaZGLUGjG?=
 =?us-ascii?Q?0nRj8ZOhi+YY1BBvZ7bocBv6C4ac7jVwMXUv1+6qMQE1MQHUnUYdnxgxhxqY?=
 =?us-ascii?Q?9mWAl1OzvMy3dMXyoV2pHK9GC3S5yRWfplEWs58cYG1YU9LErtnu4ZdP4Yxm?=
 =?us-ascii?Q?ZVWtgMcrK4cBeMXMO99Qe9ooucRwBG6qdzzNRmouecNNKstsYyMyL6CHQ4MY?=
 =?us-ascii?Q?k8OQ1AyS5dpa21CnSa86F9hJ1Cn182ieWqKEBs1waukM34+aNWMWdslDJ/QA?=
 =?us-ascii?Q?zIloYllQbunwVmymJ1qhwKlmgBLbDphV+8/ZUiR8oVrKBy9LJXiRUenRKl/o?=
 =?us-ascii?Q?ztJp8NC0l+C13CoacdToHslOCNRWAjpONpamKZn6ujXe0ipXJA3Qkg+7Fx+v?=
 =?us-ascii?Q?aRnJvXaukSb5u2RUrzhG3b03je6kOmZYISpFpU7UBCxBDTVM2LtX0ombnbSi?=
 =?us-ascii?Q?9uqkQce3mGPTiq9HBc30zudb6btqJ9JzE/O6kAW0RZ1njON2pXWFa9QNXww4?=
 =?us-ascii?Q?j42OqkwM1exmA9hOHi9p9QAfT4nusMixAUuOzOAFW6VJB5irYv2530l1xwWu?=
 =?us-ascii?Q?p8xt5DresicWaSAaI+Lamok54FY4Exr8o047iHbHjVcyYIcUCOzatIrAMxKB?=
 =?us-ascii?Q?coArOKoBjkThXEXx3CYzuWc5zpQOpslAXe4MJH2H8W0rbEfPYjz0ornU9tMY?=
 =?us-ascii?Q?Uf+nDvwIQfOk0ex1xBFVnHAYHhao4kInlEmy+pwEyIZxHO3/+3X5gwe3nNix?=
 =?us-ascii?Q?3QD9Z04ILfFxQw/GhcOQ5tzxPqZaXzTMc/gabBP5q1t3Tw9DE07D5pAUWJlB?=
 =?us-ascii?Q?RrnDJSCcqywFciGqw9PKgdyIKKwm0U7QTpp16ec/ECkflX2cef9MGoJ2mjjX?=
 =?us-ascii?Q?xDGK/qo2GRLXKMno9gXqfj3Hcko63zrEW4XYtG6eSclR5k/2hE4V6GLjX/K6?=
 =?us-ascii?Q?7JxgQYqcPDlFOdFPMoT6frE2Y5nS8iUsdvAKenFVVnKEvjzGBOVfVFiqae4d?=
 =?us-ascii?Q?I9LI3BCn/tQjaIFxGssAyiAaP+7tGNSg7t2x+qDdyLLPk6fmtkfuFv5ahCaF?=
 =?us-ascii?Q?O2MJjUO7HpiqEpMXl3V4kGwiN8rmlXuZV68KidEAyHoHXehCnS7SR5mncvu7?=
 =?us-ascii?Q?R4l65xeQ0iWlYsw4YxYAuOhYwQA1gR3TaXPT4YURZ7PnUzaKCyBElrYqdjD5?=
 =?us-ascii?Q?8BsT4rndYd0MSJaBbRY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:10:29.4047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3b3903-97d6-4acb-c42f-08de3ce78aa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

This initializes NBIO IP version 7.11.4.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      | 73 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  1 +
 4 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ba3a1eb116dfe..23f9df3ff850a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3065,6 +3065,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.hdp_flush_reg = &nbio_v7_7_hdp_flush_reg;
 		break;
 	case IP_VERSION(6, 3, 1):
+	case IP_VERSION(7, 11, 4):
 		adev->nbio.funcs = &nbif_v6_3_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbif_v6_3_1_hdp_flush_reg;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 9b4025c39e440..db14a1a326d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -30,6 +30,31 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10                                                           0x4f0aeb
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10                                                          0x4f0aec
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10                                                           0x4f0aed
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10                                                          0x4f0aee
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10                                                           0x4f0aef
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10                                                          0x4f0af0
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10                                                           0x4f0af1
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10                                                          0x4f0af2
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10                                                           0x4f0af3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10                                                          0x4f0af4
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10_BASE_IDX                                                 3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10                                                           0x4f0af5
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10_BASE_IDX                                                  3
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10                                                          0x4f0af6
+#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10_BASE_IDX                                                 3
+
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -98,7 +123,11 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct amdgpu_device *adev,
 						       S2A_DOORBELL_PORT2_RANGE_SIZE,
 						       0);
 
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10, doorbell_range);
+		} else {
+			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+		}
 	}
 }
 
@@ -140,16 +169,28 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 					       S2A_DOORBELL_PORT4_RANGE_SIZE,
 					       0);
 
-	if (instance)
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
-	else
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+		if (instance)
+			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10, doorbell_range);
+		else
+			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10, doorbell_range);
+	} else {
+		if (instance)
+			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+		else
+			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+	}
 }
 
 static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10, 0x30000007);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10, 0x3000000d);
+	} else {
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+	}
 }
 
 static void nbif_v6_3_1_enable_doorbell_aperture(struct amdgpu_device *adev,
@@ -214,7 +255,11 @@ static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
 						  S2A_DOORBELL_PORT1_RANGE_SIZE,
 						  0);
 
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10, ih_doorbell_range);
+	} else {
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+	}
 }
 
 static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
@@ -269,12 +314,20 @@ static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *adev)
 
 static u32 nbif_v6_3_1_get_pcie_index_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX);
+	}
+	else {
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+	}
 }
 
 static u32 nbif_v6_3_1_get_pcie_data_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA);
+	else
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
 }
 
 const struct nbio_hdp_flush_reg nbif_v6_3_1_hdp_flush_reg = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index bed5ef4d87889..05cbd65420d2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -279,6 +279,7 @@ static void nbio_v7_11_init_registers(struct amdgpu_device *adev)
 	case IP_VERSION(7, 11, 1):
 	case IP_VERSION(7, 11, 2):
 	case IP_VERSION(7, 11, 3):
+	case IP_VERSION(7, 11, 4):
 		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) & ~BIT(23);
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 99c4db3b2a232..4e24aeecd9efb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -965,6 +965,7 @@ static int soc21_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(7, 11, 1):
 	case IP_VERSION(7, 11, 2):
 	case IP_VERSION(7, 11, 3):
+	case IP_VERSION(7, 11, 4):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-- 
2.52.0

