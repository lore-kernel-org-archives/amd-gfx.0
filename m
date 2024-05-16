Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B591C25B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B57810EDDB;
	Thu, 16 May 2024 19:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/DJPH98";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6341210EDBD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3vImWrIvUmYqWnreP81S3fq8DyFdQtEmJsm4VQTzq6VVZGFFiYxZZw3IMK8nHFipyf4J2ZnFfxBxV+s23v+c6OUhjmmHEIGywAMPLqkucm7R9FKJmhP3erhnWxTxrhQrioVetmHULHGvnJP5amdsM9ndyyuYbQajvWrCwScWwmT3wzV69XDOXrlxUi/QbbW4WuU5nAyJ1UBb6oL6wsaShnfvS2KFB0HIcqEQIJjzlZKk/eK6Rr30D7SzBh10RgV3B+UTEkxlD2ihhVEzqSiuOnw9zb9AzTz1Ke9fb8StMtL+/UoFP45cb2BL5oGYVBpgNxacR9dwTv6b6UNmnKWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0vvkys5leg5zpI5dIW9AmPJYUiQuGzZ9qty7TN441w=;
 b=N5aUPkRl4TOFGNEZpt9Tb5Mpx9ASWkEK3U4ftKo2dI+giQEcbSMfHTtjD/j6XjVD+Gm2crNNBkfmKviGFCAJnpW2moLm1ar2DX1IfdyXq5D5pwoqMQ1IWCprXhG7rK7KmHTzEl4TUUey3Z6L24B4tWp4Vm+DZ3AJrArJzAs6Itx1u3gR3vicaiT9hqPDW7d492sAPDrx0adtZLpBp+SxJI0kTtE0OATGD8jXpMXTa28s6HzTUCq/iO+FhYvzBIqXCA8JHpC+r7Mnr6lSTqjZRAqIoqseNLJ3+T6afegfxNnmyZFJ7ESAwpwbJicCf9g/yXsPOy7/phIQwvYgK6CfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0vvkys5leg5zpI5dIW9AmPJYUiQuGzZ9qty7TN441w=;
 b=J/DJPH98l7OmAa/Ej3tZAeZZZ9OAaBN8ibdewTZUnypI8GWkStyUPshYhAnKwLFdwObLax+8MkRaR3xgzdq8+4inhuHIUBu3Za5Z4LRA6RzYsrB9nXXFpzrxb1FZb8rkNG8aw25Dv7RbdCiEiJ3FkTeWdkQxug70aI1VupEhyxM=
Received: from BN9PR03CA0259.namprd03.prod.outlook.com (2603:10b6:408:ff::24)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 19:27:09 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::fd) by BN9PR03CA0259.outlook.office365.com
 (2603:10b6:408:ff::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30 via Frontend
 Transport; Thu, 16 May 2024 19:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:07 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 19/24] drm/amd/display: Fix ODM + underscan case with cursor
