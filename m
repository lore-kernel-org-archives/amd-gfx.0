Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97869CCF2DF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EE210E7D6;
	Mon, 19 Oct 2026 06:49:21 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832E910E7D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxmaOsOnFjfTs0bneu6SPQPj82VwF0RFYtKmwpuvoRkd5DAI9+PUyPt0sHF3kt//X+oFMRwRat9GDJfEhqq9mk1MfrzKDsN5sIwTqEbqLS1bcS6yvcSjnofc3Kr4C2xolj+IZebgasYktUJPZZKeJYrpUnH97DlLAiTSdCfE0KGIUcAsAKg/VpzAHVE5Suci4KKfDlqnmuerrIIkzDCyMtg2D1M/GWWA/vfexQ6U9YmsKurnomXZj/5xHZk6n3cv6V8wiy0sN4SZOEWjH86zvGvIpPSarPFrUG7dwTqM1sb/rbxMr50/qaQdroKlqF/3GUvWjJ0BeCk+wyirZ7t7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSUWFSLpTu8w4DmE1Njj3LKLwL0/cdjkfhxmbiEa2Vc=;
 b=QNwK3elqvYueQCd4E/uvhuY7bcRCujOG+8GdBTG06Xw6E+yE/nELcArmHuuD6jGLAWzSR1HH9J4jeAazWPhsYIoiJ343C7eQTXL6g/AT2YKTAzFr1HnCAoxMBEIjRrwKR0150c+1f9u7+LZ/rh/QAMkS3F2sJkJk3C48Ad+wqr6HcZi6VZH1bUDZcIeGze4ptNNkEHGqW23h/4Z5231HFAzjmZORG5IjmSencN8XPL+78/ot93SfI8iVDE7PG5vjfa/uaZwhy7SyVwIHG82TdxGrE33ZHQexg5xnQKsPcuv1vlxYMlyTndLKVfkJZHKcdTlChhuBwAh/tfHA0dMhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSUWFSLpTu8w4DmE1Njj3LKLwL0/cdjkfhxmbiEa2Vc=;
 b=SvXn8Vq2TTwkEBaqdKL0vwWlWqLmlMckX5hbvo89P4JF0SQG0FFgFXud66bykeNwWBAX2EU2/2zGznJ3zNTUiYZURxVmfp7+HWfqkV8CFKgYxX/P0Rq+8A5bfJmFf3gx+PyxhfNja64+cgT+5Qy0I5x+S4uCBvvlJo8Hi7YWcKM=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 06:49:12 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4e) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 06:49:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:49:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:49:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 10/10] drm/amdgpu/gmc11: don't access the fault registers
 during GPU reset
Date: Mon, 19 Oct 2026 14:48:38 +0800
Message-ID: <20261019064838.2577746-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019064838.2577746-1-Prike.Liang@amd.com>
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 759bbfe0-9180-4231-d9e9-08df2dad1555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EiqTOCBnYbJlONKYRPH0Yra/1QZNvNK2J8ei4y/Oq8B0Qq+1GFYx28XJqqSNqqY6NLAB7fy7qPI/BtIW2Xyaix86sE34Ya9hOh234jsJ0i92ifO46EOjQ9fxbTFck6CjFc9u1x9672ICSFxHR93QzWbEuax0DtMUYBqNY5oAAPQNPWcAoDUyez4tETxP4fiQ6kSCIsT3VtaffguR3Pa8k00SGg509xWZFWTSPlHeUzcBcpOiBKeyJf5y0GowwEGfj82z32C3ZhTI1a5wprHAGIztaRrm3OVvoekoZRVSFl2uQByqTvJGP5vViA8YyqB+/34+GM29lKSsjcGjeI0HlC33S9w+w0LujTSzYO44q11Kz8GqQBHOUY+/2KgGLZRozIlU1y8lh3sNyaTaA1n+iXB7cXY8JOMvIAEZ8Rg+/erieC28cB9KoOT4Gm17nQHPix4xRUlblYdeNesj50yksz9Kt68QKls8EK5ApxgjVzU6OSnks1tjUOwkp0sdphlnDTqYGxx0SbiDTmlxqvi/Q1fAjUtkKZ04F93BI6ZZguYH7Im6NsLHHfu7s4Ud+uwSfyvuu26wfhn9Fzv3hcBQwqkmzpiruhd3eU57vSpcFOfrOPFfgGr/Ga98eQk/WaTrGvqEjJqXgtVaRkKW6zL+7tdebWeS18pL3CK1moyccqsPRmYJhZ8bDckSOmCaFclkxreSqZ+g39890JtrIYH/kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9/+mybsNWh5XEyjpLWrkpeXjkaEi2zgco7Elb2K2f3gyY8GcUkMFVdiy05GwD5PTLuweBBKZ1JB9eFn0vGQVioJ78cV64sWIe5Sw3Z/4Vw9AYPxxt41H03N0EcZ5ahC8TmHhoXuLybXmZ5clzrps+BqVKWDNV1FvhXaoeLX70+qQhQyz46n+Ww8QO1X8vmsbe3uCXL+skUfekSG27pkNEhjzJOydM4w5nKDX9ueZMiRXOb6R59pDZsaS0vBZ/NYJgYhKpZw6YWWoMw+DS8U1ud+jDznroZ2ZJ3kDJvADSaLzNyWj9mncaOQu3juKP7zcJwNIkue+7+IKUHJgmmnUE4z7kSIFi+48iGfK22NiS9dKX5Sf/VNw0qHKFk0Si6cMgM8b9SDlDU7FMVmEgcQ/IqxhTo6SLwGUlPAJ2ne9/carnK2fMUbRRVLirK5PCebJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:49:11.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759bbfe0-9180-4231-d9e9-08df2dad1555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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

IH1 and IH2 are processed from a work item, so a VM fault delivered
there can read and write the VM L2 fault registers while a GPU reset is
running:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_irq_handle_ih1 [amdgpu]
  Call Trace:
   amdgpu_device_rreg+0x21/0x50 [amdgpu]
   gmc_v11_0_process_interrupt+0x241/0x250 [amdgpu]
   amdgpu_irq_dispatch+0x12d/0x2f0 [amdgpu]
   amdgpu_ih_process+0x70/0x190 [amdgpu]
   amdgpu_irq_handle_ih1+0x23/0x30 [amdgpu]

Trylock reset_domain->sem around the register access when running in
task context instead, and only print the fault when that fails. The
semaphore is held just for the register access, so the reset never
waits for the fault handling. The hard IRQ path for IH0 is unchanged,
the IH is disabled before the ASIC reset.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 709c3d1b9998..bc3b1ffb5488 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -108,6 +108,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
 	bool write_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
+	bool read_status = !amdgpu_sriov_vf(adev);
 	uint32_t status = 0;
 	uint32_t cam_index;
 	u64 addr;
@@ -125,7 +126,15 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			return 1;
 	}
 
-	if (!amdgpu_sriov_vf(adev)) {
+	/*
+	 * IH1/IH2 are processed from a work item, don't touch the registers
+	 * while a GPU reset is running there.
+	 */
+	if (read_status && in_task() &&
+	    !down_read_trylock(&adev->reset_domain->sem))
+		read_status = false;
+
+	if (read_status) {
 		/*
 		 * Issue a dummy read to wait for the status register to
 		 * be updated to avoid reading an incorrect value due to
@@ -137,6 +146,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
+		if (in_task())
+			up_read(&adev->reset_domain->sem);
+
 		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
-- 
2.34.1

