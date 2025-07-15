Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EFCC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4C910E370;
	Tue, 15 Jul 2025 06:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="czcePHQH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233AE10E370
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnV6SIqM0MwiUCQjpkXMyZIYHCRK9YSgQGeatQdD3QI5NKB1tK9BJfwYTh0lAesGdhEteTP1e7Cvn4WqTJesT9D+mOF9+RYWZFgu1rSdS0cvFEYSjNH5pdOVpU5Y9iBJ+JC09jPcyFdf10cTZylZyzgW6+Oh8pFW0rtwp1zm/ePMpWM7mNb3vEa7RsXiD09SBXK4SMkr+CcKtdxkwLxye67pc/EuQ0iZqyvEcK1rydZGD3nShP4RNAKXR4zueTHz8w7HFF4sGJJGhjYfmPuIj1IQFSe2zg36VdknJzatQg5BHBzotlH9Btn67waehJZKYsL5j1Exjg5xsRzTEgvg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebii3mNqb8+aeb3gxcs6TeTG7AquGss2oEDrPKKRw/s=;
 b=dyZHJro3TyzLPTnlFN7vM553TYJlhoN7gtANnlCodSpgcW4G/49VscjvWQJ9bGURWROBacA+o4OMgO9tIFiG5oBZDu5psj9QuwIgPakqQUvfTtiqQ3KJYfd14SmCiIdC0//KPB3txWQXKE0XMz2Klyw7LL60jRVd08OXb5yPbVa5tUJ/ZkXuhINkD+75qXFnjPJixsT+DUQOQgsGln95H3V5pbiZb1R3YHRdF94JaXwn2ak3Dvr9cVx+LzQc40kRFbtZUhRyc/tWEvwRFRMkTlfgawg1RtiKEcjMZ2P1BxpFqzqmBVf0tf21eUdt2/h0JyAsn+euAPK0uXkajwxcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebii3mNqb8+aeb3gxcs6TeTG7AquGss2oEDrPKKRw/s=;
 b=czcePHQHnSgjKwWqFYpkuQNGjfd/91JyEQGAyfgVwfTf9tb9H2u0NXaZ20UmA+rXzfEdVcbPLBPjfiRBJmXWTus4xJQVmIR3Vy8hjUxE3H95efW305w8Tg4fC764i6Gu4Qk1/WmgKE/I0SSQENPfCfYMjiN2N6b/HAyIuDxQLkU=
Received: from CH0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:610:74::7)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:53:06 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::7) by CH0PR04CA0062.outlook.office365.com
 (2603:10b6:610:74::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Tue,
 15 Jul 2025 06:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:53:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:01 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:52:57 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 02/10] drm/amd/display: Promote DAL to 3.2.341
