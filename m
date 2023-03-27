Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7764DC77B6D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D9610E727;
	Mon, 27 Mar 2023 19:36:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A9C10E722
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMN7ksZt/cIsLOW3L4aQv6oyKZvrQPevkKdheGoT8RUY1afYvGC9jCIxZU3b9ygFH1ipKeEYKoQcs5XVQ3Y5qCaZHs8f/v1HAarjxfX3n0UWx5Z5IBNLhgAnr2/U7WHpFR0zbI8rVhjDUU0rhZlAlb7uIA56DzdEHgrN3etXDaz8mXPUV0xrR0zg6KepA1/Al47eQN6I5deZIGPYXcKCxIc6vs9Jxbh1I/fb2+WQZM1tijsJd1Qo0FetEZhi//pC1OVXsaVbN+j7ssOHSI6nmn3k6fqSk/urHpQSn0uFQufichXj3j2BuUSl3BGAbEhdE72wvKazcHaRQAFceU1UEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F63FCI9AfkhpeyhZX9AMTtUxgK9sr0Je6oq06atmx8Y=;
 b=kb36MDdLaQQ6flGskAtNyHAQ83pD8JFV6HFU6/ESNlgeBVQ+hP8LcuoswbCRCbCbTCvGalc2zDKZyARZTlsB6nCEpt9yJHsByHF681JnTFv3jFFxT7ioXptb0wTdHLFjBNVIK0pQX3jwuFdDubkBRZjlivoTScA/BbWTeJf7wjr1fSUObngw8J4f8rhTIR++GPXJU8dUIsgV0djPqLhS3eMZWs+Fs0FZDRJdqtZkDbxvouD6JrDsuoXE8LzHbV4nOwwUevSmwHaLTQfujHQAeiTEOmObFCmdGhNLRtcscTKsJyUuB2Zez+0+Be+Ro05cUL3Yr3ohrdHZ5Hs4PLIPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F63FCI9AfkhpeyhZX9AMTtUxgK9sr0Je6oq06atmx8Y=;
 b=AKpdCTWT4bH6/1p78ka/+hxrrOTUUwwEbHhJSDM0l3ajSfAT2+SlpTvdWYkJ9l+wQT854Q2p6bJcYdaqmcFV5qo1q22LaCLji36rBTJpAP6e3/Y+Csusb7oIJFhWvXBbqHAeUOIJye9u6MiwAF3oJSrfJHgReikJeEslg5t88Ww=
Received: from BN8PR15CA0056.namprd15.prod.outlook.com (2603:10b6:408:80::33)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 19:36:29 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::9a) by BN8PR15CA0056.outlook.office365.com
 (2603:10b6:408:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/28] drm/amdgpu: add xcc index argument to rlc safe_mode
 func (v4)
Date: Mon, 27 Mar 2023 15:35:46 -0400
Message-ID: <20230327193602.7901-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1348ec39-836b-496a-e648-08db2efa8fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBnrNeqDKO0fxsaxK8yIhgGHXafQzNBO7SWiopB+rTMkg69Zqt2jsOrqhOP4qf4K/vmxAFKG8qr5pVoq2UjPHOaF2COgM7YBwwPNVOepaG1hzjZ2AHZ21+MCXeP6ZTm6JfbfPYExksM89tRCRo98Bd7tjpxQNCErdTWxCoMCE+e9lTYBffEojyVjIsXIvWlttn1WSjxeq+doDKThGVPtrcOiYe64GWgRQj/40Xsks/clDSazJDhoshB+Ywdgiaf4DJqelWU5MmiuE24X5ztaMzaT6Xnnhfn8QFmkj28yTPbMc2+C9Vr10c+XDNiZ3tWQLxlVZxSfByVTFgRb2yuOa0i0rSV4OcF8TzOY8qJhScjsQ3nhX10DiVMJw3Q2XnvWXBDayJov+OTlsNiFBz+b6Kdl7CsAGsLOztWZLhOm0Vr+ues1a4HJ4sTwbhdXBeH22QS0au8fZkFBVleQWS55852F9L0HifIZJwgmG2e8ca08W1nz39ZP1+AvRY01rbD7mkLcsfg+uq3TMZ4GsHOoduf+1SH0xR4r0mYnK5CnWbYcnr/7PVR0ly5ufpIOpIIz7oaCMZcvwxmYRchJAZ/fQlVJE7xkYamzuh5vYm60UGiJvwI71Qt9VJtfwLw666UQjU5u2jFK5YDQX6aICd5AW0GbZgOsY1IDjSI4n6BorOkke/NYo7B9YRBZ/CdxGLPrlpPAV3FuT3skrYT2CgoD5swdOUMpejT+ZAwR49Ew9go=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(356005)(336012)(81166007)(47076005)(36756003)(83380400001)(82740400003)(186003)(86362001)(426003)(36860700001)(2616005)(316002)(4326008)(478600001)(40480700001)(8936002)(70586007)(40460700003)(8676002)(70206006)(5660300002)(6916009)(7696005)(1076003)(26005)(16526019)(2906002)(30864003)(54906003)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:28.9591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1348ec39-836b-496a-e648-08db2efa8fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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
 Morris Zhang <Shiwu.Zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

