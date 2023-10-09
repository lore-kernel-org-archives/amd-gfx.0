Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B8EE95A9F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E64710E0CC;
	Mon,  9 Oct 2023 15:55:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7285210E065
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huAhke3SkwHyCiRScc8WH7Yl4o01INWyPQqPwp88KcEqHrKasIUtBMQ20TgBMIY1L9crVRybP+65nvZfPPALdkl6L3RLGg2l52JKoZaCA2RUaVeClBc+lPWmBGUYefA2OxLsBbK8PGa5b0vqopn1WLO5WaY59NY7eXlCego1LDe4kvLhO3E9aYgi3q5N5Pt5XXMsCNw5DU30QvGq7q1ide1cwajHii/VmWKWlf+PMDijUPMQboN0cmlGuCZ20wuHO6DE2OIIjjtWRfvzjdAeIXV9rKM3zsuQCCVcPG2HmQekUZpv1LdrJPTSuCWXOI6jZntJKSr+g3PRolYJhWO5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX4VBoj9sjnyZrIPMFrxXcDlXr86l0WXhT8tTRh+EDY=;
 b=VzygH228YpQ2lnAzmkxqzwTvyAtll9d7ch8I5dK/i660WQAo4vGtQkz1ubsC0dbngSeHyf8gdU6WgrDBfUpuMKnevNdPoA2pSXWnt0XoAwPxvHYNjacWuJUEqrl63rxt42rtX9JdJrC4x1jg3B1mPU3Ex2780dm2btICtw7MZaZT9Dow4SRYt9wdMvDy+FNVosw2c0RfEAINtWM7YRXH8nxreAnSX6F1uWLWY/bO5RjvTZypOh8JROxu+l8Wyj+nvROVG+X3/SrPCTlQOXu18PuZHa3ySkHP8AzfI8RuDmMa9A3/sEDWopiXZKa4absqI+KfWGksVMvSrko75wwFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX4VBoj9sjnyZrIPMFrxXcDlXr86l0WXhT8tTRh+EDY=;
 b=flLbvnwm3jooAeVZmo0skh3QH/CDQTxr1Pzc8UtOXrz73IAA4/jD/Dlyvav+etOklAPA67FB9AzS36NxJADo7SdbF40xRxxKjdAq9zKGfmUjPGlK86gtRH3Q9NARo7uZ9t0TAW3b2uL8QfYjaolj59Pj/eEwYIObqA5UENOlPvo=
Received: from CH2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:610:50::13)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:54:59 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::5) by CH2PR16CA0003.outlook.office365.com
 (2603:10b6:610:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Mon, 9 Oct 2023 15:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 15:54:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:54:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 3/7] drm/amd: Split up UVD suspend into prepare and suspend
 steps
Date: Mon, 9 Oct 2023 10:54:22 -0500
Message-ID: <20231009155426.96232-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009155426.96232-1-mario.limonciello@amd.com>
References: <20231009155426.96232-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM4PR12MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: a004ea4a-b571-40fa-3430-08dbc8e01770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/6hX8COKw0fzEwnPoZdKRY3kLPuxjzlcUkhZxVJBpfLHgJF1DCZK/Jlo9O+jqo/iYUw6sIhIJ6/ByUI5IFEqRjlj1p0Hr729AaHKTzXLSOjU5g3w9w6Ma/1ddJyhcM1JFE9PpHuwDNoceqSIblLEG3oGNUlD+PMDGLXLYwcqaVC/8cUmTL9oHkB2kk+2/V4DiIpz/6yHTeyYvVRinVQIIu/JeDB1mg87bYIa7f+Z61nKxi/361PWo2GViyg5Id1y6VH9Cy+V/RuEZBWI0nZJPHWRaAEwKEJ1Qc9A9p4E/NS53ugyvUBUTF6Y06G00+zYx4RuMLyNhF8jd4fFaq9OsCapN6h19opx9rKXsisQEnaLpVVYk/t+HHgBYS3/grrFNJY+834S5mtT1JoseoQ+rlh6LObvOw+viZEGfp0DgQfer5pNsKRHbkIvDZBRCpYjVrDYSYa+mP+9RGdAgTnt7k/soQactX5lqpUTyLLd9giBjgDy49dudbiz8yXEpTWzlfISJxOee1v08Vn9eDs5L3O3cGxUY4wYNum1VTgZe2zdHE5bdFLzF6FvQ9Ej5Ssl1PXKh3OlbyGthbIUPDyF0Gu8Xc/NaPb+du3nKbuC3OqcfPg/8Fo8/qKSErlki6SZNNZgH9oe1XX9W5uEgKvXI/0ohwRIvEKqjPKfxtr5CIq/ekCFJNRUfxlsHUClpCIiTlTteAdy/AMuqSYmmlOiZanH01G0IUFpPFDkMQWh5UI6ibEGoWU2pZa5pzqGDLvpgaK0FPK4wtkva9GkPZu/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(336012)(26005)(16526019)(426003)(1076003)(2616005)(36860700001)(6666004)(7696005)(478600001)(66574015)(47076005)(41300700001)(44832011)(8936002)(83380400001)(15650500001)(4326008)(2906002)(54906003)(70206006)(70586007)(5660300002)(6916009)(316002)(8676002)(40460700003)(81166007)(356005)(36756003)(86362001)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:54:59.3109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a004ea4a-b571-40fa-3430-08dbc8e01770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_uvd_suspend() allocates memory and copies objects into that
allocated memory.  This fails under memory pressure.  Instead move
majority of this code into a prepare step when swap can still be
allocated.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Drop spurious newlines
 * add tag
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c   |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c   |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c   |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  8 ++++++++
 7 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b7441654e6fa..815b7c34ed33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -418,12 +418,11 @@ int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_uvd_suspend(struct amdgpu_device *adev)
