Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5EEC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0D46109E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE0D46109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C8A6E8FB;
	Thu, 19 Aug 2021 18:58:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AFE6E8FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 18:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd2fnTw13CNXNNTMV315M7AVpO4TDh/ozmaDvozgOy+F4W6E+TGyJi9PEJN0yaN7OQbReFdOx+4N1ayLgLCEyQ3tYKNkXtAEGGVK+3zwRenYUB8K6Pq22mx0L1GfKzCmqgBE9YpdVd29ikXojqSlXWUvqt/6THTqs+USAAwhFynFxn3DDF8ecRIoCXKv9F4T+MjV00XmMJGrj1axEf3MFwMrcDdgpdK4JfGxhxJ39ozrRMBSFCu37b+11yH3ytrXbiPdb78jipcigWXv0avxC6tZhDUKKn9qZW89uJFxNyfHMeti5LmpotkoH6q16NsgrDy6auTA+fH2gr54dt/0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRIL3H38g68i5Yhk5gV8rl+RbMN8tKFgRJbCeWlqumg=;
 b=VN9zyCn+9Ut1/q/cSTcmWebjyR9IlSyajqtEzT/s8+2b5Pbv57DDM58cVcRGmdHaRKdbnsqhAfpLt673CZg2ZAPZtV2GP3p9QSN/BrqOgoLo1ElVQoiF5lQdur7jcbVQ36HYWGcvi/40i05hm5CtYf1fnwJ1CDlgVXcaPHj5u1hlwH9M0PrYipdcRvurMyJn3Pq5aTTkCE1w8I27iXF3agOKP4yfOl166E9YZQjIXS+5+2Yf4c2+Q6ErjO6sRf14T8TE3mWFAGsiQ9IQuBebaAsGSDywQ9L5FHzz7Le+u6KNXUSuroiUBWHt8WdRgrq01sutG0EcxiJkvZJrdHm1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRIL3H38g68i5Yhk5gV8rl+RbMN8tKFgRJbCeWlqumg=;
 b=YHy2JI7EpdKR20mikfEXDhinoD5KQwiAdhOirY6swwAWV9KFzpHjtApumhsfA3Qo50blE6xbVt4TF5zlegU0KH/YfGrnE33XEES8O8Z7M/XsLil4fvSZ8c5CxhcUcZk573mDckl9Vuj2cDKWuBha9y7jskIYBIdr2B7Y4fK3OyU=
Received: from MWHPR18CA0042.namprd18.prod.outlook.com (2603:10b6:320:31::28)
 by MN2PR12MB2861.namprd12.prod.outlook.com (2603:10b6:208:af::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 18:58:48 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::12) by MWHPR18CA0042.outlook.office365.com
 (2603:10b6:320:31::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 18:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:58:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 13:58:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 13:58:47 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 19 Aug 2021 13:58:46 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v3 0/6] Add DP 2.0 SST Support
Date: Thu, 19 Aug 2021 14:58:34 -0400
Message-ID: <20210819185840.3682559-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac5fb02-3513-42c6-dbf9-08d9634360b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB2861:
X-Microsoft-Antispam-PRVS: <MN2PR12MB28616DDB29CB5C502810DED2E5C09@MN2PR12MB2861.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fTVlV27cPC5u+KN8U7k4JE7EVpGWMjHIIXPonWs6wHGmO+U86Ek1BHlh9O/+ay9baqSEO9JzCyloXidC0LbTolBe741+ciahOHnxzvqNiJWyj0lcBntd9rM0Uvks9CsqP9Cz3jLpvQjLnn6wbnvnVKwheb9RcTqZKOnznDu+PgOR3suKTE9SIxjQh0/GE86wYjlp+AYKgDIUzLVA57OF/xO0J3Kkyei3UiD9U5qXcusfhT/vp7KXNSp7yonEcWPgko+59K3mMOHED58WKLaDQIcvIcyeTjInON6y2H9kL7ObFghVrfDBuEJxA1yOYaZDmM2DoLN0sbAIeJ5TwABPauKvZkepQkoZBd0zdbnq+Uhiw7esJN7wu9vr6p+BZKzX12V3Buh1WdDzoKLfUCBZmwbQsvIfesQfKcYGR34JU19iQMzeb7spreVAljJhvfIqC8Zi/zb8bsXO//4EU+YKF+kGZrhFCUoQoJg3mbc8RkFDmzzDlcadp6sd6sH53GvhAjk+Txe/Eb0X8gXJX6u6hX19Q/MRFDYLxJbcQCyuidSEWcpw3OI386H30+y0AK95/haOW7XulAqdY+8y+sKMG8ry9jGb93/TdpPHcDPYUq80ZvxTGW+cfsTiVYfgqkHEo0Jwa8DgTncVpCj9oEgX4rJJihtPzeGW+i3OpPKrompLV7i59ZwJBUMFbJffPLHkzA5x+cqHrmWpcrDP+86DztKoWQRx08QHFZbyiS7hN+yFdICwfgYaoczXB38iJkZvZijDWm4umbGPe3mM1yP3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(26005)(508600001)(426003)(336012)(34020700004)(356005)(186003)(81166007)(83380400001)(2906002)(110136005)(54906003)(1076003)(316002)(7696005)(70206006)(70586007)(36756003)(2616005)(8676002)(6666004)(8936002)(86362001)(4326008)(6636002)(5660300002)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:58:48.4510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac5fb02-3513-42c6-dbf9-08d9634360b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2861
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

The patch series adds SST UHBR10 support

Fangzhi Zuo (6):
  drm/amd/display: Add DP 2.0 Audio Package Generator
  drm/amd/display: Add DP 2.0 HPO Stream Encoder
  drm/amd/display: Add DP 2.0 HPO Link Encoder
  drm/amd/display: Add DP 2.0 DCCG
  drm/amd/display: Add DP 2.0 BIOS and DMUB Support
  drm/amd/display: Add DP 2.0 SST DC Support

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    8 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   10 +
 .../drm/amd/display/dc/bios/command_table2.c  |   10 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   21 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  520 +++++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 1168 ++++++++++++++++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  314 ++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  118 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   27 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  222 ++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |    7 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   21 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  104 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   65 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |    9 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   26 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |    4 +
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |    4 +
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |    3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |  173 +++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.h  |  115 ++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  162 +++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   18 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |    4 +
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |  620 +++++++++
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      |  222 ++++
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  749 +++++++++++
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.h    |  241 ++++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  181 +++
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   12 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   22 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   23 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    4 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   93 ++
 .../amd/display/dc/inc/hw/stream_encoder.h    |   81 ++
 .../amd/display/dc/inc/hw/timing_generator.h  |    3 +
 .../amd/display/dc/inc/hw_sequencer_private.h |    3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   18 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    4 +
 .../amd/display/include/bios_parser_types.h   |   10 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   16 +
 .../amd/display/include/grph_object_defs.h    |   12 +
 .../drm/amd/display/include/grph_object_id.h  |    8 +
 .../amd/display/include/link_service_types.h  |   41 +-
 .../drm/amd/display/include/logger_types.h    |    6 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |    6 +
 48 files changed, 5472 insertions(+), 39 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h

-- 
2.25.1

