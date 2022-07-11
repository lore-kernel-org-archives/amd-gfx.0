Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AA2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 13:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE15918AC19;
	Mon, 11 Jul 2022 13:58:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCDF11AD1D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 13:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TayN6oulJ7Tdn8xqdawi0ZpJkSfScn3oAZMvkL6zO4FG3vmsjB6yZ7ukbtriX4Il15CImbZBy3k76Rt2dSCk/m3oDPIf6nNANHuicc/qrywa4zGJAG2bx3UNQQYR7TSSxZP+cg9hYUzUbZhnYK73CFa3lAPRmiusxRg0WhhGffE3K0ZWdl7xDwcpHEWfoT4FX5slVW3iQhy664Xp2yFQNEi5t/GF5tOdCX857+YCunUA8AbblgWI6/S5vnuJWD7AleD/lJtkgeEB+OdDGhv1LtYv8MXEAr++55M/vEwJJX+ZLXvJkXtFSo0j/5WnBaR3bktxXAGmWfqsnnJlVlcEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho3HkP4zUCcLpKP0Psq/lP7Jrb5fGukYIDvyDpulA1I=;
 b=MzMfYxKgFTJekjxZ6qx96IepqhsU0xTjKdZFim7maZJvWVqYVNdHwtPZ/CkNxBUFyCRwMctrsP1Q0ilmuHJnvp8BVBA1SYXTaqz/RtyFWevK36wUgRITDXKWgFs6pflaKxXcjHQwaER6GZzQEhoBxRPQ5XrAYQOCQhHFzc6IaTVvF7/htHQM90w6ycuAVKNUp5eWkT6eZMuXB7ac07Vfbg05J6igQN0U/WcghwapEkbXtcgT/K6nFfN1KFWJ9cXtRCX7FgcORkqWwPIU7Dps06iO2Zf/LwYAfE5nkdnbCHbxKSR/2BgYGq4QuydqW1smrQG01gTRTNDjxboOF+Blew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho3HkP4zUCcLpKP0Psq/lP7Jrb5fGukYIDvyDpulA1I=;
 b=sYDo2HGDNFF9MD6Oupm9igZlLaThc+QBfHHOYAz17/mqtrZS6jWPwqYQVGirZx95zEro9a6PnbbgHYvr/tkAE4Sd/pQlPXKeAdkD/kdKTUwKL1Cg97GkfVu1Nm+fCyV+zP9pW7QnryBrrkOEY1GpURH/7ULDVOmtQFoqrFadxoA=