+int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev)
 {
 	unsigned int size;
 	void *ptr;
 	int i, j, idx;
-	bool in_ras_intr = amdgpu_ras_intr_triggered();
 
 	cancel_delayed_work_sync(&adev->uvd.idle_work);
 
@@ -452,7 +451,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
 
 		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 			/* re-write 0 since err_event_athub will corrupt VCPU buffer */
-			if (in_ras_intr)
+			if (amdgpu_ras_intr_triggered())
 				memset(adev->uvd.inst[j].saved_bo, 0, size);
 			else
 				memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
@@ -461,7 +460,12 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
 		}
 	}
 
-	if (in_ras_intr)
+	return 0;
+}
+
+int amdgpu_uvd_suspend(struct amdgpu_device *adev)
+{
+	if (amdgpu_ras_intr_triggered())
 		DRM_WARN("UVD VCPU state may lost due to RAS ERREVENT_ATHUB_INTERRUPT\n");
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
index 9f89bb7cd60b..a9f342537c68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -74,6 +74,7 @@ struct amdgpu_uvd {
 int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
 int amdgpu_uvd_sw_fini(struct amdgpu_device *adev);
 int amdgpu_uvd_entity_init(struct amdgpu_device *adev);
+int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev);
 int amdgpu_uvd_suspend(struct amdgpu_device *adev);
 int amdgpu_uvd_resume(struct amdgpu_device *adev);
 int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5534c769b655..58a8f78c003c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -706,6 +706,13 @@ static int uvd_v3_1_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v3_1_prepare_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare_suspend(adev);
+}
+
 static int uvd_v3_1_suspend(void *handle)
 {
 	int r;
@@ -806,6 +813,7 @@ static const struct amd_ip_funcs uvd_v3_1_ip_funcs = {
 	.sw_fini = uvd_v3_1_sw_fini,
 	.hw_init = uvd_v3_1_hw_init,
 	.hw_fini = uvd_v3_1_hw_fini,
+	.prepare_suspend = uvd_v3_1_prepare_suspend,
 	.suspend = uvd_v3_1_suspend,
 	.resume = uvd_v3_1_resume,
 	.is_idle = uvd_v3_1_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index c108b8381795..d3b1e31f5450 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -220,6 +220,13 @@ static int uvd_v4_2_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v4_2_prepare_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare_suspend(adev);
+}
+
 static int uvd_v4_2_suspend(void *handle)
 {
 	int r;
@@ -756,6 +763,7 @@ static const struct amd_ip_funcs uvd_v4_2_ip_funcs = {
 	.sw_fini = uvd_v4_2_sw_fini,
 	.hw_init = uvd_v4_2_hw_init,
 	.hw_fini = uvd_v4_2_hw_fini,
+	.prepare_suspend = uvd_v4_2_prepare_suspend,
 	.suspend = uvd_v4_2_suspend,
 	.resume = uvd_v4_2_resume,
 	.is_idle = uvd_v4_2_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index d7e31e48a2b8..5a8116437abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -218,6 +218,13 @@ static int uvd_v5_0_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v5_0_prepare_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare_suspend(adev);
+}
+
 static int uvd_v5_0_suspend(void *handle)
 {
 	int r;
@@ -863,6 +870,7 @@ static const struct amd_ip_funcs uvd_v5_0_ip_funcs = {
 	.sw_fini = uvd_v5_0_sw_fini,
 	.hw_init = uvd_v5_0_hw_init,
 	.hw_fini = uvd_v5_0_hw_fini,
+	.prepare_suspend = uvd_v5_0_prepare_suspend,
 	.suspend = uvd_v5_0_suspend,
 	.resume = uvd_v5_0_resume,
 	.is_idle = uvd_v5_0_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 5fe872f4bea7..74c09230aeb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -542,6 +542,13 @@ static int uvd_v6_0_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v6_0_prepare_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare_suspend(adev);
+}
+
 static int uvd_v6_0_suspend(void *handle)
 {
 	int r;
@@ -1528,6 +1535,7 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
 	.sw_fini = uvd_v6_0_sw_fini,
 	.hw_init = uvd_v6_0_hw_init,
 	.hw_fini = uvd_v6_0_hw_fini,
+	.prepare_suspend = uvd_v6_0_prepare_suspend,
 	.suspend = uvd_v6_0_suspend,
 	.resume = uvd_v6_0_resume,
 	.is_idle = uvd_v6_0_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 86d1d46e1e5e..1c42cf10cc29 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -612,6 +612,13 @@ static int uvd_v7_0_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v7_0_prepare_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare_suspend(adev);
+}
+
 static int uvd_v7_0_suspend(void *handle)
 {
 	int r;
@@ -1787,6 +1794,7 @@ const struct amd_ip_funcs uvd_v7_0_ip_funcs = {
 	.sw_fini = uvd_v7_0_sw_fini,
 	.hw_init = uvd_v7_0_hw_init,
 	.hw_fini = uvd_v7_0_hw_fini,
+	.prepare_suspend = uvd_v7_0_prepare_suspend,
 	.suspend = uvd_v7_0_suspend,
 	.resume = uvd_v7_0_resume,
 	.is_idle = NULL /* uvd_v7_0_is_idle */,
-- 
2.34.1

