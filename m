Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4CCCCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 20:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1DF10EB17;
	Thu,  9 Oct 2025 20:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWFj+njM";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F76510EB10
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 20:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfM+KHhtZFCvOQW9LFNZzhsFWz7CL/AdV8UEXzknx3sOytDZjnu1rvEV1+xg9ppXisl3t+CpAk4HasjsW5CcX1YorEH6gNOIz5leL4MX9hugaDLAiaKnZdKYHQ5XEHOX7xFCB5HhAvnZ5mpaSRRQHTkw+fiFlIp8Uy9j7wuF7AdF5NSNm4DYxiCla5VVMfvXzDv/MqXRCd6YtakbXPgwiC0g4JDYFyRgwb9SmhFTqFtlre1SFydcunUh2NDYSSIvYOtST8iuVQCaz+YHOdMvxAfrCGtqMXSuIkWNTe90z+cg9qloWKxeKaHPTpJSUMyYEE/8+yiXI7eHa8yqrt5Bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNqwDwNb/GxBh6rybu/y22YsFk3bgMO2/Mx2bXb4g7A=;
 b=CnBb5wVQTO3vhOmyLHMz86no56EHZZbOcYpnwY7NkfreN0ncM9UhnUa7SZbVVYhzByOKk8hqm0pWnORnU4L4GRXuBIxt0xuZVGIxXPEKbwSxeJh3w03LVeTI19jlLwyIrCacVX5hp2RyotXVV0uHsEq5PTL99BNEB/FThXl0XaajBOWhp3jabAXCk1F+Rl5/+w+SxzemuxkqP/MTMUwAkeU2sMW6RExErGfVASFXw6IFO0+VSdkpn0eFvs494542Rsai3d9bBmemEAg0gvJdFu2cILMNUuFw2sF0HG+3eoky17ZiCJsNXzLhuIYP8uWWzIaVBXCj5cDXVHMVcQ9fbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNqwDwNb/GxBh6rybu/y22YsFk3bgMO2/Mx2bXb4g7A=;
 b=RWFj+njMaD8m1UPmjg6I+8YqEmuJudjknk7QsqtO2gPb8bdaGpXX+N3TRplSp0CoJbek8ByHgJKLdYCCnz5z/4NTGR6346e2zwhKWSBnRpuyij1hfmOOL49b6O42RPbteYhY4NEZKsRL6yeHhwiE3tjhY6UzPUZ+Qnk+TPrK5ik=
Received: from SJ0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:2c0::12)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::621) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 9 Oct
 2025 20:59:27 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::73) by SJ0PR13CA0007.outlook.office365.com
 (2603:10b6:a03:2c0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Thu, 9
 Oct 2025 20:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:59:26 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 13:59:22 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Lijo Lazar
 <Lijo.Lazar@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v5 4/4] drm/amd: Drop calls to restore power limit and clock
 from smu_resume()
