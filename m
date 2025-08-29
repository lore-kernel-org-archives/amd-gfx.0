Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1A8C8303F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8935D10E1F7;
	Fri, 29 Aug 2025 05:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G1E7GePS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB8510E1F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmaxvMcCTq6hGr/Yvmzn4JuGIcj+JGFm7tOA36f7GKyFmeDNDnT3p3oqtbzV0X42G4fA+8lsMumLvGGTHNGL0dRfwpyHGek3LGsTBixnmMjzCiEAaomygm7AWMKeNWVt2hsBCjOvawUMIJiqp5kmWYfAiHSFRNmcSuNYpF/hIYo7/mou7GL7ycDgN8w2Miq9amr91iBvGos243QCKV2x5R3V8KuhxUo9dOJAy1IGXJOt3IUgSr29EiFFLaQJesbYV+vD2vMD+JywvsRCey0B/VzJTXzuFf/nRywqc8TENXgzun8jbraqjQWW2ltG9fu/joBV9gNlgFvd182Z2CyPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wCHoSozE1ouBBPcDB5iH/9gUL6refI/Pj+sI7MGQ5s=;
 b=vrfuW8nWRflpcTqVHqVgmIW7++Xag+CwP9IsY7LCSBv5PJ9aFddTB51d7z5J2oWTX+oGDXNvifYqL7pUlCwE4nyj4NcORXT6BvuGlTGyLFv5kHEDfAXfGTW38eYBJLHIDJGz06OkXUEolqIMd+Y9Hp0aL+Ak2d2fGW06YUUmCDub4x78+C5UmSDeil5mqPrqqIXAyN+VBURxy4cTEuKl+6i0AqWRMUMsA/NGgaUTNYUrUrBA5YMmX8McUxukOdQj8BeGWyNuPjeyeqty6+6cBEDz4zlJgE0brrh7gUDfavEWGwrUWDSJwrImuM8yuXa54QCDzqD0oovnunwz4EtNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wCHoSozE1ouBBPcDB5iH/9gUL6refI/Pj+sI7MGQ5s=;
 b=G1E7GePSSLmPRGt3N851IXkt6gD9UmVsMKco/pRxKgeHn/O+i1xxs+yImo2nU1jnZnAsL0WWhnH1hu3ER4gdwajrfmvXBFvOb+4ArGktG5ABNqa+TgXtizylPEkxNYg1fISt7LfoKABEzoT59MMb4TMsoD1w99JSCndZa1guals=
Received: from CH0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:610:32::34)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 05:49:11 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::2c) by CH0PR07CA0029.outlook.office365.com
 (2603:10b6:610:32::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Fri,
 29 Aug 2025 05:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 05:49:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:49:10 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:49:09 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 1/9] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
