Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D775BC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B4C10E4C6;
	Tue, 30 Jul 2024 07:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="15YbHO09";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CB410E4C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRBVYAgQDbzle15H8NfwGmRkQiQ6cIVded9bEqM6LnmrlRbZSPXfN/BN0tPLsOjc8kV2lC5EBQCU2TZLlBUApCnNJ1OOsiA53MVdi1tc5anZUadnib6hBSGAZAZcuQLC1GN+ZP0ikhPi63Ynlvg340QOR5plMdZ/JlG4/Jg/hiKicpnTRsFLX2TSuoteFJmZIHJyatmT1zNtKHTWmr/t+svNkScSEjHaq3JOwaQoS4sHyxv578zX1VWfK1/13HVxFZ7LzQqylhipMvioLsX6Rb6ewfzPhvNoBjfPFGNYIXlEZL7Av9QX/DOVfDM0L7fWkB/hIALvCd87Ll0+Qfj50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3Tsro4NEODU/we5Pe/WHEgMCqkzn5MF5LNevemeYA8=;
 b=CDEYZk5GI0XElrjC4U2EwgIIWgxfbOWPTfi985pOb3VyOzS4mACJbyxiVzqjFPG+F/epW+OkaYpZ2SftYKPnZ254rEaNplTr68oCuxXufaODyAk+QS8J7+cwADFCxCR0diBCJGPHzCDPEWsUqoWuD6fXO5FHlzdTRWtNjJbQq2cF+2vazHVo8H2rDDVIaqlBiuFXOEfwxXrPdnVi505QmOJvtcxO/V+cV3Uxcczhzg1wkFYhE4qrgGGmGMAqScfjxzO1ImRAwH6BOjPudhipr2eFqaujTpCvfnndsmAtTvygKBXWfifGJ+lr5o24YosC13ursiIzDgf4Le1YIeIagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3Tsro4NEODU/we5Pe/WHEgMCqkzn5MF5LNevemeYA8=;
 b=15YbHO09PlAXYgmv2ThsqWnMkGVS7uYztWLrIlftGh9pxpjlH6QpRoafnL4nMRQsNLuuTlDBdWVEC/G8HVfSqUEfHMq+VH7VuqDOqRjdwAYUyeyU/nDft4/xTLrydtXfVmbsMh3q0G4+rc9ggU1Q7rv/YT8NM787QvglM9POuQk=
Received: from MN2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:c0::14)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 07:21:40 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::6b) by MN2PR05CA0001.outlook.office365.com
 (2603:10b6:208:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 07:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:21:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:21:39 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:21:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Fudong Wang
 <Fudong.Wang@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 16/22] drm/amd/display: skip crtc power down when ips switch
