Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE9BCD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B387C10E676;
	Tue, 26 May 2026 14:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6YQUlqO";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADB110E671
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhnQ/Ir9kjWmnTuImx/t8zVRaf8OkCABmU0IWDlTr4WpSDhDqUL/XmM11nX+juGi5Ze0xOgJfxA0OCopB7IyllkrBmMqfDrd974rhnmoVi0EmOI+lZObVMBammpHtg92ihmaZxlsEzDXb60bTVZbGlzXToPT2B7Q2jRQkbzcmAi4GPU2O+afXb2G190XXotE0NlRTj/spNiH6BXHRbMqB3Rjf44shUzEmYVu4jbKd1PypEbkIt/qdxW2dQ0kGO/8w1dXyvyTLcFW5E6nNeIjSXvKS+5XVrXjzKKxtGN81++T1uZvisWqrhCx/IoKcdeaiAqFT7MDtmC+N2ufpkZQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIDRQHobJXf9Kp8ndj9viifTobsWlZRo49c4VMpMe8Q=;
 b=MnE95QGxSDUO1DtT2YTXpMpyrgD5Ej9V1BHZSm/X2GQGcm4FOPPx6MHew/cFWwNbkx23wtCMZ3KMuEh3GSTptGQKpstuFQsKjJ7e7ZahDH6qdebv+xTQne5MFlI2imEOIKjDpI+OGS6VSLElo+CO+l0oCRKJ7QMPEPXCvSvg+c18iIbsl9qA2r4vSwn+yQimGqsuMZ8azBpJ7f6OwtgvSg267hj+J8azBOSWhJ/8TblMJsCj5SeUdOK2DY3WCTuBqwjPmOmC+VYZi89eXkAYoETA7yuvfMTrhMjFfEN/IwRw/KTWUHYaeGVu5HNBm8P61qAaQzmjR2fxwpgCZmpBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIDRQHobJXf9Kp8ndj9viifTobsWlZRo49c4VMpMe8Q=;
 b=m6YQUlqO4VuXaEx+axhAMmk+Dy5/UmFPqLPHbg/YW+wxwF64MuwFtxyR6MaYjOQmOTgw1ncfGRG+JI/VV2yUGdcpYic+VOXyUTBNjP/XJbScEhhOqRZlM+vLQLtA1G5iUcR8D5MCb0/sqK6Lrx0XW3gbmvQxTaKyOXPMjlCmxtc=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 14:11:58 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::31) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:58 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:52 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 09/17] drm/amdgpu: add profiler/spm ioctl
Date: Tue, 26 May 2026 10:11:21 -0400
Message-ID: <20260526141129.592886-9-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c4f1c6-f99e-483e-af14-08debb30bfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: e2eise30XzVUf84Zz3aYZlgoXRQT3+pRNunBpW/bowYSQ6P5bkQb3hZ9o1HZyEu9tBt7q6nS1Gag/Cul0/mYf02BLF2cfFw58EnsjWdcItkiK9rwI2liON9vBovvjOeGUc74wuIorCSTXvvo2+sn6s5fu6Axz5Gbl9/LUUyyGh2HUNrmmwyUSWyxrurJNJcQ/pzE7GUa1bCMGl0wgZZVSsa3qK7kBF0uyWePjvDuG4/6/XH5cl7zAbDB5iChIip0bLe7jeem1QHAL1fUHH5itn7xg2muQSQw+yw9NZuz+Bea7lCy0VFyDWXurCnh6X69cwatAHMvPNTveqbhhsxdsIi5PXEHzwgfd1RieLobrXaRd2Rv+28HR5kimSngVkG0D8ilO/g1lcUiTPiBHBUvfSY09SqHvH7WL4nm86DwFmiT/RgigW2bhxEmL2C8X6Ghu02d89aKwQK8kg3R1i5vugJUD3efwaE0dy116ne1s/LjjqbeGxGFiMi6pauRd7/PsuH7WUItopecMmdXhJxqRXZsEn3qkK/SqT0drAv8hrIJPYJLfbPfNipqXR+5k9MDylnBR9qOfYb/D8TVeSgwxUXVskMwSsEkkaVBg534kyh245OSd9g+0LF0EpB0FUMasiWkZLcT6g+BjFeKhMFxZUnh8CQOB5MCmDqwWI9NthvBS2t3b52+M1dgjQO6o0Aflgzy7UfbQC6eiJhUpdwSAfXs0W7ISXN+8/Ov3/YBQeQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6dEtuN/S1TJo5Wf3VBVOtDT94s4IxoX2gc5GE99YSp0/E1knnBpwueP1tF/3cVNk99m+AOMz4VKw+IZUT/nghOlwF3ypGIOUm6fK0n5m0aSWvu4U6M/QYc3j83eUTtZdPQUOzGLkZiu8m9jshejgb4Y/sjADb4e52JINSWsAMYSwb+Y+NlinyHd5R0F6X80odJxEFfMihOOes/9H6LCIj45eGiDVXWDE36ZJhaZoBAlBPuFKfoW32rPH03mB35D95zaejqIeB5xhj7c3yYKAYHQu17KkBWHqOFZ4reRsx7o6t56SmrWJ/n4PIVvR/RqP10I0BSnvPpRVXuLxfEqTQ/qST9Ad4tfwyp2OOCGA1Yh1Y4BZ9z3s2EHYLEZ2aw5BkSBaEOg02Ievu3oEDzTot9eSQ7kkoEL1lF0gofTJlwzxn2x/lP2VMObP0o1QYKqU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:58.2533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c4f1c6-f99e-483e-af14-08debb30bfbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
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

to wire the AMDGPU_PROFILER_SPM operation into the profiler ioctl
dispatch path, and introduce amdgpu_spm_ioctl() as the dedicated
SPM sub-ioctl handler.

In amdgpu_profiler_ioctl(), the new AMDGPU_PROFILER_SPM case extracts
the embedded drm_amdgpu_spm_args from the profiler args union and
forwards it to amdgpu_spm_ioctl(dev, &args->spm, filp).

amdgpu_spm_ioctl() resolves the per-device amdgpu_device from the
drm_file's driver_priv and switches on args->op. At this point only
the default error path is present, returning -EINVAL for all unknown
operations. Subsequent patches will add cases for
AMDGPU_SPM_OP_ACQUIRE, AMDGPU_SPM_OP_SET_DEST_BUF, and
AMDGPU_SPM_OP_RELEASE.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 7ea3c57ccd39..16884d58b074 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -50,6 +50,9 @@ int amdgpu_profiler_ioctl(
 					AMDGPU_PROFILER_VERSION_MINOR;
 		return 0;
 
+	case AMDGPU_PROFILER_SPM:
+		return amdgpu_spm_ioctl(dev, &args->spm, filp);
+
 	default:
 		dev_dbg(adev->dev, "Invalid option: %i", args->op);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index af7ee74aaa35..6ff88dfabf1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -47,6 +47,20 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	return 0;
 }
 
+int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct drm_amdgpu_spm_args *args = data;
+
+	switch (args->op) {
+	default:
+		dev_dbg(adev->dev, "Invalid option: %i\n", args->op);
+		return -EINVAL;
+	}
+}
+
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr)
 {
 	amdgpu_spm_init_device(spm_mgr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index ade50abfa590..dc55d2a8f016 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -28,6 +28,9 @@ struct amdgpu_spm_mgr {
 	struct drm_file *file;
 };
 
+int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp);
+
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
-- 
2.34.1

