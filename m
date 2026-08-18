Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE676C5DF8E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6386E10ECC7;
	Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJtdxqkz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFD110E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/ROH3TFa0tP1KRsLOMeNFBAdxxBA43N8O4HnbyMaRnQLUd11D1fbcnDoNYmyUqBbkJURyak1zvRhzsWbk+QZioMRp3z9Vg3HJL/gq1Hjn/nqWxJRIG7KWN2Vi9QaeCacpbSWzUJD8mMquXe5So+IzshvXwljnbPT7NC1+RAsFoLP8ejD0eril79VSS7/jYSIEbCl4JOEfay1/bIzsv1eQ1v2GUfHVjQf4EkiYBKiUOtHWjwdiufoQ+5VmpRci+ORyTWFIhtkl8n41r94rqtA0BxoNcIBxPoGgFpNhD0+kxbLqhmrqBPQ6R6AahcTAk8LIBmpnT1DTswCgIElyuI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRE7dRn1OLRxDhtrIeh+CaF0Wv6kNA+7zvtXreUbf+U=;
 b=NlEHh0/0qKuzMfsM0a7YyqXYFmpalIZe7tl26YQRJJqKcRDPj/WDiPvOEBzCJkbdYGyC7QB6k8d3LZef7B7kxZL+n5lxKkH20kXSxKmGtG4CdejvCczisKVvjclLN2B7Pz/rW77eQ5apwY80ufQH8au4ssBvOOCsfr9SXvETtM4+I9QYamwRgg85K0s4vCoWDvc6W6IeoBUfAz6NsSeEeejCjUNWUNO1ASQ4uO8Qi2dobBZNeAlXYPELcEyTc5Qms0Qv7BI8orbqxVR+mtyJjrCZ0fHkxcXwMHYBxgXDBl+xiBkW9knnfd8dDbyyJKKJTyahegqSubPUN6NbaoeAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRE7dRn1OLRxDhtrIeh+CaF0Wv6kNA+7zvtXreUbf+U=;
 b=MJtdxqkztls8vJrb5hRD0jCqcV6hKKz6ZCW4K3njz/Lqh/7GiztTntEhjgY3+KQWurWp8RfCV/NSIHxJmriVSk4cF0Do8hKzFz29oBXLaYws0J56cph+Htw+VEfETkrnzo4DONpCu92xMDuVd0MOek7DAvEoknPRO+Vp0GW5QC8=
Received: from BN9PR03CA0566.namprd03.prod.outlook.com (2603:10b6:408:138::31)
 by SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:50 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::8a) by BN9PR03CA0566.outlook.office365.com
 (2603:10b6:408:138::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:49 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:48 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 74/82] drm/amd/display: Refactor hdmi_frl_status_polling_work
 for Kunit testing
Date: Tue, 18 Aug 2026 16:16:06 -0400
Message-ID: <20260818202139.4172592-75-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SA5PPF80B25317E:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb38c37-039f-45ba-eb26-08defd66799a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: xoZSdiOPP0mobxOJEJ8ezmhSpz4NO8Zjpw8ODrNc8sCOUkhU90DaIusq/3wCp2t/UdMA5KzCC3Nao5J+tctYAuAeRqJlC9fJqiabPyin2mF1y+gkdXWFFwZAA36JXWxcsqzNu003FDkQ4mjVkwK0cu8SZbVPHiUhVU5sgnZoqBUQNclRW3pvUH0Pwiirklzo7GcFvbKLD6D28mE1N5Gm7xBxvNnKZ4IEs9/n1IiJSCJUcvbb6yV/0sN8/UxYQqBLA9WDoiWEWbgtk9NgGinNbtbbbRU/I+yvkeam3A8Ms0VzcSiQSf5lsUmCVWlG7ueuzPdbMZcCDc23/uBvDAAHbhVGePmVoEsIzeOvSqYOY0qYC9//vOuel0J1/WfxZD/KYMLJAjRSLYwwcGfxLxNs2Xtc1yNZKf1lWcXMv31OH/RIY3hpMyN1JVgKYHTe4iPH0vXF0onIpXU1Ln5Cb6stSUpG7ff5bvmQoH1FG9lJqCb2R/fw4D16os8Bc8aSENo1/U9KHvUdDEKSW6WuIy0ws5UBYHlwJo0/2b7WX5ldUU3Gdk79bYVXHsoJyKrjmd+V+MTpZUixUdb+4wgBcgQOZPCWwcbEA5b0uQ9GGGGRzIM5Zs+t6k8z59fBvVkhFX7L2sDFYk8vVfNyaOQBArD9fKlO7/cTE2hKaGUM7AhgTGlxPB+LJs8tlkjyi6Pihzcd026mzX1Cs6d6BciE5XdufQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eyeKJXDZR0/zfmFH7riijUcQOsFc28kgIM8B5LAS5O4wJiyMErmT4zWn+0c0hsO6orTtWz9fre/+zt1EC49t3HiZuzb696zOQh/FxBKjHMbo61MNz+2mCBr/dpO6Igu1M58lsGL4Zh0fugAI0JOs0CU8R1Owksng4Jl9/GTvK06z76RW8slNukXuF2uAdo0BvPBr8q7obIE8FRugEbfIxBc7zzl2a+dEZgevplDqnlZk2r4jIe7bthX18jF7q7TVlo58MHCPmvdnz9Lch7pgLuOWJ5L5GZzjq1+5opmmU6BmOwrStfubpU6kv7MhHYx+7ZirCyc8H7QqOgY5zYn/sGzzmyOqoXM82FhbtwnhBOPd7RBTV41E+RtdM7EaPWXB1oPzhP2m8Va+CF1Qc/acv7UMLk97bD0BN5WvgO2Mxsc+WG+286z31d5FwXLpXJFO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:50.1434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb38c37-039f-45ba-eb26-08defd66799a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF80B25317E
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
The KUnit connector test references hdmi_frl_status_polling_work(), but the
function was static with no visible prototype, causing a build failure
(undeclared / implicit declaration). Make the function non-static and add
a prototype to amdgpu_dm_connector.h so the test can reference it. The
INIT_DELAYED_WORK setup remains in amdgpu_dm_connector_init_helper(); no
runtime behavior change.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index a473218f4d75c..13f9ed0220c37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3087,7 +3087,7 @@ static const u32 supported_colorspaces =
 	BIT(DRM_MODE_COLORIMETRY_BT2020_RGB) |
 	BIT(DRM_MODE_COLORIMETRY_BT2020_YCC);
 
-static void hdmi_frl_status_polling_work(struct work_struct *work)
+void hdmi_frl_status_polling_work(struct work_struct *work)
 {
 	struct amdgpu_display_manager *dm =
 		container_of(to_delayed_work(work), struct amdgpu_display_manager,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index a86d5c879b646..6732e5e644cda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -71,6 +71,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				     struct dc_link *link,
 				     int link_index);
 
+void hdmi_frl_status_polling_work(struct work_struct *work);
+
 enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
 						    const struct drm_display_mode *mode);
 
-- 
2.43.0

