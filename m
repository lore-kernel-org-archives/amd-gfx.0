Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4627FC5B559
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 10:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A2D10EA21;
	Fri,  6 Jun 2025 10:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kSYCCjNp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143F910EA21
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 10:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNv2gAWpn7i4wW0olQd+ghLZBEI9hygUOuh16RFBJoC62g9uwbE35ieNGo8t0TAQGxPi3vPAh09NyEohkeMvUCQZZK+GMkKcftR7KTCJVv6OgBoAILW5eUCQY3o6gvPGSNXttf0B2uwqWOpGkIgrWEmRLZ7Qo74g/5kAHF+YRNdKtjHLUkUyrpWpiRMv84CPuu/35SbyYDIWh8SN1mViFV+N3oDCWrovxR01HdtjuhFORmZNOkMjPKrC4UiuYVvlg+SRgcuMpDp4XxJFnb+ZiZSWXWFGPcORCzK+J/Wma7/+jwyTcPw6F4wiotMsTpHvPOCQb32cLqKm4DERPMZPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAX5jLUqHk1AQCfnL6d2qxlL+Eqv41KM317UPh74mMs=;
 b=VgceNtGaRZ0ISBGBtFrX9t+vO2t/yC9KfxnrSeXQj8JTGv820fGEj2y2o/BmqbNBrC5ufxoEqveJm0bbZ/a+TLjY32NJyIZvWYigsbc8rf1bth0XSwuAQtHjNcVVG8Al+R0Fp4tOOsLQdeqcp5pnJvsyvixNp+mqbcKAJQR39SMjsgrOmBTa5DnrnI1+LRYqpBZoH0m1SGl+COfVkThWbwtI2BE2CKzfNgt7bZ7Y15ZNx+MGSBjDQKWr9N86D/QJLkkQD9dtIK3SN1FrOYZMjPAQYQPYLRhYYo0j49U6AF5kHaxWA3lPo9B9Sz5dNu8tCwCbbnvCiaAX0JjBfuofbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAX5jLUqHk1AQCfnL6d2qxlL+Eqv41KM317UPh74mMs=;
 b=kSYCCjNpc8WKT3AC2kKDG/iqXzPXq0QiwR63alNAMEliinRBobRieYLHgDPrfQYQrRhuIhbGSa34zT8EkrCnzs0V4r9MWIMqzb8gdRArgAXD41E7PosSBCx0ThYIq9znnnORftfI8x6kdmJfHxn9fuWiN7Nc2dQxURJfkn8+UWw=
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Fri, 6 Jun
 2025 10:08:30 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ea) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 6 Jun 2025 10:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 10:08:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 05:08:29 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Jun 2025 05:08:28 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v4] drm/amdkfd: Move the process suspend and resume out of
 full access
