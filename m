Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E68FC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018B210EAA4;
	Thu,  6 Jun 2024 21:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lBwnPe17";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F90310EA95
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqr37N08+NRGwxEXzSrWrz9c8pdM5ogpU5R3vDcODdZWTcQEsbrFOQY/Fb6mgQpaacsgl31F4HfIjVIEwEL7di4DhDlhKpMMWM21Y0DusNEzBoQAdOV2mT3sJRHaOMjn/0zsamjOOlCjpuBmRGEe/UdNpT0xN9RquGe5X0Z98rNEhYS6ZJZ+FZFDM2kIRtOVON7/pH+O5zEEOC0wOX+FxfoR2beCsiDkpxviciI/efu6+0LEO9AYx8CEoLslYlPLucR/UcUf8n3EygMwazl2sK3AlEnDj731BSavPJjWMll4BZK4lpQLgVTB13nTD2sYAYPM3nx8EQnAvuTTucoH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZHhtddHqL8QC6IWXMov5o0CvpeXKqaQ0Z8slAWgUmU=;
 b=nJSJn59drTTu0uHJLp1/8YhdHZXyuIEyYYX1/PPUHReeUgdpRvKRd60Q8MT1CzhSF42k8pkPjDY1TrNyqIhZ8Ejmogi8KJ9nEyC6DT08VAWwZRaG+XoltzEzAcNSg7fD0DGncckd4xPoe+X981139vClwWuGnjvj066L37S97RjR+gtiqPaddWXIF2OdG+vBy7lRtlqZnIUdiPkKbkchlCDy/iLOhx5JFRuojGN632VaaMOYESlS47KdjnDOY++heOzwOOmTj9956T6yH90JCph2dzl8MN8Xpa0L4hX3nSxO/9HDX8kZmspiN7p3Nx+idQruKbhgA5ro3gn8ceHslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZHhtddHqL8QC6IWXMov5o0CvpeXKqaQ0Z8slAWgUmU=;
 b=lBwnPe17j0C2sa9ECJzrjs2ZB7qdQSGd1Wlcc8vu1XWeVPXYO7kA8cwyeSyAxvo5ohMrO3MkQpfEm44e7D9PolIUpSyE2etWh3a7gPwwS1sFQwUiaL6SLf2+P5FdiJFHzUkZMJZcrqmvH5sTOXFsHvaJLm3AyWI5lQjB4Ky+OIg=
Received: from SA9PR13CA0002.namprd13.prod.outlook.com (2603:10b6:806:21::7)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:01:54 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::a5) by SA9PR13CA0002.outlook.office365.com
 (2603:10b6:806:21::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.10 via Frontend
 Transport; Thu, 6 Jun 2024 21:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:01:52 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:01:51 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/67] DC Patches June 3, 2024
