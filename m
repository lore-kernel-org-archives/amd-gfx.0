Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A373CF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8DE10E9A4;
	Thu,  3 Oct 2024 23:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3sfXyaQD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE35110E9A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OErxoFzdJHeYLO+50zzjiycDIfIZj0cNeWcnxkKxXnP7pwqMwuFU8T1qKtUA1FnCR9jb/D6M4HIzhQeK2lztFBfSeVCGSBBAqFZn0yIZzNiwJeIWkUn5en7Sdh1Z7bvGBhP8C/Oo5nYREUDwzUjwYZEwKQU4xOEdwAFrS/CrH7iSmZdcsarWGB1G/XWTeNKMYFvJd6A8L3zOT4rraMRCKcQYGOzTdDdGyKnje6xGNnhQGb0bLnp8UFXHoEazXj7fu4DMJ0n/kUKMw8v+4db5/9jVMmz8rWdZa4FRtT0++EOtwDmg5UW/FpLSKEdts0MB3LR+s5wnJ0ULTWnDuqbOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP8jFT1eqQW9r1T3AtTV+VSABQriuThgK7I15tmGaDs=;
 b=PzScp6gqeEsiE8vtSOCNWjAJrauI9ll1DPj7KBrtS1LOj8SJaGuaehb2XKJy72fsuJMP53tohjqnfcdRAVAsL+wcuJh5QTLocq2m5Am5UTiptdsTzMPxr8eOrKjMsO71HjTQPEpIvlC+lb9/seha6CQt+UaykBLYAHJTWBVQsYzgCxyUKitLP+wZEreXd7xE9ZWHBuoGO90YXMHjPZvICzqnGMSEKwABH7mvX8cB5ef6xswdKelsA9HHPHAzT9OHMkR2VIR7RewONMhFXVAuwF92D+zxrQ0R4mcxRg9LJ/oIS1buD40dYZkML6gWlBpe2jeu6FhVSIgLpHsWQ3f2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP8jFT1eqQW9r1T3AtTV+VSABQriuThgK7I15tmGaDs=;
 b=3sfXyaQDJtPGWQRnEDnzgDPuupzQIfn2hyITNBxcG57EDH33xOnMO69Ww6FqLtmfyMJbSpVBWELlV35WDRpwmtHJV8ijx7h+TeDZ5fg/3Bg4bVk6LOSSUqDXcmTI3mm5jXQ+9CAp+IUoBAMBMHHGybE7hpZmoSS6n36UNZocsQM=
Received: from PH3PEPF000040A3.namprd05.prod.outlook.com (2603:10b6:518:1::57)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:35:53 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A3.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.10 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:52 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:50 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, JinZe.Xu <JinZe.Xu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 09/26] drm/amd/display: Noitfy DMCUB of D0/D3 state in
 hardware init
