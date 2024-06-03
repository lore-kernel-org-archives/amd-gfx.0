Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED76EC25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189DA10E30A;
	Mon,  3 Jun 2024 08:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJLcLuVm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13D710E309
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHvHSDAqCuOeoCU6rbuRrx7kXKv+iAZD/hzwq6dwg4EoSLXAwetE6O+r/TOXaykp+HCXWLTNE7JMnrItCMxN0Rb2330UItuCLaMTNODfI6qUPvGFv9L4h5IxTc7PRKUZ1hTm73hTsKB/mQPkI4tCl5vS8yGXmFFi3XPPXbPlgKuJnstCEbnXyXC/uoQFEiO6idAI5DcKyfjC3R/KCphM0J+DqA/8dxJ8s8GMroHIRD4tIeeZsvUbTFJF2IWKP1ImY2VocAdPy0l4acJTKvcxiBfIvbtplcs5KQeeAhjNuOJ0iuaAtdcqRn9lcMOCsT/KLWi50NbmfZSDeNX4k6lqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqoM81eEOagkP7KNQQ5Vr2LVUxKqC+qax7VL6eeD9QI=;
 b=I2KQDNQz8v8PA9Avm54I6/Q5STnMnWiJ79greh/fLduuKwSyBHYrrsUZh+gOOotwbiHVU26roE9jp6X3MkmxMgOdJbrpgpTQKd78JcdH/gvmf8xu2uU9LptgKIEhsw3dWXYAbcPiPi6T6r3mX3acqUmF9Je5IUzvwD8n+rqFd2C9lt/tAHZgS0SHkWb8cT3SIfnlH9ReO26KQYXw2sM1SqD0FUI4ssNZJhnjQN5X8R8O0DwGV/zKrpkZWqglb+Qc+8IfdHFR07wd90FXhBNhEXHEju8Y4vAk96yp7Hgzo5JNHW8hW9/MFkpmrY/7+C+KcB1uw4o3C8AKZuG8tT8JaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqoM81eEOagkP7KNQQ5Vr2LVUxKqC+qax7VL6eeD9QI=;
 b=zJLcLuVmxbi8mIXXJxaQBZbnSEqnHoOzowu8mT45SetJ6Dvk/faVZt64j7JFi5BRMgiG7966hGqqjKC0W69YcnNrJdDTGYDZkzYG9J+UNd43wbOwLBkOaiB4Jp1CZoXp0B0nlioqWaqHINtIlg8E8vfMFTbDFQjWq+bqtdEhMWU=
Received: from CH2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:610:20::37)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 08:44:55 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::38) by CH2PR07CA0024.outlook.office365.com
 (2603:10b6:610:20::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 08:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 3 Jun 2024 08:44:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:44:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:44:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:44:52 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 00/12] *** Remove dead code  ***
