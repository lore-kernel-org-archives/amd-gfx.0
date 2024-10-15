Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1E2CFC273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9E110E529;
	Tue, 15 Oct 2024 07:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MxlGZ764";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C6C10E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7dBKFDBn9x6cxAIfyUQY4hCKQq+bicQkNNICUbsyfOKMmMUdbaVCJq2E9IiIxT+L0FhJD0/7HzlbG2Zzw73FIPBy1i+4MoR0FKQcfsfwzwWCVIHUwbS6ndZW4W6RgGT+z/xsmmDVYo4LzHzJH4dIQhACVheB93TlTa9DlFqQXA7WxO1bTek1TgV2kZPBoU/4K7/w6BaUa8N5F5zYG/CMuerwczLgZRayOsUczx8xkk8g9jbtX9gXaLup/y7aETsZNxnbwajfEVWm9nKp+HLvAD2tgBC98bMey+EboVjLp+XeAHUDIUbkn28j4n9wmbg1TCUygXH3ymcshotswJRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9HG7xgpCxJgvjpYfF2bJ/H34dmSaAGopglWJdJeEe4=;
 b=WANFGB+obwlyqitlbgjnsPTc5fYvZRFOAqB6axyQHb5DcxRbLpT3phQUlGJIMsoy5IxXVN/2XvMEVx0vPE7jbJydSlKFnXVbOdmBN3z4IENb7TcJOYIpfrsrqIrF6tOUUaYuapOjsYBkcuftCE/33EcuEFdRD2hB31zMZqfAgmZ3Qf4CnJVmXwnAdFjndTv1SfEBSrryCg+Y2UsniTX0ylbFiM/aacKxlghEfwBXTJa7ndVgpCTNE8jwLTQPORW09+/5JcTj6splIKzjZKJQwRGGJ+46BhCQFujALDKAzOrdgddHD32wgVapAlMeZZ4yJG0axRj/gAXGHCLixTG0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9HG7xgpCxJgvjpYfF2bJ/H34dmSaAGopglWJdJeEe4=;
 b=MxlGZ764WCBUyC5yv6cVJxAR6BxhX+0b2Awyn8TxUqVgT57FnaUVAZMAjLWawTbEipt0wfbtjb/53Mv/1rH0RQwZmcqz44Y7hEF17OLP1kI+t0TFCKN2zKDuRxyBe5kKcqRRs2vD1aUFGEMx0ReCSkUZVhD7FH+lnugttjOexcE=
Received: from BN7PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:20::17)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 07:43:46 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:20:cafe::f2) by BN7PR02CA0004.outlook.office365.com
 (2603:10b6:408:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:45 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:43 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 08/09] drm/amdgpu: add vm root BO lock before accessing the
 vm
