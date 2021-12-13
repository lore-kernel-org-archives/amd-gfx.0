Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0656DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7531910ECFE;
	Mon, 13 Dec 2021 03:52:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022C110ECFB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oU6iXyruzt1QtFZ9Z6bZR3u+rB5c1wb4yVVMNJqEuPPhDoVMNPzgvO92eJ8bfASp8BSCros11ikM/JmH+v7aQ6pstHaq+7o3xYch6U2y+qLCoMLcGyDMYS8cGqYJRJ0YMxemYbVMw/QsMbyVKLCOso84iKj9/7z8OZrTjg1ivDZttZvFDb9pDNqZmvvZtOj+gprVYrN42BkHg9mg4fzso8uFRABm7X0/c+HTkYIfovIl9JQMwH1EqptEsi/jscL7POzs8+NLVbi5t18BOf+vqd5lRPMzBZcz5fYBKU/19YWJwwUXxc8QHGtiBVHQtH/J8/9BR4S5azyF2ewefw/umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwjnY5lxUZ/M7qnpzNd5uGt6dBAw8Vs2mMOrbHs8faM=;
 b=MMb8CT1YKfhFbpfFQSJ7rJ0Eu9JNgL3dQElqe8MDY8cT2il+a7kAxoYGItfQdxoeeyZxtzPg6UTyGpBtR+2e6YmiGx5uA8Ka3JSTfP1S4tIuPAKCopOAB3Q/3pTc/5f4wn39l9f/WgQo2uHrD9QiLS/RTh7jkxIlesuvtaQMPS+w8ojTN4dGD52k77JlCJxaO+6VOOoFbg3wpvDtjvYT0ilP2rMbk2K1lvUTP5E5BJiajaJGhfHEe7u0D3NrNMwKaNM700pxODosBZIcsKITybDDZxmD2PzlZMpRE9BKGq9hk1XudwQEjTTNbYsOT9VyLWSP2lQjM0K/qOSPhwO3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwjnY5lxUZ/M7qnpzNd5uGt6dBAw8Vs2mMOrbHs8faM=;
 b=VCSylhJYeyECHOttKrs+j2e8z3/CzkQR9tZr/NPmXuTRZ76ctgtupovOOy6wDBZtljcYDoBflvRXWtfl+iX0v55ODMfR71Bm1Up7I/YKH2TqAf0pfXH5O1cqlvDOwkhUz4nP3ACl30WZTNP562JbzVy0uLqwl2rYV92mVgR8Hqs=
Received: from DM5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:4:15::11) by
 MWHPR1201MB0224.namprd12.prod.outlook.com (2603:10b6:301:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 03:52:52 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::56) by DM5PR16CA0025.outlook.office365.com
 (2603:10b6:4:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Mon, 13 Dec 2021 03:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:52:51 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:52:49 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 05/16] drm/amd/pm: do not expose those APIs used internally
 only in si_dpm.c
