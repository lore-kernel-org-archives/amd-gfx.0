Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69A2D3748B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559A910E832;
	Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qe7d4ekY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6003310E833
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV2yTMaJSgwL4WmSnFhgvyJIdYGjmiZIKCOADfJbIlLGiefJlVQXo9GpC5qOmTUIKP0oT98iB0Lv/mDOVQeFFVF+mXDz1xCUSwF/9fmV70ni2zPueilUW5CBKNy0Ivgo03IB8L223yO799w+AyEOoNWk2dvF+Xq/9C5nhdm0eunyl2oYuCGzESzwAz7/8wVXJypWdCVQmCz6wPRTbQGlL3buOJeLZD493gNknXs5jSLeMF+XJDiR3tuYowE15mZY7Bo5GaF+7sQh0kdLtyDreId4DoVljtR7ul8XZGTx8xfsa8YbzKAw1Wdgqudm0q9hGqsilBh6DkxbLdurkibMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfjU+ca7ie1klR87Gt9xy5bVUNv+ofZj++fxb0HUiTk=;
 b=EMK1FoYYy7I8ZItXR4pRphN3jYWaqhdR2abJneEUbT8Y/P2nC+2jrMV7AbVU9d4fga/kJrNG4dtZeQ+peBFWNYl5rwJkXpd+lMvIpZq796U5Q5rSASKQAvrIZ286A0lKbozg1yTSZvhNUk160sLYiEQkgWB3p7BYv2pdSJhUhT+1t5XsGm26fzz205Io9fgtXDOyum6v8LhZ0pZMkk0+Vla/WfTybkDIJmIRte7TYj57MIOOh0SqJ7ZZu0mvc2x91jTZaCttfQi5hgMKMsFPBK1JFH854vkii7j1GOI13JY1NhjlBkvsLP89OZhCbeN2Wv//qqyq6YRf2q2s5PfrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfjU+ca7ie1klR87Gt9xy5bVUNv+ofZj++fxb0HUiTk=;
 b=Qe7d4ekY6sHKzze0JMZP9l1ei2DnzIrTdLSQdxwzyHqFYYB+LqwPoFTNNyTvUy7bTb3fflx3ttOJFU+oGmTDK5amLTxsqxZk7RhxoIk5wOhsGsAYEVfvYDaeUf52yMSGkBjXMn3wWYUCnkibkcxkCsxW3y4RcM3ToygF7MNqw6A=
Received: from BN9PR03CA0258.namprd03.prod.outlook.com (2603:10b6:408:ff::23)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 13:21:32 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::d2) by BN9PR03CA0258.outlook.office365.com
 (2603:10b6:408:ff::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:31 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:31 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 25/32] drm/amdgpu: resume for each vcn instance
Date: Thu, 17 Oct 2024 09:20:46 -0400
Message-ID: <20241017132053.53214-26-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: b87d57ff-f1e0-4874-1192-08dceeae9dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LVxFJ03jttdRs5Xc3yC7z3hoGw1MI/YGwqp1UofkaSD9dbNTrwXBezUpjmBO?=
 =?us-ascii?Q?a3M6+jHnWyf9XqkIjUs4dsSxc6yxxYerLIUsmdWLYUeaHKXSwxkSBWmutWTx?=
 =?us-ascii?Q?vKkyPuYatNhdi/e1JNBrppMaGIK0rQly8ZU3ECrnWWNGC723C0szo5nBD8O/?=
 =?us-ascii?Q?FXDA3aXK5spHbIkbCT2ZcDLtHzIBOVXwAzk7KKWFnbV6kDOo3QG3wzUyTp9P?=
 =?us-ascii?Q?G1PssZI/cuApnTgQtCKOYNr9xp4MCck6j3wIIbQP5vxvNOYFsHBhfsxI4mP5?=
 =?us-ascii?Q?J/MOZrPu3sDdBSlUuCjqnJpn0HePqGnh+PPb86g5QeEuXoZNbflrGnrWRWi0?=
 =?us-ascii?Q?HQd6XX+ZU82V+pV0nGSVGJudI5o/aWrVxW26jTzbvWoSKmwJJZ1gSREAAFGx?=
 =?us-ascii?Q?jtv3lHFvkBMHb72HvzBcjX1glm6PageDgjmy5IPWMfxLEJMADepc58l3UpsC?=
 =?us-ascii?Q?ECf6wlo5tCxtljMEPwdufqFjIo/XO8mRIx0MZTok7X1UhPYr6ZpfishmoWFK?=
 =?us-ascii?Q?llgxmhrrOPUvelThBTsdAj9khKCHoczUz1fK0BoG8iLUs4jSDF/SHV9TA78S?=
 =?us-ascii?Q?jclglSr8IJvonXyq6pWc2r3OjGWhrrUi7YaU9UXxODCDDzwRfvWhc8E37GWQ?=
 =?us-ascii?Q?WIg39ry+ZoYHHJRIGgGuYC9nHn20SSdE3nYT48ECIbdEP5JXmFdhNXa8glMt?=
 =?us-ascii?Q?0NMYdqld2Jg+gl3XSifweDQIWUY7RL3B4RdSYj73RJkMxGanlUUAxYfTpR+q?=
 =?us-ascii?Q?53lCPGENH4pe2a3NyRZtxurSqs3LtZklxkwqmHUyeHUCXLerzhAaOmYUxdlN?=
 =?us-ascii?Q?hTEoTQZaBvwQSqawv4eZNQedCNnJW4qKqJi5p3wSDCUUVm79FpqW8BQUJ3VE?=
 =?us-ascii?Q?mD26F7W8eMpDt60BCrI6XJXShfsK56P7Rj1cIR8nIQ4lVctVdb+SiBfH3Pbx?=
 =?us-ascii?Q?Eo7s5a/OBTtsKFY4aHiHx6ashaDvd25jSFuE5DUshU/Tqh/DpPSFh8paQIsS?=
 =?us-ascii?Q?n+Q07N52zpgVljFJq/wew6JRWI4tMlzg6Y8FWXJl9cq9QfJeyz25PWaLbKMj?=
 =?us-ascii?Q?LhFxiGSgMx0oZjR+OSgSHGg5Xr7lNy0ifoyVjgQmfohUdntwtWv/CYyFgAVU?=
 =?us-ascii?Q?OzrTWRmpkq8o9DSIGQWKS/k9qHYeC8TevwR32v7fvXa3+IDC1KFdNIzKEH5C?=
 =?us-ascii?Q?MwkvaiVTURAla9yRPb8XBxkeSXymcvGBg16QMVnrYujN1m9kMVJ+MKNkqX8e?=
 =?us-ascii?Q?31su/OmwKJRuQmKIBHNfvdbFJzrkc5ag1HbgPcAcGKotVbZ9x17ScZmR6NMo?=
 =?us-ascii?Q?RZUP9CvI0/AF3Ju2Jx0+fVv81/E8LYrcy/R4JpNKopIIeeGpjClB/tTIpAbt?=
 =?us-ascii?Q?7R9VI0GhSy3DOUyp8NhyUNrc5nBrO8GuWoFo85rmN5d0AEsd7Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:31.8980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b87d57ff-f1e0-4874-1192-08dceeae9dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_resume(), and perform
