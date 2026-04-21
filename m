Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38FAF94CA0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651ED10E916;
	Tue, 21 Apr 2026 17:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eekLpvvD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEA610ED37
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3xW1RdX7SY0np5a1o4XmbSFcrvFETwrOJ92RfFXox9A9Ru8MOVtWWbG9qQAjWL3CUbHvIUXLDP6N/gEQwwMNCgaDf/k9hqWt0QY0GMIY6q3Ubre3t3mXYV4yShcMVkSZuMTaaJXTnO/A+44hsYZ8FKe7YwiT/nnNXQjpX7Q4i6MS0RUNvQrA7ZgXeiovXdl9m9vRZjh09cIfRS7VW1F1O5J2EjONzAkX8mPASylnaUBawwpo+lxt3ND8cqIIfiktEkWij91s+918scjKBCCi+Wd6k/peqwL5tazJrjBY4yslya14KL3frPfgTjI2LkYgT7e2KhOU6utVXmmIj4t/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cepfMl4aXoWGm6p/AZQ62oCV/4vYVzIR9pM9pmtlZlk=;
 b=w9m5yAM8VWX9NXyP1StbIp5VJDj/jjdBBRc1aE15HMPFD/0uCxSAtIvzgIIIfyHn0I4dZx+FuchBK6uya6jg59smAtXH5Tpb5MK4ahQb7wmWHwh6LuZEwz47rnCKL5NmFGCR/VZ3sdD1JDUUSeivxBn4GdqyYP9CZJ+vLVHmBe6Nfx4CKqbjFhmgzZ0Ah9RAJicm2G2oZM8an86yk+30Fsov2vCrZmASUK3es3FuKGtLulKytuLNNZQw4Summ/7Fz+GIlA1qIwbuzGL4V7XRPObPjkOEVAyGYUc1YzgESlVw+fC2WM8brCvzXnKnxBbXgqK6T8pr82v6/ljs/dPaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cepfMl4aXoWGm6p/AZQ62oCV/4vYVzIR9pM9pmtlZlk=;
 b=eekLpvvDP5ct4EL7HO/XH+qQpYMswnpMyqRdOh0fYuKMizfR3n7+9QImmRjpIzgD9hGf7K8d4YhtpRiF/7m5a+EfqN3m9TldupkyBJIekfBuCpvaZQ2QIK++8D0gNEXtVLWMmLDCIdDXOS65IEVDK+9cTGFuiMwyDp+Le30L3q0=
Received: from CH2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:610:4f::24)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 17:59:38 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::76) by CH2PR18CA0014.outlook.office365.com
 (2603:10b6:610:4f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 07/11] drm/amdgpu: Store user queue qid in
 amdgpu_usermode_queue
Date: Tue, 21 Apr 2026 23:29:04 +0530
Message-ID: <20260421175908.2402019-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b660dfe-542f-44a9-6757-08de9fcfc138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: xNvK0rV5rgAPbDx13c3LVFRrLJfR2b3O45G4tVwYtRxIfbTX//+NSPyA7WYbmRGn+EWwAH/kJ3jriIVM5kgOaqHaVzj3mMjTkkogzDRQyh9ALryc3rzAgCKjeQ32mdPnR3XDsEnnOCD83kdWHWSI7EtkJiwTACARLcEQEhDYM/jfuaTZp3lUlNNHnyT2EY9QHs5tGRCj4JFAdf45SvM1YBNYYArtZxSRwWWGoQ9iPRaehTWGHkhQ7akhOV2DYB228fFP6HiiSPuRM2N0gKKMv4/SlAzNH48SOpt1zbf6Xx0Gn+X3HGpMdUwde9rZtCYoldVM5puR4oB5IA9d7rESr4EFWuxTSZT7NcHk7Sumeoum/pKbdljURHHVaL2TT4QC9+2fejdv9jMIo3Qug/LTJYz9eT78ShCULbXzKH2Wi/8IH0iG0h5sG4Y9xEuE83Ffhw0Z4fuLXU3ka9/DbAz4mLmphdFNQrmsukfytmHnANQmySQ8r8RV4s3BZNo3dUHAqflm5HR0Qeaj38o1wU/5q+w2yHDScpfCvNmjMxud9z2Po//KszuelbCVK69qWHd7D2DmNkvVawZh28PiL3GKBBkSvCrg3kRNMxQE2ohUwgEHY92MV4N9awRONZ9kqz5npgHGJhSq4/Cnv+NBcvCW2elPNOaRaJZuTZbBdK59Lmp8MpohXJTmOD4PTyFJluM8kkCJIG/UifCW2vAfLYppYdRmXjt1uv/WRzC2quMU4tpVFg/147UX/hI2V4ktjQG5rtRQfdLFWDI5NLUnVsuKfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RQgdvaGFx2+MBaFJ/1EhbYMrDJ/1LnF74+Po8ODx2+Z2gyJuHu/SGulNNKznxL8DXwsdVgChVhaG1H/ZAeiNQbJetC4b5Q8+xDtZwxeCsC9NRp+61gPYd5RN1ZmX+kGEVbU6QqjIl7ArGeFi9cxFWKxgjilNu7T5Y4YfTPqJtZVn3xp6JrpnQs8qpSy3UDlyM67Mhx8tzStU99lG5B1aMOKWzMcrlF0JMqNLjqAbBgQ1PSpKVCdWh1V8LA5p/Kw601bLi3e3EGqYzZelJrIY99PCAEMOOEtcxtx+LfUcoTu4yz5gGcRcz0JLqYMzUrtaLTDdVbbahtPF8lKVqKtbMlvG5jKzwyODEGIZ0qst2yTXhxeAlG5dXDFBXgGNtFCKEsQBxjIONtw3re9mYCNXeMJsZp0PKIqq7YySr0Q7XfmSNIoqKCkFvPQhT/Sr9RYw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:38.1148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b660dfe-542f-44a9-6757-08de9fcfc138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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

Store the queue id (qid) in the queue object during creation.

This keeps a stable queue identifier instead of relying on
doorbell_index.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 00e9a265c9a7..dc6bcf955ece 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -838,6 +838,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto clean_reset_domain;
 	}
 
+	queue->qid = qid;
+
 	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
 	if (r) {
 		xa_erase(&uq_mgr->userq_xa, qid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8ce039eec2b3..3728d932e87b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -58,6 +58,7 @@ struct amdgpu_usermode_queue {
 	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+	u32			qid;
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
-- 
2.34.1

