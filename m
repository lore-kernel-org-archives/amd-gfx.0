Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B85C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 12:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E6D10E3CE;
	Mon, 20 Jan 2025 12:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AZrGmykZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0311410E3CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 12:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgU/KyQjGKb7/jKfKgdFhlZdopgxAhEzmjgv/vfoNy//YajkpAQ/O8jTCTGgPHvdgbL8cRKHL/MUQEF5IsKhAdD7cl2M7c+Obtkqp3XbktUcIKXlyuJRDf143R/lA51PUBND//r1bTjiyQBzE6x1Rj4plsu1k02I8pjPe76jUX9xz6Et9Xr9KXHsjGURkehWXTqThBDsc4fgiWtC/bsuFL+yZkbDx7KAtQ420KR8JDHuBQqO2tl52gF+qKpMX3E3t1WVOgrEDNREd1FhVs1eik2XUdv8xIOrRB/g9u23Acd9qH6AaGiKVrjzwDeSA2IcCv/UYZkNa9Feq340taUjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu2lyBJjrGDuAVhSpw9znwiFeCWs4w2Jbvy5V/wwiuA=;
 b=VdTrnMauM2gFIQRtyXY3wqWDgbnZCKIh7kvQeU+bF3aLSmSwVupXiaPFiz7ejGk83QRcWdtXXkSsXGZW+ZpFIHlJCxy7Qjd6iC9Z9vtpWC1BQpNEq4IpGcX8xHSVt7AL/gozpco7FfwbiR20cd4yf2/gB1i+TvkyM06hye+nrVgSMpi6h1swjRxMlr0jM7t2FsmCF42O9lTH3mE05HPjYBgJSjru/0ItjMoQ86++VoVSrOlRDHk5qmLXL18SbaldsPzERsffjjtK9KU6agQJumUPYX7/IIgHH7ySe2KzWlfi9+7UuobqfwvWdSZ8TRIaovCSskTcuu4w7ZRmJy/Fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu2lyBJjrGDuAVhSpw9znwiFeCWs4w2Jbvy5V/wwiuA=;
 b=AZrGmykZz59rsrZlaSUTEWa/k9vIKZmPUZpd1IQdTGImU8lL0OYpyi30t1kW1DF+GZ6tBqayMVUCfLhJ5QegNRdUpv3WSzTaVt0oABUwF0RzgWOEusKux4omyJdLuVv6eWiSiHqG3Ruk8BOvNOjnm2tE9aHB82kF9yqf4g4bpeQ=
