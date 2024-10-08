Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE89CF0428
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A62A10E25B;
	Tue,  8 Oct 2024 21:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E8zRMBl+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE3A10E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPdua4N/YjeFFAslAXUxZYuE4gsOw1IZsDtS8014sRpPkecX44M5eqILs3VBbMpe5547Js2ekSAKWHXdt5jKn1MOrSYt+pOxn5aicSOeTvVRC2fuy8M151LI8ByawjLT/4sxLkw4wSNfrVIX0hlSordVUil4k2TqYrLmKVZT1lueVNik3h6//0+0akzsPjIVvIZrqzNFxS80bt560Ql20ooIra3IMaaSbiBVuKBxQ9JYvLt+r4WEURAiylgKiLFKxIL6pVTBaoGt6cqjmMuuC/iZEgwlRNv6+jVaD0BnlL2+yY7LhPNhYhRJ9hyPao48Vzt31WnJZBMCjW3oohL39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuKMETWQ9yk1l/xPjMNWm7O5PLZsLvElwc/UxMd9cb0=;
 b=VEcudlsL9hjVC4bJdksS5EwlfoVjmQBZFpmQSyrmrXkrIWM57M6PG1DdaH/A4M8Uf4oSH9iZ9wPoBLEEaR+u+McJ1quvwLtsQGod86h20fAEVX/nWAownwxFDSue4jaLK665Cct7rRSHTWG1NyZV0vuZcRP1yKUHDWwuBlspqrvfRE3UgC6vkKHvLZFptqpaxnMDnePKYvIeNQTxLYhc5tEkq/9mOUrkWZUocTK/hkxEg1PYK2jw8E/ahtPVRTIhp5sfWJMPTsh+rar8Syhr6gV5TezuBuf50cC9aTluJQNJbXj0XAVM38dGVYf0bh7rFVk3vC0sFZjbp8QhIfqOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuKMETWQ9yk1l/xPjMNWm7O5PLZsLvElwc/UxMd9cb0=;
 b=E8zRMBl+P5BNnSjY3N4i/1PXAci6zyzUKxSmsAb2hY6Q/HtiBr7aTfA4+YYH6arl6hzo68kLHFo7mENtuvwnw1DviaPdxwtQT77kTfisRHLQU9zCkGWq4w9C9eF8WB5RQTWbUb2iLmkWFpUwBKWFZmm+eR7DaLTxhI0/7mCyqsE=
Received: from CH2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610::33) by
 LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 21:16:26 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::5f) by CH2PR05CA0020.outlook.office365.com
 (2603:10b6:610::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:25 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:21 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 09/32] drm/amdgpu: track instances of the same IP block
