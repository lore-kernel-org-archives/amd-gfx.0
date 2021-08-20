Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560BEC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1E461178
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A1E461178
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92756EB2C;
	Fri, 20 Aug 2021 23:30:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B10646EB2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWampircES0lGE7MVNYdliSTVtP/ZB3kVQ2DTNDBKp3p+qxlHOiZZzefkr1ZthY4tzasq9PB7u5Nz2AX3My/H1yOyASBwnKupjK99KXWZWNrAQMWeNCzoV54DmNXEEOEt+yZ3uzF7YoiY8ydEXDQR6MnMQ1UtckPInyL0I21QLyxI8QR6a5/CcGGbmJLB0JIwc2cdAxoDgHTc0wpqm9J4BRFScSUVwONLNl3nEvzbVFXfNMz5Tpxl6/JZukj/ER9D3zwqwM+r+VdXN7XZwKUWUA30gjqFkhRszFyXRJzGqBlu996AZucUysz0aLIA9ChDPLvLlsGGKbIjwzGgtgVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TK3qxcgfLnDXMZIFVNaH+Mkvhom/APcC5svtZB/uCY=;
 b=CIwQwqSJtwkaTfKkrlM80nkE+0JnyuwzF+LltE8MVVLI6jIvtpbJmaDYkbKeBetw1zOdyB3Et9VYOAXdtzBb7Uwi25ogaEOfHyjGMBvdikGOS5FUFO4EAZDhrcacxUdceY4YlqR3MwCTAC4YgtfEZk3OLOZTT5kXTF6X8tIDWTlPM2JU9REJYv+x6YBAOHzier39hGjF5N7n4T1hRcrCu1cF/b/w7GeGnnWf4+1jZXzYmYz+sbiTslpUtKboqZ+TB4mkP594lwoFonhDZSqhdb40YDcpVh3+zzJmCGJwDZH+kBgUnqc7HhF5zwHlrgEpYMbM8nuQCR9DTBzzp7PZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TK3qxcgfLnDXMZIFVNaH+Mkvhom/APcC5svtZB/uCY=;
 b=I0cfnXEOXsemuiL+l4dkRp+eOQNoBRwX5NjM+FDBbTfmt1FrX5fE6lV66NtZDZMyl4my+zqu7wnWVgAJz6yZD2wfcnXIaRLKomRbZNYo6XeszS/YodYhijnlm6+3GaMY/LZ3HsaDKS9Efecrqt5TJ/quQj18zKPKTQDmzEdrqv4=
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by BY5PR12MB3938.namprd12.prod.outlook.com (2603:10b6:a03:1af::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 23:15:42 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::c6) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 23:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 23:15:41 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 18:15:40 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 06/10] drm/amd/display: Add emulated sink support for updating
 FS
Date: Fri, 20 Aug 2021 19:15:16 -0400
Message-ID: <20210820231520.1243509-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
References: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2082678-2315-4125-82fd-08d964306e2b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3938:
X-Microsoft-Antispam-PRVS: <BY5PR12MB393899484D7CE867B4D34748FBC19@BY5PR12MB3938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sd6t+XPiZk0tBweBJlsPfZBWzAhfkVENyXXBHLyzg5KIU1sTtKW5OGWo40X/DAdS5ugG3TDpAMgs5r2Ucq5VaTXefTcYOcf6Whb6EANgO8g7u+OmBuatwUf8iMWBbAlD9ivWSCDS8SqBKQ6TpGJcBgY+qTaZoUw2JHXMJcK3zY0pvJww6nUYpiufbxMkpVIpE6cw09VlycgWrKMKCu8gyj+8/SLbtIGcJgAwefmrdpF0xH97nR/o+OoNctdIBA/3XOi8n3fL1k/sDvFtqO/y75aeVzj8cEVtgBuwOmnGayx2MmZ4Y+expj0ksxnKgSMzJUMD0lbMm2i7lQd+/R6cdUgEwjuQCqLWzY25F9HnYSSxyotEItdNa4nmOc9/QADxOM2REg6WHnA3P8lZJb7ke4kOl8ezd9xvyMnh4NRqeHvX4d8YWMFljuIcuaojjcBnmYWIC5gyPJCIjhQp8fFpqWHdXQraO6e87IzLNlnuHpeEUnVv8C+sLpxVi9sSKToiYEWIc06mn/KuWsRp1A1InBk+6jmK/3bcrijCgT7Ks0pkx9hm+J6lWkkxAaKxx0g5jF+hPN+8Pl3/xHf9VUg7MK5+Qsiibyb7rVOvWyeHk4lZo2wPlgJ5LaJPd6RG9XwKu0fom5zPGRSrcBr/mFsV76AbO8WU/nfR5T+3Mh82P684N7eHz1pyM0SmIC3Xy7Y+4hJ2YL5N2HWkBQKd/ati1H6MAxgCXU8Wf/Pj1U+Ma0elD2pAUzRbcN94OuSpG/7nUP5pGcVpEnvEqJBN+PR63A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(54906003)(1076003)(81166007)(316002)(8676002)(336012)(4326008)(2616005)(34020700004)(8936002)(70586007)(36756003)(6666004)(82310400003)(36860700001)(86362001)(426003)(6916009)(186003)(5660300002)(44832011)(83380400001)(16526019)(508600001)(2906002)(356005)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 23:15:41.8759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2082678-2315-4125-82fd-08d964306e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3938
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
When forced modes are used during certain IGT tests,
without a real connector, dc_sink would be null when
standard modes are added by the driver. Calling the
function to update freesync capabilities at this
point will result in an error being printed

[How]
Use emulated sink when available. If both the normal
and emulated sink are not available, set all freesync
parameters to 0.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e5ff59e2fc7c..e1e57e7465a7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10917,6 +10917,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = NULL;
+	struct dc_sink *sink = amdgpu_dm_connector->dc_sink;
 
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -10928,28 +10929,31 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		goto update;
 	}
 
-	if (!edid) {
+	sink = amdgpu_dm_connector->dc_sink ?
+		amdgpu_dm_connector->dc_sink :
+		amdgpu_dm_connector->dc_em_sink;
+
+	if (!edid || !sink) {
 		dm_con_state = to_dm_connector_state(connector->state);
 
 		amdgpu_dm_connector->min_vfreq = 0;
 		amdgpu_dm_connector->max_vfreq = 0;
 		amdgpu_dm_connector->pixel_clock_mhz = 0;
+		connector->display_info.monitor_range.min_vfreq = 0;
+		connector->display_info.monitor_range.max_vfreq = 0;
+		freesync_capable = false;
 
 		goto update;
 	}
 
 	dm_con_state = to_dm_connector_state(connector->state);
 
-	if (!amdgpu_dm_connector->dc_sink) {
-		DRM_ERROR("dc_sink NULL, could not add free_sync module.\n");
-		goto update;
-	}
 	if (!adev->dm.freesync_module)
 		goto update;
 
 
-	if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
-		|| amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {
+	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
+		|| sink->sink_signal == SIGNAL_TYPE_EDP) {
 		bool edid_check_required = false;
 
 		if (edid) {
@@ -10996,7 +11000,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				freesync_capable = true;
 			}
 		}
-	} else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+	} else if (edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
 		if (i >= 0 && vsdb_info.freesync_supported) {
 			timing  = &edid->detailed_timings[i];
-- 
2.25.1

