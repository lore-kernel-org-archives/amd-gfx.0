Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55ACD3748F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017DE10E839;
	Thu, 17 Oct 2024 13:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jp+zo4xt";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0DF10E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jtco+rA3CwJzmZzvIqdWP9iL3h9AnoYN5Akbo0/pqO/ovFIXYZ1TP+Bg8TB3UipfLLwJ8ciXH2JPL1oNICk1q35cCU/NKcHbLh3VbEsKMGiSIJ/YzML6itoJGQByd7MITMGby9iZ/2ceMkq0U7roDK8oN4mBYTIuki80tASruNegHpTZcOviLBpSckgVx46DXKYKS5pYcoM2Q9Hc55ZjnztjJT+hWIA3YU2dQHfPhM0GTKbs+HB9HC7uZ5+rE3AaNLG1j/5uOZJRz2yHLD9R0/uMGFXCW34FTrctJCz7RIbprxGgXdcQLeA0MHDTwdGb0WAnp87amhczMFq4vZ+JVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuKMETWQ9yk1l/xPjMNWm7O5PLZsLvElwc/UxMd9cb0=;
 b=leI1Jwny7LGbkH99OoSSSuse14wMBNfd+wBdJaSAiu66SL+YqTlx5W3GmHAD4aX1eVODULhrhw8NzVoTILzQxqConcgTTPZ46pnhoc7oefl5f5rDNeYfq6HmnvI6SIaTD9GivZL2GqaXK5LX3m733h/ontkyFo0t3hujjNgS9tNUcKFASrwNxj/2GSABsjlqVEN3XBkH6CCovp423gupiFkBh73QJGeFCFmrYb6evz+yRhYnXCoRPl9dTUmc9YXmP94HTQ3EfvgKOVSGRrUCdBzZbfWAGugMXrBtrcKCA9zNuQ/7CxbiroRGE69Un8yS4bGk/TbMP+3q822M89a9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuKMETWQ9yk1l/xPjMNWm7O5PLZsLvElwc/UxMd9cb0=;
 b=jp+zo4xt6hEwnChBHd2xkXMmNnlkj9lf9iNYO2tKBun+qwKVVEWK0mU5XhRredkCITfjtCQBM+ldWXrQDs6lVdEXN725HAzl14GKiwxl53u9ztON/lESoo6dRa91ej5jjBSdArDFjlebTd02+f7RrZ4jIZB2iPVKuXbvWdVAXN0=
Received: from BN9PR03CA0882.namprd03.prod.outlook.com (2603:10b6:408:13c::17)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 13:21:25 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::d8) by BN9PR03CA0882.outlook.office365.com
 (2603:10b6:408:13c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:21 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 09/32] drm/amdgpu: track instances of the same IP block
