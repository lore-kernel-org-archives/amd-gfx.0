Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B985CEA811B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AEC10E1C6;
	Tue, 10 Feb 2026 13:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jJm8Te2B";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3306E88F94
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsnLS7PZ0VSwlv1MvHooAGb1CMEkyFbvNFIQzaOBHIZHsjTJRBkEU4k+KGdJejCTatghokp0wI+YkM2eV9AMlqdDwELs4ZKI2uMC9OQK++zpzGvRjcxRd66DFB7X0ZM5gWWRV20utwG71Lrd7cmPWunQ+Mn6jyXVD631QgA1qpUYG0MbU7wZG8v5wBnt4r8eOS3f9myfVTRz4HuXcP63kZjZOS0AUgHShEQiZSQm5NJE/PmOkbZF8kW+96WlOFdtmC21A3HTVrBf1G4/uMnmu5C2ubwWTeJNQmj4U8J0k0+UuWabABWChoyvogKJdhYvWrT+UKhzlB/NOgY4PWEUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LwdmliM/EUJVs5PN2Ug3fg4y+mYqSI3V1mcJnZ88/s=;
 b=FhMsqpwUiHYVnz0HigINQAi7hoZearxPubTCDVzcSlrTj7AHYstcz8RmXYwCn7pKHo45MrjlZM4UmA/bCmQDeIti3H83OtRw8PPtrogoCzvdxCM/EvWw8rRCie/e1HHIOPv08Vv85efobMVt0x3kUOxSnosQaDA8qRZkAE9q4K0iM/JxXgTkfbLbv6tYjEe2MhykoOG4+kUHMPeFCXgzvA7c5AkbpqrUMVwxeHI6jounmFuk6LWZiUw3H9JDqIj3Opx7fKuFQRBqcGl4exJ3ZF4Lp31FDfn9mZTzYm8hCu1QW8w8VOn4mz2tZZwDp56mKmp3xS4f1NVLmw9k8jzCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LwdmliM/EUJVs5PN2Ug3fg4y+mYqSI3V1mcJnZ88/s=;
 b=jJm8Te2BA01Md3UEfAxYQpveSRvPvC0xGWNKSstwxMJ/l5KCkm7u7IAFRkKAfkLDAmQZtoyBhOL4ZDZJ4gskQkh5ZbmGy0fzCjfpXjAtynqD8eKtPX0lmGOdof+Yjundhf4AE1ex5jQ4KOUhc8F1W4IP4qTP2wZyXHCwaC7pWA8=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 13:54:21 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::bf) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 13:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:54:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Feb
 2026 07:54:20 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Feb
 2026 07:54:19 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:54:11 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 00/18] DC Patches Feburary 16, 2026
