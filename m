Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32527D637BA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646EB10E8DD;
	Tue, 16 Dec 2025 21:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1y9FMA8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4348C10E710
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJloOE9PHhrFA2eGfcOsVwYsRB3k6l4mkVxRqrsDspVMEid0AHRENmJe8xa0ZbRwUVru40M+8aUCYNkktRxoa1oLwjiH/AoD851mvlOlXXV7KX1NoyH7WOWhZWl5CM16SzUeDsdO7U9mj3OPXnKEqTDITE1JjVcN+OSamLReogh612htNATl7TTsQFYgyZ0K2OmuI4zMF9ktlf2MwTRSsKRS3gz+GYB3Mk9bIWc8IouDA4b2BT/aFhJ/2klf7PCenGS9z3Z5Su1xD8ukSX6IP4CGECOsl4ONVp/FlmmLERbrM2pF35l8lkZ0+R3trn+p0Di6qw2TX74l59/D5Bo/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UqgqwhTHsgnS2eonVMIdFsdpXYo3iGSag2qIRonFQw=;
 b=OIwhkuanKadMxkC1TxkUnYfLnzgup0pi5jAOvXoIRnfGiTbszH4TOuoKmXSBHVSUd6cd87DozMI+tlraEXcv95eQgxr84sCFOseNQQzv90Qeocm4+rAaLm8IBlhdMgMwTJ3KahPYSmAjb0qo0v5tCXDab2fpaWakg4HN22QMW9zppC+M48PsH4x3sATGVk08tn0IHa56/dORPTEIl7E0e8vAI0rX9W0ECxUkCS5Brv2rXVU9mS8+89mH3+wvlospXrhgPeQpRLn+1435cef3tB0uhq+MuEGuvhuorxprgMo70eMT/vnv7GyLhHutlZxpzMxUj3DfXE5TOzpnCC1k0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UqgqwhTHsgnS2eonVMIdFsdpXYo3iGSag2qIRonFQw=;
 b=Q1y9FMA89sVpJw4t1/+5UHAR+fQvzghpJ8G2poaDkXtyXrmChpWpDLaRv4E6lIP4IiOvP8LFIPIxJvV/g1cfPm8CYcReAKFMjOQJHjLunZrteDLxYD3NgNGf6G5RiRcjkOaDS1Emxz3aBRoYykLcRD8NtV0l5K4xLQ1CDATnozA=
