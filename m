Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A725BC369A8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 07:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C9310E7AB;
	Wed, 25 Sep 2024 07:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJbqlZld";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5552910E7AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 07:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVcd2Ng9Ahtll7w8Ez2mUiO+Oqnc80i/Q0K0pKiG5p9TZT4obCWQ/YoHM92RayAIHHlCpkP+SCzMRY2nX4l58+m8a/VgDAZv6mzjIn15UGYfmJhaqs5dswwqCVy7ADOyYUkZb7hzxbc9TKWUNR8wRq+3Han9zk96F76zxb6WhBp4xRS/4K84EGvlbAZrO9m/AByJKXIgRnH3BX2CpmO4YjZBFz4oXSSInIVYPE62dH/oGRdvSHKazLeQUJwnnh0Y8S2wFisa1b70ZmKTFjBmvVQ5uXfJuWkVbEbJU4GOP3eBERcsX5Oq3jOU+Ez65pkzdcXYmKVgb2K030O2KEeNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6K/JYhGFmtNO+zuNzQ0jHo1dLDsurXNJCHlgf1GroM=;
 b=QMC4zlpWoKE7r8ZxZ90AkqwZpUIOEyG7ycqs1D4nnwjMkMLVVGPEcdUdf9cpUYlvyBvKYNKYqhXy2eOD9/SqxcR5vkLcwqQkqwnc96IfHvvkQTdN4ir2TwW/Yrckq8ueZhzpptv/F/jtW7N70jPZg3paGtc32TFsUd5PGaIaXsiUHaXEOx0qxzNhCHeSNYoxLfJJaP1ny8CguC4vuzCrPYbMlecNdJIi6rodO9ul+FR9RXR7MawCEPhRHi8SI6L+anO2EwLACcazNVd7D42qzq3NN65UuJYB9vczkF8Ni1BdSlHEpAvEcEl41pDVtshjYU94Johxn0Iom7gBqREbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6K/JYhGFmtNO+zuNzQ0jHo1dLDsurXNJCHlgf1GroM=;
 b=KJbqlZldVtC1hOg8VdFrMs8HyG1y+36dI3iqxNqMIUoEv7+oTwzxTbr5OGz5P5snuHMYk9+r4Qc74BLf56bcCXlp1s0jTKioJ4hedKLVsWDvHJACP0f5a1rN84Sw7YSy/UbZ9rLvLu06S9sApN3UO4pp/LQpPGB4qLaQusToG7A=
Received: from BYAPR07CA0034.namprd07.prod.outlook.com (2603:10b6:a02:bc::47)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 07:56:57 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::77) by BYAPR07CA0034.outlook.office365.com
 (2603:10b6:a02:bc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Wed, 25 Sep 2024 07:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:56:56 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:56:54 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>, <mario.limonciello@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 2/9] drm/amd/pm: fix rpm refcount handling on error
