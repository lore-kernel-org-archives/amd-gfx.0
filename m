Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57E4C02184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAA010E843;
	Tue, 14 Jan 2025 02:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zh2JVr+U";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800B110E843
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljc/AwIwueE+hFjRPo9TYmTdVyzqq26d7c4xYGMpnm5DgDPoJDBdNuKTBZXYuPPZM1uPb7U5VdxLNavyWLl1qdBEuqMMDng+icrKjLJ/IV18GFm5jJ0qAtZiFffrZddBs04uzT/XDNxnkRqHB8CrpUMFJ48TjEyptamVpZFFSOSMJeZTTT2aukvvRZjCTuuVgk1t7NOWJXMpq6qngRXI8o8cAmOxmH52PgzgUiXBPkBdWHaIl5khNME9YKq7NTsXXmfIyZZn9Bm3waVWJXif86su3fS+r/fcfmzJ/JjjEl2xjbrAN1lBh4yNsDs0IgGWm+RhYXrGLFQvcuHvm3HSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HmmEr0M8T/t9AeMyalYZJtms0fFivrpeFbPzrgO+OM=;
 b=clggQkcOFSiOIRPW1OWe55ZlOAGHzXOUeeJEZEXpdb4QVmM5vb9s70xB2eRypq0czCkwWwUYkQNUKffl2h7ClmyZUja4x6sugue2xMurFjUMUbIFagkIkQT+DQR46v2AkIH9zwKgTRBjqcPfDy0APYKbaLhsVHXwHNGLhxIzMR0KpNaRDi+7NPzm9mZAM2NSToie1MCWfariMJWVYnk4yWQfDAuEdAI8UmOO8Y32I17fBitiunIkgLlpu4So/MYhc85OoWEXaA1z48Cn991hzca869XZNFcKX35HaUNvKieENF6ic2JPC9O5gpwYb8KDItHKpVp73ZtbWXUe+TMUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HmmEr0M8T/t9AeMyalYZJtms0fFivrpeFbPzrgO+OM=;
 b=Zh2JVr+U8iHO6EFGbUmONq595T5xX/E/9IgtVrtRBbE5mcWaxgCZQTj8Tr1+lXJQNEfLW5H6TSy3jwR7iJ1IOoV5Sm0R51HoLpcNlaeDl1t2yj1Dt7NCIAjsz4d70gTAH//T68vjG5NHGkrYraMBvnlihxLtMoKqw+9jKXzox4g=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:10:58 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::f5) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 02:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:10:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:10:47 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:10:29 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Joshua
 Aberback" <joshua.aberback@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/11] drm/amd/display: Increase block_sequence array size
