Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FA2CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E74A10E1FF;
	Mon,  8 Sep 2025 11:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WiWEmKdo";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC0710E1FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+6zbbw3V9rCrI3ogt9bPH1tIDGed95aKO3ttN5/QdBjFFbEVU9BMQK33vXqDAIvXh87LHpihotUSSHHAzfcnPr43dhxSqoi8OwoOYrAZjx27O14/+eQr1OqjcisP1ZmylO4tJWf2Crojmc62bgOgBceoVwKW8KZ31Z7pEdUUx7hjBifnG+wzEjayflFv54vmbgkH6h2SRvuSGp+ilYPUMkwo268ujfuCIi0Vg/hW+Mc/RecgJU3Dduj58YnllqAomHtZKLNRtwU8FG8AKIsp1qD7u/oauIRfH0fYe8hFOAPp2mXIlASK0DEm0fB4ZuL5UsL4EoCltrFlH4xP0UVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU/zCxrFs2S8q9Vd8Ke4OW046UoQl9QMNkknSqPV7rA=;
 b=Qyu4dHvRBWc70PLzxQXTRII6vxHZlrTqlS3vuMr1DBDqxOG+0bdy0OLzoMEUf88mWPqKyk2eHs3TGzVQItH3KBz93J1yx0lstYHSzWFxbPDP3ruoUu85R0FRkeiPqzvmjdQ+9Cgzvb2XjKqbO91sgzraoyQo2NyNQePrFbaJapeGX8hKKZtKIc633QCjwVepXgYAchnCGJpy7z/4oYdCJWthCiyFZ/H8r7xWBHrS2BKNSeuINqWYmbRae3OD8quU3jE2XsyX/lznHlwCAOw1D9LV3nsakY2jgU4oITyt4opdjDzbIB1bW8KNAXRuFtj5BpFQyigVBju5sk2v6tgRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU/zCxrFs2S8q9Vd8Ke4OW046UoQl9QMNkknSqPV7rA=;
 b=WiWEmKdoz1dpbJ59wSQFmpMqTn0Ij0CjqqXmOf/oN7i7up2MH5htXRaXD5KxK4ySANMMf+Hr2FUgAu/0pzeHITkhnVMI01WMYShG6pzVlJesPv/EczE2dLj0BzaqJEdRxdjEmS7v/ff16lkdTKeHmnyJhYj55sld5mwIVmxChIY=
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:02:53 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::ac) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:02:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:02:51 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 0/7] Add field encoding to gpu metrics fields
Date: Mon, 8 Sep 2025 16:31:11 +0530
Message-ID: <20250908110231.2888628-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b6cca5-05e4-44ab-62ab-08ddeec7422c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0bFItBNngO+TWYaglir8ggwCCDPd8RQQ9b42Agy8IrRmvSFBa5R9D+w0Xuw7?=
 =?us-ascii?Q?7krcsoD4eAamwuC9Bk9XWlkOzM4HzCc345IEWK2fdUWc4p3VRfxKJUr4UQ9K?=
 =?us-ascii?Q?VfuOfe/VFiLlkhkY6s09fT8cGJ4PbBIabhbHRhcMBy8AwxtmzP75CI+QuNai?=
 =?us-ascii?Q?Bs5dyTLyp47jOBpStZerpQHzpRacTvytyXaiD1TS3GuX0sUg5UZpXASbSuSZ?=
 =?us-ascii?Q?UlDvJjfam3L0c321gB1HQU9Dj8exdqnBG0g1nZuMzcGJrEpQd9swzurxkt+M?=
 =?us-ascii?Q?OUIqNVJ1hGY6Wp+IjnKFIxqvu0/VEbakTpsLfOLM18boMsAlt2V+KsFtL4av?=
 =?us-ascii?Q?L2vfi3mY91EFP1b4sKYSrHYKmgHyt1qDgQ/LOKB1ZSEsrJxahfit2HYQTKLT?=
 =?us-ascii?Q?Ip4GWeBvB01k3U1b3JdjUIl0M8qWWe+0RXX80zXysY5bYPbWyiP0jrQGUjCE?=
 =?us-ascii?Q?b1hlj2opevbUjsqBIBp8jeQFEtYjEVC5/yZmnLBmeqrZQk0+D9HLzt0mnPfe?=
 =?us-ascii?Q?x8Vn2uPB2j93SuzMPnLzx7GRg/FIpxPhuaIaHZxyPmJHQmEqwtA2+qy08m6z?=
 =?us-ascii?Q?ZOu2v3lO2x2APA+wZucAz6u7UZrYQ+v8b2tTWuQlNZCE5q6h8y+nD7XgvI2t?=
 =?us-ascii?Q?gbtGk8nkboE0mZhHq8xRw5TgV0bV4d6FAH4lP0oxkAuoKlcumJLqCVgXy6cn?=
 =?us-ascii?Q?VCtUrrr4uGqNeu4kcb/YCIQYSsoJQ2BP68zyRlWw/r1esssdBDJ8OKbFDbsy?=
 =?us-ascii?Q?WvxglAl+Jle8/PhTet3bnGg9I8jJpFWt2OzEKqpLoMmrCnEJvV5ndvIdVv5U?=
 =?us-ascii?Q?/tcFnICukZC5wziRdU1ULRfLi5wptKZ4Ji4irNRPWDM4AKEd38YLiOkHX9BW?=
 =?us-ascii?Q?4qTkmkrk4pwpwjqUVq4x+7lPoqNoZbNIwUiDEmJTZ7EWc9thCKL8mwda8qm/?=
 =?us-ascii?Q?hQ2K/sY0X2yvsh9Si+RnjQ1k+cYY03vHGePHfx1DqqNxyKW5//kmWHYyCKh/?=
 =?us-ascii?Q?LWiT+nsHXvrryrq0Z1Lyrrtl5hy2SH9r07vRpBKPSUwG2oaUYnP/J4KY6NXc?=
 =?us-ascii?Q?9SaIDCVQc8F2ijCmP2KoVGm3rpkszLZjfKqelEcy0Fp4yJiODi3GY9nk+8dR?=
 =?us-ascii?Q?zguLUq2lh+ojlqA2P7KJbq/ZFGMiTf7SJTALqx6Gbee6L1AXSIQEB7P+nGQ9?=
 =?us-ascii?Q?7yajjisAyNTp+VBl1Y7MkxtcFzwE3OwL0NtKtNlv5hPrd2Hh0n5z73DtXLoO?=
 =?us-ascii?Q?gz90Y45HANuOv1DiwX3kD2byzGeX26W5lN6NElBqk2Ddy6K5U/90FnJSa+2b?=
 =?us-ascii?Q?anNBfnpm2ccBdimNVEdFRuUQHWZ5AIAuaimUhg1o1aWrqCE7kBpkuvPo0qNk?=
 =?us-ascii?Q?UTwLUqfysTFchOe34pLllDwMrGroBXGhuyQOJmPa5kfdQWRfzfLU8/uYwYdC?=
 =?us-ascii?Q?DZPiTlxULxNNpbKbpUaIsPXlApb2NenodnHEU5iVQxI5UtffXuo3502pHN+/?=
 =?us-ascii?Q?gUKQWFwkuX/qUIHeHOF+R/gLf8M3ATEnB0Wj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:02:53.2170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b6cca5-05e4-44ab-62ab-08ddeec7422c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

