Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09A1CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 01:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784BA10E3BA;
	Thu, 12 Oct 2023 01:32:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F57B10E3BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 01:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw4zCubU6Tjn4+p/ISJfVmy2l8xePx/ImiRJjJ8kPyW8tGtBZzM//+sJqyyh80iOsFZmR4BEt2OJaZMXWhKwNU8T4Xz+zus8n9126pjuJfinLp1XjARDxQeC/a1CHBLH0bdQP17xY5wBVa5JcmHAoKDhryTzJ2OVABGPOGDZc8hjwr6fcMo0jiBme6YRXRtyelvfq9Al3KCax+tFGr72YG8DsAcqoboRJRff7GCfU5SwI/4bxNDPHA3dz61XATaAd+Ci8S1o+/R6cfY0tbUxL1L5dJc0CGzUrozBzeXculjYMBYliqKcdb8xFbCg8ho3RA5oxYSNbud27+1OFq9wTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMpojYxEP7uQzdOT/eSmOMNubRJsQ0BnhDLTCr+ip8Q=;
 b=LR5wQhn7WQji22bx+i133vshTZvwk3hob03OE++gkkdEuy8nijrEfIBfzV1cMhBgStC02LMDtH0asqQ/o1P+6UMDzYm94RF0WR8cIITBaVJlVK2RdplbOuEWhAIJkRC+Y7Uk2k/MHwIBsLeHLp7aVyHF6CNKP4e7BUkaGHFj7yx1rNb5IAcjM+rLWtcpjc2QuKInEjKebT4Nw4IZv2ysPxlcKT8iwe94mF83pqOzd4tJv+5X/NAKWroHB1h3MlSUWuTuJ8wuw/QQuaVinifQ0KcsGTc/ZmwBh1Q/e3fW5n+zw814IsRtEgQfmEn8sLTPmep61JYnLCztc3TWelJQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMpojYxEP7uQzdOT/eSmOMNubRJsQ0BnhDLTCr+ip8Q=;
 b=VKDP13tOAIdIXvNd1ryKXx4GYLv4MKJHheTiqHXFLkkOzXW7Ncae1fp9TnLTVC4+RJoNmg0k/ZxaKRdBYp6+L138o/Gm8Ja9NsfIsrjqdi+zkkSvoanKxpez634N9BMpOLJBCb6WOo5BpZRccNVn6JQbsNVKh9U9MRmvhdyJrcw=
