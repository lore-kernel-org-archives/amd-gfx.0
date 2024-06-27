Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3D7C3064D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A397110EB61;
	Thu, 27 Jun 2024 21:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K409qapt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F99210EB67
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdHtxLtFoBQqfhcOjnMatV8X6tuJ/l3C5rW3PKmxvjq1x5oeaumRRj+8JN83ZPF+9SBT9sQYzySDFAiWPXo/u58kCNJo1vOKmuph8cciHL1btGHGlLVBADHyqT4NCXHh00qwJOBZ4Tg07lkgwPuhG/JOqNH60/Xx391Z11PVr60P8BciuvJ0Qpf+ZoINUZ9wE+XptXQCUjSPTSKBGryZ1dY9gkBhzq2cl4kdU0OywvODbhb3d4ex4hAEC5uKWg/T1go38lrbGzzdtCGlkNqZfeD41QByXkGiryo0FuuBBQN2i8Omaw9fU0lVQJvFVUzpktW9iw7XKMi3ziAI3N9VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yo10u7grAeeq3l1ZqDPYkjfnnbVJzgjD6okYy7neAA4=;
 b=Uj9ocu/Bqn7+M3ULKaGsSOy37C4/SqzksxjSojbasDfiijg0sqGevOCHp6GkqKiqaMtAy3B5xNjRsKqw/QihKSwbyJ2g677Q0lrMvnhUd/8Qlb0KwPvyxPL4knPLlV817Q7cBZ0gJtJxvTpt4+KGy1bdYgw0I75JSwtU7sEu51nfX7RyXKkwRGGAdom7vqR8imUWZmedo/qQhFNVJmZ6J0FrDHSD9rYvLKEK5buMBOWikk5NlS9VImSOywW0SiO+PP4YYjDit96eHhf2OT+/jpYxc2veyWSSDG8g6no+oEQdci0ViNqk0skB0p+yMVvpHgGeKGrSeEnvsn/mtVVBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo10u7grAeeq3l1ZqDPYkjfnnbVJzgjD6okYy7neAA4=;
 b=K409qapta7lb5hgfE5aF5mikHwdiphBNhmxi3y9BKIfU2KAZNGArxG/YuL3kl0x5jh65GLseKFiF9lvMiz9Vn8MbuTKQNsHAiGx3tiuMmHoa5f3sXMMTqnFD9+zyR8E+zb+CRlG2wfiHvwzNMKHQMc3fMx1qVBwCJf2AqHhrhqs=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 21:15:05 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::fa) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 21:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:15:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:15:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:15:03 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:53 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 24/26] drm/amd/display: Update efficiency bandwidth for dcn351
Date: Thu, 27 Jun 2024 17:13:27 -0400
Message-ID: <20240627211329.26386-25-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a44737-2c8b-434c-0c5e-08dc96ee3764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YsTPIwtyOllkk/p/lbyTGNms1DMO9Kkp7rNBQgO8EQfrvrwk3nlM+YTMb3yt?=
 =?us-ascii?Q?aznf9ixYek7qH6teOb96y3obC4I29oGTPyz4nqCO6uUoNIf+CrHMSAoOz9Zb?=
 =?us-ascii?Q?N0ViBkfxoqE8L8h3pgWsO5lYJ053wIVoP6mETI8wJueiQNpeAXYbwFJ+i56q?=
 =?us-ascii?Q?hxEldnv4RFK8XeZBrGXefvZHeEsfan7n+LqbAZnTo+Apk+cjg1YLzCzoKF0j?=
 =?us-ascii?Q?U32AuKwM/Yy3cc57a/vvpHHNslEhCe1OnPFrigu/LTP6+l8EsjotQAZhPu4K?=
 =?us-ascii?Q?TSEhB93XyR2xcmNbBWRdSEzy+a29O56MZKLBWeSzcXSX8IoL1uZ1V6TpS5t1?=
 =?us-ascii?Q?9B1GeqBOr15L6bSIY+pPN9dduMwGelQZrs/7EKYFk3jqzzk3wz1ySqHD1UMk?=
 =?us-ascii?Q?1Uuiz+ZnPQXsuiDZLBcqIsTCV9WCqd1Ik7JGKb032lCaW/BCBXKdqRwDyA5L?=
 =?us-ascii?Q?bStQusN9Owu8xD/Hh/pbieCv7DDogBEK/UPOcj3oZ3VvByJlk0ksNsvV0j6Z?=
 =?us-ascii?Q?rEiUD+vAdz50bRukQbCNtxWdPkOEk/AasrdQ7GTmS7kHhWgnUr6ryBgelCgr?=
 =?us-ascii?Q?n3JqumXdoeOVOhsRB8TlPQzoGj7l9epaRj5BcwdC84ck0i0JWi9XSFnXhm+Z?=
 =?us-ascii?Q?/eZuqxJII6M7ib7rCd3+79TagEoHOIhShyJEeSTK+lQp7myeNYzbDPDagBeJ?=
 =?us-ascii?Q?CH9sNg0rU11ZjMdzAAXscfxkZkltfl6jqNSG3xX8fRwMkS73VedOJKW5NhpR?=
 =?us-ascii?Q?Z48nQ85Ce13geNXj+J3XImJrG20Sp8ijWFeuOMugeFMehC9qpMcJt+i5PVZP?=
 =?us-ascii?Q?6DuG1Ys+aK4XtMAU20qN9M5JZd1h4JsmyPJhwK1fRPr+afA8ZR2dsNr0KNvS?=
 =?us-ascii?Q?T/lCzGfcC9g7l9iyf9hRBjtG2QRUanBTAktccAqV4XTO9XsLNGujKlQQLj6h?=
 =?us-ascii?Q?J6fc7oLwS+J/SiH2DOGiu1v7QTOk4+SW+c5VVYnZd2YXNUyLA1t3IUAMNMdu?=
 =?us-ascii?Q?Cj8LdvLDj25Lau0BUSus98cRssFDRiy2hvOlwqfShGhkRT5hb+XPeeK1mwPd?=
 =?us-ascii?Q?LuojFfA7cc6Y8oWgMUcmyXM1MUQ/8onJAy67Sz8tbzpUyReHcTyzMn66fmAW?=
 =?us-ascii?Q?j484Lso1pHJ2T7I4+9ep8rnwTNZHWqLeHt4tnAWJEa6Oam42Xix4ECrLvHst?=
 =?us-ascii?Q?yKifyrkbchxZm0RlfA5Gy3g6R/Qx4wB3meu+vY+MFFGuokK1tDugjq01Ap4Z?=
 =?us-ascii?Q?+UMf/ZsBQUHsUUe06xnB7DYDSQyrohAqiTGC91szsznHk+VBriBhr521AFni?=
 =?us-ascii?Q?o3rvUPcaFmkNyBwOMssUhk35WMEVVD792DsxO+OghVNpQyrxAmQnHGV3k/4s?=
 =?us-ascii?Q?m0OBWoW7S/nB2GvY6hi61vqF9ds04luCrmM9zikVQ/DiZE5coFcRcRjxQUbD?=
 =?us-ascii?Q?sB0DqJZLMKn4d+Ccwnn2g+plfu+CtJkb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:15:05.3266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a44737-2c8b-434c-0c5e-08dc96ee3764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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

Fix 4k240 underflow on dcn351

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 935893456849..8b9dcee77266 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -296,6 +296,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
+		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
 		break;
 
 	case dml_project_dcn401:
-- 
2.34.1

