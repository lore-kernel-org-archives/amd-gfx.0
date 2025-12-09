Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B75D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 01:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F8010E46B;
	Tue,  9 Dec 2025 01:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ICT8X8GT";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC6710E45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 01:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZd9rDnPLW/m3YVnMxasZn8NUx17cRH0Xo6DiwiSLPTpzIwZnrTZM9BcJENTe9l2PjQTXpES1DOMQuEDqpW5t53tFQESNmRo8S+79CLNqRbYoWeoAgn/sZpgIQrXOlceVbHi3odaaKepeyz6DEGjJ4WpHe2PK7yweaRTl9/bFrX8e6fAlJJF+tarUuN7WMVfDRzm1b2CfjNvaFV1lO5AAItTvha/zpnoaCxZufRLKW/innvrtNMIQxeq4/vfJY1bEYQFMsYV1nlUZL4GDY0xcLY/uZS05sffQ+apmztpdoHebxan5oKam3s/GWHHKWE7ECJNigpGdsuMV8+ixOqKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaxESRsHoKfFTkVGJd/aJZ2LtyABwgQooRhRrip8SdA=;
 b=ypZ/WqtTI4hGcGRJXG++Qevds9xeODo4eStaSS3uvruDLGVud1sQxo5cgwjvrN7KUq5+vKGiSWUvw9kmWPf6wjPyh0h9n9eNGdISAYO548Xi3lCLmCbAi2wOaoGdFeongb/1XeVqBRzHuitbqo8KP5C7X2bOj6BQTkEcTv0FX/8+R5A36gtZ3RwecJ2RlFAIJQsSvtpFVf86JcPT9oZe1jTTvTAS5cOxAdQNp7tAicvv1/QCgyvIsQU/zWzlv7FQVSmNgcfXlXu0tNl/YrElDvRkH5gMAivcrRVX/if7gCLG7n8tj29NjKV1ZnLEcdotQVTYhOkD2qoKCXFxNrHfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaxESRsHoKfFTkVGJd/aJZ2LtyABwgQooRhRrip8SdA=;
 b=ICT8X8GTESunxxyPAJ/I4Mf4HzBcqqdPkihCnsUCibqh8oeeDZK/iTC+lER1gRu7Ekl8rFvCYhhMO36FRJOWyPP5F0CrPcI3zGpxFcCzHqUhmn8U7LfPnvWm+braHs/msS+UZfjNz93byaJJjUm52ueaUJmtrtfjUJLVeBetNyo=
Received: from DM6PR04CA0019.namprd04.prod.outlook.com (2603:10b6:5:334::24)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 01:26:16 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::b1) by DM6PR04CA0019.outlook.office365.com
 (2603:10b6:5:334::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 01:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 01:26:16 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 19:26:08 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v4 6/6] drm/amdgpu: Use resource iterator update MQD mapping
