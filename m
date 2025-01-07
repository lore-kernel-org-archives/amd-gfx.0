Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945BDE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474E610EB12;
	Tue,  7 Jan 2025 15:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="So6D9dQF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B3210EB12
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6jxOb7CbQ2gr+IdCZoudTkGL6ChJvnzB+X7+u3/dgYScKxkm1fzgaf1yS8X6GzLemdi2a0O1mMk1D/R1rihEXiIqSb711oQEMEa9En50X3/Otmg0oi3e/duO5lVBOe3gOJM4zOdUSkwA1NppNUgtHSpLBp8my/aO0V4dnN+Vs5aqNI52KlKnHwHH4h60b8EshnmWbMIA7ywg0EaKB0SV6wfL53sI22iL6mEP+h5chKbRtCBCmIoSOQlIOMDFU3wPrW3aCrnMYK981EMhwU3Sclrhu6qAS4MHYtBCB5Y2QdGpSjf6cIqPnRyNCnAfe68Qv04qLMQLsRD3eZ99EhRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC+HuQGxOT5a5xk/1kg6+lAW8VMxgz/eTVo3PiOLVPM=;
 b=IcdVbnqOZHAtkEqS2GMH6nu+JDST1tIx/6XbYReqaCP4Qs8ugyxtlzWi5LFci6om1X3Dy/oT/PTO3GY5QEC3D8YrfvexeYjE8dhnk5RnMons3Ei+l2LTm1nZpCXS/QZeav38/80uhJGNOPxIFJmtTbqSJeEGxre98Jyc8k9HEfTnaXqEwd7z6d0H+sczsWdSeVQsbKaeKorCp2LNpR1CIDxOM6Q3o4KR2444FHV1SKbHyTJBtgxDn4ajf1Ra/SEH8qdL65sVbJPgBwEC+cP2HgkXm9I/MKDZMicbMVdFJqlJpCBsrQZRnW0yySYhotN7f+LjAGO3jVIEH399H3l+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC+HuQGxOT5a5xk/1kg6+lAW8VMxgz/eTVo3PiOLVPM=;
 b=So6D9dQFqkPyp+qAneKal7+7hclNhdPvrCChu9lGQNoNpz5IbV9+4DCMDhDNJhlUefkjTAhzkH/5nky8ocJ6l05G26CjaOb57RQu0U+1YqiDQsRGoLWGkiaFw3gdqBdyr5pXMouUWq5lBLMb90k29+z2YYRYQle8oA+/mf6/XTw=
Received: from BN0PR04CA0153.namprd04.prod.outlook.com (2603:10b6:408:eb::8)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:30:57 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::e5) by BN0PR04CA0153.outlook.office365.com
 (2603:10b6:408:eb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 15:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:55 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:52 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ryan Seto
 <ryanseto@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 24/24] drm/amd/display: 3.2.316
