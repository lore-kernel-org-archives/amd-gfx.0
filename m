Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12648CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 17:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2B510E18F;
	Wed,  1 Oct 2025 17:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D2FCWkkI";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD64D10E18F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 17:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrLC9zVMyuYZusOdw+wN+Yg5ngBzqz5dPdU9IfckX8nKyeZtuj/e7Q0oIaLJmK+deyN9npCfWFzvN4SRii5M9e5XkgqY6bdB9ZFv7qEeQpoXdtBhB9I4eau7/+jgjT+L8qnaMoZePP4DoHJcRSM3Os5KeND7J8YRNUnIf6/eqcduIqxLvW07agsqiZ4GFzB7pwT3ko/Bpfi6BTQ0Km+jU4j3+AUf5a9WihL8K9eQ3FnOLf3BnlyuurGzqlfwdrRGxGnRwKKh0Q4JjpWrJ5mbP4xo1DV7UTHMVHQu9t64LtC8FDzulNGV0SGcZqw4Wgz6S3VgI71KxPC+Vvk+FbYDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5RC6Q8vxqnw+vxHAjSmksmKNPSHF3IAkEvb5DWz5Z0=;
 b=tt+pNmYyIsyICxWNGxz8ympLYweYOxcWoInwr2ss8rSwnmKkXY/+7taaS/Jh8uZsYnyKvMDl5qGmSnVp16n3fZywOb9bzeJHpVmrRrTjWnJW/37km0C/pA+w1WxaAhdRnYu68YjM6Qrw1r1IFBltAKaocAMve/XS2aGHz/sbQaXghEK2/bQqikhXog2eC27yShR5YrkAuya5Gb8a+Gy50ZbKwfbFLbcLHpW1+uJdazMLb5fdFI2NhkFgVCCWqeTB63xuvJbrz8DlqX4E+A/7APSpLWYM6ZB/Coc0QL9MFMhY3DNyna6Hf+WRx7L5kgFlLM8Up94dOjDWSKrRvnIhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5RC6Q8vxqnw+vxHAjSmksmKNPSHF3IAkEvb5DWz5Z0=;
 b=D2FCWkkINJ4OmX1X2VEa++7iE79WOvmi6OmvzHbqcwekxjaUAvN2vOxV7BJOz1DS4/fstEbvxRP+kzSXTnSsjNeH7zEvN85sqmNOE9tNDazOoD0F5SmsGBky29rjr7LcM3+np2wKHHRlmM0ko9aLW84Jo9fEG8+3UuX+3lfPOPE=
