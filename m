Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BCFEDB7C4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 07:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A4410E342;
	Tue,  7 Apr 2026 07:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ohSvzowY";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DEF10E33D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 07:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzmAKjayqir4B7gemLAdppEywZ6JoIg668syBh0z+RlLW61AAoDnewelrgvnM1NjlvvGVMxaCsmpHoDo2Wp6Pb44eUxN0lrXOIAHnUEIX8N37q3OC039XyB5ldfKjd7to6YlYY2/DCgRvBl3d4RnnSId/H/9uLQhVs2NpyLGv41kxl2QnXcpzynRv/ecYjZUbNHTZP0O8aM2djebgNJPprAdibgzuoUrqtcebYFFObrEKp7wOgSrVvNG+ZIlP0iDlOwGsRR/ybpRL+RLF4srHIF8vO21fmC+vQtpyJeEui6F8iR3YRY/lUjdgNn6A6EhutNIX9Htefd6vPPfJxdcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CViqmlQwsSRs8sIpAR0XvAx5BEapUqxwjJOf5nduXlo=;
 b=cZ2rBKBUEkcvnlmO9u/NJkJU2JJFM8LoKnRH3KzblNlLzGdRYIw65/FRIbnStN3YLi0/3hPvhjIGwDgUUaqRk+JGVYns7eHRhl9qNvRMEF2hlvSC5krzwyw9GtLFhVcGx7e8ifQPd1xhr2Bvq2BO0UW7H1odff+5O3JKpC/3Dw1vSGHkD9Grqvg0CQVVBn5DksSpi7Onr5rTe5a9kVXWl+50RUvKKtWJDP9f+u06vLpX2T9ANlw5MyZ9voX9Gj7gDYha6r3q2/VvyDhR/RJSq3TKnHbKpwEWZElJvkuBoK8n5KfMtwZua/THcpEtX11NCHO9I6/kV5G8o8NcboxknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CViqmlQwsSRs8sIpAR0XvAx5BEapUqxwjJOf5nduXlo=;
 b=ohSvzowYBbe8E2N5g3aRhGUMSPcFj7etCpm0otLhkdELnpGe6GA/7FkUfEeH4RlO5f6AGBtIsstgz4KCaAxNLKztmLiJx3XrbSaNu6/f7BMHUPcTbCIPfunjCWC3YTe8b8q5OcdYhXwQ290DoEWjdB41DgOyp6crQyB9kE4oR3s=
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 07:18:51 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::3f) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 07:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 7 Apr 2026 07:18:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 02:18:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 02:18:49 -0500
Received: from chengjya-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 7 Apr 2026 02:18:48 -0500
From: Chengjun Yao <Chengjun.Yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <xiaogang.chen@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <philip.yang@amd.com>, Chengjun Yao <Chengjun.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: remove compute_partition_mem_alloc_mode sysfs on
 cleanup