Date: Tue, 10 Feb 2026 21:49:53 +0800
Message-ID: <20260210135353.848421-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b58dbf-503c-45fb-2ef1-08de68abe402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AV5qnB6Q8vnyN72tf7zQP1OWwrR3ce+uCGSxIS1wLmjh8EkuXHbdHuH4KvH+?=
 =?us-ascii?Q?cjyphNUrtQdBRulLeSz+Tk8NHSkHC+7cRDNBDOWORlvFDbpeslh4p6re57hR?=
 =?us-ascii?Q?aA5eSYtwlDGhCOZcryB95MrByOSoXqMrtTlwqxeQ1mAj5sIU0p6vpCAobc4u?=
 =?us-ascii?Q?VALsVAiYF6CbKCziXyvSC/mF3AOKpGryrYY6YxJSXjldOtOBFi+AW2UCZqAl?=
 =?us-ascii?Q?cs0HmwYu6daSOEgmUPyrAavftavCq/jI1VgxQ+/tjR9c/Ybo3n+Qj1w4gaPw?=
 =?us-ascii?Q?qeccM6hLv2ALBIn2auK5wJYg0vKlL3nhhqpq4VgygVXkqgc1l0nj4IXYY2dF?=
 =?us-ascii?Q?eStdPcp4gFKbLvIOWyUnQTq+sKsplx+F8eUoJHKI9siOpJPH4c1izCJ9tq+F?=
 =?us-ascii?Q?FX2Tpv5JDEXiYa5BP7aun2XZVaC/0vVMA/HcWQY3eurKo7U1hh2JGHrvI5GX?=
 =?us-ascii?Q?9OSchpoRu+o1HKhUA3SUA1H2NlA8l6oDVO+ANOvPkQndzh6R68D9NW4uCQ68?=
 =?us-ascii?Q?wVzy/8666lj58BZXY9lAiH3SQK7lb2a+08GSH79Z3VJSNfR3dFhJi5o09eE3?=
 =?us-ascii?Q?Xby86YdwodJdqxKeVfD6rdqQPg+qV1vHGtBzaUNTc0laEwMChq6NJhkKa0dm?=
 =?us-ascii?Q?WxBiIfft93RC2hXnpQAyXoDO7sXAN/Vggz8PHlS/1OQ6aEgAa5LNQOZMs3uS?=
 =?us-ascii?Q?PQ1gPSqL4xdtQmZPziIeeWwkLRCthN2Mz0X7wW2w9Kuq3mOeCnF0/TviBGFN?=
 =?us-ascii?Q?H2pL5hswFipEAapIQdT9C2BfcR7qhnUhfg/ZlD/uN2vgG1LMRukZ6B+bX+rI?=
 =?us-ascii?Q?Ubbft8y4MYsGjaOkZUfVR0oZraVHNH7XVwzts9r7pPhZR1bD76bnDfFUp+xp?=
 =?us-ascii?Q?H8LQO65H6zYcpKpUH11En682EOvU2HLxrFm/uUUv4UIijczy5c2uswJvk99k?=
 =?us-ascii?Q?Bz2dQwW0vSzRR9rI2IlaRDPlEWZ+rh9VjrxLK2gG+A9p/JkXhDBxxmx8jCcT?=
 =?us-ascii?Q?rEdhBrAEuNwWUZJ8R+VJgJ+DLYSeAFTNRUvHLAhTAEbUl5TbEi1RJL3SNFfZ?=
 =?us-ascii?Q?rrT5Y/TtKP2MivNZBlOy7KMFqjWk56k+MLvmizNC3w+le9TPac8ng/xEaaFe?=
 =?us-ascii?Q?wCKwwkuV7L0dyOcRb2kUKq8jVAIqrqwL/B+uB3Fna4COOXaUfma+5PZJ1MCP?=
 =?us-ascii?Q?V8mSXjRRDE1P27STjN8F5xn5jdxSzzqou8//A3j1d++BRSYhvwQd5Jydbqli?=
 =?us-ascii?Q?+qnrlG0+Dr4pVg8Dyq6AIRyVAPHsfzMR840x07omQbeIQym499v+qny9RU6v?=
 =?us-ascii?Q?m00XT2ggEkzo8vNbgIDZTAJQs+qtsxdqpu7UTXkdr70eosNAJq9TbzatbP/O?=
 =?us-ascii?Q?Z/LblgQerKb3f90NTN2wXoqL4wkcDMy0g/WxSir/Gs7Fafc1rw7Q4g26jfTM?=
 =?us-ascii?Q?jr5o6vE3GLFi3xgTqrTIxnLiPUV9XBK6d2xN2lsE7D40gVonR6xPDggGrbX7?=
 =?us-ascii?Q?gWgjFkVoEAXBVpHHGEi7Zv64by00YSWpmuC1hvCSgpLgaCWQon+zPBUhgaHZ?=
 =?us-ascii?Q?XMrSeqEZzufgRqSK+FWuh4uiMltV4dUtecYIRSeGu8RenyI1D2TOcQK3RngE?=
 =?us-ascii?Q?hMPuwe9ZoAOzThABL9PN1p8OWLfDyukzBPd5LHFrreOfy0Lh54m/Beq5YD2n?=
 =?us-ascii?Q?NGuvSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5s5IOJ88eztCz02xbY3+u+A/gnEca1AzPvClqbDYMFYKewy7vQq6jvk3o/TszyznRhKmEiCgIUzIa072LaK+YSUyN4FS1gDjvnPCH/DmjHmeD7Td6CJQ9Z5stxKqUTxY1X0uzdpmoinnl4vXfSmdg0HZtdBbA1vz4EcpoH+trPdLEyiB2VrD94ynQuQeFGUbjiDQQMKXdOsbve8YIaBkvSfAeotbPbhODtOy2f9J9XQkZOAOOCwut1lLFzcR+48fZ//e4iC5zq7bKZG0tNxOjzmIwI/JnIrtDWfEIS2mYbd3TmZmoHTSNizwven1q5gX65gng5oyIX1wbBpN5yixKyPCprboNn0h5g6Xb7AlNuzvB3M0lABjK2yrtDmcqV4fhFQvvuzx5eXfR/eXpLwRixkfsAGIVFBhLaWmI9Kseuyvlv4fWoaRO696EDeTWkGo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:54:20.6554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b58dbf-503c-45fb-2ef1-08de68abe402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Add static keyword for sharpness tables.
