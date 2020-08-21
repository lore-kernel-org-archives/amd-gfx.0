Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CBAC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841D22067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vLahczBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841D22067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352F46EC1C;
	Fri, 21 Aug 2020 22:57:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC7D6EC1C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg1LNJxW1pp40+2SYXz6+/59jp/FpnurocAc9uSCyenuj44HnRWokMw6xgLni+QjKKDNKY0JCcNmtK+y5487bAL16cBiQRUvH0gxtH8f/Osvc/W0VbuZVZfrHix1kCYaSjcvfO1JULIVDoMcZ7NTaZtu+w2WysvJ0lKkvvhdKDFGXN77kheilNw+EUM+0BwINxUTuDUjioNBYpeG9Ceuqx7Jy6usqizfYLWgPMC1NnBnMdMsofwqs9h6hbUpwEeKiGpg1j2r4/wLaDamiPfyL1BkSDZEsi8dw3cVkMeu3p0uFtZxyWr9+FyOtcjC1+NwnIS32SHrmRhNWtO5nxMpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zGvPwKKOOaJ1TC3KD8D1hDr60WKb4tRbg8WH8fPUjI=;
 b=fLio4sBPoIRxVXeDHGvYiMSwxUDC3pQiMywQqSSnL1ZtNUMbrXafmpq/heCFpWO6PGQaQp6ElBs25PeenMvSYgSWQ0n1kN3xUp6KxexErMoiX2CTaoL0Ger83X/Mgfv9BRhOtd/uLJZNK1b/UKx+lUkOVhmKzPqHIVYNhaFynTJHpDOXa4/f6jvc5e13AP8XSMse08UeH7bhFoq6wTCJHddKf9MaBo3HNeoV6xsBZD4PSt3ATMSQ4X2ygTKIfbUIh0GG1ClpUYLmTHOndNnxlFsQ84OewgzAt4/EeKuPMQuoe0Kw2R9JN1jx/iMEJ95UW8M1drbPpsot+86yRPLiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zGvPwKKOOaJ1TC3KD8D1hDr60WKb4tRbg8WH8fPUjI=;
 b=vLahczBmGqLt5s/TUlyfQohSoWsIpQH7ZDutntJs79qfkURNRHVjGYrenUIDiInt16N86VA/J66rgAEJxAGX050nH0dDXK2VOh2ecuOrra9Gkd5cVoCj6uUb7iYcUm2xXj4bnn43eqMcSb3bhdmkx9j6Bn95A9+7bS4Wsaz2J6o=
Received: from BN8PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:70::18)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:57:25 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::2d) by BN8PR04CA0005.outlook.office365.com
 (2603:10b6:408:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 22:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:57:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:57:24 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:57:24 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:57:18 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] DC Patches August 24, 2020
Date: Fri, 21 Aug 2020 18:57:00 -0400
Message-ID: <20200821225709.136571-1-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0141043d-a5f1-4ab9-0b92-08d8462591e4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525F9BA7F78453035AB362FE55B0@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2J8MdVzFrYxk20vucQZipTrBmhL5zTC8pYA6DGD9cmBdxBGOzN3x42r84ozjqaEkjzjj8VYhRN88nh30c4z+fVUhAOgWvFVMNIgudSofaw9wgNKjIr85qK0zdvHnVBvn7FBp5Mj9fSh+ARoY5QZVU6/kzVMXZx41u0B/xr0JlnHb4UeTPptTFHMEVK7le8SGpQ0YK2Mvf06PIJT5PzKOvJrWsjDng7SDRxTgWq1sPHiuu4DqIQV2bCpHVNWTtBeDrrJdjDonqRUvqgHDj7NfRNZ+XlIfD+zwZ8pVK4OKPbOoeyCLgi1W71LXTsmLwUtAXw5SPcuck3glbNpeUSvr7blbPRArLTW83nniMSAs52t9CaaJOxmE/8+p+cpmRoNAB/qcmerHVSGql43wsTpLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(47076004)(8936002)(6916009)(478600001)(54906003)(26005)(8676002)(36756003)(4326008)(2616005)(5660300002)(186003)(316002)(336012)(426003)(83380400001)(2906002)(82310400002)(356005)(81166007)(70586007)(70206006)(44832011)(86362001)(1076003)(82740400003)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:57:24.7881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0141043d-a5f1-4ab9-0b92-08d8462591e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary,
we highlight:
 
* Fixes on HDMI, HDCP, and EDID Emulation;
* Enhancements in DMUB;
* Improvements on ABM, DSC and others.

Aric Cyr (1):
  drm/amd/display: 3.2.99

Brandon Syu (1):
  drm/amd/display: Keep current gain when ABM disable immediately

Chris Park (1):
  drm/amd/display: Call DMUB for eDP power control

Eryk Brol (2):
  drm/amd/display: Add debugfs for connector's FEC & DSC capabilities
  drm/amd/display: Add connector HPD trigger debugfs entry

Jaehyun Chung (1):
  drm/amd/display: Revert HDCP disable sequence change

Samson Tam (1):
  drm/amd/display: Fix passive dongle mistaken as active dongle in EDID
    emulation

Sung Lee (1):
  drm/amd/display: Send DISPLAY_OFF after power down on boot

Wayne Lin (1):
  drm/amd/display: Send H14b-VSIF specified in HDMI

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 154 +++++++++++++++++-
 .../drm/amd/display/dc/bios/command_table2.c  |  28 ++++
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  10 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  53 +++---
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +
 .../amd/display/modules/inc/mod_info_packet.h |   2 +-
 .../display/modules/info_packet/info_packet.c |  16 +-
 11 files changed, 233 insertions(+), 42 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
