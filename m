Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653F3C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB68F10E415;
	Tue, 14 May 2024 08:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f47dXeid";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F45310E498
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQQt+DuZOZDsPWS4Tr240PiDA4YqIBaltlHzWaTg1Pcx+4LjHvHe+u8ZOktG+HGyFtsJzahQiCoPrAo9lC3DYePC2gi7KCBgiBbUc0oafLffjCeBJbQS7B0ip6n7vFoAYlaN0D+0BBVuIvZw4nAdfUN9MOiX8SlPxMJXFzwPQVqrtJ56y6cBZKxjE3Rsw3buS3cjaNS5PYpiVxjlMg8SW8Svw25tXIIKLZy281QXo0NVp+lYhjAjLDCgFTo4i+YySd1JxmDVVLOLys84oZY2VawVHF/UAXFP7DuHF85z/RKiXmiI4ZZaWMkkWmqY4j82gYIxIyws+vAMkHPYSm9fdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apCrwKOj32VbX6iOQrWFBun77jFuLcYgTOIyIOB4zEY=;
 b=huGDZFf0zPyNT3gGE/HFDRxnvMv/tHJe8DEsq1nIOkxf+skzh4kFrxCJVTjv5XLBQ8oJFVgDZhvdPFsCpJuGflZIyAtWf/olo+SWoxmVvPIGzwYymbmr6YGdsCwXVuaKlLtmcfiI3+ayKteozBJbf1ETVVC8U2VMkFU1GxuVLclGoV93JTqXcPu9zTl4s7U3C++tl6co4FPAIARPMzli8fHs76+CfLDHUtU4Sl83vsWdr2+B5uEU9F2L6saUTPCciqBiKfixCkKr1+gJTK8qESJjMUehMMn4R6yRptPCZhPNPcCFmk8iD+2wOQR3Jut68Y9tdLCkkB3+n+BgMEbM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apCrwKOj32VbX6iOQrWFBun77jFuLcYgTOIyIOB4zEY=;
 b=f47dXeidZunUh5BvjljzkNNN4eOHzaLWfvT9FnpImDLoN6R/uGf5bkQTXqSkljM3ESeaZKkaspHEOQHSbHWprHtiIAnGaECrB5M/x0MJdCNcqdz0pyfquawTq3x/YkmWpQ8yytNLOUKZqWSvtYj3yxxttiPNVo4uTEFqQTGEp4k=