Date: Thu, 16 May 2024 15:26:42 -0400
Message-ID: <20240516192647.1522729-20-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 5577b095-6bad-4e59-6161-08dc75de2da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0w+eVpdvzthuFSnGxDS6j1jXfaYz9cjtzyAf78KhyU/6Eus9GYW7TTFRaGPY?=
 =?us-ascii?Q?wU79Rmg7LAEJhQPSdkUjBfGD+sr8IG9HQtE8IvvMNNSbri0oWIJlN0i4t8nb?=
 =?us-ascii?Q?2LQxRHuYhMD75xo8ZGB7xuUUdhWlkf34MPzqdB1tUCmi1XE03TB0/bHYkiKJ?=
 =?us-ascii?Q?U8S5hRKami599nEtC7MJt8itHm4m1nwGa4DqwM9uWsRDktTpYPN980ePdidD?=
 =?us-ascii?Q?rGw4dZ6kPL8yJCdUS05g77CXQhoFw67QYEpEq43CSHvsuldD+AM0KWhcL8tS?=
 =?us-ascii?Q?Qj50yI/PisBrUdTWbHgN8WXz7W22aIdBwfW2WSS5hzi3YlM1fwwfTHmMUNEi?=
 =?us-ascii?Q?Iyb0OVaei1sSiiLh0efdK7AjidFTlO+ZCjNjbFcwmejYLI/WuckYT7QAkLzl?=
 =?us-ascii?Q?jaii5/G3+LeH3ziDQsvZTpg6B0wfTbiNPXpBHhwVQkiB5Z85+8zjSNzqONPA?=
 =?us-ascii?Q?SG+/Y9ntQVXYM+NGQNUFaqPIpurH7cBeu47PZ1P7miUanGJAMO55rwNJmBfe?=
 =?us-ascii?Q?QPiQuJqbN+NsN/WKhVlWLgQsWiiH71xA/ZTFNqhFjyEFMPfpVMeKmpwzm3Z7?=
 =?us-ascii?Q?0Q+i/WII5Nm+LhLbuiWehoy/ltT9Hrzq/tUGWnrZwvHdRvp+07Rp/a8IPOVI?=
 =?us-ascii?Q?bVrGoMQ7CThaQc8uIhhtmvlwcwYUdKZvVBPMvgHee7q/vdAgY0q29cTRaprK?=
 =?us-ascii?Q?DKgcIODbCzAALKaA8Gdsdm/Kntzni9QK/0uoxEe5l1+ZJ6ZO9TR75Ryk73IX?=
 =?us-ascii?Q?H4bE+KSd1Qj/ajFrgq3fhrrN10dbWQNH7p4Cy2S/1R5rbIT50hpZV9mIIbMp?=
 =?us-ascii?Q?FJgSv3irESiIMoV1u4mtpq1f90eWk5srk+RCTirLxguVn/Dbt8hUfxvffwoK?=
 =?us-ascii?Q?5dyzlfHKBOvuO+0Lz0/lvzYqsI85D1fDOSZTBh9LRkRX5Xhg0eExvsMHcpbM?=
 =?us-ascii?Q?SEYusCjq07puvpM9IsMrAKFSglFuTcSjcVZsTBj1zC4nZdGOD7ebXFhAq6M8?=
 =?us-ascii?Q?k6ZL8owlpyIk5rFA8XFF5bYUftnFO+L/x5ha/xVqP0DLEJ6qC68NldsBDGgx?=
 =?us-ascii?Q?2qrqx+OtAbSKabtDaGpNnhOx5jbJ6/QRZn6brgBu3Pl2FL7PlyW/5XMCEGlN?=
 =?us-ascii?Q?BJOc5tIJQhi6RsjCQj26k51BMzVhtaCV/rJULhVMyfJsD3r07Qv1IkRK9JgK?=
 =?us-ascii?Q?2lU7B+fFwQi3e72zUSwlsqGobgAotNbOgSFLgyEVJ1+dgfpeuB6/B/ZaFTKe?=
 =?us-ascii?Q?fh0rcrFrJZ/WawDt8yNG4xJdKowtXiwzVDtzLAU9yGFXitx758zW/t8IMuT7?=
 =?us-ascii?Q?KW9NP2sklKpF9oK4W52onJeRDHkZHqItESKhYR5KmtLjOz0GYq77u/vZCJOB?=
 =?us-ascii?Q?m6uH6IGi1pb0YziY1pXGBvJ2BLf7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:08.8563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5577b095-6bad-4e59-6161-08dc75de2da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
There is a corner case where we're in an ODM config that
has recout.x != 0. In these scenarios we have to take into
account the extra offset in the ODM adjustment for cursor.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index a619da7716ed..f5333a095adb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1089,7 +1089,9 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
 		(pipe_ctx->prev_odm_pipe != NULL);
 	int prev_odm_width = 0;
+	int prev_odm_offset = 0;
 	int next_odm_width = 0;
+	int next_odm_offset = 0;
 
 	int x_pos = pos_cpy.x;
 	int y_pos = pos_cpy.y;
@@ -1152,22 +1154,26 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		y_pos += pipe_ctx->plane_state->src_rect.y;
 	}
 
-	/* Adjust for ODM Combine */
+	/* Adjust for ODM Combine
+	 * next/prev_odm_offset is to account for scaled modes that have underscan
+	 */
 	if (odm_combine_on) {
 		struct pipe_ctx *next_odm_pipe = pipe_ctx->next_odm_pipe;
 		struct pipe_ctx *prev_odm_pipe = pipe_ctx->prev_odm_pipe;
 
 		while (next_odm_pipe != NULL) {
 			next_odm_width += next_odm_pipe->plane_res.scl_data.recout.width;
+			next_odm_offset += next_odm_pipe->plane_res.scl_data.recout.x;
 			next_odm_pipe = next_odm_pipe->next_odm_pipe;
 		}
 		while (prev_odm_pipe != NULL) {
 			prev_odm_width += prev_odm_pipe->plane_res.scl_data.recout.width;
+			prev_odm_offset += prev_odm_pipe->plane_res.scl_data.recout.x;
 			prev_odm_pipe = prev_odm_pipe->prev_odm_pipe;
 		}
 
 		if (param.rotation == ROTATION_ANGLE_0) {
-			x_pos -= prev_odm_width;
+			x_pos -= (prev_odm_width + prev_odm_offset);
 		}
 	}
 
@@ -1269,7 +1275,7 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 				pos_cpy.y += pos_cpy_x_offset;
 
 			} else {
-				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width + next_odm_width - pos_cpy.y;
+				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width + next_odm_width + next_odm_offset - pos_cpy.y;
 				pos_cpy.y = temp_x;
 			}
 		} else {
-- 
2.34.1

