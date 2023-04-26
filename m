Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A407C7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103C810E1DF;
	Wed, 26 Apr 2023 16:27:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B1810E1DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDIDvjjiClOFaBGRW5ShFBLzvDbJ+8HfMc9TCpoYBHQcO66c7zdUEK2p8jv6C+jscXv2xPsPdNItmnOvdZ9VE2jYpkGWYtjqax/3h4EjrcKHHf9iQfNXgRag5X8ahIZVWKGDz2g0Tmf0yK7uq8i4S+RfEo+ieWiT1w4XzVdTeCCEwUdt5nSRkhOFxRyZ7QKN/wBpktaeMYxcQ7uDxvrSi5j9S9nc7niRSNlENkThjzbvui9yWYeSeQmNio6E/R4br2zENBB8vWcong5zINsWMvG7si77/RWLY8Nt6dZ/Le6kqR50tnvm9l0/J3NhoN8/scPUmFngiyGSBP/Ml7c8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmca2gJJTbp8gg+7F0IBfRLCawZiF2yqA+HRMlHLTAk=;
 b=jDqsAb5QKNrJctLRqOmxsP4C1VxgR+mQ6cQvVuwT9Zix44B8vMEzFhBSErnPIT4CEj/bw9VXrBi4NvAT+DLb06ekIHXwEXNqoeZB7nNyQkSKaBMrRY0KtpW8IknbLHfV1OGZhu3L9/iXwulLL3x3FpQwvoPhYAkaKnBWHHYbsP/nKAORMmfD4Oirapb1y7zW/NVp487vXMQJZ7FTuYhQBgEnPF179UtE7B7YjoHnayJ0kitl5B3W10Lv22FYUABnQ6BC46/6YX/O6WxFHjgeGpJrrI18ZiFbEGDwsEbxoT4u6iQzq1sQDIfMnNf9yMM/IofkAiwLpETqt65BbMJmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmca2gJJTbp8gg+7F0IBfRLCawZiF2yqA+HRMlHLTAk=;
 b=F28bp7o1aMQ1ie8fGozeREUYb5bddCd1h3/N29uyFHMtRJ9QC2hbyiAHKQVrfajx00PtRt6/xRIWDDx9jjiNTg9/l5vMNV5ZBDFBJlLRbwV+a2jCaNSQfrWFAHMt9QdI8ENU5zxwpzxsdySj7SFjJkfrU2kEIeJgKyms7Jl3ksI=
Received: from DS7PR03CA0074.namprd03.prod.outlook.com (2603:10b6:5:3bb::19)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:27:20 +0000
Received: from DS1PEPF0000E639.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::4a) by DS7PR03CA0074.outlook.office365.com
 (2603:10b6:5:3bb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Wed, 26 Apr 2023 16:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E639.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Wed, 26 Apr 2023 16:27:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:27:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:27:19 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 11:27:15 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] DC Patches April 26, 2023
Date: Thu, 27 Apr 2023 00:27:04 +0800
Message-ID: <20230426162712.895717-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E639:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1963b374-28ae-4861-460c-08db46731b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbtDtC2nF3jAMHDg5LuKxWI0VDW1VtBz00Gl4Sc4PTziQdziCz4skHCRGGomBUJ+3do4+5TFqH6G8ixMpt1LKEG4PDvd47vqHUpmblxCrmNu/eh1wGxwnUFDmU0sgdv/7ODo7vGZiSSU1SPxHz3zMHjdXLxJyBtTaXFrEbXiWo+TcvbFLOeRT/mS8/+Ks1YVzkV08jQt9e43DbdILQGML/agTerQCpO3OWrY4GmuyEQdNz43W6RDQEu4aUF+OorgZ3cx0RkojqASd2a+a/fRLvAlwJU5tGDiQVwhZxTfIlICQbGdPrZtkNrh4GNJJL48vf4vjPWSJIURW79+tEWsGJvz+lLzeteGoii4G+CQWgS2hLM2RXLtpu0neuCW9qzcnVBxeT8vAlq2nBFMTirsiRw9no0uKTX9OqM67wVzYpsw5SDYWihBTk3qDtEH1Q6jblZMlOsY23iILc0ddJxrsVedtAZ6K46D6XwkThJL9TqLv45u1zsFgyf3PQqnZdtG7Pg5OOCxdPS9Y2Te9PYTtFo7OOb7HmyivQb8KhPpH5Es3Pcy9rxgmtxhIk7OcY7WQPUIoFHD1pqgaLikCT+0feBL4sfS2wIj+vSf8ZrQbpW9uKRl0rW9MFv3tAI2weInovev/7KADX56YITZ2MWSpxbiLBcG4AFuj1yQZkUiZATdvKQmLjGHscRLBt/mXUKQwZZd4m2q5UZGLk+GfLe9YGjMOGYJKbKdh9Hm8oi0PRQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(36756003)(86362001)(40480700001)(40460700003)(54906003)(478600001)(6666004)(7696005)(8936002)(356005)(8676002)(81166007)(41300700001)(70206006)(70586007)(6916009)(316002)(82740400003)(2616005)(4326008)(36860700001)(83380400001)(47076005)(426003)(186003)(336012)(26005)(1076003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:27:19.7933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1963b374-28ae-4861-460c-08db46731b72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E639.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- FW Release 0.0.165.0
- Add w/a to disable DP dual mode on certain ports
- Revert "Update scaler recout data for visual confirm"
- Filter out invalid bits in pipe_fuses
- Adding debug option to override Z8 watermark values
- Change default Z8 watermark values
- Workaround wrong HDR colorimetry with some receivers

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.165.0

Aric Cyr (1):
  drm/amd/display: 3.2.234

George Shen (1):
  drm/amd/display: Add w/a to disable DP dual mode on certain ports

Ilya Bakoulin (1):
  drm/amd/display: Workaround wrong HDR colorimetry with some receivers

Leo Chen (2):
  drm/amd/display: Change default Z8 watermark values
  drm/amd/display: Adding debug option to override Z8 watermark values

Leo Ma (1):
  drm/amd/display: revert "Update scaler recout data for visual confirm"

Samson Tam (1):
  drm/amd/display: filter out invalid bits in pipe_fuses

 drivers/gpu/drm/amd/display/dc/core/dc.c       |  7 +++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c  | 17 -----------------
 drivers/gpu/drm/amd/display/dc/dc.h            |  8 +++++++-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  | 18 +++++++++++++++++-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c  | 11 ++++++++++-
 .../amd/display/dc/dcn321/dcn321_resource.c    | 10 +++++++++-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   | 11 +++++++++++
 .../drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |  4 ++--
 .../drm/amd/display/dc/link/link_detection.c   |  4 ++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    | 10 +++++++++-
 10 files changed, 76 insertions(+), 24 deletions(-)

-- 
2.34.1