Received: from SJ0PR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:332::10)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:36:48 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::1e) by SJ0PR05CA0065.outlook.office365.com
 (2603:10b6:a03:332::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.24 via Frontend
 Transport; Tue, 14 May 2024 08:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 08:36:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 03:36:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Le.Ma@amd.com>, Le Ma <le.ma@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add nps info table to IP discovery
Date: Tue, 14 May 2024 14:06:25 +0530
Message-ID: <20240514083626.378626-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514083626.378626-1-lijo.lazar@amd.com>
References: <20240514083626.378626-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 00752604-1d02-4c08-6ceb-08dc73f0fe8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rhMoENHeZsaKM0O2qWnWez086K3GCLjy2Dd5ga/3Sbod++XrB1EY0ich9cN1?=
 =?us-ascii?Q?VcgfDaViqMZBrNqR0NvOH5pQkuVOGpWfiAODfAYeYZM4s+W1k7gx1L0Mr48e?=
 =?us-ascii?Q?e7l/uj7Hm5igyotQlnYBQZUBmijw8RbA74Oi8XefEEa8ckm21lFGepbXvqI6?=
 =?us-ascii?Q?0tZjmhRY4W1POu9I2en07tL0GbCGxfJW4K8qqPXw/uLIOh5DmtKL3fDdOuQZ?=
 =?us-ascii?Q?/nJdVQHjCq7HIe4hC4X41/+DPLVIkguY/Is01FcyfxP6hC9bgNBx/IgUMqHY?=
 =?us-ascii?Q?zDwxihUblr8Vf0ropAh0ZMqq37xxtn6Gh3t4nDEFiqS2/deC063tvjw/f2Gb?=
 =?us-ascii?Q?ybNsu1O6ULETg3NEAJY3mkY8k92VmOGApCDIZ2aO+B3Dhw62s7iPMqkA64Ul?=
 =?us-ascii?Q?nmEWvSQolsfqiOT30oZGro3K4G+4bb7KuU6pf/LEGKseTmg3mj5JHDeKf79X?=
 =?us-ascii?Q?1IiViA/7LZOt/zucLGALBudOSmUog4a/rsH2oMxBiwpAVPwl1V6wDaeqF68Q?=
 =?us-ascii?Q?P371PNg6tJ06FTUnXJyO24aOY1WvoUTQeA6ReKULbYkIlGWgNihONRqVeo2V?=
 =?us-ascii?Q?2LJ+ljmwPHxq+uRT8NvHnolmlK5m0bhvmB1uePU04FK2MrYWBrPhc00FtUr7?=
 =?us-ascii?Q?oS5moUWdFUU/LLaJQ8LckbUz7F/rmSYXhvGo7S8Nn7XuZ7o4TMzuUWYdPZZM?=
 =?us-ascii?Q?FW4jWSvLrAnKBVCYPxSY8sTDxNNbYJWoEh53ERn1zBx2j5nyOWJIwtDuUIW6?=
 =?us-ascii?Q?G/e02CiX1Gkw8zEShPd6qIAzwbZE7knIHD9bh6HOeOreg4PoEYYqOxB59o7h?=
 =?us-ascii?Q?IX4O89dOBmyc5edLhM9Xkx+ZyPFuGqR3kexUmaUEhuoQ62EkgCfx2WQ9/HMd?=
 =?us-ascii?Q?jhX0wNkcxjM4kNKRVIyZYEYjmaT7ecR3ElHJ0BNY20xXxRkpJiqOZcTRVlD5?=
 =?us-ascii?Q?ZcDMnEDTl+YOSUOzf9r2sKcFPwf8poqZt/nsrX/o366BIqyCaadW5GhgHOg8?=
 =?us-ascii?Q?vfLZZfr/Fa1eYQ6dPuWwlH5UV9obwwgMhLqLwoyYmAughJHFRNQxr3cOqbEO?=
 =?us-ascii?Q?5TFVuLGmC+5ToMUwcZTpPwjjLewZDa4onoTIFBaYf2n1bXiSq/EzcVhj1EUI?=
 =?us-ascii?Q?0Oi43wcX1cbdYdHg5p1o4Y4IyvS7RYHlUfYmLegkdiOgAG21iRZ3ni7qcNp2?=
 =?us-ascii?Q?PD4FCFWRmYKuSE4juwaq+062/kCPGbfCrFbi0QssUL6Hc8x1dzs0rCorU1nF?=
 =?us-ascii?Q?JdrjGXwsHa89XKJXa7T2OM3N7YNoVnGuZQrNJv/mqTe6eI2hdRnZkwjYUiyb?=
 =?us-ascii?Q?MezEsptEqj73TeOPztXQXjEGJanB+zxKwQkEnvmm99yiFzqu6DlNMf7CCEs0?=
 =?us-ascii?Q?yoYfYLc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:36:47.8257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00752604-1d02-4c08-6ceb-08dc73f0fe8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

Add support to fetch NPS info table in IP discovery table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/include/discovery.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index 0bc169f1ae0d..737d37cfd486 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -31,6 +31,7 @@
 #define HARVEST_TABLE_SIGNATURE         0x56524148
 #define VCN_INFO_TABLE_ID               0x004E4356
 #define MALL_INFO_TABLE_ID              0x4C4C414D
+#define NPS_INFO_TABLE_ID               0x0053504E
 
 typedef enum
 {
@@ -39,7 +40,7 @@ typedef enum
 	HARVEST_INFO,
 	VCN_INFO,
 	MALL_INFO,
-	RESERVED_1,
+	NPS_INFO,
 	TOTAL_TABLES = 6
 } table;
 
@@ -382,6 +383,28 @@ struct vcn_info_v1_0 {
 	uint32_t reserved[4];
 };
 
+#define NPS_INFO_TABLE_MAX_NUM_INSTANCES 12
+
+struct nps_info_header {
+    uint32_t table_id;      /* table ID */
+    uint16_t version_major; /* table version */
+    uint16_t version_minor; /* table version */
+    uint32_t size_bytes;    /* size of the entire header+data in bytes = 0x000000D4 (212) */
+};
+
+struct nps_instance_info_v1_0
+{
+    uint64_t base_address;
+    uint64_t limit_address;
+};
+
+struct nps_info_v1_0 {
+    struct   nps_info_header header;
+    uint32_t nps_type;
+    uint32_t count;
+    struct   nps_instance_info_v1_0 instance_info[NPS_INFO_TABLE_MAX_NUM_INSTANCES];
+};
+
 #pragma pack()
 
 #endif
-- 
2.25.1

