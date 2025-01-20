Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF09DC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 13:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EABB10E41A;
	Mon, 20 Jan 2025 13:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LIRRsF6E";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A418310E412
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 13:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmVUlmqBl4C66q8lShAinbHbbBNXCPBy3lGLiDsMXfVjcqUS9uaa/QCx8StrXavJ9hFCDFsJaqh0ua4e8fQPhCItwBdOhsVdPQKJQys/9kYTgMz195tarLvneka9XCMRnY+l7uKB+4Q8ZQNdM20UTYAPA5k8Qs8F2U4yvR7ATcGHBwJj22lTKYDRNY5CX6OVlSFh0KONVTs+TN5dhlMYZGnC8GUR3EZlfRvaZBTw7cubE90HWUXjM003AeJUaj9gxYtcPBH4Urebl+Izlw/yCE6KPcfq+6A06N7LM+ExWAHfOeuTW0zIOEPQRrB7ky6MhBXuiashSkXNuoswb7Yy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysAAguMrUaIovoMsrR5TSLQeb3JaTTPiQ6NOJDKpcsQ=;
 b=qXI1Mk8jSUIQHfHJj8/wIlCIGHB5BZUYhtaKMxF/N2pnNOqcmpUe3uPlDo60I3hJTbEBHHHjoexvziZLQMIJZSz+9fj/fv85LZdDEATGEWd+7P0+WS4+G1DDJOHP55BOCjOkDhqAdJT8r09KrbejzKiYQonAlGjWxRKdQnNaT5GRnQirWn7YZ+W8F0pVTGvCzoH5p0r61z1HOsLijo/JFXjq+z/4L/Ncn+/J4ojCVgplzV4FHWiDTyy8JHuRXQBX3h9TAT+7s68yaLB9EWYXxo7g8D2Ei7seseWivswwYbBti9rJBbiylN4YJp0uj6GJZMToweIFnvhWNRpmnwloCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysAAguMrUaIovoMsrR5TSLQeb3JaTTPiQ6NOJDKpcsQ=;
 b=LIRRsF6EpP65HwXF7sRkLswoMt2c49BeRNB94XrXdm8xkZG4LO8bNDPZGB6nmOByJH+daP83+j6vtXLhE8A/7FbqFuQAOK5zh03fcU45KUesuQLfNIKj8rVvpzcf0yRUpIYy2GTPxH2JOMAHTg4/ZnTRu45phy8p28jBNrbZZaw=
Received: from SN7PR18CA0020.namprd18.prod.outlook.com (2603:10b6:806:f3::14)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 13:32:16 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::e3) by SN7PR18CA0020.outlook.office365.com
 (2603:10b6:806:f3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 13:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 13:32:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 Jan 2025 07:32:12 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v3] drm/amd/amdgpu: Prevent null pointer dereference in GPU
 bandwidth calculation
