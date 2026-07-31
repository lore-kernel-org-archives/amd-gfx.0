Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECD6C55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 03:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB7410E1B7;
	Fri, 31 Jul 2026 03:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kU70XhlY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E34A10E1B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 03:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBszlKoBvgTlk2F2XYIoDvpqFOlaDDqUk2LWlN3yUUotqmGgocZ32y1h29qh3zUiq0Xoyysx/HLGIUY97y3ghAwyLBYW8GPX6bICsj8eV/1XzelKL5I+RTZbXjKM8SV/CYP0D5138NvdW7tjwmTBdU1KC0zRoGTpdnKCvBLwwireM1yT32F0X/OTR19dxwVi0nLIZuVLaNK3MDqltu1MrrirOfAuWFl1uJTplPgsxFvvqOmMSw053GxWyBC1611lwfllKAcesRVUhkHkwfoM8Un0rP7Mkx+hBQJ7WpvotsP3AbvL2n0Pz6OcrZXMIzjeG2sLdD60uLtSq6/+Qgs0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OubiXUI0vAldq57//G2/vhdf1+XpsD3zP1V9SKtllc=;
 b=mwtSMnEu2R9shxEo6eDw7a5A/Wlx8z1Vlizj8lp0o25LnAwvM/ePM2301VKjrzKXIgzNtRiuzEe6YSOxi25yBaC6utrOuZ+ZNdGMXzHlDFOOnjIoQ0KuaF2K2fpCrEbnEPh7h8E8AIoVkZIZPTf/kACEiJD7wtH6odm0mv63fl1sa9sAjRFRT1P1OlWxalbCMVLFKU/Ek+Yiwd/P+pYZL/biS2dyH2ertbBnOOhqbWmVoN2G6kBkpqwZXfOWbRk2Y8VbGxxne8UOWh2sXSftwCEOPNGrY/d6yTLqX5k1UExCSMPUtCdjUmWD1UNpRX8sYad2atkq49kW9MCeLj9BNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OubiXUI0vAldq57//G2/vhdf1+XpsD3zP1V9SKtllc=;
 b=kU70XhlYScOnFsKdRr6MoJw98glqU9te+ZFC0FhSMuhy+GARp+kF+mqHR4mcSpWjUquXREy43k66a+g9K9HoB6uQL/1YevOWvnfd8PExVZH7g0cjXLrMaA1QxXqYTC+jdIjSsqBTAnZtbZqO35EUT3X5deFS5TGQRRdW97sJtPI=
Received: from SJ0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:2c0::6)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 03:10:35 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::55) by SJ0PR13CA0001.outlook.office365.com
 (2603:10b6:a03:2c0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.9 via Frontend Transport; Fri, 31
 Jul 2026 03:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 03:10:34 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 22:10:33 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 0/4] drm/amd/pm: refactor PPT limit runtime policy
Date: Fri, 31 Jul 2026 11:10:18 +0800
Message-ID: <cover.1785467079.git.kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 329e6c38-62db-41fb-c8bc-08deeeb149d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|18002099003|10067099003|11063799006|6133799003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: rCSef1vBAtedJpAzimKay/eT7318rn5g5H4MU9figlCpOeidZaVPJY2ZgX030chwFZq65zawBSOBdy+wWv+eeNtOu30/Z0fkDD0SDdNICx+mK+5/Mzi0/50fj9ZYRnko/z9XDhKBKErRQY3ZwxUmeA7taj7Kb8jY92zcUfbKlqe0rM/a3qrnX3sAMZn0JavCI9JPRyhUttX4ZrCpisgLXkbfSkC8fJXNuxTx5lmGjwJIkrgsdRGLcU49z4BKChZHw20QDcc3eJSFob13PmMbpp3bGNOFFsln2wolmHHzpmGTBHJl0arQGFZCM+zXEq6Qg90/dJ5lD+NJVJz06doTrqfaT40hf1vJKTpppnRaER9h1y1e1FTirl+9PY15iKg1ikTniZm3OtYQT/0CAoNKaomtuBjFILO/vitxdxs7t6B7jLJClwer20WcqPc2MwN++GKEHWJ3BomifwYWRqd8zZCWrM38CLTLgGuvz+fNchDiFUeiIRvCqY/vkiT9P4yAQ6t+65wUS2+kbNMjGllroOsVp7bTzokPkJge9v6/9Fc1++pNENHJK09IsmFLVczyv7G1RYUsB112WIAIxq2BBSuz3BMhJyC48SWTmCjswYEs0MeXj+BWy43HBPIknK3lwNg24OsMNW39ISVEnwnlcd6gWDtGrRta/nYxHUofS+o0bKi0uqvJRo1rvzh2hsHG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(18002099003)(10067099003)(11063799006)(6133799003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8gpZi24oo6TJvqtSGHLaOPJANEPDufQzlu0M1b4m/1kI89zm3FGN1DFxXCXOjCYS+P7Tc1vCpg/RXschyjWOhNs6NMfk5dcyE+dTOfg5FvC5m2XH2spNtzl7eYhhzoh855Nodjm9rceCbu3wTbQ/i5aGHNFzVTWY4ZquLAa/fC+4cZ1DC/ZbyDCM5kX8pnNEbg67vvrq4XjoDJf+ItIUgk2DZK62WU5bG5s9AWQgAGH+IrpWpf05cxDBvSlq+7qyWLdizRfSsuwuR/jf0E1/zf9hEefNaLfzpZANujv63DoSgqRGXF+HySkTMCTnGRoi7vBbpxg5Z9Y6eFtMTXa3AoroSNzf+cwn3yOtxyjgF5u+hLqKzOC2gho6goPw5gmAa5NnFDMTYIcjp5relituzicwDE1XN7uSrfpyQNY6UOerXxGcqI+ciwD1M/2bilw+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 03:10:34.8022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329e6c38-62db-41fb-c8bc-08deeeb149d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619
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

PPT limit handling combines controller identity, AC/DC source, immutable
capabilities, PMFW runtime state, and persistent user policy in scalar
state. This prevents the driver from representing PPT0/PPT1 independently
and leaves user limits vulnerable to PMFW reset.

The runtime model requires separate ownership for each class of data:

- PPTable-derived ranges define normal and OD capabilities.
- PMFW messages and tables define the effective runtime limit.
- Common user-profile state defines persistent policy by source and
  controller.

The four patches establish these boundaries:

- Index common ranges by AC/DC source and PPT0/PPT1 controller; pass the
  controller through get and set callbacks.
- Account for PMFW protocols that represent an effective limit as a
  message base plus an OD percentage.
- Save user values and validity masks by source and controller; restore
  them after suspend and live AC/DC transitions.
- Restore the saved PPT policy after GPU reset reinitializes PMFW and the
  platform power table.

The resulting policy preserves explicit user limits without caching
mutable PMFW current values.

Yang Wang (4):
  drm/amd/pm: refactor PPT limits by controller and power source
  drm/amd/pm: account for OD percentage in effective PPT limits
  drm/amd/pm: refactor user PPT policy save and restore
  drm/amd/pm: restore user PPT limits after GPU reset

 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 222 ++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  63 ++---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  15 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  11 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  11 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  11 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  52 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  78 +++---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 122 +++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  23 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 118 ++++------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  93 ++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  23 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 123 ++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 124 +++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 123 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  23 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 123 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |  23 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 122 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +-
 22 files changed, 792 insertions(+), 716 deletions(-)

-- 
2.54.0
