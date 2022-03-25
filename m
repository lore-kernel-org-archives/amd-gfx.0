Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA78C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B87F10E2CC;
	Fri, 25 Mar 2022 22:57:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD81D10E2CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLpGTXAQAruqYBHyUO2DwOUh6rrhxNcnvhxvvUzGP0oC1voiGXftgtifjtUPPLUf4v/RJrqC8ziEoeWXV59RKyl6KxWn8PGE7pd7D4k9Hc9KPL8EPk9EJ/6MUV8IMKRzhJew/HKsUDjUVERc4IHVhCxXBgW2KK4n7z05f3atb0MZ8yQ9dODJPo53ZHKSsk/diKm6rE7yT+xYB3UmR0NxriIKDvNNniGhbjyS6QBdIu/m8l9T+eM43mFYq1cN0NqQJzNsyPVXUyh5Qp+oqj6kKPdAbJwWm3ENprwBAQw8S1F0suqYH2LF+b4pPpV58wnGa85f3KFURgeUxuaBXPPDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxsFEv91Vc/wIpeVgJDkZyyiSjbPFMJeOTzd5Bi08UE=;
 b=blR0FG0Hj9O117MF5AA/QCbmZiBEskEGIk2TSrPds4OXveK9gUsG/8z9G7ZRbBulVC2BdBwyzJXm9q2msWCYFWkrm4cXi98+LhQFsP1JMMgme/v/m8Va/6KfAWHKaECXYS9GOXiRettHPodEd1zP0iV20vCBAAU/hROV4fFO+n8y3jBy8Qaj6u/OEHYjNU/C39Ur6FJFacSnHYzGtq0bIPn0jiVMX5g0gTd/d+UdFt+oQp1dw/5nigxn3Eu+PLGT1BROXyz7qXZZxulNUO4/slLcWwszy/uOiwL1knpJ9ijtdMR4PyjvHvTMTG3BYDxnZG+JdmybFA67bH8u4vFUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxsFEv91Vc/wIpeVgJDkZyyiSjbPFMJeOTzd5Bi08UE=;
 b=ygtrTseUmlwj146pb+Wg/1ZTVm9IxkYufv/B1jb75tOr69AOQ4nflkhx0f6uIlN8l/ghxvh3mRPIvlmjp0pV54bauwE6cKuLceURq9RSUoXxdYNjHZziUEZxceOG7tNOZxrpeTK9KRtt66aK/bSjlnJXfW/MOLal0IUShCJhe0w=
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 22:57:15 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::23) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Fri, 25 Mar 2022 22:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 22:57:14 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:57:11 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Add support for USBC connector
Date: Fri, 25 Mar 2022 16:53:57 -0600
Message-ID: <20220325225402.469841-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fd3ad45-b9c6-418a-ac77-08da0eb2cdf3
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54904ACB61DFCC07C432D6ADF71A9@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgoMoYLM4rLXEgBWkVQiF1GJSpuTbQTwoAlAKGwzY3XoeU6OvPJen9JJA7Gi73GU3bsTIhNm6Uo25O3R3+CZjV6y1hThN99rADH/J7OTjVDHES8E1nqwb07ktsM7Unyj09SPPmw4Y5nK9zu49pL7lkDDP0Sa/O080RRU0nwWH7F38RK76/hk4Z8r8/sOizBOICUgPjAmh7wMyxIfzaglv0OaFLiNEcR0cqvgHRqdMzqxUImKQp+TLXAv8eOGqjjAZNBXawe1FC3993J4n7b0+Klq8mkXXWjA6KspHvSVoOVkdT8jM1pJ6eSjJfbx99fUDX/28ELnAb6rfdU9M5zuCZfmrZutMQLm5jQtCkYrQ2ftItcqnYhusUgnK1FDEgAPJG5okXl2lo31kKwFpx7yoxU7Yinxp1o6hepwPtYNes/E0hrtaC+GCkTR3kC9M8yDdVDhouzBG8+TjZWb0EhDU5hHVApJBKKFwodZ5QRRipS2FYbU1xEDQ4ytIKBOKKODiEHt+lXotHazDl7pi5sa+5Dhyx3XpkLf9GDVCkkQY3Huh9w8MwoEp3bttKai3HiBPQbgcpFUpZk7y7IC+yWu9SFUNomXdgQoK6KaYaOef55btthYDU+rAiL4J1VBbstOWjJslBKDpUVk2a5Ja2S0itMSLwmFcSDm1FlDb4irOvK+9swpvP63TgbFWzE+pD1rIqNzuY9RaVge81lvEwzzUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(83380400001)(7696005)(4326008)(356005)(54906003)(6916009)(508600001)(47076005)(36756003)(8936002)(81166007)(5660300002)(2906002)(336012)(70586007)(70206006)(82310400004)(316002)(8676002)(26005)(16526019)(186003)(1076003)(426003)(40460700003)(6666004)(36860700001)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:57:14.6737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd3ad45-b9c6-418a-ac77-08da0eb2cdf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Add support for CONNECTOR_ID_USBC

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c | 3 +++
 drivers/gpu/drm/amd/display/dc/bios/command_table.c      | 3 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c            | 8 ++++++--
 drivers/gpu/drm/amd/display/include/grph_object_id.h     | 1 +
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
index a8cb039d2572..34e3a64f556e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
@@ -213,6 +213,9 @@ static enum connector_id connector_id_from_bios_object_id(
 	case CONNECTOR_OBJECT_ID_MXM:
 		id = CONNECTOR_ID_MXM;
 		break;
+	case CONNECTOR_OBJECT_ID_USBC:
+		id = CONNECTOR_ID_USBC;
+		break;
 	default:
 		id = CONNECTOR_ID_UNKNOWN;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 0e36cd800fc9..32efa92422e8 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -522,7 +522,8 @@ static enum bp_result transmitter_control_v2(
 		 */
 		params.acConfig.ucEncoderSel = 1;
 
-	if (CONNECTOR_ID_DISPLAY_PORT == connector_id)
+	if (CONNECTOR_ID_DISPLAY_PORT == connector_id
+		|| CONNECTOR_ID_USBC == connector_id)
 		/* Bit4: DP connector flag
 		 * =0 connector is none-DP connector
 		 * =1 connector is DP connector
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c7c4d9867c52..7aede6495e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -345,6 +345,7 @@ static enum signal_type get_basic_signal_type(struct graphics_object_id encoder,
 		case CONNECTOR_ID_LVDS:
 			return SIGNAL_TYPE_LVDS;
 		case CONNECTOR_ID_DISPLAY_PORT:
+		case CONNECTOR_ID_USBC:
 			return SIGNAL_TYPE_DISPLAY_PORT;
 		case CONNECTOR_ID_EDP:
 			return SIGNAL_TYPE_EDP;
@@ -380,7 +381,8 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 
 	bool present =
 		((connector_id == CONNECTOR_ID_DISPLAY_PORT) ||
-		(connector_id == CONNECTOR_ID_EDP));
+		(connector_id == CONNECTOR_ID_EDP) ||
+		(connector_id == CONNECTOR_ID_USBC));
 
 	ddc = dal_ddc_service_get_ddc_pin(link->ddc);
 
@@ -476,7 +478,8 @@ static enum signal_type link_detect_sink(struct dc_link *link,
 				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
 	}
 	break;
-	case CONNECTOR_ID_DISPLAY_PORT: {
+	case CONNECTOR_ID_DISPLAY_PORT:
+	case CONNECTOR_ID_USBC: {
 		/* DP HPD short pulse. Passive DP dongle will not
 		 * have short pulse
 		 */
@@ -1591,6 +1594,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 		link->connector_signal = SIGNAL_TYPE_DVI_DUAL_LINK;
 		break;
 	case CONNECTOR_ID_DISPLAY_PORT:
+	case CONNECTOR_ID_USBC:
 		link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
 
 		if (link->hpd_gpio)
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_id.h b/drivers/gpu/drm/amd/display/include/grph_object_id.h
index fed1edc038d8..c6bbd262f1ac 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_id.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_id.h
@@ -162,6 +162,7 @@ enum connector_id {
 	CONNECTOR_ID_MXM = 21,
 	CONNECTOR_ID_WIRELESS = 22,
 	CONNECTOR_ID_MIRACAST = 23,
+	CONNECTOR_ID_USBC = 24,
 
 	CONNECTOR_ID_VIRTUAL = 100
 };
-- 
2.35.1

