Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499BBC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 06:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F7910E097;
	Fri, 26 Jul 2024 06:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KB/bMhpw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A7710E06B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 06:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iH31el5v2fsvGqiB8PP1XlKXpsKWzHHaEhx99Xx+yNvzkbrUV410PvEBFbSkEc8Cbpx5WiJzydwApfWRH5uHRK8qDcqS0AhREPSGRoAK75uxrtikwiEysBuWYE8hafor1puyyriZk+QjlrZ6mB4XgNYMV1nRwTiFFf9VbWv5YSLA0F7K1yVrHJL36XUGXCbBLQiaXVmM4tE0j0EzZuy4zyaza2pwpl4h3jV92LZDBSRqCntNRUkRMg/7Meph/8SpWUFVSCIr7kz/D6UFyoczCfIddlri2RwWkkyOwUdH0HTUcugm3Bk9yqAeWNnfDYoLURJTWwJDjn35y/oHT3lHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd0z2YeHPjuezYnqVbvS6rz4VhrsgoJsRBBgt+p1sIs=;
 b=Yp3Rdh5kbuoL3Gpf4iQVW9uxv05rPONlN8rTn8CNHtlwUrTctuak0/cMWXIoUjt5yTClaXoXtyRUgMKe3ESaXNznZrJRSHUwWmbKpa5T4yupWF37kUowpXdjRdJLpOCIRAdt4Jx6YnBhYU/Fl60T4rnqtJtf10ZThEQpkIu32ekD9PIWeBc0KigT4SpdlsOQUj+CndD71vOSRGutHnly56oRBTZZTvXHkkJrJ071MYTHoqIHNF+09IGLKsWGZHax3/5ivoM1v02XAVwOcs6UwRYiQrPVow5wBC0KSlNMPZCQyJV0Shxi9W7dhy9tCAfhmmL8YZ8t0ZvBb4Za+RXlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd0z2YeHPjuezYnqVbvS6rz4VhrsgoJsRBBgt+p1sIs=;
 b=KB/bMhpwhWTNk2cma1krRYQDpeftmHQA5rELQEPIuwRrWfOIsc69clKB8HdyMpsMkh8TgbxmoOgYW8DlvXdYUEkyicLQl8HJBW6vxkN1CRrGVcZ3ASBXr3STEAa0RFDr3t4qtpPDWqAHV040QdoYrfjaSbfpQbTFs7HWVLdIZ10=
