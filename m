Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A88C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 07:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB0D10F109;
	Thu,  6 Aug 2026 07:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OjrAn39s";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B389610F109
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 07:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbtSi/XQuXzKb15tj56rzPvF7zqoQ5y38TCyNFdl6WZsXSpiNuiNB5pmLoQjewAu82LtI6FPoefHv0y/OCYTvuUdX9aju6PmBUHc/7393nqrKwN71mVf01Wgdq+U3h429wAIde+3OcDgxlwWxCHMF/H7YirvLYxtJVHEemexXJ6pLid1NRX1j3EMTeKBx5StuWX3rcZ3t5ApkHK6sLuAtXLqZ7Xk8+IQEqZEVnVJWASRaNdW650ORZWm+F4dec4oO3mRyVcI/9lyoZ9GgIetkAkzCuTKuH0XcWEL9tpxSSoea/HkXzfK7SGr3kdUGcBhmEfN7D0BPSA0G3qvgvpKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGFboKzvX5XKM0v82O9bVTgiBaAIaKoJgAQQnABKXxA=;
 b=n99RUmbEhckOtSn5rYwTCBHRKsMkrO+J83wP+t1bS9Zs2A3kTNXl7S0Ngr2TwdusXFFjw5w1VFkZ2sdojxLmssk22yfxHl+Q+KtsKTqadCdFFPTavVpag8AiphYpGVUOO2PVMI2lXo8cYUIizTFDMhAU4UlmjP2oqDQWMtPmrsHFgg03SOorkX/6QpZjP2KUyEfUMPAFS+8CtbC4Ge1DA96edp5k7XljB0RkJBy89ppMgUPg85beUsL7ZixzhdoBrfFTA0MDUwmLG9EUbZMcem6hWwGTa+TIIhsDwrc/O9SVsqGJkdqbI+LpTMw92DrxGOc1LSpvbRvzQH9+ommftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGFboKzvX5XKM0v82O9bVTgiBaAIaKoJgAQQnABKXxA=;
 b=OjrAn39sKn9Ot/4OiKsSFJ1MsQ1X5KYAs3DMpSoa43irBvIa+QLvJYSri1tQphIKbKwzUG0yof/mioTz1dUFwFNmgTSLeXpvN3dwgusXwk4W0jOhk6xyHhB74/pn3cD3B9IHwEWkhogjr6gn/SqnJibT0X3X2V423fdxyIeasZI=
