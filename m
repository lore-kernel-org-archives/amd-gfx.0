Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC513D65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D46310ECCB;
	Wed, 17 Dec 2025 13:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="owuL7iQe";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC65510ECCB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ2YXaCCZhNjmJ3OXo/Qjz9EOlyaikr9YG3yjfB03OZrYfmtGXS9VbAGtIEvDoPLs+yZ3OGcd2Li759OEuk+a6heOILePLl/0ZGiu5x1+HDHPMedaHbOPQTEXhXdNKMCycbPGJFOIdIWaCvFzfkFPmNskj31uiUEeeXZfJCF/EpDhbJIZNJ7qA3cbp+W6sF+rkjsTWihiYRnLoekcao6/+bVvqcDuI53JHIZ0XkqZPSLNvh2k62+oCJ93vi2mYaJpI/AAo2/YWKeUf2HCfcOHtLYfJxVxtoHkoqZZRAuMXtVZFsB7aNPXkoqlKbgVpjfRXJNQsNjf/QL4ZuWUkEzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Z56CxqM6p1rAnEQ7Kh4/i871mm3Wr5yAkK4u0ROsI4=;
 b=on6TE62uLunqFvcoB2azP0G7ur5I0B4XkMnaqCb+dF2fXh3Kamn1RWXkYwwOhBx732SIXgNG0qs2Zg9lMSKgINH9GkwoyCfXtySlZ5DdTTT0d4vLgu2LOObG01PTzMSwJchFh5dm6f2lVXh2/No6zDn5ns5r0uaUC67nJ06ew1624Z8yvWnBWoTZ80SxN6OiwQMBqiXjH2tqKm7O5Uh4C43VZU5VIwMqtRxNS45c6AarynrshU7eT4KNSYdlv0sVEL9+A7qShsY0jr1vGqB2AHc4eHBeZhd3AtXWQCNQzk5Vgy9DfUWrMHiUWE7hePNNCnmGK8GFHsQeb1W29sDaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z56CxqM6p1rAnEQ7Kh4/i871mm3Wr5yAkK4u0ROsI4=;
 b=owuL7iQeDtNGor500rQhdwxhGjxIbglMYktUV31iyrzTHfUnTmrjLg6iIorgZ6t1vfXIzDcHZuug+HUu886Qog+77Ss3mAyh6GCzJ9r6FT1EPoPwT5gbDl9HVA1jTNuGPNbnUK3CyrnRjRn1ddZyH4qZ3A/0/iGY/d9GLd/HPBQ=
Received: from CH5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::11)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:54:52 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::fa) by CH5P221CA0020.outlook.office365.com
 (2603:10b6:610:1f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 13:54:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:54:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 00/21] Add smu message control block
