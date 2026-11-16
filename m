Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B3606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uubpTlL9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B96910F830;
	Tue, 17 Nov 2026 17:15:34 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA4D10F830
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uN7qtk7nKUSvWc6PnxcV776KhEI9HXO1GxaGPvQAIUaGAHzp6+yXKuI+qRpiBCPCdJfTlxCwDOqU69WBn/yVL2iIMqmEpXw7z/6ut4EumK+iGPVaZZ+uqM11/HlbGaTFFcDNa5vZNW7Zj+VJg6e0Q4u82rrowvRVHoLNOAkuN2fG/4BFdrlhZjLTieLIwshGDbDKI/ne3QoT2mtW9eY1CBbf+MTYfViGdkX+AGpVoLiwRsKSjrdVDbgIX3huKchaewHk1UhmSjq6Zz4+I/j6N10mrquooO6qajLN36ZQv2CLtEyAByONNxUgJ5ak5wLGdftU+bHQ+XEU9YY8rs1ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbWpvIh5/2afOlvjjc2eQkR9QSoB3bCv1w7YM6VmlUY=;
 b=E1xESHx1uDqP2CWiWYBtpM4OVhlISyKYfFgQLUlBbxj6L5R6pP2M22RxQp2lPcYnbrkNbVRR4ZGzqSglD6MIJlGIbAyXJkO5rNTBnf6yf5F1mFeM8Xj3yZu7VvuwsIvMQoGAWGHxhjZRh1ChGgI5ijYNepGi8zWZ3to9msuUO44e1GmKaq4JstC11wVPt6ge0KEaIPeAg1BCpatV8wVA+czotnV67zt4yQP8Xq+ts4Has3DbUbwJEFW87scHwL0bVQgC2zpEZMcH9uvg0TJM//TVd5+3mIc+mi9dbmje8ZSvOz0OtYre3e8UsFf5WJfDVL9zLIm24AvZnw+xJv3B6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbWpvIh5/2afOlvjjc2eQkR9QSoB3bCv1w7YM6VmlUY=;
 b=uubpTlL9tfkLePUv5hXllVxLGys4rjERQugP1KthaA59/FdfT/IGXyEP0SNLeHXBLO6G28F1whxV/RKDWq6+mJL7RuI0oCkQfoyXllD5yiO3y525plK5eDnq40Isi76vOukdNXOFShdGxWmC0Pz1MqCJ5hT9EgZnSzFhWGwYXtM=
Received: from MN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:52f::23)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:15:22 +0000
Received: from BN1PEPF00018070.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::78) by MN0PR03CA0026.outlook.office365.com
 (2603:10b6:208:52f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:15:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018070.mail.protection.outlook.com (10.167.245.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:15:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:10 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:15:01 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 18/33] drm/amd/display: Set stream min/max refresh from VRR
 config
Date: Tue, 17 Nov 2026 05:50:55 +0800
Message-ID: <20261116215641.2800595-19-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018070:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f209ef-47f8-4aa9-c994-08df44ce5bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: xD2o1S+C+HIiNvrN6QqN/Z1zUBLglQ4C3CbHe5120CMToC6W6JlfVRYAGRIZbIMkWRtFmfBNCtjBk9YJrAtyW7P2vmh1V6zE6NiXBlCZVAUQDG1roS1LxmaB/d9c+UKCG4jeVFeL6y46wNx89Dn/j4pSB6giUU1HOArQXmQsd3NioPhSJc9DG/JrpidfZ5KHHIknjWPOWDZKDFQtBtf6b4rrydCWDf0QBVqIHqBDW3CcfwB/VSiWumGmlO0JVBdBgRxqYh65Hwev8cNdXIPNxK7gPEOQGV0Dcs6LKnWHxqBwJiEF8HNJ4szOqHtGQmd4tTPCPx9AASinALawp6g11fryMn7ZBPP3hqcZhGQZet7dXiTO1RT/GzR8BItT7FdZ+wYNCZ8HyUbxG4Un+GFsux/EJLyfakC3tYMQbi4ZHrajHxabm8iWDf73ADBqcJPuudgPg4uIc0GXj+JMqxTOcsP0xzF/GN/23JiNg+2BmxGzukl9HsiCF49HLQwY9dKaVPVycAOpiuE8KXOBlan/lZgmT+Ls2ROfVYYRlxrgw6uJ27Qv9cJ3lBG44YJ6QZlmLlQdAa/lj5SUJm5Kjr+lcYzEMDEMDU1NZqm2Ik9mQ7sZcpzIMTULo/o6M4O7C4kz3zebkKegCHXSi/CZOY3Mbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VtgFlpr88eqwJ0fRSQ9JnYzlmK7GRaeFIdJA/76j0prikVnZ3/K8oX1RX/+nsVi5gwp9brBNTkyaL65mKoXUhZtgYPRlIjhhS0jDS56p3j5r2DQfr/sunoROupRaDBziXEQJi1cmRh2/QM59J8K6x4hkHCwtGsnwSao5PqwKG1kpdr2friFaEaKq+jeQIxFXKycUMNsB1WEmJJS6OJOiFE6OAneCx7MaEryuPWKgnsWaqpGK/UZYJoVAOIn/gQyRF2tDDZmIuKwv7hIJXeyw63pwp2cINNlwUjB78+lStFuimr7Z8o/cRP0pwlepCPgPet1QI8V9J38K7P31d0NEhFxODqr1Gs2axga2ql0oE7nVUOxulDwC92RMGZippgipGbzIiUw+pZnM3oFADD6bGQsx1LR+o/3rc+u57aMPU34GpEsWUKqhGZdm1MFqqTHb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:15:20.2104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f209ef-47f8-4aa9-c994-08df44ce5bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018070.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
FAMS2 on DCN6 uses the stream's max_vtotal to estimate the DRR prepare
time against the remaining PPT window before allowing a UCLK switch.
amdgpu_dm never set stream->timing.min/max_refresh_in_uhz, so DML
derived max_vtotal from the HW vtotal limit (~0x7FFF), causing DMUB to
incorrectly reject P-state switches.

[How]
Populate stream timing min/max refresh from the freesync config when
VRR is supported.

Cc: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 40f1dd8af21c..78dbdbce8c04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -187,6 +187,9 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 		config.vsif_supported = true;
 		config.btr = true;
 
+		new_crtc_state->stream->timing.min_refresh_in_uhz = config.min_refresh_in_uhz;
+		new_crtc_state->stream->timing.max_refresh_in_uhz = config.max_refresh_in_uhz;
+
 		if (fs_vid_mode) {
 			config.state = VRR_STATE_ACTIVE_FIXED;
 			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
-- 
2.43.0

