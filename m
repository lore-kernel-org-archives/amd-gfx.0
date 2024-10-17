Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F91D3748F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE1E10E835;
	Thu, 17 Oct 2024 13:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="udRdm4uV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7561C10E82D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBX15F5TEAgzEXKb2Pm6C/W429JRh82O33m8VYrBtlT5MO+pvSJ0SYf9VBIlrbyxRt1vxUpLeu77s9g9NNDd2RIgkkC2Bb4p5hw9hdZBPM3CM8Z6ah68nlbHAGg1EHanGIHnVZCqFjkqFsQtEXhf8ECoRS5yuLW0N/T+HKcyhVARHPQv09amrDN2tyFaw8cDZbPy4XMyymr4OJjv+bUTocd0BWm8Abapg39M5BDWbTeRk6JWfFrZyEKCdtHWyWrzi+SG7ngqAt+zPQ7YHIlzwbxGvZ0LBRIQqSHI9hDetoxnYBpfueUQ2nqd18ivQRZajs9ibSOgI9I1LXtig7Cz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWDN8h2Chn7QizLxGVR4E5uJFZUbDWt95xB/HlOoCDA=;
 b=wxgL94phHzNoSu/0YuZ+3svGpTX7UhsxJmOzdGoYipyKm8dfwXAXfjsCETqcg/7VIMH8qjJXHQk4e1M4e53yheN1+INDAJx6POEpLMhS3CAtWHYd35r/ONy9P0/BbLgtFCkJdPCly6VgVsY+SoIqvVOFxJE70De4PjFLrrA1cykTsMCPkvNV/ePEi/m25oQ7Ea4voSOZutzHq+3oE88exD69CAAd/b5Zjdvjlt9YPSBnmBwWOFOdoXWAruDYsTkwmNbHfSVwCwGdC5ykusPRSmGghvB4508O2mgPGr2ObN/IEm2IA+ET6PuGVDOG3JIjldz4QmiNlSTyitV9XWohdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWDN8h2Chn7QizLxGVR4E5uJFZUbDWt95xB/HlOoCDA=;
 b=udRdm4uVpfvU4nXK9fOLqrFYX9jtUppd3bv9DNS74BFyeyrJFiyUbqLGwjzTCgHuMeeEBnQ6oy9gfIvuu+CnAiEjwuoz2NknglkPvh0LPkMmme318+0EF+E4LI3/RdIoRVreP+9fcgH3ntE0XsCTwywQx15zMwClL5647ZYx2ys=
Received: from BN9PR03CA0871.namprd03.prod.outlook.com (2603:10b6:408:13c::6)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 13:21:30 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::be) by BN9PR03CA0871.outlook.office365.com
 (2603:10b6:408:13c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:28 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 21/32] drm/amdgpu: sw_init for each vcn instance
