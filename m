Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3161C0218D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 00:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760AE10E0D3;
	Thu, 30 Jan 2025 00:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mxANHPEE";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1729410E0D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 00:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg4+z0bJSsxH4VMCD4mufk7cgQ9gfR/i4oOMzKoUbPi0e85KQyyyF8dh48RoIe4XLmmESX2P4w2n2mQV5ZqVkvgCr8cGWzj6OA68C8GSS02GeZHuMfVi61t8Ym7H8WJzq3GWYU+5SvuxQAQzpSOtFTn3r0FmNRhnuVoLqjr0wqjDdPzJ26QujX+n5ZHPz3ScdMtCO9V2LSNyZ/e6n9ghrlI85xqpExqABXunszbdKzwv+prEvgOzR83rxerE6EEHuO9q68hgspQhugNBWSHPkYE0Qqd/+cx7B3QDpTPxFYZ5yY7g+j+pfxgx3krFDfkKurGhkLaPoj1HaT/etwEDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sqeafC8ZfmzhFinlAmyTnCyi4zwLKijryHZl52VcEI=;
 b=yPdHtUyyrw6vSLPUY/Jh1hBGF+poGtz2SUvG+j6JyZKzBFrfXibDpSHTJw/lO9A64lWJruiyBkOIkIjwfohEedYvxA6OZm2wqifnTN3FsVnew3/RjDKDGQbQG4VWYrSE5iepqI/x4LLyZSlMKsTlV4j9gS8uTSPNvN8yqjHcGUh5GJwpLRCoS/DkigaTgmIsvdK3sndSHHRLNFy2hOrLufwCcpBHUFA4odL6b58SyjQbcPzDAIro+qmPOgbV70QUcwDMhJlgaCrrH80RBLnXnWGud+s+laf7fbOFaTBeCfs6a5CsvHhxoF6IVG9cgn1RYYfxL5HuVMAtzB3pf0tMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sqeafC8ZfmzhFinlAmyTnCyi4zwLKijryHZl52VcEI=;
 b=mxANHPEEZBrZkEvYG2VHOJztdq/78kwVQcoXWI1g/RrPSpj76USVREpy48UQfU+PG+xyLI1Vc8K8NkeGCkAa7sdt3Gctx5L7QFMiq4cqizLiaVUaYUH15imrjATT5PSAxtcgynK9tbBngtSlApxijRLR3qtgOGg4RhCCXaFulvw=
