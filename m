Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8103BC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 13:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1882310E387;
	Mon, 20 Jan 2025 13:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aLcYHBO7";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FCE10E387
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 13:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhJLHrx68XuKbrGdCy4Gzl4CRDR76J2tcWx+nEl4M61Hac5mqdVtsa7pnHRJ2AdqIQ9h9hCFJ69hps0yTQGWkmi5sHifAm/cIc27qUepvXk5BsFrx/pXm1ri6G5kpLhFbXPL7L6WZcSqVXATCanxktTcsNh9Ibk00dZZmCmfGUePdsm2D6iD+or8N1BMvSCMWNb5JrPE+Wqb1w0dKnVAYBvSMPl8ZP8UOpFj+m/Hg7pGFhejMpI9pzh5bUUtkxjksAYmU7afj4ES6xtzPHt5U5Ky4BQk1NqHZBkQFR9edIwwSZa0ZOLJVt//4iZ0OSF6/3bMu5dv8/KhOZNj8teo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAM540lWawXY0SUJz1n3IggGeiDOazAN/42wtHPI6EE=;
 b=GPtPzVLkHHiuVvLZpEHVJvs/GlZ48eNDzw1cMXklVzGk2gbBge5aGnc0d56TaudogtC7ta1Rq5LzusXaMY/M9LylV9RTePT/iIR1Z3cvt4/D/dKrzw1SRPOgcotYbmNaW65ZSHWanAZzZX6aUKcSvJ+6/j27ueLIo0s/BQmCtiKdw4maG4D4h1g5mFnv6sLlyTn72Xc7ueNxkHPObpgnbxna15qZ3xyDTVt5dXNDW+MgQ4h582cnE8qIZEhE9eIMbn0Gyb2MsNd8WaMUIxxxo6VGQS+YaRYLnnGpe7Ojh2c2SlfMLB0PMkXB2nXJ1i0o3BFDQvBRbTNiI5fnvz6pDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAM540lWawXY0SUJz1n3IggGeiDOazAN/42wtHPI6EE=;
 b=aLcYHBO7TR/ILpsfCXcxuS/Xtl6YSL0yO5652TkU0BEGoIPKSStDj2jMNl4gYx3NCrx1lXOvOS4gW+y73cWZH4eP7yGEWUuPEF4efFU+c2BnnaEynIBbM1I/kgsKILKjCRoKN5wR3IaIwn/JRez+3m/lGvbUONDH4vLR6DYcx4U=
