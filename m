Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC7BCFA466
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 15:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC7410E2F2;
	Mon, 24 Nov 2025 15:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4wVk/vua";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B6410E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 15:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoZbbOIfDt0PCfCWYOhZhSRvHoxMjr8VvUrc3iFwv2l/M+ciRbUBFSGaibYhkqi3ewVEL17cHBEVHzm+Hh5+8IyFm1gvRxZzImRfPS1fJxMb6O3nUhBE8rWcoYlOOvbVOnic9LKG54S5aoDsD+gFWxOEvBa1dfnzqu+WYq6OqRHRfeWxMSedUbXpsiYw/Urvz6h0TQeekpOrcODkuHMdVqzpPHZQFNreZbcpSSLRi/w1SB88e1A+EwL9stc7YdV7xbWGDwzjf3dFKFWVKgXn1LHsTuQPzQS9+LX/kKzQ2R2+P797b5jf/71kpdK5id89qS2ELb7kFTEEYd5PUvL7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOcqcQnpdulCvYBnqNAdc0COT+XRIryGU5gsDwAzDtA=;
 b=B3joTkhILPHFN0RDG2h8ChI1Rq7BI+raevceYIrT5TqBRygkvp/TCJA/wvT8Fa4tSTi+UU9f8XDNiOeF6LWL+zz8etjXnRVSadvL0W9VIp/Wh3ZZMx+7NGrL1SbTmFSJZmd6wZUdF4Ux77sqYQykn9DmVUVRaojRlmVMOfK3awAK0MjwT7bCLrVqHcGUMShe4pIL64SP70XY9RodsU7yqKQ85o1lWLJrb1Hxl2eHdPSD0o/CIzCTUU/YSunM7l2cA6BdierH0uK/Q/cE13UxDegTz2Rq6B0oSu6/7S8PAwymntPctV6MHu14Hy8NmawChwxro9iE3Aju6vDNwfgPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOcqcQnpdulCvYBnqNAdc0COT+XRIryGU5gsDwAzDtA=;
 b=4wVk/vuaLFHjdK3aM9nLh5NWH8uk86LZN7F2Ugt/H9jE0frAyaVwckhBKhviif4oDImkIlUySduBdhIjw7+Ju5P436ar+MgqjAhix+hpARfNVjjgMRnohTMJcBrFZpBqak18LHt90XJcW51ko7uVbVjumhEQ4L0KfcWOxONfYu4=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 15:26:59 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::4b) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.9 via Frontend Transport; Mon,
 24 Nov 2025 15:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 15:26:59 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 09:26:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add gfx v12_1_0 to discovery list