v1: To support multple XCD case (Le)
v2: unify naming style (Le)
v3: apply the changes to gc v11_0 (Hawking)
v4: apply the changes to gc SOC21 (Morris)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Morris Zhang <Shiwu.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c       | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h       | 10 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 12 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 20 +++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 20 +++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 20 +++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/nv.c               |  4 +--
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  4 +--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  6 ++--
 .../amd/pm/powerplay/hwmgr/smu7_powertune.c   | 12 +++----
 .../amd/pm/powerplay/hwmgr/vega10_powertune.c | 36 +++++++++----------
 13 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 85fb730d9fc8..d3bed9a3e61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -34,9 +34,9 @@
  *
  * Set RLC enter into safe mode if RLC is enabled and haven't in safe mode.
  */
-void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev)
+void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
-	if (adev->gfx.rlc.in_safe_mode)
+	if (adev->gfx.rlc.in_safe_mode[xcc_id])
 		return;
 
 	/* if RLC is not enabled, do nothing */
@@ -46,8 +46,8 @@ void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev)
 	if (adev->cg_flags &
 	    (AMD_CG_SUPPORT_GFX_CGCG | AMD_CG_SUPPORT_GFX_MGCG |
 	     AMD_CG_SUPPORT_GFX_3D_CGCG)) {
-		adev->gfx.rlc.funcs->set_safe_mode(adev);
-		adev->gfx.rlc.in_safe_mode = true;
+		adev->gfx.rlc.funcs->set_safe_mode(adev, xcc_id);
+		adev->gfx.rlc.in_safe_mode[xcc_id] = true;
 	}
 }
 
@@ -58,9 +58,9 @@ void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev)
  *
  * Set RLC exit safe mode if RLC is enabled and have entered into safe mode.
  */
-void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev)
+void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
-	if (!(adev->gfx.rlc.in_safe_mode))
+	if (!(adev->gfx.rlc.in_safe_mode[xcc_id]))
 		return;
 
 	/* if RLC is not enabled, do nothing */
@@ -70,8 +70,8 @@ void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev)
 	if (adev->cg_flags &
 	    (AMD_CG_SUPPORT_GFX_CGCG | AMD_CG_SUPPORT_GFX_MGCG |
 	     AMD_CG_SUPPORT_GFX_3D_CGCG)) {
-		adev->gfx.rlc.funcs->unset_safe_mode(adev);
-		adev->gfx.rlc.in_safe_mode = false;
+		adev->gfx.rlc.funcs->unset_safe_mode(adev, xcc_id);
+		adev->gfx.rlc.in_safe_mode[xcc_id] = false;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 23f060db9255..80b263646966 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -157,8 +157,8 @@ typedef struct _RLC_TABLE_OF_CONTENT {
 
 struct amdgpu_rlc_funcs {
 	bool (*is_rlc_enabled)(struct amdgpu_device *adev);
-	void (*set_safe_mode)(struct amdgpu_device *adev);
-	void (*unset_safe_mode)(struct amdgpu_device *adev);
+	void (*set_safe_mode)(struct amdgpu_device *adev, int xcc_id);
+	void (*unset_safe_mode)(struct amdgpu_device *adev, int xcc_id);
 	int  (*init)(struct amdgpu_device *adev);
 	u32  (*get_csb_size)(struct amdgpu_device *adev);
 	void (*get_csb_buffer)(struct amdgpu_device *adev, volatile u32 *buffer);
@@ -201,7 +201,7 @@ struct amdgpu_rlc {
 	u32                     cp_table_size;
 
 	/* safe mode for updating CG/PG state */
-	bool in_safe_mode;
+	bool in_safe_mode[8];
 	const struct amdgpu_rlc_funcs *funcs;
 
 	/* for firmware data */
@@ -260,8 +260,8 @@ struct amdgpu_rlc {
 	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl;
 };
 
-void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev);
-void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev);
+void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id);
+void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws);
 int amdgpu_gfx_rlc_init_csb(struct amdgpu_device *adev);
 int amdgpu_gfx_rlc_init_cpt(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 323f5b8927ad..8bd07ff59671 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7571,7 +7571,7 @@ static bool gfx_v10_0_is_rlc_enabled(struct amdgpu_device *adev)
 	return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true : false;
 }
 