Date: Thu, 9 Oct 2025 15:59:07 -0500
Message-ID: <20251009205907.177404-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009205907.177404-1-mario.limonciello@amd.com>
References: <20251009205907.177404-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 983897f0-325e-4953-2ca3-08de0776bbb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PNKoyTaiayrtDdhDasXYYXiEDHlvycFLCJtWtQXitN9O/ViOM21vBd7xG3og?=
 =?us-ascii?Q?kaNrAVKtmhNjB4eSv9hahN73PHPzMwRlbhOWvt+F4zcovDXtryRF2jvWeGsZ?=
 =?us-ascii?Q?zz5CD+XzHyItaUWt/NgwXR6NfdRNPkDry/uhHyIJMRo+/ARChnHM2G0nzeod?=
 =?us-ascii?Q?U6QSmUL+CejbSz1ZXn0fZ7Xk14Bgys4wvjIAhT0I6nCFOSTS6IAUOVlus0DF?=
 =?us-ascii?Q?xS/4JRSqNf5zjlSxV2DtVZMCqsfh1wq9I7bLHjyqAib78wFYsMJ+uCI74gb+?=
 =?us-ascii?Q?fIlG+xgQ712hOdvptD8DsUbbknq8hNq+9z8VOtKL3RQrK+u0CNuJPG5gSAvt?=
 =?us-ascii?Q?HoxJgWWkDCDCI0GQ0kyyWa/a9yYDz29qiD9/oV9OyZOvjQGGk3isQFQxZQm7?=
 =?us-ascii?Q?DURmap4EHDIy53xKsqS8SltRC9FWiuy3C8z0qZr+PNlN44XXwy+rcuH66cpZ?=
 =?us-ascii?Q?Sa+t+BX6qdOBpf5zupx+I/9/909n8Bri9HYKuXLerTVqOZyJP0nPFJbAJjti?=
 =?us-ascii?Q?upWDBzb3371leFd3gfHd7aYAZILq36vWINMZ1BGV4jV/+7VjmtY3AedUFgcM?=
 =?us-ascii?Q?Gx840a7KpLhVHqSE1SYsyfGuwR8C+qcea9iS8StMSaq1gYr+Rh8+m38q99sq?=
 =?us-ascii?Q?gfZCUP7ZrX2zDamNnJQCvj29xjD/CL0CMVf6KU6m00Gz/xLinYwGwTdaXOW2?=
 =?us-ascii?Q?MUQh6fsfPowjgL4wqeIpx1VqWl94X2KSRPFp+WbM39chIMhUGtRw0g0CAJa7?=
 =?us-ascii?Q?mkrznVxFKp2ItB+2KgQFDZ0Sqf8Dhz6XUOPaFSNPYLcMHHQd3eb7p7ZhGwFp?=
 =?us-ascii?Q?Bj8J7T/Z8V7Gg799+S9Rzz+/cdi77wW1jiMSqYT1FbNCcxu0yQmo/JmqDKbk?=
 =?us-ascii?Q?fro1NhHxX7pYGZWlI1yjo+pHb4A9tLpJ/NQOvzlvfzuMOVBcLpKkyEqxUAtU?=
 =?us-ascii?Q?LwKr+8jpswIMygUjv1Y98n6okv1RdGZMUaSkXn/j3YsiMkHeBZYAft5Iq/IS?=
 =?us-ascii?Q?upcfvmaKFDyJLY9unOat4vwos8e10hcrWfMUg8kKiQQFih3VVFsaGmiiKeRl?=
 =?us-ascii?Q?E5nTcHcrEoiTmxOBbVk4Iwlw0wpTJJAtMxIefey0hl1Dp86ZIkf1KU/j+mvV?=
 =?us-ascii?Q?D36k04JR9lvgQRpqUc8WwUl1H3xHxYrlpe1LyZ9f32LD4tfkr+ET9GYngO0Z?=
 =?us-ascii?Q?NjTfHy/f0I5zCxxsfqgfJSSDpEIBSw2ezukbK996peqIGsDB4z+z8Fucleye?=
 =?us-ascii?Q?sxY88EIRKX9HC+X+IApyUArFISt7JIUc2BI6WjL27HzLGJzJaPGeJxmgGW8P?=
 =?us-ascii?Q?mDHb4LBO6u4dMtymgAE4L1TKznTXZyJ/wEYfsx5rJlVjiC8IFaz5bANv4KVi?=
 =?us-ascii?Q?heFebY2GQ0HIJPhX2bRbMkvNlY6hpszx3a6AiqjS8blQtSYgPS+BiTOHK0Fe?=
 =?us-ascii?Q?+hiL3/xncTn9w4kX99+qkwxauW+wnpJh/0qN1x6Jezw3gLLYhuxBDF5hfInx?=
 =?us-ascii?Q?GhrUolPIb2lUNGGplg9NvydDc0CLbCkyhNbdC5qy/XQ5p1Yi7Vx5kTm0IBvo?=
 =?us-ascii?Q?ZdClyYmvaaiRyqisj00=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:59:26.8394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 983897f0-325e-4953-2ca3-08de0776bbb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8
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

User requested power limits and clock settings are already restored as
part of smu_restore_dpm_user_profile(). It's unnecessary to call the
same restore as part of smu_resume().

Revert the following commits to drop that extra restore:
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
commit f9b80514a722 ("drm/amd: Only restore cached manual clock settings in restore if OD enabled")

Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ea27c087ecf1..183dd4138a85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2228,7 +2228,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2260,18 +2259,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
 	adev->pm.dpm_enabled = true;
 
-	if (smu->current_power_limit) {
-		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
-		if (ret && ret != -EOPNOTSUPP)
-			return ret;
-	}
-
-	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL && smu->od_enabled) {
-		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
-		if (ret)
-			return ret;
-	}
-
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
-- 
2.51.0

