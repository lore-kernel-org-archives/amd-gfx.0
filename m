Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27472C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 08:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD96F6109F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 08:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD96F6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762B06EACA;
	Thu,  4 Nov 2021 08:19:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417E06EAC5
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 08:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmNHNii4jub4co3BHEWUgzet+ipE1HZkYfEcULhJT6ec0o7kndISxJtN9wqluWaHhHHnW/9KaDhvGkLb3PsY2HSfgKwwyzs3rFVZ1OSnvP7al+ulbSEGTyijNVXHqY3swEJ628uHGnhg4vBqyRZdjZj25JMf1pixtYntajbx2cGrhYNG3NhdQZ7dQ/AzNIgWX8dyAEUWV5OU6iR2sLw//RMQdCLmg+nA5+eSQGMiWFupfWERwobzkfNNDw7YmmZOjN/Mu5JK0TglRyjUI8SjHShCxUCR2dK3IojV8mVi4LyQv3SRFcJcigL9MIfusQI5Klk0RIVHVlGDaFGGNI2ShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9KNFnvmZOfhTrtr7cATP/M3MwA278RLuGyU4f6O9Qo=;
 b=IG3ostBjzpVmcZnNPGnzdofbCNx76tfI8CBectHwk5AP1AN23vnXpTqfp5ZY9Jf+SjQ1oj98CJ+rEIEsKZ1L24BS3Pg27C8LAWMnLspmn6CGn1QBVfOqKupE0/UiHKbUsshesCs6Oge86w4H8G0h9TFcboOHf+PRug3skTVLjp5tSUwGqxlBe9rtTfWMlXbWEVxKHsKSrAm/Z/Dml7bQcWvsTmXW9f1PxB87jNT7xhXX6xQ22Yse5w0J+QPzgi2Ih3DYjuyZVmfgfA2LL333ZWRoGF6LNdfpsv4tVf9GEkyFIsjYNPsNjsFUCfn4wGHVH5kEpKlneZW1hJvlHwBjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9KNFnvmZOfhTrtr7cATP/M3MwA278RLuGyU4f6O9Qo=;
 b=jXh6o1dgllQSNBH2J8jsRvmEQIoCD0yHDBPRz4cI6VjTqEgpjU3yHesTTHMe4GWWH45t0lIArq8tNTx8t9gLMz2XWVZEjRGivUs5ZzLw7tFX4R64hl66rfTMkZP3/S3oV6I7Nf89Bc+WkSwnVsW5qv5fte9QVNmWHXwV6cPn8K0=
Received: from DM5PR17CA0062.namprd17.prod.outlook.com (2603:10b6:3:13f::24)
 by MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 08:19:48 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::cd) by DM5PR17CA0062.outlook.office365.com
 (2603:10b6:3:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 08:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 08:19:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 03:19:45 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix the Carrizo UVD hang on system reboot
Date: Thu, 4 Nov 2021 16:19:31 +0800
Message-ID: <20211104081931.467399-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7d8195b-2502-459b-9c21-08d99f6bdde3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2586:
X-Microsoft-Antispam-PRVS: <MW2PR12MB258657D750DFA62B65D7487FE48D9@MW2PR12MB2586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxCLXQBg6N7E10Z6vTGUC5ddBK44xhni8U4MMIFLL4uWQfxUC2CnwuYbTn2sUogyVGUAsaKPaJaNB3CMrFkch/Ssrwyj2zIzyrTYkvD/0Wh3aN5ZiqcBlhusWTJvMEC7OvgcBpnO5GIS2+Mxx+rfI48glo04GlvxEIsXPbAS+OcV7DnmxYVJ8ip7j732RxGGKpjspgl8B0544wIeMjMCymiNtctF7jGASKzC1RgeqmuobrtoYsghPjkzJcVVW7RualYxoMLZRXiRgaBzIR1mJHLGxRaEmV1dPj1k00NBfnE1nhfjRs4AM3s/BMhBXnu9jHq6qkplyi7SBt1G1V3KM0AO/Kq41Y6uilr0iITfHmc7CJCr3x32n6qCkiPOR3uo4nhQ43x7pTvJRsoHq0u3TF26NcUa8bfQcxcbNmXbHDNQEoPWmJKFlFolVh9ExQ+UE+r+tshfec8xguGSnDaZhmc0Jm2jFlhIF39ybbHuMVjD4aMK487ITU2NAAPqc85Cve5U/Q1TNwIonq4QiREk+pU9fBAkDpyJFoHk+bd7xRZO+5GmQK5A6JFZftNbdPO4VLaPNncK5O0FM3j7yidHYeNBDvk6G2e9OrkMK3w9hJZu2Z0PaehwmQYASVupoy6WGP13TlqOOoKPgqlmwqX0+tDb8JUqt/wkERZaGSLhIEf3NVjCxj0qkWxu3+8tpWYS/PKoW5pI3vZxjeYReIPHsOojZCoCC/lPMb7e7Y7tbjs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(44832011)(86362001)(5660300002)(54906003)(16526019)(186003)(2616005)(36756003)(8676002)(426003)(356005)(508600001)(6666004)(26005)(336012)(82310400003)(81166007)(6916009)(47076005)(316002)(36860700001)(4326008)(1076003)(70586007)(70206006)(83380400001)(8936002)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 08:19:48.1794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d8195b-2502-459b-9c21-08d99f6bdde3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2586
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
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's confirmed that on some APUs the interaction with SMU about DPM disablement
will power off the UVD completely. Thus the succeeding interactions with UVD
during the reboot will trigger hard hang. To workaround this issue, we will skip
the dpm disablement on APUs.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I4340cc2fb0fd94f439cbac5d4963fe920866bc13
---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 20 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 30 +++++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 18 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 +++++++++-------
 4 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index c108b8381795..67ec13622e51 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -238,15 +238,17 @@ static int uvd_v4_2_suspend(void *handle)
 	 */
 	cancel_delayed_work_sync(&adev->uvd.idle_work);
 
-	if (adev->pm.dpm_enabled) {
-		amdgpu_dpm_enable_uvd(adev, false);
-	} else {
-		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
-		/* shutdown the UVD block */
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
-		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_CG_STATE_GATE);
+	if (!(adev->flags & AMD_IS_APU)) {
+		if (adev->pm.dpm_enabled) {
+			amdgpu_dpm_enable_uvd(adev, false);
+		} else {
+			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+			/* shutdown the UVD block */
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+							       AMD_PG_STATE_GATE);
+			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+							       AMD_CG_STATE_GATE);
+		}
 	}
 
 	r = uvd_v4_2_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 2d558c2f417d..60d05ec8c953 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -560,15 +560,27 @@ static int uvd_v6_0_suspend(void *handle)
 	 */
 	cancel_delayed_work_sync(&adev->uvd.idle_work);
 
