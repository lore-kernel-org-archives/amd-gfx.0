Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E7DC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 08:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFAE710E862;
	Wed, 28 Feb 2024 08:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nrW1IOb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD47B10E862
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 08:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faayShvBqpm981hL9mNAF6fhxLDITE7K26ezAsRGNo2Udih05KIpBIuIcxblHqRiUBGKoeclBHSGANwuAVm3MRcSbQ4fE2hl9oo8gPLRyUTecqqTWqXl7SrNl9e9DPVsQ56Ik+LevnqqVMdzO2DMIJkhQ1isKkFSEyshwjf94GTE+UxF+1rTviilRI2f5schq571H2d8pejj7uoXmu40GGdXukf+c92vpxp4m5xofVrrnkbTQQ2UQtb6xT0wX3mYrN1dgNPWtv7in2oAsCdrlg1AeCrj0mHhup/35MlLuPXJHOEsGtlb74ctO0gQMRRoq5zSI6VzPNOWn6c5qbevHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vabYJXJa+HyheaGlCmtJKkv4wawLrixOnE6dFv4jzc=;
 b=W0Klw7Vxh8x3AYXyjFshtL8yuDcy+rP80bRknXHYLJpcnv6E0eQ3XR1vU2IEM33FNytVcg4G7j/iCFqreJ6RqXmOLhult7mNGereIUizKe57ybHSUrrl9W7AhtFTsbfv1OfS5jg5pOMIdYk18cY2LzOcVvaeL1pfvziDSCJAO7mVXmk8NdpvB5kIx1up6RuAI9Ou23Hq3OrdcxloAxSVD/8koZmtrvAjJSYBeO0e3HYB2hZL8embTF5qBkj3x5j0wJrqK/jKo4CB09C9xX+LMdG2u5sHR1HRPEmdeICU6AnsxtRVBmuoobQHLxNayQ1Xaw3+c6kzlGnnwH2z1oK5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vabYJXJa+HyheaGlCmtJKkv4wawLrixOnE6dFv4jzc=;
 b=5nrW1IOb8C7Q9Ytexzk6t4KLfQyhBz8O4P8UK+9ivNz9/YKU7OTqm33XVbYZnvyLRl940XHaaCw+9eytljbWP9/8J5Y43t+dkTrEjjGDXSZd8WFl6/qnolYwUKw01208koNps/Kak6UoBLem2H3daVedsROojtsMQJmukLM5F6g=
Received: from DM6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:5:1b3::34)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 08:43:22 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::38) by DM6PR17CA0021.outlook.office365.com
 (2603:10b6:5:1b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 08:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 08:43:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 02:43:18 -0600
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 28 Feb 2024 02:43:17 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Arunpravin.PaneerSelvam@amd.com>,
 <Felix.Kuehling@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Date: Wed, 28 Feb 2024 16:43:16 +0800
Message-ID: <20240228084316.124843-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 7515ca82-3308-4b33-3eb7-08dc38395251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBrI/N6dKH2bgQH/wV9wIDERcRCgZqse2AF8JrRsO3JdSzr/Uv2R7ibJCHGv3hvqjX4J8/22gw7TZjuyNnyKNsr26DV03zBr1GmIHxOEjHG4pbhCKo/Cv4BvgUteciEMsuP9oP3SdypDZtfEWQW9hzmJB03VsTjgMsbt2XXr8+a/RvVCR/mgNYy5kGZDL0YTsZzv91+qVFnHKkC5rG/q8h7i9uJWnoHMoUcAQTIAIKvru6CH5fyTFLPYgYfWFuLlGJkuOTRxUA+OaXhtuiHT/ZUldhupCX6Q9img5kHmwNzt8UaHHPR+pxyk1hBOhAkWGwuqz6GgY8t9wrD2zeaKNxKyiMMGh6TzuixU6jgzWnjjAj3R77vxYoWc26ccdeP2MVj10vXPzidpjLJxb/wBY6Hi1LrCdDKVwAS9L2JVjEC3keWfROI+52BsQZpWeu0Qb4IW5ub1Jus5k7o/+T44c9TYxbFvMZtJK/dSp613yUrFfl8JcB0nsq8VZeUQ/65PdOpXeWbcTVpps1YmkhJLgM/TtpE+/mIh7w8VpU2Rjxu2It6Edwy2U3hIbiY+yCeqV57WeafztuJfB9HsZ/unpuncH9sWCUS35Mm7igBIpLYxGZ9DM09eCt63mPzPYn5HLXHiFhs645YJk4elny6ujv/KTC+wxSltQ2/pvI8b5LwTsC7Tv2eJ5WGpxCUeJ8LsnRylc94eKIaiwulMVJznC4Uf9EDIv7J7Bc86r49TiLsSYZHGhsRqZMWQt3oyOqqd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 08:43:22.4021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7515ca82-3308-4b33-3eb7-08dc38395251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

fix the issue:
"amdgpu: Failed to create process VM object".

[Why]when amdgpu initialized, seq64 do mampping and update bo mapping in vm page table.
But when clifo run. It also initializes a vm for a process device through the function kfd_process_device_init_vm
and ensure the root PD is clean through the function amdgpu_vm_pt_is_root_clean.
So they have a conflict, and clinfo  always failed.

[HOW]
Skip the seq64 entry check in vm page table.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a160265ddc07..bdae5381887e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -746,8 +746,21 @@ bool amdgpu_vm_pt_is_root_clean(struct amdgpu_device *adev,
 	enum amdgpu_vm_level root = adev->vm_manager.root_level;
 	unsigned int entries = amdgpu_vm_pt_num_entries(adev, root);
 	unsigned int i = 0;
+	u64 seq64_addr = (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) - AMDGPU_VA_RESERVED_TOP;
+
+	seq64_addr /= AMDGPU_GPU_PAGE_SIZE;
+	mask = amdgpu_vm_pt_entries_mask(adev, adev->vm_manager.root_level);
+	shift = amdgpu_vm_pt_level_shift(adev, adev->vm_manager.root_level);
+	seq64_entry = (seq64_addr >> shift) & mask;
 
 	for (i = 0; i < entries; i++) {
+		/* seq64  reserve 2M memory from top of address space.
+		 * Then do the mapping and update the vm page table at amdgpu initialize.
+		 * So skip the know result.
+		 */
+
+		if(i == seq64_entry)
+			continue;
 		if (to_amdgpu_bo_vm(vm->root.bo)->entries[i].bo)
 			return false;
 	}
-- 
2.34.1