Received: from PH7P220CA0078.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::34)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Fri, 26 Jul
 2024 06:47:29 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::34) by PH7P220CA0078.outlook.office365.com
 (2603:10b6:510:32c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.31 via Frontend
 Transport; Fri, 26 Jul 2024 06:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 06:47:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 01:47:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix missing error code in
 kfd_queue_acquire_buffers
Date: Fri, 26 Jul 2024 12:17:12 +0530
Message-ID: <20240726064712.2167971-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f52c0b-9448-4c62-2421-08dcad3ed130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmFUUTQ1Q1M3MjYvbmNlNXdVdVFwUVhjb2F2UCt2c1RUd1g4MVdnK3BBemxV?=
 =?utf-8?B?cjQwRmlPd3hrTU81azBseGM2cFVyb1JGZ0NSVWpsZU9KVlpPcFJFSE4yek41?=
 =?utf-8?B?ZnhuMUFDSHBvdnFzKzhWcE1GU0dOTVVyMWErVlhoVnpyY1pKZ3ZheGZsRVhm?=
 =?utf-8?B?TmIxK056ejBjdjlVazJPZmdhUndkSk8vOTUvSjdnZEkwUG1hM0s4cXNtZlVO?=
 =?utf-8?B?MTRiZnQzbitFekVkcWRCQnpPR1VCVlBVT2QrN3BBNjFqdXE4SGZ1UjJxR0xV?=
 =?utf-8?B?ZzkzM1dCT25iR3lyS0U5RWViSDdUZHR0eFJYdjhvN2x3a29BaXpaWUYyUFhP?=
 =?utf-8?B?SWp3YkF5ditUY2diM2d1MWxzM1lIakErRnpFSHRVemF2Ykw3WHhHenpCRVc5?=
 =?utf-8?B?SVZRQ0dqcjczYTQ4RVNCQmtqWVhHM25OM2tRR0dPQXhUaVRaQWxzeUJwREwy?=
 =?utf-8?B?MGdYenVLNXRTWDNYTHRtdE5ENUd1QmRyUVdXeXlqdkoxekFYQ0FmaHB4MVBz?=
 =?utf-8?B?TDB3MW1CVXhnVVBRaG9kWnk1cTVwa0k3eGhSNUtkRUJ2QzVLd1d3cG0rVUlu?=
 =?utf-8?B?Ti9uODgzMkNicm9ES01Va0svM3k0SmdVTk5iRnhjWk5xcDByYXppVnc5Qnoy?=
 =?utf-8?B?d3VOYmdFdDBzckg1dWdlNDA2MjlMM3paUGQ2MHBDOTdySEFMQmtZS0FaTE52?=
 =?utf-8?B?S25PZFJMekhWWmE4dnF1R05GQ1gwcXcwK1FOWU1NSHRzMHNtUFFYL24wdDlM?=
 =?utf-8?B?TldTZHo0TmhSaFh4NGxKU0NTSDRvQnRJWWVuTDJpVjVSYU1wMEwxaHBjKys2?=
 =?utf-8?B?b3hMd0Fid0R4aWFQZTJkQ3VhS0FjT2ZuYnA0QzdzS1BPZFFIbGpPZ2VrWHJG?=
 =?utf-8?B?Vjg3VlBjT3U1NDZJcVN0TElxcVZoZGk1ZkFNS1QxR1J5eXV4TnBPd0lIdzBY?=
 =?utf-8?B?WXNNNURMRTNpamlyM29Ud0RBRlk2NERNVEVKWll1UnpqRVRqaTJyK1kxV3VS?=
 =?utf-8?B?SjJLWkpNaWtESXNWNUJrSWdyS1ZnS1djQ0xIWTI4Q1FNd1RHZXZ3cWl3dmpI?=
 =?utf-8?B?NWU2UjRBaTV0TVZORitMZFMvZjUwbHVMVHArcWlJNHdVNGpmdVYyVkNXcDhm?=
 =?utf-8?B?Sy9NbFZSUElXWlppdGgxWlBMamx3L1k3Mk5PZUY5ZVFFajErSWJmSG9mcFVO?=
 =?utf-8?B?bVk2dW1GdmUxbEJOTEtWcEVNMzRraDgxaWZhYnNyWkhOZnRZTmdQTjBGWjl5?=
 =?utf-8?B?VFNzZXpFbXdTYlNXM2NISXc2Mlp0aVhTSDBrRFdCbHphNzRhd1VLSjZ3ZWNu?=
 =?utf-8?B?cmNCWW9vWGJWVDVqbTRhdXRCZk11VUFWdHE0NFVCVjZJdmlyUnpQdWdyNllQ?=
 =?utf-8?B?aHd4K2NVR2dPY1hRVkxFb1ZOMTB0YmlGeW9pZmpod1E1aXVhaFptTjlwcmNK?=
 =?utf-8?B?THNLK0dFSVFPQ3NlTzR2ZlR1M1ZqL2Zvem1rWVF1UGM3UHRDTGNIdlY2anhF?=
 =?utf-8?B?ZEJmU1Zhb0Nka0JaRVUrMEhnUjFvT1MzNTZ3bndjd3lNSmRYY1J3YzVaeHlO?=
 =?utf-8?B?dER4aEpSdmVrUWVPc0gvQnB6NEtMS2JYZ2FFajZnbW9rakFyd0QvNXZNeEtk?=
 =?utf-8?B?ek5iY3M5dEswaW9LRWI4c0ZDRlFjZG5lNU05bWNMQm9aZDUva3JQTEE0UTdX?=
 =?utf-8?B?WkozTHVDaDVXNUcra2lTR1YwZUR4cUlrbHVsdVVmaXdXRFBhWmc5cmlSckFY?=
 =?utf-8?B?blhycHNXVzZ2K1Y5d3BUUW4yQkc1Qm1WbmRlNndwNDI5RUhYOG5tSnJESDY5?=
 =?utf-8?B?M3lVelZtY1VvcW84dFduR0RXcU5pOGZQYlVFY0Nla2lDQWhKcEh6TWZFMWl5?=
 =?utf-8?B?K0hEUEJiNGQyd3Uwc0kwZVJONGhFRTRWVEFQdHVoNnNQNmZoZG9ZaVZRamdW?=
 =?utf-8?Q?AG8AmBq5BvSRgSkAF7MKTYLUTNyvT139?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 06:47:28.6438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f52c0b-9448-4c62-2421-08dcad3ed130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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

The fix involves setting 'err' to '-EINVAL' before each 'goto
out_err_unreserve'.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:265 kfd_queue_acquire_buffers()
warn: missing error code 'err'

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c
    226 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
    227 {
    228         struct kfd_topology_device *topo_dev;
    229         struct amdgpu_vm *vm;
    230         u32 total_cwsr_size;
    231         int err;
    232
    233         topo_dev = kfd_topology_device_by_id(pdd->dev->id);
    234         if (!topo_dev)
    235                 return -EINVAL;
    236
    237         vm = drm_priv_to_vm(pdd->drm_priv);
    238         err = amdgpu_bo_reserve(vm->root.bo, false);
    239         if (err)
    240                 return err;
    241
    242         err = kfd_queue_buffer_get(vm, properties->write_ptr, &properties->wptr_bo, PAGE_SIZE);
    243         if (err)
    244                 goto out_err_unreserve;
    245
    246         err = kfd_queue_buffer_get(vm, properties->read_ptr, &properties->rptr_bo, PAGE_SIZE);
    247         if (err)
    248                 goto out_err_unreserve;
    249
    250         err = kfd_queue_buffer_get(vm, (void *)properties->queue_address,
    251                                    &properties->ring_bo, properties->queue_size);
    252         if (err)
    253                 goto out_err_unreserve;
    254
    255         /* only compute queue requires EOP buffer and CWSR area */
    256         if (properties->type != KFD_QUEUE_TYPE_COMPUTE)
    257                 goto out_unreserve;

This is clearly a success path.

    258
    259         /* EOP buffer is not required for all ASICs */
    260         if (properties->eop_ring_buffer_address) {
    261                 if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
    262                         pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
    263                                 properties->eop_buf_bo->tbo.base.size,
    264                                 topo_dev->node_props.eop_buffer_size);
--> 265                         goto out_err_unreserve;

This has err in the label name.  err = -EINVAL?

    266                 }
    267                 err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
    268                                            &properties->eop_buf_bo,
    269                                            properties->eop_ring_buffer_size);
    270                 if (err)
    271                         goto out_err_unreserve;
    272         }
    273
    274         if (properties->ctl_stack_size != topo_dev->node_props.ctl_stack_size) {
    275                 pr_debug("queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
    276                         properties->ctl_stack_size,
    277                         topo_dev->node_props.ctl_stack_size);
    278                 goto out_err_unreserve;

err?

    279         }
    280
    281         if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
    282                 pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
    283                         properties->ctx_save_restore_area_size,
    284                         topo_dev->node_props.cwsr_size);
    285                 goto out_err_unreserve;

