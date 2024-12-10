Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66335E77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F46A10E2D8;
	Tue, 10 Dec 2024 22:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s55nKjwn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F0310E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8/jh0xGHvaCVfDj1T+AKxF0caVOuW3gMl3/BplMb+PLzqrn+21vsZljyjVjwU1+MB/beQJMgaI0V7qyDAdzNZIV3CjD5AjQ7TlNF4SWICQDSZHI6ub/m+NXmDOrSup99fVbKhIV/2SM8kmTNYAR+v012cPAEciDFW5F5wOYDsDyDdownfdMA0XU3CieafrWbwOw9j3PwpSttGqDie8ElaCzwcSJ6+k38ZjZ4Dq2/eGxKW46srxTrnunoLU9wPr7HQ6A5iCI43cX4gaFFsjnEqERquYfjEiyll46eXJQclqC1DP2OHDbSxvBf5mxbpadtbnAwN8Z5ncJ8EOCLQEzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOqFDVfIqguVrEWmSgVfxa0F7IhH9TnOqfDkRmTTtKc=;
 b=Ralisqoa8Ru4ZZuptuKrBnMUevVbNwvFfmYloN+PaQju2EhgEE369UMuTI0LZwsw5Fj90z2mn5hvcZeZkVUrKz0XkH5Yu5tdqla8RNo/bfslqnXy5dmyzPcqiqeVx7mqwdNNsoykHNGYPr9WCqDS/nbd9KpfzQkxdsn63KZ98xeyuWMoQ88r9oPKbEKKCwTwAO5EDIDNYr4jDXb25OAzRFBsOTv9Xfay/+ui0yfWy3N+vYHCvTpgfZPX8HEEBG9CCK4zk1oXUHf1x/2rR9MNBeswlAH5c6NJ/mL5lVmrt4KQU5hlq1mvNDuPTqe0iQ41FndeakHR1MTNlpBGL2aexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOqFDVfIqguVrEWmSgVfxa0F7IhH9TnOqfDkRmTTtKc=;
 b=s55nKjwnOUcpJkz4CZglsxsaUQpe/lheM8exyQSLIr6SF1sDpTlOn4SHpszJvrilWLVoph2GetfySm5WvIz5u25LllQ5DHwtpWu3duEK2hf4uVcbYq47cJg0hlRuBSx0EV6Pj0WEMTAWmVANodeTOp8Lh8aAPcpst0+CLiKTIqQ=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 22:53:53 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::bd) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 22:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:53:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:53:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 00/48] VCN instance rework
Date: Tue, 10 Dec 2024 17:52:49 -0500
Message-ID: <20241210225337.75394-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 886cda96-8ff3-49ec-4575-08dd196d8515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NLKjVyscny88zFrqLZJHvQf2nhLLGluTUW0VpI9nM4auT5afEGunIbymw8/f?=
 =?us-ascii?Q?aaSqV/GIMOnIUss38r3t38jO+0OTRox5NuqECqfGvT2xvks3hO5+kE0Xd49C?=
 =?us-ascii?Q?YFoamaagxa1UtyoXVS7fAgFQOKG4M5A+Rox2wxHYP+4reCppzch9rQe8s1z4?=
 =?us-ascii?Q?RxkLB5s75xOBnbYz80IgV9iDM5QZ+qxXthIcEsiqFq9lyWAJ+xv0fmZ3OmFf?=
 =?us-ascii?Q?+nUvMVPjnzaJGleQfo2NInE6aJbRJEVX21r2WmnRHcPDWeWEmKAmr38VBDxJ?=
 =?us-ascii?Q?kYNQT+30TlbVrh49Li+QdOxhkE78RjrLFRWFVhtnIc9/BiivsdW94a7Bfwyp?=
 =?us-ascii?Q?sJS/L/E4sLBt/a3/tnklH1cOysPhqmGEuVrmVo0eX9Jt86wUdEbf1O5FEoDh?=
 =?us-ascii?Q?j1b1UVJCRTVbyEZcuMJjOfAQnCoE9AmaSR3mPmKkpDdZRVUCt4CN9bGgQam2?=
 =?us-ascii?Q?w3JIQGV3UxnxwJGy8TOHAaC3bOjBtKZOILsNZnYR5vUEXmLE1fq+IRXJoeD3?=
 =?us-ascii?Q?aEf8vhW2kjPM6CvK+93c0i9VhPI7EU0a+PDi6z1CQDY99/2ia01/OClZ9Mic?=
 =?us-ascii?Q?9NMYup9XWhklU/ZBJQtZzf4rh2aVKy0RUVVryP9z55h3nVZy0zqJglyCXmWt?=
 =?us-ascii?Q?aSyVLVJG0GN4xrhvyRAZJr89yKcIO6JizvjJ9EbMNHHYaDJelD2XQSIB/Ws6?=
 =?us-ascii?Q?sreNjvYZcDbyv2d1YROUNzXbbuezLl9LQfSWRluz2X+FmEXNjCfRAfaGhmIt?=
 =?us-ascii?Q?N6G2ioixK1rgnb0SRW3Kpw5sbDGosbsjhGcPFFrfWZxoMyl9BPpdDyxgxaNC?=
 =?us-ascii?Q?bY7T9wSjJ4Vt0ujV+4qxM1eTGATKdOJq5MMzLoA0upAI6P9QKpiR2fxnAK7Q?=
 =?us-ascii?Q?Iu83bYxbW+xF0sIeiUepLl8UeMMGgbGiP4uusDXJ453tXSeadYssTYYApNFi?=
 =?us-ascii?Q?IbA38yhwpi/W2MpwMFnSbZ+slbaTNLnUFhx3Is74Czc8Et8FSoiuYKbwGpaD?=
 =?us-ascii?Q?yY0bPw4Iy1l1PHg10CRGQsKucKDcbAmTNEXZxBC5K8aZzuhl1ogeJerhFxmE?=
 =?us-ascii?Q?FfFVLbslpHlgkM9aaciJruEMmv8aSMzkMevyWGxzmpMnoMLxZLgbk6D8yUhv?=
 =?us-ascii?Q?cohYLoda20Vj7B51Qu3afMfdjzo09+vIB4AP30HmDUCa+7e0DDt4HALbT+lx?=
 =?us-ascii?Q?EkbltiS37vYhoLTyLLH6zu9QAaOBny7dV/YKtqCVmnI+Ns6ij5oeYw7lmZPW?=
 =?us-ascii?Q?dwU9zTJrfYS6avcVuHpdxP/m8YyovhqEXoT0tGN/sggUP1kmPwsUoIX2MXv7?=
 =?us-ascii?Q?0Z5zlH4DO7OpYmrVYzx7a/F36vn72GZMlRvh7L4Q2CZHN9MxGEk+JacIEyRc?=
 =?us-ascii?Q?PdNWPQSlYXLu1XTsTEirYx8CHeYEL0bOfy3UX3Rn3sdHpXpxag=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:53:53.0746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 886cda96-8ff3-49ec-4575-08dd196d8515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
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