Date: Mon, 20 Jan 2025 19:01:47 +0530
Message-ID: <20250120133147.233770-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 34aad4ac-0b3e-42de-a3c4-08dd3956da90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y00rb1o3dXBjTmxmdXg5cWYycUxobVA2MGc4MzB4VVlwN3hUc29nKzN2WWUr?=
 =?utf-8?B?NTlkOHBFTFdiR2I1ZlpVRnh4bnZIMXlEOXMxK0t6dDgwaVRRWk5rdm5CSVo0?=
 =?utf-8?B?VVE2dTVXczdVRkEyVXZ5b05YT0hRMW9ldWt5VlJRTlBvNXpmVjVYSE9lNVRz?=
 =?utf-8?B?QWxhR1RJc3hmUTFNMERaWEFyL01PVUNaU0xiSlNKaFNWdWN0MmpndnFsR0V6?=
 =?utf-8?B?bC85aUpxcEZpVENQQTJ3TVk4cUY4WnZkZzhKdUFqSEhkTi9hQmF0bVJrNTdx?=
 =?utf-8?B?VW80M3RyNXRhVHljbmhWcnFDOElQLzRGWk5lQVhJdjVsS3NvY2lxa0ROVi9o?=
 =?utf-8?B?WU1IblJEc1lMcFFKc05MMzFRbmZxUVFtcHFLU3N4YXdJeHdpZDlLUXQzUlZv?=
 =?utf-8?B?dDhjN01KVUE2dG52QTBvSDNLYnN3YVpTb21wd3d3RnBLNGpwSlJrMGdnY3Vi?=
 =?utf-8?B?RmpvUGI2dDVsNFFrWHQyV0wyd0htNVFUVFdHTU5Gc2dwUjFGQkpXQ25BcnRZ?=
 =?utf-8?B?TUNyK3FNVllKdnozZU9vbWc0T1M3UDVrSHBmZnFFQXpuY3VZWDd6cERXaDdK?=
 =?utf-8?B?MlhBYjYxc3dRVE9YM0JsWDErNDd3VlR5YTAwUE84Y09OMXd2bW1vT1BnZU9n?=
 =?utf-8?B?eUdXMHRYVTYwek9SVUdiL1A5QU5TeFU5SHlkaTlQZTUyZldoVE1HR1lEVFlZ?=
 =?utf-8?B?bGlmYU9WRHVld2MvcVo2VGtvWU1aRENWTTIwYS9lc2t2Y2xhQVBLNGZXazdk?=
 =?utf-8?B?NnBLbTVEN295dzBUOG5MRS9tT28yY3Izb0ZyMXZqUUtORnNBTW9SaHgydzNl?=
 =?utf-8?B?WlB4T1lBTk1aT0ZXT3BDRGVJa0E2emUzUC9mOVFrWkw3VjZNNk9WcGxWT25k?=
 =?utf-8?B?QlZweDR2L0k3aFJiUHdFeSs0cUtNYUE0K1Z2UW8xSEs0dmJxUURLVTNqeUxZ?=
 =?utf-8?B?cXVwSGNEcUJaNnJqOThmUlZtNWtTVmh1U1lIaG1wYndFbElkaUNzZ1czSWZ4?=
 =?utf-8?B?Q1lLNWRQN3AvcjRkOUxXVDlTRVJUL1hBM1ZpdGUrYW9JV3R6dlNBMWNtSUxt?=
 =?utf-8?B?a0thdXVLZGlIQ2xYR1N2ZnkwWUhGbWNuQytMeitUOXk4UCsrU3hZOXBtaTNr?=
 =?utf-8?B?OUpNaFhNS09WUWdqdzBlQUtueVZvVXNGUk9aSDNlR0JlbWJPSlVpU25uVkNT?=
 =?utf-8?B?QWp1WitLckdIREtWNW54ZlE1ZWsweVZTeC8vN2lMTnNkZlY0aGx3UkhrcE8w?=
 =?utf-8?B?Sk1MVGs2eUJKM3ZvV1VNNU41S1JOeUJ2YnZiZnRPR0svMWJBOUhXWHdSYWNF?=
 =?utf-8?B?VTAwNWhvUUVBekEwaEdFditmUEd5YTZhaDNSTGJkZFdLUysrU25DcWxSV0hS?=
 =?utf-8?B?Tm1uS0NRdERoSHZzd2RWUkpjVnBsV1hZVEtMTHorTzRGMFZhTC9PVlJFOXBk?=
 =?utf-8?B?UUN6cUZKVDM5VjhMNlE1ajlTTXVDSDh3S1NsKzU1WjdzMEZyeFpsWlZXN1Rs?=
 =?utf-8?B?eGI1bC9FVkI0OEFhOFdOYXRvVVBEWEdmM2RYR0tyRWRSSzBvZ3lGY091UE11?=
 =?utf-8?B?SnEvMlVUeHNjTk1KdS82WXBRc21aVEZXa1BEeTdZYVpwOWx2b0FxbDNQL1p1?=
 =?utf-8?B?RE93R3lFNTloM2F1T05zaTZwbEI1RjVkNG40eTY0QlM4VzdCL2YxSTBERGRJ?=
 =?utf-8?B?T2hmWERTUXpXb1dqL3dncVpXaHRZbWdBZ3FwOVhqaUw4bHozMFNUSGxFUklS?=
 =?utf-8?B?ZUdWRGtzaW8xK2NNRnA3ZWFZeUVxTlVEMHk3SWpTZjRGU1gwdS8yZVA2U3Zr?=
 =?utf-8?B?VDV3cFdoMHVLelBXTXprNndPMXVMSnBDR2hLRGFPT0ZPMkpodkJvYVllbDRj?=
 =?utf-8?B?MitnOFc3Z0ZlUUZrVHI2dXpTc1VzaURoWVcrU1dleWNabEUzMUVIR01HUEg4?=
 =?utf-8?B?VGFjNjJ3c2ZtVXkzZ2tUOWVyUEVQL1R4d1VnR2xNZmxGRmIyVS9RdmErUWp5?=
 =?utf-8?B?ZThacU1EYkJnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:32:15.2580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aad4ac-0b3e-42de-a3c4-08dd3956da90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

If the parent is NULL, adev->pdev is used to retrieve the PCIe speed and
width, ensuring that  the function can still determine these
capabilities from the device itself.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6193 amdgpu_device_gpu_bandwidth()
	error: we previously assumed 'parent' could be null (see line 6180)

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    6170 static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
    6171                                         enum pci_bus_speed *speed,
    6172                                         enum pcie_link_width *width)
    6173 {
    6174         struct pci_dev *parent = adev->pdev;
    6175
    6176         if (!speed || !width)
    6177                 return;
    6178
    6179         parent = pci_upstream_bridge(parent);
    6180         if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
                     ^^^^^^
If parent is NULL

    6181                 /* use the upstream/downstream switches internal to dGPU */
    6182                 *speed = pcie_get_speed_cap(parent);
    6183                 *width = pcie_get_width_cap(parent);
    6184                 while ((parent = pci_upstream_bridge(parent))) {
    6185                         if (parent->vendor == PCI_VENDOR_ID_ATI) {
    6186                                 /* use the upstream/downstream switches internal to dGPU */
    6187                                 *speed = pcie_get_speed_cap(parent);
    6188                                 *width = pcie_get_width_cap(parent);
    6189                         }
    6190                 }
    6191         } else {
    6192                 /* use the device itself */
--> 6193                 *speed = pcie_get_speed_cap(parent);
                                                     ^^^^^^ Then we are toasted here.

    6194                 *width = pcie_get_width_cap(parent);
    6195         }
    6196 }

Fixes: 9e424a5d9087 ("drm/amdgpu: cache gpu pcie link width")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
v3: change the else s/parent/adev->pdev (Lijo)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 46af07faf8c8..8ed7f2f8546d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6174,7 +6174,7 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
 		return;
 
 	parent = pci_upstream_bridge(parent);
-	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
+	if (parent->vendor == PCI_VENDOR_ID_ATI) {
 		/* use the upstream/downstream switches internal to dGPU */
 		*speed = pcie_get_speed_cap(parent);
 		*width = pcie_get_width_cap(parent);
@@ -6187,8 +6187,8 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
 		}
 	} else {
 		/* use the device itself */
-		*speed = pcie_get_speed_cap(parent);
-		*width = pcie_get_width_cap(parent);
+		*speed = pcie_get_speed_cap(adev->pdev);
+		*width = pcie_get_width_cap(adev->pdev);
 	}
 }
 
-- 
2.34.1

