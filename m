Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94958C11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516AF61D4D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516AF61D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5171789EF7;
	Tue, 29 Jun 2021 15:54:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F4589E32
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIPjjjYZ43JFkcT78WzK/bDx85nmRpDRT/DOW5l8mjw5mUEOXRi/NAvFvjQ3E7040Ken93eFEBndAy2TXMWIk8IiwuK8IHBMQOvrEIqdBTAs/DUi+eT+TO65oYBWd2jdd/0QKa0NDNMjeYvvyqgdYGcfc48oVdPiJoKvNUUl5Qvxb+2HU8xE9DJCX4MCNjGT3jE9q382saw0MNwB5D2UchypZ2eYZYFbHe+xhAW0ZOc5EwhMJMqmADOTV+0bPo39Tth1fMQmIHs4cmgueXUjmV1/fvYteGJjofaPHgWyUPDQUlXoJE7dZa+zezdGB135KF5yd2IBr/Z4l1CsGhAdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyOdKGRjRa+9vCgW8Z3GyVtEPB6q/V2+0dCyAePCNE8=;
 b=KJEUA21mavJV1AoynyR3D1LfvIC/JAeMyQAQdzFRPFYNY4hW1H5VqTFusFGduSi5warAcH9m/ohdbRHsSWOVbWe9kgrk1d3AA9ncHEXRWPMsLamOQBdMakHK6dRk3sTmaaxDM6rmY7NC+zTWnn13uQ9j2pcUFMCqoQ1cH3I0gBrtqhrYA1IELGRSPT0xLHUvV7nyNu6N2xL0Utf19RATaoZB4trnIm/M3UBBTYKTDmM41nfA+DgAKYVS/XAOM7Y8z71tjUxMyul+U1GFVHk0+cMql8EgBkidBL3Joh2tLBY5zBovlyKlt//gyXSM2bzexXlWeUQdO9A1ofjbFcinvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyOdKGRjRa+9vCgW8Z3GyVtEPB6q/V2+0dCyAePCNE8=;
 b=2kxykK2kqzhD6i8ikKZNzomruPM0bMABkBBNEPcviSnZQ3kjo/c/SCl/KiW/0Y6qNR+VWcPm9heP93gxCotCpbL4fJEnmcKtRIEGWFvyY95+CrQ5HqpTrozSPUaLEQpM3Sh7GVHkdY+uYxq3iR6BH0Hoowh9+NUdkRO6jz+n2pY=
Received: from DM5PR13CA0037.namprd13.prod.outlook.com (2603:10b6:3:7b::23) by
 BN9PR12MB5162.namprd12.prod.outlook.com (2603:10b6:408:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 15:54:50 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::bf) by DM5PR13CA0037.outlook.office365.com
 (2603:10b6:3:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:50 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches June 29, 2021
Date: Tue, 29 Jun 2021 11:54:10 -0400
Message-ID: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdeb6abf-6397-4088-05de-08d93b163a5d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5162:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51624FE8A2DE8DF604650FFA98029@BN9PR12MB5162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIlHcHvZMrWN4pqXx0j/pzgTyPjXETpZvBoIUR2s8TobNHzg3QASwNj9/eJLir8JIIzdPSl0/HnxKEzXhye1/K7XOI+MSOvaHOUZ925hasGo4AeDJUK+lAAFBY4jvzEHCuAlcfjrqgbJ4NzzqE6W277A+pk8HPQ7VON2JOVu9YiZ7nXhjaqVhYSap23lAO0+GiZVrBMKkpZ1Y1LM5dCMKIlWXFIhY/iifE1CAFe0F4YW2nz3BJE/B8SZrxraNq6wP3xrxm8/ET9RHTiZiiGWfVYpR9jUpN4RoPFQXwvtf7IKoOs7+9g7VlXHTjAAEf7EEUucegkrwc3Hn0lmjlIE3Ghz0YMF+C1KN6OtQE9DpjO8QnzktGTemyHxZOX6NMol1kTOkDZ1xtIK8gXK26FTQWt2MSPFO8yTCBXTVoTiWJIlaJ1IXOx99uL4+rwmq/FYKpUyep1cEiQwZFC1/UWCrZxFBdIX9DC+2Ethdh470HYdIgXP6TBhkDHyffWejkgRIJ+iYBCu7urwzfNyA2JhAmuIIdK1CwEmmDPdqlALnRQL4b0Y5OKDAWmUocNRLZf3l39nFnz7AIoGjUQZwfqrIh0xo9oTIxsZxehwuk8n6MzcV35dYyCjvIzzmYSLtrAV6QVKrUNcUwtwemwPF3/2yhOzixWVrf+KoZzX5ad43CTl6lWwNRewwX8QmnYf30vJBIVP0arshLqGOnqJGMIlm0YXWDXiiPanfCtJrFdUnMk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(316002)(6916009)(336012)(8936002)(426003)(54906003)(478600001)(82740400003)(70206006)(26005)(4326008)(36756003)(86362001)(70586007)(2906002)(1076003)(8676002)(186003)(356005)(81166007)(16526019)(83380400001)(2616005)(36860700001)(82310400003)(47076005)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:50.3070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeb6abf-6397-4088-05de-08d93b163a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5162
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DC version 3.2.142 brings improvements in multiple areas. In summary, we
highlight:

- Freesync improvements
- Remove unnecessary assert
- Firmware release 0.0.72
- Improve the EDID manipulation and DML calculations

Alvin Lee (1):
  drm/amd/display: Adjust types and formatting for future development

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.72

Aric Cyr (3):
  drm/amd/display: 3.2.142
  drm/amd/display: Round KHz up when calculating clock requests
  drm/amd/display: increase max EDID size to 2k

Chun-Liang Chang (1):
  drm/amd/display: DMUB Outbound Interrupt Process-X86

Dmytro Laktyushkin (1):
  drm/amd/display: remove faulty assert

Nicholas Kazlauskas (1):
  drm/amd/display: Fix updating infoframe for DCN3.1 eDP

Stylon Wang (1):
  drm/amd/display: Add Freesync HDMI support to DM with DMUB

Wang (1):
  drm/amd/display: Add null checks

Wenjing Liu (1):
  drm/amd/display: isolate link training setting override to its own
    function

Wesley Chalmers (1):
  Revert "drm/amd/display: Always write repeater mode regardless of
    LTTPR"

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  95 +++++++++++++-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |  12 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |   4 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  16 +--
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  25 ++--
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  10 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 121 +++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  24 ++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stat.h      |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   2 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  11 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  18 +--
 .../dc/dml/dcn31/display_mode_vba_31.c        |  15 ++-
 .../amd/display/dc/dml/display_mode_enums.h   |   4 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |  12 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   4 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   1 -
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   5 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  18 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  15 +++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |  13 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  17 +++
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |   4 +
 30 files changed, 338 insertions(+), 151 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