Received: from BN9PR03CA0257.namprd03.prod.outlook.com (2603:10b6:408:ff::22)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 13:11:51 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::4f) by BN9PR03CA0257.outlook.office365.com
 (2603:10b6:408:ff::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 13:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 13:11:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 Jan 2025 07:11:49 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Prevent null pointer dereference in GPU
 bandwidth calculation
Date: Mon, 20 Jan 2025 18:41:37 +0530
Message-ID: <20250120131137.213765-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120123206.188410-1-srinivasan.shanmugam@amd.com>
References: <20250120123206.188410-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fb0c9e-d7d6-481b-b5df-08dd3954011c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2FydmsyUUt3dFNMdm8yRmdhWFJ4WWRTVnVrK0xKZFRXbXJ5Y0RkVXJmZFRM?=
 =?utf-8?B?eGt1N0NnTWlWNXpXU2NFNGVUWFdVb29LV3VlWkVTQ1MzQURhYmtGTm9LL0x4?=
 =?utf-8?B?VTl4clFSaHl1NGtSbXZGTlZ0dW94cmhqQkFtTndMMmxVM2FkTlM2dXlSZkRH?=
 =?utf-8?B?RW91OFl4Vnk3WGN0MkpnaTRFRkN5OEVjYVpmNnFvQVBTZWZ2dmM4V1JkMTBW?=
 =?utf-8?B?V2ZhSFdpQWMzeFVSM25YM1BsaVdnOVN3SVN4NW12Si9vTWpaYTZpSjdGTWJF?=
 =?utf-8?B?QXFHaHlZSXpMMWp1WU9XUkVlYjVIOE4yY3N4SnFPc3lEcnFaRjFERWcxUnN0?=
 =?utf-8?B?aGo5ZjBBTTlYWU1DM2NvWHNvQVhiamJvaDBmYXI2Q1p6WlpXSmNlc2Q2MVZO?=
 =?utf-8?B?OFhDcWM5QTFCdUxtdmE0SVBsTGVVSlZPNVk2UVhmRkRVUkMvZXRNVm93RVB5?=
 =?utf-8?B?VGpwUy9LRzhzWE9oamIvb1RoR0Q2YjhrNlhWOURJQ0RxemxzMGNhelRoTW4y?=
 =?utf-8?B?WEhNNXZUUVk1SXZSOE5vZjdDSGNYV3FpSmdlUGs3UUNTdmE1YjcrL2JMTHdn?=
 =?utf-8?B?UlZNbmNwMURaR3VtTU1rOU5USUY1Yi9nditmenczbFpjcy9qQW9JSUNkRElN?=
 =?utf-8?B?OUJJVU9UVldyOHVIMUdHN0hubU5KZ0lVRnpKUDZvZTd2Wjhyb094Tk9zZ1lj?=
 =?utf-8?B?dlF4WFVaUDgxQTVTcnBOTFk2aUc0RHEwTEdJaFpJc3RtMjBDZFZ0T3U2amI5?=
 =?utf-8?B?OWFHN2ovbVBpYWNxU21ocElXRlExcFZUYVY3ZW9USFQxVTkvRnJDcnNxZk5l?=
 =?utf-8?B?bm1kbEx6Z1ZJUUZqMVZINEtXQm5JODFlREpDZXBRa1R6clk4VXVmYmY2K2Zk?=
 =?utf-8?B?NGppOHNSMzJnN2p4azNXZlY5WGdKOW9Xa1U2dXM5MDlXK0UxVFlTQVZ4cGpK?=
 =?utf-8?B?eVMyZjV3b0RQNFBhRlE4SkNNTXRaWHpDVkFPR1hLWDREeVUrUDU0Y0dSTmpt?=
 =?utf-8?B?VDVKa1ZueU9McnEyeWZyUUpKalE4emlablRFVWg0cUErWDhidXM3MXNOUEE5?=
 =?utf-8?B?ekd5b3AvQVlvN0ZKZzJBdUYvbVl4cTNOMDZYQ1k1TVM5cnBDcVlDU3VoZ3Bx?=
 =?utf-8?B?amJweG1wTTRUdjdOVWpQaDJNdmxDVWc2dDh4YVhNNk5zdzVKVVFRSkI5QzJ4?=
 =?utf-8?B?eWF1cmZzU2lOK2J3c0V6SXgrZTBmSGdESjRuNVd1dTRwSWNvTUVCOGRXZjJu?=
 =?utf-8?B?MysvSzRzUTZpbWVHblArRjg2dDQ2ZFQvK2Z5Y3NKMGIzai80L3YyVitoU0l1?=
 =?utf-8?B?UGRsY0pxRVZNNGZodzBBVE5yRHExN0JtSlBGem9kZEduQnhGeUZla3RFazVO?=
 =?utf-8?B?NWlZMnBHOStDb0ZUZHVOY1poQ21nVVprdzN2ajJDUC81RktDNkxwSFpUMzRo?=
 =?utf-8?B?bEV3MVdlcmtQSnE1NXpSNTIvcllwMTBwM1A4NFpVMFhKT3Z6UXppZkVYOFc0?=
 =?utf-8?B?ZWR2bm9mKys3MFprZStQVi9NMys4cUFseHhweVkyalNyOWVVVzRoZ0s1NW1O?=
 =?utf-8?B?NTFIL0J0WTl2YlRaQ3orenBJdW1ra3UzUjhqUWhoSitvMGpCWStFUFhVQmpZ?=
 =?utf-8?B?bjdMQy83UUx6U0ZuVjhrS051VEo4MWlKSGdJQ1VqVVZMa29MWUpiTVdUdm93?=
 =?utf-8?B?cHJnSTdTbXZjTnVvazZReE40L0o2MTNnclc5NllZdmdYTlQzZVFCSzdRTVJS?=
 =?utf-8?B?cExJNCs5T1FzY0hxUGgzUUNldEdWMklROVhoN1FZa29EdmJvS2R1S1BXUFFD?=
 =?utf-8?B?ZnBuMmNCLzFyY1VPZTk4STFwZ3FndkRkSXE3eC9taUd5UklIcUk0dHhKQjlo?=
 =?utf-8?B?cFpudU91S0crS0IzbGFVbm8wS2pydE9pK203b3VWOE5lbkV2TzI5dHcyTCtN?=
 =?utf-8?B?dllZaUdoT1dhZThheHZFUWZEakJ1VlhucnRucDMzT29qRUZzeUxoZmthV2h6?=
 =?utf-8?B?VCsvbU1oSVVBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:11:51.4548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fb0c9e-d7d6-481b-b5df-08dd3954011c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
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
width, ensuring that the function can still determine these
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
v2: Use the device itself if no upstream bridge is found (Lijo)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 46af07faf8c8..3df5247b1221 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6173,8 +6173,13 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
 	if (!speed || !width)
 		return;
 
+	if (!parent) {
+		/* Use the device itself if no upstream bridge is found */
+		parent = adev->pdev;
+	}
+
 	parent = pci_upstream_bridge(parent);
-	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
+	if (parent->vendor == PCI_VENDOR_ID_ATI) {
 		/* use the upstream/downstream switches internal to dGPU */
 		*speed = pcie_get_speed_cap(parent);
 		*width = pcie_get_width_cap(parent);
-- 
2.34.1

