Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE79C624D9
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C94010F1B5;
	Wed,  2 Sep 2026 12:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LQ+6RmMM";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E4C10F1B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQsadQV/R08uHJ55vEp0C50WC34aGRifxct3OAZav7XSssCrgZe4j2BUR1tcP4YYN+qN/ZMRB8LWBRLsiXujsEJkQAjRw1IzQxTsZSOCPFLwR7HI6aXKP/2rQx/dQqEwWGnA64UI6RQ6UF3bIqZxnjwbRkUPJJ/L5rSr9tiZepP1ZqnpLtKTXGRMsM3ko8It4op9Y05Tmvzs73MCD/JPHIqQLngNoXdcYYEBl2nB/GFhsxlCOi4WEbcVelVv9r/NaCXLJdblzsFlNxn+/cZfUW1WS/zpbx2dbh1eiC9eYm3ZP/Mp71SFDw12VlCjfV/tYDv3nw5ux37qHF1fVEuf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0T4BLjQ62qnifxw2Ag+xzulHNMFbGrnlEGHxyXClLc=;
 b=ZyL8ATzFmRx0Q/RtXYn1gv63vb1pNoKmV2FMVEAf0DHMIYNFEjZ4dLy1WarSgW/chrtxVHian1OSQVdlGHtGqQDVnj6jIo7oJojZtevUrgb/dxT+lOl5ywmVa1GLXpx0HhVz7XgjgNOFbcP+KkanCqfBTW0CoA95LHbR9Y3jgMeoi3Yol7wJFkQF269C20gVG2HpVL5ikuGpwewQ+WVxyjGw0QsEXvNUVrbSpqUWi4/sPJMSlTO6MCNHQR8+U1Ye01AW09Kf9ee+4Jj+jjU7gRj2V52sWhQtteq+BhW68lO1uIYScd5rlGJZdRzzeuvuEu0RHMwUShTxi/eNnBEwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0T4BLjQ62qnifxw2Ag+xzulHNMFbGrnlEGHxyXClLc=;
 b=LQ+6RmMMwqymFEGSIn2vqx9oet4eolhk3+8kKtT71DxsaNI5UbqRM9iaGYaaTb6wFIGAIH+YSwKd0BX3HWO60HXc8lVvQBnUtapk3Fw8wZ6OjsbqxoJmkK6ysEElKQsgrVDb4rS2/kFAndXZKW03k6eTjegorPlUf2Dkd2NI+sg=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:30 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::23) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 12:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:30 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:27 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 11/18] drm/amdgpu: depart ring scheduler after resumming IP
 blocks
Date: Wed, 2 Sep 2026 20:49:54 +0800
Message-ID: <20260902125001.621629-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: dc656570-a817-4835-654c-08df08f0c517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: LyWLiwTAHYXzkf2j1bqnfea1ucAZHgN6JavZ/eGf35DkNfESgLeyk9ei3MVPZQ/cCKWiahkZnhnJnMlG4UT+6tkH5t0LHUD1h/urA4YSVpD0Y8MxkIOk2A4lNnI+lF82B+l/IZpUXIEE0+wMRAGQbhV7XfQ9zf3z78ERkLY2ZDMvcsMEDtITgcutdrWs1J92RmNdrr9tFMkDrOy8wHF/QhlitATSVBcNQF6HDM6osrFvcM/AiQwYH+8nPg+0QRcM4lND9P3GyuJx6bpnDyZnCcyXq9gbHrGjIsN8FuWce4pbYSlUGSD1BaXByJA74+7fqUwhU6+sFOOEUbcpDeI8DYd4fSqrNeC0j8CDBeGX5neKW8I6wUV0Mn2NbtNEJPGrhRP3DNmOvt/6MXoj1siYk7DXOIdZ1Do4KWeco5c3GhuQTdAktOIRcpf08reCMQOucOblvYA7ww2Knk0yfhT3xz5RfOpapcFkNwgSuQmK0deG4xUSHI6OIjqU3TFKOstoxPLkDXznp2BjkOLqpjhT1bD+UkwthEDosvVdTZhFETkkgarXAsWeKJ7laeWHPWRkxe5FP+rfVGWZk3VS9Fk2ToixYmG6Vr1UPu/2ebRn8a2vMxCPNKjMQyuIKLh5xfrtjLEQL1zy3qyO44whqSC+jr7nSVgi/QvUqaFjgP+hUGJGbkaLH3qFqKk+E9KGiihE/BRhAi41cWcqEvrY/YFrDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oz2BLgq3Yyo01DKVWkNLUdj5ZPlp0FTpiwpiIVhVuBgkYHQo+34RCMZIx2Vw4VH1ws7GJWfkRm5mpnb0XiF06TBIFifB1EG13842K+iea139yNmu5u0k2rCqiBcduwT1f6MEVmaiHe6kuLuEolRrziyzlkXPD2Au9W9yaNxTAqeBqcQPxIeQ0zOUQNtF8CnihCmPSEYm6q9LJHtbMFIqGwtgDGneNdZW+bDSlBx4YLNxuwWIkfJvYcY4uv87AGC+RXNcLIjleRHcFcJAraNZ9XRQxIktjN1dkEOv1MNqDVwRFejhsrT47M7Qhl+ZKbxwMMjiM3vlSQfceOKPKBAK6OXaxWKhgaJiG1RQWcFUEe+F5VHLU2gg/3NxU9nHebDCn84mj7SY+5jM+XuGRQXF7qcGvdNLuUnaXfJGNzPQRXxQD4BVfleGcV8b7VOhsDka
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:30.0436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc656570-a817-4835-654c-08df08f0c517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

During GPU reset, the ring scheduler should be parked
until all IP blocks have been resumed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bd4eb97336b1..a23950f3f634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5793,8 +5793,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
-	if (need_emergency_restart)
-		goto skip_sched_resume;
+	if (need_emergency_restart) {
+		amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
+		goto reset_unlock;
+	}
 	/*
 	 * Must check guilty signal here since after this point all old
 	 * HW fences are force signaled.
@@ -5804,18 +5806,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
-		goto skip_hw_reset;
+		goto post_resume;
 	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
 	if (r)
 		goto reset_unlock;
-skip_hw_reset:
+post_resume:
+	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
 	if (r)
 		goto reset_unlock;
-skip_sched_resume:
-	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 reset_unlock:
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
 	amdgpu_ras_post_reset(adev, &device_list);
-- 
2.34.1

