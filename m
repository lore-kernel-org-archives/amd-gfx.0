Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE6DC28B30
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 03:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBC310E2AD;
	Fri, 21 Mar 2025 03:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7+EX9iq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E17C10E2AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 03:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXIsp7Yk4u0FFzd/YWHa1tP6FvPlH/GJGL9zDxpMgA0L5UzloMuqFXgxWZUAodnSM0pFtF04omfHWttU3yaoRz+75CGdWUcMC3yQhcqoy1//mNJUkuYtXMjfjOl1SbPVO7KTxod1HdLnS/NlZFgtKOheS7pGUKFISkfYbEwtHxRD7CML163QUQlppZLwWu+VQLmE5g9v7RiyHvvaWbCRta6AOm+UyLcuxecj1czMvL2ROGSdxwI6Ktosk0vY+PxHgqJXmzg+Ph1+mbKqNQmmWAhdhDmAvDAib/yfGq828+bOiNl7XNHjimzUuCjSQJjHIjHNKzPe2MPxFMAHk1DYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QazH//sHG6FT+dzsVINMR/GES8HOf8363NjyUjXUR5o=;
 b=APwbG5Wli/g+CAnzhYrUb6apqpJXkOdJNsPjcPO1qf+DLSalV3v+TRfRSoJr9ZIjXBQswmmIs5peTUHO+wf3SmepthmtJQ4fPX+Ra9sB1So8MBC0g9Wz5PPa0nLso1C1pGceNNLTJsJC3wDz8qoT8Z/neGoA3VCxux0njSEPgN2eV3bYhIWWv5SFMn8RAe4Dtu3e63kbZPhhZIW4nepIZPG20TyRqP9TAkPGykbTOBN/tSS/iruguTUWcBZ89qFAqvLQJ/svauJHuFqwih2/XpTbUWn9s+acZ7wmBezEcU/JNr3ELaaankMkn21qR3zxeXfNAkF24YcVgTdWYe7efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QazH//sHG6FT+dzsVINMR/GES8HOf8363NjyUjXUR5o=;
 b=R7+EX9iqkFavjZCApo/ntmBtBK2nRULNtm9Q7FZbVoNZRDyELD8M0sFlCQcPTCnYfN1vwFbJ/YKhAODKzzeoFgDGZx9HXvN2clILIY9Cv2aELBI/kTlE9mURJYGLuUdCx0c+OoAG+i152Ng27zK+KZB5Xp1lNIj0j/pfsM3wiR0=
Received: from BY5PR17CA0031.namprd17.prod.outlook.com (2603:10b6:a03:1b8::44)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 03:24:43 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::cd) by BY5PR17CA0031.outlook.office365.com
 (2603:10b6:a03:1b8::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 03:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 03:24:42 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 22:24:39 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v4 0/4] upport for multi-GPU interconnection to trigger dpc
 recovery
Date: Fri, 21 Mar 2025 11:24:29 +0800
Message-ID: <cover.1742526761.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ac33bb-4d31-470f-1fd7-08dd6827ebe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1ZUJ5Jc//+i3Li5pZ4Eee3x/PjkMxVH+r1aOt2KgXCEGrPbagnk0mddhhIj?=
 =?us-ascii?Q?d4NVgF3EdvxU+lWWJQlS+p+PyLxclRZRZS1Eu23iJqpJD7E15lS7HEYitKaE?=
 =?us-ascii?Q?gXv4XoxY+khu3qsLOKnEACwenbTx2+du3GFjluem6JewUUe6WLtmOWN9uDAC?=
 =?us-ascii?Q?OiZkiLJh56eEe3E6MmdKFHYmqhVesfJayIeqbrm8pv8v6Cdn6EfNhKyK9mYv?=
 =?us-ascii?Q?/iuLGK+5RZHo/FX5udEhBrNVj7Aho0A/siqM54Ao6qFoPs4ywqlsL8NEqy4W?=
 =?us-ascii?Q?gKQX0S8ecBO7lnKVN9wMMfOOkkiQdJJDFXPdg7b1hwJ/WV0PzbhCccuMsPL0?=
 =?us-ascii?Q?vzHIRyFWlbn48ikhq0pyTn5xlz1UeHpRZZUfYayWNzmAm+JTK1Y/7+Utp0hX?=
 =?us-ascii?Q?gxhzoPCNF3cl+1dvfhM894FksiqyI351CTFiCM7+c4gdML3/ygp3MS8OY8Bg?=
 =?us-ascii?Q?McTl2IOaNwO62MuQnbYANPhe5+5vBC/5NUEz0muflvzOyCglfOvScJK6C2ps?=
 =?us-ascii?Q?ai7VIiwWDl7ltR6oSbXKiDXhPr2tnopA24oV3HKG57rSdrvE6VfFBmokFWy9?=
 =?us-ascii?Q?gxHdkb1237bT5TPHqG53clPU37S6P0DVam7giqpPdj7jcGfpZaY3tSSQ0wiK?=
 =?us-ascii?Q?e4zKliDvEqMszGMcMu6Fc1vcEcS6wfz5GbcfUAi9CiHx/HgH4UDGMVjyjGea?=
 =?us-ascii?Q?CDfKocnSP9LesZrAwF2kVVW91/oKoOagYmDch3xfUU10FVbo2qT9KTsSV4oW?=
 =?us-ascii?Q?sZ1GE3lQTmn0x/3dWvq75ts7Nqn7BCVnXKFqudC+BhkcCZAdGfXfaD4wA5Tr?=
 =?us-ascii?Q?aMXUZUuZQTxdH1yHjTthGpDOqo0JeEfo71PGSAThpJyL8uzeUl+tEPvL8ANa?=
 =?us-ascii?Q?mFUbo5hVsECaUeJh5/A8uhZR8CwTLytDwzODcs0CeKLcNEXc4qxgoxY1rH1O?=
 =?us-ascii?Q?AcSooz4KNYLSvYBIyxJG51lsDtLeb8Tk3yEkJhOjZYtv80iEU8ovrf1RNpo2?=
 =?us-ascii?Q?vC2OnXU/IHI6pw+IBA+zi4AoIPoEEhwibXt1ZocO7ye2LbtgbpG7eD60AeAG?=
 =?us-ascii?Q?IPg2CrxGb7Bia8/61xMdE07IXe+K5QiOKHXTEjWz3dikadrbH/wwNKOrrEA0?=
 =?us-ascii?Q?LbXbZlcaiH0QjBQyBfYBPkgB7N5D2OtZ+jppbL8oBxo7sBMQWYG8c9KbDyQi?=
 =?us-ascii?Q?p4yfBncfW9b8OoxbK5dC9mVgxlOPVmy+qmS5a38M8DsDYngcyDssyOxf45t/?=
 =?us-ascii?Q?I7GoLXHn3u7nhUvbOKrEHamRMBiSaktJbRNXKYQwgF1JY6Mx8xUbuaI+MeHC?=
 =?us-ascii?Q?o2L3AOgc9MvbbUKwQB2ykrwJORQH8lj0OHahIPyltD3c3z98sO8jhId+JwpF?=
 =?us-ascii?Q?/rifRf8sbw/Rglfs6B38aJYmhbsYTchrWbH7/1AdzZgBgK2KMWf31SbIG7HN?=
 =?us-ascii?Q?mE2fFnbTeM67bBLecKJskp5i3QdV+hnVKeR8oQC4obCp2hKMk0TYlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:24:42.5550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ac33bb-4d31-470f-1fd7-08dd6827ebe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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

