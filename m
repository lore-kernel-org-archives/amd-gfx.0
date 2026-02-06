Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37438EE20A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C8910E71F;
	Fri,  6 Feb 2026 13:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bzdLkSgN";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF0D10E70C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIlgAD/4cKIx1IGNOTT0WDTzsmssbEZsXap21deUuCgyBwDeoU6JgxV1RFa/6/9G2rNz4CUsh/Pb+Uj0gpnR5WXzL1SE/TzpBZ2WtVr53z3ZcgCrzM4RxGBSaa8FSCGDJRUzJiFAljIfzNgehSbvv8QO7UKSiyzpkzQjgJDgMmD0NioxvmBqrXOcnkUVNsvpjPeWMFQJAA2WkBfsoNXls9w2xaHLaXk1y+LWWpXYoGh4LlAb2lG5BpbsI0KI/oDJSGp+/Loe4K3GeSuxY/BSThO36EifbtT8YIgXUb/JY7V+IBs6evWWthiJyD56mwgTGNjXM3cTdJ6/BSERBSCw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1s2zzKuPQYxmbxF4WIUkvvdhLvvaAqHqo5XfTcsUk0=;
 b=IFFSZkvo48Fe7HsiPW8QlAX+BxzOperK0KRW7RKwKjJkEu01WeMqbEZjjSTpxvrmXaGIWx53EVgF/VDJF/Lz7KbeWyCXWXTarEOnpe27+sIPAW4r4Ldt1N9P4sqmJrvb3oREDOO7LTUsRkN+J0jAeSDk8LlEsVK1BU0HmUHMNrBTky6vCoWyLUj3rPxSfX7ePVW7OA01XUN0u/xub/rgCE3og+gJqtBh1SLOy8NJrahMqgbdVfVYxipVkYPX+98PdDk0GKmg1Cutu2MLm2wwrtokk/O7sb0NbLVpgUrRQ9H3v7q3WimJEKfGdqRgul0M5S8B6EJUQBR+E2umh1x6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1s2zzKuPQYxmbxF4WIUkvvdhLvvaAqHqo5XfTcsUk0=;
 b=bzdLkSgNupuj6M+dTDhUcd6IVD8AHW1EjEVnqHUrYni95ewzdOTXpNgMjMi5rcRYutG95vbGetWnVjDShd5FeQAvBSnVUBK9tIyMKypLCTv1CMvoPzHz4wNpKy/ZbVZsBRH6XWlp5z/6LK2df7TGWtHwvj9/O/DXJOHZRtxfCwU=
Received: from SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::27)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 13:36:30 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::37) by SN7P222CA0018.outlook.office365.com
 (2603:10b6:806:124::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:30 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:28 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v4 05/11] drm/amdgpu: Fix set_default_dpm_tables
