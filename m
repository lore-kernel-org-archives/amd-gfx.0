Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8007C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 14:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DBF10FD06;
	Tue, 30 Apr 2024 14:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nBqTvio";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3990510FD06
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 14:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM6thq+bCj6Gp0aVhySKgWstcPZUwt89P+R7DtgOllILaTFufKwTuOQAEUCCTekOMQhz1UmQoVpzCbllZewo+HDy7VTuS3dMByLSu4wTGOCCqAn3l+Li2nCFsk+cmryjWGb6SuU55YyKnZvS82EQM+sHLD8VeYsUdZvKO3h58pSPtD4xrDAOYfHOSubKgUqPLKBczJJJpEUbCC07wLazLe8nhGdlSqMEZU92gAusMfPhr2X4tov52F73zQre40rVDTn4ygJo4HU+iXKtHJno+JFEg/Ln7IGAoGZNUAZEc9V1z+FVwhFfHM5UW/XLJWNcfLE6j6vB3Ie9ko8jfQO/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFa1pCX289kF/Y5PCRDNfRmnnkyvYU5BVq9oAe7x9uo=;
 b=FrcHBhkhDtPDu39CBCksCgs1mEKIecBXJIrE4PikhuF52KKsiW/LwjAUR9vjbmAa3k+tNx8xvgcz4FRIm24kD9y1nEr/OT2VKWc+GQoMTJMaulkpz2drRwwImLIVutCOg8mhQE79DbNpaDHG+N451Ah/2lgJHWVg2HNuD5IX78nI03r4qkazWqAiHt7flDK3dHdhuZqetliyp/6AGh5x055tZ4urpIqHLZgB410Q+AJuA6zy8a2mozQ1gsW66Syg1XDaQbAiNw6YilhrI4nSBBZu60+V6RqmyoNaKAL4fjOlyd5Kskmb2Y5nI2lGzhagJ6mGE0p1BrkGHM2Aqq3Nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFa1pCX289kF/Y5PCRDNfRmnnkyvYU5BVq9oAe7x9uo=;
 b=3nBqTvioDT6M+/2wZru5ENbVrZ8NTMQCOQjlz3uZRtvk0smCJ2LUAnC7XkJPEgTeDwIVZQZeZ0K0HstGGC6yqb8q0/6OAd/yiPtAhPEwKBq+e+CZ9kS6U/6sKfgCGVPprTP/3xvXk/8Zp07i46e7HkGcCCVF7ewkRGct9wQ0DsY=
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 14:24:15 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:32b:cafe::52) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Tue, 30 Apr 2024 14:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Tue, 30 Apr 2024 14:24:15 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 09:24:14 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <lijo.lazar@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: avoid reading vf2pf info size from FB
Date: Tue, 30 Apr 2024 10:23:56 -0400
Message-ID: <20240430142356.23489-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a5dd13-99c6-4e11-9cbb-08dc692136aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TFwV8KJbgoRvkhK1sPnccttFeppexn4IByhVrMcFBsZanXBgt/w+WaWv6nAX?=
 =?us-ascii?Q?hgE1/XJ6Rl84aBW7oK5GPBGDc9N7kiS3mHm4FHH/3fWkIG6w7WGvB/mUZwU5?=
 =?us-ascii?Q?sYVjSXVjOO5SnRG9gph0ExvYQLIHGp2post1t1ZiLYSjTSjtTkqnFJdybxDQ?=
 =?us-ascii?Q?LZ2eACyX53KJ/SEwG10V4EluXl0o9sAnoF38iBtmYYrm8X3gBDnbyz61y26D?=
 =?us-ascii?Q?sotWhtO8CLWeh22xRGRdVXRnLXQ3tXbDJTBkwDRepUvKpth5AYlgkxXWN376?=
 =?us-ascii?Q?TTQz+WHeHMD2h6SnkX0q39jg1bY7FpNyHlY0okm50SI5aA4BnsjYWH1EC62j?=
 =?us-ascii?Q?e/Gn/+45uBfFyc0xCFwhMcxyOYr/IlAu8/oPbZvj8mCejVoN1na1erlLH9Xw?=
 =?us-ascii?Q?urUr8r4p9yt3YhStL0ajaTLTiubTEBNzeBhpOMXCl82/rJLuatqkHqe0QFOU?=
 =?us-ascii?Q?CqBEQKASxuAv+pknqQsyrnVkSUrpgloYHnbyVKKl+1BHJ9NxL/RIARym2lVs?=
 =?us-ascii?Q?dXu4Z/pgkkDTIlaRvQlz4Y+T5aDgUOTivwjOKCTYzE46moZxcWx8KUoe4kPN?=
 =?us-ascii?Q?+6cud4oolbQkSE27BltLxOgQ2xJ8LHuJ4+BKPjtTpGTmwkv2xkWhr8CFemKI?=
 =?us-ascii?Q?WZ6E+bqXLgqxa40voYiLtoWY4Q3JOYa3V/ZoWSrKNzbFKpa+DzHkRp4szjYf?=
 =?us-ascii?Q?Q4wCWbh9ZnWt47ItJoF+XPSITxHAaEUyjkih6UTNatnOT4BfynPHhPlXgO8l?=
 =?us-ascii?Q?FBUAwCRRt1EkFWNC2I6GP6odcgIfxcqCH1oM6XKOjyTdGZfVgIXxUkzMApQj?=
 =?us-ascii?Q?2I5la+1qG3UpmltxasHjivibCOgdKvUzPedJQIHF5Q+1bJspP0LujP/ZXXes?=
 =?us-ascii?Q?KfbSG4VVmssXMD0XtL+XlMUti7t3xZOONLUP/temmDbI+phWHLDGREtJZVn0?=
 =?us-ascii?Q?9/9t8k5pRQeghpQVlouxSKy40U0m3WzjDnKbdqBotXih2PdlTffnPAS7wTSd?=
 =?us-ascii?Q?OnojalzxwP5xWg99wkmZfSjnWaoabf+c0G7phDbYEXOMmhOKGqCGTI9en4VE?=
 =?us-ascii?Q?9MPGuEUTjvK+QjKmznmDx0C1aJbOCN64vXddoR6TIOJkHQ0NcsoY3MmL79by?=
 =?us-ascii?Q?Gg9O8DRgppLCQy8zDqtmWEmepwYzEDUKPTxQ5RGOhIpatDwd+w2DZSU62zVB?=
 =?us-ascii?Q?nr5ME7w5pI2gvJuKQZi86kd+yZIbYynfB6k+V2/H5e0fuyWHp/XKwlovDxc0?=
 =?us-ascii?Q?o6ohgBiWUophHejEjX2xDp8WUJaSJjycHxv8hUJc5o7fDfp13UxOVeB3TRh6?=
 =?us-ascii?Q?FzeT9ppNJ1YjyqoF0j4OIQK6RrgCctQGUdOREe+1Q0/a5q5BrVcYlcVthlOq?=
 =?us-ascii?Q?xQkuZ/uzxw7gBMrTSi6y3Qj4uFmo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:24:15.1287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a5dd13-99c6-4e11-9cbb-08dc692136aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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

VF can't access FB when host is doing mode1 reset. Using sizeof to get
vf2pf info size, instead of reading it from vf2pf header stored in FB.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 54ab51a4ada7..c84d2217005e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -583,7 +583,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	}
 	vf2pf_info->checksum =
 		amd_sriov_msg_checksum(
-		vf2pf_info, vf2pf_info->header.size, 0, 0);
+		vf2pf_info, sizeof(struct amd_sriov_msg_vf2pf_info), 0, 0);
 
 	return 0;
 }
-- 
2.25.1

