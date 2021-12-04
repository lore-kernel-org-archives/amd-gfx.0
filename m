Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB58AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19ED7A2FC;
	Mon,  6 Dec 2021 10:20:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBEB06EC19
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 11:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij6tAG8sVI6y5I+EhHp8oba0qcLH59dMLynHr7fbcCiMrgTMLvExsRMcO41fiKcjXcnogaL130PjnHBzHE4Neqpdt197j3UZGC9ssCz2ZzFYX7g4stMRKZIFCREICS1Pylq/2bO9UvVKL+LidX6kt08vfenFfW8u4EyAEeCOrYTRXS8NywZ3HBpw3oCBPBXI7ojaPxWJf/6XvM6yqyuayHnZFKcPpfoevgq3n/rFpEEuOOWOLtcr+8bl8HULXOJFrmlXNIdF029MmX4wB0fdb0WdyGSHakAdB336e3XIekTDuUh4+Ha+Jw64OkG1AODI25/ywhKMWyvdAjEP0gLmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TFnuDtf43fy0Sif9BhkacozZLZyHHm9ZVCM0rrxbMU=;
 b=Qm98KZ+Ti1Fh/WjsA+Ze9ATOUzJECV9igfRQXKt0PbQfqsAX0lGUT23vF/j0FpEV9WcsRKwXuDYhYSjlXOTQKiTLU0SiW2P2Vatl6eFBe8es6dEUUo2nDnsiyJzyaAWdXNqsHMWe99mU2g4jZTfnirMtQQIsVXlTXye9kxqmZe8cBJhQw/LoyVYSXwfIfn2zaFRVrum60dv9YG3y6t9oOehmpHOsuffSMz8d4Gcef9sjiIPvYxsjoLF4e+ixsDveRj9UHqKw3pLG/3LB626f8G08stiUxTWaSWtXaK4tNEZZ44vdi1TDEHd2vAROhJ2Ety0lJOVA7E67JaQbKrDsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TFnuDtf43fy0Sif9BhkacozZLZyHHm9ZVCM0rrxbMU=;
 b=wMnKultDEXP69qhOxrQybNqrCdDc9JyLXex+7u/U539HJRJWYnMPCcJoxHFfZJh4KnCSCjASaNNUwpSvwhYsf6ohQIRP3yDahWIAp6NUTmC8pYbSbkNpmbylV0wKgVFOjCbGgKWKzsGCQgOxi25d2BcR+LeZy9DDk9U/QSHefkk=
Received: from MW3PR05CA0018.namprd05.prod.outlook.com (2603:10b6:303:2b::23)
 by BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 11:47:26 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::c0) by MW3PR05CA0018.outlook.office365.com
 (2603:10b6:303:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Sat, 4 Dec 2021 11:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 11:47:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 4 Dec
 2021 05:47:24 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sat, 4 Dec
 2021 05:47:24 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.17 via Frontend Transport; Sat, 4 Dec 2021 05:47:23 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: check df_funcs and its callback pointers
Date: Sat, 4 Dec 2021 19:47:21 +0800
Message-ID: <20211204114721.17032-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca290593-911b-42cd-6de6-08d9b71bd79a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2773D44802E23F764296DD8AFC6B9@BYAPR12MB2773.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SaQC5ny29yb8rhK70fnJl/VueOIqbKgTATMCKi64VgDmphtcymE5eGRPlzR04HRq47x/f83uRj0AAoeohGWRwHGz8+XAt4WNNrp/Wmn+bQzIaa2mR9PEJPZJ3GB4rzJsZJ2iDpONoIMXun8jvViW1FnEoXw2vHUog80W9ec79gBKu/r1urNJ7MZAAPgwAGJP/ztwfFPAikmOf6/KVhYz4LaOs3/INzJSlXbTbIAemLSgMKrQgf1AR6QnA0nrMCevxZ7p8MmjvsxoW2kYSCfDmTyFIiaj5B7lWOT5CRAWC+gUiQOpqUonpkYFdNk2gU96AuQqf+zaMhbu07vxvQxnc1hK/YyoP6JjaBKmDWvIqagb105VjvdymmfLjzjFD9Q3V51rI7BQjU0wa2MuFRMSJpyvLqk4IdTl8GHCqC2N+2SaFEoSHKBcnbDYHJgnvEogVD/NeeVE/UZepH2SsEcZUVR+C9QRSbHhewwl5j9niFsmM3BfeuCErw1P8qt5fH/QC76MrC1tAZpmcB56iciG4sWHoHrZPfRp5NT/N43PX3e4kOqW61BUffh9u++hzDjlTVoI5eSCmgWffNp2IIYgzH4B/hZ0CQwlFANakYk3rZYYVDJhJVXqgnR9me7bii+/CKy3YvtkS3X5NpLIhDMdBXY5qeacPFHOobjXBXnBIp0t1p1UR0NlB6kR+DtCTkU0sNVh/Z54kW8vC5QpPG4xa5eR01R88sKvJf3t0A7fHF0UCmA5VG4quiVJTliRoubaOCZRkexg0zmt7Y9QI2CJxxl3SWdAUHHDhzA9RgV6fs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(70206006)(86362001)(47076005)(83380400001)(2906002)(70586007)(336012)(6916009)(2616005)(356005)(426003)(81166007)(316002)(82310400004)(7696005)(508600001)(36756003)(186003)(8936002)(5660300002)(26005)(8676002)(40460700001)(1076003)(4326008)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 11:47:25.6983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca290593-911b-42cd-6de6-08d9b71bd79a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

in case they are not avaiable in early phase

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c  | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 11 +++++++----
 drivers/gpu/drm/amd/amdgpu/soc15.c       |  9 +++++++--
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 82e9ecf84352..71ee361d0972 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -233,6 +233,10 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
 
+	if ((!pe->adev->df.funcs) ||
+	    (!pe->adev->df.funcs->pmc_start))
+		return;
+
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
@@ -268,6 +272,10 @@ static void amdgpu_perf_read(struct perf_event *event)
 						  pmu);
 	u64 count, prev;
 