Date: Wed, 25 Sep 2024 09:54:26 +0200
Message-ID: <20240925075607.23929-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8844f992-2d8b-4019-1495-08dcdd37a0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0MRwEKXLUtdeZdkKG5P5BcT6UOmrZCxtM5ge9uQzLesq3bjvcghYgwyCSCnp?=
 =?us-ascii?Q?YqqlAHIvC7vHyUFuUEfAB0VubH5Th3yjAgmaLvTk5I5evDxbi5B4ttjReANE?=
 =?us-ascii?Q?uZjJmdQvO6oidVgFK3iogXvJT1vWeu2nepzGS0wG9uk/B10wsI8+2wV6hxxR?=
 =?us-ascii?Q?5JuMXRIdZ+cKhPLb9G1F5WtfskptcqE+qcGe+p2D1WerASfszO7F+nQ7fQtU?=
 =?us-ascii?Q?P0ydrytoSeRynfei7MDv5MnknBAtoQmOp2Okb1ROWkkX+aoBNGfobuIGvLJo?=
 =?us-ascii?Q?A5vYTPGnHl/5vRggSXJpU4s5liJwddPRNOQNgFqOAT+7g2BzvCh7KIVm53g6?=
 =?us-ascii?Q?zgEYhOAK0HMyR9LNg4kyJ1kehEXlslsUTidpa/IMC5tLs8MLjkN4TQ9CVp9w?=
 =?us-ascii?Q?ULT0hVCBHE27kvF+elB2bzelK01v1DuRsGQIOZcJ0aqSTv5mCbdcjWTLHndr?=
 =?us-ascii?Q?TlhaYFOVlbYU4HVYAUA9mHMrbYb62+LFAd2MXfxnSOLX0LWohSHukLp7FFaF?=
 =?us-ascii?Q?wUld7llnEJQZEPtyUbjfR++XeyYWCogVmiwoOqFS/iXOPYoeSdwQOptjfRHt?=
 =?us-ascii?Q?L8gvyT4mYeHVylCMN2andQqO18Bbchg6IOtHrS5gItLzBmgqdURoAchf4BEv?=
 =?us-ascii?Q?bmd2Hv7+UUIqtKFBKDFQfotkCYFXbirgXWw6sIiFNRgQPchTZEUOoHfY5KRG?=
 =?us-ascii?Q?B0TZfbs5K49T3iMQkzuHi8mQyG0/vkQDwhkxI795WBT+4eroMf2CY6eXZ5LK?=
 =?us-ascii?Q?ckV3w+HqNHue2wK/8wxSEqagDtHq/Fy1AxKITrvQKniCU44rSXr984j+m/Fu?=
 =?us-ascii?Q?dVyAdlRoigo5YyVXaBtGwyGvqxQFVJvvDcLXihwbyXei4/ZhA1Clo7Kt7kGe?=
 =?us-ascii?Q?OHzDSHAmknVXdctDlnbCx33RILEU3DpeEZ4iRwUVja2TQo7lRCD8DK9qca6N?=
 =?us-ascii?Q?kJlYZSflvMPH2uvEGlEXRke2fm1NlFHX3kKDzZa7OYEb2bpxD7uu6UuDmceh?=
 =?us-ascii?Q?hFOLEINIjzLdoijipK60QK9WqmoeOUiziQycEmNguhOtlGaCh6m/v/9A4Y46?=
 =?us-ascii?Q?6rGLgfZwyEg50BoCZWaSMtWto3lFBqHOl0TCycBifXLqpLDsfJbkiDfU7pMX?=
 =?us-ascii?Q?7mCrvJn+PT5AKIsVAIH/QTIZUhaGQGXlLcFXNSZ4sESNj9dgWzREmfdjCjKV?=
 =?us-ascii?Q?8YuOScNp30hlLyLO306ej8B4xYvZIg/JRfbYOpdYzKdwXUCCzdDGBI2L1OFK?=
 =?us-ascii?Q?UYxypUPKUkJ4FaTUYA9j+B4FJhlH2i4tgNK4Hd5l6bqzpSYeORJ3VA+rvziq?=
 =?us-ascii?Q?/dUhxgcVqXgJfOsATyZ6mybCrc+eKlCrIX/TaxwGzJUVmB3P2+4bnEH3C0OU?=
 =?us-ascii?Q?7gHR8T7exwDR4bWVZZl10I+mRBIt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:56:56.6252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844f992-2d8b-4019-1495-08dcdd37a0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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

pm_runtime_put_autosuspend must be called from all exit paths.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d5d6ab484e5a..485672f3d6c5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1815,6 +1815,8 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
 
 	ret = amdgpu_dpm_set_apu_thermal_limit(adev, value);
 	if (ret) {
+		pm_runtime_mark_last_busy(ddev->dev);
+		pm_runtime_put_autosuspend(ddev->dev);
 		dev_err(dev, "failed to update thermal limit\n");
 		return ret;
 	}
-- 
2.40.1

