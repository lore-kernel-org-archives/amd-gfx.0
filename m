Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DACD116E1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC66F10E198;
	Fri, 25 Oct 2024 02:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PwBykSgZ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B8E10E198
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8nPFE9P6mPdSrKDTqe+vvLtlc10clytgmzZH95EXjVM2VJ1HbpbhUzZQWKH4s5YiqfxI1CAR3UuMId4XZh1zwgcZTTI63FEmfRaLwTAljkcbDa2mJAWGzPDACQ91UYHpyphMml6BLjL5XWZudnf9A1a/CHR94ZXcIirT4DwijyxpuupDPzfdirr4xce6d/2wKVHIkMkklYMgZ85KPPdKOGwvlEnGmUQDRJUjeEK+EXs5iAdHhRbWES8A2/6QoJZmTlEGwa3naQ2CVUe3wHkJkll+b9J+yadd3j6wimRaLOvciqdXKXRV+VzgGzprwTOirhzJZTQqGpw4jSiQJyB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD9uWqh5/UBCcu2V35hVNDnE+L5MIzHSM1O3E80DPc8=;
 b=sDz+ohhH5UugEQyJ68qQl1SCuZIE/nmhMMtOKbHIFkiZf9rmEsY8dQ0AJVEBLxFZJC8VvHpKeY30KKr0EZj68ln9MH3iFuwcfBs5D0cHIcv0lR2j0JTkUcr2C/KpQq1Fs8JuR7eLU7NkZwpoPHJB3ONvskajJXTDqyNUvx0tJoJBnUR4RJzoeR8vEk2XTEsUf8uEkAcr8O+v6L2MPijc/ACfmyCFHX6R5xJJ+6QO4IEef7Ao08vnGZaNWM9wsD9H8gjerHIouVUnYByPMxA3aVI0Dn/gug5afbkfWNLqIXU6J7aqhCMb/ZnVQDR/qPs3axcoOB3iFWqGggYf4oJhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD9uWqh5/UBCcu2V35hVNDnE+L5MIzHSM1O3E80DPc8=;
 b=PwBykSgZqKOeoCHSEh/ijAr19UJWzp6ZT+HpHC7etGNkAZyO2N+dsRI2QO6FAMccTy1qvpGJhpJFu59kGEt5FRxcD2JaGr6w/OdfnjpdDjPdxJrqRvAbl8RNfifC1vk4plNuy4zLQYhSJdXZQBukQM9dzwQmmEaTP2oyeIyNv0g=
Received: from PH2PEPF0000385B.namprd17.prod.outlook.com (2603:10b6:518:1::69)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 02:43:46 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH2PEPF0000385B.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Fri, 25 Oct 2024 02:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:43:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 21:43:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v4] drm/amdkfd: Use dynamic allocation for CU occupancy array
 in 'kfd_get_cu_occupancy()'
