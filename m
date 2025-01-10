Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF74E7719C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 20:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0F610F185;
	Fri, 10 Jan 2025 20:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eCdyDrXA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB1110F185
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 20:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJkYHLDLC91T2046/t6RLRXIqzojfuzHmGNZd/KJoxEo8imuqLJPqB7W+doWBRnDGNYOMViMzPIZMss3NsUeDDgzaxz1F4zneuGp+d87IZf1LiPWav+6YscjHPLaS9yrUO8Nie8bY+4sV818Pe4pXFMDmMOdW0dFwc8Ev2qOQtm3p6JmZSf6VqendvdnFzWPBaGNj1LTyT2yVZubwDtsZ3f0ijjFY0CA8d/Ae5pA59xSyLkN/IRIrzLe8uv43ExYKWIN1IXhOhCFZdDtZ1lYd6TeHIFGYFslNgVija8TtKPQ4Y/tDyjrl82op5GqbDg1lCuBYEiaLexB6lFfRsqNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLrcXjfTWQO2G7CNuHeu/sYNNfVGWfdjCyD6B5txNR4=;
 b=vLLAE9+900tJOAvyX8awF01JjC2rauxtmC5b9wIS8c4d0r5gRE9pxdAfzTVzQc7j7o4PsMrRTQdw/zUccYbN8+ji3LKv4VilvPpb1t3YFfWoTCxYZ5yZJoy99PPmbz6mcUiJF+9SVAofJzFfMJhBTTrNnr2CN2hm4jo5PUACd7H6RPQIxh3FOjmaORBanAe8yDV7ltpZjprFR9V7mr1BKPWSFNaZ/HgTV3qSB+14V3HeEhB0/B8dTjURzD+LrQCjTn0BSwvtDwaPThIEgLjSf2M9d8b1KK6sP16A1CQav6+Z4rQbz522YJpS69FihJ0M+35MvGVPEFRHg9yuPNoIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLrcXjfTWQO2G7CNuHeu/sYNNfVGWfdjCyD6B5txNR4=;
 b=eCdyDrXAoVM/cvzwTrfW7ybvs9T2hQnICBI8Osgeej0J4twfhQgn93cNVG7fWD1CpCvoPnzlA71oaK8Fj8Cb1+33yZ7I/rdg5qOoOXgwBl+IN0CMZfZgFL9Wuap21KU+c/FC+SMw6h7b7C7gqZg3Kz3ne0KLPsFQ/EARCBdH9PE=
