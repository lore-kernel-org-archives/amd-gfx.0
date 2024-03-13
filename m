Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F6EC54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 21:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD4110F1AF;
	Wed, 13 Mar 2024 21:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i2Sk9RI8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10A010F1AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 21:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5yJWI2fFqCofI6fROGG3kRqSvSKd/WA9/HW92spIVFbRHxYXa/fxJ7lowNSMo9KKcOCAHm3SYSxeXTqCQMGRwbPx8jQZji9Hnzii8GSfLHZUXHHA7F18m1mszv1kATCjbImGXZ01O+hzVxasGMIMDvIx8NsjCdL3p0Dk6d3q7xOAj1hcE3Xc8Vm2gGXx4xlNo2G/0J+O19WdglXZPvdfVor9MrMZb9mf3CR+gAuzVZGf3WIwl2Czphh4vJS7iMU5tuSmGflbbwjH1/8j2+if1Qf/Sp2X/AB8mEhhQdv0Hs0amY4ydMt2ch5kLa4RgtEK0Fr4H4mAAYQ9/48GvIT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+v6+09Q54RgKmakLJvO4/VD2Y2Yzdbi1vCtjoU0UMc=;
 b=JFHvYrzM1S8KpWsiwpx1ZXDISKcznjqM/e0fBQfuhrQBC9y67/G8zyJPX22S1k7XgpqdQqWwv/f+eM7YTc6cpaut0iatyQyqZHICaGWT+TsBg9GYLkUgSDn8aVOVpA4DQ+5k21o/BNpx7bgNEjXivxf4M/MwcM+6/RRsicBjC3kbaeh8i7cKcrg0ZTBKO7t3thWyfaLs5omPZUfrebYyLPtY/FFWSt9rRpGcsvRLz7bQye1yX3wwZ7SuH/+Iq4iFJB7LTn1fY/6K8ZCpxRZHsXWBQ48UBQNTJxhvFV7mH3SQk+T84OvVi0tM+ybCYU8fc+vkHlqoYa/3QBofMfyTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+v6+09Q54RgKmakLJvO4/VD2Y2Yzdbi1vCtjoU0UMc=;
 b=i2Sk9RI8SgATZGpKDq7jaFIkTmjHD521VvHqYaTaWT9H2E1kwLMVK3AaL3HqCMuU2G0nNCdawvtDfT6GUsG36t41Dxo7ZQtUdt7zQbwUcuSFnQKpYSlcOoImoqNq6DTJSeZ1MNP0zdE/nlE+0yGk8dFfQhY+9tg/NcolCkmFS/U=