-static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev)
+static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 	unsigned i;
@@ -7612,7 +7612,7 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
-static void gfx_v10_0_unset_safe_mode(struct amdgpu_device *adev)
+static void gfx_v10_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 
@@ -7959,7 +7959,7 @@ static void gfx_v10_0_apply_medium_grain_clock_gating_workaround(struct amdgpu_d
 static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	if (enable) {
 		/* enable FGCG firstly*/
@@ -7998,7 +7998,7 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	     AMD_CG_SUPPORT_GFX_3D_CGLS))
 		gfx_v10_0_enable_gui_idle_interrupt(adev, enable);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
 }
@@ -8092,11 +8092,11 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 
 static void gfx_v10_cntl_pg(struct amdgpu_device *adev, bool enable)
 {
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	gfx_v10_cntl_power_gating(adev, enable);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7bbb74aceb45..fa3c79a6ecaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -123,8 +123,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
 static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   uint16_t pasid, uint32_t flush_type,
 					   bool all_hub, uint8_t dst_sel);
-static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev);
-static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev);
+static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -4532,7 +4532,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 0);
 	WREG32_SOC15(GC, 0, regCP_INT_CNTL, tmp);
 
-	gfx_v11_0_set_safe_mode(adev);
+	gfx_v11_0_set_safe_mode(adev, 0);
 
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
@@ -4632,7 +4632,7 @@ static int gfx_v11_0_soft_reset(void *handle)
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 1);
 	WREG32_SOC15(GC, 0, regCP_INT_CNTL, tmp);
 
-	gfx_v11_0_unset_safe_mode(adev);
+	gfx_v11_0_unset_safe_mode(adev, 0);
 
 	return gfx_v11_0_cp_resume(adev);
 }
@@ -4785,7 +4785,7 @@ static bool gfx_v11_0_is_rlc_enabled(struct amdgpu_device *adev)
 	return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true : false;
 }
 
-static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev)
+static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 	unsigned i;
@@ -4804,7 +4804,7 @@ static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
-static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev)
+static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
 }
@@ -5032,7 +5032,7 @@ static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	gfx_v11_0_update_coarse_grain_clock_gating(adev, enable);
 
@@ -5052,7 +5052,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	     AMD_CG_SUPPORT_GFX_3D_CGLS))
 	        gfx_v11_0_enable_gui_idle_interrupt(adev, enable);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
 }
@@ -5120,11 +5120,11 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 
 static void gfx_v11_cntl_pg(struct amdgpu_device *adev, bool enable)
 {
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	gfx_v11_cntl_power_gating(adev, enable);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static int gfx_v11_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index d055e44eee1d..d56dda5fc588 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3362,7 +3362,7 @@ static bool gfx_v7_0_is_rlc_enabled(struct amdgpu_device *adev)
 	return true;
 }
 
-static void gfx_v7_0_set_safe_mode(struct amdgpu_device *adev)
+static void gfx_v7_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	u32 tmp, i, mask;
 
@@ -3384,7 +3384,7 @@ static void gfx_v7_0_set_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
-static void gfx_v7_0_unset_safe_mode(struct amdgpu_device *adev)
+static void gfx_v7_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	u32 tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b60480876149..278416acf060 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4903,7 +4903,7 @@ static int gfx_v8_0_hw_fini(void *handle)
 		pr_debug("For SRIOV client, shouldn't do anything.\n");
 		return 0;
 	}
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	if (!gfx_v8_0_wait_for_idle(adev))
 		gfx_v8_0_cp_enable(adev, false);
 	else
