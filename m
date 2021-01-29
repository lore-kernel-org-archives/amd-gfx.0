Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B89C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B213264E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B213264E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E7F6EC1D;
	Fri, 29 Jan 2021 21:28:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3760689D43
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC5wCClOTj/v9hpk7fyCttwYXl9NNcKbfljKQE+/atNblS55NukHyYaNJaxp90Cr6i2EuBkqqMRWTUMC0nMJKchHiW/XJaSLs6EQvMeef24MFLmHyFmCsjV7tDj1SfYMznYCwAqx6nFWEz1B2L8LdkHaI5D97N9C15h4mNmsATv02wXklfnkohCr5hFJEcbI/3U9xaugAwZqcaOcYylq+YHsnN2vQ2UUcz5YC8uqHM+a6AkcOMAQXT98+ZxUZ0ca1JB5DGhw+Hq5Ksk2zivSSxLw2+C2dt66yIZT2jt42Ne9GZYVNOxARIAfDmjtJifF0ldB9BZtIBLvtakr3TTMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxsms7SWB8tvgXJGeocUL0sbzmda8hKffLQlSkSMes4=;
 b=ak2cT8a1EsD7JS4s6wEZOkHIRvNO116xq5zOyIzQKii60jqwAhNK80v+CEJzsNfoTqOYJMGiN8szhM28JPQBXim8M6K3fg4PcUKVpR+0MFi4DNfxgs68k0AC1/7m0gplieDrfPvLZTeXbQLEGBlahznawUJ82g7J4caL3CH1bgNAZfx36Fpx8gJ1OIKdd72U1aCkXCII4h8GaWK6+GYnQ+r1mLD9QCgxjiWOx554DvetsgVHiPXbo5IWJgRDMcvo+otCLnHCIQU0RLO6vURcC6FJFi6FsXYnanfFI5pcoM2/tieT69eaUVntbk4Jl1HansvZKUOroki9XpSYFb4b2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxsms7SWB8tvgXJGeocUL0sbzmda8hKffLQlSkSMes4=;
 b=ohbAyCcIWm8VEA2tNG3dYctjN7inorQTbOTM7QfEY9d80kvxLbxsNJqOvMKK3WHUEGoNKR+Y5DJ+MZ8JxlW5weq13oHUO7Z9Wh8fPC6CSY0HV6V5MQuARHTLNxGYpL0Y50e/JbiC3YHuPYYC5ZozmolF4RrUkXcwnIwvq/bK7AI=
Received: from MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) by
 BL0PR12MB4738.namprd12.prod.outlook.com (2603:10b6:208:8e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Fri, 29 Jan 2021 21:28:01 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::30) by MW2PR16CA0018.outlook.office365.com
 (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:27:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:27:59 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:27:59 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:27:58 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/27] DC Patches Jan 29, 2021
Date: Fri, 29 Jan 2021 16:27:25 -0500
Message-ID: <20210129212752.38865-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85feaf19-3c4c-4f67-fec9-08d8c49cc0aa
X-MS-TrafficTypeDiagnostic: BL0PR12MB4738:
X-Microsoft-Antispam-PRVS: <BL0PR12MB473831385E39309A0C4827C1EBB99@BL0PR12MB4738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVBmWuTZj8VO9LYhvJHZq0I0HHTYhJpfdj1vjVQcIjt2BYPK6YFMTMVRyM7OdUHvmv5uSuHoZLf0YaWQO9U2qeNgm/6Gu5cH1xX4vmtKpsEEf2g1oscmfjFxBG0ueAsXn2+552r35JXfiOqeK0R7UITUi95yQ0CMppp/5bTuuvdyYiO+msEXniZD9Z8vqUyEA/UE33njrPje0/Pl4/WiYg8KCXm6YLDMz9JyrJy1V8RxcKfZiI8pR+c0wV1LvymOpemUnKE9G/SBozRLRZXEW6ZXRSIK08WH+hEvrks/vEMagg/3SnCd8aKEGbFi/fkTB11qTVBFZA6P04HcaXWa51eWEJ5t2APfaHgxsgiVW7HraFnobUaDNrxdW0ktg+6gKS5KHd88JHieObkah9be2G91gbdPt9BfdF0+qkZTtlQhGxTdItHPiWTgW1TxO2uHTdOITmcSQfyWNs6VSPsH9QnOKcVFYjGfOOylOrK27AHhQMAn5RRGP7bPbf0h3hDZyKFq0NTvSwjxpgesqQl5BKV3cif/NQ+CNuSv22CZKpaL4wTf6TKWKpREAqfsQG0/LxMskkhy2tqM5rvcWmI8KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(336012)(426003)(83380400001)(47076005)(2616005)(36756003)(1076003)(186003)(2906002)(6916009)(86362001)(478600001)(8936002)(4326008)(5660300002)(82740400003)(356005)(6666004)(8676002)(70206006)(81166007)(316002)(82310400003)(7696005)(26005)(54906003)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:27:59.7610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85feaf19-3c4c-4f67-fec9-08d8c49cc0aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4738
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

