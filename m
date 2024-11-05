Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6BBD1CA16
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 02:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B5C10E3F4;
	Tue,  5 Nov 2024 02:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zii2SxjX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A1210E3F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 02:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk1+0Swz+ujrxypMEK/EtZXov1IHZqTgCjbWyac28WaKwANP83brUAfNckYWd/30jniYNY+OxtkhZnC3uwAguC6n9Dzoh0K3HYihxEMG33P0vv17yogU8LBeVvgwgMOEWgfrVv028Uq8qX/x1pazvR+w4lKYb2bjBFT0aKBQKW2Bv2KH2DQBAdx3VczfRRmzNUsnkMNrGN1XDv6L1Vr5ixAKUNASjxHE7ygHHTrtRRTCqj18n8ZJZJPoVXqUq5vbhkWErCiRPrKXNUYCeWLMlltGUuw0S8EjxjLLbqoIns0utLQNioZJ4edhbD6X48bpQozWYpZwyTAw9YhkZQtRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXeRXz1Ox2m/SQpIGgPqsvzvE+1g3izlEMMwYgQqNLc=;
 b=gwO55FcHIGQx7aGyzwyO90U/WH3V9L+KmZqe2kvYymBdNcUCdzvKfVk/i1zz4myTV2JhsT25xQaUI2aq8OusjZzq6+aMAnxbVap49zZJw2Y9012X9jVeL7+Jq1hJqtQDCXzjjR6ddZdNUjejSDEdHiLXpN4Y4n0lh51mOb3WRg7XNa3WblqXsU13tRIs+gq3JJTEY84w+uQViElYg/YVdcaIQWtKoY9H54VcvuG8SsB5brNQ7DGunCF0b5NyGkGl1XAT0Z4i626wZM6ikAPhoe1RvZwBUZxUZxLjEjVY8969Y4CXL1bl6XSvVM0Nr9rrqIrTooNWoDaklJu/z1KdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXeRXz1Ox2m/SQpIGgPqsvzvE+1g3izlEMMwYgQqNLc=;
 b=zii2SxjX8LuqbAeUVj/aMEgBDVcvLmlpGKXxDFuu9K+mDQOfr0oApmsMUXSsZqdF9owcpl1ZP5Q3aXwTFqwA2sbLaNwZseLUlHelOJnw8uzxMAt9V+3s+bHNZJtNPLnXUYL4JPBnSt0RsPr6VDExAidmRYEKoAAOR2/zCRPXZFE=
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 02:51:32 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::92) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 02:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 02:51:32 +0000
Received: from lc-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 20:50:25 -0600
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <emily.deng@amd.com>, <lincao12@amd.com>,
 <dejan.andjelkovic@amd.com>, <zhengyin@amd.com>, Chong Li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: fix return random value when multiple threads
 read registers via mes.
Date: Tue, 5 Nov 2024 10:48:51 +0800
Message-ID: <20241105024852.30452-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0e8e15-21b2-4154-5262-08dcfd44c15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VTI+R7COduJoYDsTpxauTddMcOJ1KxppZy70/PK6EhGaW6sv3YvGqJkQfxof?=
 =?us-ascii?Q?6AbBa7I3vUj34zz9qbqeTWcuqf6XE8O7EnZo7re+k3uMH+i+iwUyNKPoQNoR?=
 =?us-ascii?Q?4c+GgYcFfAdxVujDGhtinNSw5XFpx08DmI3xYgyVU3l9fahTZXCKIRSe0R56?=
 =?us-ascii?Q?DycDIpS8QdJSr+FBSKbg7Y3iuD8LesN68NZ433Y7ENz8P/kzkYmb6oanEgjj?=
 =?us-ascii?Q?Pe2bXP4m1zAxntxWo74bqOk5Q+rmCyMBx70zNsBZiN/ocsSJM0yDKTCa7hph?=
 =?us-ascii?Q?7VNirCEnbZZlSOMTwKmNbD/N8auHW7DHqfpHj2ZK9MymM7y6w6TVs0lZnTYC?=
 =?us-ascii?Q?KsANLdlP4aLfCdyxsOoUTmisUnQanVuzK6lVEESZPaBFVK0tcwxwKGZdMNtq?=
 =?us-ascii?Q?5NW9p5iisWcc8iDMsaW+ldiwiOCxHzhXePSoRC024mETGIuF4EqVxMiM0r1I?=
 =?us-ascii?Q?v64lKxsaLYVlTxq6XeDUW3yM74HwSgHDoVxwnKqGI/pjhCezsJp8lYfKqEcF?=
 =?us-ascii?Q?Bsa1lPzcpS5dKmS+coD2zbZtpLYPS/LegkCB/Wqjrrw4HrKvlSEF8xhdYvdd?=
 =?us-ascii?Q?/q+YC4H7G+JPUV8386YJHGBDv7Q927xRUAU5KgSN0C71+3KLgvTkk1NZuRv0?=
 =?us-ascii?Q?2U/OReIGovOqtf5aIOM1HskEv4Cs8W50PD3FfYlCs6c3LLoz+xHVz6TAQPM4?=
 =?us-ascii?Q?wQDEgu4wigiJhjBGRmwiZHJmgNkHInthVEbdiUxFIlU1ajsFi/sIsGTG+wBp?=
 =?us-ascii?Q?CgGCsrezfN/jDD/1V79YWcoiwxDHYtHrm3fW99stEkM3Ee+S2OZMkXOuhjf4?=
 =?us-ascii?Q?G3qYI53sVOEcGWM+EvAKm6U83fc5hioe5GiVkNfobQHhyJGEDPwQL5T4GCXp?=
 =?us-ascii?Q?G8qyvcUCh8N7bmK08h5DeBCGZWuT7p+LfveG0TMkG58/NurouRGsk3pxZdV0?=
 =?us-ascii?Q?4RFKBfSo9S+fSU2dK3GD94a593AWzo3mbrJyFCKGXhsY5L6WE39qvFKJEzjn?=
 =?us-ascii?Q?sVqV231xHKnSmQ/Ntb+dHSw+gJh7RZmwBlzzOMa31+xGvnAdZTwCLRt2gLyp?=
 =?us-ascii?Q?E7NhoTT/cjiRcYSJwT9i4WvBQcE9gzQ0aopUiH9ojupoC8XjEAzvtjyaG+2e?=
 =?us-ascii?Q?f9+bvy3y8CuLKtTnrZxf9aIcZwPqNCvHRQnKUK7p6X++Ew+EzrE70dvTzRSi?=
 =?us-ascii?Q?dOaEMt5jlhLRMA40DmZHcWXK7EjppjCnbkJ54+WD2al7WRmr2NDy7SOapXjz?=
 =?us-ascii?Q?YxTwGfcJIyxNgs18d1IAw0FUrgXT/qdScfegHKbcryg4+G2b7em1iCDp+MNe?=
 =?us-ascii?Q?w1BtgYlRb+vRVySHEFqNlon4736nGUiTP3r75FLGIiVHs9ucytQDbMeV+Bzq?=
 =?us-ascii?Q?W1xV0AW63l/jS5dZuy20859qZ61PoiYCBhlX3OI7J+dyyq6Hvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 02:51:32.1574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0e8e15-21b2-4154-5262-08dcfd44c15a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

