Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80AC7115A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074F410E122;
	Mon, 16 Jun 2025 06:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ja6nVGZ5";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A7710E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 06:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukENKrdwOnOAcMaU64azqTbuZ1eCJqnSWplQYrifc4g7owEeLGi/frgKFYLM89deOOwzK0CNBuzULEfmV/Xqt4R+Q2Fn5QSd65dNZ3mkeU/iQKF6MU3Q76S3v2nI+sJZjrngBQe+4O1XbXY2pZi7c7q6rhCgNwQQcQ7iSqIUWgu7oOBrSaVGtyggIhAwriZ4Rd/PUgrFEgEM3T9j+4SG5O/dZeL0Tom+Ucny+azcnX5+MVjRGoZUjf3AVqJ7lxtKn7jIV5LOsuIm8VdmHD1P+q9iIXMe+d0PNjUe96OEFxTWJ0Nw4CI4cn4SyHkIU/dJfFvTqUVmpLAMcPL4wJyGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7mgSNsPyR7e6ADNOVrNOndKZV3PR69uDJgk0sBjg4o=;
 b=yZ9V1EInuERf/n41P2PbkRY3T8zAchxbZ0FZ9v2Z9VWClp5w22VXu7/IfVqZd9K0bt4Rn1Do1UcqKn+5p/XCB1Axtwrx8/2drhPZUSDLrt7MBSOg0eOGddiSoZ+Af4DF4ORHs/fSIfekV5Wlha7E2kDEoaQ1eeSXqBFUFn9w5CwqV/hTQNQm0OA6X87m01AgHTjPdPxW+1plP82d2MQSH8Nf2ZK0IkIjTBeyg35lIKd8SAWnkyPN6IBXNn1uu/dBi4u7vEo6q8UGx0YL9OBo+/0/Q2HgKivbZ3DTkwsEHyfzQDXi1WLKWW6xS+KJtNxVB3GpXlLXyBFFDCH/+Zjcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7mgSNsPyR7e6ADNOVrNOndKZV3PR69uDJgk0sBjg4o=;
 b=ja6nVGZ568COC5hXnGu/GaUrAMcZCLtRnbCzvk7MVSzKXHDVAIVKu2kGbIajG+oe2a3Za/vBF1HGlRMx9tqkxBEwnfO5hOabOdKK0s7Mo2Nz63RWJcmChyBHaLZmCwgsQKJPrTqPDedLEbqNCPI2uNMh1gABKnHFeC47oAt5xo4=
