Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFE6C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 22:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA6D10E05B;
	Wed, 26 Jun 2024 22:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1sQSQjxy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624E510E05B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 22:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJSFOO4yy8rH4n3ELfjeqwHE6zXGd/7Xc9VJBLtgDmEqBi56+udbHaTNY3zXWsnOt40HIZ18OfKUXR6WZLXXUoB0HfpM5IIOuKACgCV4Kw+xu0FClVgtmo6gC7z/1ui6F3CfgWgKDFciz287vseSpb8zY4BSa55LyXkEpQXzJPtGuU5BYXa413Ez3IPEloilzRUAHq+V4KmdVy0VDPNQstkrjNqON+IBwHq1K7TCB/Rb5648XFFlCsnQdzeiWR7tafseibwNp/+Bz+4j+jzKHG2Duv5BOJBXb9evLOkIj98izOA496IVu9RiYj2/LhPAUHhcpH4CLhYO5YdVidwz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXUdQ8z89nQKB9X14a9Po1z4c8lAKBaHnUvM1hTETL8=;
 b=PhLeywvfqEE74WaA/gYwid+zQ1BnunMvnu8pwrdGo28DMFt17q9t7kM8t0+UgjZLAB4+JsS004ehJSnMFx6Jn6EhAabHTJ2p4tV3W3ZYUf1fF5o2ofiw3Q/guEZL9Ar+wMZx3RSYr69WFk/oBmYpvw//wzErwbxZd8JKpGw5XM7jj3g+3YXFNGiRA3G62yO1QRP/nHxnG1hWP448xOTzfSVqTeBlbBE/y8b7ML3AJNFMR8Lfax1sPa1aTTFs+NFGhCz4jOMs2nqMluki3O02hCNUOodgNzMdMdQgqwazAGbtkq4caar05M2OAjI2aL4qhddqtlYypsZF09k9u1M72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXUdQ8z89nQKB9X14a9Po1z4c8lAKBaHnUvM1hTETL8=;
 b=1sQSQjxy0AwYq5HZNUJWZb4PgY/owCTyLb0Y96PSxte3DGGPJU3cKtq8SbIwijNwJq93KlGaPL2WUUm4e7M8m0hVsGbfcHqepEGfMgBa/TymqDUsFzYl5SrnwObsVFKJYfQ/5tz93TXG/PppI4o7y9Rpu06UbK5gQwmJ+dFH/aY=
