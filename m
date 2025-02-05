Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD783C02199
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A1310E724;
	Wed,  5 Feb 2025 03:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ANsAXF1v";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C244610E721
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ka0o4QFLpF1B/7O37fKWdhggIosYt1EVYPsoinS2Dmn9ZQt4LRasttC4UERsjAYMA1xbcSvlD4L3usqr+8PiuWO4IsTlqixnDF7RVU4nYMWf3ZRSZdpmtaRPJLq5EnwC5ScsPAtYuJ0iuE+mrNrL/H9o21UAm3eqq3bgNT7o/k2HDQxCqfSA1COpgI8IQGaGrixfXEutzzMGfbR4Jjx9PKf7Up1TamA3JNjLlvj9nnHhFEEMGjABR8R8XVLq/Kcqc28PAM51zE4fJ1yxci0Z596Ic5KvEQljXGCHWuQgJNZncSkARw0ic3W0/5k0BQgEEVbEGwFka8+ckSaqojU0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fes3c8q7D8sr5e43wxoRwBwJwnOuu/eLhNAbby3OlkM=;
 b=qL0+0AfEJXpxaEnU9bsaqtxsNHTEK2SyVOgS6lPii9m1VudEr/S3ZX02n3N3mGZ0zvCcGL+fX9NRrCveQEUlesO/wT2rHTwyEMoT1TqmR00QdAKix/R2UlxsoudREiqwJFy/bONKAGwjQyUQv3XQcOhk1+tTZW81hPu6JKMNjM8UFQ1B6OBOr9N0YcghkY4W1tGedKUK04BU+zXnyrJ2sccLGO01ZHa3HeqTypJpHpNasvOWWKHHmXGyxgbNnvHiBvib9RuQiqKwJV+V6slVhl4zbQA7phTgVa+cjpuBW5Y7dPigC+YGg+kxEPs7xBaqkpjQbcLtkxfCgOIMjoJaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fes3c8q7D8sr5e43wxoRwBwJwnOuu/eLhNAbby3OlkM=;
 b=ANsAXF1vSEGSOVkkJ0amcL2u/VweI354EMJeHc5PNqDWgQsm+JCXJcTP0VRjaylbti/b2qVzZGB5LGcnbIcAuMhruDLc5G29vVsi9XFbGxkmOr5F7zXTQBO4SrNnWF8iMga7FjP3iQ2393f1RdRXRyr8MDEl/XPqIFtBdguoSnQ=
Received: from CH2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:610:58::24)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 03:10:32 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::b7) by CH2PR20CA0014.outlook.office365.com
 (2603:10b6:610:58::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 03:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:10:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:10:30 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:10:03 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Zaeem Mohamed" <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, 
 "Wayne Lin" <Wayne.Lin@amd.com>, Martin Leung <martin.leung@amd.com>, Taimur
 Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 02/12] drm/amd/display: Add DCN36 version identifiers
