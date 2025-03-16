Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8E6C28B2F
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Mar 2025 15:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E102F10E19A;
	Sun, 16 Mar 2025 15:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oijbqn6Z";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9A110E19A
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 15:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrQ1rfVZH5UCru2WbPdHdEv+tPBx3UFVhYqnfeKHEedSc9Tl/kgx589QUUyXFwpStJGj+CFBL5anGbRh2nGb1547ChCVIaian/OsP8Pod2UibAzyng2gTM/uB5FUhLlbGJuOxEUa8AsnLJXpsoj26U2T2wgrPxrIysdux/o9F9v0OELK0RBNcpGrXAR5hVEhgx840udFBr4YdgHxokuyMiPw/HwPQ8834OzCyUwIekar/fjQkCdq7jx2QD2B1C0sPuskYntmwNC27ClrxRPGeTLK6Jo30zICxUU6UtSvHEhDDtWJbmft3jukpIGjDREG0NlVb4Xzt9H5u96KgXoLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF2Au+7ePtKPcQ0sH5Rzz3bdWkZSBeEcWO3C5jyz7Q8=;
 b=ZAF4dbXav1GU2vi8IQec3jT8kH9YdOGhPe1e3+iL9RgX7BT+XfqlRH9UoF6+9GaSm4sMPcueBR+r4DMknFAAPynBLO1jrLm9dww9bZLxj2ZdoueIVeAacLs6m4LhNP22/Z/J1r80JeFPWtTC4XvwGVCCQBLE/Nq+T1GxJOcQYVu7KiLBjZzz7yLtUA0qVlHxTFfk5lykb8RyeTfV25RW8IryqT1gLUssET2mCBghvjOpqjTOz4xmqdcIJwbkHciIsCztNJ8JCIz9sEDUq5t8ljVkR2cLrI4xlrk22WMy4ZVo0pMchULaoihGXBQGjitilIaVhMjpPtN6CfmxTIa8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF2Au+7ePtKPcQ0sH5Rzz3bdWkZSBeEcWO3C5jyz7Q8=;
 b=oijbqn6Zt489/ZL9fPotKm7JNJFpUZnQFo2YgT/EmonqueN/ZFc//fA21fTv8oIQmZ9AbYB/lfAw3NSufDDbUnryhID0VU6jhKlXq4opdKUZOxflzQlZhKg2+7mt3V6yMzkKgNfkgWRr8pF7PQUmnlzl6/ejNmlICR0KMYuJZpg=
