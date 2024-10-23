Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9122D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1BE10E1E7;
	Wed, 23 Oct 2024 04:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zbv2sCp0";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15E010E1E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxF01ocPMTq3sBSiJ+mj347LLGKybLoBh3Zniw3E2t3nrtDrAwuRhx6E6TuymGw8Jma0h8r/WhrdBgoEnuEqUrLQnRhRSorrCbGnn9jLhCx5VxvlSWCxALRx5oaQKCa/5YQwjg4lxYQQhEt+eQpLfCxHeoruQbtZVMF9UxodWpuaWm23AY711M0AZygKnQCwL56Mr2qBBo2+OOZrnM1DyvEnFmzz1SJQZX9mqvK0GQK6P+xSoWqawRNAHOdda9ZZmubKoVvvSoFRSupYcZW7XVdHgOqIv8nKNKJbAwXNe8+r6o8JGY4gP9CY9uT40QL/zcephO1zoXb+sSdV+BnY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkuL0UvmMbVC458VwaBLkNh0yVPYpk/Ll5NBVOo62BM=;
 b=t+aLLGP+Dc0gksxdvP+3sgwlzStZ57ZiJOn67J8FygkoeW9xZsbtUARv0rBX/tTbhoYT5+ooGE7DJN8rlTX1jnnyCvJTDYNRxUmzh3sTiit98gt1oSF18bVwTjW+iVRwgSCJ108nOaiXzi0lsSd/uJpeJdEnCQsOqp+bWOmsYSxcqxvazqiErJ50sIZnqswlIhGE93fwWDm+GjD8/pM/y2oxvmiViJ4tvbTaP5VPdbrqY5niVuaNVpnl8CxcouVdx3Rfoq9J2DtsmTcq1EQYNKYdmrROYRsRSRjWFk87yMbdWzyStd9Fxt/KDzXqH7HOSzDyfVmRzBi9I7MxR902hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkuL0UvmMbVC458VwaBLkNh0yVPYpk/Ll5NBVOo62BM=;
 b=zbv2sCp0yWTf5OAh7Afbf4NW0DzrxCLaOW6IpAriEbgQ3ecn1ekarICBRKl+zJTe0eWFqrF0Qnng4aVyftqzpKmZMIM6RttQkaHJKYugrmjm4w0UwDZ97tlaun/WKofEvh436h3EhHkxUG7trzqfRiRx0AnBZTlM+Z/MYQvwOc8=
Received: from DS7PR05CA0059.namprd05.prod.outlook.com (2603:10b6:8:2f::32) by
 DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Wed, 23 Oct 2024 04:53:48 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::54) by DS7PR05CA0059.outlook.office365.com
 (2603:10b6:8:2f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 04:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:53:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:53:46 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:53:43 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/16] DC Patches Oct 28 2024