- Refactor fams2 calculations.
- Add gpuvm and hvm params to dml21.
- Expose functions of other dcn use.
- Extend inbox0 HW lock support to DCN35.
- Disable SR feature on eDP1 by default.
- Implement ramless idle mouse trigger.
- Migrate DCCG register access from hwseq to dccg component.
- Skip eDP detection when no sink.
- Refactor and fix link_dpms
- Correct logic check error for fastboot.
- Check return of shaper curve to HW format.
- Remove conditional for shaper 3DLUT power-on.

Cc: Dan Wheeler <daniel.wheeler@amd.com> 


Alex Hung (2):
  drm/amd/display: Check return of shaper curve to HW format
  drm/amd/display: Remove conditional for shaper 3DLUT power-on

Bhuvanachandra Pinninti (1):
  drm/amd/display: Migrate DCCG registers access from hwseq to dccg
    component.

Charlene Liu (2):
  drm/amd/display: Disable SR feature on eDP1 by default
  drm/amd/display: Correct logic check error for fastboot

Dillon Varone (1):
  drm/amd/display: Refactor fams2 calculations

Dmytro Laktyushkin (2):
  drm/amd/display: Add gpuvm and hvm params to dml21
  drm/amd/display: Expose functions of other dcn use

Dominik Kaszewski (2):
  drm/amd/display: Refactor and fix link_dpms I2C
  drm/amd/display: Refactor and fix link_dpms info

Muaaz Nisar (1):
  drm/amd/display: Implementing ramless idle mouse trigger

Nicholas Carbones (3):
  Revert "drm/amd/display: Add Handling for gfxversion DcGfxBase"
  Revert "drm/amd/display: Correct hubp GfxVersion verification"
  Revert "drm/amd/display: Add Gfx Base Case For Linear Tiling Handling"

Saidireddy Yenugu (1):
  drm/amd/display: Skip eDP detection when no sink

Samson Tam (1):
  drm/amd/display: Add static keyword for sharpness tables

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.370

Webb Chen (1):
  drm/amd/display: Extend inbox0 HW lock support to DCN35

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   8 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   7 -
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   1 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  15 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   9 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    |  54 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  14 +-
 .../amd/display/dc/dccg/dcn201/dcn201_dccg.c  |   7 +-
 .../amd/display/dc/dccg/dcn21/dcn21_dccg.c    |   6 +-
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |   6 +-
 .../amd/display/dc/dccg/dcn301/dcn301_dccg.c  |   6 +-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   5 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   7 +-
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   5 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  11 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  17 +-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   3 -
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   5 +
 .../display/dc/dce110/dce110_mem_input_v.c    |   3 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   1 -
 .../dml2_0/dml21/dml21_translation_helper.c   |  11 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c | 205 +++---
 .../amd/display/dc/dml2_0/dml21/dml21_utils.h |   1 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   2 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |   1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  10 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |  10 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  33 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  26 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  26 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   7 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   4 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  29 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   9 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  48 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 640 +++++++-----------
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   3 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   6 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |   9 +
 .../resource/dcn32/dcn32_resource_helpers.c   |   3 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   3 +-
 59 files changed, 698 insertions(+), 663 deletions(-)

-- 
2.43.0

