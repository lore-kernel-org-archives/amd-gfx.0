Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34E1C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C1A64EEC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C1A64EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9FA6F4FD;
	Fri,  5 Feb 2021 22:03:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880636F4FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmdmEad8SL8ueJLGFKOZHbqRp1pTz8gcsVzG6NMn9fq1pPgVE1+75eZU9+A7IfeFlYEp5+EZx2NCT/Hk4m9suUcko/SDy3mTDgXgUuRhwEvM5ixur3X6Cmn/AvZHimYs3x07LC+J4BXW7Z62f+LOCa+QokfPlCpz/hda58HFnsRuj2OG+mjodW4dzsyNaKss4+SYIlLtPNdKw9TZQNXxb5sFQ/06EXEwBU3QBfmNIyS+0am8p3oP+KrUKJO4gCc4ozGw6cYZ16oTeYmImFKOQV4tysb59HNbvuXYz52oeqhKKQk9xdBC9mezJsBQueoSVPHYieNIpg24d95F6IOmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSI93BZt5xtEpXFWWm6q/8c8JzYVqcDpYyew79X+jmo=;
 b=KGzwpSc838K4fi7ggmrmq71SsVpblc6OcQsloPf9EzrPnjfltjK28//yhgdQ4qd+cJNMKVm+0E4snxxfgxsfQpH+C5OGpqSf0uudqc75ET5XoAWiS9xZzRDWTai24Yp1pQQZz27+IFqWrrMlp1j8bZhKB8gpfH1yLO0aXP4icN14Fz27ikic2mLQZcz3/fy7GId5UJyINpRsJqN0BKu+eySHAnzJSYnVs2ix40SzLDc7K21apI7SGq74Icac1slCFpzHmcAMPDfEr0iso0ay6JKQzurL7qrpE/9rkISadm/RDnx30hyzjzwXfNhpSvIemcFJOxckBUIHYAI7KFDDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSI93BZt5xtEpXFWWm6q/8c8JzYVqcDpYyew79X+jmo=;
 b=Q2q+ulgNu9hkV/jkemCRGeVeytVqm1eBHuB+SQPe9BSqR+tkyxaOvetVSbPgbI9048RsdQCYaJMntauPa3Lb/2E5SMUgT1Q+t/Ii0mLXBgX5XQVZDTbfz3fHqH0NRsgCdoR2Ar+wh7RtJ0evQRm/lV178E45WGFcU5XSlMs98Fo=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by MN2PR12MB3711.namprd12.prod.outlook.com (2603:10b6:208:161::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 22:03:03 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::9f) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:00 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:02:59 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:02:59 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] DC Patches Feb 5, 2021
Date: Fri, 5 Feb 2021 17:02:39 -0500
Message-ID: <20210205220250.1871069-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01ef6051-5064-48d4-ba08-08d8ca21ce2c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3711:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37114337F6B27AC94634A283EBB29@MN2PR12MB3711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpNKAI9NPlvPHl5C0OUzWa4BuM4HnMMUQ6SdFqsENYRBM8G84PFvX+1VPmxDRhtgsixhKQ7Amg0ta8pD7ZEp33Kz/43nxDYCCfdQL3PgOdbHZuPgriphS/uAHDvhjMnGO5YPMYf4Y9s3TegVAFJ0+OcjlZ8atoUzNz774zJnYjgpQG0FfEhCc4WqVM9EccgaR3HCU+P6cNgdv/aZGvs/u3C7kxSENAEf4v0/p+RkE4axUXHvHFmLi3e/3SfAsoEHyrHYViZSmK8+GJ3jl74SNC8e3Bs1V39+WFJ2X2HVDlYdO4LkBGY4AeRb9gyKXH/oVztILpjcc2BvChzG32s6qWkwVQ57T4y7Pa8mMy51DQrC7ej147bsisRBdGSTJbq13ZI9EgmLhtnWXDYzI4//7/Nq4DkYjHWCEtJbDxYnERaNT6PFme4P2Nl/cbXcMHtsNI0HVv5tDws9y9vHgbnOoHNPmvrwxTkbDdo0bR/neuNJLhWYQbTLIlnziNZ+ju5tOiqAxKTblz4ApSqSMgiM9Fb17UF5BmfRtn5PN0ndPQuYkiVM4wsIDPxP56cLvW7ZOSq+Z5s51XbJlAdwya9SVy2phenRE1585lYBTTtydU5xj/NBt2YQ8Tc5AVTxjfSjDM8I90OunSiNLzjboaFvYIIkdvad8vqvaxdO3Ut7m8Zvll2Rn5qS4G65adKp/19K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(46966006)(6916009)(2906002)(1076003)(478600001)(356005)(5660300002)(336012)(2616005)(26005)(4326008)(82740400003)(8676002)(426003)(86362001)(47076005)(8936002)(54906003)(316002)(7696005)(82310400003)(36860700001)(36756003)(70206006)(6666004)(83380400001)(186003)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:01.1566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ef6051-5064-48d4-ba08-08d8ca21ce2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3711
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

This version brings along following fixes:
    - Fix error handling in dc/dcn10/dcn10_hw_sequencer_debug.c
    - DIO Supported for virtual displays
    - memset dmub_rb_cmd to 0 which fixes issues talking with firmware
    - fix 64bit division issue on 32bit OS
    - move edp sink present detection to hw init to fix hang
    - reverts a patch that caused 3x4K60 displays over MST
      with DSC enabled to not light up

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.51

Aric Cyr (1):
  drm/amd/display: 3.2.122

Dale Zhao (1):
  drm/amd/display: fix type mismatch error for return variable

Derek Lai (1):
  drm/amd/display: Add DIG_CLOCK_PATTERN in the transmitter control

Eric Yang (1):
  drm/amd/display: move edp sink present detection to hw init

Fangzhi Zuo (1):
  drm/amd/display: Add return code instead of boolean for future use

Jun Lei (1):
  drm/amd/display: revert support for DID2.0 dsc passthrough

Lang Yu (1):
  drm/amd/display: fix 64bit division issue on 32bit OS

Qingqing Zhuo (1):
  drm/amd/display: DP HDCP Compliance 1A-08/09 tests fail

Wesley Chalmers (1):
  drm/amd/display: DIO Supported for virtual displays

Wyatt Wood (1):
  drm/amd/display: Initialize dmub_rb_cmd unions to 0

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  8 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 40 ++++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  7 ++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  1 -
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  3 ++
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  6 ++-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  2 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c | 15 +++++++
 .../amd/display/dc/dcn10/dcn10_link_encoder.h | 11 +++++
 .../amd/display/dc/dcn20/dcn20_link_encoder.c |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  5 ++-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  4 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  7 ++--
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  7 ++--
 .../dc/dml/dcn21/display_mode_vba_21.c        |  7 ++--
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  2 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 29 +++++---------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 29 ++++++++++++--
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  2 +
 27 files changed, 135 insertions(+), 69 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
