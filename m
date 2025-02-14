Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC20C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1093B10ECF0;
	Fri, 14 Feb 2025 15:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ncmgaJl7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C8C10ECE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIQKv1/MjG9eJWF/cfzXXbhlelSPP0laBvCHlptQpKOHLEiILUr+SS93szE+WW+dRGHOwc85e4Tp5iReshrff87O+qvir5jhyLCWIi0vLm3j+PeAQMZUaKQFwkyp/fH95dUqEqNlTmA9jHYoocjlywk5Fa8KYFIK5lhZiEQ8KkBikBgaOH5YGf4RurEiMvuZjfOXSPkWc0XJIvloleIj3iKVwlW43D2fjw99C/RiFxJ2aSOiYm1dFCBD929MlnLHP+T4lnQbGDqbW883cEZ6BGr06sw81NT272SBhBeVs6OrfE5LQKaQiOtOLjaGi9YfZRlmFzSnRkAyyOFHFNz+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW9BgkIKiK6z4TPro5SLAvzLPdCO8vUss4TC+y9IESs=;
 b=T7On3eLjmammclQTnhgi05l0E6FxsBuYUONm82ZIy9GkShiegbSLjEBL3/dDI5UbIhRnChrhYVlDJBDQ/4NbJHRaKhixR+1X6lKLvl2rlBLBt0oyl9LfboMUxEuE2sEBHyDHfyRdWnFkLTYphJOtEYyB4m5bIX6dcBuUatVmJbSlSQzzSZjKqTMISDMcTYfvNRefN3eUtMPttlPqFqV0V5VJp4fqvm/43JuSY4PUQFvf9cPybD2Iw7nslxvpES/l0MdMkvkJgOy9f8K37F2YKirmZcOSt8oJxXQMn1K1lIXkhdy7cBrA9yFyulo+uSqauEn3Fjd2gRGgIipXCKJ8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW9BgkIKiK6z4TPro5SLAvzLPdCO8vUss4TC+y9IESs=;
 b=ncmgaJl7QrBDAP3ljg7faXwYECNP+qpoFSVio4lHlLMTMwn6NTaw1VoP1g4u5ZV8S45LNurMcPpEhH2PGmLH+UgtpvPqZ5krhheJjF0I6GnWGigfwfgvfmSVy9rS7IC0mu8BBLb8Aw1fH0LM7XfWPxzCBBRzkMoa17xmEZJ23AA=