Date: Fri, 6 Feb 2026 13:36:01 +0000
Message-ID: <20260206133607.91047-5-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee0e06b-7f22-4c91-909c-08de6584bc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7zi6a+BmMhulaXDcocZWU8M61TZtuCaM5oT3cMQNLf2Ko2lLFQt2NC2x+8XS?=
 =?us-ascii?Q?/NM3FZPAva4vPujFsFHoIWqrpvoz0u+sf+gCyOHXAfZVIFEqZGSFo7iqtuzs?=
 =?us-ascii?Q?OW6oGoiQhKFfHDLRBDtMN8ndmopOy0AQIygnDOLdf82qIyuaNQa/h+m4mwdE?=
 =?us-ascii?Q?idCggfZN129R6FOk8UUykxmBrwBjy3W+WWk8tD9PHfuMHrwXE1TTL0dndQQL?=
 =?us-ascii?Q?CRLWCP4MoKDz9TouB6I9C+uZT+Hj/pYR3A2UlSYGOHc7N0hi5dAznFlCECmi?=
 =?us-ascii?Q?6+DuwQ5XEd+O4LGgJsL4iKsfcs0GCfLtLKcNxGsB6+UsJAo2ewyLl0Y4S1QJ?=
 =?us-ascii?Q?xMAunV7NHYHjTW9wkSU2j1eIRvBi6SSi5WZDdYo60NEsDjDhVcgxbCTp3lG7?=
 =?us-ascii?Q?D1pk+03zIGcHIZE3KzEkbz6TuN5a6mvMhLfmY3d6aKGHkQzgTMh5S4l5Etv0?=
 =?us-ascii?Q?ryeY1u/TEmaCl4FtTLjCzqm2GBHx6+zoyJhtWMxESzMU/10SAEBpB8eOGFzw?=
 =?us-ascii?Q?BeqE99J4ylsHJQljwopF1ajWpcLKqVP1Ht/udMxC+iO70dJicICm+S95IbVf?=
 =?us-ascii?Q?GvmQ2Fu3R9X3R1wAzdhM3KWSqDKpl4levhNv8U36/2pG7f7lg+AiiBmgOmGS?=
 =?us-ascii?Q?hbma6R/cegOPtVi1MaIzYrgK6mVcG+ueBsnlnlbd7uYpepcKqYR+8IlBQ56r?=
 =?us-ascii?Q?RZvbpYvy2LBZNybx3U+TzoEMG+5/xd1FId1XopQjXKfAKoTujVbdJxrpSCFl?=
 =?us-ascii?Q?gcp4Ro6GpyCX0KstQhK0/ZZe1BscCdUZ26tb202fQ+T5Bq64fsxyCwsRIsce?=
 =?us-ascii?Q?pu1I5QuxY1WQHG0DWxzMOwdgUzcKEVtn/Vd3rvm3Zjv3exOLO6A5AJHGMv0z?=
 =?us-ascii?Q?eJUfM8cL9Om5DeDNkCff79kkey3+HBWtBnxxrjkeUM8hm/Y9hjjIbodB/wvc?=
 =?us-ascii?Q?FV5p3XCMM11X5QtSLGwe6C+Cckzeeb9+jitfuSyv6CkItMAdN1GqRxpaM0SV?=
 =?us-ascii?Q?a1qDmqW48PonIghW0jQxBjwvXVx7LJ8nTStiCXVj6LIGnZZODd6Ujdv5ngb1?=
 =?us-ascii?Q?Jehz7adfCp8HGGcVh/gEXu56XhqNvhaCdTEI5TDOWbrDuDt45YexA+zmn1Rd?=
 =?us-ascii?Q?jftaN2WEfpuOK3JaSJbxsa98I6dhq6xupuX431QpMxGWGi5FlPPU4psGDIfa?=
 =?us-ascii?Q?iY/55ByXmk2HozlnFCVnYveiA1l8qp9sx8yJ1IxnSxEOtNOoOZSNgn9eVYuw?=
 =?us-ascii?Q?vWDQITg1U5+3UCgm8k0AKBBfDvwQ4J2vzpyotR3GavSB/7a8ZnRow91+VkUH?=
 =?us-ascii?Q?vOtGvdqXW/0jP8W5Fbpso0SZ5O+qVTvBB2j6VhIh/qERpTT+WuvLiVw9Yfoo?=
 =?us-ascii?Q?Gfi/rbw5oI9XgtPSFAquKlmxrW/00SxK5kHcy9sNvziYTk2nHorx7i3zfzvU?=
 =?us-ascii?Q?dV9WuSNIauUwG7fXN8trengGB9it62BynQ1gUTO9UuM7YOAdb676S7gGiGn3?=
 =?us-ascii?Q?HUeePz7AMUYUN5BoqIPgv1x9ABzR1ijSEsKAdtxJe5+mGEwgT1j86ZEOhQJc?=
 =?us-ascii?Q?H37mkoIAoVoI73pY6N67axth+hK+9e4dX1BXMwbRA7/V/Q+pXPn2fTt+TU+D?=
 =?us-ascii?Q?d2ouuAbFbOPH9zRUV1lzKMiP6D88x8OL23lzPHPHOtwCLsAYz/OEpvZ4+XV4?=
 =?us-ascii?Q?uK6fdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WDOxduHos8jRm5EFzPS0gCYZIpS6zQkb+23+EWVPKl3sYDRnkVBOIHOQNYaU0pxtWdTuqd8QJzgNwHkSnVl/ynJhpFNQ/G2MXwPiXDRVsCzx+xfPKZkVtiUUTP29NMgo4BbORXPUb3cdsDrjsxtyFtizEgKlTXPS0NTX53PGyIyMNIi+JXbzzvtXGZwAG0oYBUNjaTvh5clnGblcUBhIUHtHpfasA+4hE+1hSiTRtJKFDd8wuH9pTRH0DeEM6hyv5A9WAQtjiI1NrpN/7DHN8j7aHCLN9xAniSaejTQQ8u5MtCsCCXdjIsNF4GQDfztPJaT+MaKYPd499uS5HgJMyP6qRSBb2Gl4TUNT13qvyJPWRkHDBTSP592KsqCMw0F/gP+F0+sY8WSCVDEx1I6bd1r01WDBgy4aNY1tWVq6fhVUenubSgsr6ng2UxmC+eYn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:30.5148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee0e06b-7f22-4c91-909c-08de6584bc80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
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

Use smu_v15_0_0_update_table instead of common api

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 7ab6cf2367df..f5902319c056 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1791,7 +1791,7 @@ int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
 				    smu_table->clocks_table, false);
 }
 
-- 
2.43.0

