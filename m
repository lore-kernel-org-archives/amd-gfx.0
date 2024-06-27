Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21761C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCC210EB69;
	Thu, 27 Jun 2024 21:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Isy436+d";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9526F10EB67
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3vcmwGh/Gw7lYqVJ0Yrlr1wAqyqgLK1NPos8ts6I//QxyNI0mSvlnujhmKy8rxjcbBE1pHWoOsrVCw5dYuZHX5s8uYNSiS027VpM1lD3gPJqgPiXvXIlNBeimR/De4j437X6Zg+2EloTIGFJ2zsdsKsW4Ki+MRk/fNpHFcHJsDBxHyyCl6ZbwQpthspKxvFF66ZSx8mucNcKGCY2vIPLESfxwBjCn3daHcaVSqvC/EDt0n6TgP3Z1aC71ozf1oqQfzKWKWFbWhhh+c1UlofmSZux3bM7uDHJKTBNxCWEeLYDx9B2mov0FRWO5eJbw142WXiMiu9nF58SgemqDQMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+obNuJbESQzshod0HOVgIpNvlVgESJNEloqdeaMIQk=;
 b=fZZjKmA+dr4mWx+SXIx4srNpqfiPyhz6EpgY+bFIO47oSezkwik5sd0WfEk0VX9RlZQeSIfL6b9XqPc7wfozwjs6unfVkmRZX9NbRX53KLxRWDPicJwcSwCnSjXZ3yDAq5iSRcXRFIjtv0mGo0kO7VLAdSpRBzKMvOTHge9pq+P1jcJ82JtljE4e3Xp/m1pJNdgt79iQsUVN3KMHhUDCQ+xI5bU1iuspfA+VaEnEfpSPbf91EzHCYR+bC3K+60SyIr3WZQTO7toDXYAKtha8nMTsD1sd4ghiPYhmPprWGVUWYSxWK9qol3Ixv9S2MC/W16jP4r6wO6T5jos2jlSQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+obNuJbESQzshod0HOVgIpNvlVgESJNEloqdeaMIQk=;
 b=Isy436+dT+m54awL1TjMK+e+cYGw+vgsQ4zSjT+j2Tv7oLFkqlBYalxp69ZBbpQo0/k+XfI4SU49dTr13zh165Hb57axLMcHVWeMdH8Tjfx6FvcqI0ZkOH7oRSp7Lt5Xc2axCzjkJw95xOggauXc+LOObYXkPdLvjJYEYxPKICM=
