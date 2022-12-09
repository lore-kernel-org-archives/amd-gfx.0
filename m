Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF3EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF4C10E55C;
	Fri,  9 Dec 2022 16:37:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACF210E558
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHcfKisSUbLqLRXrAEeE9oqJw+QiZN3ZImSQIQQGNDfcpjWyxERQleZoScrwAt0UynebKRDrWnVzxVQ7DGLEXGQpnrSZhfQGGaTQkbLRfOjAHZj2aW+R4Fv2y93/bGJ4VzBMitRTHxWkQrhO6MKGKUBvvOVh1P8e7eBIj+kwB2s9b0VLXOz7wAP3f6R0ghNEv13PwodJP/pD2ocF0qNz4v+K6phOmE+CPz0cUybCzc7Wcijy2sBpWaMfHRgbJJWao5TITiMRX5dRo4LuqSTZIQK9U6hSrlXpXt2eiIA6UromYCxtNwm/VE8Ec2FShJWOOdPHXAjbCq06CnHDtW9xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RzREG5aKFpWhD4tOMZAP2SOdnPXEzOc37TlZla0fAE=;
 b=SSyDR+22za6osK0OT60Ti1OKCk6EA4Rnd2LNxguxhmOL0/+/XKPEuFZBYsNfKI4BWlca7f1nhGXAcHFmwK+tLXTEjtG1fZSL/7fI5mPY1w7OZOVd8zbUijScsRNJpbU7OWyyBSROQ446SEnmtbG8Hx8yPL01ucpvw/l+KHsSvHV5zmshc9Lp2paLAQ4AWRouB1AwKZPhd7pwyHoDF5R8WXziWbEOuTzbKyAKlF0KKF0ylapdnRE7HvBxkmDd1APkUI8tN3/7zEFb5jeFwdyC7d3ofor+xfOMJly2XUhSx2X6v6cOzbWEkJk/5EcQ0qtOJRql2gPDxlUbuCC8QVDTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RzREG5aKFpWhD4tOMZAP2SOdnPXEzOc37TlZla0fAE=;
 b=Y0K8dfyjXuZyBWUeRJOhFdxuHjIjyfjdUY4YHYjA6/g3zzNzy+Ljm8kYLLipwJtpVg0nHpa6DO36zRkVfbMtOcuE4zHAXD9QAfRE3FSBibMw9zRRhgtArikW1UbFreUo5ssGg4enaK9GYLIDlV00CqFJbjRdIc/S3CNJn94xQTI=
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Fri, 9 Dec
 2022 16:37:16 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::cc) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:16 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:14 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/23] DC Patches December 12 2022
