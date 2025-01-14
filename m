Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E9CC02180
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2CC10E845;
	Tue, 14 Jan 2025 02:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m2SiDZX9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA48210E846
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDTxB6qZJb2ZgsSaXLPI1IJFcTZzfhtMuz2pSuExHHP/apPR6Ia6jxT2VfSFd4AG1PeJOqfrocbI79m9e/h8KE11aaTW7u7BemqiL/Bh/Dh6KvhMARwKf8sXYynGLRncJ6uzSxpPcU1GSILLZ7VFSJk1UwCprHxn49vKDnGOuec7G39WHiXnk/MiS8Grh4zvExnRQwm4Q2E+D9gGsGdUOD2udB1gG37PpB+gcAiOcHBJMhObCqB0GvXRXZ1StRYglJNvbcmWi/khn/W8mbhlKRHiqCY0TqVEw5+3uu8T9Xyus6U/M4xIT9Ckz6aOFHeCs3Ep0K9114eKqi7M2PfZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oAvIHz1zN8KNfYbxwIAJZc3EP8jeMf0JE6bWaNg8kw=;
 b=tfPhDMFqhTweaXgon8qkr62tBmdG02ARCsSj0yiTVhBSIJcID2PN2yBc+8hUG9yHtrIuZ7IW+8mJrFIkeFj+fXDZkCrVuiH2xa85FAj7zQ8iF1pT6e7kbeqSc1mepx3XyB5n0x+wznz1ZdRzcjF6U8xoD5zEamXKAq9/Zf7VW5L+Ro8j0riJULqncE8s+TbYqpYrt1DjuX4j3bUHaWR5FYppEstz68wq4rxSJrTB0+jZX374WhCQ0GMrcL5POGeNMJpK+6pyl85w+rH6Cpy3uJV4c/GRG3OXrNC1yzsT53jFNqez+fdgRzT+epwKJ1FWMtRAgKOyj/lbpIQoGKWllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oAvIHz1zN8KNfYbxwIAJZc3EP8jeMf0JE6bWaNg8kw=;
 b=m2SiDZX9q4stbA9eXKWVwIcpbiLkpj52X0J4SRyI26iMi+Uvr3S+4E+xnh3VraQOTww1xeJc9MoOjfC5oDcsNdXEafxfNTQJaRltU19xRjeZJlje89G0O9mGVRW8Sy5cazualLV4/rOvPU3FyzNSvLn+cWDrdUS9Mo2x/VI5N0Q=
Received: from BLAPR03CA0124.namprd03.prod.outlook.com (2603:10b6:208:32e::9)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:11:17 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::36) by BLAPR03CA0124.outlook.office365.com
 (2603:10b6:208:32e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.19 via Frontend Transport; Tue,
 14 Jan 2025 02:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:11:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:11:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:11:14 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:11:10 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 11/11] drm/amd/display: 3.2.317
