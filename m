Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A5BEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02DC10E2C4;
	Mon, 10 Jul 2023 19:27:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3E810E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKbpNT6bN+emA5I2EhTmivn9A+2A6+YBta4bsMpXWPjx/df7fTik04QRy20iAaTnsc1dAdMbYST54Oh+F9b6+7fGqDwSj7I90BwpmHMQLtpVyI/LZGXX1E/cl74XwXc7Zkl1cOx19TobaiAiSjtPiBbW6qD+I28bRftYDjSWJLwM9/tPHOufnBxUWt1uLmhu0ZsCC8QxpqqVd3khVDsZyEFpQwSoV9jQsh6CFo8M+RGd9A5kZZk+dQ9zPG6a1QulX6k1uxc3qHNLml6XAslDmBU3bV7/Xu0TtYsry+N17bTgTJyhznlRDUIopSm/6Z2M8K/p2jrJZDr6C++McGpUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m34ogL1RPx0+aktNOgKDSCvTYDTkwYXsS66Jxat8YLk=;
 b=RcwgRQU5sFHbTUP8zscsSa50pmf6NsoZnZwSl9vxfPqga2b31B6DQKxKNWQkfHsQ+TIdZxDDpNbV2LdxGLPYrJXV1Xq+ar4MB4DLThsfRjKN3Nze1BDLiNCjVhwRp6x+XPT8HcRHmK7Zjnupl1Dht5iCnZ8i71OVLW63EqYF14alb7sLyNqOkrecPWSFl7ypzcM8M1gp+s+c6TZ7mLSEXM0KeNYtT+cwLgMROzsQSXI1c/41vUPK77FHEAqTJjdHTPN57rVInzFbINVD+a0uLm7x7GwbG8hNIQ3533gRt0t8XEJYYqc3dPgNw33hXM/dP/HyB+nM5QeL8usaHZQ9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m34ogL1RPx0+aktNOgKDSCvTYDTkwYXsS66Jxat8YLk=;
 b=VyYIS5rTie1GJKLzxooSs69RSAG83Qhwg2OH+7vnpbRQwZ68BNUlJmKvU+XxV5eyZBWMTWrdnpbymHpAzUovqotVw8v6HDaj1ovOjIZq5EOMT1OKthtMewrmpLGytSpC5ngnAajBq3tTAUzNewGXoMzdpTJQmMTPjwy6x7Oh/Fc=
Received: from BN7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:20::16)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:27:40 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::c9) by BN7PR02CA0003.outlook.office365.com
 (2603:10b6:408:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:27:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:39 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:39 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 08/10] drm/amd/display: Update adaptive sync infopackets for
 replay
Date: Mon, 10 Jul 2023 15:27:31 -0400
Message-ID: <20230710192733.1344403-9-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcb5d9a-7c91-4dd0-5a0f-08db817bba12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShaM123gwZKX5v+Hxq22JCya5M5X9kDjOp6Q1M/uF/Hx8l0emqtzx9WklKg2zS9WEnx3lfX9XdpkkcyPNC2YtenAuxO1OttR3mbOFP6PGhcMEVnOGok+9YjBBri0FeSLwPs2YyAws2iCxB5ZwHmSI3P8XNGQ/RmKgVAfYRGFLLa/WEidEkY/76yDO8n/CZNsKxc30OCsskJDpIpfRg/3PR51Xn6lQUsNXoV8Y6q6f0lhfirLBlQoYySFh+L9L79Y654ZDXbPWvSnGGJlj4R2kO072ixNW+6nePbhHMmjqZ1K7EzW7BRmv4nM69C3H8gUEg1ShRwyl6Mf/icAko+2+hE+YTRrSBg1bdZjVkMZQqdNzYLaCZvMK22i7k95kJyxDzMUg6H/iokadjXOCMnsMalOzHFogv6j4mI9awozYCTyiYAJetXwXx8n7glc9OqrZTjHgGnT+KpEM+YSgriTsL2GfNPij9Ob8uYTs8CljXdSp+I3UWpc1m1/th1DKctnmkvLPMTh1n8reFgerBQ5o2lv3l9w6BPirFQQKa50dzreV+CnxKJEfdKI8rshvK/SzoT9jsNS/s6POhVz/2fASWkSadI0lvapVLwzdDmaqH3c2PcPCrso6geJ7AR45epBjEqWRSVUID7gLMBhQvqP/IO8eNnJk12u3bTAidwnVRwb9wXaXc/BFg7TFL3MlZZKpilRXS/9kmlxZ685R1HKmzFReHGIZM2sMMr86yLcG3Rh14RJ5eNRoWxSF/bTXySXoVXQZJenGEFQWeuh2RrQYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(86362001)(82740400003)(40460700003)(40480700001)(36756003)(6666004)(7696005)(110136005)(70586007)(70206006)(356005)(81166007)(36860700001)(26005)(1076003)(186003)(2616005)(5660300002)(316002)(15650500001)(478600001)(8936002)(8676002)(2906002)(47076005)(426003)(336012)(83380400001)(4326008)(6636002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:40.5313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcb5d9a-7c91-4dd0-5a0f-08db817bba12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update infopackets for replay

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             | 4 ++--
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c574a11a10bd..90bc32a29356 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6097,7 +6097,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
 
-	if (stream->link->psr_settings.psr_feature_enabled) {
+	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -7842,7 +7842,7 @@ static void update_freesync_state_on_stream(
 
 	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
 
-	if (aconn && aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
+	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
 		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
 
 		if (aconn->vsdb_info.amd_vsdb_version == 1)
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index ec64f19e1786..5e0068f71609 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -149,6 +149,8 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
 	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		vsc_packet_revision = vsc_packet_rev4;
+	else if (stream->link->replay_settings.config.replay_supported)
+		vsc_packet_revision = vsc_packet_rev4;
 	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
 		vsc_packet_revision = vsc_packet_rev2;
 
@@ -536,6 +538,8 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 	case FREESYNC_TYPE_PCON_IN_WHITELIST:
 		mod_build_adaptive_sync_infopacket_v1(info_packet);
 		break;
+	case ADAPTIVE_SYNC_TYPE_EDP:
+		mod_build_adaptive_sync_infopacket_v1(info_packet);
 	case ADAPTIVE_SYNC_TYPE_NONE:
 	case FREESYNC_TYPE_PCON_NOT_IN_WHITELIST:
 	default:
-- 
2.25.1

