Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B56C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 20:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B4910E15B;
	Thu, 24 Sep 2026 20:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kNIHFpoO";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC9610E15B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 20:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPhTkzPCEKVwhgDDb3cBcLEc5e7KuglcULmIj8Ng2U/oREoG0W1AhdNbNcAi5/dlgzlwE/g/ak7nqyVTfc+Pbus9hgrVq3CWSPSUXwzvHuV0wJRQZsrx3qR9efpen2Kp00H/GluQU8euouhNcwOHBa1W9OwqrtUdZJqfgzMgJelhRTlYNv9AGOzTvyQM+t/E6th2Z7wBkTT5rRDAaNV1jmRxRq80EKpfN4YS9L1rDn6AJ34Zj8q5JkRNemevkphfrmRGQs/IuqjbL+wOwsL7PaedzgyI+ArT4ONXtDEahbODrux5ispeGytpKZ2bGZ/Pd8ePd7JVnMuYGsYyTGr4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYqWIJ2ryopZChGdMw6upgjsj6D9SD1xtd/rPL583d4=;
 b=Hda1XEnA4shMIYuSjskknQp+2fhu+kkZV+pflD1NuIXpRjcLwM7iN1lDm2LW4GWb/cJg/Ui+0dAQ8r1ueqs8i7etGGJvEPjbRNtY/bvP7X0nB0YJn8DlQ3fLR1Fzj7fxKbFaNeblZPf2g8g+3crtHrmFeWHYDRhgcOk0ZFJj8FAXjpwmB7YooVb9lGX96V9d4eeAqy1AREzuGQ8Z0E28IpXgOciV0Ddf9Hlcy2tBXNL6H3lLqhsKyEMuYI3r2vSqnvAhQreK+tl6J1lxHIP80aDpDqdpzjaTDyoaF+EEwZFY/VsHTjEiX45x0quxV0PIW6U0KheOiUG9UOwjRUsOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYqWIJ2ryopZChGdMw6upgjsj6D9SD1xtd/rPL583d4=;
 b=kNIHFpoO6JU3id9ofZJK7dj/nK9Y61jRoG1POhH/nWImPj+VALwLiazkxWkZHDoNdEFWcTzKtPBSiat8ffPjV4wCb90/XNvkMzuAXQwVFIXzbEJP+QLJI3P8F/BG0cWVvC+vur2ut89+I/pOQE/+V0FhEEXx+XK9dcC0IBkvHKc=
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 20:38:19 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::2b) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 20:38:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.5 via Frontend Transport; Thu, 24 Sep 2026 20:38:18 +0000
Received: from rocm-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 24 Sep 2026 15:38:17 -0500
From: Maharshii Patel <Maharshii.Patel@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <kenneth.feng@amd.com>, Maharshii Patel <Maharshii.Patel@amd.com>
Subject: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across
 s2idle
