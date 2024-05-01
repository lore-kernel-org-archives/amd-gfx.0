Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F655C10F1A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9664B10EAA3;
	Wed,  1 May 2024 07:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WBVGQRyV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D6B10EAA3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NswrtQbvw9fX0UODdF8FHMCW1kQU9QzQPDfvPVyl3j39vyfCOdv67pAuLm78rEltuykpFshmKN4CQdKQexm9W3zt2H0fjIaY6+nWphj7jSt8fEJKiH1MitcTBQ2WgNtn3pHSpS1gB71KIPM8ITxFTWq7/EaeNp47fjX7u9GT1j2loqJZuk3FvIVJdHjuIGn6rAHKF8n7SFm6I/MWcaa1ti3wtmzhsKV7dQJIMnTswBCxpKVaFEclchNV5rhzCJWf0fdsK1ssjOs7g0LO9Z7PahSQD75O4dFtn/FQayO3y7tvC7vLSrRvpOehC4lCbNU7dunNyXtzY30hGnk0ycZ7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFttja4+EteJuQJZ1xaEGauytaZOBQzeaVlGbwgbPYU=;
 b=H4c5x1nFvoVUbtlr4qS8cf/sNr8vW4UTt8AVOfyMlPVYbxEkO/NkX7sT8JnzaQO9MvhkAVwL7WWZks9dFyoOOjFNLx6WKo0JSghrajweemNKd/ONAb6JsMS9TNBWPU6OodYEiBw/Fe7gYpBgjvWpIa65Kp2wJl8Kqhv2sLR2twoUVk5gFA1BZ9cuqHodcp84zvrYo8ucE/TyyaDHSoQiCf35VNMbySyRvWjnMFKMC5I+vRu4Jp2eDKqq7iYImnvFjXwBZtBdd00sn9EQ+tesafe+NyZrjHFcc3JyXtX7WHhjLOL5CAQYIeIiP8ebaGBQ0aZ8VoMjNLCo2Si5/rSufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFttja4+EteJuQJZ1xaEGauytaZOBQzeaVlGbwgbPYU=;
 b=WBVGQRyVfVNpIfj78pluN9ir0P+Z0Iw9XF70KUSF9zD0acrW8EKg9FNx04b165uOCkMBk47BzMJ12jd55k6QMbWOSZ0pGTyJkxXR8DYNYd25nRPtiU64bnfTGTb1PI8KQtNZaJDc3dlIfBEZONA3eSDHkXOm9Dz7GKfqi2Ue+Mk=
Received: from CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::9)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:17:35 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::93) by CH5P220CA0015.outlook.office365.com
 (2603:10b6:610:1ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:34 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:26 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 08/45] drm/amd/display: Skip accessing array for unknown eng_id
