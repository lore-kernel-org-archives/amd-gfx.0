Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B47FCF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D4510E697;
	Wed,  2 Oct 2024 04:41:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XDZQSR+T";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37BBB10E697
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFzYc1dY2txNlo7GbNx3YURhvF3v+Q6HokjWDQ8k2tzi3QsGplDD0d2yJyYCn4ebKnjFjd3ivrkUbJR1mOohwstafb9/bw5n1QFftsgm33+4SnTPnEcSHjIU3lSu+YgZ/KGb1Mr7VWDRxL0GmxfF0VqDKSfUuKY4loklVVCvK6BJrh2zaUVXzNb/R5k8CEn/YcuzPJW8ivNuNjS1ade/kYbI28fL4S9pP7wtezJDAowFlyy7ILbJlEPb5GBrQdLOVBl0PsvkjusdufJjjh25iNH54/gLFUP3TESsEvFv4Ox+GoBG70nggwsVrNip0Fx+4uhkBa9oIHg0iUtka5vNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXdwVNt8e7/Tdix/8vRDdx6eUfH2NfoqP6D1Pa7tI5o=;
 b=q0/rJdiYCL8leNAomglL6fQzoKdbwtC6Y7uSsp1PcWksvBXBlJcex4XGczdd7e0reBox1m//MH9qNXrnAo8ZTEgoXA8BniM2whJSlc+JPxv9MvLAqtAm1uGCaRBPT4NwfLaYYRJmByzvUvU/q2st8C4/MiU55TbKnmrE4pwClueyqAOiukGY809cYBKWd1ZJ563a0dAThJfJFeG7/fUzCEnbZX944AX99sR7NlsTOS6TluhD1No/TCT0IA2Y1ekyWemimCAdkwaBhX7EMupDU7FnO/0RbskvwQZR4PAek7XqKa7pNoSi0+j4wPvAdq8+Q9uJBLJnI0XBnUAhU1ImMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXdwVNt8e7/Tdix/8vRDdx6eUfH2NfoqP6D1Pa7tI5o=;
 b=XDZQSR+TNFN+kw426orW8tLXbno+0CUJhBU8a2YhB0uqM01cVZgZsjX6SYYvdezF3CYfiBg+5RHx3b7GCsH0ALUMw2TuqUVo/4D7OgYlOD7RlJo4gowsl79cHdKoOFbef9jjKHNpw0EIZsxcanDysWZai//DXqenuNUNC6qs/2k=
