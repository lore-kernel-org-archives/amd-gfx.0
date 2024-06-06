Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A62DC27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E40010EAFC;
	Thu,  6 Jun 2024 21:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpwI3B0T";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28CD10EAEF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIlUZGDPf+5S/QZ4JvhRnYqwJ90xpnRpFkocq49pJ427bF22ux0SlTX7bs7cYHXyGUXYPLGYwEr43/lmSpXYGcjgYG+zFmEECtGCfJpUxGAsCoQOlqlwSL9F7+mdi+lGpiKzcDQCOth7H12HnLReagxgqYeCmk8XlNDR6vLmpdAzywpczxs5wjxEtpedWl0LlOqbr2Io7zGwnP20wXniDorLb8GIcXcJpNu3dQR0zVOq1guJu45DzHUPjQZ4s7qwN7fAcUCHWHQ42Me7QDnoglDTTlpoVx6OHnKnue+F0/alPFTefu1cHUuqXb7Xu7Q6FOb1vZ0wmXUNZTFSjZA3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCoApdMQXeE+r/426qxYuKQK+e9aYM1Atv1OYE9sz8A=;
 b=N49IFwejh9ZAGuvPXdzCZrW7vGvoPD6mNhOBnanY5LabXwJ07O4MoUdqZ52BRiACdHn7oICvYnBT0FUGQokMnKsNm9Ez2XhopeHFdin6NIaM9JSOIPYicA0Qu1z4qEXam4xT6aOwgZzAOpQOtE4vAx2m85Vhdk3YTHFBCndPs96I6JS9VC/In18zZ6jJMVciTMec+6yjz1RJcg7bY277aQcS+EhVxuR0ZJ/LI0kLOvoXToL0eVfg4fpt22jzaays36q7qhKFyOTs3Pfvq13nAnw5ukP1NGHfaDIyZ43w3yil8rJw+Oa/WefQDOihpoVAhG0FVToaP4tJ/iJRKa61FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCoApdMQXeE+r/426qxYuKQK+e9aYM1Atv1OYE9sz8A=;
 b=XpwI3B0TWuFfBnzN+0o8vKXtRtlxATepfoYuziRHzk6hchLUHCh2+ntL9uTr3/JmMGv7Rq1eCzVl2BFymNDajbIyBo5tCCVJBC/QjwLXTj4XdXhXKqmp5dpxtFm5kQwfm5xsSgRnzJtaAL9FNbjeGaLliqEtliKu1xACc8Lkx4k=
Received: from MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:57:48 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::36) by MN2PR15CA0055.outlook.office365.com
 (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:47 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:43 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 31/67] drm/amd/display: Avoid programming DTO if Refclk is 0
