Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845B6CCF9EA
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 02:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF5910E0C3;
	Wed, 29 Oct 2025 02:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4SZxLxw";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD2A10E0C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 02:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et7lv8KY6qtV78LT9PKA8c2HQaZ5myX+torhU3K4HYONWBsoh4jJlwimdJiMSevdE4npeVyu1Qj+FbmKrfw3QVH2EagFgI07AoNN7zKs1L/uw/rTnNDxkCHsu356OUTmLme7nORkfr6FU8rhmql6y2KB/cxkH1FKk5N+VuIa1spLC68/XNCDJ2jYQPwjrCPWinJFEks0cPqze9pOPvHRGkT+xBP+u9IapaR/KKt4VRIg4zS6EKWuItwp9o9u4ipR6YweqYZVpXN7ZE8Xz6eoWKaWPryzPtmF2VdwFFV5khHhWujLnBFlCHUUlHecEBhDZDISGusy0//Cu2jyfQ5/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2/S91SBHiftsyTnj2ZaWa2p2/ov+z0SrsSii4qj+UE=;
 b=R5z1aRGswGc96ZyuRUyICr3WXV8uDFhUp0xjQMNDrDvASdvP1jyc49qHehlVxThDTiE56zvd3dg6zwmbAJVsug0rbM6nchulCH5vV63FD4Rvh8no4wrRsdbBT6ozypBZvm4qBSPujY9RWxoHE9QPD6z6vdOfU++VCBKxDRirJqYjHolhgTm8CZzoJaeE4tvKhxBdJKmc52orlIiWmqj0W4BowYuyPcjfyLZEXc0qWIrfYcA4j96fXjiNF2GxfMiEbkGXsW6ipnZyJsCBkPQsEnB85eg1qgyvsalOlwOfQCzTkoHbAWpB+fVA6nDZSl9m/4L5vxTGSl3DNxW50IFskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2/S91SBHiftsyTnj2ZaWa2p2/ov+z0SrsSii4qj+UE=;
 b=N4SZxLxwVWUZUYEVbTEqZVVFYI+vAkGjMVogw9DIS+ofjzbyE+FAAisOZx2PF6QWPtwiA8CumX1sUG1UUfCIPvxJFLCw7XTQtApU5P4bQ2yeVb7mg8YvjksNOoFXe0DubgXxeOu48INJQVBrcKLdHZpw6VSXpUuX5H1+z+xOUnI=