Date: Thu, 24 Sep 2026 16:37:56 -0400
Message-ID: <20260924203756.2771789-1-Maharshii.Patel@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca2f2e6-1aff-4d6a-1cb3-08df1a7bc454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ocBtX84De+gkADHRV4ozrGHuxlAslj0I8M+cJUrKfsR84tdOSUuv0RYsi+zTmJKg7cdji2lUjz8zRDfrcQQvViAN0GbQhFhsn/MH9nAI3rbmPFzAB5HilADWVivlXpByKIDxcCp6nV6dlFvqDgRUO4TwpBn4qMVvc7uQHNS1gxpCIfcfjXecFZmVG5B621dJ8bYsqNy1IZ2AvMWV8GM/oj2ed4XgbixkHLMPiEB58mbuWJBfZ11SB41QwRnm0C6T/ZBb9GDpf5ciVwta6b6uoCWewQBRNWn0ezLrLyTPM/oui1FPhmB4cl5NJK3lTJAjBNcu5TxE/UuBTcxPUUKs8IjswvK8+Fqgx/RR7pz6Gf8eh97GTzSfXfcfwV1fmKitF+eUrQpgLM66I0VgGcfUOUaYU2snMLjF7oIpVHwzIoKVO4Bya7C2yV7lW0URkY6QWdVYy5s4U4sSVssoM/SI/dWv9oCilGI+YNRXOOM3a3vwHxMKNS8htalC1+RV1iN/jXuHMXs/uzWzWs9KvC7QNI0FKrRy/Vvo15Q2q8GjJGirCzOWfwlIE5EDCXVMVXlN2o1UuwCVVS2W8i+xYXrOB1weS+TZjVKYzt8pNPdPkyO5l8a5Py8JZK1EGd7TOboW1QqKVKin8sN/aGE8PXpl+0XnKvg8dM4g7l//wv1CsND2L+L/Jij4lAc6QzUfC88LCeaBK+iJns5p/58Y4tRTJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xORjXfxETRX9NFU0stU2q2NHUcpFrYLc5oUmkQ/RvszWAlYdoZzELCK1p7y0CXRIlkgTOc6ePAw5HsthnCWyC0P3g7RTFEcjVu86OFzwRzAsQprs2Jk32hpalG+kMQJdTubvJkmwOngwNDKfPuaLHYlwY5qmSaNiXcY/4fF/DV1t62wVqzbykyHnLhjIBVsjtlcEahorWw9Lir647l1IrkYiRuhRDqs+pTf//khsQOdz8MGBlKDvbEn3T8ZQdCLaHofpu7xYf+FjQj/Gs3mDK5lCkrOnvovtIN/9BgNYtzyrsLrnc6lbogxzQcjDlLDtLUnbajODy+8sYEWSBBFqLzEAnM/uEtBqigBjpilntPxuBOdT7YoUop3c8BubY/T783Q/AyfIqdL3XGJJwHfJdNxtfolq7whxDIoB65Qp+jveIMGgYvMOIC8PttCkqJpn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 20:38:18.5564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca2f2e6-1aff-4d6a-1cb3-08df1a7bc454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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

dGPUs take the S3 suspend path even when the platform suspends to idle,
but amdgpu_pmops_suspend_noirq() skips the ASIC reset for s2idle. On
desktops the GPU also keeps power in s2idle, so it resumes without
having been reset or powered off.

SMU 13.0.0/7/10 and 14.0.2/3 skip smu_disable_dpms() on suspend and rely
on the PMFW to clean up on reset or power loss. With neither, the PMFW
still holds its pre-suspend DPM state and stops responding when resume
sends EnableAllSmuFeatures:

  amdgpu 0000:03:00.0: SMU: No response msg_reg: 6 resp_reg: 0
  amdgpu 0000:03:00.0: resume of IP block <smu> failed -62

SDMA ring resets and mode1 recovery then fail as well, leaving the GPU
unusable until a power cycle. soc24_need_reset_on_resume() does not
catch this, as it only detects aborted suspends.

Do the skipped reset in amdgpu_pmops_resume() when the VBIOS init state
survived suspend, i.e. the GPU kept power. S3, and s2idle platforms that
cut power to the GPU, are unaffected.

Tested with this change applied to the amdgpu 6.19.4 DKMS driver on two
Radeon AI PRO R9700 (gfx1201) on an Intel Z390 system: s2idle failed on
the first cycle without it and passed 16/16 with it; S3 passed 10/10
with no extra reset.

Closes: https://github.com/ROCm/legacy-rocm-build/issues/6684
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maharshii Patel <Maharshii.Patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c5e93c..b9be88e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2703,6 +2703,24 @@ static int amdgpu_pmops_resume(struct device *dev)
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
 
+	/*
+	 * A dGPU takes the S3 path even for s2idle, but suspend_noirq skips
+	 * the reset there. If the platform also kept the GPU powered (VBIOS
+	 * init state survived), the PMFW still holds its pre-suspend DPM
+	 * state and times out when resume re-enables features. Do the
+	 * skipped reset now; resume will POST the card afterwards if needed.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev) &&
+	    !adev->no_hw_access && !amdgpu_acpi_should_gpu_reset(adev) &&
+	    !amdgpu_device_need_post(adev)) {
+		dev_info(adev->dev, "GPU kept power across suspend, resetting\n");
+		amdgpu_device_lock_reset_domain(adev->reset_domain);
+		r = amdgpu_asic_reset(adev);
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
+		if (r)
+			dev_err(adev->dev, "reset on resume failed (%d)\n", r);
+	}
+
 	r = amdgpu_device_resume(drm_dev, true);
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = false;
-- 
2.43.0