Date: Thu, 6 Jun 2024 17:55:56 -0400
Message-ID: <20240606215632.4061204-32-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 20072dd4-1e06-49cc-849b-08dc8673b3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i49nTj7PLpGQ4p2HMtiQJRMBCIlEEgR8o0XqPbQwpHY+6h5s/KhTl6m7yeVz?=
 =?us-ascii?Q?7IBH6GmSf6Kojs7VqK4cHrUHKaPH3sg0XJycJ8VUDhqvhxxFFs98TsBqJ61O?=
 =?us-ascii?Q?gkAomvc72s6DeYCjc/rpfDhIvuBoM7K1ZQPMsMbwJRk/TSVXTE2Lry3nyL3P?=
 =?us-ascii?Q?mRKh8AGekFcI+NiwbLtOqz/+kHvlSGybsh0YXN9PBir62/sh8oivFhkomNbi?=
 =?us-ascii?Q?zdNAv9RR0ReUHmjIyWyWsV9wQilzJszLb4tQOL9jwRu7UBqHlCkhZ+wE4W78?=
 =?us-ascii?Q?ql6KitQUUjo+V+oHzq0+7ZuhoqoCpXo8pzfhOR6K5YsmWYi0GEAZ7So83SUT?=
 =?us-ascii?Q?rJtfiVa9AKhhG/wmga2yAAnvnsoENpb05b8+A1SBvOgz/naVjzYf/qNpa6lO?=
 =?us-ascii?Q?/mu9YOq9eRgTCU9OWCECPqpLr0tFM9jsHxPTfBBqvsM3/jnnxt7CslI9ecmx?=
 =?us-ascii?Q?t9ggCxWcS0JAQB9/gW/idFD0Z7fNgY/SZkOPsl2tPH5ls2mQLRo7lNiSfbcu?=
 =?us-ascii?Q?mhf2wXun/QN9SzHPnSgL+evNkgCgOJEury3dn2HopU9y0pJDW1dQ9VcHSEOw?=
 =?us-ascii?Q?TDvyFZKxXNyMGupWx5qdCEfKNJzQdGbNr1wmFSO168BgpBF2bbRYgBiH6k+w?=
 =?us-ascii?Q?AxApKo9zNU8mF+15oEizgItqXB54N+3WFxrLIbcgBtQadGZoFGjVAyqt9HhD?=
 =?us-ascii?Q?Tb/O5kyiZOzmQ/F1RaEOE2Ctez5xW/l3Yar77mOBVuaAI6nzlzjfGSDl1FHL?=
 =?us-ascii?Q?WhFY8HsLViZ0Ed8hll6aEoowKiLxpcUyxq+etXVcCtYsXBcvEcxjBrCEUemL?=
 =?us-ascii?Q?j62KBDLZ62PWwgQxYnEQfkb2BD+m7tQ+CNyARWbvn9I+nExhzgd4oEAaJnKI?=
 =?us-ascii?Q?Wy2U24oJD65TtPSRP7rrUPy5Hr+miLbSqIKvO3FkMfy6H9WHjNZQRS8YkwG6?=
 =?us-ascii?Q?TokWNu/Y4YirB0wNTMMp3SAGavF5RT3SM5aQ5SX08KT6zT+O+w1Swx/DeZVN?=
 =?us-ascii?Q?+XZIfRC27K3bRAhV7yrvvQf14hJueOIfsNGdgOVIvKeyrIcuu89on5A96Auy?=
 =?us-ascii?Q?Nykx/e4ByB+h3SoBIjMWP0x0hMitIgmSSX5EZLulpCoG/62gjLIuMg2L11xJ?=
 =?us-ascii?Q?ZLG1zSgZwPgoEZqOp2l9tOlf4SMw3okoqEayfAsd6sCw8GjwqUc7tIlymQEf?=
 =?us-ascii?Q?FFfSBUZJC9fhkaU9xlgnviQp6sssWp8fhmmxzK1WTPahATpfe0JBD/UdjhVv?=
 =?us-ascii?Q?k6zWvJePAgFsxFN1qHuJ9YOAzCQpxuDSaH6h48bnA25y7qtYbpiLU2madyaL?=
 =?us-ascii?Q?NYvETc23gtJKdTT3WnspA4ZnTtCCrGO4HbEc+U1fghqeOtZdpkGPzkKVoh+e?=
 =?us-ascii?Q?pnyrp79oOLAtVcP/dkBC/JPDGddi++kAEwx+gkXi4GyRYAf+Mg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:47.6470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20072dd4-1e06-49cc-849b-08dc8673b3e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
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

From: Chris Park <chris.park@amd.com>

[Why]
Reference clock, either DPREFCLK or DTBCLK can be a value of 0
which then will encounter division by 0.

[How]
Avoid further calculation and programming if refclk is not
populated.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 3538e190f217..dac31c4cf2a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -603,6 +603,10 @@ static void dccg401_set_dp_dto(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	if (!params->refclk_hz) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	if (!dc_is_tmds_signal(params->signal)) {
 		uint64_t dto_integer;
-- 
2.34.1

