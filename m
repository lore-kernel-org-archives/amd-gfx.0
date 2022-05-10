Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7C7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FDA10E7E7;
	Tue, 10 May 2022 20:45:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26C710E7E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqepVUCIMDMogecjDBWOW8vUXQPE0QyJlKT521/n3/gik79fl3nVZM7LyqQq2r/jLPrK43KYnaPMt9YLx2Pik6MaKWlkC93uoaL5J5k6AWcZmHm9VB1Lu3RHgO5B2Qxk10bdPiUSpah+Za7y67s10rKUZCBZlf48wWUg2+ND8YRiUaPupP3eawdo3w0Yj+0EMI/Chisf4X57hZ+Qw8RvePaIqSdFcFUoJ7GH1v8V4pYgxDEedm4m7cupnSFUhUwZaZA1CtJBlNxMgwAjma8knHTr/GaMXVYuzv9k3Js8/nes/L2MgM0z8vyo204H6Uq8iqRcgzwgpuvHR3tkDYXk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQk2vB+kzpOuC05mEpIUAl/Wk1M/PqOwOPugiuiB2so=;
 b=Hk+v/4mIBw5Bth7yFYS2SfX0KP14hMk0+Kezjen/2BoKf3VcTruLYg0fbDc5IHd3pRhd6GdDN2OIAVFaoaBHR7hlKTSE0NltwLthiUeX8jkXLAvtSZQ1S1p/Z6NW9hal+qvwCLQajMjbqzWMSvWkCKfI9+aueBETVsgdfiesFRclQXMRcLFI0DVrSMHh+M0DxyltSp4Moz2VDBcN76CSv2SO+COHWvbxJOjtZtOKSmot2n3mAmqRXOUSAhecRQfmje0Im30gVgYrfBiBaFZ1YEzr941c2N7BOK8s5rSK3QmjohoQMAwjm7xAWV+Ra7WD/nH4c0y5JwnnIP+chfy5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQk2vB+kzpOuC05mEpIUAl/Wk1M/PqOwOPugiuiB2so=;
 b=rZVu9+R0lRnb8Kzz+B8dbDfoLokexjCSfoCJWEtJdsu8bjLSVnYx82PL4Vz7tLtS6Hc8yyK+l+c2XKBk6BF1MCViYwro8pCqZg93hMWizAyZhguZwDerpSD2IvznSp6ag9I3hSw0NFzO7JRxB66MFbLouUDwZPQ+cPV2CPm6hsk=
Received: from MW4PR04CA0075.namprd04.prod.outlook.com (2603:10b6:303:6b::20)
 by DM5PR12MB2391.namprd12.prod.outlook.com (2603:10b6:4:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 20:45:22 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::1b) by MW4PR04CA0075.outlook.office365.com
 (2603:10b6:303:6b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 10 May 2022 20:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:45:21 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:45:20 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:15 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 00/19] DC/DM changes needed for amdgpu PSR-SU
Date: Tue, 10 May 2022 16:44:49 -0400
Message-ID: <20220510204508.506089-1-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8420ee29-03f9-4c4e-b7f3-08da32c6007d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2391:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2391C753B047F018D701F9138DC99@DM5PR12MB2391.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9rfI0d/O3rgXeGvsGN/a5s8/dLbfw9o4bAJuGXhTvw9LW67eHxCJ20UAz/83V7PawfRFUrL0Oyug56WP4dqK71sY4xo9vUPpJP+BWn8vmVh0L5nrZ0Y/NBJkZBeeHhZBzO4rcCKqngwBDCd1V2SGDy32UUkZeb8qdql/xjIMsoVXWa7jnqgn4TCWZ5vsG0b49cWAFhEvU7J6+jXgemHW2PArCBS6bfaAnBlse/sjSLbzmqXVP3GJyzGONfxgPulE8qhDUljSW0Y5caBuijabfRsV37pgJeyOHpj5aKwrcPWKUnf+IuE2bCWejF/BwG1xYo2SFFEUx0FLd3D6TWszfIIwgKMEA+4ovAVzTrtPoxTn5UozJjtX13bEb7/2mbr55aqAwX6PQDxL5PR7lr4hv/9R/x+Q/VpQ2uc+RW3++vfwkvpv1A07W2lcK29eYUnrll4qeZsWv7BEuKI+dEZ6QedOOnCsiIdkfGntpR2yogYj3z5MbhmtsM/n9fFFWdwcY6nkeQwqXMN59d3A4fFe+H6/FZTup6HiBhTp67l7ihNW3ttNskT34n5bUtTfpNWKMwt6KuJz/uRczZUoxrTmKg3OSrJ2KRLdMF5NV95P0Sg+ESh1BQKLHRgyAgozMH8HrQpzKrZTb5v2Acpzln1yvIIdUPyXe7PUkme3VemHKbyJkYnJJNeChmxPO4L0cHeKNKLB2CCNx7w11FRzBgWsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(508600001)(36860700001)(83380400001)(26005)(1076003)(2616005)(2906002)(36756003)(336012)(426003)(47076005)(82310400005)(40460700003)(86362001)(356005)(8936002)(7696005)(5660300002)(70586007)(54906003)(70206006)(6916009)(81166007)(8676002)(4326008)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:45:21.7624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8420ee29-03f9-4c4e-b7f3-08da32c6007d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2391
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

changes in v2:
-----------------------
- set vsc_packet_rev2 for PSR1 which is safer
- add exposure of AMD specific DPCD regs for PSR-SU-RC (rate-control)
- add DC/DM change related to amdgpu PSR-SU-RC


David Zhang (18):
  drm/amd/display: align dmub cmd header to latest dmub FW to support
    PSR-SU
  drm/amd/display: feed PSR-SU as psr version to dmub FW
  drm/amd/display: combine dirty rectangles in DMUB FW
  drm/amd/display: update GSP1 generic info packet for PSRSU
  drm/amd/display: revise Start/End SDP data
  drm/amd/display: program PSR2 DPCD Configuration
  drm/amd/display: Passing Y-granularity to dmub fw
  drm/amd/display: Set default value of line_capture_indication
  drm/amd/display: add vline time in micro sec to PSR context
  drm/amd/display: fix system hang when PSR exits
  drm/amd/display: Set PSR level to enable ALPM by default
  drm/amd/display: use HW lock mgr for PSR-SU
  drm/amd/display: PSRSU+DSC WA for specific TCON
  drm/amd/display: add shared helpers to update psr config fields to
    power module
  drm/amd/display: calculate psr config settings in runtime in DM
  drm/amd/display: update cursor position to DMUB FW
  drm/amd/display: expose AMD source specific DPCD for FreeSync PSR
    support
  drm/amd/display: PSR-SU rate control support in DC

Leo Li (1):
  drm/amd/display: Implement MPO PSR SU

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  23 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  64 +++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  21 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 +++++++++++++++++-
 .../amd/display/include/ddc_service_types.h   |   1 +
 .../display/modules/info_packet/info_packet.c |  29 +-
 .../amd/display/modules/power/power_helpers.c |  84 ++++++
 .../amd/display/modules/power/power_helpers.h |   6 +
 21 files changed, 887 insertions(+), 19 deletions(-)

-- 
2.25.1

