Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CC7ECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0321410E690;
	Mon,  9 Sep 2024 20:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jeJShCVk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C9D10E68D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyljistUBuNgT+hwluPGLQ+sQCK1+5QhcQ8+OodsOimpGhOdXJ/v2L8j65VmTKOZQJP/hBoyc7E1DXgphxRr7LNWYQmBH8uh+45R9yo6OXkchMGg0t9+XmU1x1kv3pDfJ7c/pvuo4x5mGfKnXGKOKexFlkRZES/sSKYQlnABQFqKxW7omrYRi89WHVp8U4MdM5KPo3+Zj0RtFuJbWuEUPyfOoWfvXH1xtIxGI24//FAT7E66Ae7HILtZ6c8tUflur2gXCf//NiuQ6Yq7nEEN6GNtYSPwHrbHdUsbc1Qui3B1MS/gg7MaSQUvgXTUdveg769dzzIgvvMK18su9FLcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdxdfVC8QZBn/SMdCpe1U1itqdyy8RSrHYcbAIQV3gg=;
 b=HAq1gcG4fccdnTTQ9gtU2enVOzVKGIlsxArbj1BdRaQIF96hXpmvA9jHd5kC0qR82cZwVmxsMPu+eq4bCWRElQenAX/2C4zhPMIRyKXl5YgCo04KeoWpJLYqG54VtFAMO7JpkW4cUeeGi3JNnv/2fqeSkaTZ7Th63Gc4/ZYmHm8nMoXr/3yNemoMUTXiRk4/9J+wc6N/hFKefV60Nl9x/JKXi9Zp9g2x0JutLfRjEBIY6gVNLnTPWNgXR5/d4AM1sFzQwYmS7NRQzRa17AdBqJB42B974k9DcnrzNCC0h+mMVlskkT8B9DQBu73BMhwDakUfXiIHP8DNam33ICMvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdxdfVC8QZBn/SMdCpe1U1itqdyy8RSrHYcbAIQV3gg=;
 b=jeJShCVk9wp3NAcscBz50594jgQZu6MsZXXcV+sqTfiqhNtwBY4x8C6b1JFkZsVrqcGwq8JPuRdn2c4j40fjpl0Y4Zih+SPL/TThi7Wp+TcLCKNZpw8yXLabN51jWldTuYyJOTOSeGS6ApKlXDy8VFWJkR3h0DVlAhIBa2ewO6Q=
