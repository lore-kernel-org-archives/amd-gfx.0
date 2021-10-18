Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B68FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 07:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A6D610A3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 07:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1A6D610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665B06E97A;
	Mon, 18 Oct 2021 07:35:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA696E97A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 07:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRb3QzH0Uq9ejWsDATcks1RXvQQA53uU7qHY98t8RV6r6Ssr5gOWJ9wF2f2ZLJwy8lZY6zFtxE/8fKqeakNZZy+o4O/rL59HqS6QVbUAX4VA0eoYTYSXv4Bq0Do/a/N8PC3sC4mXEgLHwmyuUVUhE0+S/O1jc1WOuH/NqU7rIDQOXNVbOzS0BN+6p1NGa0X84A8JL7hyg6n73RPmBfV5NYjcBJoDKnjadqQgIMZi7WyrEgBzKJfuAQg8BYXC2HTy/yAEg7ZDmkyq4fZRvQjd2epOwSYCaKlfzzsiX06clJsa1KXyj/7MpdluwP3iArb0x7tOr7NGJLqSgRDFZ4/Eew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g392URAuWlu1tOZXgHv3zVYvoqJGkriMB/yvVhgCfko=;
 b=gAXiNYDk7obBHcQtd+5SiOsd+PKTMxR7RcMyQyykvVXOx/xQTfVuhbzmpB0u62bhY/KG2XUg0QrTmxAWr7zW7o+ix1MtDN24zW2YJTFJubne4vbajfZ1U8iKh/MSSUU5m64YkCEn2eDl5vp4Q+JV1po9E6LpOuevOM1CYpWJjWCaubqDmqL8l4a716civyUTHuUD2YVtJODSJXdYpUmNfJD+dGzYRE7j+pZbYqRXjmKGOgdqo/jmQZzjoRoiYhpBwV7H9YPs3TDqc7Jhyk+677YxNGW5rStNgh62UqWlKYjfSELjbutVL44E3n6nyKT4gwxmakn7Q2ZZiG0UldjDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g392URAuWlu1tOZXgHv3zVYvoqJGkriMB/yvVhgCfko=;
 b=pFc2aVPLnTtzDpaiFRQ1QA76CnXMsCRwlFPrUPZ3FGBhzwjggVIsyU0/c3TzeZ+EgM1R6iTRIDKJK+kjFDsQA+AQfK+BSDnbbdXGvD7y4fVRr+WhFS86Prr5cdZRR04VxhnwNA0qpu63gDLyPZ9nTcpbqp8dR3ubHHLs4qpXSgk=
