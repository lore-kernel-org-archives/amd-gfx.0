Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2428C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 22:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3308710ED4E;
	Thu,  3 Feb 2022 22:15:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A2B10ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 22:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gjf89GrJxY8eqtG8sAltrmZ4fk/hN+ubxBG/5qqVziC6rPDgf8RzkJhqvmBtdGrCuponAd9alk6oZ6lTSS6JnTD1yChYHkUQThHkb1s4Yy9zZzteOo5VeRJe+4dxwNo8wjacpo9fPEu2O4Mu3pGw6TUCQExPBgncN4lCcfIoFKjYzZukp1XhNzveQJygQ661SPUccSr7mNgzNQoa9rc6WuOhCWKH3Q6eziv0JnuZsq07rs6bisLrIwePsangkmZrC9WBopN9VO4YyI5XBuhrbWHWyi4As9clOF0Gr+dBgW6gJoYUbrUAOTUZgmCinZPHT13DPPULOqiWtYsY2bld4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXx4uGIg8R4T8g4zsItMXLumtuCrHlFi4fio1EzWlPw=;
 b=Tebn3TBuLDTcS4/sdXDVdVOBBmcZd4FkFr6KfcTTgP9zlbVKMMUm12vCZR3PPCztVBtQfuhL7bdCMWp6ptg18l5hOWERr73Znd33cxFDpDQXWLgseDnThxkZvudRvsGbShPSSb+iDSIjZ8tGUOnGyt04trDf6kF5dgvllGxcA5L5tisD9QS21hy7c6kqIioS9dPkOa+GMcTEIlmrzS0R67jSxqSeYupFpgU2dWkFat+Cy2sQEnmg2cMz30Nj2yk8iUMpYftwmtL/RIJS4tPuWHX3ewVXp2pfMWThbHBRYrF6TS/N2HVBPeHsrwqkRkUiHlITIbP2IEK5lUSu6PiBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXx4uGIg8R4T8g4zsItMXLumtuCrHlFi4fio1EzWlPw=;
 b=FFVdsKR3QYuBqUUf4pxE2SVSep8rKMvYn2AhoMQ7BU++hj18MQ3Wio34fk4jy1ieKoH8nop1qFpY2DiEH4ZjsB77dtkkuXRc/A18VufXyMw2fRTNWlXCMYhqtGdWoxyVZCj8vh9tVylvX4qchDAe0gdLBhwlUvEpC64L1v4sp24=
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by MN2PR12MB3965.namprd12.prod.outlook.com (2603:10b6:208:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Thu, 3 Feb
 2022 22:14:58 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::ca) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 22:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 22:14:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 16:14:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 16:14:55 -0600
Received: from roma-lnx-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Feb 2022 16:14:54 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <nicholas.kazlauskas@amd.com>, <hersenxs.wu@amd.com>, <shirish.s@amd.com>,
 <Jordan.Lazare@amd.com>
Subject: [PATCH] drm/amd/display: Cap pflip irqs per max otg number
Date: Thu, 3 Feb 2022 17:14:42 -0500
Message-ID: <1643926482-17226-1-git-send-email-Roman.Li@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53693dba-132c-4eb7-7a2f-08d9e7629ce4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3965:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3965C3B1088D3ED6CECA059189289@MN2PR12MB3965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tv/nNm9aFrsURoJPDuVF0ZxoOgQs2XilfCwHFHK2aNqjtotS0Hc+Z5GSoZqJpD+ejVeGQkP4qFiuth5viRKIEJWJvnlTkkaODEgz1a3Z8BkXGlgJDNBkhWWRiUKs9CiXGBBhVXAuj/n/W0JfIg1+Quyq8Z3gPGD75Qp7GHfg7fTRdL6fxkRTXKXdACtn+YJJCY7ArOv5EDBijolkXMh3d8gBmkp3IKeJ3TkJKO3CQyARmUkjObd4m3VYvHo/FisUaKGUHnDES1j7D9eQejCUHRsErrmjPTRZGIdPODdRiFYnLHc5HUY0jfjAPBc23DT54D47sKEtMrHwtsINfokR4fDKummwmeBKYdfuWvKTxNkTkCBMUg0KrVwQxoS8kE0nvm8phsO+OIZULIml/nmrrs9A8u+ROeAmWOxIogxkABaZbLQRCixbJ6oEVo5YpnKjJ6aa3026oxpiqEFC2VZhA6KsY35o5hmWa6ZFekD+E2UB4oI8e2zn2zAtBDtgogMmooVMFEK4rcYbnael1kuLiBT4or3xmlGo6GXNEZpRIM4eh9f41XhQQxrjKLpkCFARBAS1E04uC2RjYjhJJ5SMS8INToWv4fFT5LRP1pg6JbqsM/hXOX0uwg6fO8xlU6rwDNK87iibXu8urAK8sUPVKZCfcbMs1p+1+jwY1dXYE+HHyc9bD1ZlxsE4rzG0exm/7c/APwmSPl4oe44HXzXvMwdshnGKaRiwsliV3db8mjc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(356005)(186003)(36860700001)(2616005)(2876002)(81166007)(336012)(2906002)(82310400004)(26005)(83380400001)(6666004)(7696005)(8676002)(40460700003)(5660300002)(6636002)(316002)(508600001)(110136005)(4326008)(8936002)(70206006)(47076005)(86362001)(36756003)(70586007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 22:14:57.2635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53693dba-132c-4eb7-7a2f-08d9e7629ce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3965
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
Cc: Roman Li <Roman.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
pflip interrupt order are mapped 1 to 1 to otg id.
e.g. if irq_src=26 corresponds to otg0 then 27->otg1, 28->otg2...

Linux DM registers pflip interrupts per number of crtcs.
In fused pipe case crtc numbers can be less than otg id.

e.g. if one pipe out of 3(otg#0-2) is fused adev->mode_info.num_crtc=2
so DM only registers irq_src 26,27.
This is a bug since if pipe#2 remains unfused DM never gets
otg2 pflip interrupt (irq_src=28)
That may results in gfx failure due to pflip timeout.

[How]
Register pflip interrupts per max num of otg instead of num_crtc

Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 2 ++
 drivers/gpu/drm/amd/display/dc/dc.h               | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8f53c9f..10ca3fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3646,7 +3646,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 
 	/* Use GRPH_PFLIP interrupt */
 	for (i = DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT;
-			i <= DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT + adev->mode_info.num_crtc - 1;
+			i <= DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT + dc->caps.max_otg_num - 1;
 			i++) {
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->pageflip_irq);
 		if (r) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1d9404f..70a0b89 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1220,6 +1220,8 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 
 		dc->caps.max_dp_protocol_version = DP_VERSION_1_4;
 
+		dc->caps.max_otg_num = dc->res_pool->res_cap->num_timing_generator;
+
 		if (dc->res_pool->dmcu != NULL)
 			dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 69d264d..af05877 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -200,6 +200,7 @@ struct dc_caps {
 	bool edp_dsc_support;
 	bool vbios_lttpr_aware;
 	bool vbios_lttpr_enable;
+	uint32_t max_otg_num;
 };
 
 struct dc_bug_wa {
-- 
2.7.4

