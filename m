Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E215CD1CA0E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 02:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E8310E05A;
	Tue,  5 Nov 2024 02:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jPeEQswN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C881210E05A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 02:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/IRgurnbjBA5snuqNcZTnuG7RUShLSv+0gG/PmCe4urmdZ4QVtAATFaxUi5kNKEpSqzsc42MkVr3I0CzAOJHofIOgzLKStRgo251PO+hR28HI9J2H7ed8mb0I7SwTF7xCCwT62KJc2lDNXfzhdFYXtiAoJMuKkqECxflHv+O6C7Q+j3Selj/Dwl6u97gVkdIjobfWA/vtZFH8n7UpGUQDkIgpswyX+tkdnqJZpmmfIRVvlmb8y+L0diZlOpJ41nOsejysMmpBvyNDVGy0uCuUqktHzgyH38VvA0pGuDTUMAYiqlS/WlJHiZUsxeuRDTjF6MNI3U/rTKLLmtO7hqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXeRXz1Ox2m/SQpIGgPqsvzvE+1g3izlEMMwYgQqNLc=;
 b=ZaC+mlYAY8w0ilg6eevXL5cRtQI0hRL2WbwHQb4unAHu49wB8SNpSLAR7MNQ/W66v6uezGvHMPfIhn1bGkbjkWMB3iHmtxBtQwDAue3Frq/1wjZOsRKhoeVT59dtST3xKrVjf0HWIED29PjUMCZz7YORm2aA1Qdk31/trFtaaDvCBJOiDPog9VC/h6fPb0dQaDoy7wkMOCjAyHkD3dEiNBsmLOrZmttveIqiOe5ktAJUQao/1fjUANrJ0MFzuTYV7kdn0W3zQxq+8Rnn1a8/5IL5Cc0SKmL/bpox7dsmQWmUZLDE/5lK88GxA9rgmruRFNhaUlr0zOptDrmXAB3LgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXeRXz1Ox2m/SQpIGgPqsvzvE+1g3izlEMMwYgQqNLc=;
 b=jPeEQswNfNjviAVjvFAo0r5IXw6LNXA6n+JUdQ5HF1PVFF/JJY0Fb7mLXLGsM8vENj8BZsjWVme5V6KC9ZMoqNiibt/uQjKpl17TsDUK3rX9E6JCnNJQuBGWUDUlxhc/t+YuXZztP8rdwIjo9XZxDS71k31xZoh9LyGRiZcHDLU=
