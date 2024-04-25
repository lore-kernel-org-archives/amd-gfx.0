Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375B5C10F15
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 09:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A00F11A337;
	Thu, 25 Apr 2024 09:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0p+du9Wi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C6510FA6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 09:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMqRykqC1Hnu3MU1kZkMwcnUZEzLQUn/tGlHPnnAZC5MDDNEmmfTzb2HqgOv7OrSXkDjJpb7u8y+xD1vPl1NH97WvdT7WPTl7njlFJXlsXTv+ZQKkTf0gu4S7zKoRGpTlkyPq9WrppgTP51Xjwf/yZ3tQTwlHG1uJDybgYO8hoMz9MXzaNM37tC6y+ojF2R0vOhDNiAf+R+99OA2Z9xDz1d+VyanSheBgQeEB74apFXWEXN8ubSv9lsPoxZiR0CDMiTltZSm8L3VWatqJzi8ZZeCJoSWo+miM1fKKwBvbsQYYAy688osvAFQ/9lo1z0+fG1RVVkkFKIVDYzYim68sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdvM3XTcAmNjOAYjhtqaSgO4Ur1jYIwz7iqhgXcsH7k=;
 b=CYDDvxruPSpTpktmCKgyKT1Ni+jkBWUNrS9LUqpstGtZ6ixuiY5DSLfVr4L7M8OWw7XGxH/uRVlPi1B1Jqf9iEZY0FsSHciWpppZu+YEyWWvXPed48ySDkLL2u/dp1HV/4nfUt+Z+97qfXGJqEWj27SvMCHjsksiotWKAuVD7ojOHRQ8YGxTkDsrkYDKrMlfFVbk2cfopQf3jTNLIFlmiUxx+reVuo2XpGaz87JyIZJumJfOT6MWXr/iTcsdL8+PfEXwmhLkk+AdWJa2gbEZ8sPojFL8epuFZ6QcOVmTNiXMbzUzLbV97w2hnlHfy/3qhy5rvwQFv+Zy8Z3KrAtCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdvM3XTcAmNjOAYjhtqaSgO4Ur1jYIwz7iqhgXcsH7k=;
 b=0p+du9WihErVbws2Cycq1NtjwXT+C63baqd1+k+a/jR7YYc0uvj6CZYL6CtToxl7/Ns4F2y7J5zmQNj/UMhuR05PNJ0s+HCgDtQOUHGJaVoCjS5rUoLXQo0mqT817N10z5INEBBUL0fKAEybcId1F+vULSnu9rINCowRhf9paWA=