Received: from SA1P222CA0113.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::27)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Mon, 16 Jun
 2025 06:54:21 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::cc) by SA1P222CA0113.outlook.office365.com
 (2603:10b6:806:3c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 06:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 06:54:21 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 01:54:17 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add xgmi API to set max speed/width
Date: Mon, 16 Jun 2025 12:23:58 +0530
Message-ID: <20250616065400.868818-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616065400.868818-1-lijo.lazar@amd.com>
References: <20250616065400.868818-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: eff43053-137b-4277-c832-08ddaca29f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k1lOrMlzWB1iUOIYV3owaRtLZI1lKvAFWFUIxpvgpsIBpQsZg/1hHBSJqiBg?=
 =?us-ascii?Q?i7tJupEyidoak05BVmIiTsXAXDrbdNDOImVebR5qqEXKQylo48RW91OwYVGW?=
 =?us-ascii?Q?py0Ifl3kpX6dl+6Zuc6UIbdMHquA9Kw71zIZ77YSFgcLFMEmdgRNocPyKoZH?=
 =?us-ascii?Q?IkaZqXMzvXlpTE4YURoN062nxYjJDizhU7Kiq5v7XeqmJ47YnYHLnrEa25Xn?=
 =?us-ascii?Q?bKkBlUgs6Rmr7rjHJErvK9p8O7YQnLjJNUuSCPZejQk+lslMFhju+rnl6GxN?=
 =?us-ascii?Q?uhXaurt9kEOw/wNg0TsVRRQ9CGWqRC81lxzy7XRvQwh7qcs0numvPExUKjfi?=
 =?us-ascii?Q?TMk03F2tbT4si0VvaZ4sxCph3mlM0S9P+23nrB2uA6+42AL+xj4Iz+0ZqfId?=
 =?us-ascii?Q?wjC+y0B86Sf3mKSabgqnAi51mbv2Dgwr3tOWmIpBBksvIiPQ5Ee5kzyFN6kN?=
 =?us-ascii?Q?njnsyyuuN7P9jPFce6KAkuiS3z6gjx5qo5zYrXf4AXuti8vB4WBNlHc48ypA?=
 =?us-ascii?Q?X2MIv8JJWnL6V4UQeTrZkw4wIg145Hq4DIcPaiuvmNiWtrFyx8xOW1rp3irh?=
 =?us-ascii?Q?7emabAW0eJ3ImOdOCPinKEqsrGACy89Vw5b6EWdl7iI78I1EyaKMNc+TejJp?=
 =?us-ascii?Q?zKVez+mbByyoZV17rFVO4Cb9qkG5rK8+4+IzX0flXvPiKnW96dG6GKgAJk5B?=
 =?us-ascii?Q?xFKpFAywgy9Vvu7fUc0zUL+sb7MAj55NbWorA5s9zue+Suo6fCfkUzRyUdhb?=
 =?us-ascii?Q?8cNEynxeijT/8Jy5A64k18YK/3yrWx5A1/N+Be6nEBdOS0AAIs7MEoxMl3cK?=
 =?us-ascii?Q?yWoYDrHgXDW+vRxwNNbf7sAZb6BjC2YgMPmEZa98fbnhROhWTgn3Lq9I+wpL?=
 =?us-ascii?Q?EklC6EMo3DKTMnzpaLaZVsCEHE0GMXnPzDBgrOHMSzizbBIVTnTgkDI7r6Kb?=
 =?us-ascii?Q?OxDDz0PJ4VXuRZEbbiw0Hy+QhKRLoT6Uzjm6vm0Cvzo2LaxH/d7PAEmiwFqP?=
 =?us-ascii?Q?y3WyTZMVyAEr/56A5lvVjndoQM4UFcUnOvX1mDQAQ2x/VNTMC3Jm0mf4fK/U?=
 =?us-ascii?Q?i4G5C1CLO6wG7anSxPjlGWJHfpJI00XN2ppHNAe7bfvgCAz9ka8Pxa1bKPUq?=
 =?us-ascii?Q?kMG9l6aM61pbq2QXI4wuX9wiotGv9XYkKX6igGJqtAn6HN/ViuYjy09GhX+4?=
 =?us-ascii?Q?1J63YHD9Wrc8ui6iLHOeDgaB6uT6nTQzOF0h6sFtDiaNza67oCGBTTpIhru3?=
 =?us-ascii?Q?Yk4vwKRdhqWTEdfrSFaWQQ5z/WYNdCBBUttBFn1UR1Sw+eif/7K2Oaih8btJ?=
 =?us-ascii?Q?95fVXvzZapCS6dq1sZeNkEo7Z+D4wAGzArKKwlK61bF1kSbhbnhf/FttLjac?=
 =?us-ascii?Q?ZZzjfk48cRA1naIb6qscE9S+2HAfpVOSESka5QyvLrC6mYn2unn9q5biCiz1?=
 =?us-ascii?Q?2hzWNTboFUTxgSWJKQhJkg8UwANSlsWCVR/vqAws43qg3BWMKmZYMo42BkqD?=
 =?us-ascii?Q?hHv0XuI8Jqg+AXR4lgcTeA43wMWxPIGriqOn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 06:54:21.0632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff43053-137b-4277-c832-08ddaca29f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
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

Add an API to set the max possible xgmi speed/width.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 6f9997198518..1ede308a7c67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1786,3 +1786,10 @@ void amdgpu_xgmi_early_init(struct amdgpu_device *adev)
 		break;
 	}
 }
+
+void amgpu_xgmi_set_max_speed_width(struct amdgpu_device *adev,
+				    uint16_t max_speed, uint8_t max_width)
+{
+	adev->gmc.xgmi.max_speed = max_speed;
+	adev->gmc.xgmi.max_width = max_width;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 433d94f52ac3..bba0b26fee8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -124,4 +124,6 @@ int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev, int link_num);
 void amdgpu_xgmi_early_init(struct amdgpu_device *adev);
 uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
 
+void amgpu_xgmi_set_max_speed_width(struct amdgpu_device *adev,
+				    uint16_t max_speed, uint8_t max_width);
 #endif
-- 
2.25.1

