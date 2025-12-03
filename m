Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9BAD12D50
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846BD10E7A4;
	Wed,  3 Dec 2025 13:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5JXMrToV";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DBD10E794
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYqXnKhnnPwbmy7EZDzrVQV6+Jv+4HU133AgfuVIdvtTXDqM4xiHV1M03iNShtAjcZLN2UYkj+l0PYAFcsAm/lOymGUv92YSnW2GVKDdTS4daAJQXOJO9LIuWmgEQBbtUjG/PD/WcfzuZayY756/gJ5Cdz67rtMG65QVDPrMJifHLMyUeQlWeH+jo6t+NmdEiDJJSGzgAK73tunMvj0+8S8JeRGCTaT3zZcdEmYOY2fQXPiU+HwcFQrtWxfLiHMm3vrXBHfu43ip1W1x9NTYcSX3twT3SgreFxkiYQX3swhdQLony5eyHveJttxXLNecmgHUt6Hku2vlzNvfpwWm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2DapDljM+3z7pAu+v+YylgW+TjRDO8IDltoOrW0bPI=;
 b=aRdTtu+0TN4TOcCqlJxfVI39RYEjwDPrsmdpqqOA/hWrE9d1oISqyD3bIsfyRTuakv1dp62r4tkjXy6A3EyEeKMQ6bdahPs3xuAxixher/Y1+LTuAtYs7R+7z54lQA3D9isIUk/yLs6tNjMGwkBQ7xZXBwsH8M8Lo1z+imTQ6QQZ8PHs5q0wSS4buPtfL/R6+mPOG1NPM5M3j/KQ3BSakhZA1HxzaM21risJzzxivjisoB1L0BwDO6lwU7L/DXSjCXgj6teeLJWNFh+ThDZRk/yWud4R+xUojrS3fecyOf+N3BFR4IWvfRbXZplnBJKTyu6qL3gAHCa5bsAPbNNq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2DapDljM+3z7pAu+v+YylgW+TjRDO8IDltoOrW0bPI=;
 b=5JXMrToVjQnFO/XCXkFQaxOfxvLMGd156cJSY2ZR3Hq+G7NvrfpurfTx/qi915JeJo8eGJXVDS+2MDp8qRGk7frLbq90pmFoYKo+/oMqlincQnd7+mmyhOvSEJBy3QwY3RZ9GWWQgDTVbQLyLxKUYYr+8/msfZXkhiZf7aUcGAQ=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Wed, 3 Dec
 2025 13:05:08 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::f4) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:05:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:06 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:04 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 04/10] drm/amdgpu: Add user save area params validation