@@ -4912,7 +4912,7 @@ static int gfx_v8_0_hw_fini(void *handle)
 		adev->gfx.rlc.funcs->stop(adev);
 	else
 		pr_err("rlc is busy, skip halt rlc\n");
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
 }
@@ -5377,7 +5377,7 @@ static int gfx_v8_0_set_powergating_state(void *handle,
 				AMD_PG_SUPPORT_RLC_SMU_HS |
 				AMD_PG_SUPPORT_CP |
 				AMD_PG_SUPPORT_GFX_DMG))
-		amdgpu_gfx_rlc_enter_safe_mode(adev);
+		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	switch (adev->asic_type) {
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
@@ -5431,7 +5431,7 @@ static int gfx_v8_0_set_powergating_state(void *handle,
 				AMD_PG_SUPPORT_RLC_SMU_HS |
 				AMD_PG_SUPPORT_CP |
 				AMD_PG_SUPPORT_GFX_DMG))
-		amdgpu_gfx_rlc_exit_safe_mode(adev);
+		amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return 0;
 }
 
@@ -5536,7 +5536,7 @@ static bool gfx_v8_0_is_rlc_enabled(struct amdgpu_device *adev)
 	return true;
 }
 
-static void gfx_v8_0_set_safe_mode(struct amdgpu_device *adev)
+static void gfx_v8_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 	unsigned i;
@@ -5563,7 +5563,7 @@ static void gfx_v8_0_set_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
-static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev)
+static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 	unsigned i;
@@ -5622,7 +5622,7 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 {
 	uint32_t temp, data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
@@ -5718,7 +5718,7 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 		gfx_v8_0_wait_for_rlc_serdes(adev);
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
@@ -5728,7 +5728,7 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 
 	temp = data = RREG32(mmRLC_CGCG_CGLS_CTRL);
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		temp1 = data1 =	RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
@@ -5811,7 +5811,7 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 
 	gfx_v8_0_wait_for_rlc_serdes(adev);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 static int gfx_v8_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 305974d682eb..77f1362c2bbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4583,7 +4583,7 @@ static bool gfx_v9_0_is_rlc_enabled(struct amdgpu_device *adev)
 	return true;
 }
 
