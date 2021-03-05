Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0936EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C8E6509A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C8E6509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF966E2ED;
	Fri,  5 Mar 2021 20:03:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3606E2ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQuV7yxW/6BAS8UJAIKxac/x130843enQiRPU1O/NgK3rPyvlrz0pTkt5xqozKgSf/N+VBD4maP5+cH3KPFVhwHruAerqQYRiXHnt8jeKBujwpEaJNZDwGtNbryg+BAAnl+tj9BzYZyBGcO/ibpMzltK8XXPZJ/UIZldapGz+HCVLVKumaOMqzED9VBAiaiBOUeE2dO2snNKrbjzhPzlUjMEcgeA3LjGbwJ/E5aFITOmF1UqGLZeTOx2jadwRWP5PUyOxPCKL0hwrJZOKh867hNfSzBDtXeUsQu6pv9KBoq/NHCUavxgyiOuCPJUV5DVuHSYLbFG801Q6dJviZYfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=628EM0wmWPJHy7uZo6yySiI2e2vmSZnjd/kAumNdGTs=;
 b=U4AR5XahiQ99AHURRQTHEB3T5W2wbztbcaruz3cRLNWdeMFaOTenbTxWxqVjxSiF84WmB4oyrifPq1c55uGMty50N4ts95Xx3/Srx/w99fGgRLgAcZwI0MNi8FAD1V+xH+5Z1GCaPUTBSwk0homnkZVORjpKWEerCHiXKEixM0zioRi0UYKhYzq64slMtR4/L07mjX+bulTiT567Csz1FKaEqGIM5sjTPe0zp3InpMxhURHNlPtqc6R4AZ9lZQRYwx7W4wxHPoNXad6h262oC2zvxQH5hE3GSW5PwBM0ojCdWIMYzbDn8Vr9qwzlPx/NPNaYyVea/kLk4AgIAxtxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=628EM0wmWPJHy7uZo6yySiI2e2vmSZnjd/kAumNdGTs=;
 b=r9ZwTSY0bI4LQLKq+jqvC+tfzVrDtIzhoWD0bAGKrRf2TkYhXfv0INa6y3V/QyOaJqCCpnxqvuaVwOvkqjjfSQ7a5utykFff/88fwN6PhECnI9NZ5iCFC6ALszl/DTbVBnkvrayoTrS+SnOvZ+2Q0swJdxxbKF1gXB3VxPGJuSo=
Received: from MWHPR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:301:15::22) by CH2PR12MB4805.namprd12.prod.outlook.com
 (2603:10b6:610:12::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 20:03:41 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::ef) by MWHPR2001CA0012.outlook.office365.com
 (2603:10b6:301:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:03:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:03:39 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:03:38 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:03:33 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches March 8, 2021
Date: Fri, 5 Mar 2021 15:02:47 -0500
Message-ID: <20210305200301.17696-1-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80936bd7-5997-4a5b-b681-08d8e011c544
X-MS-TrafficTypeDiagnostic: CH2PR12MB4805:
X-Microsoft-Antispam-PRVS: <CH2PR12MB480585E82B1C31B5FEEA9D0BE5969@CH2PR12MB4805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThWYfQM2kpihYCovWu3X9bF4m/cfyPAASZV8BFfuEp8E3i10wQHl81yv10wj0NUHg/RiDlxHOsmBRGwxisRoYmA+SAR0NbBx+cz1aXlEQ87SKRTlDTN2rya7huChA8br5hHrhYTg2TdCrHPipWveIZ4pPxKpkioGrkO9s5rYgtF0LIvgYGSP+el2SnnUP9E0yyFrqa+AUbc1fWrGOAe2Fjrs4KpTx5PUQwOPI+FxLSHL5+YbaEIartX2h/RfwOuE3wRmlj8xO3fqyt6n+09Jz91qQ34TVyfHaidEuJfQl3YP1qxmjHl7YioB/aw8oTZ/j7sSzGfrH0yKnC3yVPrkVYclQ2MxfkgXxJ3U7UxjcLePs81miptKRuGdoGFykFFb5+Z6Ley8c9Dp20hyCghK4+lmblDOyZAOnMEMJYKg2hYE5lH1YdT05o7BwTwuqvklHvABpK2QlS9qhu91NSnKVcw7rZzhwFZuVzmvwUn7dhaytsu0S6q7pRMhs+lRzPCrZniKOrrrQNUbDwoxCH3b9XOHXQqlRWu47AUgyTcKJjFzzR63kMZ9FhP5UpXIt3REtWQxcrMY3whlaqPXWHg+eT8Re9zZwgOwYP4wone1USWN+E0ZsIdstldU+Di8kQ266VbpmLPYGDXuRfjH4Gu/LvF1+iBUNoQwr+JWoc3mfUW84dmxTsDO2SfscKXwzYYI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(36860700001)(6916009)(2906002)(8676002)(36756003)(2616005)(70206006)(47076005)(4326008)(8936002)(70586007)(186003)(336012)(1076003)(426003)(6666004)(82310400003)(316002)(478600001)(54906003)(5660300002)(81166007)(83380400001)(44832011)(26005)(82740400003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:03:40.0066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80936bd7-5997-4a5b-b681-08d8e011c544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4805
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas.
In summary we highlight:
 
* DMUB fixes
* Firmware relase 0.0.55
* Expanded dmub_cmd documentation
* Enhancements in DCN30

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.55

Aric Cyr (1):
  drm/amd/display: 3.2.126

Dillon Varone (1):
  drm/amd/display: Enabled pipe harvesting in dcn30

Jake Wang (1):
  drm/amd/display: Added multi instance support for panel control

Joshua Aberback (1):
  drm/amd/display: Align cursor cache address to 2KB

Martin Leung (2):
  drm/amd/display: Skip powerstate DC hw access if virtual dal
  drm/amd/display: Fix typo when retrieving dppclk from UEFI config

Qingqing Zhuo (2):
  drm/amd/display: Enable pflip interrupt upon pipe enable
  drm/amd/display: Fix warning

Sung Lee (1):
  drm/amd/display: Revert dram_clock_change_latency for DCN2.1

Yongqiang Sun (4):
  drm/amd/display: Move define from internal header to dmub_cmd.h
  drm/amd/display: Fix dmub trace event not update issue
  drm/amd/display: Read all the trace entry if it is not empty
  drm/amd/display: Fixed read/write pointer issue for get dmub trace

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  11 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   5 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  21 +-
 .../drm/amd/display/dc/bios/command_table2.h  |   3 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  17 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |  11 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |   6 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   7 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   5 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  31 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 846 +++++++++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  25 +-
 27 files changed, 948 insertions(+), 84 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