Date: Wed, 3 Dec 2025 18:24:55 +0530
Message-ID: <20251203130436.745633-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c81b4b-e458-4ba1-4c4a-08de326c94e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D9ghk3BYxEjwibGBiAcoG7RwKNXgx/XGMRpXlvzwij/rzGiBc8lglfawjfJ9?=
 =?us-ascii?Q?lvLgd4PqxQrLeeyzSm6kR+UPrhRW1cBj+SAm0sTBweqIke5Ebs4EXrE6KjVi?=
 =?us-ascii?Q?KUqmmmt3M9pV5GnGOiUToFURGsQ4T2ypTaDcz69dt2qCPETjALENlVLZyH8G?=
 =?us-ascii?Q?a9P9qdb1AJDOld6AYZyxDCQiunfjcBioKD8nGhgFw7c+DKlepCToH/E5/xcO?=
 =?us-ascii?Q?MJNwEbFhSXF/BBGSwD0J1y2w/Qew47iz35vZmDFjITkUA8FQ8rFWTvmMfZM/?=
 =?us-ascii?Q?VkMLbCkfNOL2EQtRy1K9QgG/aNyzi0igV4qFmQq+wAqLv49RC5i2927BOdVc?=
 =?us-ascii?Q?5S1zxGmkRJh6iSvE0ZiF6S7e5S9cg5p71MMKdCLu5XoIhXyttbH8/4yHjIXE?=
 =?us-ascii?Q?4amU4ObjdRVYKeCkQkYT44wIdG2CcPOloYvxyX7C/kxQFdp2QkLpxNQ4o2Yg?=
 =?us-ascii?Q?pA3Nhsd9Ysbd7FtYzgf4DLFPOyCcNEo5YS75ZxV48NZ7znCGjJev2HzHpeTj?=
 =?us-ascii?Q?6MNBw5MarqHGYLIpxD98wklHx/zs98oal1xkbZNu1rQABhU6wmySRrzFUTeK?=
 =?us-ascii?Q?WQqBoVIRpv4Ckf0cfQ4mBe5+JBdrXbwDOrqp1ZtE8ZZ/crsOzKiSkp8CC0Gz?=
 =?us-ascii?Q?1qqGHjaMCHWKAuR9lpjvL8wpGBjsHmoYefxLY2SA7rEums0X46EVvPF9w7Vd?=
 =?us-ascii?Q?eElAMmDuhjXsdvVDVm0dprnpvVatzvkSJbD2lc0REx+5iJRoNYgxDwMqAQvg?=
 =?us-ascii?Q?deFPvDIWr/RwWkAgHVjNwlYM8Hz9bpH4KVIeR3FFnA6H1V4q+bJU7byb+FZx?=
 =?us-ascii?Q?F8v/29dR92SlNGcaHcu3qNyk5SWODwvfzUkvAzySnRjaTWXpnoTREOmxsnum?=
 =?us-ascii?Q?m2fuZY4IVAqb2Y0wLIWIApNScWCZZgmmZsXtpIuKdnvPepnGn4qkc+2HSF8w?=
 =?us-ascii?Q?bUh9QbLv/c5eXXj601+Vx5k8/VcYZv6LDfYhsM4H+kt/bQqAu31aPaxKscL5?=
 =?us-ascii?Q?41bNjb6AxBETAX6wDEGZveugtZL5gSW/+s1mtxFtwU9JT3gQ1hMJPgE5Eg1f?=
 =?us-ascii?Q?KBdkHk3I8ZTpIyGQKyAXYqwgwkzgYdIXMcWiMlfX0IQZ6TB7BnZyhgqCBrj0?=
 =?us-ascii?Q?qIvVlaBgq7u7FbJ84OwA0+FQlgfjWAVK6sJUtJUO6ohFW2kI5cN9Y07Bto1b?=
 =?us-ascii?Q?LoWzfL50Uzjgz1vJziqlbk/gq1qVxznp9nAypB0wb5jG1dCxq3CPr9W0ZXFS?=
 =?us-ascii?Q?wIyN9ctp7u3bk0YCh+zLs2sTH1eyWSbEZ5f+/Lr/5LiizqVpbf0+VtMRaonG?=
 =?us-ascii?Q?N7PqJO7ju946KTQeCOIr2IoExF3NOFeWDHykT7sCGciI81QQHzo8TXYNjcAB?=
 =?us-ascii?Q?hTDVq53z0imH/2l2mqahaF0qMKsMmXZiM1/iMcdkyl9bjG7BrDRteC+RSF9x?=
 =?us-ascii?Q?PSPdPW2PVqQ8btOCTGdo8k1QEURvq+Neis0ZLwiHbjq5cf0y1yBKtUaXaH7E?=
 =?us-ascii?Q?X14Gg87G/lU7Yu4zK/3zQ60ouMZh7/k0g+VcfYSMEdZ4zJCd+42IXgWCc2Ov?=
 =?us-ascii?Q?Oen+qtaLLMfoi6yIXrA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:06.8647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c81b4b-e458-4ba1-4c4a-08de326c94e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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

Add an interface to validate user provided save area parameters. Address
validation is not done and expected to be done outside.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 44 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 11 ++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 4252c31eac4c..1b4483b5d5a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -63,6 +63,15 @@ static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
 	return true;
 }
 
+uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
+{
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return 0;
+
+	return num_xcc *
+	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
+}
+
 static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
 					 struct amdgpu_cwsr_info *cwsr_info)
 {
@@ -406,6 +415,41 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_cwsr_params *cwsr_params,
+				int num_xcc)
+{
+	struct amdgpu_cwsr_info *cwsr_info = adev->cwsr_info;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_params)
+		return -EINVAL;
+
+	/*
+	 * Only control stack and save area size details checked. Address validation needs to be
+	 * carried out separately.
+	 */
+	if (cwsr_params->ctl_stack_sz !=
+	    (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {
+		dev_dbg(adev->dev,
+			"queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
+			cwsr_params->ctl_stack_sz,
+			num_xcc * cwsr_info->xcc_ctl_stack_sz);
+		return -EINVAL;
+	}
+
+	if (cwsr_params->cwsr_sz != (cwsr_info->xcc_cwsr_sz * num_xcc)) {
+		dev_dbg(adev->dev,
+			"queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
+			cwsr_params->cwsr_sz, num_xcc * cwsr_info->xcc_cwsr_sz);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_cwsr_trap_obj **trap_obj)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 3c80d057bbed..96b03a8ed99b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
 	uint32_t xcc_cwsr_sz;
 };
 
+struct amdgpu_cwsr_params {
+	uint64_t ctx_save_area_address;
+	/* cwsr size info */
+	uint32_t ctl_stack_sz;
+	uint32_t cwsr_sz;
+};
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
 void amdgpu_cwsr_fini(struct amdgpu_device *adev);
 
@@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
 	return adev->cwsr_info != NULL;
 }
 
+uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
+int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
+				struct amdgpu_cwsr_params *cwsr_params,
+				int num_xcc);
 #endif
-- 
2.49.0

