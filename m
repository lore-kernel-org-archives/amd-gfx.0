Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB41C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 14:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2966610F239;
	Mon, 22 Apr 2024 14:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o34EcxF8";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E5D10F239
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 14:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4J2D8Q0fJXPLQw1GQ0P+Ucw8c/iSR55R6lx9lx2PCHJ7Ji8orzmwgASTWssjUcmYlw2a+YbxGkMLRHFUAvap1+DANJMiljGzolg6vycBGb7123mAOLGzjTcpv64b8XTsuk8mRFV58t+bKHH2MJciOVyBGHX699UBHFTiTh9xXIgWvX3AltjoEjpCK4wdG6zJcFIVmNdjtv0bJSP3BZYRtEdGAbIWUaHnYGizzb3I+vZwXZDRY/y3P8iUJ/W8eTROiJeWJmJd0C/M4FfZUJIwVG+XUWxQBwVeGoQwjBubPkJm6pS2zPy9zbLEm0/t7FcI2uvGS2AOY81NuatktNsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RR7Mus9lHGguklGN+d4USg8jMEhQtY/TNevesNxcLM=;
 b=Q2i/LPO3c0DycfHA2zJxBjsTk6m6Nsg7zY2mUiDcNy5HhKvo07r2F6LpOOWyXw7TJc471pc8Xb9HXXFqQOwjbQ54zrQP+gITNsUI1x5+ifvfYbSZI/ypkMHVdHLrMuwyfrey06Y6cyGEasAtas8qMgiJsPXb6HblUghh9YSLv2N/1lvePKsUL5MyL1VT+e+b04jOmQNAIufUeIr9cyjAt6+dUjexi0F5GBZ1XVOfxsfB4H/6Ldm8Iz60rtl2U9I8ezfTVMAOXFTUuSItcT/5MbuGLpYm3hgYdEUqOU+KraoDOq5xINkCSSWp/C/VNP317HokAlShgdfXZEwy4I0GrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RR7Mus9lHGguklGN+d4USg8jMEhQtY/TNevesNxcLM=;
 b=o34EcxF8XSiHyIzk/04AaryaIul09ZOo+5NHz7nzJ+wXlFYWVNcCTZ0XzR0AMxY9J1gMz7UkgV864r9PfbQuYZ2iRwsKd+cxzgMwd4mSGd43pl8Rtg2N0cI2gxZh/tqenrebbVl/lZn9r3trYEfAxZdqVHPBiAEg1bIGo0Wxw44=
