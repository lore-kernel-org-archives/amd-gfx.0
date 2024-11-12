Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46794D41D51
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 19:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED79D10E629;
	Tue, 12 Nov 2024 19:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HvG42nQ/";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442C910E629
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 19:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8kRvJ09mBx8Waerq5mce0B8YvA3pdS2mekkW9za9sdmq/K2OPNNq/e6FiRCfy+M/yo5vvFNPl2kB9uCECicKvybV7e0d315HyAKXSDPtd2jFOvCD5ljOSw5ZtOWeRWnJa4zA042fuSeammWIISRFGZIP0mMGTHgahAku7laLd7f7kOdkq3ETbbxUO2beW8lDUjtOOyT0Z0p2GzfSqj2S4NxEn4QpyH5Va0e5WZzXaZDYtNOwzWPJmvba5NU5p0vNBuWK9mCXxHi02DKESYG9oWVaJv+JLRx2huBTL7n2vXVRwy8nl3nkdjvf+sYQSLM+WQzA1TazwtAxD7nb7jhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGLXLAKq52pRAcUOpkTSJsS6yNOMMnY6amIahUcDP1E=;
 b=hvzUyB+RZJMBGrUoK8WaQN60+6Cyqdf2H6IZ3M6WT/NLBMHWiOiwngx+26jmjDXOo9fZXLsmovMw2RSFVsMxEZtmGxJhJBLXxgkH6k6pb4tHsAV6IC0lFih1R5d9XC01/UK4eovgwNAkGr0PoYjUO5YzFLv7WTuwRCyO276j33XfFMXD9oHtSSC+gErtlbwFGwJcSk008O1HJadjALUCW9bjm4ZMuG4h7r2uN7CBXEv/FM6NyLoGVnwA4BFG1os8OW+dSSiaUx9SJzlwjwkFwXy44ck20ml39y/G9r3h6XuQ8e6IkgXeL7HlzEd0yxPY7Cqxrqd8TSq8Q84gFE5o0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGLXLAKq52pRAcUOpkTSJsS6yNOMMnY6amIahUcDP1E=;
 b=HvG42nQ/IQBb0gnSm8ftJe1f4QLBqFSDFAMeIDIu7O+Sy7UPubhBgdtryDHfBJbqF/HBMNgQ+urTeS/F0xUWkyt1MGckxD/CiLLjfwO41nIM64Fwi1ue1Ob8RtLRMp4slxZu/H6KygsvS3IOzc4uSMZGJywK0E8/nMwVFsN+l08=
Received: from BY5PR20CA0024.namprd20.prod.outlook.com (2603:10b6:a03:1f4::37)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 19:58:17 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::40) by BY5PR20CA0024.outlook.office365.com
 (2603:10b6:a03:1f4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:16 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:15 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 0/9] DC Patches November 12, 2024
