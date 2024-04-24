Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22241C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA652113919;
	Wed, 24 Apr 2024 08:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1Dm/NiM";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2451113918
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEx9M9rGr+0ZcjUSWo0KW9ExP9VpObod7WMZ1j+mokCD4PaqS9qDXCUfug0sE60zP76/M9qW4CWtlg2GnROYfa7WzGEH4zAqo53q9qVEFXnPrQ/yL9c+IrWI+JEx152eCxAtt6N64DuUbQzLgniY8badP3QL4XLAnBgPdOS0ZssCta5j2cKAgnfVs+mKWysNxkbZHdPjKFmcfXTQ86L20Fas+4kmXUi2HnS6+iF3U8y8GNSrAFgv4MBjPOnhZs9M02/GBDJC0TsEmWOr+EVn2TKMkd8/bocmj9QxnJmU1zYvCFtfGpV0D8kztVlNrpwZpFlEvfqlpxIOiByl3+Mi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaVdEJms8i+Q/VypVJfQ2ViJSvKbKSmdPV8HYJqtvFk=;
 b=ghe24AYokpk//hcv825hx2SQyBQNM5RJLfqgVqRiVsyKmKXpmrfsqKowvHPq+wwGzgEXBIVx9BdfWfV+m3r41ENyEXzKd/cn0zWHXiEumzRIgmds1EweBiDiitPQXEbtVl+zKpEozWMrZzH3rawqyu4X3iIDcOtsM1EDfRwqvkhphagYX5dMeQMgz8QX69IbpOZ2FTIT6puOB4B4jNRPSYBXQvEpb0g24qRsDxu4eEi5YQJUjB+4L9CRuOxfX7iEjCl8mHtT96L1uq0/3fcKN81lRnN3CN5GDH4Q6CIVsotKgll+rq2rl/AySM8BtylGPRMq1jsvqFYl1q8R4a+aKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaVdEJms8i+Q/VypVJfQ2ViJSvKbKSmdPV8HYJqtvFk=;
 b=v1Dm/NiM9HbaLAHHkeIbp9FNDLENg6Ij2hi7VZaweWSkkVBzCx7HU2vFbazRfkMcVoL25h4Ksomt+MkyeHhDG7N8kHSyp5xSoy5i0WbBCJwIGvINeskEexvXDs6g2atK9WTJJnlQJ+RXRb9AmzqdPgZ5dvQqRotUekdKZ3QZxiI=
Received: from PH7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:510:339::10)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:38:45 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::3) by PH7PR03CA0014.outlook.office365.com
 (2603:10b6:510:339::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Wed, 24 Apr 2024 08:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:38:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:38:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:38:43 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:38:34 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 06/46] drm/amd/display: Skip finding free audio for unknown
 engine_id
