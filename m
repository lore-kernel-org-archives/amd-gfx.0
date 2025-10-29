Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA85CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08B410E15D;
	Wed, 29 Oct 2025 07:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WuzugP2J";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2352F10E15D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2uhfOzrx79m8x9eH7a9ADR36z9thdtH2kb50cz1Pf4wuHFZhEGgqBxxseP52lXpQzfgBahU1U770bkeQzFoNyaxcQ1KxoEnzboV7wzm83O6dAO9BmWroDxPolYhla/RN0brvkIskMyyCSb/qzRTXdT504PxZ+RsfwNysFDGvPgsLj4pbpCOPEVcdjATPk0YXKsLpDWkgcpYlcVnkblwc97pG9chErL/m4Cp8wEgm0KC4R/wywgX3Nrsv9sjyZ6tZ6tgFQBgX/xZZWEuegxaxjNxzlL/qQDtaO6wqLSYqueBYbWqjggfddgMpBa4wDf2weiNGv1blve/FZaLRYUlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kH9g/BR15X6aZzA/yJ8FjDaoLSBXv/2/g+pMQ2iyomc=;
 b=tN31Nzf69R775OVnA6f9STS42hmzQ1ZgCme2mD5sPIZp345HteV0JlpjBWo3bfIHt9IAjqsfG5oWFNgV0O+5hzF5b2+18BEg62jtswA2j2pkcr+JhFgrKUcAAjFmfSLtqMC/0Rujy1OylCbgKOR8OLNtsJ7a2gRV7BA1rHGbExye15/bOIUJ0P68DG+PhaDdzeo3pVq5slQ3t8LApEG8blIL/lB596ViyU4fBVmSbpEleTByN+w3+5piibfxTDteC7EmcUwUt7QMPxUVae5Ge0kiVnVLkm4yuPwPHJ8Snspyxqh+pd9dzNXynu5nZ5MmYgfpF52JlRG4kltZg65grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kH9g/BR15X6aZzA/yJ8FjDaoLSBXv/2/g+pMQ2iyomc=;
 b=WuzugP2Jsbkcy1rDuyZpM4j1XdnppPATrElAiWWNyIsr+02G5hGv1wMi0r5HOaGfSP3BEGSTBCla+VlTbZv2l3HlVgYshHNb06Gn+eRmGCCjsZM16FkoA9jZEHNCwe0VK0qgeBxpB8jYAGMKYa2NFFsuHxNIZJapLpAW0Clvw80=
Received: from DS7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:3b8::16)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:30:41 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b8:cafe::36) by DS7PR03CA0011.outlook.office365.com
 (2603:10b6:5:3b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Wed,
 29 Oct 2025 07:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:30:41 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:30:39 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH] drm/amd/pm: check pmfw eeprom feature bit
