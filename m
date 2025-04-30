Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A9BC3ABAD
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 10:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DDC10E721;
	Wed, 30 Apr 2025 10:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Rpf61Nv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAFF10E71E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 10:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FawtFdxMUrYY/TQ86Lil9zV1EWdy6Y5AU4vnY4M4z3qG/visfBPokw7tPPq7UtGn2+EV817z75z4oPSA/kaiugp7e6Lxh4NYLK4jWdOxDyVE04CWZ+WyIuqiTqfOo7Gs1afznD9RvdFZW8gvFAa4KDeOanYzuZqvnWEtwQ9UC1sbC7ieToU5jvlBpAmV2sIt6Uo7epng71NTxtkvTPf2L39neqKUhB22jNlb86ycPWTBKqWzrc4UX2cPa5+4IjGpOVLKKcEynpn/thLh1/T2vys3Ne+5Qqp0vBXsACVGsL0xl8Im6yGvKkpWdvlca1Avd2xnRb9Ve9Pp6brjZbHLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrOSHVorsjqzhNIAAf993oSGHkULdx8+8nYVLKUXzi4=;
 b=TqKs354KOhSuFnzR4KJA8uJHY+DcCL/2PfvM64Xda1GWO1IvYI6RHh57jzLG21xwDWrXpDNOSdpAjERU7v/jw8JBPosI5ZcSpJmFW+QqFDDET2mMDBO51dDuLhw9AgLU64/JDRPlOAmeobhM7R49TfcpWDZQe5Zv8YM9EapdM6sVpCPpGehDIKFuF8AjBkvHEqVYlLM/9cvHtsshd19wzsFxJR/n2C6zJiEVUMKE5hhxNwyYWIhR+m5L/UuO1Q0xZatsEQxpby6wU3kxgMlRQwim39ZhCdeD4QMrCZU3dWdv43VPe1WxScNYAlunJtqBq2RVctPMXPwl13Z/24Dbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrOSHVorsjqzhNIAAf993oSGHkULdx8+8nYVLKUXzi4=;
 b=1Rpf61Nvt6tYolyMOcKEU3m8HYsjkn4EMKqAuFhB98Uo5iSYzqwTgmYP45Ny+qYze1KppP0A2qVibgBDxQgdZvKLMwKNIInos1qDAp1H6KwEtHhvZh4BiSro5a+dUtg3BtCm+nedEjGuQbfQkk/o73zI8EG+bXTmo8jbw848284=
Received: from CH0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:610:b3::30)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 30 Apr
 2025 10:18:37 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::50) by CH0PR03CA0055.outlook.office365.com
 (2603:10b6:610:b3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 10:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 10:18:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 05:18:36 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Apr 2025 05:18:34 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH v2 0/3] enable switching to new gpu index for hibernate on
 SRIOV.
