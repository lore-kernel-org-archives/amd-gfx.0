Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CF7C87FCA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8205F10E72F;
	Tue, 22 Jul 2025 22:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rh6WPhda";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF7A10E727
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icw+v26hKJHK9pz3Rjzr/qctVkwtLrmROGUb92wuz+muPjF3A2f5H9uLT1OQqlQt/Ct/2eFVknwsYinpyAc3ZPgtJBUdPzojEIvoZhxC8IXxTpRrMp/ixPXUs9NAaKRou577wwzsTJl/h8C+tATyn2IJ+JdsuvS+lsg5NalQceCTIbM3VLbFEvgfgGamVKai9Iy0WrkvPVS9J0/CpBbsqTHMp5qKV9b/0gI79ZST+xJPinJ+bi0IGuvMrb4fm+ot8ZIDK54plTIP8Osjo+ifG8zKR/3uXtm/kbxZtoT7YiuBVG64ZanYkleb0dnuZi+mfIzGitJ6zxacrkekpOBrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MoxunAefvKfDkmytfvNNpvjO0tKvp/41ok8zfpEIOw=;
 b=Du3k4uJp95f2CLJ1MmHDl58K9e5GhprqUZtFV9OLKTXEN+GGo3wCuvZ5Zc6yeAtE+R/8eANElG3bJoU/90gQiRnFx0L1zW/PQIVAwRJCdbV7QddHik2ZdAIXrH4N2VvdwjpjvX8DXvo7nmTo3OBCcmsqzTKkOvXpPdwS6CTbFN3jhzINJE1H/mUfWByGL5dS1fBPbV38snBskPyKu8ioIdCCSgWvcejyXkVIpzKaIA1UZE0DftHTZyKq8rOe4k2GKiy3q85/JhRtag6BTanMfQsVuh4eHIhmnEGgsSpk6FV0r3Pg0ukXq4ufbx2E07Xrkk7HQr8lhR9XBibdiGRaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MoxunAefvKfDkmytfvNNpvjO0tKvp/41ok8zfpEIOw=;
 b=Rh6WPhdaHoVClJSPhLSVAycvvLxgrf3jc2KZZZfymDdnnRZ/CYUdjcufRy454sZsIr8MiGyXu3sHah09iEBh7p1Yuiqrtd+JkSTXkqbiTIChM07JBo21GalzDjMghnE/qrg8MQJTn4QoXy/L4RZfoyhMy3qsfpe4WPTZERyrkLc=
Received: from MN2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:208:c0::46)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:39:31 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com (2603:10b6:208:c0::4)
 by MN2PR05CA0033.outlook.office365.com (2603:10b6:208:c0::46) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21
 via Frontend Transport; Tue, 22 Jul 2025 22:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:29 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:28 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 14/25] drm/amd/display: Rename dcn31 string shown to user
