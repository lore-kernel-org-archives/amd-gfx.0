Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779F4C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 20:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2023C10E0CE;
	Mon, 24 Mar 2025 20:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cJhWK1GX";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8779A892EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 20:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1kK9bQMcFoCXfIbQfl3Du/xNvdNR8MxIiSgbVpGOQ4Fn9NghGbxvOZAo+cb7Zf+tyfkdGPFQUAwqYt6Rz433a8QrPCuTNuM8LO3QwuAQTUiHmjHmRlJxF4UH+df838KDjsVIUANQQaJyx/23xxlY9hgRY1cmOxmm22pZG0s3mWusyJLX31WoezvVPLrzgTI9Uc9rTf7r75677hEqo3kWZQDNb+cu1y5sYmInMbAL/DKOgJmRX3BYCc75b6V7yT6f+7uC3h3v3VsFQzv82AwAl4zUDdkKTMmWWeXQNVwCuI3qVFQpPCe2HxnR6uAbiD7pz3O0KYSYmGAH0udYaxtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY+YjKOyGC8mEzqbGrefwGBd8pnI9M0S2tVF7o461kE=;
 b=JYBqGXzQrqnDYq5Y39XEP40ND8rbaVTl89ySH9Yw7/PjWHc4iMN7KrrXIrScrtj1DIaNnGoH8FsqF8LGkikAXM9RnZ6XAeRKtNpaZpOAgXr/UtVm604WZANPa3WosKjyO18kPkhplbfNTYe7lrvs9oIJo73C7lZo7imw/3Bv+rrU+6V+CGGLzDn4OQ7ZJtyewCQCsc469Aw+ujC+y85H25dOplL8fZ+ZjOnyPw3E8PEu3kzZ6FwLb3+mSbWnV14xZQSPefSW3V90brmlD9tDZe6TFDoTMsogfIylBrSIBGp3igHqC/YEW/P+GdutZ0eavknq5LjbV4UqWlww6FM4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY+YjKOyGC8mEzqbGrefwGBd8pnI9M0S2tVF7o461kE=;
 b=cJhWK1GXvHdWfl1vcvyabPOUr1iodXJxB1FNtO942C8gGfzjRk6GMw0ybjYsvr9AlwrdH8lnomZvbNxDwr+1fGW/gqZiSFe5ntLI3h+rqnfLmd3FBiFEhH0sOLL4KwGoSorBkoJYnKpX7M6VyyHEcWNkh1OtG/3aEZODDnLUehU=
