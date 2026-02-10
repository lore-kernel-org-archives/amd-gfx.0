Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6794EA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BA088F94;
	Tue, 10 Feb 2026 13:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EK2OQiWQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD53D88F94
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdcPTDIHT5RnPFk/jdhDfYgaInZztunDsFR1qYRJOHsrSigRylgyNtlwfPZAJg2P6qfPiuE++v7/hD6NM7BLCBchRW4B8KeT9DAved6Hr49rY6FAG7rYinRPfA6159WYcy5ZqOT0/kZBBoo4o0elkMmhSZQQnZB4T4cv3woxzDIQOLyrdg8fccuIqizS/eakwjW1Qj6w30d7zq9yLTnCx5eqsZl+4LzeCELoNgrRjYWzQ9HTQ+psM4RRfyRtTrd8H+JRsiPJAaKJGpFBwyDt+wdJNuNnFji9AlkXCsySqBbYxJsA2O+Z+KAzlPNUGd6KvDbdepYe+rLbYlqPReGvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHyTcHYi3EJqotMXDQsr031zF8GIyTx85i0djlLT0ZY=;
 b=a+4An1YSvWlu6hIW6bQ7q8k3bjBE8B7aTDk6krBE7ygr01sp9dCzs888KQaDP/oQNIdtRyfb5lz5VIS3CKB7xUWdjy7MudaRDyGvRDUEy8YnMC0anzRtIcDZ30+3qZXtFtwsvoqPzckpWf4WzmFgSvvSKUym6nxwK85rAWlRfSAe85MRu82vnXc6kEGvqfP6G3a7JwOHVFeA1uVY2MJG09U7CpVseHcQ+JQfIBj62MlM0xM13JPMl8IotlTNk+rOARj3ipr94gfnS7ESYgTA5LKBSsN6YX9lzkTB5fHoLxFhXFX1xl7ot8sVpgf8e40Q9vWB2Datu8XYze9iKavE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHyTcHYi3EJqotMXDQsr031zF8GIyTx85i0djlLT0ZY=;
 b=EK2OQiWQVyBKNj3Uxvzx7rQH2QY2W0Y+Zh+EGAh15sU080RenOJIKBWkJvpL8mhmsuS13Wo05+k7HjTaZHHL3bUKuxNjf7WtchzHALz3OyGJx5IGBpX15+DwqnzVR9Z+G8JK+WUvQsw3cpIxlxfoO1BWQsMaEu3V494Fa0M2qKk=
Received: from PH8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:510:2d1::29)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:54:28 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::e8) by PH8PR22CA0014.outlook.office365.com
 (2603:10b6:510:2d1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Tue,
 10 Feb 2026 13:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 13:54:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Feb
 2026 07:54:23 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Feb
 2026 07:54:23 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:54:20 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <samson.tam@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 01/18] drm/amd/display: Add static keyword for sharpness tables
