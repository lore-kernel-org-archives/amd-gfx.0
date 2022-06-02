Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE28C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5510710F473;
	Thu,  2 Jun 2022 13:21:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B624610F546
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbFSXrc/7rYZETAVBc6qjR+EvjcjBCLIKWWXRJBVXh5yV9ML6WdT4kIK193QU2VhgxEBscXZ0Fzisij+OmEWlneMPnuaXplh6BMfgf4fessxj3qRomRlcyiRPEHqrQsuANoHbiRmm4UDxWRdZavqaDjoxhOSovBuBvuy5Q21+pUNSwWwbKU1rDu6OZVGXQ71FdHaSd1Z10VLUTro3W/RKNH6WLwfcRVfVvt1OInNfXQqwR93BYi9+iXlMwPTNY+D22pswInp01enS9pOMIbFuz8aONMvMPaEygkI+dGGHx4xn7Kb2S8XxlSLBisai3umBNVYBiltlmmIZTJzED3POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAuBmhAvCCosCdVlpqd7nG0oBkmD26+9vANeoijktQY=;
 b=oLaK/qlc1vee2uGoJfaj0cyvzIgU3uIqqHY6pFVo33j8a5gGZ4ao9s5EHCQ40eDDobuNnu27m1Y74z5B9j1YvQ9bsy8RVj0eNGcWKfSZ5W7kUkX95wm7tv1BZw8rC81GbE92ciF22oG0IzdNgqbhw74bNy+bVNVkp02OZCSxgj6LLBmoUrdbWIk6ZU+192fwSBqI66ibUrlv+GHwuAXwISNfrSgKau8k74uccVNCyNLwCgyWmilXFb2oWzhblIV5GG+Y13HoAx2LFbJUUipYDCo2OmkcmuozVITKQF1iobB5EiROINBk9MicvpWtCsYfeVW1IhvLQ2X25wvjWYXwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAuBmhAvCCosCdVlpqd7nG0oBkmD26+9vANeoijktQY=;
 b=a4k0/6iNNjTpUOMhXfRtLjZbTQqvsJayGrUrDMo5hxuXexg3FHNB0XfU5YXfiE7wY1l5akwx3J973ItQ0g1gXnGiLgybPOrDzySFDAfuozBf9kybA4F9HEdH9uv9j9Yzp1UsRhKsVJgka9qyYVPGxywsz20XBI/+L7uRCxw9pqM=
Received: from DM5PR11CA0020.namprd11.prod.outlook.com (2603:10b6:3:115::30)
 by DM5PR12MB2423.namprd12.prod.outlook.com (2603:10b6:4:b3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 13:21:29 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::7e) by DM5PR11CA0020.outlook.office365.com
 (2603:10b6:3:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Thu, 2 Jun 2022 13:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 13:21:29 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 08:21:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/1] drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
Date: Thu, 2 Jun 2022 09:20:29 -0400
Message-ID: <20220602132029.6225-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d71711d-c0c0-4cf8-278c-08da449acdab
X-MS-TrafficTypeDiagnostic: DM5PR12MB2423:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB242365278D57B1FD7792B55CE6DE9@DM5PR12MB2423.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eFwQj6h0lH8yWV4/AplJq9jU5dfYUH/KUWyFsutcvv3ZigPyLPUqSgK/BOBQkDDg3c+Z0FIe/PA63jhKwj15rlCFbX0ZCtGsrdpfRO9W21EvwPPC8Wkku7kjdHy9Vh3gO5elT/NkbMe8I7eEtL4QNd4a7UIQ0O6Q6ALpXvv9SdAtZxEdlcipjgZVy17hdVDxD+iOTa5MVRP8XQRPX5eoj7oQ3kJAKKkVREnuEmvGWS3RoyJNuP8PJovarVRzc2rPAZAf4bYZ4u2SXtDP5VjrLAdXdDconHZruxZR5mJu429m2p6p3/VURIhbzD0kyd8j+eXi+jMnmed1obo265ZvWoWClu0q37fKQ7LOuD0ID73s+OH0kyVR0WZjZbMSR1QP47tMKOvwVbAUWdJr1fT+H8Ao8GPKSLA/QrA+7UXePDqLVAHbt4kVgptX9LwosxdTdhqo7Q8Lay4Sb6k5XrH5ijGuTdylx/0a2KXJMdqJ6ZVS1eWIexCKGdrHis8IeKdqAr9YVLUKzLfRJk6ulTI8fji2dmGfwAVqqDpPZayz37jaz/EXob6lzbggM/b0xEfPiV0bwHBv/yaUc56HWvgQtJxbG0RxMFKL0G7y0Y1u93Hydndek7WFvlbc6gXc6BMnLiUJTFxB1kV6KvX7Ym+SY9MsAyozAlxdu5rdaN9eRt7TysMjMqbLeLYYzGu2WYbDv7ohz7HaVd0lTJkxnQzNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(356005)(2616005)(86362001)(4326008)(40460700003)(426003)(66574015)(2906002)(47076005)(316002)(336012)(83380400001)(1076003)(70206006)(70586007)(36860700001)(186003)(16526019)(15650500001)(508600001)(5660300002)(7696005)(36756003)(81166007)(54906003)(6916009)(8936002)(82310400005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:21:29.1451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d71711d-c0c0-4cf8-278c-08da449acdab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2423
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
Cc: Philip Yang <Philip.Yang@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Flush TLBs when existing PDEs are updated because a PTB or PDB moved,
but avoids unnecessary TLB flushes when new PDBs or PTBs are added to
the page table, which commonly happens when memory is mapped for the
first time.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9596c22fded6..1ea204218903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -737,6 +737,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry;
+	bool flush_tlb_needed = false;
 	int r, idx;
 
 	if (list_empty(&vm->relocated))
@@ -755,6 +756,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 		goto error;
 
 	list_for_each_entry(entry, &vm->relocated, vm_status) {
+		/* vm_flush_needed after updating moved PDEs */
+		flush_tlb_needed |= entry->moved;
+
 		r = amdgpu_vm_pde_update(&params, entry);
 		if (r)
 			goto error;
@@ -764,8 +768,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	/* vm_flush_needed after updating PDEs */
-	atomic64_inc(&vm->tlb_seq);
+	if (flush_tlb_needed)
+		atomic64_inc(&vm->tlb_seq);
 
 	while (!list_empty(&vm->relocated)) {
 		entry = list_first_entry(&vm->relocated,
-- 
2.35.1

