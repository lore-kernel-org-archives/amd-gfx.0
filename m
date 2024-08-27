Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7397C5473B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F75B10E399;
	Tue, 27 Aug 2024 16:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i5dLMP8f";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B278810E396
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIAT6PVoLQvlamkLQNW6SdWQse9DAf1/cA/fiwNJsyN00LVVRykgoIwtPMIfyQhfM6/sn5fWPTPYN3A2QMGgc1wU7QWb6dlu6aUNRHgsKmDNgpCJUkIWHBZc8iDlL3WMvjI5F3Q1oXZ2N90cKYe7aVAWY8ypM2aLVmFm0aCqiIO55HKjiFFLTSaomBDEuXBFxt2znLtVZd56QR1h4IuLfWLLukaXIDZaGjvKAKZqGdS8jDt0syv0OUVXgQN69cnf1ZCM0vPN5JfnXR099CizLCy3WjKIFQH3YUVVz+MMqwSlkfnsZFW78A0bKwu2ZCV520l5YqePprDyghWGBfE4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jVcjZAAJRciPRp7EVB6/xILn2GXbPOrFsCd+UnuxwY=;
 b=C7cl8ErN3V3WgYb3+HpWMpd8r5YzaPe0yei9YEiGCRpl7yLHtrNjriQm9l6A4KU0VGm0dGThq+VM4oZOLu/7ASa3GNKbgTCgrvK1bUEq+MbLKAU1bFlpmqDUSsWvi5RzKsCDMlz6zJnSR0M+oPe3AXng7rOxvKPR9JN79ZEP+zX52Fn3OhY0ss+beCVSpfBF8Ckd7MHUQq3sEoVRga1W08yoMgMTzdMxsCEEiOu/ixt9Jx28S7HaMDs1v9gsFEHGUThdV1D8G5lCerVXZoCqO09XZM4Ie3BmICI/pux2mbnXIvQa4l3i7vjvyGLHyREewaguRelI6XouwemxEMi+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jVcjZAAJRciPRp7EVB6/xILn2GXbPOrFsCd+UnuxwY=;
 b=i5dLMP8fl1QcU9WrLt4O0UHeP158Q6ylXUZPUgeDHPAowY6ttpONpjSPtQb30lSyvmPGHT0RVYCsfLMQVGn/+6d+z/CVSY9VYKew8s+D80dias1aCThICtxTYFQkakTcbZih+J9HdBUnVn4wx3GEf0couvTLPXZ1NG2YBQpFAHA=
Received: from BN9PR03CA0694.namprd03.prod.outlook.com (2603:10b6:408:ef::9)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:41:20 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::2b) by BN9PR03CA0694.outlook.office365.com
 (2603:10b6:408:ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:19 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:17 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 14/14] drm/amd/display: 3.2.299
