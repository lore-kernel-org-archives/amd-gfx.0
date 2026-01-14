Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28060D38FEC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE40810E648;
	Wed, 14 Jan 2026 16:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o5yukvYX";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE30A10E644
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkVMaW6TrssP86z8lxkrpK2sTMLRR2KZ3Yj9XQ3FcB/bX0zu80CDWy4pKbL1NATz78ljS9+0Kx5Bd+fg0UuVWI1zh9caAqDkdWZAGNrBotTn0nKkqwnjLkYORLh1unxNZWiCV93a4CbbpmiQcJR39sPnnmZ7YdI9IScaXwEbkegR8D9VXTcU+i+Qym+1W+EZn9lYuOoIr/9SGxSVse4HyhurlghyNGqfbnO8CiSwIH3rmHt/7If9gJY2TSkvy9CuGp8lHLueCKXijlpwTVQ79ypIeJ6LGPWnL0ioaHw3JmW9IDsT5NU5wCulfUWLuiXIGQ16LrH+AYXt+6tTy2u8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSfOLOKSqaB7krA80CSIxsKM4ig82+yJjU9HvUyhkOs=;
 b=bFpGZBw+WvjGkdIwUypydY+KHyJsVhanjk+NVQi0tDKGcrvsRR/3q8rds0k4Xl8KFuOzZfTD8LdXly90jp6Zmxi8NyOv0BS1PzoMZSs6y9fZPay+lm/FdBDfvZnyZZ3ovFkrDQaLRDdQrU7Wg1AW8tJ7cSu/7UPLxHmP4uVc2oPpPCxC1CmVsHZfU8YbBN+V9GZyAHrXevrNx2b2y/U8OAtarIv8z+OnnniokDbdUnX4DIeJvAKFTs8RRBwV8lkUA/sXa6jAT21kVgoSFiTjQ+o/IkZYAUZVm3L2gcd5N2gcBcdqoH8XjnxApv3JTcgC8tbMS5Tdyjyxy33jRkKG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSfOLOKSqaB7krA80CSIxsKM4ig82+yJjU9HvUyhkOs=;
 b=o5yukvYXDJDxkueSda+Pcu6uYeNU1M7D6RrG/yoylUnBZykZYhXZIahgSx/C7MJX1qU1gUAq4EJfkKQ92M/bWFxMDoGk8on8ta4BrI0uG0DxgLUKezFRxAdxvbxGXoOadT6Er1YuIRMasl3sYZA8ehlz487Zd4GCts+jmH1tp8M=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 14 Jan
 2026 16:47:52 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a5) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:49 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:48 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/42] drm/amdgpu: don't call drm_sched_stop/start() in asic
 reset
