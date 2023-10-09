Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A78BCD611D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0CE10E2AF;
	Mon,  9 Oct 2023 18:34:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6C810E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLYlY4tBPEpo9ypFSdKVGYN2iOrzZ92y38ISIVtA2VhRDHmqvmPy2RS0q4XhSB9RnF3uvYJbE5HpXaQJsnz+ZxklbX7PmoUbcnyXsfj9vIWyAa2yj9MEKmzdWnD0ebTrwLvSy7iuFkoaLlp0ca8ROyKcP88itN44FnUUsTPkgC1C7agQTamPp2O854QhKai2jlY6p9Oj9mi5kqnprn3gaOHsTqZZn1WQFbp2A7ie2CnEZ4G7OIHUqNd8kWZabO4/feSWTKvnwKuNUxWV23CVqOjr2s8xYBsLXsO+WyZ9R3pxbPo1ioVZmLvskR6NCkqQ52Vg+yL/8f5iEYIeeXO5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCuWf27Nkhe3XDnHhgtc1ALMejr2N4IEqELl/NHjmvo=;
 b=UzLmig+hjv9qovzMJ/oZxrm2ap2aVSB16wQNsLI7GXg1JF/WKj6vUlKJxGci1EpunLu5wrMc9fG4DhWPIbU1Q6W4sCm+a7pmmbUJvhrR8TfrjfYD64ImTkyHAERBZiM6VvzRye62eYiKpLalvz/8ZEAdxr7Pr6MZguJxvnUXRVy9nB3usTMbHkp7ynEHDfwZqIqGTaiuttYGXPMnygcuX0tMBeljhLxhaS0Iw+B7JgHIzJIcFUJn2QVZ2lYWW6PHyPeYKvDqjPsYBiTbKG9CK2rEYkj2isPvFwpw/MQxP8IpX+QODe7r59y8Wi1EAGR89Cby9asOuyBsd0PVc1NKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCuWf27Nkhe3XDnHhgtc1ALMejr2N4IEqELl/NHjmvo=;
 b=Ks7z1GU9Ha/O0hwVof/rbZHV+IGbDmlOeCzO1l76qYAkcYI4drB/mpKuVTcWDvB/7T5vsiFhGS4amxDZ2dK8MEVHjUYG7J5XtKjPsR3JN2odnjwRE/NZGZFrejAx5w5Y7Vpsya7ZzABGsKDHRxiWzxnYvgdah6kPyZLkryRX3Hs=
Received: from CY8PR11CA0039.namprd11.prod.outlook.com (2603:10b6:930:4a::27)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 18:34:20 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::fa) by CY8PR11CA0039.outlook.office365.com
 (2603:10b6:930:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 18:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 18:34:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:34:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add support to power up/down UMSCH by SMU
Date: Mon, 9 Oct 2023 14:34:02 -0400
Message-ID: <20231009183402.518574-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183402.518574-1-alexander.deucher@amd.com>
References: <20231009183402.518574-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: c62d931b-78a8-4fff-168e-08dbc8f65a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drKFAp1FMwdDLWi2GuR07CyvOin+76dwtwZrY78qcdbB0knUIVTX8CwtkwYIXxuPBpzPbb2LZ4Ja6zcPDm1LCtvMP6NhMDUrVj7ROd7Pt99oXpId13vbcF6+q+AXRvDvDunZWdB5YZGix77Re+1GbEcVrmm7Tvf+biynkfz7aoe03CrTf9dTHMM8sCe8cblD1mnZDAGJPllqXItB00pj53TeAeChbBZ3DEDugLcm+w5LeOn/zsvFeV29UHIWFq/lOi23MizDJdLUs+vwkldr3EVQqraBLdrD0m8BdK2BDfQ5/uaWI45ZqbR0xmQuevFk4W1YC8b4IWkrs891F0XBRl9fU3weBliAQ+iZ8bvk6BtfUZ/o3f2R4KFRfywZ1MH+DHCa0yxO2yxl6CPYbRlKIR+nyBw6FY6iab5trvQbtfpFXsH63OjhPSXNeN07b2SM74ffOfffIyloeX+w+A72EnIZCULHfDOEvznh1quwHWDNZGn7WQ44wqhQspHZlM+YQd3DxiezqL2Ne4LPna/1Yyv7aVbTNdJUTPlZAhyBCMnc+q37lv73s1I3I0JuLn+4fHl3fyqTJyuz7sHqf0MWjFDtd/l53TO/tJy9ONy4rGSzcTQcK/Qo5aXg6hlcqYzkqYAGwxG4zw3tMQp5IA12iy7IQdTdyhlFFaYbuuOACpMlD8AMefuVToW/yLlmPI5iRyJtV5M3dzIsEiOJ5zpB1dytybboQhG4+KcH4P5kBq0Rd424ctCF9c1RxZBN/2lV8MU8tTi8IPPG4awnlKSL8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(1076003)(426003)(16526019)(26005)(336012)(2616005)(81166007)(40460700003)(86362001)(36756003)(82740400003)(40480700001)(356005)(83380400001)(2906002)(4326008)(478600001)(7696005)(36860700001)(47076005)(8676002)(6666004)(5660300002)(8936002)(6916009)(316002)(41300700001)(54906003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:34:20.3033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62d931b-78a8-4fff-168e-08dbc8f65a37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Power up/down UMSCH by SMU.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Acked-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 26 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index df513347cb73..7c3356d6da5e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -299,6 +299,29 @@ static int smu_dpm_set_vpe_enable(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_dpm_set_umsch_mm_enable(struct smu_context *smu,
+				   bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (!smu->adev->enable_umsch_mm)
+		return 0;
+
+	if (!smu->ppt_funcs->dpm_set_umsch_mm_enable)
+		return 0;
+
+	if (atomic_read(&power_gate->umsch_mm_gated) ^ enable)
+		return 0;
+
+	ret = smu->ppt_funcs->dpm_set_umsch_mm_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->umsch_mm_gated, !enable);
+
+	return ret;
+}
+
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -1196,6 +1219,7 @@ static int smu_sw_init(void *handle)
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
+	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
 	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
@@ -1549,6 +1573,7 @@ static int smu_hw_init(void *handle)
 		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
+		smu_dpm_set_umsch_mm_enable(smu, true);
 		smu_set_gfx_cgpg(smu, true);
 	}
 
@@ -1726,6 +1751,7 @@ static int smu_hw_fini(void *handle)
 	smu_dpm_set_vcn_enable(smu, false);
 	smu_dpm_set_jpeg_enable(smu, false);
 	smu_dpm_set_vpe_enable(smu, false);
+	smu_dpm_set_umsch_mm_enable(smu, false);
 
 	adev->vcn.cur_state = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 190a2ce38ac1..1454eed76604 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -375,6 +375,7 @@ struct smu_power_gate {
 	atomic_t vcn_gated;
 	atomic_t jpeg_gated;
 	atomic_t vpe_gated;
+	atomic_t umsch_mm_gated;
 };
 
 struct smu_power_context {
-- 
2.41.0