Received: from MN2PR20CA0060.namprd20.prod.outlook.com (2603:10b6:208:235::29)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:37:54 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::79) by MN2PR20CA0060.outlook.office365.com
 (2603:10b6:208:235::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 14:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 14:37:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 09:37:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add a spinlock to wb allocation
Date: Mon, 22 Apr 2024 10:37:37 -0400
Message-ID: <20240422143738.322710-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: c116174e-f5fc-4a09-67b9-08dc62d9cbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T/mDvcIStLIU9NqpxeH6JrCOeHXuj8Q8l3SADIH2A4TyqWhFuw0deBWrDrer?=
 =?us-ascii?Q?+fkjhCfRPY2OaPvmo1Dy5BVYMEgXy7NirEDUdYYJCpzAcb0vzNCjd5z94oHV?=
 =?us-ascii?Q?t9246FNkaSf3/Vljubtsec3FBDT2W//6A86J/ITEvlXi7ysAeDTpxKDjQNhI?=
 =?us-ascii?Q?rIsgbwWzcgNINVHE0T7bacHo1ibRcdO88+Xng3lbQEUGd2OOKfbMPtoowPaF?=
 =?us-ascii?Q?R4dgqWAbY2sg2dPeAd7azRzxGkhC3L0TDacIwwsRWSxtDmV+0Xmcf6gmRjWH?=
 =?us-ascii?Q?fiWpWEoA9+1GhAJRjw9oGSpYTPlhMjXoSITIJuLl26ihsdP8laA8WTTynfNq?=
 =?us-ascii?Q?YALFVVhlpgLheQZXey11IllLnrVgw2E8UYxEI5J2NpMEk2kDNNeEhoGbu4Bq?=
 =?us-ascii?Q?MdK635i+kZJYy+JHecsPusXdMgSxuHlUSt6SEHD9P/V6CMgYV3NuSWWhK73d?=
 =?us-ascii?Q?4hPCe4JWpttsEfXGtCzkLxF47Kp9kJNQ8g1bIIp7yQFMcF7P83kBSzOTWJ9R?=
 =?us-ascii?Q?5m27FpYhQb+G4UKIvaJrXpgyOLF/yx2W6mvPr8Jc4rF63fLoET/lGOQQptAc?=
 =?us-ascii?Q?gFRcvSqKTP8+PmBtYfzHP59lGRmsVxZDQhGCO7gUVo3G2aJyZf8v9Nyh/mSK?=
 =?us-ascii?Q?g5tOVodGDQB6SlRFVpo0JGGp53/IH71G3roOBuA7jrW144nBVP6/lIExKbj5?=
 =?us-ascii?Q?OjovAD9cLoMWnOJpO0URjDCYyGRiDBmhOSl7ZQLuIduKEK6/YHCfpS8xJqVC?=
 =?us-ascii?Q?NO+KYdUzrs9//FfZIczBAq4QibT11cx5r4GohU4HlWQpvlFcXnc6w+ym2vQH?=
 =?us-ascii?Q?BJrJySdiee1g+xKfStcotLqf53w2AxWMj0AeMexL/MyTkbcWlo61Z0RG4ClT?=
 =?us-ascii?Q?kXUU729g1S/r/fWttBMNQOnTkZ4WVu5CdHu5tznDg3Wo10s5fbs1zjVrSlg4?=
 =?us-ascii?Q?UYqTrsdW2ri7qVrJCZeUcF3Wh8J/wQsRuU6ENw/jBDTUoZUQXwKjgffLOU+k?=
 =?us-ascii?Q?xgkYewUwYF66za8lJjuM50oCPH/5jRvIdgip5PUVvzoILLVMIfTD/tUUmrox?=
 =?us-ascii?Q?FQ0a9T0byxhEYfuGTujoJ8N3wo62BEypyK4qXfBPPBmhLx5sOw7KSs4HAy8g?=
 =?us-ascii?Q?r5q2hzDPmfYe45uxG70QkkaBjOQUkE++QOXP7uSwDyGao8glKLvwJVc3r1wB?=
 =?us-ascii?Q?Kxsb+gZ/Hllcsb5634Qjjzcn+YUjFFtBGCMbtW1AqO4KQS2UlwiIkLKADDET?=
 =?us-ascii?Q?F4GvZgEVyuC0r/pWVBnbZ1ujavJaN83/F/8TNRW0NRDvv2SUub/d1v1wItYy?=
 =?us-ascii?Q?iZPmP7ppx98assE4yO4/yNCbN1eBDyl+je84p7yb8LNf9dwX8vLWk29gy6WS?=
 =?us-ascii?Q?+7bz9Dc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:37:54.5108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c116174e-f5fc-4a09-67b9-08dc62d9cbc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
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

As we use wb slots more dynamically, we need to lock
access to avoid racing on allocation or free.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cac0ca64367b..f87d53e183c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -502,6 +502,7 @@ struct amdgpu_wb {
 	uint64_t		gpu_addr;
 	u32			num_wb;	/* Number of wb slots actually reserved for amdgpu. */
 	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
+	spinlock_t		lock;
 };
 
 int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f8a34db5d9e3..869256394136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1482,13 +1482,17 @@ static int amdgpu_device_wb_init(struct amdgpu_device *adev)
  */
 int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
 {
-	unsigned long offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
+	unsigned long flags, offset;
 
+	spin_lock_irqsave(&adev->wb.lock, flags);
+	offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
 	if (offset < adev->wb.num_wb) {
 		__set_bit(offset, adev->wb.used);
+		spin_unlock_irqrestore(&adev->wb.lock, flags);
 		*wb = offset << 3; /* convert to dw offset */
 		return 0;
 	} else {
+		spin_unlock_irqrestore(&adev->wb.lock, flags);
 		return -EINVAL;
 	}
 }
@@ -1503,9 +1507,13 @@ int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
  */
 void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 {
+	unsigned long flags;
+
 	wb >>= 3;
+	spin_lock_irqsave(&adev->wb.lock, flags);
 	if (wb < adev->wb.num_wb)
 		__clear_bit(wb, adev->wb.used);
+	spin_unlock_irqrestore(&adev->wb.lock, flags);
 }
 
 /**
@@ -4061,6 +4069,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->se_cac_idx_lock);
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
+	spin_lock_init(&adev->wb.lock);
 
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
-- 
2.44.0

