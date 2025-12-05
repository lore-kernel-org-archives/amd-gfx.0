Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA8BD2F7EA
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 12:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0106A10EB06;
	Fri,  5 Dec 2025 12:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5pQFPnEY";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1053C10EB04
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 12:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDWjPQzA1bS7iTdsFHl2JCF1Y0AE+cqh71ufQsfWUBUP5skNnXVH78edoSvIW6xlWww5uUAKyEmvY/PXcpCd1tUWozqJ1JvPFXvFDaLf++rQKu3tYuCdhZDstWc9cZkGPWz77oBP5GgpjRw5QTqk7k6+c2ncqP+0QXKvvJ2NkDMaN4xDuaQd8FXhhy6m0SVoQ0JfZn7diiDfzb/nUEKq/397i5ze4OpCG6Q4hLQ0kEQXsE1AOiMO5ZQa0RtrHjGjroEvZnKay/qhBBO+P64Ngg2J3ic1z9jORXUCZpQYGyo5nl1qOuE5zvracU3UUxg69ePHjfmh1x/HgTjWWmF1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCVRah1LRDnj+56WCmbXnXFatqnsT+z1S6TaQmx3GUU=;
 b=zPXT7f16LG2oiK2hToIbMiPUjg+c6FKYUIcCwlE4selo+FhoEjNKoCZzIEON9pkTO37kdBHtTazlyfbbfglE0SLXLPlrATemI8DFl9qZKpwvddquamVE9uoeS66QldmrSZGe9gQzCbgZyhJaZu5Dk503L54xRGmDTncUrukQYFR3awTd7NXjVfcJlVef312GgXZoxZAebkhD2Dj/occrHDPgqotPPn686wo4jWCSlzTZm9GvSLAwEgWPYuAisSD9K8e7DwA8pnfUYw53nHh9KukdxnkXmGQZJqZlxGakE4h02KDzAFge9D6P+FVrIeAuHEUUEKH0l/8z/C9EO6Jq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCVRah1LRDnj+56WCmbXnXFatqnsT+z1S6TaQmx3GUU=;
 b=5pQFPnEYpetWCvOlfpC67HBCxVlj4oLRHFK9kHAq+jkldSZuIl1rmcF23Tbjla/N2q8aycCvWfXdkcz522zHBBIByy+ufeg1ZMZqebXrz6eRqWA82J75IVrh7rPKiz5JzecbQz+HAlLhabl9cjnGQDDFEhi1XlVvng/9eS4S7iU=
