Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC1EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9841861213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9841861213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311C48825E;
	Fri, 12 Nov 2021 00:54:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A13B8825E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDiIk3XjjtQUfCJcXt2otTTWjGrtxOvoK4hEAEQRRLL862vcznXHhBF/CtcipOrjFXNgbp9ue++3cSk25iWTtdTMTTlC1VNgqiF3d0M6gzP/opuy1mZRt8+bYuEoKgVcNEiXzG8mlZlwjaRuhl84y52TqJuOt0Ns6gSgYD3GJMWHyP4SazzShi/lNRlh9MlRr8SsLPmPtOFxw4VzALqThrX0kDWCz/3mv7D6rrUYfggk6OLkXQlMcqkcuxLSPreELkjRZoBw08AG1dwGqLsBPmlM+v6gFG2DpE6Uw1/P9R9EEGVo+L2LkEtludPLZ6QaCHRm8Ta1gqZdieu+S3pX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLO7DpJg/rDe977qNK0J/RHguLKCJwC1f7w9QZAtOH8=;
 b=OF8dX3xtkd6VPcfpaXTGLCEf0xd5c2UCoM6Zyo7cX+PzWfQZVFIONiayDh33ITjE4ERv8eEspPAfEW+YARuIg1rXwxWzdcjWOQlo9l6SDfq5Qui00zaCi56iHVVnLgbRL1Wzg4VS5DSQtuLKJbdGFocIrDHgs5uhrVsU1wSJEl8eXu/CA80P6svU4GnZkhiiIttdE4KnadbScU9VikvzCG3DYCJRWS8TtuBMM5g1O9QLcGzdxOK7x+uUtaGjjYzFA4JZ83XulJRYsXKvqLZcAh+RlDIsoOQg/TDgnjmanGC9927Q4RF/yuxiZTDJGtqR2AgVbf6Ur2PZ8JxFFshg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLO7DpJg/rDe977qNK0J/RHguLKCJwC1f7w9QZAtOH8=;
 b=IHlmFDgYQKSSAMdZ1JseWuEDqAjJMsUhT8c+lRWWIJXXrIiGYzFt0XSLiFteiYpepH/duAhKNA3IOUMEBzSQjrwl5W48fxsHxX0HxZW3RJFv48bGDNw0Oz6hSxl2YDtAPNKL8MBuf/3P/Girm7ECWw3EGHZf8pEfsycGBqw482E=
Received: from MW4PR03CA0067.namprd03.prod.outlook.com (2603:10b6:303:b6::12)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Fri, 12 Nov
 2021 00:54:53 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::24) by MW4PR03CA0067.outlook.office365.com
 (2603:10b6:303:b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Fri, 12 Nov 2021 00:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:54:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:54:51 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:54:50 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:54:42 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches November 12, 2021
Date: Fri, 12 Nov 2021 08:54:24 +0800
Message-ID: <20211112005438.5505-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6682436a-1364-4e1a-b9ca-08d9a577096e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:
X-Microsoft-Antispam-PRVS: <DM6PR12MB412472C4449A0653F67AF525FC959@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrsK9+iJNVsY9Ean0OIPXXrUhoae9otLomGJetkWDCcP2u1eqVly4QKE1J2sMxUX4Imvby5zWfkqW6uNluTtDU8jBOZeiZi+E48bdOcLne6ha0DXB2XvMguS9e9yQsQ6iEHAt6dPW39iMHUFYvklu3jwOJxsfhZTL//Cp355oWycBUUjPBCxArXmm1TlwYtKO0JQsjGuEW3F4RtRRFfK2oeRCXSs3Mrd8VX0Rf8h1OJ3Yd8OgpE0+hjMtjAPfvtTq73GxAFploe89uuc+euzTaRmmtTLWgPhGijb8xg/5ak922BU4wdxjOG0hg7YQdtdWpEBrAAp0/J7Q9/AouNSPig7CPkuZ8vBSKix5Tz/PIE0IjJjkSITzB1HEVTKT0vInEZGz2yP4MoiYZ3Gk7ymQOeS6jBuDwt4UWq1FDh45x0yXZBvQNpqSLsudJq3UO99pwS1cogLFF3wxIQ4f3IjVEPYnchuwcm0trTiXSMS/tJ3ismChAK8nHcZMnpKNPFS7/cZGBd3Z5swVQIrX90H+UQi3I8oXh+15/19FPoeDDqA+yfoJQQu0i4G3myjuvurwbFhH1kZShIYjHeoQ35Y5H+h4CtVoqd2Y0HF0Bw5v6btrawokMCyO43VZysUPTe6o/N7AqYOpZxyJ0B1Qnw9e1BOQyEdJokYLuxvA2ozHa2cr2W0EGiIVme3Sfjig/8fdzKbGFvjzbNGgT9U7WLwAzbRYYfXFkdrHqVXqHHPaKE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(82310400003)(7696005)(6916009)(508600001)(4326008)(2616005)(6666004)(336012)(70586007)(81166007)(8936002)(8676002)(1076003)(47076005)(316002)(36756003)(5660300002)(70206006)(426003)(54906003)(356005)(36860700001)(186003)(83380400001)(86362001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:54:52.5859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6682436a-1364-4e1a-b9ca-08d9a577096e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Fix issue that secondary display goes blank on Non DCN31.
- Adjust flushing data in DMCUB
- Revert patches which cause regression in hadnling MPO/Link encoder assignment
- Correct the setting within MSA of DP2.0
- Adjustment for DML isolation
- Fix FIFO erro in fast boot sequence
- Enable DSC over eDP
- Adjust the DSC power off sequence

---

Ahmad Othman (1):
  drm/amd/display: Secondary display goes blank on Non DCN31

Angus Wang (1):
  drm/amd/display: Revert changes for MPO underflow

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.92
  drm/amd/display: [FW Promotion] Release 0.0.93

Aric Cyr (1):
  drm/amd/display: 3.2.162

Brandon Syu (1):
  drm/amd/display: Fix eDP will flash when boot to OS

Jun Lei (1):
  drm/amd/display: Code change for DML isolation

Mikita Lipski (1):
  drm/amd/display: Enable DSC over eDP

Nicholas Kazlauskas (1):
  drm/amd/display: Only flush delta from last command execution

Sung Joon Kim (1):
  drm/amd/display: Revert "retain/release stream pointer in link enc
    table"

Wenjing Liu (1):
  drm/amd/display: set MSA vsp/hsp to 0 for positive polarity for DP
    128b/132b

Xu, Jinze (1):
  drm/amd/display: Reset fifo after enable otg

Yi-Ling Chen (1):
  drm/amd/display: fixed the DSC power off sequence during Driver PnP

hvanzyll (1):
  drm/amd/display: Visual Confirm Bar Height Adjust

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   73 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    5 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  167 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |    7 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |    7 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |   14 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   37 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   15 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |    3 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |    2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |   14 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |    3 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |    2 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |    2 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |    2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |    1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |    2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |    2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |    2 +-
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |    4 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |    5 -
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |    1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |    1 +
 .../drm/amd/display/dc/dml/display_mode_lib.h |    1 +
 .../gpu/drm/amd/display/dc/dml/dml_wrapper.c  | 1889 +++++++++++++++++
 .../display/dc/dml/dml_wrapper_translation.c  |  284 +++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |    8 +
 .../gpu/drm/amd/display/dc/inc/dml_wrapper.h  |   34 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |    3 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |    4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   18 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    9 +-
 .../amd/display/include/ddc_service_types.h   |    1 +
 38 files changed, 2599 insertions(+), 31 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dml_wrapper.h

-- 
2.25.1

