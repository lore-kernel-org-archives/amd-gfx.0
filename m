Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720B5CF34D8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189D210E9B9;
	Thu,  3 Oct 2024 23:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oIHCV4vE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A1310E9B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEi8DC1oQwKeRo1yDX25MnxBiwIxX1mKrF4p1urxh3lYlwPEUDD3AT/IZcRN+iSKg6pwOyWs/MUZoX/8TyS+GcdJCC1iFlHW1tYBXhXzSZAX24/1fsWTcWhDx8vq2hIzJPNZtR7X58t+tfZvG+Kx/D3nKJH03/jUGNsNU2+joHX2ZPFXB/FG36nce06wB2csLU0caNnAfqMFLR/IgGlC/CtLY42LBJF4HmykTMuZUZc7pIjP2YFC+J6G0fksoI3yIDCB35uU98n+cOwRBmJMxbEOE7Lx/+hgxm2etv33V2i3yBdgVUxZ/xdwJ343bxoFmfVxbj15fCiaCuaJOpEifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihmJrjHrYelZDnfpLgKTHXmvfrzI/Zk6vSaBwJdCc9w=;
 b=ltIHx58vbgMMX3yuzgWWN5U/ZP40vAY7CnNKCKeYtQwGzMEf8ZSW6yLFN9IBIWm/xNQWEknFPNB0Ji+JAO6yFUjxCWXgC8XssnTCpjbQlMM1yIrktd8laW710EDoJ2gZyab2skdOF3MPFGZRajgsF2y9Olo9k1+jD3/Ik16UjYbDDknqi079KBqbKIwtVnzlWYExmOxJa+XRnBRC/csGdRuFqtGDpfml1yhIyhNfkFakIQOnS8c/2UdG1CboxMejcrvS+Qbhdo5OBJM47e3xw8+JZOIjkFGrcgbwYNyGBXDb0otVCVDAi33b2AD03QhM/fkGaY14jbWPWtGM24KuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihmJrjHrYelZDnfpLgKTHXmvfrzI/Zk6vSaBwJdCc9w=;
 b=oIHCV4vE8q05p2ECaGMSqYLUWG3RwPfke+8hUIFIkfycr7MnjuOo/kNZwz5HH7K4Px+rWY6rwiA0Ts5S/XLlQSKs1xwysrIjYz5z6LaPcSWw6bolwmduqcFZCBuqNrPO7ZLOwgX1cM/Sh3gGRIbuvHmErFUzCJc5VYOcdw9VZGQ=
Received: from DM5PR07CA0094.namprd07.prod.outlook.com (2603:10b6:4:ae::23) by
 DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.15; Thu, 3 Oct 2024 23:36:20 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::bd) by DM5PR07CA0094.outlook.office365.com
 (2603:10b6:4:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:15 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Kaitlyn Tse <Kaitlyn.Tse@amd.com>, "Harry
 Vanzylldejong" <harry.vanzylldejong@amd.com>, Iswara Nagulendran
 <iswara.nagulendran@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 24/26] drm/amd/display: Initialize replay_config var