Date: Tue, 27 Aug 2024 12:37:34 -0400
Message-ID: <20240827164045.167557-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 01554f1b-8a53-4131-14f1-08dcc6b71403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I9aTyYgkcZuaDb6qdFq7UDszpRmSmA1+7OnD+UAfhq+uzRr1/+osOeA/4uoX?=
 =?us-ascii?Q?zVtyr9UH08Pmq3nsgbowgC5Iry5o32v03R/8txtjtIxwTPhCPSu74HTRnJYI?=
 =?us-ascii?Q?uNEr8k9u/BwBf2ficJ/YYuxHEkwsHPCugPbSNSzzRbwl2Qdq0bDFSlJea/kx?=
 =?us-ascii?Q?d6m4SSm1NwQd3OCxUJrJd2K6qNBIqhDJPpy5KpQGwYNYRQSBHuU4jevN39GU?=
 =?us-ascii?Q?bfGgT1uLiR1NUH/t+1SBUgl4f6OrlSoZVK58Yxu9W1V+7mmUKwnVOZw6DtkX?=
 =?us-ascii?Q?lMqTy/ccLUWd20bSskuug6jlDfYQztgijW5v8SXTecNw1r6v3NGM8FElgf5H?=
 =?us-ascii?Q?Jq9WZ6iL185w+5NyDsWkG8kKnSmF3KrbouIzEItBHM8c+L0vmxJ70iEFAC8K?=
 =?us-ascii?Q?LSKJ91ZI4fTvCtnzC5eAiLvwEra/nmflTSHzKkCkMdQ0JMWNjl+YM7AfnaDH?=
 =?us-ascii?Q?2/GQh9VTHZkUwQdet6kKhRVq0ulvzZAOBNmlLibYfAZivk5wGPh42WJrEimT?=
 =?us-ascii?Q?LFnxBB9Fn5T6IOrUioo3UN3HOw4jhYZ1FlD1pjCiD5udCX2ieZY0KO96CO66?=
 =?us-ascii?Q?HP4O8cO8gQzka+T+GjeDw19bJFviYTCrN2T1t0ujB43RGvAtv7a+SXA+Xb3P?=
 =?us-ascii?Q?bwemrnYy0P3Re/9KXL0Ay+4cw6uMMxCJNQcvZ86b5asf1Am76LODcmy7bmyd?=
 =?us-ascii?Q?m7S53nb8YXbbICA6JFW26Q4DkvoDYyCYVHdqkadzVpBqD3r5Gd6qYeB6Jf+a?=
 =?us-ascii?Q?JKGAjn6JmrRrJZzTUNJZJEB9o2uXsLxZcLAc+ekGkzZlHcomKfEfM8tbgg16?=
 =?us-ascii?Q?WiZAeN2DS4U9cREyYiKTFTtyeCukW35y7x6JwH81etmX8UjP0nNHRknLB3XJ?=
 =?us-ascii?Q?Ffzy7nSGRVfNL59voxiWvYgp6gpf57qH/Yx5Qak5VcjvbVDG6XYu/+eLujJU?=
 =?us-ascii?Q?+p4J8NJ9BPfPdTbLj2257YPfBclXTawEtANp4N7zYtQlEYqXGJJSMSC3S9GB?=
 =?us-ascii?Q?d+k+XDsPh+bS/E6S2ULbZ45ol62WLyTUaIuIlS1yLMDZ0unkgdCBSsCYt1ya?=
 =?us-ascii?Q?0RK8q2e9KJEYGPmQryT30Aj0FJOQGjL2TiHTmrteziJCBKggEOxT+NYddgjD?=
 =?us-ascii?Q?6uvcs7ISRd6ioc/ioZv94IGN2THXQVbqXg8L8/wtOHJkPrFU1wneXg7YvmFy?=
 =?us-ascii?Q?mfVKMwg1OT4ToMtryE/uF4XEURIp0d4UozQAktT49lhjHaEYko49gyHgeDH1?=
 =?us-ascii?Q?Bbu0dUwNCDmKNzv/rRgL8+mQq1suF+6vEqqnNuLxPeCzaTtRg02ihip6XGF8?=
 =?us-ascii?Q?DZ5/Wr8eevHbbZoJC/N3Vyva9Kmtax8MKcWkw4QOGdJsMs9VwlJUgfJWv3QM?=
 =?us-ascii?Q?AX8qMerj/zcay6BgmzIgELhGx4TLpNCHRaJ8znJ0Uw155elD9RvaNLHhJFeZ?=
 =?us-ascii?Q?iosseqTka43V1MzX0/eXvSt7cQXyhhm3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:19.6046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01554f1b-8a53-4131-14f1-08dcc6b71403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- DCN35 fixes
- DML2 fixes
- IPS fixes
- ODM fixes
- Miscellaneous cleanups
- MST fixes
- SPL fixes

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h             | 2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1a907ff82336..4c94dd38be4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.298"
+#define DC_VER "3.2.299"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f5dda1d69ae0..e20c220aa8b4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -111,7 +111,7 @@
 #define DMUB_MAX_PHANTOM_PLANES ((DMUB_MAX_PLANES) / 2)
 
 /* Trace buffer offset for entry */
-#define TRACE_BUFFER_ENTRY_OFFSET  16
+#define TRACE_BUFFER_ENTRY_OFFSET 16
 
 /**
  * Maximum number of dirty rects supported by FW.
-- 
2.46.0

