Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDECCD2F7E4
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 12:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623E310EB07;
	Fri,  5 Dec 2025 12:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z0MpMOE1";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF53110EB07
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 12:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnEp4gtKhwED8FgtzFtTFuW1ZF8FS4DJblqlLxDY5xmRotH1EusUVGCOr4G3/w2B2kCSOUAEcTD2Jr81W1E4OD8pMF1AcVUd6XHMy9AwPfRreGr6Fb/Nw4+60iOtV32j40cEasHfjimfXtL4XMYRYb5ZEF+S5tG7C5+bbIY99++HA3XauBAHvRKqhhVHbjixiw+vDEaq6ZNzmdPM6ThudwdXe+2JAp/M9GNjk8JGBakgzqoUxsgAMWNq6jKZ8JEdXkYb4tCkPa7p+qnu1hPM1xICex0C6uhaO0Z+YlTAjlQTSXwKgxPOZ7zhWlwoxFzyGqzdKhCP0+2rnNI1ZSVtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFa2gETYUgmcc8QpxGD0MwNqbFuoaRuxVlJWQ290+m0=;
 b=qx6LWJsr50xdZJGWFhWHCVLkohxpedwv9RHAjkE/75QQQP8/iJjU6RexkZNu/Ue7L/MfQ/eOH5/JypcaiXi+P9aLBdwkOjm4TFHpOUYPXei2ZPEMOEctD7PuO+NRK/LTVo/aF4sqssjO6wcfPOL8+VfKeY0A8sZ3rjdTDCJLLqJarrsc3bBJpdcS2oW0AdXqiq+rA7Kl2H6LrIW8f2aCy+BItshnEwfAj6CiAISOlzCUd9tkRUAKV7M5Wl7ss2l8X7qeoKUiSTsjUDT7vDSbc6PKKniDext7ltiTMJcJMGED6b23E/R+FwD8Yv33CL44DhKV8ufrCsxtog3ibQgdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFa2gETYUgmcc8QpxGD0MwNqbFuoaRuxVlJWQ290+m0=;
 b=Z0MpMOE1u72w1ZLGvj/Tmmwhr7D/Ra1hPFTcT8gMtmQrCk84G7riob+IMSWZ0y7IbTPmuENdmJoCJsWx22RDr93DLktKKnMwqHceLptWZynarn/z78wHKypOhRKWpCrkbJdzeTVnJloJUl1n2zyy0ACI0dnRcbL1xp9Q+oJlRuo=