Date: Thu, 3 Oct 2024 17:33:42 -0600
Message-ID: <20241003233509.210919-25-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c0a3d6-be2f-4ba1-dad8-08dce4042f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r52dQBDk6X71PQJ/Iha/p2uNqb3Nn4lFfvAFeh0Slw6erd0dpGie5tAZMZ6p?=
 =?us-ascii?Q?NUo0Mj5wW+AKOsMdgqu+sHb5d6KUAuqVX6Dbwd3j3tvNn7KeVIzWPtptNmD4?=
 =?us-ascii?Q?+LSi9yXd9Ejzq+5iuWgDo2l7y6lyEfMC2T+v9hhDrXnixUr0pTdoniXUVgfn?=
 =?us-ascii?Q?L9sfa5RqqHEhIMIUpkgNi3ifTyYLW3TtmiSO5NTEr5pnRy3zI0X0KBs/HMEL?=
 =?us-ascii?Q?QoQw36Iq4S0w5YLP43KUj+ynOsK+0KRrkB6SCOpFC/UF75BH6+vU7gZU47Uf?=
 =?us-ascii?Q?rrPKLHfJEu+28bD+LC8+d81fUdeSsPF3VKxseOmvlF/idQr908E6in7luPa0?=
 =?us-ascii?Q?fvBCytPQ/8mMdw+xzlblyBfLS3dD2lxXZs1qEIAh2kpxXVBxf0cJ7pTpKTzQ?=
 =?us-ascii?Q?tsCI+lue+3VA5697fPrKQwrEx0rM0xKN8ew2wQBkn1JkKRpONVJt3CUTzUFk?=
 =?us-ascii?Q?r5uRJvIhuYw5SijoV/SPpxu5DhX4GOn8Ftj/Jyx2Dcd169Zr+fXY4vlGdde9?=
 =?us-ascii?Q?xc9rS4S2N/B73mU9ZWTMToLCKgB6CK9ihNH51rBnSEoAaTd9upzGLIki94Am?=
 =?us-ascii?Q?SMtwCukX9FLmnUA07gnghYbEWy2dbxjE8tQtTYiovXRsbjxjVB2WtNbNYIrH?=
 =?us-ascii?Q?c63sAIvSWBL7InI9Ub/0wnxK/N/SdzoQ+JJ7hQGePgyTkeDSzO9Gj0T6KF+L?=
 =?us-ascii?Q?bdkUb7rPwPvO+O3gk3PRRYhtJaD5N2IWwdMMTXidArdSj2Xi27mseO0kdD/b?=
 =?us-ascii?Q?i6Jg7ipq9oOcsD5qjnjYfIqBE4rWLhXtiunlTMhgD4vfSiAztnDNHQDRpJdL?=
 =?us-ascii?Q?oRXTz8PgOuLKMqQ7QkPjpHMn4b+Ym7cV0xZg18+GJN2psYeUVmP++fM13qXQ?=
 =?us-ascii?Q?LB2DwRweTmKSZ4ZnK4rLMe1kAS9EgQgN7HwCPuU3eo86nrZnx67fVARF7dD8?=
 =?us-ascii?Q?2GgyAquGgxBRC0ue3BQ1NtjwW48B5GpwfjbPlt3ruOLUmTFrXv0Z0AeweKs2?=
 =?us-ascii?Q?ENI1zkI4OyUaN2E80SbIwtxNEIwafnmam2weGsJXvjqruLJVxBquNoUvqKy+?=
 =?us-ascii?Q?8wMsh33cRu09ixKMW5CHqfK6fSxrWovS8S9TxWBQMSaxQsQWKwx9gLBk4/u8?=
 =?us-ascii?Q?QRRTCzovRG7QOvN3Uh6JlE467/WbfKuPH8Tp45guh33D33VJaO7XBuYKFVKW?=
 =?us-ascii?Q?9CmKuguAmxglFlDxUW/0vKQOcwSJiuqtiL74DIwAsABtmTEZYfmLYiQUvv+F?=
 =?us-ascii?Q?gGd7a0pirf2PYHmYwpZdAKq2uLPo+gZE88TdXsZEL163JTenxHUZ1BavwAIW?=
 =?us-ascii?Q?LsHcm3DfSTsuKFfheCfjqUgzKAueMj6EQzTzhd9mRR+NRrR+H5jZHIfd6Pks?=
 =?us-ascii?Q?su4YlNxHQA4/H7USHHkbkc7lx3JH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:20.1870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c0a3d6-be2f-4ba1-dad8-08dce4042f43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
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

From: Kaitlyn Tse <Kaitlyn.Tse@amd.com>

[Why]
Uninitialized variables could cause some bits to be set, thus enabling
features unintentionally.

[How]
Initialize replay_config variable to avoid future issues.

Reviewed-by: Harry Vanzylldejong <harry.vanzylldejong@amd.com>
Reviewed-by: Iswara Nagulendran <iswara.nagulendran@amd.com>
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Kaitlyn Tse <Kaitlyn.Tse@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 7680bc8845d4..cbea36916d35 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -938,8 +938,7 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 	struct replay_context replay_context = { 0 };
 	unsigned int lineTimeInNs = 0;
 
-
-	union replay_enable_and_configuration replay_config;
+	union replay_enable_and_configuration replay_config = { 0 };
 
 	union dpcd_alpm_configuration alpm_config;
 
-- 
2.45.2

