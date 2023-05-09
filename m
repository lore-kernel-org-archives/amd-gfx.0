Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C96FC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F17910E3EF;
	Tue,  9 May 2023 22:14:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BCC10E3ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZSFW3dp9kXRW+9d/+4ZZdb34T9XOsaJqt+8Fh9xEz7HRDcPeLKbVuiMY2uWoGWiNossW2sD85US9qPwz/nitMKdhm7wT6y2lHQOtLGIMvQgyHykL7Z9IkUNJt5ECE/fmNGrDNvT3VPMCH+UZQ7Eb3leWaABS4Y3zLMye9EFONYJgKVcTyeDhsXp0kaMcQyC3ehkzuf5+ZyKeCu/BPLi93Xo5qnGPNQmGUj/DyOG+4e8MWfICvuJQKz23ssHbwFHaq5X0LhtokLVS6HELygDcKYpBIb+GQYgtMB0ea0LE5iwyLErFyxA7Vzz2SI9WblTj/YxAd3KJ2sK5Klxl1Jinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztRfLz6/elCM4v2g7EGT9VoBaO9gp95LRd5X0+HyI1s=;
 b=mibfClX6TcyQUuV+2zluPC7DRJqQON7JJ4EvvC2vwCDTteCNFrj5OnLpm5p5EYw+lhUpJ7/QYvtMt6AB3MCb7ouWOgLkE2CXlcXm87o/GfO6gVMwny+uy9cK/3r8tSvsZ7xf2snoD2GE/qUJx2EG/SKbAZ5SqGLPHNUHcqmp/BqcyPhxnqP/U9N3O0TMxgz7z9s+kz30tQ6jV1crq+H1XR3wJqOS+J3GkjJbc4SCeE+pdvD7FUvJOptn+SrZw/VR+TUIGLInSAW4oDdwZuUunhRQb7TS00Y1NR2AMvSuSmfNWMtC8Ob6qeKvGDYTNsi7P8QJhpPRdAptgXsx8NEZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztRfLz6/elCM4v2g7EGT9VoBaO9gp95LRd5X0+HyI1s=;
 b=D+PimQS6/FXiVEKUsnm98L9APNjmQQ+hXmDXpTLitSKJA7knqEcU8bFuBpTxk5j5jORgzk416WeVk8RnYSBi8j6klo8TslH658KD1r7rqw2yWnYqjlYIbFd+XAqQ5kEFIldL/JB98m448ErpSwT4d1IdOe+ueHQjgMq9Wx54ho8=