Date: Fri, 6 Jun 2025 18:08:26 +0800
Message-ID: <20250606100826.2064143-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b80d20-ebdc-4a65-1ff1-08dda4e21697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xp3yn9AskntW9MSwbrs6XDB0ft3isLvS2fgzR12hp3l5URpAhUHSHghR2e5C?=
 =?us-ascii?Q?rWmgGS/r3/PPORpGBAJXVaxujsC6099/LsJ4cFq0eZo21cD0hUzuhinxiIE+?=
 =?us-ascii?Q?mldNNIwseeEXJo8aiIgO6EYgh5l6Ch6bGcdLCDAwr7shV3Z73LRfOnM5zvcN?=
 =?us-ascii?Q?KztVVQEwvx5lyLM5PkIobrJaB+/zYcX9W5PMjJq/csHNOPJFon5486Z/UQbb?=
 =?us-ascii?Q?MxqcfgHm08A6KcMREZi+NbA4r7XxZYlfvXn10LnoiRL8VgH7kfEcEDFvV4Ss?=
 =?us-ascii?Q?Nxu6XggSh2PkYp1rm62cTwtmg6/puQCkd1+cX83d5frO/Tgo1OjHuG4/PtY3?=
 =?us-ascii?Q?rgRETRNjb24/kwyKWNsBHvcLEM0RST1jLAHz9v0FrvvKzjcpxvmaB9gsosNg?=
 =?us-ascii?Q?x8g2mbG0R6EJktU0TVtoYid3drebCz6AV6OQZH6KlIOxDWQ7JJpopdc+6mOk?=
 =?us-ascii?Q?C0AiT2Bbc81h3AAT//RSRZsYIOssDPKFI9KQxMYaK29wLohTox1ysr/ll4MY?=
 =?us-ascii?Q?XE9MgZKnvTKxhPG4U3vbPO8Nr3aWDQx0a+N/rr9mSLvdFRFDUzywsWlyUIds?=
 =?us-ascii?Q?qD+WxcXLsGz1TTiOikoqIofxEaVKb1M1I4PuAZmk17n/k7wSgBTuYsM2noEy?=
 =?us-ascii?Q?6v2kzd3ghMp+2TkUFfIzdO6X1x26iqOvuDegeCDl7DN/XySj3DzNvLg3FMnq?=
 =?us-ascii?Q?u+z8SijN823MV3iw/8F9p+AsQptYqKrfG8KuXoV/O3JD7Ov+/EdYIfYdmCYz?=
 =?us-ascii?Q?BJRvmH77seUAtJT4yMN7meq6memC66WCN3Sg9zypBc8rZ4GXP41mGXVOXRAx?=
 =?us-ascii?Q?mT6/uc+CzS0mP2HGs0h+w8en3nteQZ8GFVO6HtP/Pqakm1OQU01Kiq9IIyS4?=
 =?us-ascii?Q?oCtUDadg39f3dFDH93dYCuPY+wCJdoEA8I4vYD4E1texeEKvxagkeACfwV8A?=
 =?us-ascii?Q?oFjtUIpIiZjwogN7MgDqevWshJywOu9ki3woU3AybJPlh4zBdtYQVx3lypxG?=
 =?us-ascii?Q?B9KHc7Q78jOiv0ltdCZBeLeeAE3PcBy+S4EXCaaUSBgJ8CQeQpI7up8QXgDs?=
 =?us-ascii?Q?C0PTMfx/JTKRfXIPlNTUnnJXLMQBgnhhYZJljGWA2evtMfiJymvEXb3GnDdT?=
 =?us-ascii?Q?BmZJv27mR1h8qmKZGURzjt8eIokal2zUXpQxcUcQKLLhfECMzMQZboM3BmxE?=
 =?us-ascii?Q?s4u2wSrAbKMtXWdGGiRosP+JJqiMpSXb4j+AaqeCBFmKLYIJGtMrJXoGfcOa?=
 =?us-ascii?Q?EyL1xQajojp3lgF8jHqGhH1ssXLbQTgJ3EJTWqEJg/erWXhEXgnhw3MKNqzk?=
 =?us-ascii?Q?2qAO46K4OUyw/sopRV3zkTkdOg+T4eBNNxuMrxs1KB1xuWRZyy6KARIvQeKL?=
 =?us-ascii?Q?1ez+WU4pp3McEb3GiDbSCF6lpPvgccORDV25eiEhmt5scCZGH6bG4knrucrB?=
 =?us-ascii?Q?A771gC+BxMLQHnT21lEcLtHlhLAKmocSucJrSzVDHOOOpfnOICTJUFzxHaRA?=
 =?us-ascii?Q?nsJVsY+x4wgC4J/5ecQ//Sebi0S+ezbuxBEW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 10:08:30.3710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b80d20-ebdc-4a65-1ff1-08dda4e21697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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

For the suspend and resume process, exclusive access is not required.
Therefore, it can be moved out of the full access section to reduce the
duration of exclusive access.

v3:
Move suspend processes before hardware fini.
Remove twice call for bare metal.

v4:
Refine code

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 24 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 25 ++++++--
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 11 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 57 ++++++++++++-------
 6 files changed, 89 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d8ac4b1051a8..fe282b855734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -248,18 +248,34 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
 }
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc)
 {
 	if (adev->kfd.dev)
-		kgd2kfd_suspend(adev->kfd.dev, run_pm);
+		kgd2kfd_suspend(adev->kfd.dev, suspend_proc);
 }
 
-int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
+int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc)
 {
 	int r = 0;
 
 	if (adev->kfd.dev)
-		r = kgd2kfd_resume(adev->kfd.dev, run_pm);
+		r = kgd2kfd_resume(adev->kfd.dev, resume_proc);
+
+	return r;
+}
+
+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev)
+{
+	if (adev->kfd.dev)
+		kgd2kfd_suspend_process(adev->kfd.dev);
+}
+
+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->kfd.dev)
+		r = kgd2kfd_resume_process(adev->kfd.dev);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b6ca41859b53..05ecba2a85eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -154,8 +154,10 @@ struct amdkfd_process_info {
 int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
 
-void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
-int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
+void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc);
+int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc);
+void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev);
+int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
 void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
@@ -411,8 +413,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
-void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
-int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc);
+int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc);
+void kgd2kfd_suspend_process(struct kfd_dev *kfd);
+int kgd2kfd_resume_process(struct kfd_dev *kfd);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd,
 		      struct amdgpu_reset_context *reset_context);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
@@ -454,11 +458,20 @@ static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 }
 
-static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
+static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)
 {
 }
 
-static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
+static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc)
+{
+	return 0;
+}
+
+static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool suspend_proc
+{
+}
+
+static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool resume_proc)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index ffbaa8bc5eea..1105a09e55dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -320,7 +320,7 @@ static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, bool enable_wai
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return;
 
