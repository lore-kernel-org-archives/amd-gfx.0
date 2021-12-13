Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02293C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 05:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C08010EA81;
	Mon, 13 Dec 2021 05:43:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7B110EAC8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 05:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmYXcUZW0mF1zdvZLzWcWUShUD77ItwkE8oVUbj1Y0nmMEoJptXkJU6I9aBdGlme6d5z38UCzQJyU79gfRrcDxZkZDnqafp8XtU5BF/jdcQVihwZEXqBFpEaq0BfMzQfreiMH8MnMEV3ROjb1Js3eyPfcFpGjtedGV+akVrGdKBvCtewp4IfrCagH6w5FrD/qtoaPsFq60MV+qOlaBrzfqxx4Descf1I56hmCzVaN8Ic4OxcYSLSyjZaA5NmbfOSBUwvPB3Nsq114pk5ppnOnllw8W8R7NxWj9St81gZ+r3UPwz4pBwkc7Ziedjrtfstk8szSbJ6P4tgpYAGkhEO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ljiqa2x0OLxQ+QqGAQDFxHdgJXV2L6RUO6N7dWRQPU=;
 b=EvJhaSjKPxNM1Y8GXwUu3iH1pAVnsxpT2bSEAeIfSLUkOB/fIefO3tkc05Qzp1cKcH2AsYA6zRFwjRWW6pE3KopRZtj5TVhxj7Ch8K2dmtaTnbTaM92C0vV9/tHOAYlXuQ3YvfnhE2uaCZ79/znMj6+BydyotcNaCD5IVBzdvIOAG2yD+BnUnlaO5nEVjJC0ivOJAySD849wp+ZERp9Tfi8VYdXmb/EQ//pzDxIGjl9ipq4dxZUMQdowySfP19J8IdcS0MMBYTm7kIfMf55Bz858ngxe1AMRv/Iyj7nzzbp+2s+E+eyTJS10eZMcBU9YZqc1fOFvuhumRlpmXl5zIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ljiqa2x0OLxQ+QqGAQDFxHdgJXV2L6RUO6N7dWRQPU=;
 b=VB/1NoPqF+BqLS2GhsJ1LZX992Y1c+Cql+r/8ZnLO1/Kl1d4b92KySVJ+AT94NUBA4nN2ka5NQgD0e/E214PYmdWeWWltSXln8JO4PuERSOd8yNh4GEU1XdZTGQ5xUk/PQhI1lq4q119OxwP1PgDAV1OHaOo7WGWzBLB7J90ZYY=
Received: from DM6PR07CA0110.namprd07.prod.outlook.com (2603:10b6:5:330::26)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 05:42:58 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::aa) by DM6PR07CA0110.outlook.office365.com
 (2603:10b6:5:330::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Mon, 13 Dec 2021 05:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 05:42:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 23:42:55 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move smu_debug_mask to a more proper place
Date: Mon, 13 Dec 2021 13:42:41 +0800
Message-ID: <20211213054241.773719-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d60367-1a6e-4ec9-ef64-08d9bdfb6b16
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4973E602C3DEC61BA7FBF35CE4749@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1aNE25TYhEcl26FKWbRuX9qNNjpOGPS/GCS0JODk+0CgaXYHNcWO8W3EtceigM5vaMBXfDNR6F22UiCmbjrnJwaqRtwPH0xjF1nuJCLmRhhkd1rU4LwU4VswPnBKnaMrYXiUyJ3tfQgLIjnMKLRq8HyLH4rDos6KW2Z5hCL5zdfEd6O8YT4uA3RYy+pGaS9h2TfPilYGflb/zkN2hPd+8nM07dDtOz0w+jqouzZyEkyBqz6V2I5yNqMoBGpmJOdcs0G5ZsajCuxeCdJ1rO9XLgBBx14Ll+WzB1c9glv5tfLOGFgmVEM/q+EsAqPj583/5FDbURt2n+9wha66j5BaEIWM0yNaGKSaCco5ELvgAZqrSUtjOvT5lHYYi2R3ei+9x6V0M9V8vGnEBs9sCZD8IEkaHHe5sst8kg50MkwSHi8f8737a0zuMHZSgMbjMq+TXPedjzXvzzW9MhSbwM17EHxwwu81+eTUueGnNhYgdbo2HWg1svn5KecKcM9qwbHF4tPeOzWUkq1+lU2p/qo3ykvTPitRTBSvuV9pXeJuoIAwkrIDJQbOIJDBEQfwp7Zds/cxHfGs+XihVdXyKVDaPHhBub5pg8XzL8LJF99XBSzNJKMGtkL7ji1WkM1OwOYAV0Enu7gDF4U3lliZx5+krO2llu/1C7NW7b1GSwpwHxuV9kDC4uIiTMD3/AP7Pkjzojm6/T/byi//uf//EbtDIY2TTDWV1EOzCBrPEUCfsDg50WMNmAOe2WXCqXRap6bxFzHcTbp6hrsAi+gmOkC6rlIcOOd1sszuxO0b/q8L+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(81166007)(316002)(2906002)(82310400004)(356005)(8936002)(86362001)(40460700001)(26005)(6916009)(47076005)(16526019)(1076003)(54906003)(36756003)(8676002)(70206006)(426003)(336012)(7696005)(70586007)(5660300002)(44832011)(508600001)(6666004)(4326008)(36860700001)(186003)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 05:42:57.8711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d60367-1a6e-4ec9-ef64-08d9bdfb6b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the smu_context will be invisible from outside(of power). Also,
the smu_debug_mask can be shared around all power code instead of
some specific framework(swSMU) only.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I1a0e1a436a51fc520a47b3fb28cde527d4e5eb6e
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     | 8 --------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 9 ++++++---
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e701dedce344..9ceb8f3e73de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -811,6 +811,9 @@ struct amd_powerplay {
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
+/* Used to mask smu debug modes */
+#define SMU_DEBUG_HALT_ON_ERROR		0x1
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_device {
@@ -959,6 +962,10 @@ struct amdgpu_device {
 	struct amdgpu_pm		pm;
 	u32				cg_flags;
 	u32				pg_flags;
+	/*
+	 * 0 = disabled (default), otherwise enable corresponding debug mode
+	 */
+	uint32_t			smu_debug_mask;
 
 	/* nbio */
 	struct amdgpu_nbio		nbio;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 9dfccb20fedd..ee1cc15c6f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1619,7 +1619,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return 0;
 
 	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
-			   &adev->smu.smu_debug_mask);
+			   &adev->smu_debug_mask);
 
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
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
index 43637d55fe29..b233d9d766f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -257,6 +257,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 				     uint16_t msg_index,
 				     uint32_t param)
 {
+	struct amdgpu_device *adev = smu->adev;
 	u32 reg;
 	int res;
 
@@ -272,7 +273,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res = 0;
 Out:
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res != -ETIME)) {
 		amdgpu_device_halt(smu->adev);
 		WARN_ON(1);
@@ -293,13 +294,14 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
  */
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	u32 reg;
 	int res;
 
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
 
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
 	    res && (res != -ETIME)) {
 		amdgpu_device_halt(smu->adev);
 		WARN_ON(1);
@@ -343,6 +345,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int res, index;
 	u32 reg;
 
@@ -372,7 +375,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 Out:
-	if (unlikely(smu->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
+	if (unlikely(adev->smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
 		amdgpu_device_halt(smu->adev);
 		WARN_ON(1);
 	}
-- 
2.29.0

