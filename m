Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1552EE7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 07:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE76B10E11D;
	Wed,  4 Dec 2024 07:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pspx+vuk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F4510E11D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 07:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCLp8JLpOfV/Emb0tURkkCJB3xvvoaHfRukg2Mg1rCOXHJJQrEwD4tayK/oBp7BJQ/YW/MfJN9I4eNKNfcxMCFZJq8sfTEZoMQ/vqK0d+fkJZIg0ahNkrs84fYipGjlobW4pTyYHVa6hrqMs/rb7ihvAYIjMmgFpALc4kWhON6omNa9cfAwz1wujzsjKzKRFbDGMHu0DmYB59J6dtfvwJa2AyujaG4avTHLSXhgvblWdx3zGoQvoZTd3skwobvfph7vYylWO6vSayO3fWKXeG5dVWRHEIc30PsIYM8/dK+9QtZfweJMMlCAK9Uh3a33flCNCP89+B/ISCFQjNRqG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU0FQZpg7taYGmLmnZCHll8U9rKG9cVOyczvSpe6dJM=;
 b=Jxu7gk2FVXtZx6EyBOvK31jSowxIocngeGwrA1wFSUv6c15fyHKM3YrkQdqTN6GUer5+52/oEpDSDN39z1UN8UQG2kFspXWhUmXkmZtdbVYi7YFb8tMdkQPU7szo1Vuc80XQXYvHiW5rq8VRDr6zPKVFo3Ntpd+rtsbcl6WTHEy7TkMdatTKsQCZlBZj1xtfCno/M5hQQ1TDeuXplVOuO0rDL1OyigVEskxyd3kQb4DCk/KC4nUyLI27mt7+6mxD4Qaaj7jSwZlMwf+NFBq69Px4z5dX84sHGn78BluTrtKbB3oGFnA1Sz+8MjtuhbbeUmgsrZHLz+qR0EW6pGlvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU0FQZpg7taYGmLmnZCHll8U9rKG9cVOyczvSpe6dJM=;
 b=pspx+vuktomG0m3DJliVtQdz9E0ZhknpVTQ0cW1dQMv8YPIM7o6wpqONDVYkcITGnT3yx357HRr0pBN2XDpJM7trjoEfvW18iXw/sRzYRx9M1IccAUu3DnJLtXJNXA1E8PcTXBndLAymypGaj2UNTHn1ISBQUYdo6mVbNSIHvZQ=