Date: Tue, 7 Jan 2025 23:28:55 +0800
Message-ID: <20250107152855.2953302-25-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a39d866-f9e0-46c4-5f70-08dd2f3047f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tSZoNGla78VZTVMKJAJiOpSFSTvVKyy/FWogLV0WXFaIytP8ohUBxJXBGEUf?=
 =?us-ascii?Q?92dzFg9JSZrS26q+/FSJnFcaRVlHRy9UDjSsQI4NxpXLix/Q+hjKR7G4Npby?=
 =?us-ascii?Q?0e26b2UQSC80zig/5cRtYhivmkajvYLF3IaVu4VQxCiozBLFFvAmsOluMSdD?=
 =?us-ascii?Q?+finZ8qwvamt41HkxOkvLFHIAb5nlHuQYa0sTwujEPz8K6akF48vjboNAxZF?=
 =?us-ascii?Q?I+nrjaZKONBccuHMx9bT8mxi2PsjQ9Arj90+Nf05uGI7mvLkdJKvtYOBu+Ex?=
 =?us-ascii?Q?KQfWfyLjU7bz+Gfb6pc0WilljoNLr7eLwHBkOEEynsVMTiYUMovGOYqSWwGZ?=
 =?us-ascii?Q?rDfdMRC3uZnCXY4d/zWtTxbDymX+TAt6ilQ+IOD8SLaPcxasOnao13N0qbbT?=
 =?us-ascii?Q?81o5LQxaCIS1Sna/lTTgwje9a0xZWclOKvyFIk3vSRl8hTguIAy4eelQnVfO?=
 =?us-ascii?Q?UupDnIAgaoh1CnLlBSde8y3nvStm624X5/e7aAQcU6hJmFM6DoLAeGFpRH4l?=
 =?us-ascii?Q?XX0RX/zmXDLHgxiCP5r8UQDg6fl4KCKtmOvtXm9D/FxDRcaCf0DoVd+SKlF1?=
 =?us-ascii?Q?efKrVMBc/JOfk7TWrDzhH0rUe9QA4ihE4gcf8VYL91F2+0NHy1Zz8OJWMOE0?=
 =?us-ascii?Q?yK+8vFcv4Dxz1bFH1p7lzI23GpTkr0HSdpjJOYapaB+B0SQB0+iJ+xQJKu7B?=
 =?us-ascii?Q?qlAAufcgB1yPg64u6OSnGQFlQ9q8fMbVsIE9MKEFuoil/84vLHilgsoHGO5J?=
 =?us-ascii?Q?w6zh5CBT1WGY/GLl5UT68Ub4OrDsO1rl9GNmdBbMx3pdrYyfARsuTlBduUXk?=
 =?us-ascii?Q?kvT/smkATUO4q0zyX3fO5JdEv7kT0hPUIOuj5B+EwBfz3ac0TC75CdyafspF?=
 =?us-ascii?Q?93lOvKS0FRkRmZNTEnYV9XSu+nNId23Um6fH8WpKENK8duJ2xDmvR2bodb8w?=
 =?us-ascii?Q?MJXCOXnNTXyQeOf9MCtV/Lp4Dm0HyLESk3QmBhVglLvHPPe8zUp5lw4cKRbj?=
 =?us-ascii?Q?/w1sL9T0nQrWNBeJ+uAntw8ErCqtF7bqyQLOg9P3/GNDaQ19Omq69eazD8GZ?=
 =?us-ascii?Q?sbnlfvMJyKTiw3uNS9asN/4+xrEFV5vwqMO8Ig17WnRDTtF2xxfbnVv13ALy?=
 =?us-ascii?Q?ffxj5lwYbWj81tocBV4z+3ufcIS940TqOaTh3MOLQMWuvJPdjFkOg4A2yebY?=
 =?us-ascii?Q?L8B3S2R5QzBrbk7HLbgxSF4etMOY64TJYfREDVGBfrEitncVwrCzBKMcSAu/?=
 =?us-ascii?Q?k/3O1Xb+bOZ552Gt9BXi1SGPCZ08CVBdbNfBvpTd7cHTrEqjMpmFDh0ADaSq?=
 =?us-ascii?Q?OrBQcqS7WzJUmhlinKyOl6qyCR0BFQOUBjsgZMIBSnuli1izNE2Q5wBLaxH7?=
 =?us-ascii?Q?daImAhO4pQ3hurGRlX7hTkqkr6IzFHXsODY2KIbP9gKxghflbocsiI3tU6PL?=
 =?us-ascii?Q?t1qDuuVYbQ0i6Fb5P599G2DqniLNPdGlCVnckqtVECj6w2hzLT+C8mesQAvT?=
 =?us-ascii?Q?pTpWSsBRMfFO1Dc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:56.7583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a39d866-f9e0-46c4-5f70-08dd2f3047f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

From: Ryan Seto <ryanseto@amd.com>

This version brings along following fixes:
- Add some feature for secure display
- Add replay desync error count tracking and reset
- Update chip_cap defines and usage
- Remove unnecessary eDP power down
- Fix some stuttering/corruption issue on PSR panel
- Cleanup and refactoring DML2.1

Acked-by: Wayne Lin <wayne.lin@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5fb15c6315a4..053481ab69ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.315"
+#define DC_VER "3.2.316"
 
 #define MAX_SURFACES 4
 #define MAX_PLANES 6
-- 
2.34.1