resume ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 60 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 +-
 10 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 968355228095..67081fb4e96d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -330,47 +330,47 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
 	return 0;
 }
 
-int amdgpu_vcn_resume(struct amdgpu_device *adev)
+int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
+
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->vcn.inst[i].vcpu_bo == NULL)
-			return -EINVAL;
+	if (adev->vcn.inst[inst].vcpu_bo == NULL)
+		return -EINVAL;
+
+	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
+	ptr = adev->vcn.inst[inst].cpu_addr;
 
-		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
-		ptr = adev->vcn.inst[i].cpu_addr;
+	if (adev->vcn.inst[inst].saved_bo != NULL) {
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+			memcpy_toio(ptr, adev->vcn.inst[inst].saved_bo, size);
+			drm_dev_exit(idx);
+		}
+		kvfree(adev->vcn.inst[inst].saved_bo);
+		adev->vcn.inst[inst].saved_bo = NULL;
+	} else {
+		const struct common_firmware_header *hdr;
+		unsigned int offset;
 
-		if (adev->vcn.inst[i].saved_bo != NULL) {
+		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+			offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-				memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
+				memcpy_toio(adev->vcn.inst[inst].cpu_addr,
+						adev->vcn.inst[inst].fw->data + offset,
+						le32_to_cpu(hdr->ucode_size_bytes));
 				drm_dev_exit(idx);
 			}
-			kvfree(adev->vcn.inst[i].saved_bo);
-			adev->vcn.inst[i].saved_bo = NULL;
-		} else {
-			const struct common_firmware_header *hdr;
-			unsigned int offset;
-
-			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
-			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
-				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-					memcpy_toio(adev->vcn.inst[i].cpu_addr,
-						    adev->vcn.inst[i].fw->data + offset,
-						    le32_to_cpu(hdr->ucode_size_bytes));
-					drm_dev_exit(idx);
-				}
-				size -= le32_to_cpu(hdr->ucode_size_bytes);
-				ptr += le32_to_cpu(hdr->ucode_size_bytes);
-			}
-			memset_io(ptr, 0, size);
+			size -= le32_to_cpu(hdr->ucode_size_bytes);
+			ptr += le32_to_cpu(hdr->ucode_size_bytes);
 		}
+		memset_io(ptr, 0, size);
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 0695433a269c..72341b7027a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -487,7 +487,7 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_resume(struct amdgpu_device *adev);
+int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 806ed6c550fb..11153ca0c3d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -156,7 +156,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -331,7 +331,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 397aec069862..d36ab4368a25 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -161,7 +161,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -359,7 +359,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 088a3521ac5a..963086b47b1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -191,7 +191,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -436,7 +436,7 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index bd8322cdbcfe..098a523073b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -174,7 +174,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -468,7 +468,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c195742ee4f7..bdc3f37fe44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -182,7 +182,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -396,7 +396,7 @@ static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ed0f25f7ff5f..c44adeb4494c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -139,7 +139,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -355,7 +355,7 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 75ea91749276..dd392b787790 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -144,7 +144,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -347,7 +347,7 @@ static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 69aa555b7227..b9fdb91fa86c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -128,7 +128,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -311,7 +311,7 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
-- 
2.34.1

