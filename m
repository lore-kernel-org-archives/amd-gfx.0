Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE23C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3731E10E445;
	Wed,  7 Aug 2024 07:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NuD6wnBO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C6710E445
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBYkUIYr6ie+IpyrCQ/2io5xoVFqTY/oLu351ZJaqcSUh+ujY3IJUGXLVwTyOtf+Y3RzPi8CsgeTYbDxeoAAxn3KUqhy+3aiipy27L8ncFeSZxYhDAC/AUcf+PcM4baN/3YqrfLPwhqMpijA8t8p+yjTsGnumkr31Fsd3uC+icCRUVhNfELQFJ32gGeLVGEh+Q0AsBaJLXhmFP1PVyK5s6Jlr3X+Qe1V43NfQkkAcIV6TvvKZZKXrgK3yQd0/xCL3WxkRgDOujMRATsCtc/3m/Gpm0vgUAMZPQmT1DWcgoQtY+12ah9IDoDWWKZkxeIMP2Cc0h1da01iMwlJWty/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pwzYmKcEc+WxLpL5IsPO3fgusCn2a0CzjClRimOJ1Y=;
 b=QTHLZB1LZconWyeLCkM0GGbenSyVW/4E0GW0ShokWy9VuHqpnmwrIqpWMZgXcflmOu1BznzS9eu410LAtUH1CxFZA65Z8afHh+/4Mw0V31uaBXbWyi2kzmw5RHQYYALwGr/4PxJNr0LAmVe4Kx9Q9TsP/9lZF6gRH9/+vUnYlCsv61H6TanOUemc3RQ1udCIROBe2mOU602SW6SAqGcWkFugyKIAg+Z4HE30lHHQUTM9/kbp/HPxCDD1r4Tg8idX5oFPeqGjZY0szYkL8oxA7U5m9+wuqiQnT4NNbAVxI5B/rv7wG0CqSC7JH2jlDzGs+wBWd6leOYCRX5DhGJYROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pwzYmKcEc+WxLpL5IsPO3fgusCn2a0CzjClRimOJ1Y=;
 b=NuD6wnBOCsV+8FMBqXW8Ndg1Om4vyjkJvtKRX1gM7s4p850luR2EauiPh2DFwp1cvNADt5S52n7RyNE4+DbwZqG83cCjHfjWkj52C3ewoVI5vOW4meBOfRMoC/fosnCLsWclUgJVYm86nYyf1K7oo9VnJHekXe40bUmPs7RgSfA=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 07:57:01 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::43) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:00 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:57 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 13/24] drm/amd/display: Reduce redundant minimal transitions
 due to SubVP
