Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4C9C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 04:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311D210E4B2;
	Tue, 30 Jul 2024 04:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iLgrlavm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B00F10E4B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 04:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrfcmkG09qreycvxtjUiXXGBlAWLdXEb2E775RJHO2CP4LV3eLm06pzQlmbcXEtz77i8NlM+iy2wybqYrbxyqJ1Q4ATH2OYu/Bqg0H/+9977lO1OdWmYYfrlmIMjy/WmZGUE0QjZmxqOwH9Baq/hLLD+12ybPNEVsfUUn4sk1pnbUh1uVvdAoEKkvYZqUmgF1Xrbt7AtczTjYIBI1Qr/OPdxiKDmSVb4xpAd0QspdGkczxZHc1aBGVvwEcm+s9IslT7lhOadTu5prABfrsTzKTFC9NXTFaWf+TucqKo4emml0mC/8yq5+99MJ6WPcIPI5K5oFbtjoBBMDjK1WZRiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiuy372tR0sLQMbJctZv4Hn1ZkuflwmaeTt/rA55HEk=;
 b=EAH6zv69nigYSFW0s7FYwV0uU4lcY66DysSoE70QgR4aSpjM63gZpsOblbB9FPTUqOEAmnbPWRXNAE0zB7A+4BFfbgc2islGLbWyYFyqYKkUFtzmJ5Ipn0OWOzkCZrwjfUZOtP56YilsUHv96yx2Ts/Cm9ELU1aJJvm2tNL6pz1aOjAKRfLpo5WMfQZuvIV21pX+xma+lzButA6C8hEW3ihQzcEoGghZJ+Kr779ViVtbidjH/E97XNLUvTyODqEqb2P14aQp3HkxXfQRIseL2xuIvDGAvn22SymxaP2V5GI2rVQIhDVR5rW9d51/OL13KPIZ15IIPYVLXCTc2v89SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiuy372tR0sLQMbJctZv4Hn1ZkuflwmaeTt/rA55HEk=;
 b=iLgrlavmtFwAd5iZqRvWGa4g39RmNjMgGR4PrIxgVbzRX4UwvK1aY+5ivLMMdCa0mYMOigalrpjRvRw+QVbgd+h3aTCrcc25sIjdth2E7bzWN5rqj6ejTHtu6pKeXHC2ws8x6LAI+0GWBuuqQlLHcfFIrLVegk7/X1h1sL9m6cQ=