Received: from SJ0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:a03:331::18)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 12:16:00 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::f7) by SJ0PR03CA0073.outlook.office365.com
 (2603:10b6:a03:331::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 12:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 12:15:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 06:15:57 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/ras: Reduce stack usage in ras_umc_handle_bad_pages()
Date: Fri, 5 Dec 2025 17:45:49 +0530
Message-ID: <20251205121549.408575-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a22ec96-3dd7-496e-1291-08de33f80d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDRnUVo0TE9DTlZCR3EvRnZBRHltYjZ2OVRBeGFVYW5sZVZKZjFIaTdIc0R5?=
 =?utf-8?B?WXd1N21aTHNDdFR4MEFtaFUxTXh4Z1hVVTd1cllsWTQyQ3pwaXFDWHJOM29B?=
 =?utf-8?B?cnRIN2VyZXFuMXJZMkhnd0t5b0dlZG5wMW0rSHIySmxIcWlob1FmUVIrbFNO?=
 =?utf-8?B?Y1F3RENCR0FTbFp0NzlNckRramh1TEdFclVIbHplcXcrZ0tpbU1LbkVtSmU0?=
 =?utf-8?B?UUNzMmRCMTRYWEtFczB6WDJxSGkzRFplWEE1c2ZDZEdkeWt5dDBKY0VHUkZS?=
 =?utf-8?B?c2VnMFpXckVqNk5uTEJDenF6MDhQeEhFcGQwSThXN0Nob3NBV0wyWEUyUDZF?=
 =?utf-8?B?cTBjclorK0UzckZUd0RkVDNEWG1qUlNSbWVNYlNrRzEwZ1ZpTTBxcGswWGM4?=
 =?utf-8?B?aklJUEhuYzNRSmlWdFZQUDJFTkgyZks1c0pRMFNKR0MwTnZmRWJUTEdFcVFX?=
 =?utf-8?B?WDdVdzZZYW9ZWDJybmNhOC9HNENJWnp4MW5uOXZOTnh4RmowYzZ0WnUyTVd2?=
 =?utf-8?B?R1VWdENVVDBkRDh5cmRCZlFSY0ZmeVZnNUprU3BMZ0krV2UrTENxZUFoNW56?=
 =?utf-8?B?Tm5pOEpqUFJ1cUVVcVRJQWdmaWQ5WGF2ODVZb2tRdHNvZFJBbzA3ZzgxclFL?=
 =?utf-8?B?MlZnQmlMVGF4S1RyU0N2UHh3QnlJcWRURHpjRmE0ME8wcDZmRG1OTTQxbTJs?=
 =?utf-8?B?UlU4R2d0WXZoYVhjbXlvcjExMTV0WkNNQmtmOStOckxCaVBrc0l4M3FVeTNE?=
 =?utf-8?B?Q3lyemVHOGg3MGJDdndNNnhLYWFIUVY5WDlMRTQwRGZBUFg0TTVmWVRxbEtE?=
 =?utf-8?B?Q054bWxHZk13N29JVVl2N0trcEtiRmVwblc5R21KOW50eEdSa1ltMVJCSFdE?=
 =?utf-8?B?dkRPYzZ6eHdhaUZDRzBXOXBFZCtyakpiR0hQYi84YTlmcUVqT1d2RVYzbmty?=
 =?utf-8?B?UFp5RTBwU0w0OEdOR0lBRUxFUi9LTExQNWJ3N1ppU3JlZ29MVVdwTkFsUUNX?=
 =?utf-8?B?aHMwQzl6WE01RzYrUDNyczhmL0EyQ3laemJFWVkybHJEVU9TemgyYTlPVTdO?=
 =?utf-8?B?aFZWbnErcVN2ZitXdk9kRG1jSkY3WFdQZFVLdVVvbTVpWmpmbDhkOEFxU3Br?=
 =?utf-8?B?bEtnUW5JRzZoYkRTSDE2Zjk4NzZBTnQvTWIxUFB2Q0l0VllaaHAxczZhZk4v?=
 =?utf-8?B?ekFEY3ZzRE1LSytKZ3VGMENTMjM3TUs4VlQ2TGtDZGpiNmtCNEFnOGkxeTVt?=
 =?utf-8?B?cGsxMm1aM3Vjcm5nbGlSNW9uY2dZcDVPd3NON0VkazNMNFRHblM4ak82RVlN?=
 =?utf-8?B?YlBpNFNmYVFMeEVvc3MrMURPSW54MmR4UEd1VDBHZFFxbGE3eXBTLzNXek9W?=
 =?utf-8?B?aHRoY0Q2TWZGOUtQMkszNDRLWWU2dzQ0YTgzUFhZcGFhbnBOOEs1YkI0cjVW?=
 =?utf-8?B?TjdIREhiblNjU25CQXZjV1JpZVBYdWRxU3RBa1lrNUJrL29OV1kwa3RrbFov?=
 =?utf-8?B?NEFTOXBPQUhTSSs1UmpZdnhlM2txcXI3S3pGVDZURFlucWV6ZzdpZUxaNEFM?=
 =?utf-8?B?YlJ3OVlyYkNXWWs0dXIveUlJMUxhMlAvN0hDUlEvNWFnRit5d2UzK2JmNit0?=
 =?utf-8?B?am5nWDZVWXlYZUtrYnJJbk5GTndjR2lrWGcxM1lMejNadUMwTGxjUVB5OU9p?=
 =?utf-8?B?OGpXNmxtWFppbWc0QXFSUnhhcDI0aVpOYlNUV25nVUdXZ1FVSEdZZWZOR2FI?=
 =?utf-8?B?Yi9TQkczVCs1dklzblJCNHdNWERpdm16aUlpOEoxNVlqYzFNZFk0ekp6SlZs?=
 =?utf-8?B?aTBtZkF5ZHByUmF2QzhmbVFkMXlNSW96RnVVSHJPcUJ5MzZnUFRjelZBaVJ0?=
 =?utf-8?B?ZktMcmZLR2pLZ2NLbW9QamdZbUVaVm9mNUxDQmU0anlXZmVJTXNKZUZwYlVh?=
 =?utf-8?B?WjQ0WWVOc0Y2N1pWdkcwdlM3dGVjN2F6aEh4ZmtWMDNMWFFQMng1TEtPd2k2?=
 =?utf-8?B?eFUwY0FZcGFzU3pwRUVmUy9jZWl4aE9lSmZHY3RRSUJJSmtsclJkTjlENmVL?=
 =?utf-8?B?MTNGOTJEMlVGcVh5VVJpZGtXSWpZVWxlQmpNTG1GcTN3VURTNnBVSVdNTm1l?=
 =?utf-8?Q?yB+4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:15:59.8134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a22ec96-3dd7-496e-1291-08de33f80d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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

ras_umc_handle_bad_pages() function used a large local array:
  struct eeprom_umc_record records[MAX_ECC_NUM_PER_RETIREMENT];

Move this array off the stack by allocating it with kcalloc()
and freeing it before return.

This reduces the stack frame size of ras_umc_handle_bad_pages()
and avoids the frame size warning.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_umc.c:498:5: warning: stack frame size (1208) exceeds limit (1024) in 'ras_umc_handle_bad_pages' [-Wframe-larger-than]

Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 31 ++++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index 4dae64c424a2..6061776b894d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -497,27 +497,44 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 
 int ras_umc_handle_bad_pages(struct ras_core_context *ras_core, void *data)
 {
-	struct eeprom_umc_record records[MAX_ECC_NUM_PER_RETIREMENT];
+	struct eeprom_umc_record *records;
 	int count, ret;
 
+	records = kcalloc(MAX_ECC_NUM_PER_RETIREMENT,
+			  sizeof(*records), GFP_KERNEL);
+	if (!records)
+		return -ENOMEM;
+
+	count = ras_umc_get_new_records(ras_core, records,
+					MAX_ECC_NUM_PER_RETIREMENT);
+
 	memset(records, 0, sizeof(records));
-	count = ras_umc_get_new_records(ras_core, records, ARRAY_SIZE(records));
-	if (count <= 0)
-		return -ENODATA;
+	count = ras_umc_get_new_records(ras_core, records,
+					MAX_ECC_NUM_PER_RETIREMENT);
+	if (count <= 0) {
+		ret = -ENODATA;
+		goto out;
+	}
 
 	ret = ras_umc_add_bad_pages(ras_core, records, count, false);
 	if (ret) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to add ras bad page!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	ret = ras_umc_save_bad_pages(ras_core);
 	if (ret) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to save ras bad page\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	kfree(records);
+	return ret;
 }
 
 int ras_umc_sw_init(struct ras_core_context *ras_core)
-- 
2.34.1

