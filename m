Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D20CF042B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31D610E5C8;
	Tue,  8 Oct 2024 21:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XPbWdsdO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F2010E5D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8szW1COEIfmMeZYnXCcNIwfRKp9FQr++yCwNooosgMWOaSC0Fskvza6VIT7uXUXQYIkwuwd3bBFGdQM3YC3ZiFtngQlKoKhdo9ZWg7TVcjZnJ0AHChAbzrqOZkaK3f2kp+yv6cdvDX0ExI1mU9z21p4ef7r+y//8IYrxe0+gX9KqdCFlhBuw46r3A0+HGuz9yHcaE0XacrOiMmeoY6qsW4WHy+9BS0MRyQHmKGRKLpHpiQKfHpF9XMB2iGSzS3B4stRTuY57vYSXP88OrGne6PTjxLQOhfwzDP50jwnZ2ZgqFiDo0kPDVIjo8lcJxnQE7kJAsklfMA4v6acPCtJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfjU+ca7ie1klR87Gt9xy5bVUNv+ofZj++fxb0HUiTk=;
 b=Qnk0Ccn3F+H0q6v4OZ7IwVZ7TWnaMJW1OscLUWCUHjJCrcBZayVECjMHLpaVCVHvr0iZGS4KI5Mw4weM9dorNxT/zXEELJrr/Sif4DaI+0c+9hIk9PFuaRYBk4nJydxaWpZLrna3uxs3GrziLduHFA6ggVFBSLQAP8Hs3UbcbuQlduwVBozhgyKoayMRRufUk7fKWJ6zU9wM4ejfs2egiDWCNBvnlAI8b/IlHdiLB4RRcYr+XSVfdc/t03WkSPm0tId1talSwO8smkWjby7a5MTVPVPKoFJaHx+fBlz0fyIq8eF+rd3Q046zTDNl0PqrqMYGJ/62rHfUcRGMi1zYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfjU+ca7ie1klR87Gt9xy5bVUNv+ofZj++fxb0HUiTk=;
 b=XPbWdsdOwF4GMO7qgTe1Qtg+wxncwd8sq5x5qFNPTChC5YJ9PlOQspXTWwKPa7OdIDH9hc125W3p4bl0V7w20H+DCIlTO8bAcsMEeUt9B9w58ZpZrnvZV8PBiIjd/Tm36cgxpQ1SUoQManQO6exxBhP1CE+7pnMPIYuNvaP2Uvs=
Received: from CH2PR05CA0032.namprd05.prod.outlook.com (2603:10b6:610::45) by
 MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 21:16:33 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::b7) by CH2PR05CA0032.outlook.office365.com
 (2603:10b6:610::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:32 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:28 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 25/32] drm/amdgpu: resume for each vcn instance
Date: Tue, 8 Oct 2024 17:15:46 -0400
Message-ID: <20241008211553.36264-26-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8315bd55-2406-4673-eca8-08dce7de7c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T4tOch7AJSqNgR68pYr4fgVy2Bg+8zmZSUjdbSab5AkIhaPb8XWmPpFHMwow?=
 =?us-ascii?Q?+06Tw2KNP9TgmocAHVxw06BGD2yTV2HF/eLST2bVAAe5fG6Nex01GnQe7IRp?=
 =?us-ascii?Q?uBSZjqlkTnjV6MRN4nGnNn2sm3Fa5U41yyo5Of/p6GSvC7dw+3Jyoy1oef4/?=
 =?us-ascii?Q?q4zrSmEsT50BMkUZuc+q6BZwslRgoz1j3LEgLogipbO8LJCqxLZg1a2B80GD?=
 =?us-ascii?Q?2Z30hwoGtQykNLKFidztO+VjYSthzTnULqb+LtEpg00uT7UXYpUrjkQdCD84?=
 =?us-ascii?Q?cg6faBKwxpH0/hVJKb79RWhKEgqYUp3EWOIDvUfdJCTnycAnv8lPjCxYFnDZ?=
 =?us-ascii?Q?z77y6UMjSviiOz9IygqSROMcZLKR6vgDw012q/+xsxAtHQuJwCFfrUhOcE0F?=
 =?us-ascii?Q?oSN9VfHUSUJUygeXiu2k/hANe4U62i1HSeL5hZS5iCnxf7MbtxOa81dihD90?=
 =?us-ascii?Q?xl2OYitrX7GmxIPczGO7fH2ThXwMMtVfIIgefiVW6DoQLzY9ZCm2mDjAxjtl?=
 =?us-ascii?Q?Wnkfk1fKC33ZoJ5zcnvi10oLniMwDk/HX13uPcaMuhk4vQb4JgU9KkNZ6erQ?=
 =?us-ascii?Q?ZTD6tXeN0QZrSv+cuXx+cq25PCz0O6hxQFPn5L8XetoiBju4AuDPcF1Im63B?=
 =?us-ascii?Q?9saUGKrQs/PY0LLPjE9ubrTRtarLad7b7b9xWnYhzvyUc8jT62HDiWvnX+Xw?=
 =?us-ascii?Q?MUSRAqJSSiRxKEmiyI3+r8H9tZ+GQo1+QcsJD5Vju3F1E5sJZSo+ncYLQAZ5?=
 =?us-ascii?Q?im6TSI2efdjwohgZFPFwg+kiAWuwUvX/yfhlZamDDLIrJK0C8LBeruWSb9Nk?=
 =?us-ascii?Q?ZmLmDGUkYozozX+pGLx5azhZ8AL6GeclO6ggmCo/JAhzLRo2EZpciGh8vZT7?=
 =?us-ascii?Q?g9q+INSvmD5702cL+Y2rqbLSSo/lV9tWrlfTpYVV/UGY+QYrQnsCNgHCBUfQ?=
 =?us-ascii?Q?O8lJX9u8++nd4nNyrypDbcn9An7BYXPT5ZS1zDurWi8sgC/hSNAsvwIMiNeE?=
 =?us-ascii?Q?thEiPgMuxXf7o1nn1711CzHdC18JypCfzICNXUn5BavqXOixbOkrJyUWnNvG?=
 =?us-ascii?Q?s83Y375r8YjfPhjf6IM4b6IKTO/DFGtND7UYQayD4VoeS+51riBadOLf6po1?=
 =?us-ascii?Q?gTfezmeGsfjPllPECKmgT2J4tj1FdnbApr9iDUHJ79upVJzGqblQRrPkcSsV?=
 =?us-ascii?Q?nNmJ4kikFIzg+h7EtDiKUmiTtSnU/le9TzvuX87iws0JQCPtkPdNWPporwjR?=
 =?us-ascii?Q?AP5i4Tc8yuUbi6xwiwO/E6TCXu9B+EUroFJnifoM7RSs14qh8f4/Yu/2Y8y1?=
 =?us-ascii?Q?oWvg0kowq2OhGl1cubMCKdjV0a2eEFzKOYaB0qOEqv8tfL093af7xOHSQVzB?=
 =?us-ascii?Q?Rf2SqvY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:32.8263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8315bd55-2406-4673-eca8-08dce7de7c12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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