Date: Tue, 12 Nov 2024 14:55:55 -0500
Message-ID: <20241112195752.127546-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f53b25-5cb1-4738-9278-08dd03545970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4f0k3KmX6/H+b9JAI2w045Q8X8BciLDR22NQCYIM41Lzop27bsmcK9Ex5i8V?=
 =?us-ascii?Q?NXDWBHdUmsRUJHP+w3oTVYY9eaksQE6k3do3t03gD+0BdUwh4p4VnvzWTnd9?=
 =?us-ascii?Q?QHink45A8attbiuByvpjw7t0of1j5zV+pZJAh8a7OMyEQCTkvEbzbSSSSBxE?=
 =?us-ascii?Q?8HSaZ60VH6/lmV5ZG6kfkRZeutVrYxMc6ImBArT4zX2KNPpUacy+iScp6yBt?=
 =?us-ascii?Q?eUCUZtf6zh/GarUgqc0as3oilrXnxtPzF0fOyCPB+UtIjUMd+h/dQgebnEfG?=
 =?us-ascii?Q?KLapN9k8HLZSck2/KEktY4x9yFDnW+clKz7rakzmcySzcnZ120eXhrVVC61H?=
 =?us-ascii?Q?z3lAqkNavPlDBK/CsAiJiXMEGG9ZY1J4ae/lq65QBGRYClSPcz+Qy/v8AO2C?=
 =?us-ascii?Q?6ctKm8gESSpEuWMB4jyW6CwjmO1XMofX+EHhwhGmrOYiYbIBuLjUApQ6Zm9q?=
 =?us-ascii?Q?L2hsGCmHYvTIAG6DIs7WhB3LNKhdKE6+3pidVHASOzDAaLnqEv34M87hPtZi?=
 =?us-ascii?Q?/3RG8gPB7ZaMNq0hkFwYL5dlQ/Fo/yI5JyeKTCAot/g84sMlyb7hVxzIC+2g?=
 =?us-ascii?Q?REQxvU5IKlJFrq+/7jkA20uQ4Gw0lMUz8n3BO3qF1bLqKI3RYf8E2CYkOkyB?=
 =?us-ascii?Q?Vk7eoHaaRI/fWEV5kjZvUHASPz5PEWuiONcIKkZgb18kUEXQV7D2x3ISTsaO?=
 =?us-ascii?Q?3H3ZudsllPlj5zLUrRJ7OOehB3tZ2DVZK77kdKRmH+0l4uzIKW/+XKC4T/Wt?=
 =?us-ascii?Q?CKPRshcuwquWgHMFx4f8CUtcJKW3R9n6JSrBmhQoQJP5hfpgl+j+L9s6Tj2K?=
 =?us-ascii?Q?LNl/n4bMSnmzqnkyzBuRHDf2cs6Tm7MVXpIrk7dWnNkuNjBmPrtjqF2AA8uv?=
 =?us-ascii?Q?nwGnmUumfAukDOWctzz/Mv5PdFIUifq5vQetgEr/uq5fpZEEtmUXdU/yUnlV?=
 =?us-ascii?Q?qxqfjpACsuPow2xiw0qh/GmaiHqV419dJ+CF1uXI3cNF1aT2cEmtagLlSF1j?=
 =?us-ascii?Q?UK1qCy//DyVGWyXc8yv3IZE/OA4ftWNa4vqJs0NFm9u0yMiWeyucaKhpPfst?=
 =?us-ascii?Q?vYD0P9P8IhXHlM77irJVZP3nIhw+lnj72spbK6AA15fvXmoRdX+wzWFUE/RN?=
 =?us-ascii?Q?xcAueKJYtxSwtd0zYtwp+0sPfoe+C0CnQ/EhGeQjtcMm3Eboqk+A4SzaF7Z1?=
 =?us-ascii?Q?zzlQeCcyL6oiwnIqM31qmTGe5XcnEb8+Y0Kx9YPnR05SswLxemHRi3J9eWvv?=
 =?us-ascii?Q?BAB+pF1ZOaPEUNh1PGgY0hPIUQhPx83rV65HEOzxRVG8WaJU985szhI+6Clu?=
 =?us-ascii?Q?AVUB42iHO+1n6LZ9jVA24TeIb39xM9C9ggWromhM//iNreSWBMFsgY+s074P?=
 =?us-ascii?Q?x1VT1L3b9depLWFVeYpPmLacYhZRvAeYAixzRSrQw7rQnjN2tg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:16.7601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f53b25-5cb1-4738-9278-08dd03545970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.310

Austin Zheng (1):
  drm/amd/display: Populate Power Profile In Case of Early Return

Chris Park (1):
  drm/amd/display: Ignore scalar validation failure if pipe is phantom

Dillon Varone (1):
  drm/amd/display: Enable Request rate limiter during C-State on dcn401

Joshua Aberback (1):
  drm/amd/display: Fix handling of plane refcount

Ovidiu Bunea (1):
  drm/amd/display: Remove PIPE_DTO_SRC_SEL programming from
    set_dtbclk_dto

Samson Tam (2):
  drm/amd/display: add public taps API in SPL
  drm/amd/display: allow chroma 1:1 scaling when sharpness is off

Yihan Zhu (1):
  drm/amd/display: update pipe selection policy to check head pipe

 drivers/gpu/drm/amd/display/dc/core/dc.c      |  7 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 15 +--
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  6 ++
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 23 ++++-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  8 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.h    |  1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 24 ++++-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |  7 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 13 ++-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 97 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.h   |  2 +
 15 files changed, 166 insertions(+), 52 deletions(-)

-- 
2.46.1

