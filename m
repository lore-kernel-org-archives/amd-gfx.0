Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A46CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FFD10EBA3;
	Fri, 12 Sep 2025 05:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5rtXenqA";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035C710EBA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSnvDdRJ0BBaz8vGjwaIE43NcHlzHj1HkVhoCfQC4Fjc3pr8Q+qoYRoWkKmjIeaAzA+Zrthxc4gM0iGa+5Xa6Y7s1vcYP21IE73Xvm9fxyxNAVmfvy0teTIXKFlSMq/GzO81XBU++qk5Gd0Ky1Iw3qLPAQVWkXrxd4s+m/X+tDXjS1fyVw5m0HqB++OqQQwEpVHqT3FWhANxmm3Bj2jxcp9mmO7lK9p/bPmbY/F5VkIpCfUlxWq7zqI0OurQBtqTPuf2F62xTX8z1kNi56MnSxd8c5xKvtOfe/Pmw1FX9Sdh3I+5/Boel5nZvGBlLervVYzPS2xF+BWak4yLwI5DMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5VnPajVcZJu7wx8bQjqWFco4SzZPDpddmL6OgBVgUE=;
 b=cuj1MuiE8W++WRTNR2rFMxszWNMTqgZX++MzSxm49796116CxhNch+FXGbX8LuCng69+cv7SC/d4s6u6I12K8L4aknDSggbZ9iY37O4uNYpZ7suODxCsz44xim2pU4thVbGenB8L8CSrlnTUazeQR/jcgvsFx2i9hjVa01Ot3P8uoZVi6s2Fkg8plVoU3c85yC6DSKNIzq3sz3l4TIfiskcJElKOWDWoM8yZfmUoIrOyJ7c7a59zEkb0h/NRKJU/IHFkY+fM8DmFtxOvfSCwvWI0FzctC7O0gxNXmchtf9Ai3y+OXbmcvVPg4zfmklh81nR1LMQ/W6SfnqMhrqxDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5VnPajVcZJu7wx8bQjqWFco4SzZPDpddmL6OgBVgUE=;
 b=5rtXenqALWh4qe4RcOpv1BrtwPBdXrMolb2CxIw1nogwuzu8ropB/OwElxC3iX5J0EdJKP7yxzqvifrbUtCgBqwm1DCMuD2ADBYl2UF/b2mfe8lzFfo0jjvnxkwAzSN9Q1x1DoWbbc9EUSMM1er1Elum9lx1Tcu/mVW8REQxO3o=
Received: from BLAPR03CA0103.namprd03.prod.outlook.com (2603:10b6:208:32a::18)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 05:55:45 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::14) by BLAPR03CA0103.outlook.office365.com
 (2603:10b6:208:32a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 05:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:42 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v2 9/9] drm/amdgpu: validate userq va for GEM unmap
