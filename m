Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3315ECFD317
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 15:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83A210E2E8;
	Mon, 24 Nov 2025 15:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONbOBaif";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AA610E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 15:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtcrsTLMbPENEzVpUIfnAyfheba1A/MeIRfRip83+c5G9NduttNhwwxSwwuGpOabqKEwCqtoExsyK171mW2FwCAGt4gXw35xJ/IGrEnMKoy/XKFbrTyxeztHVyN7cxUuaNcyuQfaHxIcNkc63QGypm/Sp9sxEWk+t4AX2DfBtGDAHdhxrZEKu4G1d3bY/KscwkYdn3INM+H5HVVBbRzu5W5mVK8zul2HwHkTKskuKf84KGBcZtvAtbWBNp2Xuw2TNaNCpB+Ihu14ni8KVjPWOQGSmRh3Z0oMdxYOALjDTSF/Bpl5Xw/7j1Lh9t9Ju14QsdL85ZhpAnEI171cz17rMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m15OXKCSg154vNtx3Z+UXPeY8i2405BangV50AizSyo=;
 b=KYWFm6IcyMDuJKZnS0zxf+agmY40EJFmwODgX2Q/WlzU9QuEb+K+VMQp1adLrwFDlm03HeeNdcOCVNWerc5Rtx/9RTcDLrts3UyfXVS57PzzEK1CSPUGuCT5OmwVtyG3hQq6IRU4Jt8b8LTgA69IlJPHIZDJw3tUqTUNdswPeOLe7brsRUM0bTBgvMtwIVttVA74DOiCdUAJXsQxdVGgdw1jy+bQTB6eESe+4weMpHD53exc0aL0ki177Fda6hStI4sayKS5+jm+N0noq74MZhn/tbpFlmKSMiBymskMOaF0u14nmDEcuCyfVzxrCvCwhBiLIlkbyEgF3TaTI6efHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m15OXKCSg154vNtx3Z+UXPeY8i2405BangV50AizSyo=;
 b=ONbOBaifRq7zLMbukn/vDPtABMzplUxSzA9Z3ClA2lX6+UV3L7Xq+zn22ffLTHtk27XpQXLVFJ2Jg7/RyFY9ZoFu96JrqX9s8z4RA3aQuYxtM2+/uJqXrt+lpqBU8v/wDr1LDn6yO4HrKWd+IYjS3+t/cvP9fHmzGslwvQxcFbI=
