Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E959CCA0FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 13:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9539410EBC4;
	Fri, 29 Aug 2025 13:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K62TOuk1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1A410EBC4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 13:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJtvf7LfJ/FaPV0VsviVJKalSspaAzrhUsiCQC9EX9KCgygh4Pn9JuyL589fPVJpUDixqM1r9U9eVgpxIG6EJZFnH2dbBdyw8HzoyAvR3/V5lZKZ7g3vjD6hTQL3AKwCYav3JHhTJglaAu8d0ELF5uLOIp1064JSHvGTSzehf3UobvDKnUYRFDvVhl4Ya2Fk4LrvyYeG1pJNK0hxeImHvdlJ+pjpgTxxqpld2qHprQZ3SmWzTjZa6QiSw4a7ixntUv5wOsRMfbJlJqKprPNcSXd629hoI44h6Y75Dnts+DbyEoBuknhX7dFSm7vi+XMlaHaCcSdF/bSlM8UWvEZQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wCHoSozE1ouBBPcDB5iH/9gUL6refI/Pj+sI7MGQ5s=;
 b=F3CPh38HcW8EHyyEyu1MKeGWpGrlknURjCRtKfZ4j0f5SupVxydCApVp/e3YPc7FmsTqySZlUPK1M6PlZF4iW79p4O7rsQ6YmP/biYqSRu7K0U0xmGGrjalz1w6WAZSuZQq25y9SVpe34kM2MZEpi5JaiKC89jRv6+TPmztoR6eYaN2aP2eWinum19aLO2WeDwjRksPuSwXYHvPTwY/WMxy6aoDAJb9K/wG0e5YPsYersegAXl3XCpfDD9qQuqKJkVbnP5zP/b0ZlnLeoRqIGpNXFjVMqYHYC+Yn8Od8SzHAl1eVaVrsXyUrSCosCtEnwbnbqjMaHAI9n3362sNqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wCHoSozE1ouBBPcDB5iH/9gUL6refI/Pj+sI7MGQ5s=;
 b=K62TOuk19oa0afPv6lAlRYX4vIr3HS7pMkRGoirFAoj/bxjNoMGSH7nipK7U6inMcBoAYaUHkWzrKbQCRZrWKQ+IkC6XLsooAA+bucy11k29ZseIECM1RjoybMSBVhd8zUdj348aexe/41jdipARzRT6sZyYlDER9m5/vl2dZVY=
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 13:56:49 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a2) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Fri,
 29 Aug 2025 13:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 13:56:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 08:56:48 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 06:56:46 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 1/9] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
