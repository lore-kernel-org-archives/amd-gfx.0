Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32FCC7EE30
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 02:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46A810E078;
	Mon, 30 Jun 2025 02:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MpRnHAxZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CFF210E078
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 02:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGa73fYiYr/vOpJFsdX89lQRLivQc3y1TQKEUYF48GaFFIUkEtuZIrF+cj/G6ecxaolyK32ytUlY4X5Oyq9KKgPz5CnfgIzWSF0EOlLG/dM/zKo1G8X8bqAa8485+P4A//OQbEG0AsGoGUdp0wx4fvEaVEd/mhulaZqZQfJTI9XrnTSOm5P2oKEJfWpPIRE0ksNv2nLizocIgOxCo2GVt/LnB3gYJhu6QyJ/MVfyppma5EmlG38Tm4EjiRkO/C64mvfN8t9MprYi6a8stySKYmvA9/xdp6L0LEfnMhM/21VS77dJaMR7b9f2vgeJkTfA6JBaJF4OeFTi0F4tP2dk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlR3IMoA3GV9BFR0DIdf27nh+8C6gJmQqdAi8veSiBQ=;
 b=e/wGruk++aDVh7FCKteAUuQktV1kI++KoPkrlPdwoGBkr/IRrSKkRx31LkRM3BNVQkbs9SMBOmKWgcvDB2o1Zzlcz4CWXrfSOcZARMCSOFzoWIvUkPzRHaauLKXBnn7TSc5KexEcDZSAe0WmaQl0nmrUgJ8hG1UC2CJG/78AAZexDcyJFRd46CYG53RL4ZS5iR26rgsnRJEU9Y7sdtAKCv4i0OdYeARbOduaRpo8NIvb9NGEq+0AP+H5UNPeGC2XQt/NihYNFcwWKGXthBdaAXycEuk88flupAhSzUgFdlO/XlT5Ul+Fd7u39PWZlNiTJlSLT2vSiEPQAGQArMf/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlR3IMoA3GV9BFR0DIdf27nh+8C6gJmQqdAi8veSiBQ=;
 b=MpRnHAxZWfEU6V87t1c/JCaH13p8mVVtZb4F3DQfVYmkvP5FO0wvYUNjck6UUrhHB6M1ZpFHnAu6S/+LHG3DhdR6BZ3JjJjXFIYO/cqMpGgMU2ICkoomqOEqY8HEkHCusL5ViP2TnprHaJuVWmZn584U8X/it/oFmQqFCtbASO8=
