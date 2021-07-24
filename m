Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2A1C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 03:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E91B60EBA
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 03:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E91B60EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF9B6FA8E;
	Sat, 24 Jul 2021 03:50:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5DC6FA8E
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 03:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHSsSXZbVdE7GtyDvaH1RwzTaAwbb8Jk258OFerbPprHkX0mQD2vGGbI7qZufzwuWbl3Eu5kQlf3hettlLnaKV3jguVJ3XFslditukG7ua92QTziiq7aOqyE237E6cToP3yUIIirgm13Au0E+FQkZNPjzLJK7hcU/zRO1JioEFokl3w2my9MVbFjIhxB2uYwbdUxiYAbXgR1XktT+9Bq2xaUzfd1G3YRVfWQx6qRRk+SDy7zS1IwK6FxpYOC2WBeLf+d81T1Dwqyeen1z0yZW/xx260Ls/Mvg94YaE0Yxzer+eBTAYlHY5VBC255MNfi+5DvlluD/hXA3KdXS/VEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWMPJPQ94V/fn/BRj6bzX3I9MN+rVGqH8u9Ki9wIbEQ=;
 b=VCnbGYgkUCi4V0OLU6y72jqivijWjmaAWUPrmq6TtrYo65QadhBJDkWBuCiGt4nWP2P1HmZKPzoRnw/YMwNqUgfRbBatGVaecXABQ0RE6hHimfsenoKWy+KHJdLJcKhj++sVRw7csbKSADXWP+X1Sd3Igz9y2Ze8ZDPzq+pRFN8QT+s6fi/I8JZ6+IirjR3/dtQozwHyI36goSv5BJbhGoQSS/nGU1RIvNrrrz1E6esoGKGYLHPGHNC2hkeLKSmT8/A/a0N7nNMXYFMH7mtL2SKTzfNSwaF5MPnf87S/MQzIWIw5b6CVcPZcdMtKdE+niP5QHFpPuF0jACBQiXEYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWMPJPQ94V/fn/BRj6bzX3I9MN+rVGqH8u9Ki9wIbEQ=;
 b=Ih4XuomXCeD1Un7QpCXYBDG5v7A194CqmQOHiCJi7vR8RKagdFc1iKT8Btw8Qcr69boV++a3vOK1abC7JOQOnLToQoJQ4ffQ6BWCMMzSUSwV6Wep9H8X+9dUvX6SQu/CG6UArbX0xB/ugG4b4xkBSRg50R4KRBc3QiNORB6ls1s=
Received: from BN9PR03CA0218.namprd03.prod.outlook.com (2603:10b6:408:f8::13)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Sat, 24 Jul
 2021 03:50:25 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::a7) by BN9PR03CA0218.outlook.office365.com
 (2603:10b6:408:f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Sat, 24 Jul 2021 03:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 03:50:25 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 22:50:22 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches July 26, 2021
Date: Sat, 24 Jul 2021 11:49:49 +0800
Message-ID: <20210724035003.3845158-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0989a1e-7c14-4bbd-5bad-08d94e562baf
X-MS-TrafficTypeDiagnostic: CY4PR12MB1159:
X-Microsoft-Antispam-PRVS: <CY4PR12MB11590727FB08D6291018B54097E69@CY4PR12MB1159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v10Mb0+ycltKtnLsjox9FfMxUiScau4P4wgBR7ngLKzsei8XMi7Adn98CNtSeIruaHXLPnQwxKWSO5ctwdFS2U9BPMr857v7sT6VWRKtnj/8l3ejKNw4Udc2xlXeqPfiGXdf34AfDkeP4/75PHko5YAKJyECHDlrxDzJtNODzSMcWLvEAhvu99ZbfjpnkAtVToetx8St18XpGXY8GdGJ8P5WPF/ZOJAckv0A3MS7M7cn2I/huAfurFgiZIFKPK/sMereJj7ozR+i3rR+57+FsXU0F942ZZrLsW4mgljah+G9V9Dgc2ML+wsL7PutD8EeV6fMNlAgMmMhdXzQqcX/UUanwdXn7eSS8tYn5380emI6voOvyFaEs8BXggA7kEa7EmrApPb9irDhQNZdba3VZne7A1JbMn8IUBWqcQUgHEV3NoAtu3QYvg011kTq6OB5IllQu04t4gPYrpMM63Mkn9+qXuQWPlw0D1TxcGVcC1PhCs55cVaOsoPfUWms0/sbBPMyQflSJyqFTinN9xXHOMogsUNYe2Cu++0xhrjd0A9T637NmkGElJAAcguA7UPWRjjNb7LeidyiZzbJ/aePH6y5T76vYSO1YOXSJCcJgyxtkr9Mx8iH2PWBaNjRJux/ihmPgo86fIVab2SRJZRBCBzT/uVLtT9StaWQhBO2XcOCxC/aqwRe1Q9Sa/Dt9Q5SN3tfRCyfJKrxQGJYOj07fi3mUHefohw/w+rQZZ9Z6CY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(1076003)(2616005)(426003)(70206006)(336012)(16526019)(26005)(2906002)(36756003)(81166007)(5660300002)(6916009)(44832011)(8936002)(186003)(316002)(82740400003)(7696005)(54906003)(70586007)(4326008)(6666004)(8676002)(36860700001)(478600001)(47076005)(356005)(82310400003)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 03:50:25.6162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0989a1e-7c14-4bbd-5bad-08d94e562baf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
Cc: Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Guard DST_Y_PREFETCH register overflow in DCN21
* Add missing DCN21 IP parameter
* Fix PSR command version
* Add ETW logging for AUX failures
* Add ETW log to dmub_psr_get_state
* Fixed EdidUtility build errors
* Fix missing reg offset for the dmcub test debug registers
* Adding update authentication interface
* Remove unused functions of opm state query support
* Always wait for update lock status
* Refactor riommu invalidation wa
* Ensure dentist display clock update finished in DCN20


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.76

Aric Cyr (1):
  drm/amd/display: 3.2.146

Dale Zhao (1):
  drm/amd/display: ensure dentist display clock update finished in DCN20

Eric Bernstein (1):
  drm/amd/display: Always wait for update lock status

Eric Yang (2):
  drm/amd/display: fix missing reg offset
  drm/amd/display: refactor riommu invalidation wa

Mark Morra (1):
  drm/amd/display: Fixed EdidUtility build errors

Mikita Lipski (1):
  drm/amd/display: Fix PSR command version

Victor Lu (2):
  drm/amd/display: Guard DST_Y_PREFETCH register overflow in DCN21
  drm/amd/display: Add missing DCN21 IP parameter

Wenjing Liu (2):
  drm/amd/display: add update authentication interface
  drm/amd/display: remove unused functions

Wyatt Wood (2):
  drm/amd/display: Add ETW logging for AUX failures
  drm/amd/display: Add ETW log to dmub_psr_get_state

 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   4 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 108 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 120 +++---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  81 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   8 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  21 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   8 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  48 ++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  17 -
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 -
 .../dc/dml/dcn21/display_mode_vba_21.c        |   3 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 393 ++++++++++--------
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   3 -
 .../amd/display/dc/inc/hw_sequencer_private.h |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  70 +++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   2 -
 .../display/modules/hdcp/hdcp1_execution.c    |   6 -
 .../display/modules/hdcp/hdcp2_execution.c    |   3 -
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  53 +--
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  12 +-
 26 files changed, 538 insertions(+), 444 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
