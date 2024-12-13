Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57906E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE57810F071;
	Fri, 13 Dec 2024 15:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KU1ALWAW";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A1410F071
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqbIKbmHPg3haabCtL1zM1sRsSgqJ5wQHFjD7YT8JI4kII+x4LZQx7FMsCPlnwMG6HrST7M1Pqg2aKE7dmCyeAq0/tpyJQyvOza8YiGB4pa/93jK1Gam3ICg1nfZ23PsBVRMKXRBy6uPi6Qe0B7ECe1FTIneN3rx+TcI5PgXKLIIbtWcaEafcB2rL2PQZwRqRn8kOaVLMAiUha/LLE236F3f+AyXwXHyc3V8pqBcBQ2lFWwVS7cDqRjGg+Ub3YntMpozg9I25qgkIcac8IjK3D93dBXDJ2anWsX/e0xZ0sxRXz/vemDQMx/ghOlxhxvw3RmOsbD+m6q9v2XPg5yRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYQzGHJEFUBFf7h/wNTbMbVl7O7GvYFF9dLp8pa8Ki4=;
 b=vDNM5xPmG17wHV2wAkcLdM1kSEKZtH2rcvY3auN0zZvXF4yu37dH2Bi1x0HcxDNsMZU4XovgpEYJMSRsojj6Ff/J2x1zmfL9jSlu1FucrGjf1wzDC+gvRcOrBXPT95CEQZDPQYIBo8804bXjP6pf3F2rTCW0PD4CZ9ERULny+GLYURkYsg8ojOFNVDp3Xr+5KWF/k+7zs5yVHzRU4TCUxMi7k12NAdW32sKhcfJe62USYA/YcoQCFYX40HD+sOGdQpYV51cHoab+ot96Z7Vjolg8/pVPCkcLOeQSUE65qEEpfySsqDUdhvEZk7V1iA5FLqDrauNLcdge0SZiWWcQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYQzGHJEFUBFf7h/wNTbMbVl7O7GvYFF9dLp8pa8Ki4=;
 b=KU1ALWAWSajtZfntbZ9ZHSJUAM0TKQQcfXUaUJGbv2E6XdFSz7IuYai7CK2CMH/dh5azmd1KnVPmvfIdtLqU51t+AHSuiG9KlRG/xyf8Gw5G0RBilShc/RheUNZZdnbUx/OtmNXu7Rxmye5Fyr9g3xcWeJzpSddhoCIk2hFgRWo=
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 15:54:51 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::e1) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 15:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:54:50 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:47 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Harry
 VanZyllDeJong" <hvanzyll@amd.com>, Iswara Nagulendran
 <iswara.nagulendran@amd.com>
