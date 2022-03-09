Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5A4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 21:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F92710E46C;
	Wed,  9 Mar 2022 21:03:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5762110E464
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 21:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe7yqgHoFU07T5S01wnWQOl+cJFWOBQVkcTwbDHvpPPGU8Jj3SHIeFW4er5FUCmXSx9zJoMgXQYiBaZNpPa4ukeJ4c5ag/IuJnlxSzjXeiBrG2AWx79noGPVtHVoKjo7YaSjTb2DbXdSC+zOYJiAZYTp2lXEV29VWJSlVr9shlvqmcY2XDiZdaitadtT8L4dZVM4OAY5zXGqDdkA1TwjbmKSEx8WcxXTTXAH3gH3krmymBUr+vCyw1NaFVG+8kVpSAz4SGjSrRLkp8RM+nLYx3jXXGou3mroX8BMzkJRpUv2l0jMoVwQ/H4TMSNx8E6QChVTwCL0tUPu/lqcohyeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJReVcjue5KT0TtoKbegvkk+LyksyPHV2oaDgX/ivCM=;
 b=cKola60fwVaEevkFkU36YXJ+zvZWMK83G7Ts0Pk3JEweMHTOXJNG2ds/64e9p1W6uHt4ra6qtn2hf1sP1AeCkb73eC9qkpQLna/BQLDGbYuSVn5JNmbeb6+asNpQQzi3dUFX1hdT+kzOWrS8rFQK7TWu1BzqV75s8gQN+qXCF2Iyym8nd7c6iBi73UpI/cxu0Q+soiozcEhmsAhuRi4bCVzdnKtM1FS010rswkb93doh2i+qP6qj5axkVtHtrljG4xcBLyWVUbL94wKWoIIq1tKOcvfaZcO8oF296Y+yJOPEeCr1hnMqOJMTNhIlE5yFjL37jqgzl8ETP3w2F9iaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJReVcjue5KT0TtoKbegvkk+LyksyPHV2oaDgX/ivCM=;
 b=3EvdWSQtNhXs8MVHegC7TPwvv4FO544ZNNPE8cF/EnIUmqDGX5N7Ts3quOsbMcYppb50eA6qsIErFPSzr8hYnvTGwLCvk7N0Y3qM9R4V4ArTu62ab/eZ3/TSiK6LLwHwoJvBeB0gAOS+E2bF0I15KuI5HMRCJ9iX8jlcnKsHxoY=
