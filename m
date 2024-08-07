Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3217EC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE59C10E448;
	Wed,  7 Aug 2024 07:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAZ1tOGr";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4224710E448
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMMZf1goa50n5AyTQLqcMeQ+blwJycwzTEDn8ZtLa0WkLO9S4Ix+dp4g6PYCFcX6zhgoX+fgHTT7XPH6p7aWsW+p7s9sBf2LyhE01ArZku5daqlM64NOZsl640/nrype0qTgeVzjfWM+9yKY1SrRLigob2kAnXoK8HJFfpa2tSzIi/MvEH/SJx4n+ZBSyzBd+cl+cpbXcMWUQMzptu+avTy3MD4snN6OsyMpHQTNudsyhc7lich1ibKWXWt7f7gu5Iqs4wWNb6s10WuSBlUqVt5SSIOwBhNzwdk2lEeoIdPuNqVbPunpVsvanB/6Ax74k2ioUZ8PT7pkDUZ4ZGP2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ycog0YnQKu2t19Zlu5bpQyJS0SuTnRPhwXtTnnMnoA=;
 b=CY7XYLMbqMyqDCREvFHP16zwgo18K5ooX9U3Equar1BhIbD6IeGcg0784HV/eRz7lSPVlQCW3V5Rcd0kO1kjRyyDxCwvWkJjUvS244w7EIJtUFRV8/xYczsnGXfIr8pt8Ja3VpRrnffogooRiKWKLIpC8bU8TgOYIS3xCbp9eMUB+Kh6y+wfLr6dycp1gST6SQbhdhHL/nTcMNfftzgMqi/ncBIXYxPZ3fd2YhYR7ErgAVqLBfYjdIraruZGQFmJiWhmtzqrPj5M1aigyN6dHdiXs52twVJ1olqIRE4QtXuquqrb0JGxjAEZEXVR210AWT45xavprgmfRmJWVhRjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ycog0YnQKu2t19Zlu5bpQyJS0SuTnRPhwXtTnnMnoA=;
 b=AAZ1tOGrL46CjMD4r5PwzWfCRx1VplWItLCXRrZuUGwoyMUdlKq3OD+NGpCPZSAkIicoDnjoR4EujhZm182Y8RoVFf3Csey7hk6pM2BJEfxLEh/RiGkcMPG3+w7+WsVid96x6pEAtUWn8uf0AF7aVyjGuLlB3TCAQoFu5/HOREY=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 07:57:15 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::9b) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:10 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:07 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 16/24] drm/amd/display: Set max VTotal cap for dcn401