Date: Tue, 15 Jul 2025 14:49:26 +0800
Message-ID: <20250715065233.160043-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a95838e-7deb-46f0-e4e7-08ddc36c3f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RHsuQPfMCAWRJNLw59MpPuNf9dz2Q+r7MRi6nZyPfWE6W7n0mY8HRQlFh8dd?=
 =?us-ascii?Q?CDcpBVFeMHhmAvsgKniQlXN53A3xK/nNcpKI5YCD9qSXpipsN+3Hocl052Oj?=
 =?us-ascii?Q?4yf1kecABOf//Jogvy410vT+sti1k8KBdvEI0yXwf9A8A9BPcYdX4wmlP/rC?=
 =?us-ascii?Q?LPo8zlGynBc1lZKoqoIIYTUDtvIJzg+vV7BL+0znfjM9Er+DHubVaMZuNw4L?=
 =?us-ascii?Q?TMgYkkr/XrfKlYR0GCwEOD7ffMo3o8qY9m7BD/NozToiHUmZaYxwtHQwfgXo?=
 =?us-ascii?Q?TKZEZVPLewvL2aHyCIe61r45ZwjhxR77HOzS8FWuwW3eV1Eyw8T3ErcLMZoJ?=
 =?us-ascii?Q?MS0poJKP2w1DMtujqb9bxo4/BfTHW5by6jEge5GFAWNoRaJyPfbiljVOFzGp?=
 =?us-ascii?Q?F/XIJJcaKImG4SlD7egY6NrGiKvkUVpryBZ6AggRzi7XtET7v7ADd8qGrwzC?=
 =?us-ascii?Q?X9/ZNBRxtySupVDmiqcAwrKanep3R5Dr7UVlBwdLPXIMNNilgmns31mEQeb5?=
 =?us-ascii?Q?Z22bmoT17jyQe/uov6IgbXI5H5rZRDqCIuswuR5LQUZDSmGZVCPRS0lhL0GT?=
 =?us-ascii?Q?+aI9AOVgWbJFcgdprcyrQlkpJSbmTB8Pay/EFTbl7Hy9kAmZhVfX+eMV6gGc?=
 =?us-ascii?Q?n8y/V7pmV8/XGckuk4lNryQf/MkBo/JrefdHfPbvD1wvHgLGUDaAiLPT1cnH?=
 =?us-ascii?Q?6bbR08xeB1oQOcA2teN1ksxM+cx9EloemwgA9uNfizzO9Rcz2A+SunGdNY9t?=
 =?us-ascii?Q?32LxvChMAj15hpav8d7Du2IicJTL98uk7LdRCI45Aev+DB+P7mkxAKTleAP7?=
 =?us-ascii?Q?LkvKkgSKQFDera9ltN76U01M3k6zdqPPPZb4kCLRBEoxCJ/txl9YI1c9lxG3?=
 =?us-ascii?Q?Kk/ZEAfZ3+TTF3JCMiCDN6HDAfUFqkyN4eIfHShECNYjHGwuaZOC9A9xdc42?=
 =?us-ascii?Q?6teDRB4M46wGKcVZQ1ul/tODipm/iEbZUOWti2cj7ivCaNmuTQayTMOsywEc?=
 =?us-ascii?Q?x3KPHxAPoqKfpev9T+coqgqbKc+OnukkvQ9qC2RRkEYIMw/igWJa7CC6m7UW?=
 =?us-ascii?Q?zAWPNLkhlrtkBFUbshQYWedg9BIzlstrlsFA3Gz5e4OEaoYzaFWUY3IlUVoo?=
 =?us-ascii?Q?oQPeD0Kz2QlY6o5lwD1zVwT9/vDCBVbhcgcus95FqTM1bdDkX6pIFVz3AiWV?=
 =?us-ascii?Q?AauxHJ3cMNi1upUb+RvkBd+BWSBhpx7/uOanLbPWl30tkV8a0wwux2Oe9cYr?=
 =?us-ascii?Q?TRr+SjN5A3T4oUadccBVGuibzTCdpWuvpikkzA235Bf6T/IAMILTQj4nKITg?=
 =?us-ascii?Q?OmH+s6jBILx4FwZKwYxdnvf265gIxGXcFUvBv8g2MxC2Q4R0UmpU+a1lPsqx?=
 =?us-ascii?Q?88M6LlHQRKL/wsOmxXuKNKw0WqJeG3O3K80q/YI1yLNq0S+0ihrM8OgUx3Jt?=
 =?us-ascii?Q?iRY5jl0QIVNlB/kZueR0I1rfPgt8NmQl5w5+Q3cyWF43D5QZ/p4i5wD9LdZy?=
 =?us-ascii?Q?WXtLTC9Y1RgwC5u5OSaB6L2TDPvbN3GlamanN9jmBciK6lt4NVNvGNL/SA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:04.6459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a95838e-7deb-46f0-e4e7-08ddc36c3f94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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
- Fixes for DCN401, DCN32
- Initial support of SmartMux
- Improvements for Replay, IPS, and IPS2
- Refactor of DSC

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 59c07756130d..d0c78f94a7a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.340"
+#define DC_VER "3.2.341"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