Received: from BN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:e4::8)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 04:37:29 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::9a) by BN0PR02CA0003.outlook.office365.com
 (2603:10b6:408:e4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 04:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 04:37:29 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 23:37:27 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: use CPU for page table update if SDMA is
 unavailable
Date: Tue, 30 Jul 2024 12:36:52 +0800
Message-ID: <20240730043652.1455274-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: de878ca4-650b-4bb6-c4f8-08dcb05151f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ev7jV87z7AUMM3Pc+vQmKjXWNbKx4518hP2TH3D+Mv/QrdoKZVpi8aXX7x8?=
 =?us-ascii?Q?9SzVuu/alIQlrw36znA5X5M75n9M6rQw6VClVFzde7sYAYOtN/P2ENAWLWhY?=
 =?us-ascii?Q?9WaqnsV1QnzJ/gDfw1fA3TRK02YbZdRnKjsfq05zpINsZcwhZH4Vvu5i08YT?=
 =?us-ascii?Q?la1d3gGKd0hRnNW9xIWPCVe0EqL8LFq2H9T6RUNFJwtIo/YrK7lIptIEB9rH?=
 =?us-ascii?Q?jrJQVlvK+lF8Kk71u3QpDfeMW3gbDszUUtQ9WvB+vacvLNjfEH7XEFuYiq7x?=
 =?us-ascii?Q?ylhBNSfru3iOYc7epPbT4svfho78FYjBhtQy47c8lABonoBMyaXQmcwUFUpt?=
 =?us-ascii?Q?aARng15Csb+3umTdb9CDbzhHY74sMW/xfpZ8ZZcIk4dXD2+1gZzCQM5G7unC?=
 =?us-ascii?Q?axCI9NSH0eBS/PkI4RjBSPenwlI62t2TBetv7U5Ta5AIB7z9fPGZYKWE0aIh?=
 =?us-ascii?Q?jWSJzXY+ltz3ay5OM61p7C9kDIN3sQxFEQNKGTAW5ZwvogmkOoNDWcG6FShM?=
 =?us-ascii?Q?qVYw1uEZB7NADGvxt5A/yTy2X/9HT+Wex8JSfRtLa4a8WjmyO0QdE+TIi9fu?=
 =?us-ascii?Q?jeyINSZ+iUScdNSm0y0+QMha04fZuAmPvcpWfd9qIOw07bUkFdNAGcVmQhBc?=
 =?us-ascii?Q?D6MtFqbP6eXmBRf/DTIQjhOwOuGvTFJ8Nn3wDjKKpl7zzJaRF5qIEE7u9VUK?=
 =?us-ascii?Q?4nSQjgUytnfchxfQ1OcufOqQi3jSNQDV2xhv9bpTZpTnOqCKIIusJ3UdVDPz?=
 =?us-ascii?Q?cVvJ7DGU/t3wtqEqdN3JQh1DHR7PZOU+tVj7Nl5sXvFholWRyEcD1228rzyR?=
 =?us-ascii?Q?vWrmerqx68lw/pTk5gY5fQy3whPppQQakftZByjBGq19EH8WqFBrTHYgyNz4?=
 =?us-ascii?Q?l9J2CJzQoWKnG7eIprh5EX9+hLW1f+97/TDQ6BuGzaDGfc8gd7DFMl9OkIAh?=
 =?us-ascii?Q?dmV572x+PYMjmxbuP0pF1HjAbox8YhqCgRd1328VZUi3t1uy0nZj1u3IX92P?=
 =?us-ascii?Q?cBPVBPir9X7abe13rnHdPEUiqx6gpVWSGWeMxmWeHpHyOyBB06TaTsPykIoM?=
 =?us-ascii?Q?hw6P9fKTY5UfG6u7pvCvOFa+2GSNG+7RtWV1qIFKY3yB9wbNfdUjoZtOeAJB?=
 =?us-ascii?Q?63FuiXQY4wYcTA7DK4dfueSX0+NO3lSMNDblUP1udWmzTPI7Vdms7jCF6vdv?=
 =?us-ascii?Q?iVSWjysVAYXwSdCo/vfGwnxImH/I9Rr7DjxNptdskUbg/iaIbuXQegp2ACEs?=
 =?us-ascii?Q?y8LDo8UhhBHvPVBb0nHzdCF/+ntKO/5j3T5ugHBatVL6biukJyRZ/w/92ZgV?=
 =?us-ascii?Q?wClbWKYSe+RhDPYtfub+Pp78u2GWyp3J8CuH5QsRY4GvXzoQAqHtrT+0WZbO?=
 =?us-ascii?Q?C6UeXKYysIm3Td8Fs9ge89a8TWWwSKJaJ/nWcbQxyMaT1TjruFJqK4047pec?=
 =?us-ascii?Q?CWfzeMCOcjD7t4MSzetRItrtV81gHq2K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 04:37:29.2781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de878ca4-650b-4bb6-c4f8-08dcb05151f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779
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

avoid using SDMA if it is unavailable.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a060c28f0877..bcb729094521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2397,6 +2397,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int32_t xcp_id)
 {
+	struct amdgpu_ip_block *ip_block;
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
 	int r, i;
@@ -2426,6 +2427,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
+	/* use CPU for page table update if SDMA is unavailable */
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_SDMA);
+	if (!ip_block || ip_block->status.valid == false)
+		vm->use_cpu_for_update = true;
+
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
 	WARN_ONCE((vm->use_cpu_for_update &&
-- 
2.37.3