Date: Mon, 24 Nov 2025 10:26:42 -0500
Message-ID: <20251124152642.429146-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251124152642.429146-1-alexander.deucher@amd.com>
References: <20251124152642.429146-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 09300a40-fc0f-43b7-29cb-08de2b6de913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7p6gAbJNapkmr70G/X6w+jRMVSeuBvCDFG6fWG1aJGmi5Q7dQWofIBN7FDQ?=
 =?us-ascii?Q?xY4OVaLUk2WHY+tRDT2pfFLq7kMF2S4YsO7HV3HgGOiCmIpU24BeaPhly+1Y?=
 =?us-ascii?Q?09ZKU1TBM97LCGCZFM9n7yLC9Qhd8i9dxQIMs6U28qa6l6NMlEzXHxzkqAKr?=
 =?us-ascii?Q?Z9tIrPwFi/e/vjtWPKjzgBgklOcRAQlUgi1t/7NU/vvYe7wrLY1Fg5LbuEo1?=
 =?us-ascii?Q?0IkxMP2LZikkNy3fw+Zf9AtkDnD+RtegLqz7JrJbBE1o5mDTMIcBRp1FS7TX?=
 =?us-ascii?Q?y3KWNs+kKqykvHnsEdx6OvzDacj5np82OkKAtskLAEVaGH3sEBAbT804ZM+U?=
 =?us-ascii?Q?I+nMXsVQYgPeJS7bIYkoC6bZq5rWwQXLICF+UWSuYXpQhMAsCDAeYWTy0Xqv?=
 =?us-ascii?Q?miisxm2RFG/SioNrKkPf+C5NSaz4wWxFlHfwYvp44+kyyxCoNFw+9fGYchiq?=
 =?us-ascii?Q?pSGE3B8KX/JHoX6S+Rt7/3n6Gw38YyjwVMWnUJnHpCzZda6ygCcy0LkuOFEE?=
 =?us-ascii?Q?j53F86o5JwMA529zdbImsmnoxU+HYes9o94OoyD2R0c91vC6s6C2V/e20oM1?=
 =?us-ascii?Q?c6xlnSq6TRXfOY9yBFfbg77mflySzbIjsntWCDCj5QYUMvmqMtfEd85lFS0F?=
 =?us-ascii?Q?grCbZy91wtoskuX3NrLgw/SgdYutUR6A/IUk2UtgZxz+tdSx9L8sM1zK5qZi?=
 =?us-ascii?Q?evUCQRRTPIGUUYo4KDbmjm/6sS7Ntsnrxlp4EcZxzGvCDguF8SfzucftUl63?=
 =?us-ascii?Q?cUgkBmBhpBpC4TB4MSPxLVfJVVpUP+ydyWPmizCiQuIpWG2wIwrb0vGtNLaW?=
 =?us-ascii?Q?2jsKZr1T7Ps/PFRqa9mcMy8NkVQMvmd7nawjwWDKITgsARwf0IBL0FvKKzVm?=
 =?us-ascii?Q?J9kzya66pqoJTKCTMEEy4kSxsl/oRTQPY/3yCkuX0CeQ5i9pH6F97uYDYT0f?=
 =?us-ascii?Q?5Ivy1nN2hWPzUKi2kGa9ApBmEOdt5zaxERsD3nZBSEFb69TPerjqJAKspmsy?=
 =?us-ascii?Q?ZczLZPLKRMZFdlipgT9B3xxXHDYexHpaEMPKWM0eFPWEedAnvSCuCZajDYbS?=
 =?us-ascii?Q?Sf4Mb5ztezkSX/k2HJ9ltayzqHQZao/kGVCcMVv1aisTrVuQHlSFy/BWqORJ?=
 =?us-ascii?Q?fsFDPEPdhOZ/Ieqa/+gJCi+5POV8DcHBA0NHhzlnSFTZddtgmIgmCz8LtS1t?=
 =?us-ascii?Q?aGsN47mojx2SAZ7Ic/XZRcmZoY2iOHeZmPQAx/VxzIqovmNV3vCj5jMSf7u8?=
 =?us-ascii?Q?uVUqeAuk33oND94g4XqLgaE5Y9/siotIqqKQOJHTMn8TNInaFg4sIrgo75QW?=
 =?us-ascii?Q?Okcn6G0lcXs6ISeHSjAb345uZQoF4hFI91w/xXFh2lpRGTOAHwrrIx3oNmXr?=
 =?us-ascii?Q?rmTswacgTCXwH18Eor3hj3X0RrKzV34Mx1is/BEaVxb8s9XizQwKGIf5gLx+?=
 =?us-ascii?Q?a4q/LRyVGJ9uQy/bPNb+gqiOVSBe21zbEhfTT3UXpgQlo7BrFH8N8hLyrqCn?=
 =?us-ascii?Q?ecPRRVuNk6ylwi5GCr1dbUsWoJ9Xk8ZNHCklkPDEXZwsXKaRT91DB4fShcoJ?=
 =?us-ascii?Q?ITjYIpgTh34D4lBQLRE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:26:59.4526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09300a40-fc0f-43b7-29cb-08de2b6de913
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
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

From: Likun Gao <Likun.Gao@amd.com>

Include gfx v12_1_0 in the discovery list for
gfx IP blocks

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0b94a23d03b68..ffffc60c98db5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -79,6 +79,7 @@
 #include "gfx_v10_0.h"
 #include "gfx_v11_0.h"
 #include "gfx_v12_0.h"
+#include "gfx_v12_1.h"
 #include "sdma_v5_0.h"
 #include "sdma_v5_2.h"
 #include "sdma_v6_0.h"
@@ -2363,6 +2364,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(12, 0, 1):
 		amdgpu_device_ip_block_add(adev, &gfx_v12_0_ip_block);
 		break;
+	case IP_VERSION(12, 1, 0):
+		amdgpu_device_ip_block_add(adev, &gfx_v12_1_ip_block);
+		break;
 	default:
 		dev_err(adev->dev, "Failed to add gfx ip block(GC_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, GC_HWIP, 0));
-- 
2.51.1