Date: Tue, 15 Oct 2024 13:13:08 +0530
Message-ID: <20241015074309.2484264-8-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: b3daf237-c30c-4ca0-407c-08dceced1980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUJpQU9sVlVLaExaS3dlNUJjV0Nzd2JSYTFLWmpzVk1kTlA1SDROUElxRVhP?=
 =?utf-8?B?NlJXWVhCZTJoQ3lMalZ2QS9kWjNzeWhOLzVMcU5USjE1eXRNL0hsMHVFazRj?=
 =?utf-8?B?Z2ZJaU5WNGtFMDR5OWNzUXFBbFQvU1F0OTdjRi9nRWFSald6V0dJY244MGhO?=
 =?utf-8?B?dXhaRS9GTzNKUVJRSndKQjl5bjBmTm5XdkdMenJpb3l4N3dmTFB6b3dVQ0Nh?=
 =?utf-8?B?Q3NBQ1ZjdnFEQlFON3ZEVS95cFQyL2hLOWJ3QVoxSHVRN3FtenVqUzJqTWpW?=
 =?utf-8?B?TzRDOHFKTUtIL3JpS1JLZDNvZTNreG5XUXQ1YkN2SGx1anphdUt4d0VaSjJz?=
 =?utf-8?B?bEwvVFNPMzNXb1pIcHRTSFNCTHdqT2Z2aWNBcEdRVVVBTW1IUHJrdDIrTGo2?=
 =?utf-8?B?MGRpd3BYVDd4aUNiTGdaaEY3Rm4rbS9oWk4zSlZuOUxmUE1RTG5FMXR0cUNl?=
 =?utf-8?B?SStvcWRCckdBZlpDSWVpbHVKTlJ0WjFJYnNRRXZFaTFZZldKTjJTc0pud3NV?=
 =?utf-8?B?Mi9CbXRWUUx0c0NnQU4vWnR4R3pnY2lZVTUzR3NuTnFtKzh3RnJaOW9DSFg3?=
 =?utf-8?B?MVg4dTFreGx5QWVZdEsxelVHTFpnZkx4LytDenBmNnEwY2VZZHc2M3ZiZmhB?=
 =?utf-8?B?dWtDd1FoM3grOG5yWThzVEZXYTJndEVlMzNTZlNNYU5JdU9QbTAvcDd2MkZq?=
 =?utf-8?B?VEFGK1B4b0FqZS80M1JKQnlZS2ZybjBhZElGZmRzRWhkOHYzK0dudFQ2VjNC?=
 =?utf-8?B?eFRHa0pFTTBIYVlyMkhqZkp6U3QvdGd3SE8yWHd5S011blNvZ3lyeXhLcnVK?=
 =?utf-8?B?OE1nd1NtYWRKM3QvKzZOcGZ1RWtQSXJmYzl6QytpQUxlTWE2WStQNFdLdk5S?=
 =?utf-8?B?S1VLZ0ZLYVZOZU03cjlBSXowRHJiQjd4bXVxeXV5LzhUNEwzTVNZSnZCOGo0?=
 =?utf-8?B?TUlwbmNCSFpPNDVtWmJVTGtvK3BBN2VjNkRJSGFlQUFBSjlkaC9GdVJQV1Ra?=
 =?utf-8?B?aFVoeDhoN2lyUThsM1lOSzduQlZqZjU2b0tzbHVWQU44MDU3T29zWmJ5TktC?=
 =?utf-8?B?S0hiS1dRR3ZNWEl2UFl1ZldPTW51Q2tkd1N5clhoZjJzaUhaMWFwSCsxU3Jx?=
 =?utf-8?B?WGU1RVdEUWgxbVVtOHJ0UVkxODRNVWtSdm85UXMrdFIzRGErTHFNWTE1VHFW?=
 =?utf-8?B?TFUycUNkYVE2UUhmdHBVRlNtczBwdGU5Wnd0b040TXp6RUQyaHpocTZ0NTFo?=
 =?utf-8?B?RFg4VW5KYndBMFRoRHZLbkNMRXMycU5rU0NHb25CWXFuSXArcmUxSDN6SFk2?=
 =?utf-8?B?Rm5VSnh2d0ZJYVdmejdpSGV6MlhmQmJNMnp3cVkrdHh1djhjTUhlVTlScVVK?=
 =?utf-8?B?QTdVaWo3VHZKWlRtTGZlanZmUmlqa3VLS2FEeEN0OXgzblJaWklGUll1OTRC?=
 =?utf-8?B?VkhaV3ZGTytNRDQ1SUVNZEV6Q2dlTlZrWWZwSTZSUCtEcXpFODFvbUJSaFBu?=
 =?utf-8?B?VGFVNG1pRElwdDNFUTEyMGljTUQvdHFKQmZBK0JpOG9qZENZT09lUHZMZWVI?=
 =?utf-8?B?eE9jK1RibHcrQXN3UjVFYWFWOElpSWFHL0FTaGtPU1ovZTc2dFZWbDM2bUdT?=
 =?utf-8?B?TExTTGwzck95NEs5QUJCbk8vRmFsanRHdzRVbnJJOE5JbTFTWkRjR3lLU1Yv?=
 =?utf-8?B?YlBrZ0JrMkQ2MDBveVJ5a3RzVE9TRHhXcUY4eEZiZmFjd2lvMzY3MFlDMyt1?=
 =?utf-8?B?Sis1RU02Ym9UbitKNlNBb05ZNHhiRG81NHFORGxTczVHQzM4OGJseDNZS3ZC?=
 =?utf-8?B?VEl5d2U3M3crQnhlSzg4OHFVUGdoTENKYjZSY3RaR0t2L0hIR1IzWStQT1pX?=
 =?utf-8?Q?9staprjfULfoq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:45.8226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3daf237-c30c-4ca0-407c-08dceced1980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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

Add a vm root BO lock before accessing the userqueue VM.

v1:(Christian)
   - Keep the VM locked until you are done with the mapping.
   - Grab a temporary BO reference, drop the VM lock and acquire the BO.
     When you are done with everything just drop the BO lock and
     then the temporary BO reference.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 93f2656a37e1..279dece6f6d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -321,7 +321,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 /**
  * amdgpu_userq_fence_read_wptr - Read the userq wptr value
  *
- * @filp: drm file private data structure
  * @queue: user mode queue structure pointer
  * @wptr: write pointer value
  *
@@ -331,25 +330,29 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
  *
  * Returns wptr value on success, error on failure.
  */
-static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
-					struct amdgpu_usermode_queue *queue,
+static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
 					u64 *wptr)
 {
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_bo_va_mapping *mapping;
-	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo *bo;
 	u64 addr, *ptr;
 	int r;
 
+	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+	if (r)
+		return r;
+
 	addr = queue->userq_prop->wptr_gpu_addr;
 	addr &= AMDGPU_GMC_HOLE_MASK;
 
-	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
-	if (!mapping)
+	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
+	if (!mapping) {
+		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
 		return -EINVAL;
+	}
 
-	bo = mapping->bo_va->base.bo;
+	bo = amdgpu_bo_ref(mapping->bo_va->base.bo);
+	amdgpu_bo_unreserve(queue->vm->root.bo);
 	r = amdgpu_bo_reserve(bo, true);
 	if (r) {
 		DRM_ERROR("Failed to reserve userqueue wptr bo");
@@ -366,11 +369,14 @@ static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
 
 	amdgpu_bo_kunmap(bo);
 	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
 
 	return 0;
 
 map_error:
 	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
+
 	return r;
 }
 
@@ -449,7 +455,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		goto exec_fini;
 	}
 
-	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
+	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
 	if (r)
 		goto exec_fini;
 
-- 
2.34.1

