Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B8CD6C2B9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 00:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0EB10E06C;
	Wed, 20 Nov 2024 00:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQSwdT9V";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB4610E06C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 00:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUx0999DR2psZNSc6CuF/VL84T5pVLYdgJTsXsaWewAOJWAs9jlEdvaOZjCmj+HBwXnZx7cdcGT8SlqpZrxZCb3TDvEZzaMSfpeh9HsjPziWj/JAo9e+p3vHgHnrrjJn5F+kchZVwktR8CKeSIoGSsXSFGMULlSzCFQyJ2Ix/8gNGtUh2tHRb1oaEdWnujDBs3gfabOw3shngkykSYA95eUixyGgjyyTEwTZkR/pFqzRWhm/bbYb/d2AcnQXH5W002Dlj4JOtgeldd7vKHKFAfwhF6gyeiFcm976xSqgkWB13/XqlKJ/MKV4QMl601gkqjlYQvaftu7ut4YLlAAmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33haykMA+YWQApu0/m0I6ZZGJ3mpsM7QBFSPfUI4HH8=;
 b=KIoaTdWXFK6b/k9dyDtPdAhvH9PW+kmEH3SSgQt9zIDzw77jhaDOjK9cQFR7kJdFjK6MT95wgnrbWNVKBxTNPaDemVG8vYNkbomclcAKuSEpUaYl39yQoAxisGMnQU8niVzVT/EbJgDaUGSMlhN/Kw0JNiehd6dlC7sMpgV9qllrUEg0awPGW/IegQTmJcPnURMYKXhrwwv1u+YJXG0OwbhBoQn5Im8PHdTJaNGCtZMRO/3LQkipTObBd8vqo2XTQsNWJuO1LYTkPeIMRa/JJn38CJe50Nfv+sW6jdGuUgFpSXMz7G2MiR82v/lyzAFcRiXRIxhkV2L5Ptq5lTSKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33haykMA+YWQApu0/m0I6ZZGJ3mpsM7QBFSPfUI4HH8=;
 b=MQSwdT9VDskN8nodVQQh9bbvxTm1eg8xU7b5p8t7puyvFp6B2/WUVPtF+s0v0lEGO1k0pn7cA9wkpQT/DTVbKrk6ApBU48NlLc1FRbxSWzGZLdEkCCsRRN9W/MyCKROXlw/n3alMJetpJ2gEigwEW9JXHbnTAiUcM/+v9Fltvhg=
Received: from BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 00:32:40 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::b7) by BYAPR21CA0025.outlook.office365.com
 (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Wed, 20 Nov 2024 00:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:32:40 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:32:37 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 0/9] DC Patches Nov 19, 2024
