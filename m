Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5B7C27C6D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D95210EAD0;
	Thu,  6 Jun 2024 21:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M0rYq/AU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1674010EACD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti3lTK+nOQnxSqxB5kLLbvBsFLX7e8IO1qjMXl3hITAJdamLXQ7q2VJ0L9XDD+pEOAqL20oYB1TAsoJ8Fhni3xHfz4zeFU1/uVJ88TlbHS3d4Uw4rTBIAqilbpCigIM2NWeWQaJCVDFooF1jpR8oPEspOQjpgLDYgeN+Xo9WE0tqomSxO9XenYEJsCwmJtSAI36bFLWc1rDIEZWo988f85kI9NdIgBW6udiRmZR+pkA+un4HnXXegYIQudIAszDA7fbsEE1T7bT1iTcIM3qtdCQ6Qk/LI1KLAn2Bf5p0KvIpiQ84q4NL+tAa/Uv1t+YrOx0AUtmTqzVEWCIlZYUOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6s/mmLkWWSaPQDl/hWB1F3sh+ignEujSR9KZLn8LaF8=;
 b=ny2Azy7HzGxvWPmV6ljiu0JCsxru/FQ6wLCFo5AuZGlDGqy9ZfGBRTJ742pio6JG4LCBZorvO6AgobGeofAVQ53mMzj+Micm8PQSDgg9Py7nyLydEbIvIbLWxsf6UxIFFmEgJ/wVc2v2GirNEB7uo+UO58r2uNUqxjvSQIzAYn/1YaZd7KedCwaqjBiJXEGjQ44w8KDNlsMXZ6QjDB8pU8r3Avd8Ra+RKpcc8plfZjybqlKNL6poifssX/2bi/JC9v4Zlc6NlSJRiYkQDXR8mGljp4J9y4eG+0Kt367f3Cmlx31kZa3fm3YdzYozEzMdQA+R4TNUTgTen2dJtDp+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s/mmLkWWSaPQDl/hWB1F3sh+ignEujSR9KZLn8LaF8=;
 b=M0rYq/AUG02WixZIeXyyt6+yOponU/xZro2KnAJaHKlhwGw3dTd5GORazYpD7MGanEeswIxexxvVNRpR6Ck9muWmp1i/TE29nBcPSBUg9F0tZwVO1I8TuTURvVWDfyGTUbr+lO+/bdBIOwjF6KGoIns3XO6uVxz/1TCiRkrvUts=
Received: from MN2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:208:e8::25)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:57:02 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::7e) by MN2PR20CA0012.outlook.office365.com
 (2603:10b6:208:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:02 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:00 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 09/67] drm/amd/display: Remove unreachable check