Date: Wed, 5 Feb 2025 11:08:47 +0800
Message-ID: <20250205030857.2608094-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 31468319-5f0c-4ec1-b8dd-08dd4592a6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KlkbBrLQggfZLOmGsGVCn8OecktVt688U0KaZQjieI1VMEGZZoNUWrLR3VDV?=
 =?us-ascii?Q?EH4w3Tz0iCqBF28Wmb5MA1Z4MLTNLlxKjA1Wi0cioRfF2nTPczo1OItSRzDT?=
 =?us-ascii?Q?0AWrTdWUreOu9IJwgzQ4bmkHDKS8Y65lnnTIwLvJU6lZP0mkA9eTC0uzpYbc?=
 =?us-ascii?Q?oeH8UvJfBRdQgqBqb30TCHGgMG1SieE0JxTFCKFV9YioS1KIC84zzQBZMD4D?=
 =?us-ascii?Q?X84uVNBgW7tRGWh44DpeubJwXvb2ixHLA1T9G50MEBGMhqEWtvbMQ1aPDPaK?=
 =?us-ascii?Q?h9rRFK3BdptLWmDGEJ1ubJYBOKvH0FmCfhx8ygaDhP0FwO0sHjF5HVLQWcgh?=
 =?us-ascii?Q?+/MA0RIGVJkX+F04sliW6Gr455In1J8vSpDzDqh2DD1a5VFIpDrorkysYgI9?=
 =?us-ascii?Q?WxgKoc6K8Bfe7IJ87bGboFdwWGv48DMuhQSghtqB0urHmAS78AVtXOiieq2+?=
 =?us-ascii?Q?/HXBo91Ob8fkpBAhJMoqAfhlBvC+EEgDHWtI+AeaEVEa1mAzteSJgO95lHIr?=
 =?us-ascii?Q?cyWnCOxC2qD5GtK0odC3OqJ61wm7mtKH0pDtYrUuNAhQNPoCE2vow77BrQbV?=
 =?us-ascii?Q?EF6lp1d7BdQINprsEqPTlY05QAzYdMJ1qyTI7ndlxy4sm3urG5rQJEqq6+FA?=
 =?us-ascii?Q?lt8ywnG7UO5Jhc+2Y93IxJ5pV2vQeIzYsVoVFD23R4y3BYQEuDPnCn3VoVwt?=
 =?us-ascii?Q?VwThkBgOirStBAAtYjAHswGYiMKtukBb/fJwbCda7xvDIwBOzqZShAaFIz1I?=
 =?us-ascii?Q?1hwJ3CEX7hilR0fHOP02pBEYXgnVSi3c+9FFfgcumlWQeq05O8JQ8QQGm8yN?=
 =?us-ascii?Q?hovnQL0HERslo3B9nCWeukUxCjzPEzoB1PhfEzoScCkBtrX/N15IPXragPAI?=
 =?us-ascii?Q?cWwA4Yek/pG6v3bnxb6mVslkInI1hp0RXtsPz4Dgn/UgIy0eg4BzKX0uycNJ?=
 =?us-ascii?Q?0VLZ6pfCrXzc8spST6Npo5PDS9fTueaP20aVbbBlerbD3aifuQIsy8soukbs?=
 =?us-ascii?Q?M1as/nqRxoZp3metGhtHFtK9LjXBRPR850Xfr5xw2nW1zg6fgIi/uPJk0IUc?=
 =?us-ascii?Q?8mqtPNw82g1ZGBFuc2yAgCW7ytTUVWp1LxeZ04mR7NtrZ5+TDQRQd7eTbKmJ?=
 =?us-ascii?Q?UaNZ9/7IV9j47nGYDFwJF4x2O+69So/pD0StqOrxLHNS4dVuK4zZvsVoq2u7?=
 =?us-ascii?Q?3BgBVWUZZQ4pCh7d2egYXnfkFdtCzwNGRzlpq0+/1NAg0qH+EmW/uYUTZcQz?=
 =?us-ascii?Q?vh6GRm+LBKEXCJjBNZp9o8sD2ILPG+bqk5QlURGCxfjo3aIqE88pb3SrhRQJ?=
 =?us-ascii?Q?/cwM0DWUZrbj1Lx71ApdlTgHFZ2xt/zAU+2gVzG3KCGkuF6egbbprbK+NNY9?=
 =?us-ascii?Q?Ke+6jz+dVCTaCx4Fwv7XSoWqDqLb4Oa83u0estnhwXUEd+bA4BKfPiTT0Ev8?=
 =?us-ascii?Q?uBiln/F/DUv8Qj908SVvY/ce1b1BAZabl1uYkdNac83v05szGzs8SqTU+TLF?=
 =?us-ascii?Q?emPuofhCx0luImo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:10:31.9561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31468319-5f0c-4ec1-b8dd-08dd4592a6a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
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

Add DCN3.6 asic identifiers.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_helper.c        | 2 ++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
 drivers/gpu/drm/amd/display/include/dal_types.h   | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index b402be59b2c8..8f077e15b4f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -741,6 +741,8 @@ char *dce_version_to_string(const int version)
 		return "DCN 3.5";
 	case DCN_VERSION_3_51:
 		return "DCN 3.5.1";
+	case DCN_VERSION_3_6:
+		return "DCN 3.6";
 	case DCN_VERSION_4_01:
 		return "DCN 4.0.1";
 	default:
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 4b3ccbca0da2..0787cc3904d6 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -114,6 +114,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN321,
 	DMUB_ASIC_DCN35,
 	DMUB_ASIC_DCN351,
+	DMUB_ASIC_DCN36,
 	DMUB_ASIC_DCN401,
 	DMUB_ASIC_MAX,
 };
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 090230d29df8..5fc29164e4b4 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -257,6 +257,7 @@ enum {
 #define ASICREV_IS_GC_11_0_2(eChipRev) (eChipRev >= GC_11_0_2_A0 && eChipRev < GC_11_0_3_A0)
 #define ASICREV_IS_GC_11_0_3(eChipRev) (eChipRev >= GC_11_0_3_A0 && eChipRev < GC_11_UNKNOWN)
 #define ASICREV_IS_GC_11_0_4(eChipRev) (eChipRev >= GC_11_0_4_A0 && eChipRev < GC_11_UNKNOWN)
+#define ASICREV_IS_DCN36(eChipRev) ((eChipRev) >= 0x50 && (eChipRev) < 0xC0)
 
 #define AMDGPU_FAMILY_GC_12_0_0         152 /* GC 12.0.0 */
 
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index 654387cf057f..a021d12acd74 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -63,6 +63,7 @@ enum dce_version {
 	DCN_VERSION_3_21,
 	DCN_VERSION_3_5,
 	DCN_VERSION_3_51,
+	DCN_VERSION_3_6,
 	DCN_VERSION_4_01,
 	DCN_VERSION_MAX
 };
-- 
2.37.3