-	amdgpu_amdkfd_suspend(adev, false);
+	amdgpu_amdkfd_suspend(adev, true);
 
 	if (suspend_resume_compute_scheduler(adev, true))
 		goto out;
@@ -333,7 +333,7 @@ static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, bool enable_wai
 out:
 	suspend_resume_compute_scheduler(adev, false);
 
-	amdgpu_amdkfd_resume(adev, false);
+	amdgpu_amdkfd_resume(adev, true);
 
 	up_read(&adev->reset_domain->sem);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5289400879ec..e8b500c266c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3524,7 +3524,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	amdgpu_amdkfd_suspend(adev, false);
+	amdgpu_amdkfd_suspend(adev, true);
 	amdgpu_userq_suspend(adev);
 
 	/* Workaround for ASICs need to disable SMC first */
@@ -5061,6 +5061,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	adev->in_suspend = true;
 
 	if (amdgpu_sriov_vf(adev)) {
+		if (!adev->in_s0ix && !adev->in_runpm)
+			amdgpu_amdkfd_suspend_process(adev);
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
 		if (r)
@@ -5080,7 +5082,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix) {
-		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 		amdgpu_userq_suspend(adev);
 	}
 
@@ -5178,7 +5180,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	}
 
 	if (!adev->in_s0ix) {
-		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
+		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 		if (r)
 			goto exit;
 
@@ -5197,6 +5199,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_init_data_exchange(adev);
 		amdgpu_virt_release_full_gpu(adev, true);
+
+		if (!adev->in_s0ix && !r && !adev->in_runpm)
+			r = amdgpu_amdkfd_resume_process(adev);
 	}
 
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7..48e2d67273f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1676,9 +1676,9 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	amdgpu_amdkfd_suspend(adev, false);
+	amdgpu_amdkfd_suspend(adev, true);
 	r = amdgpu_sdma_reset_engine(adev, id);
-	amdgpu_amdkfd_resume(adev, false);
+	amdgpu_amdkfd_resume(adev, true);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bf0854bd5555..6a832f3c2518 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -971,7 +971,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd,
 		kfd_smi_event_update_gpu_reset(node, false, reset_context);
 	}
 
-	kgd2kfd_suspend(kfd, false);
+	kgd2kfd_suspend(kfd, true);
 
 	for (i = 0; i < kfd->num_nodes; i++)
 		kfd_signal_reset_event(kfd->nodes[i]);
@@ -1019,7 +1019,7 @@ bool kfd_is_locked(void)
 	return  (kfd_locked > 0);
 }
 
-void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)
 {
 	struct kfd_node *node;
 	int i;
@@ -1027,14 +1027,8 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	if (!kfd->init_complete)
 		return;
 
-	/* for runtime suspend, skip locking kfd */
-	if (!run_pm) {
-		mutex_lock(&kfd_processes_mutex);
-		/* For first KFD device suspend all the KFD processes */
-		if (++kfd_locked == 1)
-			kfd_suspend_all_processes();
-		mutex_unlock(&kfd_processes_mutex);
-	}
+	if (suspend_proc)
+		kgd2kfd_suspend_process(kfd);
 
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
@@ -1042,7 +1036,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	}
 }
 
-int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
+int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc)
 {
 	int ret, i;
 
@@ -1055,14 +1049,39 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 			return ret;
 	}
 
-	/* for runtime resume, skip unlocking kfd */
-	if (!run_pm) {
-		mutex_lock(&kfd_processes_mutex);
-		if (--kfd_locked == 0)
-			ret = kfd_resume_all_processes();
-		WARN_ONCE(kfd_locked < 0, "KFD suspend / resume ref. error");
-		mutex_unlock(&kfd_processes_mutex);
-	}
+	if (resume_proc)
+		ret = kgd2kfd_resume_process(kfd);
+
+	return ret;
+}
+
+void kgd2kfd_suspend_process(struct kfd_dev *kfd)
+{
+	struct kfd_node *node;
+	int i;
+
+	if (!kfd->init_complete)
+		return;
+
+	mutex_lock(&kfd_processes_mutex);
+	/* For first KFD device suspend all the KFD processes */
+	if (++kfd_locked == 1)
+		kfd_suspend_all_processes();
+	mutex_unlock(&kfd_processes_mutex);
+}
+
+int kgd2kfd_resume_process(struct kfd_dev *kfd)
+{
+	int ret, i;
+
+	if (!kfd->init_complete)
+		return 0;
+
+	mutex_lock(&kfd_processes_mutex);
+	if (--kfd_locked == 0)
+		ret = kfd_resume_all_processes();
+	WARN_ONCE(kfd_locked < 0, "KFD suspend / resume ref. error");
+	mutex_unlock(&kfd_processes_mutex);
 
 	return ret;
 }
-- 
2.34.1

