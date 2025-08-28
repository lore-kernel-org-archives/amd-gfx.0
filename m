Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86B9CA0FF2
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1D510E93D;
	Thu, 28 Aug 2025 09:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e2Q8BZMe";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7FB10E93B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giRkOg+3KF3qSbCHQWP0zYED7n+6jlgN1HOFLz6VLIktEkqU45XtDH2y4VJgm0sh2We/xv+UvMA3vqX6Iv3Gw94jYWGPFF8j9kOMz/Y2+CU4cYgHYfQnu6Au8SuIHSQjq3BT9n4evvW1w1sdk7UbuMBGLG5H+NdmFygqudGGgQqEX/ag0tFHwC/JN2NjE+yMro6CmC7z4AciomSj3ug8+jwNExRJjPGz+rbSUA3vgiLa8Ib+D8hXUhmW2fDlrKJoV8NwCH3RajDAJTbws+L1ghgdnSQtE4sHPYJk2/xTHV6pmD8jo1rpl/pxP7J6btoa4s7A9zN5uvvObB6fng1nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z3gQHsVCG+EEtLX9O6fRVEJ6H2gWp+xeuxWD1UXfsI=;
 b=Ej916AJo94aQA21Ewh/fZARngEbWSWzX0m8XPwzSgf0HrmDdV6qwgKNa68GlkfKbYSFZKR7AbkGOX5uUzTicJrvYsgboPdhKfHzFDpj3SX9mGeATfqt8T2XjeLz5/gHUcw4Od07HDerh29iMJJ2wDuSWhOgwTh8ElemOwIsKCxSftZcpmwN/aJgSR108Cy+jitrOZx7ZawiOs6j/XoBKNDfd+3JT1Ed3dWCCvA0Ezhu90AVutUwfAskTExzX4wVZsblGNeSS4YCbbqQXObf7htyOUtZdkX8xSO9AEThdoy62HNNTuqsTFnsGWDh5CRaLcF9ovhkdAjQIIkVgolJ6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z3gQHsVCG+EEtLX9O6fRVEJ6H2gWp+xeuxWD1UXfsI=;
 b=e2Q8BZMetI3CJpSbMvtn2Shney+4dBDSCuhc6Lc9xkzN7ZV44+BBaKGXb58Z1/OtsEEoMzBf7HqR5AWUhB5hMAaZrRKSYbPhdNixa8DH3/bCnl8No7Upo7SgERxF/ISxb9xcwJYc80F3+g7xD1jw9tUs72vVy2accks8NqKjGC4=
Received: from CH5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:1f1::20)
 by BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 09:15:39 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::98) by CH5PR03CA0010.outlook.office365.com
 (2603:10b6:610:1f1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Thu,
 28 Aug 2025 09:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:45:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 5/9] drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device
