Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D42C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 09:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D068710EF3E;
	Wed, 12 Aug 2026 09:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SLL7pZzU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE90C10EF31
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 09:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxnn9ENO5x8pGnyYsULEPDVRr3UXuETbqh3cCRks2rm/0fyOFd57r7LKhVT8/2SRLzHH860h6dQ1V0ziBrHJ1HlDHVMu1YmJl1gXjJmZgRo95Gm4tBjNTMmvPrWx74tXTFV+iuSU/LlHrBN3CL2cSC4N5C8bNjnLxtSapxjfnxsJYDfuswiLRo+1orLF6WreCBvX6eYT1pTQ03FvSM0WVH5SqI8UDgF7YmUCkTkbackubkrAFsGMYSsUCDykv0blX079xI4ABJ/QtFXBzd61xXHPoGN7pdPN4WRiT5b9TY+Fv9+Yiz5vMsrD2Ih86awYzpBv7NUHLWRWSV2zsYt86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWSQqyClzLX9p0KYHdmilCpMX44Om2QLyvedisSCIBs=;
 b=DTnFaOco+Hdv4eZHFsqaJGVkz8tDCsv4z8uvUPfPRP/rfeIfwgzfR7x5DFsyiIk0LGeaZidfADDymptOl7opA4MDjHQt2qtMOS/j8Pdl1foZhN7S+qV+OzSTMQWwQlm/NtbGkS8RMi6cGOf3BwgVjzoU7WPmRVveQVTs7aNQ4oiFBDtfq8O0t5VlCCjKN1JkxQDL7OIkd69v9PGnutIKscC8ppaSGJiVeBcZZZC+v+/4BpO+5KNAA/kVKd5L5pdo/aJ8YceQPD+wl1pHX3X+Fu9CbTZt/bMXE/VKtTWRK5bG5H+PMLX6TR+ZOlBdiwZuFPrXCcPqr+UZDdTr1PGdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWSQqyClzLX9p0KYHdmilCpMX44Om2QLyvedisSCIBs=;
 b=SLL7pZzU7xtD/nK4ROoWiNIF3lbFF6hQmXIdtu0viNaySvMZdDpKKK5AUQySKJFzH1xl93ze0jvbaIhRcArZJsyN+ueqj5Wb/EwL/s/37izkh2/W4J3qnH+LEZGZhxk+aWmXiymSZ6L19e/aAoI28KLdZQo8Gd2GuBcywLfw1kE=
Received: from MW3PR06CA0003.namprd06.prod.outlook.com (2603:10b6:303:2a::8)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::610) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Wed, 12 Aug
 2026 09:24:18 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::44) by MW3PR06CA0003.outlook.office365.com
 (2603:10b6:303:2a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 09:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 09:24:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 04:24:16 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 04:24:15 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: force complete the MES scheduler ring fences
 on reset
Date: Wed, 12 Aug 2026 17:24:03 +0800
Message-ID: <20260812092414.2513383-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9a5356-f059-403b-3c91-08def8537c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: XkG/SAhF/TSEyd5rYPZ0NBdylSIRue+MkMXLahAHKbzOlxgoReKH34B078TvBGGTIhpjCGcJB5qT9mQCOzmdMtk2NlY1YGYzl1H/jvmdYZVyzR2Ma9Hr7Zs0rFBDEWcN80zFYcSyhPrabmY+wWSP1uiyXm5ohTXdBHz5rXnvWDp9IBz4PYKG6MTRajNmZmwHQ9pnYDw0eScxW1kGiH9Bz0u6cj740BeavwqnU5F0nbcbEUfKIEYl/3sbVbb6zN4DkysAzVI3Ml9xKNUnFDLEWv4FTGgA/6nhv7/WNWsVGutBWpIVEhk32Q3hulNjDvu+m3veVdmU80go1belblB4BaFdKVwR/HjZE2GhyZ/Vyfnna3vVOKH2o8ILd1byn66uQD/6bgxlW8BFZJjm6beohnxwitpfQ77H/Lu00YML+uOTs+NcZVvZ0Q+BZQr44aQdiNtwxQ8i7GGm58NYRMdu78QLqct6mwE2w9rSiIll7zPpEPMAnw8oD1PuLXwaeYJQ/XNROhv8bpZwigy6prdzjYjvEhwBRqAFPc0PSEwjYaiEnJCKQ08FTc9CXjy4z18/oEotCFbbETyz7yOlZFbt7LfFGmH07hHheaYb47zup6yDQPOKZ40czf9EK31ADwfOl3YisrNDEDPm7r89fqP9TIx7Hk6I5PNHpyvH2A/89xE/Ox+B/aFcl2bHRg3mzpxJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7NVjFVEkui+64a4YMZA40Cfi94hSu6nYS3EzESM9TuNrkVoB+qF3vJDvmR26BpXiCo+K0S8uyo12braZqcxl6tQwkz9NKpeRY0cvmu5cPSm+i+n3ibSO1+HVKOg2nIdlwvyuMXWycoYTAwHYBbSSIHg7NHxt9ctesBw3vS0rDh9D95dPC5KKSZCvC2kE1CD341LIIN4e/rkNHGw+ElvH7MvBBCOnRs8sjvZfXXk34gDoIzm/vnZjWxsmMw7GZMBHpWf17azsBBggS+9urN6G4WKv2PNt99sBaHHfL5mDf2X3PTsBa+VuAJzZ9b5Wxse6EOarSq4WyCz2WENLE20pDKAUYCmS3HkZGulM/iK21fG50GcMN9gE2dUZooD3yHiHBWjTemSSvizotsYa53d7l8C8G6n65fl4CwbXiQSQYoqNS87fv429IJFHG+kKm7t/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:24:17.9047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9a5356-f059-403b-3c91-08def8537c09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF
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

Force complete the MES scheduler ring fences together with the scheduler
rings so their hw fence is realigned to sync_seq.

v2: cover all XCCs (one scheduler ring each), not just mes.ring[0].

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 520fd59036d5..e2b8253489f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5036,6 +5036,19 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		amdgpu_fence_driver_force_completion(ring, fence);
 	}
 
+	/*
+	 * MES scheduler rings have no drm scheduler, so they are missed by the
+	 * loop above. Realign their polling fence too (one per XCC), otherwise the
+	 * first post-reset submission polls forever on a stale seq. sched.ready
+	 * skips KIQ pipes.
+	 */
+	for (i = 0; i < AMDGPU_MAX_MES_INST_PIPES; i++) {
+		struct amdgpu_ring *mes_ring = &adev->mes.ring[i];
+
+		if (mes_ring->fence_drv.initialized && mes_ring->sched.ready)
+			amdgpu_fence_driver_force_completion(mes_ring, fence);
+	}
+
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
-- 
2.49.0