Date: Wed, 7 Aug 2024 15:55:38 +0800
Message-ID: <20240807075546.831208-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 457cd113-eb83-47a9-b9ca-08dcb6b68ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hVLr1fH6X1E8aw24g0/nm39SUh6xqVNFDFmLxocF+54+VO7nYRYj4ZFBj02I?=
 =?us-ascii?Q?1m1FhVQ2uN4HTndUfpWCRBadrhQpKzKEehTskz6b/M2zgVp20mdkqf8Wpwhp?=
 =?us-ascii?Q?cizRCkj55kuMUAnNTlVF/btuxYFYzx2llme/gzaldFyJhY/9xEqoJaPk15bM?=
 =?us-ascii?Q?3edm9PNwZyqG1MgOtJPj/CEBcCxA7pYhTBLummd/7mYLzKEbi5RhUzgLKUeC?=
 =?us-ascii?Q?oIDCBt0IDX4FJN78FDAIfYyt9xl8sAhKLcHh1UGVTe2r8MDn1HNSYAcYIWWV?=
 =?us-ascii?Q?1Y0iSVUgoK/yT1FW0XzWwdRlBU7Ib/rjOAb7N++0vuHhmHzpLYymp7vK7gsx?=
 =?us-ascii?Q?R/myX0l6PmmVBxmxHhe4JgxsQXyeeTdA5m4id9C6aJ+gzZUuryFY/4fQ3DOX?=
 =?us-ascii?Q?Kd3UwSAPGodDKLZlnR7Kcp6dGAurSslx9ZKEL2dGf5UFy82yq1lW2mRXgnWy?=
 =?us-ascii?Q?ieYF56Cd9foF4mfPU/F8DLoG4mLCjbYQYpC2PpscDfNjH/gQ8wb5OEa81MDA?=
 =?us-ascii?Q?1mGG1xepy7TL+286StnzvTOIe+QA3vNWlDW+8soBqr+3QX9mmu785YICq7u/?=
 =?us-ascii?Q?pTRgVFlVxk6VF7VPyRV1v4Kl0PQeB9nVhCTnXCz9YqFkALOSQtYZPU9jhs/i?=
 =?us-ascii?Q?TJ9Y88+plxLq31DoURgcI5QBUsOhkpmAwe55qtDQEgjicdGAODDD5xtXC7ow?=
 =?us-ascii?Q?N96TkQ+79OUxBokMj3TYwHOmwDUMWFG7+UlfGzpi7catWXYxldfC3qeNT8n2?=
 =?us-ascii?Q?H/IMpO/o0Jxk2OlxDsQFcP+BrYF9PQhg3lSA5QXG9sKuWc1XVf7gMWiutNLf?=
 =?us-ascii?Q?Iea3TTT9gHwzkcY4JY/lFldNI0U3EAfdD7A1Xx4wXFBbcpEeW4Lek22QxNPt?=
 =?us-ascii?Q?CaaU05bHg2GalZMhEK550tvJ8llLp39yN/KZGARuO4AJBOVvHZg896rnvFHb?=
 =?us-ascii?Q?MOvi0PXWPltc3ALFM9cctQWW0dM5HN1J0JHMeyXZBeutvMEngJNnqow28v+I?=
 =?us-ascii?Q?LTvKWhOVKsJpxk568TPcd+TIP9EH6hfQGpsfwv8JDXZzku4YPXvJ9g5Bbrmu?=
 =?us-ascii?Q?5xBw6o2BudnojhxxYgAlUl4SXq6zqNYGSbQVraZvblRIrMoWdsWshdGCKcLV?=
 =?us-ascii?Q?kuVPjkH+DBqvAJIjAQeNwjg7F47AVCrqwuK2UVw54bmGhD/byhBOJKfXpjiv?=
 =?us-ascii?Q?VDmW++p2bJGeAMgPsXJxzqIg4FDbApbI4EgwKjEeRWkl1j26fym1RGTPpyOq?=
 =?us-ascii?Q?LRgsu4WSfl/D1+lu5k9NcBaZ8mqvGbaogJcuVmzVViYOnK0EIrFpN1Mh7xCq?=
 =?us-ascii?Q?9HIXwMI9lfsWYuMgoYd1M0aTAcOSJuLdFHZnauH0s2HtgwUDAcCUVcXIo9+5?=
 =?us-ascii?Q?mHf83pI5M8v+rEWTqBiXGInJaYuJHz5fAuO/RAN560cZRB4WtBovMcSP+u8P?=
 =?us-ascii?Q?67on4qey+HN0kvfE9ve2C8SVEWhhGKku?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:14.3024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457cd113-eb83-47a9-b9ca-08dcb6b68ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Set max VTotal cap for dcn401 because VTotal
register is only 16 bits wide on dcn401.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index ec676d269d33..02e63b95c36d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1822,6 +1822,7 @@ static bool dcn401_resource_construct(
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
+	dc->caps.max_v_total = (1 << 15) - 1;
 
 	if (ASICREV_IS_GC_12_0_1_A0(dc->ctx->asic_id.hw_internal_rev))
 		dc->caps.dcc_plane_width_limit = 7680;
-- 
2.34.1

