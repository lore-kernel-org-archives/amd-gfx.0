Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0954AC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCE810E554;
	Mon, 13 May 2024 09:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mf2SqGU8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07A510E554
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2ySOqNyA63diY+wjGuzGWMP5nDIjY2k732nwMKY4h48NMxi30clB/RUn0AcwhKZXlroCmyJguaEUOPI8AI6sNwV03YKqfoFkUxzBW12XhXJgv0c5N8fK2hr4jGTwPsXWEhKBU37c8eyIDYSa3q9HRiPmymwFY23oylwm5P633LvgNkGx8o6gBoAX3gmW0QXuCJpO0S4U9tC+R/3HEj8AvvD1KJ0nZqGzFqnTudBM3NLAzNs0Ww2S4GXr0/vF7BIx9a4R881XklR0w5dPtimI/gvKh7DIcmo24AGa4mEwwe7JAx89iz5wD4AAcaE12VsP82nJjKIVAy0Pi5WXW40eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCwRuxYGJoycPRaIEoYR3y79BXP3GPUFfPAFUecniH4=;
 b=i+W90uFXJTzcEowb9yzWhP332Smu4X78kla+gEZehZEL35b0MY6iPa4mW8o3ZnAWFcECxg5Fc7/vUeFLhJBQEpaOZuzStUWZj91LA3HpkiYU/5EG+/pOyVMFkP450oJ7ACofhdwMXPGCope/VX9zsne/HFZGNyI68p2U+HemMDG0ehpiL4CbURH3k9FBugCnWvHpI8k/mxD5eobl3+zj4jK+teqLacAvcwSyx3M+ah+piD63qi8CPzEUV68bFqNkG4OPeHFK6NUARi1BvPWkp3RoVqLKuqV9AZ2nmpkyBlZ0okQjfTHj6zHUB06sX7SS4K/qT7BfBUba7+1q2l0g4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCwRuxYGJoycPRaIEoYR3y79BXP3GPUFfPAFUecniH4=;
 b=Mf2SqGU8J0d0pa7MqYRK1eCil5ZJCHSjF2c3R7NHO2I4mHXc0dT9yxYzd5ysRfso6ri0JpHTVoGnQFVX9iWIkpkolHvEMMa77V9MWlCIM3lxhNUbPm4vzCbKQ7yoDivj0urvPz11NkoKwan2l0Q68Ovo9mZkFT8NnCZh+UItodI=
Received: from DM6PR06CA0019.namprd06.prod.outlook.com (2603:10b6:5:120::32)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:28 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::dc) by DM6PR06CA0019.outlook.office365.com
 (2603:10b6:5:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:25 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 00/10] Add PM policy interfaces
