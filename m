Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F315C3271F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 19:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0157310E9A2;
	Wed,  3 Jul 2024 19:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tqUMCCJY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 008F710E990
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 19:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dms9wfT9Y9KcXZSRuIcgb9uHt0HH73DZSRhh8YALtnVlul1l5Ir3NDO2jyi7UQvveAwb6KE/4knOJ27vp1dYk1RyxTTiOZD96GilTTklWf4e96RaJ+oqLsh9iTVFTmRC/y5c6Kpgms3QO7B0lJVnrHSukCbZfMvajHfa6zVnOczLsDUlfwKK9TFNGUSNGv0JT29D13aB6EJsYXJtkICuUF2iwr9Tc5mmcDACzVp1quOKsKZizzA1f/J1Pwt8tVdijPyIO39VkZDTfLxTWLTj0luHN4UBkEOX/JLJsJCUN+R7eu9gIVK5aCYB9cZwAZQH2SMr/xdFC+D6RPQtdUPEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgbbiMuqYZor+VQ6jQylgYdz7R9zmDF4j/hejvj4x4k=;
 b=kI+puSF4lgZ33DeH1OY01oHHkb1RT+EQbx+lcqtHPn1AuE8Hlg6XR4OzueY9yDVZZ6uv6H2H2fkjd/0gn5eE3Gnoxq3yp3G6jOqkjRoYN6rF81FQR5QrbXmhZBEs7Wl0fXuBWJ3RhAFW33WFa86g1yKouDyjHVfBvs3hmoviAaYypblARgtU1V4+bepUD1ESfAUt87y2q85ygxPNZkEFus99v0Ksy9nXpiD30NHlfpBSjlAFhPgZyZSHnLIHsiuD8qHG1LI2UhV8wsntDUu2gRy5OeTiByNEWbe4v3Lw7ionBsmZQxyCgrv8ZhEiFTLWWOL0532CA7gkfFtzOb25Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgbbiMuqYZor+VQ6jQylgYdz7R9zmDF4j/hejvj4x4k=;
 b=tqUMCCJYNQ3MhB6BVvIA6u1MtElrw9hLCzV8Q2+FX+3kpnHI0xBhwh0qqNkqZxUSr9jE/6UXuOyZXz0KIvd8kZBnxzcK5UEZL2w8bKusGcSfa3OgNBcFB4qGCfIEMonR0nDBDSQoi7gQQlJwMKkTjc1l5mIcgfBN9L225VQxJWo=
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 19:36:26 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::a2) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27 via Frontend
 Transport; Wed, 3 Jul 2024 19:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 19:36:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 14:36:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Subject: [PATCH 2/2] MAINTAINERS: fix Xinhui's name