Date: Wed, 7 Aug 2024 15:55:35 +0800
Message-ID: <20240807075546.831208-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2f509c-9af4-436d-86e9-08dcb6b6851a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DmWV4OCPv3ts8MfJMzeCnPiUUWsuAgCgA9VbbggFk6e2s4XI+oZdBshsTs7C?=
 =?us-ascii?Q?8+Czrh8eXmiw2MBug0NrjlEZ8xON2QnrAebUpcIdSH8FRZpYCJ29j6yuZNqO?=
 =?us-ascii?Q?pkzKh4TBnp/kjhGBLR8rib9Xcm9JYFuKQA9Wy+Uf5HjzSDE3rgR8iCgmM2UC?=
 =?us-ascii?Q?gxgXuNqG3cq1fzUnbIiWBMtFmxd5M+2pWm4rJ+NornKkWaoXq/zt+OiPtOgF?=
 =?us-ascii?Q?FuVLmHa+wO16D9lwWIIbsKxS2iO5x8zARiRUFQKtpcTI6xKXxtIcFxhFZGE2?=
 =?us-ascii?Q?jne9hOIkiPJYMxFziLZtTU1l6mKTeZTVag9uxXn8RjT+Bq98r/Yox9mv8PI+?=
 =?us-ascii?Q?5CJF8ke6C4QKRqYwbx6M3e+DzLiNPnv02HNb9IdCaZuraWm1njMcFtzTu1OV?=
 =?us-ascii?Q?KODYhvUkSz5/vr7bUW3cbRhCLogw2RUc4DPGYtApZFCn9URs6HNc37ywon48?=
 =?us-ascii?Q?DYHhrBvn5oGQxeHkwaV6seUfjOfIJY1Qy+3OniU8kskPdfBouCAGSjUh0ICJ?=
 =?us-ascii?Q?gqvTRCjZ8l5gWHSmN9UCMwdEpb1AoYE4G852nYqLeLVEIxHpxBbvYunJeJ7+?=
 =?us-ascii?Q?E30Ban4qGPjHB4h5awoTqIpZCn49Lmj53pmvDLpKaBjXflpAvEj0BsIQWsD6?=
 =?us-ascii?Q?UzDIzSH7sKoSyRq0fDn/feFa2kl+fp5TGrvTCIxvrzAmRh8hnuk+z5GI21BZ?=
 =?us-ascii?Q?CrQC6DV0vZYW7YntCwlEL9VwZmuHvzGaODu4enRAFC8XraKx97upDVFqzYnE?=
 =?us-ascii?Q?DoWRUjGf9uSRUXzF0PuxnIhpegACg1qCmScm9UKTCAVt4V6DTxO/a8yWeCox?=
 =?us-ascii?Q?e4vx+HfcNkD/mOSl1QQqOqp1yR4DdGGdcnb6IJZJDjeHiTqH9FLFIrY0kAfG?=
 =?us-ascii?Q?NnnKUH5FmkRDhDitPCGUJpEDV6e4iHeAIKsrnKa0k2Mut6wKRQd98j4VJHCP?=
 =?us-ascii?Q?51QCYqJnvL40fJuQC8fyernSDLV6/IXei+ZwExKSJAEbrv5KICYrgkWqFXQB?=
 =?us-ascii?Q?//7Gd5MjGNJLWVNEl5NzWufr0YRIuBd5OBGcY53f15MrHfecNpP8IcEqoxcL?=
 =?us-ascii?Q?CNUyqDwwR7nSxDJIURS9B1wkxYEtEw+BQX7wznZz+Ur35OGAspmUzuI4vd3/?=
 =?us-ascii?Q?78szG1tE/jTn6DNoUCQ/sx415ULoMgkHUjycP4rcFXJlct0g14/pFRyNTSsK?=
 =?us-ascii?Q?zAqux9ASwlmsM03dVVSI2oEsxZQ4+sSB0m8cTmMOAR1WPpMUUp0rvWxHq6GT?=
 =?us-ascii?Q?F6VH8cHX/Rz1GZ7x6UV9JePPQT/h3iQtRZR7KvuEj65LBAnnOpTxN6PFDOEe?=
 =?us-ascii?Q?bfjnPVv4p9CvHaD7PCrfESjT11Nb/N7Ce2ED02r1ChrnuabI2/KdQVOT4Pu6?=
 =?us-ascii?Q?5DZDEAVLXe0q3Vqd3zylJA7Nki6uLonIdmEhjQKCecgiRJt+QeSwiaJnCs2L?=
 =?us-ascii?Q?Mp7ThIMh3+HqSbEMEbf+jxkqgsV3+WqU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:01.2554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2f509c-9af4-436d-86e9-08dcb6b6851a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
Stream ID's associated with phantom pipes can change often as they
are reconstructed on full updates, however they can remain identical
depending on the required update.

[HOW]
In the case phantom streams and pipe topologies remain the same
between updates, mark the transition as seamless.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index c3bbbfd1be94..d75a811c90d9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1719,6 +1719,28 @@ void dcn32_blank_phantom(struct dc *dc,
 		hws->funcs.wait_for_blank_complete(opp);
 }
 
+/* phantom stream id's can change often, but can be identical between contexts.
+*  This function checks for the condition the streams are identical to avoid
+*  redundant pipe transitions.
+*/
+static bool is_subvp_phantom_topology_transition_seamless(
+	const struct dc_state *cur_ctx,
+	const struct dc_state *new_ctx,
+	const struct pipe_ctx *cur_pipe,
+	const struct pipe_ctx *new_pipe)
+{
+	enum mall_stream_type cur_pipe_type = dc_state_get_pipe_subvp_type(cur_ctx, cur_pipe);
+	enum mall_stream_type new_pipe_type = dc_state_get_pipe_subvp_type(new_ctx, new_pipe);
+
+	const struct dc_stream_state *cur_paired_stream = dc_state_get_paired_subvp_stream(cur_ctx, cur_pipe->stream);
+	const struct dc_stream_state *new_paired_stream = dc_state_get_paired_subvp_stream(new_ctx, new_pipe->stream);
+
+	return cur_pipe_type == SUBVP_PHANTOM &&
+			cur_pipe_type == new_pipe_type &&
+			cur_paired_stream && new_paired_stream &&
+			cur_paired_stream->stream_id == new_paired_stream->stream_id;
+}
+
 bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 		const struct dc_state *cur_ctx,
 		const struct dc_state *new_ctx)
@@ -1737,7 +1759,8 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 			continue;
 		else if (resource_is_pipe_type(cur_pipe, OTG_MASTER)) {
 			if (resource_is_pipe_type(new_pipe, OTG_MASTER))
-				if (cur_pipe->stream->stream_id == new_pipe->stream->stream_id)
+				if (cur_pipe->stream->stream_id == new_pipe->stream->stream_id ||
+						is_subvp_phantom_topology_transition_seamless(cur_ctx, new_ctx, cur_pipe, new_pipe))
 				/* OTG master with the same stream is seamless */
 					continue;
 		} else if (resource_is_pipe_type(cur_pipe, OPP_HEAD)) {
-- 
2.34.1

