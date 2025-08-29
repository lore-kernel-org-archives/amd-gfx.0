Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA8CCA0FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 14:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCDF10EBC8;
	Fri, 29 Aug 2025 14:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uUoVMZGx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4185E10EBC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 14:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PInnYTl4AdteyfXLojm7DP8pGf2P1kVxUAsit2b5R6IXTFs0w0qApBG8dlB/IGohGdnuMLphEFh/iq6xRCCMHDfWCcME5IPPk34qJc+4dk4exgrOXY18xKXHh9OfjbQ5S5MKYzKa6qEbcCJYDytwO/vMLRaR/n33EGXSPGR1eIJch4iMmt6P3SOsaB7v4uDSA6i5tzxGBw2WdRJE3btdVzExB+vcmPOS7ZAfkUTYgKLSOeZipz68pOvSK9Lc7YiRzkDk/N/05C9YHznuT8x8kpgs7kJhLS+4nENh91oA0sxHtRts2ijwQvzMM6gMG9PPAov6TBE3Jk5N6ZpQ02yuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FtSKdrbhM7sc5SBnTbKGx4g839Pqmn/OqnoTODfyXA=;
 b=Fs3Px/UbzXUWLKMnOUtBwMh/DGCtZxu78CuKdf0bgCMnlEt0nPfRXFdAqX13SKCofBNuCLfqg1RrEm+wciCPmnNbkhVAmqLJaQkbsOcNR7zTA8Z+dKPYVLLymv5GqPHVq557OxQOndXNgK3PUDz6rrENXuLv/8AasSfQDrs19UsFvUmuLe9H3giWfl7OBDHuE2DD8W5pBdsXNL0mpCVN0xHSPFfskxd+0esXk3extcy7Ks6VS9jh4RxuXV6RDECgMWNJheVERb8Nd56zna1wlYTBY7MuCOVaMdYQdDxMjEvMlxy12BRQVA9jlLPjlv0Cl3q0I/02kUqLBUeyF7VWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FtSKdrbhM7sc5SBnTbKGx4g839Pqmn/OqnoTODfyXA=;
 b=uUoVMZGxGQHmVOgjypoByJaT9qnXV72a5wbprk9iDHJZw5psjkSA+TIgp6BciZ4BncpdspaXXjCU+aDxg5rCY9W7T8Znae0A5GPQGD89sy7YuybgGnWLKHaaJiRYwo9MTTdaUnOS8SBPhvbVuwhqII2q74+J2J9vXhiwlhdEgUQ=
Received: from CY8PR12CA0030.namprd12.prod.outlook.com (2603:10b6:930:49::8)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Fri, 29 Aug 2025 14:01:27 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::12) by CY8PR12CA0030.outlook.office365.com
 (2603:10b6:930:49::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 14:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 14:01:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 09:01:26 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 07:01:24 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 5/9] drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device