Date: Fri, 25 Oct 2024 08:13:28 +0530
Message-ID: <20241025024328.3657725-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004034505.3759692-1-srinivasan.shanmugam@amd.com>
References: <20241004034505.3759692-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 055cb742-fb56-4462-b4c6-08dcf49ed8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG5YVGRuWTd4SDNLUXdFTkszaFQxUzBDZXJQZ3IzZ0pKMm1SaGM0Rm14WnR3?=
 =?utf-8?B?MGhjRWlXMko1OElqOVYvY0lEb00yOWduUUlsNFdiaCsvakloV0h4VFVKMFNr?=
 =?utf-8?B?ekZEbCtKM3ovZGVTRUFSY0d1Y21CcjBVWDlZbXJ4aEhhdTc1TzVBR0F5UEE4?=
 =?utf-8?B?dGdTU1VTNVlpVXJTeWNNK3RJQWJUTlAxaCtlN1o3R1d5M0wwdEZXVm4xakJI?=
 =?utf-8?B?ODZ6dXkvcVkyTlpxWWZCMWtQbDAwRFpmSGp5aGlUNkhKZ1c4eCtSYU00Z3I3?=
 =?utf-8?B?cjFVQWNWdkQrZ3Nzdzc5Y0R6V0hQNFVPZko5aEhWblR6RzY5NEFJWkpGeWsz?=
 =?utf-8?B?aE1PK09HSCswWFNuUjE3SnBKRWRwSHExdWd3NTZ4b0ZSUG5OUlZGcWdyRjNV?=
 =?utf-8?B?YmxMR0owSHRBY2lxdlRRT0IxazZveUNVWXdQVTNhYllWTXZkb3U0Y0lMcSt6?=
 =?utf-8?B?TVhyOWZHeVVFVVRMWitETm9wajdrTVJFTE5Lb0tFdkNieVhrdXhVNTVxbi92?=
 =?utf-8?B?RFZqaHRtT09jU3BOODRLZVVMKzNoSEZGQ2dMc2V6Y2tNN1hpZm1TbjdERU51?=
 =?utf-8?B?cEVGMnUvTnVjTFM2V0hnRDBhKzRNUmd0WnVKU205UVA5YW0yNEZOV0t6WDA4?=
 =?utf-8?B?OWNmdG80VzlwUHZJYjRGYjVuT2pINkZCYlVxR2xMSXNmczBzNUpnS0dON1Mz?=
 =?utf-8?B?M0g0bENQWWdobmo4WUpURitRU0lVaVJuRGN6WXhRdFZlZm5pN2l1MjFyVS9W?=
 =?utf-8?B?UkczRW5SNUdwdm9SR3NHYm80RGhFVS9Rc1dYNmd2OG85bUpsQmJLR2wwYzhu?=
 =?utf-8?B?QU9jLzBmc3lObS9MaThRUFUyNHpjWXlPNjF3UHRMZnk2VVVDYktURlRubXZq?=
 =?utf-8?B?MlVXZnk3MlMzN3VMOXYxdTFJQ2RLNy9Pcm5FeC9jL1lOQ2g4WjlsRENITm9E?=
 =?utf-8?B?Z0JoTW9SajZWTlc4MmVqbExyMGk1MnVlZ0VSZzgxR2xjTFRwQUNCOFBNMitW?=
 =?utf-8?B?ZUpLb2NEUVVzL1d1ZjlqK3FGenlrQlliQ3VsOW1zUlJYNUVwZEVFQXcrWUxk?=
 =?utf-8?B?aW5HWHlkN3RLbGNtc1ZWQTlUWjUyRmx2azNnaXFoRVNBaEtoT21iMTRxdzAr?=
 =?utf-8?B?NlNsR2p6OHdEeUduaVY1d0xEODl4ZmFWdlQ5aFQweUdPMm9PZW04UTlrdnV3?=
 =?utf-8?B?aUJrdGdsMVhrUmFtNDMyZzY4ZitvU0VLZ2swaVJmWi9wLzBYL3QwS0x5SE5K?=
 =?utf-8?B?dXViZXNqMUpZMXNsVy9wQWpSaEgrangydEhRQk5OQ3NSMDBJS01kWUxvVHhQ?=
 =?utf-8?B?UE1QbWZLanR2MmR1RmN6bmx4NnF6c01IR3BIWmgwSHdNRTZYYkRsN3dMbXF2?=
 =?utf-8?B?VUhoMmEwd2xYNGQ2aGgwRXhvNnNDalBIc0c0SUxCb29XeEFhaUlBYVJNRHFq?=
 =?utf-8?B?VE85OGsweFVDQ05zR3ZNKytsZDhKdVA5ZzVGVHRYb1lDZm85dndlWmJrUkdV?=
 =?utf-8?B?aWxid3YyVUswU1lCZ2I5T1pJL2hxU0VmUXk5UnF0ZFUwVkhFVStJNXdGVHFU?=
 =?utf-8?B?Rzl6YXhXQndFME1YckJtVlV1T0pRaUUwRWdtdHl2TlRkaEZjenpWYVRTRWRL?=
 =?utf-8?B?a24vU0JaeFFPaG50MmNmZUtEWURHUUlDRnVwN3RrK05GZHdZczBCcXMvSWpW?=
 =?utf-8?B?WnNQRkxxendyZVpZclprNytzeDl6U2VpUEZicHFIYTZGTXFQRnhycWNnczZu?=
 =?utf-8?B?Um8xTm9ra2dUVERaZUJTTkNPOEthYjQxOHJ0eW00T1pOZU11ZytvbVhlTmZt?=
 =?utf-8?B?VS9zVXQ5QWkyRlFtS2ZFL2ZnZ24rZk5WTEQ2Skt3NlJySjhzeHpZME4waVdn?=
 =?utf-8?B?blJHT1EvZEFBbEVjTklaTGE1cytJKzZpSzNoakJWOWZHNnc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:43:45.5800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055cb742-fb56-4462-b4c6-08dcf49ed8a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Mukul Joshi <mukul.joshi@amd.com>
---
v4:
 - Allocation is moved just before it's needed (Mukul)

 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d4aa843aacfd..6bab6fc6a35d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -271,11 +271,9 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_process *proc = NULL;
 	struct kfd_process_device *pdd = NULL;
 	int i;
-	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+	struct kfd_cu_occupancy *cu_occupancy;
 	u32 queue_format;
 
-	memset(cu_occupancy, 0x0, sizeof(cu_occupancy));
-
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
 	if (dev->kfd2kgd->get_cu_occupancy == NULL)
@@ -293,6 +291,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	wave_cnt = 0;
 	max_waves_per_cu = 0;
 
+	cu_occupancy = kcalloc(AMDGPU_MAX_QUEUES, sizeof(*cu_occupancy), GFP_KERNEL);
+	if (!cu_occupancy)
+		return -ENOMEM;
+
 	/*
 	 * For GFX 9.4.3, fetch the CU occupancy from the first XCC in the partition.
 	 * For AQL queues, because of cooperative dispatch we multiply the wave count
@@ -318,6 +320,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
+	kfree(cu_occupancy);
 	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
 }
 
-- 
2.34.1

