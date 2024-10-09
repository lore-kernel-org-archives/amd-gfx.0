Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF794CF043B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 03:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A7E10E633;
	Wed,  9 Oct 2024 03:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Jbtv8Qv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1C410E634
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 03:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1/KskUxKePcvQpPAHxXpYIChIf07w8Kd9fkl4AwagVZoGacpaqLBO1OBfvwHDJu/n8ZdRgpWJZX2n2O520K9+8iZl3t97kI8jmyvCfI5DA9GXRf4Yw+IB5TPQ3Aif0lzjzHx3vRr+AUPdal0sUiR94yOiufEP3/69QhdgCCnttAUKrcbCHHv0nFUcGzS1JV3e+oLWd3cUVItlRRkBpKaWOsFT1rzdavUORkav8Ftrjdnte7p5qybwdRqtm4q9Ar3nSSr4QWsG4LZDa7qeUVgk2RF6r9J3CgbaDVisyTtJzTV8FM47/rV7uQGwkbWfLTbS8ymXjj+gdnNA2VSsXVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zCOQvedWZ8XAqwqYqRGzSNEDedVoY5KjFTighnwjW0=;
 b=yBZp1a7mp1O1BdC5BAx7P7S5KbUy6N2hZgIErhvNyuMFITMHOPKQOVdHfRS/yjCHp4+0qgBRNxX09eVt+UOjxOfXxBCoEiyK8tekjLmrXeFUQgZwKH9s9DFER03vS7zIgdXC4ng8mB0x471rM4tOy5gKCVZ+OCKu7GY9e7VIkBxsmMOlIFPpY3fa/Gjzq4zwoZLqEX+rjO7YVK9taKreqCi+JuAWAzI4DGy8eREqA78OW1Ut62GoZ7KgTG1p5Jb+xS9AJT1nkZde0ETFlYY+/45iVtovMHFwurV5WwpMg5OJBGfSMmur11fwZzOg12egM7erbj1MDHWu+G8YqJ0wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zCOQvedWZ8XAqwqYqRGzSNEDedVoY5KjFTighnwjW0=;
 b=2Jbtv8Qv874QQM2XGNDhrZQz6EpohWvYS3s2sI7DKbYfK0DcKo6wpmXKL2xM0zHU7akKDmna0el/DznUC9i+U/UViE54HnJ9GIyrbZBBxo59ID1qH1fPvD76bTRyh3Lr9aRJda4ugW244nwz0ViRfcqjkMG4GvJcKZXAWzD9WE8=