This DC patchset brings improvements in multiple areas. In summary, we have:
- Better handling of dummy p-state table
- Workaround for some legacy DP-VGA dongles
- Add Freesync HDMI support to DMCU
- Enable "trigger_hotplug" debugfs on all outputs
- fix initial bounding box values for dcn3.02
- implement support for DID2.0 dsc passthrough
- fix calculation for the pwl backlight curve
- Fix display detection on HDMI ComboPHY
- Drop SOC bounding box hookup
- Fix DPCD values
- Fix multiple memory leaks

Anthony Koo (3):
  drm/amd/display: [FW Promotion] Release 0.0.49
  drm/amd/display: fix calculation for the pwl backlight curve
  drm/amd/display: [FW Promotion] Release 0.0.50

Aric Cyr (2):
  drm/amd/display: 3.2.120
  drm/amd/display: 3.2.121

Bhawanpreet Lakha (1):
  drm/amd/display: reuse current context instead of recreating one

Brendan Steve Leder (1):
  drm/amd/display: initialize i2c speed if not initialized in
    dcnxxx__resource.c

George Shen (1):
  drm/amd/display: Fix DPCD translation for LTTPR AUX_RD_INTERVAL

Joshua Aberback (1):
  drm/amd/display: Better handling of dummy p-state table

Jun Lei (1):
  drm/amd/display: implement support for DID2.0 dsc passthrough

Lewis Huang (1):
  drm/amd/display: Set power_gated to true for seamless boot pipe init

Michael Strauss (1):
  drm/amd/display: Add null pointer check to is_dig_enabled func

Mikita Lipski (1):
  drm/amd/display: Release DSC before acquiring

Nicholas Kazlauskas (2):
  drm/amd/display: Drop SOC bounding box hookup in DM/DC
  drm/amd/display: Fix CW4 programming for dmub30 cached inbox

Nikola Cornij (1):
  drm/amd/display: Reject too small viewport size when validating plane

Samson Tam (1):
  drm/amd/display: fix initial bounding box values for dcn3.02

Stylon Wang (3):
  drm/amd/display: Revert "Fix EDID parsing after resume from suspend"
  drm/amd/display: Enable "trigger_hotplug" debugfs on all outputs
  drm/amd/display: Add Freesync HDMI support to DMCU

Sung Lee (1):
  drm/amd/display: Add more Clock Sources to DCN2.1

Taimur Hassan (1):
  drm/amd/display: Workaround for some legacy DP-VGA dongles

Victor Lu (3):
  drm/amd/display: Fix dc_sink kref count in emulated_link_detect
  drm/amd/display: Free atomic state after drm_atomic_commit
  drm/amd/display: Decrement refcount of dc_sink before reassignment

Wenjing Liu (2):
  drm/amd/display: correct some hdcp variable naming
  drm/amd/display: remove unused force_ignore_link_settings debug option

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  76 +++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   7 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   6 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   4 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  34 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   7 +-
 .../gpu/drm/amd/display/dc/dc_edid_parser.c   |  80 +++++++++
 .../gpu/drm/amd/display/dc/dc_edid_parser.h   |  44 +++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 120 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h |  11 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 111 ------------
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  10 ++
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 143 +++------------
 .../amd/display/dc/dcn301/dcn301_resource.c   | 107 +----------
 .../amd/display/dc/dcn302/dcn302_resource.c   | 168 +++++++++++++++++-
 .../amd/display/dc/dcn302/dcn302_resource.h   |   2 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   7 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  29 +--
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  10 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   2 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   4 +-
 .../amd/display/modules/power/power_helpers.c |   2 +-
 37 files changed, 625 insertions(+), 438 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
