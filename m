Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A4C2BA18
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 03:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A687D10E913;
	Fri, 21 Jun 2024 03:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ROswPQCD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A051A10E913
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 03:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy0o/MPxDNW3c3tDQsM0JX9kgtzEzZuuvvCHBMxJxpb7hTj2iWUmbDMjM46e5dWYiatxO3FGxAb7hgvjMG/PNq3nQ6FwJnSH831ge7oXQ1c6gp1zv7xcelwdkgFzoDqK/qEb+Vy1zGLAuRKmw07vNme2V6kMPY2PdGN1FhNoohXdNntI21Zp/YQJUGTOywKDBz8VQEMEUUXBRddVHHQipcF0ZbtgMsPgfeUrMlt8iBAm6lvWq7Vq4f+8/IYOcxNkgujQUGnSKAOySasIQHwfwqTUVz/U4XDSBFcfi8enSMIqwPqiRLP4NNVEoHz4UWBkE14f7ZiKl4Qmibg3D3lfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqeszOc7FgP7+gKzVDJkW/0tV3Y2pg3ytiarWtdLuYM=;
 b=oGM2Ge5CsGUO8YP/gQgyO6XST9ehBFCS2o2zDlY/UHUQKrQ8kuhu6xRVomhwtWW9O4I+IcLVC2y/p/k86qESFjVsi6XuIv/Tj1/qKyiJ1XX9Qe/WSaUSxrS8xziJHEzoumpNqgkJvKYsn+J//u8kqfB9w/XJU8v8L7fqtMNrXb73LgcSTW7XfsISHiUsMXdwS8SpJ7sKaR9QBe6y9dozFSLOkIj62DTDd6Nyx919BErUdAbqBCpnpZuxFBy7lMfMAa58l+MG+eYr2u37Je5lpbqPIIVi2pFOI35ZFaf8Oocic+Edz12Tdj3lWRZn3heGwpfBc3YynKUYSo94Yf3itw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqeszOc7FgP7+gKzVDJkW/0tV3Y2pg3ytiarWtdLuYM=;
 b=ROswPQCD/hktnXMTiWCHKCNwPm0bN05vWYIbtkAUSxMvJg2Cq9jIcf3v6qVYr7I9/6qEcrC/pimj987+WK/NQLc+uFaoKyb81v2HmQacx6xiy+MT05AQSqjRpg7yy8xao+1Qwxt2rD4g4bgWJyTPUc0FISE8ClUlOR+fbVfk+/w=