Date: Tue, 19 Nov 2024 17:28:28 -0700
Message-ID: <20241120003044.2160289-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: baeae130-9acf-4116-5a3c-08dd08fad734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5yZ5Qleb0ZRhFz60Xk8lDDVKRvvnrROwpC65dxGaha2c3PXhvDSGEw5JA4fb?=
 =?us-ascii?Q?Bv2b3qSIRxfua2QxG8Z7QRhSS0KhTClcoPGRF2yx8iYwidqsulMoNMvE+KaZ?=
 =?us-ascii?Q?sa6EJhYfQ8HTRvMc2fSTd6DccvhnkxEffKTiNy5ZIVIKhKpGSKqRTqsHJdus?=
 =?us-ascii?Q?Eu+3s39twIi5xhPRkm6F3EwgjYdJQ2HLTBizNInWDf3nTCAvDD5wPqZ5CdXS?=
 =?us-ascii?Q?1A6eE6JfOgncKdAHtCjWp84i2HpLV54UUtQwJPU0NovkGPpQYyZ+PvP0bBIp?=
 =?us-ascii?Q?05x1Sa9sSy3dxAjZuplJbL8fdOSPZTXTFG6QfnlEGudbqg+LpEwqUtX1q2FH?=
 =?us-ascii?Q?KYAGhI+b/zi/DoMUJXtxv/YVq9tAsCHgS7whgIYMorrm/IRhKXXR3Ezv3rSa?=
 =?us-ascii?Q?G5qq4SnNRFz2gGENCtDmDWr1zWskFlrRCK4yEjvHfKcNgbAB5EpywQ1wlbtJ?=
 =?us-ascii?Q?EDYc69exs18cgj5jaiQMfYhfgFdNkaGG/VlQXUuuA5hw/5hwVbMj2Jvedno4?=
 =?us-ascii?Q?U0zepCaBHtX4Pk3TIAjmHijqv33Opq5q7MFT1Zn1iOrMdtUE614WyHqMk35L?=
 =?us-ascii?Q?JvmEeV4gD07NVJ9v2Og46OiwI0Olhq0xrEskdZq1hBsmvqC0ZP3x5IdECV66?=
 =?us-ascii?Q?YqGCLMLU9r/VhFtG0fYKmNDUOXoKsTdcbIVrXp2HcOZ8qm8wpWk/sTWyLVuL?=
 =?us-ascii?Q?4G/vSIR/ned5mIgAaCpHC/bFoErec90WcvYzgcA83FKkaF1/AwvMwFqlT6er?=
 =?us-ascii?Q?i5E7ThRPBuUoeOnLW0GH1TMejj0iQcXIwED4pgMqR8SQQPgkRxn6jQF1NvHg?=
 =?us-ascii?Q?uB47PXsI6ZpJUZodVrgrDIZomeR26S/PsrJRCbiXXJizXj94EFhehaAT99o2?=
 =?us-ascii?Q?bxzJdO02cpGjjYkvPn5DfDIpVj727WWODDrE6iiTd6LjLTm6Jk1VoF4UtHkt?=
 =?us-ascii?Q?jLETlkcPV+EP4YNKbs42w8nVURfuBPEP2Ilu9xWujW0esS4hdnpopwHAUmj5?=
 =?us-ascii?Q?KIilGA73Knsgg7frHB86RhiJAGtZcrvZE7azCry7DVP9eH/jCM3IvqIgX1oU?=
 =?us-ascii?Q?7LitZlMapGBFh4+WfO7TH1CNjLcgG4IuWHeibjSPQKfTeNLodkQpCx7a77Ot?=
 =?us-ascii?Q?3HYmH3WmiBnpGfluh4AJnf/I1Leyfa44hHfK/hjekFr33/Uj+A0Uh9a9NIVb?=
 =?us-ascii?Q?uFIzrWV1SkevWsesyFMEcHIIihPFcUzjgmlRTZ7yYJHXlOJ64Cj+V2YyTxv6?=
 =?us-ascii?Q?hOBVWmlHE+gIlT0HWFBLjAh3qrzBJnCVY/XsIoYcrTeheTuqZKVjNI3MdRxt?=
 =?us-ascii?Q?hZ0WtP6w2VHOC/wqDurlz5En6+pPbRHB7664uAW7X/QcljpWIp8tzO9V+idv?=
 =?us-ascii?Q?EFcEXxPtOGxy9xxwNGpPSj+QZzQFgEGuG9gZ0kug7Fj7w2cKkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:32:40.0138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baeae130-9acf-4116-5a3c-08dd08fad734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* Add hblank borrowing support
* Limit VTotal range to max hw cap minus fp
* Correct prefetch calculation
* Add option to retrieve detile buffer size
* Add support for custom recout_width in SPL
* Add disable_ips_in_dpms_off flag for IPS
* Enable EASF based on luma taps only
* Add a left edge pixel if in YCbCr422 or YCbCr420 and odm

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.311

Chris Park (1):
  drm/amd/display: Add hblank borrowing support

Dillon Varone (1):
  drm/amd/display: Limit VTotal range to max hw cap minus fp

Lo-an Chen (1):
  drm/amd/display: Correct prefetch calculation

Nicholas Kazlauskas (1):
  drm/amd/display: Add disable_ips_in_dpms_off flag for IPS

Peterson Guo (1):
  drm/amd/display: Add a left edge pixel if in YCbCr422 or YCbCr420 and
    odm

Samson Tam (2):
  drm/amd/display: Enable EASF based on luma taps only
  drm/amd/display: Add support for custom recout_width in SPL

Sung Lee (1):
  drm/amd/display: Add option to retrieve detile buffer size

 drivers/gpu/drm/amd/display/dc/core/dc.c      | 18 +++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 42 +++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c | 10 ++--
 .../amd/display/dc/dml2/display_mode_core.c   |  1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  | 48 +++++++++++++++++--
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  7 ++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +-
 .../dc/resource/dcn20/dcn20_resource.c        | 23 +++++++++
 .../dc/resource/dcn30/dcn30_resource.c        |  1 +
 .../dc/resource/dcn302/dcn302_resource.c      |  1 +
 .../dc/resource/dcn303/dcn303_resource.c      |  1 +
 .../dc/resource/dcn31/dcn31_resource.c        |  7 +++
 .../dc/resource/dcn31/dcn31_resource.h        |  3 ++
 .../dc/resource/dcn314/dcn314_resource.c      |  1 +
 .../dc/resource/dcn315/dcn315_resource.c      |  1 +
 .../dc/resource/dcn316/dcn316_resource.c      |  1 +
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +
 .../dc/resource/dcn321/dcn321_resource.c      |  1 +
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +
 .../dc/resource/dcn351/dcn351_resource.c      |  2 +
 .../dc/resource/dcn401/dcn401_resource.c      |  1 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 37 +++++++++-----
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h | 10 +++-
 .../amd/display/modules/freesync/freesync.c   | 13 ++++-
 28 files changed, 223 insertions(+), 28 deletions(-)

-- 
2.43.0