Date: Thu, 28 Aug 2025 12:15:26 +0530
Message-ID: <20250828064530.3948378-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 05953e0f-b2de-40e9-d196-08dde61372d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXQzc2R5RFB2b3hiM1NWNGxTSERGL0d3ZDU5T01BRktGbFdVb21YOVhEV2xD?=
 =?utf-8?B?Z0dDa1BpTGt1ZDlJdlhUVERkZWs1cXFadS9kSHl6bTBLK1BpcGRqcjNrUzlr?=
 =?utf-8?B?ZWhPTGZtQUF4bk40MDl0K1YyUG8wZzVpOHdxSS9ZajBUdGZYUW1pZCtrdTRS?=
 =?utf-8?B?NUFyZEJOa3lkYUlHdm9yUjBkbXlyeUcyamkvb2pDNlZCaGNzNWVPTmhWcXk5?=
 =?utf-8?B?LzROSHZLMlJqZzJHTDMyVlZaQ2duSS9SN0YvSTlyYWVTR0ZGem5rNG5kc1pl?=
 =?utf-8?B?THpxT0lrN2JUMytZYStVSTJ6dU9JVE90UU9obXlRbE0xTis5WWtNMjdzeUdR?=
 =?utf-8?B?UG1kVlZKb2FuNmhxR1hkQTdqOW1MMk9JMFNRNFpFMHVKLyticUJSTERTQmpo?=
 =?utf-8?B?KzlwSFQ4dFlaTWlBV3pLUmdSVktSU0YxNFFuMk44WWVUZ3BuYllsUW0za1lR?=
 =?utf-8?B?S1l2bmUwM3BFSE0yNWJQR0hIdVJQRjAxdXYvUUhOS2hhWTBkc2thSkQxeXdY?=
 =?utf-8?B?dGlMaG5TYkg2T24xNFZLV012aGxRWFBROFBNMXZNWjBsL1NLc3pGNTNtNnk1?=
 =?utf-8?B?eE50ZU1tNDBwV3p2MEQ2aURhYnU5SVlaLzhjOUs1VFFGT0hET2ZMZFpPR0RU?=
 =?utf-8?B?VC92b0s3SnRCTlo0Ulc4RS9yd1NBYS8xUnNhaEI2eTRCYk9lVzRDTlZmaVJ1?=
 =?utf-8?B?OGxUb2ZuVGRjbWR0SldKNW5kN2swb3FHWnFGRXNmUXFrYXVoanhWNjZjQW9t?=
 =?utf-8?B?YThwOU4zUmJ0N2ZrS0E4Tzl1MksxU0ZjOE15TVpUcWNGd3FaQjR4Vnp2TWwy?=
 =?utf-8?B?cE5WeHVjeWlGQUJndmdyeDQ5M05qSE81NStCdFUyeWVPUDBKbVdEZ2oyZkla?=
 =?utf-8?B?bHJHREpOenpCdEVEc0hCcEt2akNiMWo3OUNzNnFXdVZvQ2xPRW51V21VMzZ6?=
 =?utf-8?B?WENDNno3QXlVWTFSbDM3cjNVUDZaVG9ZcmtPbWE5dmF3R0xJbC9hYldpOVlL?=
 =?utf-8?B?VnBrUXREM2dZaFNKM3YrMzh3VmhWd2lxUGJFWGJVWHVGckI0KzFEREVWNU5P?=
 =?utf-8?B?QTBRSXpCMWlCc3l0WHUrZ3hVQmY0bm1OVWgvSkJValh6MHVGNGJsa0hZY1dK?=
 =?utf-8?B?ckQ1NUJacHVjVGVPdE96NnZhSDY5MHZyL2liTmI0L2FvdUptZXBKMnhQN2tt?=
 =?utf-8?B?cWlKWHMwaFp3dGEweEZYK1Y5YnI2U0VxMnBkSEpsUjVCYUpqK25EWlVLOTFj?=
 =?utf-8?B?N2VMQ2NqSzd3cFRlUWsvaHMzaHl3aTZwVkkzNkxqVlZKNnNwZnhXcU1SK1F5?=
 =?utf-8?B?REgrTkVjdkFpV0JBQzBURUtmV2ZXZTVPUWxseUJZYndPRUgyajlEaUVkd0ts?=
 =?utf-8?B?VlpTNzlEZ2gyVUdFSGQvVFNMVDY2TGRZQld4YjdLbUJVTlVpSlFoMDJqeGR1?=
 =?utf-8?B?RVdBVVVOa2UzN2xESitiRmxrWll0UFlBdGJJdUp2d21pVXFESGM2dkVmV2tP?=
 =?utf-8?B?UWMyajJONGdpdjZOYXBxZ1gyejJ3amliakdUYisvUUNlWVp5Ymxkb2s3NjRp?=
 =?utf-8?B?NnJHZE5wMk0yWTlTMGxUbDlQOEhVaUxpMFlMUEMxM3ByNThBR2V6N1hQMHh1?=
 =?utf-8?B?REs2aEFFbkhLelZCR00yR0FONmhmQ0U1c1U3U1Fjek43eXB6bHhsV0VWQ2Q0?=
 =?utf-8?B?cUJhNUwwbFJWQTJvVThSYVdLYU8yM1RSRlJhRmREa0FEcm9uRThhcFhtQmEz?=
 =?utf-8?B?V011SHNGUG9zakdIaU9LM0d2ck5ubjlhY3V1YjAzK3NCRjdXdDdpVjZZbDNj?=
 =?utf-8?B?WnMrcndvV0w4OUZxYzArVUFVdkpRZTFvMW5Mei9YS0ZhY0tBTUM5VG1DNlky?=
 =?utf-8?B?Y0VkRUFFUUZPOXJQT0ZnYTh4ZWl5cHYvbVgxbDVmRkZBY3FjTjl4dEsyT1dj?=
 =?utf-8?B?cHA0cEJ3UmJxVGgxbDAwOVlaa01lVVYxSXNMTHlFNFd3elUvTCt6Rmpzekp5?=
 =?utf-8?B?N2hTSXBHdWxIdDlFTkFKUmtjQU1BQkgwV3lkeW5OVUlxQmpaTm5Sd0EyN2kr?=
 =?utf-8?Q?cl02Xt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:36.0993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05953e0f-b2de-40e9-d196-08dde61372d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596
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

Add bookkeeping for the remap page to struct amdgpu_device:

* bo:	kernel-owned singleton BO

v2:
- Use existing amdgpu_mmio_remap container; remove per-field members
  (Alex).
- Use AMD_GPU_PAGE_SIZE (always 4K) per Christian/Alex.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..24501d3fbefe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
 struct amdgpu_mmio_remap {
 	u32 reg_offset;
 	resource_size_t bus_addr;
+	struct amdgpu_bo *bo;
 };
 
 /* Define the HW IP blocks will be used in driver , add more if necessary */
-- 
2.34.1

