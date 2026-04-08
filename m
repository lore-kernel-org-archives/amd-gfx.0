Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DB7FD5F75
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 05:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7287910E519;
	Wed,  8 Apr 2026 05:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q/DJ7OPM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8ABD10E519
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 05:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM+hgrkbkL3ViUJHFm70lyYCkmyCmMfsqb0Y7qwPH5pFhLfvUTv7yVwTOstbjTLOtp/U9FKt4UvtaosAN5rzfnvYte40BB5d6wsP34vFLh5Qg4dXQLez6zAYIRJ9uBXAORJ0AzxtvqADFJjBt6aYLd4u2N0SiiCa4kREkWMprnUXj52nUJVenmLl5ZrPIXW1SpirCxiYxcZY3VYcf+/FHsaQ+g7ZIMkTDGw/V+h4qok4HE9a0HaFQSzo/vMlYxKWuhkkh30U0KPvA/FAZp2UOPB2KTUt9Kmo4LW6xA47FfagVzs3IYQPCVxKHO9TH9HPo5VRDPkO1emL6xp+PyEggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIZd5GwDwfnEVteUS6MXIsa+J3rCdD3TEioaqpFgRUA=;
 b=Ye0Ky1CoTcvoZWMwuEcWZzDdaTQy9coLTrSz9Rizxn1jhNyfseP+baHjbcss3wGPag7duOrGG0Koehm4hZbMUwaBrXhYthaaRnoPcRf0kpmlKnXGZdRaPNQJp7J3bowebs/Rt35TLLBJlfyr3hbxkz4jGa3lNbJ2Eo7X9m+Y8DKB2A1EJu6BStKaRtTHmQC70Ze47mF7qmJVMGELzLeyDqwxUq/fgrcRpbRGbOSjXOqq4c7RaZ1Aghfr7a22jQzd60xwLegVHGl2RBe9iDoRZkMiI0m1l1Y5eNLHFp+b6Ut0hviTYo8y1xrV6Bp5GhK3YIgo1n03cLiilNWeqXO1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIZd5GwDwfnEVteUS6MXIsa+J3rCdD3TEioaqpFgRUA=;
 b=q/DJ7OPMeHftgB0nFWtd8o6mJyNZUvQ3WthaR1M4LXcDUpL3gqn3BMiMUGO6y6l1lmoTJYGgi040h3Fg6tVQtpqiPdvYyfoCJqKKNvCwMG4jKU/EZgTpkTg0sJ7FP6A9j2/N+rJLBbNgcYyAKYGvInwLXMwScmilQmdugq51yr4=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 05:41:41 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::30) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 05:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 05:41:40 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 00:41:36 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: correct single device PCIe reset flow for DPC
 status
Date: Wed, 8 Apr 2026 13:41:26 +0800
Message-ID: <20260408054126.2202627-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: a59ac20e-3b00-427b-c4c2-08de9531825b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CKQDk0dS4LeL7oYlyhxktLwvoxoSxPtrrQ/yWbEGH+sdOSNqTvy4/7QZPBJSAOwNHyXCetkrJE30IdJKB/F72FxS0i7tEB3NAS+IrX/S+R6mGR8tpMVfjUD0vSmkYtqFaQVkDDF5K4Eol41dMrg8wQq/DyvWA8ukTy/ZcblyozNyQmFErlQ1SIMharPocb01BSjr3UdVv+g27xqO5uOn3gh7LeCFV4GViCvvEWYH1zP3bD9buQakqZ0Pj0kqcB4DGn4aOd78jnDAtlMr5xfPdLKOl+7U48nTJ2uUyj/ZpbEPkd0ZC1mFqRx+lgfaX+CcOVZFBFa8sgMbbldDq4jwmGjCJlgaddQyJu0EAz85ud236lJePjR/K22PciVMAd3J+DCxtxob+0Hc34pibOklQcmepk+17bl+c0dUbRjTPSTyHADGIDAY1l+8Kuh5e0l0ECMYAk80pnZc8IKtuo9ypYG7oOdUD5ATpJO3UAKDB4n4UYSKGHk3rqQrjKKoIJON+Dp3UnodHJqCOZ4XcBRCS9aKhEpM3kaNv7jjuQfj2cyuf+3YTYlnbjmBD0h4+1TVWg/MTY5Mk7UNKua0VF0UdBMEZtG5Of5xHyBMqDCpMtcD2eH5JqVSMSSddjufvm3odfuqvJYGzMQfSLbJwbs+/G/NjEwnsD9leOHoIP0QcmGcy54Ikj6K4Q2HJl/Ix+LBzwknFk4NarfeCk+h2J+HQRCMWfaqunUY0v5QHpLy+kANS1JpTUFZNOI6ksC3FPi9p7yCEkEZXGHTQ2ODYBq8Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IIMJgqMvbn8ReAvIYyKOWbGTKKFnWTEjzJt2R04zUiA0fBj8oeAqzFtrqhSjXSQiaQKy+pFo7H7eksI/Yf0M/3gGdWUOw6YDdd5GO73uDLTVRN/FLXnmahrB25RQ82fz8S31c0+iW3E6APaWslT+19mYcSdARzSczm2BJ3SVRrcd+KTWnWQAaHncDS2sTXbCj0zjEp1W4PyY/sxvHhY3f2bMWgSi3IJzOHXK/g55bC2zwZseLNCXGmpa0p3PLgJmnYe231EUpI64sKvNh2SpZeH8BWqKMEDIm4kA2uvcVsj4XHI2eTVzEgPFUiNxqXP/9+y8yZi4pydHf+eiitRM3mSlG/rTNUVje3/ep3Z8bXPTfGQcjcJlXm/xSlXAzHkEFYjsRad8/1l+Cdd6GQ7mTWVpzM4/DYpGkQbqqA1BYv8jothvT6nroeQ+Cj5m6lYF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 05:41:40.4843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59ac20e-3b00-427b-c4c2-08de9531825b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

For triggering the dpc event with a single device, we still need
to set the in_link_reset flag and the dpc status.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index deb41c095b59..0bdb54ab9a53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6291,6 +6291,9 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 			amdgpu_reset_set_dpc_status(adev, true);
 
 			mutex_lock(&hive->hive_lock);
+		} else {
+			if (amdgpu_device_bus_status_check(adev))
+				amdgpu_reset_set_dpc_status(adev, true);
 		}
 		memset(&reset_context, 0, sizeof(reset_context));
 		INIT_LIST_HEAD(&device_list);
@@ -6411,6 +6414,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
 			tmp_adev->pcie_reset_ctx.in_link_reset = true;
 	} else {
+		adev->pcie_reset_ctx.in_link_reset = true;
 		set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
 	}
 
@@ -6467,8 +6471,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 			tmp_adev->pcie_reset_ctx.in_link_reset = false;
 			list_add_tail(&tmp_adev->reset_list, &device_list);
 		}
-	} else
+	} else {
+		adev->pcie_reset_ctx.in_link_reset = false;
 		list_add_tail(&adev->reset_list, &device_list);
+	}
 
 	amdgpu_device_sched_resume(&device_list, NULL, NULL);
 	amdgpu_device_gpu_resume(adev, &device_list, false);
-- 
2.34.1

