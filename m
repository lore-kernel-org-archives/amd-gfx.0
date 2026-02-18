Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E88E9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D94210E2FA;
	Wed, 18 Feb 2026 16:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zMpG8ymI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDBC10E2FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/UfZ55k+y++4r34uuhk+GPEDpHpNzjNSRss3mCw4B1xNFzEUR9HesUh/wo4KRONZk0M5i/Hf622qkqMz5DKABfkxy/mhC7jXUj6TCOofG5riPwO7MV7/6FJscTgRaqzm1HhQiaylge5xOiocWsfqudMxnj09dc8G7ZSZeJIfokTLQyz+Rlx39JzYA+dlQVyU1dgEhOE8dCS/lkrG1L2mJbJPJCbZjO31Q0RiUOL2ROXN04ju/c4ZFoM9QlBjtOq49QkQW8xrh0+O3Te5dLfWLVB7zeEyIQ7UUYHhqhYW3zcGdb2Q1J0oAmqJmn+BLslnlHgUe0reoKxCKgT3MqWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHu95D2lmy0mC0tBRmUlUWoOHyQ16B21221bx+Bk0H0=;
 b=IT/Z8nRUI2B1Vp7FyUMTLa7v01gsJgpU8XTVgGjyDbq7VFPcyFVwpspubxTSrEN5UH39ekjih6aopteNR9Ztqgg6cavz4f+daOLyCI0dkgqwpyrwEKLXACc2vzoL+6GL7RdYgY3cg5aYdyPyqHYDpBo3RP2k8gHwZhdBPEIZAUjTtw+qfPbPi5XNVkMftiLGAoQL/NDbFXNrWr0HXLbvbnMkEfX8dpvx2V3LxxSap6E3r3ZyiA1yAcNsXCokrY0BN95ZE/2ZFcZCAx7HTdvBXOCLjUjvMNxkot33GbxZMkkWWSDFqed7T0xPnppD6RSU0ICXubRcamFaJ93h2R2IsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHu95D2lmy0mC0tBRmUlUWoOHyQ16B21221bx+Bk0H0=;
 b=zMpG8ymIK8AQm1qEOL6EfUvGZXioNzszw+pYqhc7HLO6tZYukdMefP6r1ZPPJakSNRPjU2IlxDVVkrq0llY74a8ayBbFoz4OgC4nGMaSx6GhUHFmg57JJwm1WymLM/IKjZn3AL4LisbuLMwmsBL68TU/33pW2qUB/sxxxVGUgYk=
Received: from BLAPR03CA0118.namprd03.prod.outlook.com (2603:10b6:208:32a::33)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 16:51:22 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::53) by BLAPR03CA0118.outlook.office365.com
 (2603:10b6:208:32a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 16:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:21 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:20 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 0/9] DC Patches Feburary 18, 2026
