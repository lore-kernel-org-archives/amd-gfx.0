Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20558CD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DBF10E791;
	Wed, 12 Nov 2025 18:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASWMhjkp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4C110E791
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXq651VfmLMGl+cCcHLtTObI7twCMKmGGaMVEarsF/jIb4QrAEXotwsylCOULiOkY/NOIAYb6o149kJ8cnkBjh64IewAA93dnWvCUBq6dfoBUs71OC4yOhTsBjbBI6gTl0dxemGxh9sBhxPz6oxk2GVJwapK5cJrx07qay3H38gcASIFgpB5knxIV/ta9j78R+bUhynOWUH0Wj4uJbHfaWcoZpI0nFB1XlQyTrC6nAhlmxgvIX9zq/xppZM3PQ+Ks0y5ki0AGAedpgPpMKpRWctQIS9caNEMHff3f6CedEvCYBSL1dBho0x+6I3/QJnDAjBtkJx5HxbudmdJP4UfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDktqkjJzFmTLLxwF/uxyQhU/eDJVv33Ian5m39b5Vc=;
 b=R7eCV02opNrbBdYoVP6NmR0jjDvACi7q6Kv2briQO4RikqzUzM2evGnLHiIpQv06kpY1q0zaEmSgW98gdDPfnT2xHsgLBPu12jt5kgSvEvuNFkDw4qScEFHEMW8b5Fq/+a3ugENcCtg3HqsYdVKmXM7/12hgPzn8k8EJD6jvAj/9V6CGRPwgjV72G/TXRjkET0yM75uxUwiEA8QkA1GsD0lWpAXQPcg9Jb2LEjSV1UCJ6SvGE3mHv24WkBvs/AhC53E4YBFyiqoPVzmJsNqUjXWc50pPFyiJ210n1Cbxqf1LkD0fo5fabv64QJGIzMRVaOJKDrIzSuQoQF3nBITSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDktqkjJzFmTLLxwF/uxyQhU/eDJVv33Ian5m39b5Vc=;
 b=ASWMhjkpu69S2zI5i+97DPUTkvD0hGkqNbsYaLHZflf5+QfBoSywfqajkTo/sqRhTJDgbkGXUbjoxxuaMxZgcmYQxTHNqlVlyAwrohoSyH0unbshTiX1oCl9sV4gstutpqYr3ztGnDHDr8ivrpJXj7hzLkZ/OMlUKS4bC/ht83Y=
Received: from CY5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:930:1e::35)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::990) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 18:23:22 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::77) by CY5PR04CA0009.outlook.office365.com
 (2603:10b6:930:1e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 18:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:23:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:44 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:44 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:43 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 08/16] drm/amd/display: Increase DPCD read retries
