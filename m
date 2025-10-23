Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456D2CCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 16:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE08D10E92D;
	Thu, 23 Oct 2025 16:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J0EZMmDB";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E4D10E92D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 16:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4jP8HKPAVoUjz79/QBqkdnYtTMHzVwni0qpirk8sOfPLixZuUUA3UKKGBLnnjVOwnJwiaohV5IH5t2PIyPbd+lqAtBgJMqBUxVTuC46+093Q6GwEMouY75trlX5CbKTbe4YdLO6nRIpAVqohH5fr9u8Sq5YSm2nGWwTLPvjzwBfjEUxCD+g/PBOki00m+vawaB9pbJ3PMjWNYyAHLDmOjYzQDElGhBpdvVWxZsnLbD1gtzUvUmN2YBIl4rAaXa6WkTdQg/j/e0JZ/I5hQZk6pLoyOvggXmpYjFHJnIF9WmvCWq8ZVR7tbRJ8ud/QR3ynBi29RMbBxz8EWm92wSI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycZChZ4KnfjZPHhTgdFE8HqZ6SjKOcq6E+2QQVkQ8mA=;
 b=s/dyPXGQl7hyPCXyYCIhfGpwMSCfFmP0j7ap7Vj61Evo0gZlAXroXfF5FiFtxXKHeY+sIK2Uw6Xw+j2O0yh32VnU/u63Tuny9u/5mXj64y7XJUUR5MpwuBBhyGv8g/LbBqthx/PoJCxjqF4IjjtUNaNpsac0lPyTG81oLeiGRF9LXeM/bNwoowUWgnRJzBSMNOg4q48k4s3iyaMY01XpFKng6bhd57UQzls1Rnj5LHBp/j9IJWOkADgdPwkuROUdPVm/n0Ow9AmOYNytfltvUOOiu1TIbH6bxSdQB3O3G1Y4EwznUtSvEdHJx0QFzCqBtutHxEwe2x8xUoxESylKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycZChZ4KnfjZPHhTgdFE8HqZ6SjKOcq6E+2QQVkQ8mA=;
 b=J0EZMmDBuRVaqgKZ4ivOI/nCipnrrMoxyxFW6A80l1egrLct17U/KyX3dtVZC7nrR0dm6wxjUKZ3b5PJIdRs38On1Hk4Ixc3fO73gvutFH0BhL1GGUDyH/hcCQcnzzRbrKsVP3UYAsToV47ZX/y2z2Szd/9lK2iWGw4roxwQ7CI=
