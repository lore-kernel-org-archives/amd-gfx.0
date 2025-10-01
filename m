Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E96ECCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 21:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1445510E15F;
	Wed,  1 Oct 2025 21:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Azzy/vj5";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E12B10E139
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 21:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmSd/zTpiIKx9hp7ryAUqNh7VbvkH1gJJjWW0poSGehSxDqmP4TSMg3B1VxrCOY/Oaao+VXWkuqF1xPtsHS23kJhgdBH8Czxz0/saig+ZDGQeZ1+pUNCWPyhlsyx/kj9tRvmwXw4CgF2r+UuZUHx/BBZADl7R1USwZ/ZlACgXE4v3pnRPA8o8ucsKVfH6jspKaXyphdNpoCZ0/6Nmz8FoNKfu9RpgsxbM3svzf5GiECTBQDbta8LBzPItsEkSrqdGM2WfKjiYyUXL+OICHyUNUtwGWHEDJDKUQZqr/Dy5vCtGz+5yJV7W8LCExILdNbSN1noZI67AY/t+1JMuG3OSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwsDezA+Bi7bWV3ea/3aJ2jHKvkN2OhmzJQ0DD4/qPQ=;
 b=leib8qBq+RXlSpjV7ck5HbfdC7AJPcli3nkVDFZ3tA+8e/DEsX0mGht2XQ3E9w6WnKIEKc5dSNxDAAXDJPncgAPkB/A889CpntK9r+3OwfeAwtGt1RMpd2569fsiDr8O5ojVNVqqMod8aq89S9XgV3VJ7aWSQcyvY7Or89krz0T9eU6/Jane5hV1ffuO1Lz+lfr5Ws2j/J+WJe4j3mWF7PaLNroq3LsoLemedAsppz7+q9nTiTZX64vCCVyP2MyAvhGM5Icn1via9UvJ7h+mC1zLgnaZcy6dgRel4UJ/I2H0MCQDBr8SE/Tw6wLP83ZKSYZGLOEmMQADoOpp9SpC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwsDezA+Bi7bWV3ea/3aJ2jHKvkN2OhmzJQ0DD4/qPQ=;
 b=Azzy/vj5Me40+VcLvCqFMBzAp2HAdD/KE9gRwwTJ0RtwuxtKEAjIHdMEYmoUSaBZqDAK6dcWZT8M1/OVyzyWybomoCq9JblCKQbKPkr+Mmnui5jLsUldFtl28STiYG5f7VQn7Lva5YzPgIyi/D9nlDiGzKe/gavJNidPW2WoJxw=