Received: from SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 04:41:05 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::c0) by SA0PR11CA0040.outlook.office365.com
 (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 04:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:41:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 23:41:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/gfx11: Apply Isolation Enforcement to GFX &
 Compute rings
Date: Wed, 2 Oct 2024 10:09:34 +0530
Message-ID: <20241002043936.2960921-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc0f97e-2dc8-4174-63ed-08dce29c6cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODd1cFdnbnV0V2Z5TVUrcVYzRVR5QlJONUhJVFlrM3pzRlJVMHhUeUs4c2sr?=
 =?utf-8?B?ZlloWFZGVGF4Z2tNa3JqcVoyd213eE5nT0hEZVl5bFVzQnlaVWgrc3JJeUtE?=
 =?utf-8?B?enhiYTV5ck9GeEdOc2J0bk5WT2xMbWpsazNxRitYNEVxSzZsa1ZrREtOSkNY?=
 =?utf-8?B?VXBCd2sya0MwQWFMSlB1dnVEQXQ1TXV5NDBtWm96dmZ1Yjd4UE9NRERVRzVJ?=
 =?utf-8?B?WUdIa00zT1pFdnlSYjREaXNNWktLUVJ3MGNNSG5uVWV3Y3lvcEVhQVJjR1dh?=
 =?utf-8?B?eEFOZUVadHVqc0VDNHVKVEFsR2ZDK1VGaDBsOU9sSzEzanRGTjNTQ3k4a1Rx?=
 =?utf-8?B?TjdOUkxoWGxLNk0ya21aVVE5bXdzMVZ1TXBJZyswbjFQajdLMk4rUVpXL2Z4?=
 =?utf-8?B?QWlzeGtTb3pKa3NVdnBtRm9QQTNURk0wSzlLVkVzbit4VFZrS3dVbmRpTXhk?=
 =?utf-8?B?Q0xCU25OMjZJejRRQnUzZ1BuOFg0MXZqRWo1c1hLOVhYcHhWYzF1bFFzckhw?=
 =?utf-8?B?aTRyZHhJT1l5TllnTTM1Y3Z5VUJxS0MyZXlMa0FnZXZaT2FQQWdtNzVoV2h3?=
 =?utf-8?B?NWZ6TWx5cFVSUFhPYzc2UVkzSWRKYmR6LzE1OGZNaE5aNzN1UjZpRkxKZG1v?=
 =?utf-8?B?TWVramF5RGs5Q1VRU3N6R2wreTlpRE5mc3dIZ0cwN2Y2cHNjbVFjcjZ1VVBk?=
 =?utf-8?B?YXQwdnA5Qk1vRHNXMHBZS2d3Zm1hazVSSXYvdVZoVVFrNkwwK01QWnVSMjU4?=
 =?utf-8?B?SGtrVW1oa3VMcWRIMTVMaEZVTjlSZjllazMxaDNGTFZvd0oyV1N3YkNKVEJV?=
 =?utf-8?B?ZEZqZXF6MFFuYW9WM1pac2hCWHd6b1Vzd3ZmL3VLKzl1MjliK0FtOUVycGc5?=
 =?utf-8?B?S1IxSSs1Z2EreUUrTXZjZGQzYURvUzJkM0JrRWlGdTE0VUVJd0I3aW9TNHFw?=
 =?utf-8?B?SGs2aXdPN2pYa2dQVjhRL1hRWjVEWlhLYmlHRXRuY2NxUVVuTTIwU3l5Rnky?=
 =?utf-8?B?N2Y2Q3hWZFpSUnc4enB1R1lpUURHR1pSbVhOTjlkTlQwbC80Q0tXR1YxSU5N?=
 =?utf-8?B?bTM1UW5lNlJGcWY5WmhIRitlTS9naVNtaW1CNS9oZ2UwYSthWXVJdlZodEty?=
 =?utf-8?B?czU4TVhMOXgzekJONWtRV2tXMFdldlZzc0VHME1DYVR6bWVadm03VFczUDVh?=
 =?utf-8?B?OERETm9DMFE0cFhVcG9tRFZ6NEdPY1FKZHhnMUFHU1ZCeEZaQkJneEhSVVcv?=
 =?utf-8?B?Tm56aUd1LzJiam11Q0syTEpBRldFWDFJeW1jTzNKaWVickFwQW5IclNjZm5I?=
 =?utf-8?B?d1BVeUoxSnNjenVXVitvbTU5Vlk0YXp5YUNVeTlUNm9sOUVXY1dVWFQ3c3Zk?=
 =?utf-8?B?M1p5bHVwZEJuQTBOcGVXUHdOZDFZQW9yYUorMnh1cUNZNDZRcUVyTi8rY2NC?=
 =?utf-8?B?TnlUNG1QSDhmWTFaQnM1MUhBbVRpVThUTU5kbklYYjNONlFzNitFY00vZnZF?=
 =?utf-8?B?cCtOU2ZNQW9ZYkVNNGhUZTQ5SUlQMDNmSEpnTjk1Ni9OK29TK1BzeTd1UTBy?=
 =?utf-8?B?dGM2cGh4dGd6Ym9LenB0Qk5aNmFnSlRUWThnSnhtbFFRaUZNODhGeU05OHp6?=
 =?utf-8?B?ZzR0L1pMTWpXYzRGVWZITk1aN2RyZnlSMmh4UFZXYmYwTFRNN3pWSUJuT01x?=
 =?utf-8?B?STZTTWhCQU9Kd2NYTlFIdG1qY092QUZJeXh5dXlhNTRJd2pUY2dobE53NHhW?=
 =?utf-8?B?b1pYNFpiUUlpdkFSc0hmOGszZ3FhaC82dDVHb2k5ZUxNbm1hYzJlQ1VOZTNF?=
 =?utf-8?B?OUxnTGZsblJaZ0Vad3RLNFRJMEdQdENmYVlKcGQzMG1haVBjamdvVWhrTGJi?=
 =?utf-8?B?SjNQcW9GUEhvckRKSlJSSlZSYjh1Mi9RcDg5UTJUcWpiMXVzWDlUdVBPK1RG?=
 =?utf-8?Q?AKbeAyRe5SwzlBMk9JfE+CrbiwOY/Z6T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:41:05.0111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc0f97e-2dc8-4174-63ed-08dce29c6cfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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

This commit applies isolation enforcement to the GFX and Compute rings
in the gfx_v11_0 module.

The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
`amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
called when a ring begins and ends its use, respectively.

`amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
begins its use. This function cancels any scheduled
`enforce_isolation_work` and, if necessary, signals the Kernel Fusion
Driver (KFD) to stop the runqueue.

`amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
its use. This function schedules `enforce_isolation_work` to be run
after a delay.

These functions are part of the Enforce Isolation Handler, which
enforces shader isolation on AMD GPUs to prevent data leakage between
different processes.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 745996ed2380..f938919cb098 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6874,6 +6874,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
@@ -6914,6 +6916,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
-- 
2.34.1

