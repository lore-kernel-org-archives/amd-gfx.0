Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA98BC54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 16:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9B311231F;
	Fri, 15 Mar 2024 16:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fgDvdL+X";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF10411231F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 16:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPzPFmrmJYpoKBTSQo+aCgPjlBq2SdNXRR1ch8qupr/HO+1mXElUlkxr/iKhYkhIoza+bc/VrR2azHGxFo6PqbhxADKA/yIfMU1p5/KDuMU+XSwLAjxpr2a/kIMHVTwjSdeAj67bVlifCIooKz+t4ifYYqoSAnHbg4YXaFWdOiVdJgITKZu894ncjH8dHLuc7aeCpSzv0VX2Gj6aYSz0s4Qj+f/SBKVfRBNOn9ey9yJ2LIhEEqBjYsIGlI8JMn7AuuNaClYsy63/lT4kKKT2wVLDlB6POCTs6yCAClR2C8Lm94UsBo7tiSK55KVEsY/0iehbQqXb4ogibWPmlKJG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFq6Fu/ipEqXvnAbokKf+DlkGsbpelwVmnPvsqj8zkA=;
 b=cgAXi9hcCNCDcIF1K3fLM6tv5hzaHRi8orbMG7Zi1uOTMyOQy4DrkrTSW+i1lioPIMUkY+7EJ6fGb4Xn9jXSKETz7u1qx7Gw+GO5PItNVjsPXZGTu8Z7IRVQKTVJjNut4UNFI5og4GrWApOSc3ckMOP4ZHY9OmkIxkK/IW2Cq6MS7TnJjF/mvoyUYd1FMsDA3DbumV2Kbl2rZ2C8dZ50wrK7pcwwDj7q4Xgw8cALYKcu1ZksblGYcLh+RcY2UdHN9AQOPwTxIdkaX5PBidRMhYlV58H2Ql+jY2XET6IYiU+bZHYG/IgXTdO37n8OhcGBaEI4N1dMMoah29ldBoMe5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFq6Fu/ipEqXvnAbokKf+DlkGsbpelwVmnPvsqj8zkA=;
 b=fgDvdL+XRom2Q/+rawJEJJP3D1x40aRwvsWbAMzJa3XbCHqz1ZdNEwsTKHSae/BcOK2M7fiCv2So+S8YFPJO+smO5rhI9rE1197JANRgnpmiaZJvhB1/g/HpKCW4L6qGiqOjYEthdxGj6MrlqqL4wNBnbFPYsRiyLHR9UMqKdnc=
Received: from BLAPR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:36e::19)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 16:01:24 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::ad) by BLAPR05CA0010.outlook.office365.com
 (2603:10b6:208:36e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8 via Frontend
 Transport; Fri, 15 Mar 2024 16:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 16:01:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 11:01:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Documentation: add a page on amdgpu debugging
Date: Fri, 15 Mar 2024 12:01:08 -0400
Message-ID: <20240315160108.2595995-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 04311480-97e7-4bb5-0d4b-08dc45092a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVCu+gAV/0U+/rmJLc3W1yZ+Wo3exCZrud4LvT5J0csZdZShzsoY8K17eTdeK3DmMgPBsJYShB/aDcQL3JdAdJX16jDkARdnOTeB07JLj6MMrqLTHg2L5jiAu0LBGgag492mUaVTnpo5JwWowRpCcp7nDLyaWjBxg40tinJa1qscHfsxxmUCAcM1ZUP/UI6FSytb2+ftrmksJgJqRlemQK9RIZpj36Pc++1Aj/aTmypMrN7eCwPx3XOQVVbkape9LGWbuG61cLtaMj9oLYwycA2hyuuzyKACBtlNhvyX7I6RsJ3uYfY78gH0jvbXhBH8ngZ0on2hk8oSn4zVAbUbE0eoPOnEk69+URMz15XAEwdteSuROPhIQw/2q6N+cPByobOt97bBMn4fAdPO+sjxSR1gbg087J5w6EBDZnG5AJNceLtu4yZufWc/+IS3Wdntypa6VdL964eQvghObywOrX2+DswNgy58wg7zwCJbWLyG1jJmOaHk7/PyZ7scbkos1sVbfazk+uBkdwGSpPO1+CLvnL0PIgGqZERCd7kxuk57DIz/tVgNf71D3uFBlT2Ewf74UHJJt5W8IROkWro5kQzR7q0ZyQ2xIkHTKlwE1Y6pA0RXmAIljvqVRYfFS0gxdTjGLsHM/v7mSULj4gNugK0rs4iTzumgwSQaRHOtsKf/iyzDlq8nrCxP1BDEtUl7aRs3ab3qnxz5E46ynkPatA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 16:01:24.2212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04311480-97e7-4bb5-0d4b-08dc45092a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
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

v2: update client ids to include SQC/G

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/debugging.rst | 79 ++++++++++++++++++++++++++
 Documentation/gpu/amdgpu/index.rst     |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/debugging.rst

diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/amdgpu/debugging.rst
new file mode 100644
index 000000000000..8b7fdcdf1158
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
+- TCP/SQC/SQG: Shaders
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