Received: from BN6PR19CA0065.namprd19.prod.outlook.com (2603:10b6:404:e3::27)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 21:03:52 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::f3) by BN6PR19CA0065.outlook.office365.com
 (2603:10b6:404:e3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29 via Frontend
 Transport; Wed, 9 Mar 2022 21:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 21:03:52 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 9 Mar 2022 15:03:50 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Add STB dump function.
Date: Wed, 9 Mar 2022 16:03:29 -0500
Message-ID: <20220309210330.576809-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f493c4b-dca1-4dca-ae0a-08da021050f7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4331:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43312928708761BC922C24AEEA0A9@DM6PR12MB4331.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTHhqTUfkR1/tq8eE7NMVVtZVXQnpq/e83YclfYlM8/Ubf/waadnu86NxPUw+YtG4Lbc430lcsC86llPbLBNEEOQ6v874UDxMu/I8LIf4r//MwXESLtQBJoVPZFxS3uPqy8tAgZPgGnSCVA57Z/wcp5Xjzz0AM1cEs2fUE2Krro2Yb5T7QuR6fwvEANaT/0ORyb42qFN5MeMdnZ5ZjstBEhvAXvURNZGHzL1SjKvx04lMuZLuBoMvFiX8wVypHZ/wpPp3hAzTzo+/gwBTyXRXvQVFs+/qqRKeQ6AVSucKYmSREABmAY693Vn1W0o0dkJrfg8bgFrxVYamM80ZecXj/Kb8+mbzEIe+3KiFxn6LsoirnbQc/YT6ueGHXY1IUrzMroUUIOh76WsI7AB/b1Z8Obt9todX0uTvBA6FhjhcLD82yptoA8ulFlrr3m3R0y/2haC0FrzmSGqlAIQ7pe3Zbplr4799AxVPwfInwVAYufaucEvN73DJjVBzpfo0MrPyVmUfEvZBheZsOT3bNwfRbsZ0zPpCZgABdWBHQMqOENO1m4Z0FvBqeFuXui09FymLyCh/PP/1RxQv9uQEv07IUXS5h6DY3YjczvvDYd2cGHQpwW3Q/kXjsmY0dIhcdBP6yX2MDfCELvqAlUNfaSmVk1Z1qPuhP5trIY1go8hyJgRryV1GYtri+0+QVAMZCLPbdpwyiSwqZqv7UDAH2mL7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(186003)(47076005)(36860700001)(40460700003)(336012)(36756003)(70206006)(16526019)(426003)(2906002)(44832011)(1076003)(2616005)(54906003)(83380400001)(316002)(6916009)(5660300002)(356005)(8936002)(508600001)(81166007)(82310400004)(70586007)(7696005)(86362001)(4326008)(8676002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:03:52.4675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f493c4b-dca1-4dca-ae0a-08da021050f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Amaranath.Somalapuram@amd.com, Christian.Koenig@amd.com,
 Shashank.Sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It will be used during GPU reset.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 10 +++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 26 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
 4 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1d63f1e8884c..815a6367d834 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1327,6 +1327,16 @@ void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
 	amdgpu_smu_stb_debug_fs_init(adev);
 }
 
+void amdgpu_dpm_stb_dump(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	if (!is_support_sw_smu(adev))
+		return;
+
+	smu_stb_dump(smu);
+}
+
 int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
 					    const struct amd_pp_display_configuration *input)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ddfa55b59d02..99351d463a72 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -503,6 +503,7 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 			    size_t size);
 int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev);
 void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev);
+void amdgpu_dpm_stb_dump(struct amdgpu_device *adev);
 int amdgpu_dpm_display_configuration_change(struct amdgpu_device *adev,
 					    const struct amd_pp_display_configuration *input);
 int amdgpu_dpm_get_clock_by_type(struct amdgpu_device *adev,
@@ -540,4 +541,6 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states);
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table);
+
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7e79a67bb8ef..aff0ed9b6f9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2958,6 +2958,32 @@ int smu_stb_collect_info(struct smu_context *smu, void *buf, uint32_t size)
 	return smu->ppt_funcs->stb_collect_info(smu, buf, size);
 }
 
+void smu_stb_dump(struct smu_context *smu)
+{
+	unsigned char *buf;
+
+	/* STB is disabled */
+	if (!drm_debug_enabled(DRM_UT_DRIVER) || !smu->stb_context.enabled)
+		return;
+
+	buf = kvmalloc_array(smu->stb_context.stb_buf_size, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return;
+
+	if (smu_stb_collect_info(smu, buf, smu->stb_context.stb_buf_size))
+		goto out;
+
+	DRM_DEV_DEBUG_DRIVER(smu->adev->dev, "START PRINT STB DUMP");
+	print_hex_dump(KERN_INFO, "data: ", DUMP_PREFIX_NONE,
+		       4, 4, buf, smu->stb_context.stb_buf_size, false);
+	DRM_DEV_DEBUG_DRIVER(smu->adev->dev, "END PRINT STB DUMP");
+
+	return;
+
+out:
+	kvfree(buf);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int smu_stb_debugfs_open(struct inode *inode, struct file *filp)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fbef3ab8d487..991586f61a85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1426,6 +1426,8 @@ int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 		       uint64_t event_arg);
 int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
 int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
+void smu_stb_dump(struct smu_context *smu);
+
 void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 #endif
-- 
2.25.1