Date: Fri, 9 Dec 2022 11:36:24 -0500
Message-ID: <20221209163647.25704-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2ddc20-ace1-4d8a-a3e0-08dada03a212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC1ncrUzgmd3Tl0Uqf4GNTM/fDwkA8lGJ+PmLdUUf2MIYVjX3VPJEp43brgl8DtEugN1k0EIDZ5zuZO3QlMdPgMirV/X9Ig0ik/AdsF5YXB9/J8KN0qf2NYY4hOgu2/5Adz1LonyuysoCXVmPfG+2BSZwX50qu/nLMXnBIwkZEOBA82EIM4D1EQkVHHYQSKRlAl00cChPCFdONmQagfImMvYCoIY3HeOv4fDFIOZq/4172NcbUSjf9gteL554mSPi5TsZKlmx+HaUz2tksJTvI9t/UzB2Hl+HnO3c1CGQeKLKxoQ7NFrY0ZceNycqxCVoq8QvlKmXCMI4QcYfVdM3xhN2sImfaOj/u4qSFbi1xFVunMRHRvrdSid2L/VMwjgbyVg3IoZjqpsFJIqMClnhCZ3jsYgZq/35lRfKDFScjMypMJQXA8Yg6gTkuLhK0H+bdxNJtkXYBeEE8iqEd+m8VrqDYrwQQsbahPsj5CnVm/4fqyJkI5FKIO9FvGEaDujlkxCceE4YXqssYiJfPKaG6VuwADAdzoGP6UalRe294LrmEeXJsRVSLSWLabebv+sQcJTgKgdDp6C+fIJmurnKuC1YM8rrb3PBw3axJAljekgc8ceM6mZAK2s1QfAi0Mf5SQM7+FiTgh2Mtww+GFXSp8+V/1lFVjOSHWMLIOZ466231e8S83UUQGcXPlCc0roy8rgarzXhsut30u9EExZyMyl9mHREqhgVQr6t1Gl4V0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(82310400005)(40480700001)(6666004)(1076003)(186003)(426003)(47076005)(26005)(2906002)(8676002)(70206006)(36860700001)(4326008)(316002)(336012)(2616005)(6916009)(83380400001)(16526019)(478600001)(40460700003)(70586007)(54906003)(8936002)(81166007)(82740400003)(5660300002)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:16.3827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2ddc20-ace1-4d8a-a3e0-08dada03a212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, jdhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fix array index out of bound error
* Speed up DML fast vadlaite   
* Implement multiple secure display 
* MST HDCP for multiple display 
* Add DPIA notification 
* Add support for three new square pattern variant

Cc: Daniel Wheeler <daniel.wheeler@amd.com>



Alan Liu (2):
  drm/amd/display: Implement multiple secure display
  drm/amd/display: Fix when disabling secure_display

Alvin Lee (3):
  drm/amd/display: Block FPO / SubVP (DRR) on HDMI VRR configs
  drm/amd/display: Clear link res when merging a pipe split
  drm/amd/display: Block subvp if center timing is in use

Aric Cyr (1):
  drm/amd/display: 3.2.216

Dillon Varone (3):
  drm/amd/display: Add debug bit to disable unbounded requesting
  drm/amd/display: run subvp validation with supported vlevel
  drm/amd/display: Reduce expected sdp bandwidth for dcn321

Fangzhi Zuo (1):
  drm/amd/display: Demote Error Level When ODM Transition Supported

Hamza Mahfooz (1):
  drm/amd/display: fix warning in amdgpu_dm_crtc_configure_crc_source()

Ian Chen (1):
  drm/amd/display: Revert Reduce delay when sink device not able to ACK
    00340h write

Ilya Bakoulin (1):
  drm/amd/display: Speed up DML fast_validate path

Leo (Hanghong) Ma (1):
  drm/amd/display: Revert Scaler HCBlank issue workaround

Mustapha Ghaddar (1):
  drm/amd/display: Add DPIA NOTIFICATION logic

Roman Li (2):
  drm/amd/display: Fix potential null-deref in dm_resume
  drm/amd/display: Clear MST topology if it fails to resume

Samson Tam (1):
  drm/amd/display: Check for PSR in no memory request case

Wenjing Liu (2):
  drm/amd/display: add support for three new square pattern variants
    from DP2.1 specs
  drm/amd/display: use encoder type independent hwss instead of
    accessing enc directly

hersen wu (3):
  drm/amd/display: phase2 enable mst hdcp multiple displays
  drm/amd/display: save restore hdcp desired for disp unplug plug from
    mst hub
  drm/amd/display: phase3 mst hdcp for multiple displays

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 252 ++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 153 ++++++-----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  26 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  38 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 160 ++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  17 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  25 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   6 -
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   1 -
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  80 +++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  15 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |   5 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   3 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   1 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |  16 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  25 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  37 +--
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   2 +-
 .../drm/amd/display/dc/dml/display_mode_lib.h |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  83 ++++++
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |  21 ++
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   5 +-
 .../amd/display/include/link_service_types.h  |   7 +-
 32 files changed, 711 insertions(+), 296 deletions(-)

-- 
2.34.1