Date: Tue, 14 Jan 2025 10:09:00 +0800
Message-ID: <20250114020900.3804152-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ef6b2d-5503-4628-0d6a-08dd3440bacb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lSvzO3AKPisiH/CDOKUuIWxn3xWy87BfXpEwpZaBvf0WCTD+O749MARH0z9E?=
 =?us-ascii?Q?Hj3W0Simn5vKWJlr6zGYj2ebcCox4duezA8/VAg1sQFNkeXHJbPNqNfFGVgS?=
 =?us-ascii?Q?NzcQhBxtk2jIzuo40WqXAhoSB77RxNEQpLm8V9gDo2dEtiBPs++kGBI9KqFs?=
 =?us-ascii?Q?dEYK8Pd0fqTAyxSztudYiPrm5ElCQdCWbvqs5meXOa7qkBALyzangBR00q/E?=
 =?us-ascii?Q?CG2F0IZ9OXroSLvjBGa+62oaW8c2lGHN5mvVosJ2uf7HQbXfuRm4vpMCI5/q?=
 =?us-ascii?Q?R6afN0i2TYvt8LQ0i4xoa1j1wXGoc2fTvt5JTujFgOzCr+XOHP+noxeQMGML?=
 =?us-ascii?Q?iLU73mTM+opAkPOcZtmGJMB+WKyT00QI5IdGA/rBt+26KxhM1tCw0L4zW760?=
 =?us-ascii?Q?mqDIPMi6ZYp5gt9nalIbP5nz3Mc7uuLYVbCXcNcmBOuwq24FgZG+u+Oa3d4U?=
 =?us-ascii?Q?T3ndBB2AAncf/qYdw6HmtIiIyPhr8MjCEwIWPC43Yis3HaHpKmJBOCCgUvIT?=
 =?us-ascii?Q?/v2WLx5RZHtGBKPbWSurXKvHacrMWhgV0kh4AQJDg2QwmVQnl0KtxyDsPJRp?=
 =?us-ascii?Q?WXk47KxCGtQZC0frtFvlsuBEFQ4/Ucvo52fIdTUJ59ak7MA1WcIA5BZRSW3c?=
 =?us-ascii?Q?ae3zpHku9KzS/kCs8UmwiOS+JKmvz+HhpCKz0AmfRg1txRMO3rQ9gy1SBEtq?=
 =?us-ascii?Q?oc1L4EpC4mcRDdDu/E9PgPsjW3vZurbNvfd+kY63rwt8DIztGCPJvgQrh4BK?=
 =?us-ascii?Q?/NN+vy9G/uiptxWY1xSycpFMFRE4/W2LbbjeCB/+MQSwjWu6Qjep8TEoUYPe?=
 =?us-ascii?Q?ZFzFmRJJ8Zgc223/q/RZ7mJ+e/V57bIGF+Vd8LKekCBitawBJFg4vnDTTqoG?=
 =?us-ascii?Q?YEmgXoIhJZrX2SEr2LUxPWOXl3RlnSdFeE40ZtlKgM1RbLS4nGH3FS0ZU9fl?=
 =?us-ascii?Q?+vABkIJPFSJygZsUlpu5Z2l2No/ndpgfluqLAKXW7on0ONyRGWoIhrObhE58?=
 =?us-ascii?Q?3t7xoyfXZuq1TDRVZqifnuWuG1jBCXrIME1EEp+WIX5vVHgigQS1MYnlcA+W?=
 =?us-ascii?Q?WmKzyWeey940SRHA4d+EpkmWrpD0yMiqnZKRC0Wnmtvp2jsnyXNLwNMdNeGi?=
 =?us-ascii?Q?BKPZDb5sTB7AsYZ3WxtP8QqrdyYohfPqahsWRo8qmX/7u3+kcm5gG/lva/bd?=
 =?us-ascii?Q?Ot2I7ZWIiGrVnEKNi0/u1mAuUefeFEJeEC4g+8TP49S0w41m90iYw35ujZmF?=
 =?us-ascii?Q?zJLGrO5/Ri3mfoHLy6LHWAJlY5hsZYKheW4+b1To6ausOe7cUkwnehj08FHo?=
 =?us-ascii?Q?IGkBvOc3VpCGspKWVKDaS1vWMi0ej3TD8QsTL3Ks4zQ3+gi0kOg/SqZfrsBU?=
 =?us-ascii?Q?azJRxKoCpR5qBsUeRB4Qh87/rFC5SGDcOu2X3pzWfIGOWJfdVpveVXE7RpS6?=
 =?us-ascii?Q?eBF2iF10FYgurnQe82X2EvMAVAHl4VRlFIiwXCxfj28Y+Y0aBpxSydlm+2qM?=
 =?us-ascii?Q?oICqeXYf7ZVriNU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:11:17.2117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ef6b2d-5503-4628-0d6a-08dd3440bacb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

- Reverse the visual confirm recouts
- Exclude clkoffset and ips setting for dcn351 specific
- Fix cursor programming problems
- Increase block_sequence array size
- Use Nominal vBlank to determine vstartup if Provided
- Fix clock frequencies incorrect problems for dcn401
- Add SDP programming for UHBR link as well
- Support "Broadcast RGB" drm property

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 053481ab69ef..47ddc7e4b9ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.316"
+#define DC_VER "3.2.317"
 
 #define MAX_SURFACES 4
 #define MAX_PLANES 6
-- 
2.37.3