Received: from BL1PR13CA0353.namprd13.prod.outlook.com (2603:10b6:208:2c6::28)
 by IA0PPF52B16157D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 15:55:44 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::51) by BL1PR13CA0353.outlook.office365.com
 (2603:10b6:208:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Sun,
 16 Mar 2025 15:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:55:44 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Mar 2025 10:55:42 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Wait for pte updates before uq_resume
Date: Sun, 16 Mar 2025 21:24:59 +0530
Message-ID: <20250316155459.1183356-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316155459.1183356-1-sathishkumar.sundararaju@amd.com>
References: <20250316155459.1183356-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|IA0PPF52B16157D:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a349542-44a7-46c7-42c2-08dd64a302b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzJ4dEdWNnFQTVRkeFovd3lSbUpOR2ZNVU9IQnc3clk1YWhKeldDaVJtS1NN?=
 =?utf-8?B?dkpFaFNaRjl5OTFYREFyOEpPVHoyOHJ4ZVhoZTY5RW1ZTks2Mjc3UkUydFN5?=
 =?utf-8?B?Y3F6SktDWWQ5UktRTTdFQnQxS3lvbmJXWFZUdCtUZzRYRTRBcUdqb1ZqVS9G?=
 =?utf-8?B?akg0MVB6U2VGck1RR1RiaWpqYWh3eE5QeS9vN2Q5ZUwyR2J1OC84V0pNWDl1?=
 =?utf-8?B?MmZxdWduNXRzOVdyZjkyR2NCK1N5dWZ5U29xQy9YVUQvN1haQjdybUlNdUQz?=
 =?utf-8?B?MmdOUEdCM3ZTdHlCbW80U1BWYjJjMHVQaWlXQWwyTzhGVFJBRmc4dXlsR2RK?=
 =?utf-8?B?ZDFVb2pMVHh5aWtvdU94WlJLeWI0V0ZoTjZNSWk5YWNBdHpmdVdsazk5ckVH?=
 =?utf-8?B?d21xN0xIV0M0WG1jWE9kdFNhZmVyYjhpMjVoNkh4cmttQTQ0ekpkOGpTSzgx?=
 =?utf-8?B?NzJhaHZyQTZkQ1ZJUWRWUDIybHQrQ05mUFFwanA5ZGRMUldJdW4zVFBHL2Rn?=
 =?utf-8?B?VkVTRk5JalRXQzRJaXB6WWFIRUFlTEhsd05BSlFEMUdhNmp1NjBxK0VWdXQz?=
 =?utf-8?B?U0NhelhjWjJHdkpyV2EybWFKdC85U3hmY09JdUdadHg3aEJvL21PazU3T1JH?=
 =?utf-8?B?L2NaOFZJa3dQYTAvK1J4QXgwdlFMK1EzM2ZMaWJnK0V3Yk5YdExPYmdTTmww?=
 =?utf-8?B?ajNQZmFzaS9YYjJQb3BVSkpsM2l1TTFMQnNsRzlLelh4aWhaS25qOUJsMzBK?=
 =?utf-8?B?VUpRSXIvRlcxVk1HUlhPRUNtdkx5cnZZTmFubXA3aW5sL2x5WDVpZ0NuWk1I?=
 =?utf-8?B?cURyTnZheWs0YlBNeW0rVkgweFNFVm9XWFJTUnN3V09sNWFLVEFNUlhvUG8w?=
 =?utf-8?B?cERBLzkzbTlZU0U2VXZ5aWViaFNtOEFhTDRIUXBTSFJVcTdmSUNkQzNjRVoy?=
 =?utf-8?B?bmkrWE1HNXZMTStxK0U4ZWxESzNra0JjdDhsVE5nWlBmSlorL1J3SnoweHBp?=
 =?utf-8?B?MndRTnJHLzVORjlEU0EzZ1NmdllqRDRtbCtSbVJKTUJxZVBsRVpEa2Y1dHp5?=
 =?utf-8?B?S2pFeVFaWld4ZXUranJXSEM5MzN5QThxSDhKSTBONWtIY2NFYnpQYVRWcnhP?=
 =?utf-8?B?VVV4NXEreFpsWXdHZE5XTFZmdmNDTXMvYU5ZQlFDTEhxUnJ6TkV4WnhSL1Fk?=
 =?utf-8?B?VURlYlFrK0dTM3JxQnBaNmo4R1dCZU9FdW56dE1pVUo5di9mb0VobmZ1ZFND?=
 =?utf-8?B?WCtPS2FrTzFnMlJ5c1lmcm1FcXRhTGhJcmEyNUM2TUZSWVVtV2hPM0VLMURq?=
 =?utf-8?B?bjJLZjFXRWJPcU9qRlIyWklJYk8veUVTUjdmcjhIeEhMOE5NYkRyQThtTlNt?=
 =?utf-8?B?V21TUExCaFEyWHdDZTJmK2lQZmFIV2l5a2MyaTNOVHAySkQyRHF4OVdLNFk3?=
 =?utf-8?B?cDZZNUNIWVppaFNKalRzUHV6dkplZWxGTGh0NEtqS3ZTODFkZVNTMHZHdGNI?=
 =?utf-8?B?K0tmTDhwY0Z2NmN5MHR2c0RpeTdjbHFjRG56eXZ4SHNiSzVhOHRvRStMcXRP?=
 =?utf-8?B?N09wcU9rSWdkT0tlcjluZlNXbDNRK2pTVkQ0ekVOdmRhVXAwc252VWRoT1Z5?=
 =?utf-8?B?RzRrQXA2U1RrRWJxUlNLWUJndHUvWUczWUFYRWcvaGEyV0VEeDNuZ1FaQi8v?=
 =?utf-8?B?L1QvMEVnbkl0eWtOYUUyL0xLV2l6anB2S0ZreFpRVEpoMStBR0NGSjNNT2Ja?=
 =?utf-8?B?ZFgxTlZNVHhFZFFJRUpnbTQ0U1hIRk85d0dKdi9pRjNLVnpUNEZLa0twYmxN?=
 =?utf-8?B?L2RQa2RUYlowaThCU2FuWXlTclZzZTJTUktYYWtXWDl4ZkNxV3dJNUJ5OHZ0?=
 =?utf-8?B?RDNUaHJVcE95eVlJdkt5bWI4ZDBoR3gyTHZPVmRkc1VIZmU4Z1VBc2pUTkN3?=
 =?utf-8?B?aERVYW93RlBVcXd3TWlmaFVROWNZdVd5dWpYNnJVRHE5eFFtRmIrVkRLaUhy?=
 =?utf-8?Q?ikW9V1PuiYsU+mNfImlaucp0vChPK8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:55:44.3955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a349542-44a7-46c7-42c2-08dd64a302b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF52B16157D
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

Wait for vm page table updates to finish before resuming user queues.
Resume must follow after completion of pte updates to avoid page faults.

amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
amdgpu:  in process  pid 0 thread  pid 0)
amdgpu:   in page starting at address 0x0000800105405000 from client 10
amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00A41051
amdgpu:      Faulty UTCL2 client ID: TCP (0x8)
amdgpu:      MORE_FAULTS: 0x1
amdgpu:      WALKER_ERROR: 0x0
amdgpu:      PERMISSION_FAULTS: 0x5
amdgpu:      MAPPING_ERROR: 0x0
amdgpu:      RW: 0x1
amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
amdgpu:  in process  pid 0 thread  pid 0)
amdgpu:   in page starting at address 0x0000800105404000 from client 10

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index f1d4e29772a5..2bc4797fc9f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -541,10 +541,23 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 static void amdgpu_userqueue_resume_worker(struct work_struct *work)
 {
 	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	struct amdgpu_eviction_fence *ev_fence;
 	int ret;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
+	spin_lock(&evf_mgr->ev_fence_lock);
+	ev_fence = evf_mgr->ev_fence;
+	spin_unlock(&evf_mgr->ev_fence_lock);
+
+	if (ev_fence && dma_fence_is_signaled(&ev_fence->base)) {
+	/* Wait for the prior vm updates to complete before proceeding with resume */
+		dma_resv_wait_timeout(fpriv->vm.root.bo->tbo.base.resv,
+				      DMA_RESV_USAGE_BOOKKEEP,
+				      true, AMDGPU_FENCE_JIFFIES_TIMEOUT);
+	}
 	ret = amdgpu_userqueue_validate_bos(uq_mgr);
 	if (ret) {
 		DRM_ERROR("Failed to validate BOs to restore\n");
-- 
2.48.1

