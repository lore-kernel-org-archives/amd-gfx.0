Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70042C30658
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 17:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF4110E14E;
	Tue,  2 Jul 2024 17:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2lL/TwUu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BA410E14E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 17:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMVF0NX8unMl/FLWLVQD15AN1n076uLHKPtLPEgzrb4OhdY7vxPpDJBrkkXyRkmecUfZZY1p4Pn+1MYGrkGZC3BhhAUpqq0yPV2GY2Xs4bj4pRIxnuaxVNrAvaAUi3ISi0KPvL5g9P5KJHKS0klMSt4fShqnBAc0nCt8Wi9z4hUCC3U7M3gDZV0P+ct/MAfPHF3CllK4kDKAe/eM5QvBBW+8MlyJZf080kcCOLa/yhP1zajpJX41f/KsBU8SRIuHqm7Y/6aidxwLev71eevQZhHR3I5kbokvKMU8rNSQPXbtd5cg3CZogbvOkkc9UIDE/JfTT0ZX1KuIFKArHz9rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y99+CVM1b6qa7AMy/+9CUAqGNFqLSeBS5TfeXOP2A9s=;
 b=AAtuy7antPQDqc85RFWjyqNjIP2gDJsPLVC30KMW0piD6sXHXh1yMtYX+0f0hG47TapHoJM4qU50Pyze8jeZEO7+pNNtx02z5Wqs+P6VZJsely6Rq//fGCSNYCT1tS5MG+Cb7SVKD2wmBrbM/+DX0M4AqIeGqkIy94cSzbROze2SqA8Rd0QR1qN0p3V3gJ2QX0ZpeiiQkjEYuLEmaMuX2PEoQcvFZ1I3ol3SoFBM/PsFliQFo++NNRqO9rGBg1sKJr/xdYX274jcDY4wIByjFLdBGO+y+/02P7tXlpZYwUTt7mOGNADvg/9hxbjzWiD1tnM3sA5eLh1XEGmV+39v3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y99+CVM1b6qa7AMy/+9CUAqGNFqLSeBS5TfeXOP2A9s=;
 b=2lL/TwUuLg90bbiHRVUSURIgrA3c8qQFUdxqxHddLD5h6T6+fYHcw1X6PFGXJloes3/QKtsVb6pU2aBPcTg8/EYPxMZmKtSHLYIFwPNscTMcRyknrHtg6mxyrQ3Pg8DU44o8tgDQS0v43qz1Nk+Wtd2WDcHUJUZQkUBNgCHRkXg=
Received: from CH0PR03CA0421.namprd03.prod.outlook.com (2603:10b6:610:10e::26)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 17:31:03 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::61) by CH0PR03CA0421.outlook.office365.com
 (2603:10b6:610:10e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Tue, 2 Jul 2024 17:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 17:31:03 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 12:31:01 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH 2/2] drm/ttm: Make ttm shrinkers NUMA aware
