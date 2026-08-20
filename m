Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9103C5DF87
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 07:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B82B10EF1E;
	Thu, 20 Aug 2026 07:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e36Vk6XY";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF9410EF1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 07:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3bhqspC8U9tnWSOg9rRI9Zh22y+ZbYuAf7z/Wa1YQ2CCyym3rwTL8JwpqGcLsIZLIeGo+enxr+I21IiDcAD0HHyyqtK+b7h3MEzY/u1NaIplvhjFOJGMLQlWHwgiRDrTGTCrl9QSpjFRtyCZAm8y5nW/+vSHopE4WMPkM7WK1J/n77uY5iDcTJxjIe047MO9Wmi/1fBpitQwyzC7DkOfa6sHeC1+qpgJZsMYvWXlHKoBJGauecv3JkD0AfwzBl9szsR44Ro0IFr/qBM+JpXT5mVatR6/6ar+lKhTyzCGF7KM0IKD1rrniNgTBziWyeblgLf0MaaJV2THb/p6xHxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q27HW/3fkIFLQqbyTaewHsx/j+XZa+tBUvk7/PTroWk=;
 b=PWMavWVgD5HQYbnYYHywvSLyxbM8WRX28YOu1tdGCvcG6QB7tC+WfZhh8VcrfFSVMW4wQVElXrA+M7fR8igG/5rV4AxEN6uzQHm2bdpCfHjb3ow3iLN3SfIjZB69SbmuwQ3Zpu1W+wfbn4oQKqjUcwqmr/lXiyQ+fIpGqEB1diYz0aM9AnHXlncH+ABxlzGinkapedyI5nSz6I8MJYgAhVXyQE6BAGBc+X1EVymE/61ZrbAVFGu0OvYTDS15+oh44Z/GI9CYlheZgDDbSr/WgiAoWTSHA/evY+Mw9T6cVgQUnDWjcLWxZYxz8+TduipF38ex5E5JeptanZjC1+oF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q27HW/3fkIFLQqbyTaewHsx/j+XZa+tBUvk7/PTroWk=;
 b=e36Vk6XYXS71ED8CaXWrsYo+b5q6OIWFWNJZNLWtIGfWVOgwOGOvDkO2i6Im5oiAjvWnUtIQ5S9hq+5tbtf+TGdahnrg5tMF1WZ105SyJc9T1BDc/oiWiRBHbFt+XPuRjpoGbNbXYcNKI1e0CoyOZ4mAxkMZeH6scb2nXlHXpRI=
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 07:02:47 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::3c) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 07:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 07:02:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 02:02:46 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 02:02:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lancelot Six <lancelot.six@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, James Zhu <james.zhu@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>
Subject: [RFC PATCH 0/3] drm/amdgpu: Render-node second-level trap handler
Date: Thu, 20 Aug 2026 12:31:40 +0530
Message-ID: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: dd763653-6f3d-4888-66bf-08defe890a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|10067099003|10086099003|11063799006|5023799004|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info: jppZcgtLv1qVB7kJ1eSWqpYACcdylA2sZJhRSVGgziKOF638R0KbFoWO7G4SNytf4GYiJThvhqws0VORWcQntKhSUvr9MJ4DvSeQTB59rMCFWIWLFrEXmwA30quuudl74SHpLZpTxWG8veNX+dl4RFW+rih4cOs2Aa//Lsw+f7L6WJ5moBVHIVwZMz6k6sjDMuwur9hoqaNlWefCHLlWSE6aylHj3SmOeVLA9VxnNyEjJvyV/jae8WO7nTZQQCP2WoQwYf/BsHeod8w2G0d7ufx0j02kUJ72QkIiEcBSi5KePMEj0yS0wXbTLCYni8GyiSYyLYgwSxYya/xZmhMoUoHzpR5BSPnLJLkNqxnjaBCjSQrpO6kUOIbvVpoEvt+ubk3CPDi0TGu8oIUkBaym5M3FGMN0WDV1eMBghVmqvby6SxujNoKzSdXGCObPn3zwBg1JwN6U+Vbuw1jJNEIY0nWYi4+/KhhK4//FOp8SwoElfGSzqnqPZXYHx5i7SFaEr1lL2w74YamMOj46uNgNOLXLj5Fei7Iylp8O7dDWRtL1JYP11hFHcqKwCR7RFGiROzFJYcruJPmtT/ktBzuPu3BuqEFVv+Q4yuQd+Y8Yvfy7pTEoQBH9/48Moecfl2yGCRJXASp6jwfELFc5yReCC+Xa7tWYNF6gkvglQ4ap9NIW4n0iqh3KMwN10mCozpkdFpGDy9CdWkpgy3vHJ6EG+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(10086099003)(11063799006)(5023799004)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q+BuKRPhFnSgYtT5RvpOETYC3bByE7yhGMTar7SCS/mA8S/+owWhP3N+JxuvZTjQ0BrvgImdGNWzxMrLPqHdrnEWk6SXcj3MWATLxuoQOZvXwHSs3egSny5HOOL1kP5gOKZlK1Cr5lmmnNnLO65f6Wjn1EnSJi8OqCkxIpo2y6rtAr41eRPEWmZI/p346/GkPrj7fyInukz59Z5XuKbzJHO/MebhrM68bKD9Vf1DFjlVLQs/Pf0Nk6nZdG/RxLwPy6xLbCbE7o0/qiGEBEFxJiiyyQNfBWY67sQfafpo59L/4lsRNiXVCqa+okZxAKhKBfvJYT8jVOgLB8tD5OlrMNGG1w/vMJv6zSx8zWmaWCJVrUnPED55sUCz61owcCHNX68T0OAMWAMSKny2PsFvNGhyXK/nFPU+d9tvhF7eY/nfm/fWRJlkBEvWERp5Ugly
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 07:02:46.5921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd763653-6f3d-4888-66bf-08defe890a23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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