Currently, gpu_metrics is exported a binary blob with the defintion provided by means of a structure
and version. Though providing the version works well for backward compatiblity, it doesn't work the
other way for tools like amd-smi. Installing a driver with a newer definition of gpu_metrics
sometimes could break compatibility with the older version of amd-smi. Even if newer fields are
added towards the end, a change in datatype of existing field or an increase of size in an array
element will break the compatiblity.

To address this, add field encoding before each metrics field. Each field is designated an attribute
id, and along with that the type (only integral ones are used currently) and number of instances are
encoded. Thus an older amd-smi tool may skip any unknown attribute field, and move to the next
attribute. This encoding scheme doesn't take care of elements that are not valid always -  say
member_field[3] is not valid under certain conditions in an array member member_field[10]. Hence this
still keeps the design of having all invalid elements initialized to 0xFFs.

Lijo Lazar (7):
  drm/amdgpu/pm: Add definition for gpu_metrics v1.9
  drm/amd/pm: Add helper functions for gpu metrics
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.6
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12
  drm/amd/pm: Add schema v1.1 for parition metrics
  drm/amd/pm: Update SMUv13.0.6 partition metrics
  drm/amd/pm: Update SMUv13.0.12 partition metrics

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 123 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  94 +++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 140 ++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 156 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  62 +++++++
 5 files changed, 450 insertions(+), 125 deletions(-)

-- 
2.49.0