Date: Mon, 13 Dec 2021 11:52:12 +0800
Message-ID: <20211213035223.772700-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 300256fd-38a7-49d9-1e59-08d9bdec091e
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0224:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02245FB1C60330E5AB947771E4749@MWHPR1201MB0224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bu4Vn1fwsnmhU11YNfbtW1tUmG/sWHEENqM0+9dXes9oLRy8nlrv3tbBMq3SGsWT6dqUQFgEUORQ0486qEh+Mt0NQxyNCxmURU7rE9omgz2AvFmNu/zOP8VGQ94uWiT6rTpJw+161mBrhOGA+7o7tGvvmV/9Ld8JREVvbf8MAPG79KqyqHp03oIla/jm/SIf3kZUuLeIRWjy0hL/NUIwj2f32081X8AlsyJpyhZNZkaAvEzSmKYOJ0bPUFdPvbZFtDsYNP0kI28GEwYYfuqkklfU21Mlntt4xeP6+/EXj5GRojdjzvVeGMVL6/deR01sR26ngjrpx8fH9+DJ7lBm/NGDIofJhLALb7VfPZ284+Y1dli2PmHyaeXdPKCmIASPlesGl77BFY2zetwsSjcZ3c6JeNIReQlejeloewtGmrsqZ+J5MgqtEprMizqhtfItzPpO0BL1WxotTcMmyYcsb0xgS7ihZvBmFUK12W/tI4Wp2iTeuc0ITEdVUiIwfp/YXWydyZ3rCwkguF8y+w4Ah+vxCaXQrSdtxxXVmUAO4/LdiMMje7tedWGhYXgIXyLvuH+AT4Dmsb4uADUit6C4r+Hhqk6N/Fl/ePj8hkiDJ41JzlAPun0C3OKyqGnswVlqcEW8MxzxRwDflwc1PWiH4StnAZ59ybidAWl5k7ga6zEsQm4Uq77NcBHkl+KcR2a2+TqGXLtKp+bUtOOS91aN1NU0/V7VpPp9EO+oq9fV5HUYUHVBUDxv+GAzMnDxYhn1h/YED756EFMUIV4vjkqNVrAvHPp+O8JmLJq0CR3H1wM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(44832011)(2616005)(16526019)(83380400001)(82310400004)(8936002)(7696005)(336012)(70206006)(508600001)(86362001)(186003)(70586007)(36756003)(26005)(5660300002)(30864003)(36860700001)(316002)(40460700001)(81166007)(356005)(1076003)(54906003)(6916009)(2906002)(4326008)(6666004)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:52:51.1754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300256fd-38a7-49d9-1e59-08d9bdec091e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0224
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move them to si_dpm.c instead.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I288205cfd7c6ba09cfb22626ff70360d61ff0c67
--
v1->v2:
  - rename the API with "si_" prefix(Alex)
v2->v3:
  - rename other data structures used only in si_dpm.c(Lijo)
v3->v4:
  - rename Macros used only in si_dpm.c with "SI_" prefix(Lijo)
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       |  25 -----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   |  25 -----
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 106 +++++++++++++++-------
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.h |  15 ++-
 4 files changed, 83 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 08770888cabb..0f9e109941f1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -894,31 +894,6 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 	}
 }
 
-enum amdgpu_pcie_gen amdgpu_get_pcie_gen_support(struct amdgpu_device *adev,
-						 u32 sys_mask,
-						 enum amdgpu_pcie_gen asic_gen,
-						 enum amdgpu_pcie_gen default_gen)
-{
-	switch (asic_gen) {
-	case AMDGPU_PCIE_GEN1:
-		return AMDGPU_PCIE_GEN1;
-	case AMDGPU_PCIE_GEN2:
-		return AMDGPU_PCIE_GEN2;
-	case AMDGPU_PCIE_GEN3:
-		return AMDGPU_PCIE_GEN3;
-	default:
-		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
-		    (default_gen == AMDGPU_PCIE_GEN3))
-			return AMDGPU_PCIE_GEN3;
-		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
-			 (default_gen == AMDGPU_PCIE_GEN2))
-			return AMDGPU_PCIE_GEN2;
-		else
-			return AMDGPU_PCIE_GEN1;
-	}
-	return AMDGPU_PCIE_GEN1;
-}
-
 struct amd_vce_state*
 amdgpu_get_vce_clock_state(void *handle, u32 idx)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 6681b878e75f..f43b96dfe9d8 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -45,19 +45,6 @@ enum amdgpu_int_thermal_type {
 	THERMAL_TYPE_KV,
 };
 
-enum amdgpu_dpm_auto_throttle_src {
-	AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL,
-	AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL
-};
-
-enum amdgpu_dpm_event_src {
-	AMDGPU_DPM_EVENT_SRC_ANALOG = 0,
-	AMDGPU_DPM_EVENT_SRC_EXTERNAL = 1,
-	AMDGPU_DPM_EVENT_SRC_DIGITAL = 2,
-	AMDGPU_DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
-	AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
-};
-
 struct amdgpu_ps {
 	u32 caps; /* vbios flags */
 	u32 class; /* vbios flags */
@@ -252,13 +239,6 @@ struct amdgpu_dpm_fan {
 	bool ucode_fan_control;
 };
 
-enum amdgpu_pcie_gen {
-	AMDGPU_PCIE_GEN1 = 0,
-	AMDGPU_PCIE_GEN2 = 1,
-	AMDGPU_PCIE_GEN3 = 2,
-	AMDGPU_PCIE_GEN_INVALID = 0xffff
-};
-
 #define amdgpu_dpm_reset_power_profile_state(adev, request) \
 		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
 			(adev)->powerplay.pp_handle, request))