Date: Wed, 1 May 2024 15:16:14 +0800
Message-ID: <20240501071651.3541919-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 08aea265-72eb-4496-3a6e-08dc69aec615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9FTMaBDMlqJKX/Ki2uMhZGqYqTSlxBzRLkjiHnEqggyqg6IPAgvv2aW6PLG4?=
 =?us-ascii?Q?sDtcwghTqa0c7b+aKcaaLjCTsSlOMAWU0ZluzNGOTrlNNjc8sUnH8MA2vtx2?=
 =?us-ascii?Q?FYI6+qGHp+zLbQMQWRBBqkONTzYMXjDD+7rNpWF8jWnukiWIs7YWkrkxJIw7?=
 =?us-ascii?Q?MpfvosRoFF5WZDtDUmWa3IdPOUCqUTMz/JoSHByHsOWA+9zhhLKSWRE6jZjk?=
 =?us-ascii?Q?ZZEK8YH0ozXcWEMgQ5wYv7EICzcS5mUudiv59yXckv3TUc2WLnMKMAUzZE+1?=
 =?us-ascii?Q?RfwzOrSFRugqXg12nSwhYCgzYHf8p2yR3wlzpKO2/J3ZlP5bbL3J3B7Hb7fq?=
 =?us-ascii?Q?lL+AwCe/a3b4SNr/1Q4ipPiLFV6+mHQaDC+RUAkLDtwRhLATGXHX4Yp698i5?=
 =?us-ascii?Q?WCb1ESZozuurIHgWSkGE5EMkBcXXeAlre59+rtdhucN0lB/tWAgYjFvgcX/v?=
 =?us-ascii?Q?q3w05V5fErdJyQ4DnxeyYxYosl490I1sQ9IoJQw4kAQXXwOSxhkwbYcq/Lpg?=
 =?us-ascii?Q?GuE81MBg3Ly9JvduIpsKl0M3HV/mwfeGsQ3NH/bU7psdxMrC5f3Wsvwpb/er?=
 =?us-ascii?Q?gAlCYMg5F57c0NK96VWXRwo5DwNEp1X2IjdoFvLiw5AY8iwNNDlqV3Hd0D+b?=
 =?us-ascii?Q?VbHMyj2QjR1YCVpHBTRE1yD9ofECO1Te7ZaNMM/KBQ79lKU0NswM0V/yEoNK?=
 =?us-ascii?Q?Z+6slyDC0fcuC2feKVV37JEmXxJ4ondN8d4SPdLtOseDHSyiBo+8/hswUDKZ?=
 =?us-ascii?Q?Fc07SbH8SI2ioksrbq8r1kC1CRQ48TGioT7KDpLBL/ePfSGNa5Us30w/KbiK?=
 =?us-ascii?Q?pXOsvY1yDvTSLM3Xo/W83ShQhOKdc8IEDxXSGtAHqVLV1tbc8jQv3jBKgDzc?=
 =?us-ascii?Q?bmTttQXxSxOBUcvfosetQ3J0HPmQqCLULBUal1hKhBKnB270iOYjtAILRZaJ?=
 =?us-ascii?Q?FKS9+lJfuRKCaZ7z4KY1yv+r/La3NfeUV+b/y6p+UCdAv8j2tZLjHkkHeEdG?=
 =?us-ascii?Q?FRZ1ykk5hUWZmyvn+6M41+la5sQC6QP/kjCL+SBnRWqpcwLQn3h9pF1qpGo9?=
 =?us-ascii?Q?0cdyka+ONqFfts1vYfUnUdA+6T657gHSNhZ/WzNWGnPikZM21NqU39fPx2UX?=
 =?us-ascii?Q?W8nL/KkPEowLUBrs7akb71IWv4q7hMrztE84eMNpNax7zpL0XlhkJV/ATcu3?=
 =?us-ascii?Q?qnbxsMIbBZWZC10jRIUQle7CYKIGa+WVI/Jh3iR/+YpOLnxODOxJfKu99oZq?=
 =?us-ascii?Q?bpMOBRqvaINkO0SPMXWSW9+d74M3RGMArx/Dhap+rtxjLJTEkpaAtw2jryPo?=
 =?us-ascii?Q?3yLu7/R5m6vSC2f1ZvEFs+9ABo/Xz9lb5pWDqTiC8uZYqz0qvHiKsoccK1Bw?=
 =?us-ascii?Q?cTnxUsWtwFxeZij8aoRFrjqdkqC0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:34.7648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08aea265-72eb-4496-3a6e-08dc69aec615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
ENGINE_ID_UNKNOWN (-1) is not a valid eng_id and not a valid array
index.

[HOW]
Check whether eng_id is unknown to avoid access array with negative
array index.

This fixes 4 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index be5a6d008b29..039b176e086d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -248,6 +248,8 @@ static struct link_encoder *get_link_enc_used_by_link(
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
+		if (assignment.eng_id == ENGINE_ID_UNKNOWN)
+			continue;
 
 		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id))
 			link_enc = link->dc->res_pool->link_encoders[assignment.eng_id - ENGINE_ID_DIGA];
@@ -517,6 +519,8 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct link_enc_assignment assignment = get_assignment(dc, i);
+		if (assignment.eng_id == ENGINE_ID_UNKNOWN)
+			continue;
 
 		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id)) {
 			link_enc = link->dc->res_pool->link_encoders[assignment.eng_id - ENGINE_ID_DIGA];
@@ -540,7 +544,7 @@ struct link_encoder *link_enc_cfg_get_next_avail_link_enc(struct dc *dc)
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct link_enc_assignment assignment = get_assignment(dc, i);
 
-		if (assignment.valid)
+		if (assignment.valid && assignment.eng_id != ENGINE_ID_UNKNOWN)
 			encs_assigned[assignment.eng_id - ENGINE_ID_DIGA] = assignment.eng_id;
 	}
 
@@ -602,6 +606,9 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_stream_current(
 		struct link_enc_assignment assignment =
 			dc->current_state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
+		if (assignment.eng_id == ENGINE_ID_UNKNOWN)
+			continue;
+
 		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id)) {
 			link_enc = stream->link->dc->res_pool->link_encoders[assignment.eng_id - ENGINE_ID_DIGA];
 			break;
-- 
2.34.1