Date: Wed, 29 Oct 2025 15:30:23 +0800
Message-ID: <20251029073023.1698032-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a597d0-0c17-4048-12fc-08de16bd104c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?saaYxj6/IHXjmelsSSskg96M9K4JSuPGfDGLWFgFAxIuYubGMYlxWtNHmE+g?=
 =?us-ascii?Q?bOiENFup1BrYL5RBF61G7vkINzDO2ICnP1gv78CWYan3oKRS4/WGHdZO83ew?=
 =?us-ascii?Q?w+3lpFttsvGuP2lnhAqNuNw+m7Dmvdn6bgcVIBBVzUG8AHiSkCqZM8DbuWCn?=
 =?us-ascii?Q?aAY5+tUcu34wAQ6hFmZIOSL1K1eU6NoiwFYMGGg/0RSlPXJEwzaCTff5WtLc?=
 =?us-ascii?Q?d+23TD88HGeNtMClVG8cgQ/CLma9HeHKqXJ4ek57PPkqw/98+PqZh0Sf7PUu?=
 =?us-ascii?Q?bJHTiJw/8ZPH26GqqjKq5f7Erg+jcrAJ6IoVWhoq9/E2h6unlbnsCvmqSCbz?=
 =?us-ascii?Q?W+ngqcP5KTX4dsxYRUqYlEJvzSKyEVuQUxBSAZUpMyUms/52wQMdS+SFqxvV?=
 =?us-ascii?Q?2lB24653oTfHns3fDgdWVwgPrfve7/k7ZHDpgrK2uFycISl2BSXu5QecDA08?=
 =?us-ascii?Q?ShclvBfgRrCEIU5N3B7xvOmsSxIqM2sUKXalm7zBPmo5geWe+Qp5bOjAq+K8?=
 =?us-ascii?Q?uNNh3XrWnsNwD86L3cOoi0zWLguUSkCttqlz598LAHvtCSsXQS7G296kGD6R?=
 =?us-ascii?Q?t79TnzfufThb6AjuIxWVLWjZdB58zOHedJjEWM0S2ZTd1pqy7F0/7vPDrzdh?=
 =?us-ascii?Q?F+BLCv/xyt0oQTwkCelH7QshcQYMs3SkEEH04982XCCDxY4FIoIU73n9Nrxg?=
 =?us-ascii?Q?x4K6YTDKjL/v3VqsJ6bp0VAQ/QrE4N0QZqpcN7cGqmqU3jECIGKFiDnzwHtI?=
 =?us-ascii?Q?6DLSmetVhamAG1wZPtJtUyLzHt2vopkyYk0Y44mEg/+fL2Qcn3SLL49nkZDT?=
 =?us-ascii?Q?96SmSzB9gWfJEYrxwpb2AvVdMzkvTIYkjetYhbDHCf4LNPy8IYTcUhTUjLI2?=
 =?us-ascii?Q?MKZebdFSSCqtb+5V/8D1yBvx/itAMmYnhgwmVahwmpKxmyCLArkE1ijG8MYT?=
 =?us-ascii?Q?IVkebWxvONIrJK41ojNEglyjInId2qbkbTHq/VcY2F6nnVrHjYDshLYCBk6l?=
 =?us-ascii?Q?epCdpLTZSeHovQsagpatUN9Ms2KQC/MmjyndsL3agBhXUFO7lMCn6X+Bv3yp?=
 =?us-ascii?Q?151QQkiZaYZ2Ve90FvLZl9+Phvw7ZfZ4DN0NpXC4gFF3c4yLA84G8LP2vfHe?=
 =?us-ascii?Q?B3L4q/W1IsA/lW9RxOF7sZ2EHpEX7fe6OqT3v2D0/JDFcYTiH2+Gn0EOTotw?=
 =?us-ascii?Q?0n/VG7wHc+tLLFzQlrw8s2cZtcyRMwFz72T9HWfaXSEJOCx9gFPth+Gy4M9Z?=
 =?us-ascii?Q?sGl+l9ZTp9yy2YETb5RByP4k3rMCmc5wqJneRJxPEI1gTzxCxqtB2H1qetD5?=
 =?us-ascii?Q?ChI7ro2ANsrwoc7lYbttN4+3Z1JMQPOvDO6wT01eJLnktFcwo12mjy9ptwM8?=
 =?us-ascii?Q?BuaZbawRMaCM2f31ube5SQO7ZHzebAz/cUjAsBvqfC7eNTB70utBbwZsc2J7?=
 =?us-ascii?Q?Mnpi4g6jtn6zYJahwx3PYWZrH8YJKXRLu+beiv78QaDDs6EC45m4PX0LP1KQ?=
 =?us-ascii?Q?M91Qv2+CkjJldRjN9gn9iEkPJ2dPo8bDnatAk3G3A70MJ+ja3/mpldDH+dzX?=
 =?us-ascii?Q?9WJyu+NZcFWiCYOhbq4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:30:41.0703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a597d0-0c17-4048-12fc-08de16bd104c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

get and check the pmfw eeprom feature bit to
decide if pmfw eeprom is supported

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h   | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c      | 7 +++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index bf6aa9620911..fa43d2e229a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -87,7 +87,7 @@ typedef enum {
 /*37*/  FEATURE_DVO                         = 37,
 /*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       = 38,
 /*39*/  FEATURE_GLOBAL_DPM                  = 39,
-/*40*/  FEATURE_NODE_POWER_MANAGER          = 40,
+/*40*/  FEATURE_HROM_EN                     = 40,
 
 /*41*/  NUM_FEATURES                        = 41
 } FEATURE_LIST_e;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9315ce49b396..3a3930ef7ed9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -465,7 +465,8 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(GFX_EDC_XVMIN),				\
        __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),				\
        __SMU_DUMMY_MAP(FAN_ABNORMAL),				\
-       __SMU_DUMMY_MAP(PIT),
+       __SMU_DUMMY_MAP(PIT),				\
+       __SMU_DUMMY_MAP(HROM_EN),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 14b46e110730..16678efabed6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -82,6 +82,7 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_DS_MPIOCLK),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_DS_MP0CLK),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PIT_BIT,			FEATURE_PIT),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_HROM_EN_BIT,			FEATURE_HROM_EN),
 };
 
 const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] = {
@@ -1060,10 +1061,16 @@ static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
 
 static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
 {
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
 	if (!flags)
 		return;
 
 	*flags = 0ULL;
+
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_HROM_EN_BIT))
+		*flags |= RAS_SMU_FEATURE_BIT__RAS_EEPROM;
+
 }
 
 const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
-- 
2.34.1