Date: Wed, 24 Apr 2024 16:31:22 +0800
Message-ID: <20240424083202.2647227-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef23f9b-834c-4f4b-bfa6-08dc6439f3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vFzXvGYCN+aR+Lu/S/0HZ8Tqz8HqEvRRa9lWzK+R3bNIQqoRjX/a1vxcX1WO?=
 =?us-ascii?Q?Ra1nBuLKcUFbIt80yrfJaxy+am7Cz1Egs1niLYXLHhY+ckRwX+YJQDpt39IR?=
 =?us-ascii?Q?tBzafbUn1HFhcZeQdpdQiVdOBkG71YJVUkLuc+9ilNXVkllOJ73OToM7vP3M?=
 =?us-ascii?Q?M9KOVm2UtcFSiBjuYlmqlqlgamXXeeLM4it4Datalr5RpPFQlosaE8XCYdFy?=
 =?us-ascii?Q?eeUz1ZkLnxi0XvYW7kn83aBVh1Cck4lV7YZD8FaxF7UJBOXUeNN63byKVqk+?=
 =?us-ascii?Q?X3KkMit+t1GB6VG/r2j+LIIl96k4sMpFu+dZk6KP0l1ZPm3EbcpiPtj2r4Sq?=
 =?us-ascii?Q?tVqMR81HrWmJ0G6B6eY74cL26ys3Q6QDu/yWVYMt+7/2udJPxBzG5M/OiuE4?=
 =?us-ascii?Q?XDWla4Vm/DfyByYNn1sCaygosdqaP84RexIkVH801EMiMcKQ1bWaIPFHq3Dc?=
 =?us-ascii?Q?dzQNYR8oS40uO53yboQbr8KZB2EX30olgN2W7qbAQ8DVxYMSiKilt4oocEqs?=
 =?us-ascii?Q?esBiS2LqI9T6teEDC1eczAsUnIcOGqtgaoHSOuerBrVrcU1hrm2EUmwOWbM8?=
 =?us-ascii?Q?ouY944F91HNOkOIF2dECyIFADKBLh8dNHe2LZscpg7qXIauL+zY5jWqhFSjV?=
 =?us-ascii?Q?HIGcIFW5TPFl652xX5CLjq3kPaG/x2iUGIVUb2Mol3nFJ/GaaYqL9PwOxe4q?=
 =?us-ascii?Q?tGPSds5YMZWsdz4jlGvyBBcGaEnk1LEZxVsX4Ze5dDCiKdtP+m1i19LMBw4S?=
 =?us-ascii?Q?EMECpYIcdlq2dwleCJerjhNvOepf5sjrhWpn1YyjXy2EPc52pcvo2zf/1a8K?=
 =?us-ascii?Q?BLqDul1Lp+kRCE2y+FLMoDkPFU2m/aC6GHKhmY6XC6f0hqeaCNJsHkeTqvVX?=
 =?us-ascii?Q?BoOkrHBjBk6dQGvzav4oYMpnaEh4OrAA6njGIxSOsdCs7958Jjk3/7jl6Gfw?=
 =?us-ascii?Q?hYmjk5GnJ4kCLj14sPES9ReNr3Z6wUl7FGYExtXMmCJ4rku05Ntjnazz2ozs?=
 =?us-ascii?Q?v2mBJtMSIsdn7QgYt2+yD/bTJSvFYiR3jGP6kdngatNqv0w/qQHbTeQw+LzJ?=
 =?us-ascii?Q?61SDK5eWD5ZVAYpqN5AScdXAlQUzTv6vGaPnJvvh6fHwDf4B9y7RWG0PmmRz?=
 =?us-ascii?Q?qsTY65/gFxux7L5l4pWATEY7+1ikdlPNdL/S0xYuRnrrOlFK8ENttIneGkFJ?=
 =?us-ascii?Q?/n30vqv+tlNMIQUZ3eP9JI35A4cVVp8kFSRwk3p4E01l8unqx1I4B4iz/b/1?=
 =?us-ascii?Q?S6dIyI7xx2UmhHR3I8EDKTpNBXtYdYF396y3UqUw2kMRGj0ZWUm43AIY8TYL?=
 =?us-ascii?Q?/aLes08RGGtyl8nNbVMWIBsmWdaRpbj5rh9mpTj9WvXbV72OawY/v5Kzzfdu?=
 =?us-ascii?Q?9UDLeigZwfteolk+poNK9vo9Jgu/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:38:44.7228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef23f9b-834c-4f4b-bfa6-08dc6439f3f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
ENGINE_ID_UNKNOWN = -1 and can not be used as an array index. Plus, it
also means it is uninitialized and does not need free audio.

[HOW]
Skip and return NULL.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fa93d6d6563d..93f05e2080f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3230,6 +3230,9 @@ static struct audio *find_first_free_audio(
 {
 	int i, available_audio_count;
 
+	if (id == ENGINE_ID_UNKNOWN)
+		return NULL;
+
 	available_audio_count = pool->audio_count;
 
 	for (i = 0; i < available_audio_count; i++) {
-- 
2.37.3