Received: from SJ0PR13CA0158.namprd13.prod.outlook.com (2603:10b6:a03:2c7::13)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 20:34:17 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::85) by SJ0PR13CA0158.outlook.office365.com
 (2603:10b6:a03:2c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 20:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 20:34:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 15:34:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <marek.olsak@amd.com>,
 <prike.liang@amd.com>, <sunil.khatri@amd.com>,
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add UAPI to query if user queues are supported
Date: Mon, 24 Mar 2025 16:33:27 -0400
Message-ID: <20250324203328.4174703-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a6b031-da7a-4214-5449-08dd6b133dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uE+e3oSIjq9Sthsyn0VSvn8tUwBsJ1tbzHSznsfB2tyMwnpJgZV4jJi5F4Z2?=
 =?us-ascii?Q?b6tqinJNPUqXneZEuaMbTy9syTr0m+O/ycDCQZHQbIj0G4b4vODy/sD0nJuT?=
 =?us-ascii?Q?JXQnth5vJpEztW214Dm0l9g3ZKzZZy6jBqmmEbcVIMVJ7dwCJGezjxA6DkyS?=
 =?us-ascii?Q?szmpR3eRXmM/d/+Um/GwrOmB0TeHqusVHDXyo4HSi2YEzYp+EZyrrH9yhVoy?=
 =?us-ascii?Q?lh4zaNwat0GyKe+Nk48KVknbNKTzIWXIvcHOlpRxSGuCHXGdfs7J0R3N9pAP?=
 =?us-ascii?Q?onHdOsd7YHnNeMfgSSPxmQo5FgXQJrKVfndpQbbAyDpW62mvRdt+mrVeL2L3?=
 =?us-ascii?Q?bB6AKirgiU9TuntsJpD8BGMcUs25lNWBB+5u9ogYuo6pl/79fNLceJM0Ct3x?=
 =?us-ascii?Q?azOgLlD8l14LRnp+fm2mm4jeS9hLEk72WuxFrnDMqLurFAvE4LZslLxsU4HE?=
 =?us-ascii?Q?FjaQA7uPow1/imkdI9lVF3ru5rxypBZ+gcO55aFK//1ROULtLHtxNEpb+WN2?=
 =?us-ascii?Q?qiZuV1k5oIKl4liymxsvBQRJLg0aZHNYY4Mcamp84uYHMvEE2lGtoyEOGeBL?=
 =?us-ascii?Q?uircsKRRUWOzSFQX9/kjvFlMFLlT3RvPq1R1ekChpRzrjnE8Ty+GnZ2xYd+n?=
 =?us-ascii?Q?6RhnJXRlQ5xmE9vEg+BaCrkz3qdPHkkwbDrs+C8OIMXk7sSVp0w6+VI8oDXX?=
 =?us-ascii?Q?ZEkeXFVmLLwiaxgFeZBdqEeFGDQmFgEsIOZlQDN6p5qZJwcJf95lO36iqr6W?=
 =?us-ascii?Q?0CDurJX+xfSTDl1pApzbps93a9dy+55kJNukwH4N8iafoGAobTedisJBCFVn?=
 =?us-ascii?Q?91u59ZxJJfwapaXeaAJhlPR6cc+kDl/LxBteYVSIEocHbWy47GAoiYRidbKt?=
 =?us-ascii?Q?IANZxu0l2GBhRJMxYwb+T5P8q8whP+BML6+2zYxAZqrcua8R1+nGN6YbfmJL?=
 =?us-ascii?Q?06uJPJ8D1J3NrCY/Cp4kwEcW/4tb6GSKyTOm9i6OSw9voqpZ6AqN8wgRgZF5?=
 =?us-ascii?Q?sG6XfYeDX6S6b3mW4IItnj8pU0C50uwRzrDcGGrfSVZMMn/ISjGR34SEwngD?=
 =?us-ascii?Q?vz+mWhirAa5xyZs11AdwakezT/gAEYDijYiCtWQIlvmrwcHJChr9BB+3YAlF?=
 =?us-ascii?Q?o2NbVKU34QJq9+EwIE02VIN8L/0dU30y5cLF7Cm+4DCeWthTKmKpjanq6YMd?=
 =?us-ascii?Q?4v872z8R7OhA9e2L/0j/g7Io5swzC/gJ0F5j52BHi0SD0EGbLxB/UfIL9Ii/?=
 =?us-ascii?Q?5K7YMSArg9fKR4C28UaPpUEuZ4NjATqw8xYaQ0YgSQiP9LYelVPagtj/UN9f?=
 =?us-ascii?Q?xtULRLFsEf1Y5VKBr8MUlfoCb0ulfncb7UALzO/AJi4518cB2DWBKYi3S17Z?=
 =?us-ascii?Q?dL6oACYMWoCQaqNtNFZz7RRu1H30Uj9Jd6GTZ+NaaSMow6Q69x8rquVaBaZS?=
 =?us-ascii?Q?Pj2AWnfgHa3De32ge/W4m0tntDpvWnsV9NccnR66uxRHG9JjRMJ+zq8upBtv?=
 =?us-ascii?Q?UEAekdYhbSQA4wo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 20:34:14.3438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a6b031-da7a-4214-5449-08dd6b133dfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
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

Add an INFO query to check if user queues are supported.

v2: switch to a mask of IPs (Marek)
v3: move to drm_amdgpu_info_device (Marek)

Cc: marek.olsak@amd.com
Cc: prike.liang@amd.com
Cc: sunil.khatri@amd.com
Cc: yogesh.mohanmarimuthu@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++++
 include/uapi/drm/amdgpu_drm.h           | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3b7dfd56ccd0e..0ba3ef1e4a068 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1009,6 +1009,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			}
 		}
 
+		if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
+			dev_info->userq_ip_mask |= (1 << AMDGPU_HW_IP_GFX);
+		if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
+			dev_info->userq_ip_mask |= (1 << AMDGPU_HW_IP_COMPUTE);
+		if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
+			dev_info->userq_ip_mask |= (1 << AMDGPU_HW_IP_DMA);
+
 		ret = copy_to_user(out, dev_info,
 				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
 		kfree(dev_info);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 5dbd9037afe75..ef97c0d78b8a0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1453,6 +1453,9 @@ struct drm_amdgpu_info_device {
 	__u32 csa_size;
 	/* context save area base virtual alignment for gfx11 */
 	__u32 csa_alignment;
+	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
+	__u32 userq_ip_mask;
+	__u32 pad;
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.49.0