Received: from CH0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:610:e6::25)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 22:28:33 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::38) by CH0PR03CA0290.outlook.office365.com
 (2603:10b6:610:e6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 22:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Wed, 26 Jun 2024 22:28:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 17:28:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 17:28:32 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Jun 2024 17:28:32 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <harry.wentland@amd.com>,
 <aurabindo.pillai@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix null pointer deref in dcn20_resource.c
Date: Wed, 26 Jun 2024 18:28:31 -0400
Message-ID: <20240626222831.691600-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bca9882-59a7-4129-3d5c-08dc962f502b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MJFZoUH6Fvm9ajEIkvQd/3dp7OaHdy9K0ozpuwktNSX+jqifcpmDwJXc/hxP?=
 =?us-ascii?Q?lSIxd+NFbilLLrconhKzjXHOGJc0k9OTnFO/WcG/bQ0fGyN5sbaVCYbgw+pz?=
 =?us-ascii?Q?B079xrAvPhInS9yVjTmGe95dRjP8pI5MeXxGURr25b8SajpEI644OBPz882h?=
 =?us-ascii?Q?XZFc48Nhp68TwBiB2bIDAeRXL4Rs0MEOqct5h/TwLzxaUYeH2F6fmZ6cr01K?=
 =?us-ascii?Q?wK5l2Rl/Uja3Cf8Xn4wU5xKqkj85rKPgO59Ci4e0FJusvV1qt7QQaQf3ByPp?=
 =?us-ascii?Q?Wn+JxP8zZQ7dozoJscZzpu7VdakZFCAQFXSX217+S8MFlqoLi11WrZoPXtBv?=
 =?us-ascii?Q?i8KMAQoY9Eau6YuTsDjlyvSTXXqjltXnnJjE8fzT33Hv3Zqe2DoLDN39ZDbC?=
 =?us-ascii?Q?zZk4xwQ7I1H//CbUsXNyFzO4Do6pK79Fw5KstIPAiWlIM5uwFnQE+ZRrx0vt?=
 =?us-ascii?Q?OfDyrVoFuUDluUamHse9zi9/4qb+rDFAW3X84fVBzcSVVfPGTM8jmazltLDJ?=
 =?us-ascii?Q?tRfwU+5DWlqf9GolYaBRd5XhKoQT+9/osauFdpnQJbonlFf0n3fH6n4cRRuU?=
 =?us-ascii?Q?W2+o8zbYih+7dBnpORW+8M/c0V+aDNohvj+p9aedg2YynLJdsqkw2mrTxrzQ?=
 =?us-ascii?Q?HztaugbL+juPR3kQs3S9ipaUSUHPOpnlgwgXh4xavr9OurnBysueI3+M9mwt?=
 =?us-ascii?Q?d0CrHX+oeHU/3X6QGwMjyWsfhnEACWNZl6baR6kzOPuE259qFLxMCIRJHCIo?=
 =?us-ascii?Q?2/Y8hxlPuI5pN/F6xeRYP1eEfE4fTnJ1zFVpQApte0qS5HQ+6ysit/XfOXRy?=
 =?us-ascii?Q?ulYRtHf35vc9z08x1Wb5b6d5LDA13Tgt/4sKTC3kwfqCBpZfDDdqQuAZ/v0T?=
 =?us-ascii?Q?J8EYjKrC32bV0nklEwTJsCF7n4pXNScqZV69n8+J4vLJ3yEntQyjaNjU2H0O?=
 =?us-ascii?Q?+Lnz/m64bLFR1LOt8GOzesMJ+1ZRebimEoEZowvT4fAqQsXfNEFU8upseeIE?=
 =?us-ascii?Q?46j0DQrO0ef/xlmaGR+SQB1OdUnscj8SQdi5aGHWtkluDn9qfXprmnmSqAJ+?=
 =?us-ascii?Q?to8htRMZItKUCuJkyuV+q1hRmJM5bw1ThCzBIMrwN8aLZSMj95kEaaLPswZr?=
 =?us-ascii?Q?1S6PoT6yHqKSNIdSYPY17gAP/s0GCaqDGGpoh3jioiCNFr2ftT/oe2AOzb1W?=
 =?us-ascii?Q?l92WO5MhmuxnAQ5BFOeZoYQi+/mKJu+r0/HnS5BPt/j/mbtf5pj6KWw7rTi3?=
 =?us-ascii?Q?Di8NxezVNT0X+cVmkHHfF/pZ1tJkgrnhOGucTUqrnJqpltcgR1uIgHtvnTKk?=
 =?us-ascii?Q?qxr86rrmbmXqjQqd12oguKYdyrPW9hpnpS1cEOJKUirX94w28/8IpiOwxcsi?=
 =?us-ascii?Q?iHPF0mGkCdHru2mPVlYRuUF5VKfKJdzfFldqceIpj+N0flU0eBtcX0L7WZY1?=
 =?us-ascii?Q?x6wuOaDru4BoRGsueuaI5fHGtFuTdkFv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 22:28:33.1626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bca9882-59a7-4129-3d5c-08dc962f502b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

Changes in v2: detailed description about the how the issue is
reproduced, and remove an extraneous else keyword.

Fixes a hang thats triggered when MPV is run on a DCN401 dGPU:

mpv --hwdec=vaapi --vo=gpu --hwdec-codecs=all

and then enabling fullscreen playback (double click on the video)

The following calltrace will be seen:

[  181.843989] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  181.843997] #PF: supervisor instruction fetch in kernel mode
[  181.844003] #PF: error_code(0x0010) - not-present page
[  181.844009] PGD 0 P4D 0
[  181.844020] Oops: 0010 [#1] PREEMPT SMP NOPTI
[  181.844028] CPU: 6 PID: 1892 Comm: gnome-shell Tainted: G        W  OE      6.5.0-41-generic #41~22.04.2-Ubuntu
[  181.844038] Hardware name: System manufacturer System Product Name/CROSSHAIR VI HERO, BIOS 6302 10/23/2018
[  181.844044] RIP: 0010:0x0
[  181.844079] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  181.844084] RSP: 0018:ffffb593c2b8f7b0 EFLAGS: 00010246
[  181.844093] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
[  181.844099] RDX: ffffb593c2b8f804 RSI: ffffb593c2b8f7e0 RDI: ffff9e3c8e758400
[  181.844105] RBP: ffffb593c2b8f7b8 R08: ffffb593c2b8f9c8 R09: ffffb593c2b8f96c
[  181.844110] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb593c2b8f9c8
[  181.844115] R13: 0000000000000001 R14: ffff9e3c88000000 R15: 0000000000000005
[  181.844121] FS:  00007c6e323bb5c0(0000) GS:ffff9e3f85f80000(0000) knlGS:0000000000000000
[  181.844128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  181.844134] CR2: ffffffffffffffd6 CR3: 0000000140fbe000 CR4: 00000000003506e0
[  181.844141] Call Trace:
[  181.844146]  <TASK>
[  181.844153]  ? show_regs+0x6d/0x80
[  181.844167]  ? __die+0x24/0x80
[  181.844179]  ? page_fault_oops+0x99/0x1b0
[  181.844192]  ? do_user_addr_fault+0x31d/0x6b0
[  181.844204]  ? exc_page_fault+0x83/0x1b0
[  181.844216]  ? asm_exc_page_fault+0x27/0x30
[  181.844237]  dcn20_get_dcc_compression_cap+0x23/0x30 [amdgpu]
[  181.845115]  amdgpu_dm_plane_validate_dcc.constprop.0+0xe5/0x180 [amdgpu]
[  181.845985]  amdgpu_dm_plane_fill_plane_buffer_attributes+0x300/0x580 [amdgpu]
[  181.846848]  fill_dc_plane_info_and_addr+0x258/0x350 [amdgpu]
[  181.847734]  fill_dc_plane_attributes+0x162/0x350 [amdgpu]
[  181.848748]  dm_update_plane_state.constprop.0+0x4e3/0x6b0 [amdgpu]
[  181.849791]  ? dm_update_plane_state.constprop.0+0x4e3/0x6b0 [amdgpu]
[  181.850840]  amdgpu_dm_atomic_check+0xdfe/0x1760 [amdgpu]

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/resource/dcn20/dcn20_resource.c   | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index e783afbbb397..5e7cfa8e8ec9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2200,10 +2200,11 @@ bool dcn20_get_dcc_compression_cap(const struct dc *dc,
 		const struct dc_dcc_surface_param *input,
 		struct dc_surface_dcc_cap *output)
 {
-	return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
-			dc->res_pool->hubbub,
-			input,
-			output);
+	if (dc->res_pool->hubbub->funcs->get_dcc_compression_cap)
+		return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
+			dc->res_pool->hubbub, input, output);
+
+	return false;
 }
 
 static void dcn20_destroy_resource_pool(struct resource_pool **pool)
-- 
2.45.2

