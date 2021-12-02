Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899EDC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E276E932;
	Thu,  2 Dec 2021 03:10:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1758F6E932
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7M3acUBzNO18ukCUJp93aaYEyEbGK0mTVqpT2N9Use3dZnF9vPHPyl5ayYxqejiRMXTWpVzkWV04fZBok6X7Z6ryUcIRILb8Ilg/IjaRcRld371ojmCDFJHIRZ/0FwdXyVxx+CGoepipRWJt2sGw0TMa+WdhvWnnORF3zC16MwYnQGR7yf7rD8gKrlPQkXhPofBohHqJVdxrD6yOaeXn5xG0dEgkKeWSqH6DJLrF+GHhQeukGJDkY6COT50HNbmf95aMdCIygsbZ0kPlf9WFBRxubTZ3kmoTZO9zoNCY6F5ZpdiBSHGm7TQDRg3giZpeqDgiNE+3xL8cn/sqSckrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oy60uKNJBJar/RKshuEmmchCPrlauqcK4zcCK7aXmg=;
 b=dzk0x8HFOxP0WnytGenUgkr/+NkZ/3Cezr7kTneVNhH93dcLwfNjlKjVsnv95M+jxwqNnxvnpTyxCWuCqif/cF1qcg5XxbSma2IIZYwSe7Rp+0b7NJNfHhHafrGKjEMdzsh5swCerbltv0s/j5XcnTMMnCyTxRXDtL2Eddclp6RakyiTybLaS+43rWUCG95TpAcYty04ART6eT839iLYtjkaOHKVuP8PC7a1p8L0U9avcn8xzxoQbnxwuFTqp0xb4/WiuBCJhS+LNFecmXWa+gqn1MwPr/nOFUyNGe8EUSTcNAJM+JyqJjOlVBhmSdA5Ub35TWH+1+rhgD+juySP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oy60uKNJBJar/RKshuEmmchCPrlauqcK4zcCK7aXmg=;
 b=XDYNjKX+UzApBh/M/8MC0A/X5yRXLOeFK3bjirBa3kLRxiacqUYIkEhWbqZMQu9M2KvZavybDTAvTMmwPtDzfgZDIlxQhsiE1oMwU3oy9FTB8+W5dFjV8ztoL/nJG37G7HeVlvZalpeo1cWvkwq1utqO1spQdCPXnBT5y5Kf604=
Received: from DS7PR05CA0006.namprd05.prod.outlook.com (2603:10b6:5:3b9::11)
 by BYAPR12MB4598.namprd12.prod.outlook.com (2603:10b6:a03:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 03:10:10 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::9d) by DS7PR05CA0006.outlook.office365.com
 (2603:10b6:5:3b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:10 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:08 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 05/17] drm/amd/pm: do not expose those APIs used internally
 only in si_dpm.c