Date: Fri, 29 Aug 2025 11:19:00 +0530
Message-ID: <20250829054900.3983348-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: e34e2f36-1ed8-44af-5301-08dde6bfc726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjljOFJLZnZRYnZvc25vMWdsOEcrVTQ1Z0k2dEI4NzZkUkNRVXBMbVZRL0tm?=
 =?utf-8?B?QXhmQnVwWTg3TFlyMGw5SmM2WlhWa1dKeXB3ZGlodlJvWVhqd1M5WEU0d2gr?=
 =?utf-8?B?SG5DQ1cxd0xqbnFHbHlrTFh6Yld2QVQxaXY5VDQ0VFpISXZVbUZnMW5uNUwz?=
 =?utf-8?B?TEhGazZLd2k1ZngzSWhrSWxhd3JLN0tYM0F5a29vVHBkajl3WFVZL0F1ZmVU?=
 =?utf-8?B?bGg2YWJkU01EeUtBcGFrT2JicWdENlBOZkU1aDlZSUhmWVdWNEszK2c2YWxm?=
 =?utf-8?B?cXZTVjl0dGpLNTlLT0tGWFRCbUcvUHNWQmFyelZiYmJLT08zSGpiSkZvTWNH?=
 =?utf-8?B?V0V3d2h0RHNlWnRxbm9mWFk3QmMweFRBNnpJOWtjMEQ3SGRBMWdCTERXNmxy?=
 =?utf-8?B?ZFc4SG54WTVmaXM1TXBrb1ZqUTh5RFgxQ2tadkpQN3EwMzk2NTQ2TkFUMkMy?=
 =?utf-8?B?UENKdkxoZXFnUUtQRisydGJvNzBzY0tYcVNxSVBTT0FmSG4vdDR2NENLRXU4?=
 =?utf-8?B?VkRtWlZoMEgyK1R1ZmJYTmNKeTFHbHNWNlY2Mkp0czNtQVhueG5Gd1FWOHR0?=
 =?utf-8?B?VEsveEN6MFlwaTBDVDJ3T1p0KzVKbXk5dzBuTHRDQ3liYXJhVElLN21IZHBy?=
 =?utf-8?B?M05vazJoY3NyN1ViWWpYb1lkNnhkdmhLaFNQUW9YOTJZOTIxajdQMXhhVFRV?=
 =?utf-8?B?SVNDZUdnM05qeGhGeEIyTitCa05UUmliMDg5QXJXNFVJY3hpWGw2WDBqVXpv?=
 =?utf-8?B?Z0Fmc28vY0w2RVFvZGFVRVphL2xwbENieFVxRmNmTnhmd3lUWEc4TytGSTlT?=
 =?utf-8?B?T08vMGpQOWh0ZnQxY3ZHZFRmd1F4NWQxc083SjU1WkpmVm1QS1d2L3dSc0gz?=
 =?utf-8?B?VWVMeEQySUdWNms1SXBCNEJTZUF4VitRZWZNSStqSy95S0ZRYmVKRGQyeVRw?=
 =?utf-8?B?a0x5Ym54MUU2STZmckNkVFVLL3YwQnkvN2JUeFAxZnZoek9FMFIxVHY4ZFFu?=
 =?utf-8?B?YVBCdnNmNmRXaHkxTEVHelJmZUJRMExYRlIxVkoxMWZuTnE1SHBHL3Z5OGRZ?=
 =?utf-8?B?VTJmWmhjWndRcENrZW03NjA0enZhRldoMENBNUdBa1hveTFDS0tIQzdZTjJW?=
 =?utf-8?B?bStDVFZRUU83ekt3TittakU2K1RzN2xMb0NqdHUzUGwxZzhtTytua2dJYVRY?=
 =?utf-8?B?TG5jdk40V1VVOEZ0czlxNFgvYkxGd0RySWRwb3dHcytoaWRNUzFZKzAvRWtp?=
 =?utf-8?B?a3VLNE1vNG16a3RvaXE0Y0hzZmJQTGNBUU5RMzdqUVQxclZ5WVFRZ3d5ekdG?=
 =?utf-8?B?Q0g1Si9OOUpMY0ljTW53NTZIWk9jSzQyY3A4QjM2S1ZwQ0ZtS1QySlNhblVZ?=
 =?utf-8?B?QmY3L29MN29BZkNBc3dKcGxldE5HYnBPSEJ1UjAzQXIwQ1QrRHM1bSt0UXh2?=
 =?utf-8?B?Vk9pcjJPTUJLT0IvcG04ekpERTZPdEpaZWJPcDdnT2hDUTdrM002dkV5cnNK?=
 =?utf-8?B?R1RjSjZFdUtTWGhrWEhtK3VvTktUS2x3QnVDOWdwcWVKNXBPUGhMYjVjSk1Y?=
 =?utf-8?B?T0tyb3VNRnFkSjMybitYZk9kWHIzMWF6cXRkSkRMK1kwMHI1K1g0TUVXWndG?=
 =?utf-8?B?YVlabVdjeW5DRWcxcjRKbTlocjZZeVZyS3haaHpYV1cwNm5sSXhHTHpoRHFz?=
 =?utf-8?B?amxXSllVdDJLaUxkQXNxL09GRGtDdzc2bWo4S2xVeklRa1Z2MEZqdEg4Z1Vx?=
 =?utf-8?B?QW1wUm9WSEd3bTVaTmNJcWxISCtaVEFlNVA5UzRxczdadllTbmQrN0lKMnV3?=
 =?utf-8?B?SWxLTEZkSVY2OXhpcTVIc21Dem8zNUtQeE1TL09zaVh0cXRZWlVaWEF6aThS?=
 =?utf-8?B?bzNTL1BtaGhKQ25zSS9OQUlZQnc4cmNCYTdwOWxpRDA3RUROVlRERVhCdHFX?=
 =?utf-8?B?TTJISHdRaDUxSlRMUFQrQmhrNGpZQ3JKVUtUSXNjZDY2VjVGMy9GVEdKU1FS?=
 =?utf-8?B?eWdGSm9GMXM3dkZmRVN6ZXhDMmdPM1BYbldoVDlLZ1RTYVdCQUM1VEpOVEh6?=
 =?utf-8?Q?eWOwAI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:49:11.0245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34e2f36-1ed8-44af-5301-08dde6bfc726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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

