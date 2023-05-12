Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F154C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 21:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5AB10E2FE;
	Fri, 12 May 2023 21:44:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BFA10E2FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 21:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBA7Yd1vXLUnGJ3ilyK9G5lqPl0Vb3EnN2E4I84QAvZ7m/OwNZ+iPdaqxHzA2nfE/3I7GaZP5DA4wz/sBhQj03Om0pg0IqrheNWvOY21Lf6+RaUV51EcHvelKjsqK61NlMcM38vxkr+xY21Unpe4xMcQ8ww40TtUL4EhwzS6pQEuTwRPHQUptfbvvbqqbn4tmkKROkHYW8O6lZ8vXrUoWtBMABYrYdFlV4wfJUZ9wK9Xe4B4yMRUUafw7lynyIq+PWMOdMwhtnzYDQb4Nhv0UKtdhXXmpbKFP8h1H2HZctIOwaHGok4XlB6pdowMpB4C5MU9z/z90aVM08sWNQmd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xW29c+j43MfFCYxOD4JT7n9zsd8NYPNP2C549deCGQ=;
 b=bz+EaIfnivQEu/osCf4xIqjuLHTvUF/nz7qg17YJLU+PgoaZ0s8F9ptzcqttKhb7xPujvCmyTBtTkP6Ql6Q0qORMlzYUofp7Y6sHhYCXSFzRwcgJ1pozG0YOL9UIh6vVNcb0LLm+QBfvvF5IiCBuDNTVdk3O0gQ5hc7EmoBLLoDAJYWqa+ai+JEHIbl4SP2CreqmcBAvSWVbv7eDG74HVMoXyK5qjtiOvLNEhjz/otOyYV6fLWS0s7Ut5uGzrrWp0pkf3uCZNhsPydSmTu3o+aTCiE+YVBSymcKAK4Eob0HtS7IOF+0BtFresM9q6fRiLBqUMxiiRMHsc+RF/7rObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xW29c+j43MfFCYxOD4JT7n9zsd8NYPNP2C549deCGQ=;
 b=mI7u7qlKGMSR/HetBj0BvrCL0WE/Dt0tZUvv72Nkof6tUHsuxLm33+CcQ20YQAR0nti6rlxLPo/xR3bMe8N0zKmeA+Fwbe90ZngdmyXJlt/3gyGx4mZtdDqLJhaN40HaMkg5G4xCFd3JH4Qs1hensZEEAYnjXpUIlnbBOQtVGpk=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 21:44:15 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ca) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 21:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.26 via Frontend Transport; Fri, 12 May 2023 21:44:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 16:44:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amdgpu: add GFX RAS common function
Date: Fri, 12 May 2023 17:43:42 -0400
Message-ID: <20230512214351.1356254-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c5f8b8-2310-4f09-d24b-08db5332082d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iN42RqipuRUoMytHqR7KzdcIqb/VoPS1gFaM8oBhCXfNkTOKLCPLOPd+v0H44NiQTLYlGXQseDfU1EeV6JjQ6+0d6O4I+G3+B1ZksHPUWKp637E+MDZVtAlRNwVZSHVI9H56FxYRWJ/s68GUdvBHYh5sDbr8YK9j24V4npt65UNoV24HRSbrqPaFmhwEd1XwTvxFAd6JxqlH4NYhMXyICOV/sfBXF3fvswDRBXuh/zb0FfjOdTh67sqhHWujRypTb7w01ETl3rim0GHh3yThRdIpQyTQGa7LfhQnWa3HnA6Qp765uQwIOMi1jC43oDzlqu2zvC+cp2MGjZIcIIK4dNboKdNyn05y0xatv3GRWDxYVfvK1Cx7y9/jXg1qFtm1VFCXsFA77wscvNrMF1cPpwVzav61wryLIFEHv12MOnCxykbQNyRGkJvSdFn5LwmkrRJ8ESkDnb4QcBkZCzck8JLaAeV6TR/qcb5EJbd57yzaXxEayZ0VoRC83yRXPYVRXkxIkVqnc679AlEXClZ2aaSEftrCOSxKWARucKupUGQOYAUZXz3YdQM4FA+gcfnrnTEvL4UgmaBSzFDn5V4f273D250qAM5oL2pxLoIdBoA0MuSK8eOKqYgzu/etyXxGFpRHtksFTCAwW9BAB110KxhbsgvWoYQZKKcKxUtHVzS2byEvYXl98adGKJDfSKXA68GZ7F+TJg9hVLDIsH9qENOhwI7mHlW5nSBPtaFcSahxc4Z7AgYTs9GC5QvGupZyNp2jSuc9keB+lQX2ieSmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(316002)(40460700003)(426003)(336012)(2906002)(36860700001)(2616005)(6916009)(6666004)(4326008)(41300700001)(70586007)(54906003)(16526019)(186003)(70206006)(5660300002)(26005)(478600001)(40480700001)(8676002)(7696005)(8936002)(1076003)(47076005)(356005)(82740400003)(82310400005)(86362001)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:44:15.2185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c5f8b8-2310-4f09-d24b-08db5332082d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

The common function can help reduce redundant code.

v2: remove xcp operation, only need to do RAS operations for all
instances.
v3: remove check for GFX RAS support, will be checked in higher level.
    add amdgpu prefix for the function name.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2ebf5c6f4ff7..7b072413e576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -878,6 +878,25 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
+		void *ras_error_status,
+		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
+				int xcc_id))
+{
+	int i;
+	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	uint32_t xcc_mask = GENMASK(num_xcc - 1, 0);
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	if (err_data) {
+		err_data->ue_count = 0;
+		err_data->ce_count = 0;
+	}
+
+	for_each_inst(i, xcc_mask)
+		func(adev, ras_error_status, i);
+}
+
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	signed long r, cnt = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ba5f417146d3..f07117d8959b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -496,6 +496,10 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
+void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
+		void *ras_error_status,
+		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
+				int xcc_id));
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.40.1