Date: Thu, 6 Jun 2024 16:58:21 -0400
Message-ID: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8360551f-0db1-4253-7bf8-08dc866be42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0oycnJmRmFwVGlubk5wR2FvVWNEdTFNS0wvbU5HM2xzeHlDaWxTeDN3TnJE?=
 =?utf-8?B?Wko0TmJrTktkb0poTEMyalphVnlXRmRrWFBCQTA4aWxNM05GQ2FNOExKUTBs?=
 =?utf-8?B?RXEwU3dNRTJzbUk2WDkxaTM2Sk13b0s5VllqNjB3OUpINldIVk1pdXVxdWZU?=
 =?utf-8?B?ejJBRWwxRnovV2FnRzloVG5iL0ZtNS80ZkllN1pqY3UwNmhWMnlsMmYwR3Jy?=
 =?utf-8?B?WmRJbVFYU0M5WmZGOTRlZTdTMUJOeXNNdEx1dWFtVWtMd0ZaZlNTK0ZzV1BE?=
 =?utf-8?B?aUxleWZGUUR1MmFpVWl2bU4ydUM3MkQyNkNOOVE0enpObkw3c3VYNHFaWklK?=
 =?utf-8?B?MkZGUnA5aGN3eUlISjJ2dkxUMThsbmpzdUVEd1dTTDlUa3QvWGIzVU9HRlBV?=
 =?utf-8?B?WWhUQ1NLem9vOWpPc1NBZm9QbzJYM05tSUNNRGsrY2NFUnYyVy85bWk3b0JX?=
 =?utf-8?B?VDJWZnp2VjdsOTNKNUwzQTRnZ2NjT2pwaTBGWmY3TTFtZ1lMTnpqKzBVTld6?=
 =?utf-8?B?enc4bjVSQWo5VGZlcEFNRytqamhGRlZEYVR5SkZ4Um5POG1YajQydlE2Mity?=
 =?utf-8?B?L2NYbVJaK1VFa3p1UGExSXhiMjhwSllVRlFFTXJuSVRvQ2pDRktqK2pmY3p0?=
 =?utf-8?B?TTNlcnN6bFhqdWNadzcrdkg2UjFWL2pGb2RpMlZYUHZHTGo4YWlBQmhWREgz?=
 =?utf-8?B?MHdEM0hCeHlUZUpYN3hScEhXTkI1NlU1TFNqME1DWVlaNkJvR05OVFVmOEt4?=
 =?utf-8?B?MUt2OThMaWVFckxYT1V1VTlzb3dGRStQZXhtTHNPeXpCdFhMN3F5QmZLZ2d5?=
 =?utf-8?B?b2J2cCtZYWhaOHpVOS9TNnVqNVZ4cGF1S1pMZlp0WC9CUGNYRnRrNWVHcDVH?=
 =?utf-8?B?djdkTi9TK0dYck1hTmRiV0U0ck4zbGFrclV3eW1lRncrNDcwZjVmdk9LUFpj?=
 =?utf-8?B?N284cWJyaDJMakpubGd2T29WVnd4YUxxaU5iTmdXajBtbW42cFNGOWtWbEJi?=
 =?utf-8?B?c3FBRG41R3dCWktlN05vTVBLUTJybEl3RlFUZTArNmpBMURIdGZGU0RvbTU2?=
 =?utf-8?B?UnFuTUJRdFJKb0VEMlk0TUg1eEtlSk1saVlaREMrcFhEaTB5YUlMbzFNRysr?=
 =?utf-8?B?RHc1Yk1OODNwZW9yRElCSVBSaDJXdWF0RDlNQm5VaFBwcFdINWZJR2lLYXlV?=
 =?utf-8?B?d3ZOY2ZUNGlRcnpRYVhycDZDWUVjR0xmOHVhZ2RLM2YvV3l5WnpIQ25od3Yw?=
 =?utf-8?B?MlpMN0liS2d1V3RqeForVFpBNWc5a3FvUUQraUtUelBWajlNd2dYREZ4dDZ3?=
 =?utf-8?B?bzVscW8rSSsycHdpNzZVOHlqQzhtcFlKN1ZXSENsWkplVXpqb2Z5ejkvT2M5?=
 =?utf-8?B?ajV3dzZISEJKbUo1UjBTQ3JTYTFRc1FQdFhJYlRUUmtqUG1CZTZsUkY4akcx?=
 =?utf-8?B?YXRwQStENmRjSm1GbDFmZjd1c0hzUzJFdkFsbUdYd25US2VRZUkvMXRyYkVI?=
 =?utf-8?B?ZHk1NjMwTTlMQVBOWjNMZkRsZG50OUZRSTdVUUpGaWd2aklydUw2MW9VMVN0?=
 =?utf-8?B?NW93ZDU5VUoyZEZmSUMyY211bWtpOG82UTd1dG9ycDAwZ2plTThjQWM0QlVp?=
 =?utf-8?B?SWdlb3NUTXdTN1A3cUdXamViRWpNN1dFa1lrTXRiTHo2V2xDTlpRSnlSYU1F?=
 =?utf-8?B?N25kcVk3Nm80a3RZRkNhLzNUbTBNdzV2T2RTMUx4L05iMHZGUjBra1NtbFFT?=
 =?utf-8?B?dlhGV2R6SmJBSWszUE9sY2JBc0dHbk1XbElpa2o5TkZCUnN5VkxmNi85OU1W?=
 =?utf-8?B?c2E2cFN4QXR6T211YVJqb3lkcnZNdDByS21KUHphVkk5Zm90ajdQbncxbkRn?=
 =?utf-8?B?S1JOTm9lOFp0ZkFRMFhCNU9FVkxvbG5SL2tvOTgvR20zWHc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:01:52.6598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8360551f-0db1-4253-7bf8-08dc866be42a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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

This DC ptchset brings improvements in multiple areas. In summary, we have:

* FW Release 0.0.221.0
* Fixed missing targets in FAMS2
* Populate hardware_release hook for dcn401
* Disable DMCUB timeout for DCN35
* Move PRIMARY plane zpos higher
* Introduce overlay cursor mode
* Change dram_clock_latency for dcn35 and dcn351
* DCN401 cursor code update

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (6):
  drm/amd/display: Fix incorrect size calculation for loop in dcn401
  drm/amd/display: Fix uninitialized variables in dcn401
  drm/amd/display: Remove useless comparison of unsigned int vs. 0
  drm/amd/display: Remove NO_EFFECT self-assignment
  drm/amd/display: Explicitly cast v_total to signed in a subtraction
  drm/amd/display: Avoid overflow from uint32_t to uint8_t

Alvin Lee (3):
  drm/amd/display: Remove NULL assignment for stream_status
  drm/amd/display: Ignore phantom DTBCLK requirement
  drm/amd/display: populate hardware_release hook for dcn401

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.220.0
  drm/amd/display: [FW Promotion] Release 0.0.221.0

Aric Cyr (1):
  drm/amd/display: 3.2.288

Chris Park (3):
  drm/amd/display: Change AVI Info Frame version to 4 for OVT
  drm/amd/display: Prevent overflow on DTO calculation
  drm/amd/display: Avoid programming DTO if Refclk is 0

ChunTao Tso (2):
  drm/amd/display: Replay low hz
  drm/amd/display: Replay + IPS + ABM in Full Screen VPB