Date: Wed, 12 Nov 2025 13:20:26 -0500
Message-ID: <20251112182212.559007-9-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa86d89-5478-427a-e30e-08de22189006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xtpdm2UcVdD/Sb59Aqpk3ACi6yljUUoIAudguX1LbJQz5fEsZkR5Xl5prDYD?=
 =?us-ascii?Q?PLxbYJ+mfwAQD5k2/W0jKbhYSd9dXCV4q1XZ9ds6tHy26o6M+ReRuUt/HHwH?=
 =?us-ascii?Q?ysq/G4fUEkLixwW5WW7ebQm0GzSbSVLo4pxA++6yiv1sfQzujB1elKLU97Tp?=
 =?us-ascii?Q?7bFzR1ggx0SIuGDd+BHXVODqYcDpVToCMONsj5rU09I+4lK0Hg+cLbZGlPxR?=
 =?us-ascii?Q?w8TdzpkjzLTEvwYbw4Y7KJfwX7lkkIzDliPdTl7YFl51PVkjYTzQIICZf3fh?=
 =?us-ascii?Q?EgEuz1FvICBL+49VQTZJ6C2V6LEuW1AqTeKaGAbk4isDoZAZyKBj50WdovPn?=
 =?us-ascii?Q?6VsqwzLKvHjMwyf14OUvZIGGv8o8hmqJBCcdp94joTSgMgfACty/QcZ5to6k?=
 =?us-ascii?Q?hJ+arHkhcM/gaYwrTAf4sSBZAYNNbX8GU+CRIAYS8eqsVuK1Ol+KVZQ5RytF?=
 =?us-ascii?Q?wP1VTSadNqT6qQZnHnG7QQw9AtIJPk8IIZJkCWfbVfv23qlV75N5ZEfP0ulK?=
 =?us-ascii?Q?PPyiRrW1DUIToOriM0S4eiUJ2nM16IebA/M6sVE0vTzluTVoHhX2XeComtBw?=
 =?us-ascii?Q?6uXyCcHdePbWwLxJYOX5DQZWVEaeyaJyFgvu3RTSZbYBnZw7zaO5TVVu01By?=
 =?us-ascii?Q?oi3I4rdC2qsTmjl7KzZ+y+yr2FU1aTUWqVRu6paddm8dTkDDlGucCdK5bTm6?=
 =?us-ascii?Q?UNYqSt4oWxLCQwFBNH9CGqyk8g09B8pqvZWEagcYkrPndPbKPvMjqDMLdtBm?=
 =?us-ascii?Q?TzNLa4VIswQHn7iieZXznhxH0M8hF5M5RWi5bSlug8/gZaxymBO09SsqKdmb?=
 =?us-ascii?Q?y9k2693yEkoSeH4jFIRs2HRQfhzrMV54HWRs5RQXsF6k/Ec5397z86IOwe41?=
 =?us-ascii?Q?d8eT+pTBPfNSuCLLyGLwDxF5W6DiQm4VrPh54cdiUsFI/LP5Ri2ss0J8o9gv?=
 =?us-ascii?Q?7GM6MMw8STMg9j6NsauSu7Y6Ny7oI5BaOjwrXh3sZ9V5WiAwpUi1aeS6cSZT?=
 =?us-ascii?Q?QtKsJTcleWt+1WYiSq88n7+SmvLg0MXyDggusTTpGT8JQGvw1JVgv5EuaXGF?=
 =?us-ascii?Q?I+FTWNQJ1UiR04eIjcVVoLqcXasST3daaefVvz96BrnaGFZh2o4gxZf/4TAS?=
 =?us-ascii?Q?gj7nj0JBAXgOrrihtSpGkkwFE+zEraQfkoBUzDOLn+thBCPGWFGG+T136Sfa?=
 =?us-ascii?Q?maSgW4spTVXK1TEVioXNHBjArgYD5jfsCdAfmcIwy+f5Zeijsq71wUCWzgFF?=
 =?us-ascii?Q?spEWK8UUL6gyWUmHMy8TADceV0iL9sPGNJNLGpG60r0mdfMYKoA48IyRgV6H?=
 =?us-ascii?Q?Z7fsv//IUADWzKey8p9ic3ZQpKYqyOFr11JlW6E58+iOtRx0SsLJXTniJmqu?=
 =?us-ascii?Q?882i+khBTRuMM6/iVpA+NRsdOdQVEMWhDWBjexhyXQYX4pz8L/tq/B8XgCRr?=
 =?us-ascii?Q?9W97gVz3H7EQ3S6SZsqf87qdiW7X4RP+3bhbdB+KHRn3goXSZY/9LmMBWnQV?=
 =?us-ascii?Q?oHSrZZefTsKvFB9NWzcfTw2PmKxC6ortlqKU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:23:22.3243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa86d89-5478-427a-e30e-08de22189006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[Why]
Empirical measurement of some monitors that fail to read EDID while
booting shows that the number of retries with a 30ms delay between
tries is as high as 16.

[How]
Increase number of retries to 20.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4672

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index a3f64509b131..ad90a0106938 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1713,7 +1713,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	union edp_configuration_cap edp_config_cap;
 	union dp_downstream_port_present ds_port = { 0 };
 	enum dc_status status = DC_ERROR_UNEXPECTED;
-	uint32_t read_dpcd_retry_cnt = 3;
+	uint32_t read_dpcd_retry_cnt = 20;
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	const uint32_t post_oui_delay = 30; // 30ms
-- 
2.43.0