Received: from BY5PR16CA0008.namprd16.prod.outlook.com (2603:10b6:a03:1a0::21)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 00:04:39 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::3) by BY5PR16CA0008.outlook.office365.com
 (2603:10b6:a03:1a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Thu,
 30 Jan 2025 00:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 00:04:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 18:04:37 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, <trnka@scm.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix user queue validation on Gfx7/8
Date: Wed, 29 Jan 2025 19:04:11 -0500
Message-ID: <20250130000412.29812-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: f31b8b90-338d-4bf6-7bca-08dd40c1b091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXFWakdXSG5ETDhCeVFhZnN5aE1wc0JKSyttTmVHWGM5R1F3TlZKODAwK3Ar?=
 =?utf-8?B?QXE0RU03UnplUFFiaVEySXBtbDlEUTJkVEhEcXc2TmN3Um1rU2hRa2p3TC94?=
 =?utf-8?B?aG1MajZ0NVZUdVc3amExb1JLU2ZOUVhWaWZHZC8yVWhKZmRmMnVieHN2THU5?=
 =?utf-8?B?OUovZXYzZU9Vc2dsVW0zODhzZmQzYkJ3RnRCUDJkRWVNdTNFbHJRWTd2Y0RN?=
 =?utf-8?B?ZGdYOTRPeWNyWUd3Z1lsT2lUZ2E1ZmNyUTJtTitMZ2x4YkdodnY4VUZwVUhq?=
 =?utf-8?B?RzU4U09QR2QyeDU0ZGcwWFh4TzR1b0hrNWFmYWRqRm9mcTgxTDZGNUFTR0t4?=
 =?utf-8?B?ank2alRiSmV1NnhhbzB2L3NjVE9hMDNsMUdSR1dyS1d2MGhQNENIRFp6Y3o2?=
 =?utf-8?B?Q0hTOHJvbk10VjZReGU0bVpVNSthMGZXNUFJenBuNDdCRFVQMUNZYnlvMHZC?=
 =?utf-8?B?c25PaTV0bXFvcTRoYkVQclpZZjBQZUJlT0t5Z1VVMkRFT1lOSHRxUUpBNDIy?=
 =?utf-8?B?d1Ziek8rUkNQQ2FIa3VaRTVGZ09BenoremZGa1pvcml3OVd0NjZZcW9MbjJi?=
 =?utf-8?B?aXZLWlN3YW02YmJ4UzZJRmRxaHhmbmpxcGFuT2plbWR6Z01CS1dwR0x6V21l?=
 =?utf-8?B?MExaN1Y0a2lPT1NkZkRLeXhXNnZNaS94c3NJY2syZVAxaC9mcS95SlA1SU9I?=
 =?utf-8?B?VnJ5SXpUQ0kvMHRzdkZSSWpvV2tRRHEwd3JGc1MvZ1JMbk9JSzJadzRCYTJs?=
 =?utf-8?B?alFOSzJLLzk3ODdHU1phbDhEbCs3M2JsTnROSVpBZDdIWktuNVZWU25jb2J2?=
 =?utf-8?B?RGpLV2dIS3pWaFdmR1NnZXZWaUZONGRwSTJLd1dsNkQzU1M0MkRJSU1lcWlH?=
 =?utf-8?B?Q2ZGaHlUTXdhMHNqVGZ4VFh6dWtVdmdac0xXN2xOWk52bm9nTUNWRGdpMWJE?=
 =?utf-8?B?MVJtZFJPZDV5RStiaXI2ZHkrT05JSlNNUXRYZC9GSVJxeFBEZTBxUkxTVUVO?=
 =?utf-8?B?QTBmZUE5eXVYRURjckJEcUlETUoyakwwRjRkVXk1cVNHVGNzbVExQnBSeEtG?=
 =?utf-8?B?R0ZIZXBpVzBvMnhxYytFM1RZczAzTnpUTzk5a3hMc0FMK3JmTFZIWVBXb2xN?=
 =?utf-8?B?QnJZL3pGTEQ5Mmk5SzhpUm50K0JndXlwUXd4TzBOTXNreER1Y1R1RUs3SnVG?=
 =?utf-8?B?RGhWTlFYa1hrRW5HTTEwblY3MjZhQmFhN3A4T1IvZXVndUJoNUhoTEdoWUd5?=
 =?utf-8?B?RGVSWVBTdkNVWDRyb0NlcTNtM0d1Ukx6U2VFNG5odGszbDV2SFk1Uno1SVJS?=
 =?utf-8?B?YXkvY3ljVkJ3NEhCSEQ0Vlh0Wm5ma2N3L0VKUEdwOEJRU2RFbHpheUQrTlZU?=
 =?utf-8?B?Q2FXSUFqNVY4SVBreG83a25kWjFCWG5RM0ZIbTUwc29jcUFURG9Xd0dDcFlU?=
 =?utf-8?B?ck1rUHJKYS9SWm8yVHh6Z3J1RXBsK0FXK09JZ3FZWVBINU9EWGpxV21Bam5G?=
 =?utf-8?B?bDYzS0xoamsyZUtZdU52VUxvKzhsZERzak5ZbTFCVTltc0ZWWFR2c3hBVDhP?=
 =?utf-8?B?azNSVnRNSzVaRW4wd3FqaDM3RXY2V2FLV1d0bU85UWNFTU5sdERWYWU4OUJK?=
 =?utf-8?B?NG9UZlQxL2UvUER4VGJGTmZNNGtQYzFyODIyTGg3RmU0WFdVakNRS0tUaE1X?=
 =?utf-8?B?cjNmOW9UV0hFR0s0eU1nQm9sOHB6U21paVMxSFNRUnJSU3d5OGgxcURXbldm?=
 =?utf-8?B?ZlB3cys0SjZuc0hVMm1ET0ZMWHFJREJXbHRTV05qNG91OGdhUTNQbjNnRTE3?=
 =?utf-8?B?RlRGUUk4Z1F6R3llRWlLVHAwUjU1VUwwNk12QkVLRFhXNXZoQkNVNnI0WWU1?=
 =?utf-8?B?YmxhK1BqYmVKZ0JPcVMvL1RZZ2tUeTVLdWxMZklzaGJCWURrTjE5elFhNEpx?=
 =?utf-8?B?bEsxRy9Ralg0ZVc3M212TXpjemVSamcyWGQ4RnQrZ1ovUHhiTHdxTllIR2xS?=
 =?utf-8?Q?Fjxdn4iZqyWK7QN3cbFKGwnsNXmbOo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 00:04:39.0106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31b8b90-338d-4bf6-7bca-08dd40c1b091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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

To workaround queue full h/w issue on Gfx7/8, when application create
AQL queues, the ring buffer bo allocate size is queue_size/2 and
mapped to GPU twice using 2 attachments with same ring_bo backing
memory.

For this case, user queue buffer validation should use queue_size/2 to
verify ring_bo allocation and mapping size.

Fixes: 68e599db7a54 ("drm/amdkfd: Validate user queue buffers")
Suggested-by: Tomáš Trnka <trnka@scm.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index ecccd7adbab4..62c635e9d1aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -233,6 +233,7 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
+	u64 expected_queue_size;
 	struct amdgpu_vm *vm;
 	u32 total_cwsr_size;
 	int err;
@@ -241,6 +242,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	if (!topo_dev)
 		return -EINVAL;
 
+	/* AQL queues on GFX7 and GFX8 appear twice their actual size */
+	if (properties->type == KFD_QUEUE_TYPE_COMPUTE &&
+	    properties->format == KFD_QUEUE_FORMAT_AQL &&
+	    topo_dev->node_props.gfx_target_version >= 70000 &&
+	    topo_dev->node_props.gfx_target_version < 90000)
+		expected_queue_size = properties->queue_size / 2;
+	else
+		expected_queue_size = properties->queue_size;
+
 	vm = drm_priv_to_vm(pdd->drm_priv);
 	err = amdgpu_bo_reserve(vm->root.bo, false);
 	if (err)
@@ -255,7 +265,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 
 	err = kfd_queue_buffer_get(vm, (void *)properties->queue_address,
-				   &properties->ring_bo, properties->queue_size);
+				   &properties->ring_bo, expected_queue_size);
 	if (err)
 		goto out_err_unreserve;
 
-- 
2.47.1

