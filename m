Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B8DC4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E7322AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E7322AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3143B6EC71;
	Fri,  4 Dec 2020 21:29:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7B86EC71
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRwND9JKw/EdSORauzdEcqSb2h89lvH2QgPT7X+vGySM3j/2M871yIuJJfNrtPvUP7ycxYR0cbbyb2MHTnpF438vrPmS/jerQCBxzoh/5pw/XTZHzdsDZyvZgorpURMBv6pCdGDHFd1+divZUhk+v+xXAf1jVEy90Ot0j9vg/DVl1ZAN9ZMcJyeWYgJcyvP23DRkPCBEWxMiQE8q3rCKHVfzaCizZka3ddBmuhQxC3pJmKfoIQPmsbazclgc/aqPyCsesuIQ2xrafNYn0bsvsbKZpU4idG3RcR8pg1DH2VTNizKelXU2N8TRpTyKt+kF+exNkqbDpMVgepIU746Rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Jh/Rfp3mjh19cwWmX0g3QdQWl5Fjf4JL/zFZeXaxpo=;
 b=Zudef333xDGo/QGNjNsoS5JBe0o7aQB1UFDtevF6BSYl5QidWGADxV0QTUDkp8z0H8L06aOUIh3FzmRktyrwZR1LCNjRzX7WJ+TtmYBSknBkil7ualCefhviFoARgnW6S5RUKG2Vv+yuG6o4ZDIBouD7F2QsxTENHrE6aEU7hDkrl8UfzJZwPERUDJyhxwq/1SMamB5kp/CF3ZenGGelDp8ohZV5m/LgzAGt+RD9N+NlRLV4YXvPREjdo561BFZqwecN45wbZaFaKRD/FnqTl78sgYOSjsStsVTkuYUJCqQCMWFh53UbrsGWU4gqvqNLLYFiu0vbMQxZfwVudP7bnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Jh/Rfp3mjh19cwWmX0g3QdQWl5Fjf4JL/zFZeXaxpo=;
 b=TnOkTRUyJZ3p08SCpljW8qdy38ji5mDfpjpHApe1q14SFgQtEg3jorvr8TpH3HT8UOFu4f4o6lfqQIoaAGZ8jxarkWDEOkkLzJ5ZLoa291teEexz5Wp03Zm/s1PzN3r6BtxIAFk1foDniz6k5UHX9FPU/iOlAMqjLJFZmXcu8oM=
Received: from BN6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:404:23::21)
 by CY4PR12MB1205.namprd12.prod.outlook.com (2603:10b6:903:38::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 4 Dec
 2020 21:29:41 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:23:cafe::e0) by BN6PR03CA0011.outlook.office365.com
 (2603:10b6:404:23::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:29:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:29:39 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:29:39 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:29:33 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/17] DC Patches Dec 7, 2020
Date: Fri, 4 Dec 2020 16:28:33 -0500
Message-ID: <20201204212850.224596-1-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26d18bc9-399d-410d-ec83-08d8989bb53c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1205:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12055BD129329D707DEC82FAE5F10@CY4PR12MB1205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: col8NBnkflBc+/fAupVt1oh3C8I0c3OAhSTo0PssMBGQQaqZ8NkNwbjUiAF+XTUNT0dGK3HxNfu/EDx8Q/mr7s3xPk6EDt/wqtuiy3E40JcZb650q5HA1CU4rFEATgJoPkRqlfbX5YkyVK4bMD59TVdUK9o5vuyJeOaDtUFojyWRTLqyJo4k4WAw1vDpaKeKMJfKm7ip4nkOndTeGwzLtceDz8LvnJrCScY0WyplLoiPJ2A0vL1ptDDaTC74vJqAT/l4PYib3fP3DHPmB6uxwOPSlfBA80miuMC6Mz/lLxTvMMHa+MN75DlWGJdqtb1uGEIWmwyld5Y6RRHFxCVKxkz5K6pW4YENBcoY18HyjvPH1hdC72MDKcWQMRzZwcjGaBXE7p2a2YfLUYQ4v2LRMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(186003)(47076004)(82740400003)(5660300002)(82310400003)(356005)(81166007)(70206006)(86362001)(2906002)(478600001)(316002)(36756003)(1076003)(83380400001)(6916009)(336012)(70586007)(44832011)(426003)(26005)(8676002)(8936002)(54906003)(4326008)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:29:40.0497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d18bc9-399d-410d-ec83-08d8989bb53c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1205
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Fixes in MST, Compliance, HDCP, audio;
* Enhancements in VSIF;
* Improvements in seamless boot, DPG;

----------------------------

AMD\ramini (1):
  drm/amd/display: Set FixRate bit in VSIF V3

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.45

Aric Cyr (1):
  drm/amd/display: 3.2.115

Charlene Liu (1):
  drm/amd/display: Enable gpu_vm_support for dcn3.01

Chris Park (1):
  drm/amd/display: Prevent bandwidth overflow

Dmytro Laktyushkin (1):
  drm/amd/display: Expose clk_mgr functions for reuse

Jing Zhou (1):
  drm/amd/display: Set default bits per channel

John Wu (1):
  drm/amd/display: Don't check seamless boot in power down HW by timeout

Judy Cai (1):
  drm/amd/display: Change to IMMEDIATE mode from FRAME mode

Michael Strauss (1):
  drm/amd/display: Revert DCN2.1 dram_clock_change_latency update

Qingqing Zhuo (2):
  drm/amd/display: NULL pointer error during compliance test
  drm/amd/display: Only one display lights up while using MST hub

Reza Amini (1):
  drm/amd/display: Implement VSIF V3 extended refresh rate feature

Roy Chan (1):
  drm/amd/display: Fixed the audio noise during mode switching with HDCP
    mode on

Sung Lee (1):
  drm/amd/display: Add wm table for Renoir

Wesley Chalmers (1):
  drm/amd/display: Use provided offset for DPG generation

Wyatt Wood (1):
  drm/amd/display: Add support for runtime feature detection command

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 +++++--
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  93 +++++++++++++++-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   2 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    |  10 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  18 ++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  17 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   5 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  |  62 +++++------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  |  38 ++++++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   6 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  17 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  29 +++++
 .../amd/display/modules/freesync/freesync.c   | 104 +++++++++++++++---
 18 files changed, 367 insertions(+), 89 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