Date: Tue, 7 Apr 2026 15:18:42 +0800
Message-ID: <20260407071842.167543-1-Chengjun.Yao@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: cb615555-2af3-4bad-7787-08de9475eaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: i8LJwEFr1wcQWKNkj0sd/sFLC9x+te3e/8YRBLLQTrvu+covZ66fnDPD3is72uOAgF19K/td5OpoCo3wTZk0LUuh/4e5/qMzmppVpuOunolFOj5goF/LCa7+0vO2FpZRz7PuZ/ZILCFfrjii1kmuP1O2d+H71m3Q2WKxDPfKxkRCEBAvHIn5Ucw90NH1zAyMY6z8vv+9G9IsDDRp5XPIoR15oixG/inNRBw5xamX81+DX8nMC1yf0opubXh5iCf5uB3ZKMC58GTuReJAbaEcr95nFjFG6U+i730W2POeg/c4mfVZeWn9TaT9jEYLVFDij3MfWnbKZObXNtPPO7Pcq4Li2Ra8YJjThqQojnk0iHDK+f1jgf1vrXV7uyF/oNp49mj7SA15yZxIvLuaqQTUfAP2Kf3jNwX6l87zFhCrot4VRpxWB3DOJj9J93JSooIVTA5nwmk2B8RNkNygH642iEJuiKk6sn4AV6GzQziHyvSCzJWraAERSsSngSLEIdJ8vfGjVdkPB+6/eNTAoJewv38TC0Qcl2tbnR2giTZfKwaWIX4Dzq/5BwTZjIXqF25bubB6VQf4Z7Nb2z79MlxTsIxxLI+2c7yErHWVwLM806rgN0ZwC7mvQ3Vhf9ySRvZFAGNnIExInhhpgKP0ZZFXiuCQayC8AbuQKlSBSF6xZAcdj9kUXPQNVF2PPwDbDXIwJXnSIgY30Yt6Ic91HdqgSsOKus4XuIYNFN8UAMNhPRPxk8S25dBcQqySi+v0nDlpucjSd1ZE+TrhGFYI4TWzTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DiL8fEdKVpH4LVdrQxwhv3RGGbk/djo5ZnDIi8cvp/uWJqX1QXrUN6ig0sBwjZNxebwg4gYt5e54VS6pWXsJQUzhQaJW0m+ew/X9xlpioXagUax5xduG1aipxu3zaK4ueDSdNEZq8KH+iQHIuclUgqwi/cl/9Gbyv5p+/6U68Qpbw7ovxNyy7SQ9lwzfAd8JOZ84f1rNEwJ++lm5WbF0vMjg8r1a5AQ5oVc1BoUWLP2rpAFuUVca0fsNrJSXTysEVrI9FAHScTd3PHPWpyDPXnE4QyuqzMmJscGabpWmD86iEEItaHKPNGaVY/S3jpWmjnInj6sFiaOWJuiEXp0NFPQjo1n3XM741fwNsxRZUF21PqPYIwJ/Y3dX8/xidUmZeBPMGGgX5rZOBYUByZ/PnAYaesNsLS4ycrygRZcTDakJK9o6/5mxUeAT7bPI1c+o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 07:18:50.5795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb615555-2af3-4bad-7787-08de9475eaf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

Commit eaa1281bfa2c ("drm/amdgpu: add an option to allow gpu partition
allocate all available memory") added creation of the
compute_partition_mem_alloc_mode sysfs file in amdgpu_gfx_sysfs_xcp_init()
but did not add the corresponding removal in amdgpu_gfx_sysfs_xcp_fini().

This causes a sysfs duplicate filename error on module reload
(modprobe -r amdgpu && modprobe amdgpu), since the file from the
previous load was never cleaned up. The sysfs_create_file_ns() call
returns -EEXIST (-17), which propagates through gfx_v9_4_3_sw_init()
and causes a fatal GPU init failure:

  sysfs: cannot create duplicate filename
    'devices/pci0000:00/.../compute_partition_mem_alloc_mode'
  amdgpu: failed to create xcp sysfs files
  amdgpu: sw_init of IP block <gfx_v9_4_3> failed -17
  amdgpu: Fatal error during GPU init

Add the missing device_remove_file() call for
dev_attr_compute_partition_mem_alloc_mode in amdgpu_gfx_sysfs_xcp_fini().

Fixes: eaa1281bfa2c ("drm/amdgpu: add an option to allow gpu partition allocate all available memory")
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9254..bb2bcfb33823 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2012,6 +2012,7 @@ static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
 	xcp_switch_supported =
 		(xcp_mgr->funcs && xcp_mgr->funcs->switch_partition_mode);
 	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
+	device_remove_file(adev->dev, &dev_attr_compute_partition_mem_alloc_mode);
 
 	if (xcp_switch_supported)
 		device_remove_file(adev->dev,
-- 
2.43.0