Date: Tue, 10 Feb 2026 21:49:54 +0800
Message-ID: <20260210135353.848421-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: e65be9db-2427-499a-3c00-08de68abe848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BXQFkY88/ISeBWKrNy/QzYkR9tBfx4aB5oNYCibTglpWFmBv8tJLFFbrX6dD?=
 =?us-ascii?Q?MQPoxD/Boeh+oyapgG/bXUwmjUcEjqVMxgxBZoQoSFcFm7A4dQVx2acyAMNB?=
 =?us-ascii?Q?b59LaES2lai6Dqkj7vDl5ZZdvOxNikxZqzsonraXjT2i/j6BvHfqlo+q9JdL?=
 =?us-ascii?Q?17HFSjsT9bfVo0T9UB0IkmzjtvehWp/YGBchxnE2ctDIgvdULRYdeKIh69X3?=
 =?us-ascii?Q?4UuXCgOSaCw5PiCppESD2nCWsB3q2OvPJiWSGNltvJYYk7jO3eVpxLObE/it?=
 =?us-ascii?Q?uFmRi/b5SSC3r+wxN7m1PDnOyU7SGrxVRQR3mlUiI16Jnegk8Zz+2VtV6qdR?=
 =?us-ascii?Q?IMsuODN9tiwGaFmvHrl4s58XVPu7jLS9sQ1HeJ9UeWB6KnPJtv2GNKVvk2qw?=
 =?us-ascii?Q?ly7F+aqUdBAJn07aDYPoklEirNfdFVRCTGXX0wK6alM3lAKfIxRE7ZtlQkRi?=
 =?us-ascii?Q?6botxY7SgogeWHOqDa4lLOMyQSR5h3+9Z1SHOruZwDdDt+X2v0Ci2n2oys6B?=
 =?us-ascii?Q?79wuSc9yt+caa5rJIdHxB2Xn9lt8hg4HomHp04psij/PKLSppP5OR9bl1wOs?=
 =?us-ascii?Q?wpAe0oc4xDHLn1NK7ewPjKK7ZsQmUGKY5U9VutwESkGdvkaHSDG8pe0QdSv/?=
 =?us-ascii?Q?aBV2Jlq4aOSo8WBvodisERqd/ogjzSn+G1s12noObbOVwN7sX1F3oA4WmXWB?=
 =?us-ascii?Q?Ce5qlkpf1PizMNzJUTkaA0ZxIy/kvhcaNn737jRUFig6oSq5IJp/zrwZ5N4I?=
 =?us-ascii?Q?Vu5+fs3CzsFIixb7Nama5HefqQCEhJCAiDUrFnyxf61XFPK44wYN9N3CpMTZ?=
 =?us-ascii?Q?zzRm9Zf/n/GLrl0qUl5YumOVhjawgZOuYDkdFvv7D7FALlJkirl4JjYtH12r?=
 =?us-ascii?Q?y95wm7TSgPlOSh5A1aieyJxlQUp5Ezrage0XDXaJrkqYGvH22bF8smiDY2qj?=
 =?us-ascii?Q?c9AJgso1871YXoUbci+O1iZYEsvViv1kJS0OOBbXOpl32UvBPJKx4QFyWvKY?=
 =?us-ascii?Q?R6Vpc1lU7kuYxzVHr1CH02Sd2TPtWObF4CoaMm192z2bjlsdjMmmrAMOlKA9?=
 =?us-ascii?Q?ts+TkklgS7QHqvyY8rSZZGwHhDpiUjfeT5QIfhfAU+VrSczHYalypT761BnR?=
 =?us-ascii?Q?86m98q2wyHng4/GlvqpmB9Fgaq92fqz82CF20Vb2mI7h6UbKzT+nJ51LxHnM?=
 =?us-ascii?Q?5W280l8A2ozjHvymLUyphTPmBMFJvyZjNAbbTkOZj/g4KHS5/bvs6L3p5K3X?=
 =?us-ascii?Q?CFRIngQm5RC+bdKWY+Fu3zzgGGYUHv0a7NsCtSXJ4C6BLL6i4MA2hFa3oqyj?=
 =?us-ascii?Q?Y5OxhZyHerMWVzekK/QQ5m5ds3EXKTtVc0bfTEEbgtjOrRpsAnLiuKDVkdp/?=
 =?us-ascii?Q?0477bPU/ZJiVjAtfC6zS5IdlwGMWLF/FRSAiKfciiTIS2EA41LIIdQBJlZg6?=
 =?us-ascii?Q?uI156C3PJsxx54uZ2uvnh8/dNlgKfeom59LGG4vDNVfQrBZ5riR6e72kdUuu?=
 =?us-ascii?Q?8ifTwkI1xDLra+1HEe8Eg/XoBNTA7SxGmmQQAscQgm+DMGfyPQk8w2/pAW9a?=
 =?us-ascii?Q?CxVvuJfX+DvfdiIUxnQObHu88q+U2vw58VwyzZRKr4k2NOi1nhra8wkKD/GD?=
 =?us-ascii?Q?jTYbXjIvvSVrAE665cSLsTsCs5r+qV30p9yc8CGHe7gkyL5YzZmxbSgrMoNb?=
 =?us-ascii?Q?uYFtAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eG6UzTxXE7fCReC5b8FXP37QVFRCc09eOgwwEwn8eTrGhR1E7v43cL+8fqIUgHL8PVS8cTb/U+JnS9IlQ6L9/D49B4l3AMtZY2FNxpfIAs1qELZ/xXadWQRoEstP9nvZe58BHo/cwQyGDM4cx05IqucIAJ8Rv8QNDhrPB4NMTP//8E13G/boKe9EmzwG8HJL8sflkEoslC2vZ2UmqhG2j0qEf4CkeT6hZXb3cLI+8tWObtwbearR9iKZ0tPMyoFCi7XKEjB00A/9M0K0NcDcvRypEw4v0OUo8otMWNODsW9iP6jtMrtNbYddT71vwhPMmPJdMku3Ie7NVNS84fTVLZzuaex84pYL45qJjmHRwVTqesoZVv5ypmaMEC+zsc1RSD3pG9XLOhFQ7zkVNN0AF9+oai8DUjnxS+2ZJDULurui3p+7LkD7mKC1RSuaD/fx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:54:27.8142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65be9db-2427-499a-3c00-08de68abe848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
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

From: Samson Tam <samson.tam@amd.com>

[Why & How]
Sharpness tables are only accessed in dc_spl_isharp_filters source file.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
index 1d9edb89e47a..a75ab23b0726 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
@@ -293,7 +293,7 @@ static const uint16_t filter_isharp_bs_3tap_64p_s1_12[99] = {
 };
 
 /* Pre-generated 1DLUT for given setup and sharpness level */
-struct isharp_1D_lut_pregen filter_isharp_1D_lut_pregen[NUM_SHARPNESS_SETUPS] = {
+static struct isharp_1D_lut_pregen filter_isharp_1D_lut_pregen[NUM_SHARPNESS_SETUPS] = {
 	{
 		0, 0,
 		{
@@ -332,7 +332,7 @@ struct isharp_1D_lut_pregen filter_isharp_1D_lut_pregen[NUM_SHARPNESS_SETUPS] =
 	},
 };
 
-struct scale_ratio_to_sharpness_level_adj sharpness_level_adj[NUM_SHARPNESS_ADJ_LEVELS] = {
+static struct scale_ratio_to_sharpness_level_adj sharpness_level_adj[NUM_SHARPNESS_ADJ_LEVELS] = {
 	{1125, 1000, 0},
 	{11, 10, 1},
 	{1075, 1000, 2},
-- 
2.43.0

