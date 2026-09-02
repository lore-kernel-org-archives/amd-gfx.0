Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16DAC61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBCF10F1BB;
	Wed,  2 Sep 2026 12:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqBFT1l9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1ED10F1BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qop1l0YGyn9poai5versB/PyMlT5B5KQRufjll2DaY+tMZpKE/4mAtNIin5Zczqj2FgrpLl+NHh/sUdn2olGuLHpiSELPtSEcOo1cg24eGheA6NJilsN2abc0/oTv+GnDmHb/z/WbVn+0RZ+iSyx4eQiiARxmHqWVNQJdgKman1XLKhyC2YIIpO4egpeFaKn5641kk1PQ9fZCscx6kRQfOiaZqKCu/vFkw7gv6FW513SDtT3oI10fuPxMQWVrY7M5+MI4B7ZBhB9IbYSiTrp+GIAUtROobtM/UKD0thCkrT1h4tVPCXnMwq/NeoRfV9pMBSipVHEqufNEuLfscQ+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6zogO+GYOkGbjXsC7ee5IfsGcvmkxOu9GFPAVQlkMk=;
 b=arQTTacZyJZgp1IiSsezOzQnNDvQ+pv9J171DMeY7DC3P97H87oK1cpbc7wgDf56660wL/CvnweyCi9E9ZxI1s4xgLMXsgIrDYDGAsuQgXlBlOhCrzdvHGn4qlQrt8PbNoJE+9M/KFq0iLBWM8+yU4h4kxYMiYEcOvfZ10ljrW1hbCypLarFaAPZScDtpqbJroDGRCYlo8IPK4lCZGqcILHv5GUDsTriJFOWouVGP/QMvjO5MTZwCOL8dMEUnBi0VSZWFVk6BinZx0lNvA7gf/us5r+87EtolvZa7D657sgRqNDK/+Veia9eTQpf5m0qefkVmbmfX99axH1AfS6AVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6zogO+GYOkGbjXsC7ee5IfsGcvmkxOu9GFPAVQlkMk=;
 b=BqBFT1l96m+7Lf2GKQmZzBHwBGgN/jCefQkuWYVKvsIuAoJN0DtZK599qGJW+WFGqf6KRp9hw4dMq5TSvQmCx7pNGgUMQzgJBGxZ+Ix6O7d0y6ez8e2HbkjcclUYR6D9TUJvN/6ay6Dudv4K1+ZAGGa8pMpF47iMMblYMXHm5/w=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 2 Sep 2026
 12:50:35 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::80) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 12:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:32 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 14/18] drm/amdgpu: skip gfx switch_power_profile during GPU
 reset
