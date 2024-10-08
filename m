Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB3CEF177
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D064210E54D;
	Tue,  8 Oct 2024 13:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ezpqjbpc";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31A810E54D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 13:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFItdiCzvToafegv7o87/6ZNSdAFrAz4lAZNX4FxtLpUhXvLnmdDPLMc+F+FnsBNVOa3Nw6OlHvhE20S9awhUi7WNTqLpkFAQBrkxv0i5HCyT3BrfLj9WuTT6BL60D6DmjYV6o/b+JmeTb+lqlmYbTbSON3rJG8J5+zmoJmf2r3ro1M+KNej+57MbrzPOZQ2w7xs/jIVItFXSkQp6InoQXv72Hagyq9gvamquhZwe+jzrrqwIh5/GNTkVIma6SY0OpNzW+qsSUsN8qqeqQYh/LaBOI/IfXX0uR5a1aHnRsM1tofae8bUlhF0jPNAatXtzQKP+eR9+GvFKNa0A2Er+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRp087lHzNb+oQ8Jzxnc0az7yYtn50kAYj2MKQoaMEA=;
 b=KzIeC1/1jHMLiIqrqKxj8pJ+cnAHIcuf5bzDHqoErREnqmjyC50GNKGBXcJNK/Mx43oFTVNHtbSaCFkPzDGO/5zRSB6XV/iHB2L3tBHrxE5IDrXfn6NaFEsuWZgy0hlNyJIsauxMHFlEar9g1+NXnT0p/7VOkFXO6bymojE0StyVMJdyV9Yb6rHkD80pNd2kRH97k64DhVZ6lmu1kJl2fhLgZ7EI86+RIaVE5lvypqi7ReKCb+o4hBbEBErq/3I0SEyK7DHOvWtgC61TwneYDizUOBc68WnOf9b78rhMIzo9yN6D0BkOEpPryvd+IYNgxlykrn45l9CTPlvdWzNIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRp087lHzNb+oQ8Jzxnc0az7yYtn50kAYj2MKQoaMEA=;
 b=EzpqjbpcOTB6BPxEvZ6nVR2AdfMsTb/LcaqcFYzB9ay0d4TE6uSgKz8bbJM5LSYrrqtmP5XfUTotIvDDA5VTOI/048NlzXnhmYVit8/A7qK8kIck+hhmsRVrDjybfYeR96bJzdLilxCoxJA8ZibC6v4EACgdXdrukohoQMBjFL4=
