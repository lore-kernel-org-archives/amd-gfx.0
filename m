Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C93CC27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A78110E6E7;
	Tue, 11 Jun 2024 16:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="32r1Qn3m";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBA710E6D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyaF0YKexHdQuCXo/Ma0ht081dXdefBz246YxQdnFc9Z2Zo3VG34CsNsNLVoL+ona/k7Hngkho1doOyRf9iX+GDObl+guICWhqt0jQNmwG9kDxb9FsSka8Mk4chJppEb1TIh2tcA13xO9gqIU2D1Y5cWgdJy2EqC1QKTR/gpIeyfRSWRhy6eTktuNIVTomC67vF9VxVznRTf8wxZjccR4EgnZTbRr4A1vhw3polG6/V/kjlpzV00EtuISg2AT3i/gout7/xvQddkPWVv3YfG/fCqeBfZl8f4CSOZQv17r0RrKmMbmmY37QvrLmouBovTf3pu9KEo9JeK7AEOjJ52bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxeaQnrsj17atHQDiUARN7JlL7/GBv8KswQ5lX64Szg=;
 b=nBze+e3DJWMLUx3jWbAKKXJuItAvBB8tv8AEnxuvo2Vl298Wm6Qu0gSylniWXXJmWTTvWTPHvSnqi2APjaRLbbbSBvf82Majg8muNh1nJIzV56nu76luCnk+YEIoxgN3IogfOCQis1Dx7l8Bq1MdS/jAdp5tIEFp0DXnU12/98u6l87twguakrZ5BAR2E7zIVJCbKW8+vfGOEgzaG8jJdPdZrycNxbJqQE8AJylXiZEANHvnOpToIB21oF+WnW3Equ43k0TPJKWojBa8ipBmIeBtPOCAl0/ixCWnYWNF1lOQcIVc7kDo8XWIAvft1dq/2Eg78KlOxpknt9DUmqP/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxeaQnrsj17atHQDiUARN7JlL7/GBv8KswQ5lX64Szg=;
 b=32r1Qn3mo4XVJDylqdKMx4asC+oc0zDG53Cc4b5cF2A8o8SKiOsSoXDkaa3++zfDqnI/dbo6w8FWuvLYQnoGzPoB900vSAFu2dBuWAmn/fXGGb/4la1nC+BI4sV4VaZ1Rzb5PM+nszVHMQWoCw8hXLTuTtWf+N0BAiJDO7bY+RE=
Received: from BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:51 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::57) by BL1PR13CA0151.outlook.office365.com
 (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:51 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:48 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 31/36] drm/amd/display: Remove redundant checks for opp