Date: Thu, 2 Dec 2021 11:09:18 +0800
Message-ID: <20211202030930.1681278-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d42828e-af4e-439f-fc2d-08d9b5414090
X-MS-TrafficTypeDiagnostic: BYAPR12MB4598:
X-Microsoft-Antispam-PRVS: <BYAPR12MB45981C1AD9B1F97C84226636E4699@BYAPR12MB4598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vd4VJIbWO807mJUp1h47jEArA5UwxKcqk5g9rSfOwY9DGkhoJQtzI8nsJwrNWgRtkqViwNALn7RfF/1cSzVuddQr8Wu/28+xqkKVzDAziQcvAQijv/sWjlHfJSjyBv+ShAEQlT9FKtrzG/d4Q9k0ZA7PY7XTK8N7OSn0v8bGooRPPA+Oz1zoDUtLEPTzxpsWwlAQel4xagmHhV8x/zAKGUJK2QcxTYAaMm7OmYRnspqU6nk1pfq7fZdb0KXjUfmREILad7RtJdqrQE6jD/TUxcuDLr2bgTyeMsUgyskzVh3jwSD3BDf3+zlY4HSqRZalwcX5bAN5IKAK5Sm4C0S3W8V16Ht+1JXc1mmXg/gS0eglbVr7Fo5e6qHJjhc4zEKdKv7ujOgPt8SfsjgEeLPwGT1ojJ5ZqxDwQQqKW5XxCBYi5rC252AfrCA/zC9Ll2S3QHtgdQ28XtiQgKuny++eJ37t6SzrM/vKT4W2HpEEyWxY+wvl5imT60GT2ZhcdC7vPc3fKbX60tHQh7oGgWx7LWq77k570JdJcE/O6rPaWn73pWXNuXOS2Gz2Iho287jPj61L2q0hB+RBS/4cBUp5JPLUH2svP/lkJRKXI02QkYaisnXRZa4EwTa2XfR77QnYALDMDpvpT9ZqUeEKdcKcYpTlstCorewc3SCMEcUrJ05F7wdcTbguvOjSwjw7FLym4LWr0/dHUR/xZK5kT4MQV8PGQciQYItk6pErUtCaXf4QC6jNyAqA4+XkKVX/BBC8JluFpR3voha6WSuGP79Ped/fYvJM8LUcsNpkNURO8cU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(2616005)(336012)(8676002)(508600001)(36860700001)(7696005)(44832011)(16526019)(36756003)(6916009)(81166007)(426003)(186003)(1076003)(70586007)(4326008)(47076005)(82310400004)(2906002)(6666004)(30864003)(5660300002)(70206006)(83380400001)(316002)(54906003)(86362001)(356005)(8936002)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:10.9517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d42828e-af4e-439f-fc2d-08d9b5414090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4598
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
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
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       |  25 -----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   |  25 -----
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 106 +++++++++++++++-------
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.h |  15 ++-
 4 files changed, 83 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 72a8cb70d36b..b31858ad9b83 100644
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
index 81f82aa05ec2..ab0fa6c79255 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -96,6 +96,19 @@ union pplib_clock_info {
 	struct _ATOM_PPLIB_SI_CLOCK_INFO si;
 };
 
+enum si_dpm_auto_throttle_src {
+	DPM_AUTO_THROTTLE_SRC_THERMAL,
+	DPM_AUTO_THROTTLE_SRC_EXTERNAL
+};
+
+enum si_dpm_event_src {
+	DPM_EVENT_SRC_ANALOG = 0,
+	DPM_EVENT_SRC_EXTERNAL = 1,
+	DPM_EVENT_SRC_DIGITAL = 2,
+	DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
+	DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
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
+	case (1 << DPM_AUTO_THROTTLE_SRC_THERMAL):
 		want_thermal_protection = true;
-		dpm_event_src = AMDGPU_DPM_EVENT_SRC_DIGITAL;
+		dpm_event_src = DPM_EVENT_SRC_DIGITAL;
 		break;
-	case (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL):
+	case (1 << DPM_AUTO_THROTTLE_SRC_EXTERNAL):
 		want_thermal_protection = true;
-		dpm_event_src = AMDGPU_DPM_EVENT_SRC_EXTERNAL;
+		dpm_event_src = DPM_EVENT_SRC_EXTERNAL;
 		break;
-	case ((1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
-	      (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL)):
+	case ((1 << DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
+	      (1 << DPM_AUTO_THROTTLE_SRC_THERMAL)):
 		want_thermal_protection = true;
-		dpm_event_src = AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
+		dpm_event_src = DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
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
+	si_enable_auto_throttle_source(adev, DPM_AUTO_THROTTLE_SRC_THERMAL, true);
 	si_thermal_start_thermal_controller(adev);
 
 	ni_update_current_ps(adev, boot_ps);
@@ -6904,7 +6942,7 @@ static void si_dpm_disable(struct amdgpu_device *adev)
 	si_enable_power_containment(adev, boot_ps, false);
 	si_enable_smc_cac(adev, boot_ps, false);
 	si_enable_spread_spectrum(adev, false);
-	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, false);
+	si_enable_auto_throttle_source(adev, DPM_AUTO_THROTTLE_SRC_THERMAL, false);
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