-	if (adev->pm.dpm_enabled) {
-		amdgpu_dpm_enable_uvd(adev, false);
-	} else {
-		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
-		/* shutdown the UVD block */
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
-		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_CG_STATE_GATE);
+	/*
+	 * It's confirmed that on some APUs the interaction with SMU(about DPM disablement)
+	 * will power off the UVD. That will make the succeeding interactions with UVD on the
+	 * suspend path impossible. And the system will hang due to that. To workaround the
+	 * issue, we will skip the dpm disablement on APUs.
+	 *
+	 * TODO: a better solution is to reorg the action chains performed on suspend and make
+	 * the dpm disablement the last one. But that will involve a lot and needs MM team's
+	 * help.
+	 */
+	if (!(adev->flags & AMD_IS_APU)) {
+		if (adev->pm.dpm_enabled) {
+			amdgpu_dpm_enable_uvd(adev, false);
+		} else {
+			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+			/* shutdown the UVD block */
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+							       AMD_PG_STATE_GATE);
+			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+							       AMD_CG_STATE_GATE);
+		}
 	}
 
 	r = uvd_v6_0_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 67eb01fef789..8aa9d8c07053 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -505,14 +505,16 @@ static int vce_v2_0_suspend(void *handle)
 	 */
 	cancel_delayed_work_sync(&adev->vce.idle_work);
 
-	if (adev->pm.dpm_enabled) {
-		amdgpu_dpm_enable_vce(adev, false);
-	} else {
-		amdgpu_asic_set_vce_clocks(adev, 0, 0);
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
-		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_CG_STATE_GATE);
+	if (!(adev->flags & AMD_IS_APU)) {
+		if (adev->pm.dpm_enabled) {
+			amdgpu_dpm_enable_vce(adev, false);
+		} else {
+			amdgpu_asic_set_vce_clocks(adev, 0, 0);
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+							       AMD_PG_STATE_GATE);
+			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+							       AMD_CG_STATE_GATE);
+		}
 	}
 
 	r = vce_v2_0_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 142e291983b4..b177cd442838 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -520,14 +520,16 @@ static int vce_v3_0_suspend(void *handle)
 	 */
 	cancel_delayed_work_sync(&adev->vce.idle_work);
 
-	if (adev->pm.dpm_enabled) {
-		amdgpu_dpm_enable_vce(adev, false);
-	} else {
-		amdgpu_asic_set_vce_clocks(adev, 0, 0);
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
-		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_CG_STATE_GATE);
+	if (!(adev->flags & AMD_IS_APU)) {
+		if (adev->pm.dpm_enabled) {
+			amdgpu_dpm_enable_vce(adev, false);
+		} else {
+			amdgpu_asic_set_vce_clocks(adev, 0, 0);
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+							       AMD_PG_STATE_GATE);
+			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+							       AMD_CG_STATE_GATE);
+		}
 	}
 
 	r = vce_v3_0_hw_fini(adev);
-- 
2.29.0