@@ -403,11 +383,6 @@ void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
 
 void amdgpu_add_thermal_controller(struct amdgpu_device *adev);
 
-enum amdgpu_pcie_gen amdgpu_get_pcie_gen_support(struct amdgpu_device *adev,
-						 u32 sys_mask,
-						 enum amdgpu_pcie_gen asic_gen,
-						 enum amdgpu_pcie_gen default_gen);
-
 struct amd_vce_state*
 amdgpu_get_vce_clock_state(void *handle, u32 idx);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 81f82aa05ec2..5bd7a24b70b6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -96,6 +96,19 @@ union pplib_clock_info {
 	struct _ATOM_PPLIB_SI_CLOCK_INFO si;
 };
 
+enum si_dpm_auto_throttle_src {
+	SI_DPM_AUTO_THROTTLE_SRC_THERMAL,
+	SI_DPM_AUTO_THROTTLE_SRC_EXTERNAL
+};
+
+enum si_dpm_event_src {
+	SI_DPM_EVENT_SRC_ANALOG = 0,
+	SI_DPM_EVENT_SRC_EXTERNAL = 1,
+	SI_DPM_EVENT_SRC_DIGITAL = 2,
+	SI_DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
+	SI_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
+};
+
 static const u32 r600_utc[R600_PM_NUMBER_OF_TC] =
 {
 	R600_UTC_DFLT_00,
@@ -3718,25 +3731,25 @@ static void si_set_dpm_event_sources(struct amdgpu_device *adev, u32 sources)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(adev);
 	bool want_thermal_protection;
-	enum amdgpu_dpm_event_src dpm_event_src;
+	enum si_dpm_event_src dpm_event_src;
 
 	switch (sources) {
 	case 0:
 	default:
 		want_thermal_protection = false;
 		break;
-	case (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL):
+	case (1 << SI_DPM_AUTO_THROTTLE_SRC_THERMAL):
 		want_thermal_protection = true;
-		dpm_event_src = AMDGPU_DPM_EVENT_SRC_DIGITAL;
+		dpm_event_src = SI_DPM_EVENT_SRC_DIGITAL;
 		break;
-	case (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL):
+	case (1 << SI_DPM_AUTO_THROTTLE_SRC_EXTERNAL):
 		want_thermal_protection = true;
-		dpm_event_src = AMDGPU_DPM_EVENT_SRC_EXTERNAL;
+		dpm_event_src = SI_DPM_EVENT_SRC_EXTERNAL;
 		break;
-	case ((1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
-	      (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL)):
+	case ((1 << SI_DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
+	      (1 << SI_DPM_AUTO_THROTTLE_SRC_THERMAL)):
 		want_thermal_protection = true;
-		dpm_event_src = AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
+		dpm_event_src = SI_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
 		break;
 	}
 
@@ -3750,7 +3763,7 @@ static void si_set_dpm_event_sources(struct amdgpu_device *adev, u32 sources)
 }
 
 static void si_enable_auto_throttle_source(struct amdgpu_device *adev,
-					   enum amdgpu_dpm_auto_throttle_src source,
+					   enum si_dpm_auto_throttle_src source,
 					   bool enable)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(adev);
@@ -4927,6 +4940,31 @@ static int si_populate_smc_initial_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static enum si_pcie_gen si_gen_pcie_gen_support(struct amdgpu_device *adev,
+						u32 sys_mask,
+						enum si_pcie_gen asic_gen,
+						enum si_pcie_gen default_gen)
+{
+	switch (asic_gen) {
+	case PCIE_GEN1:
+		return PCIE_GEN1;
+	case PCIE_GEN2:
+		return PCIE_GEN2;
+	case PCIE_GEN3:
+		return PCIE_GEN3;
+	default:
+		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
+		    (default_gen == PCIE_GEN3))
+			return PCIE_GEN3;
+		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
+			 (default_gen == PCIE_GEN2))
+			return PCIE_GEN2;
+		else
+			return PCIE_GEN1;
+	}
+	return PCIE_GEN1;
+}
+
 static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
 				      SISLANDS_SMC_STATETABLE *table)
 {
@@ -4989,10 +5027,10 @@ static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
 							      &table->ACPIState.level.std_vddc);
 		}
 		table->ACPIState.level.gen2PCIE =