Date: Fri, 29 Aug 2025 19:25:19 +0530
Message-ID: <20250829135523.4032168-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 289b4301-d985-42af-e8f2-08dde7048bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmJDM2ppdG10WUk2Y2hJNkV5cHVsaG01bUt4QjcrUkJGVTA0TUxHR3QzWDA1?=
 =?utf-8?B?L0x5SUdaS0FJdENHUnlUb25RNXV0Y2NRRmNqa0NJVUtUMEJFMHgvVVhWNUtI?=
 =?utf-8?B?bHFEOUdpYzNDOUdzalZhZW5jcGR5bDFrMFV5RlhBTHI5LzUrRGtqa3hncm1p?=
 =?utf-8?B?bmc5KzRjWVhUZWNPZmI4c1BQc1JWWWpyck9NMnZHL1c0dDRIdzVwTmlMNUNL?=
 =?utf-8?B?SGVTSlRhT3RnOExzSlhJR1p2L3NHb1NzUlpQRWFuLzFLY0tuaGFyYkNITURN?=
 =?utf-8?B?ak9kOWFoYXVMRlFUWGlzS1UxUm1IWGpDbmNXREcxS1V4dTM4SGxQczZINkJX?=
 =?utf-8?B?M3ZDTnZpRktodlJJSzZQYXR3N3lvalR1c0VNVUVDU1cyNXczYk5UbWhma1Bj?=
 =?utf-8?B?Q2U2ZGppYmRZaWE4ZXkxeUVXOW9jdzhxSEd3VmJMRkZ1Sm5IdjBWRHhLS1JM?=
 =?utf-8?B?K3JEeTdRUXcycC9BTnJacGZzMTVwc0lISndCRXRVNzNuQm1ZWEFiejU4VWNQ?=
 =?utf-8?B?MGVNbllqS044c3NPckFleGs5L2Z1a3hWL25mcTRQRisvZ1pMSm92dW1rRnNO?=
 =?utf-8?B?UTAweXk2TzVmNlUvcUo2L1VVVHl4N1Ztd0xwNEpVR2dXOUlMOUxXWDN6SUU1?=
 =?utf-8?B?eVJFNnBMNHZad1VCaGE1bEw5NzViM1V0SE11a2VEMTRDYXJDRFNoRy9XSmtv?=
 =?utf-8?B?NmIxVExldDNYYzIvZ3h2WmJLUStJeVJ3d2tpZWNXbWxVbHJkMEJ4L2k2YmxE?=
 =?utf-8?B?NlFhM0YrNUNHNXJjUWs3U0lwczc3dnRzUlpRN0U3elZrRXJjVVNua2hPZyty?=
 =?utf-8?B?cG1uSStmT3l1WFpCSVRxTWp5eDZETm42Sm9aTnkwcW8vZUsvNzNoTDNJeDZt?=
 =?utf-8?B?bVRCYXE2bGhFdWxTcDJ2SCtNNXBQTTJGUUQ1V1Zzc0JyMG1uZXl1Q056RGRV?=
 =?utf-8?B?WW9kc3NWZkNpZlBxKzhtOXRnZnE3OWJCZStUcG1jL08wRWE0ZmJuUUg3cGZY?=
 =?utf-8?B?NUlDS1JNclBGTWlaQy9FeVdjTUo5cmxDaHM0aEFjY3NxbjN0L0I3QzA2Q3Vw?=
 =?utf-8?B?VlRubVRkbVd4VS95VjZWSGxRUXJSaURFWW8zS0tRMjNNUzFnWUlKTjVGVk80?=
 =?utf-8?B?RnAwaFJRL0xvc3NmRHdLM3cxN0dRelRhb0hKYVIwcktnTSt6VVYzK1JnblVr?=
 =?utf-8?B?UlphVGNCWUtFQ1lVbWwwV3ExK0tta3J6SGlDWHBxTGtLVEdZSkg3dm02aXJo?=
 =?utf-8?B?NHJtWmF5UCt0ZWZSaUpNNENrQ3JVT2pDZm9GUklPY1p4SDlob0Y0U2pvTFFn?=
 =?utf-8?B?WXdNTE9jbGhOTi9rOFM3d3FOM2pqS21JaDl6Z3hpMWwrOVhsK3RJY3NVaGFL?=
 =?utf-8?B?K0ZwZW56SU1hdUo5WW1kNGJpc0lCVFdTL3ZpS3luZU1aOWdSeEFIbHF4bWRn?=
 =?utf-8?B?U3JFQXlxdjdGcmtrbUlZVSttZ2tiMUJpdDNaWjhMaXZsNXNPL2Nua2pwMmdh?=
 =?utf-8?B?bExQekprTlpZNjBKbVRiNzAxaWpIcVA3SjVvQm55c3pac2gvbnVPbVlkNWNv?=
 =?utf-8?B?eE01SitrWW5TUmdBWkZnbVhVajFSQUtwSFNsbmdSR0RYcUVPeVRDRU9nL3U5?=
 =?utf-8?B?d2pxRkducXhiemF0Si8wbFBpN2hWTkxvTFBEUU4xOVh4OFkrZk9TWmlQa3Zy?=
 =?utf-8?B?VDJ4RmlqZGJpY1piLzdMVGhwUnZGSnBNSU1tMGFGNm1IWE0vYTVzNDdqT1c3?=
 =?utf-8?B?RnNjZUtTeC85eDNuZXFidnZGbnpQaUxtM2k2dW53UXQyYXA5eVkwZitKbk5B?=
 =?utf-8?B?NkRkb0VQd2xXZ3pNOEVPUXhXc3E5U1N1dy9nbWFXWGZnSlllNjZVcVZGZURI?=
 =?utf-8?B?a0NBdUlhTlN2bTFnWi80Q3FkL1RTL2NjNmxVZmloayt5MGNMNWdqVnNyRG9l?=
 =?utf-8?B?RFRQUUVDOVVCaVZpeitFYUdIa1NRWUNtNCsxN0o0WC9YNDlUNytVNXQ2aW5B?=
 =?utf-8?B?S0ppVEQzTmhUYmdIVUJHTHpvTFZIemUwazN5Nm8wc3pxQTNyWFlWUFBBU3Av?=
 =?utf-8?Q?yYut4x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:01:26.5638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289b4301-d985-42af-e8f2-08dde7048bb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