Date: Tue, 11 Jun 2024 12:51:34 -0400
Message-ID: <20240611165204.195093-32-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: ce079562-b1bc-4e6c-94c8-08dc8a36ee80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iD/QCnIXNHHTqQqG3chCTbpbfzLOauOT1V1BnBdvpktVeWE26sHmKC75NWHz?=
 =?us-ascii?Q?pcvBpwDcAhwBdsCs5/6qkSmhMHNlvDtp2bYUo368droGjBJ5S4ox15mqddVU?=
 =?us-ascii?Q?H/0b/66KRr0weZQcSRXF9lgDFbXNqpK5OjhNH8qhw99VkmL/wKWOv6/Y3oXS?=
 =?us-ascii?Q?k8uKSZ0e2nTwSYEpHa8JER3xTbv5dsIEL/8Eqy8cBurvzEX5mSP6tsO3bZEs?=
 =?us-ascii?Q?d56Tc2RUtBs7Nmgc6RO+pi54kOH2LgLXR+15QkTJsZv0XDiXIWpaCzX5O2TT?=
 =?us-ascii?Q?bi80/G6HXnTj+FqEU4x8ZQBLAM6E1ceX3DtdfdcN5sPCeCI9YT4UmXkRMcM5?=
 =?us-ascii?Q?KbtsrIEqzav+4SaFnEE6vozaKW4sOUj1BIy7vOAYVSsFPR8Rz+BjdWXh08Zj?=
 =?us-ascii?Q?NTLJYV88v4mmdY7GpAsZWPF9HKG7+yPgSzjUaRAlQA2qVyMnX+EQ2ITWply8?=
 =?us-ascii?Q?d+l31NZJIGg04gECM3ecAYGSSiH0DWYolpQNV8Yx+KTumOIiX6hsQ61WAxof?=
 =?us-ascii?Q?CMSmz8aA3nFqJmqcMO1NYcaklyCiLg3Flg2epZwfwGEgSmDdARRdNbl98wvk?=
 =?us-ascii?Q?o/8oAIxd5t/cJoCIsc+PoobANGDQaxGXDlI+YeOu5aGJEvBKqarcmLTK9RzU?=
 =?us-ascii?Q?8Zr+GkH6puVSJkmOWO+1Kn34fnaKpFf55ShRnz6mhHh5PKbnAHZ14NpQ0P7v?=
 =?us-ascii?Q?gXGxoDfEED8iYSpvSVva0VV5u23Hd8cMG5adOKrcm4XHVlSnsTCabtLirqLb?=
 =?us-ascii?Q?IA4zsulp4TA0gsqIMkKSiZ0ctXtIohBEOnTx/NJP1syraiKnViPVvKCu0mXK?=
 =?us-ascii?Q?pdjl1Gt5BdIpD0cki/WJ8ZDK/teIc7o/rnnVp99OW9elZG3kNPoTXvk0N/Gv?=
 =?us-ascii?Q?73DOnzaMAKfMxAAfiTTuW6RoNDh6mnmk1IcMX6ltkNl+7rjbcIZgWTlXLQru?=
 =?us-ascii?Q?DrALV/BfnIwoIjhwHl30H2MzASDj+qJE4W4DtW3Cgg5nLOTnFLfbd/UT2vUB?=
 =?us-ascii?Q?xt2V92YrUzYWXfGHbvd+UaHRNAvrRSX2qO71Q5Gyka6lpm3HfY0p6B3DWrNI?=
 =?us-ascii?Q?L0fjFO2vgCxACG3oHLe4n5xHMk+T/XlQDz4qLghmpauMY8BWprKOYEt7VdnM?=
 =?us-ascii?Q?nfoVI676YSc1+/2+K3/qQlJyh92510Uqt0oOFbeTnO1y8G8i51Y+OnQiSJN8?=
 =?us-ascii?Q?nnI6cMep80iu4jdQpFPoOAUpZNRLY67kJg5U99akEvfntLL71MpLaVkFISbe?=
 =?us-ascii?Q?EwygSQpMOxGgn7zJ5Jht3t7hb8E2IGuHp8xcJ9nTm2KcwbbJU8q2vqNyqYRN?=
 =?us-ascii?Q?lJi4hiU8PrupQIlYiVySOWWJ3/mZvN9exAYqnsmGoYqucmK4SVzlMV2F9cvu?=
 =?us-ascii?Q?fE7YersWVhbYk+R/c1F/lj0TC7+OZkiRRj5FpDB3ZgFObMPC7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:51.1382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce079562-b1bc-4e6c-94c8-08dc8a36ee80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
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

The null checks for opp are redundant as they were already
dereferenced previously, as reported by Coverity; therefore
the null checks are removed.

This fixes 2 REVERSE_INULL issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 85f014cae6be..841b6423952c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1260,7 +1260,7 @@ void dcn10_plane_atomic_disconnect(struct dc *dc,
 	mpc->funcs->remove_mpcc(mpc, mpc_tree_params, mpcc_to_remove);
 	// Phantom pipes have OTG disabled by default, so MPCC_STATUS will never assert idle,
 	// so don't wait for MPCC_IDLE in the programming sequence
-	if (opp != NULL && dc_state_get_pipe_subvp_type(state, pipe_ctx) != SUBVP_PHANTOM)
+	if (dc_state_get_pipe_subvp_type(state, pipe_ctx) != SUBVP_PHANTOM)
 		opp->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
 
 	dc->optimized_required = true;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index f96adc689055..1635e5a552ad 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -408,8 +408,7 @@ void dcn201_plane_atomic_disconnect(struct dc *dc,
 	if (mpcc_removed == false)
 		return;
 
-	if (opp != NULL)
-		opp->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
+	opp->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
 
 	dc->optimized_required = true;
 
-- 
2.45.1

