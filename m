Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBDBC7115D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 22:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DC310E963;
	Wed, 18 Jun 2025 22:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CpW6Q/VV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E2510E524
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 22:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnRvh4fjyAo/wNgOHi8mc0QeT2rLsqwyRbChkuz/4Yzp0oCjPnEfhTjVfY0qnb/wRj9+RfGoQng6xtehPCA8kxDO3T7phYQwiM9dGj1fizNUTSpRAo6jBwq5BMPF6t9iEwKfdZXjtWXDvq4TCkO3V1+p/fJv2q+jXWM8wADWhAgm74ipY/VdxHq4V8xqk8J1GTaqD53CYnJxrmK85S+YnjmiDLw8DSsMbpDLPgvwFpbLt2ysef2QETgPrO2FD5NSYFh5YHghGidTSirDwOJXcD9ZZFNHGHPaGUu3lxnp1M5rtyV588rzjZ7GyK8dusoDvWoWa3Pu48SY+Ngjn15Kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1irKu/UoRCKcqM17rfjBDwqtow2X6FDp28AT8BV384=;
 b=R9TT2GAhEyBeTo6zYmRuAOzcV0LW+dJuP1dbklLtxHFMvaRCJ4uDlatNU6gPyhTyqd/Rx5kftr7lu9hYqwLSPhMzZ8I+4qxzucpW8tMcSx+CmZh8zFlB7SAQtMxXOPEWBlJ3px/0ziugD2CEpDEX1bVw536GvG2q9/WEKr6cefndczSEMBv2U0qlMJMUW/QEBuo23RpTfulmFn1GawQZk5z7Nr0/OPMBAbqoohjfr311CWLx/YHO51hADPOTosfWfGOYEx+B6DYQ2gh8H9wVqt7NsFSlZDH1ptagWDZzgQulN8YMjW2AM6sXSujnaMEnOz5QHPIyBAvIgzKqP4RRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1irKu/UoRCKcqM17rfjBDwqtow2X6FDp28AT8BV384=;
 b=CpW6Q/VVTJFV7JJH0X9xlvoPCWqB99UysBeEfZeczl6++/jElENhOzMQ7IsiX9I2b1cbyrLI3auWVRACQl1r8KMjZfcvLuSflOmyUO/rP012l+UdRGoGaRNBu0aAiPAqXflVZZPr3zfohq67LaBBjImjTHpRlOEVcN0vjxDO1Jc=
Received: from SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::25)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 22:19:45 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::71) by SA1P222CA0112.outlook.office365.com
 (2603:10b6:806:3c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 22:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 22:19:44 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Jun 2025 17:19:43 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>, <lijo.lazar@amd.com>, 
 <xiaojian.du@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <Phil.Jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 0/4] Add ISP Generic PM Domain (genpd) support
