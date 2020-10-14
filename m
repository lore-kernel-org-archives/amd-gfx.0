Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63772078A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y2KzRjVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63772078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61AC96E09F;
	Wed, 14 Oct 2020 07:18:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9468A6E09F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 07:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdetgdFcWprvcj0vXYKKrYCk7qeEJNWeqrfb/7dlfL15p7gzmqh3ZTKZwcQfWeD24uiSKhGL7MU10l9f8XVvhPYOgtvL+bo2K9ICMCKD83zsBH4Y78j8KPiYkohex2+Duf1x2BSlGLU701jRp4I8zZWIseHkRXyHyAva+gJ+aVYuOZc0zwMk9AKKgcrcimq4y9QB2iKX+SAQMfJgaMAJyVfqP2P6fQsuREM64la0aOwpOhYBytVWdWZVRBvB1ac/4WXtAllq/L5jVSE/nvCrVbLvTL+YenkB58A+8rCKc1Jx3d2el3ZUfykySSomv36hZZZ65GAhRLsR1HDjEe3QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nneRCSvvF1nsAuAFOdp1oi1hO4slYaMUUbRz5z82sok=;
 b=VjARuw6BgzuurxGmzKH6yUzwV3XESuN/qAFentEdma7kOomJqip6ET9hyRMxBiZ1Jn00xuGrSdh9aHksnzeCm8LvKjILOY23zB4oVcia+JtqRb9JXtR0GgcyYaf27aT8/0XAVdRbaDbh7HHY8aOmPp8khaWWDz2JFoaou5VnjyrGSfWm68vMlYDfCW4lyBeJPlxQHpn56VhVniHP5fJQ1OFkwDdIK7XHZydJbBUaJzz2SYXkbNu9Uti2HjJHp53OxLQxHxC6Dw/bW1il2SXYuB1qUjAMn3ZI0lAHRYcar9gRAN3yB5p/SzUMFbwnnV4C7f9ORiOkZpfM4ySKwTacCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nneRCSvvF1nsAuAFOdp1oi1hO4slYaMUUbRz5z82sok=;
 b=Y2KzRjVlahLA02RJGgg3K3B4O5iv3JKaDe8a5ZWYaXyEgmoiYLtXA9hB9M5TZd4wpmBPWVdETXKt7fsOH4+dXNrrLs1fAwkUxRupSkNELu775K7j2HrRCb6BeIEM6EfudmA+uQAIBfzdTbiy2FbAsC0FSQbmSYmA1P2Yd59fvRo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.27; Wed, 14 Oct 2020 07:18:33 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 07:18:33 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amd/pm: correct gfx and pcie settings on umd pstate
 switching(V2)
Date: Wed, 14 Oct 2020 15:18:08 +0800
Message-Id: <20201014071812.8396-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 07:18:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df2b315a-32d1-4cbb-cdd3-08d870115baa
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2891A2A1E66F8C63FD7AB49FE4050@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+XymqfqSVD2zkO/H12bp8uvjJG3oVq4DFUlLiyJG5PtU2cQrE4/tBSKY+AKul/xv2dI82kfEOO7QrvR5wh+VsqHniOLM8y+uqvuccScpAPojw7r/fFSz1qUMBrpRu5sL7wX5Ojfo8dgXrv4NeffeE+pkhXnVVDyG+gHeaedLz9Qbj1hAKJ+IPCz/IZqjNkE/fgFJnkgk22d5EfpdNJa4Ky/49iW9x8zXf87ipIMF5uSpjmd4vHwymSTo4x+uZHJuJIAU49re2ZUlXxeGZk4dzCAHeq0vOhV1MebiYr2yYXDCzNdo4+pA93zj0kDdkLi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(376002)(136003)(44832011)(4326008)(7696005)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(6666004)(26005)(16526019)(316002)(5660300002)(8676002)(186003)(8936002)(478600001)(956004)(6916009)(2616005)(2906002)(6486002)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: L+e/3YBFetr3be0GROmqNAQd3PiF48ne1Tnnn9p+uvc8VmbLNwlNmsWDM8HRsohVFSj7C0buvRYFC1iotRrwVlXjqgW+na8ckM0ahKtWaw2bIysc4l6crS8dYshP9QoiCwh2myGwgGMVAaoraeoqaybNW/vUHAxpuLcQhDBqDSnEp82fO2w6eOWzDlDqU/t9hh70+hKp96IKdwXQUW1rGyai0F2pAc0a3SEt+mp3lcIdHbXEHehDn3gM6pySVjTCXF8Q87pBBhmWCxecB5JZCZpGaVj55y0vKCCQoU1XeJSj3hEdoVSqYER38YgLgBo4nP88u0ab+loXURlZ9Gun8/HCM84O/iZh5ZXm+PvaYLw8/qG0zzhdgcd09q6a2HKuTO9vI2o4nPuld1msSFvkmXR+spsDLRGElqHLHS+vkzvln6wIX098HeyyKp52Qyikob4yYXNzdmoKCergKXIV3EUtB0xo3+0Ay18Ct1PxBZWFNN6rRL+jdk8F3sEBRgKRawTurUL8plNe/4OrURaAGbTwXZgq+zVmvU0jRNGOhr4/oREk3IkcjKrgI11a5A7UF942tRYhKOCKYHfx74/LvkEiw3Law7oeCPUeYQOOJsppNRx+tuSE9yxOV5fQy2XNByHmcZ6eg5RsLXX0KbINxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2b315a-32d1-4cbb-cdd3-08d870115baa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:18:32.9979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGzNT+TlfvbPvloB3O8JxrBroDDdY1gEDYg7eNJknwpcx59JsBuL06xSM3Rp0e+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For entering UMD stable Pstate, the operations to enter rlc_safe
mode, disable mgcg_perfmon and disable PCIE aspm are needed. And
the opposite operations should be performed on UMD stable Pstate
exiting.

V2: take those ASICs(CI/SI/VI) which may not support this into
    consideration

Change-Id: Iff4aa465fd16f55a4f4de8ee0503997b204f8f9d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ece1b41a31f9..f8f3e375c93e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -623,6 +623,8 @@ struct amdgpu_asic_funcs {
 	bool (*supports_baco)(struct amdgpu_device *adev);
 	/* pre asic_init quirks */
 	void (*pre_asic_init)(struct amdgpu_device *adev);
+	/* enter/exit umd stable pstate */
+	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
 };
 
 /*
@@ -1168,6 +1170,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
 #define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco((adev))
 #define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
+#define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
+	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f78749bc8760..92869eb297d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1415,6 +1415,7 @@ static int smu_enable_umd_pstate(void *handle,
 							       AMD_CG_STATE_UNGATE);
 			smu_gfx_ulv_control(smu, false);
 			smu_deep_sleep_control(smu, false);
+			amdgpu_asic_update_umd_stable_pstate(smu->adev, true);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
@@ -1422,6 +1423,7 @@ static int smu_enable_umd_pstate(void *handle,
 			if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level = smu_dpm_ctx->saved_dpm_level;
 			smu_dpm_ctx->enable_umd_pstate = false;
+			amdgpu_asic_update_umd_stable_pstate(smu->adev, false);
 			smu_deep_sleep_control(smu, true);
 			smu_gfx_ulv_control(smu, true);
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
