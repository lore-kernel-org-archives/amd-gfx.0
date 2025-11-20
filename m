Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F57CFA450
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 22:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D16C10E7CC;
	Thu, 20 Nov 2025 22:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="26JE2M65";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013059.outbound.protection.outlook.com
 [40.107.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53BF10E7D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 22:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbNDaCiIYUVSZqyLGwDPKrp2c0FCT70CYtGVI/mPjsEz0MXkEuz7lE7lbPsMGvp17SFfOw+K9z5ZcWI1b1h0vlVrf+MMtYhKLAQ1NAC6WSLMa89Toz9aePEFUjnGaWAAQwHMuUaXtVDQCjKX3IfVLIwz4Ta6e4BQvWU9DJt5cWUK/pIh9moZShAtc+5f4lOwanQSqZj6e/tjLpWI/eSttpDil06p5BwwM0rygv6sJRHlQfgXWgGu78lIXPj7OLL3GfAhCA7WfPB3lsLwQAjgRpgZSqQGNVB0TWGfvQlU5KM8HC3WxIFFPaqk57voc5PjqbqU/878NbAexjX2+5xv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpgYWy/U7Gs69daCvKf2diacu2Iu81VLnC2f3wheSRw=;
 b=cWWyKVxzfG16jj2WX6FTCfbeoVrIU4OV2cvgY4HvpNX+mVVrriRLO8Z1Iyi71fMG1CyNdZM2PxICUXUkUIpCBm7xaxfLZpGvAiXMVKm2YCyfvMDSws6yuLe4hr2mqfM5C56oqiOiNvpFuAwqJh++SMSZrZv+cVOxBb9Fk9B7U8bCXgG9K6Jp9F4nCad55SyXOhhyZRnQlwPHgxDKdq9a73jec/xMic7m5w2c3IJ5gNXWbWQlZq0oq8cH/fpcJWqYFRvy1YWXLHf9KJcIojOZ0PzizIQiFQ8x6KzwJC3Nk56cDVwCNr9PHIPDRLVNZ+ybyrNfLJkS5lvY+MflaQK77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpgYWy/U7Gs69daCvKf2diacu2Iu81VLnC2f3wheSRw=;
 b=26JE2M65Wx+CQ5gwjVTEQ712FTgrbh1Spaw/BYapr/ecVnBEup0MBFPB6Z6EmddHDKhSf0aafNYIZryWgIgSAAKBYVSR9ju+2F2diofSpHjmmFz8I7wTzH+/6TtcWWgcBxIj2hNhlEbF8XwDJ1sAnrjOwvL/T/oJGW8ANPmnnPE=
Received: from BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::20)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 22:52:08 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::90) by BL1P223CA0015.outlook.office365.com
 (2603:10b6:208:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 22:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 22:52:08 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 14:52:05 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: add support for sdma v7_1
Date: Thu, 20 Nov 2025 17:51:48 -0500
Message-ID: <20251120225148.23345-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120225148.23345-1-alexander.deucher@amd.com>
References: <20251120225148.23345-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acc3502-9150-4177-5a86-08de28876f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DJlsl2C5O0dkmjQRkEcFkbVurtTCFwGmS1ELAVZ+hWw1sbDkR0VkxN1y9hHa?=
 =?us-ascii?Q?//jsMfjistb8jw+4g0zRgLr5OG4D9IEN1vXhXBnz1thbf0MZiBNdA83NJVWO?=
 =?us-ascii?Q?3Fvo/GCEusKmYwd84DT437anmgEnApUQdtAdDK2H31hlg1NbKGc2PXmD/ZWt?=
 =?us-ascii?Q?tyMwFNdeueW4k1qwnosIIbqF6i0g4vc2cwEZilyEVq75zqI/j3IP3347xWU5?=
 =?us-ascii?Q?efemDFj2VBBCl9tDNuY8kAw3NBOulTuxW0l88ArpzFME+oGLJVO46joW2lEu?=
 =?us-ascii?Q?ub0Jr4MlpMT1EW9ex976pErMoOn/3+4RxsvmfKzB33CYa5ruNXkctxchjjrk?=
 =?us-ascii?Q?sQgQkNYQ99JJUnqhIMbjnBeAw+R/gVNgWed4f18OhGCeqE3gzMmdowEV488j?=
 =?us-ascii?Q?5nkGKAioM304PyZ4J3jquBao+fm2XHu2bB+3U6j/yNugIYeGaG5IFk473usJ?=
 =?us-ascii?Q?03S7WahAinl7RJSqxs+Vki3bguiaUDUB0f5lWmWuSf3by+tqQ8jU680bCXKl?=
 =?us-ascii?Q?AagCEJ2jq2ROWOcntjRAQ6QW+6R97LQJFTTdRTqJW0UtXMxChTsakquzYGo0?=
 =?us-ascii?Q?NEKKfEo1K4c1PnHy/BSSRqN/mKsasQ4OdrizZsadRdn4BL0o5Tg+0kxg+1nz?=
 =?us-ascii?Q?/eZ9FC1mpIHhHvpcAEB1OAFHlya81jf6lb9c0f/AYRntKeeB2vH6edmfL6IP?=
 =?us-ascii?Q?nR/khLlnNcrduVSTuaOAFdHT5fB61CjhAcwnHue2jZgNf74ypQ2SbR+87ga9?=
 =?us-ascii?Q?NI6Rdc+TCckz8AWwZ+w2RevotbNcl8bLqj2F4eZrCxJGJ/OXM8Lg+ycYdc5d?=
 =?us-ascii?Q?Bz3WHQE473cSLoEQ31a3koZB4zL0DIscAwJOpI/yIc5FYMAclSQ3709ZnDGL?=
 =?us-ascii?Q?JPcIjjr+4dDuWl2WCQletPaD+wH6fbMbqc940rpj2y/ZwqY/KYeGQQNnEr00?=
 =?us-ascii?Q?tVS/aFP48PWR6rA/HP1HcUy9GKQbcLLYL59fj+o656YBeUw1vrisQ0mcfWXz?=
 =?us-ascii?Q?uQg1oOfrIzLkaP86GLgr+HkPUPfLJErwH1TS5tWMorjnYF/fskPyKt2BE2AN?=
 =?us-ascii?Q?VwVv0H4VbWysXb7of3kwCOblZjuC7RNc0KXLMKAc5qq+Gq3F9pYJXGusKGRS?=
 =?us-ascii?Q?o7zIisyRDca6FCctVMo94mno1NOupc9mrLZBn96oBHpPa/1XBelBjCaiA0q3?=
 =?us-ascii?Q?K/Rnt6gdmtS3sWMx+qFckWx60xbTilZvmA/4n426o97KlrMNlcwERPL62B+7?=
 =?us-ascii?Q?DHPf4SnqpUBoLpV386XvMMhZkEnusVQxu4atWm4mbE5zXwajCYt6oUWcOdCN?=
 =?us-ascii?Q?20F3OCRFwzyx0XbHpTdyzIPI0N/PuZotGKInLbu33qwtuYHuNg+txgKY546Z?=
 =?us-ascii?Q?jYcAM2MA4jsz0SqnsfhJAXP8ffTjN0Sk1LX1GtOw9PpmayObEZJ989A0wQUl?=
 =?us-ascii?Q?dUh6W01YXK8WF6OPzvldIyIxopPTlrYbDFNxiaQDfh19DSd2uEjMtvU6/S0X?=
 =?us-ascii?Q?eI7NdY+u7EaAqCV0BFh/xRafhG1pami/Y4BgcY2uigYIaMaHm2H41Pxw0cni?=
 =?us-ascii?Q?fHzPwuCb0QHfASwyuGs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:52:08.0877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acc3502-9150-4177-5a86-08de28876f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
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

Add support for SDMA v7.1.0 ip block.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e123af894e86..92c959710355f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -83,6 +83,7 @@
 #include "sdma_v5_2.h"
 #include "sdma_v6_0.h"
 #include "sdma_v7_0.h"
+#include "sdma_v7_1.h"
 #include "lsdma_v6_0.h"
 #include "lsdma_v7_0.h"
 #include "vcn_v2_0.h"
@@ -2417,6 +2418,9 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(7, 0, 1):
 		amdgpu_device_ip_block_add(adev, &sdma_v7_0_ip_block);
 		break;
+	case IP_VERSION(7, 1, 0):
+		amdgpu_device_ip_block_add(adev, &sdma_v7_1_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
-- 
2.51.1