Received: from BN0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:e5::8)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 02:44:41 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::53) by BN0PR02CA0033.outlook.office365.com
 (2603:10b6:408:e5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Wed,
 29 Oct 2025 02:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 02:44:40 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 19:44:38 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, kernel test robot <lkp@intel.com>, "Tao
 Zhou" <tao.zhou1@amd.com>
Subject: [PATCH] drm/amd/ras: Fix the error of undefined reference to
 `__udivdi3'
Date: Wed, 29 Oct 2025 10:43:28 +0800
Message-ID: <20251029024328.2068340-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3739cc-3126-454a-82b9-08de16951bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qQmjZy5eQ63ma04piXjVAAJyjYBqEcbnCfw0V36XPhMwJFVZaysRcA5gyg2P?=
 =?us-ascii?Q?mmWsnw8KaNkQKRjzmKUUsSIc/MGNh17T50Q/J1i96geqt3+GtF1g2q0T/b0V?=
 =?us-ascii?Q?3oZ5N+CVRNdDBE0qX1eJgUGBbWEaD51abLh5kyIVlsjmLekQhIzOqUPpYR2H?=
 =?us-ascii?Q?v0sBtTpblH8hrYvr/4tXWD8MLnXi4cWAFYmaetjTsjW9xPyowHC01vfUUonv?=
 =?us-ascii?Q?ry7HKAAWmg6CWQRXKvvSMLJl6QZx7048CD4airntOGvM+uY0rzxzEstWbq8G?=
 =?us-ascii?Q?n7hDBiNaRR3hksChmheIimSnBXTxR/KIIuI6te1cYmDu3Hw7iDrkiK/bG73j?=
 =?us-ascii?Q?Vph22gLQTXidlmoQvwqjBwCyonN8uxxFb7pXYXNDp5wPOzGP6BQL4cMz4xfW?=
 =?us-ascii?Q?VC6svb7XLTS57LIBB9M1iRDy+GlLOSgnCfWv8Ne9ZNBxDDbUAYxic3+M/s0K?=
 =?us-ascii?Q?FfVHasvFGVt0rFWvhP9bi/HBXQ0vt1r0HW8KYGibQ9AV72PFKdLAvWRwIirS?=
 =?us-ascii?Q?KR0Ku2Lqly4et4J1b0eDhIqWpLY2rWyiFvvlvFIecNLxDrjaBuauWWc+y7Mu?=
 =?us-ascii?Q?i2nJx18Oj9kdx8EHMqoH0JvVG1i5UOsIW5gMrMMoHqstv5KJD6En8ehDJ1aU?=
 =?us-ascii?Q?zzwkTLAQGozkM5qNPhXDOcXf49GXe18Y2upP4vSli9XPpimUq5AaaOOmcNiV?=
 =?us-ascii?Q?PdEyoCTwcwIZtRV3MBPRvt0drBJHAmzkXKYjhcad+I+RZplgQzjoiYiPQzaB?=
 =?us-ascii?Q?741IXTraVWiDJKawO+3OSaKdkOpTPbSQjtDBdHyS504+touqE7hCPbzip/ze?=
 =?us-ascii?Q?+x7epdKbxAaCX7hV3kXIAiFK7f9ppGEPXDExc5QEUX+4nHnXsK5p3YAg8/u7?=
 =?us-ascii?Q?gH8GrlutOhJ/La8Z0MYob9dUDmTJ3VV08NAfRU6IpI54BkP2dmUHx3LysDEg?=
 =?us-ascii?Q?PueaV7FAArKfA2StMKE5tkZcef82q+BsxPvbF2z0MCDkKE8ZDDH7zpmvt2Id?=
 =?us-ascii?Q?Cm5cMxQnLUuXciA2yiSYWJSigiT4zesWoMptBKvvleWSRdak2d2Me6YSbYGm?=
 =?us-ascii?Q?X/lEze5fD3l7wOIMxMMIjWOI5yKgeuZjU2ry8RQFPNUZh8WNZKKVWgDliAUW?=
 =?us-ascii?Q?nJVQoLKuBvfHFBNshK7owmvBTBkjBXLhP94CSlZYDnIcf5a6bIFGYrdH0dqz?=
 =?us-ascii?Q?JlZzqdQ8palv9deEDKLF05uTcFIXXHC5CxXjfyiJo9fe9ytxB/6sDNFZpU4j?=
 =?us-ascii?Q?zlzDHhtstSXJvVJdsXFVjcvRGSINQUUxy5kFNQES2Y5MteTbCOhRSmfbR4nx?=
 =?us-ascii?Q?NXhV1rWZwbwHPPOFuCBIwmB+9/JFaeBCqIqUPpeQUJc5O4gGkurCEF6Ju7UG?=
 =?us-ascii?Q?oKIGCbzuR5Qfs6KGD3u93PnaRQAGjXRZKkmrzfoSbpk0X4u1Ck1JtARVCGaZ?=
 =?us-ascii?Q?WdxDg50Z/qSRpl49O2dvfZVCsxqcFszMxnbFwRYOE1Dv+xwusid42RFdnOGw?=
 =?us-ascii?Q?E8mnxmuZlzXGLrVBQrVwmNZC0rHWptzD/yFBLD449MqOP2946efq3y7fpQnU?=
 =?us-ascii?Q?OzP5XY1PbaunGMq0jGc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:44:40.8178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3739cc-3126-454a-82b9-08de16951bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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

Fix the error:
drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/amdgpu_ras_mgr.c:132:undefined reference to `__udivdi3'

Fixs:b5bae0f01786d("drm/amd/ras: Add amdgpu ras management function")
Reported-by: kernel test robot <lkp@intel.com>
Closes:https://lore.kernel.org/oe-kbuild-all/202510272144.6SUHUoWx-lkp@intel.com/
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 8007e49951d8..d09c4a75a7f4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -37,7 +37,7 @@
 #define MAX_XCD_NUM_PER_AID			2
 
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
-#define ESTIMATE_BAD_PAGE_THRESHOLD(size)         ((size)/(100 * 1024 * 1024ULL))
+#define TYPICAL_ECC_BAD_PAGE_RATE (100 * 1024 * 1024ULL)
 
 #define COUNT_BAD_PAGE_THRESHOLD(size) (((size) >> 21) << 4)
 
@@ -129,7 +129,7 @@ static int amdgpu_ras_mgr_init_eeprom_config(struct amdgpu_device *adev,
 	 */
 	if (amdgpu_bad_page_threshold == NONSTOP_OVER_THRESHOLD)
 		eeprom_cfg->eeprom_record_threshold_count =
-				ESTIMATE_BAD_PAGE_THRESHOLD(adev->gmc.mc_vram_size);
+			div64_u64(adev->gmc.mc_vram_size, TYPICAL_ECC_BAD_PAGE_RATE);
 	else if (amdgpu_bad_page_threshold == WARN_NONSTOP_OVER_THRESHOLD)
 		eeprom_cfg->eeprom_record_threshold_count =
 				COUNT_BAD_PAGE_THRESHOLD(RAS_RESERVED_VRAM_SIZE_DEFAULT);
-- 
2.34.1

