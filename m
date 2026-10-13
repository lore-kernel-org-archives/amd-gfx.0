Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA147CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 14:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC8B10E615;
	Tue, 13 Oct 2026 14:14:27 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70F310E615
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 14:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4yLt6ocxf8xU1T8QjvcsYJOvLtVNk8J2AThZjFrmkOTz+WfuWL2OYZTZ2cnZNv2q/lnBV3Bn0aeE5QXShIXKvDLSQgpc/XVmgMx0c8tJIV1bcx7yvzsKNJOw74382mZR4K+q4Vp8KjgLF3z4viBEVAt6ImKxqLhk/Mq9JXSLyT8y7otKTze7TYv8D2wgEGCWH4YMTwzLoKqmjCZ+WOZSrbKD/mvTWeWkwAvmcne+6+oDf3Kxl4vzckwxwxgfu1hZqsdCmjifRJy+/VTAJexrkRNZ9Od4/OpQoLKL8PssIze+P1f+9TPGuD0CsfA87ZoUeeGY7CsAvpdqa0vccOIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQipC2iNAEKijEsY2Ku/ATNYoYuhFI3qRXyYFsQvnr8=;
 b=f/Z5FkFzHlx5Lk3NWruge7d9Hydu0W/6QFYiCI1Xpfz6uP7lC5LJ2MTaEaYY1UcwS5h8N4G7l1VRe+X9FcqM+Rfo5k97YiPiUtfhYmebftW1obnDEXDtZlgCnmC8WUCqDgsxiay/LxHuzb2/PhfISVjJ+1uSJIM3xfYcLmNabVzZCmMlxt0ZqUwZYTr1LgZAmxyTVvlZ9uopiFwoK7uh6vz+C3pxvKyqoJUPlwk44bUGxs6YxhM1LmbsrVhQsTGKZ3qrfZi4FTxYW7r4MKHbjcapn1is0M05I03rkcOaqJ2WGa+9hfcsrgciwrRpXax2tEzYLu5s3Zb6vx59XT49TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQipC2iNAEKijEsY2Ku/ATNYoYuhFI3qRXyYFsQvnr8=;
 b=kJfXEV2Psjz3wH1zSGJsCiKIrY//2XGVNgGaXxcdNROM67yDhpZ3KccbdkH459BfVAWN3sCJGppgwb8ogiy81Wj/cfBU6Sgs0pxpXVZ89Rw9kIH5BfXCTZihRiN+l1GvZCZi9LCs04oci5oHLrKQuRJy896MlswvnUg/JdDR2ic=
Received: from CH0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:610:e6::20)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 13 Oct
 2026 14:14:12 +0000
Received: from BN1PEPF00018549.namprd05.prod.outlook.com
 (2603:10b6:610:e6:cafe::21) by CH0PR03CA0285.outlook.office365.com
 (2603:10b6:610:e6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 14:14:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018549.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 14:14:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 09:14:03 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 09:14:02 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH] drm/amdgpu/evf: skip BOs no longer in the VM
Date: Tue, 13 Oct 2026 10:13:57 -0400
Message-ID: <20261013141357.1907194-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018549:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 4575da2c-209d-4c8a-e979-08df29344135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|11063799006|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: HkQ2F4ODgcNpelCsM9l43i8yXfkr2iordd45D8VG9uJNj3hbMloYXAIObGGNTafrZWSC29IxZ9SzJozBDXa9rz32wUX1oNTn449xfUWdRMHZS/1M5zVPzBHWkRJg52SUlZGD7mvwe4VLAf3u3Z/d1hoEIb7sM950o65/UKHKKEJnHdlsFLV/yeY+/5E6TH0ahIC49IFLhKrXtrUPqx5n1BQRPf33/uj8onx+VLLolYcpmCm8vIcyWI9iI7lED0wzAotuFUFrJFS3zM4PC5KU0W3s73MKci/3DnarV0xeQPnnRuaAeP0gJzAjXX1pZtojfNEF1WwESmlJX7qie52//k6u8Au6MQVfTx4zTulbtsoLtey8T7xXSHPwD15tSYuoS4LojD3dAIzJ4XwqMip5NSxF095DpnTuBDLeSs+5CFRiYQZ2oTeyJKAzNQivcFniLzEZC61eMEfmbbiUlSg9z4TU6SMjaQfzYgsPd0+mtBl4AZZu8zmeZiqsAiR/VS6CpcvS/x07WzCmG6dzAKG9+mxX3ojNY9XsZ7d6e25GZioiE3y51AIpvHeAsDHAz3ZLBsQpfB0UijP54Hb5G8yrPLbnS8T2zoDO0tt6vbVNJ4aljJi3xcbEPi8HmY5cUvAM+U3wuPM4HKMYs2uGh4Gl5FnroStrPoU7Hdr72C3m1ce0WO3ClrCNb0NEDUl5JnWadWofg74GCrE40nb30TuPew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(261009223027099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6lf1PQjl45ZYYs2cISqxqfzWQVffqCTJlzoUrlSOXSi9hXwFVrxFedv03WIGIP6MtXle2+v+Hy7eSzpMsZilknVo/b2A6ia67SwT7yHjKzgBl6Sm4tsk0YOl7V2IqaDQ2hHEVlmIPiNfsr/8wGjBNtFWIcuCQoYnyahfL9j5YG96g5NHl2NeFF+zzaf1497ZYkGdIhu6/PXYzchObin+bvJBy4fNd5zDF4r+1daue8VgacgJ4zZDHXMrwgOSpBRhzNtt64Ek3QpskZ9+MehNt60A9xdCBU2lKU6bn+0/uqVzx48EWVi0BWJfxPGIYpVgr08EaIIdJ0Laflr6rDHoVQs083AiQ/lkLNYMM0huzhyR7rRHC3BSCmbG8JMpVZ+3I7lurmx/U6gIXQMVf2Ec9Vir/Tecb3AHqrM+RzafR90pCK5kuiQQNIciDevbnRUA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:14:11.8567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4575da2c-209d-4c8a-e979-08df29344135
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018549.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
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

If the eviction fence restore gets triggered while a BO unmap is
happening, the attempt to lock the BO for restore will fail. On retry,
drm_exec locks the contended BO first, but it is not actually required
to be locked, and the eviction fence should not be attached to such a
BO.

If the BO was freed, this extra lock will cause BUG_ON to fire in
dma_resv_add_fence, since the gem object and its resv lists are freed
already.

drm_exec::prelocked remains set only if the object was locked on retry
but not actually requested to be locked, so use that to detect this
case and skip it.

Fixes: 2cd7284ba54b ("drm/amdgpu: completely rework eviction fence handling v2")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index a0802012de49..1e119173564b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -145,6 +145,10 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	/* And add it to all existing BOs */
 	drm_exec_for_each_locked_object(exec, index, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+		/* A BO may be locked after it has been dropped from the VM due
+		 * to how drm_exec treats contention. */
+		if (obj == exec->prelocked)
+			continue;
 
 		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
 	}
-- 
2.55.0