Date: Tue, 2 Jul 2024 13:30:48 -0400
Message-ID: <20240702173048.2286044-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702173048.2286044-1-rajneesh.bhardwaj@amd.com>
References: <20240702173048.2286044-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 46715bf0-75e8-47fd-3b02-08dc9abcbf74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ujbNoN8R95Cmm8UkHSabvqLRPipVAi3GwCKc8e3LEudybmJGDqeJ8GNzfB3z?=
 =?us-ascii?Q?nlfuAedHivD5tsMm0MuthVD5RnoOeB24RdtP1jeCfq5WaZRB0JIwnHF4Vuo5?=
 =?us-ascii?Q?pVb+dDw929EtTrOY+xBg5n/KkUOA9efQs0Mokh6yrFvq9Gkopq5z4r9luyeC?=
 =?us-ascii?Q?yiaIJoMMMNKm0JFcr3D9VYZcX7i6cCI0bTKzysgh3AiikLu4qc6VBaPM0GOF?=
 =?us-ascii?Q?3SOHCVQE9fIb9zx3iwsL2Nuabg0tG5nBjt4SKU6wITcygmzdIX9SO7JhKkOe?=
 =?us-ascii?Q?2EN6tPHFgVPMe7gX3rdQABrwX0OtAFRRWn/05GPrU/5+8b1CGtyQ/Y1IOMuP?=
 =?us-ascii?Q?31eyL19eehMe6gMdlvTl4BzMk27XcrH6N7zTv/cLUif1dwNj9l9ENNZARSJo?=
 =?us-ascii?Q?Oc8RNWdnjL5hnfK0nzcIzcZfoEeMvg6EJuGQx055T9FxM8EYK1rOK08PKAfu?=
 =?us-ascii?Q?3c9FAb8EByTfngHak40ERKXyPeEsMwW9eo4fu05o1CgOk3uOkqbYqZCA4s9z?=
 =?us-ascii?Q?9IthbdCBY9KgNwWe55QQVvcum6CTSA6wA99NGTaCB3r9lH7dlr6ElMiqMR+a?=
 =?us-ascii?Q?6B1+MzQV+jRIQKuh1PXj6UsOl0FIyNm4ZPGRlJzwCTXJYMSCorFbXKdFFXZ2?=
 =?us-ascii?Q?D7b+FfA+JQlpGfpEUwvgvAy6mxj0+btsjB1l8KVT45F0qjGHbAugXKDPY7Bt?=
 =?us-ascii?Q?rQq4+QL6Si1UINXHQdiLiUicSfC6wgsiMrjMg78dY3OtqzownLuV+XGMStcA?=
 =?us-ascii?Q?yKkKKU+YQusr5zsr8kproSygF7ATRUHmMnGdg9ztouYikf+BK1jpnAePvDXI?=
 =?us-ascii?Q?xAY/+D/1M+VDaEz+CxPVhubU7+wDNyfb4PBj5jeWQ9FKts5xwd9cRrQ/b4gT?=
 =?us-ascii?Q?IHTxjsBalX2N7v6vFVg9F9unyj5lekiUfKOQ0BTJk4eqIcW2TELxTk4vZYS3?=
 =?us-ascii?Q?/Cl0Kx95CStxS0v54vC3WSY/p0OI7D5OGGwhVqGvMpbWZDnaBYOU5J3Mwyf4?=
 =?us-ascii?Q?M6EzsjB2iur7ZFzi7WkfrYVPyYM8Qpyj//MTSiGFJdWibg57xBXPTQCn3e50?=
 =?us-ascii?Q?MqrkZZQT1CsT9zl/xhe+5tyZmqB1ekyUyTpYbU0uf8hCeoH0VBIFMD605ED3?=
 =?us-ascii?Q?gvDXufJhtR55m5/FpU/Bl4/kQjYsUOi2EiJ7PQowBWC85rf426DRn5HpfKMh?=
 =?us-ascii?Q?QJNahWiCMhrbDecesFRUwEE7U+0Lay+PKvwqwcYTLvpJl80MKGn0jpWE9qtG?=
 =?us-ascii?Q?dgBuWHJRnEnD1ytc9stGKKBVDeuqKWMFl++M3IYE6W9uVJjZD17FIFs85m53?=
 =?us-ascii?Q?+SqlVba7w26XhhDONdnI2WNbH/KZ9hmAKlNtFpAly5SH8UxCYgVEGntWZA8t?=
 =?us-ascii?Q?PYtRIpC38Q5Od8IEof7l2T4U75cTFXN/M9xc5ldBAjsiLeNfLmgJrhRssoKZ?=
 =?us-ascii?Q?FlqT8q1kqwn15IYq+djK5enDi1+BUXyy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:31:03.5425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46715bf0-75e8-47fd-3b02-08dc9abcbf74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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

Otherwise the nid is always passed as 0 during memory reclaim so
make TTM shrinkers NUMA aware.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index cc27d5c7afe8..f93ac9089a60 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -812,7 +812,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 			    &ttm_pool_debugfs_shrink_fops);
 #endif
 
-	mm_shrinker = shrinker_alloc(0, "drm-ttm_pool");
+	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
 	if (!mm_shrinker)
 		return -ENOMEM;
 
-- 
2.34.1