Received: from BN0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:408:e5::18)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 09:48:16 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::56) by BN0PR02CA0043.outlook.office365.com
 (2603:10b6:408:e5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Thu, 25 Apr 2024 09:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 09:48:16 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 04:48:14 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <Likun.Gao@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/mes11: update ADD_QUEUE interface
Date: Thu, 25 Apr 2024 17:47:40 +0800
Message-ID: <20240425094743.134248-3-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425094743.134248-1-Jack.Xiao@amd.com>
References: <20240425094743.134248-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: cebe4121-59b0-4445-5d77-08dc650cd4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TBP8yBTfCF9CdeM3Hgjp/TBhl161FPeohs5pgR3+z01vghSgP9R7bDT4vpO0?=
 =?us-ascii?Q?IQnInKCZDTnmzoCFITyGRw/9cPvTZwovWO1TJnydl8OGlIiFwLdK24vgzaFL?=
 =?us-ascii?Q?oGqtFEIbzYiriiPQYjMKk6xNKwtgRkTKdT5rHJJbjUTzAuoCsaUyDBIjDNuJ?=
 =?us-ascii?Q?FmXSS7pUIMD4mRN6iUa9d7UGCYytrA3GyFv9nYbqHPGuHquVfHn5Y11/gIi0?=
 =?us-ascii?Q?iDSXXbFDGS2p5HSaZJbOA1b2FTb9evGJJGwMmWL6lX9ROyxDPdwGW0HpWfBg?=
 =?us-ascii?Q?iMMK3Nv0Hb5Uwo78twI/pmhVyFTU0p+xT8gV11KZw1MBKRHy0/B7SWEKJBJN?=
 =?us-ascii?Q?d0gGdPH9iJjhjvvlE1QCxyYq7AmuboMVP65fCgeY9grwVWw2/FoZVwVPtnvv?=
 =?us-ascii?Q?X0ATWnOCYWvlFL0XVUPwZfr1NhYWwd6yAjsxA0kZRTbzNOex+J/GdM2rC3Yq?=
 =?us-ascii?Q?GCB4qQ+pka7cm2jBix2fXKjoGNPB9ZIRKwne+7YmsZOrhGry7AE0CbEhpXWU?=
 =?us-ascii?Q?8vadL2liIQKHKCo0oozgy1GV4wqRPvB1DPwvKCqB9r7IZiBmixjGVQbHpBU8?=
 =?us-ascii?Q?oVob2BGV5pynpIaINBnIuaBoE+ucjDYd79dQh7qk9zyyP6nJNGgcgopKp75d?=
 =?us-ascii?Q?YzWONH9VbdgImzmLLxTs93/NlkVsZ8rGY+SmpsyyJOdxZNsBxZLLF7k9p9Id?=
 =?us-ascii?Q?pL0Hj/vwJsd7v5iEBF8udOQqrvxlzVXkWaaNZwPDfqSYMwM+BpO4xB3tCIjY?=
 =?us-ascii?Q?VndZJGKaJPDBQyPEDg/OiaOgtPsEqtaR0rvGGJh4iTgtAv55PBrRGXZfp0Oa?=
 =?us-ascii?Q?6YIvz1SyFVmS8CmW1caBBcfUhl9V9Z89aAwEOE0zo4ixKhwc7Pe6rs/ZJ9wm?=
 =?us-ascii?Q?1QfKYXqVyI9nqHbtstfQPUKQchEb8Q9gb4/nvxurwMYxedrCPOi72BaoHj3d?=
 =?us-ascii?Q?u1XXliYHr5Ya74lGYEUCw6mgWASHD7vvdjX9h/g+FhZgn7iHxJURfXIGvtKO?=
 =?us-ascii?Q?yQAPpuztH1GBlxnmLe1d06rWTn6IuT4BfLvO/I84VZXTcTg6rP9obzscfjHc?=
 =?us-ascii?Q?x1PSIvrrX398oWzToKg/wkWRc5/KprC1SM3exeNZn9o3sLszsrWpNMqZmThF?=
 =?us-ascii?Q?K7/KzxGlO8iOZgEJdUQl078LUjac3yYXXliAa8r3QWCzRW0K0eKUgDrQqorO?=
 =?us-ascii?Q?0OiS8Kb5d6mhzyj1J3Jd6rIyfHcP08eJtk7PY79GVBa2PPbGG0fsrqTCcOof?=
 =?us-ascii?Q?d/ReOjx43BFuNgHX6VaiOZ84SZcDRiLEchaVvkz475xBRMhM4zAaIW8LrThg?=
 =?us-ascii?Q?jwkWeV2i5gXfmfk4AGjWv2hItDy79fa8AbuDmCZ28xjgtdb/lTqcNCjxMuCO?=
 =?us-ascii?Q?UtRAf4JEeP9Jm+M9VAZ5JwBPUChS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:48:16.6555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cebe4121-59b0-4445-5d77-08dc650cd4fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

Update ADD_QUEUE interface for mes11 to support
mes mapping legacy queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 410c8d664336..b72d5d362251 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -299,10 +299,21 @@ union MESAPI__ADD_QUEUE {
 			uint32_t skip_process_ctx_clear : 1;
 			uint32_t map_legacy_kq		: 1;
 			uint32_t exclusively_scheduled	: 1;
-			uint32_t reserved		: 17;
+			uint32_t is_long_running        : 1;
+			uint32_t is_dwm_queue           : 1;
+			uint32_t is_video_blit_queue    : 1;
+			uint32_t reserved               : 14;
 		};
-		struct MES_API_STATUS		api_status;
-		uint64_t                        tma_addr;
+		struct MES_API_STATUS       api_status;
+		uint64_t                    tma_addr;
+		uint32_t                    sch_id;
+		uint64_t                    timestamp;
+		uint32_t                    process_context_array_index;
+		uint32_t                    gang_context_array_index;
+		uint32_t                    pipe_id;
+		uint32_t                    queue_id;
+		uint32_t                    alignment_mode_setting;
+		uint64_t                    unmap_flag_addr;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.41.0