Date: Tue, 30 Jul 2024 15:18:37 +0800
Message-ID: <20240730071843.880430-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb992ec-7e1f-4277-fc46-08dcb068415a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gmhWH2SirGduusbvgrpySovmCbyf7vQRgZO0CyF2FNixM3Kte6/8fSMDNmHR?=
 =?us-ascii?Q?o3j0PQjWHVRTfGoQveHNpWCjEwUbbsee5PLn4gW1qCwFCfQiEJdhImfAYY7N?=
 =?us-ascii?Q?X9PzoMxvb+uuESSOFD2kSlmbN4woLvEDsfcXIInf+UlvUj9WD+MktFyd/kJQ?=
 =?us-ascii?Q?WD14/rcSlehWKX1YjerOeptL/o9E4/pgDkiY8nTtJe0dhoheWHOTL2QTuGaC?=
 =?us-ascii?Q?T09vFcSPPKsT1YfSg2LIv6Zq0c3nL9IVzL2IcOZ1JK46xvdVXjWYBN9Hx11B?=
 =?us-ascii?Q?bjbFst8Aljj2TANn8z6RFjnpiotwNcpRsafYyBGEBRrEl+fbcQTm0nRNCtPp?=
 =?us-ascii?Q?/PXKejRRBFTYn2ZB11+ViAupI1j0LKivCRo7MNDEslR5kjF/yEsJv0gf3N9u?=
 =?us-ascii?Q?wHd/dMZjIkMVLobIneT8KS7E37cFF/+y/fEnJf/fg6V3RXriEW3q3VL8pxg+?=
 =?us-ascii?Q?CFrcCh+rIPe8oYTkQjfOt0d8oesho5qp3YXQVa9Ha/9G78t9bDoIGMXO933E?=
 =?us-ascii?Q?RRWvHyBzi/3lIRX1MFnDQrpsPTb096W3EhZAD97HCJGWheLXWzpj//t1/TDp?=
 =?us-ascii?Q?T0lrS2Vj8nS10kjHrzjbR+Bsa4AywPWp6HFvf70hSvKj9rU6NG1JF9T4/7us?=
 =?us-ascii?Q?3+Zs41a+ZRuwxyW2zXZIvR6Z8DT7AiPJef9f/n3AT6GSaMWY0nJcwnaYCOXc?=
 =?us-ascii?Q?L9nHZ8XAF6QLQzVrgA88oAoKSJUQJBrMXTa8WXn3S84r7S9O5axEgwd/hN7p?=
 =?us-ascii?Q?aDTD4L8XN+u8d9q1e2WbTRIqjAItqec3/J+rBoCCO7bcn9J8/uNr0OgBRSde?=
 =?us-ascii?Q?FEsqAk0c1OckpRErtbseNqrxzFzN8lxgc5J+HA2ZizxCEZ2nm4rmrOotJGU4?=
 =?us-ascii?Q?B2Mes0N0kEWkRdWQUbT8yJ0nHOsAsRhrYYuFOlH1hhT2QYjEHlje+SqUCo2r?=
 =?us-ascii?Q?VfR5J+jplfYA9kAW2E9j0P7JZtn3J9dS3/mq2qGZeAyZayogRkVe4uzHvWM+?=
 =?us-ascii?Q?OS+kz07+vgfXriFjlvOxrHM2k0tGmUWeY0hcuQudnyHdI/o9WrrDiv59Yjpw?=
 =?us-ascii?Q?B+ZAUlwvnMNyrKEupedTtcPP4gPNJu2RfJfX9riWY1MA2cQbbbFBERU17dsM?=
 =?us-ascii?Q?/1hq3Hf3ftnRm1IwaJUW27/UwT5X3+tf7WOkyejdrYqymspd+ebmA2QLqpuJ?=
 =?us-ascii?Q?4FB1GpNoEZb6FymUmx4ryohP1FoWqDajO9WSqf7Bnr8FbzHM8t0LSdrkfqk/?=
 =?us-ascii?Q?tXsmQlg24STq1ZMM849Co4tvuxzT3MvP9vy+E9fY/bhcqnklmiOtwplgYkJs?=
 =?us-ascii?Q?AcfeqFYgQ2frKnNs3wBfvWBBczfy1lFUcjG6vDSL/0IhNJQUdc5pamXkW9QC?=
 =?us-ascii?Q?ylnX5Rg0usGz534NqArId9CiCIEaqSLCevz7cJKFYRHHzHqaKgYfFxAyEGWo?=
 =?us-ascii?Q?9oxbFSygvqIHXBgQGgvQ/jwzybYSWzIq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:21:39.8711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb992ec-7e1f-4277-fc46-08dcb068415a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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

From: Fudong Wang <Fudong.Wang@amd.com>

[Why & How]
Add a dc debug option to keep crtc on when ips switch.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Fudong Wang <Fudong.Wang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 95b0413e9f17..b6a5ea93fd45 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -979,6 +979,7 @@ struct dc_debug_options {
 	bool disable_z10;
 	bool enable_z9_disable_interface;
 	bool psr_skip_crtc_disable;
+	uint32_t ips_skip_crtc_disable_mask;
 	union dpia_debug_options dpia_debug;
 	bool disable_fixed_vs_aux_timeout_wa;
 	uint32_t fixed_vs_aux_delay_config_wa;
-- 
2.37.3

