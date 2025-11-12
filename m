Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72255CCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 15:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF8810E754;
	Wed, 12 Nov 2025 15:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+ZdJiYH";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6098610E754
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCi02odv3aJly7+LZGaNRkzAoNBrOSFemtBv/k/JFoxYjjpi/Oku1lKv25moWYks8+rwHzPUFn1x2rqcMoCP1Q5idDbOeTQBkgD2VgtfZt+ZaAG1sJ5w5/UpgSpFmjSvv+x278F/BBYV5WYslPTyc35S/jHDFBvk0chVEuA5Y8dbXKsFYUP7vnvgao1YFtl+EkD+/aMfLIom6roUgRwsBufnf3u4de0sTm6OtKDlkuPz+mfEMGiHKKu8kPNPdYB16akK7w89+RdNEyFldIkzOW0JN396Mft61h+UDOu9ElqwMHLtVMThn34MHx0TnT89q+Sl8j1GQ6alLF9iwcUXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT3/cyDu329e/I5RHd+bkLGWVUb3zM3pV6vTvDS68vI=;
 b=wcEOYa2bNVzc5kSUgZfQNh1Utrur62VuDSy09ual/+P9nZ9RYqD3BewHuQaZRSyvTBoEEZwKLi6is6LJWnLm7sMlXqH3XlcHGqHg5aVQTssgr1E75JldEi6KUMHbL+e9myM/2lLdqnbNdoFgI2Mu4o0hIgHx9XJI2eJWPVEecTXnsez6r26OfKxmw4TFiKFLDgKWwpCohHB9A0+D/h6vF27rX82eIDDvXsaYIGnrAXY2LG2cq1ZDjhjKCglsi9yboenX62SaFoC9lZnLNSVaNev/+5IuGvSIFc2Tt6FsmrJKgtawHU6ifkAvPoTjegy6mKBXBvMwbX8jRMFsPAOCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT3/cyDu329e/I5RHd+bkLGWVUb3zM3pV6vTvDS68vI=;
 b=B+ZdJiYHX4FtGiBbnZaqmThD4OEXtRqHHkcGEdQAGYRpjIaSR2MG6F14IT+8x6r6ZlyPfK/9hfnQAH5gzyY5I1hglMC0rXxkhxPA2cpbww/5FTFsXaMeVAomP+ESlhREJrCF7uSA++0wHefKKCtLVpRDAq5dWWTtHhug3wA8VOo=
Received: from BYAPR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:74::35)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:28:41 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::ea) by BYAPR05CA0058.outlook.office365.com
 (2603:10b6:a03:74::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Wed,
 12 Nov 2025 15:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:28:39 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 07:28:27 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2 1/4] drm/amd/pm: Update pmfw headers for smu_v13_0_12
