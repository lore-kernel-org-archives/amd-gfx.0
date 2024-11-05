Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2C8D36137
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F63510E14C;
	Tue,  5 Nov 2024 20:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PuSSOl+P";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2664010E14C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j39zk/KEU84o/UnO7yp+cTnU+EFKNBWkGHQ5/ZxzujplLSKZsqpauSdt36s9ajW5FXDG4oJg5cIOkOX8BEyhd/MCVWengAvlQSwx2+I06oZvGws0+DWjKkDPSyMuaNzhc/i43nhSrvdroE10SKa4CqmvGtuPk4ac1SaGeNLcdvZWe3SkOHsgKk1bcN6sOnp/ehriApUau353jSy1r5JFXwWP1FtO6YKv+hxEP8S8sqNz3yj4ctjnbh1bv2kvwU9PsfZhwZtRA5IjNHlh72C5h09oSeaxKsplPBvB2R5r7DWHvWbF9WYsyPvmNGAZskQnaOd4UsjR4cMnWBozbijqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+wvGynZ5GLA9QeHQSHYvdZyqOf7NOm6JQsebJtOVuQ=;
 b=zHMABIZeCuvGoqDeptfLDBFy+nce13xACkAXvFmcHiLJeT4RVhcSxdk1447b2cnSWfLGyn2zdks4g2onsG97orfiBZJy3zvYGXeU2dSzb1e5bdS5wXlxNVhZj/kc8H88MqS4OglXkFW1urwQoDfPtZVBU/jKzeGqU+tmqoIq8RdSUK+f7zxrbqHP0hR+xDlz5BFNbuQSNp1kVEJnmgqY9T+fXoPwIyt9nwvgts8ky999pP3SJ7lPNZdl6KGY1e7pkHrfFwebI6WReKgLD2HWFzuvQDBoIYsZxBSheW8FKRt+CS7zRe09swIMTXUx5UCF/SKR7rmwb9pwowPSQA2rIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+wvGynZ5GLA9QeHQSHYvdZyqOf7NOm6JQsebJtOVuQ=;
 b=PuSSOl+PIrv4P2jcWHnSozFMaHvMOFPYoMpLAYzPWr7gn8Obpp1P9iIVWBD+F4QhT7cvOFVHZHMfrei1AhqRkgzTjSgToG6IoapHWQPB1nOtbBD8aR8XiUnw4Qlbvu7PrBW/+LANgXz/0Z0vRsyT05Rdh0bnfyLs9SwUsQjIpL8=
Received: from BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:05 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::62) by BL0PR05CA0020.outlook.office365.com
 (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:05 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:02 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/16] DC Patches November 5, 2024
