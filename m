Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B70ACCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 14:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25E218B8BD;
	Tue, 19 Jul 2022 14:04:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0928418B8D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 14:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTm5LnIhGL1/zU7rKEuFSiCGelx/SDvXBJZynE8l/wqa10xFX1tk0gnHZJnwkrIQuytiPM0ELUX+4pvBeBcpm8fiFGT22Kkaz9+kpjDlIbSwe3mAh0d49IwoVUubNS1BWc6adijGCHf0Bb4uKQYtP8YVauynoR6oAOvoGT6T970fmvitw6es2TDUNVZF95wEPo7WGsV/9TUPMWPNGkjw3tBM5kdXLFllxBV29bMiosVqefzHdmW5SfvPOk16+El4vbrkvOAQ4AsqIOlQNlnAR4NH4pVOkWQjJvWnDXRveBw6z4geuey6/Nfdf87X3E3LrPfp/TpEc34xkddGoMQsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Mn/pcSeMA711UQtJwNB+yNkkRVVPTiajMIvASGDlwM=;
 b=cDgn0eVkobjAYdGOLA9gaifaNEgAWNSJ/WWCEY6JJSHE4dBWlZmYaYE+lPBSyLwwEr4/5hvHmxiUk8vOjZTi/xn9LKhbXfw8qvOr/I0mjhjWU0AeUFZgu43X6cQAH1OmljDDk4A6+n4FYE2JLLUR+DWMrbvRrbBIk4TPD2MfFAe5aXh13zHArXIyTBQWbXbPyx/ZaCkK0yJwaPdUMzHKF/cb09fD8pH3VUTltrbE+wSIevJb+8Z8RGSSiv6FZvfoa6X1KUE1nPacGdw7yHajy4Iq/y1Q05i+69dp9A5I/ujFACg677LmXxtDJ6nL+h7UimNXcq+1ySWz5fWr7ZwmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Mn/pcSeMA711UQtJwNB+yNkkRVVPTiajMIvASGDlwM=;
 b=rORG/0uAjxdM+sMbmo7/Ekp4a94tBD8Kwd0c6DzpPoCOrMQ8Fkymhewi0bK1L3BfVmqlC9h47aohXcSpjC9gXjynSXRY5HyQnqJPDEiWP/eXicIeoJ3e/vR64o/7BjfzRoDjZc6LQYXWhRFUZz19jMjUp5Euy6cXNuaAA4Am7rc=
