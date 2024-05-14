Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362AFC25B79
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 16:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B38710E276;
	Tue, 14 May 2024 16:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iL3SzBJn";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FCFB10E276
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 16:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu043NV4r7M6JZKdzI6uRHtKVjZHr3EakhzZOK+8/9Xk2EOnwUDyrQwlxijlNVvMzl7wP7RCZpaFhIsjbkEWKq48dgtHvM6JCFg+qYSAnY3Rgd1Yk+h9JwEBQWZaiA7Wz2xcUMk+71tq7mLEipxrPOqQoj3M2hz1D3aZm7NR0AGjqpO1x8XmSaxRB4CP3icbMGG287qsWvmt9UTDt4ZF4OggsJh7qIC/We0OeFfAVuhbYnlNWwjK+Pwa4ga6lchMRJgnXaC/y+5O2jhNyIUFe1w9rRH0bZBNsL50M/IX81J6A/wTcHw4erKmCNK7MPZpkZUWZbGULBMRSuMLOZOk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmJCqQImpVQZAGzuOrEGJOtr5164uGqnTqg1X5MXhOU=;
 b=QYvX0CIJws44kJecTQIj4LD+5ncUEER0jf0I6Qq2le1Yp95pX/HB1MENaNhniyYg9icF54+hjpS2Vw+TJf38xWN59nFZ0aIju7lHlozwnPi7pqMLwccTLjEjye6BF8l/xFCTj7MadMxev3Goe0MQZd9DSw6SYPhfXFJUQbMEIE7sqDspyne62Kh/UQNY3KpfcIE4xcnFz0CXwCbljkHN+HD6IubM/we6rblr798uX3if1Z12sVIStjyM/PNbjtisoUxOEsBHWnT0M5BwDmuwyEpmMGSSOAF3j6i06fFBnhYZT1j2iwE+VWqG2A4Tu1h6eO6MP8e+ZRScWNEC4xkuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmJCqQImpVQZAGzuOrEGJOtr5164uGqnTqg1X5MXhOU=;
 b=iL3SzBJnOz+LWp4oQXz1YU2HOJEn9Hcfkj1NZZ2Gjog/Z5uoXoCiXgmxZ9AONew1MtB5biKofZaaNIkR3wEsnBrF9MUezcMZOZxn6Td/OpLt6V4TrkLqeR4VSV04eHqvEc42rRawCytccAGHY2z/yoxaoYFQpUdV4gd+ZKr8AmQ=