Received: from SA9PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:6e::33)
 by CH1PPFF9270C127.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 1 Oct
 2025 21:27:24 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::e1) by SA9PR11CA0028.outlook.office365.com
 (2603:10b6:806:6e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 21:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 21:27:23 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:27:21 -0700
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 0/7] DC Patches Oct 1, 2025
Date: Wed, 1 Oct 2025 15:24:05 -0600
Message-ID: <20251001212700.1458245-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 896f8bdc-ec78-4006-b82d-08de01314feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wLLXejPPHy5VqmJ8KZWAVg3N+rvs3J6+aB/3TzCUUJ5z1ae3ZKpNYuPALaCN?=
 =?us-ascii?Q?11NxSohBcGg1QC19WpJYKKewNKTR2zkDDl5mDcs3FDdpk+eIQ2tFgmGJWqYw?=
 =?us-ascii?Q?fsC+dZfnmjOP4+0Z7k5V8IGtsJGoRopPrm96M5ePzGlTG8IMdpbNjOXGITIl?=
 =?us-ascii?Q?CDRHZ80U3gvA5oZMWSGaRlS6rlkEWh9+aurI74wQ073MFmmNCKdXhwOWNADV?=
 =?us-ascii?Q?bZIAl26hXF3QlRTznbmRpSnrPxoHDGIcum7gvDyaOd8upA7hXL/oCAmlkUra?=
 =?us-ascii?Q?BEYltjGIvssxCz2ZdkASIOtZ7pEt7EsVmfs6ndxWiOWuiiVfXSQEh3ZnkF9Z?=
 =?us-ascii?Q?nHlZxMo9mP8GyhMNNRn2paTYoMdOnBo5PcKn5l+QTPZsDB1tMMDqnmiLtKlt?=
 =?us-ascii?Q?TW2Wj88yrEOW4MDQ8oQQ1NPdQph407Q2mRB+wCOrSGqQhERiChqdg/SF8ooc?=
 =?us-ascii?Q?yAEkyfROXj1XqrPyaB4uiVPSZDCRcTxlUfQ+MVte6nH+gYB386+7RY57znJl?=
 =?us-ascii?Q?DB6CNTJEwSUrj62hEMjBJanBeQs3kcgvQ0i1lCYhg+g1vQZg8z9wXLcB1DD2?=
 =?us-ascii?Q?wL2gKa/Pzcv6kJmW4b+WSR6dm4lr1GF8DW1Md0lAOh8gEUgfH31sSUxejfbx?=
 =?us-ascii?Q?k1Tj03sszK8djCzsgvWiqmQ4AxuzbqzaxzPHW9sLLuymbBE+x6a1QUY00dSp?=
 =?us-ascii?Q?GZ1u6PE3QgtKO+SDHaZh48V+4ckRw+DzNFIyB+8DrEeRJqkydtbynzli3seU?=
 =?us-ascii?Q?ECHGz6xMV56hNCuaw3is0jBG/DZt7lf60Ff1ImW6/INKFdasYa7l1B3KDI1p?=
 =?us-ascii?Q?+P+pjRlLss3sZ6swOCx/COZ5CxCGMI2TnfkFHORytPaz4B24QJLje+oBdggv?=
 =?us-ascii?Q?KNZN7qp6EkVks9cpf4ailUp+zhzzlqnjFosQ+kK8eowcSWsZbCddaNqMmZZc?=
 =?us-ascii?Q?ffg9zJ+1nbcyathJqYhH2Vj5ulsH05ero0i/1BfIM7NWxUgnT0Bu+yOf/pjx?=
 =?us-ascii?Q?Sm6srOuEZj0zS+1ZZjxCZz8JAuXoElJI3VvdxnTuwsuOhLp+hZovQumiv/+o?=
 =?us-ascii?Q?ULqptJCQXdNK/E3F5iE1tylkfcRq9YrKUOXnZBaTO24ZtTnPa4+BPWR+UIdn?=
 =?us-ascii?Q?m3DLBBc7bfsg00nqnZCW6GkRBmIQB+uBUGf1MpnN2vAM5+6hF6G78sYRiF2h?=
 =?us-ascii?Q?ffcrLQCgfERkmpR1Pn7FrOA1Y+32VBuz0yEGR0mcN4zzvIUNDLY53TMm2GQ+?=
 =?us-ascii?Q?VQtcdVjkBceMNx7Uqj3daHgL5+oV3aEb3JBeHFQRMQgAHht+JE3S/Y9E+8Zz?=
 =?us-ascii?Q?EioiUWFTNGQnM3wJw7IZwdcT3UAWiIWH7EhhRNnS3a1PLnN6ZYdMEW/ASe2+?=
 =?us-ascii?Q?/I2xDijiwgHeXsJyyl1RqXh8l9Skz8ogd/El7h13KyfqutObncr8WNCSIVxi?=
 =?us-ascii?Q?vsKv9IGuFmmcrbqCvqoEE3XUCj8c2IZCqa7MWdE/SNfpAA0y8dUCnjGF7GAL?=
 =?us-ascii?Q?bSeyuHw5/kSv0ajABrPDyYhRPg8q0yu+4ZR6mrsJejgRApK4FPYSNqBrpsei?=
 =?us-ascii?Q?hX0qCMl7c6aR/rbcqE0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:27:23.8459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896f8bdc-ec78-4006-b82d-08de01314feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127
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

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Driver implementation for cursor offloading to DMU
* Incorrect Mirror Cositing
* Enable Dynamic DTBCLK Switch
* Remove comparing uint32_t to zero
* Remove inaccessible URL

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Remove comparing uint32_t to zero

Clay King (1):
  drm/amd/display: Remove inaccessible URL

Fangzhi Zuo (1):
  drm/amd/display: Enable Dynamic DTBCLK Switch

Jesse Agate (1):
  drm/amd/display: Incorrect Mirror Cositing

Nicholas Kazlauskas (1):
  drm/amd/display: Driver implementation for cursor offloading to DMU

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.30.0
  drm/amd/display: Promote DC to 3.2.353

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   8 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 ++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  12 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  42 ++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  99 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  36 +++++
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |  19 ++-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  20 ++-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  42 ++++--
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  69 +++++----
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   2 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   3 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 138 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   8 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   6 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  60 +++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   7 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  14 ++
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |  22 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  10 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 104 +++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  22 +--
 31 files changed, 689 insertions(+), 95 deletions(-)

-- 
2.43.0