Received: from BN9PR03CA0379.namprd03.prod.outlook.com (2603:10b6:408:f7::24)
 by DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 14:04:36 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::2f) by BN9PR03CA0379.outlook.office365.com
 (2603:10b6:408:f7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Tue, 19 Jul 2022 14:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 14:04:35 +0000
Received: from david-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 09:04:33 -0500
From: <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/kfd: Add sphinx documentation for amdkfd
Date: Tue, 19 Jul 2022 10:03:38 -0400
Message-ID: <20220719140338.1644486-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719140338.1644486-1-David.Francis@amd.com>
References: <20220719140338.1644486-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ad06d6-0018-445b-3355-08da698f9ce7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWKimfHDy8Gjl+977CRjj4eI+CSiTX+DOGCMosLcyBgZsF5vfNH+p18+PKmLN7zDjU3Q3xjeuthTA5c5lwq3JZAP61FDPhYh9DMrrEqRPXajkTXU3ItEmEMeYoit1ciqmWJasRThv31j7pGOzfZyTTkNVb9EZzxHQg/TQ3rrwqeCvwFAuTFkLjFcz0EN38SB+X46X/kjsJrbv8YUhSEExX4EuXBhL87W9hLzI/hqcUP3/bYDkiWbfQk7OjGIywJ758C0RV8aS8wkgTgEMNW0+oVhVLetEgtHWtZrU/7DaFjqTtAwX13neeVz5hz5qMZCGGGVIPA+SQRVPgIffdBhT/SczTG5/NslwXkd1A5tm1qcX70jW3VCoQILKnwdaKy5LyqYiEYliSV/ghvjzjQVVyJBnSRsQ2ZQbDMF2RBN/y9hNurDoFJGxD0msGPy8cfYHxLffkFTku5tkiJr9uHV4sjV49SRxitUn2FFannVAoWLMl3KvjwDBPfe5WPZlKIIFCONvNgVfNYg0iwJRaubmbv/Iqw4WTU/lG2WstLWXYHBENnPT4I+FmMJG4kEewxtmPfn6kbv/GBv8lYKEAOVb/E/mpjvMEPwcnipUxPBjXLbOlxoZ3DcV++dvZm9VjNg5cwT26DsOnux8A6LAwG0reXn1vugDqYPhCRF2QgZ9q1HGUtD1qfFvPXn5euCK49BgvLGyKdGxqAyS2CdzD6VJSbLAiI+eOxeJhd4psPyp/tQK6nyPrUs/KUkHxzbq5W32D/wVYT7saI7anonsVsSKAzdLx46NNYHBCGOYA2kVMq3fhSKcTiZVLiCpkWiyVsP9hchuP389fAHZ88oEqpM1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(1076003)(186003)(16526019)(54906003)(40480700001)(83380400001)(6916009)(8676002)(426003)(336012)(47076005)(70586007)(70206006)(2876002)(4326008)(36756003)(7696005)(2906002)(2616005)(26005)(40460700003)(86362001)(82310400005)(36860700001)(478600001)(41300700001)(316002)(5660300002)(82740400003)(81166007)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 14:04:35.9358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ad06d6-0018-445b-3355-08da698f9ce7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
Cc: David Francis <David.Francis@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Francis <David.Francis@amd.com>

Add a new series of documentation entries in the AMDGPU
section describing AMDKFD, the compute driver for AMD
GPUs

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 Documentation/gpu/amdgpu/index.rst          |  1 +
 Documentation/gpu/amdgpu/kfd/index.rst      | 14 +++++++++
 Documentation/gpu/amdgpu/kfd/interrupts.rst | 19 ++++++++++++
 Documentation/gpu/amdgpu/kfd/memory.rst     | 33 +++++++++++++++++++++
 Documentation/gpu/amdgpu/kfd/queues.rst     | 21 +++++++++++++
 Documentation/gpu/amdgpu/kfd/topology.rst   | 13 ++++++++
 6 files changed, 101 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/kfd/index.rst
 create mode 100644 Documentation/gpu/amdgpu/kfd/interrupts.rst
 create mode 100644 Documentation/gpu/amdgpu/kfd/memory.rst
 create mode 100644 Documentation/gpu/amdgpu/kfd/queues.rst
 create mode 100644 Documentation/gpu/amdgpu/kfd/topology.rst

diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index a24e1cfa7407..e1152c40d78b 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -10,6 +10,7 @@ Next (GCN) architecture.
    module-parameters
    driver-core
    display/index
+   kfd/index
    xgmi
    ras
    thermal
diff --git a/Documentation/gpu/amdgpu/kfd/index.rst b/Documentation/gpu/amdgpu/kfd/index.rst
new file mode 100644
index 000000000000..c9bfc52c547a
--- /dev/null
+++ b/Documentation/gpu/amdgpu/kfd/index.rst
@@ -0,0 +1,14 @@
+===========================================
+drm/amd/amdkfd - Kernel Fusion Driver (KFD)
+===========================================
+
+KFD is the non-graphics component of AMDGPU. It allows users to run
+their own programs (called compute shaders) on
+AMD GPUs, including discrete GPUs, integrated GPUs, and APUs.
+
+.. toctree::
+
+   topology.rst
+   memory.rst
+   queues.rst
+   interrupts.rst
\ No newline at end of file
diff --git a/Documentation/gpu/amdgpu/kfd/interrupts.rst b/Documentation/gpu/amdgpu/kfd/interrupts.rst
new file mode 100644
index 000000000000..f59b985ca3f1
--- /dev/null
+++ b/Documentation/gpu/amdgpu/kfd/interrupts.rst
@@ -0,0 +1,19 @@
+======================
+Interrupts and Signals
+======================
+
+Signals
+-------
+
+Signals are locations in memory used for communication between CPUs
+and GPUs. Uses of signals include indicating that a kernel has completed
+and indicating that more scratch memory is rqeuired.
+
+CPUs and GPUs can poll signals to await their signalling. Processes can also
+set up an event, which will trigger a CPU interrupt when a signal arrives.
+
+Interrupts
+----------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+   :doc: KFD_Interrupts
\ No newline at end of file
diff --git a/Documentation/gpu/amdgpu/kfd/memory.rst b/Documentation/gpu/amdgpu/kfd/memory.rst
new file mode 100644
index 000000000000..2d6b3724d3fb
--- /dev/null
+++ b/Documentation/gpu/amdgpu/kfd/memory.rst
@@ -0,0 +1,33 @@
+=============================
+Memory Allocation and Mapping
+=============================
+
+AMD GPUs contain their own page tables used by the GPU's processors; memory must
+be mapped on these page tables before the GPU can access it. The GPUs also
+contain VRAM memory of their own, which can be allocated. By mapping memory on
+both the CPU and GPU, processes can load data onto or off of the GPU.
+
+Interface
+=========
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+   :doc: Memory_Types
+
+Implementation
+==============
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+   :doc: Memory_Implementation
+
+Memory Features
+===============
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+   :doc: Memory_Features
+
+
+ioctls
+======
+
+.. kernel-doc:: include/uapi/linux/kfd_ioctl.h
+   :identifiers: kfd_ioctl_alloc_memory_of_gpu_args kfd_ioctl_map_memory_to_gpu_args kfd_ioctl_svm_args kfd_ioctl_set_xnack_mode_args
\ No newline at end of file
diff --git a/Documentation/gpu/amdgpu/kfd/queues.rst b/Documentation/gpu/amdgpu/kfd/queues.rst
new file mode 100644
index 000000000000..dbd18029e0c8
--- /dev/null
+++ b/Documentation/gpu/amdgpu/kfd/queues.rst
@@ -0,0 +1,21 @@
+===============
+Usermode Queues
+===============
+
+Queues (HSA queues and DMA queues) are the means by which users may submit
+programs to be run on the GPU. Once a queue is set up, users can submit commands
+to the hardware through it with no driver involvement. This is different from
+the way that graphics shaders are loaded, which involves an ioctl each time.
+
+Interface
+=========
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+   :doc: Queue_Interface
+
+Implementation
+==============
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+   :doc: Queue_Implementation
+
diff --git a/Documentation/gpu/amdgpu/kfd/topology.rst b/Documentation/gpu/amdgpu/kfd/topology.rst
new file mode 100644
index 000000000000..309f2d01fed9
--- /dev/null
+++ b/Documentation/gpu/amdgpu/kfd/topology.rst
@@ -0,0 +1,13 @@
+====================
+AMD Compute Topology
+====================
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+   :doc: Topology
+
+
+Discovery and Initialization
+============================
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdkfd/kfd_device.c
+   :doc: Discovery
-- 
2.25.1