Received: from BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::20)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:15 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::5) by BL1P223CA0015.outlook.office365.com
 (2603:10b6:208:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: reserve umf hole size at vram high end for gfx
 v12.1
Date: Tue, 16 Dec 2025 16:03:46 -0500
Message-ID: <20251216210349.1963466-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: bc378413-2e5a-4e6e-c5b2-08de3ce6ab96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aGp6j7tMIXrr6z6rmCiBCamrtJjvFnRqtmqKB9demys/AAYLOV4tRX0ylAdB?=
 =?us-ascii?Q?0R178YG9I9QOh3CBjB6lz9/zZcgxISA8F1OCnRqn190JtJ5YjOisGwdRxNWu?=
 =?us-ascii?Q?CXZFzMLIgm0YcXoROLNHvWKAGigdTLthGnomIYUoDkrCLR+wwNEzYUA7iXfb?=
 =?us-ascii?Q?z7/qJf5ZBgk5WEQg6nytPFiQESbjCefHQt+bF50YxL6+S9yXBNmr6+0JDutv?=
 =?us-ascii?Q?zXECaOBUZEvZECTjw9BL8JqSZw4bEYzvh8bw28EHmxpH9AhSTgWreztuRozK?=
 =?us-ascii?Q?PUapjWyr/HaAxe6k7VA5thKgjjrkekkAMFfKYVBMlrjbE0cFvwX1UYi+umqq?=
 =?us-ascii?Q?0CfHw7wht4adivZkvAYCz031phA06d9m6fdUV0hYtAIC6NdZH6MCx7mgWwZY?=
 =?us-ascii?Q?fJ0HcFZbxQvDixn5titpSVh5gT4hoGkUeklGLiWGL9riRHGvxzraBxIxFGlA?=
 =?us-ascii?Q?UqRL3T+wuStkSWOurQ5UpM5+r8W0tAd88jWlyUXGBbyNbS1O8jOWH3/ZWc5S?=
 =?us-ascii?Q?+lXREvx3hLRWBrEh6bQhiQkWtX3uD9f3Pva7/FDs1yF9Ch9ox0pErRTgZAw5?=
 =?us-ascii?Q?ZGgWvwaLMsD/odQl2D4bJJC9l8nznJEkLH5qlqhhE5MHgNU6EhYj7dMZoN5n?=
 =?us-ascii?Q?GQBSumHsuRqo3pK3833rTyGdwcYJGfsjFW53eZKF/+dG1KDeihcRgckqO9YT?=
 =?us-ascii?Q?B8AsApDGTm2asyBAksyY8uUSPfzhgk8G4KyGQyhqxBAZyqtO1zIUFRE1pgtV?=
 =?us-ascii?Q?CxbculRJnpEo4pYytiHmFwh2EkAAEexUm3GmL+kvPfg3/zUDR1ypTEUz/g7u?=
 =?us-ascii?Q?Tdt4ZCdxVEvT/rTpY7E1A0Zoh2KdfLQU7TUS/94HKmj4cmXO5HM7ITv7xFkB?=
 =?us-ascii?Q?az9iluMSK3ifkuB3wPZlRDBp7JcFjSfmBVcOguI39OWv0p56jI1HjXHQoIry?=
 =?us-ascii?Q?OxiF8k9L5yGpczE6pPBv/Dp8NdytDOpuagmFZUUxyhhe418SIB9hkLdPZkbQ?=
 =?us-ascii?Q?yw2KEdP7CRZ/DEoSXrMkOvcc6qET2V1x7x/KQrGucV29O0tpXQret/bfcO+0?=
 =?us-ascii?Q?+F4WExJ62bKhb5QxP5dPoOw9Q97LPeOma2LDVKSXsMujQhvt3wPs3GbAcU2x?=
 =?us-ascii?Q?5UjFOSiCjMhrynbV/vEuBQ24LEEcCYwneb44384mTiddxRTQqmMcduV6Ahvi?=
 =?us-ascii?Q?gVTDTYpKs8bYZrxwq1fMOQ50xF0PuYiiMjIZ8Je8bgNVS8ktdODfjJj4GJ3/?=
 =?us-ascii?Q?8/SfgrvrjaMNFKK6Q6dLVTC0BKCyWpTBOdQNBxrvQyz0vSqOYRxSYPKJXFRM?=
 =?us-ascii?Q?l84skOkN5PqWLNvR1YRZnUSoC8jLE4KaHkmlB5PYlCnQ+NMNbQ7RRWTAQz8G?=
 =?us-ascii?Q?IiAWUM+pMLZlcbn8voCkWDsYC2Tun/WUlzAqIes5H081bnhKA/xog2GAtF4I?=
 =?us-ascii?Q?HIyQGp8uf/4ybT5suoTmcJibdJRsx2EhLEmzXUChWAtOFJLEmVmIjuntrmCf?=
 =?us-ascii?Q?fEggWDV0Ew8nDzMsOsUZmFQR34eGSZvejq60l0lZ347KyXkB20fk2EJ4LXRh?=
 =?us-ascii?Q?m/rG02p5d6YCx+1Bces=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:15.1686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc378413-2e5a-4e6e-c5b2-08de3ce6ab96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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

From: Le Ma <le.ma@amd.com>

This region is reserved by firmware thus carve it out in driver.

v2: set reserve size based on aid configuration.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f83d140b6ae5..87b913a62fb6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1835,7 +1835,13 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
 	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)))
 		reserve_size = max(reserve_size, (uint32_t)280 << 20);
-	else if (!reserve_size)
+	else if (!adev->bios && 
+		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
+		if (hweight32(adev->aid_mask) == 1)
+			reserve_size = max(reserve_size, (uint32_t)128 << 20);
+		else
+			reserve_size = max(reserve_size, (uint32_t)144 << 20);
+	} else if (!reserve_size)
 		reserve_size = DISCOVERY_TMR_OFFSET;
 
 	if (mem_train_support) {
-- 
2.52.0

