Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA8CCD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 09:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADDF10E4B5;
	Tue, 26 May 2026 09:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YMiPU34X";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA2E10E4B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 09:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGPH4HOERQCiedIg7rvINQl7kSxupOY4u49mibcQRnjxBfp2Lni1+nXWXNFIPJugRxsHGOCzACOBLuE4s+ef9gaFPb9Kr/VGtXmGNcLbTE+soDQQyfEsczXhAlYP00NDa+oVXaiHGBe3A2N2JjwGdG3+NbeE6eTnT26fhDJNCzYUrHzwoHczhfnZFalAIN0dD+I6/9997ItA2SPxsSqkoMioleg1ppD3AtRg2nt3cYofN4oBpgTTtWi9wwIhVAXNNKrBLT+IQPuO8xwh3RFU4Ovokl5Ej4tDC/qvPvSkvgbrvKreHa+bQu4Tpy3aWAzyeF8UplJPxE/jJ8BMsYOCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlNe8HU0f9SWCRoTTJxWT1xsY+G0442gEQJdlJ2C6F8=;
 b=h7TEwNuwMkehsaiwhZsOBjAZ3obQ6qorOPcrtu90j7P+L6RE4pmZneCN30U4u5aQcyeCEMj4WQlz+SUGnFIrcGXN3dLSCprDGWRa1NQMWABKPONuhaZaJA5Dey5/PkfXOFy5vvF5u6I3S1+YZR2x/gHr7Oak3QdPU9BPHgm1M3R32W2ZUq7vLwkJc2k+FbtOSBc93RJhoodyqT+pMz017UQJthdg6G/v6EUjcWCK3YPyB3tbftqv2cVWFIyoXeT/Z/Kr67b2Bd4u2q5WqQFCSblYYHJ1gFE5Z0eCjrHuEvvIp73I9kQQJGqB6Oqum8q+37UxPoeFjVCkx3zibBrJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlNe8HU0f9SWCRoTTJxWT1xsY+G0442gEQJdlJ2C6F8=;
 b=YMiPU34Xo/E2knPQSCpGiFOoBiEvyz7q0fdAZObLWEj40nbTqaVUSOREhvwCwqVEuaEy2WyXydNeBue5RirY2CcEnBuF/nF03zt1qYm/C2O7GuSBCxkcjR7NP+bR63HOgLtF2Rw59w8QL4LdCydBmOamKuJjC/ujvsR8hiWu9mY=
Received: from PH8PR02CA0015.namprd02.prod.outlook.com (2603:10b6:510:2d0::7)
 by EAYPR12MB999181.namprd12.prod.outlook.com (2603:10b6:303:2be::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 26 May
 2026 09:32:27 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::4e) by PH8PR02CA0015.outlook.office365.com
 (2603:10b6:510:2d0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 09:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 09:32:26 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 04:32:24 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: reserve TTM move fences slot for rearming
 eviction fences
Date: Tue, 26 May 2026 17:32:10 +0800
Message-ID: <20260526093210.55565-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526093210.55565-1-Prike.Liang@amd.com>
References: <20260526093210.55565-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|EAYPR12MB999181:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af458c9-d2f9-49d6-aa37-08debb09b310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 376tOUVgon1GL2mcfQD6HlIQsIz2XNBMhhdmsKfv5zYv6KvU5PWMXd6veZdY0gZU94uCnq+4jYZVycPASOvTsLLOgxRL5WeLV7TRHplcccgtYm3Gy2xyPQIaqS+POKGn1hMaSOrkJNZrfJ8AYUUA2oBpAHG3130ShhMVv1oT+4IKGXg3LPlAW1MKysQUC6NGBoi//E38MqMtN+VTAWismTSxVMtwJL4Wi2tZVG/mKzD7TgOaEgbkzwsT6eCYHCaguUNsETzGKxcU5Qe0g8Mdx/zULx7Wcvv9DIRoyw3w53WZH6XrcR/1qtUcLQdpFhRJ9ggWTS+/2aIPMGdf5G3AnFxup8bPI2BOtEbdDU1nw78De7Yd+qQtN/AX0gDZoJLpU7ueVWpV+UxIYsrKf/YtkmNpXMq64qQyMA3QPxmPk3HjgJL74UPdIPXbCtPDJ9dOkhI8viOhBMIkiYsG4+LhbDb9zyCPnEtZI23E6ucW54HlFXPx23HM/NO3HBqbJ4TvWVo3jLXq81Xjvo86pUVq/EylPfHCXh157RlBEAivXABH2IY5SL/7dvLP3DF0kld38eAT4icM57yPJyaZgZK1I9NIsJaDj0y4IZ1DV23iywWk85cKwjW8W7EYp2y+9zktEmVFd8kL2RsVGlgODpdUYVHrfidbp0hY69aT18FnR1g6h/rBao+0KP6pKSwycVxeg8EIcAHffOfN+3vz6vTTypRGCuWqsJnDC+CdwcO6dzI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RPG0N8UdoOkrZcEI+YNsAC0lg91ZQnr7DX9NoMZL7Z+ydaigpCEJ8uOB19kV6A6D0rCuRn5NKcdZDt23z2nsn5vZoBpAOF33HgcicIo6Wo191i7jo6xOqtBXyRveOZ1P96C4uFyrOABR4VCxEd6hY6r3pBrl0qcdOXZkFSXt/2q9bNZxv1B36jnY8aVIpWpHv9QfN1vDNXNQiReyvJhjsmRzu/LDStQoltDNVFcuPAtaSw3TQoMqfs62eH9x+73KFWlblMtxbM7/wyMap4yiTaLfTICeJsyoqh12l1Q6OoMQwyTKN8l2BfhZYratIEoIBmyTZrk1bOz1WB3XjEtsdvyzXf10Ia+c8RobTzeGPltKPRcn/q9yt/8Lzz8r43FxzxfFKDbZgdn9QHi2d+Ulf8zBsaOuLFt5iISfJ46KWe0xomU7whFo5Ycem7BNc37B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:32:26.6086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af458c9-d2f9-49d6-aa37-08debb09b310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999181
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

The eviction rearming does not cover possible TTM move fences. If TTM
moves the BO and consumes move fence slots, the later eviction fence
add can hit the dma_resv_add_fence() BUG.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ea743407dd06..22ec4eb6e17f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -249,7 +249,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
+		r = drm_exec_prepare_obj(&exec, &abo->tbo.base, TTM_NUM_MOVE_FENCES + 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r))
 			goto out_unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f650d8d0ef53..39b188848927 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -978,7 +978,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 		if (unlikely(ret))
 			goto unlock_all;
 
-		ret = amdgpu_vm_lock_individual(vm, &exec, 1);
+		ret = amdgpu_vm_lock_individual(vm, &exec, TTM_NUM_MOVE_FENCES + 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 519352378b9f..51ddd267da63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -473,7 +473,7 @@ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
 			amdgpu_bo_ref(bo);
 			spin_unlock(&vm->individual_lock);
 
-			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
+			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, num_fences);
 			amdgpu_bo_unref(&bo);
 			if (unlikely(ret))
 				return ret;
-- 
2.34.1

