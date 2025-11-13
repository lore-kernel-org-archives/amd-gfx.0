Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB6CCD5BA0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 08:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758B510E780;
	Thu, 13 Nov 2025 08:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R04zqXkw";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB01E10E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 08:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4cuxBwihIqvFX4bE8HtkXLUdLZ07t/TzOmqVHcVkAub4/VPoIiYtu4II2q8FxkGD2JftRV5MwCRp7ukWfQFkwy1uBBZgbmGupJt9FLUDmlY8NVTTc62lQuZcBT0oWlS4t/7WHYf1nnAbdErbLYraNIhEtnlI9p3aD+OSXRxQirZs2oGrwqIMEiz7Mqr+qaAGUfEDch4QCEGMAfVdgBBuCSujMcIlkFD4Yj9rKfA5DplNh4qy1iOQuiMDZwf+O+GVd1N2q4OELwhKoDpYzxsBSPoAlOEmbSee2Xbo1xLq04XxQCXiBGDLV+aNc+ukdKa7l7Hcc2aRARLGTNvz9+y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wz/WWtwYOX8hOQh0b3FZCDNKostB+y1VJA05pjjRkDw=;
 b=DgvTqKN8sLvI2JeaLrBt10r4xPcKPft9OXUlX1YQFLFbd3KHx8E8JW9qbNLNUz2DR3RuuPaax1beXVsX9GubyZcmBn0wn3IFfnygpzpRARpDM8LUu7g/OMI7JBuThl9ptnxABDPL5tsikdwsubvg1B4EyvfJkxIgqYlYQU9WmcPGDiYzDzIBc5gwQfx7CfeywF+o0x2iyJ8fhAApiRp1I5LMScpNMWBx7XKrwqMR1vhdMulRlPY4JFm/fRp9aUjmUtycWEGPx6i0nnP+UoYqaFlXfZK0zRBeU5m5NYCCtEgeiC2OX6bRxpHCCNGObGlJ39lISolOCJyVuu3TpT7gvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz/WWtwYOX8hOQh0b3FZCDNKostB+y1VJA05pjjRkDw=;
 b=R04zqXkwnQpc5ZKD/5JMe94ATw80WiTxM1Tft3064BpkxG36pSMINqjNbuRj/dgyU+aof9g4s08HEEvPppzT3WepvBrUxfbR5AS+0tuCnKIWFQbQIm2sfCUgHFqwErny4gLUy49/CfgJSKQJIVDiF2O1iNYBJBQTFXIcNGt8Pgk=
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 08:42:52 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::40) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Thu,
 13 Nov 2025 08:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 08:42:52 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 00:42:49 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Synchronize sriov host to add block_mmsch bit
 field
