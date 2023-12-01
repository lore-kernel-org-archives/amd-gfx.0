Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2842C07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3394D10E89A;
	Fri,  1 Dec 2023 13:29:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAF510E897
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2iaSavBUeh+u8G9q16TX/3D6PpbN7l/++OakUB46/Z0LRO0C152GAhXtsV/U4nrpgGjIjyAOrXiiqUaX0As7Llpek9rOsr07bb9wfpXMYpY5rWyM1O3xqrxpDcMPlW2P1kShZ2EKQ13G3x7Zv1HIpSedv1ldkEHpmXpZ8S8J0djUnyqB6XyutO1Jb2Gg0Ty8UDDYfD0mXMq/oqjEwMpcgh2VY4iEBd31CJ9ssT9NuW/CaX8F0Ay2T/dXDrLgWzx/rrR4s+hSgXrOgg/cJmGoH6Xg6q5SA3I4WY9vhbIkYiqenmQj3m+O9UjMUgLg0DTJki+kgmydvdL4iY7YX9poA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hDVtAWqbz9zCNZbA2rO1n9JDNM6NBD91nsIlXxM2sw=;
 b=FlI6PC+EPpgBnqX/SiwGHEdTm0jJN9ucitguNtongLPxEJgpaaFYmcw0ATJSHGYIB6yhYZXQeHDDrPZS23Or3K4lpfB0A43b3SVWXxhdNKMD4dW/tHeOGR6JKwPIhX/jZAlRIefxeezQtzumtYvnbptyDYJHXTJWz9TuIw3HvTlpJBBlTxouf7Wdy7Ld0fvarpIhtB76eJ+4iDi4FXOt5TLyslIx14N9vEBvTqhKp0osquyMdnIIBIjoYwwRlZauZOTEHpWq0mapWL2a7NwMAiRIu69/GuYvmYY+ZjKun/VZIQUV+vLADLTT3Zkjt6oEFoRze14RkQdc5+QV91Li4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hDVtAWqbz9zCNZbA2rO1n9JDNM6NBD91nsIlXxM2sw=;
 b=m2iVQ3p8wc5I9VinTsb+DP3Wpt9II29K5iKWJU+L7HXtvukiuyiSIrzvuv7AaWyBZ/+iFr3DJZgT0HmQfT1FMJo0bPxIUUfWMxxjx6fJiq8XHsw9CztqoJX5LoQvr41jRJbw++vzYNsctX5b4c8vN8sNQ0/LzLOxIuiVRAgmOXM=
Received: from BYAPR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:40::18)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Fri, 1 Dec 2023 13:29:13 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::9) by BYAPR04CA0005.outlook.office365.com
 (2603:10b6:a03:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:10 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/47] drm/amd/display: Check writeback connectors in
 create_validate_stream_for_sink
Date: Fri, 1 Dec 2023 06:25:28 -0700
Message-ID: <20231201132731.2354141-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cb9885-ae72-4c66-be86-08dbf2718206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXtOO84TCzpYrTBaAs3lPRlFzjHfIqFbqHeuKof/VTFX2WoX7DFwQgTSLNs5AglFRveHAUwx2jflpMgELITjBHk1QdochuuYsbH/168cct5iKXE15ZgsH0ku3t8XeAYGzJgJmsqDu2XSk11sRKRBRh76qfW+seT8aWCkHGKZZdBRy0xgZsbEQTbiFzQT0m4xEEqo/wsMUSkFfI99rYCsVqYiwOK0nmHiKvw/Z8/5ke4zUcH6blFGb/ZW6rCAWXGKea7K3R1vHKlH801hWXJCbR4OJ6iFyBylAomcxkh0rN12Jo/hycuCBz+PBKJ9+F1D9LRfMwl1SWyZU3Rmi4ym4NsgTZbc2ebYTznOx3AgWljfzWVBiUJCh3lT7L/zchaiOW5rvpChzsQnkNiKNEOHWrT+n1rqvauft/yk4S1v+iI0fAM/huyYaCvGUPv5CMVNtxZDiNzy/wf73QVpGspWWtqjfwAfqlowW7qMdXqr7AC3wmiMmAuLznEdvFEnqnXSZOlSRwlkrfIWcfIiNXjJTVX77zZNZzrDOLKhE1N1UDEqR4E7eVT7I5JgB6H/T8RDFwiHOVoYkbFOZt9vymkQL6m9vGSNheWjsgqGj5Mg7Y3rvyNsJBszLKDPGZUkgorcTj4nK7ZYiLKVohbvi6yq+SmPth8xhtvGo128l/7z6Rpv7z8ptRT+QjZclhAFMk0IKnuKn7dfrB2pqZUxvCdxs9Tk+5Q/sCiRiyOtDsCoAvsZaZsdeXvfyG+YLz7OhPSN5fq53PO2r4fxjBg9o7o5Sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(4326008)(2906002)(8676002)(8936002)(41300700001)(336012)(16526019)(26005)(316002)(6666004)(54906003)(70206006)(70586007)(6916009)(1076003)(5660300002)(2616005)(426003)(40480700001)(83380400001)(47076005)(36860700001)(81166007)(356005)(86362001)(40460700003)(82740400003)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:12.8825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cb9885-ae72-4c66-be86-08dbf2718206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
This is to replace 24a2efb3aa08 to check connector type to avoid
unhandled null pointer for writeback connectors.

Fixes: 310b5f1a3c9e ("drm/amd/display: Revert "drm/amd/display: Use drm_connector in create_validate_stream_for_sink"")
Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 09ce6de09039..eb9f9d77127a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6658,6 +6658,9 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			break;
 		}
 
+		if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			return stream;
+
 		dc_result = dc_validate_stream(adev->dm.dc, stream);
 		if (dc_result == DC_OK && stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 			dc_result = dm_dp_mst_is_port_support_mode(aconnector, stream);
@@ -9406,7 +9409,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 	acrtc = to_amdgpu_crtc(crtc);
 	connector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
-	if (connector && connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+	if (connector)
 		aconnector = to_amdgpu_dm_connector(connector);
 
 	/* TODO This hack should go away */
-- 
2.42.0

