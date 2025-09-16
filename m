Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A50CCAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 13:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF3110E7DA;
	Tue, 16 Sep 2025 13:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wKXT/226";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA3710E7DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 13:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oET0cGTqr1FLepM4MGiiQmau46KwJ7y/y1PZo/8qwhNbxzhUQ/j2gX1pl166HJEtDloFoRxbUXmkXEJ7OxLlXHldr3vrUUqNlktG+jxviIKVMLKqoKjLwKJubWO1NQ03nISD3iFhoF8L56nV2NpmcSa+S6ddcvINt1wFzQBYS7SKbe7cDpWXGx3w6FtEWN4dkfOmAXlEindRReTmBHYj8xa3t8I2wsfoeOavAaiizjQHHFMUd67ty3uWAoXS62IXKGlwlJ7MlfjLlP/U3XwgwZtcgXz+/xTYrCH1dS3lOjxYlJOGVFqOtiYArXl4K7YAhLSjkU7jVuH1BbTrru1O2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC1EhwCDJEPz7/TmSps0gPB6mNHPD3wmTQk60sNJOFI=;
 b=jKK1lUx0dd2pmNczUqpla1qPZQqvsp12KrM015MDIV1jCF96j/aqMYPvYOWZEOnbaKausT76ulw6MNTIRex9Pzo5xoaDy2L88TTCk/PwouVd4LHxbwW04jyaW1te4th7VM42JB/v9d8QdjMa3zvQyTwffzpYL/tYX9GXFuS8bQdD+ohB5qkKIvZcnrlGLuJI9EWfZlng2K5SUFBfNGhLS/vaSdlEg0QrhZFAvfYseWLAb8IzoaQN5NE22pObw8B7XktCsNU/7ot1sp0GRdTr4182gSj1LBQyy22evxqnRpZx1BpaZqYAQkkxa4wnwZP99QTxp/MsJuBLcywRWB5AEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC1EhwCDJEPz7/TmSps0gPB6mNHPD3wmTQk60sNJOFI=;
 b=wKXT/22672f2sEkOiKHvUMGVEkgM3ZuJQavPQpCNUXB0jNJQK70Vq8R/UusgrHu19cFd5YjOepTtGlupABDZfMGX/bGn/h5Jm/98tSdUVf9nkR+HlGX/rkrumPxL4BswsvTDBkUx4H8l5gVkZgjokofXD/wMOC90A4J/NFVGfZk=