Date: Tue, 8 Oct 2024 17:15:30 -0400
Message-ID: <20241008211553.36264-10-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: cdddcd51-bd3d-4f10-305c-08dce7de77ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?US9UWE4wRm1nVHo4ZEoxcjRqWDZJSFY0ZTRhVFFDTkZQZzdSUThkYTJKSXhP?=
 =?utf-8?B?eXZONjlCbjdHWnpMeWJKY3BYai9sd0w0Y1JrditKQjhWbHhlL2lPbk1sVjNk?=
 =?utf-8?B?UFd0Q1hEaVNLRDhVV08vQ2hoMFpoSlVLb204elpsSmVJZVZxcHNrUXlrODhI?=
 =?utf-8?B?NHhYby8rSDVHZVpCYVFwVkJPeFplZTZyY2ZDaFZGYzFXcDBGeXZoQ21UMVpO?=
 =?utf-8?B?elRHaU83emNhVk9EYXN3aC9BVENuYUUvenprSmtJRzhFbjBDRnBSOUtSLzFu?=
 =?utf-8?B?VVNvT2RRMzVSTUtZYWQyLytZV3dvdFJNejh1bG9LR3M0aFI2SzhISVkwL3lr?=
 =?utf-8?B?MFRNYm9Cd2cvMDZ3c0lzUVVpUEtCTlBuYWl3V05hVDR3UWw3V1JDRWlDVVl0?=
 =?utf-8?B?VHN3WWYzVzFiblVHcUhLMGRXdWl1ODhVM0FDZTBkbnI0d2lqWlBLNU5FM3lk?=
 =?utf-8?B?bHhUT20rcEJ2MjFjV3hlWGFBM1ZjaGFTRkJuRjY0cU1wTkpSSFdBbVkra3F5?=
 =?utf-8?B?aUxlL1Rzd0tiMWJwa3F0VmgxRzd2N0t0WTBNWDJwMDFDTHNOSVhUbnFLQURz?=
 =?utf-8?B?aUpqUDN0aWgzNFJHdHdjQW9JVjVvSmdCYTVyNjJlUmYrUWg3ZkJQU0s5clFV?=
 =?utf-8?B?Q3RObTNBV1MyTDlndkJFYTVmck92YXB5dm5lWGtsRFNFZmIyK2J2UXFVQTZL?=
 =?utf-8?B?RUZXWDQ0b3VkRlpWbEdlWTBvUXVNaHlQbjBpTTh3Znh2SGN0RWtLb3IyTk95?=
 =?utf-8?B?STBJSHc1UU5xTTFxRituMDdYcHhZMitqQnVpRVVlU0VtK3FFMDhBb3BVYTRK?=
 =?utf-8?B?allXV3hjTjhtZGhOb1hYNnVlRERyS2ErdjRWT0F6dWM2S0tIbTJVcVd5Ty9a?=
 =?utf-8?B?b3BYNGtkamlVaXkwRkVWUDhjVHlYdHR0UXJUNHlHakpnVy85RjhhQ2dsZ3BL?=
 =?utf-8?B?UDY3Z1B2WW1aQW16cGJOMUo3MDNpVXhnVlBCeGgyczZOb2R5VUpkY1kxakRj?=
 =?utf-8?B?WTNlWlIzaVIrTUVvTE5KK05mbWlKT3NRbVJUbWFUQ3Z0WmxuOTdlelJlWWxD?=
 =?utf-8?B?L2ZUdTBWa29oZHlKN0hBYmlUR1o2ZkZKVndlR0ZBSzUrcTFwdVBFbEp4NkZ1?=
 =?utf-8?B?NlVtZERBQy9nNzc2Wlc1Y2kvYkp4L0RnZldtK2t6MkpSVmNMZllKSjB0Vkk5?=
 =?utf-8?B?aTc2SDlsZ2MwNERRUFNIN2JtWTl0bXdNd1Zjd3EzL0U5VW45MUZSTm1VaEhR?=
 =?utf-8?B?elNlYTMrbDZKYUtPTzBNRDFXNnNHMk50ZzNqQUlsanA1czIyN1JNTlBQdmRW?=
 =?utf-8?B?Mk11aDBRUzYydVA3MTJ3c0dVUlk0TTU5bzdNN3hDZ3J4WHVCMDR0Z00rSjZx?=
 =?utf-8?B?bGN6aE1ic09pSTFxNEtxanU0eGpiaExlYmR3ZlZaM1hYZFZjM0dpOGlKKzBO?=
 =?utf-8?B?WVhxVktDdWUxMWoxTDAvVGduVE1nNmN6WjZhTW5TV24xK21SY1pSeHV1KzRj?=
 =?utf-8?B?cmE1UkZwalJQNDVCdWlQUGE0dVQrdjNaZlF0b0lDaU1HRVp4TjcxWU9Ga0xZ?=
 =?utf-8?B?NWdoQlQvbHlzaEwvL1ErUGt6SVpSa0dnUnVTdW9FK1JmZGZBSTRuOG9QRGky?=
 =?utf-8?B?bDVRdDh0TFRJMVFxVEVucHRlZS9EVVdOd2NzdThMTE0yUFJ0cDB6N2grS0Ja?=
 =?utf-8?B?V3lHM3kwWm1ITXRhck9WK3dsU2tPcVVTa3l0aGp4WUVBeDdVTC95UEZnNnJC?=
 =?utf-8?B?TjNPaFZuUUJ0UnlpZHhaSGpxdFlwQWFjN241REtXUXhsWkpuWXRHNjlRbjc1?=
 =?utf-8?B?WjArQUZuZG91RTVFdnZ1bWNvL01GSllqV1JGZWxuQ2lDcTZybVlIV2phdDI1?=
 =?utf-8?Q?F0KlOJ5XcE7An?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:25.6075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdddcd51-bd3d-4f10-305c-08dce7de77ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
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

