Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27050C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 07:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA9610E36C;
	Mon, 13 Dec 2021 07:20:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A7B10E34D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 07:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGmyi61PVMCVUExHcodYf+jNiOkOGsI++XmDTViuviVOoj7wvgEmm/9IyUS5UVskvO7JSYWHeZBLr0iEumFQcqhR9wkuK1yknvRURsUgMP04rY7YtDp4u12h9WhUhxHaVpOZ8LVYBWbBdlR07IbV/z60HXezHiFpYagy9EKHIfAVWAXL29K2TZlkh0qk0NC089Jm1weScifFbl/9XRHySg85vT/Gpvp+D/BRLzTBhuYAs5pUSG0cPYgRdZTkO4ymIrejQ+P3m4WbkNuGb01wpBslDa3JDF5RxeCeJtRJcGBQtUnQRCtkzNKA+kPu98z/cnC+gbkt2C/Jfgbg5yEkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jvx4a1RWIamBIPfwZi05n5avFRSIQu/LZLB3rE03yJE=;
 b=NRa8+THRn/rqYRvOSJIo27Sd05WS6zJA8H+kJVJkMxzpS98EnwYh9MckcaE+Y7/cfLYHQKK/f/Scodc7UhPmCn+Vx504J2Ji9B3JU9vsJT1aqEoGYFZqKyfrPXKtIPqosZtdC+DjcwR7eQgzT1EriBwZLjY4apQUy2ZvqxcHxvXuwl1uYWkYytC0YeJXKGN95/Tz6f7o8sYL71ev+iM+co4BfphirbZ6pp8nnlSRhL9nDLatkb0vU68yOlRG0NHIsfn76B6upnTDEkXy/PTYFKYC8bA1ac8iktCDuyuzQxYK2h+7HH4myzrcPZMWXfByCB15UBaaLXD+EpnFIboRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvx4a1RWIamBIPfwZi05n5avFRSIQu/LZLB3rE03yJE=;
 b=XWpO0bOtNqFWEhSf1GNehnQ03OSXIuD5dROFvQwUzFmTiSWnu5uKG8Yb2FiaVxC5KCZwLNLhf02EQedn478k3nBUZJZLoVpIv5/+PwWZxh9JlhmdtWepmwLssxdh7E5GYQXrHoRZA8VAh+BAcfrS4lf2Q1rF5ktCNSwXkyGItgo=