Date: Tue, 5 Nov 2024 15:22:01 -0500
Message-ID: <20241105202341.154036-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 92839c1c-2552-41f0-9ec7-08dcfdd7cbbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZX9ffGeRxZvfKIcTfiON3nwD3/r0cLBaQ2V+/vX2SMYoZKcWdjFIM/pLx4jE?=
 =?us-ascii?Q?v1x1DKHl03rKpTPRTHXvvLiQ64ilkI5QCrfgobi4/Qn3dlQg+fMmUHgHcdcR?=
 =?us-ascii?Q?ixFIsI0CfAFrHBa0FJG09A7ePBGphvsV5D8PrebkscMJZqDciSl2pREmu93m?=
 =?us-ascii?Q?LiA9gwpj92M8UbDWEycoHVRjbkF3JO6Jkqnyf4iyee/dIM/gAtkiqIf3ECWa?=
 =?us-ascii?Q?VV2R9B9CZMW51YJmyAJAcUmgqkDzQ7zuTekZ3eydRc6ei+W3/haHno43NPKb?=
 =?us-ascii?Q?2E3twUmzxN8vgMx9fTHCm0Hh/HWB11jx9oDMu/zWocMBD/x4leXzAcLo2pDx?=
 =?us-ascii?Q?xX6wWW08OkNh/9egRpnlelxjI9uaaEgBsxeQnX310Nm/HyAYLhl3abMy2aZC?=
 =?us-ascii?Q?GmdhGfClvuxNWxK4EKp6Mbs3H3/oNNyquP+St9ScGpNAelcGDvthF46iVFx7?=
 =?us-ascii?Q?Xa3NlB6xGxJEO9BZjoLc9XhewXB/4mTIB/zcWvDcso+VLSpy+1SbWOTwf8Nl?=
 =?us-ascii?Q?RRyXboPZbS9qwKwBAxZ7pWB7JVpEU5PambOmXGpbe5LcE9TGUQpwxRv5WovQ?=
 =?us-ascii?Q?BwlPpj/MNP8PUM3t7vLQ67VO9sds9I1wBg9GktGVBZ2qaAyVuZNkw9Pwnzu6?=
 =?us-ascii?Q?tSHE2bqOEna5Hhf7sFGiNTXHosBrk8KhNyyeIdVBYcHmaB873cYMiAlsP4A5?=
 =?us-ascii?Q?bc59ioSF3hWlOsBGDRf46ByBDV3EclSeVPxuTNHl+EeHFpUOGrLnU+L7vKOV?=
 =?us-ascii?Q?O/erm/xx91UOxVEqrKdiB/UR0w5Gb94q/NXdWpXl8olc4wvjqXDVuV6AxbhQ?=
 =?us-ascii?Q?lJYScjKaIs/4M1mwvaBdZG+pCDtYb/qsY7Kagzh5B9qSas8hFUWtUTlQGbaN?=
 =?us-ascii?Q?ec+O7RLP/Vhg8xRw4fwYRCQ69120cFy2FT+cxxbJjMynwfGVtj2LGVLCOzuw?=
 =?us-ascii?Q?ForUAAggCF3MfQeGzPW7Ju185wg5/8KtxP5ZLlZpUbc+SLr3Dzyj8Mzik+8K?=
 =?us-ascii?Q?HWX7rE87vKFtpzgm+lJKqwORA/aVDNH0Ye3q1/LRSaOABbxsEXkvJ7+JLvso?=
 =?us-ascii?Q?E2SU+1bx3XoMkHOCFPCv5C6whm7eAqCWw0KHW69H8jylBi2TVKov4FLXsXw0?=
 =?us-ascii?Q?CFH9zhsTzQQjE5LUpPUyfZ0FS/IpTT899XZTun4sItRat4MefjiKcHaMrCNs?=
 =?us-ascii?Q?a7gbDOIvd9q88Dx7S722N9H/oJulevtp/PeBFoQXmBwN+Uufr2+51B+aQaPe?=
 =?us-ascii?Q?+NMHm9GUkFGZIcxtmmV2VpmuRiyV7PP3JY0q7mETPToTGWQzZ70AOlPenTG5?=
 =?us-ascii?Q?ZJ8kEwMM/6QtGdQzoLOb0GB5AKRagGJ3WaZQs2nCAT3lBzsXz9auy2Qn9Y7l?=
 =?us-ascii?Q?U4jxUiGM3mNZUooclsSprVo3ueVCb4EwL0JHKyAaKhuLTJ2V3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:05.6802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92839c1c-2552-41f0-9ec7-08dcfdd7cbbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
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
  drm/amd/display: 3.2.309

Aurabindo Pillai (1):
  drm/amd/display: Read DP tunneling support only for DPIA endpoints

Austin Zheng (1):
  drm/amd/display: Update SPL Taps Required For Integer Scaling

Dillon Varone (1):
  drm/amd/display: Require minimum VBlank size for stutter optimization

Emily Nie (1):
  drm/amd/display: disabling p-state checks for DCN31 and DCN314

Fudongwang (1):
  drm/amd/display: always blank stream before disable crtc

JinZe Xu (1):
  drm/amd/display: Use region6 size in fw_meta_info

Leon Huang (1):
  drm/amd/display: Refactor HPD IRQ error checking flow

Meenakshikumar Somasundaram (1):
  drm/amd/display: Adding flag for forced MST blocked discovery

Revalla Hari Krishna (1):
  drm/amd/display: Change parameters to fix certain compiler errors

Rodrigo Siqueira (2):
  drm/amd/display: Remove unused code
  drm/amd/display: Adjust VSDB parser for replay feature

Ryan Seto (1):
  drm/amd/display: Handle dml allocation failure to avoid crash

Tom Chung (2):
  drm/amd/display: Change some variable name of psr
  drm/amd/display: Fix Panel Replay not update screen correctly

Yihan Zhu (1):
  drm/amd/display: update pipe selection policy to check head pipe

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 140 +++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   5 +-
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   2 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  11 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  19 ++-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  13 +-
 .../dc/link/protocols/link_dp_capability.c    |   8 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  16 +-
 .../dc/resource/dcn10/dcn10_resource.c        |  13 --
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  15 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  35 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +-
 20 files changed, 182 insertions(+), 115 deletions(-)

-- 
2.46.1