Daniel Miess (2):
  drm/amd/display: Change dram_clock_latency to 34us for dcn351
  drm/amd/display: Disable PHYSYMCLK RCO

Daniel Sa (1):
  drm/amd/display: Return after Init

Dennis Chan (1):
  drm/amd/display: Fix Replay Desync Error Test

Dillon Varone (5):
  drm/amd/display: Block SubVP if hardware rotation is used in DML2.1
  drm/amd/display: Add null check for phantom pipes in prepare mcache
  drm/amd/display: Fix missed targets in FAMS2+HWFQ
  drm/amd/display: Do not override dml2.1 reinit
  drm/amd/display: Update idle hardmins if uclk or fclk requirement
    changed

Fangzhi Zuo (1):
  drm/amd/display: Update efficiency bandwidth for dcn351

George Shen (1):
  drm/amd/display: Ignore UHBR13.5 cable ID cap for passive cable max
    link rate

Ivan Lipski (5):
  drm/amd/display: Remove redundant if conditions
  drm/amd/display: Remove unreachable check
  drm/amd/display: Remove redundant ternary operation
  drm/amd/display: Remove duplicate 'update_idle_uclk' in dcn401 clk_mgr
    code
  drm/amd/display: Remove reduntant comparisons by Coverity

JinZe.Xu (1):
  drm/amd/display: Disable IPS when it is not allowed.

Joshua Aberback (1):
  drm/amd/display: Disable boot optimization for DCN401

Josip Pavic (1):
  drm/amd/display: define abm debug interface

Leo Li (2):
  drm/amd/display: Introduce overlay cursor mode
  drm/amd/display: Move PRIMARY plane zpos higher

Leon Huang (1):
  drm/amd/display: Expand supported Replay residency mode

Michael Strauss (2):
  drm/amd/display: Update FIXED_VS retimer training pattern delay
  drm/amd/display: Add fallback defaults for invalid LTTPR DPCD caps

Nevenko Stupar (1):
  drm/amd/display: Fix multiple cursors when using 4 displays on a
    contiguous large surface

Nicholas Kazlauskas (3):
  drm/amd/display: Add sequential ONO sequencing for DCN35
  drm/amd/display: Remove register from DCN35 DMCUB diagnostic
    collection
  drm/amd/display: Disable DMCUB timeout for DCN35

Paul Hsieh (1):
  drm/amd/display: change dram_clock_latency to 34us for dcn35

Rodrigo Siqueira (2):
  drm/amd/display: Use the SPDX license identifier for dmub_replay files
  drm/amd/display: Check otg_master pointer before use it

Roman Li (1):
  drm/amd/display: Add config support entry to replay caps debugfs

Sridevi Arvindekar (2):
  drm/amd/display: DCN401 cusor code update
  drm/amd/display: Minor cleanup for DCN401 cursor related code

Sung-huai Wang (1):
  Revert "drm/amd/display: Handle HPD_IRQ for internal link"

Wayne Lin (5):
  drm/amd/display: Adjust debug msg for usb4/tbt
  drm/amd/display: Defer the setting of link hpd status for usb4/tbt
  drm/amd/display: Correct the defined value for
    AMDGPU_DMUB_NOTIFICATION_MAX
  drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
  drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()

Wenjing Liu (7):
  drm/amd/display: use even ODM slice width for two pixels per container
  drm/amd/display: add odm_slice_rect parameter in spl_in
  drm/amd/display: reduce ODM slice count to initial new dc state only
    when needed
  drm/amd/display: remove dpp pipes on failure to update pipe params
  drm/amd/display: remove ODM combine before bandwidth validation
  drm/amd/display: use preferred link settings for dp signal only
  drm/amd/display: make ODM segment width of YCbCr422 two pixel aligned

Zaeem Mohamed (1):
  drm/amd/display: Remove dcn32_smu13 duplicate header

pochchan (1):
  drm/amd/display: Use TPS3 for ALPM on Specific Panel

winstang (1):
  drm/amd/display: added NULL check at start of dc_validate_stream

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 589 +++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 248 +++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  29 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   4 -
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   8 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   2 +-
 .../dc/clk_mgr/dcn32/smu13_driver_if.h        | 108 ----
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  90 ++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  67 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   5 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   5 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   6 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  12 +-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   6 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 124 ++--
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  35 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |   6 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   2 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |  10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  14 +-
 .../dml21/src/dml2_core/dml2_core_shared.c    |   4 -
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   3 +-
 .../display/dc/dml2/dml2_translation_helper.c |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   4 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   5 -
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   5 -
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |  11 +-
 .../gpu/drm/amd/display/dc/gpio/hw_generic.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c  |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   5 +
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  85 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  85 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   2 +-
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   6 +-
 .../dc/link/protocols/link_dp_capability.c    |  46 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  24 +-
 .../dc/link/protocols/link_dp_training.c      |   8 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   4 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   3 -
 .../dc/resource/dcn35/dcn35_resource.c        |   7 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   1 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  32 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 157 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   5 +-
 60 files changed, 1226 insertions(+), 700 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/smu13_driver_if.h

-- 
2.34.1