Date: Mon, 13 May 2024 14:51:01 +0530
Message-ID: <20240513092111.341168-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c9195f-7898-44b6-ddab-08dc732e119c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2LPYiLANI72rZIwDmuocnUMjhq2SWZokCjDx13Y+PknvLFSqCXaCtgaQRiRg?=
 =?us-ascii?Q?gXqJ+wiucQgqU5+CEJuMc56v8AeKRFQEmWvuYHB8q14QzWj1ibUd9JWCrV+U?=
 =?us-ascii?Q?AJyVHBAoVb57fvTovhL9To/gnFUJE4oa0NmOAfxPKyMMWKlgImsYxQelRW4L?=
 =?us-ascii?Q?u2Ps3yQPQlX8HJVYo9G4nqnypWuowrwuSEaRgJQyhF+ec2pPeD1i+HrdsmC5?=
 =?us-ascii?Q?CPB4Ah1GJNuan8xdE3iOviK8J/LiwFwB/ZG/sPgmoOw8tdqXEXd0LaEU4VVE?=
 =?us-ascii?Q?Nzb2eEd6Ef43RUCC47EjSqoJdANalJZFR1xlAPf13K1wTrB4D+iezy5VGoKl?=
 =?us-ascii?Q?V0HxcbLJhqTq7vhBszayZge9TvgS2GwycblGdyculWc1RW9TRZcGqPRSEMqd?=
 =?us-ascii?Q?NdGaNFA84LSiHq49TOg3V01CFofwt3TEtflHmcNwUvNxW6xzTBnowvE9rUq+?=
 =?us-ascii?Q?FikxbHEB8tBT8BLR5ccDm0FnoMliE46t77eojZ0a8olNWGreNjdcSZRta+Gy?=
 =?us-ascii?Q?PYjGOAhAPmSR0OlBHbTkUbVxQjIC8L7mcvEhOPDwyYBLA+UC1bNmwkxuMPOf?=
 =?us-ascii?Q?OcoTRN2HPNdkwSr7o2GLeDD/PonNd/bge9MQQ8XLe2jNux3yMbrD7Q4FyVk4?=
 =?us-ascii?Q?F1B6LVXhcyYkA4g/kA5O+dpkVdB2dH5WXifVGnWFt3orYCgX9JgkxSIT5mGD?=
 =?us-ascii?Q?xE7lckLlBVW4hdCl8IOBSY0LiNpovqOxNlnGKSAKxGwLwS+LS3yjbCikuU3B?=
 =?us-ascii?Q?l3s/PcXZpooY7rYd71T/hAqmASB77cv9pYdvXwFxvNFlhIp8D9Y+X7oaeJnC?=
 =?us-ascii?Q?w4tfSOjb+2x9bn+9XuZBIOhwSwTYKC1Smpf6+CKztoqZHFcAP6Nxe3FQtMF8?=
 =?us-ascii?Q?hDq9C1AYj/N0RpyEMugjMYWoWRmgWWVYBiw6WQAoaSF4ExoeqLwWBfRHtWj6?=
 =?us-ascii?Q?gxjGsDKshsoRftR2nTAbmjBQYe8HbYpOsIxfr1CxEgVBkY8BbjzA7YqClDsy?=
 =?us-ascii?Q?DbM/eTMnjpJDY3sfHVkyoEdTtARV5xVkHq+N39Cc5DdtioVQMCe8ML4C5N9S?=
 =?us-ascii?Q?qqbfrYVRrItTzWH0iqQoMHTGKhFo4SnTN8B/jGZFz1RJT/8roSDTCqVQh6Jf?=
 =?us-ascii?Q?1X9COQV8XSvPX/XLDYpXt4JhyNBwQdeClFDPRmVgBqJldLEs2fAi2xzZWSqI?=
 =?us-ascii?Q?9gDSJEVIcBwjpPYqLfv92BOwAm1RFyzk8+Z81rGyZSCjl7kTBrI2p3oPhQ8v?=
 =?us-ascii?Q?Sl2fTj73aX3if3bFQKhXqBbEnwWaXuL4QwqDBHG+0SABr43UhYAEYlO1plop?=
 =?us-ascii?Q?veHJPz0y9kLBoP1/lxx7gmTFbyJ4spwqTRplb92QiCWI7k3FitY5s5Qz4hSV?=
 =?us-ascii?Q?G9WyKKA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:28.0169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c9195f-7898-44b6-ddab-08dc732e119c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
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

This series adds APIs to get the supported PM policies and also set them. A PM
policy type is a predefined policy type supported by an SOC and each policy may
define two or more levels to choose from. A user can select the appropriate
level through amdgpu_dpm_set_pm_policy() or through sysfs node pm_policy. Based
on the specific PM functional area, multiple PM policies may be defined for an
SOC For ex: a policy may be defined to set the right setting for XGMI per link
power down feature and another may be defined to select the SOC Pstate
preferences.
 
Presently, XGMI PLPD and SOC Pstate policy types are supported. It also removes
the legacy sysfs interface to set XGMI PLPD as it is not used any client like
SMI tool.

v2:
 Add NULL checks to avoid access on SOCs which don't support any policy.

v3:
 Rebase and add documentation patch

Lijo Lazar (10):
  drm/amd/pm: Add support for DPM policies
  drm/amd/pm: Update PMFW messages for SMUv13.0.6
  drm/amd/pm: Add support to select pstate policy
  drm/amd/pm: Add xgmi plpd policy to pm_policy
  drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
  drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
  drm/amd/pm: Add xgmi plpd to arcturus pm_policy
  drm/amd/pm: Remove legacy interface for xgmi plpd
  drm/amd/pm: Remove unused interface to set plpd
  Documentation/amdgpu: Add PM policy documentation

 Documentation/gpu/amdgpu/thermal.rst          |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   4 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  17 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  32 ++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 133 +++++++++++----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   9 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 113 +++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  37 ++++-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  64 +++++---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  59 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 153 +++++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  57 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +
 17 files changed, 527 insertions(+), 169 deletions(-)

-- 
2.25.1

