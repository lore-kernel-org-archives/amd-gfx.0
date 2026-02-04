Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F1DE8B39B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA06710E53F;
	Wed,  4 Feb 2026 04:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QHBf/TRX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4989D10E53D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDWhs1RlWmaIulA4UTgMcNnlEsW3QmHi1AbPbkax9XPvzPK15dQZwANdkOmIqx84sCuZrzLbeDyeBWEj4+sY0IgwWmN/zKLddVt62khxO/SazJZVntNEe852Z7x1vTe6gG/3jeBRgbcnd1ev/9/GI/4c0zVGbe7Nv1V5zHbt2im2EoAuwr6cBn6DlXAWzMvTH2ofEKTQ+hJNjovdTuSqLVGPkKWN4Aglo5q9ZLYyvU9/vYMF1ZtqYlmi14jjatCcPlgJEiqiTXHi/kjqDdH/XdmmpOvjgdFv3WikMTLnWiqOfogctznEOCGzFwZElrywercMyhjVDX2MR58jIwkMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE6V2i1SLZ/lzAmFaSCAoNroguR1rXN95dDE/9Nz8BI=;
 b=VEa+Hc8IXWeXow0NeJ6X7u9FwedxGv603g7e11mKgwzdMvdGLxd2+gKGQcq7xn7v5ez9uV26WVBXvgSrRjE56kagXn+vtJ18rf7rhFqdeynzMHNc76v4zmxAdvxe360s9FeCvgynC8N06pkuNgHtNIIEKSRScnIR3ux0QaqOMA2uMFkoiN0yGrxvHQiaN/9ZblroC4avC4lxMpVXEgchOlt8fP+G0Ush8aU6iowM2WvkIDzSLCrEfnIwWXG1/SiE8NUmIKN0ymSYlg/Imc5KSfR2Use0k7C3BQSdieVBqrZzzqSAYdqHmM2cIj8JGvdm70eU9JB5j5fXsoVN/gRLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE6V2i1SLZ/lzAmFaSCAoNroguR1rXN95dDE/9Nz8BI=;
 b=QHBf/TRXp7xbpRslJ+pJddOuoZQcNlTTme1sPRdQpbgL+MMvK7D/Rm0NR4iImICBLBO8vNWmERn0Q6BDQLHVqgZNzxDx9f1g15dZiQxToy3dlprI2aKiZsdK6AbJVfJC3Liin5emVUSTxakK3XkJj2O0EyAHcOB92zVcrbAm4SE=
Received: from BN0PR04CA0131.namprd04.prod.outlook.com (2603:10b6:408:ed::16)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Wed, 4 Feb
 2026 04:44:14 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::76) by BN0PR04CA0131.outlook.office365.com
 (2603:10b6:408:ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:14 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:44:11 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 11/11] drm/amd/smu: Fix User mode stable P-states SMU15