Received: from MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 03:43:13 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::b9) by MN2PR03CA0015.outlook.office365.com
 (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Wed, 9 Oct 2024 03:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 03:43:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 22:43:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Harish
 Kasiviswanathan" <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v3] drm/amdkfd: Use dynamic allocation for CU occupancy array
 in 'kfd_get_cu_occupancy()'
Date: Wed, 9 Oct 2024 09:12:31 +0530
Message-ID: <20241009034231.366002-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008135108.108253-1-srinivasan.shanmugam@amd.com>
References: <20241008135108.108253-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: a3857124-e504-46fd-44a6-08dce814802f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGtHSTBId0pyb0ZsTWREZDV6WXVnWkIwQnBnOCt6Q3ZNbk5RRThlQkRUd2Yx?=
 =?utf-8?B?Uy8wK0lzM003Mkl3clljSUJxZ2FPekgvZFlQdGt1d0RiSmgzcFJjdk12Qmh6?=
 =?utf-8?B?YjRLRTc1NEtsMkloT3lqeG1MRi80Nm1qd1dzNmFrN1ZVOHlNMDJnMHVvcGJS?=
 =?utf-8?B?NW9kUXRDbTFTN3VQTzEzcTVQTEhTL3NQVDFWeEdSdjJ1VE1SbEc2a0E1OXRs?=
 =?utf-8?B?L1NYZnQxRVk5VG9kVXRITml2R3lxaHAyY1JENHNZdUJXR3Fta3hDdVpJc0Fy?=
 =?utf-8?B?SE1PT3h2N0w3OFdVM3h1RVlVUkh4Q2JqSUtRdHorUVozUVZ0KzRQZ241UDdl?=
 =?utf-8?B?ZUx6NHF2QlVBRVZtazVNbkpPR1RkT2l2S25abXlZZ0NsQzRGQTRnaXhVWnlG?=
 =?utf-8?B?WGgyRThWUVFMdVdHK0o2RElJUmFES2w3Z0MzTTJoaDJrenErSnRKekhhUzho?=
 =?utf-8?B?SEh0TE1QeXRBSHlDZ1dKTGQzM3B4Y0JLbmdxOUhwSUtiMkwrb1NmYzQ2YXRM?=
 =?utf-8?B?T2dqakVNUzI4QlRjNlRYcVRQY1BTT3FCSTcxVklBcDJ5ckNMK0RTU2cvaHoz?=
 =?utf-8?B?dEhJaDlXOTN5aHZBN2hPN0w0ckpFYVV3bUlEMHJjNURURlluOGpFTjVjZWxS?=
 =?utf-8?B?M29EenBBaEVNMDcvc1JTc294SDA2Vkl2UmsrZGwveVpUWmJoeEhpR20yV0Q4?=
 =?utf-8?B?U0Q5QlJ1bDVJcmpVRW9hSlVmRmJIUXJiUEg1QU5zd3RkaXUwRVcyaXRIQlR1?=
 =?utf-8?B?SXVvTEZyTzMwRkFORnQzWFEzdCtDTVUwbzF6Q1cvSk5uNFg1UzJ1NnhqTVBm?=
 =?utf-8?B?enJQTE80K3pmdXM3OXdDTXB5TnovbFdRbjczY085aXhXTFNOY3k5bkw3Ym9D?=
 =?utf-8?B?Q0s5QlpKUm43QWhDK1NhU1Q3d3cxSFh3RDMvSEFVS2Nva0JlRDBpVU9RSDNx?=
 =?utf-8?B?ZTV1RnNnQlNUTzBXUWI2bFFhbEVWbXF5elpJVGFTamI4VWs5Q0d0SWlJSXZK?=
 =?utf-8?B?UXVZdkY0UTN0VEFNUVBEUDJJbVZhY1dFUTJwbmo1UGYxT3NYcGJDUGtmY1NI?=
 =?utf-8?B?aEZPUEFwbHljN2I5ZU5BUEswZ1g1RFp0Y3NIN0pwdWFxb2RGNXhJaXFsN2pj?=
 =?utf-8?B?aFF4SnNVS1BwTmpGU2syRGxJQ09wMzVYcmNnLzNMS1dnR1ZRVFY2c2JNQTVp?=
 =?utf-8?B?TzJJcW85bXV0NmFsS0pPbFFsMVl4RE9sa3JPODdRMG8xRXNRaXh6K0dJcURS?=
 =?utf-8?B?RnVVWHNlMHRyd3VGU1dQZlZhYjNJa2t0eEFSYVUvcUQwRHhGRXJYd0s0cHlL?=
 =?utf-8?B?dnk4eE9CV0FmNlY0M0xXU2RRTTB2dHpPMHlWaUNwSWdLVitrQ3M5dFdoR2d0?=
 =?utf-8?B?Ukd3cUZxcTNTd0JDQWlPNjVWeVQxNEV3VHRRdzVESFc1bitTK2oybitsSDRu?=
 =?utf-8?B?eUxGNXMwbktwMlhNOC81MjFTcHFrUlhVY3VwV0RnMGJ2bDF0bVpwcjdpS21B?=
 =?utf-8?B?aDYwcFBGWitxUFJOVVVEK1RQRk5sREVTSnA3eWVnVGhxNUNUQmd3OGp4cGJj?=
 =?utf-8?B?SFhCV296NzZsWk9yY01YWkNWTC9lMnZvODU2SktuVUhzWTVGZ2luUVl4Nllp?=
 =?utf-8?B?MGJMOUhZWlk1OGdueVdaWm5lQURRWXdyOWNHZzhpUzhBU3VCTTgvUzlybUl5?=
 =?utf-8?B?OUpONTFTbi9JcnhjNm5zODNYM25JRXRXeFY5UE5aQlVCSGVScnRtbWsvbFBw?=
 =?utf-8?B?SXMwWVRFNW94MFBHKzJWT0lNUUFRb3lwRWV1V09SVTJUcVRGRGU3TG1EVFhw?=
 =?utf-8?B?R1Yrb1pGYkVpZDZzVFJJMjlEenZXTVd1ZGRYblpsWFZEVitBRTRuYmdiUXR6?=
 =?utf-8?Q?SA81BRzDzwk2Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 03:43:12.6714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3857124-e504-46fd-44a6-08dce814802f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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
v3:
 - Remove unused "bytes_written" (Mukul)
   fixes the below:
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c: In function ‘kfd_get_cu_occupancy’:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:276:13: warning: unused variable ‘bytes_written’ [-Wunused-variable]
  276 |         int bytes_written;
      |             ^~~~~~~~~~~~~

 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d665ecdcd12f..45fe75078b73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -271,10 +271,12 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_process *proc = NULL;
 	struct kfd_process_device *pdd = NULL;
 	int i;
-	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+	struct kfd_cu_occupancy *cu_occupancy;
 	u32 queue_format;
 
-	memset(cu_occupancy, 0x0, sizeof(cu_occupancy));
+	cu_occupancy = kcalloc(AMDGPU_MAX_QUEUES, sizeof(*cu_occupancy), GFP_KERNEL);
+	if (!cu_occupancy)
+		return -ENOMEM;
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
@@ -318,6 +320,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
+	kfree(cu_occupancy);
 	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
 }
 
-- 
2.34.1