Date: Thu, 17 Oct 2024 09:20:42 -0400
Message-ID: <20241017132053.53214-22-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e27fc33-0836-4729-fca5-08dceeae9cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a7Hn47huLan+kBmyC14bsOUKJ5BS5aR5kXIN4LNiHucozM5OayfxyNrQkTxE?=
 =?us-ascii?Q?TphQSQLs6FXtJrGlptnCZgURXxLQSNPQbhjBBP1j6LxeUpLNVOmihvDzLMXV?=
 =?us-ascii?Q?0BLk1qerrsUh0h1QmG6hwaTEiRTQGcI3pSFLCeeS6kIKnMXRdZ+Fc/GLT1Xh?=
 =?us-ascii?Q?DVKbEm6o8QI6EiuSNZe8D7YIbAbTyGZMQj5SM3QaPmhx7Rd5vmxDlblGbZwT?=
 =?us-ascii?Q?9kXKXGpDmsMQxWuWhcYuuFmmJ3Z18t+xvy8AkJ6mp7NG5u5lysnCK9UtxJZq?=
 =?us-ascii?Q?gC6hhUch0VJAt4iWVf2TDJHmgMSROC+3/9YmSnck1fXcqsXh/iFHZGOpEXkK?=
 =?us-ascii?Q?xN3A9oKjEWSZoj2GbESKWY26XqIvW4P9MT4F2YRikjCsGma9k90lgNI+jRxe?=
 =?us-ascii?Q?JiW07wa3WgvOj6D3ebZ19P2hTfxFHaRBDY7KXH7cRGBcIxfd38yZfSkatXg+?=
 =?us-ascii?Q?GJw/R3ZyKVbhaNjcczUOiRXWphCPktxgY/+I+keK6QXdZpdFxY+nPz1keAG5?=
 =?us-ascii?Q?vOAK4DSqNCEkCqMLMKtdsNzLQIsjmLL97y6Wh+a6cMQCETb9Ui9ckFDXTgU8?=
 =?us-ascii?Q?szs0PvGxz8iB3heVrlgQ7h9zRMCpn1RUHygK/870zbq5HflaamcBGyZWLW64?=
 =?us-ascii?Q?0G5QE3iCybYiFtWhkfgGQE4lbEgIVBCHMGwcJWJCwTzgxNTvOvvsr2sBpxUS?=
 =?us-ascii?Q?BwP+Oq2gEhcJijvThYV5t4OoCvsDdzX0fz62lza3aIMeUl+k/DXChLudlACH?=
 =?us-ascii?Q?hLTyc9l94gxEAejzjIpm8/cFmdzN+cwvF0yAgcE4wsv9Yp/rigDDWLk/K17R?=
 =?us-ascii?Q?BxIiYB/lJhY1ZupFqYWPDlT8bpSjO90PU0LlLjcJOsAOseTybldz/7T5K4HR?=
 =?us-ascii?Q?haEAuMBtnBuDwGeqKkZ0XaBxHQm7ggUEZGe47NAw1lBa8nr7Pf4TJEdynCF1?=
 =?us-ascii?Q?gpIl274Fhqd1sKOC2o2oBi8eT9DnpXFVO6qOsQS+BqqfItatvF+CXjaeFHNW?=
 =?us-ascii?Q?2/I0jlp7s3eoNlBDT87a6u/1y7FXl0NhnYx1JfIzetRjGcC4FGgP0r8/tyvc?=
 =?us-ascii?Q?F0KjHi43BevHTMjuFFGcfM9wSIb/St+CnGK4YCjuQw5Fenn2wF2eVCHoFvfY?=
 =?us-ascii?Q?zh4eW0BBiE7jSy6fQWPg/MvKrMrmW8X0zIzwhM1kfTjrqS9mmRBjhKgHnqCo?=
 =?us-ascii?Q?HpbpmrTQTgEBZkzH8QzHla3/Q1uB5N7TOGJdFHMHJ67bT9DBn7e4WG+Wa9aP?=
 =?us-ascii?Q?wl8KTtgyDUcOhdMDmKFAmJIvJxuLNEX4Nmzbw4EhrGnc27RBDlCcAu0/h3lY?=
 =?us-ascii?Q?oVbACKf5WF0H8oxV2SrYG73ttICyVV18D3GwHkbd8cfGCLXXvJ6Mcu12FXeX?=
 =?us-ascii?Q?jWAhD9QIk6rIgo0XW81eFI6wrdWix/9468Frw7tk9130gRMSoQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:30.2329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e27fc33-0836-4729-fca5-08dceeae9cd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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

Pass instance parameter to amdgpu_vcn_sw_init(), and perform
sw init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 83 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  7 ++-
 10 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e2986871f3a8..791b95867ac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -111,24 +111,23 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
 	return r;
 }
 
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
 {
 	unsigned long bo_size;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
 	unsigned int fw_shared_size, log_offset;
-	int i, r;
+	int r;
+
+	adev->vcn.inst[inst].adev = adev;
+	adev->vcn.inst[inst].work_inst = inst;
+	INIT_DELAYED_WORK(&adev->vcn.inst[inst].idle_work, amdgpu_vcn_idle_work_handler);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		adev->vcn.inst[i].adev = adev;
-		adev->vcn.inst[i].work_inst = i;
-		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
-	}
 	mutex_init(&adev->vcn.vcn_pg_lock);
 	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
 	atomic_set(&adev->vcn.total_submission_cnt, 0);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