Received: from BYAPR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:e0::46)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 20:17:32 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::57) by BYAPR05CA0105.outlook.office365.com
 (2603:10b6:a03:e0::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.6 via Frontend Transport; Fri,
 10 Jan 2025 20:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 20:17:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 14:17:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Populate pmfw version for SMU v13.0.12
Date: Fri, 10 Jan 2025 15:17:15 -0500
Message-ID: <20250110201715.3828934-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110201715.3828934-1-alexander.deucher@amd.com>
References: <20250110201715.3828934-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: fa45f612-ae2d-49f8-9441-08dd31b3d06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?12yh+/1aRkqeNQY9b5Vee+TcZMYjnPhigaSUSEEYAp28JQlXOL8+1BgkJ4bI?=
 =?us-ascii?Q?AtDitzsokgo1I3S4/FObI2SDreYA+ar9R+orBKGk6M1gLYP5vDxIAf7X1Q/t?=
 =?us-ascii?Q?8PRZoamaPaDlb+a9CcUjFQqHpWQpag7ACfymnkQUQ8mGjH9b6KyTZsCg5a13?=
 =?us-ascii?Q?VPdkObPqApEd7bJpHNEqIlb3Qt9jwlTMeUZUTd/IgKWVEXKBBJJEH4PZ7ysv?=
 =?us-ascii?Q?wXqYoSwuq+KOrRYR+f/uxz0r/+2stSPqCBaVc5bnlhWHMWcnTlPmrS07gzBL?=
 =?us-ascii?Q?WYfpubSD9jWMOqXOV8r/rZ7trnw5UR7ypEydu1OtcoR/e9gYHXosk2HmWWmK?=
 =?us-ascii?Q?ZW4lofQhzTvibNoTHNoUoLlfUhA3LH5OYp0hpHHChdjGxcV55c+8qGKWM74x?=
 =?us-ascii?Q?ddE0F65snTyv1wGNHXksziuIR3C98UGx8bn6qFBIs1MbbqJvIYibL4zNl+q6?=
 =?us-ascii?Q?b/o3haykX74Uaum1djUVxEoXcYrsoeJvYjxkQ6FW6wdY/x0wlMjVyR+M9GCy?=
 =?us-ascii?Q?iaN68EB878QObnCvp3apvfwqan6/MXjeHzvHkYSCOU6n0NkqIf9ErXgghZ5t?=
 =?us-ascii?Q?pHsmJQIlnRvepMCUhywtFCeaTp5k99WRcz4RpxVsrA/x3VTm86WQPO/QTA3M?=
 =?us-ascii?Q?F5U9qeX6pn2rtsSMd3TVTBzezcxYwx+8SlP/npDvuzQy85Zdfx/qIdzWjt2f?=
 =?us-ascii?Q?GKMEMfLlExoJHzBkyfEQqUDlbAI12FCcYCxwjUaJAmlq84QqGjTXIU3pk5IU?=
 =?us-ascii?Q?zQ3k1GAELNL4wosCWMsdxiZ5cer3HhWtPmzYTkQ+L1QI2j//XHZvDPYRIkSh?=
 =?us-ascii?Q?tVgsH9CAE2EmVPoAg1d2i4ISmTnVaz4Z7wTc+/bUW1llpHPK+y+tt5vsMBkL?=
 =?us-ascii?Q?e7M/dHVa+viN88v6VBwegPJx+phe04EvaAaF3+GMe28QSwB3NCXBlWyg/s2S?=
 =?us-ascii?Q?9fY8FHMWfClm3NTfigP/1/wXxwtlbCietL8TTlyej9JJJuH/gHP8jXJaxXF5?=
 =?us-ascii?Q?I8+ir8Yn0jXXvlNPboktMI2S+0SiMnZqpmgT+odSHM+sYLTIWs1KvPmglna0?=
 =?us-ascii?Q?vujMBnBgIq0uszbReQXzn9PZbCQo7gxiVlZXUT4x04HblsIKyA5N8GZNmFju?=
 =?us-ascii?Q?rkL+O2ApiUorQUhRYXmcHJPmbW8aykhlz7Td+Z6epBv+qxNtlrW9BIKV4YLW?=
 =?us-ascii?Q?jwwEAsEPg5QVSd7Hq+IfBg1SVIPx5ZBj5tK8jkcwoEzLU+GH89mQ4sm/rblF?=
 =?us-ascii?Q?3lexwwqfFG7qYe+OXf/EXg0Yp57+8oDTIECG0ODb8wbeOEFaLcAMzpXUpjMA?=
 =?us-ascii?Q?kYocONq7kitaKhLrqVEnGymmG6qMnd34yHbG88old4MQrZGkWui2LS7VnyNF?=
 =?us-ascii?Q?/by2J1NxaO+ZgfQ57gbBGCQmd7fkQSLMy6mHcD9+sJlJGdfJij6tfhrNE0G9?=
 =?us-ascii?Q?MbW40EnnfYt1KD0x3Z1d4whD6k8CC4dqudEJdLkev+lOfusgGECDiOBU9JcB?=
 =?us-ascii?Q?UmaFbuJYo2kOang=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:17:32.0599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa45f612-ae2d-49f8-9441-08dd31b3d06c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
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

From: Asad Kamal <asad.kamal@amd.com>

Populate pmfw version for SMU v13.0.12 to device struct

v2: Remove ip version check to get smu version

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index fbbdfa54f6a20..0915d6377613b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -267,10 +267,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	smu_major = (smu_version >> 16) & 0xff;
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
-	if (smu->is_apu ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6) ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
-		adev->pm.fw_version = smu_version;
+	adev->pm.fw_version = smu_version;
 
 	/* only for dGPU w/ SMU13*/
 	if (adev->pm.fw)
-- 
2.47.1

