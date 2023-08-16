Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB4AC27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE49E10E3CB;
	Wed, 16 Aug 2023 21:31:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B23D10E3CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfoxgaO+GsTU6/a/FOPNTttV2BRglPWg/T/n7des3AZHe+6n80h6Aubbe7yahUi0jjhDzUxsC6HjTm76XOaYroDgYweb44BYwfsNpj0e9f05uWz4/KGBfKR6IW1RA9ViWIZsHc7GxWwPyCQKA3MzYL6VmYzNMdbvL43BbvfYLDmSyTusGeSpi3+NUeY/vUXGG+rsgeyYEUsfB11Hr0zNAcpcpKr2MojASWsdrn1ZhNechMs30O5jS9zWaxqPJMdNEtLJxaZb8REA//BdTtq3deSJTaFjN9h1Ouj55eQlGm7h/p4MuuVlUMlcbgV8S6EwIKO/YrAvoNNxiuNuRaq4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZiWmi9U/bRB5/jXWdEe/FVSMlVM5MaDSODL/9ExOkI=;
 b=LMG3/UjdDN4gXfRCXWsSeFFQJgBPCSr51klBtPy4a4RlLAOvfzFQPgOlPlo2ddEnQGHhOahs86IFAdOjFXkbW6p3MH06dpTb5W40jnCrhMCnNtpXxPqpq3Ic6kws7+f6xUg6rCW3JtfwaTlikH429BhVyt/Zq/gy+hd55mW0U3fI7Irewb6qXqj7BPLkLLrzTM9rXc+wMBm7asEqF+Ze177Qaa/E1fsPo4TmPMHOj21ecGGVF9TusaljRJx9pv2aGvwwEczWKMewf0G+Gb9QJEFRBIYb8e7iEidrudadUe55Wi7s39nEvqcLuievPDYVrLVKlS+zv91C+dlqDQtkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZiWmi9U/bRB5/jXWdEe/FVSMlVM5MaDSODL/9ExOkI=;
 b=dc4yDLF/M2FZv9EO8YmPa1vTXWF7mb1dJuDHAIh5XoxdPumUpGUuglV4SRN55XEawasTrySJeFsDp7++JNAL26XHr13qdyJKh4cUupyjtXtf16kqEhguxuZZ2jFpcf6Q7Ts6Q3nBYtTXmgSNdhMOnXUDuusiNNdpCH/oqRJgd7I=
Received: from DS7PR03CA0155.namprd03.prod.outlook.com (2603:10b6:5:3b2::10)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:31:42 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::b) by DS7PR03CA0155.outlook.office365.com
 (2603:10b6:5:3b2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:31:42 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:31:40 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/18] drm/amd/display: Add writeback enable field (wb_enabled)
Date: Wed, 16 Aug 2023 15:26:23 -0600
Message-ID: <20230816212626.987519-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b315eff-4c97-4759-df2b-08db9ea02ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNlpWGUEezMIpfhFzCNrtSIepeKqCy2iw8+GCC22fM3wuY/wTvcqOVvuCUv9MnXHFmV37hj0g/+zbKyHJzob6o0vdk4AyqPBx12Fr+/L6nexOYWIAeHHuxvNYyQwUBbR+a2PMLFgi7pQ1SlGOoL4Mhi4GheEy98uKEgF1PygRUNgZoGFU7Hny9QuhvI/w81wIaB5gh7/oPcSVzgdywHINL3/GUsTHyQNWOjO0JQmYWnwGcJ0KMdhxWpP0CQkfQyJ2OZXL+908w8OF2M9hya5HM/vajxI0pKEtG4cVpdV3LaImdf3CyyNDSbEDfyeRsZbYelY1d5eCtFQVIK8xmLCBH5av/zSb5zl4I3Pf1tAkIPgqI2tO3oRorAyOTYBVshcx+PfAbgYcFe+WrIqQnvuHRvG/1FlCEdo6iqDx4pHj31+xjQEkMfLDL5yH0VSG+/Oo1Fwc6pM+LqqVhODWoVhfVJSBt8VSHDZO2N5VP1crBAaSMGo5PVtScsVCiz9greHjRB7lqNw7dyzIxiRhBglGU/udohia8Rti6sfxVgJzMhLQzSXaS34+SoJMUE/+5aGfLLOop6y+i4yrILoogsDN6J/5m3FGTTzM9l0MjdhG5VEtY4pEBuGCM1+drJFFDimAIsWyce9XexRKbB4gJvtRe0yHl7i83QCkaYfxe3qznUhu08sb5NYEXncPILrz+1AFPVj8bvf4orARd4+eKualXLL2fbsxUkgbfJ88HYt8YHCveC1wlyzv7So9xefTko2AIY+S8KVUL+oyoKvyInFBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:31:42.2072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b315eff-4c97-4759-df2b-08db9ea02ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHAT]
Add a new field to keep track whether a crtc is previously
writeback-enabled.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h          | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index a166d7684719..d8083972e393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -418,6 +418,7 @@ struct amdgpu_crtc {
 	struct drm_pending_vblank_event *event;
 
 	bool wb_pending;
+	bool wb_enabled;
 	struct drm_writeback_connector *wb_conn;
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fdfcafbaa668..e9efeb62d6b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8569,9 +8569,13 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		if (acrtc)
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 
+		if (!acrtc->wb_enabled)
+			continue;
+
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
 		dm_clear_writeback(dm, dm_old_crtc_state);
+		acrtc->wb_enabled = false;
 	}
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
@@ -9136,9 +9140,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		if (acrtc)
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 
+		if (acrtc->wb_enabled)
+			continue;
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
 		dm_set_writeback(dm, dm_new_crtc_state, connector, new_con_state);
+		acrtc->wb_enabled = true;
 	}
 
 	/* Update audio instances for each connector. */
-- 
2.41.0

