Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2519D25924
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 03:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D6A10E044;
	Tue, 27 Jan 2026 03:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GWs8XZmp";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D152C10E044
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 03:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqsmYYeeaVQjmHpFGnGclhCuU/DftSOMU1xDB7SGtsFD7aAGrlAHbPp3w15Vx+r1b1VfB1WEKEJKONiSF21Y9ZqhtVvKePI1yP/LD5gHWI9sqyiTJQYmjjFAaWOC+/HfLVXucGyFFTOMVRa709q+GxRz8snZAVkdfjRuzRrKU1nITAfFZNrXzSIz6XY+09o2ndAUuBboKNGYQTI8+euQGoBVG4zjpa1ZKkRA9jGFkDnJkivXYKfMTgx9hx4Jdt/8YhW4tIeWossJkA4B9CLxnlWWv5nm7y7xZld2VncfiF+kSSTH1F4lhQcKJhZsu7Ja8UPtCrFjhZQR2xscxnffiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqEeIrAN/gqTt9PTpMiDjLAuHkoheliUq5QI272Y1aQ=;
 b=GkC3aPe3qPnKZ+rAJacjdriE7Gk5+nJLmnGLr4BATGeBNZLebV3YejvStNT5o2SlazLbIExxjqDn/AW3J+FDlXH8+H9e4GH4RstlzwKgpqLTS9SXaGODK8bRoS47hrPC8W+iadF6u0FUtqCdzqHd4e1/6/jvepsJJlSTaIXuKcYq4zu2H6liVw61Bxpb5Zp2DjlK6yYmglx1CXKzfrE9F9aUIZ4/vKhmp0Tznj64K+g3Qxr99sld10H6pRZ26+6kyugHBQ0Z569ZwmxdFySs7y+dDYEl3RGaoVEfcFn3yWgmJkJbJMdzcpPmkBYTlsNqp+iWl6CqE/D7QctCoWaPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqEeIrAN/gqTt9PTpMiDjLAuHkoheliUq5QI272Y1aQ=;
 b=GWs8XZmpAY4NmsOUXbE74qXzXwdFjErDAKsWiPehk+NJYfjLedAhwrVqq5pROdxAdwvKscih0VKCOiZRthtxb8SUJEUiv6vplWpteOnwZjI0PMrsI5N/2oN0lJaRwibuyZ7pxqdo1C1u1QWHbjB3rELJUS6EtnNUTErKr8EhYdw=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 03:11:00 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::43) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 03:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:10:59 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 21:10:57 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix race in power state check before mutex lock
