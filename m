Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6949CC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 072DA10E2B7;
	Tue, 11 Mar 2025 21:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JAH0jHDK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7CB10E2B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXLPhUByZmfxdecXvwToUO4gd9r1FefIbfandS+uUJeRru+dTnFtcoqeTGfyoLKhBLdycxfhN46Ko9VaegwB2E1+e4K+ehI9Vy+Ang8bmvCedFLGJrDCO0ymvT5+W8Ca7eTAHFLDXRfqsMjHLFWocGmkjnL9GvFiL7bkyfsyhfJdR9TKKUT8jC5OBJgJffwjBCYHlVaggSuRkknZcDahDaVsMBmWz9zUqhSEIKxpGaIbyJQX0OWA7HffIMc4jvjhVy1KRLdZ4QVcEmiJi7Gxhs0BjdfktXTVJhBi+/3KHuNUi3PeShXTsj4Y04ycYc+wch6RPw35K5ysGH0+aRqJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alfQODlDjNXikvHMnB2XfRQFbnmvyyzsreiExmv/vvw=;
 b=OOtx5xf3RTTVyr/p4dntJjAgsJ4o+LSBjEdWZ81sXT/awPRzmJKT5DwoB1aJmxJVr1g8vUYogtY6iEpuy8ffX3vtwOm8fQmm/33KwCj48jYA6HGQaaDLHJHqA+lEjVo0I6Mq7xXOdklptKC9qORxSKWN9cU7KXbOeJy14MebLS53We8Stp3YTzbvnyZHXhG+CwYscgQ+ET3gEk7soBWgm1HEFgPNqj/3d+PF+6KHhxWT3UuS0uKZKhGp8bHtO1v7lc3+tfOQvO3wn1tFzhzw3sU/bVr2HF9BUBgH2ub05om2CQl11jPAqvFkvg9HC0+olmGcMTYctGIeFlkPjvWnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alfQODlDjNXikvHMnB2XfRQFbnmvyyzsreiExmv/vvw=;
 b=JAH0jHDKxsguUIUmaSACNYT1Hx2QLQj4XmO0coB8Gcc57HIoYIw8uGxIPdBVftEEUhunMh1Pex9M7sROhaokwFVT4riAfWH982WEQYrpc/cmNb/nfsQ1cgWlmPlV8RFLmzS5Rp+Vw7gRku1W7UQIKmlJC412nxd3itU+A3ovPTw=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:48:52 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::99) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 21:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:48:52 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:48:50 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/11] DC Patches March 11, 2025