Received: from BL1PR13CA0067.namprd13.prod.outlook.com (2603:10b6:208:2b8::12)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 02:54:39 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::c) by BL1PR13CA0067.outlook.office365.com
 (2603:10b6:208:2b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 02:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 02:54:38 +0000
Received: from lc-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 20:53:49 -0600
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <emily.deng@amd.com>, <lincao12@amd.com>,
 <dejan.andjelkovic@amd.com>, <zhengyin@amd.com>, Chong Li <chongli2@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix return random value when multiple threads
 read registers via mes.
Date: Tue, 5 Nov 2024 10:52:10 +0800
Message-ID: <20241105025210.30636-2-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105025210.30636-1-chongli2@amd.com>
References: <20241105025210.30636-1-chongli2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: a77cf19b-8ac1-4013-afea-08dcfd4530a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?48gqoCCugl2UmJoUbQZ02H2O6yX7dQzQkv4XUnkz9cgk4NJmam9t2fm8B/HX?=
 =?us-ascii?Q?/p+7qzPGTbXl8c5Hs0iRMIPxPWGrh5EeKoyX66r7a+XVydVYYACI+EMHm0i6?=
 =?us-ascii?Q?vBkNR89GIiNpkkCvgfl4Orfh6ccWLzn3ZZfS6XDVxswufGkP0aa9U4k4ulbF?=
 =?us-ascii?Q?u+9jD+98c9eDmKuXipKgivOmlkZyUt5my9rJVTdag1d4XuxyvkkCI+5xukW9?=
 =?us-ascii?Q?IvWUOiWPo1oYAuX0KYJ4w/Nf/WK8uZ6f6RTaW9gxmH8oOvFsyG+wc8/XIGPs?=
 =?us-ascii?Q?rAGnfiakICVC+IpuDemYiNLBa8nPUPppnApSqgIf5YwmjC5dkloEEOKnkytD?=
 =?us-ascii?Q?U0CJZZq4xdd7bqjoxc3hCkcKxlsJEx4VNx6Fn11IWXkDtP+tV8S9iac/W5nU?=
 =?us-ascii?Q?6V70H3ZRBdLL8/tTcNZVGKgohCp9NyPgOnyjaWccGniYbHVIKGd/KnL14vd5?=
 =?us-ascii?Q?p1Bz7nbLl8n2/2eqg4IvTwKB0Z7OM2CDV2APPqtwht41qf02W9vAYuRgtTX1?=
 =?us-ascii?Q?d+ki4Zhi2IJrAEk5mpF29IKkbKgO1waqkQlcJOQbYr65vMrT9X8cWO3v2fAR?=
 =?us-ascii?Q?j5Hk/u5K4Pvcz1ZmbAsO56QxN8s6Vi3flOA527iwC+aIb6n0syJjeACXHDSm?=
 =?us-ascii?Q?WPpX5Gx+6DIO9wcgzdDehXSsJ72QNNV0URsklANQZuSS1dYGAupZafjc1G6I?=
 =?us-ascii?Q?R+e0+ogQN7k1HOI1xyEueZfjIf4z006W5d+gFgptO2RxFac9SVjlTPs63usC?=
 =?us-ascii?Q?XYcrI8SNIbLK29WN7iQXG6lYYYx1Oz9s+F9s3GbbsoxWztMn+LOjzsbwD6h8?=
 =?us-ascii?Q?6/ItDRGwNUGqHN6nvHi1uAqVGY9MHzHbE0DVKW1bkmz7cr22GAuEJYJOHIHp?=
 =?us-ascii?Q?AS2oXaqqUA8OQ1HhncJXOQTcWnsaaEB6jWwpqDvZUIdd37AUHpBzTqVt3lmZ?=
 =?us-ascii?Q?5bSqRFkXK4mGZvnMcgSMzEGJRxG7QwUJIc6g/VTWWbxBifG4N5EtLQbklWbs?=
 =?us-ascii?Q?R80A7XUMlMHfUk4VYisVCHcwZcRnqE7lM2RzZT5n//oAbv7l/QiYYfCp4cKq?=
 =?us-ascii?Q?1UZJbyrxZ2omrww+2yQx4ToMjNXH64Idx519CNcn0JYihRfCkcEgrL+iptpb?=
 =?us-ascii?Q?cQhM10ixIIj99MJ2/6nxb69M1kIgFdLvZt3k5/4wTqYU1E+c40ky2DMn5EQI?=
 =?us-ascii?Q?cgIKA+boqfRKeYvvFuhNI1SHOGi6BcikWjJZGKNPjhvNJNg/f2zG7/0m6Ji8?=
 =?us-ascii?Q?p2kqbrE8JPanMifHCUEwi4pB0RkJ1HktUT+tu3IVuOPCz0IxXluhN1cpPJME?=
 =?us-ascii?Q?ELnq+EaV0nJhS0dPNjWbHcHc5Q95QD8uvYm77pqJ1C+qdj+O54r+SPIIkqGK?=
 =?us-ascii?Q?ZR9dr6ssCc8DExryHe8bZJ/bcbYnFVMUKIx7H0s+lWxtLvK57w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 02:54:38.9681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77cf19b-8ac1-4013-afea-08dcfd4530a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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

The currect code use the address "adev->mes.read_val_ptr" to
store the value read from register via mes.
So when multiple threads read register,
multiple threads have to share the one address,
and overwrite the value each other.

Assign an address by "amdgpu_device_wb_get" to store register value.
each thread will has an address to store register value.

Signed-off-by: Chong Li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 83d0f731fb65..d74e3507e155 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -189,17 +189,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs[i]];
 	}
 
-	r = amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
-	if (r) {
-		dev_err(adev->dev,
-			"(%d) read_val_offs alloc failed\n", r);
-		goto error;
-	}
-	adev->mes.read_val_gpu_addr =
-		adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
-	adev->mes.read_val_ptr =
-		(uint32_t *)&adev->wb.wb[adev->mes.read_val_offs];
-
 	r = amdgpu_mes_doorbell_init(adev);
 	if (r)
 		goto error;
@@ -220,8 +209,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			amdgpu_device_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
 	}
-	if (adev->mes.read_val_ptr)
-		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
 
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
@@ -246,8 +233,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 			amdgpu_device_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
 	}
-	if (adev->mes.read_val_ptr)
-		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
 
 	amdgpu_mes_doorbell_free(adev);
 
@@ -918,10 +903,19 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
 	int r, val = 0;
+	uint32_t addr_offset = 0;
+	uint64_t read_val_gpu_addr = 0;
+	uint32_t *read_val_ptr = NULL;
 
+	if (amdgpu_device_wb_get(adev, &addr_offset)) {
+		DRM_ERROR("critical bug! too many mes readers\n");
+		goto error;
+	}
+	read_val_gpu_addr = adev->wb.gpu_addr + (addr_offset * 4);
+	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
 	op_input.op = MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset = reg;
-	op_input.read_reg.buffer_addr = adev->mes.read_val_gpu_addr;
+	op_input.read_reg.buffer_addr = read_val_gpu_addr;
 
 	if (!adev->mes.funcs->misc_op) {
 		DRM_ERROR("mes rreg is not supported!\n");
@@ -932,9 +926,11 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	if (r)
 		DRM_ERROR("failed to read reg (0x%x)\n", reg);
 	else
-		val = *(adev->mes.read_val_ptr);
+		val = *(read_val_ptr);
 
 error:
+	if (addr_offset)
+		amdgpu_device_wb_free(adev, addr_offset);
 	return val;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 45e3508f0f8e..83f45bb48427 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -119,9 +119,6 @@ struct amdgpu_mes {
 	uint32_t			query_status_fence_offs[AMDGPU_MAX_MES_PIPES];
 	uint64_t			query_status_fence_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint64_t			*query_status_fence_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        read_val_offs;
-	uint64_t			read_val_gpu_addr;
-	uint32_t			*read_val_ptr;
 
 	uint32_t			saved_flags;
 
-- 
2.34.1