Date: Wed, 4 Feb 2026 04:43:38 +0000
Message-ID: <20260204044338.96093-11-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 98dbe263-6c4f-43ce-01ae-08de63a80c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w0pJGezL5pXs5cOqmnpB+v3FLpZT/cAoLnHjaswnc/fz8BVPYycJ6xlZMb3H?=
 =?us-ascii?Q?Cw1CzUffHUUdbJ1ly0B9YvkRAfLenraPIWI7EG2MfStWzymXIVgOXwiTCxdc?=
 =?us-ascii?Q?qhhRrcGun3HFQ/b6RrlHPtr+X1e/2Iy8wp9/2l7Pp8f3Z7VYDDQ1s2d7pFz/?=
 =?us-ascii?Q?thlohHINXKgd5owFVbC2Uo0YOoOboYTkzv4CDc5Dvq+wv1j8Ba3WNzFL6pti?=
 =?us-ascii?Q?TiW0xADqYKeGXvwLCMbgfLWfR+ISc2cNZn4LBvj0VCPhwrQaG3k1x9EH/EJA?=
 =?us-ascii?Q?7uQIhAsdJqP+MxlIBaRxm1Y67j7WzWliqHnY46hRkJy/1MlUhsmuGq2EG//F?=
 =?us-ascii?Q?2sM39cdgrTQV/r1i6cEQdTeD/2CDGZ8g64wCoQQsTY8kMSDmzkiFhEJqKJfc?=
 =?us-ascii?Q?pDkB3F+BsoC8kscfnUTeP+1gcjRsA2NYxAt2sQUC6JN0m2ZpR5FhqFWT9/du?=
 =?us-ascii?Q?p9ZonfmVMYymMLNugOkRiYMkkf0s0w3PkjHJWr/SlYLqBFizacUAG4DLRAsY?=
 =?us-ascii?Q?XLhrDCJLJT8Ve//TIL0z/ivG8uls6fyBKIy3IxZDzjvpJJVEo/VNAhlL9w2y?=
 =?us-ascii?Q?Ur2XvG6l+ERJ/7vc5kz1rjKK/aa80Jn/6ZTtF5gucm1H0AgkJ5NeiTctEk2E?=
 =?us-ascii?Q?0ddS12XvVWNqIpS2rtfp/5c55jHrhJ6+i5oJ9548DIPtlowck6TCSwFcw/f2?=
 =?us-ascii?Q?guU50rCKqSwB8n3K/umspkZVlQQcpyjiftHHj5gAja2gTmz9Jn13YKz0hiHy?=
 =?us-ascii?Q?kyn2Bo0ov8y3VHnHq5xQazdUoYTUTIZqEpGNpad4JeCPW9e/0Cn8FKIOHhzV?=
 =?us-ascii?Q?3FpDTJUS/umYX4u2HZKcQ/hfKkQQLkdf4lVHajHJFYxkPlvd6lFPzVlJVX7s?=
 =?us-ascii?Q?dT2+KkCvDY7Vx1pUgsXwemc+RYxN8hPlNjc1gaQ1QZ2PzUQ5SR7EnkX4dwgy?=
 =?us-ascii?Q?ikkbEeW3KdcqJ/9z+BNsEPPtolYFgXKF70fiEHFWIlJ/mlI9NOQ1JMZUnCBB?=
 =?us-ascii?Q?Y24omQ2t1CebcEZQJOsgBHYJaejq/T6fkQCvuiP6WqvIzf/9Z5aZ55X3wLKY?=
 =?us-ascii?Q?1QOv9/aEw2OWDtoJyyijvuyE4Lv+v5Oj9Qd+7KGVx5crjyzjvd3mKUFRQY7S?=
 =?us-ascii?Q?JtfB6G1jECQ/vooqczg6IvKlSXlWgxnNfz6ef2lChrYBlOuG6qbYI10xpb+r?=
 =?us-ascii?Q?caluwVyYz3Ifh2EPTOJ4OkeijCHjHywPFyaarTcR8Z/shfFNFW1nunJd1/RF?=
 =?us-ascii?Q?5TCtWGX2ru+aqV1jdotQFmvLS933oZQI6Gr1e5lGUu4uHTiLJL8CzHZ0Ni/b?=
 =?us-ascii?Q?ko1OkyeWj+lhHCU2RObTjfb3uP0FdARNDPE9/jivXp6c1yfOc7v1i+E0F9o/?=
 =?us-ascii?Q?ksNNyym97tR4hz9G6n4E3Q7GDT7smHJkAdJmknd2flGU050sOsS/nHCZPfG4?=
 =?us-ascii?Q?QbaINSL+V9p4wvsK0gYna+RO85d3+6c0uvwddB5aeVHqf15p5afsrjAY1DMy?=
 =?us-ascii?Q?1QEU4vWxLXgnxEaP8etVQUHB8WAUHG9ClwDbMMMtoyh/++pkNmJP4UcbvU7f?=
 =?us-ascii?Q?fGYajKH3B7PFpld2sveNzOjEJ5P85TFHkQrAgsSldMzKsbmsD27mhXQ6XiD9?=
 =?us-ascii?Q?CBIYoGM6JVBHKw5j72O40Hm2Wp5pmIy37jl7bsCjdE15dsn3vkaFL4GHGB3P?=
 =?us-ascii?Q?hiw4lQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MRqR4J3h3V9iF80LODN1QT2Frud/6mP2udURrYvDCfpUhP+XqjD0MavZUGON0wb9tD95IWuCIPgPBGyoAwTKELpWnvYo0W9eBxNIAq7HSqaFgJfbY0XnPgryaW8HuMt3/Zb2gh5aXBKPbwNCiDSt7eNnsfgXxNJV9Tp45dL6cN+AMJzaV8jgatbcHclOGyDTg+I4s/h+X158ltB35prRru3ukVyeJ9yh0V1grwnFNFSVz+V3fV0JzcPEs7oPheVPn6xlu7MHUDFOE5bAmbnwMsRvXwQoF9OhZC1IVhNc/ep8VnSWopR3qDO+Pn2spThnqj0DdrMY1g8c5Am89kr9IbZ2VZcIVbtubWtkUBlaPObdFKooPj8Ouy+VTdxkKi9SXLVgkVr7COcAmwDL9XxP/O/kMsUmFVpSThUrguOwqM+/MxBOobK/rg2zSfBq42QZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:14.3745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dbe263-6c4f-43ce-01ae-08de63a80c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
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

SMU 15_0_0 exports only soft limits for CLKs
Use correct messages

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 140e5b8c0489..8e6b7574d159 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1033,26 +1033,21 @@ static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_min = SMU_MSG_SetSoftMinGfxclk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinFclk;
 		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
 		break;
 	case SMU_SOCCLK:
-		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinSocclkByFreq;
 		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
-		msg_set_min = SMU_MSG_SetHardMinVcn0;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
-		break;
-	case SMU_VCLK1:
-	case SMU_DCLK1:
-		msg_set_min = SMU_MSG_SetHardMinVcn1;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
+		msg_set_min = SMU_MSG_SetSoftMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0

