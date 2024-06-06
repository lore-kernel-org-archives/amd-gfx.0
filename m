Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27157C27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989E010EAA3;
	Thu,  6 Jun 2024 21:02:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ykz98ho5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C884C10EAA2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Llqgg0CcD4PTWxx/MwGbTnDLrxp1VDrbt7APPKX57hQyTFv8JrrDuWhB5eDKxqI1kCrz8Vw9PEFar7epYoUUpPjrIQ19zEcSVa+pK1vIWpPIX4FoIwf2HJc0YpzBPQfzbvjuxFdJmj20mdAjbKfqTgBYutjbvWBFK+wG9drJV/8amL+DJDpI3N8AVckgRWATQPZP4h5jicvBhLcX0gLvRf0jAiwvnTRE1hi4t0rcHf63f8eViVORvKgYn+E3pxWDB6Eh7Zco3S+xJbwOgKco/5TubYwX5+H+2VIdBDrvWZD1RQu+P5k5cvc+whcDLKCWjD/GOiKhqBHPe0ZkZZgh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXNnAxAoy0xceKizyRbhJPoSduDBxagw9NgZkLbLg8Q=;
 b=kf+HIRlQ0H56+31ZjASQHt7qev0HqBHlXDW6NDuzGnCJylh6/V0dUSkEkHolQm9Gruilqt398qaoTxbq38UZuhPiyNsJ7oQpOkjRRBsygaBdUno4gDNxXc6nomyyREXClWXmN6lN4HO3RjusT6Zh+t4eRVYMizII1XlpCP2MsW16f2la4yhDg0PizZtnxW0zb/kkCaVE3NdiF4Pk+SpDxEYndXkDF8p/2EbIPXKCbter5jCcsMsQdS0JvX19utJsVv6yfCmZUShCBySD5D2ZS8sRKik6GXQy91h3pHqiDbllp1MGLX/bZoW2bOljuo1D8kIWcK9hprjZPRBiTmTFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXNnAxAoy0xceKizyRbhJPoSduDBxagw9NgZkLbLg8Q=;
 b=ykz98ho56xEKc93eHkJ2MsRvFZslBR/3DIVoeKol7qYAPkFvf5e42n3JJiU314dJ8dXwAYC0ec8//yrfqiKRTwJZ0rmdI3QRXwvXGgJAi6g812gPrKJkXyu1Z0v1KbZR342PanLT7sAg8HivB+dUvrhXWmeiO9xX5M6wI7I2Rro=