Received: from CH0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:610:e7::15)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:16:37 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::a4) by CH0PR03CA0220.outlook.office365.com
 (2603:10b6:610:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 16:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Thu, 23 Oct 2025 16:16:36 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Oct 2025 09:16:31 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amd: Reset the GPU if pmops failed
Date: Thu, 23 Oct 2025 11:16:19 -0500
Message-ID: <20251023161620.270811-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023161620.270811-1-mario.limonciello@amd.com>
References: <20251023161620.270811-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: b785fe91-3326-4197-2c3c-08de124f8a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEcxRVhyYklEYmp3VlVDSjFOckg3V3FhaUpmWm1ONE9hWThDU1E5bXM2WWpt?=
 =?utf-8?B?UDRZUXhiNUVSemVjR0ZZUGlKMVBKN1gvUnVJbGtaK0hKL1loL1hQRDdaVis3?=
 =?utf-8?B?RW8zdkp5cjE4QmZRbzQ4anZhRExUNkZoMjFueHU4ZnExaEcvRnRqSjh3bVAx?=
 =?utf-8?B?Tk5NWUs0UnpoMElQRTRqYUdwMVcyeGRzbDFIQ3FHa1VNMnJkQTBoMlRnTng3?=
 =?utf-8?B?L2loUnJTUG9BeTcvMUJ0STBOczBTWjdJZm9oSDJuNDlQZVBKT1FkNlROcGRK?=
 =?utf-8?B?dmVKTUFIVC9WQnFiMzZEUW84MmxnZnpxalQ5ZTJiaVdJQ2owd09QbGpmSDdF?=
 =?utf-8?B?VnRJUUtNV0RNRTZyOXUxNVVyR0Fhd2ZESGNHMWhQSVRnUDFYYmpmNUtKKzFQ?=
 =?utf-8?B?Yzk4MWZsQ1R5eVYzTnZRZm5oNVJrQ29ZVW9MRk5MY0Z6R2FuRU1xOVl0YnVq?=
 =?utf-8?B?V1RFbUpzWjVaZ2RJV3NrOVgwNUNiQzNMN0pBRHpheFFxZlIrelFlL1RsSVdL?=
 =?utf-8?B?SC9JOGtwUXBYcDdMcWZlb0F0SHV4YmdVVEFtaHc0d3dGYWhFcWt5QTRZSUZE?=
 =?utf-8?B?R0JJdERYNk85MXFQUFFsVzR2SHVZYy9XMWEzUE1PcTJqRXJGNFE0Zmo1NCtQ?=
 =?utf-8?B?aEVLMEQrR3U5MUlwSHJKR0E3UFZGVFMyN2tNRU1KLzk0aVpqeGZvaDJxWTJI?=
 =?utf-8?B?L0xXMkhZZVk1NlZWdFFtUE1HczdzRmJINmV4SFEwcGRZc2plSlpTMTdxOWZ5?=
 =?utf-8?B?bFR6MEI5Myt0UCsvTGxWQjlCdkFaUFZVRWhZVHBvNjNRWk9HU0JGNmY1MzJP?=
 =?utf-8?B?MFAvVjR4NjJ4SHlXeHN3ZkcvZ3NYZXV0R2kzSS9GSTMyVzc5Qzk0ZnJLVDh6?=
 =?utf-8?B?N0VBV1dFRWZXRVRhUnZOKzJ6NWxpZmJ4RkJmcjhYcGdjS3hIc3hXd25BZjd5?=
 =?utf-8?B?MXE4eWpnQmxTVktnNG5XUmdlYXUzZEpuNjdvdFJpNEFVcDgwRVh4RkZtMDJx?=
 =?utf-8?B?emt6UW9QUklUZmdKSENhRmgxTHpCZXdiSmc1K3I2eGEyUlhRNUY3dGZuM1c1?=
 =?utf-8?B?QnZVc2xNbW1Jbko4RVlXdThPd2krL1c1K2ExSWMrakJsRmFDYzIyS2xMV1Qv?=
 =?utf-8?B?NC9QRmVidCtWdlYyWlRISnZmMkh4UndLL1BZZ011blVtZ0pvRUxwTmZ5WWti?=
 =?utf-8?B?ZWc1ejFweWhoQW9jYTFjc1Q0czVCU21raXNCYjRMWkJ6T3hkaE1GQVNnM0Fi?=
 =?utf-8?B?ODZPL3prbXMrc2thU05VRWQ2YU1JUjhHY1lUeHYvOThGb2lPK0RMb1pGQzJX?=
 =?utf-8?B?SUJGTyt2ekhnRlI0L3RnQ3hCSmc1V0lTZkhYMFhYdkdZTm50VmVXb2ZZTWtv?=
 =?utf-8?B?MUlNVktXSEl1dHRIYzlBYzIwb2wwODhzUmNKbmRkZkQ0ZHZBNGttRSszQTVS?=
 =?utf-8?B?dkcrdkVocVZsdTJnZFpQc3NDVis5dzkydWhKemRUQThTcjJNTnNVVzJ3NUpJ?=
 =?utf-8?B?dXRmT3d3YmV3a09sZFpPUHByMERVbERsOGdjS1hRdnlUdVpNT3VxNFRHOHhv?=
 =?utf-8?B?ZzNBS2ZUNlNJTGxQLy9zYTRMK010RFJuWGlBUGhjRFJ1eXhRRGE1TVJ5bHBY?=
 =?utf-8?B?Z3lwcTV2LzM3ai9WSmx1NkJFb1AwVXZqeXVESVZ1UlhjN0tBMit0aWNaOXBH?=
 =?utf-8?B?cTdjR1ZjZzFBc0IwekFMcDY4SkhrTS9uQ3IvSkZnSWNGL2pqQzNadGVrdERn?=
 =?utf-8?B?RXdaT0hNbW9HZnMvWmNJaytHdzd2UDN5N3Z3UG9Ebm95UUlLTlJsbXN0WG4v?=
 =?utf-8?B?VytSUDF2MjV6Wnpza28xV1NYVzhFTnVOZHR0eUV2Y3ZLeGs5RVgrZGxQeDFM?=
 =?utf-8?B?N3dOLytGWTAwUi92VUU4ZVI2dis0bWlKSDlUUWFVa3FYUElCMTI2d2l0ZUdv?=
 =?utf-8?B?L3ZHQXJaVG1hYXY1ZVBpdDdPUll1YWxyT0pVdWR0bUJMWjRHdzNhU3lDOXRW?=
 =?utf-8?B?ZUZhbU5SZkNvcElObDZScFRIQ1lCYlNralhKZFFEdUNqK213WmF4STEza01M?=
 =?utf-8?B?Z29Gc2NpWGlVbSs4eXAyUFFDcndzdTZMclVwOHAxYTNTYXZ1OWl5MjBHeUV3?=
 =?utf-8?Q?k5aY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:16:36.9190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b785fe91-3326-4197-2c3c-08de124f8a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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

If the GPU fails to suspend the return code is passed up to the caller
but it's left in an inconsistent state.  This could lead to hangs
if userspace tries to access it.

The last stage of all pmpops calls (success or fail) is the complete()
callback.  If by the time the PM core reaches this state the GPU is still
in suspend something went really wrong, so reset it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a36e15beafeb..e2d598dd462d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2590,6 +2590,17 @@ static int amdgpu_pmops_prepare(struct device *dev)
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	/* sequence failed, use a big 🔨 try to cleanup */
+	if (adev->in_suspend) {
+		adev->in_suspend = adev->in_s0ix = adev->in_s3 = false;
+		dev_crit(adev->dev, "pmpops sequence failed, resetting\n");
+		amdgpu_asic_reset(adev);
+		return;
+	}
+
 	amdgpu_device_complete(dev_get_drvdata(dev));
 }
 
-- 
2.51.1

