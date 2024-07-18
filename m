Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982A0C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCCF10EB26;
	Thu, 18 Jul 2024 21:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rmKQH2Cs";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2291B10EB26
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAI9E+wM1GQLyCVhm0FNE9gJYy15NjAIb/+yNoQwjcERgS4RrCOB8sgvFhDoT7W2cUEX8gtegrkn2TFDy0+KTaPi0TAYwSp9Ua4ai8+VeoTib4/scFkET4HfRc1FODJ3PZi34TlHUWkTtt5zcrvIPsPpcg5udZjS2dcZic3BfmvnYvVeP++FnSbg1n2jhzzCSgcNQd4Y8b33l8Tr6oh4bNwZ16G6xN0lfEz/fKO8K8A4pKUCYunmsP/rPYVairOqRAfJ6/0nQ1yOd7BsXx0LuOdiVN7scPNydTdojeuv1fZ+wTrpl0A/D6QfywrFIhbP+HVlvQmiIABWJNq4eQEjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hxzn+27mOKq+zOiPAj97Lx2oXzWDUH+Lcu2wDnKgks=;
 b=K3XcFLryxLLt/IVvL4drE2xefo749oVqlAD55fs5r5oid6NR8k16e1RRoFstiJfLvouKaBjtYSwJfAaXllr//BDWqsYmFuREKEAQbLvAqbbV3XDEhwGSQUBpx8SMIqQJglLKrlTQTbTvQKawzuyGXiKaUS2QSsJ9CxhUlftmDiY58hepWCgc6yMwMejlWVY7ry5Wg5xlfElC41on41MdmIl4IJBOlsDdh228xdaPvyheFa3K+1Kc+qYhaBneFMvgNHHESQW6+7bJKxGylfVVN19w453/5cBznfVluiCQZlHMqHYY2635qNZpt9+WDilxntcLXjPQFGN+/7u3BIcVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hxzn+27mOKq+zOiPAj97Lx2oXzWDUH+Lcu2wDnKgks=;
 b=rmKQH2CsvFWYi9HHLGAL/RaBxycgrEHoafbMKMQADDK4+OtIdKq+zGsso+QKtoghnbqtjGJq1U/6FH+8d2XGjmyhxuaVd6Nd6PVv+m3OVHZVLAVTEYwQgx4vh3yAbzjS1kJZ7MtTehtQjYrGQdsSbBCS2gIUiC/GoUjlY04aD+g=
Received: from SA0PR11CA0110.namprd11.prod.outlook.com (2603:10b6:806:d1::25)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 21:06:14 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::7f) by SA0PR11CA0110.outlook.office365.com
 (2603:10b6:806:d1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:12 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:11 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 0/9] KFD user queue validation