Date: Wed, 23 Oct 2024 12:53:20 +0800
Message-ID: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b87d60-c024-4e7d-a659-08dcf31eae5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pkTLX4D5Ewy1kgtF7PZSnNVVlDpaxmKcO42ZTsC36p/8AKEomXRiWBLihscH?=
 =?us-ascii?Q?Wcx8NL9IqLP03Sc22Rt539e6ipHuLR0jCpSKYiWgj7nc05nN+/C/N1+d1tLU?=
 =?us-ascii?Q?88CF2eu2kQ5rFdlsBj65CkbFPDgAlRk0EJaDrqI1erjGeD7KbJsfxz8xOK/0?=
 =?us-ascii?Q?cNiIc7TGcSZ9iHWrh0WfLrfQzPmnPWLM/+wPBRJqkx7vIMNDCG7libooWSga?=
 =?us-ascii?Q?xM8YX4kMuPv5yIFeOIwTrcRIeIZsK2GI5dPgoJEPZHJEcRD6gweQZoNw8EMA?=
 =?us-ascii?Q?F3NitSgBsUd3BgofLxe5xTqc59YRyE/+r0VXcHpzIDiEzL85ckdvCilo+BOJ?=
 =?us-ascii?Q?rw4kkU0HGhlGFzZAk1RLqPz6byIAPzOy8TcxXMM/W6mEAdtjopWSU7u2E9eA?=
 =?us-ascii?Q?FJlbionU/1vYM9V/9GWmNFbOfmwi98uRT/mB+HimWvIz2wTJ+ahTybHeiueJ?=
 =?us-ascii?Q?CIdaieTi36BilK9zoArhrjI6dIEucBXpEl1cpY6tYr86KUDpvX4E5kWWYDL0?=
 =?us-ascii?Q?C6TCzrAVubBqUtFDT/lVWeqN+TtPRIpTayPOcSvKu7eygIPyR1hjDNzy/I80?=
 =?us-ascii?Q?CkicfRLKU3A1S1GMgrU/S9sH0MOWhzq9xwAo/PqjlCuyVUj2t1KkbTyVA7aP?=
 =?us-ascii?Q?1pHeI+H1PY2ah1FbhCTgaGicBFD1TJOLglOcVz6c5BCa1mGu3pXAGbEF7mpU?=
 =?us-ascii?Q?g7hyWLVoD3p0Ofoiga7TbJZ8eHemKz36HYM+lWRgCMN2Hkrkub5Sq+XXOHy9?=
 =?us-ascii?Q?xdItNDSsggvQBfTvpa7iWNXujwCnSCE/v6gkUQQxfqI+ToH8NRpAeu7wFNQp?=
 =?us-ascii?Q?sFPXS+EmyWnpr4htakhd5xdIiNuURaXJbv07hRTduV4X5jLilA83VcSzBEng?=
 =?us-ascii?Q?eVvt/vNzvXDVzO97zKcX9p7SV+LsX+LeAwtQiPwiXrL/OW7Qn5Ep6sMbPltp?=
 =?us-ascii?Q?PhDy9eiXhV/e9vpO+eAit0+vZEBxw+d/AnAhhH0AiFD1S7tGlhs98n6fonXI?=
 =?us-ascii?Q?GbVmalnPT8IzFOo5cKAq97YZmVwNFC+Xg1X64XhwGtniKPy2jtDzST59xMJa?=
 =?us-ascii?Q?eHl/jQsAW+iQF+YeubcGwGyW7/4C3dYxlW3HWNgTOc1JSFmS37b/AhSyt17l?=
 =?us-ascii?Q?k4M0a8s6a+l2cRZeel8wbHeRNO36V45J+9n8yAlU/PjmHZUw9bJ/Eocr/RDC?=
 =?us-ascii?Q?6uE/2kbLo3G0zprR74zzPOqpv4U4/RA0459FwqokJUu2JZpu8TJxz3Na8J8h?=
 =?us-ascii?Q?XxCG0uPRH25t9mCDwTBvSz7eOevxLr7WsLWwTdJJIW4de2nXQCTEBd5UMVDx?=
 =?us-ascii?Q?ici/79e7uQ00Kfu1fbmQCY6UR/OZ9oHFqVT1d3UH75M3fWoh8v0DVu6mYuJq?=
 =?us-ascii?Q?1B5pspMv2Q5dxzowxUKwt/8EaLbROoa6n7ZTMezlwwGWvDrjfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:53:47.8015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b87d60-c024-4e7d-a659-08dcf31eae5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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

- Fix polling DSC registers during S0i3
- Fix idle optimizations entry log
- Change MPC Tree visual confirm colours
- Fix underflow when playing 8K video in full screen mode
- Optimize power up sequence for specific OLED

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Remove useless assignments and variables
  drm/amd/display: Simplify dcn35_is_ips_supported()

Aric Cyr (1):
  drm/amd/display: 3.2.307

Aurabindo Pillai (1):
  drm/amd/display: Fix idle optimizations entry log

Dillon Varone (1):
  drm/amd/display: Add P-State Stall Timeout Recovery Support for dcn401

Fangzhi Zuo (1):
  drm/amd/display: Reduce HPD Detection Interval for IPS

Hansen Dsouza (1):
  drm/amd/display: Add a boot option to reduce phy ssc for HBR3

Joshua Aberback (1):
  drm/amd/display: Change MPC Tree visual confirm colours

Leo Ma (1):
  drm/amd/display: Fix underflow when playing 8K video in full screen
    mode

Lohita Mudimela (1):
  drm/amd/display: Refactoring if and endif statements to enable
    DC_LOGGER

Ovidiu Bunea (3):
  drm/amd/display: Optimize power up sequence for specific OLED
  Revert "drm/amd/display: update DML2 policy
    EnhancedPrefetchScheduleAccelerationFinal DCN35"
  drm/amd/display: Do not read DSC state if not in use

Samson Tam (2):
  drm/amd/display: fix handling of max_downscale_src_width fail check in
    SPL
  drm/amd/display: store sharpness 1dlut table in dscl_prog_data

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.240.0

 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 10 +---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  5 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  6 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 ++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../amd/display/dc/dce/dce_stream_encoder.c   |  2 -
 .../display/dc/dce110/dce110_mem_input_v.c    |  2 -
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |  2 -
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |  2 -
 .../dc/dml2/dml21/dml21_translation_helper.c  |  2 +-
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |  1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  3 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |  1 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  3 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  9 ++-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 12 ++++
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |  8 ++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 15 +++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 ++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  1 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 15 +++--
 .../dc/link/protocols/link_dp_capability.c    |  3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  4 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 16 ++++--
 .../display/dc/spl/dc_spl_isharp_filters.h    |  1 -
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 56 +++++++++++++++----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  1 +
 34 files changed, 150 insertions(+), 65 deletions(-)

-- 
2.34.1