+	if ((!pe->adev->df.funcs) ||
+	    (!pe->adev->df.funcs->pmc_get_count))
+		return;
+
 	do {
 		prev = local64_read(&hwc->prev_count);
 
@@ -297,6 +305,10 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
+	if ((!pe->adev->df.funcs) ||
+	    (!pe->adev->df.funcs->pmc_stop))
+		return;
+
 	switch (hwc->config_base) {
 	case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
 	case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
@@ -326,6 +338,10 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 						  struct amdgpu_pmu_entry,
 						  pmu);
 
+	if ((!pe->adev->df.funcs) ||
+	    (!pe->adev->df.funcs->pmc_start))
+		return -EINVAL;
+
 	switch (pe->pmu_perf_type) {
 	case AMDGPU_PMU_PERF_TYPE_DF:
 		hwc->config_base = AMDGPU_PMU_EVENT_CONFIG_TYPE_DF;
@@ -371,6 +387,9 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 	struct amdgpu_pmu_entry *pe = container_of(event->pmu,
 						  struct amdgpu_pmu_entry,
 						  pmu);
+	if ((!pe->adev->df.funcs) ||
+	    (!pe->adev->df.funcs->pmc_stop))
+		return;
 
 	amdgpu_perf_stop(event, PERF_EF_UPDATE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 567df2db23ac..a38c6a747fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -265,6 +265,11 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 	ficaa_pie_ctl_in = AMDGPU_XGMI_SET_FICAA(0x200);
 	ficaa_pie_status_in = AMDGPU_XGMI_SET_FICAA(0x208);
 
+	if ((!adev->df.funcs) ||
+	    (!adev->df.funcs->get_fica) ||
+	    (!adev->df.funcs->set_fica))
+		return -EINVAL;
+
 	fica_out = adev->df.funcs->get_fica(adev, ficaa_pie_ctl_in);
 	if (fica_out != 0x1f)
 		pr_err("xGMI error counters not enabled!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7490ce8295c1..9684d867199e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1294,7 +1294,8 @@ static int gmc_v9_0_late_init(void *handle)
 	if (!amdgpu_sriov_vf(adev) &&
 	    (adev->ip_versions[UMC_HWIP][0] == IP_VERSION(6, 0, 0))) {
 		if (!(adev->ras_enabled & (1 << AMDGPU_RAS_BLOCK__UMC))) {
-			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
+			if (adev->df.funcs &&
+			    adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
 		}
 	}
@@ -1505,9 +1506,11 @@ static int gmc_v9_0_sw_init(void *handle)
 			chansize = 64;
 		else
 			chansize = 128;
-
-		numchan = adev->df.funcs->get_hbm_channel_number(adev);
-		adev->gmc.vram_width = numchan * chansize;
+		if (adev->df.funcs &&
+		    adev->df.funcs->get_hbm_channel_number) {
+			numchan = adev->df.funcs->get_hbm_channel_number(adev);
+			adev->gmc.vram_width = numchan * chansize;
+		}
 	}
 
 	adev->gmc.vram_type = vram_type;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index de9b55383e9f..a06c4944ed37 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1238,7 +1238,9 @@ static int soc15_common_sw_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_add_irq_id(adev);
 
-	adev->df.funcs->sw_init(adev);
+	if (adev->df.funcs &&
+	    adev->df.funcs->sw_init)
+		adev->df.funcs->sw_init(adev);
 
 	return 0;
 }
@@ -1250,7 +1252,10 @@ static int soc15_common_sw_fini(void *handle)
 	if (adev->nbio.ras_funcs &&
 	    adev->nbio.ras_funcs->ras_fini)
 		adev->nbio.ras_funcs->ras_fini(adev);
-	adev->df.funcs->sw_fini(adev);
+
+	if (adev->df.funcs &&
+	    adev->df.funcs->sw_fini)
+		adev->df.funcs->sw_fini(adev);
 	return 0;
 }
 
-- 
2.17.1