Received: from CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::10)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 30 Jun
 2025 02:45:28 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::60) by CH0P221CA0002.outlook.office365.com
 (2603:10b6:610:11c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 02:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 02:45:28 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 29 Jun
 2025 21:45:26 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>, 
 kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Fix code style issue
Date: Mon, 30 Jun 2025 10:45:12 +0800
Message-ID: <20250630024512.220139-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 3286fa05-26fd-469f-8604-08ddb7802c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YG+9LAln87GLzpFMJ547hXB46DhoheCtFmKBwv39oJtdWNd2Z2ToAbU+NUtP?=
 =?us-ascii?Q?BuP21yQmh9jySKxu0KfDeDsJlZ50PXfHCyS28+Iu4emB7NPHKHqVA6l6/m89?=
 =?us-ascii?Q?mQPMyUSYLFAiEQuO9Gsgaf3a37CPu4EqEv4PWIY+cCdiLm2/QOH1870eF2ZH?=
 =?us-ascii?Q?pWsX++5eZ4skJ3JrjwkEhXawkuash2KuIW4f1YhZZQOFLergQDyKh/cTXsGL?=
 =?us-ascii?Q?3m5h+Y5wGdbW/LRupNSxpPWy5tLd599feYAtIHrm9Y4jY2x0g+crNl6M6qii?=
 =?us-ascii?Q?uqPAIcSUythMs4CjBtOhZxpOcshg4sNCcSpRZzOqF+x0dX3cKQ9OUGrrwc3o?=
 =?us-ascii?Q?xX6qfGswBH1a96s4PkETy62aQJwgr0lpQ+BPxoBvp9hYzJnl7AMh8TuakF1/?=
 =?us-ascii?Q?XShaA+ZRVHP5cdGZWKyDJcM2FFqWkwII8hoZ+W6Hug6AV+2kwJF5XJGRNIfW?=
 =?us-ascii?Q?r+a/QNVsToh6BShDVcwitwM2ZRhZKMt2upY1gtG0Vl+6RtzVCDhw5E94TKxo?=
 =?us-ascii?Q?2UuVjVtXqp6x6fIYiEmxVM95l5dYHldlW2QFgWl3goD5/JLLtd3yQtXiww50?=
 =?us-ascii?Q?Jeoot8YYoNBVW0HqYMmYF4f1xD/q6Ob9XshrZZ7t0Q9KCfoUEUq5PN4G8alp?=
 =?us-ascii?Q?GYVvxSvwJPpAE/YOV8bX7jMB2E0Id4lK5wasyiSDujIEk1/7SJe/bnnrbYj2?=
 =?us-ascii?Q?8Zao4xuzbmJLwS/z/814Gg5AFxoXGakM7FCA/kQMvZj3gYW/qSg5pBLqwWWP?=
 =?us-ascii?Q?/m005HvYDgzAQICGlBoj3gJab+dllM+KqHvswNfg4/3kOyVx0RdEc23VhcV+?=
 =?us-ascii?Q?DJMmSdC+xPqmnqpJIWWILwjyGBAnEvmm7Em5zvjUVCz4JCrH/Jrz8NNOLRe4?=
 =?us-ascii?Q?81O7NqTKYHifl8OxE6jmoeBYQauYUwJMui2TuV6VB1/RtZGRD1CE6sT6st85?=
 =?us-ascii?Q?ml3lWGIQqZvK8L5Be3IeKkazr5y3AQP3dOKk/FK/2DDkF8UCjhLI1W0B1m0Y?=
 =?us-ascii?Q?tpTIg34o5q6ABugXFfZpMASDV2/gt/No9icKQnpBcrYE4oZ24udU9/6iiGVZ?=
 =?us-ascii?Q?gVl24PrfGlXpzN6pGG0kRT52gM4KdjGVCt2CxOfjLO3x0zIjglu3gZxjYahG?=
 =?us-ascii?Q?rGQN8QL4cRLy/R+acUiLD8r6+Q7eJ7OVzvTY1hy41Gd2QDNoBpfAI2VXfjxZ?=
 =?us-ascii?Q?QwfQjstPswiJ8nHeiQBY19bU/mhjLk4A1kz5CXTIM0aAhUlgzXuELYYUEjI3?=
 =?us-ascii?Q?uIPNfSQXHSURDdZAmOYOpl4whSpIw/nvz8jb5UPh+Cb1dAAiZkWXpEUoH9oi?=
 =?us-ascii?Q?OdkKxZpXFtFmdxedTePJkYvLbAH8/JFgj2a2FCFprcjyvCpqdgAJPP/UdRGB?=
 =?us-ascii?Q?pvxz8HUP6Wki/dC+p0sxvm7SMXTX76evCfvIqWsPJarIi2E+dTyC6RkqAVhS?=
 =?us-ascii?Q?947cBfSbCYhC6ZIO/ICMMIW2AkbCBZhSphggXnVKU5Fzej/7Bq+VfGByeCD8?=
 =?us-ascii?Q?6ieEHvoOveyyCJ1jfdAWqvFNjgJktBYQhMzl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 02:45:28.5548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3286fa05-26fd-469f-8604-08ddb7802c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6088:8-9: Unneeded variable: "r". Return "0" on line 6141

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506281925.HHIpXiO7-lkp@intel.com/

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f13439404760..7c8c3f27d5a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6143,14 +6143,14 @@ static void amdgpu_device_recovery_put_reset_lock(struct amdgpu_device *adev,
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
 }
 
-static int amdgpu_device_halt_activities(
+static void amdgpu_device_halt_activities(
 	struct amdgpu_device *adev, struct amdgpu_job *job,
 	struct amdgpu_reset_context *reset_context,
 	struct list_head *device_list, struct amdgpu_hive_info *hive,
 	bool need_emergency_restart)
 {
 	struct amdgpu_device *tmp_adev = NULL;
-	int i, r = 0;
+	int i;
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
@@ -6202,8 +6202,6 @@ static int amdgpu_device_halt_activities(
 		}
 		atomic_inc(&tmp_adev->gpu_reset_counter);
 	}
-
-	return r;
 }
 
 static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
@@ -6414,11 +6412,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
-	r = amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
+	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 					 hive, need_emergency_restart);
-	if (r)
-		goto reset_unlock;
-
 	if (need_emergency_restart)
 		goto skip_sched_resume;
 	/*
@@ -6857,14 +6852,12 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 		amdgpu_device_recovery_prepare(adev, &device_list, hive);
 		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
-		r = amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
-					 hive, false);
+		amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
+					      hive, false);
 		if (hive) {
 			mutex_unlock(&hive->hive_lock);
 			amdgpu_put_xgmi_hive(hive);
 		}
-		if (r)
-			return PCI_ERS_RESULT_DISCONNECT;
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		/* Permanent error, prepare for device removal */
-- 
2.34.1