Date: Tue, 22 Jul 2025 18:36:20 -0400
Message-ID: <20250722223911.2655505-15-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7845ac-7ba4-4971-f688-08ddc9709fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/kL1euoClulvI+KtJ8yRTgzxCg7uDfkuvkjopo1Y45Ku8Gn3ylSRX6zfXeBW?=
 =?us-ascii?Q?oGxXRJokBtkRXwibhQdaf3lndt3ecWfbY0u/yN//WQeRTQSe3DdDy3jgCPhT?=
 =?us-ascii?Q?PgRQSqKaJ8PcZBp5ZH7uN4swp84ajCZhEzcvQH01mgLwS4bU8+4MGOehFi7J?=
 =?us-ascii?Q?luB8JGYt5u7FbxZDWRxBnCP/VhROQkgUltyMThLwTkDw/ewH6kiRe0tdDN/6?=
 =?us-ascii?Q?L7AYVjvPluBcfXfinCyTC3NcK3udMyOP/sdnNcWPMC5QeokwVkhuWpHS8MyK?=
 =?us-ascii?Q?9g9ffp8AcBdvcyZ8zwqDRddgd30yy8DAhWMQvQVKi3ylDcf2yWdXceYhdQDE?=
 =?us-ascii?Q?BbDLwPQbGdrMcBm4RD5h4MTGErSICgzM27PSBk6o9jl4trtFDObpPIz3p3Pu?=
 =?us-ascii?Q?VyCUmbHupqkE7ra9HxvUwIYRCdj/tdh9OPLVax52RPUoRvT78KwzJK7//LUY?=
 =?us-ascii?Q?MbpAc2ULZyBgC3M36MehqHGJwNipfNXsfiPviOjGFpQd7ME07+pFP0B54PKF?=
 =?us-ascii?Q?SLCSMT3Y9RboEI2vU3ZzcocHm1qA1Sd4Qbij03XzH8cwDBuoJZ6cIZpUf8c2?=
 =?us-ascii?Q?CDyGh0vc28fchkbzkbLqBUzaTMWG5WDZ3mNkM2bsuxDYjQqJxcskjsTVtjqE?=
 =?us-ascii?Q?lW4wZ0RmMW6IcDlviTW/fdvo/NpCBtArb1jicGdF9VbkuuDu3hC4PPGuTpKx?=
 =?us-ascii?Q?fvEpyZ3yyDD9FHskdWrEq29k5xb9Ahu8wjrkRGUn5xETQyiUzpgyuOXRtTCr?=
 =?us-ascii?Q?tWWAcZML6YmIiNwGJw5dk/VDiLOf7Uo/XaJX19WaRISxSI/ZUwRhRthoSVV0?=
 =?us-ascii?Q?xOscZLBgiBgvCh+IzOClGz3PLHh2o0LGrqlgH12XqLWseTKBRazgAxM9YLt2?=
 =?us-ascii?Q?LSxaIXulcBq4iifQ6LBqIv/q84wCfkZOikZ6ROmhE0WLdVbe9y5ypGYOMWC7?=
 =?us-ascii?Q?tsXV7T7DpkvgOo0Woja1nh/Dr2Q5G4H1SzG87APyQ0j0oPcJasU11Lb0QFZ4?=
 =?us-ascii?Q?JJpnNxYaGGa23JdZSzgdcO2tk6rezF3W2zpm9d2FoA8HjfgKQL7AemC2ol0o?=
 =?us-ascii?Q?Id7IKTth+4eqhRwRAIk6wkQrXpsTFvRB5UFDlgTyNePrCySq/EaEPYc96y2Z?=
 =?us-ascii?Q?tZl6bqKi4a6sZJuWK1dUOOIfhXGny2l4wIWsxSZ9udH0IOAo6YxVvKh+Gehd?=
 =?us-ascii?Q?04KH9Pa1FA4x0rAPlZ7BXeZO/iPQR+vSjNODns+Jn9rSw5PjOhhD8WZfccXi?=
 =?us-ascii?Q?3trMTS28bsco5Zs4b5KWPWg2BOiiasnkj2humeR47lDHRKgUFAEAFLJy6qdI?=
 =?us-ascii?Q?fYbqd5NrlTOnL6tiMpf+/bELCfRDN4/PkB3MPbs9Cgi9cKyCn9iNfElM3nbS?=
 =?us-ascii?Q?aVgLGvH/xsc47tl+zfo2XK5A9ra0C0l7x62//SfP3qcEyPS5sGAXQru7i3K+?=
 =?us-ascii?Q?dVPo9cH+py+mrFzLDVmAYY2X8XnZxQ9Q8rURLVGi+qcusPyXTnQy2Z/2OE86?=
 =?us-ascii?Q?X7roh+jycf9FBZX9ZZbCkCkAGGEwp5cmc5qi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:31.0056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7845ac-7ba4-4971-f688-08ddc9709fc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
DCN31 isn't a product, but DCN312 is. Matching against documentation users
might not understand the code.

[How]
Change DCN 3.1 string to be DCN 3.1.2.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 7217de258851..51e41aed7316 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -732,7 +732,7 @@ char *dce_version_to_string(const int version)
 	case DCN_VERSION_3_03:
 		return "DCN 3.0.3";
 	case DCN_VERSION_3_1:
-		return "DCN 3.1";
+		return "DCN 3.1.2";
 	case DCN_VERSION_3_14:
 		return "DCN 3.1.4";
 	case DCN_VERSION_3_15:
-- 
2.43.0