Received: from BN6PR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:405:4b::21) by DM5PR12MB1641.namprd12.prod.outlook.com
 (2603:10b6:4:10::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 07:20:23 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::c4) by BN6PR1401CA0011.outlook.office365.com
 (2603:10b6:405:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Mon, 13 Dec 2021 07:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 07:20:22 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 01:20:13 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu: move smu_debug_mask to a more proper place
Date: Mon, 13 Dec 2021 15:19:59 +0800
Message-ID: <20211213071959.793698-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ed9733-fe08-4ba1-c70b-08d9be0906b6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1641E6FF367F8DF03D6122CBE4749@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jq+CSqVlOYnm/MYDymZZ8WNdfi/C/64YpUxSaBgcTR5CuPegxBDbkJHRn+Jjkok8WW0+rnu038i01Que4nFMjVJjTEXpxUQUTnIKCvVj5zdy5petEZC/5A8kyak8lgjCwh4+FXMc6LntS2u+8Wv62ab3l5UNMI3yZgPBLdveG64qrcWQyrcbPlaKNHqnHqlRiIInD09zxsJyRNDcAlDsyIKoNlNNMw859YoXHEGhLqfLHbjGjCnGXEbtIYb2lxYCdmR/yaPSzAMMtv1dGVKI8O5lzHnB3ES5GhB7A7zF99aZg4woChNxit6j81ynV3AbuaWMwsHDFFaZEeR7xLefkcnT7exrjkD2os7RHjkLsQHfpRx3wRcD9rV1NhEU+qVHrCZQ41Xw1td5YuaJUblSm5N73ijMdUH4UUBdDf0fKODXzto92JaDyuMlzMPWunDorRAc1i1LSh5RW4SAb+Jp+LsgdRsK74zBWtuDNYoM09DJ4sRVMjVWYLGjp5cqD595lNw7g5s/e8xBoB+Hdst4j+8bKiICZHPvNl3ANfPNgmlk7iQ8RlmN1MNG6mbIazvnesP2H+XCw6TpRHmNeqF8VaN8jVqoVY+dUOKJkwkVYlCmHyZmUeevIylhe5HyHqIs2pMCX0AWpV76X1ACMBDKd0LYXj6uib+bV5O2d8f/CXrlLFo5Wg6hi27PxzhDsCuryFVttqyxaueNgplEtJMe2zFnN6f77BX0F7pcmtlCiFInQgAlIN/z/fKri/s3HXMVev6Odwkky9LaXKSspSU8q5f4ozPTdFHbMV4fHJynits=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(70206006)(6916009)(8676002)(2906002)(70586007)(6666004)(2616005)(81166007)(40460700001)(36756003)(4326008)(86362001)(82310400004)(36860700001)(1076003)(8936002)(47076005)(26005)(186003)(16526019)(54906003)(44832011)(7696005)(316002)(83380400001)(426003)(356005)(508600001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 07:20:22.5831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ed9733-fe08-4ba1-c70b-08d9be0906b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the smu_context will be invisible from outside(of power). Also,
the smu_debug_mask can be shared around all power code instead of
some specific framework(swSMU) only.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I1a0e1a436a51fc520a47b3fb28cde527d4e5eb6e
--
v1->v2:
  - drop non-necessary intermediate adev(Guchun)
  - move smu_debug_mask inside struct amdgpu_pm(Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h     |  8 ++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  8 --------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 16 +++++++++-------
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 9dfccb20fedd..25e2e5bf90eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1619,7 +1619,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return 0;
 
 	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
-			   &adev->smu.smu_debug_mask);
+			   &adev->pm.smu_debug_mask);
 
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 16e3f72d31b9..c464a045000d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -423,6 +423,9 @@ enum ip_power_state {
 	POWER_STATE_OFF,
 };
 
+/* Used to mask smu debug modes */
+#define SMU_DEBUG_HALT_ON_ERROR		0x1
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -460,6 +463,11 @@ struct amdgpu_pm {
 	struct list_head	pm_attr_list;
 
 	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
+
+	/*
+	 * 0 = disabled (default), otherwise enable corresponding debug mode
+	 */
+	uint32_t		smu_debug_mask;
 };
 
 #define R600_SSTU_DFLT                               0
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 12e67ad9a3b2..2b9b9a7ba97a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -482,9 +482,6 @@ struct stb_context {
 
 #define WORKLOAD_POLICY_MAX 7
 
-/* Used to mask smu debug modes */
-#define SMU_DEBUG_HALT_ON_ERROR		0x1
-
 struct smu_context
 {
 	struct amdgpu_device            *adev;
@@ -573,11 +570,6 @@ struct smu_context
 	struct smu_user_dpm_profile user_dpm_profile;
 
 	struct stb_context stb_context;
-
-	/*
-	 * 0 = disabled (default), otherwise enable corresponding debug mode
-	 */
-	uint32_t smu_debug_mask;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 43637d55fe29..735e1a1e365d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -257,10 +257,11 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 				     uint16_t msg_index,
 				     uint32_t param)
 {
+	struct amdgpu_device *adev = smu->adev;
 	u32 reg;
 	int res;
 
-	if (smu->adev->no_hw_access)
+	if (adev->no_hw_access)
 		return 0;
 
 	reg = __smu_cmn_poll_stat(smu);
@@ -272,9 +273,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res = 0;
 Out:
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res != -ETIME)) {
-		amdgpu_device_halt(smu->adev);
+		amdgpu_device_halt(adev);
 		WARN_ON(1);
 	}
 
@@ -299,7 +300,7 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
 
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res != -ETIME)) {
 		amdgpu_device_halt(smu->adev);
 		WARN_ON(1);
@@ -343,10 +344,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int res, index;
 	u32 reg;
 
-	if (smu->adev->no_hw_access)
+	if (adev->no_hw_access)
 		return 0;
 
 	index = smu_cmn_to_asic_specific_index(smu,
@@ -372,8 +374,8 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 Out:
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
-		amdgpu_device_halt(smu->adev);
+	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
+		amdgpu_device_halt(adev);
 		WARN_ON(1);
 	}
 
-- 
2.29.0