Date: Wed, 12 Nov 2025 23:28:12 +0800
Message-ID: <20251112152815.203110-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: e7de3b9d-88ee-4217-d467-08de220027c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cwj3+/muh3F/uVQL8vS0CxP6vGHKyEEJGhHerqVnB7ugjnEtCZUQLmr0fTwp?=
 =?us-ascii?Q?uJ7z2QU3gryVFhPcy0zUCB/67s3AMWmQQ4B9katz2f6s5aBlXMEJgc6XmvZH?=
 =?us-ascii?Q?9eT6hNXskItT7/V8YlcgPewqyJDro9IeBNedz1o12TFRyMeZZf7HudFLiE/v?=
 =?us-ascii?Q?Z7CQn4zui8CthJoUsFcRohxbmC1P1ehDpK95maa570lUih+sbA5S0pN30M/C?=
 =?us-ascii?Q?+HdGAcG7DdU96jofWV9en44bvtIRReIUZWvm0I4/1EXRag8aHGDmjM8ex8xX?=
 =?us-ascii?Q?h+lyiFguAlfxsnTOnOT/+9tj/HqRqAeMpPjpopBJ6zEEatLFJhN8AePkW+t5?=
 =?us-ascii?Q?llLUsao/a/t6rCHx+ljgPzmQDDlLyJqNs3JtKAiq7AYHM6rB+jAER7Y5Vjw5?=
 =?us-ascii?Q?b2J1pQOVxAJRTtvQZYxdaVya+6UIDFg/+w/4mXs2H2kcdwfGpIQtXhC4Ok7n?=
 =?us-ascii?Q?fjbfs0ACNNse/LPRvAuyu0t1M/AhN9/gIXOeQ54AepMfJIAR1eIlr8hAfSt8?=
 =?us-ascii?Q?y5GumGDTVIe1SfnUSNHmIvGz7TZMQy9FEeCF3ss326BeGRVYMe6dPH13u3CL?=
 =?us-ascii?Q?bVux+d38/Q2mZRLJMvUaKg/e/afBqOnHre3HGtOvVZo3enPUTB7J0CxPk+nJ?=
 =?us-ascii?Q?K3aT2FbxI1b10H0FfMCZzucc2S8WmlWYnSATiG1XSuX336+pR4yiYY/JqVrm?=
 =?us-ascii?Q?g2JgoW99ocnJceHnbftNvRc12p4lphlk5LOsZH8pwq4R84u+/ROX/3sBwYk7?=
 =?us-ascii?Q?ij6WtM+WcTRRG3ms1SCzzl3E54ClIhY02ayjvzOH/gdol0dc3ONnjei01Gr9?=
 =?us-ascii?Q?I8l89RgGHgzNIFkKplfMNWGMU0yv98SBM4kYEV4GsUl6nfdjp42bZDtTFb9U?=
 =?us-ascii?Q?XfZHMqdvhVsxL9APagnS3uQPqdMFF07ZgCAMOo0ZUGxv2twlSVJ6fFQrqNDA?=
 =?us-ascii?Q?zu1FzKnRSTKZ21yMfr+ITxlMAl7zvSaRhd6qX3u3I5AvYq+aORer4eolYx7M?=
 =?us-ascii?Q?uOvvXUfD1NuCFkEwiIQ8v9v8qJYu1l2vI8TWObcG097hYDfCZXPKv3tSVORK?=
 =?us-ascii?Q?O3yP8liU/RH1IsmY6rLSrWqhp1j9qPDZXGK+66zIuIjVW4f77QUzo/gnxjLv?=
 =?us-ascii?Q?cCte82NLQykmO+4KXozYYeNO0zYdENSUbOYEeuEG2B8FDZb1u84pWSJDxp3v?=
 =?us-ascii?Q?tvxUn4zkxohF1brVRmswvySgLgh00Rufaw79U/Z1yA/oqbmwlRoaNFqcm713?=
 =?us-ascii?Q?5B05x9hTiBWWP6Heb/rB/i6LzqBGidtoJvc4efutAgR1vOW05tSKdvQ/GaYP?=
 =?us-ascii?Q?8IT1RiA8seACccnt1y5oZLnoe+t/XN7cfbzpBRybnYuV+yJ9Rh99rkYo+l6e?=
 =?us-ascii?Q?KnTTjsiMXc9VTE5KhV5H1a7tR3V+wfgHBv+l2iUIIzQxGL9tSv4oBcgGqDta?=
 =?us-ascii?Q?1oPivReeFRz1bIztbe0VeRE+7/6K1J3IaERfCvIv0akqyuEb54os8R98NlCZ?=
 =?us-ascii?Q?MGOGSgWcymjqsRrc8IHN5WxrbVK2VaceIOwDdS7VoEQ9NghZfPfzQwO0Jlh7?=
 =?us-ascii?Q?2szcKF/k6xTkQ8XH8V8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:28:39.4728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7de3b9d-88ee-4217-d467-08de220027c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

Update pmfw headers for smu_v13_0_12 to include ubb power

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index dd30d96e1ca2..acf7b2f43b0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -189,6 +189,13 @@ typedef enum {
   SVI_MAX_TEMP_ENTRIES,   // 13
 } SVI_TEMP_e;
 
+typedef enum{
+  SYSTEM_POWER_UBB_POWER,
+  SYSTEM_POWER_UBB_POWER_THRESHOLD,
+  SYSTEM_POWER_MAX_ENTRIES_WO_RESERVED,
+  SYSTEM_POWER_MAX_ENTRIES  = 4
+} SYSTEM_POWER_e;
+
 #define SMU_METRICS_TABLE_VERSION 0x15
 
 #define SMU_SYSTEM_METRICS_TABLE_VERSION 0x1
@@ -310,6 +317,7 @@ typedef struct {
   uint32_t NodePowerLimit;
   uint32_t NodePower;
   uint32_t GlobalPPTResidencyAcc;
+  uint16_t SystemPower[SYSTEM_POWER_MAX_ENTRIES];           // UBB Current Power and Power Threshold
 } SystemMetricsTable_t;
 #pragma pack(pop)
 
-- 
2.46.0