Subject: [PATCH 06/17] drm/amd/display: Fix brightness adjustment on MiniLED
Date: Fri, 13 Dec 2024 08:52:38 -0700
Message-ID: <20241213155405.393252-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8b9033-9dee-429d-f830-08dd1b8e7a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cVzl4I2xtzOj+8xCccVnuamNY6xkwfqhzPdRAmVEQkrxc7KZ/txRFt7UTB5s?=
 =?us-ascii?Q?N9onVF451kOQZn+UGJYnJCRnVurifLYIyFCKM1cZbQjB0GxYq9ebkRD2Q1AK?=
 =?us-ascii?Q?A3KpD6zOX2O6jgRa6IFHKoGqHJWCTmNBhRhH3n6Ad3RQ7NEdYrFBa4wrOXN4?=
 =?us-ascii?Q?or6aSbVTIAiV/6Z9mjKc0BGEysGqhNICOBQTcz/Z9cMPvxiJnSD0DW98SvBq?=
 =?us-ascii?Q?uXqdBX1qk0GzGzR4NXlHunWxwsx5ZPclHlJyM85vivu1e/HMlVjUbq+FJuRB?=
 =?us-ascii?Q?5xf2mnWozV/+e5tHOAkC/o/HzpE8Sxnh6KLgkH0floOKXXM6IxmYdGZ/kAns?=
 =?us-ascii?Q?kI0c74kUXWA0OJuZWhlHAIbzmrBZvTIHG95stRomf/E40xj/M6LaZqbg0frC?=
 =?us-ascii?Q?Svj36PTCz2WS447nCMVu8F+lepWJAUhJzseREDrSPprMC5+0rQVN4gZoWpk9?=
 =?us-ascii?Q?RqIkL4RgWDkquFJ9sluGXONurXtsSbeUQa000OM1B/34vwEKnPRbqcXFeTOe?=
 =?us-ascii?Q?wA/yKVPq02WtnEvzGKX/w3GaU9eIgnIttZddPz0D7taVlA3mtUTfbYBFN+JA?=
 =?us-ascii?Q?SsmdRv2js5SoyaFmWTaEZSpZQ+fDl9xr2TQ+y+RMegCkXG3BRGiUN0fXdS7k?=
 =?us-ascii?Q?7Jnzu0y/IfyVEee+Qau1ic9QdMJIxNVKq7Hxc1w5xy8rc3waG1gzaIGYYvnq?=
 =?us-ascii?Q?orqJnPfrlOKdl8eY98XARSmgpIxZTXSXb0hOggHOYi4j7WuWBNkhZX0GzRt1?=
 =?us-ascii?Q?XqYjBSFuJaQWOdfRcFugUXWVkKkQdkQyL8+VukwIz6N5+ub51PjAwiOtp7tD?=
 =?us-ascii?Q?A+J7OW6LVDoiQ95qPb4vfKIK1UYk5K6PwULLQ8pF5uoS9rY9ZIYM0UGCi3IZ?=
 =?us-ascii?Q?DvkWIg54/QaovFL0HXmH0tMs4yZBVqeWBfAKnKPnBT1+7Rya2hJLIGTO47W+?=
 =?us-ascii?Q?nVcFOIohzDoIFtqMi3jBpBzmvBpGEaelnWhQj9wKqhBlZjKYs6rhzO800LIq?=
 =?us-ascii?Q?aOU6gA5ygq+FO76eeVHowHba+In2leH68fwTEqVprMIWrxcHv3sg1jfcQubf?=
 =?us-ascii?Q?69qXB3OEsmKRttiTq+TiyEK7z2C8R3cVQPsgn/Y0+qbd9NpD8OEiFVNpoLHY?=
 =?us-ascii?Q?bxvMeJhqjEff9rCGpWEpfoDuBEUkhnFOmd1rBNaEtLLYEqsrRJ5F1VtUcOdd?=
 =?us-ascii?Q?nMdoiekPSAbdZ1mddd+v5Nj6XFTk5xL+mOOs4rafcbYuUN2MoRDPXGXLDxra?=
 =?us-ascii?Q?iNp2TGKE3R0nHeucG16piWbJR1P2QLG5H9ChAMLmpk1d4QHit79Xip26i/Q3?=
 =?us-ascii?Q?6B/st+JBVQ9qB/SCTVoDj64rgglZlMtK4bF6gpG3kRLb7vStJZ6VXwf88RA3?=
 =?us-ascii?Q?r4B7gCR37ft2ZeaH4yLLk67Rmht9mJ2wimWNT5ooYf3TxPpz6ZKlbbWriPpz?=
 =?us-ascii?Q?KfmK6cP7nSz6QfTYnVkIGf4Up6u4hzEt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:54:50.8153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8b9033-9dee-429d-f830-08dd1b8e7a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282
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

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[Why]
Older Asics were changed to target new DCN while still needing older
support causing brightness adjustments to fail.

[How]
Reverted the DCN targets on required DCNs

Reviewed-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 125a28e11cc9..fb2ffb637931 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -97,7 +97,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.set_backlight_level = dcn31_set_backlight_level,
+	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 9d87ce33317f..21ef03a76229 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -99,7 +99,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.set_backlight_level = dcn31_set_backlight_level,
+	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
-- 
2.45.2