-			(u8)amdgpu_get_pcie_gen_support(adev,
-							si_pi->sys_pcie_mask,
-							si_pi->boot_pcie_gen,
-							AMDGPU_PCIE_GEN1);
+			(u8)si_gen_pcie_gen_support(adev,
+						    si_pi->sys_pcie_mask,
+						    si_pi->boot_pcie_gen,
+						    PCIE_GEN1);
 
 		if (si_pi->vddc_phase_shed_control)
 			si_populate_phase_shedding_value(adev,
@@ -5430,7 +5468,7 @@ static int si_convert_power_level_to_smc(struct amdgpu_device *adev,
 	bool gmc_pg = false;
 
 	if (eg_pi->pcie_performance_request &&
-	    (si_pi->force_pcie_gen != AMDGPU_PCIE_GEN_INVALID))
+	    (si_pi->force_pcie_gen != PCIE_GEN_INVALID))
 		level->gen2PCIE = (u8)si_pi->force_pcie_gen;
 	else
 		level->gen2PCIE = (u8)pl->pcie_gen;
@@ -6147,8 +6185,8 @@ static void si_enable_voltage_control(struct amdgpu_device *adev, bool enable)
 		WREG32_P(GENERAL_PWRMGT, 0, ~VOLT_PWRMGT_EN);
 }
 
