Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7F3C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B646610E975;
	Thu, 22 Jan 2026 10:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ePjLlIQH";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D5C10E18A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVUMSR7AgM6aaGY3nmTl+Y5L1sxHz0bnMxrwF90n8sb6vjkTw79VCCICFO9lZ5YEGttJOOhRKomjvfe+WV93aSK+8Q3gM37WeVQU0vGAjuSxDG1type0n95w4HHXDVPk8oi06C0pAOdteyVTx0V+7MH0XG76XlJt8yy6er2J3vzSPAYiO4JnceqcKAFE4ynOkOE2r/fsA9+035YaWrJkNTs5LAiIznHVIhJiuDWV6LENy0POOAezNtHcF72wXKweLvUm5WFfncxz9NtkFfaSlDAdmUJLgpNFFuVwxGSeCBOKC9HbR0Kr3W4UhYkjPaGAY/5aZrADqHbcT4WtrDi1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynoKA9peTKvUwY7/h5/NvGjgpcu68v2286MYZwOvjfc=;
 b=ZVJ/cZoGQeLAw0cza3ZzrpFmFp3csYfiLHtgiHxIdTMrKBnBE6Lxi4A363hreHUOhPtZR8y4uaWdpIs/o44WSAo/qi90VFgtVomE09ssHC1rMpoweNtUP0VcHd7XYv2CznzizMQ9j1OaO0zGdHP83JNAKsMpJueb3yqQWkLGneraLLrKxQC6z5o4g+h+TM7pMqRRzQKyDyhXWxZhyzp/iCRYJsQZRrS8R7bB0eFc5N316KgVykmXq3yNoojmZRQYl/KfKOneiy7bpi2Z5YslKYaj+iqOPQMjLWVfzKPqDVQA2zCDFjHdaNpnAg6BmSq0GG/aQ6N9pwAi1UHh8MJ7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynoKA9peTKvUwY7/h5/NvGjgpcu68v2286MYZwOvjfc=;
 b=ePjLlIQHg5I+cWjHtrkFD9yGQEXJjbyS1fm+DeEf5D9L+PCqUQxJwaZYv6AbwTUQRjI+uasXRqkVmO8UQko8s+NGlBMaoH/ki++8e2tVpVl7v9qQRhLo+7Jkr3hBntx98IP/vLsowB/WQRDyD/QBO9XuH5FPvAtENu5TfT/s/ss=
Received: from PH0PR07CA0111.namprd07.prod.outlook.com (2603:10b6:510:4::26)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:41:57 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::18) by PH0PR07CA0111.outlook.office365.com
 (2603:10b6:510:4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:41:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:54 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v4 07/11] drm/amdgpu: Add user save area params to mqd input
