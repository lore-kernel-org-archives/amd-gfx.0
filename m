Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0007C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E1323A9D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E1323A9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B4B6E45D;
	Fri, 15 Jan 2021 17:27:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED9856E45D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDlqn246aQznBe8viU9sG5FYdh9Z/QqjH4FUU7/emD51ziNhYnKOEO11KP1eRMU8gnFSqn9fQLU7Kc8rtJHJG1qmMGjs8UrcKzD7VTYEFNxtClV0XkpUCOjdZAylGB5gqledTVRbVUxY68NEzDxWAjOpWLGwsglj5PGdptx8xqf4IAFuEl+arfApo5cWUCKnSimdSFGWjnTVL+PN2vsMlfSXwIj1m+rk2E492ZbNgB0ak73ohgaqOR6mEAUIcHqGaKA5mW81wkbX8ioSLWhAZFQNAceyO3eKZOdUzIwU02m5QC2rKv52luQUmhZfWZ0aEVlEU9COHTUOgrWOLZl7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Biax0Gr0dudaq7iDT1IRk69IkUpWA43G7VwpKYNf/t4=;
 b=XRH26dx47UH18dGnlWqFjTObvErMi2DOC7XIkM5hb9UvGr0QN6RbsrmMWLrPDFmCG+xfOEUD1AvgyRq0j8P4NNLVRFNMdI5LsL1Fe4lpB9AMiy6vhSBRYIfwc1A5kHz2F3evMqmJZNreXHLJOVHUfx4gyh5Fot0DZ+uDpmviXoafBSy+omtuLNU4F4uvnB3TWIY+gAdiH8KvraGNUQ6jm1e0W3FNc4DhZVmiIAlq8Z1+bgOxvI9Svj7/GAFSFSbTZMucssgGs9FeQxAYaOGV9KyG8KNJ0VzPKU4Omj/Hmc+dpiWmlpWrcwMHSIOb1+8XJY8sfpJkpiaey10N5mH64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Biax0Gr0dudaq7iDT1IRk69IkUpWA43G7VwpKYNf/t4=;
 b=TTY+pbrCsE2evCadlBlnyICatZf3LcklCfo7Ph46gLVejT8oIcD6lkVLSbXqVBlk8bPXlOMjKfOcttousgr3aIGUjIWtsyxSMGZ3pdJ3ME4nHrRg56w7u5ItWputv4lSUc/Nvd4l88T83wPf6Uh/PhUqbDW5U0s06A0B+i/YLYQ=
Received: from BN1PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:e0::29)
 by BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:27:53 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::e4) by BN1PR10CA0024.outlook.office365.com
 (2603:10b6:408:e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:27:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:27:51 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:27:51 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:27:50 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches January 15, 2020
Date: Fri, 15 Jan 2021 12:26:59 -0500
Message-ID: <20210115172714.126866-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8e7b2f5-21d6-4adc-e30b-08d8b97ae320
X-MS-TrafficTypeDiagnostic: BL0PR12MB2547:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2547E7F3E54D837D954562B3EBA70@BL0PR12MB2547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqKvJBPqY8lY1ojrTQSHFx9C6F9DPAaW7D2UIIBQur8CDgZqIR6BGMFRVPtVHxTdGNbsIeZmGdLsQ1ktj5nQC983th0eBIf3/wvRjYsC3FHPL2iQdHiPP9XH0ioBQqEHyEwIL8Tyhtq38Jdmoae+pCLO6OeJDnNKC33TSrCcm1aIC419cMzWW2DGTylfvY6qNdZlyEVcKAeedHj3mTGe68ipvRkWlNOHGS63SWpD1ga8k0z1FZHDhYKqUE4zgOkyMJtKyYvFXdhnyV2UIgkrJyobdh0lxfiaJ7lnpKoPrlmMJ8JJj4bKlVPkLfqWX5PNpWJV9PvcBFaOslZAl5xX0mUpvGHgvQtpxjhFrk4ZirDeFiGCZ18bu9c8t30zEqAMUkOfQll075tRsqS5kDdlRtUHaPdll8sEO7NE+iH3WIRJzvSHAk5BTV9nwEhvqZlmzK7/7Hnvbb0YFwHbaI38i/mAiOdoFMTiFCJWnIsIivzzWUGhwTk6tt4LyINV1oGLaDlL1E3MJ5BBbo7dQRMY1J++sd7+uBO6hH/Fyzj8+hqHpwga2RI4bCkytR7AJ3rkU+MLCulpZG2Z7QfFMntAncUMz5vJNVYm/rEfmZmluJXKmU8ZjOo35Ho0bDj6iyHx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966006)(2906002)(356005)(6916009)(8936002)(83380400001)(86362001)(7696005)(34020700004)(54906003)(186003)(26005)(2616005)(36756003)(82310400003)(316002)(426003)(5660300002)(81166007)(70586007)(478600001)(4326008)(70206006)(47076005)(8676002)(82740400003)(1076003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:27:52.0227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e7b2f5-21d6-4adc-e30b-08d8b97ae320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
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

This DC patchset brings improvements in multiple areas. 

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.48

Aric Cyr (2):
  drm/amd/display: Allow PSTATE chnage when no displays are enabled
  drm/amd/display: 3.2.119

Bing Guo (2):
  drm/amd/display: Change function decide_dp_link_settings to avoid
    infinite looping
  drm/amd/display: Fix dml20v2_ModeSupportAndSystemConfigurationFull()
    to check DesiredBPP.

George Shen (1):
  drm/amd/display: Log link/connector info provided in BIOS object table

Jake Wang (1):
  drm/amd/display: Update dram_clock_change_latency for DCN2.1

Mike Hsieh (1):
  drm/amd/display: disable FEC while using eDP

Nicholas Kazlauskas (4):
  drm/amd/display: Use hardware sequencer functions for PG control
  drm/amd/display: Allow dmub srv hardware reset before HW init
  drm/amd/display: Guard against NULL pointer deref when get_i2c_info
    fails
  drm/amd/display: Fix reset sequence with driver direct DMCUB fw load

Stylon Wang (1):
  drm/amd/display: Report Freesync to vrr_range debugfs entry in DRM

Sung Lee (1):
  drm/amd/display: DCN2X Find Secondary Pipe properly in MPO + ODM Case

Vladimir Stempen (1):
  drm/amd/display: Fixed corruptions on HPDRX link loss restore

Wyatt Wood (1):
  drm/amd/display: Allow dmu_stg to support cached inbox for dmub

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  28 ++++-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   6 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  18 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   9 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   7 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 117 ++++++++++++------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   9 +-
 15 files changed, 171 insertions(+), 65 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