This section describes the DPC high-level workflow for Multi-GPU configurations.
The GPUs are connected to root ports or switches using PCIe, and there are xGMI
links between the GPUs.
Multi-GPU DPC Workflow：
1.When an uncorrectable AER error occurs (assuming GPU-a encountered the error),
the error is reported to the root port or switch downstream port

2.The root port or switch downstream port disables the PCIe link to GPU-a and
sends an interrupt to the OS kernel

3.In GPU-a:
  (a) PMFW receives PMI from PCIe link down event
  (b) PMFW log the DPC event
  (c) PMFW runs the link reset sequence, which resets PCIe and related IP blocks
  (d) PMFW runs mode-1 reset flow

4.In the OS kernel and driver:
  (a) DPC error handler notifies GPU driver with per-registered callback function
  (b) The driver stops or halts any uncompleted activities, and triggers SW-UP
      link reset on other GPUs in the same hive.
  (c) Start DPC recovery sequence and release PCIe link, the link training starts
  (d) PCIe error callback notifies GPU driver to wait for GPU recovery

5.In other GPUs:
  (a) PMFW runs SW-UP link reset sequence
  (b) PMFW runs mode-1 reset flow

6.After the PCIe link is up and the mode-1 reset is completed, the GPU driver
initializes the device and gets it back to normal state.

problem:
[  188.024875] amdgpu 0000:38:00.0: amdgpu: [mmhub0] no-retry page fault (src_id:0 ring:158 vmid:0 pasid:0)
[  188.035550] amdgpu 0000:38:00.0: amdgpu:   in page starting at address 0x0000000000000000 from IH client 0x12 (VMC)
[  188.047297] amdgpu 0000:38:00.0: amdgpu:   cookie node_id 4 fault from die AID1
[  188.055531] amdgpu 0000:38:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x0000DB3D
[  188.063957] amdgpu 0000:38:00.0: amdgpu:      Faulty UTCL2 client ID: VCNU0 (0x6d)
[  188.072188] amdgpu 0000:38:00.0: amdgpu:      MORE_FAULTS: 0x1
[  188.078458] amdgpu 0000:38:00.0: amdgpu:      WALKER_ERROR: 0x6
[  188.084835] amdgpu 0000:38:00.0: amdgpu:      PERMISSION_FAULTS: 0x3
[  188.091698] amdgpu 0000:38:00.0: amdgpu:      MAPPING_ERROR: 0x1
[  188.098172] amdgpu 0000:38:00.0: amdgpu:      RW: 0x0

Solved by patch-4

Ce Sun (4):
  drm/amd/pm: Add link reset for SMU 13.0.6
  drm/amdgpu: refactor amdgpu_device_gpu_recover
  drm/amdgpu: Multi-GPU DPC recovery support
  drm/amdgpu/vcn: during dpc recovery will corrupt VCPU buffer

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 411 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   5 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  28 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  26 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  23 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  22 +
 9 files changed, 377 insertions(+), 155 deletions(-)

-- 
2.34.1