Received: from BN0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:e4::18)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 03:30:41 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::92) by BN0PR02CA0013.outlook.office365.com
 (2603:10b6:408:e4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 03:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Fri, 21 Jun 2024 03:30:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 22:30:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 22:30:09 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 22:30:08
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix register access violation
Date: Fri, 21 Jun 2024 11:30:06 +0800
Message-ID: <20240621033006.19213-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d98716-f35f-43e7-39ca-08dc91a286b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kE6e0ppCuHeo6qE5EE4GIQseImuWDUtyt3Z2K/qOhIM4+Zv/MM0mCnXr/llA?=
 =?us-ascii?Q?XNsDvV+NdgdSbJINa6SPu0PAqDrH16Pm2E4AS0wtnqpdOPeKCtUl+fx9SVS1?=
 =?us-ascii?Q?khaj+eWPtAbCGrZMCOjacIhFX2XJ9gF6VvRZMnzZ112MgyXOL7mfICFDVvjn?=
 =?us-ascii?Q?87QSn4oi4du0LfUkz+49rX8AW8RxMOlQdBrya45hM2sGSnCDzB/jj4p42s96?=
 =?us-ascii?Q?2JQqBdEMdZq49xITPDmyznWuvLz5AM5UM6rBqleFoZnOmZoacjhKhFZbn9hX?=
 =?us-ascii?Q?Ufx6rOfa5qOoPF3wnhJoB+eVhKQKbFmwT1A1benKCfn9rezbQ3q1gWpUqqZr?=
 =?us-ascii?Q?4VGqazhThBCH5wrp2L7csAIV7AuMt9+393/PqMFuoqV3jjAgs4az10ym7v7w?=
 =?us-ascii?Q?vqCcFT2B9wzc7qO+cfFH0Zfx7CEN9MleRrFhV3jiz19clgovTdHzfWRVZCvW?=
 =?us-ascii?Q?Oxe8HxRNgrok/iY6ZM3Dgb18tTvQTGq5vO1Am09Erf/Xqg9SsPUt5liATpuD?=
 =?us-ascii?Q?y3ryxQIe11EZdStuIfUM64ANASRkaVbXrxud7gpumj6df10txV+cCfemiHBN?=
 =?us-ascii?Q?azDR/S1o0+W1Dfg1hDoj4CAo2BKFqnrsjIsfQa9l/LjLYbD/8kXJRRH1MLg/?=
 =?us-ascii?Q?J1Uimv5rOBeN6Ssu1XupmsKNlqsDz5zIpX9iraNtEGLdcLnSHJwojwop31sb?=
 =?us-ascii?Q?dRss1hD58yU7IpuyTyOp+2oAY9/c+lfAucDVXTouDfRxMs3Nw+t958BOCc3L?=
 =?us-ascii?Q?z1KdxRUlWNKNV+DqvllXtJGrr8iOlxPsNGqBjOgzPtDxXWoB5rUbhEYDZJsS?=
 =?us-ascii?Q?aWjqJxAkRt5cCFVCeA0yru1XQwgpuSb/BrajrX6WhspGgRkGt1HRwV7rreDm?=
 =?us-ascii?Q?EDSskhcfUaqa1mQTVvaZSFLSRtyrFLPYUHIeFqNz0CWrhD8psJsXofud9YfT?=
 =?us-ascii?Q?TY8cXaEBrOvGTAt7DRUkIZDRKub9o2fAS8pZLDxC7HGg8KS3QStebfFuXKVv?=
 =?us-ascii?Q?4UDlY5YlqdEKvm5q7jllnSj04XMHDTIJ4uhkj+2tHEig0GRDGXCUOIsMZdoF?=
 =?us-ascii?Q?fhlpqRQ+I0wiVYdYKnbAbv2DjfJnXFH/MG8ErXwjnWe4O74etyUsfKB30I3b?=
 =?us-ascii?Q?48GT1QXIZxvBCylXnjSD1/XSelGyDnM89/nk9VeBFcFp8jw+JN9cbzlaoyne?=
 =?us-ascii?Q?aE5t31hKfrwwcSMcL0Tfiy/Up66aL3TYPqhuB6imNZUHqXB+QCFMCHG1s5AC?=
 =?us-ascii?Q?uoURRWJqJuHerYnO/T+tOQfijZo2Gt7ahP+6EwhR0VEqQFWUDUyjFGaLRXOP?=
 =?us-ascii?Q?66Ek3mYhlGtvwbZSZpfSc4NxknHq6LrvkZuI7q1Ua1cc/wTeaJfr4HyEZk+T?=
 =?us-ascii?Q?TPNDaxkgtFQ0biRlhpBE8G/yiv93DrwA7r+Ki9/n4rBLkSsOZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 03:30:40.9830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d98716-f35f-43e7-39ca-08dc91a286b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
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

fault_status is read only register. fault_cntl
is not accessible from guest environment.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 8 +++++---
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e14acab5cceb..72109abe7c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -629,9 +629,11 @@ static bool gfxhub_v1_2_query_utcl2_poison_status(struct amdgpu_device *adev,
 
 	status = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regVM_L2_PROTECTION_FAULT_STATUS);
 	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-	/* reset page fault status */
-	WREG32_P(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
-			regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* clear page fault status and address */
+		WREG32_P(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+			 regVM_L2_PROTECTION_FAULT_CNTL), 1, ~1);
+	}
 
 	return fed;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88b4644f8e96..b73136d390cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -672,7 +672,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)))
 		return 0;
 
-	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
 	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 7a1ff298417a..8d7267a013d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -566,9 +566,11 @@ static bool mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
 
 	status = RREG32_SOC15(MMHUB, hub_inst, regVM_L2_PROTECTION_FAULT_STATUS);
 	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-	/* reset page fault status */
-	WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
-			regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* clear page fault status and address */
+		WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
+			 regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+	}
 
 	return fed;
 }
-- 
2.17.1

