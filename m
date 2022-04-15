Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97F0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 04:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5946D10E804;
	Fri, 15 Apr 2022 04:13:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6871610E804
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 04:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAc2jqrcMcx+SUUvpLBpkr2Djis9rihenk2406So9RTwekgiqpaFKfFJvVmcEdg5mYjJE6+yiedYgtLJNPEQayAikTNH14Gf6BSeF3vrFmZYdvCJpHzm5dTNUvnkSlRcvFfbFA8De5IbZ+v3qnHNQkhWAswmRkimqGdIq+OoUHidB/mN88C8mhg1M/g3Cwc758pz8BLEkmjGXkB439slvOO6zHGKgMJMK+tEGhRYYz/e2g4+7Ur7xcdqqIN17oskhVHzUoh9JkwEfRvc+mHYJKWHAAfcfBQz1mYlbXlIzOi4C8/ygdXFs7VAWFAgeTpc1vxRrmfLeV56ImTnEHNYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1UdixhUFoD8nAUKgKOH6bZyyJc6UWvMkh0f7wOG1rM=;
 b=HYPvMxDjgZeXGlrlCO51KoaPl+8Y4D1djjjMI0mfzPhFBFafuEjWqpwlk9OCLlDFJgZnRGTIY4aqBcsE7pw6LSyYRa+oigUhCrbzmmma9J95ejyYo6g6oZmCXROcvP+h8/drzQny0U18EvMNeKSmjsUfTxCkg6WH74nqkBKEfQuGzRtWsL7yD44OvdrSrXtgJT97oBEBhR3lOW6rWpa/11PEUyYefy1uyo+9a4WdK4hVBpQ0g4LrFYpSbuuiBBSakcmpzcQXAYXEv0U1jHwOlOVCZTeFfVV8r1apbGG1xx1FkVieFOTeVJtbmjcQ/h+EM4SbvqNIzsYpA0LIfSo4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1UdixhUFoD8nAUKgKOH6bZyyJc6UWvMkh0f7wOG1rM=;
 b=ZwpgL+wNpfi7xAmR9WKoceVo6VUtJfBWnwcFNdvygEm1ahKI2+t8lYz5Zzr23Tp7pB/j+AaMA3vB5O10Dk8SmEffGy2Vf2OV74Ye5nQJ7hSUTwTxwODOKdi3AU3uSyypCYIkTKpEcVSRkGuzFuo9s63bm+CAIk9RGT/aS37nE9k=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 04:13:47 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::e1) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Fri, 15 Apr 2022 04:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Fri, 15 Apr 2022 04:13:46 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 23:13:40 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: fix the null pointer while the smu is disabled