Date: Wed, 2 Sep 2026 20:49:57 +0800
Message-ID: <20260902125001.621629-14-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 424bb04d-1fbe-4d72-d7c6-08df08f0c81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|5023799004|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: VSLhZMqd2u3a6blOtNssYTTh7QXEYa1HGiwqYoxbKYbMQC/xpXKE/b0K0Y0qiPQBKzr0sgDj937FLR+diCdCqDvJpS9Jk+LoWnyAR7xH7kpU7wJSs37Iz4dqbL7qCqM7WA9BE060v+RLdcG0UI6Yatqlbif/Q8RwYzwj2GPGM6ZXciUrENMx5gg6TcJdO/I9TA2dhi+CVCswyMlNkbS0t6R2k17xBrhmjqwj/jHhYIRvGEd2mPuwFbZmk28N4igYSIpWjP95k7TVILoHmRzwdvSfw/bBT1LHnoQIgG7PXEAF6Vorgrc27WJfJm67DKFflyKvT/jXmchO9eF4fAzXvc01B2Mty9dJV6qbcmTAbVGP2aE+IK8kCMH6DETxVoMWr2BOf2CbGyzl7SUs6m1r8+b59WaK1iAa2U7lMz5tt8cCfai5unuhmh8YKsOYL61Oh3y7akHsL10e2cm2XKFFRrfGYomuyO3o4udJCzdNsdGDfGmuyAIpsPSNufPpFUaFwNuRG7zuv6rGgI2CiD7I+pweYMzdiB6GtVKpytKeWCxzvnvg1nXgCpNhrxzYBqAKiMoNUtIU7B8Nu5ifHXR/w9nP9MxwFFIW7Q//SCixmHPvZcmjOH0wMzonluAhAbb6RacAmwo/MzAPN4G12tj5zhCkhwkcLfkCePYCtMDHKIuHRbrRgft+XUlCW8EQK3k9WB4tKHwNuagVx77SyXDdQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(5023799004)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +yGiM6Y/TBhtea55AskSiE5dScNF/swO2BK87+sCj7bMO/Dsp1un78747tqI0jY1yr5ehdrlWErx7eC70tgAhqNuB+86j46NxfOSVycgh7WfBLEt4FddI3J4/twwkJScqd8JJfqvBQMjoz66fPIkGSKp2VSRC1Vd60dE9HKmqw3++1hRdA5yjS38FxUFCWm7RgaEEI27ASUCgkX+LUVmu/obr/oMvl+K6LNcM5Hu2YyQuqJf4XFR/Ie55G7wxo0jzh/uLgEml4XQlJqpPzo+4x8gpc2kq0NNTDpNwTQdTYBDkVxO/mcph1qSfMqllxhFPMTLF5hIrXOFA8traMYu7z6dqL+iMjDkLjcVowly4j27foTn0DEPYTnM0gnPQp9e/PUWdVcgTm8oDChQPW43BZXn1WXs7CO3mDPgMxfj5bARs91HBSRO1InpOIIxaiAB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:35.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424bb04d-1fbe-4d72-d7c6-08df08f0c81c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
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

During resume from GPU reset, the gfx idle work may invoke switch_power_profile
before the reset completes. This causes the following assert error because the
register access occurs without first releasing the GPU reset semaphore:

[ 1576.768935] CR2: 0000559ea133ead0 CR3: 00000002e6c42000 CR4: 0000000000350ef0
[ 1576.768940] Call Trace:
[ 1576.768944]  <TASK>
[ 1576.768953]  amdgpu_device_rreg+0x21/0x50 [amdgpu]
[ 1576.769158]  smu_msg_v1_send_msg+0x1a4/0x6e0 [amdgpu]
[ 1576.769437]  smu_cmn_send_smc_msg_with_params_ext+0xba/0x120 [amdgpu]
[ 1576.769721]  smu_cmn_send_smc_msg_with_param+0x33/0x40 [amdgpu]
[ 1576.769993]  smu_v13_0_0_set_power_profile_mode+0x192/0x2b0 [amdgpu]
[ 1576.770267]  smu_bump_power_profile_mode+0x5d/0x80 [amdgpu]
[ 1576.770538]  smu_switch_power_profile+0xa4/0xf0 [amdgpu]
[ 1576.770839]  amdgpu_dpm_switch_power_profile+0x6f/0x90 [amdgpu]
[ 1576.771210]  amdgpu_gfx_profile_idle_work_handler+0xe9/0x130 [amdgpu]
[ 1576.771460]  process_one_work+0x23e/0x6f0
[ 1576.771491]  worker_thread+0x1c4/0x380
[ 1576.771506]  kthread+0x10c/0x150
[ 1576.771512]  ? __pfx_worker_thread+0x10/0x10
[ 1576.771518]  ? __pfx_kthread+0x10/0x10
[ 1576.771530]  ret_from_fork+0x314/0x390
[ 1576.771537]  ? __pfx_kthread+0x10/0x10
[ 1576.771546]  ret_from_fork_asm+0x1a/0x30

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index ce526db4d24a..808be6c425bf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -348,7 +348,8 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) ||
+		amdgpu_in_reset(adev))
 		return 0;
 
 	if (pp_funcs && pp_funcs->switch_power_profile) {
@@ -367,7 +368,8 @@ int amdgpu_dpm_pause_power_profile(struct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) ||
+		amdgpu_in_reset(adev))
 		return 0;
 
 	if (pp_funcs && pp_funcs->pause_power_profile) {
-- 
2.34.1