Date: Thu, 13 Nov 2025 16:41:52 +0800
Message-ID: <20251113084154.115932-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b289ff-1c00-4bad-9d4e-08de2290a1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hCL7sIHTPG4E64bl66a0yVI9KXo118jMUy3M0oHAPQZ9FyP7cMUkjEdBQNk1?=
 =?us-ascii?Q?VxAcv7aznRSSw9QLV3AfrulzccAvurs4s4V3hZlYRnZimUYj1eKw+o+3Akhe?=
 =?us-ascii?Q?dngKVAkiqbo3pIjDj62a+5uOzhhAQ1bQaBxmaEQmlYyO93Pdxfi8gq0gZlgF?=
 =?us-ascii?Q?7JBPlPWXdWhZF34rIQE+aWq+qH2DDeo1umfynTuQ+Y0bA6qNACPSeMMQmUUB?=
 =?us-ascii?Q?COHfgU1RXgCvCVsYz9D9V2WjVzdYlsDxzIHSGvbi68QPhT9P7DbmUZ4A127V?=
 =?us-ascii?Q?L5+vqK61w0HSYXE7vLnYQLKCbXWYBCfS/3/RtM91DxwtHaMH1EK5wBNqdUAZ?=
 =?us-ascii?Q?stHlwGnEnZb/5Us+Br1BBs8kG1Gt02x+lOUOKXl0Hwfw0SqkpXX6ihLRMELe?=
 =?us-ascii?Q?PM2Aq0bIbDHlxJugyiIMRLh6ZBFQEpJVsoL//ekj1gsB4tIk2jOUs47suenL?=
 =?us-ascii?Q?Ac/xDoKvkNdFQl1puAAfmEFdyh8AXtUdKdBAhAbyvrzgZb9d8tvhhtUScV+P?=
 =?us-ascii?Q?AkZllASF8qiCa6H5KE9D59++jLE4ZYFwaf/IwjO5QJIZeS9z+lxn4P/GoNJ+?=
 =?us-ascii?Q?HW//NxHzfejTW5sWx2DFsDzGlJLW832KS0K2csPCSxQ2VOsueAyKY7thqXKs?=
 =?us-ascii?Q?5J0R1nChWh0cl3cRIVPP+KsXQ02++2bMM64xT2WYhO+z8GqvY1yeyRdXEdVu?=
 =?us-ascii?Q?ZUfowcuPTkAsUnTGIKJhaWlhq6BbFrsOLPH0pLzaZG0guFhAwDabOLc/i2P+?=
 =?us-ascii?Q?KCOmq0vrXp4CzFltUdJBHz4t51zRXgK9fUvxYLcmZgw3a3SMu2jX0YXMpiWJ?=
 =?us-ascii?Q?K0EuyV2wlQPzImlJ3xjJWIthia4DKEjNeRNqPvmBagJVzvNGH8zvzbuyqunp?=
 =?us-ascii?Q?I2oSgmIfpDxcthyQul5ForaQOJkjHIQJ8FMeBWm40ciFrO5Hs4AeJsJbpUNu?=
 =?us-ascii?Q?RUP4fr4GNEDxDkqDZMCBNBTVMfTncS4F+sf7s43TM13bCcelvwDBUaDOsgs1?=
 =?us-ascii?Q?7lmJ81ibw6XHTJED+YFIyi30zP2qfQUixvsWBcIProvOWZObzAPTAq7wojnF?=
 =?us-ascii?Q?+xvofOlkfFlRA6422O6bmbJWPz4EmoJIcHqOhnG0K9uRLPUnSyIklHFE0rgH?=
 =?us-ascii?Q?C5eVH1ZMTmLLmecb+AkyTX0ZLhfIIXClJRj6JH3RpiEUjTCepc0/rvIY5b7i?=
 =?us-ascii?Q?IsrZvGZ+N3BSa56scmBjM91G/8yjLxnHGLaS5C5Gmgu93D8KkWS0TiIyaAiD?=
 =?us-ascii?Q?EuS++Ph6p/etbYLQRM5slA0w8AFmf/GAJ8+/DGS87HtIf4TajRIKL0IHpml5?=
 =?us-ascii?Q?D9b8upRk341Hy6Szb6OE7vEIf5X0pFOLKKsnOAruEQkGKZEk1uoldbqO88h+?=
 =?us-ascii?Q?jOeMhFhXlX9lFbg5TmOQ2QJUP1hodtLOHNZlMDbjuHTSW57uEa8ErXQe+UrO?=
 =?us-ascii?Q?Fk99ep+zzP5COb4/XNjuy3kziUsP+aTF1/cn6RDPEpBK0zFASmNHYdlZ3Rjn?=
 =?us-ascii?Q?dB894giNqouV8yxvFqKnW4e9VwoKqqgLFlwgpV09ifDOKrtfUMYn1a3Uk/u5?=
 =?us-ascii?Q?6HSjShq5RSwBLO+3Zdw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:42:52.0172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b289ff-1c00-4bad-9d4e-08de2290a1fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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

Synchronize sriov host to add block_mmsch bit field.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 1cee083fb6bd..17c013201685 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -198,8 +198,9 @@ union amd_sriov_ras_caps {
 		uint64_t block_jpeg			: 1;
 		uint64_t block_ih			: 1;
 		uint64_t block_mpio			: 1;
+		uint64_t block_mmsch			: 1;
 		uint64_t poison_propogation_mode	: 1;
-		uint64_t reserved			: 44;
+		uint64_t reserved			: 43;
 	} bits;
 	uint64_t all;
 };
-- 
2.34.1