Date: Fri, 15 Apr 2022 12:13:25 +0800
Message-ID: <20220415041325.3345497-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 273bdb0b-1a5d-46f4-e785-08da1e96561b
X-MS-TrafficTypeDiagnostic: BY5PR12MB5014:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5014F2058CB922F127A33022ECEE9@BY5PR12MB5014.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w05fcGl/yPhau2ouFSO0sdVbk39a3iXP7lJobMCmXZSA8lo4GVXPuLW42XSCcHtnHinRHH4JCzLEYwGK4sDUJK6LGuF4mqWPi8+KSjssmPfxS0OrFaeLqSGQWapsMCdpRCz4MF284UJCFwaucHpkBTPa5Xkky8p4XSzTqj28qpFcD6qKREPXCT9nDf32Aaf3vLOQAZPRaAqmqBoEA3vWlKO0flu0osI7sQ84WUWw93gTaCu09GfiyFwDp/HuEkW3ixoap6kvMaYNPlat8i8yaAjOtHrDq8TXyNLu0gyKZ2hupJdaAslc0HpkJy7iewiRUclZX3Obtq6sVoW0kIB0/OVPbRX6KgXx6QvSo8+XNREQbGRSmfZWPZ1+c1CCEVAdp/aU6CkjriPVM/vtHEHKFXOyzTUhHop5ebt0Bxr7gZTe/HfAl2X3SJQcwuCIjdPKC9+8jSU+NSWVtjeKw+5csBFs6ApAP2s8HTgdAg6RBuKnVpwHP0iUNJX5/bHpamgFnmFIp7c0LqvZsoOJnnbLbxgErtsjhKeA3KnYULuJIvpYJ0eMF5hnejV/nA5/aBk77Gl65FCRL0dA/4BG9Sgp4flki8hGbodoDeKiVCMFYi75V8LKRKcytMNYwUA7gFiHFxS7bGy3L5CejTCLXW5H9JCaCbpyZaSSr8JS307b+OKCXOhm/FnNhHsmULmAPwE3oruI5kTYDaeSuwmQ9UMKgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(82310400005)(426003)(54906003)(186003)(336012)(2616005)(16526019)(47076005)(8936002)(316002)(6916009)(5660300002)(81166007)(1076003)(2906002)(36756003)(86362001)(356005)(6666004)(40460700003)(7696005)(26005)(70586007)(70206006)(508600001)(8676002)(36860700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 04:13:46.2131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 273bdb0b-1a5d-46f4-e785-08da1e96561b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <tim.huang@amd.com>,
 Evan Quan <evan.quan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <xiaojian.du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It needs to check if the pp_funcs is initialized while release the
context, otherwise it will trigger null pointer panic while the software
smu is not enabled.

[ 1109.404555] BUG: kernel NULL pointer dereference, address: 0000000000000078
[ 1109.404609] #PF: supervisor read access in kernel mode
[ 1109.404638] #PF: error_code(0x0000) - not-present page
[ 1109.404657] PGD 0 P4D 0
[ 1109.404672] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1109.404701] CPU: 7 PID: 9150 Comm: amdgpu_test Tainted: G           OEL    5.16.0-custom #1
[ 1109.404732] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[ 1109.404765] RIP: 0010:amdgpu_dpm_force_performance_level+0x1d/0x170 [amdgpu]
[ 1109.405109] Code: 5d c3 44 8b a3 f0 80 00 00 eb e5 66 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 08 4c 8b b7 f0 7d 00 00 <49> 83 7e 78 00 0f 84 f2 00 00 00 80 bf 87 80 00 00 00 48 89 fb 0f
[ 1109.405176] RSP: 0018:ffffaf3083ad7c20 EFLAGS: 00010282
[ 1109.405203] RAX: 0000000000000000 RBX: ffff9796b1c14600 RCX: 0000000002862007
[ 1109.405229] RDX: ffff97968591c8c0 RSI: 0000000000000001 RDI: ffff9796a3700000
[ 1109.405260] RBP: ffffaf3083ad7c50 R08: ffffffff9897de00 R09: ffff979688d9db60
[ 1109.405286] R10: 0000000000000000 R11: ffff979688d9db90 R12: 0000000000000001
[ 1109.405316] R13: ffff9796a3700000 R14: 0000000000000000 R15: ffff9796a3708fc0
[ 1109.405345] FS:  00007ff055cff180(0000) GS:ffff9796bfdc0000(0000) knlGS:0000000000000000
[ 1109.405378] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1109.405400] CR2: 0000000000000078 CR3: 000000000a394000 CR4: 00000000000506e0
[ 1109.405434] Call Trace:
[ 1109.405445]  <TASK>
[ 1109.405456]  ? delete_object_full+0x1d/0x20
[ 1109.405480]  amdgpu_ctx_set_stable_pstate+0x7c/0xa0 [amdgpu]
[ 1109.405698]  amdgpu_ctx_fini.part.0+0xcb/0x100 [amdgpu]
[ 1109.405911]  amdgpu_ctx_do_release+0x71/0x80 [amdgpu]
[ 1109.406121]  amdgpu_ctx_ioctl+0x52d/0x550 [amdgpu]
[ 1109.406327]  ? _raw_spin_unlock+0x1a/0x30
[ 1109.406354]  ? drm_gem_handle_delete+0x81/0xb0 [drm]
[ 1109.406400]  ? amdgpu_ctx_get_entity+0x2c0/0x2c0 [amdgpu]
[ 1109.406609]  drm_ioctl_kernel+0xb6/0x140 [drm]

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1d63f1e8884c..428623e64e8f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -717,7 +717,7 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
 					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
 
-	if (!pp_funcs->force_performance_level)
+	if (!pp_funcs || !pp_funcs->force_performance_level)
 		return 0;
 
 	if (adev->pm.dpm.thermal_active)
-- 
2.25.1

