Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CEAC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 21:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6668710E3D9;
	Mon, 10 Feb 2025 21:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h6YyM2Bm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6EE110E3D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 21:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLLJJaIQCIviFc+UHJGY2FBwJQfMKYBj9ULlD6/0klNL6Wj/FqzY1lyhn34wDE0HUM8+iL7hAukDGC0r3XsSXLN7t982g8GcQxSHYM9yqOQtrKHfnMa82CloGq+BNwemby7u+BndllY2GJN9ctshcRvpf6XWiGjYlPpdNsOTWf+/fDNQYSN9FW26q5h65zY2YQk5qam2T1nPZVXs38njUMqqxTGSrLBx1VdyOcHbPdlfd1hvTWPOB9VYfqTFSKLuXXT47F8RGWuAxXQr9u6+qA+ocFSh02RNPFsFOmuZZgvvdXS7OYKHK20iW64LHHH5XWmy9HhaLXY5Cam3VkqHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wlh+CQPBfNMIecv5dihh0qUTkUllEjPN9vjdPOmISU=;
 b=KE3+ulYRMInXjCkJruu6aa+2PfTWdepCCkPwM9nyp4h54bYD7bAhlGIVMb0jURigJvsFcyX/IuW+UsOesEOgFmGrJpEffuYCTg6ibnGOJf4wzpG9zG3spgysql3nIpiiNnGBOdNMtZ6Nk0z3NqBqlZSwBWxjLVv6fdvO5v0x34TFYYLQ4pjzQ1LCserpXHW/krBrV0vCXClCBg8JCEoU80Thtlc+Vdvu9U0+czwuBGWSqNRlAG/+mFJoKgcOcjgoQ5yFZa8kueRrBl8nWOtjkkrqKFIzkXrvcYF9mZnQW0Pk3P+mcdwrTVlziwqvFQQvAZriL6pCSNsqZk2P9Ix4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wlh+CQPBfNMIecv5dihh0qUTkUllEjPN9vjdPOmISU=;
 b=h6YyM2BmeGUd1yuuhNajH20vdu8B4DBoCZBcxgr4DweZU8ChkZnWICA/Veltrx1olAfU+eMR2O93QQ3iyRQQXE20AeCqsnSV3toFFFM8a5DxyBycM7Q0ftKhfTqOHaQatpijqCKDgiQjN0g3GQxS+yGYMm9yniLm5udPjK+CQMk=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 21:19:24 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::5e) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 21:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 21:19:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 15:19:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, lin cao
 <lin.cao@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH V5 1/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Date: Mon, 10 Feb 2025 16:19:03 -0500