Date: Tue, 14 Jan 2025 10:08:55 +0800
Message-ID: <20250114020900.3804152-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: bb872b6c-f692-4ba9-d374-08dd3440af33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t/EB5UqB4OfwVwPAaqY5fnMtJ5L2eIOY+UFmfDhIDE5dlVNf2hzL/r+RJjKY?=
 =?us-ascii?Q?pccwJlNckvwQ1MChNJwsM+u2C/lKwkckr8MFSvT3hjy2AtnPsD7fm8gOAdP9?=
 =?us-ascii?Q?zeEZsd/TRjxGYOKPe7UDpvQpIj64Bib8KApsFWVplUL19SJeousAzZs6UnvN?=
 =?us-ascii?Q?2k801EaDReo8VpMwod0pDk1AHaaxQXQkxphVcfoJqSvexcNnV0Vzykhr+TKe?=
 =?us-ascii?Q?NtXG7Cu0WrnkT3dl9n4kqBSFn8JVb9YkzzTID40eyESWl0iBO/+kPW5ValCQ?=
 =?us-ascii?Q?I1+AZatBiQTnWa95Ww3VD5y92wL71hN6ho4y1hnk/qr97oogufthxSSu/p0Y?=
 =?us-ascii?Q?JkKzvIYC7XuhBDVbzDy600eAzhzXHlhjof7JsS2xyMIx0Ah2+RuEXALBudqi?=
 =?us-ascii?Q?fnHzekNIViC+GbDPKMlaDCuAwFPf2MtZh2oRCZxnMhoW5/dJLJiIw51fFp1Y?=
 =?us-ascii?Q?7L+n5cPU4oyXbVf8ZaQrNUh2Ogkx4z0GIukN2NaFno+5L5+8TiTbjmQQoTMZ?=
 =?us-ascii?Q?TBkaxZcUtd0i1KWAA7I+O6YsMezpkOB56d9elZEaRx5nMad21OnexkP+D1uu?=
 =?us-ascii?Q?9WkQo/8CttqHJj9JWhqmExhOMHrLmYqr6WA94OKySpqxwhjjWs2ndzVCwDFT?=
 =?us-ascii?Q?S/sk0Gf3HGrTHG0tn+d94D3+f/DVOlW5VC77geYooWuDy5zGW73PCveFg/Ip?=
 =?us-ascii?Q?P2dEN6XwzhF3n5bO+IU2JpVxKwika+ZdVmZz79b39aurW6ZPaqGpplHDmuN5?=
 =?us-ascii?Q?42/2jSX4MlgaLjgPq3txlGBBqiHXPsJ51cZ7SaZFyz+j3eoiPTyipBYywkfG?=
 =?us-ascii?Q?ESg0JB6tJTg+3RS+2VNSSmxaCBcrIAPzTQAooe0+b7q0fmk2y3hGT3DgIKd+?=
 =?us-ascii?Q?B8XSLFF3vNQwjHtkUQWUCgGyI/T0/+3gj5+e273WPB+NJetmhrJgt9InhSLL?=
 =?us-ascii?Q?RgyOxyZO/e3c2UxnSbPkduXT5iNglVBs77HyCO4iQm4cYdfZNq0B4H1Tv5Be?=
 =?us-ascii?Q?TZSMFmK8x0GnJUe5fGooLpemiZt3ZIszSy92N84gPBkDpSTa6VxFt+y80xor?=
 =?us-ascii?Q?hQKChTFdM38Mj4qAO5YUPLgewlAV/igQrh6KqhwAbJJkQCj/F/zM+2w7GnXH?=
 =?us-ascii?Q?rnU3qmmuAKg0myD7hBkujAG8hApc8xeJj20kAH2XYdGukjrl/xiMmf95tC8/?=
 =?us-ascii?Q?CyltSHy1sblgbuq3MPcCAAw4GVcn6/oqeWUCKIC3rm7jW19R+D+SHYi23hK6?=
 =?us-ascii?Q?lJaF02R5B6qt660CX3sHlG9ejp57UiGVX5k9imKsOTVBEv/RVMhNxD1sbRMO?=
 =?us-ascii?Q?01585UAQvBkk5rhJ76KSsQgBwt2p4zgDgGZVewrGf9cr/7uVSdfs4F52ZzrC?=
 =?us-ascii?Q?K8XrMdVOtApnXxAYzJ/1lEdKSX0YGnZ/XhaJvDJhKjzNjyQhWHWoF8FyqiTb?=
 =?us-ascii?Q?8t692JZhmtoWQF3tYQmLQEvhgC0qpROcLpK9h2m7M+wwYsf/yFniTTojwCSH?=
 =?us-ascii?Q?hPU2Zg75d/bOB/w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:10:57.6876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb872b6c-f692-4ba9-d374-08dd3440af33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
It's possible to generate more than 50 steps in hwss_build_fast_sequence,
for example with a 6-pipe asic where all pipes are in one MPC chain. This
overflows the block_sequence buffer and corrupts block_sequence_steps,
causing a crash.

[How]
Expand block_sequence to 100 items. A naive upper bound on the possible
number of steps for a 6-pipe asic, ignoring the potential for steps to be
mutually exclusive, is 91 with current code, therefore 100 is sufficient.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index d558efc6e12f..652d52040f4e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -627,7 +627,7 @@ struct dc_state {
 	 */
 	struct bw_context bw_ctx;
 
-	struct block_sequence block_sequence[50];
+	struct block_sequence block_sequence[100];
 	unsigned int block_sequence_steps;
 	struct dc_dmub_cmd dc_dmub_cmd[10];
 	unsigned int dmub_cmd_count;
-- 
2.37.3