-		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
+
+	atomic_set(&adev->vcn.inst[inst].dpg_enc_submission_cnt, 0);
 
 	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
@@ -206,45 +205,43 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	if (amdgpu_vcnfw_log)
 		bo_size += AMDGPU_VCNFW_LOG_SIZE;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM |
-					    AMDGPU_GEM_DOMAIN_GTT,
-					    &adev->vcn.inst[i].vcpu_bo,
-					    &adev->vcn.inst[i].gpu_addr,
-					    &adev->vcn.inst[i].cpu_addr);
-		if (r) {
-			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
-			return r;
-		}
+	r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_VRAM |
+					AMDGPU_GEM_DOMAIN_GTT,
+					&adev->vcn.inst[inst].vcpu_bo,
+					&adev->vcn.inst[inst].gpu_addr,
+					&adev->vcn.inst[inst].cpu_addr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
+		return r;
+	}
 
-		adev->vcn.inst[i].fw_shared.cpu_addr = adev->vcn.inst[i].cpu_addr +
-				bo_size - fw_shared_size;
-		adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
-				bo_size - fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.cpu_addr = adev->vcn.inst[inst].cpu_addr +
+			bo_size - fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.gpu_addr = adev->vcn.inst[inst].gpu_addr +
+			bo_size - fw_shared_size;
 
-		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.mem_size = fw_shared_size;
 
-		if (amdgpu_vcnfw_log) {
-			adev->vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev->vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
-		}
+	if (amdgpu_vcnfw_log) {
+		adev->vcn.inst[inst].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev->vcn.inst[inst].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev->vcn.inst[inst].fw_shared.log_offset = log_offset;
+	}
 
-		if (adev->vcn.indirect_sram) {
-			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
-					AMDGPU_GEM_DOMAIN_VRAM |
-					AMDGPU_GEM_DOMAIN_GTT,
-					&adev->vcn.inst[i].dpg_sram_bo,
-					&adev->vcn.inst[i].dpg_sram_gpu_addr,
-					&adev->vcn.inst[i].dpg_sram_cpu_addr);
-			if (r) {
-				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
-				return r;
-			}
+	if (adev->vcn.indirect_sram) {
+		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM |
+				AMDGPU_GEM_DOMAIN_GTT,
+				&adev->vcn.inst[inst].dpg_sram_bo,
+				&adev->vcn.inst[inst].dpg_sram_gpu_addr,
+				&adev->vcn.inst[inst].dpg_sram_cpu_addr);
+		if (r) {
+			dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", inst, r);
+			return r;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index acf4b88e2797..825b70a396cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -484,7 +484,7 @@ enum vcn_ring_type {
 };
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 1a3907295e36..70d865724463 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -126,11 +126,12 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
@@ -146,7 +147,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d14062e1dd31..834311e13a4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -131,11 +131,12 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
 	/* VCN DEC TRAP */
@@ -154,7 +155,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 5d145adbe932..f6d2e3e3bf32 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -156,12 +156,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance;
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		goto sw_init;
@@ -185,7 +185,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 sw_init:
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 464a502a7cd7..9b62296cc233 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -160,14 +160,15 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
-	int inst = ip_block->instance, j, r;
 	int vcn_doorbell_index = 0;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
+	int j, r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 58fdc07d9641..79d5ef8f857c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -168,14 +168,15 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
  */
 static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
+	int r;
 
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 4641534bb768..0932e992d088 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -127,12 +127,13 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
-	int inst = ip_block->instance, r, vcn_inst;
+	int r, vcn_inst;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index d5ef1b0bcf54..e551ba1d1e12 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -131,13 +131,14 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t *ptr;
+	int r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 88248fcfa138..dc15a74bb3d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -115,13 +115,14 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
 	uint32_t *ptr;
+	int r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
-- 
2.34.1