Date: Wed, 30 Apr 2025 18:16:35 +0800
Message-ID: <20250430101638.649274-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: a42435c5-27f2-4899-54b1-08dd87d05ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TRfYfeCl7QI9n66aYW5yD7zJqxGXkZ7fkeJuC6JZc/tWsvY2jW28jyo9zLZ2?=
 =?us-ascii?Q?ktiJmvDgnslkhLAlpuV2hABRyEuuYKIGd+jUOceC5JoyH8Ug8Hznr0u/RwiA?=
 =?us-ascii?Q?8n5w+NvYv/uZSPXXexzWfy5WFywXFWL88x3SMV6UMTer+LO9U72p1jrpsT3e?=
 =?us-ascii?Q?sUzEo9voZ1155iA9E03JD1Qel+oFZSq3vP43O82VBpVpWWLV/gRIbFtm7uuh?=
 =?us-ascii?Q?3r38Nfkzg7P1bSyaYu/UcRKy8enXza57GEBK56A6u0qkubJDjKCQBUgo+Pmb?=
 =?us-ascii?Q?fgNmMqKktsc8jeWbNy3fjfGzWMg65fBJHi2wqohEDHTKG+RWQeoaIs5gkxUa?=
 =?us-ascii?Q?q930rhcLsAU6ZY928y/IvqT3HVmjDhNKj2hGjLXJ+SloNG0x2ykLlzgZcUJv?=
 =?us-ascii?Q?go2yGQmomLNjWpgUIEfEXQ3ocOJdmmyTwufJ6zF764IlPuAtOiLdchezf9Qn?=
 =?us-ascii?Q?x3UALplzBCDlr6JXEsn2MaiOXSb/EJLeJLfzhcsDvEqhTPiz7fxHCxaaxf4Q?=
 =?us-ascii?Q?0LMdrr2QIfTQNkJIO+R6cpR2nm7Dd/jnBJ4SblotaZNnQLKBLnAhTP/8h2wB?=
 =?us-ascii?Q?PQOIpkd5G/fWbFe1popDbodk+OoUwfCsCN6ZoJJLQXdAUyaxuhV+PmTXbGYn?=
 =?us-ascii?Q?+zV9JzMso7ORs2d7srzg5IrFjcQUdXs2WVCj1oeWwNJWhhKiaux2cF7LlSqC?=
 =?us-ascii?Q?g1L5+Cy4kzPh2MArKwQMNOtMzjG75GcRiAeWcvUq+rfNroP/+hhiNoRD/A6D?=
 =?us-ascii?Q?mwt4C/3c6IYqHq9DPE+/zCeTiv6KeKARxjLT0LGDCZar+zg4c0GHcjcgV8WR?=
 =?us-ascii?Q?Ou+KdW5hhSSwjv4Lh7+QAIBA28JOxakV7sp76mmZWFmm8hKM35jsFms71iQ5?=
 =?us-ascii?Q?tyWZMMg4+vfGtzDug2tijAQfdf4aGt7n/4iEhHAJnsMTLLOaHKwvIbJOAvMd?=
 =?us-ascii?Q?3fUaAsfM/h030tCBH2bmrG56R4uWdtLYXBiLNkVqAd2QnDZJQ5oB/wl6QydQ?=
 =?us-ascii?Q?e0as2JN3dFp9QfLVS9LvPqM6qvNeiGVJ1nuTRAKwSmWbbXgs7sRfB7Zj1KKC?=
 =?us-ascii?Q?4oDCcS0vIdY3JBTTB2QML6dtCyDdnfLezYEj936Lj+++BxyDM0PfLFp8rKOC?=
 =?us-ascii?Q?WCpX4Sk6dhp74LFs5JFx4nTK0YKHGKvbfvXcSnBaB9COZvj/wHdou9rnjCYU?=
 =?us-ascii?Q?rsuZfG+7KCaiXy+HpoLV7zhG8w7tRzTDLyz0GQgV+E6eMI43duGF4osZbIeX?=
 =?us-ascii?Q?fUV2OCd/j/jNKkBrY2K88Ch1jbYGzp99rwRcGCEOnrpcPykbpYMO4tJs1jYN?=
 =?us-ascii?Q?wBy5tKSTrSCHTjDSkuG8ebvxWjh4ebsJivdSk4aLhGrmDu92KdbLWj2lC1ek?=
 =?us-ascii?Q?alePL/i0NS1cgC/Pc30552ND/wAFLpNZf7/Nyd+v0HbhlIpYARt+pq7l/1cC?=
 =?us-ascii?Q?Icwl+n3fJr5A+Hj/AyxrNlVAsQ1Km9C8HPyIn1+ShFnWiBDQ8R/qYyKYZl+S?=
 =?us-ascii?Q?vB59/X/mLbvB6KtSvyTrTM9xMcXPXVZwJrm7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:18:36.9367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42435c5-27f2-4899-54b1-08dd87d05ece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A
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

On SRIOV and VM environment, customer may need to switch to new vGPU indexes
after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` will 
change in this case, the FB aperture gpu address of VRAM BOs will also change.
These gpu addresses need to be updated when resume. But these addresses are all
over the KMD codebase, updating each of them is error-prone and not acceptable. 

The solution is to use pdb0 page table to cover both vram and gart memory and
use GART aperture gpu address instead. When gpu indexes change, the GART gpu 
address won't change.

For psp and smu, pdb0's gpu address does not work, so the original FB aperture
gpu address is used instead. They need to be updated when resume with changed vGPUs.

Samuel Zhang (3):
  drm/amdgpu: update XGMI physical node id and GMC configs on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 46 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 22 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 21 ++++++++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 ++++++++
 10 files changed, 140 insertions(+), 17 deletions(-)

-- 
2.43.5