Date: Thu, 18 Jul 2024 17:05:49 -0400
Message-ID: <20240718210558.26340-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbf81a6-ef20-476e-06ee-08dca76d7448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kKutpqbrPT1uHZpkUokVNseEqnMnfPJYng4Q5/JF97VdM/NQAZq8lTEOqiuA?=
 =?us-ascii?Q?cyimeSMBGvk7Fm2lUgWSz16EiGX3O+AxYVIgWoF2EiZKvkWEaTzB5exBoq23?=
 =?us-ascii?Q?32VpHnOHgnz0hFDDyObkEJVszbNRK9UhcL4S0rTxVXDy1GoOfqPPD8XhZSzW?=
 =?us-ascii?Q?G+QCwlrW9y2gzQDR/ViyYc4wapnqY8eljxyzpNow5bjh9ay0FL+cw4ZIwI1S?=
 =?us-ascii?Q?aCMxP/PPpvCaDxamUmD/8uv/tuOOV4lPSclm6zvNqHskObu0Bvuh5vHF0rgT?=
 =?us-ascii?Q?uiMoJpG0bq/7PBlAgoHcwtwg54ZZ7W7kn61lWdlLpIn4Xov0/Ibo6Ni4MLmG?=
 =?us-ascii?Q?8DsekTylPS7pZX0y3BQm5wDyv1k/vwr0BMg8SBJDFonypgcWPBJF4rDgVYRP?=
 =?us-ascii?Q?sy9I7M2+hoWaaMQLON62ue7XkC8gDrwvm6AqlntFTkYeYADw3I7VPMtQPvSe?=
 =?us-ascii?Q?01HMFx3pzBVlDEr1MGPJI31QSaJsS7LkFWH1FCID16mCsxVvqnRB2hh+zMjR?=
 =?us-ascii?Q?A2Vek2jlDr8fnmoXuF+nRpiBASxBnT/MSF976YfS+bHgUx1nUChWJs2v3m2A?=
 =?us-ascii?Q?RI0VZxEZKU0tyhlUc3aoIUurzC/f5IeEI8T8hXfoG/MkVAQXk4RgD4mjAmej?=
 =?us-ascii?Q?qvQBoQDz0XX4Hot89gCUudVa0h3FT0rNzTU67Zk1ztgFTcX//6/oICrfyzDp?=
 =?us-ascii?Q?fZlMUwcrTzZOMDpc97gHyUyYAVGOljYGqkjOAuGSPiEEkUkF6B2UNV25y/Md?=
 =?us-ascii?Q?vPB+jy97kz+isJrhjHEUDPav50FxprZD8xrpP7O4Pv5ARC5yn3BGl9PEo+SK?=
 =?us-ascii?Q?WoFUK/wL2OgZxMD+Wy97/cGQfnt7Y+CPgeP0qGRpos3jSO58Ghek+mP/qEZZ?=
 =?us-ascii?Q?/Q1xFzF6+p4n0WE87Fo7XtqzbqYSVqsU07RAwKXQoz1vecn+h0dWgxA71fHf?=
 =?us-ascii?Q?wLDznziLMv7zBbDAE/Di2jd636vg0ZzQckDhMom9eRp795UgqB2/syiEpStY?=
 =?us-ascii?Q?yHX+6OuzD/6MZKtxxO5OheeqJ0PAbIxNYYI3jAqz8QZ2RdQhiC2FxtFxtCjS?=
 =?us-ascii?Q?ZoaHeB9axBDjf+X7nJrWcal304TXxKmLvGA3qJxno3cLk3lsupH4DYMUyvcZ?=
 =?us-ascii?Q?k88D7yVAnNYbgcmtab2tdTPtO6wu5+ndEZGbpl2flxYlzTKjocF/k7ojfJMg?=
 =?us-ascii?Q?FUv4Xw9LLIjEtwvyQtxLAxSRuiJkNlFy6ud2B+xSLK64zoC3m1hx3L8vVjS4?=
 =?us-ascii?Q?PEQfrXTuVh0IsajQh6ahQ+V4qPHQ+bNdBpMiGC18ZRCT2K07aLS9KVUQcY4z?=
 =?us-ascii?Q?dnuPsB2bF0KToCWy8+MGNveu0dmqibyaXh2Fxo9hmgs0pimDy7/VBd98ngKu?=
 =?us-ascii?Q?F6vdgeTBUUsdlpLA4obtX28ovBDl902bUakfYxuOW8Fl2dc6o019NlqZ6jUJ?=
 =?us-ascii?Q?NHssssdNLySOakn7cHqNlyjyf5Ij3s0G?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:12.2981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbf81a6-ef20-476e-06ee-08dca76d7448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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

This patch series do additional queue buffers validation in the queue
creation IOCTLS, fail the queue creation if buffers not mapped on the GPU
with the expected size.

Ensure queue buffers residency by tracking the GPUVM virtual addresses
for queue buffers to return error if the user tries to free and unmap them
when the qeueu is active, or evict the queue if SVM memory is unmapped and
freed from CPU.

Patch 1-2 is prepration work and general fix.

v2:
 - patch 3/9, keep wptr_bo_gart in struct queue

Philip Yang (9):
  drm/amdkfd: kfd_bo_mapped_dev support partition
  drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer
  drm/amdkfd: Refactor queue wptr_bo GART mapping
  drm/amdkfd: Validate user queue buffers
  drm/amdkfd: Ensure user queue buffers residency
  drm/amdkfd: Validate user queue svm memory residency
  drm/amdkfd: Validate user queue update
  drm/amdkfd: Store queue cwsr area size to node properties
  drm/amdkfd: Validate queue cwsr area and eop buffer size

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   6 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  61 +---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  79 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 336 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  12 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   4 +
 16 files changed, 489 insertions(+), 91 deletions(-)

-- 
2.43.2