Received: from BYAPR11CA0078.namprd11.prod.outlook.com (2603:10b6:a03:f4::19)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 12:14:55 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::3a) by BYAPR11CA0078.outlook.office365.com
 (2603:10b6:a03:f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Fri, 5
 Dec 2025 12:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 12:14:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 06:14:51 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Reduce stack usage in MES v11 helpers
Date: Fri, 5 Dec 2025 17:44:42 +0530
Message-ID: <20251205121442.408502-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbc1e4f-d259-44da-ab86-08de33f7e5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnJnT21pWDU5SWpwaGJWay9Wb3hiWTdqTTBJeWcrOXpCWHVYdUxtcEx5Tk0r?=
 =?utf-8?B?U2Q2VkdwamJzcldCeDJ2YjE3cWU2bU1rc3BZRTU2ZGNNc003ZU9jSXpQaXVR?=
 =?utf-8?B?cnJER3lKdzIraHh3a1JFQ0lLelNiUmRMRG1MeGZsZGRjTXFKQXB4aEZkcEhw?=
 =?utf-8?B?ZGxsNlA4bG13cmcxRjc4UmIyWWVVb1ErTGh2M0NRa2s4U2pTY3hoUG9ERll5?=
 =?utf-8?B?dG9NaUhaL05uMmpQQmFhTzdjeFdlb25NK1k5WGN0cENOK281aGVscy8zY0dh?=
 =?utf-8?B?Q2ZrOE9uQnRyREppVWZyWHFIUHN4ZEp2ZFRRWFM1WlhLTWg1VkU4MDEwbkQ2?=
 =?utf-8?B?RmFYTlpiRkwydDJPMEJaMXVXck03K3Z6S1BtUHpmME9wc2d2VHZlV1pEd3kw?=
 =?utf-8?B?YWlsRmZRZmw2M2FvM3UxZjZ1cmt1SktKNisrdmc5eDlFR3JsOU15UHozdWVl?=
 =?utf-8?B?NUpSd0VpOUZad2l1RlQ5dTBOYys1dVpsTTBuNnUvYmpZL3ZBMXlJVUtKRFdE?=
 =?utf-8?B?SEUzQk9qS01sTEZPRHlZZkpQRDZRTGFXRTg1dUFUNjJCdU5VYjdyRHQ1WWlv?=
 =?utf-8?B?RDh3aVZEekw1RDBoYSt2OXhuUHEwUUR2VGFKSFdYajI4cFNhNG5NelNNWWtL?=
 =?utf-8?B?YWU3aFZLdFdYNXVkb3o5L0tqQ1ZDYXgvd1FXc3VqeXVZS3pBZGNVU2hkODAx?=
 =?utf-8?B?VHE2QWtzVkxHOTJ0dWV3VnFadHVIZlRRSHpiUmpEUkJoV2J4YTJJMGFXaFp5?=
 =?utf-8?B?dXlkSXc1MUk5QlF0UXhLZHB1aDdBZ2xOTHduTUZTeFJvalRpQnZ6UVNDNVhS?=
 =?utf-8?B?S1NpbHBIZnpQTFREN3hHVWJPS0p2UHhHaVAwNjZYVGpscUU3c05vRHdpM040?=
 =?utf-8?B?VDRscDQraHYyeU1Bc2w4OEVZT2hsWjJYVkVaZGRiS3Q2R2FGY3YwK2pkcXBp?=
 =?utf-8?B?dkpXTXAzK1ZKcUNoZ0NmWkM4MTdUbTg0Y3pkaHhyVWl6Zm43U1BnME9halgw?=
 =?utf-8?B?NW5pREtnUlVOTkZ4bTIyKzI5T2dIamJLaU9uZVhBV0RabWlqVlA5RHJuTnI1?=
 =?utf-8?B?bldGdDUxNjF4NzE4b1o5aXQxRnBIbDNoeXJIdVFmTjRmTSthcitwbWkxVTlN?=
 =?utf-8?B?K1M3UEkxaFlpdmZvNkVMbW9KZU9oSnFnMEJNUGNUSGJzWWtsVXhOY2JUZ3BX?=
 =?utf-8?B?aHJCRU5HeFNhR3ZrQldsbXoyaVJUOURibU5Ea2ZSRG1zWkNHVWlwOHBXWTB5?=
 =?utf-8?B?ZExadmJ3QkY4M2p5NHg4VHFYYlE0VU1mNHkwb0lGaTQvMmJmRFdTeVF5cjFh?=
 =?utf-8?B?RmxlWUxqemtnMmFRaVozZWpOOFN4UWVvU211VDA1Vm9pbjNadjc1OHB3NHF2?=
 =?utf-8?B?cEwzdzJpYzd6K29PVEoyRFo1UzQ0U0dsRTkyOXg2Q1NrdW1zZzg0V2Znc01L?=
 =?utf-8?B?dUxOVnpHZDZPL3IzeU14QVFmdXh3a2JnQzFOT3grR1FaYitHaXcvdUtibU1X?=
 =?utf-8?B?UGNVTFdDZmdSakxONFZKRlBIQndpdU9lZFpWNk1RV0lVQXdDU3hNK0NDR01E?=
 =?utf-8?B?cUthb21IMHZQUEVmcG44amFVRlIrZ2FYVzlVa2hTNlhMSi9GMGUxcTQ0Zm9l?=
 =?utf-8?B?dDc4VUF1V29JL0lGaFpQZUp1UkFiMzRNNU9iTngzV2NTR00wMzlnaGVzS1BG?=
 =?utf-8?B?d0hualFjV1c0SlJmN3NzQ0JxTjZzYXJuWlJaNDVoRGVrZ2xZZmxhN2JlWm14?=
 =?utf-8?B?Z3VDUUU0V05QWlhTQWNFNXlhaTM0QjFQMWZvUStsMnNOV0d6c2I1WXRvTWZE?=
 =?utf-8?B?WmREVHBrVnEyR0lrbnh5WGpmeVdqTngrdm4ybHJpS25hS3pGaG5ucVZDT3Zn?=
 =?utf-8?B?akpZNlJNZmZzSytCQnRDOFdRbHJ0VHduejdZWUlyMFJXZ1paNVNjS0hXRFBJ?=
 =?utf-8?B?ajR5eFFsMGhUV3grYmM3YlFzWTBvbTJoZlYwc2x5RmtpdXdJWC8wYmpnQ2Fu?=
 =?utf-8?B?V1ltWUJXSWxsWkwxOHVyTkVVZHNtcCs5S2xkS3dLMXBSK0NXMjQ3amVsVWlx?=
 =?utf-8?B?bXA5aFBWUW11eHRITHdkMWdnMlR0OExtR0ExY090RGZHMUdNelZyTHFubHF5?=
 =?utf-8?Q?ltLE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:14:53.5161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbc1e4f-d259-44da-ab86-08de33f7e5ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
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

mes_v11_0_set_hw_resources(), mes_v11_0_set_hw_resources_1() and
mes_v11_0_query_sched_status() were using large MESAPI packet unions on
the stack.

When these helpers are inlined into mes_v11_0_hw_init(), the stack frame
grows and can hit the

stack frame size (1144) exceeds limit (1024) in 'mes_v11_0_hw_init'
[-Wframe-larger-than]

Change these helpers to allocate the packet with kmalloc(GFP_KERNEL)
instead of placing it on the stack. The code now fills the packet, calls
mes_v11_0_submit_pkt_and_poll_completion(), and then frees the packet
with kfree() on all paths.

This reduces stack usage in mes_v11_0_hw_init(), and keeps the behaviour
the same.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 129 ++++++++++++++-----------
 1 file changed, 74 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5159f4a9787c..5533098530de 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -582,17 +582,25 @@ static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
 
 static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
 {
-	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
+	union MESAPI__QUERY_MES_STATUS *pkt;
+	int r;
 
-	memset(&mes_status_pkt, 0, sizeof(mes_status_pkt));
+	pkt = kmalloc(sizeof(*pkt), GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
 
-	mes_status_pkt.header.type = MES_API_TYPE_SCHEDULER;
-	mes_status_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
-	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+	memset(pkt, 0, sizeof(*pkt));
 
-	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_status_pkt, sizeof(mes_status_pkt),
+	pkt->header.type = MES_API_TYPE_SCHEDULER;
+	pkt->header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
+	pkt->header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	r = mes_v11_0_submit_pkt_and_poll_completion(mes,
+						     pkt, sizeof(*pkt),
 			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
+
+	kfree(pkt);
+	return r;
 }
 
 static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
@@ -671,93 +679,104 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 {
-	int i;
+	int i, r;
 	struct amdgpu_device *adev = mes->adev;
-	union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
+	union MESAPI_SET_HW_RESOURCES *pkt;
 
-	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
+	pkt = kmalloc(sizeof(*pkt), GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
 
-	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
-	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
-	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+	memset(pkt, 0, sizeof(*pkt));
 
-	mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
-	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
-	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
-	mes_set_hw_res_pkt.paging_vmid = 0;
-	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
-	mes_set_hw_res_pkt.query_status_fence_gpu_mc_ptr =
+	pkt->header.type = MES_API_TYPE_SCHEDULER;
+	pkt->header.opcode = MES_SCH_API_SET_HW_RSRC;
+	pkt->header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	pkt->vmid_mask_mmhub = mes->vmid_mask_mmhub;
+	pkt->vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
+	pkt->gds_size = adev->gds.gds_size;
+	pkt->paging_vmid = 0;
+	pkt->g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
+	pkt->query_status_fence_gpu_mc_ptr =
 		mes->query_status_fence_gpu_addr[0];
 
 	for (i = 0; i < MAX_COMPUTE_PIPES; i++)
-		mes_set_hw_res_pkt.compute_hqd_mask[i] =
-			mes->compute_hqd_mask[i];
+		pkt->compute_hqd_mask[i] = mes->compute_hqd_mask[i];
 
 	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] =
-			mes->gfx_hqd_mask[i];
+		pkt->gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
-		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
+		pkt->sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
 
 	for (i = 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
-		mes_set_hw_res_pkt.aggregated_doorbells[i] =
-			mes->aggregated_doorbells[i];
+		pkt->aggregated_doorbells[i] = mes->aggregated_doorbells[i];
 
 	for (i = 0; i < 5; i++) {
-		mes_set_hw_res_pkt.gc_base[i] = adev->reg_offset[GC_HWIP][0][i];
-		mes_set_hw_res_pkt.mmhub_base[i] =
-				adev->reg_offset[MMHUB_HWIP][0][i];
-		mes_set_hw_res_pkt.osssys_base[i] =
-		adev->reg_offset[OSSSYS_HWIP][0][i];
+		pkt->gc_base[i] = adev->reg_offset[GC_HWIP][0][i];
+		pkt->mmhub_base[i] = adev->reg_offset[MMHUB_HWIP][0][i];
+		pkt->osssys_base[i] = adev->reg_offset[OSSSYS_HWIP][0][i];
 	}
 
-	mes_set_hw_res_pkt.disable_reset = 1;
-	mes_set_hw_res_pkt.disable_mes_log = 1;
-	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
-	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
-	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
-	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	pkt->disable_reset = 1;
+	pkt->disable_mes_log = 1;
+	pkt->use_different_vmid_compute = 1;
+	pkt->enable_reg_active_poll = 1;
+	pkt->enable_level_process_quantum_check = 1;
+	pkt->oversubscription_timer = 50;
+
 	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x7f)
-		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
+		pkt->enable_lr_compute_wa = 1;
 	else
 		dev_info_once(mes->adev->dev,
 			      "MES FW version must be >= 0x7f to enable LR compute workaround.\n");
 
 	if (amdgpu_mes_log_enable) {
-		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
-		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
-					mes->event_log_gpu_addr;
+		pkt->enable_mes_event_int_logging = 1;
+		pkt->event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
 	}
 
 	if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
-		mes_set_hw_res_pkt.limit_single_process = 1;
+		pkt->limit_single_process = 1;
 
-	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
+	r = mes_v11_0_submit_pkt_and_poll_completion(mes,
+						     pkt, sizeof(*pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
+
+	kfree(pkt);
+	return r;
 }
 
 static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 {
-	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
-	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
+	union MESAPI_SET_HW_RESOURCES_1 *pkt;
+	int r;
 
-	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
-	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
-	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
-	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
+	pkt = kmalloc(sizeof(*pkt), GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+
+	memset(pkt, 0, sizeof(*pkt));
+
+	pkt->header.type = MES_API_TYPE_SCHEDULER;
+	pkt->header.opcode = MES_SCH_API_SET_HW_RSRC_1;
+	pkt->header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+	pkt->enable_mes_info_ctx = 1;
 
-	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr = mes->resource_1_gpu_addr[0];
+	pkt->cleaner_shader_fence_mc_addr = mes->resource_1_gpu_addr[0];
 	if (amdgpu_sriov_is_mes_info_enable(mes->adev)) {
-		mes_set_hw_res_pkt.mes_info_ctx_mc_addr =
+		pkt->mes_info_ctx_mc_addr =
 			mes->resource_1_gpu_addr[0] + AMDGPU_GPU_PAGE_SIZE;
-		mes_set_hw_res_pkt.mes_info_ctx_size = MES11_HW_RESOURCE_1_SIZE;
+		pkt->mes_info_ctx_size = MES11_HW_RESOURCE_1_SIZE;
 	}
 
-	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
+	r = mes_v11_0_submit_pkt_and_poll_completion(mes,
+						     pkt, sizeof(*pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
+
+	kfree(pkt);
+	return r;
 }
 
 static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
-- 
2.34.1