Date: Mon, 3 Jun 2024 16:44:51 +0800
Message-ID: <20240603084451.2569401-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2d09f3-4d74-48cd-7af8-08dc83a97109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bQearAAqkpf8fZ7dqpmxp2fEJYlB7C6Lrmhky4q0eKJjv9+b0UZrEfxsmCVG?=
 =?us-ascii?Q?iqxJb19O4JCSAyhnUCH7LjX3Q8tdj9nRf3pQ/RpqKhBX+Hv0Kjlb0GddntOO?=
 =?us-ascii?Q?5xREgt93wl1lVvIyUAE/kxA8kdWJKyAVF8gUI8S+YmIM06f6sJ3WD7mcq0aU?=
 =?us-ascii?Q?IwwgnA//qhdAF+BTQC14hB+W4SBWbxaGsWat+urfFpv/gm615Ypa1mI6czEv?=
 =?us-ascii?Q?6YknsG18rZP7Hf9SJ36u8ewceDTeTRhPO+PClv20pZemMZTq9Uh0My/xLqho?=
 =?us-ascii?Q?6IG7XpzEtuC8zs/sCTjxdw+NlcWBIXl2mXMNYk/Nc+n8H1B5VyYQ7L1ELKXO?=
 =?us-ascii?Q?B2cIh/sWkCkaF6R87LT3lXhzRUK6fwRbQrLdWEagTLFn2b0h2Q5RcDAtCU62?=
 =?us-ascii?Q?osZyg/jdJ/ILmga+8FzMIj0tZgbvtkHFJxaA/YR/joVHnSOg4TNUVpe9PyG8?=
 =?us-ascii?Q?bMP4E7/euwgc6KaXMdPqf2N7Do87qejJAkYjFQqMRcJq4jJy50D26ytCXNPz?=
 =?us-ascii?Q?6GTQjphr19wqblfKqbqzqpyH88l0R2ei3F6eqrDefqmAeiBe9/2pzUVZgjaI?=
 =?us-ascii?Q?Uyp1vI25JEsRrWxxRwy76/slVGhPrvf8vrzgKrgWKW9QtoxWKrflD3ehdoYU?=
 =?us-ascii?Q?8CFDHuTp7lqFdSZlU6uW3hFGQTOTPbTtq2H/X/mKjLH1FMjklNgVUuy3yiTo?=
 =?us-ascii?Q?9it2HGdpX2QRdhfWr3HSBabqGsGINqsycaecF8WgUOOodJgssix4KcoCKibd?=
 =?us-ascii?Q?mtTjxTDFR878aqLmTdgQg1DHh1RmqKzRb9tDqHGhpjZPkrQwAArCGw1+dHEi?=
 =?us-ascii?Q?15Pka/qBMtqIXR/RUg3aw2MIQqjKHk+J7SgqrjDJJuJk1xIhS16OFpAmTlQA?=
 =?us-ascii?Q?voVhZkzo/tqN0uZPM6B0l/VdqVUzxcW5V+uhfiiBtziEXzR2Q9UYEaPlEu/Q?=
 =?us-ascii?Q?fDv83gg/wA28rnxUpt+VXljWI1xPGMs9DP7pEmZNF9q5rBL8qPJWiS6bzYkV?=
 =?us-ascii?Q?sRndUHfZuldGz65YC4gIokKD8jfCeKp5rRPsSv3M2zapOX9EkqlWQKa/HwAG?=
 =?us-ascii?Q?wWXzcpTdWvi3uZCkYyQmyBXA8Mkgl/pY4Woipqu1kwQ7MYxA+fB83+jVIIGf?=
 =?us-ascii?Q?8czrGsaoGUDkBgL+vE7c/cMmq/utBMJOiIN8AVUF49O9QO8pZLaFWqcNAeTB?=
 =?us-ascii?Q?hZTgVIRF84OA+qwU9E4dBN9voH07S0CAlHOCAiVeenpF+Y81lAjqGHyxh4cA?=
 =?us-ascii?Q?4zlf6eXAacPr//8BNaGHSTOTyE1EQ+kYFS/ZugVGvM1tZ8rvJzjZrEsQuen1?=
 =?us-ascii?Q?SinnQ6hQf1+MTvE48Aqp/f+bJehoqDMQlGMAr4VtJOgAaYLVLQIec/OABQgA?=
 =?us-ascii?Q?aw7sj0JFLnKyOTIbT7eFgdxgkZBX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:44:54.8301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2d09f3-4d74-48cd-7af8-08dc83a97109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
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


Jesse Zhang (12):
  drm/amd/pm: remove dead code in si_convert_power_level_to_smc
  drm/amdgpu: remove dead code in cik_program_aspm
  drm/amdgpu: remove dead code in sdma_v6_0_load_microcode
  drm/amdgpu: remove dead code in atom_get_src_int
  drm/amd/pm: remove dead code in navi10_emit_clk_levels and
    navi10_print_clk_levels
  drm/amd/pm: remove dead code in smu_get_power_limit
  drm/amdgpu: remove dead code in amdgpu_vpe_configure_dpm
  drm/amdgpu/pm: remove dead code in aldebaran_emit_clk_levels and
    arcturus_emit_clk_levels
  drm/amdgpu: remove dead code in cik_program_aspm
  drm/amdkfd: remove dead code in kq_initialize
  drm/amdkfd: remove logically dead code
  drm/amdgpu: remove dead code in si_program_aspm

 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  2 -
 drivers/gpu/drm/amd/amdgpu/atom.c             |  1 -
 drivers/gpu/drm/amd/amdgpu/cik.c              |  5 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 39 -------------------
 drivers/gpu/drm/amd/amdgpu/si.c               |  3 --
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  5 ---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  3 --
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  3 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  2 -
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  4 --
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 -
 12 files changed, 71 deletions(-)

-- 
2.25.1

