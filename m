Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6B1C83F03
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 07:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661B810E94A;
	Fri,  4 Jul 2025 07:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5eX4Pv1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153F110E94A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 07:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxIaazdNP3eV3Jarot84YJ7pR5XDm7Gg+2pv1n/hSevLwP71i5b5FWwH6YyCvnxR3wWRCeKwJhBy8ygtXDniyb8t4tPCJihDORqnxOEWYvMaxJj1pJrJjyEcxl0WrjrRCNVSJwzR4m6lPVR9pWwcTeQWVxXP5O21Er+lUnRbB+9tuSl7jfXemIHMnW47mPagsA7MY3pw9NUdF8pudJ4YgvaBnmjb8yDaKZNtYfKwtuxCOa7hy3olhtE5hMYUrrt5Y+D5Kl5Cvpj4l4ROe04nhvt/7I7VxryB62S0KD//z4usAS/fnv2wGhZ9lPMC/v2jZn772/bJqBZTTRljNKL21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE16E9IxP9NrdDnsJq2TcVzu++FSJgb5urga6Bt+bwM=;
 b=NPRCi2wUd9YCkSIH3bHLhCNkEyz2mQv64WAVXUcJTI9A56UJDnHE9j36Gc/be0LYls3lDe+fgBoIU5kVls9+FlcEyRgX635aSXkAQxWkhgKWPxLoaXnqVpBH398DMz0jxUDLNNg5PIOi4KSkBpjvEF7yQRxU2cfvhIYokiS+3zQq+TyPUJoG8btUaLFj8g+W8aTNj6UW5fTY8oetTUQgiYCfaR1ISpnoxhERDTR01fX7kGziTKRGGxNAQNYF7TwqVYGHQNZtQTojI2jOUJaPBOCWOy8UC+vk8Nt9cJFmFjp/p+O9XopYxNmlws/LQMqJliXZwE6lA++O9JY7nF8MYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE16E9IxP9NrdDnsJq2TcVzu++FSJgb5urga6Bt+bwM=;
 b=F5eX4Pv1rsRsZbu9YrMnkvC94JI+a5REApyhyOCJFWp61tTjSb6Ui2QA53s42JUQJ0IhL4Dt/85UcVuB2fCYEMD6MoSnJAmS/4FBks8fjWLb0JhYAfUyST5whijAuj1dW4cHBX0faUyT2CulJgzrIgO6yYQKsE+uS5fhAcVowpo=