Received: from BYAPR02CA0057.namprd02.prod.outlook.com (2603:10b6:a03:54::34)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 17:14:10 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::f8) by BYAPR02CA0057.outlook.office365.com
 (2603:10b6:a03:54::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 17:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 17:14:10 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Oct 2025 10:14:04 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd: Drop superfluous call to set_power_limit()
Date: Wed, 1 Oct 2025 12:13:40 -0500
Message-ID: <20251001171340.561444-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1093b04a-7e0c-4cdc-ce90-08de010defca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iNA1ApiiBUqMWeOD8HXtx3wyRdDjFSHErg5HRwbKLfjnZ3A1SBwbvBBOpFYY?=
 =?us-ascii?Q?9QRJC5AwAICZfQBnjwUGD3517IanGovQ0cSG31coRg8cOhXemuaVP7nDGlEL?=
 =?us-ascii?Q?TkTfINaRYlYTjh2JeVFzDjP6amGdayMR+J4kslfuWWwe8qZV6krDmR/j5dtI?=
 =?us-ascii?Q?XxoBHGeGoC4pmRc9fdXH2GqPiJzJBcCtQCC8FLXc3jRyX6qkUOpejaoTZMPB?=
 =?us-ascii?Q?yqjkiCEyAG3SoYrKD3oZrYp+SzZz51l6CeWDUe9bt18TxlGgPeiGYBTs4hW9?=
 =?us-ascii?Q?6tMsCm7jWRU+xvPxW3yW0qWWnBiJMLgn0I5qDhu9YCB+KgHKyuCYxpgiyJuQ?=
 =?us-ascii?Q?S6JoXr9PYiHfNMg1samJKQQJy65HYDLjRP4d6F1kHm6ZQs+rJALZoKBMiPg0?=
 =?us-ascii?Q?zB/4YqfQpXR/tvHuV9ZnHk36rRiYLgtjNBEL3piDgJKGD6HtCgWxYf2CXvr7?=
 =?us-ascii?Q?J7hVaXKooipYO1i7F8fDNPGJGB6jxcD0DAJxSwCrfqbJn1s8DotGxPq6VvCK?=
 =?us-ascii?Q?/ilgX6Kgog/GyqEdHEPzZ+kP/8R8er6Ms/Pue8uEDcfdGz+FzPOahEmUbwXm?=
 =?us-ascii?Q?ZsGev6oDmwo1RZg9m1o91CnYxVCy3+CGlFYsrARZ94YZg0L2cYBgl28ioNHZ?=
 =?us-ascii?Q?tHBXtyB6CSY1DRVhXofbTm0KT5N3tizgLo6/cTxc9yKeH5qLLk3YRRCa93OI?=
 =?us-ascii?Q?CwX5N9kcYkfUexqsbpB57oPcUYbLlRe6RsVbZjSCP9Jvcg0Iaa86tZ/0ZGAG?=
 =?us-ascii?Q?/mA6DRsbOmDSC+Ovt3W7fr+dVyRKeEMEJ1drMbIfiZDBXyQb3Tt5q8rcHdKi?=
 =?us-ascii?Q?UkyLryWRRscuP6troPt/ME4KfmUJ8o4tGXDHWLLnKPjMvA6cLNzKZmfYqq/k?=
 =?us-ascii?Q?BWJ4bcVaiS9RVNKHvQBLlK8h+POATb0gN4CxxezBq02A8/g6c5/ds3d5Swnw?=
 =?us-ascii?Q?Cw2xNY2IZvYEmNMiUsgiN6zTu81vtFN0kKSTX37SXHVMihge8jbm41I4kbBk?=
 =?us-ascii?Q?bfbTiNycEqXGSSrbTp0u0H3SRJK6sSob6aetTGifFxvLl2bPbOUNS71RGWxZ?=
 =?us-ascii?Q?7UNxbuxMW2R8Vc3rJN3YY17aLUy3rrgTTY4s3pAjtLYPirZgyFKZQbXWM0nY?=
 =?us-ascii?Q?L8kVDX2YKMM7+CWW+kw9dJ+xuwkPXVI6z4GChxtKhfHCiVbvORhxpKmKI810?=
 =?us-ascii?Q?1SBBbAMv7uVq//8MhOwYE9kgy8yHEMMBgxLTUBUCJ/yR+Al3GyQrELBon1e1?=
 =?us-ascii?Q?XpIZ2aewy4A5tS9mZbKf7pZNnIbOW5HNwtPabBfwTvy5+vSaft+qDZPpd8gc?=
 =?us-ascii?Q?TseOkVr8TuQgteij5EthSVdjWjPwyxHpweZ6HCVTXgnaVO70Q38M0Vu7LVao?=
 =?us-ascii?Q?12nRjtllQynhlD+XH54PjLwFUHl4BjcRkXCnz/si/286T1zh8m0gZXMnqosc?=
 =?us-ascii?Q?md+5BHupXkF9te5XSMfhPhd0Iv50uebEo+qNTC0qH8SnU4jdfIl0TWfxco7Q?=
 =?us-ascii?Q?TRHRQrq6M8UMitqZxlKezpYYm5wIsBs4N+6MMzoYiAk9oZUgddS5pSCHIMSi?=
 =?us-ascii?Q?ZnIMjcgwKJcVUEL8jZo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 17:14:10.1049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1093b04a-7e0c-4cdc-ce90-08de010defca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
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

smu_set_power_limit() will call set_power_limit() if the limit type
isn't default ppt, but after a bound check will call set_power_limit()
regardless.

The first callpath is not necessary, remove it and do the bounds check
for all calls.

Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ac99bb7e2e7b..431333060b72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2939,10 +2939,6 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 		return -EOPNOTSUPP;
 
 	limit &= (1<<24)-1;
-	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
-		if (smu->ppt_funcs->set_power_limit)
-			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
-
 	if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit)) {
 		dev_err(smu->adev->dev,
 			"New power limit (%d) is out of range [%d,%d]\n",
-- 
2.51.0