Date: Mon, 8 Dec 2025 20:25:37 -0500
Message-ID: <20251209012538.3882774-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209012538.3882774-1-Philip.Yang@amd.com>
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d64e134-bc7f-410c-fab9-08de36c1f2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3z/IAUAt4/+WDf8RYdsmnOhiTRxCZIGomFkw85W7xCd6+SSyKxI/esxxOMJU?=
 =?us-ascii?Q?veP4iDdoK58I7XY/6Od2Fh1Ikk+3QOpdiH58XEEwnzw7jVyV9JnDLm335ry0?=
 =?us-ascii?Q?hEd2sllol3hjQKfiu4eM29CPsnvTZM/byNzJzBJVBRgFOC3WuYPBbbJ5jel5?=
 =?us-ascii?Q?/vCEptqayoHJy1aPu2Ok1qct2a2hMmdhbYIH/ZbSMzf+2jtpw6g3K/ZewMO1?=
 =?us-ascii?Q?DF9nqQAidFx/eW6Y8yggBZsZCFtARn5VJ7X7CEhzxd5KIve0sYVUc3hxK93y?=
 =?us-ascii?Q?UDQaCGop6PFDDgGvpqte7XWOlyibl/jTtboglIdNd55v5ekNjoUKpMtVH89W?=
 =?us-ascii?Q?OFQ2xZHbOJ5uLKoz5bhISB5hZDIHXbCugJsHanQboUt7N/aYqGVSy9DJQCuE?=
 =?us-ascii?Q?w/ZFSXvXDjo6uzLyBT1bTlUrpNaZ3T45hCdDVC9d1feI8c68KSZV2OOojjA3?=
 =?us-ascii?Q?H5aE5iwSTacvKhVS7MS5xNpE7Hs+099XMw17JwnXNtcFhh01N+csoDxl64gr?=
 =?us-ascii?Q?gANzYldh4iyC8A1aDSh0jXy7rI8Co12P88coQb5gJKiQcEMQsLKOS7EifsA0?=
 =?us-ascii?Q?RdwJ8fueNBIcjw77YbMq1XmZWos+V6DXoQe0CcGWGQcXLeY4+anOgkRZGNT0?=
 =?us-ascii?Q?zxJQjoYGtVFyV5HI3Xe4KQ84Hn3sVBm815MLgx66f+2/tlmu4L8E/Uqgn8sI?=
 =?us-ascii?Q?ffZuiFdLtrGLxDLrlBB4gtQ25ur46g1h/bVOi/lSAQq+qZjWBDn7Y4eOhzw1?=
 =?us-ascii?Q?YgdYRY0tFaTqeElbhu8nvtFnbN5/3/imUtCP3hVB4A0OBVdtw2ESKQWtVuuC?=
 =?us-ascii?Q?xN0fK9QwhWUO4yOUNFIoipRcWMjcCsjVR0AQ/3q3HJKLPXWsNf/ALqk1elO7?=
 =?us-ascii?Q?TZPe/ve9pNfROvP7W7mzw+Mek1S/xt0H8MNYS124n1rsOZa4tsPF7K6lYP0A?=
 =?us-ascii?Q?++evuk/GCnCcM6iIBrTY5jooBwr+6LUHVNSGfcmzJdYih9uqadd6MNtC50wO?=
 =?us-ascii?Q?Cw8yuXpA82S1UZChwWxjgJ2HCdfzGTS/urpy9BNQ2U3s43O6h+7KUoVaMUWD?=
 =?us-ascii?Q?UiM5CbApCNqeE0UwDTelM3/7OxD6bSRLxFjwcRg4PZrH81HqYOOiznVsakh8?=
 =?us-ascii?Q?Q5bsyYXW5QVg5TnZLyqaj8lKXTfx4Mlbgxb11D+Ki1016MCyhQ7kOy6QcoPe?=
 =?us-ascii?Q?2IX13eDew4I198BCYeQh78uAJ6HJ3wPdVrp/Q0YdVrXfODOY0AU1WdpAIls3?=
 =?us-ascii?Q?lDEVzGUYRhZgVAQWGEYeGtLEIA5COZB4j+zxj5d6KjbCPbENaALF/A/BEsHh?=
 =?us-ascii?Q?olPmwwS810+mKkj7oXoV+HOy/mL81dXGeEP7yDDKK7jnXOaYC90E2FaHTpNS?=
 =?us-ascii?Q?VUniTjDQ0A0FhJYT2JyoASkw8idhLro+JyLgDSERevdneKoQ/oASrmAW8gna?=
 =?us-ascii?Q?WXIhw2S6C2tycH6osG5s69JCaRSRCN5qqqmSFUabspBCoYG4VwI0De/7NYhU?=
 =?us-ascii?Q?NJ5s5FN6frYc9DK7qR7YYsUYoF8uH6g3fWIg2pd1RMCHn3ZOOzqfsnDGIwmn?=
 =?us-ascii?Q?1B258mph5CFAH1nXVTY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:26:16.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d64e134-bc7f-410c-fab9-08de36c1f2a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

BO VRAM resource maybe on multiple blocks, use resource cursor to
handle MQD and control stack GART mapping.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 29 +++++++++++++++++++------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 43009d3809b5..47923c632f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -888,6 +888,7 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
 	uint64_t total_pages;
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
 	uint64_t page_idx, pages_per_xcc;
+	struct amdgpu_res_cursor cursor;
 	uint64_t ctrl_flags = flags;
 	int i;
 
@@ -901,18 +902,32 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
 	pages_per_xcc = total_pages;
 	do_div(pages_per_xcc, num_xcc);
 
+	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
+
 	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
-		u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
 		u64 start_page = mm_node->start + page_idx;
+		u64 npages, n;
+		u64 pa;
 
-		pa += adev->vm_manager.vram_base_offset;
-		amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
+		pa = cursor.start + adev->vm_manager.vram_base_offset;
+		n = 1;
+		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
 					   flags, NULL);
 
-		amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
-					   start_page + 1,
-					   pages_per_xcc - 1,
-					   ctrl_flags, NULL);
+		npages = pages_per_xcc - 1;
+		while (npages) {
+			amdgpu_res_next(&cursor, n * PAGE_SIZE);
+
+			start_page += n;
+			pa = cursor.start + adev->vm_manager.vram_base_offset;
+			n = min(cursor.size / PAGE_SIZE, npages);
+
+			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
+						   ctrl_flags, NULL);
+
+			npages -= n;
+		}
+		amdgpu_res_next(&cursor, n * PAGE_SIZE);
 	}
 }
 
-- 
2.50.1

