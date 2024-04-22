Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A195C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70755112C0A;
	Mon, 22 Apr 2024 15:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JaHufdMp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0020A112C09
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffK3PEgsISjfPpjwZVcf6eGPC7meftc4t0OrWRglB46NMcIAA2M1Ct/gzx0rAtXVcNHOLVtPJcUjrhjFhLKb1G9ezlyXf13Z0dW80bi7z1kQxRJjrMJPPJ7vaG60WFIlWhcX1bHi/q7SDp0BCnewMX+ZboXfhENNx04Zue6ZhOZRTrNlcg97JabpPv8dFxjJrklo4rrby2Zd5p9L/wWnl6UqNCtmwbe82gC2rDUDySmxY0+Rcv0ePmnWPdqs2zAjQXtWdgCvvcafKLmS6FqrPdI7G7Z87qEsVrnTloRVvVU93eKbqeqeALXuBh39GAHhy/6HVnkBRaQifsyqqI1ftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imQbMWc6hck0GE7f+g0cLKQ2O9xSAh70Wsxv97j4rkk=;
 b=GnUAgPB41wGbZ19+wbvp1RdeJaJ55ejOuDrLfO3EAB5Ztbp/tPpMaUrqGeOu9CkgmNPvOmVdljcI3IV1/HnCSTj5OuPWdggMt59ftaIPVysJYUAJQngupiG/fu8TqWrTcnkB3Vq0cujcWlTU7ldtwZZQgdFLhDmGtdEys+wijQagWxOhUS5TD84Yoc898BrDRDKJnlEbA5Qz0T8wf+hhKzHzTeeLXWOez+6BzzI/W3Rse398p8sQ0GslZG5ws+sXCCkVxb8feoU+HQEBz1xxOfCo4f9+fOXIgBTcFfm0albLX0XIHx0hgWSIZLTo7itwE1qVKAhF/bNr+dTpUu4iBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imQbMWc6hck0GE7f+g0cLKQ2O9xSAh70Wsxv97j4rkk=;
 b=JaHufdMpBAKPEkxmuAh+7K9FsR+WP0VW09bda/3tGqs+tbW0Dpbf4CLfvpxjDWOYk9Vbr7MvccAtwyshry8HKSxZw2GmvSVIUQPgnlid82OfQnZLjGhxYjVrRvxgWKSWps09m0wloG5i5w4YOttMkpYfKXJn1UE0mEsb5sJlh3A=
Received: from PA7P264CA0109.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::10)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:31:45 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::3c) by PA7P264CA0109.outlook.office365.com
 (2603:10a6:102:34c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 22 Apr 2024 15:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:31:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:42 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:31:37 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 34/37] drm/amd/display: Update dcn351 debug flags and function
 pointers