Received: from SN7PR04CA0204.namprd04.prod.outlook.com (2603:10b6:806:126::29)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 21:01:57 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::30) by SN7PR04CA0204.outlook.office365.com
 (2603:10b6:806:126::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.19 via Frontend
 Transport; Thu, 6 Jun 2024 21:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:01:57 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:01:55 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, ChunTao Tso <ChunTao.Tso@amd.com>
Subject: [PATCH 04/67] drm/amd/display: Replay + IPS + ABM in Full Screen VPB
Date: Thu, 6 Jun 2024 16:58:25 -0400
Message-ID: <20240606205928.4050859-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0ed9f5-ad51-4d00-abbc-08dc866be6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EgRnzp8/ma50eMo54DH/PNWLa5Bqz8nvLahVbHjrMXsyEA9y4CtiTRMRKzCg?=
 =?us-ascii?Q?3oAlFtg26KYhuOOYmGpVD1oiSt359RgLL8zMC7kPMGivDSnt8sm/QrJGQDmI?=
 =?us-ascii?Q?5oYIVYNMkGWjaTHLdVLPfbTE1s7DzIlkmR7USfPrAYubKKgBf/Fk/dQw+bud?=
 =?us-ascii?Q?1MR351aYq8dwlcm6n3n5iqlsY0aNFDNQdHmbKd+dlPqB+ZMZvLttJ2Mb8LNw?=
 =?us-ascii?Q?SlcfmIhMCGGnup8yuIF6pYLr0CZAeV7gYHOy3fxcVZ6TpwfLiM+DBqMf2br+?=
 =?us-ascii?Q?6rrbTL+iZQFID/k5ChrmyDrcxEaQr0212Zkx2qLpo+EJnild2QYtOZ2GbMOg?=
 =?us-ascii?Q?aDZl858H5e9N/qHbWnU8QHiYbACuzChFNCWizJRY4yf4MYYtGGmzg0Fn49Yn?=
 =?us-ascii?Q?nrpWx/vlNpQKutmjBIyxxgsOyueGC0TbGjafxPIIg76JW95A4VTnoJlX+j20?=
 =?us-ascii?Q?5gy7Z2HpT3ILrnfJ2Vy44IaO/v/twtCQuZy+0lAAXUqHaMf+9fvawGTu4Kct?=
 =?us-ascii?Q?Q/U+ywZtYJJnnbcalGSWNZM8oZo8WLggVWgW4Mqls0caIdDN4mHW58mCqUYb?=
 =?us-ascii?Q?KudpYf5sZpmo4ZVVxCzfZAUOiAP+szCTSbWvTQUtFbdV3t8PZ3MGMWUQsxeK?=
 =?us-ascii?Q?Dsrt8tge72XcodhFzOI9pEVTv37sRAUJyf2J8M6MzrCfmIMRR7cNXCOIzl5F?=
 =?us-ascii?Q?xlidPxlIQECzPUtXV38LmA95javu6RfEOVpEikw+40Njg/4nfKDvrsd7/YVG?=
 =?us-ascii?Q?SRfu87FiP847tEfup5Qp+hugdF9b5b8OQ0KGv3+etGoaTrk/RLtt99cq23yG?=
 =?us-ascii?Q?+elDYUH/WfjC8Kk4h77t33bex0yVGqDVUW2itMhoZAmvZawmL7OgvjzIUVmI?=
 =?us-ascii?Q?l8x/j+k2mTlwiWnlxkKIb8WKA9cm9yzkb0Vnq092Yb/h7J6QSlLGfdDDDYeb?=
 =?us-ascii?Q?DsAdDxBpiLf+ursrni8RfoKTv9P5Qq2IX7f2ii7YgoAuOcM2IO1VJ26BWZGF?=
 =?us-ascii?Q?5G20Iw0ov7wOqznDNex92Le8dxdCniMrFlcYu0Oyd2zvhhDkpDGtyinShg1O?=
 =?us-ascii?Q?esctWeyzAlxEJwNLNhUU1m50/fnPZhr+Uy1y/J61kyxid2PCNekaJhPYWLVL?=
 =?us-ascii?Q?x4WmdldCuVPrl51n5WYDQ9ogNMcAn/ZYFuGjrO+lrzDJ2oit23Lu9FN+wjqX?=
 =?us-ascii?Q?bMLrpMcnVET5s9LAqesarhMJsBPvK8MzY+rKItwL3ESgQzmG4eok7C7btyAk?=
 =?us-ascii?Q?zpdb8C9dQuT2olqfv4Us37CP/3PgqlWMURQWu0FPUMaJaHKds/11ee380Oqc?=
 =?us-ascii?Q?k00YOaua88U8FeStFBV4ZjmCYEavSd6lAImD0u+lObzzvrzHbfKAKU0wL2yI?=
 =?us-ascii?Q?3TM8veW+j59Zp4W9gtp75hMQscURs1Sv8m20N/LwVIUr+m31Pg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:01:57.3509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0ed9f5-ad51-4d00-abbc-08dc866be6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

From: ChunTao Tso <ChunTao.Tso@amd.com>

[Why]
Because ABM will wait VStart to start getting histogram data, it will
cause we can't enter IPS while full screnn video playing.

[How]
Modify the panel refresh rate to the maximun multiple of current refresh
rate

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: ChunTao Tso <ChunTao.Tso@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index be27ab7ef2da..958a927d0cea 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -350,6 +350,18 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_set_frameupdate_timer.data.frameupdate_count =
 						cmd_element->timer_data.frameupdate_count;
 		break;
+	case Replay_Set_Pseudo_VTotal:
+		//Header
+		cmd.replay_set_pseudo_vtotal.header.sub_type =
+			DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL;
+		cmd.replay_set_pseudo_vtotal.header.payload_bytes =
+			sizeof(struct dmub_rb_cmd_replay_set_pseudo_vtotal);
+		//Cmd Body
+		cmd.replay_set_pseudo_vtotal.data.panel_inst =
+			cmd_element->pseudo_vtotal_data.panel_inst;
+		cmd.replay_set_pseudo_vtotal.data.vtotal =
+			cmd_element->pseudo_vtotal_data.vtotal;
+		break;
 	case Replay_Msg_Not_Support:
 	default:
 		return;
-- 
2.34.1