Date: Thu, 22 Jan 2026 16:09:56 +0530
Message-ID: <20260122104118.1682154-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: b0df129f-0205-4531-5603-08de59a2dd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T3aAq7aDaU79p5YPMe8ay8PhHqN3nl9TPBPoz7bVnEva3mWiugp7yyc8srsl?=
 =?us-ascii?Q?+rOJYPyBPAr5yrZvTMUgBFXxCEVSTWgBAuarAHdDy0Qc9+h/whigLNFrY+J7?=
 =?us-ascii?Q?YipuTur2FPoyWpSwkaqmzQwuM8nRVWsw+oYkMswXMNTNAfetNZ643Mpq37mJ?=
 =?us-ascii?Q?jx6tSj/6cw0YYlrtGTUuQVVgsnL0vRnby4h5YLSKcwfF1KvDS/5QnzIpjKxi?=
 =?us-ascii?Q?Ciu8uM8x3bbE9wM70xfhf4CiRMBW4ESxBEp4Trw8kNWn/Vjxx6qycEMND/2n?=
 =?us-ascii?Q?9j6F3WUgcODR0LViFs5hNxahCdO6gGT6hHdFcuGMnMh9YKg+VfKFu1yri/QQ?=
 =?us-ascii?Q?XjNlrHdtPd2u/mt7dv0nsBfjrq/mchTxqdbxa/xkdYW8oPsgwfEDj5mOj7V3?=
 =?us-ascii?Q?1c+vEWBSHjJt2Gff/yHn5IYJiBfpqhp4Ft63snNjvciK5sbmHhMB53H8eMbA?=
 =?us-ascii?Q?ctzD+Pk8UeKj4hbI0rNXlHU8HehuC8v84g+em8n82ld/nkE5HakFnovnvXln?=
 =?us-ascii?Q?oKH+FJV17MhX2c0sSF/dSubsozhz5Emi46WFz/rjQhNtoc+0Dxbh55MiEu1j?=
 =?us-ascii?Q?DDJp3HsfrSESy7bszUPQVqhdqyFz0y26OwXyQC41OMVe71d7zmbHl9g6M170?=
 =?us-ascii?Q?LcOalw+gFIceYheuRnOwq8XSRxwQanJBrf3Tab5UT8DA5LEXt5z01MibMH+O?=
 =?us-ascii?Q?B5ZK88GBVhjeKYt+EmRCQrYaNCekFD9EkkKw46AbVFTNUiKCmVBUUb4MXoyb?=
 =?us-ascii?Q?KwhvPJkm8Q94bDVzuJNBPJUbCDdZUj6sWu7E61rgTvzi3Mzlyt8NrHFrnG9U?=
 =?us-ascii?Q?ejnVFxdRn7jLL0Vq/8IXOZ5Bw6SGyTbQr+PjlDfcV1B2b7sICyxgCF2Jcm25?=
 =?us-ascii?Q?3fdglIwiPxhVWUsfIMyThmo8hI3/xo+z42VgZx1cEWic9ctRy9VKeiQwNn5o?=
 =?us-ascii?Q?2IqrfXfEMsNp6FkaW7NNxX07J6lEBR89XSPjHFtYXDP+6AQa1ygjoXKA5jWe?=
 =?us-ascii?Q?Xr63buAkyVzvWhiJQuPLDOGUwOCoKA7BbLzogDDSORoCEKC2clS+bR3hgjRx?=
 =?us-ascii?Q?F1AjvkeFyY2Omu8BPco9pJZ2OgG6N9R2umPkP3T975hdymh6mat/bTz3HZVh?=
 =?us-ascii?Q?zfpWMYuuo7U8lBndsEKCP4iEz6/JwEuXW0s4K8V9ISB+DOryJwq4bVna4EZh?=
 =?us-ascii?Q?LhAHw1kV/fy9dUDfLhMQRWYhH1GwZ4BRfRTlZU2qk4+CFaAZjp0Ucm0WyEV3?=
 =?us-ascii?Q?X03EvonWTObzZiunuXeajv54BPv1HfNc8oA5YC06K8zTzVP8EK+oAoDeHyUy?=
 =?us-ascii?Q?uEvYemy5OlNm3t4gWkptaXVGzLkE4GPmkoN1YleqHGYhbBbcwmoNbNFewReb?=
 =?us-ascii?Q?ulk3SnJZ4/aolqkaJxhu85V6rqJMSUO0vSTTtDq8BNAKnpOdAt9Shj6NZ+UH?=
 =?us-ascii?Q?1S6jvS8pwK+7cY2pLcByG2vzS8PtQgMUqrcEDFVoyfRX7l/40Z7SQgynog8r?=
 =?us-ascii?Q?2urBWoMAtdKjXKirfwyeVq8ev335mQNF1u69i2PvjapMutvu22h0+jPEWRDh?=
 =?us-ascii?Q?VACDNb3dKwRGpfJaZVJ1P63Lha5Ini5R8yW6AmRFh+QnLOn6UYpLfAH0sz8B?=
 =?us-ascii?Q?4ezAT/fqRzSMd5z4Y2OALa4HiLeMVznTLoo7GQCibKevWWzMthDebvO5LHaF?=
 =?us-ascii?Q?2/Y0jg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:41:56.6180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0df129f-0205-4531-5603-08de59a2dd5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237
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

Add user save area parameters to mqd properties for queue creation.
Validate the parameters before using for mqd initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 14 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 16 +++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 218d8030a07c..26b757c95579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -814,6 +814,10 @@ struct amdgpu_mqd_prop {
 	uint64_t fence_address;
 	bool tmz_queue;
 	bool kernel_queue;
+	/* cwsr params*/
+	uint64_t ctx_save_area_addr;
+	uint32_t ctx_save_area_size;
+	uint32_t ctl_stack_size;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 37a526a1085f..119b84a0703e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_cwsr.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -265,6 +266,29 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	uint32_t cwsr_size;
+	int num_xcc;
+	int r;
+
+	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
+					num_xcc);
+	if (r)
+		return r;
+	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
+	if (!cwsr_size)
+		return -EOPNOTSUPP;
+
+	return amdgpu_userq_input_va_validate(
+		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size);
+}
+
 static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 5845d8959034..a64292bc24dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,6 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
+struct amdgpu_cwsr_params;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -157,4 +158,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 				       struct amdgpu_bo_va_mapping *mapping,
 				       uint64_t saddr);
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 40660b05f979..5f6a6f630495 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3243,6 +3243,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
 
+	/* If non-zero, assume cwsr is enabled */
+	if (prop->ctx_save_area_addr) {
+		mqd->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		mqd->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
+		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
+		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 27917614b1a8..7ad8297eb0d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -314,6 +314,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_cwsr_params cwsr_params;
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -339,6 +340,21 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_cwsr_is_enabled(adev)) {
+			cwsr_params.ctx_save_area_address =
+				userq_props->ctx_save_area_addr;
+			cwsr_params.cwsr_sz = userq_props->ctx_save_area_size;
+			cwsr_params.ctl_stack_sz = userq_props->ctl_stack_size;
+
+			r = amdgpu_userq_input_cwsr_params_validate(
+				queue, &cwsr_params);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+		}
+
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
-- 
2.49.0