Date: Tue, 11 Mar 2025 15:42:01 -0600
Message-ID: <20250311214618.3106637-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b09e284-4254-4768-eadc-08dd60e68393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/UL1gHSJyTnpuWrA2vSvYC7KEPqQSOI5iEiYUtf5vla5kY2Mytd6ukLMSviU?=
 =?us-ascii?Q?5rpKzSD+r/bSQuRQ7nZqYLKml9l3VsPHPpf1cXsYKT9kypYGeJu8+CnJ99hL?=
 =?us-ascii?Q?hPCPxQWFV8moWcWH3ZUhX5lxd5GJv/a4dF/iz+ch7SPxwtgHjW9YE4LE/Ceq?=
 =?us-ascii?Q?ydbHgPd1UBuXf6O19Eaeq2orv+8uO05MCnXjdGGGKuHZf8CtXcHjga60/kLs?=
 =?us-ascii?Q?So8kTqNzmIJFSi22siPRT6XaSUTclj3T111LOtxxN5vPPOhuhsxMTVjZPOw+?=
 =?us-ascii?Q?2UsJNSVaY/U902eMcsHqFNPyBbzrT+vnpsGaoNH6pMn8wlJej4fsY0LWtyEQ?=
 =?us-ascii?Q?6F14EDdu+0vqCu/4nHCwgd7OE61qPqRdDmJOMpfnzslLXCOnd2WnDBpitGTW?=
 =?us-ascii?Q?Tq5Iub6R0lvk8ObX7yX9x5wIJ+IRPdsJCkMXV1hZvxw4hNFRa4DMZXd3RQeb?=
 =?us-ascii?Q?voE8iNBJ0sIi0V3PKWHqrwVHURNZp9Esq1+QeZA094VLzwjUUchuYuD5mC7R?=
 =?us-ascii?Q?+jIVtmcQ6FQTCr+Rz51/wjFblengSTh8aEdjgacUXCKPYeq0pO6yCjzsKHP1?=
 =?us-ascii?Q?d7OVX8bDfj+gesKIFPh5FlkG7z1Ws9SsTGzXb4FpR792F0wM8C8Y0IS22UQl?=
 =?us-ascii?Q?MGgRqlJBGJPkPYKzqvQbLXpGZwNQUM9uJST/N2luTglP9bEjRU8PllcGEc8u?=
 =?us-ascii?Q?tMKPRFLlBAb+Hxm8KRuD8WR6w10Z4cgzGQVSiyoGIGTOyfXN1Ixf7qPdtToW?=
 =?us-ascii?Q?CJFVMA52W91WcVByNphtHGBZYLodszdsWX4RV2c+gieOVCgsxtR4xLkvKnku?=
 =?us-ascii?Q?VDmdEBKssC6vXKD5CzqJ2jGaadRLqw5Tt4gwdmaZZeMOQprZU+I0GOFOmjh1?=
 =?us-ascii?Q?8ia36Oqnx5loGyMGRVOhxZcfIo1b2kxUzN6dUi1YEO0PzR0LvMYz+/YdGTRQ?=
 =?us-ascii?Q?nTcdo3kYxeecBOrhKUa2/aHwmaBYEcOdsy+s2k4BTrmkIFWSmLtRNhnCXE+X?=
 =?us-ascii?Q?6etMIew3O/NTzEP+i0emayHv7cKBPXcMYwy67TIRqdQbEkhBbfTFIyb3a0hX?=
 =?us-ascii?Q?CKgd1LYh5nIg9143gxm9/UY5FmiX5bKkC62+sohIiHyrWKYeJrchFVPMYivA?=
 =?us-ascii?Q?yXDFdYo41vrQAS0zLgvAd9Uu1BYQxUJs/0wRII0IebJgoZFX5MU/KomFtB1+?=
 =?us-ascii?Q?yovq06/gwflyXFsduYN67yc8aVmazfcpJeCyfJF7myhSWxLWjkGzLQ7yGZEy?=
 =?us-ascii?Q?/lRGOolSF9zRFLeeS6j2hwwlBI55ZY9IXSasToBj7gXaCs4cKl3ArQJqWFGb?=
 =?us-ascii?Q?QzonxcHm6HSw/mNVix7NCbUqD6rSYf9m6jA0obTdubjoOLVOROR3GT40mkcQ?=
 =?us-ascii?Q?ljOasdMwXhhOyiInxrPDGtGF/Bh06lJ/7rE+VXvl9aRM1i5uDGWOPsgoylBs?=
 =?us-ascii?Q?CNWjMpoZu7sKHoxELv0sdakmuB19FN4HhoLWamiUZg0Qf5B8/bzpGp9ky9Pw?=
 =?us-ascii?Q?57LTBVJkl04M8vY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:48:52.2263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b09e284-4254-4768-eadc-08dd60e68393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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

* Fixes on DCN31 and DML2;
* Enhancements in DMUB;
* Improvements on DP, eDP and others.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Check pipe->stream before passing it to a function

Charlene Liu (2):
  drm/amd/display: Update static soc table
  drm/amd/display: Use DPM table clk setting for dml2 soc dscclk

Cruise Hung (1):
  drm/amd/display: Change notification of link BW allocation

Dillon Varone (1):
  drm/amd/display: Revert "Support for reg inbox0 for host->DMUB CMDs"

Jing Zhou (1):
  drm/amd/display: Guard against setting dispclk low for dcn31x

Lo-an Chen (1):
  drm/amd/display: Fix incorrect fw_state address in dmub_srv

Mario Limonciello (1):
  drm/amd/display: Use HW lock mgr for PSR1 when only one eDP

Ryan Seto (1):
  drm/amd/display: Prevent VStartup Overflow

Taimur Hassan (1):
  drm/amd/display: 3.2.325

Yilin Chen (1):
  drm/amd/display: Fix message for support_edp0_on_dp1

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  20 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  13 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  15 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  18 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 185 +++++------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 -
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   3 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  11 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  19 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +
 .../display/dc/dml2/dml2_translation_helper.c |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  17 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 -
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 -
 .../dc/link/protocols/link_dp_dpia_bw.c       | 193 +++--------
 .../dc/link/protocols/link_dp_dpia_bw.h       |  18 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 132 +++-----
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 121 +++----
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 299 ++++++------------
 26 files changed, 362 insertions(+), 734 deletions(-)

-- 
2.43.0