Received: from MN2PR20CA0063.namprd20.prod.outlook.com (2603:10b6:208:235::32)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 13:22:24 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::82) by MN2PR20CA0063.outlook.office365.com
 (2603:10b6:208:235::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 13:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 13:22:23 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 06:22:22 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amd: Run KFD/userq suspend and resume routines for s0ix
Date: Tue, 16 Sep 2025 08:22:11 -0500
Message-ID: <20250916132211.93617-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a735021-6822-47c6-f979-08ddf5241257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OPdC3W9XkqPV0Jw67PwbsOL8cToDn5LJfAiRV5wFVhZ+EdsokTU2cxdr9Lcv?=
 =?us-ascii?Q?MPTOkyd/dV339BkCpNWadA8ulMS81oSjnvxXm3u1ZuKx9m15m+3Cb9OjCjTJ?=
 =?us-ascii?Q?4FF7IirIlyuT5mz1MkZ57IJIEmvGSkhY1CV1CcWeBvl3jXNP8gBlBvfGEj5j?=
 =?us-ascii?Q?kTVBCCw5m7BWUBibke1Y+ISy0nFJsQFpw1D5k4S2WzXmOE/TG/YF8I1l/Mzt?=
 =?us-ascii?Q?q9+sMrNwVrqdR23D1cfpH0+acJPAivbod8eXf5hbecroJW/vr5fwf+18jREX?=
 =?us-ascii?Q?WFI30s9JJqfE3hYoLPmHVmXJAMUlU1ye9V8zUdbXO3kELO4vmeIHuqhS25AE?=
 =?us-ascii?Q?Rx7Vce2L8s5Hor5EgdjwWDmDCr86Vop/UNQZQ8XBJRb+39ZgjOu/K0MUQ6oj?=
 =?us-ascii?Q?HvaJZvmC91vMIrD4qfjEGhdEzp6hQ9xBrw8wa7Yirln+8b0X6a1MwXmV+aIQ?=
 =?us-ascii?Q?J5e4BZ09OXWoSaODeFDiEEhiVOYfZTeyVMtqfngPLj8lLeZPg1h9RCJjI2Sq?=
 =?us-ascii?Q?hvnyt1ZVdDjREt9g7l+FXHdzUWj73So3lawcUHXoSma5UhUPyiyRCz3UTrWI?=
 =?us-ascii?Q?BNlIn82EyC0k3VISL1nHfTx8Dqq+XC4I/tPdKLvtyKu3LQkRlttZ1kSL/WSS?=
 =?us-ascii?Q?TV1062yy7ceXBv8h+GxBLl9hK9Wca4oUJ2Q0w2GwD2mIAXKpzwqn1vLzsTCM?=
 =?us-ascii?Q?oE19zS3XcWxsyVC5d+HBi2iKyszeRIOjPlK8ZhURrHb5Z/vcF4pTLnZhQiHq?=
 =?us-ascii?Q?L+ZyQTqGaY1yb8q2vl0qmoWK8AnDAdsadgWVweq/MmgRMN034XK34uBTMgPf?=
 =?us-ascii?Q?vdjvxBD9R1AeKccgonsbDrGDGkKkyCMSnedeMySGzXwf06xpnwHn/7lad9De?=
 =?us-ascii?Q?o0rfBeCDXGM/5mX2pgtfGJO+pJQzlKaxpIsT7EP/Mm/W1ZwzJoZz+PlcOaPg?=
 =?us-ascii?Q?b5lr73Tur3tAoBjIGCmOaeIEolMWP93YjiL8DJMqaJPH4ITgFOPYVI8ft/35?=
 =?us-ascii?Q?t8Qx8YebZWg2uTt68Gj7XH6RUaimQKAJobU9AmcB7/++QK0GWlUSq6Cb0DAb?=
 =?us-ascii?Q?y8ZOUsakEhBtPnsqknORQipFpA88lziPN17mdl/5jU3W1SdVyu2KR0+Nmyyx?=
 =?us-ascii?Q?1dDzJkGqOZsYblyZwYYQDg8dxpiUkJbgUDBQH+Tb65vE65b9SWMOaz3rmxM8?=
 =?us-ascii?Q?Z5dorwspHC/gPypjaJyKPO1BaCldL46I9zysBIQgl0FbKkGY16GBfauG4BCZ?=
 =?us-ascii?Q?Hd0UFGmTx/UzsJMUAfHRuqVFItA7egNoXX06nuW/0TKwS2gQTukhteFv5Avq?=
 =?us-ascii?Q?SCl6YU7wizV1sz3r/MYcjh/oED6SrvEKuZ94xAVHOyIvAqZy0E7DIbpxkRvg?=
 =?us-ascii?Q?cAKiIrtVZMgru3969xMWRq0oimkxkUx8aGMG2xcsb67i5S1jGd0rg7vO1+HA?=
 =?us-ascii?Q?LxMUUTNUySUfEGemAMGSgDSKVEUsgjx54SpvwEdBy9Bft/7cBUHX/9y3LtfQ?=
 =?us-ascii?Q?JEIP4mVmHeb++SY8dBEMn5RutIK2vmikRTtX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 13:22:23.1430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a735021-6822-47c6-f979-08ddf5241257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

KFD suspend and resume routines have been disabled since commit
5d3a2d95224da ("drm/amdgpu: skip kfd suspend/resume for S0ix") which
made sense at that time.  However there is a problem that if there is
any compute work running there may still be active fences.  Running
suspend without draining them can cause the system to hang.

The same problem can also occur with user queues too.

So run KFD and user queue suspend/resume routines even in s0ix.

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * handle user queues as well (Alex)
 * Add tag (Yifan)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0fdfde3dcb9f..85b58e5edc7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5220,10 +5220,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix) {
-		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
-		amdgpu_userq_suspend(adev);
-	}
+	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	amdgpu_userq_suspend(adev);
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -5318,15 +5316,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		goto exit;
 	}
 
-	if (!adev->in_s0ix) {
-		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
-		if (r)
-			goto exit;
+	r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	if (r)
+		goto exit;
 
-		r = amdgpu_userq_resume(adev);
-		if (r)
-			goto exit;
-	}
+	r = amdgpu_userq_resume(adev);
+	if (r)
+		goto exit;
 
 	r = amdgpu_device_ip_late_init(adev);
 	if (r)
-- 
2.50.1