Received: from BN0PR04CA0186.namprd04.prod.outlook.com (2603:10b6:408:e9::11)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 21:14:53 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::f) by BN0PR04CA0186.outlook.office365.com
 (2603:10b6:408:e9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:52 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:46 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sun peng Li <sunpeng.li@amd.com>
Subject: [PATCH 23/26] drm/amd/display: Fix refresh rate range for some panel
Date: Thu, 27 Jun 2024 17:13:26 -0400
Message-ID: <20240627211329.26386-24-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 09495bc2-f62e-4512-73e2-08dc96ee3033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HazviqVRmaX578u3ezaw9l6D44xRMGSgC+imZii3uCBTsZpSJOaZNUhM31j5?=
 =?us-ascii?Q?u/GQAWgCI506ifnGU/vRFPZFFs8YK3R7iPqbe+L8PIXZCL92wccNuEincUyi?=
 =?us-ascii?Q?xBmyr7Ac65UB982OSQwedUZoJT431hfTwBXzmfJV9wp2516pxhF172DVCBHV?=
 =?us-ascii?Q?j2yCsAdpddsXkKVyaigm8Qulm+xEGYsFANApXj2IzyIxFfpKOxowRQ6IwLQf?=
 =?us-ascii?Q?uMhLh9eqhf226EiIQBUxKASuDdaVxuFndmLOlosyk3L/Yc7/PhSbvFtojOMh?=
 =?us-ascii?Q?oiBYh1Z5w10GH5Yvvtafjo0rLOwfiAr+hrti3V2cF/1SFQ+RKGaniblJwI9D?=
 =?us-ascii?Q?42Nz/6omSNHyO4VdSgLRAejhVBjaV3b6btNK/bxk5vq6+5uRuQneJORLrgSd?=
 =?us-ascii?Q?4UONeBQ87x6+zVh9DJsKK5RCLyEFZxWyd2+fKAQzR3cpoam8lTsK04GNgkUV?=
 =?us-ascii?Q?PMkGlv92LcDW/hx/qkxuXKQgY5xxTytE82QtE/spivE+RP3pu0NOmKxQBTib?=
 =?us-ascii?Q?dPwNrtISE/T/9xy4Ei5EL00+8rJT//XJajHr1vcKW6AryYypW81s/SbyfjO8?=
 =?us-ascii?Q?1EVfM2gUr/T6lVXVY672SGl6R+8UGq0t2R4bnJP2RGkwywwzxq7Ywsf/TgpU?=
 =?us-ascii?Q?j94/EKjYUAclxweVxvL62HVd0ra8Rba416zRa44XHFsq+7IwG6YhXKIWtSr/?=
 =?us-ascii?Q?dfrHkF3T5KAwIhWXYjDKUEPryizpoEpdF33r5xRqc3qwzMn0WYmOPh8pQtZW?=
 =?us-ascii?Q?eQ10B76KZXv4+E05JtJfYTfDiykb9LtWNCsVx5BOY8ksNJ4OmaiPwUziFfW6?=
 =?us-ascii?Q?i2G6gCxFYiraKedM27iQ8uqlTNmeIcveK5bH1zF7F3LHKh1iEU+M7bweUI7p?=
 =?us-ascii?Q?87PLXc1aP5TQOfNWYoBt9QBiqqbzwEB9zY7fKLpl3ZXpej/IAPUUNBCltzJd?=
 =?us-ascii?Q?k5Wp8PgQf/HyFwNWZ/wRJYH3V3JyafJhBnSfYDqpyBZ42khEOaJe6IsjFNLo?=
 =?us-ascii?Q?r73RLn8f/cgZOAochGJGHk8yNzHYhk78m/2S6Fuw1EMgbcikp9+oIGAG43D7?=
 =?us-ascii?Q?ivbJniOLxKwsRj24r2Tk742IrymqPZ0AhU44bTCQsqV2Nos8uxs0XEhsyT2/?=
 =?us-ascii?Q?dYfbN0niOiPkzRezUILko0p7I7IgsFo1Gak23MV3U0NvSPwN+kXzTamY+en4?=
 =?us-ascii?Q?/7YtN76nId1ZKNMvNshBO8yyfriGlsmFjp2gHSyZrZ+gJ9c+ZFJgXaMacvL1?=
 =?us-ascii?Q?/am7lqfOU0coandodocg8B+fBm9uNJ8q+2aebr5QdW0/bJnF4rNUkwNwZRa+?=
 =?us-ascii?Q?456bfa4BbiYYfVRrhAUJbwRd+mjzAOv4ePtDnyNeGL5l3nXBTd+QOMWIFfu7?=
 =?us-ascii?Q?23JxGqsFd438MI22iqB+AJ3RG6RWydNEgVbUppDSCIngsMAMYbhKo6S2xvhV?=
 =?us-ascii?Q?/flAh0YF0zJdp+b/1wZXMvihjL/zfl1b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:53.4204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09495bc2-f62e-4512-73e2-08dc96ee3033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Some of the panels does not have the refresh rate range info
in base EDID and only have the refresh rate range info in
DisplayID block.
It will cause the max/min freesync refresh rate set to 0.

[How]
Try to parse the refresh rate range info from DisplayID if the
max/min refresh rate is 0.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b19461aca640..c42558043bae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11873,6 +11873,49 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 	return ret;
 }
 
+static void parse_edid_displayid_vrr(struct drm_connector *connector,
+		struct edid *edid)
+{
+	u8 *edid_ext = NULL;
+	int i;
+	int j = 0;
+	u16 min_vfreq;
+	u16 max_vfreq;
+
+	if (edid == NULL || edid->extensions == 0)
+		return;
+
+	/* Find DisplayID extension */
+	for (i = 0; i < edid->extensions; i++) {
+		edid_ext = (void *)(edid + (i + 1));
+		if (edid_ext[0] == DISPLAYID_EXT)
+			break;
+	}
+
+	if (edid_ext == NULL)
+		return;
+
+	while (j < EDID_LENGTH) {
+		/* Get dynamic video timing range from DisplayID if available */
+		if (EDID_LENGTH - j > 13 && edid_ext[j] == 0x25	&&
+		    (edid_ext[j+1] & 0xFE) == 0 && (edid_ext[j+2] == 9)) {
+			min_vfreq = edid_ext[j+9];
+			if (edid_ext[j+1] & 7)
+				max_vfreq = edid_ext[j+10] + ((edid_ext[j+11] & 3) << 8);
+			else
+				max_vfreq = edid_ext[j+10];
+
+			if (max_vfreq && min_vfreq) {
+				connector->display_info.monitor_range.max_vfreq = max_vfreq;
+				connector->display_info.monitor_range.min_vfreq = min_vfreq;
+
+				return;
+			}
+		}
+		j++;
+	}
+}
+
 static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			  struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
@@ -11993,6 +12036,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module)
 		goto update;
 
+	/* Some eDP panels only have the refresh rate range info in DisplayID */
+	if ((connector->display_info.monitor_range.min_vfreq == 0 ||
+	     connector->display_info.monitor_range.max_vfreq == 0))
+		parse_edid_displayid_vrr(connector, edid);
+
 	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		bool edid_check_required = false;
-- 
2.34.1