Date: Tue, 27 Jan 2026 11:10:47 +0800
Message-ID: <20260127031047.4068526-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 1411d702-4d81-4f0b-1b08-08de5d51b248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vod2iorvQXG94y0JJ+e8/9XdD0Bh7xYBYKHLEeQHHCQN03tcihiC1pk2mOIt?=
 =?us-ascii?Q?zCy/P1Y8ywncgPe9BrGPnKrvV5Sr1LWaIQpbPnpDDa9DOCl/mzzIoClw3lTE?=
 =?us-ascii?Q?qvlHkYvT/Fz+V+NaKLPSSOPuo0GSFiVETveS/obIL03W285kU9HnX0i0giUc?=
 =?us-ascii?Q?LwwBUczldjPyTIkOBan5eAsXVGEOU++xYCm0JIKmyHv7dIz1EuBIJ54NFBYH?=
 =?us-ascii?Q?p0OYR/mQfwzqY+Z2thNORZWs94LhNQtsIvPGLMlEWfYTAnLMvP61PuDhibP9?=
 =?us-ascii?Q?ia7Wxb9Y6+WB34Un1Y3C7ZmgfYQPBLTDBzbb0aSVZOBpJqC5qyg9eI5MjJkV?=
 =?us-ascii?Q?RycScFR5DSdYxuWJeKx+I7t2maoPNg4OXh35w+ecsMRRtKzLxJe49Smz/LnO?=
 =?us-ascii?Q?TA+K5e5dyBQCkrrtmb7Qma8KUuEXzv5FSKItGxrAhIyyVLvAgkwY5ujVW7k/?=
 =?us-ascii?Q?VAzxdg3GXZy/82Gh30tgYqftoGYCPC5f6l1otFdm8C6S+ZbvVv7P7qYn3Pyc?=
 =?us-ascii?Q?CJo/yE+jslS+i1aK4NcedcJvCOOzw1t0q9cw0J8QSZE0YuNOMBVbkqLuxGrU?=
 =?us-ascii?Q?qjhtKvBjJzJJqvlK/iWjJTDUYhClcAHwNnFzN4Sh3bAeDa4oitv6PEJpCfKw?=
 =?us-ascii?Q?qDasmUkHb6iqfTRI4pFgLj6TbFJUgxA4u3PhP6WagE2sXLneJfToyy0Uwnm0?=
 =?us-ascii?Q?eGwx1FV3va+kxi/2HJ1wbiHfIXQ+K2SjyDU3/3C7Yf+4t816iOIyGb1d1u+9?=
 =?us-ascii?Q?m/gS/nUzMOZ9p5cVcnZENvXDzdMV/Ru3aKHJurqP9QiJBYqVtiUDJPrzqOOy?=
 =?us-ascii?Q?GCUXcP21gNHwHIRBhoEGLg6Fcvrj42JgZmodxg0hM7PQiGgxDvDPn6hf8f+G?=
 =?us-ascii?Q?OzRPtA9zmd6N5PDF1k0nYxon8UTCG5Mf0RlYmhCdZXmkk3zqCTCVwqtEHHmf?=
 =?us-ascii?Q?bz3yPX0DvUSGKY5VQYbXSzb138pnnvnAJ0E98xLcK7CIkx+8l3S9IoeMQtna?=
 =?us-ascii?Q?PmaVFp0fanmyiNXfplFCZu0u53J+UZ2+goJqOu86BQQy4Tqm0ES1oEkCdib5?=
 =?us-ascii?Q?1C2qSseekmcbKa0vD1HmAHflACE3OLwWo48IMrOoA5Fg0G8gAhl4MVEqOC1Q?=
 =?us-ascii?Q?qobJqWDsJVXGOjjBxthD5r9x9OuyuIpLiWJ/BLcRLvGgfESoEnuCroww+wY6?=
 =?us-ascii?Q?b7kYuQIBhXa0HO39uUXdqYJryJp0Bq6papJoqcBY28BBqlz94R7rcGP4cvH0?=
 =?us-ascii?Q?qKFApi4v5horXaz7tlm5RqaaMhJnLppPN+Q26eB546IuT2pROS7RwcLrGPb9?=
 =?us-ascii?Q?2hEo0ICXsmYb5k/+kzmLSOpkRjG405Kk8hRMCd/0bGwJfFOtmOXGmqP3T9qs?=
 =?us-ascii?Q?JB5sgnz4PPsw4qdCly3MrjlQbAmmlhUwWXBxeQSs/dU+7AV7DrPdh1jWPHKc?=
 =?us-ascii?Q?YCveLZRsQZPM2emgLOhpLbYxDzzrs6YjlMRRIpZEc98p4DEMf1a1vFVJjsBM?=
 =?us-ascii?Q?r6DufSRXnAgDnJ8lHNviOX9qNyaxp1RgiRMmY6V812DPvNfUzUTTTGC3RwaO?=
 =?us-ascii?Q?LVK4MhIksHa2za53d45vI0uqAllPMyZKiAA3jXT6ziTMj/6BxCbRW+5LTqF1?=
 =?us-ascii?Q?pqi2vf5eEdYveZVpLT1Z3zAdjFjvhdZz57lWaYDws1hW/ENG+vwk8N0mWrUo?=
 =?us-ascii?Q?s3KhUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:10:59.7446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1411d702-4d81-4f0b-1b08-08de5d51b248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

The power state check in amdgpu_dpm_set_powergating_by_smu() is done
before acquiring the pm mutex, leading to a race condition where:
1. Thread A checks state and thinks no change is needed
2. Thread B acquires mutex and modifies the state
3. Thread A returns without updating state, causing inconsistency

Fix this by moving the mutex lock before the power state check,
ensuring atomicity of the state check and modification.

Fixes: 6ee27ee27ba8 ("drm/amd/pm: avoid duplicate powergate/ungate setting")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 4214f7314963..feadf604b474 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -80,15 +80,15 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
 	bool is_vcn = block_type == AMD_IP_BLOCK_TYPE_VCN;
 
+	mutex_lock(&adev->pm.mutex);
+
 	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
 			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
 		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
 				block_type, gate ? "gate" : "ungate");
-		return 0;
+		goto out_unlock;
 	}
 
-	mutex_lock(&adev->pm.mutex);
-
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
@@ -115,6 +115,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	if (!ret)
 		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
 
+out_unlock:
 	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
-- 
2.34.1