Date: Wed, 17 Dec 2025 19:17:53 +0530
Message-ID: <20251217135431.2943441-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: bfae200e-c2be-4d13-be07-08de3d73d9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6lOp503EWbCB9ysohF45pP0mrXogGirpTkEFP0Jog0BX8sjEzu3wa2mDhQbi?=
 =?us-ascii?Q?LPCl6Iw+1tz1kD+QYiDNboawPc+36RFGyx1mODnPelkK7shXZnCWGaFwcAo8?=
 =?us-ascii?Q?QVsfSVnufGXsEfsgxQpbq8IOTW3qzL+r6CUtVbRf4z1E7bUbNJmk25/HtY3K?=
 =?us-ascii?Q?2Y0egp5QvmYhPb5gNlIchZMAsCWGJEyRclzmQWAY9QSmYVD/57WDQpRUK7Pq?=
 =?us-ascii?Q?ngRahjICK+pmJyqvm2bhMQFBD8rNP08/bdOMIUQyXEDA/zILwM1DTG2n4M86?=
 =?us-ascii?Q?O0Tig8hTDFdSCHtb1KWm7lx+jt12aq95ptc79uwlpqKd2H+mxnRSJ8TrTIPp?=
 =?us-ascii?Q?WV8tzU9fr4qkf+SVy09CirFzs5zL0UMBvY8IjIcT7dAC+vf/3TySuI8mkzTd?=
 =?us-ascii?Q?NeV7xWIwSDkGy78NWnNtCFCuXq6auFgl1x37YC+aEWobgRAC8zKv++NAv2cy?=
 =?us-ascii?Q?a/8LJGCQZlyzf7QYN9naa5wjWk3TuzoLmNFl6mSF42eHyaPOc4t9QRxJMoIJ?=
 =?us-ascii?Q?9LEVHSEeWjFqN7UMy7/3omhr/yIIlIbm0xF1T2xHQunrl4lQFlU148iC8GER?=
 =?us-ascii?Q?fPaBvoMMIhQCZdrbSghssoXNCQLlOhyt/o8zv+cs7ITszo2/BURfPIlnhb+b?=
 =?us-ascii?Q?WJD+Fc5g8XcO6elBV2Rd7tGWZqiRFhIy0ZMcROvgpRPLGrO3GjYwr2AO1U+r?=
 =?us-ascii?Q?X3vHf3Xbr8zfssnoHdR75aCVf+gCX1YapE0ft18YEB9neRFdfJ9H81rF9pnC?=
 =?us-ascii?Q?Y5V4ycojmhBcoaaepjv2D94LbMIIhzdlqUa0SGdZI4d+KWEOI8Mnnygnnpcz?=
 =?us-ascii?Q?IyGteX9NVY3qnvQPU2Y7Uczhm8c1jB6ZUOEgm4dsqQYDdQC5SLSKWtxdGUd+?=
 =?us-ascii?Q?PZxgHpC9lxlmbt26wPuf62VmU31B7qVHDZnbSfm4CiGMN88DJgniSq10w9OR?=
 =?us-ascii?Q?D2CPg5N7/LBgdQtqzYrq+/p3zoVE74ikhoB4rs7Dx1U9XS44Qloh1UlAAZJu?=
 =?us-ascii?Q?AcqpYSSFeQuMHd/kCScMkrjbzvvYGVl+GSuTgs/D5anUn7Sw86hCQiwI4sia?=
 =?us-ascii?Q?tCfCj6TGoP5kehS8D+zHEI/PitlbLmsg/ER9kv5Z4a1ZRDKPaPb7Do6O/N2p?=
 =?us-ascii?Q?juZkuyLl9Go7LTdEi2tD174l1K17GBzJxTjsDIfLygOY4/RipN6T5m484EVe?=
 =?us-ascii?Q?72NsjaGDNB6PR765Q2UnvYvhcGN1IKKP7rVLlb37CmzRkOQf7VQVqBYGZnKh?=
 =?us-ascii?Q?Y4xlupf0EreD+JWW80sGApGtMCA2VeiPQIdxDWEG+iBgF7+EAYKSis17xPzk?=
 =?us-ascii?Q?ts8S7n/9qXOObuPU1efmRpeYQxcqi1kUPRbuMYUceGoO9+bNGjSTGlmZSYHu?=
 =?us-ascii?Q?eNwnwU4vkabBEGhoEJl4WTLNK7+C79773XfmaZ+DiFFkHiTw/INxqzdetgR6?=
 =?us-ascii?Q?0q/4nuJ7vqSdByjZA6LIgFUEJKtqCsVwe9F3r4Nzyzhc5RHfzcuThECfBRgx?=
 =?us-ascii?Q?E5vEn+wcbR2JrAmIUop5MHGcsb6ux/fcrEn8gxWfinK+Mb8W1V4dmIlr0Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:54:52.0390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfae200e-c2be-4d13-be07-08de3d73d9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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

The series adds a message control block to take care of driver-PMFW mailbox communication. This
helps for individual IP version to have its own instance and differentiate if there is a protocol
mismatch with the common one. 

Message control block primarily contains -
	Message config to provide mailbox register addresses
	Message operations - callback operations to support messaging protocol

Both may be overridden by IP versions for any custom handling.

The legacy ppt callback functions for messaging are removed as well as part of this series as they
are not used.

Lijo Lazar (21):
  drm/amd/pm: Add smu message control block
  drm/amd/pm: Add message control for SMUv11
  drm/amd/pm: Add message control for SMUv12
  drm/amd/pm: Add message control for SMUv13
  drm/amd/pm: Add message control for SMUv14
  drm/amd/pm: Use message control in messaging
  drm/amd/pm: Add async message call support
  drm/amd/pm: Replace without wait with async calls
  drm/amd/pm: Remove unused legacy message functions
  drm/amd/pm: Drop legacy message fields from SMUv11
  drm/amd/pm: Drop legacy message fields from SMUv12
  drm/amd/pm: Drop legacy message fields from SMUv13
  drm/amd/pm: Drop legacy message fields from SMUv14
  drm/amd/pm: Drop legacy message related fields
  drm/amd/pm: Drop unused ppt callback from SMUv11
  drm/amd/pm: Drop unused ppt callback from SMUv12
  drm/amd/pm: Drop unused ppt callback from SMUv13
  drm/amd/pm: Drop unused ppt callback from SMUv14
  drm/amd/pm: Drop unused ppt callback definitions
  drm/amd/pm: Add debug message callback
  drm/amd/pm: Use message control for debug mailbox

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 111 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   5 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   5 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  21 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  17 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  29 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  32 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  27 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  24 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  23 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  32 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   3 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  12 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  23 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  31 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 662 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   2 -
 28 files changed, 630 insertions(+), 528 deletions(-)

-- 
2.49.0