-static enum amdgpu_pcie_gen si_get_maximum_link_speed(struct amdgpu_device *adev,
-						      struct amdgpu_ps *amdgpu_state)
+static enum si_pcie_gen si_get_maximum_link_speed(struct amdgpu_device *adev,
+						  struct amdgpu_ps *amdgpu_state)
 {
 	struct si_ps *state = si_get_ps(amdgpu_state);
 	int i;
@@ -6177,27 +6215,27 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
 							     struct amdgpu_ps *amdgpu_current_state)
 {
 	struct si_power_info *si_pi = si_get_pi(adev);
-	enum amdgpu_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
-	enum amdgpu_pcie_gen current_link_speed;
+	enum si_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
+	enum si_pcie_gen current_link_speed;
 
-	if (si_pi->force_pcie_gen == AMDGPU_PCIE_GEN_INVALID)
+	if (si_pi->force_pcie_gen == PCIE_GEN_INVALID)
 		current_link_speed = si_get_maximum_link_speed(adev, amdgpu_current_state);
 	else
 		current_link_speed = si_pi->force_pcie_gen;
 
-	si_pi->force_pcie_gen = AMDGPU_PCIE_GEN_INVALID;
+	si_pi->force_pcie_gen = PCIE_GEN_INVALID;
 	si_pi->pspp_notify_required = false;
 	if (target_link_speed > current_link_speed) {
 		switch (target_link_speed) {
 #if defined(CONFIG_ACPI)
-		case AMDGPU_PCIE_GEN3:
+		case PCIE_GEN3:
 			if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN3, false) == 0)
 				break;
-			si_pi->force_pcie_gen = AMDGPU_PCIE_GEN2;
-			if (current_link_speed == AMDGPU_PCIE_GEN2)
+			si_pi->force_pcie_gen = PCIE_GEN2;
+			if (current_link_speed == PCIE_GEN2)
 				break;
 			fallthrough;
-		case AMDGPU_PCIE_GEN2:
+		case PCIE_GEN2:
 			if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
 				break;
 			fallthrough;
@@ -6217,13 +6255,13 @@ static void si_notify_link_speed_change_after_state_change(struct amdgpu_device
 							   struct amdgpu_ps *amdgpu_current_state)
 {
 	struct si_power_info *si_pi = si_get_pi(adev);
-	enum amdgpu_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
+	enum si_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
 	u8 request;
 
 	if (si_pi->pspp_notify_required) {
-		if (target_link_speed == AMDGPU_PCIE_GEN3)
+		if (target_link_speed == PCIE_GEN3)
 			request = PCIE_PERF_REQ_PECI_GEN3;
-		else if (target_link_speed == AMDGPU_PCIE_GEN2)
+		else if (target_link_speed == PCIE_GEN2)
 			request = PCIE_PERF_REQ_PECI_GEN2;
 		else
 			request = PCIE_PERF_REQ_PECI_GEN1;
@@ -6864,7 +6902,7 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	si_enable_sclk_control(adev, true);
 	si_start_dpm(adev);
 
-	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
+	si_enable_auto_throttle_source(adev, SI_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
 	si_thermal_start_thermal_controller(adev);
 
 	ni_update_current_ps(adev, boot_ps);
@@ -6904,7 +6942,7 @@ static void si_dpm_disable(struct amdgpu_device *adev)
 	si_enable_power_containment(adev, boot_ps, false);
 	si_enable_smc_cac(adev, boot_ps, false);
 	si_enable_spread_spectrum(adev, false);
-	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, false);
+	si_enable_auto_throttle_source(adev, SI_DPM_AUTO_THROTTLE_SRC_THERMAL, false);
 	si_stop_dpm(adev);
 	si_reset_to_default(adev);
 	si_dpm_stop_smc(adev);
@@ -7148,10 +7186,10 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	pl->vddc = le16_to_cpu(clock_info->si.usVDDC);
 	pl->vddci = le16_to_cpu(clock_info->si.usVDDCI);
 	pl->flags = le32_to_cpu(clock_info->si.ulFlags);
-	pl->pcie_gen = amdgpu_get_pcie_gen_support(adev,
-						   si_pi->sys_pcie_mask,
-						   si_pi->boot_pcie_gen,
-						   clock_info->si.ucPCIEGen);
+	pl->pcie_gen = si_gen_pcie_gen_support(adev,
+					       si_pi->sys_pcie_mask,
+					       si_pi->boot_pcie_gen,
+					       clock_info->si.ucPCIEGen);
 
 	/* patch up vddc if necessary */
 	ret = si_get_leakage_voltage_from_leakage_index(adev, pl->vddc,
@@ -7318,7 +7356,7 @@ static int si_dpm_init(struct amdgpu_device *adev)
 
 	si_pi->sys_pcie_mask =
 		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_MASK;
-	si_pi->force_pcie_gen = AMDGPU_PCIE_GEN_INVALID;
+	si_pi->force_pcie_gen = PCIE_GEN_INVALID;
 	si_pi->boot_pcie_gen = si_get_current_pcie_speed(adev);
 
 	si_set_max_cu_value(adev);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
index bc0be6818e21..77614ff10df6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
@@ -595,13 +595,20 @@ struct rv7xx_power_info {
 	RV770_SMC_STATETABLE smc_statetable;
 };
 
+enum si_pcie_gen {
+	PCIE_GEN1 = 0,
+	PCIE_GEN2 = 1,
+	PCIE_GEN3 = 2,
+	PCIE_GEN_INVALID = 0xffff
+};
+
 struct rv7xx_pl {
 	u32 sclk;
 	u32 mclk;
 	u16 vddc;
 	u16 vddci; /* eg+ only */
 	u32 flags;
-	enum amdgpu_pcie_gen pcie_gen; /* si+ only */
+	enum si_pcie_gen pcie_gen; /* si+ only */
 };
 
 struct rv7xx_ps {
@@ -967,9 +974,9 @@ struct si_power_info {
 	struct si_ulv_param ulv;
 	u32 max_cu;
 	/* pcie gen */
-	enum amdgpu_pcie_gen force_pcie_gen;
-	enum amdgpu_pcie_gen boot_pcie_gen;
-	enum amdgpu_pcie_gen acpi_pcie_gen;
+	enum si_pcie_gen force_pcie_gen;
+	enum si_pcie_gen boot_pcie_gen;
+	enum si_pcie_gen acpi_pcie_gen;
 	u32 sys_pcie_mask;
 	/* flags */
 	bool enable_dte;
-- 
2.29.0