Date: Wed, 18 Feb 2026 11:48:01 -0500
Message-ID: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9037fe-6a5a-427e-40d2-08de6f0df1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WJMSEFrhJNciuPAxCYV5yEynxmOKpnLHMlUgiQRsxHbXGoQ5+BKJNUjk4Bbm?=
 =?us-ascii?Q?el3XAzA0pPMZNZPKIUUjiZegDnuHLI/7GBXSsmTjVxjR29ABNxEDEDvy8t2b?=
 =?us-ascii?Q?r0IUpAMk8Yl51tEmg3zQG9GkXr9flqvWLyPuatzshR9MAJiCpXj2A89gRoKG?=
 =?us-ascii?Q?1CKRzDSFY9OnH7EdFvaYczH/+0KnhlkfS25uW0eAIQfIWDknr8UnZmW3iGPA?=
 =?us-ascii?Q?qwj02W1cPK682wYGk4yfAWWI8pl39Nt3geg9v6GDBzBhhfq+qG9vQ/l2zPk9?=
 =?us-ascii?Q?LbB3UWe/ErR53DbZ8DM4GOP4C8H3KmtAf9nyJzMBHYWCCjTGEFrzBjyAoYA/?=
 =?us-ascii?Q?uC6en+TTjppqlWf3ael3Psf9XzXXRbPIFuS9DVtmF77JUyrljYjKJvK0Q3li?=
 =?us-ascii?Q?3VUDZCf2NUfJ64sALXg8cIB495LWJkEy8MxlYESaXyMvBGv8yMZL30bQw7zW?=
 =?us-ascii?Q?NPwJk4COODcAroeSXqf80o4xS2n2zPAweMm3lKYtaJoN0tVx5yTuOuV3uOPA?=
 =?us-ascii?Q?W18kqsP7pCVui84qZEMWE4h8tU73XHYZvhP+U2LJEgl8LO4QIE/Wa8NhKoTA?=
 =?us-ascii?Q?THIKZlLxIt4wq9z2jh2MZDm7Dv5hVf0PktEp1I0SRkVXBQAyK/JLKLTgzXBO?=
 =?us-ascii?Q?U/Piig2h4wsMbD4WcaYCaD0ymjrMaJ9ktihvn2NlqWpf1M3D06n/rBaGk1Pp?=
 =?us-ascii?Q?Gf6j9eTQNHY27tIXGXGgwPma0mzd7hT2VOakg6xZTscK23x5lkVF6iQvSAU6?=
 =?us-ascii?Q?NYyUI2fiwFxGWDYTDsORycSafMIPIiLeZWFNy8ERNGzgOGdLpFcqvCZ44GWG?=
 =?us-ascii?Q?TA25mo+Kt8ZYxy74BzjXvWwtFIW6Fux0NNScKbM1nhRyB4eVQjMQ1L5Hu4LN?=
 =?us-ascii?Q?CzYFbWgdLiIhTr+BWUiSli6O7cSHRoETz5yAm3NKffzbMRzfMk/PY6Udi9YR?=
 =?us-ascii?Q?4GPngsHhBuHQgne6jZGaV038b28lFwqz+he3Ye0TKE1U7xEVo+tDe6IMu5n7?=
 =?us-ascii?Q?DQQhNesZj07kl+GXY50rvVe8+utuVWj1/ODYtSoiLlysVFNvJWTpk4EBLioX?=
 =?us-ascii?Q?f8cUSZgeo1A/E16Xxpe0TNKyer+jIubXanHI9sFLn1qoFUB6dvYNuEnHuV5j?=
 =?us-ascii?Q?lS1CHsrdd0kDmBwog2wtFBNHr8EjPeW6VqWM71KV3gGuF1JCz4DaQwhE4d5d?=
 =?us-ascii?Q?pwavcVON9Azxao03FADzo6gdXU7qN1yU/Whc/gBD7ffhv8evy0ooI/NUPHoo?=
 =?us-ascii?Q?AmpG1KJcIsrn0nCXOkKBbgpZvd1W6Dx5xWDLONiIZ9h9w/3w0uQ+xMfE81i1?=
 =?us-ascii?Q?posa48kp1tKXCdU2f/dZee5No/AXO8nZnR9YEdRnCegysgQJQyK7TfknwjsX?=
 =?us-ascii?Q?gxYqHIuuMvZZ7GIRazpx112LgRuUBdpInuoWoV+jUP6OhQ0B2QHBz5yVUL0T?=
 =?us-ascii?Q?O2UdxvBbg+1c1tBTPP/Ij2bYlCtub5T12vHwvVXoaHgGZvIE1qZUc/nfOMQf?=
 =?us-ascii?Q?w5zpBliYe42yTK88KvbNGY7KWBCJ68+GCvScdu/W3I9awSY4lWwBiDQalnXu?=
 =?us-ascii?Q?MvTEJluXYSgVXc1AMKNvFuzyTx5MszWtwHBNc1vXRwyEQnzRz+aK+NE2dWVS?=
 =?us-ascii?Q?t0hFnHZ2ovirY0I3Kx6P8VK5hCZZ31qsWk9wudI3HTOsefH5SeVGMsAOwhJP?=
 =?us-ascii?Q?srcnnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nAY09D/lbXVgiOQOPftX2Dh2WraQs7/Ep8G2AKJuGDWRv1Ax2PL+WR1mSCM2ATPVGRWJ5Lspwc2M59rk5lE4tLeeQ02RQDdKumDDMyPpCKx6xy7oG0Ar45l7u99QQ4xn5VOkNDY+2RcwK2rcuBbcvIdOiVy4brkYs2T3PZMLtREsWI3VLJzgCc4IsPgBXuZHnMAMtEtlfi1jbCFmV89NlCocPtogdxrVlb0OG3oHp+qfSrFmRoJur4RdS1QFIkCWt/Em2PNhEdZtFZW79S+W1smTXnTmnwAhUlBmOS/n1Shn7GX+I8o2aIN+f96jYZwwXxoSSOJZYZlp20kNx9QNshlxNd9A+kZSOecDLm1Wo84wZ7J2zUxd6bqdpKvarc6X05HNDQHBdRPKMEGq4z08NZanyMyshuyfbjtBTDCpZKFTHoWcwl3tnjvAoPpz4azJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:21.4556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9037fe-6a5a-427e-40d2-08de6f0df1c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

 * Add visualconfirm support for refresh rate change testing.
 * Fix IPS exit with DC helper for all dc_set_power_state cases.
 * Fix cursor position at overlay plane edges on DCN4.
 * Introduce DMUB IHC command.
 * Add missing dprefclk and dtbclk clock types and fix formatting.
 * Fix DPIA number and driver ID field sizes per spec.
 * Minor code fixes.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Charlene Liu (1):
  drm/amd/display: Fix dcn401_optimize_bandwidth

Cruise Hung (1):
  drm/amd/display: Fix DPIA number and driver ID field issue

Gaghik Khachatrian (1):
  drm/amd/display: Silence type mismatch warning

Ivan Lipski (1):
  drm/amd/display: Fix cursor pos at overlay plane edges on DCN4

Muaaz Nisar (1):
  drm/amd/display: Add Visual Confirm Support for Testing

Ovidiu Bunea (2):
  drm/amd/display: Exit IPS w/ DC helper for all dc_set_power_state
    cases
  drm/amd/display: Add missing clock types & fix formatting

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.48.0
  drm/amd/display: Promote DC to 3.2.371

 drivers/gpu/drm/amd/display/dc/core/dc.c      | 157 ++++++++++--------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  21 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  23 ++-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   4 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  10 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  54 ++++++
 9 files changed, 196 insertions(+), 82 deletions(-)

-- 
2.43.0