Date: Wed, 18 Jun 2025 18:17:21 -0400
Message-ID: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbed54f-1b49-4a81-1ea1-08ddaeb63aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O/bInUmFkb4iSgBrpG3tOAupzEhW8R0lfrTCFrxlvvXeNtc3dpUFv2P2Hqwd?=
 =?us-ascii?Q?z1Hw+LiLETI2PY4hoRJ2gYQoOtumCMgB1PzzUkfxqWtyXDLNrsm4ejBuWK+P?=
 =?us-ascii?Q?HkHE//kMZScuvU9XLdNfIORA7MMGyQ9qiJ+GqDvzWqKf2s3sLbuTDpRGdgBM?=
 =?us-ascii?Q?r9ehPHEawwdhCyS4CsEEgCLkcBR24XiVaJVfu6LcQOXN98xW2jDmvAvEPsma?=
 =?us-ascii?Q?VVsdeuGiSEfR2I16oIeQ4c6/3xObfIfhjxWjppY74KkVZbic560/Ejh2c/54?=
 =?us-ascii?Q?CFOjrgO9v2T/cvc6SEOesl+aNH+42hT1zc2JsgcBlH2IqPKlbQVFcvdK3ARu?=
 =?us-ascii?Q?O43cuFEOMEkUTfuhCIgYL508QRrOevL9WxyFI0JihICQAaGaSXsqPOTFpA4/?=
 =?us-ascii?Q?U9eYyenOHhkukUVoZQ07I15c2bpej2kaaOlPzTpc/Na1LVERGszpylynNLrY?=
 =?us-ascii?Q?H3CDKkJQwfLKxVohVD6U/yAxpzNVBulSUcowFb0QKKKOC5wacCjw7SGXXjDd?=
 =?us-ascii?Q?XnvgOvNmO1xcLY1NlmhaFkfgzJxoFyr8HDoxcpGGu3k6aerAfElMpCTPXxNN?=
 =?us-ascii?Q?yVDxgoSphscCzXXRT/uxWYCbulVTA6763qNkJsXqa/tKnLxmJfT1oyEK4Te0?=
 =?us-ascii?Q?ea3YJ9Sr0xTZc1Hc1iaH6gLeYjHA8hJgIb2+Y2E/oiNNDFTzXIi2g/9flqOu?=
 =?us-ascii?Q?H1FbDVyR+4Q8t/Tyv1cAHrhUzx+jUx4EgG4wUlMSmn5jMaMX4qFEkpbeKuyo?=
 =?us-ascii?Q?zntMWi1FcJCO8SViBUnuU88wPPUf+n/J3TfyAhJVnxnbkRz9rAjOArNKLURh?=
 =?us-ascii?Q?rFNmA+LSrzJV+9M86Z0xL2NU/Hl3Kxsxh/rDpYtbSoTwAa1D40CztNSYLT5s?=
 =?us-ascii?Q?gDpyqQoolJAIEKWDj/kYDsRBwJzm9AqLy0HUH2BjiRsYJ2LegaamCUJs7mq6?=
 =?us-ascii?Q?ADCJH7Yh5jmoHzPfArsJbRRrUOWVCUn1tvzLWHO1xIJcNFk/9d3vc2xET5ZC?=
 =?us-ascii?Q?Wb3ddxQbC6Eq18GIN/FlFxWeVLu/enSiTlo8mCYAf1GLwS6UmeuGVkR8KZJJ?=
 =?us-ascii?Q?IAnbd8mytZhtrXAZLQP5zpSz5YsFTdnLauvZ97W3+sJ1ktwK8TtlZrsynSFH?=
 =?us-ascii?Q?XqDfVgKOPaprt8qemCqLHGtAi8zXSJFO3sXe/jJcc26diVAoYEep2Cz7kdbc?=
 =?us-ascii?Q?4iWIeqMly0FY3xvJRmqx5Zs+b+oCQar0ccHYZMT6BpvCYO+dEIck6zSKDGEv?=
 =?us-ascii?Q?yU4snM0JLoXoOza/WtVNLALrBoYX3mUAFTI5YZNMnYnYaazey5XYMLUfefPS?=
 =?us-ascii?Q?pz2JiUMLSiOdNzL+CrhIZI/HOJ4TxsllpO7IVRYe3jeQZRFmT3tMm8FCTJEY?=
 =?us-ascii?Q?CsU15lVC+rWKjwTAPlDe6u4vnN8rUvm0XjFr4ZGALUR3HqsKSly+zEI2e6bN?=
 =?us-ascii?Q?PmtP/91lglUEIFEEWttY0zvcYXlogvNd1RqTCl3CFb48EXkt1weZyfcztvmX?=
 =?us-ascii?Q?hgB7jEsekFN0AJXthMWNnfgP74/7ctVLgncs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 22:19:44.7592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbed54f-1b49-4a81-1ea1-08ddaeb63aae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

This patch series adds support to control ISP power and clocks using the
Generic PM Domain (genpd). Its required to control the ISP HW power from
external I2C driver to successfully probe the sensor device. Instead of
using an exported symbols from ISP driver, enabling Generic PM Domain (genpd)
support in amdgpu_isp device allows its child devices (amd_isp_capture,
amd_isp_i2c_designware) to set power and clocks directly using PM method.

We need to add support in amdgpu_smu as well for amdgpu_isp device to set
power / clocks when invoked from genpd. Though the below SMU messages are
defined, the actual support to configure ISP is missing in SMU interface.

PPSMC_MSG_PowerDownIspByTile
PPSMC_MSG_PowerUpIspByTile
PPSMC_MSG_SetHardMinIspiclkByFreq
PPSMC_MSG_SetHardMinIspxclkByFreq

Added support in SMU to control ISP power / clocks by updating the existing
amdgpu_dpm_set_powergating_by_smu() and amdgpu_dpm_set_soft_freq_range(); and
the underlying SOC specific SMU implementation for isp v4.1.

Pratap Nirujogi (4):
  drm/amd/pm: Add support to set ISP Power
  drm/amd/pm: Add support to set min ISP clocks
  drm/amd/amdgpu: Add ISP Generic PM Domain (genpd) support
  drm/amd/amdgpu: Refine isp_v4_1_1 logging

 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c       | 173 ++++++++++++++++--
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  15 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  41 ++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   9 +-
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   2 +
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  60 ++++--
 9 files changed, 264 insertions(+), 42 deletions(-)

-- 
2.43.0