Received: from BL1PR13CA0411.namprd13.prod.outlook.com (2603:10b6:208:2c2::26)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 16:44:52 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::39) by BL1PR13CA0411.outlook.office365.com
 (2603:10b6:208:2c2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Tue, 14 May 2024 16:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 16:44:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 11:44:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix documentation errors in gmc v12.0
Date: Tue, 14 May 2024 12:44:20 -0400
Message-ID: <20240514164420.1111568-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514164420.1111568-1-alexander.deucher@amd.com>
References: <20240514164420.1111568-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f269ed9-7043-4da1-0c5e-08dc74352d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WbMGVRMQJJun0S0pSEQmlRA3BmSSqW/2UISkPUl+DSuNTmoywWBN+T7lhl98?=
 =?us-ascii?Q?vhcQO6aXo4QWII2b5J5W9tLsCzwrrRFAz42ke/tV1TQCWLCvkCbYBBNU8qjg?=
 =?us-ascii?Q?ZTb3Lbt8HODzXMdpa4geFaLEVGLubw+ZEwF05RFUp2F04AYeBmriZGOdowPq?=
 =?us-ascii?Q?vFotYCJGuttRAkQjTQpOQhUX8u4WSA5EClyLAPv5spDFfznlOk4/cyQYR734?=
 =?us-ascii?Q?D5nW3YJ86RndVkDtZw1LCD6banrXLdtnV7FwBGM8xCll/jnyqcHuXE42ZQVi?=
 =?us-ascii?Q?gwHacHXZ2Co/6oBe9qQN0Ce5sY7qYq+B0ZxkzRjTIWGUnlL+L0wX2FitY4kM?=
 =?us-ascii?Q?/MVc/g46ZJbcmdGeAduLKV5BioYabjfYLyqytsHCCZyHUKOwc76t6jsPb1A1?=
 =?us-ascii?Q?MQNK73y/q2myhG+eSsS/FYd9myR5VxVUpGjpbPxVSCXpsH55N4u1CKHhsE90?=
 =?us-ascii?Q?SNAxTgmTGOybruEdx1l4YINqVW9MZ5YtzKNjgRLyJfkkXJAirsYPCZBqA2Tk?=
 =?us-ascii?Q?9ASI9g7w7JRZEXa16N3d7b85MIHHr3ACqgXoOg1cf5GsOqaECqMaKNqsvmKd?=
 =?us-ascii?Q?e+qAa+1JuSbgfsu5xSGvf8rPJ6Dn4ts9e4E7FOks2nCHKJTxYXDOxUmuJCVI?=
 =?us-ascii?Q?Ksk+qgQxUyUr7i+GO3VEOP09LU7wl5Hj8qnCfma4C08mnWKFiNy1zXBYJZSJ?=
 =?us-ascii?Q?JkOp/XaQCnI2zEX+b9Ckt7OTEIg70Ez/2Nd2wbm8URnPz95PzQb+tW3oshhm?=
 =?us-ascii?Q?w4ipfD/uhZLvHy2PfT6G6e00YNumSEs4o9t94HrXX6mfnZjoNxYOM6nJSjPh?=
 =?us-ascii?Q?/r9DU+ggwwjmC2Mbb8cwXLXmq8TCxPbjtWxFoUG0Q6pwvSC4T25Q96uF77DT?=
 =?us-ascii?Q?Te2g6x+mxiTVIalkL3+PJbGKd8iwrEoKArTvZCC1DXBJWizZdRgoJfYuaikp?=
 =?us-ascii?Q?+7ce5jTpvIaow74ZqZxBmxnaMJm9pV5+L7cdmz7F9RSnacT/ohkHzJS8rL9E?=
 =?us-ascii?Q?1/hHXD5sLjxMN3cqfCaN2RJfxvBu8lNg8F79HsXqZMNClf9VZCI1oygVwskS?=
 =?us-ascii?Q?LrWbS4xrQUIy1CybGs4meVviotj4GZd5doYf1JE9I/x8pMaOCUbC2yJMFdvY?=
 =?us-ascii?Q?tQWd483umYJpRcgDOmXGrXrY+jT5MhxF83Erd3G7txKEq94jLYxVeHrJUd7F?=
 =?us-ascii?Q?gEaSdAwaEZBTwgrAVTyJ2iBZkQrg9MDilnUfZrnBtJ9ctkTRfmFyyi4CdkES?=
 =?us-ascii?Q?oHW76C9215vC9N0A4wp5DtaC3Kz1hhAQdBY7PG4fFk7YpDbIPnmRaNj5h1Se?=
 =?us-ascii?Q?kdqXo4QfrY9OyegHkGxHECiJwHu7Ky64xQtXoE8zNhCkxA2m7DUfKSLYi4Na?=
 =?us-ascii?Q?PAKripbkhdzkFBlHMULtBNVPrkYI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:44:52.4139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f269ed9-7043-4da1-0c5e-08dc74352d79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

Fix up parameter descriptions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 34e751b9b7003..c12c96f5bbaae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -282,6 +282,8 @@ static void gmc_v12_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
  *
  * @adev: amdgpu_device pointer
  * @vmid: vm instance to flush
+ * @vmhub: which hub to flush
+ * @flush_type: the flush type
  *
  * Flush the TLB for the requested page table.
  */
@@ -321,6 +323,9 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  *
  * @adev: amdgpu_device pointer
  * @pasid: pasid to be flush
+ * @flush_type: the flush type
+ * @all_hub: flush all hubs
+ * @inst: is used to select which instance of KIQ to use for the invalidation
  *
  * Flush the TLB for the requested pasid.
  */
-- 
2.45.0