Date: Thu, 6 Jun 2024 17:55:34 -0400
Message-ID: <20240606215632.4061204-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aad3d65-7be9-4022-0971-08dc867398c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OOsBxCk/AA1k2NRKPcLNMRxt0yIvhZO6EKTPcMn8kxSpF50Nz+YL6bJ38h5l?=
 =?us-ascii?Q?+zcCTbHSH36F02oCyjeiWZ/fQl/dKlVU1t7oHHiQaPq4rQDs8tw9d6VhGvgc?=
 =?us-ascii?Q?zDAZsiSmrD7V/ZA2Nxanjl/5naVnBc8+V6NFiabr5KEGDR7J8m4GUwcP9zF6?=
 =?us-ascii?Q?iWoWKZeKZ/1zHaS/ojy2yQSC+U1YRU2TvUK+Cm53hGmGWuPYD43CqI2gMo1C?=
 =?us-ascii?Q?tbzBC874inhO4LByxRTU4VdSkFB/CZRaQEENbepUauH4N38bQIyveX20jZlQ?=
 =?us-ascii?Q?A+58mv1YsX/Z/wE7BGLrY1uH0bXuCHAVqVseYVGTcAvEzLQvh0YQGYu3iVln?=
 =?us-ascii?Q?wHwL5mQFda3yerT79c/RccdzO3T81jjAP+O02sGs4iSZAo3rXuSzJ6W5UXyJ?=
 =?us-ascii?Q?iqbTk13pWo2E3r4jtsjOHVJZlVM6wChyYqjOyUmvY9nZFFhjtDPIcJPeHUZT?=
 =?us-ascii?Q?OwBdaG+K/5WDYrMSMnsQtPOG5feDXPqVK27q8G5LfiaGeP93nZcPcVzajKCw?=
 =?us-ascii?Q?OdJjPHQi7AjBkLUghD8Q6bqPnyzsnKCXK7tU+E7AAsvkHBscFFgiIQ1Fpgkx?=
 =?us-ascii?Q?go5soDVC0xmBZenjFnkdb2RNg589XPw3s6WHwxqL5CPxwcuGbyPMYYZI/rUj?=
 =?us-ascii?Q?VWrqoHgvc9mRQfq9dbg15MvTCqLM1/W4XGnwY6nDWTdGOALfQ+KcgAsorgtB?=
 =?us-ascii?Q?0ERqJW78C0MRZn8VdgPSukLWMWQapAnpVphbzeNZIfAfTZ9BRyA1RNF92SyT?=
 =?us-ascii?Q?FNhEBl3yqNBbWfEQSIIgYWe5JTyLuOm6VfS5FYodmtfhEN9OZO1bMq8fZl+L?=
 =?us-ascii?Q?iQwv/e+Vi1LH/fj3OBy4wZAtZuCj5uWbkDYhMS644LbvC17NEZy/0o4QBCh1?=
 =?us-ascii?Q?UadtGRXhL2HCjgOUHcuww8pRhCZuwA+VV43/3iLs4muZ+HGnZaE7sMxwRz0k?=
 =?us-ascii?Q?eB25dWE7hfDgzf+p+NzGD0lcF9qMdoUPUN0yvcm4d4tOzLlKOx/0H/787a9h?=
 =?us-ascii?Q?VXEIU0ddwEz7/pwygMHlCxH+Xtfq3G3d1Q+hMgzX6iuefBwAeT78dFK57nNR?=
 =?us-ascii?Q?EkcLStuKJjhGkxE8wjNzGQw/Doy6PChELQI0SuyUxKvLtCMOZa0RFzG2GlSe?=
 =?us-ascii?Q?ZmF92SEY0NB0bzX6UfzjcpRUYp+FIhKCWOnZhbffvqdC11JISBxbD/eqMTIR?=
 =?us-ascii?Q?Dfrpm247jtKMmDWW9NenNQIvaqPuXnOgm9Jjj60irxdTWiwQ0lALjThJzTCW?=
 =?us-ascii?Q?VCdW3Utb8+u4PvvKkw8A9apo79DXLtJ9sYvlmXjKpCh763jp4V56mOI8gjIy?=
 =?us-ascii?Q?hDwqyRx8iXC+uUyRYefFSn3We/DAScmNDSCphv/fTd08JIDpIqbU7sBylVO+?=
 =?us-ascii?Q?ALsm1HV7M6vyB2N1TizihMvZ50xgXu0zPgMlQ9L7FX+QmeCB4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:02.1069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aad3d65-7be9-4022-0971-08dc867398c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged this code as DEADCODE
since the condition and return in the outer loop
are never reached.

All operations with the 'dwb_pipe' variable happen
in the inner loop, that already contains the same
check with the 'MAX_DWB_PIPES'. The later
check condition cannot occur before the check
condition in the inner loop, thus the later
condition is unreacable.

[HOW]
Remove the unreachable condition.

Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 2 --
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index c78675f8be8a..b2d79c908ec2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1666,8 +1666,6 @@ void dcn20_set_mcif_arb_params(
 			if (dwb_pipe >= MAX_DWB_PIPES)
 				return;
 		}
-		if (dwb_pipe >= MAX_DWB_PIPES)
-			return;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 0cb2cc56d973..5040a4c6ed18 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1419,10 +1419,7 @@ void dcn30_set_mcif_arb_params(
 			if (dwb_pipe >= MAX_DWB_PIPES)
 				return;
 		}
-		if (dwb_pipe >= MAX_DWB_PIPES)
-			return;
 	}
-
 }
 
 static struct dc_cap_funcs cap_funcs = {
-- 
2.34.1

