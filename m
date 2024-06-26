Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF82C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 17:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B146910E964;
	Wed, 26 Jun 2024 17:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BylLzRLR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB4910E964
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 17:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx/GST/g0BOsnkVjzJKd0bQOOt8jkiWw7BssXTWFrHaX5wTA60xKV2Y3Y+dtRH8mYdBMHF1lY0pynXXuSZ6H8uLXeHK645NHto0nxTAtSx8SsTbF9OlJfDBxcwDxGVwLsZVYi2fJOjTZc5XuOzXRQ5UpYEa0YfN1Pf3BIEOJ0BVYFp7wtIC7guGz3dEq/CoIAgzBy95owGShp2xd9bf5Szcph49C7jGHm3YN0y0t5Qdsv9E+Kh+31+gqGFEk3+sCszQ/M0JVpQGeJXt/jAE50VE4Dp644jHZCCoA+gWxT2pHYK5Vc1b3shTVSW+ppj4ed1adL6bo2+OyFA22DvAI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erzWSCK+dbWeK0km4xygsacOfG4v6VbB8g0zy2bV+LY=;
 b=DcdMYfBTs0LoDRbF/Zcp52iNdXp0zP/L9ZU8cMIKuQ5LURwHiK39QpR3/WO49Q3gnTS5fL8dv4aNyQMjHW+4lMku/u9MjaLOexu2INo6M5rXNd6t7s/1w/bOq1VN4VHHpL/ilLqxujjilTuM1p+lZMoQ5YRhCBjitBvvcvpca/Rmzhu8VUyNjDn1vdb8dSG7HuHMMR3c5yk+nxrkima9mQcvqVRDe83iu7hqAsaIL03DV/8TtYOjZMNfMsrYtBSouDeAWIrj1G6Yvxo20w9H3QUA+E32JJjl6WXaK455oiWcDo4no+EYKIyaQu0BpjFvirY6dzKseI+dUZN9/8gklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erzWSCK+dbWeK0km4xygsacOfG4v6VbB8g0zy2bV+LY=;
 b=BylLzRLRUVaQ+SjwohOU9m9nI+7zCStF2+K+9kXl9bWKjPj8C+aWttvQSXTk4PvOtwrrrvciP35Z7qy/Rd7oiIpCMb6qJBnfrQyB+Vz80jbjmJQ319rsVbL5/5wlSPHuzrX+dGSxS7wNHWiHEPOPg+HPahScZzI/O+K/Zzj453Y=
Received: from CH2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:5a::28)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 17:16:54 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::a7) by CH2PR08CA0018.outlook.office365.com
 (2603:10b6:610:5a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 17:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 17:16:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 12:16:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 12:16:48 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Jun 2024 12:16:48 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <harry.wentland@amd.com>,
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix null pointer deref in dcn20_resource.c
Date: Wed, 26 Jun 2024 13:16:48 -0400
Message-ID: <20240626171648.660826-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1289ba-f29a-4cac-cc5a-08dc9603c6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ET9oTW73SLLnqRE2QTnUQ1iIsjbAIgeUG0v9/qHxQo3E971szhOdUOHWUDQ4?=
 =?us-ascii?Q?g43ReYdE9gCnqtUSTs15E/V8ZmxX58OhdGr0tTMFG7a9ibEZvrvRnFSFw02W?=
 =?us-ascii?Q?9AFcRw/tFVVD7pBQ4Al6SzQ1IfSyyOwBeNgT3AGPFeTOlWQRxmLA5iMuHOJS?=
 =?us-ascii?Q?YSQ+5fySoWRADGDFzFZkgq+ZQpXRV3kvhDuLoGqNxADsptZ0kLErSs918tKt?=
 =?us-ascii?Q?3qIKMu3kEVa8CZkNTUutzyzD9oEbgC7+9IPBmm2XHvCU3GvPQNcjk3hrnXJP?=
 =?us-ascii?Q?VNTiCNFAKOfTKjyiwkvaIsoz/XWoMJghRNrLkIVyYxZgJykvVZdyIrQsWFyi?=
 =?us-ascii?Q?c2M9jXjwdE75hWxqrU8+2DskhuUSVqWt9Lwi1ZCt7kc64BlnmoitgnCUTUe9?=
 =?us-ascii?Q?34/ujrt+bXtp4WyWFJpm+RCUL4Isl9H+8DHorODuYlF3cnTbdCoP0ab4zupS?=
 =?us-ascii?Q?jxePROkRm9wf9cUkfcy1Seh3DnBfnXO3e9B2L+jk6NeEmWuZGJwPyZ9fJ9tP?=
 =?us-ascii?Q?6g1GMZ+faDRGW5DC98DmEAF6ffPSK6UkzJiMnUwrUwZcfXbtrCk/Qh9C3nY7?=
 =?us-ascii?Q?OQHVmaNT7Ghd8Ptsrhqu/7jAhMhUvaqCgUSchdlfNTUvsgdNhK8axKKIr9L4?=
 =?us-ascii?Q?/ko/ElK2jjqHi3JdLlUrL8yT4i2QbJXhXInQtD2OfE9FyNuwp1zj6LmC6voJ?=
 =?us-ascii?Q?mLSqx/gCHIa5HPQDcIO36D8SwXkno+EXIaplglrrFK2b+7tIIAfLXSR9rMeD?=
 =?us-ascii?Q?e4VhMaVbCvEdKp8cOzuRMwwGs2DmnbE3gu/NvhEAdVPA7bMBze9GwrKUHK4v?=
 =?us-ascii?Q?BLw7jmuifG4f+oCviSb89rkRUYWFUQr++kkGcutKi1ulq6UH8tsRybOS2s3r?=
 =?us-ascii?Q?yedwT3vzkjYyCPmLA0IhE0nIExzX/bizVQF7gBdBzjnCCW4CJT/wLYfT5meD?=
 =?us-ascii?Q?ISbESAfaneJwOW9ZjnQ+OhvzHI8VV7/Zbvsxnd2fzUXN1g5yHPJviRs0E6g1?=
 =?us-ascii?Q?y9mg5JFVf10hFv8jBHpjctBGiffoyDDbxe31wmAlM9KS06fhbrL4VS8qdYgB?=
 =?us-ascii?Q?pduUYMGSH180ICBYS9vEWAMZBi3P8pdFX72TgcbHC8gQJ1fkTZ5eY8bxgDBN?=
 =?us-ascii?Q?4MdW5KcoM4PFe4dqKv1y4OY5zRFWg8ocnJSQhO3En0/63p16ugVP5Aswt5va?=
 =?us-ascii?Q?YzmbQZrf8Pj5YDZhBJ7ib61yFUtjDxfBtRQkFw7Yd0BMxBLhsjNTOhckmvxy?=
 =?us-ascii?Q?AQTzJR2yO69Z7vmNeo3xeearIIVsWX3G2Vs7r3wnytBDKt4OlIgUQFsH8Wi/?=
 =?us-ascii?Q?OaAd7lJyFysmtqCP03bzpSWx3SzM0X2p3VOTdqjCD8NAtHp6OBEeQHIGRhdP?=
 =?us-ascii?Q?Yb2FMT0KnHH3qNBLAMKhkbMgYhF37IXhmE3+bjihfKm/w+2LQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 17:16:54.2331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1289ba-f29a-4cac-cc5a-08dc9603c6c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

Fixes a hang that has the following calltrace:

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
index e783afbbb397..645927496807 100644
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
+	else
+		return false;
 }
 
 static void dcn20_destroy_resource_pool(struct resource_pool **pool)
-- 
2.45.2