Message-ID: <20250210211904.281317-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a052dcb-700d-4c8e-06a4-08dd4a189709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXp4VzVRSUwxWmxXaDFjWDBQbStYVS84Vis0K3FkTjlvSGUzNVlWb3lwMi95?=
 =?utf-8?B?Rjl2NVFZeEVZVGpUdDVEaFhEcmFVM21Iei9TZ0lLVitaa0tzUzA3Y1FkaERi?=
 =?utf-8?B?N3pVWEh5QklaVlNONWxQR1RwZmdxN0RqaTRHV2x5NVFGTno0N1R3cWVLQlNo?=
 =?utf-8?B?bGdMQTFIWU50STdFUGxoNktIcGFlY2RybU1LR05OTlpoUHJWZWtZMUdmWkdO?=
 =?utf-8?B?MHlCSGtZYk43NUtHVE1tZmhCbVFROWgxQ1dBUm9Lc3hKNUZqSHNKQTYrZjNh?=
 =?utf-8?B?OUo5QWtIelh5b01JTVlyNWRXY0tMV2pLaUMycG9VOHlxRHZQTWNQMmc5dmVs?=
 =?utf-8?B?RnF4S0lTajVpUEZIY2hTWms0dzlUckxRazB5bytPRHhsUUdOOEV0U2RjNm9Z?=
 =?utf-8?B?V0Z3WFdnRllJL29RSk0xMHFVdi9zMjhyNHIzVDJjVjVtZGNldkdTY3lQVUVM?=
 =?utf-8?B?U29iWVU1eVBrVWoxdUNQTnZOdVBJQnYvSmRxQWowU0dDbmtyekZpTCtKQllm?=
 =?utf-8?B?aDFUMzNYMnpmRzVNTmNkY1FOakhiMnJOYXZ6U3pWNzVzblMxTk8vUW9JRThn?=
 =?utf-8?B?ZmFoSHhpazR1bFhScHRmb2dNcnJBR1RUZmdjVU9oTXhubXVmRlk4Y3liS04v?=
 =?utf-8?B?UE1GYVAxNVRmQUx5bEMxYTJPaHhtZW4vZW43dVpBTEVpdTBWQU1xU0d2eExP?=
 =?utf-8?B?V0xsM1ZqemUxNHFiYzBkS0hXU0M3cG02NThaZlpVNUswWWh6QXFYRWdVVzFE?=
 =?utf-8?B?RVJNbzdrY0Qzc1hvcnR4WDFMYUZBL09GZnUxNlduNGdwL25HekF3ZCtrTW81?=
 =?utf-8?B?OThWN1RTM3VuS0JaVGZjWWQyVTFSNmthUE96VmhoQXZQc3lQaDB2aDg4SzM4?=
 =?utf-8?B?UWtHYnVYQzBXVldqd2szQkNKbGVxUi9SOHdBNi9rN01DR2dMaFJEUkJqWWhn?=
 =?utf-8?B?cHpwT0RzZi9FeUdVcTdHOGZYS0dvdHVKeWkwekd0YnRRMytuNVM0Yjl4SldC?=
 =?utf-8?B?QnZYczExWlluWEgrbTBoaVg5OTN3U3ArVWlITFJJdkY5dVRiMURENTdxOW1X?=
 =?utf-8?B?RWdidFZtZlRyZkttRHFOTE1wQ2FoU0xPck5vNzYvZC9nNFBnOUZNNDNQdlQr?=
 =?utf-8?B?VUNVNFlndHhIK29aM1c1M1Rtb2xCU1ZzVExMajVLTVJ6OHZHMUJPMkVOcnMx?=
 =?utf-8?B?YmwzUzM3a2tUaXdhRDAzb0ZhenJ1cVdKQlFpcHVtdXh0d1JIRFJ3VVpZYkJw?=
 =?utf-8?B?RUVaYlJCNkxTRGFiYzQ4ek5YQU9SRit2YUpJRDVEUFJUUmhEcHl4djQ4SGNi?=
 =?utf-8?B?TU1WNzBVSmM1blJxZXZUS2lHSzRTNGZjMWNid0F0djFXaXVja2NIejloTU5D?=
 =?utf-8?B?Y05uckUrSHpOTmJqc08rRGZUblViWnlZMGxqTVBkdlh4d0ZqbEh6dnhKbkxQ?=
 =?utf-8?B?MWI0VWg5YlFsY1d3aUNOeG9WV0NST05nY2crejFycndocTF5QkRNRm9UbVp4?=
 =?utf-8?B?WkNza1R5dlFGd2FEbTBBM1JuaEc1QUMxc2lMb1gyV01pNHdLUGNKREQ0bU5O?=
 =?utf-8?B?cWVmcHZsbTV5TUw4R2t3Z2FnUGlIMEJHNVhzVS9yQWVidlgwVEpjcE5wV2pu?=
 =?utf-8?B?clJINDFyWmVuNEhITmFuMEo4OHVHYi9yZW5xVllBcCtoNHdocG9JQ3JuRWxz?=
 =?utf-8?B?emtJTEZQUzlaRGZ1cXRWeWlkU01WZWZ5alpCSk5acy9lZ0xUOXVWb1VabnpY?=
 =?utf-8?B?VmhDY0x5MlVETGwxdmZvZ2E0N09sSHFGVVB2OVpJTDl2a3JSbnlpeWFYZHcr?=
 =?utf-8?B?SEpwUnRDSVYyaTJQb0hlblJGUVdNZitQZUozRHZCaXNmbjRMTXhDcUFuSHd3?=
 =?utf-8?B?ejd6Z2lrOCtway9YbUJoOTZlMmpzdXdqck9JNTdnNlFtcnhlS29WTUV6Rmwv?=
 =?utf-8?B?UWRLWVlieFFhSUpzRzZCSkxoZE5oMzA5UWN6V2VRRjl1MEZCRXBpM2Z6cysv?=
 =?utf-8?Q?XyiFaDFtEs+T7K1s6mtNNdZlFb0cVc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 21:19:22.9318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a052dcb-700d-4c8e-06a4-08dd4a189709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit introduces enhancements to the handling of the cleaner
shader fence in the AMDGPU MES driver:

- The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
  KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
  that requests are handled in a controlled manner and avoiding the
  race conditions.
- The CP (Compute Processor) firmware has been updated to use a private
  bus for accessing specific registers, avoiding unnecessary operations
  that could lead to issues in VF (Virtual Function) mode.
- The cleaner shader fence memory address is now set correctly in the
  `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
  the cleaner shader execution.

Cc: lin cao <lin.cao@amd.com>
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e862a3febe2b2..26af0af718b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -743,7 +743,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 
 static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 {
-	int size = 128 * AMDGPU_GPU_PAGE_SIZE;
+	unsigned int hw_rsrc_size = 128 * AMDGPU_GPU_PAGE_SIZE;
+	/* add a page for the cleaner shader fence */
+	unsigned int alloc_size = hw_rsrc_size + AMDGPU_GPU_PAGE_SIZE;
 	int ret = 0;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
@@ -754,7 +756,7 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
 
-	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+	ret = amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_VRAM,
 				&mes->resource_1,
 				&mes->resource_1_gpu_addr,
@@ -765,7 +767,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	}
 
 	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
-	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
+	mes_set_hw_res_pkt.mes_info_ctx_size = hw_rsrc_size;
+	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
+		mes->resource_1_gpu_addr + hw_rsrc_size;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
@@ -1632,7 +1637,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+	if (amdgpu_sriov_is_mes_info_enable(adev) ||
+	    adev->gfx.enable_cleaner_shader) {
 		r = mes_v11_0_set_hw_resources_1(&adev->mes);
 		if (r) {
 			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
@@ -1665,10 +1671,13 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	if (amdgpu_sriov_is_mes_info_enable(adev)) {
+
+	if (amdgpu_sriov_is_mes_info_enable(adev) ||
+	    adev->gfx.enable_cleaner_shader) {
 		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
-					&adev->mes.resource_1_addr);
+				      &adev->mes.resource_1_addr);
 	}
+
 	return 0;
 }
 
-- 
2.48.1