-static void gfx_v9_0_set_safe_mode(struct amdgpu_device *adev)
+static void gfx_v9_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 	unsigned i;
@@ -4600,7 +4600,7 @@ static void gfx_v9_0_set_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
-static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev)
+static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 
@@ -4611,7 +4611,7 @@ static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev)
 static void gfx_v9_0_update_gfx_cg_power_gating(struct amdgpu_device *adev,
 						bool enable)
 {
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) && enable) {
 		gfx_v9_0_enable_gfx_cg_power_gating(adev, true);
@@ -4623,7 +4623,7 @@ static void gfx_v9_0_update_gfx_cg_power_gating(struct amdgpu_device *adev,
 			gfx_v9_0_enable_gfx_pipeline_powergating(adev, false);
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_update_gfx_mg_power_gating(struct amdgpu_device *adev,
@@ -4650,7 +4650,7 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 {
 	uint32_t data, def;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
@@ -4717,7 +4717,7 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
 		}
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
@@ -4728,7 +4728,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 	if (!adev->gfx.num_gfx_rings)
 		return;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* Enable 3D CGCG/CGLS */
 	if (enable) {
@@ -4772,7 +4772,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
 			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D, data);
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
@@ -4780,7 +4780,7 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 {
 	uint32_t def, data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
@@ -4824,7 +4824,7 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL, data);
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 51a033537be1..0e162189d860 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1091,14 +1091,14 @@ static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
 	return true;
 }
 
-static void gfx_v9_4_3_set_safe_mode(struct amdgpu_device *adev)
+static void gfx_v9_4_3_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 	unsigned i;
 
 	data = RLC_SAFE_MODE__CMD_MASK;
 	data |= (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);
-	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, data);
+	WREG32_SOC15(GC, xcc_id, regRLC_SAFE_MODE, data);
 
 	/* wait for RLC_SAFE_MODE */
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -1108,12 +1108,12 @@ static void gfx_v9_4_3_set_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
-static void gfx_v9_4_3_unset_safe_mode(struct amdgpu_device *adev)
+static void gfx_v9_4_3_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
 
 	data = RLC_SAFE_MODE__CMD_MASK;
-	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, data);
+	WREG32_SOC15(GC, xcc_id, regRLC_SAFE_MODE, data);
 }
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
@@ -2126,7 +2126,7 @@ static void gfx_v9_4_3_update_medium_grain_clock_gating(struct amdgpu_device *ad
 {
 	uint32_t data, def;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
@@ -2187,7 +2187,7 @@ static void gfx_v9_4_3_update_medium_grain_clock_gating(struct amdgpu_device *ad
 		}
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 }
 
 static void gfx_v9_4_3_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
@@ -2195,7 +2195,7 @@ static void gfx_v9_4_3_update_coarse_grain_clock_gating(struct amdgpu_device *ad
 {
 	uint32_t def, data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, xcc_id, regRLC_CGTT_MGCG_OVERRIDE);
@@ -2239,7 +2239,7 @@ static void gfx_v9_4_3_update_coarse_grain_clock_gating(struct amdgpu_device *ad
 			WREG32_SOC15(GC, xcc_id, regRLC_CGCG_CGLS_CTRL, data);
 	}
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 }
 
 static int gfx_v9_4_3_update_gfx_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 148049782f50..dabeeab2f2ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -629,9 +629,9 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 				       bool enter)
 {
 	if (enter)
-		amdgpu_gfx_rlc_enter_safe_mode(adev);
+		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	else
-		amdgpu_gfx_rlc_exit_safe_mode(adev);
+		amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	if (adev->gfx.funcs->update_perfmon_mgcg)
 		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6ef4be9322d9..7d59303ca2f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -549,9 +549,9 @@ static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
 	if (enter)
-		amdgpu_gfx_rlc_enter_safe_mode(adev);
+		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	else
-		amdgpu_gfx_rlc_exit_safe_mode(adev);
+		amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	if (adev->gfx.funcs->update_perfmon_mgcg)
 		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index f5e08b60f66e..36c831b280ed 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -508,19 +508,19 @@ static int kv_enable_didt(struct amdgpu_device *adev, bool enable)
 	    pi->caps_db_ramping ||
 	    pi->caps_td_ramping ||
 	    pi->caps_tcp_ramping) {
-		amdgpu_gfx_rlc_enter_safe_mode(adev);
+		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 		if (enable) {
 			ret = kv_program_pt_config_registers(adev, didt_config_kv);
 			if (ret) {
-				amdgpu_gfx_rlc_exit_safe_mode(adev);
+				amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 				return ret;
 			}
 		}
 
 		kv_do_enable_didt(adev, enable);
 
-		amdgpu_gfx_rlc_exit_safe_mode(adev);
+		amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
index 32a5a00fd8ae..21be23ec3c79 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
@@ -973,7 +973,7 @@ int smu7_enable_didt_config(struct pp_hwmgr *hwmgr)
 	    PP_CAP(PHM_PlatformCaps_TDRamping) ||
 	    PP_CAP(PHM_PlatformCaps_TCPRamping)) {
 
-		amdgpu_gfx_rlc_enter_safe_mode(adev);
+		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 		mutex_lock(&adev->grbm_idx_mutex);
 		value = 0;
 		value2 = cgs_read_register(hwmgr->device, mmGRBM_GFX_INDEX);
@@ -1048,13 +1048,13 @@ int smu7_enable_didt_config(struct pp_hwmgr *hwmgr)
 		}
 
 		mutex_unlock(&adev->grbm_idx_mutex);
-		amdgpu_gfx_rlc_exit_safe_mode(adev);
+		amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	}
 
 	return 0;
 error:
 	mutex_unlock(&adev->grbm_idx_mutex);
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return result;
 }
 