Received: from CH0P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::9)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Thu, 12 Oct
 2023 01:32:21 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::77) by CH0P221CA0008.outlook.office365.com
 (2603:10b6:610:11c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40 via Frontend
 Transport; Thu, 12 Oct 2023 01:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 01:32:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 20:32:17 -0500
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 11 Oct 2023 20:31:51 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix software pci_unplug on some chips
Date: Wed, 11 Oct 2023 21:31:48 -0400
Message-ID: <20231012013148.207757-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 4904a1d1-4044-4196-1953-08dbcac313f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5R3a0HIRl13V3JYrN1t1nFJScyGpC72iluOljKajiW2dPo/MouKIkT9pETdxI/FlfPOpkNW9JyfCTA9mGybV+LxFZMCK8N3T4yTe7g96FzZ5KiqN8y41uHfhpZCcurvWaPQ+ULelJgP/TvUP/Tfff2Lnwyx5F6h25SW+xLXXJ/OXnx7F8q7Z6F80T7gm9Zm7dS8/qVUzheV8FxBeQyfVkvV+q9ow6fdru4T02JQbXXRJLfGVeHlw1YWcSWfw8e2Qk7uNfuYh4oe5z5Iv7A88XTlw7J1EJQIqpvsIb8UQ/p/Mp6Bs0A1oLOCnCQB4eJs7NwWt02uUUxlUB/Tbyy/Z+uxilJ7DNPQd9gxjM+lDEsSOGknBCQFr92IhFyQuvo0aUQDW4iQycKGOV/gBp6ab0ugEBBUiNdYM6fP/mFQMQLvqrKT96R5TH+LxqF7d++F9Ei4yAv5eQa7nvKI66l9FxyG52XHRbKrFfLjBE+gPdOa0Mjt3594CFggHb5wWJkhk0Nj2C88lqiEmoVvKO6P/4odrXkLctSzT8dkfdhzJYxmdnD0CbX6Jm3lxolvOnUK8zIwprWeQ25Of635EQ8avw0K5julAuqtywrJmpsNp8idyP8FrFnFSMq8uIaRjNDvV/2SgsOrJDqAX6wfpysO2F71iWShtSmM2wmHArDhdyeqThmw4tqNNKAp1j7paAA5NUfu5UK3FGkh7u9FvFobyU054B1siEcyirCgA33ZhoQ4UPo7/DfnHBpz0l/efSB2SEps8b8ya1KjQLgxApNxBVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(7696005)(426003)(26005)(336012)(2616005)(1076003)(356005)(81166007)(47076005)(41300700001)(40460700003)(86362001)(40480700001)(36756003)(82740400003)(70586007)(2876002)(4326008)(2906002)(478600001)(36860700001)(8936002)(8676002)(6666004)(6916009)(83380400001)(316002)(54906003)(5660300002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 01:32:20.4277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4904a1d1-4044-4196-1953-08dbcac313f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

When software 'pci unplug' using IGT is executed we got a sysfs directory
entry is NULL for differant ras blocks like hdp, umc, etc.
Before call 'sysfs_remove_file_from_group' and 'sysfs_remove_group'
check that 'sd' is  not NULL.

[  +0.000001] RIP: 0010:sysfs_remove_group+0x83/0x90
[  +0.000002] Code: 31 c0 31 d2 31 f6 31 ff e9 9a a8 b4 00 4c 89 e7 e8 f2 a2 ff ff eb c2 49 8b 55 00 48 8b 33 48 c7 c7 80 65 94 82 e8 cd 82 bb ff <0f> 0b eb cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
[  +0.000001] RSP: 0018:ffffc90002067c90 EFLAGS: 00010246
[  +0.000002] RAX: 0000000000000000 RBX: ffffffff824ea180 RCX: 0000000000000000
[  +0.000001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  +0.000001] RBP: ffffc90002067ca8 R08: 0000000000000000 R09: 0000000000000000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  +0.000001] R13: ffff88810a395f48 R14: ffff888101aab0d0 R15: 0000000000000000
[  +0.000001] FS:  00007f5ddaa43a00(0000) GS:ffff88841e800000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f8ffa61ba50 CR3: 0000000106432000 CR4: 0000000000350ef0
[  +0.000001] Call Trace:
[  +0.000001]  <TASK>
[  +0.000001]  ? show_regs+0x72/0x90
[  +0.000002]  ? sysfs_remove_group+0x83/0x90
[  +0.000002]  ? __warn+0x8d/0x160
[  +0.000001]  ? sysfs_remove_group+0x83/0x90
[  +0.000001]  ? report_bug+0x1bb/0x1d0
[  +0.000003]  ? handle_bug+0x46/0x90
[  +0.000001]  ? exc_invalid_op+0x19/0x80
[  +0.000002]  ? asm_exc_invalid_op+0x1b/0x20
[  +0.000003]  ? sysfs_remove_group+0x83/0x90
[  +0.000001]  dpm_sysfs_remove+0x61/0x70
[  +0.000002]  device_del+0xa3/0x3d0
[  +0.000002]  ? ktime_get_mono_fast_ns+0x46/0xb0
[  +0.000002]  device_unregister+0x18/0x70
[  +0.000001]  i2c_del_adapter+0x26d/0x330
[  +0.000002]  arcturus_i2c_control_fini+0x25/0x50 [amdgpu]
[  +0.000236]  smu_sw_fini+0x38/0x260 [amdgpu]
[  +0.000241]  amdgpu_device_fini_sw+0x116/0x670 [amdgpu]
[  +0.000186]  ? mutex_lock+0x13/0x50
[  +0.000003]  amdgpu_driver_release_kms+0x16/0x40 [amdgpu]
[  +0.000192]  drm_minor_release+0x4f/0x80 [drm]
[  +0.000025]  drm_release+0xfe/0x150 [drm]
[  +0.000027]  __fput+0x9f/0x290
[  +0.000002]  ____fput+0xe/0x20
[  +0.000002]  task_work_run+0x61/0xa0
[  +0.000002]  exit_to_user_mode_prepare+0x150/0x170
[  +0.000002]  syscall_exit_to_user_mode+0x2a/0x50

Cc: Hawking Zhang <hawking.zhang@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5fb57419ef77..1673a10835a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1390,7 +1390,8 @@ static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	sysfs_remove_file_from_group(&adev->dev->kobj,
+	if (adev->dev->kobj.sd)
+		sysfs_remove_file_from_group(&adev->dev->kobj,
 				&con->badpages_attr.attr,
 				RAS_FS_NAME);
 }
@@ -1409,7 +1410,8 @@ static int amdgpu_ras_sysfs_remove_dev_attr_node(struct amdgpu_device *adev)
 		.attrs = attrs,
 	};
 
-	sysfs_remove_group(&adev->dev->kobj, &group);
+	if (adev->dev->kobj.sd)
+		sysfs_remove_group(&adev->dev->kobj, &group);
 
 	return 0;
 }
@@ -1456,7 +1458,8 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 	if (!obj || !obj->attr_inuse)
 		return -EINVAL;
 
-	sysfs_remove_file_from_group(&adev->dev->kobj,
+	if (adev->dev->kobj.sd)
+		sysfs_remove_file_from_group(&adev->dev->kobj,
 				&obj->sysfs_attr.attr,
 				RAS_FS_NAME);
 	obj->attr_inuse = 0;
-- 
2.25.1