Received: from MW4PR04CA0382.namprd04.prod.outlook.com (2603:10b6:303:81::27)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 21:02:16 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:81:cafe::8a) by MW4PR04CA0382.outlook.office365.com
 (2603:10b6:303:81::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 13 Mar 2024 21:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.0 via Frontend Transport; Wed, 13 Mar 2024 21:02:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 16:02:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Documentation: add a page on amdgpu debugging
Date: Wed, 13 Mar 2024 17:01:47 -0400
Message-ID: <20240313210147.484930-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f06a3c-de68-4ca7-d322-08dc43a0dcf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zic3aiLLs1m98EcJ+lPhBlXskrkL7MYhW10QyQtaNiy/i9OOk0vHLHcpcssrXTiFbYQhFbPnoYN99G6TV7iWllQg6tC8gg8X70VMyYoRkTnPwp/GIb45TfRIjyoaoc4KnqCoSY8C+R7+LoAyIpGOnBUqHI9I5+FGrzfY3biGNMkIVKQRRzaZ8RTZv8Qtmt99LBxwPCXpxiUh+/OvOtmU732r6qlpJfISux7nxp6QQdK6WVLk6VXaJb8eygfdZOCtBmLDLe1+LMS/0cggVmSqEkiQ4lihuGMPN66u70iQWmc2OvwnVr+XZgpj6UlvRkXsWoybWkNnN7O79L53ybf/VTsSOhGl+LlD+4ZZ5uBn3WGDl/+aPwffQijq4Mo55hSR+U6Y5CQksps0A/JVVpmD5rWJVrYyQVZ5V7OuK6Qu2q3gZpkLJ35Of8gIfLzdlHlknxUlZgdHZrtnLYbyeuLc8xVIEGvHQ0yjxlr13kvUVMwFD8RUNza/HHa3zK+yY9rSQNKEf2xs++0Z0qtU14Zig5QBsuEA3453PJoOEhO84N3EEBYx6kn+9RpHh/i8VoilLbU1/6PS+hJmXqykA6Yjp/FKTVmkUJpTQk2QdqqfPR29fZ4eXDrh9pzykCquS6jgKGy7dwruJwZI5A4tXdrgfw9lJqThmt30aaqZ+L4yTrkAUd4DGv+QSVguXhvx4SRSI4ghID8Go5LEC4OOtI1CqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 21:02:15.9549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f06a3c-de68-4ca7-d322-08dc43a0dcf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

Covers GPU page fault debugging and adds a reference
to umr.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/debugging.rst | 79 ++++++++++++++++++++++++++
 Documentation/gpu/amdgpu/index.rst     |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/debugging.rst

diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/amdgpu/debugging.rst
new file mode 100644
index 000000000000..29971a7a6815
--- /dev/null
+++ b/Documentation/gpu/amdgpu/debugging.rst
@@ -0,0 +1,79 @@
+===============
+ GPU Debugging
+===============
+
+GPUVM Debugging
+===============
+
+To aid in debugging GPU virtual memory related problems, the driver supports a
+number of options module paramters:
+
+`vm_fault_stop` - If non-0, halt the GPU memory controller on a GPU page fault.
+
+`vm_update_mode` - If non-0, use the CPU to update GPU page tables rather than
+the GPU.
+
+
+Decoding a GPUVM Page Fault
+===========================
+
+If you see a GPU page fault in the kernel log, you can decode it to figure
+out what is going wrong in your application.  A page fault in your kernel
+log may look something like this:
+
+::
+
+ [gfxhub0] no-retry page fault (src_id:0 ring:24 vmid:3 pasid:32777, for process glxinfo pid 2424 thread glxinfo:cs0 pid 2425)
+   in page starting at address 0x0000800102800000 from IH client 0x1b (UTCL2)
+ VM_L2_PROTECTION_FAULT_STATUS:0x00301030
+ 	Faulty UTCL2 client ID: TCP (0x8)
+ 	MORE_FAULTS: 0x0
+ 	WALKER_ERROR: 0x0
+ 	PERMISSION_FAULTS: 0x3
+ 	MAPPING_ERROR: 0x0
+ 	RW: 0x0
+
+First you have the memory hub, gfxhub and mmhub.  gfxhub is the memory
+hub used for graphics, compute, and sdma on some chips.  mmhub is the
+memory hub used for multi-media and sdma on some chips.
+
+Next you have the vmid and pasid.  If the vmid is 0, this fault was likely
+caused by the kernel driver or firmware.  If the vmid is non-0, it is generally
+a fault in a user application.  The pasid is used to link a vmid to a system
+process id.  If the process is active when the fault happens, the process
+information will be printed.
+
+The GPU virtual address that caused the fault comes next.
+
+The client ID indicates the GPU block that caused the fault.
+Some common client IDs:
+
+- CB/DB: The color/depth backend of the graphics pipe
+- CPF: Command Processor Frontend
+- CPC: Command Processor Compute
+- CPG: Command Processor Graphics
+- TCP: Shaders
+- SDMA: SDMA engines
+- VCN: Video encode/decode engines
+- JPEG: JPEG engines
+
+PERMISSION_FAULTS describe what faults were encountered:
+
+- bit 0: the PTE was not valid
+- bit 1: the PTE read bit was not set
+- bit 2: the PTE write bit was not set
+- bit 3: the PTE execute bit was not set
+
+Finally, RW, indicates whether the access was a read (0) or a write (1).
+
+In the example above, a shader (cliend id = TCP) generated a read (RW = 0x0) to
+an invalid page (PERMISSION_FAULTS = 0x3) at GPU virtual address
+0x0000800102800000.  The user can then inspect can then inspect their shader
+code and resource descriptor state to determine what caused the GPU page fault.
+
+UMR
+===
+
+`umr <https://gitlab.freedesktop.org/tomstdenis/umr>`_ is a general purpose
+GPU debugging and diagnostics tool.  Please see the umr documentation for
+more information about its capabilities.
diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index 912e699fd373..847e04924030 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -15,4 +15,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
    ras
    thermal
    driver-misc
+   debugging
    amdgpu-glossary
-- 
2.44.0