Received: from CO2PR18CA0066.namprd18.prod.outlook.com (2603:10b6:104:2::34)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Mon, 11 Jul
 2022 13:58:25 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::b) by CO2PR18CA0066.outlook.office365.com
 (2603:10b6:104:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Mon, 11 Jul 2022 13:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 13:58:24 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 11 Jul 2022 08:58:21 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: use cached SMU feature mask in runpm
Date: Mon, 11 Jul 2022 21:58:08 +0800
Message-ID: <20220711135808.11949-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5058570f-35f8-4c2c-d1c0-08da63456c56
X-MS-TrafficTypeDiagnostic: IA1PR12MB6355:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pW3Dd8R6AVXg9CGh7aiIquLYKAdfhCiR2tuMwD57e7yrrqst71hnbugEP+cAh7Sk3Rvr9LwVXx/4KUM3J4qIsAUSo3N/HcfvDInbsfeh3mvrgXcjGFdDW4oYBidTwN8E/5lKxiAfHI2C0e5nEElrNEjim5WxFB17j7qrH4cJGaIkl+5IY3nkZOUDjTnpZ/+gmrhNWoMGjazQ67Xz4eeTFeInTijLCLCwcpiHIEuFsJQKlcTMecbup3e2LhTqklqPuCPDJK1PIIiQ77cPAz5CmmUG3tnNlU2d4BzaceqzZRN0vvlRALt888NK4fHRSD59ZFG1nmBNT6OgJqYZD82y+timibX5d6bY6PP5FHBoi5ulqYJT6epbIiJRcGhagExGVXytN2kAT0kENqrZxWeq2br/7gob5Ffs3aqjmql9QJHKhcSFntC8h1ClkWNU5ZQbl8VQQxP+ppM6yIkGZliyLSdqmqZXA0uqEKxzmQPyOw+rBP+xOv/iaSxnTuoGgD6RoMIuklEZ3+/bHYhsrG2yar3C96hHTSbptu57VqIwTJRKGWp0BwHYiWmW7qTCTjJliaIpBHDdqFjkli0l0NcjfxhT5aX3fyc67iG3Qtit356ZiWWZU0IFEjH9+Ffpf5eNkybfGTWUlJ9wvJKOFGVUemsgzFsxJ1jnR+7Ga5/m0mkhHGp8tnf8aZwaZ7uEJ4czGah/x1olEOp6l0Fxw6U2iKaUVjBOlGrv7Hy+N4uORZ/lQnE2PAFay+o6+iSTm0AEI/2tSZHMqlbj6vf8ChNbJ19/9DacRozPiUH6CPcP0rPnXU4DlbIa1wm9dqMJ7GQHjehnds1QY5ARsq8tLMeG5HTftXv2SenyMdrcxPKcGD6ezKs2toNE/UqPUjOcZ2d2RKALqsPIJeQ11onE51c86A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(40470700004)(47076005)(110136005)(70206006)(83380400001)(186003)(41300700001)(336012)(6636002)(40480700001)(426003)(6666004)(82310400005)(316002)(478600001)(26005)(4326008)(5660300002)(1076003)(86362001)(8676002)(36756003)(7696005)(81166007)(2906002)(70586007)(356005)(2616005)(8936002)(44832011)(16526019)(40460700003)(36860700001)(82740400003)(34020700004)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 13:58:24.6150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5058570f-35f8-4c2c-d1c0-08da63456c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU will perform dpm disablement when entering BACO,
and enable them later on, so talking to SMU to get
enabled features in runpm cycle as BACO support check
is not reliable. Hence, use a cached value to fix it.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 4 ++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 9 +++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 5 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 8 +++++++-
 6 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1cc9260e75de..dc2e78bb7224 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2478,6 +2478,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
+
+	/* cache SMU feature mask */
+	amdgpu_dpm_set_cached_feature_mask(adev);
+
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 956b6ce81c84..211f73a987d6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1702,3 +1702,12 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+void amdgpu_dpm_set_cached_feature_mask(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	mutex_lock(&adev->pm.mutex);
+	smu_set_cached_enabled_mask(smu);
+	mutex_unlock(&adev->pm.mutex);
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 524fb09437e5..e9c002a561c2 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -543,4 +543,5 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states);
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table);
+void amdgpu_dpm_set_cached_feature_mask(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fd79b213fab4..e8ead58a00b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3130,3 +3130,8 @@ int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
 
 	return ret;
 }
+
+void smu_set_cached_enabled_mask(struct smu_context *smu)
+{
+	smu_feature_get_enabled_mask(smu, &smu->cache_enabled_mask);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b81c657c7386..678123b5e2bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -568,6 +568,8 @@ struct smu_context
 	u32 param_reg;
 	u32 msg_reg;
 	u32 resp_reg;
+
+	uint64_t cache_enabled_mask;
 };
 
 struct i2c_adapter;
@@ -1465,5 +1467,6 @@ int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
 void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
+void smu_set_cached_enabled_mask(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 15e4298c7cc8..b3087085622a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -499,7 +499,13 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	uint64_t enabled_features;
 	int feature_id;
 
-	if (__smu_get_enabled_features(smu, &enabled_features)) {
+	/* SMU will perform dpm disablement when entering BACO, and enable
+	 * them later on, so talking to SMU to get enabled features in runpm
+	 * stage is not reliable. Use a cache value for this instead to fix it.
+	 */
+	if (adev->in_runpm) {
+		enabled_features = smu->cache_enabled_mask;
+	} else if (__smu_get_enabled_features(smu, &enabled_features)) {
 		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
 		return 0;
 	}
-- 
2.17.1