Date: Wed, 3 Jul 2024 15:36:10 -0400
Message-ID: <20240703193611.2002463-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703193611.2002463-1-alexander.deucher@amd.com>
References: <20240703193611.2002463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7f2343-19ff-45b7-f69b-08dc9b976df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjg0RlR0cTBPL3FYbnl4T3B3bGFYK3I3SU82WnZVUGlJVHlzTjBuVEdmUHRw?=
 =?utf-8?B?Y2sydXVVNjdpSEFpcGZYM01JQWtmMzRvaEN5TkdSdGJ1bWRVY2UzbmpGYnJ5?=
 =?utf-8?B?WDJMUWJSRlkzTkhqOCtpeS81UEY3WXVuSm85Wi93bi8yRHVVY2tZa0NUdnBj?=
 =?utf-8?B?YTJwak81SzVuVU1wS0xCUFZYS0N4RnBQb2lSTXNMMnVwT0d5b3I5WUY0UWVa?=
 =?utf-8?B?WjQ1NlRkQ1NBbDJqSFFmRmJ6SWUvL3NYZFVjNnVGdkJBVHVZeUdiWEVUNUVa?=
 =?utf-8?B?ckVXZFJpRm0xMzFuWkpLc2M5bTJXK05ZMkVqR2JWdGFabERyYjVtVHFhRVlY?=
 =?utf-8?B?TEZtUzVKalRISy9GTlhDTEJ4NS82aGVSaGVQWiswY0gyNmRrejhnR1AxbmY2?=
 =?utf-8?B?MGFRcm04QWhQQy9LaEhwWUJKSVN1RVliQVN1dkJzMklQcnNKNHhySDBhWHhC?=
 =?utf-8?B?VFpaTlRJRDIzakNwU2NQaXptbmRxV2tGSW9PK2ZpOUg3QWUxRVRUb1NiNTFr?=
 =?utf-8?B?NXNxaktFTlR6bjVoNmgvT1M5dW5ZYVU4bUowcXdhQjA0TGg3L1lDU1pLanpi?=
 =?utf-8?B?ZE5TdGJCVVF0K2hxOFQvYlFORWlLK3BrZm1XZFF3aVZYRWFxelpkNEZRRjky?=
 =?utf-8?B?bHgvSG1JZmdQNFdzRXYyQmFuL1lHVzMyNjlSVGxLREk4SSs3a2drZGNxL2hx?=
 =?utf-8?B?WWVYbGswRG8wSlc3Y0NmQ2FFZ1dsa1kxV3pVY29zSlc4WENVcGJUb0dZQTlp?=
 =?utf-8?B?NURsQVFtK21yVTk0NDhoT01Ldkp6TG0xU21IZmtaRVRxM2I3bThRaEt1ME91?=
 =?utf-8?B?NHhyWXBlcU5qQUtDVmZnMWd5WmVreG1XdUFubnc0NGVEbEY0NFJ3ODUyRDJv?=
 =?utf-8?B?UlZuK1pPUXpPOUtUVWpCNjliTCtWYlhBYVJhOHhwZlpyUkhPdTl4NE4xV0Rp?=
 =?utf-8?B?clZ4ZC9XVUpCRFM3VVluTW1BRGJMeEZwT1c1bUkwcE1LaWt2SVJmWmJMTnp6?=
 =?utf-8?B?dzRtVDJxMkxLRXpidmZCcWwrTmprZGg5Nk1WbHJSaGUzeElzRFU0K3NXY05D?=
 =?utf-8?B?QVFhQVd2Y1RmWjN6em1SZldqUWdlclNQRDBPdWE4TE9IbGxxb1ZDMWRNZHVy?=
 =?utf-8?B?NWNMVWxYVFNRT09ZR1JEQm5iM01pMXJZOGhjRkQybnY0V1lQUXhlY0pIcmZW?=
 =?utf-8?B?WjNqcmtmTTJvZzcrbTRuT0JEYnNNYW94TC9aTDlBUHJCdG9KUCtxd0t0SkxJ?=
 =?utf-8?B?ZEg5NGpuaFd4TmRMQjhPbGk0ODlrRUFvSEdnUmpaWVZpNnlYaVBTLytZc2U1?=
 =?utf-8?B?SSttR3k3NEh2WDI0ci81ejRSYXBtT2R2QXdOd05IaEtvMzRyYkJBYzdab2FG?=
 =?utf-8?B?Q0pZdjRBbldQQ3VEbERKYjUybFduQ3I0d0hJKzU5aVlMcGIvMU9sQ25HYmF2?=
 =?utf-8?B?RHlmdi80Q0huRngydlhWaW5DdXcxUU8zaXQvK0JYTWJ6WHFKVmd4M1ozeFFv?=
 =?utf-8?B?KzlqdWZtcGdqcW9GU3gwZXplZS9yUmlRZjRhZkdSSGx6ajVyN21pUDNVRmo2?=
 =?utf-8?B?TlErbXd6MkZHUys4RThoVnNzTThCanBEZ3UraUlEMnpkdTVpVW5BWWUrWmZk?=
 =?utf-8?B?ditDZmRHQUZRQm5kVzJVK2tDTmI0YWE2L1BhMlBackoyVXhta2ErMmFvbWxT?=
 =?utf-8?B?eDFNNWJwN0JWTzc2RVJaUWZBS242R0hyaGtURWx4RG5Zbk5WQkxSOHF5dmNk?=
 =?utf-8?B?NXhHd1dCYzFlS0ZXU3NJdWNzOVQxMmxlcXppcjFKNkJDbFlsaG4rU2FhS0Y2?=
 =?utf-8?B?UCszaDFqY3YveTBKOVd1MTc3NDZZSkVaSlpmVW5tUVlIU0VCc0k4N2RxYXY1?=
 =?utf-8?Q?sDqnOAlq/b9MA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 19:36:26.5992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7f2343-19ff-45b7-f69b-08dc9b976df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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

Switch to fist last for consistency.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b7aac333d8e..5fd6fba07fa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18648,7 +18648,7 @@ F:	drivers/net/wireless/quantenna
 RADEON and AMDGPU DRM DRIVERS
 M:	Alex Deucher <alexander.deucher@amd.com>
 M:	Christian König <christian.koenig@amd.com>
-M:	Pan, Xinhui <Xinhui.Pan@amd.com>
+M:	Xinhui Pan <Xinhui.Pan@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 B:	https://gitlab.freedesktop.org/drm/amd/-/issues
-- 
2.45.2

