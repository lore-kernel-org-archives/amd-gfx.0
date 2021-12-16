Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD02C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 11:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9AB210F60A;
	Thu, 16 Dec 2021 11:35:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24E010F609
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 11:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1DhEKqoqd7apYsz/eCtXjD/r5OsPJ1nKBywQn400ey6G/qVbpwy6uLacXjTfJgxxI6eHUi1e7QboI2WhXlhDCfDIB4rYOTnCUkQHxAvM6rw73ola8VLW4m+hkvxp8di2fL85/B2akQdAPz9tMFeP6KyKv9LCd3dQI2nxA15KdpIriShbpeuJ+YsWHPqE9oLtZRayypUTjpeI+T7tYcY3OOYPV4uY4loik7nh5R/bMDkaQTn7IlaFuxmY1gqRuRvOCU8f1t+8dGEO6TyPRuuG7qydX/KK9d91Q/QCkjmUT+4FewUIbiWVvhwZwbET+/9Xf2JwOQDOIdVJYpuVkQ11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkXjDlYZE476PR3OALgeDsXx/yqCmPz2+YV7hfrVE+E=;
 b=hbiJgGugnXbKCbGJhvDFcPMeUymXdZ4gh+6tCuJ12j5f8JZ+Oq0ueky5AZNhH6h4DRTColejvPd3PV0bQ4EO8j6S6IYAo4TblWbdPCTcJjU5kM5I3X8T8ras8CVgb2csfyPj+DOUSRn3AWB1u6fjtGPN/bnCVADzOTt+t9igFQodeSG30w31K1uIFK5dHHjBeLiJUad5qJkKU0K+68KqnXXo5/eyh2uBwZQbiDO6fYaIs3t4wRuc/AkKaadxnnINT9N/qa9Dl2lpx1m5T8ems1CI+nQwCwjh/2eX64Ttrw1ii+3flWSaLZ9PZLLcFxus5X/zu0KIKTwwz31yt3mAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkXjDlYZE476PR3OALgeDsXx/yqCmPz2+YV7hfrVE+E=;
 b=bTGH2d2mQ7SQ/pFNU4XMkhQbdjsGYjQmrrZOEpiortA11KFRVTFL1faWwyAAlugTD9zI76JBC3ZsYQ/LTXouAIu25FfluJibKeng84rSWYLm1E7iEJEtobwF1qmAloeYNYaQ/8GkFCjkmI0YvsOiQV+dCPxDfbWqKAhP9dlwaq4=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 BN8PR12MB2884.namprd12.prod.outlook.com (2603:10b6:408:97::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 11:35:45 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::5e) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 11:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 11:35:45 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 05:35:42 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add gpu reset control for umc page retirement
Date: Thu, 16 Dec 2021 19:35:29 +0800
Message-ID: <20211216113532.12369-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3720ff6-39d9-4173-d11c-08d9c08832ee
X-MS-TrafficTypeDiagnostic: BN8PR12MB2884:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2884F304A4D352483A58EEFBB0779@BN8PR12MB2884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PLmkPbTLg7soI4xjIem8W3kvabaS2Zvw/czhx4691mOrHqfz1wANjljnASrJre5sfVS41xzmqc+hSKu3Nup136Adkvx0cElcVYNaqFo7nEbKcR7HyWCiE4Wk66+7V5eAcbGJUwEreANOUfDltPdifz2EkeqZ8vvNapXy4zMhUGleM/RJzgX84Ej0rCr0cK8hz5fYtnj2AsigxFhH5cGQbzrY0/LKa/WZw14la1V/1vhHvJVLk9Jh60WlGFS2T5QUDHRolIp33Tn9N4wSBTjNETMOydcaCuFrP0yKpPqlAuORjG2UF3DUuz61sDE5KBwwy/pDCmn9oB8/LilJ2y7c+sFBNgzDl+Tikqp55FCaHnq4AQBfyeudndyMb6BjZKNUcaynTkUT86jFG3QMUSpfC7/HGnlwzYHsIH6Gpj4gMLHDEGV/iu/V/zJ2Ya6kLPs3boGjnpELQ0NltJWtulKQSB1AxFL6UT/kQIDfHMzEdchPEw0yQCohsPIXmstnc81gcCd786tBiqMkE8zJSYaOyESdM4LbTq4w3dYdPvP1AmI/R/+kwV2HX3rO+7VzWKvE/+02vgIICIrWc43OW+oa9uvDak1hhOtMkTe2Gc+NvTwnLeMjo7fHQmrDCnrbn2mNNUYwaNAnTmWvLbTKc2DQEsTIW54z2Zn6BvAcT3asFcJ2jFCfaXnvrAH3eCxomJSWGXLd3z1AGRP0y/dFWAtj++U4Duh6taO1clw7VwEsoBkS4B4G2xKbZw5wpLAksOXFO1JyQ/jwJfEXghFTidboq+UrDAlvnbzQncmHJWm1w8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(7696005)(26005)(70206006)(5660300002)(356005)(186003)(8936002)(2906002)(83380400001)(110136005)(70586007)(336012)(2616005)(6666004)(1076003)(47076005)(508600001)(81166007)(316002)(8676002)(6636002)(4326008)(86362001)(36860700001)(40460700001)(36756003)(16526019)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 11:35:45.1451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3720ff6-39d9-4173-d11c-08d9c08832ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2884
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

Add a reset parameter for umc page retirement, let user decide whether
call gpu reset in umc page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  5 +++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 6e4bea012ea4..0c33f367a4e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -23,6 +23,13 @@
 
 #include "amdgpu_ras.h"
 
+static int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+		void *ras_error_status,
+		struct amdgpu_iv_entry *entry)
+{
+	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
+}
+
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -88,9 +95,10 @@ void amdgpu_umc_ras_fini(struct amdgpu_device *adev)
 	}
 }
 
-int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 		void *ras_error_status,
-		struct amdgpu_iv_entry *entry)
+		struct amdgpu_iv_entry *entry,
+		bool reset)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -164,7 +172,8 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 				adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
 		}
 
-		amdgpu_ras_reset_gpu(adev);
+		if (reset)
+			amdgpu_ras_reset_gpu(adev);
 	}
 
 	kfree(err_data->err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 9e40bade0a68..8d18d5121f66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -78,9 +78,10 @@ struct amdgpu_umc {
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_umc_ras_fini(struct amdgpu_device *adev);
-int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 		void *ras_error_status,
-		struct amdgpu_iv_entry *entry);
+		struct amdgpu_iv_entry *entry,
+		bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
-- 
2.17.1

