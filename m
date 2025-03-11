Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BF8C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0633A10E69A;
	Tue, 11 Mar 2025 21:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q0jkkrq6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5281310E69A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdAjzCJZuHUwUqkMzZsHN8VayzdLH68PKrGiYc73A85tnfmE9/nGAn/4fhc2y0xjMkT3/60NLx2ge8rkUewWPRZJfBk/gGUvw5FYInrpRIaMAzP7+Iba5wiMGHCYxBFK6njb7Nn4pI2Plwtj4/2Nac53Fzt9DtErHrfIPt3zg84s0LZMl9WNr3is2A1JUJfebNNHhIl0crrriSahLNQK7Z5EXcdEOuBiv57GZKhANBxNUriAyVXnF6Xn01xYFRF0CZnMKgROSEGj6tMTM7i4P32iq6mtj3QiAPUVke/n5Rxe6O8QL2ca9MS2/btmc0hWClqZ27PY+GLqXEeBr1BgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9d2OiOQEiuFzTI2HdWWQGhKy+SvuLrFBar9bLbkKCc=;
 b=s1zMMEwZEspibfNdnoksZtTnXiECYViwLTmXt1p+zDhGOeH761X9NDKYdO1m9fV90vzpwGMY2ZfotVLn8XpbhIyyWKenni5Z7l/s/5AhcXIzoZMVngOcZNmGZtHwr/riz8Y5dv+MKDhb8Fe1rlp1VMIK3FhvauqlXUbVH0U6emVyujmKlD2cElZuTHSh1hq3GNhbxdAf+digXUXfsUczE4oTZQ3cW6LpF2Bf4eibS35x0MkwZH2Upr2zOMbUqqwy3/rRXLMLHGDmaioZnQzVME8k2glSo5785nXitSlEM47I61PjVYGIR9vzqRDcnd/zU8VRULPBmUJBv7MTVe0xGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9d2OiOQEiuFzTI2HdWWQGhKy+SvuLrFBar9bLbkKCc=;
 b=Q0jkkrq6D9zQxCzWOUS4LFVxIO9A+ke8S/A99hZSdXGKoauTGFcFroJiGxK03zLC0se6Dax60cs55zAhB1+Pb+XcIj9p1qW1kfvxavL42rsYHIbCbG0ZG71oTkwoYvMmBtHuCGTxUr8M7jBhWjfP9gBiHAxuBNlrzvoFYeQQDJw=
Received: from BN0PR04CA0159.namprd04.prod.outlook.com (2603:10b6:408:eb::14)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:51:23 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::2) by BN0PR04CA0159.outlook.office365.com
 (2603:10b6:408:eb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 21:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:51:22 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:51:20 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 11/11] drm/amd/display: 3.2.325