Received: from SJ0PR05CA0129.namprd05.prod.outlook.com (2603:10b6:a03:33d::14)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 07:56:57 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::4e) by SJ0PR05CA0129.outlook.office365.com
 (2603:10b6:a03:33d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.8 via Frontend Transport; Thu, 6
 Aug 2026 07:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 07:56:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 02:56:56 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 02:56:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: force complete the MES scheduler ring fence on
 reset
Date: Thu, 6 Aug 2026 15:56:47 +0800
Message-ID: <20260806075653.711275-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DS5PPF7671D5CC0:EE_
X-MS-Office365-Filtering-Correlation-Id: ce956606-bb57-4352-1b71-08def39049a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: fGh0M1kW2JcIG6Tu9CWmovecJXkRsOnPyCIisUrswVEK977Ojf+6ilo8IsRz+Yc+hqMfzk/H2+Lu7L2bN2c7/8t6vPHr/f+BVvKdWrVyiVuxD6OwMzm7g/Je58lWlb7DKfh9Qyey7R3ldH1tViB/zyfqz5CepHb9ism4/lGqBQ6oZPlJmhMBvEpiiOeT8HQDKuHXciWaPQ3bo23/n2D77j6+v0XIEcEivW+Tbfi/erW9uBJO9Ewdg8HEBXS9HQbPaQo8S1RDbSorROZY6YPIo0l76Z4aqu1Ti/I7POJEQOgbVPPpdzx/VlYDZMMn/dokZFQT5uzqOhhiBYfA5DPVDsjkFiDvyNlwJGcjcM8UVlOPRog5L4EJh5P5oKFpXNA6CYtint+AK6F3m09bOiaK1cGUieP/XPL+7dzclMWbOcv2rHh8mFk8Olib4kZCNSLKOJu20ctezKnAwZJanBxeCjhlXvrWd5X3Y7G3Q+9zWWA8XB9GYuW7twInHMa45qFeJ7/OMMERUPPOcbwaeSbuijQloZMgnF0t547haMRMduZGkehdFf4zGQPpQvD5Onz8CBU/baPwc3ZzF5dyI5geio34FHVn+brcL6+NlIvRrTR6Bgq+m3zRG/V0ZS0pIMCAfZxEIfvbiPMWcrKxRPFehtNhvI5FzomYz/vz91G0EAHDC1fcoGs8GiBI7vp7V73TDTWd1jmJYppcCefEhFL+8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LiRbihK8mXHIxy7Wabb6xyNI5I3BgsuFOtiteCduZkJYP1oJjnRrL7NVopCB8ITa78KuVODtvbpbwIBITlj+2UntxOm79FOMz3c5lBCuvH7XuU693aqdZV/yjmq1JOyVvi/rH71DkfQPQCa5h0KX6mBKv7wnrVbedT1BeBLQfwWhvM9h0+hGcA9mSOn9TkeTlnHZhVyiY7ZcUL7svmtQUWvTsQy7Q5UzMQpnGSYCi29StCDQO5iGqcHcWgobMDhMok/uIztQvpNy/v+VJE0mvBGaXZLB9s+kO7G+IGjyWYKWIGzmYComTMibIaoH/NDXa57aDhs6Ju+kjk1X2lQpbjyEl4fV2k57xa+jI3Az8Kp5C4/s1dDsb9jiO8V/qf4/1Vn8piNK/mdaXLOu5u3rmk1Wm4isW0EQFIF7y5vO0bYBe1xOzyiQ2HmaNLo3x175
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:56:56.8292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce956606-bb57-4352-1b71-08def39049a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7671D5CC0
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

The MES scheduler ring has no drm scheduler (no_scheduler = true), so it is
skipped by the force-completion loop in amdgpu_device_pre_asic_reset(). It
uses a polling fence whose hw value lives in wb (GTT) memory and survives a
MODE1 reset, while fence_drv.sync_seq keeps advancing for every packet.

When the reset is triggered because MES itself stopped responding, the
timed-out packets advance sync_seq past the last hw fence value MES wrote.
After resume the first MES submission polls forever on a seq that is never
written back, failing the resume and wedging the box on a second reset:

  amdgpu: MES ring buffer is full.
  amdgpu: *ERROR* ring gfx_0.0.0 test failed (-110)
  amdgpu: resume of IP block <gfx_v11_0> failed -110
  amdgpu: GPU reset end with ret = -110

Force complete the MES scheduler ring fence together with the scheduler
rings so its hw fence is realigned to sync_seq.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 638dfaf127fd..5ad13afa87c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4988,6 +4988,18 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		amdgpu_fence_driver_force_completion(ring, fence);
 	}
 
+	/*
+	 * The MES scheduler ring has no drm scheduler (no_scheduler), so it is
+	 * skipped by the loop above. It uses a polling fence whose hw value lives
+	 * in wb memory and survives the reset, while its sync_seq keeps advancing
+	 * for every (possibly timed-out) packet. Force it too, otherwise the first
+	 * post-reset submission polls forever on a seq that will never be written
+	 * back ("MES ring buffer is full") and the resume fails.
+	 */
+	if (adev->mes.ring[0].fence_drv.initialized &&
+	    adev->mes.ring[0].sched.ready)
+		amdgpu_fence_driver_force_completion(&adev->mes.ring[0], fence);
+
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
-- 
2.49.0