Received: from BY3PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:39b::14)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 07:03:50 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4a) by BY3PR05CA0039.outlook.office365.com
 (2603:10b6:a03:39b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 07:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 07:03:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 01:03:48 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 4 Dec 2024 01:03:47 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: set the default workload type to bootup type on
 smu v13.0.7
Date: Wed, 4 Dec 2024 15:03:46 +0800
Message-ID: <20241204070346.1295087-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0e0621-ce64-4182-304a-08dd1431ce14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jFLSEtC9/a1v+DGHrA4VmVJQsOzohXiwrpQZ942Pvg2a24WeRRsGtP0ILxss?=
 =?us-ascii?Q?ZvkHaWV+6o9hUj8sqill7LxKDgC2qzEpfmKbgbXvSVpgXPErKz2+Y91JuTXy?=
 =?us-ascii?Q?8UQUjFQKC4DdfATLwCOFYaQYjZ0iWBZZnnrgWo1CBBtmxDB+f78Lort806oD?=
 =?us-ascii?Q?ckbGv2tG1xXJJZbxoVAFDGE3+W+SCSj74wbQqlx1j6DwUxDD7C8np4IoICnK?=
 =?us-ascii?Q?PET4d03AkQv3wah2qBFCZLq663iGbyrC0czPmnsvZ9R77zhKPW43XqRcYKtS?=
 =?us-ascii?Q?IWRMWwUKtXPqRDA09nw+F+SsEd/eQ+7k/evqVvge8z646HNR9lEt+DD6ao9F?=
 =?us-ascii?Q?cLsc5RTN4KU9vRE7Lu4uEJSfmVC/HI3WQ9ie/E/14hCwMt1SJ5/HNJQ9Tmly?=
 =?us-ascii?Q?twE2p3PbNlhvz08xM8eVgeS1UxARLrwslBbRpTnfVS9yf+ZS2sge+YvlSvfN?=
 =?us-ascii?Q?sT7zo56wmZ8AB3wcDxGoL5ZN16Ytp/6fRvClSvtreVyOfk4VUt5tJq0PKEyQ?=
 =?us-ascii?Q?NECvyTBwR9pFVpizC7mRUt02wa353CuDG2IX8LGUf2m/GCI/TdDCn+FH5fHN?=
 =?us-ascii?Q?hf/CpdQr3lRVCSJicpJm9XRj9aDtl1Wreb9FKYGSWBVwRIPYeDbLDI8jWmZD?=
 =?us-ascii?Q?NiM416jiguK671DG+BS7csn/jEo5H+DSmCL/4xiV510I4OpR6VzgkI2hKu9A?=
 =?us-ascii?Q?TKNw3svDAHtDINKprriXVSU170/8ICJoV8lin5fP58+qz5sJyc3MKbGBKqhj?=
 =?us-ascii?Q?WSU3/H/lYT6Z1N5dUKebdgNsiPUIehaM2BFRK2/bN1usEMStZvGzjobr4nA7?=
 =?us-ascii?Q?1+C/cIMwRMfRh8BQTOUOYHMQBli3N25pSFWHEKawH445eploOcFd/IILM11j?=
 =?us-ascii?Q?fH0vqCWZCqdeIL2WQvIzhmJ2PyizKwe6SMwTeLXvPPi4bkx8/PZy5WCYNM+J?=
 =?us-ascii?Q?GGvl6/iHPTrvRGiT+uX9G6lexL/XJKWhvu/ri7kLKjLz54EDrYc2VX6ldzUu?=
 =?us-ascii?Q?z8mtCyRNpwYsKD0n5kSiv2b+hEF/5MiXcNqwOQv5jysE5sT5ZwMAAu+5LhGC?=
 =?us-ascii?Q?HS2ceDeo6ozUiQBDE0+7cCwqv5CTsyLOdBVrw8s4BNjpHUsgzjrmxUXgpwHc?=
 =?us-ascii?Q?Pxc+/qgWPIITZb7S/vqpVzp4jY5uTkVzAXf/tIdb90LaNnslObeBpP6rx1IW?=
 =?us-ascii?Q?h6Byzi8n8yu70n1KuOZrINoFVdrbPSfnJEop5390YYV40ldooNM96n2W1P9M?=
 =?us-ascii?Q?MmPL6pDDYn0gn0BdTMW0L20zloZEMHx54LM3VNgdPeMUo1VFYQhQB+g9cATN?=
 =?us-ascii?Q?XiIaS9bz5RzrJdY4YPrlJYO14rpJbxAtgMZEXoyH+ofEIUML5l2BcZNj0KM0?=
 =?us-ascii?Q?hz5yVN/hPmHMknBIxUP3nk0LtwkiIMG1AkpjN954MqRBXQ8XTfDpm6HdBgbk?=
 =?us-ascii?Q?k7bw1bPtjoxsQYBcvcL+mRgJ/6zp9rQJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:03:49.8142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0e0621-ce64-4182-304a-08dd1431ce14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
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

Set the default workload type to bootup type on smu v13.0.7.
This is because of the constraint on smu v13.0.7.
Gfx activity has an even higher set point on 3D fullscreen
mode than the one on bootup mode. This causes the 3D fullscreen
mode's performance is worse than the bootup mode's performance
for the lightweighted/medium workload. For the high workload,
the performance is the same between 3D fullscreen mode and bootup
mode.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d1bab508ade2..c8eecb54a16d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1280,7 +1280,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D) ||
+		amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 7))
 		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	else
 		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-- 
2.34.1