Date: Tue, 11 Mar 2025 15:42:12 -0600
Message-ID: <20250311214618.3106637-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5f63f8-f074-4b14-de48-08dd60e6dd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ttd9/AVQt7gw48BWnu1EVLmtPuzXPiQVfBaKgVhdbcrR6xDXiXO1n2cDfug?=
 =?us-ascii?Q?RCAFuulHwWoZvugEuRNds1ZRxCLQJ8NIud9cAtaSrTih05+7iywihYEpTqVd?=
 =?us-ascii?Q?6mROrFLFBa6jJG+IB0uPBP3xXCDYU1Xys7I+C3esJkGvJ2UKe3i04hkKPqOp?=
 =?us-ascii?Q?IDzNPCEto2YZoma5m2onLIjz1+VqHRkTQimpqipwLOGbFGRQ0XEEf2ReZ/HT?=
 =?us-ascii?Q?s5l+M2TD8uviT1Zmr/3Yle6xKJjcYGddqnT1sHsPh/oomNirqxTuR0QAcUHt?=
 =?us-ascii?Q?4Qqyz4rIMQ0D4d54F9dDI1lmcs5+elIIb0KrxuzazJjQrmc/E5RWeBb9IlQR?=
 =?us-ascii?Q?TnsL3hnizGXWeLdGMGdaRh5PUu247IZVuExNzP+zFoQ5I9NW7tWaOpQE81s8?=
 =?us-ascii?Q?Pp0p7QDbVDW+ikQAM8Y4jYmv1xArvCYQUbb9KSZ+eKZAonTKwmd17fOWbxjk?=
 =?us-ascii?Q?hoyTQ/HEQ+ZnqQ8BUwo+vtlvywbrTlO3ekLlEVSJ2CBymEeiSgaZPDIpbj1d?=
 =?us-ascii?Q?fF9cpLON7a3CzIe1WGFPoGV0IMJZWyNdyHcNxp5E4l8RpPAxfFFL9vFtkoxP?=
 =?us-ascii?Q?jg8H4PKSjTCHyeDcMLU87of6TZYLWdlNhrfgMc/lAkW5EAU7KiUnFqUE7nC5?=
 =?us-ascii?Q?2Jc3cdOlOrFFUALJ1gpU+aAFjExp8W9af0XIT4HAZw3Ki1E/LckKE1EkdyxS?=
 =?us-ascii?Q?sKOFnNy1vjZvw+n445eThZW0D5cJyjDrt182r8Eo6kB0vXCchN75ms9ndtgS?=
 =?us-ascii?Q?kT5R60aeCk7vWJSQDF+CSKBeGIIh26Ng2mQM6pEI4Nhbn86bl18LFSxDca2U?=
 =?us-ascii?Q?9gMYzP/ej/FqWFDTDI6i+ggSVjoZmA3bhtUQogGeS9gjmiS3vGx7XMVMLPpm?=
 =?us-ascii?Q?x0v73WQN6amSgvbx1JAJpcmUluSWn8JgqEL1HEJlXhwwJYmEXSHOEceDTPvq?=
 =?us-ascii?Q?21n1GWhEm3084G6iawkf6vFB0rVH4+2WTqTmZwvu4BC9iylWMEgawz1aH6bR?=
 =?us-ascii?Q?TVwNnSjYhnf/V8PReX2gqJztZ7TNMgRwHDNnyAmOgSjAtyDhn6yzvKi/GDCI?=
 =?us-ascii?Q?2lFCbMWpIo+2ZYs+j6gRyyRJ/Lmp+SRuulm7yARYZnZ4bXTBTu17GMxFjVxI?=
 =?us-ascii?Q?nYEbYhxc5ZLQy3B6XSXrPSdmsqC9JeQczpaROs6Y6lgLYywEZLcDvefFBWBx?=
 =?us-ascii?Q?svjZXKJfN8PHnS0xpjydt7KnteVqlY9yO5gbLreQistY3AI+MDQZNlY1A7ED?=
 =?us-ascii?Q?5r/XD3h8R59kdr26FRK3WEwk7nx+hiSFZgSK6wbm+o4FsskIcUoAICBx8eTp?=
 =?us-ascii?Q?ECWSsnYvEJpCBGy5XcoNRdIeNHbFyEnxgT8EBFUAJDjDURBVRJw7EPiUo1Du?=
 =?us-ascii?Q?zmK8JuQ243IfMXoHlBfyQsZzaTudD6XpX8K/BodDVUfJVrs7aKKFX5vPpQPC?=
 =?us-ascii?Q?gpyWlgRf7kBxC5I2s+NMzncph+v2q4X48ukRO9qdJv6YSpkG33o16cVLCFhO?=
 =?us-ascii?Q?kwZ9r2gkXSu51Gk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:51:22.4910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5f63f8-f074-4b14-de48-08dd60e6dd26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following fixes:
- Use DPM table clk setting for dml2 soc dscclk
- Update static soc table
- Fix incorrect fw_state address in dmub_srv
- Use HW lock mgr for PSR1 when only one eDP
- Revert "Support for reg inbox0 for host->DMUB CMDs"
- Change notification of link BW allocation
- Fix message for support_edp0_on_dp1
- Guard against setting dispclk low for dcn31x
- Prevent VStartup Overflow
- Check pipe->stream before passing it to a function

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7932d8f99d22..7c2ee0526926 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.324"
+#define DC_VER "3.2.325"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