When a GPU shader hits an error or exception, the hardware calls a trap
handler. AMD GPUs support two levels: a first-level handler that runs
inside the kernel (via CWSR), and an optional second-level handler that
runs in userspace. The second-level handler lets a runtime or debugger
catch shader exceptions without any kernel changes.

KFD already provides this for compute workloads. Render-node user queues
use the same first-level CWSR trap infrastructure but had no way to
install a second-level handler. This series adds that support.

The second-level handler is a per-process (per-VM) setting. All shader
queues belonging to the same process share the same hardware VMID, so
one SET_L2_TRAP call covers every GFX and compute queue for that
process. This setting belongs in the VM ioctl (DRM_AMDGPU_VM), not in
the CWSR ioctl, because it is not specific to the first-level handler
mechanism.

UAPI backward compatibility
---------------------------
The drm_amdgpu_vm_in struct gains a 32-byte union for the new op data.
Existing ops (RESERVE/UNRESERVE_VMID) only use the first 8 bytes and
are unaffected. The DRM framework automatically zero-fills the new fields
for older userspace programs. No existing Mesa or ROCr code is broken.

Implementation
--------------
On discrete GPUs the CWSR scratch buffer (TMA) may live in VRAM, which
is accessed through MMIO on some CPU platforms. Direct CPU pointer writes
are unsafe there. The driver uses struct iosys_map for all TMA writes,
which picks the right accessor automatically (regular memory or MMIO).

Installing a new TBA/TMA requires two separate memory writes, which
creates a race: a shader that traps between the two writes would see a
mismatched TBA/TMA pair and could crash. To prevent this, the driver
stops all user queues, flushes the GPU TLB, writes both values, then
restarts the queues.

GEM_VA UNMAP and CLEAR operations must always succeed — they cannot
return an error. If userspace removes a TBA or TMA buffer without first
calling CLEAR_L2_TRAP, the driver detects the overlap, runs the same
stop-flush-clear sequence, and lets the unmap proceed silently. Queues
that lose their trap handler this way are marked invalid and not
restarted — a queue cannot safely run without a valid trap handler.

TTMP register layout
--------------------
When a shader wave enters the second-level trap handler, these hardware
registers carry the relevant state:

  ttmp0/1    faulting shader PC (set by hardware)
  ttmp14/15  second-level TMA address (set by first-level handler)
  ttmp2/3    free for the handler to use as temporaries
  ttmp6[30]  wave stopped flag (set by second-level handler/debugger)
  ttmp6[29]  saved halt flag (set by second-level handler/debugger)
  ttmp11[23] debug mode enabled (set by first-level handler)
  
Only compilation tested.

Based on: amd-unified-interface branch
Base commit: 0f354d789fdc ("drm/amdgpu: Drop vm_manager PASID to VM
             mapping")

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>

Srinivasan Shanmugam (3):
  drm/amdgpu/uapi: Add second-level trap handler ops to VM ioctl
  drm/amdgpu: Add VM ioctl handlers for second-level trap handler
  drm/amdgpu: Disable L2 trap handler when its VA range is unmapped

 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c  | 341 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h  |  54 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  26 ++
 include/uapi/drm/amdgpu_drm.h             |  80 ++++-
 8 files changed, 469 insertions(+), 77 deletions(-)


base-commit: 0f354d789fdcd03147eb77ab2e3ecdd5a67a1fad
-- 
2.34.1

