Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CD4CC6B16
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 15:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323F610E92B;
	Tue, 13 Oct 2026 15:47:39 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5E610E92B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 15:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQMwgxLJBKCXbJ2X7xbSingoBzJR12kd7ZjZfIYTXbcNiCW3KO1Irx/PMh9e0XsFIQS+Th9BJBt61vluCoxjX4yLCL9yNLlAFtDcJ39yOyRWbxVwaymxEhKnX31QXoc3SQBqOD6JNlxqbSrR4iCN808ibJja+tfDTmhxkgoJh5mGoEXESgHVUeLIuD21NbJ/KcENZ60c6WaGN6Xdp8ZFdJ5Gl6gD4I6l0bsETT5NlcEFr0DpoOdkYcf21Uv4pxNgPF9vIRZCfD3keM2xOIL203LOqB2wKu4hywh6+hEG3lQ5kiYnOmUwz1rN68u05ftRBEjflLG8IwixQqBAoJaV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1zeIt00xanUVnbpxTOWcrnBD+hgmpKStglkN/hZ7nQ=;
 b=CHzTcL/ndxuVac4JLBjWlyvU9i5Xvs7nG4Ox1o7QCK05vW8Fc1Phy9+1l99USOoPbUp4f4rSl9MNTeLjXLo/CUL3Tvf61ypFXUIHPx9YDsSEQigBKM2Eu56uEyx4gSVe4zFLqHTB8WhW7u2KC0sAPFnMrr32agFt8cr/jS7NGC42o7IkLGXSAgNNyK/iEQWIMT7bb1ok8sPhZjQTvZQFWNn00z5cBY+aVbzeHptOejY2aVaGWYn3cYiExTjvQw68E3WDsP0FIE4EnsEe4CgSdNkp/mOskUm/6mkmtWqk6AM9qASwgXLatlZj4D1DYNcXarDLZKXLOqAnusOVcqa5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1zeIt00xanUVnbpxTOWcrnBD+hgmpKStglkN/hZ7nQ=;
 b=pu/zNzMnc31lZAFAbjaBHd6TU1vZhx2DmxxrhYFWHcdnCE6s4pa3RZZ3zNJLubn7jni7/Tdk0ogIeMXHd2h52AvSKbVPDxwTyBhH5YvjbIfbkCY8IeFcP24qfqLlhGJbnP2i6uNumDwmX1I27k213ohdE7fK+rCodV1XHQ9f384=
Received: from CY5PR15CA0258.namprd15.prod.outlook.com (2603:10b6:930:66::29)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Tue, 13 Oct
 2026 15:47:27 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:930:66:cafe::35) by CY5PR15CA0258.outlook.office365.com
 (2603:10b6:930:66::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 15:47:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:47:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:47:19 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 10:47:18 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH v2] drm/amdgpu/userq: actually validate userq BOs
Date: Tue, 13 Oct 2026 11:47:16 -0400
Message-ID: <20261013154716.1951333-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009154651.632259-1-benjamin.cheng@amd.com>
References: <20261009154651.632259-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f87cba-0088-43c1-4d57-08df294147a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j9rgAo9Z9JcEk8faKllBA2vJjjfgKaG/nqvNhz5oLawaHIjfwPJtOtM1GaqUBW7MRNawK7PyGAehFhTQCNz4SRCuN62UNXdz10S/9oN2PPdSjDt+YHvPgVQW44RrjsVM38at+afH5mKve+HMbtxyxqPTvQbeZjXUuL1kQy7l60cA8vi18PqRZmpL0M95C5FM9VQXY2PEeGhJzv9sYL+db9G/iqzUEeS5RVdmk1M8WVca4A7zvfmTlh8pSd6W4mXboZm26RDMCwKzMcEUtegiD+XLunc8IdkqEZuRY2KcbwGLl9y/6MbG2RvejjL/UyGCH9F+HDWQ5gFTunTfh1uuZF1DtJH8PEKOSzb2wj4WYRjRuPIR/48AsRO/ohGTCpZKW7EfkImbeOCvJUGqzEn5nYPQd+n/JjLtiwsGMsLkGIHGNEIcEBPam7L1Cxqq3rLzIpS+mIGyjOnmp6ceq3eSOQpu4PS9C86M96qoIY/AuA9qachJUS5t/1NLfdnpnoNj4x53aXL8Sqv9MWTITZrhghXTjYjjhft9qCuF8ZE9ySg7ZI/NWEiY7P4JIvSJhzH/ovdlUktSVMeNUZSDYoNRRi6NH3gcoHH+rCgp1xZ03oXeNmPrTJ7rZe2GzSCz7wT0pE9tuutG7Rqj/euDY1zYCDhMNJsoUOL+LMCVXOA9VN5VroPciaLmJjVreMUS0xZKWh3pI0gk2RnBT73RakmRXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SuFKhlW8uwFMds1rWMdDEQ3PN3SCwR/tTYEZXx/TJXGNzb55Owfe3qAQfwypLfj5+GrXbt6j0OMVMVUfwQDpaDADyVbDFXhEc5aF9GncrF646yHuFSi8IOKJ1XYIgAjyCAKL2nr5WuIXdURg5cdQ6fiqyKWUBKIZHCFGGZvzz7KL7NIyazGpPCrg1wW2yR+noDr/qbRWr3nvAM6MvKDdrdTqixwVI/WQDfojldnvrYQoW80zw9MME575hBGYi9Jvz8SlDrofHDSJKdT0O/vbdnaCBTj6n1FjdSrwS5tL/2nJBexbsXo5muK0nLVp5RP5YW31TAOKuuB6Ep+mysFPC52UD2xzQIH5CF0U44+1fsQcEJhoY+lG1pzoPS/XwZp5BHaSxPG9xkbxp9Xd5Jnm37c6n8+ieHn8vpJaZUwkS0SwTjmv0NfdfJ0sYk1v/Y3S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:47:26.0411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f87cba-0088-43c1-4d57-08df294147a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

This was supposed to loop over the individual evicted list, as the
kernel and always_valid evicted lists were already handled in
amdgpu_vm_validate.

Without this, BOs that were created and evicted before a userq was made
would never end up in an eviction fence rearm.

Also add the missing ref to the BO before drm_exec locks and refs it.

Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v2:
- ref the BO before drm_exec locks it
- updated commit message (s/invalidate/validate/)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e29823ae8672..4dca1ab48410 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -998,19 +998,21 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va *bo_va;
-	struct amdgpu_bo *bo;
+	struct amdgpu_bo *bo, *tmp;
 	int ret;
 
 	spin_lock(&vm->individual_lock);
-	while (!list_empty(&vm->always_valid.evicted)) {
-		bo_va = list_first_entry(&vm->always_valid.evicted,
+	while (!list_empty(&vm->individual.evicted)) {
+		bo_va = list_first_entry(&vm->individual.evicted,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
+		bo = bo_va->base.bo;
+		tmp = amdgpu_bo_ref(bo);
 		spin_unlock(&vm->individual_lock);
 
-		bo = bo_va->base.bo;
 		ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
 					   TTM_NUM_MOVE_FENCES + 1);
+		amdgpu_bo_unref(&tmp);
 		if (unlikely(ret))
 			return ret;
 
-- 
2.55.0