Date: Fri, 12 Sep 2025 13:55:18 +0800
Message-ID: <20250912055518.2719533-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912055518.2719533-1-Prike.Liang@amd.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebee2bb-4a75-4fe1-d76b-08ddf1c103ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THN1bCtJMkc2UVoyUjdTU2xNdWFqL1M0dkNZeVdETGtBak84TGJZbVpZYmF5?=
 =?utf-8?B?WmRrU3dOVS9Md0VpclpZc2NUZjd6cC80MW93Y1V0dWd1NE9EWVpHMmVZSkE5?=
 =?utf-8?B?ZFpoOGFoT3pxY0x2dWUrWDRlTGNoWUdYL1FhQmJGMDVYcGpjZUhBaVZJaUxD?=
 =?utf-8?B?WndtUnBGVUkvWUFOOC90QnNsZVl6bXNwMVMzcGVmNU1aR2xXNzVYRGtrK0hl?=
 =?utf-8?B?N0hReTNUTElzMEFCRUlWNFc0NVVIV3dMV1hwbTJuenNJTjRZcGgyOEh0bWty?=
 =?utf-8?B?S2tQbWxpSXUzeEs5d1lBRlJneUJ6WlZoTEdvY2U3ZGxaVzdMMTROeUM0SndX?=
 =?utf-8?B?dEg3Y3JzQngzTTIyU0l3NUs4NWZvNFNmYW42c0huYXh6SmZPcDBkeXBBYTMr?=
 =?utf-8?B?eUgzSTZXNi96dzdzNjMvUWRCU2dreTQzMjJXcGFYUGFrQXhIUzVLeUlCbU5M?=
 =?utf-8?B?SjQ1TUtiZ1NwTzNWd3B5Mi9nelJBODNaZ1h0bEVWNUtjRzhSZkdRRUJtS0ho?=
 =?utf-8?B?OG1ZK2RCSE5tQm40N2o2Tm41WmhBYWpudHY3dVhMRUtodjdtakthZm5OUUFB?=
 =?utf-8?B?TW1ZOWNEWmxiVy85bE5kWUN6M3JEejFvQS9pMW50UTJrVXpveWQ3NG90L3hM?=
 =?utf-8?B?RFEvaFcwRVFLTmp5cHk2dkVTZFRYZmZXaitTcXF4aXBDdnJkSHBDSEVaSXJE?=
 =?utf-8?B?UDlaSU9TcVk3NTZZWmkrc1lOTG84VWZLSkpneVNXNUp4SWVheTlDUjJ3cFZk?=
 =?utf-8?B?YWl2OC9UTHVSREw1ZTBQN2p1OEROVEUxNDdUWGY3M0J4NlR2TjlZTDg2cDR6?=
 =?utf-8?B?TGJiS090TTJXZFg5VlVkYTVxaUM3eWFwbnFtWHJGQ2lxd1pabXRBNk42QXlq?=
 =?utf-8?B?K0c0aG5aWjFtTGtxelVHVUErU28wVkt2OEIvZ25IZTNsR1pBVWRybXczSE81?=
 =?utf-8?B?dW1OeEdxWndIdWNXSlNMUEt4UUhLalV6aDZiRHZmYzNKZVk5L1hicFRVRXVs?=
 =?utf-8?B?RytQd1dFYkFUdHRPZ3Rpa3NUN09iMnZVbFpnSks4REtxUlhpNzNLSXV6QW9F?=
 =?utf-8?B?bTBXbEVCZ0UwVERkYXdkakZPdmdlRzQxS2JxQVpxcEltQnBwcFIyZEVvVXFy?=
 =?utf-8?B?NUk5UndsNndHTmYrTzFiejdvL25VaGtBWnd6SFhxV0FZNG0yQzJlWG84Smtl?=
 =?utf-8?B?dTZXMHRBZXhKSHBjb1N3WjEvRk16N1owOWgySkN2SmlpaTgwSnZkUDdYU1BI?=
 =?utf-8?B?Z0xHSlVoR2lqMmZ6bmJBSTErRUJJLytxTktSMlE2TDIxNjRwR3JDN3VMck1F?=
 =?utf-8?B?ZmJSdXY2SW5wWW5jaUdmUU4yVGc5a09zb21oMWdud2I3QjdNc2tNTHFObW9r?=
 =?utf-8?B?eGxzZ3UyRUZudFpwRVJ1Z0wxd21oeFhiNFYzMzhtR0kzQ3pCUnRJa01adXVW?=
 =?utf-8?B?SUEzY3NLNllpUUduV04rcmg1OGFwUEtveElSTld3RXFiR1lJaFFOT0hNWktR?=
 =?utf-8?B?aU5ab29uWSs3K0F3am5jYjh5R1ZXbEcxR2ZVWTNMaERkQ3RMTmVVNjlUMnd2?=
 =?utf-8?B?bUVXaHVTRHpSMzV3aGtLTDFieVh3YXFOL083Z1dmWmsrNEF5cFFaTnZlMVdZ?=
 =?utf-8?B?U2lLNEMzWnlLZVZrM0VRZ3lxaVZzR0hTSFhKbTBtRW53SHlrTXN3cXZKMkdW?=
 =?utf-8?B?M0FHZ013eFVaTGkveWxtQ2hkcTQwWXNIN3VodFNxNy9iZldSVXUwcVJiNlVG?=
 =?utf-8?B?TlVHdTR2enNrVm9ZU3hwSGNrNmc3NThiY01lN29KMGdTdkYxTXpJeXk5V1la?=
 =?utf-8?B?WmJ5Z2xFS3dSSzBKZGtHaUpKWDF0UmlNVzNzUkt2c1ZnQWZQK2NIS3Z1YUxD?=
 =?utf-8?B?Uzc1U2RrUGgrYjBTNFVIbjVXMDRhN0o2OE1MZjhBbnJsWURQemZ6TkZucW9N?=
 =?utf-8?B?UkdrYjZWcDJUemFDY2o5d090dXp0N2J0cHZ6SnFPc0lHb2R0U0h2N0RrMFNj?=
 =?utf-8?B?c0FIQ25xbkxyTDVNdnRwRkR4SFREU0pZY0hBbzVMM3BRdDcwUVkrM1AvZEZQ?=
 =?utf-8?Q?VHnIWZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:44.8826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebee2bb-4a75-4fe1-d76b-08ddf1c103ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
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

When an user unmaps a userq VA, the driver must ensure
the queue has no in-flight jobs. If there is pending work,
the kernel should wait for the attached eviction (bookkeeping)
fence to signal before deleting the mapping.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 29 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 +++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a13f186f0a8a..e14dcdcfe36e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1182,3 +1182,32 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va_mapping *mapping,
+				       uint64_t saddr)
+{
+	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
+	struct amdgpu_bo_va *bo_va = mapping->bo_va;
+	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
+	int ret;
+
+	if (!ip_mask)
+		return 0;
+
+	dev_warn(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
+	/**
+	 * The userq VA mapping reservation should include the eviction fence, if the eviction fence
+	 * can't signal successfully during unmapping, then driver will warn to flag this improper unmap
+	 * of the userq VA.
+	 * Note: The eviction fence may be attached to different BOs, and this unmap is only for one kind
+	 * of userq VAs, so at this point suppose the eviction fence is always unsignaled.
+	 */
+	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
+		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0)
+			return -EBUSY;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8cd307be7256..c9a41876f10e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -157,4 +157,7 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
 				struct amdgpu_usermode_queue *queue);
 bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
+				       struct amdgpu_bo_va_mapping *mapping,
+				       uint64_t saddr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd12d8ff15a4..ccde1f040cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1941,6 +1941,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1961,6 +1962,16 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlikely to happen that the mapping userq hasn't been idled
+	 * during user requests GEM unmap IOCTL except for forcing the unmap
+	 * from user space.
+	 */
+	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
+		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
+		if (unlikely(r == -EBUSY))
+			dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+	}
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

