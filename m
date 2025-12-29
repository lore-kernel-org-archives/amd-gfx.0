Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D9FE8FDB1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 09:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BA5113655;
	Mon, 29 Dec 2025 09:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FCQw0huv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA485113655
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 09:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4CGJXKRexqyoqUt7zgU5zWoJ2GKP50JRMKQbMO0w2iDhoiDy6RsG9jlg1GIgNajA4rYXly7ZLbVrlxTIlolgKgZvgqw9PStzkY23NwZoQhCrC4KOs8WmbgFVxiTh6svghz3DhqB3TxmrocxCb7DEGvZlW4C2e2lQVHrvPYKkop/krCeZ9QSS3X3yNv7609j5exqRcjW8ZHJKFGNjAQAHJB0JLfJbF51RQcoQVGlB4d4yeVQL7VdRlyOwe22BJIKEYtKBHh0HHvSyBb0tyVp5MedcWyVfJCn84IUCMDlCKQMDnViy/RxdYt4LpYn/d0FyeNCCCHZQEDsDlE/qLER9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgLz16uOGsJcK5ecS5pFSJvajiav52JNFr2dPrTXmzg=;
 b=YzIQzFRUK5wKiYGzbCucMYEZb1ayFky7BsASpOoD4xC62Gw7ZzyNfAWTbTfDd1M5V4kwvvx+rZpv5IWq9I7a3BFy6FsJBj7O0b/c7lkRUfrQeOqj7BQlV3BCU68PjSVR1Wm5y5NLkSXDJqXPmUAWy7gS14Fse72a294SR6Gok8JncKekWwtPEkBc/jiDmbQ5qD+cQ/UP6L5w0wbN5yWLv5IRF9wJv+e7qMD5tT8RO+X8A6DpsOyZeliSJMGH4A1hALko62LHXkuyfe2/SR4108M7iAqqAvJszlnHS8H27WTUMDCa3W4Hfw4Vp2QRi+SUplkOfp/8o3vI83Ft/fNNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgLz16uOGsJcK5ecS5pFSJvajiav52JNFr2dPrTXmzg=;
 b=FCQw0huv6LAyd3Qn3/r7Q2DjcM6zrdui1xMqCvcPeGmEqw4LiWvtxmPm0oAtua0shRbeRF1mEsNGRojevKahPyvTsLdvEpd9wksskzGvbYz8ZOC6f9n05HwcWFZuq8hA7gMZaySYjr21em59CN6hQgUL7uB9EJ2BpDigC8acAbM=
Received: from BYAPR07CA0078.namprd07.prod.outlook.com (2603:10b6:a03:12b::19)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Mon, 29 Dec
 2025 09:21:08 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::3a) by BYAPR07CA0078.outlook.office365.com
 (2603:10b6:a03:12b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 09:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 09:21:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Dec
 2025 03:21:06 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Dec
 2025 03:21:06 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 29 Dec 2025 01:21:00 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/3] drm/amd/amdgpu: Schedule user queue reset on GPU
 privilege fault for gfx12
