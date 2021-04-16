Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE42DC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779A0610CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779A0610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150136EB7E;
	Fri, 16 Apr 2021 14:34:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483716E084
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WABWrMbFyhppjyPLX3SAKjhfSepVOFddNg8krlWxqOIbxyKpJ/Xdsn0WYz/5uZq7CYWRupuuCZI21g6C1YU8mAx+hXY716faADOColBiisfiVvQpOnIYxLVBtwPCqt7opWl6tcf9ryR4ZnkNQPbEwrf5NwDQXv21eH9sNTJoMOfs3ybTHsIgiVksIJUYd5vLx9ZHCBV0ZNfDA4AALmCa3Bedjs7eCSXlZf2BVBnDqYWdRZsv+uAyAw9XlZYQ7p08hogwvHUZuCs9VO2vwimpTpSQCMo1GP1C4NM8hLMTKwdqzTYphwhUzox4o+nmFA1hjzDF1NPok2nEhSETqOqBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTJbv/Kb8JfoEA07TdCHZhxMdPvrALpaznYRIZcUhQM=;
 b=K7AXY/y3yKWrhkSFoQfVix2zeyJoMpB1zk6TYcMQIOieniIcaJ2ssdVkzl17Cm/PAo2jjfIMrhqCKhVe8NFJqhuwm80Dla2s+xosppcnrThfjiA1W1J3Lidn03YuiCL0Fd1ranu0ZxWv66gD0U4/5A2rjsN97aUKcxZXdkdrcxQFsS1jjbtYjCMk9/CzEleWsBuUjuXMTeU98dkp0cfOn+5gzJiyT+DyYMGVjcEjL+pW0nHM2Ns2KBtHiHAJOBHoqJf/gFm7c5Y2pUOZL86R+22hmF03oh27G8hojkSU8+fXovVCdnkh48NfuvEHlb38mmFcYbrFDHcsLlflihTWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTJbv/Kb8JfoEA07TdCHZhxMdPvrALpaznYRIZcUhQM=;
 b=gY2Sbb8ocECJRCAynbiKAGwEMMoyL/ApAtt6W8f4EqX2rTaaGL1MzgjzF3RChqfXVkhBE+eBK0uqv5Cu0CUvCJgmMtePft+FV5wUdCDlA1LBLbsOFLrXyvhhHZav86HU43EGrJ6qpItXyuuAHSVyIaeWQvXJJ46z9fgkuA3xQsc=
Received: from BN0PR04CA0203.namprd04.prod.outlook.com (2603:10b6:408:e9::28)
 by BN7PR12MB2756.namprd12.prod.outlook.com (2603:10b6:408:29::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 14:34:19 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::d6) by BN0PR04CA0203.outlook.office365.com
 (2603:10b6:408:e9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:18 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/19] DC Patches for 2021 April 19
Date: Fri, 16 Apr 2021 10:33:58 -0400
Message-ID: <20210416143417.611019-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c350d080-455c-4bf0-e9d3-08d900e4b88b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2756:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2756C27AC577175178468A998B4C9@BN7PR12MB2756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh0k0d2DIPOgAp+JyaSnvnMlJpbZflXnCDxvSZr49lb2JJGqOJ1kBjDFs1q5FgYop0E8GG68DYIKhj2LP93p1bGTJxLEQRMx5W0CjogtXh7kn5Dd3JfXWKAsmkt1Ss20npgC3NVclS3i4Nu8ZHEPWY5/wrqDmEHofrZESioDDox2dDpr/0Gn2rXyD6r4/ku3cLNATLhVdolu0ghl7t2MonEi9EFxOXV5xYmVdZMurb/m41oYpP2GKIaE3GVfbsIIEPPP7YLgLl//NraM/VqAuqtuPSpnKPr1trvHmnd8/8gMJEwWDKqTQEvD4Ve3NwB2TsFOHn42aii1vNorbD2I0OFCAZ9Bsgx5S9jJthmU9k1K8rpPqReFXxZw21NYue7lPYlzrLWZll6FVGvkv8o5UVu61RFGlwnki9fjZe9nMSRX3NDSEqxbRiryp0ZekLMO8Ko9O1Oc9vJgiawveYJygyvvHjl0hKKvbODRKiEOKG+towyN5+t7+Ynra8kZCy2KUTc2mkbx66P4ojIGqkGpVweHIW/Xnya+LvNsyOAQWIB6R33kgHQPctkkmz0Vnji1UDc8zNsB8UQvQT7GM1Hlf67Susigxi3REpAg4J/c8ipRcR4Gve4LB6fwF4vZ7kAF4E+fzv3yxfNvmZ//D/vcNX0nzoby29A07S70meYxq4nj2wBlpnz92GF34v1qJVa6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(5660300002)(44832011)(1076003)(478600001)(6666004)(81166007)(36860700001)(8676002)(2906002)(54906003)(7696005)(70206006)(6916009)(86362001)(47076005)(336012)(83380400001)(356005)(426003)(8936002)(82740400003)(186003)(26005)(316002)(82310400003)(2616005)(70586007)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:19.7906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c350d080-455c-4bf0-e9d3-08d900e4b88b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2756
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* DC v3.2.132
* Fw v0.0.62
* Bug fixes across HDCP, DSC, FreeSync, etc

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.62

Anthony Wang (2):
  drm/amd/display: Add DSC check to seamless boot validation
  drm/amd/display: disable seamless boot for external DP

Aric Cyr (2):
  drm/amd/display: Fix FreeSync when RGB MPO in use
  drm/amd/display: 3.2.132

Bing Guo (1):
  drm/amd/display: add helper for enabling mst stream features

David Galiffi (1):
  drm/amd/display: Fixed typo in function name.

Dillon Varone (2):
  drm/amd/display: Fix call to pass bpp in 16ths of a bit
  drm/amd/display: Report Proper Quantization Range in AVI Infoframe

Dingchen (David) Zhang (4):
  drm/amd/display: update hdcp display using correct CP type.
  drm/amd/display: add handling for hdcp2 rx id list validation
  drm/amd/display: force CP to DESIRED when removing display.
  drm/amd/display: fix HDCP drm prop update for MST

Hugo Hu (1):
  drm/amd/display: treat memory as a single-channel for asymmetric
    memory v2

Michael Strauss (1):
  drm/amd/display: Add link rate optimization logs for ILR

Nicholas Kazlauskas (1):
  drm/amd/display: Always poll for rxstatus in authenticate

Robin Singh (2):
  drm/amd/display: fixed divide by zero kernel crash during dsc
    enablement
  drm/amd/display: removed unused function
    dc_link_reallocate_mst_payload.

Wesley Chalmers (1):
  drm/amd/display: Unconditionally clear training pattern set after lt

 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 130 +++++++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  25 ++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 ++++++-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  72 +++-------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  18 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  33 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |   4 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  15 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../display/modules/hdcp/hdcp1_execution.c    |   2 -
 .../display/modules/hdcp/hdcp2_execution.c    |   2 -
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   2 +
 19 files changed, 257 insertions(+), 136 deletions(-)

-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