Date: Thu, 3 Oct 2024 17:33:27 -0600
Message-ID: <20241003233509.210919-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d12ce6-0784-4e47-b4e8-08dce4041ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j05N3xs5hEuBmffuHFxpmUCucg2sV+nWlFqF6kLdMdFzvL0p7M8W2SctwVtq?=
 =?us-ascii?Q?F0XYnZ34RqgoKFx3fCn4ClD4yjkbzsKxAg2Jg7W+5liIEkFtddfOCUz5JOmf?=
 =?us-ascii?Q?BjviSpdG5buy6fc1InbPtBMthZoaot9SeuwzB4drEVTiF72jcA+sCfXzqlmo?=
 =?us-ascii?Q?LmD4cyhx/QBnxzoZvPaDOFyLNRAKEQta5KFmI4pZnZJ/Zb0RrGVNotrY2NGe?=
 =?us-ascii?Q?EaQ3KiCROgHPQBYzqGJi4bmN3lflc6OBXvKEv2jFgei+sWyEWNZ93Q4rHzo3?=
 =?us-ascii?Q?x6AEElVrxvXmxPX/AzsQ8nY7Lya0gzAYOE2lSP33tgDYNQ9wM4ejqkHQ57Mb?=
 =?us-ascii?Q?zYcB9STsn8EwLSyvm4eydPl8SX5Bnq+gTNURgwsvteVN4meZ1qnThJZHFTU7?=
 =?us-ascii?Q?70zauzxcCfJlWtEojUIfBIG8VBTeJJMzzDKb43Yu1qI1QDpzJ2WgRj6oyyLQ?=
 =?us-ascii?Q?p3OtiBsKV1lKIl4NfB3EmHI1XtoUCno2ulFVhxV9WsRwS7mQhYZTA56dY8aJ?=
 =?us-ascii?Q?TnrUreLmWjm1ZW6RXv7jyTXusHhBTicaRDoztXxSxzYJ64VUXgrbRIp3vB5p?=
 =?us-ascii?Q?oCTUFzYc3UhU6K3zRVvBvs9puGuvaao1wt/aNErupqxv7GjXBwcxo0Ek7j3x?=
 =?us-ascii?Q?Jrsh5JjF0snLgl71+2tplRDbregbWjPvys+69+Meokk/+nD0dLqTDdy5yG0l?=
 =?us-ascii?Q?WuNu7CHedrKsLyJvsFOoJ6aHV5d8Ye+FZfvMZ1A1M4G/NxzJFyQNaBmMe7yV?=
 =?us-ascii?Q?m7ktieVqdhMhAS7BHXAuFeomqi3khwfKp9dNyGpGGxDxHf7KgEyDj0stfovA?=
 =?us-ascii?Q?dG9QAWuRsYW8dnRfk+lgKurvUA/ubQmTCAwrVBQM8KYwgeT0wUA6tNzM+hOu?=
 =?us-ascii?Q?e0Aud+56kMLKt/Dm+rJWp35c4qQYfddCxXEqs1FBqZdaFYAJp8ANbp6mYfNm?=
 =?us-ascii?Q?HWF71WnYVkMWyT41b8vIllMjqjxvpeINcz6fZB5w0Bp/pemeyySqcMoBbCRu?=
 =?us-ascii?Q?8A+VYoXuV/eUHSAGaY8ks6CjxvFBBH69z+UZvfU44J0PAO1j7axeT05uaTGT?=
 =?us-ascii?Q?ZCGUFy3HE0fGRNDtR14/Ci/MpwCy9HVBSM6sWsBUo+lkIkY/DTWPBUJgoWN8?=
 =?us-ascii?Q?eGoCKWbncPZbxCexYk8HG0ylyw1beL3rKLoVcNjDmuGUUL7Ysd94nzpC3Xr6?=
 =?us-ascii?Q?6rUNKUUmCVn5boCLG5neqFKwPFKadGBLMDFxkcOlHPXpJW4lf9pR8t+vSLSD?=
 =?us-ascii?Q?97qd6LZPCddaJUcbtGFDztQk+SjEC5WrLjfQ00p/OQzXzvYyRh83LWNdeld/?=
 =?us-ascii?Q?svJQ++QJIOp3AToiT0IXnJnQAOuTrpd6FjtjtANlAATP2MyOxBjbnmE+2ZNi?=
 =?us-ascii?Q?8Wdvjc07Wa2nvTPW3WQ8QU3tMJox?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:52.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d12ce6-0784-4e47-b4e8-08dce4041ef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816
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

From: "JinZe.Xu" <JinZe.Xu@amd.com>

[Why]
Missing a dc_dmub_srv_notify_fw_dc_power_state in driver init.

[How]
Notify DMCUB of D0 state in hardware_init.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 57ad6ce88f3f..981d9a327daf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1431,6 +1431,7 @@ void dc_hardware_init(struct dc *dc)
 	detect_edp_presence(dc);
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW)
 		dc->hwss.init_hw(dc);
+	dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 }
 
 void dc_init_callbacks(struct dc *dc,
-- 
2.45.2