err?  Not sure.

    286         }
    287
    288         total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
    289                           * NUM_XCC(pdd->dev->xcc_mask);
    290         total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
    291
    292         err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
    293                                    &properties->cwsr_bo, total_cwsr_size);
    294         if (!err)
    295                 goto out_unreserve;
    296
    297         amdgpu_bo_unreserve(vm->root.bo);
    298
    299         err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
    300                                        total_cwsr_size);
    301         if (err)
    302                 goto out_err_release;
    303
    304         return 0;
    305
    306 out_unreserve:
    307         amdgpu_bo_unreserve(vm->root.bo);
    308         return 0;
    309
    310 out_err_unreserve:
    311         amdgpu_bo_unreserve(vm->root.bo);
    312 out_err_release:
    313         kfd_queue_release_buffers(pdd, properties);
    314         return err;
    315 }

Fixes: 629568d25fea ("drm/amdkfd: Validate queue cwsr area and eop buffer size")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9807e8adf77d..63795f0cd55a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -262,6 +262,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 			pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
 				properties->eop_buf_bo->tbo.base.size,
 				topo_dev->node_props.eop_buffer_size);
+			err = -EINVAL;
 			goto out_err_unreserve;
 		}
 		err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
@@ -275,6 +276,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		pr_debug("queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
 			properties->ctl_stack_size,
 			topo_dev->node_props.ctl_stack_size);
+		err = -EINVAL;
 		goto out_err_unreserve;
 	}
 
@@ -282,6 +284,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
 			properties->ctx_save_restore_area_size,
 			topo_dev->node_props.cwsr_size);
+		err = -EINVAL;
 		goto out_err_unreserve;
 	}
 
-- 
2.34.1