Date: Mon, 22 Apr 2024 11:27:43 -0400
Message-ID: <20240422152817.2765349-35-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: ac93ca6b-8bd1-447a-5606-08dc62e15053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8l7RfLKgJRYbfh4ndbjdDKx/Lv1E/ORSBlH5RfaXGmyfVJReuHgeSgzDBt2F?=
 =?us-ascii?Q?xCzNtt0p2bnUMiCOPMY+jjPD7+rintqJDfXUKXem41cObOgbl4QPJnygL/Vo?=
 =?us-ascii?Q?0HOGO82uedfZV64xZTWCreJNE/yI8y6l+lV1gJtPoJLqVIBss8pKvUEwDDbW?=
 =?us-ascii?Q?gAXNMvYeotVZppUSustJO7tjG/LPCY74CL3T6XDySmxvgWi+EZ9c67jUW0LF?=
 =?us-ascii?Q?Z5ZhACt6HwpEL5fT5kQPTPbOjj6/cf65A0+kDYvDDXkuP/ybVYj2PiLsmxyP?=
 =?us-ascii?Q?7yN0Zubi1conPIUOLL95QKRl4uSS/e16aiwQHNCkf6kgpz2fzbJY71DRBVin?=
 =?us-ascii?Q?92VQaL0W0Wz6u6Mk+E5O/JaJvRKIADFMTJ8RWWWDjvaOCv8KrRBMyJVWURer?=
 =?us-ascii?Q?TkC/4dWt817Fsjpjv+eScPXYChBCIVZaieAE0vZpTYK+dFkV7WrQgdigDFCL?=
 =?us-ascii?Q?gv7Kk4jBf3BSUYdfvxkGbDHXr5Qspj/NLjL8vMz2iDkbRmys3efilWvHl6TM?=
 =?us-ascii?Q?BNhfCpe+xbv6UCkAwN++js6jXO7tV4ThASsx/w1Nj1Tgto9qKGxNXktaFTdX?=
 =?us-ascii?Q?PZ0lO6zNQUNbkUZD9O6hkBemgF0fw6zYz0FOIW1RsVKEEEf5EGo3ZDmCcs6s?=
 =?us-ascii?Q?c5i+PZ9mwQez20N6tcfWEurxRSu9GKAVXhs9Qgu6Ij/szZqY4zVbxV5O+GCQ?=
 =?us-ascii?Q?BEpEuS2XDBDVN+YpdGvXPgUZvnzz8DZitxrqBD0wR6XQYsF4k92Yd8mOh7AU?=
 =?us-ascii?Q?t4oCpzJQyT8Ou+9akbyx/Sqq6ttERN2Y1XPqhmWYLgM7kNCsTulIEy05zyX9?=
 =?us-ascii?Q?Y497brYR3qEI0UshAQW5AzwlXETQ3zsGxWkOaqrFazM5VQ8Q3L8o2gkV50JZ?=
 =?us-ascii?Q?nLX0AzmCIyBfKby3C9xS0+dImmEdyOq2yJbOQflgFRcvt1weU/R2JsxvxpsR?=
 =?us-ascii?Q?q8YX2Jswf5me7NKYQUlUu2hH0+3QBntGKb5gTquc51Po3CkQA1ohHf1Q3VRt?=
 =?us-ascii?Q?0N+garmyDgpywmlHGzUxeVZv6CoA3xQ21y8yJyCxdvFGnUxigoFfvRbTvsMY?=
 =?us-ascii?Q?ZFKZU+Ti6YoVnySvVDBW25uBziaBmJctMjggy5G0L9lf0ZrOBYvSJrr/jY+8?=
 =?us-ascii?Q?fCCKeFhkGYy/QJjDvGzIP2XvFwSN4ACgxjyotCJcyPKgh53T4JJ5mx7/cQz2?=
 =?us-ascii?Q?Q5D0KR0rtYIa1uq6p8BqV1Y0m8Ba7F7uRT5NlCTs5QVpHx54/OQdXTg8E94B?=
 =?us-ascii?Q?OriTEGvRftaciGtdCBzg15qvy1joCWXHrDUQp8P+VcOtvC4c57QWNuS2RpWw?=
 =?us-ascii?Q?C0WmTAkVZQ4uZr/Qkh3kku55mHfuIdJtvG7PVpg2cfaSKppIM9bRibE1iUEZ?=
 =?us-ascii?Q?AJ+iNCQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:31:43.3945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac93ca6b-8bd1-447a-5606-08dc62e15053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why & how]
There are potential issues with Z8 and IPS
that need to be addressed and need to add
in missing function pointers.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c      | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 3a5352c57c05..ff772665d1ae 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -121,6 +121,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.hw_block_power_up = dcn351_hw_block_power_up,
 	.hw_block_power_down = dcn351_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
+	.set_long_vtotal = dcn35_set_long_vblank,
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 3acfbbac8538..ed98bfd9622a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -744,7 +744,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.seamless_boot_odm_combine = DML_FAIL_SOURCE_PIXEL_FORMAT,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.minimum_z8_residency_time = 2100,
+	.minimum_z8_residency_time = 1,
 	.using_dml2 = true,
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
@@ -763,7 +763,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.psp_disabled_wa = true,
 	.ips2_eval_delay_us = 2000,
 	.ips2_entry_delay_us = 800,
-	.disable_dmub_reallow_idle = true,
+	.disable_dmub_reallow_idle = false,
 	.static_screen_wait_frames = 2,
 };
 
-- 
2.44.0