Received: from BN9PR03CA0479.namprd03.prod.outlook.com (2603:10b6:408:139::34)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 13:51:25 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::b5) by BN9PR03CA0479.outlook.office365.com
 (2603:10b6:408:139::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 13:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 13:51:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 08:51:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Harish
 Kasiviswanathan" <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Use dynamic allocation for CU occupancy array
 in 'kfd_get_cu_occupancy()'
Date: Tue, 8 Oct 2024 19:21:08 +0530
Message-ID: <20241008135108.108253-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004034505.3759692-1-srinivasan.shanmugam@amd.com>
References: <20241004034505.3759692-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: d66d1c6f-e8e1-4402-7396-08dce7a04d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkRxTFd0VzZJZ2VmN2orZHhDT2tCN2plODFneUVUbHZDT3NBWHFsSWZsdi82?=
 =?utf-8?B?aEtZTHA2SlNkSFhNaXF6K0RqZEwzNFhHaDlYTUxrWkNtZVBQT3NTRTJHcURF?=
 =?utf-8?B?Q1ZoN3hiNTZmd01SSnNTYngwemlUdEVuV0VHbWtsbmVTNi8rMjM0ci83L0ls?=
 =?utf-8?B?TlZVM0NMRWl2Z3BPS1dzSkdldFNseWcvTm40RUY2UWZ2amhGZXFjeTJhVEJ6?=
 =?utf-8?B?WHdhMUFDa05OYzhpbFBINEYvR2pTdXIvN1k1eFVjbkszbjNBU2h2aEVCKzUy?=
 =?utf-8?B?S0l1MUhTZElDcHRwZCttOW91UFBWZzhaUXFRUTlZTUFuRnk0NjA1b2hhd0s5?=
 =?utf-8?B?Uy8vYnQ4TFFMUlFUcTNkR2RkMHluRC9jdnpuZ1l3T1JrZ29rNHdHWXRmTFhS?=
 =?utf-8?B?Vit5dHJQSFZTb2lWQUczNUc3aEF0aGJrR2MvTE83R01abTFvV1ZUOFI3RTB1?=
 =?utf-8?B?UllySk1ibXNsdVhOV21hRTFTVkJIR2dTdjBOd0o2QXBlc2x4dXlianlYNmFj?=
 =?utf-8?B?Tm9SKzJJVEpKTnBIMk1HRXpOYy9ibEZTVjNxNE16N1h5RHdNSGZvRVIzT0Yz?=
 =?utf-8?B?Y2FIaHBKZjlQVzFSL0s2WWY4alZFK0NpMWRIaVpmSFRNL0QvYUNlcTFoaUdI?=
 =?utf-8?B?UlRuVDFXSXpobkRqYll4b2xuS2lNS2RqeGhnYWtpYW0zdmQxTDhkR08xb2FW?=
 =?utf-8?B?ZjNpNTRycXNnMW5mMzNBcUorMzRwY0I2L1RIUDlxZmxxTHNaWkhmcy9lWmFj?=
 =?utf-8?B?djdHOERYM3lrUVFRUUw0ekN1NisxWjg0RkNUS2FCZ3FhWXBseEdwRHBkOGts?=
 =?utf-8?B?WFY2RTZxbEJldlhWaTdXdlFZa2l2RUNxeXNmS2xqTTkxWXVWT0RqR1lZK1I1?=
 =?utf-8?B?dkp0Zk1YU2puVXpsWlhhelVNcWZhYXk3S3V1b2xnenVsNmxPYnJuKytRZE5C?=
 =?utf-8?B?cWg3ZjVqbGdLcFZkditJNVdGQnNDVlpUYS9hWlIweW8vSEljZndWOWpnM3J6?=
 =?utf-8?B?WWhDU2JkV1BnN0FRcjNTOGFoWEwraElTQTVYa2YyQ3pxRHNlREQ4N3h4b01S?=
 =?utf-8?B?YWFaWlVQT0RWL1U2V1BJVFE5alJjVkxyZkRBYVlDT2luMVJNQzFlRmkvWUFn?=
 =?utf-8?B?SzhCcVdyTTFhNUZMMzNhaG1Ddyt1MW1uV0kwT1RWSnU0ZmpyUHhXb1V4MGdv?=
 =?utf-8?B?clBQSGtmY0xoWnZlNy9EbFlEQ2ZrT3krMmdJZldnMWRNR0s5S0FqdmZ5cmJV?=
 =?utf-8?B?ZWZnN3hqRjMyWEhrSGp4K0VkbFRybEkzTlFDWlFSL0dPd1A4ZHJzaXJDNmdr?=
 =?utf-8?B?TFZGWkl2K1pCWU1TYS94VEdoZE1TTkJKcFpMMUI5Rm1iRmJLdnBsbzhoc1NP?=
 =?utf-8?B?ZDVONXFaVVg3clN0eG5qVGRJMHpwR2ZqYXlBVk5adGRwaXVSM2E5WmpPUUIw?=
 =?utf-8?B?Q3dXcGVUL3p2c29lUUFSWHk3K0ZRd0o5UndTWXYyT2FDOE8rMUUyMW4waGxY?=
 =?utf-8?B?bGIrR0JsZC9SUEY5dC9TeS91TzFyaGg2TnlpZ3g2SGtYeWIzL2ZabThFU013?=
 =?utf-8?B?WW5NM0Ryb29iSHM1Nmd2UkVXeFN5end2OVRNNlRKRHZRdmN4MlZQRlJkdGFz?=
 =?utf-8?B?MkV1SzNJSDVXZFNaa2lwQVZ6QkE1UUd3TVlmR1lkak1CQVF1cFpTV0NrMlBD?=
 =?utf-8?B?eDBkQ3l0QVlkVkNqRU1vNTNVNHp6ak9ZRFd5V0p4bjFSbE1DWStGbjZEczJn?=
 =?utf-8?B?U2pIbzNJQVBuV09ocWtZRnFXb2o1dXN3TFFxMk8zR0RHYTMzTHVjYWdXdGxC?=
 =?utf-8?B?c29IYTdBNU8xRkRZQStEWlFRVlRkTnkwcDRURFpSSGliWExWS0FNeHc3azBp?=
 =?utf-8?Q?xx35x+7VEFp0a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 13:51:25.5118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d66d1c6f-e8e1-4402-7396-08dce7a04d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

The `kfd_get_cu_occupancy` function previously declared a large
`cu_occupancy` array as a local variable, which could lead to stack
overflows due to excessive stack usage. This commit replaces the static
array allocation with dynamic memory allocation using `kcalloc`,
thereby reducing the stack size.

This change avoids the risk of stack overflows in kernel space,  in
scenarios where `AMDGPU_MAX_QUEUES` is large. The  allocated memory is
freed using `kfree` before the function returns  to prevent memory
leaks.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c: In function ‘kfd_get_cu_occupancy’:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:322:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  322 | }
      | ^

Fixes: 6fc91266b798 ("drm/amdkfd: Update logic for CU occupancy calculations")
Suggested-by: Mukul Joshi <mukul.joshi@amd.com>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Use kcalloc for zero-initialization (Mukul)
 - Remove bytes_written call kfree just before the return statement.
   (Mukul)

 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d665ecdcd12f..186fc4fd3be8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -271,10 +271,13 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_process *proc = NULL;
 	struct kfd_process_device *pdd = NULL;
 	int i;
-	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+	struct kfd_cu_occupancy *cu_occupancy;
 	u32 queue_format;
+	int bytes_written;
 
-	memset(cu_occupancy, 0x0, sizeof(cu_occupancy));
+	cu_occupancy = kcalloc(AMDGPU_MAX_QUEUES, sizeof(*cu_occupancy), GFP_KERNEL);
+	if (!cu_occupancy)
+		return -ENOMEM;
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
@@ -318,6 +321,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
+	kfree(cu_occupancy);
 	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
 }
 
-- 
2.34.1