Received: from SA0PR11CA0033.namprd11.prod.outlook.com (2603:10b6:806:d0::8)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 20:07:15 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::7f) by SA0PR11CA0033.outlook.office365.com
 (2603:10b6:806:d0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:15 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:10 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <Arvind.Yadav@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <Christian.Koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Shashank
 Sharma" <shashank.sharma@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v11 12/28] drm/amdgpu: enable SDMA usermode queues
Date: Mon, 9 Sep 2024 22:06:03 +0200
Message-ID: <20240909200614.481-13-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: aa17a279-00e9-40a9-b89b-08dcd10b0038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWJrc2JaZTQwMkl5bXVqSDF5STlDY28yOEtoOWh4NEgyMlpnVjI2OXVKaVFT?=
 =?utf-8?B?T20zYWZJNEl3TDRuNUVqUVgweklLaEZqMWZ4alhIOE9QQW1UUXR4T2J2bzh5?=
 =?utf-8?B?dENyWkFvWE5PU1hIQStwN0ltcjFybThwR2xyY0RYNzlIKytMajdaSCttWEdZ?=
 =?utf-8?B?d1Fwb0V2YkZJN0hzRjlrb1NrMGgraDdFY3hnZjVGYjd1d29KRHk5QkM2aWVh?=
 =?utf-8?B?TW9GWW5hbVRxMzhyTmF2UXVzUnl2bVQrMFNRS012Z3J1Mi82cVM2ZUlNTHY5?=
 =?utf-8?B?ZUxxQ3h4Y2NGVmU3bGFid2RvL2tySVY0Q1U5L3hnUXIzaTdJMFZJOVo2cmRQ?=
 =?utf-8?B?L3lxQzl2VS9LWDJnWGFlWkVNRklkVlhQRENtY3pmb2JweGJIQjNEV2xQTTVR?=
 =?utf-8?B?Q1c0dlJ5ZFBNNjBPaW1Wd0FISjJ6SHNlRkFiU0tZTDQzQlpTVzNrbEJ4akxO?=
 =?utf-8?B?cVhxL3F5TWltbUFjb2Q0TWliR3hNYTR5MFMvZXRSNEdWMmZzSWx2REI4bUZ5?=
 =?utf-8?B?bGFtVlQvRHpGZlB2WWIwcnRxWFpLWFF6bXRDTVFMbG9odHhnTVNTMHVjZFFS?=
 =?utf-8?B?ZUVCY3dEZUNkOGNUSm5YUWVmS25oNTVMTjF4MVY3S0pNbUZUOFh1ZDBORmg3?=
 =?utf-8?B?VUFDKzhZVXBKTXhMUFRWS0g3OVJGb2ozejVDY09QcDJ3NytZRkN2OTBjdVkw?=
 =?utf-8?B?cSsybWtxa2RERkVheWZYUFlNUEdHNXp6V0haWHJXKzgyR0JZZi92VlMxaXlT?=
 =?utf-8?B?aHhGZC8vU1hhRDR4OWN1Z0IwUlRxTWZpWS9EN3QrMWZBbkhldS9mSmtmVG9i?=
 =?utf-8?B?ZjVvdjh3cXBWQVNLaVZVVUZWMEpKMmxReXdIQ3dpd3JDSDVMV0NRd2w4YUgz?=
 =?utf-8?B?Rnl4NnFBekFSSVovbmdHUWgrSEFlbFVUc1lsVmZleUNseERhdlJpUHBwSHE1?=
 =?utf-8?B?REltRDBsU2JBTXJCY1F6L2dyTTRqVThMUHgvSDBXTnVhdWNXcXlSY2hZbUZG?=
 =?utf-8?B?SFhhMEh1M0FvTkR3UENGcm9oZEwrdEdrWlFjR2xNZWt3Y2xsdThMVWxrSjhk?=
 =?utf-8?B?ZlpTRkJuMkVNbC91TncxL1F6bTM5ZGNBYzRRWXFZK3hRNy92dkp2V3V4WFFX?=
 =?utf-8?B?T204Tlg2L3F6cTBLS0dWZjdybmV3VEs5Ry9VVVpvdXNEVmUvTGdGOUJFUG84?=
 =?utf-8?B?Z2tGK0F4MkVPZVBYUkRNZEl5c1pRS3drWGdNQ3R4dlZFT2NZd3kvQlRpR3d0?=
 =?utf-8?B?SDlxNUxtOUFsVHVMQjBPWmp1MitXR2JSbGIzVjIxWVY4dTR2US93MU1PWERM?=
 =?utf-8?B?ZThhSTB5WWpTTThEcEJDK2FDTUdWV1A2T3pBN0JIL1FiZU15bDZEZUgxRU95?=
 =?utf-8?B?cllGb3NNMlVXQ0xRb2JYQWJJMVFHQjFrUmp1NkJybGozQktnck5tYUk1SVhR?=
 =?utf-8?B?MXFZMWYwaG9TYzhJS0FlalZqV2hQWXkvcDRhMlAvN0pxT2s4eTdBeExBWmJU?=
 =?utf-8?B?WUd3NUErOXdZektKRzNSMVplczNMaUVtNlpZY0lxRkNYcnUvMEZEaW4yNUdY?=
 =?utf-8?B?djdPUnRUYUt6eUdjZEtEOVdRTFdwa3p4NVVYOXZyMkFEeWZYV1BDeTVSRU5H?=
 =?utf-8?B?bGZHSitWY09kdW1jREdzeTVnWUZldDVnaDdNWXo4M2pQVWxGWW9KaXpjOFJQ?=
 =?utf-8?B?Q0sxMUx1VFg0SkhaaDc1VUkwaGwrbXNtZFl5TFpvWWVIVks2ZFpCWkU1K3g5?=
 =?utf-8?B?MllKNnhvaEpXVk9QS2hOUUNlaDBZL0Qwak9VVHZwSytMK1FVU3ZaVzduNWwy?=
 =?utf-8?B?VXZzR2RBajNNdGI3RnRPTEdiUXh2NnNWR3JrRjFZMlVsVGEwcWJqMnFIeTBB?=
 =?utf-8?B?NjVsVjBxY2RZcXBBamQ2bFVBenQ1YXhXb0t2NHhWNXBaTXpVa2plTjBwcXkx?=
 =?utf-8?Q?S1JvokwD56M8b08n+ai41rneOxLdakY8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:15.7549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa17a279-00e9-40a9-b89b-08dcd10b0038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
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

From: Arvind Yadav <Arvind.Yadav@amd.com>

This patch does necessary modifications to enable the SDMA
usermode queues using the existing userqueue infrastructure.

V9:  introduced this patch in the series
V10: use header file instead of extern (Alex)
V11: rename drm_amdgpu_userq_mqd_sdma_gfx_v11 to
     drm_amdgpu_userq_mqd_sdma_gfx11 (Marek)

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I782acfc08fef0fa5302e665173788fc03dbc51e1
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c  |  2 +-
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c   | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c         |  2 ++
 include/uapi/drm/amdgpu_drm.h                  | 10 ++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 5cb984c509c2..2c5747cc492e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -189,7 +189,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX IP as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
 		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index bcfa0d1ef7bf..dc5359742774 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -206,6 +206,24 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 		mqd->fw_work_area_base_lo = mqd_gfx_v11->csa_va & 0xFFFFFFFC;
 		mqd->fw_work_area_base_hi = upper_32_bits(mqd_gfx_v11->csa_va);
 		kfree(mqd_gfx_v11);
+	} else if (mqd_user->ip_type == AMDGPU_HW_IP_DMA) {
+		struct v11_sdma_mqd *mqd = queue->mqd.cpu_ptr;
+		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
+
+		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
+			DRM_ERROR("Invalid SDMA MQD\n");
+			return -EINVAL;
+		}
+
+		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		if (IS_ERR(mqd_sdma_v11)) {
+			DRM_ERROR("Failed to read sdma user MQD\n");
+			amdgpu_userqueue_destroy_object(uq_mgr, ctx);
+			return -ENOMEM;
+		}
+
+		mqd->sdmax_rlcx_csa_addr_lo = mqd_sdma_v11->csa_va & 0xFFFFFFFC;
+		mqd->sdmax_rlcx_csa_addr_hi = upper_32_bits(mqd_sdma_v11->csa_va);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 208a1fa9d4e7..62f6f015c685 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -43,6 +43,7 @@
 #include "sdma_common.h"
 #include "sdma_v6_0.h"
 #include "v11_structs.h"
+#include "mes_v11_0_userqueue.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_6_0_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_1.bin");
@@ -1340,6 +1341,7 @@ static int sdma_v6_0_sw_init(void *handle)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
 	return r;
 }
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 895d64982498..3ea067242b19 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -428,6 +428,16 @@ struct drm_amdgpu_userq_mqd_gfx11 {
 	__u64   csa_va;
 };
 
+/* GFX V11 SDMA IP specific MQD parameters */
+struct drm_amdgpu_userq_mqd_sdma_gfx11 {
+	/**
+	 * @csa_va: Virtual address of the GPU memory to hold the CSA buffer.
+	 * This must be a from a separate GPU object, and use AMDGPU_INFO IOCTL
+	 * to get the size.
+	 */
+	__u64   csa_va;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.45.1