Received: from SA0PR11CA0092.namprd11.prod.outlook.com (2603:10b6:806:d1::7)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 12:32:22 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:d1:cafe::83) by SA0PR11CA0092.outlook.office365.com
 (2603:10b6:806:d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 20 Jan 2025 12:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 12:32:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 Jan 2025 06:32:19 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/amdgpu: Prevent null pointer dereference in GPU
 bandwidth calculation
Date: Mon, 20 Jan 2025 18:02:06 +0530
Message-ID: <20250120123206.188410-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 87344f1f-7719-476b-3989-08dd394e7cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHFucjdlbGZqWUE1NnZucE8rT3I5RmVpTlJLa1hkNjkwTjNQUmlhd0lIVVRv?=
 =?utf-8?B?S2czQnZaZ3BPQm5HZ1pwdlYreWRFWEV6bWJ6UDhiU2gzY3ZRWWpMZ25XY25T?=
 =?utf-8?B?RE53TFNlak45T09RT3FJSmU2cXJwcGZmaHgvZk9jTjlzZUdpMWs3ZnVjckp4?=
 =?utf-8?B?aG0xZ2p2TVVwWjFaUXdKZWhQZ0xXMURMMGthZ2dIZHVMS1h3K2hMK3pDVXJN?=
 =?utf-8?B?VTdNUnBhRjZSdjFEWER2T3NVWEErZVlyR0ZOYjVvRzkxWXNkZlhtOXFkQ09p?=
 =?utf-8?B?T1pVa2NRQXZsam9hem9nSTRTQ244cE9zcTVzc1NzRDYyNlYxRXlacGRkb3hP?=
 =?utf-8?B?cGhhS3hpMGFSZXBNYy9NcFNqT1N5K3RVOWVvUTU5ajBwV2MxblM4bStCZ0dm?=
 =?utf-8?B?Z0pLdGNWS2QzeGd3bTAxS2JidGdUcWxzelJDRnFZLzcvUUpyZUJDeFBMWDB1?=
 =?utf-8?B?a3dRRk5hWklIZUxxNjdNYTM5RTJiUExwM1lOZUUzbHdLZjcvMlh4VVo2RUNB?=
 =?utf-8?B?Nm8xclhQSlZobjl5L09wTUw1RUtmSXZhcThzREgvck9JVEZGaURtYnlTQmQ0?=
 =?utf-8?B?cEZoS0kxWW80ZEVBZHVtNzNLSFFudmJhbTFvMGM3WFo3VnVwNkxTUXZZZFhY?=
 =?utf-8?B?NGVxUFRyVUNMd1BsRnJ4OWF0SDZveG5pSGlkZlZjc3VnQ1Vsd0FTbnc5WW9a?=
 =?utf-8?B?VVl5M1pZVy8yclNyZUJsR1ZPakQxSVV2c1p3VmE0aGdZZHVWN1JwOVU3OE1q?=
 =?utf-8?B?YkswR1hIdUFuKzdpaEYwQUZIRXFISXFJTVM5ajlXQVNzM0tUbXd0RWw3RUY3?=
 =?utf-8?B?cUgrUUdVWDF1V0lsYUV3VnM2eXRXM05DZWEvZ3lIaVhObmdwSUdkeFA5UGFw?=
 =?utf-8?B?ZSs5clZnR25uSHpVdlh1eklIRjY1clVjSC9MMlVsZ1NyZ285TDhLdVkzcGJo?=
 =?utf-8?B?RWFodUtncXcrZHhqVTcxRExvcnBPcWJRUGdkdHAwNisrOHVKRXNmWlFYVDZT?=
 =?utf-8?B?a1FrRFRXckdZR1NpeERKZTVxZUtkM1h1ZG5lUlV5cW41RW4rL2JqTEFBajZr?=
 =?utf-8?B?Y3ZUU3lLUTcwOHpnS1lGeUV0RHBLL3BlWXlGR2xDTG5jam5tZ1NvNTZqM0JW?=
 =?utf-8?B?TGVPT3J5UGw2S3hSSDR4NUtQN0pNQ3lFVjl4TGJ4cmdKY3NaWTNuYjh5UnN1?=
 =?utf-8?B?RmJFTW5GUVJTdEhTQmM4SWhzSEUwTTZsTU9lU213aEpWcFdIcHovVytXUVU2?=
 =?utf-8?B?STZiVlZnenh6eFl6TU9LYmNRdzk0Nm02MUNuQWxEU2doYXIrS3hOanZWcVFP?=
 =?utf-8?B?c3hzbHRqM2hqakZtM2g1Q1ZtVWZEZkw4UFB0R0x4bEwzYTE5NzFQOEV0NUNS?=
 =?utf-8?B?ellGQmtHaDNpZTUxbC9RZmFVS2Y1V3UwU0YzK1FWN1U1ZmpmMmRaNHc2cmRi?=
 =?utf-8?B?dm9UVUFEc0I4emdkdkJ6cHhmZEFCY2pFaVJ3blR2MUJ2MExDdWZMS2FHeCs0?=
 =?utf-8?B?T1RyZTNSMXlQQkM2amNFMlE4cWEzYkdtWkx4UXRHRGFtcGlwMk9HbU02Z0FB?=
 =?utf-8?B?RFlnSVI4c2ppY2NqUEVnVmI5aTZNcHQ5Y3RINHBOTHBOT3R2WUVLak05dEkx?=
 =?utf-8?B?TW14OGQvWWFuRDFVdlZpZHMxTGVXVERTTWhVd212YW1uWUxWdzNKOGdTbk5a?=
 =?utf-8?B?bW5kcGlSakhJQVNPeDY5czBmU0lkcTM5M2RqNzhhblBvbHY2WFNGZ1JPU2hJ?=
 =?utf-8?B?bDhnYVd2bFFyNTVieHpjUWFxZVVMRmcwdmN1TWI0czBFYURpUzBzM0JjclZt?=
 =?utf-8?B?VWpQZmNicDYvSjFFcXJldk1vcyt5cG5aM2kva1Joc1R6MXlzcW00VUl0Vktr?=
 =?utf-8?B?R1ZyNndpbGFVRHpKT0gzUHJiZlpSa1laYnFWZ3lzUFVHUHo2RjVKRmhuRGhW?=
 =?utf-8?B?clA3dEJQcm1KRkFHVkhwVFgwWTZGSHVURXVUQW5xY3BJMzJlTEttM0dpdzRo?=
 =?utf-8?Q?/5EXGhHDQtdWsnXjNLt5OllhP+6PXY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:32:21.7500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87344f1f-7719-476b-3989-08dd394e7cad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

This commit adds an early return if no upstream bridge is found, setting
the speed and width to PCI_SPEED_UNKNOWN and PCIE_LNK_WIDTH_UNKNOWN,
respectively. This ensures that the function handles the absence of an
upstream bridge gracefully.

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 46af07faf8c8..749791a486bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6174,6 +6174,14 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
 		return;
 
 	parent = pci_upstream_bridge(parent);
+
+	if (!parent) {
+		/*Return early if no upstream bridge is found */
+		*speed = PCI_SPEED_UNKNOWN;
+		*width = PCIE_LNK_WIDTH_UNKNOWN;
+		return;
+	}
+
 	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
 		/* use the upstream/downstream switches internal to dGPU */
 		*speed = pcie_get_speed_cap(parent);
-- 
2.34.1