@@ -1068,7 +1068,7 @@ int smu7_disable_didt_config(struct pp_hwmgr *hwmgr)
 	    PP_CAP(PHM_PlatformCaps_TDRamping) ||
 	    PP_CAP(PHM_PlatformCaps_TCPRamping)) {
 
-		amdgpu_gfx_rlc_enter_safe_mode(adev);
+		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 		result = smu7_enable_didt(hwmgr, false);
 		PP_ASSERT_WITH_CODE((result == 0),
@@ -1081,12 +1081,12 @@ int smu7_disable_didt_config(struct pp_hwmgr *hwmgr)
 			PP_ASSERT_WITH_CODE((0 == result),
 					"Failed to disable DPM DIDT.", goto error);
 		}
-		amdgpu_gfx_rlc_exit_safe_mode(adev);
+		amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	}
 
 	return 0;
 error:
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
index 9757d47dd6b8..309a9d3bc1b7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
@@ -915,7 +915,7 @@ static int vega10_enable_cac_driving_se_didt_config(struct pp_hwmgr *hwmgr)
 
 	num_se = adev->gfx.config.max_shader_engines;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (count = 0; count < num_se; count++) {
@@ -940,7 +940,7 @@ static int vega10_enable_cac_driving_se_didt_config(struct pp_hwmgr *hwmgr)
 
 	vega10_didt_set_mask(hwmgr, true);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
 }
@@ -949,11 +949,11 @@ static int vega10_disable_cac_driving_se_didt_config(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	vega10_didt_set_mask(hwmgr, false);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
 }
@@ -966,7 +966,7 @@ static int vega10_enable_psm_gc_didt_config(struct pp_hwmgr *hwmgr)
 
 	num_se = adev->gfx.config.max_shader_engines;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (count = 0; count < num_se; count++) {
@@ -985,7 +985,7 @@ static int vega10_enable_psm_gc_didt_config(struct pp_hwmgr *hwmgr)
 
 	vega10_didt_set_mask(hwmgr, true);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	vega10_program_gc_didt_config_registers(hwmgr, GCDiDtDroopCtrlConfig_vega10);
 	if (PP_CAP(PHM_PlatformCaps_GCEDC))
@@ -1002,11 +1002,11 @@ static int vega10_disable_psm_gc_didt_config(struct pp_hwmgr *hwmgr)
 	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	vega10_didt_set_mask(hwmgr, false);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	if (PP_CAP(PHM_PlatformCaps_GCEDC)) {
 		data = 0x00000000;
@@ -1027,7 +1027,7 @@ static int vega10_enable_se_edc_config(struct pp_hwmgr *hwmgr)
 
 	num_se = adev->gfx.config.max_shader_engines;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (count = 0; count < num_se; count++) {
@@ -1048,7 +1048,7 @@ static int vega10_enable_se_edc_config(struct pp_hwmgr *hwmgr)
 
 	vega10_didt_set_mask(hwmgr, true);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
 }
@@ -1057,11 +1057,11 @@ static int vega10_disable_se_edc_config(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	vega10_didt_set_mask(hwmgr, false);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
 }
@@ -1075,7 +1075,7 @@ static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
 
 	num_se = adev->gfx.config.max_shader_engines;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	vega10_program_gc_didt_config_registers(hwmgr, AvfsPSMResetConfig_vega10);
 
@@ -1096,7 +1096,7 @@ static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
 
 	vega10_didt_set_mask(hwmgr, true);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	vega10_program_gc_didt_config_registers(hwmgr, PSMGCEDCDroopCtrlConfig_vega10);
 
@@ -1116,11 +1116,11 @@ static int vega10_disable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
 	struct amdgpu_device *adev = hwmgr->adev;
 	uint32_t data;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	vega10_didt_set_mask(hwmgr, false);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	if (PP_CAP(PHM_PlatformCaps_GCEDC)) {
 		data = 0x00000000;
@@ -1138,7 +1138,7 @@ static int vega10_enable_se_edc_force_stall_config(struct pp_hwmgr *hwmgr)
 	struct amdgpu_device *adev = hwmgr->adev;
 	int result;
 
-	amdgpu_gfx_rlc_enter_safe_mode(adev);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xE0000000);
@@ -1151,7 +1151,7 @@ static int vega10_enable_se_edc_force_stall_config(struct pp_hwmgr *hwmgr)
 
 	vega10_didt_set_mask(hwmgr, false);
 
-	amdgpu_gfx_rlc_exit_safe_mode(adev);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
 }
-- 
2.39.2