Received: from BN9PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:fb::26)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:14:31 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::4b) by BN9PR03CA0051.outlook.office365.com
 (2603:10b6:408:fb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amdgpu: Add auto mode for compute partition
Date: Tue, 9 May 2023 18:14:08 -0400
Message-ID: <20230509221408.476829-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 262b8824-109c-4117-0405-08db50dac328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BSl1T5UPnjHEUpfPwX5oX5srT7yMKGNJJARv4C1Y5/7kz0deo414VQYVhx/AKhxQ6H0joLgECVYJgw5QjhLCtICg6mv/YJk+g51z7Qw6un8nig1OVpctCXNUECEf+ytKDAD9tpcMruK8i3E8AHeZfmpTB2a/kRlWMOkOe3nqSUvAAI2pTWw2/BKlFTTjgmi4rqFIY9kCTcqSki5sW8F0SZgd3zSGnTapDUZPTfYvnEzhfP/m/JwgMTx3ggjzwJpBeZ600qIdhdnrMM7e7/slHvpmNOTgqxqf6viVg2IcZ0JCyvisZp/0FYyOsE0i3PRzXSR9MnHnqFbA/Xui9KzWnxRv93Aoe1JlAJcZMUaTKKPtAFVRzTdMP7IKs5h1HqUiEl9XlopBzB97uMiYJD/Dbmxgumr5spWp9cj0iaa1xpyhQCIB+cK1pa8xZcaGSf+YlWZRMkNqJmymx/F5QnbF7gbuJXya06fuibfZoRarxYZ2v4JMRCELhpJmfDWHZqYiYTY85pZEa6lYZEe5C7EEkbOHdy+0IBywGsS14vwcws4Weci872jUA+ndNNZj9cqy/RFe7oAu/QSLhLUFSQoAG8ZYOmla7ov2CYR4RFujn4zmMCHoUZBE8rwaE57MAjzpPjBBJahwe5kSeo5ELpF84siYXZu/myQHZdYXziyxpV/CD/eFUptDr3tgLHVRN7tcuPHqwiYAh6sSEg+3rA3lD53BLRk/IfhohGU6WXcsxh5olayP7bw4LkMEzThmvBJKKA7R9vz6TTlYaVFCLCOJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(2616005)(83380400001)(47076005)(336012)(426003)(36860700001)(6666004)(40480700001)(1076003)(26005)(7696005)(86362001)(81166007)(356005)(316002)(82740400003)(54906003)(4326008)(70586007)(6916009)(70206006)(16526019)(186003)(41300700001)(8676002)(8936002)(5660300002)(2906002)(40460700003)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:31.0016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262b8824-109c-4117-0405-08db50dac328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Philip Yang <philip.yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

When auto mode is specified, driver will choose the right compute
partition mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  2 ++
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 28 ++++++++++++++++++-
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4ecaff14f2b3..9904ce78b8fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -243,7 +243,7 @@ extern int amdgpu_num_kcq;
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
 
-extern uint amdgpu_user_partt_mode;
+extern int amdgpu_user_partt_mode;
 
 extern int gart_ram_alloc;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 39975724be73..e4d09bf0887d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -194,7 +194,7 @@ int amdgpu_smartshift_bias;
 int amdgpu_use_xgmi_p2p = 1;
 int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
-uint amdgpu_user_partt_mode;
+int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -964,8 +964,10 @@ module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
  * DOC: partition_mode (int)
  * Used to override the default SPX mode.
  */
-MODULE_PARM_DESC(user_partt_mode,
-	"specify partition mode to be used (0 = AMDGPU_SPX_PARTITION_MODE(default value), \
+MODULE_PARM_DESC(
+	user_partt_mode,
+	"specify partition mode to be used (-2 = AMDGPU_AUTO_COMPUTE_PARTITION_MODE(default value) \
+						0 = AMDGPU_SPX_PARTITION_MODE, \
 						1 = AMDGPU_DPX_PARTITION_MODE, \
 						2 = AMDGPU_TPX_PARTITION_MODE, \
 						3 = AMDGPU_QPX_PARTITION_MODE, \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 728977f8afe7..e9c93f6e12b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -62,6 +62,8 @@ enum amdgpu_gfx_partition {
 	AMDGPU_QPX_PARTITION_MODE = 3,
 	AMDGPU_CPX_PARTITION_MODE = 4,
 	AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE = -1,
+	/* Automatically choose the right mode */
+	AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
 };
 
 #define NUM_XCC(x) hweight16(x)
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 7469de3fd6fe..a165b51e9e58 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -235,6 +235,30 @@ int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 	return 0;
 }
 
+static enum amdgpu_gfx_partition
+__aqua_vanjaram_get_auto_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int num_xcc;
+
+	num_xcc = NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+
+	if (adev->gmc.num_mem_partitions == 1)
+		return AMDGPU_SPX_PARTITION_MODE;
+
+	if (adev->gmc.num_mem_partitions == num_xcc)
+		return AMDGPU_CPX_PARTITION_MODE;
+
+	if (adev->gmc.num_mem_partitions == num_xcc / 2)
+		return (adev->flags & AMD_IS_APU) ? AMDGPU_TPX_PARTITION_MODE :
+						    AMDGPU_QPX_PARTITION_MODE;
+
+	if (adev->gmc.num_mem_partitions == 2 && !(adev->flags & AMD_IS_APU))
+		return AMDGPU_DPX_PARTITION_MODE;
+
+	return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+}
+
 static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 					  enum amdgpu_gfx_partition mode)
 {
@@ -304,7 +328,9 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	adev = xcp_mgr->adev;
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode))
+	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE)
+		mode = __aqua_vanjaram_get_auto_mode(xcp_mgr);
+	else if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode))
 		return -EINVAL;
 
 	if (adev->kfd.init_complete)
-- 
2.40.1