Received: from DS7PR03CA0292.namprd03.prod.outlook.com (2603:10b6:5:3ad::27)
 by DM5PR12MB1372.namprd12.prod.outlook.com (2603:10b6:3:77::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 07:34:59 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::84) by DS7PR03CA0292.outlook.office365.com
 (2603:10b6:5:3ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Mon, 18 Oct 2021 07:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 07:34:58 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 02:34:56 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <bp@alien8.de>, Evan Quan <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: fix the hang observed on Carrizo due to UVD
 suspend failure
Date: Mon, 18 Oct 2021 15:34:32 +0800
Message-ID: <20211018073432.1525697-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b006121-7a93-44de-8e66-08d99209c9f9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1372:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1372A5F0C975C22C6AEC67F3E4BC9@DM5PR12MB1372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61+En0l92JFo8S33e5ELJr9f5xnteREPcPGjo+9g9V/2HwjQ9uEXyB4DtgGXPTKv6/zmqY6PlsmxQUQ+yhmizeJq/KpQsJThIElRUGIKQXNcA9iAugBkzGf6te0tgunHkEY5aCVB3xeQo6+22AjFJkUtQ0C5Hwz/dWUmf4DlmoqTN332O9vZ9GacdneMSfvDiocEnj/kMBvDEkBj4Q8GeG+K0kk6C4a7dKzvP+K9bDuaWzZpUod2J/RXroiiqJ2OCjSiacn5/Zxqni7rxxKKX/cB1SKyAPHih5Z2XyWdyw+xjbIi11fk0kDHPQMidtKa1+i71l5Gaikv4B5E30iHvt9EHTvO8NIww6eyN9BHXNOwGpRTURbJMHI4HgGn1Ev5ZfTSMHpSuT5xxRO+6OSH7n4UawqXAwQTdvsHJiEQNirEao8G3o4+lUB/O8eIoTiq0EjJa4nxTSBboWAp+Z773mdSBhMWr+lvQ03m2DsqLnYOn476eBvRWjyJQFYAorggMI72Gn3RvVhyB56fsPI4Q9v+cMubCPKOMMWwZMWghIyh9YURND+inCao2TOB5y1j3c97z/dPHNX8otQOpFRTBONKvas6SwCDkZGr+9qOOc4f96N9s23DbM300uKzaK5AXyLQHiwnzFK8slhi3owFKFnrS3ReGnYOs+Xhb+mhkBHFuJ246RP+uy+GmBiVsmOYEbfiAfNXPPRB0g7LDbJi6CccEB4aHWvJs+UE4qYfxZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8676002)(336012)(36860700001)(26005)(6916009)(508600001)(81166007)(5660300002)(70206006)(83380400001)(2616005)(356005)(82310400003)(47076005)(1076003)(16526019)(186003)(7696005)(8936002)(2906002)(36756003)(86362001)(70586007)(44832011)(15650500001)(54906003)(426003)(316002)(6666004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 07:34:58.9702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b006121-7a93-44de-8e66-08d99209c9f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1372
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's confirmed that on some APUs the interaction with SMU(about DPM disablement)
will power off the UVD. That will make the succeeding interactions with UVD on the
suspend path impossible. And the system will hang due to that. To workaround the
issue, we will skip the UVD(or VCE) power off during interaction with SMU for
suspend scenario.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I7804d3835aadbc7cf4b686da4994e83333461748
---
 .../powerplay/hwmgr/smu7_clockpowergating.c   | 20 +++++++++++++++++--
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 16 +++++++++++++--
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |  4 ++--
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
index f2bda3bcbbde..d2c6fe8fe473 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
@@ -57,7 +57,17 @@ static int smu7_update_vce_dpm(struct pp_hwmgr *hwmgr, bool bgate)
 
 int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr)
 {
-	if (phm_cf_want_uvd_power_gating(hwmgr))
+	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
+
+	/*
+	 * Further inactions with UVD are still needed on the suspend path. Thus
+	 * the power off for UVD here should be avoided.
+	 *
+	 * TODO: a better solution is to reorg the action chains performed on suspend
+	 * and make the action here the last one. But that will involve a lot and needs
+	 * MM team's help.
+	 */
+	if (phm_cf_want_uvd_power_gating(hwmgr) && !adev->in_suspend)
 		return smum_send_msg_to_smc(hwmgr,
 				PPSMC_MSG_UVDPowerOFF,
 				NULL);
@@ -82,7 +92,13 @@ static int smu7_powerup_uvd(struct pp_hwmgr *hwmgr)
 
 static int smu7_powerdown_vce(struct pp_hwmgr *hwmgr)
 {
-	if (phm_cf_want_vce_power_gating(hwmgr))
+	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
+
+	/*
+	 * Further inactions with VCE are still needed on the suspend path. Thus
+	 * the power off for VCE here should be avoided.
+	 */
+	if (phm_cf_want_vce_power_gating(hwmgr) && !adev->in_suspend)
 		return smum_send_msg_to_smc(hwmgr,
 				PPSMC_MSG_VCEPowerOFF,
 				NULL);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b94a77e4e714..09e755980c42 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1247,7 +1247,13 @@ static int smu8_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
 
 static int smu8_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)
 {
-	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating))
+	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
+
+	/*
+	 * Further inactions with UVD are still needed on the suspend path. Thus
+	 * the power off for UVD here should be avoided.
+	 */
+	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating) && !adev->in_suspend)
 		return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_UVDPowerOFF, NULL);
 	return 0;
 }
@@ -1301,7 +1307,13 @@ static int  smu8_dpm_update_vce_dpm(struct pp_hwmgr *hwmgr)
 
 static int smu8_dpm_powerdown_vce(struct pp_hwmgr *hwmgr)
 {
-	if (PP_CAP(PHM_PlatformCaps_VCEPowerGating))
+	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
+
+	/*
+	 * Further inactions with VCE are still needed on the suspend path. Thus
+	 * the power off for VCE here should be avoided.
+	 */
+	if (PP_CAP(PHM_PlatformCaps_VCEPowerGating) && !adev->in_suspend)
 		return smum_send_msg_to_smc(hwmgr,
 					    PPSMC_MSG_VCEPowerOFF,
 					    NULL);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index bcae42cef374..4e9c9da255a7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -1683,7 +1683,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_PG_STATE_GATE);
 		kv_update_uvd_dpm(adev, gate);
-		if (pi->caps_uvd_pg)
+		if (pi->caps_uvd_pg && !adev->in_suspend)
 			/* power off the UVD block */
 			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_UVDPowerOFF);
 	} else {
@@ -1710,7 +1710,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_PG_STATE_GATE);
 		kv_enable_vce_dpm(adev, false);
-		if (pi->caps_vce_pg) /* power off the VCE block */
+		if (pi->caps_vce_pg && !adev->in_suspend) /* power off the VCE block */
 			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
 	} else {
 		if (pi->caps_vce_pg) /* power on the VCE block */
-- 
2.29.0

