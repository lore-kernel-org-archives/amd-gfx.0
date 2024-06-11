Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D986BC27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5136410E6D5;
	Tue, 11 Jun 2024 16:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sp9Ba9Bd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EB010E6D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFunIw09WTnh3yZ2rORxa/ySctPtYAU7qeMPpHO5lE9yKbfiHIvz8nKutXR0is69MV7Wkzd0xhUGAiSkk9uNh4/RAU+lH6v8XrtD6LgZQFQgZS67opQhQc4ttois5sbj9px6DgQla81M+wC5KGuK945sti2YlqFE6r7SLHsF5YsteS24NELokSWgjH8uEe81i5QHCeEk+zwfJiytXWjvUehQs7Fa7NxLR9WQN55uFZ5Sw+LrIf1cFbRyAfO7+/s0EOBFMYiVxHL/cZaEZAt7zaHi6tWSMs5FoGZpomSB+ZAj9d7DTKhPs2ofMlzPEYltk1ccJfuzQPjwJy7AEsoLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWtwxH/1+yz5RL2pACE7/9kWZ6XMrE9/Ch5yhkCGafU=;
 b=TQeZOFJLUv1GDdWNjHmrNLAz3MJrGNab0lcZttU1tEAe91KON2dfQoO/lOTK8ps5BoGFIZkiztaKPAMFuLcTxJbDjVe2EjjDRFbMqujq0/tOwgylewDCF2Anh/BXJYfqg1Kl2NSeTWfox4N7cqHQSRcmDDsi6cs564FK6JpUOjA2if9JUlDIih1dk3wloLBJmTDUYwJr3W3Zd0iq3p1OUOFVgNHs1dWgeGQhM55Oi72ixxJ99yyqrH6BZqKY24KkekdWmvfZ2aBK4SLa4/5xoa43HPlTzVgefdGkxH5ioZRzpjSFKgkOCwaigg4Q8SPv+IYNT1wIm99VB51gJyrzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWtwxH/1+yz5RL2pACE7/9kWZ6XMrE9/Ch5yhkCGafU=;
 b=sp9Ba9Bd1xO3Rgl9yjcyO5n4OnCAAVRImyWTL4s5BXYgN/krPLzDm9G+Ofn/jDJ1zj46W3RfpELoenMVyN+XHJyOFP2XJwIgW6N3Q4wELxSG+bUZXcZx8SS8fQXBoxOs70hKOdIuvWOzNrFozfKr1lIyIh3cT8lYRzIfH4KM5j8=