Received: from CH3P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::28)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 15:19:17 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::a1) by CH3P220CA0004.outlook.office365.com
 (2603:10b6:610:1e8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 15:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:19:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:19:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Date: Fri, 14 Feb 2025 10:19:01 -0500
Message-ID: <20250214151901.2071738-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214151901.2071738-1-alexander.deucher@amd.com>
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 495b061a-b770-48f3-b34e-08dd4d0af29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O7UAiSOLuV05iRdR3rC9YRtpcRWTYGRuedBAGCJbj3EfX4X5pUcnoDw4eUKm?=
 =?us-ascii?Q?c51TDjhWLdSjwJ23916+ArpAv6zH7qgqP6ISa2SAi3uknMeSviRmkWqE/cnJ?=
 =?us-ascii?Q?U2xmRlSRl7qzLHdNKQSI3/Vuv9GNau29BZH/Go7Ae8IP638G7l3JUXt7WI0C?=
 =?us-ascii?Q?J5HfBgwj3/HGj7JLOm6aw/O7t8ot0Cs/5MQKqibxtZadIuJdeCPQ8NaacxWv?=
 =?us-ascii?Q?GAVKv7RpGquEwUIlvZ4I8hJvWnlz1baX9EYZbH0ukmA8wotcbwCiKC8gzn1I?=
 =?us-ascii?Q?XokchASFFXQBmppC7aMPiGwMPE7QqDd622Equ0OyMnRui5C4g1JP6SRwxW59?=
 =?us-ascii?Q?hAUXFuucSzVnjboa24JQKRWYYtKws4xNIXHs7Ckg+dM2AFopLuJFN7Lwp+6M?=
 =?us-ascii?Q?WcSSJhMx0sczyYYuJVQi55+cRCIjkBbtO3hTI7pCg+vrcRr0g7xph8eTWShY?=
 =?us-ascii?Q?N8AOeuOKEtD1S6ndtQaulXJHKeNsVpGM/ZvnZpYbDRkmwVN2RVvemvmviJ/M?=
 =?us-ascii?Q?9WqDr9rAeWYuu5YFTung+CxJTVF7pbb8xWe60iLFAtHUrsIUC50Dv6v4N6FU?=
 =?us-ascii?Q?Z698Wz0cjToLi1UrLr6fO4BU8+tBSe12JIEh8Km7XCp1PkQjdrUApHT9gGQv?=
 =?us-ascii?Q?RttPT/n3cWf+iEykwcpEU5+cg7QTAcmE9wapU13hR1iC80/Zb05biYK5rgxP?=
 =?us-ascii?Q?WJ6seYxjt8sTqlI/7T0FH8K6uqr+aOmRVFJbtwOWHSaUSnfugBUJU2i0m+Jy?=
 =?us-ascii?Q?vrxVVtRmsbuPwvprSVKuIm/qjTvu2dsRI5mhEUqEiHop4/Fxqn7M2NVF08jj?=
 =?us-ascii?Q?PhfTlFQyNZt9HxEYzJNNf1++l+PoALFJ9pcTl3X5maHe6fdEz2/wFYrVMGVW?=
 =?us-ascii?Q?muI5/tZEPQ/oAFm2ts3YeqWjq0NEgJnDXPZSeXv59xYrgPn1l+1eBbvxs5Ib?=
 =?us-ascii?Q?goDaxr5YxoH7T6w0L8FOT7l+UeBES0d9Ry5kn14qEk9LTccJwhTZy9CgFL5c?=
 =?us-ascii?Q?8bUWe/8REmT8IIbFVceaimzLf3qu9FDK0uTOB00uVXeP9XEc2nFXZkhQZCyK?=
 =?us-ascii?Q?LwLGCB/r0pNXICH+CK7FSZsv0NiQvt3HwM8rpKy8PYB6aL/k8rRY/WTibIup?=
 =?us-ascii?Q?bPxXJBkSwurdJkCQYgsRysVdJ1lRi2Bq+384Lix2vi8IIjlWGrrqE4EKB2lj?=
 =?us-ascii?Q?3mLhjdRiIhxSXRRARSsTnRTG+Slvwv29xVxkz+KWEJ6HWQPaXkYioQrBAXsH?=
 =?us-ascii?Q?1aJ59cPPHeufctxiQCurPwTGvodECzbvyfqqO2WSc7EV9ujLfnW4M9nRXKwf?=
 =?us-ascii?Q?cYP/FxK5XaDXR9qDLCvj9434ZTyWQ14lQwYHqOxrUHkMMSTF4QmMyM/OdlX4?=
 =?us-ascii?Q?wgGK1PuEFwzx0gwekPRoIZVm/msNFleVgkKFbjx53R50XjusckKGNNewSUTl?=
 =?us-ascii?Q?kmB4muyW/vnc9qvpvLV/63LXkB0lYFMVj4wMgLRVtqmfQm9QXQLyxRwQvUVD?=
 =?us-ascii?Q?Fj4eTBG6w5QRtIg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:19:17.0777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b061a-b770-48f3-b34e-08dd4d0af29a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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

Allocate the buffer at sw init time so we don't alloc
and free it for every suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 8dbab3834d82d..6db88584dd529 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 
 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 {
-	unsigned int alloc_size = AMDGPU_GPU_PAGE_SIZE;
-	int ret = 0;
-	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;
 
 	memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt));
@@ -689,17 +686,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_1_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
 	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 0xa;
-
-	ret = amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-				AMDGPU_GEM_DOMAIN_VRAM,
-				&mes->resource_1,
-				&mes->resource_1_gpu_addr,
-				&mes->resource_1_addr);
-	if (ret) {
-		dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", ret);
-		return ret;
-	}
-
 	mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =
 		mes->resource_1_gpu_addr;
 
@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	if (adev->enable_uni_mes) {
+		int ret;
+
+		ret = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
+					      AMDGPU_GEM_DOMAIN_VRAM,
+					      &adev->mes.resource_1,
+					      &adev->mes.resource_1_gpu_addr,
+					      &adev->mes.resource_1_addr);
+		if (ret) {
+			dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe;
 
+	if (adev->enable_uni_mes)
+		amdgpu_bo_free_kernel(&adev->mes.resource_1,
+				      &adev->mes.resource_1_gpu_addr,
+				      &adev->mes.resource_1_addr);
+
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		kfree(adev->mes.mqd_backup[pipe]);
 
@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (adev->enable_uni_mes)
-		amdgpu_bo_free_kernel(&adev->mes.resource_1,
-				      &adev->mes.resource_1_gpu_addr,
-				      &adev->mes.resource_1_addr);
 	return 0;
 }
 
-- 
2.48.1