These series reworks our instances are handled
for VCN to better split the state between instances.

This allows for per instance powergating and opens
the path to further splitting VCN IP blocks
per instance in the future if that is desirable.

It also starts to abstract the IP level instance
handling so similar reworks could be done on
other IPs in the future.

Alex Deucher (48):
  drm/amdgpu/vcn2.5: split code along instances
  drm/amdgpu/vcn3.0: split code along instances
  drm/amdgpu/vcn4.0: split code along instances
  drm/amdgpu/vcn4.0.3: split code along instances
  drm/amdgpu/vcn4.0.5: split code along instances
  drm/amdgpu/vcn5.0.0: split code along instances
  drm/amdgpu/vcn5.0.1: split code along instances
  drm/amdgpu/vcn: switch work handler to be per instance
  drm/amdgpu/vcn: make powergating status per instance
  drm/amdgpu/vcn: move more instanced data to vcn_instance
  drm/amdgpu/vcn: switch vcn helpers to be instance based
  drm/amdgpu/vcn3.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn1.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn2.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn2.5: convert internal functions to use vcn_inst
  drm/amdgpu/vcn4.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn4.0.3: convert internal functions to use vcn_inst
  drm/amdgpu/vcn4.0.5: convert internal functions to use vcn_inst
  drm/amdgpu/vcn5.0.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn5.0.1: convert internal functions to use vcn_inst
  drm/amdgpu/vcn: adjust pause_dpg_mode function signature
  drm/amdgpu/vcn: add new per instance callback for powergating
  drm/amdgpu/vcn1.0: add set_pg_state callback
  drm/amdgpu/vcn2.0: add set_pg_state callback
  drm/amdgpu/vcn2.5: add set_pg_state callback
  drm/amdgpu/vcn3.0: add set_pg_state callback
  drm/amdgpu/vcn4.0: add set_pg_state callback
  drm/amdgpu/vcn4.0.3: add set_pg_state callback
  drm/amdgpu/vcn4.0.5: add set_pg_state callback
  drm/amdgpu/vcn5.0.0: add set_pg_state callback
  drm/amdgpu/vcn5.0.1: add set_pg_state callback
  drm/amdgpu/vcn: use per instance callbacks for idle work handler
  drm/amdgpu/vcn: add a generic helper for set_power_gating_state
  drm/amdgpu/vcn1.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn2.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn2.5: use generic set_power_gating_state helper
  drm/amdgpu/vcn3.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn4.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn4.0.3: use generic set_power_gating_state helper
  drm/amdgpu/vcn4.0.5: use generic set_power_gating_state helper
  drm/amdgpu/vcn5.0.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn5.0.1: use generic set_power_gating_state helper
  drm/amdgpu: add a helper to get the number of instances
  drm/amdgpu: use new helper to get num instances for VCN
  drm/amdgpu/ras: use the number of JPEG instances
  drm/amdgpu: use new helper to get num instances for UVD
  drm/amdgpu: use new helper to get num instances for JPEG
  drm/amdgpu: use new helper to get num instances for SDMA

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |    3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   37 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  455 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   43 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   17 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |    3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |    5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |    5 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |    4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  190 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  213 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1033 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  658 ++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  661 ++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  611 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  644 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  588 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |  499 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   12 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |    2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |    6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   27 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |    5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |    5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |    9 +-
 34 files changed, 3075 insertions(+), 2735 deletions(-)

-- 
2.47.1