Received: from DS7PR05CA0034.namprd05.prod.outlook.com (2603:10b6:8:2f::35) by
 LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 07:27:11 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::22) by DS7PR05CA0034.outlook.office365.com
 (2603:10b6:8:2f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.14 via Frontend Transport; Fri,
 4 Jul 2025 07:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Fri, 4 Jul 2025 07:27:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 02:27:04 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Jul 2025 02:26:58 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Marek.Olsak@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Replace HQD terminology with slots naming
Date: Fri, 4 Jul 2025 15:26:57 +0800
Message-ID: <20250704072657.553572-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b0e0fb-697b-48f6-49d8-08ddbacc3040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8AqthqshdNFVT+21o1ia+YqRw4Q5dBJwHUBygiyLkR0SzuBuFEylm8EWXNsi?=
 =?us-ascii?Q?QZTCQ1eLJveg3TAWCrpXRrbVN+Yy1jbx88FllpD6ZLEkPYQmnOjZa6Rc/Qjh?=
 =?us-ascii?Q?DDespfcsx88rVqOFJvybhTQht7CWFcMp4Hi7eaa6jHE3T2TA4Jo5Ks9mNVca?=
 =?us-ascii?Q?RiSyI7+ly6xnaLb2cEWn3yenaUREUBCETZyZASSFQUCeryTrb5xXn4y8ehOf?=
 =?us-ascii?Q?HzJRGCF6pXId7ypBI4xtgVuIat47ojH65dLxQnhlIDBUc2RgHKMwVfeIVRiv?=
 =?us-ascii?Q?PzepBykesrvkY/yukg6ljceXvUU3XpZFXGe9MuDfZhMltnofI36+aWeHfecJ?=
 =?us-ascii?Q?IYt5L+e+G8S9DlEJVJ3xgwfi4rrI/ujjvybrd8qhAxfs2hoJuKeNhtBWXbRb?=
 =?us-ascii?Q?cLO8p+6YyLuNLkYueA/BlkNL3EIVzibq82xQyYyv/P+p/2LgDktBlCbrRaNj?=
 =?us-ascii?Q?q+w8qqM2OhsLUZ7ViEbUONh51FU85YhZr599T0l3TbzIeQdR/xm0dvsbGO4R?=
 =?us-ascii?Q?+kJGb0XYT4KlyYlRzQFg0cZ6WSSzkJb03noT0biFtAuE5s5aWXoHr6DMWw/Y?=
 =?us-ascii?Q?7afsk7mowUFVQpVhir5uSRB5QvsgmWXts3eio97rS3RLrQIzbRRPsM1K0AJK?=
 =?us-ascii?Q?fP5M87pLlLwvnZj6QCP1NUaYzX1os5Ht7NDiKR6upv/hwv/2vZ+JlwuHX/XB?=
 =?us-ascii?Q?Lz2BeLiFmuN02mfpkVCuSxQmAX0yrQ1gY/MvqoTqj6tVHipyt99rnZNVuV37?=
 =?us-ascii?Q?SMUyhaRJItMuEYhA/DpjdNEsU23iXsN0PWR8H3lxlqz138Ryq4moiNOGljNk?=
 =?us-ascii?Q?5Li96/CTodGvQDPoGNQi+Q1mxhN77xluPby1fA5ZhS2oC7OyLj8eR3R1Uoe+?=
 =?us-ascii?Q?cKuPPtU/E44mnXUlbTWkg+rex7ugaP0erQlmtdak8RhdfxxEe5TS6tzq+rmN?=
 =?us-ascii?Q?gRuBXzjj3mZcZtLs0gFsxqSANGK/4p3WQSadQgtWQNXacHLivReoU4ZAwesI?=
 =?us-ascii?Q?eDNIVhbiS9njonERyH2Tzz1vTKUlTO/qCfcaH9venkHlTyJN7VdL31seJbm0?=
 =?us-ascii?Q?yNnvCkD1jvDQR698htXX8aLnFtHcMk3Lw2FD0IoJcmoH2Uf8W4zj0PnIHk06?=
 =?us-ascii?Q?ve8R4900B1g4/cfbQwGDtgrSj+2EcS5RhyAyEH9UMYel+bizbK03K+n7sZpQ?=
 =?us-ascii?Q?DQo0gy7KALXBFbOLZ5mKf2ZYp2m1/ggEFtoisHrZAg2Mqh4WLZmmcqBkTRzP?=
 =?us-ascii?Q?jLFmVO8J+IEtycufDghYwks58BBiVj/84OoeAqCZTsUqg+y0D1BjQKH9u/v2?=
 =?us-ascii?Q?upMCym4O7K9Rc85vRE3LHV5sXbBytNMkQB/H1m2//zmKf/6+W0Ng//pcHdHE?=
 =?us-ascii?Q?gBAZd3re91Z5yCYWJtJMAldKOrkzqOf2+2o5EF0PwZTVR4dBpZCtTOKqcGwC?=
 =?us-ascii?Q?66WffPQRJ2C1YOpIsNNcjBWWkclB86G35+eFdRTW0Ql0P7rlZAvU2e2fTqTX?=
 =?us-ascii?Q?OUgB8s0OZdh8XgNv3gpOIaaeuDwlCwguwUD4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 07:27:10.1335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b0e0fb-697b-48f6-49d8-08ddbacc3040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

The term "HQD" is CP-specific and doesn't
accurately describe the queue resources for other IP blocks like SDMA,
VCN, or VPE. This change:

1. Renames `num_hqds` to `num_slots` in amdgpu_kms.c to better reflect
   the generic nature of the resource counting
2. Updates the UAPI struct member from `userq_num_hqds` to `userq_num_slots`
3. Maintains the same functionality while using more appropriate terminology

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++++-----
 include/uapi/drm/amdgpu_drm.h           |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4aab5e394ce2..e2aa2264fa0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -399,7 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	uint32_t ib_size_alignment = 0;
 	enum amd_ip_block_type type;
 	unsigned int num_rings = 0;
-	uint32_t num_hqds = 0;
+	uint32_t num_slots = 0;
 	unsigned int i, j;
 
 	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
@@ -415,7 +415,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 
 		if (!adev->gfx.disable_uq) {
 			for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
-				num_hqds += hweight32(adev->mes.gfx_hqd_mask[i]);
+				num_slots += hweight32(adev->mes.gfx_hqd_mask[i]);
 		}
 
 		ib_start_alignment = 32;
@@ -430,7 +430,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 
 		if (!adev->sdma.disable_uq) {
 			for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
-				num_hqds += hweight32(adev->mes.compute_hqd_mask[i]);
+				num_slots += hweight32(adev->mes.compute_hqd_mask[i]);
 		}
 
 		ib_start_alignment = 32;
@@ -445,7 +445,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 
 		if (!adev->gfx.disable_uq) {
 			for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
-				num_hqds += hweight32(adev->mes.sdma_hqd_mask[i]);
+				num_slots += hweight32(adev->mes.sdma_hqd_mask[i]);
 		}
 
 		ib_start_alignment = 256;
@@ -589,7 +589,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	}
 	result->capabilities_flags = 0;
 	result->available_rings = (1 << num_rings) - 1;
-	result->userq_num_hqds = num_hqds;
+	result->userq_num_slots = num_slots;
 	result->ib_start_alignment = ib_start_alignment;
 	result->ib_size_alignment = ib_size_alignment;
 	return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 66c4a03ac9f9..bdedbaccf776 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1493,8 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  available_rings;
 	/** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
 	__u32  ip_discovery_version;
-	/* Userq available hqds */
-	__u32  userq_num_hqds;
+	/* Userq available slots */
+	__u32  userq_num_slots;
 };
 
 /* GFX metadata BO sizes and alignment info (in bytes) */
-- 
2.34.1