Date: Fri, 29 Aug 2025 19:25:15 +0530
Message-ID: <20250829135523.4032168-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 3054183d-d290-44f6-3cd3-08dde703e643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVFqYnpFSmF3dzd3VitNaStBSTJCTWU3N2d2UEFkQjhuWVNoODJvQzBZWlg5?=
 =?utf-8?B?NzI2MFhOajZKZFRYWEdkQjZLdUhhV0NXczdhY2c1Tlkza1EwcjRmLzFkeTlK?=
 =?utf-8?B?S1F3MkpmbEtsME12bUpFc2V0SmdaUVNINHF5bEtGVlRwbUlPUHRwUHBTM0pr?=
 =?utf-8?B?dGdQb2RrNkYxTW1BU3JDanJNbGhzVG1WODM4MDFDd212UW83dlV1WHlqTGZO?=
 =?utf-8?B?V0lQUmx1ME5ZTXAzMnFZbC9PZVFxcUdnUHdrY3hqS04vK2Q5VDVBVUwrU3dH?=
 =?utf-8?B?enlNWUtiNzNVUlhSL3RKa245T1FlK2R6RE9RR0hPYzBtOGxJZEZaZkRVdTJx?=
 =?utf-8?B?YWYwOW1DZXJJZEZRK3plZ1dSRHhtVFRob09sbHZZOGRrYXRpL3VhTDJkRk9t?=
 =?utf-8?B?NSsrSHlmS2NsUUJiM016RkZLWUZiK1VqUWo1ZXZzU25UK2YzNFJWL0x1TEZG?=
 =?utf-8?B?TTExY3ZUYlFVU0M0ZENRZUg2VXA2NGdGR3RSZ0ErWEU1VTN2d2ZrbXZhWGlo?=
 =?utf-8?B?dkw4TVpDNXV6YzhuN1pncFpuOE1nTlNhY0lNaVVIUy9hQjIrcmVWVmJ5elQ3?=
 =?utf-8?B?Q005UEZZTi81VUpOWjJaM0ZVOFZGSGxkMGtJQ1BrdHlSNDhqYUxQUzA1MDkw?=
 =?utf-8?B?alJlK3UyM3V5ckFaUS9pRERTdEppRVFRVEdlM25EZDBxNW5KSlRDV1lmRlYw?=
 =?utf-8?B?cTBGTjVoREVkUzFIdEpwTEVqdCs1MHp4UUJsNmJuakJNekR0VWtzM1ZXRXJz?=
 =?utf-8?B?dHpMK21pTVNCL1ZwZUtxcjN5TnVkc3M1REpRMFJ4NVQwcGVycXNmZEV2dHhL?=
 =?utf-8?B?ZVJjd3hHaDBtOXdCYlU1SW43V0d1bjRGc1E3ZnlyTCs1NmErc213ZzdkT0pj?=
 =?utf-8?B?MGpwd1RNc3FLeEJ4YW1qbWNKdFcxdFBxVkRvc0pwa0o5R045eGZ4eEx0K2Vx?=
 =?utf-8?B?Um1qeUhOZ1NvUTg3N0dUbGxTblVUelVCRWEzdFpUNnlZWjIyTUYwYUgzKytV?=
 =?utf-8?B?bnUxYXFMREtkNUdTQmhQT2JEd2x6c1NYQkV5UVhYTy9QSk9GeGNrcDE0cUNL?=
 =?utf-8?B?NWowUllUZjVGVUx0dk04RXMvZk9jQkFUbmhtM3ZZbk9DcDRSeUp1bEpmYkJC?=
 =?utf-8?B?MW1LbXZjUHFHUlo3N2F5OFF4Y0dKYlNEVFNIQ0Yrc09iaFpGRG40VmpLRlF0?=
 =?utf-8?B?dW1IL01hdlZwZ051RUpaU1NlKzFjTjAyYkN1UnJYaFVWalhQYkFWTmR4NDBM?=
 =?utf-8?B?SDlWUTltaXpJYzdDQlhMc3c0TGRlZHc0NUlPRTh5L0YyT1EwMWxYSTlrKzEv?=
 =?utf-8?B?VHNTcno0MWphM0xRdS9mWE1weXBheVRaL0hzSkpsWFBJalVGWng0bmE1UXIy?=
 =?utf-8?B?UTRDazVUVXAyVjN4QXloWE8zUitXNXQydUcxdEQ1Mnk0TE03SUlLYXNhTnBR?=
 =?utf-8?B?anB3WTgwR2ZKQWNQenlMQXpNK3Y4ckdlSUpVdnJKYm9MdVVwc0NFMmhyTWh0?=
 =?utf-8?B?d0JUZFJVQXR5b09Rb1h6TkR4TmtESk94dUVXcVRLekdDTENzRWZaa20rajl2?=
 =?utf-8?B?QnBzKzBYeFVVYmsyNnZVT2psRWtTQVJ0VkFWYjRScTNBd2xpY3FId2l5dU83?=
 =?utf-8?B?eWNvMldZdWxlVVZBcEc2Y2FVTzVDNnljaDJWYzI5eWFCU0ZKUzlqWHViUzcy?=
 =?utf-8?B?c1hYK1Nhb09wRFN5dlllZ29UL3I1UmZ5MldCa3BKeG0zOEpKWjR5SWZoWkFI?=
 =?utf-8?B?L2RucUdTQ2JkTFBrUDFFZzY2bkpZMndCN3JNblhOVGxFVEJ4YXJkM1ZzWk5k?=
 =?utf-8?B?S2tHWXFRRm1BV3hOTVRlRGhydDlDUENqbk1EN1RGdktxbEpaeklIc0d6cG91?=
 =?utf-8?B?Z3YyNjRtS2w1NzNGWGNGVW1UZHNPdDZKNnVzSlNWZjRFVjVuSUtoVEx1VXhs?=
 =?utf-8?B?MGt1L2dyMzRXdjJsSFJTdERjNVY4KzI0UXdsbTF5ZnpYaTZZZXM0R1JGT0xl?=
 =?utf-8?B?M0J1UVNQVldGZnpmVnYvMFdUWEtUWk4zd1JsMWo3YTF4TWJjZmFMd0pDZndI?=
 =?utf-8?Q?Ga+cgp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 13:56:48.9211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3054183d-d290-44f6-3cd3-08dde703e643
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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

Increase TTM_NUM_MEM_TYPES from 8 to 9 to accommodate the upcoming
AMDGPU_PL_MMIO_REMAP placement.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/drm/ttm/ttm_resource.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index e52bba15012f..f49daa504c36 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -36,7 +36,7 @@
 #include <drm/ttm/ttm_kmap_iter.h>
 
 #define TTM_MAX_BO_PRIORITY	4U
-#define TTM_NUM_MEM_TYPES 8
+#define TTM_NUM_MEM_TYPES 9
 
 struct dmem_cgroup_device;
 struct ttm_device;
-- 
2.34.1