Received: from BN8PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:ac::19)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:39 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::b5) by BN8PR07CA0006.outlook.office365.com
 (2603:10b6:408:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:39 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:35 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Sridevi Arvindekar <sarvinde@amd.com>, "Nevenko
 Stupar" <nevenko.stupar@amd.com>
Subject: [PATCH 18/36] drm/amd/display: mirror case cleanup for cursors
Date: Tue, 11 Jun 2024 12:51:21 -0400
Message-ID: <20240611165204.195093-19-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be7614e-3947-4cf5-c6a4-08dc8a36e756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mMK7FdYlY7tpCLn+93KH5LbPCAZbiak4wgF5gjgVVA1tACXx+zLp3aJ2u+5Y?=
 =?us-ascii?Q?L90asLpXxd4dnlCNYtnaFwsIAm2749iQaOpRxaGQj3bS8ObVWNqccDKmjBhC?=
 =?us-ascii?Q?GP/ua8nHYUVPjop2RoyJWnuE8/JvTzQ1I7CnC0wBlCn88mPsG25KZ6S+4w0J?=
 =?us-ascii?Q?Ac0ZfUK+teq3rG2dS0UJ9rhvQmygCEQRcHrsWLGLaR8lbuNAo8lhg/owuWrM?=
 =?us-ascii?Q?pE9GSuptkG5lLscWRJkHvjfkvRyvKyBQPlxYC2iqo6n5t4ue39zJ4iaLrxS9?=
 =?us-ascii?Q?B+3yej+1ceXpanUyjlqll+gG0qq8hS+aa6BSSo4Sjm93110UA1VzPQ3HXRbO?=
 =?us-ascii?Q?GgpQ/PpaVK6tPHCxWujBBVY3D7IO4XYMP9ggu862ibHgq0MjAyhi7FuCu+Gs?=
 =?us-ascii?Q?KIMR5n8VDPlrbY60JuTP5YTMUxR/nmYPZd64K38rHVsuHFzjyUNFJ9oJa3bT?=
 =?us-ascii?Q?UkEV4q9VB+W+KJsC30DPVCiukyfxl7+FpLe2pFGhWdTb8Cl/nYhsMWRIsrlX?=
 =?us-ascii?Q?dzMto+m2TpuPo8V6uf2oLkrxP6OVAzG630CF7QROELkNgp7Am9BhVw2CUJD4?=
 =?us-ascii?Q?GVGd7InRxPN8TS7hXzhxZur5TuQit5UCyVzKnuxGbSyd+R4ScP+3owwMgp2a?=
 =?us-ascii?Q?Mkk0rbda9FXKdLO/u2g6JUIoB8ug2pnoGgY2Hb3yvMovnhMKKv0qpAdapjSM?=
 =?us-ascii?Q?MtY6QxyEA+VJ/Le20CryGpRIFhsWWW8jrwBCswNrsa0eS6h1GtTrqST/bFxY?=
 =?us-ascii?Q?To8QJBPDULXW5Lffi84usEAPp4A6kSWSdCZ2rP9VWt+v+3OVeGK1+a7T5f03?=
 =?us-ascii?Q?BhhSSiSkut4deWLvpMVzsp1Oe3pWLT4J6KGVCZdIbPgR5zcZp6ah82TUHlKv?=
 =?us-ascii?Q?WwvuQ/HpZR8N4ixHWDQgBGMPkTZQkd9hGTgBKq+AVvrBQkf/odoAqvYvdNFa?=
 =?us-ascii?Q?HDOUUGSDazJwdxpqhrKJE1rF79ZUrt2WiQ3OO2lCR2MvZ9xxM/4LzY9xU/OO?=
 =?us-ascii?Q?G3q+SyDpkYrVeXPiLY4GVzunkV3uam/FAv4oPfoHjPESWC04kuiN+VcTmgAA?=
 =?us-ascii?Q?ASzz9TWdKkFT/8F1ANgE2sN3P5L/LYXpnjI5Zw+32uqJjMRRZh4fU953GSFT?=
 =?us-ascii?Q?DkJ2YUG1WU9ndb3x0pJE/VypM7b+uDzQ48c/IJ1470C+DQOZvlweB9Gp1pjr?=
 =?us-ascii?Q?/NSB7zmO6xgeL9/zscet58ngJjaGAd1RzIACBHNu/RmXzl1fA0MGdCVfaPqb?=
 =?us-ascii?Q?AsGOdJJWBbJC/vbr5ZDcCNzF8qRK1ShnyTriWjmZuauLVbExecsYXFiMf5qR?=
 =?us-ascii?Q?B6LIYS8ZYZX6pDAbWU0yMslCmcY2ubOh/EYRxQnCMbHE3tcVl+DpZCPUXSKQ?=
 =?us-ascii?Q?qfTKBqBHGQ38FqM2RREvIpJ/X6pTOL/v1ghLVCOzLbWyo5WjiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:39.1983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be7614e-3947-4cf5-c6a4-08dc8a36e756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
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

From: Sridevi Arvindekar <sarvinde@amd.com>

Mirror case unsupported for cursors. So, remove code for mirror case
with cursors.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Sridevi Arvindekar <sarvinde@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 30 +------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index e7d6d987e3d3..ef0a42f2933d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1209,34 +1209,7 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	if (pos_cpy.enable && dcn401_can_pipe_disable_cursor(pipe_ctx))
 		pos_cpy.enable = false;
 
-	if (param.rotation == ROTATION_ANGLE_0) {
-		int recout_width =
-			pipe_ctx->plane_res.scl_data.recout.width;
-		int recout_x =
-			pipe_ctx->plane_res.scl_data.recout.x;
-
-		if (param.mirror) {
-			if (pipe_split_on || odm_combine_on) {
-				if (pos_cpy.x >= recout_width + recout_x) {
-					pos_cpy.x = 2 * recout_width
-						- pos_cpy.x + 2 * recout_x;
-				} else {
-					uint32_t temp_x = pos_cpy.x;
-
-					pos_cpy.x = 2 * recout_x - pos_cpy.x;
-					if (temp_x >= recout_x +
-						(int)hubp->curs_attr.width || pos_cpy.x
-						<= (int)hubp->curs_attr.width +
-						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = 2 * recout_width - temp_x;
-					}
-				}
-			} else {
-				pos_cpy.x = recout_width - pos_cpy.x + 2 * recout_x;
-			}
-		}
-	} else if (param.rotation == ROTATION_ANGLE_90) {
-	} else if (param.rotation == ROTATION_ANGLE_270) {
+	if (param.rotation == ROTATION_ANGLE_270) {
 		// Swap axis and mirror vertically
 		uint32_t temp_x = pos_cpy.x;
 
@@ -1285,7 +1258,6 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width + next_odm_width + next_odm_offset - pos_cpy.y;
 				pos_cpy.y = temp_x;
 			}
-		} else {
 		}
 	} else if (param.rotation == ROTATION_ANGLE_180) {
 		// Mirror horizontally and vertically
-- 
2.45.1

