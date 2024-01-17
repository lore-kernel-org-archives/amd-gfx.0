Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCEFC47422
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 09:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70F110E641;
	Wed, 17 Jan 2024 09:14:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A6A10E66A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 09:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNu5osKJozdPQYn14W/FK2RYrS9O1gy+sxCDpturq2AARSuK0z73os+ZClcYKNpApZ/QmfL+GIoOtcFKaZd1oNp5QAgNPsth6O9k/um3ZFVwMKoq4uQp/PXSV6TreZy1gRD+yeiiX6irs7ewgGUiyQMyA4qV4DRC+sXyyUHAD5CZlXob0FaubRv0DkaJUGnvz2B0QMs2C4ZLWPgxy73jBnCjPJmuIMlx4L53eGQXw15UNeZFg5Apd1ckSjnn90ZqTnjOAUIOyDn1wvv4haR+AkfVvYPE4IU+atZjn268THiNRwXNV716AAV+dkrGbseauoFvHZeMMehpv5UWNNb6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+GO7qDC54OGmZChJtUUv9bEvU1QK+LbULWlRtq7tPI=;
 b=eBiGnli3rLlNRrGQ6CwLw6rrD1BMOtRme02iJu7EjqU3LPDZb8yovbpM/nbLuAUmL+VA+64+W9DSVMM+ey6fnl2xzd9lie27uTBMHf751V+MuN33C7Oye1zHY9JNvF2tJYUDB9i4vCMq6t3PJZ2nrWwzoLg5j9ZwzynCAvchIr5SKfiMxMgEEtc+nZgLlerMB4ZepUUzzzvfqxu7eUAcqPZSQN2NF0uX6SHRJ9zJw/Ayqwr0P9dO/K4jhxPVamDtDeGtTq5gPUn+7XknGVum5/kgAFe9nBhdKoQivVCcQxzc/w3AS+wOr2GKYcleOBo1Li0t4zp33iWI+7vWcBcJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+GO7qDC54OGmZChJtUUv9bEvU1QK+LbULWlRtq7tPI=;
 b=pKDC9tzyi5dxbYX5reb2jhGWD8H+fEpluLSsWSdFc0jokZ0aNkSR80UAAQzLm0nRrllrHMyk9Crh1DPSRlU3K8jtM0ZpoqtoFwAdABWB6KHk49CJT5ncABzBv8QGGw3W9lrCLn7DMG42Z0+YMW5KMQAZ5FaaBZAwYk55WEUyzLk=
Received: from CY8P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::6) by
 LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.30; Wed, 17 Jan
 2024 09:14:52 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:46:cafe::1b) by CY8P220CA0021.outlook.office365.com
 (2603:10b6:930:46::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 09:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 17 Jan 2024 09:14:52 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 03:14:50 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] update check condition of query for ras page retire
Date: Wed, 17 Jan 2024 17:14:30 +0800
Message-ID: <20240117091430.29140-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240117091430.29140-1-tao.zhou1@amd.com>
References: <20240117091430.29140-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: b1aba421-87fc-4cf8-e5da-08dc173cc37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpNRRQqfYCp1NdPVeoQxPst1rvMLExkU8Llh/bl+IT889gxbGtqDOoiw9uSJmVNLslNWQ97W3XqnmaASrmz4jbWoH7gnKjbLTQNxea18c5feKqWpLU6nMkc+OuMy6HszOfjGZND7hpT1hJ3v8Az34Lz19H7K6PUMAc2/BZ+3J+h29bltEBcfGFA6FmAm35KoctQRlIm2BCtXTXyavQvBI5GUvXiKh5vQmc5G/Vq9g7x+SepdgCgBKxahTcW3oTZyNyNlPsz4zSNTY5FPMdDBV+UzmYfmDUyStRzhasIRcG/T4edrtrXrsT6L6TOpc6aYLgnisCRon1QuVHM/7UPOdz0CcUVBnTUT1/7DDEg/Qk8tqDCwSJMa8GR57V8xLW7g4YUNO6RO7OIxij1P53tJ+De7yFsFnBBmZdJO9auXapjZSRef4AH191/VGeP0wUbpg7rPjSFNV+GFjgfCdRTOyB0Qfgr+qbuwpU5pnSQ/4a4lMnot80lp9SIJIaEKS1g7AwzqLTNZI02VDvb/EiKuV0OZqvs2FI+Om/KSYOMJRjC1SZjrUMm2EGjgw+JPdW0SRAx0N6t0KXE/HDO6eQZ71SP2d2w0YpMin4TTplYBCzFih1HFNXEP5uXESNS/a5gqa6tYNQOoB9qjfmWIUb4zWB6K3itLg+SqqhxA1I8rydD6GkKA+fZFWOhLAgwak6iBFa+5RCBG4YLpF0cWBQRcrgupyxUvfVa3y4ZYBd/wYqK3y5mrpeQnFU0FObqTWTKbvyEyEbNO79g9OsmQQzwq8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(86362001)(70206006)(70586007)(81166007)(36756003)(82740400003)(2616005)(426003)(83380400001)(16526019)(356005)(336012)(41300700001)(47076005)(1076003)(7696005)(316002)(478600001)(4326008)(5660300002)(6666004)(2906002)(8936002)(6916009)(8676002)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:14:52.4180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1aba421-87fc-4cf8-e5da-08dc173cc37e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support page retirement handling in debug mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c              | 9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 41139bac7643..6df32f0afd89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -90,12 +90,16 @@ static void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	unsigned int error_query_mode;
 	int ret = 0;
 
+	amdgpu_ras_get_error_query_mode(adev, &error_query_mode);
+
 	mutex_lock(&con->page_retirement_lock);
 
 	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
-	if (ret == -EOPNOTSUPP) {
+	if (ret == -EOPNOTSUPP &&
+	    error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY) {
 		if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
 		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
 		    adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev, ras_error_status);
@@ -119,7 +123,8 @@ static void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			 */
 			adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev, ras_error_status);
 		}
-	} else if (!ret) {
+	} else if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY ||
+	    (!ret && error_query_mode == AMDGPU_RAS_DIRECT_ERROR_QUERY)) {
 		if (adev->umc.ras &&
 		    adev->umc.ras->ecc_info_query_ras_error_count)
 		    adev->umc.ras->ecc_info_query_ras_error_count(adev, ras_error_status);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c560f4af214d..d86c9e7fc64b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2909,8 +2909,8 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
 static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
 			void *table)
 {
-	/* Support ecc info by default */
-	return 0;
+	/* we use debug mode flag instead of this interface */
+	return -EOPNOTSUPP;
 }
 
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
-- 
2.35.1