Date: Mon, 29 Dec 2025 17:19:31 +0800
Message-ID: <20251229092045.3368038-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
References: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b4a049-b3a1-4e49-5371-08de46bb994e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gqa7SEcVbFlvZOt3CoE6ktEMpePShb6iwid2oHNO6a7ggbgtQMbex8ln1jpq?=
 =?us-ascii?Q?LCq96fHz5HyQRoV3qFMqzJS6zS021WYVA1xs02Vh6LWngTwmMdBPgjLBFKj3?=
 =?us-ascii?Q?hHpgIoaPYSHtoSvnUgyHhVFKuXFP6RAVPDEvnEthGQ8+QBNucaKR5DRNR/Br?=
 =?us-ascii?Q?Gf6cILg9xK0kVY2GtENTNvvU0UiFMLiVWTF9FScmrBUktf6wuT7BP10iugXf?=
 =?us-ascii?Q?v0qM/F/XN7joqAhSu56YqM9K1WeJDnABaqpx149S2QkDu/HQUwxlCyqSuSEK?=
 =?us-ascii?Q?Lufny4m2wZ78GU9d1Tom/V/KciAzsc8VZQexR1IRrpMyxlEsNV1S4jKtufR8?=
 =?us-ascii?Q?/TH98YgKNPIZ1+sp8Quo/nNSi0VRHdX6WwVAVQXd/SP4epEJsX0KYvIRzSCN?=
 =?us-ascii?Q?teaMNKuNme6qfCLbDsQeiKQH83aIPNg0Kx9177N016W7kGxYuHkulKYlpYht?=
 =?us-ascii?Q?r1eJpfTnbek4Eym8GNW1qcVt8uyWJYNXqvhHHPfOb3O231D1qDs2uw8jyfog?=
 =?us-ascii?Q?c5XCFMdJ0wbh4YPov92pxcKTVx0M4WTpWjqaQDAXo619+IBb1t6wMwoHsAb1?=
 =?us-ascii?Q?d8bRxvbVwc+iwT2y8Qlzld4JkFtOAO3Zq7qTXyi3B2IwluJOaqHsu0jkJ26w?=
 =?us-ascii?Q?nl1Qvi4eTASfCz98slNXiRP8vaybEFD0fRHT1AQKcJwGX6e7/heuoxtaWwWu?=
 =?us-ascii?Q?9p+2NURYubuDIVnpEmle9wsC23jTN99l60H6SPsJG33V8gpoJILmvvp27bYc?=
 =?us-ascii?Q?UB0yKmjaYmlRnnUkUXW76ueAjLqYsv8T5f3GswVlMyZ4nyngsKh5npFXKA2z?=
 =?us-ascii?Q?f2owDP4uxGsPQiqR7a9uqZsWi0H0xSnsTM6ePdcJnwNp/C0IENhiWUaiGli/?=
 =?us-ascii?Q?wqIn1D/OxALZ067yNnVoJIPsx2G5NgFsUtD4xZnjfgEyhlkI1O1UMKyT73Hi?=
 =?us-ascii?Q?h/y9+UsnZ7TNNkRdjgwYv/hbOomkg7Ym3dy6dpU7RMbv09sKK9sib0LOhi1A?=
 =?us-ascii?Q?5I0GEXsafTwvQ6BXm82CiGz6Nb/MbPlPlV/OBnnoYYJUw6WfmyuCKzKuMilp?=
 =?us-ascii?Q?XyzwTBtQuUYbejzVk3hMYy4IXpQ2kinXVugv4GszOCU2jdCPx0liCORSjliN?=
 =?us-ascii?Q?3ubdyLrKQ6Fc9VOTgvsiWUfCm7N0GDUDY96OnZV3tdSHeoiMmFWGuYFhH3X7?=
 =?us-ascii?Q?goLTUctE9BVQBfENXWPstCOYD/GNZQ2gsjg1BQ8LSaqCYVt+LxGR1x9V7pw2?=
 =?us-ascii?Q?ukSa9XMzbTeBqwjHvvbmxIPikDp4OMLv8yjy290hKH/3VXlrFQYB8znYPvtW?=
 =?us-ascii?Q?roIuLtP0S7HQt/xJ6TLK+t+GDBQwiaMtklJ1ulILRN6wq8MnhezzMWnvpzMd?=
 =?us-ascii?Q?F6CfPu1Reb7o6GWgn/+vASdH9gBokmUOipWTZEkU3uNALrUI8uA4afOOv9pB?=
 =?us-ascii?Q?tqtuTtucw6qxxWicCqDQSpxbVZTBEDto3KtrjREtOc275vYli+DIYQe3VbrT?=
 =?us-ascii?Q?fbVL9ICvEO+FPK8m+T3HYT+73m1iFmgDE2AXSb1FgkWibLHN1uwf1uvnVmmb?=
 =?us-ascii?Q?zhHxamLgnp5aLKgmX2w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 09:21:07.6720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b4a049-b3a1-4e49-5371-08de46bb994e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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

When a privilege fault occurs in a user queue context, the GPU may be left in a hang state.
To handle this gracefully and recover the GPU, schedule a user queue reset via amdgpu_reset_domain_schedule.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c37..4162d30947ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -46,6 +46,7 @@
 #include "mes_v12_0.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_reset.h"
 
 #define GFX12_NUM_GFX_RINGS	1
 #define GFX12_MEC_HPD_SIZE	2048
@@ -5030,6 +5031,10 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 			BUG();
 			break;
 		}
+	} else  {
+		/*TODO: schedule a user queue reset work */
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+						&adev->userq_reset_work);
 	}
 }
 
-- 
2.49.0