Date: Thu, 17 Oct 2024 09:20:30 -0400
Message-ID: <20241017132053.53214-10-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c6969e-1a8c-4f91-a980-08dceeae99db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tzc0UExyM2s5UjY1c2dkS2U0M085TGtMQWVXTnJQblFOWVlYMzhxeXV0WXN5?=
 =?utf-8?B?QkFYbWhWbnhnRC9FSENvL0tEd2lCaXFwZmZML1FIbHljTERZcU55aDQ2NHFz?=
 =?utf-8?B?MXhFREluczVnRzhnSnZXOTJuRjJIYWhUSFJpUnNib1o5R25oRGEzV3pJdzE4?=
 =?utf-8?B?dzNqRWZidnhSRW1WTUsxbFYxS2k4SEhZeVd6Mm01UTNvQnN4dCtBUDlXZ0Ra?=
 =?utf-8?B?SE9YT3lnT0ZLclV4VUVySjI2bkJCRjhTRWFqbHRkc0RRWjNRa2pPUTFLTmFU?=
 =?utf-8?B?OVRFT2JKdVZjbC9CU0JIZWFLZFlaTWxSTm1UOHZmbXg1Y2Y4L05lUWVYVTBi?=
 =?utf-8?B?Y2FyVkxaaW4xckNscFJad2t5SjFwdysyOFdod0VXZVY1YUtoNTQvOFRxQ0Rq?=
 =?utf-8?B?WXhIVzJtU0wraENYWjRyU3A2UU84U3NoYm5LSVArS1J1S1BieVQ3VjFFU2o2?=
 =?utf-8?B?UCtxSWRjZjhZSGRUZzZjNnVKUGxyWUQrb1pMMVZmMlpjREN0QzlaU2ZYMlBx?=
 =?utf-8?B?bHlpSnFOWGRaaWdWTGlpMmhNWEpPWXAvYXk5eEkzVDhEMVN2cTVodzlJL3gx?=
 =?utf-8?B?Z1ZaNGgyeEtEaXIyTGpXR3JjTzNPalBuUFAzeG1melpQMkMwR1g4Uzk4WWVO?=
 =?utf-8?B?ekhvYlRiWTZaejJHVktOUy9HL3JxaEk2VHdJbUtRaU9nemVoZldOaUxNV094?=
 =?utf-8?B?SGxRZjd5L0c3YmhQV0w0NEtRRHhaMzhlcWh3citBUktMT1hqVUwwNm5XVUpE?=
 =?utf-8?B?TW9GdnkxaGhTRHBEV2dYSWIxN2psVEd4Rk12WEttSWdyaDQxczVJN212dEpR?=
 =?utf-8?B?RDJnZTdvT2w3cGFuaXVYbjFQWXkwMW5Wc2NHNjZ3ZXdSRHJHWWk4R0U1UDVr?=
 =?utf-8?B?UndKUVZEUFBYNjNwTEdSdHdDcHBsaTRNWXdvdGM4NDNyRkhraWx2QnZjS0pY?=
 =?utf-8?B?bjNnUUNpaVZnNVhxZnJnbUpmL2U2Q1hyTnpJQTl0SFYyaENIczBWc09iRVl3?=
 =?utf-8?B?RFRIZmdMeWdqQU9RSW8ybDUwekZpNWtjVTBtUFlZdVhuekk2TVpQY29jVDJm?=
 =?utf-8?B?aGhFVlE4V2RodS9QbFpnaDNnamFDOERudXJiRDNCaDQ1SnRuZFVOUVF1VGwy?=
 =?utf-8?B?M3E3dmdtRHE2aEY2blM2SERzQXRxQlhoUytheVgxQW1aZDhWczFUTnh4UHlE?=
 =?utf-8?B?YWlkL3FqY29oY01UZ0RYTnJ0WUlQM2dhWjRMRWNUQmsvVFQycWErRFkxM0Y4?=
 =?utf-8?B?c2dTdG5oMFBwVEhYeU1BT1dDdUFQNW9DS3NEeW1ZaW5RQk5wR3RlRjFvKzkz?=
 =?utf-8?B?b256QjR1dlFJRlo4ZStBdWpTd3VTSFNSRVhsTU1tcys1YUIwQzI3eWhVekho?=
 =?utf-8?B?aDJsNUR6djZMd1FnTWpac0ZpZXRCS2NNSFkycnRwWXdlNDQzZmhJODF3NzZ6?=
 =?utf-8?B?aDZhMFhtTmtKbFpTVGlOYXhneEpVUld0bURlR281a1Q3czU5ZXFNK3k3Z01G?=
 =?utf-8?B?dk1yRUpCQTJxVm96T0FMQkoyMW53T3FuVS9PZVNDS3dDcW9DZkVpalNmY3Jz?=
 =?utf-8?B?bjl6VE9tOHc0dTR2VEdzZ1YrN0RrZ1lXMFJsR3MvKzN0ZVQrUUI4NHhWaUdT?=
 =?utf-8?B?VGw3K1NmY1ZtdWROUy9zc1VTWkRYWVlaRzJEMlcwTnRzMVhOb3h0YW1aMFVU?=
 =?utf-8?B?WVZ4OWtITktUUlU0OVhyVnhWNC9FU1lJSE5xV0tQMUs3STdCK1l5VysyOEJw?=
 =?utf-8?B?MUVja3Z4VXZBSXhVWmU4SldJMVN2b3V2UUZCeTJLcktabEszMjRYTUg1MTlt?=
 =?utf-8?B?TDJrTFY1dVFJQVVoTGRrdnl6UGtnSkhLc2Y3cElGN00wVFdQV3hIZnBnbjJD?=
 =?utf-8?B?R3JldnhscUhnaExKZXBEWk5RdnhsVk00WWdMY3pUcDdnYkE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:25.2016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c6969e-1a8c-4f91-a980-08dceeae99db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add a new function to count the number of instance of the same IP block
in the current ip_block list, then use the returned count value to set
the newly defined instance variable in ip_block, to track the instance
number of each ip_block.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..3442564fe174 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -387,6 +387,7 @@ struct amdgpu_ip_block {
 	struct amdgpu_ip_block_status status;
 	const struct amdgpu_ip_block_version *version;
 	struct amdgpu_device *adev;
+	unsigned int instance;
 };
 
 int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index af159ebe9cbc..426beab725b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2283,6 +2283,28 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
 	return 1;
 }
 
+/**
+ * amdgpu_device_ip_get_num_instances - get number of instances of an IP block
+ *
+ * @adev: amdgpu_device pointer
+ * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Returns the count of the hardware IP blocks structure for that type.
+ */
+static unsigned int
+amdgpu_device_ip_get_num_instances(struct amdgpu_device *adev,
+				    enum amd_ip_block_type type)
+{
+	unsigned int i, count = 0;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == type)
+			count++;
+	}
+
+	return count;
+}
+
 /**
  * amdgpu_device_ip_block_add
  *
@@ -2315,7 +2337,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 		  ip_block_version->funcs->name);
 
 	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
-
+	adev->ip_blocks[adev->num_ip_blocks].instance =
+		amdgpu_device_ip_get_num_instances(adev, ip_block_version->type);
 	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
 
 	return 0;
-- 
2.34.1