Date: Wed, 14 Jan 2026 11:47:12 -0500
Message-ID: <20260114164727.15367-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: c45d7708-1b6e-4178-6ec2-08de538ca889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aVsccbUWFcJp6LT+qChZKtcoTgAG4ID5nD+JVR2uqY0rjAfSF2zeGlq8MgCk?=
 =?us-ascii?Q?7wDiZzYa1hoxVeXe6bma0aBL2ElVu6TBe4JUQxTwyCz9m5ThB5ndaSsH5clT?=
 =?us-ascii?Q?sQt6r2qK1VTzG9eMIuPsmyiX7EhhPHf/RBrhpLFJxVbC/DY87dyM9XP1z+81?=
 =?us-ascii?Q?7nC2chp+kN1DLyXS0MwNwy/2YQ9fn4wEH46XvucfmHECQlFgVy7ZTaBoqB+3?=
 =?us-ascii?Q?KnV91/8zb8z17HYz7PqA2wj7S0Q393l1/mUN8m/ZrCCw+I/8R4mozGI3pPFi?=
 =?us-ascii?Q?RiK9ozxWtcFwLWg96jzqsbdwpzU8FttmIEQxq/wITsp3i2OUveQghiLR2AeV?=
 =?us-ascii?Q?NlA8Cpz1GGmenClRlsW23Tv71GYz+g45+YpmA3Usu9/hv0h0bRAHfLwnq03e?=
 =?us-ascii?Q?iX+nslj7xApFvHTe4LBzpfO126RUqrx0mJYflEIJS0a4dlY9cs3WNzgZ6xus?=
 =?us-ascii?Q?zz9Iw10aY4NInNDxS35u7GmnT1WPUyyvLBcPUBRx7S6MOs2fjlmU5+A1INOs?=
 =?us-ascii?Q?ueQA5E/qW5kOyE8ubYmIheOGv6u979ta/Q5lmcXZ27gzTPHfUDS8U+tjmZnJ?=
 =?us-ascii?Q?7tNsbE26QmgR+ng6aaC5tsQ+/PPxFXfwM0Um9dzQyoCbcRay1kUj1g/ZasQA?=
 =?us-ascii?Q?ns8zHWaBSXA/IefR/OuukpCsZuZGAnG492xfUpD4vkG97IK4tv5tMF5GcWTX?=
 =?us-ascii?Q?mfm/sZMDxkqctX6XmvvgkYEfqqgc/jSKwjyBn4eDcvC7L7u6WwK6IIgvwXsh?=
 =?us-ascii?Q?vnorh0paDaiWQNricDGn9qOFbDv5F4KZRPI9VGYHKgSHI9JmUR8lkN7zpvPI?=
 =?us-ascii?Q?7DrNjJDo/yFpWy4rxogK+/sRT0oLhSCrII1RKsoYtXJIMcyH8gAceW2Fpeli?=
 =?us-ascii?Q?Eo6pnrGWWUxBMYGvrXzVQDMB3trKXK9vQ6aZ5RKXgSl94WRKEA5aYXUgmREX?=
 =?us-ascii?Q?EUsq9cuYEquQoQ314V46voY5u/SRRdmnsfBSDKtEurVRJuIyyDZ1M2q5lV+x?=
 =?us-ascii?Q?QXdYtDWTtnXpUvErJNeywTtVRfIH1VAYK0+uIwHwQR2gSIFzHgAd0Ws33Qvw?=
 =?us-ascii?Q?MAb5/z2Whc9hdmtqOkf/gmp/bH27UvHxvhQllS1rbbNzmAhe3dRiYYgf1QYh?=
 =?us-ascii?Q?/5sUAOBEa+wG5LAIfyOX5Kxb0+0uwhHX60hYF0WjUTIzcUA6PECysgSEtfmK?=
 =?us-ascii?Q?t7pRG1KLGQ6SGYNs37MQryLrm3sPI1Mw/Dj0OLYGMkhVggnCogUlwqekQVMJ?=
 =?us-ascii?Q?EFoFw+29FYojpbs8hcvikLmln5JFtFN5GLZLJ1o0gBFcVaFIOV+0r8HwHW5k?=
 =?us-ascii?Q?PCPJDH24c5EextgAlYxKuYkW6v15+pGOfPaBrP/7QonZDjIAYW7P59LGsk/p?=
 =?us-ascii?Q?3CIZtpfcykCvPxDuOEKTsZNBtV9ev1buike97w5/NnITX1sK5rt4FcBCBSZZ?=
 =?us-ascii?Q?cr9Gthvgt8qFrEqzTjBbv84NQwK9Jiq156g3Lcc9ITmVABTiSKKCfpG+fWHJ?=
 =?us-ascii?Q?CEwHg0SvBIxGcTdrLFDZjh8Nyu3ZePYX7BnI29/ZkYha5Svul0NlXlI1Imqa?=
 =?us-ascii?Q?Xkwwr5deWc0txL+RHmADkTMDqeCX291I+YOB/aRG3sh46GudOO1DWKvFrjCF?=
 =?us-ascii?Q?t0Iu4vy46FlLeCL4KwKR0Vdrvld0nQDt2z+llqDH07soj6qEk/1JZKhzMJlK?=
 =?us-ascii?Q?2Z4QQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:51.9964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45d7708-1b6e-4178-6ec2-08de538ca889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

We only want to stop the work queues, not mess with the
pending list so just stop the work queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c89077af45cfa..673f65d54accd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6309,7 +6309,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
+			drm_sched_wqueue_stop(&ring->sched);
 
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
@@ -6393,7 +6393,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_start(&ring->sched, 0);
+			drm_sched_wqueue_start(&ring->sched);
 		}
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
-- 
2.52.0