Received: from BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::18)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 15:22:45 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::f8) by BL1P221CA0034.outlook.office365.com
 (2603:10b6:208:5b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 15:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 15:22:45 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 09:22:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add mes v12_1_0 to discovery list
Date: Mon, 24 Nov 2025 10:22:24 -0500
Message-ID: <20251124152224.428784-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124152224.428784-1-alexander.deucher@amd.com>
References: <20251124152224.428784-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e3a243-6d5b-4f33-a33a-08de2b6d51aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZnZbnT1mxzaCdVVOsLf54OJDjJoOCnWT2eOoLSquLcBawj0ZRIU93+OuNzED?=
 =?us-ascii?Q?WfnvyO9ytLwOpjg6AJhy1r3qLw1Qr/kfW9wiV8JLsjnmD6nh0QK4Bnbp7eO1?=
 =?us-ascii?Q?5TjgGDVHsPmNp35932yN4iMXbwqcPxgb+Q3epcMqlVqal2OBD+h+ymNjXq5H?=
 =?us-ascii?Q?TMztX9t6T8j6VafpHrn6yFlOPdhMIu+iEthxW98E5k+7l8i3AnUWrzYWulMM?=
 =?us-ascii?Q?TeZwQctbPOxeWVd9uP1cuvs9qFmYR+RZfajhIqwLWqotzvDQ9Ye2tbugygSQ?=
 =?us-ascii?Q?gAi/7JFrARPnn76X0KqgQkGfW+kgK1z18+806lpAIQZHpAWAAtzFiIMUaSwW?=
 =?us-ascii?Q?A2yU/3K6tJWCTmY13CJeWgvHF3r+vfOFZknyB7539qI2uHMvssEgGWXrkk+9?=
 =?us-ascii?Q?DpDt3oXOfqe5AGpoRYlEpfzskuyNvU97IDSN1XsCQ0bLdlvmXvoVM9YgpkyJ?=
 =?us-ascii?Q?r/j8Wm0+KvK89Ch8F++d4BdxfYCk/hYxE7XSrGn0HDH2nmfy0Ms/IomzXNOu?=
 =?us-ascii?Q?s7gsNoa/tHQu6U4+rk9UwLFIwUXRrOEKtm/6ORMXaiEMAgEmzjHBzQRM9rHM?=
 =?us-ascii?Q?tn5pmj2PI3OC7kKjv0085w5awT0my7m9Ts+qxuc0Pd0cQnf7TElQh6FcVeSv?=
 =?us-ascii?Q?lYQ0Lm2kFPafnIk9YaOTpxD2ruC0uaS64sM3alO5072lW8Pd2ZCWIkuEQt2G?=
 =?us-ascii?Q?ib2IPv+5ZMPvpoY2E2KdHTY7jgxS8c9q2GTsUCgY730ryG8VpvIvkJQl17IP?=
 =?us-ascii?Q?vQ8khPjtYA0svr1JiB5pFbCOmR2QUiNmZx0Iw5BQj/1jIfYRAa78hHioKG7y?=
 =?us-ascii?Q?2gppmoxZ5fa5Yhsr7Erh4QJgAxRasAKF7Iqrrd6Gimd0s0rRCIwF73JB2a4y?=
 =?us-ascii?Q?ij4Acxf0lTNIcIGEvbJ9MuXF6pBzB/rtPQRWXdoWC8iqpy7t8vFcByA4ieRp?=
 =?us-ascii?Q?t/MPtDIoQp3CouYr2YI7Lb2zPz/2Kx8ye+Q9eWm7IeSb4Rx7zbtzlsbV1unJ?=
 =?us-ascii?Q?OcqAOY6aoIAu9YAIp7c2hScuzjCh7V3DeQGPdVVSEOC8qGjcfKdZz7J1waGn?=
 =?us-ascii?Q?Lavik6/rzJ0YNLD6M3x6QzZrUx4oyb1vG5LWeFyQ5HSyHnHQ0Lx71wLkDcvd?=
 =?us-ascii?Q?4xEDGuacCm2zMaayOGDCiYAfDouVVhPm5T5dzIc/fSPhV5UW5BpQvoxM8H2L?=
 =?us-ascii?Q?792m6X7jvQIuj1rL9Rc5DZtMEoERGfm9hcLiBnBigaEvYF9uC4KT8inRlrbx?=
 =?us-ascii?Q?4R0bQz75c3oGI7gR3rd3wo2IsEuNIuN1fVgapW+EpZTpDBRZB29g2FTP0O4+?=
 =?us-ascii?Q?kyv10f6Uip4H/LSckbbvr6GhB4208gr2NIsRrO+b/R515DLxOjI6u7ZAPmFo?=
 =?us-ascii?Q?PJs5KSJXF/stY9tssy87030oXyvRIrF02tg2p4sSO+vNtKnUzZ9GAhmET04/?=
 =?us-ascii?Q?wH2vJqpjoshyx/xAaha2Ykots7r+/KOAxkKPnBEHMxIaIRgIcg38JHMpSOJn?=
 =?us-ascii?Q?6Uq3nJNkC961zrBc480XnnnOqm8kWppqRqXat4gTBeRgdU/hWnxRrs+XhywQ?=
 =?us-ascii?Q?TklQNH0MGiRsl5Zrw3M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:22:45.4329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e3a243-6d5b-4f33-a33a-08de2b6d51aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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

From: Jack Xiao <Jack.Xiao@amd.com>

Include mes v12_1_0 in the discovery list for
mes IP blocks.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c43509f95b89d..0b94a23d03b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -99,6 +99,7 @@
 #include "amdgpu_vkms.h"
 #include "mes_v11_0.h"
 #include "mes_v12_0.h"
+#include "mes_v12_1.h"
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
@@ -2566,6 +2567,13 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		if (amdgpu_uni_mes)
 			adev->enable_uni_mes = true;
 		break;
+	case IP_VERSION(12, 1, 0):
+		amdgpu_device_ip_block_add(adev, &mes_v12_1_ip_block);
+		adev->enable_mes = true;
+		adev->enable_mes_kiq = true;
+		if (amdgpu_uni_mes)
+			adev->enable_uni_mes = true;
+		break;
 	default:
 		break;
 	}
-- 
2.51.1

