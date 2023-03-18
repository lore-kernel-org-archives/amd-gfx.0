Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7A7C61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB3A10E04D;
	Sat, 18 Mar 2023 07:56:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D645510E04D
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOQpb7BOKtGrPcjgcPVpkUYK5tfjyVhsST7Qv+iDErvbiawcJ5molIPpOQn+IUyjfiqJst5cUyLiHgTi7qyjm16ZGVk3cn35T3+fDAf+SBpLg5xuplp627Er8AGI+A/kCGM/eqBEvw8j+TkxNbRxz0AfOSoua26tANLVGg07MQfiRHHznPpVyrWiS1su0pQ7y0/wxWcbl+g3q7fXsFywKimXH6996fgQsx94NZ2j5OLlw4+hb/+NtMgmBbGQ4rmgVOf+EqXvRZQt7gjO603+8uZYvo1FyV/TBiXbCWL5ovAFvmC4iNYLYQ+b0nXHzQ1lySWXlh+tNl6oCLX9IWjqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DG7EqX7nioTWoPngzjp5cGpp+CDHXYgInom1ts5UT8=;
 b=MtFdlMpk+1hZ/lHkuEUVnZjXVob9JXcpfLO0nHSSrEmqh7L2N4HrUWe8ZbDOaaZh7ugHPMCL9g/RQo+ADdvHBRRTVIPJGTJZDVdUuxAAbHKLbg+eNLdxGcHnBOCLBDGFdpxDAXKhQiT69w0lhNlmd6A5Iic7una5MsHXmesZ9D/qIfwHs51PB9Cp4UmPE3tvIMKMi+aKbUNV2/1B3BGP00k+Gkfd5GwlKKKopxn/cGdmr1U/RAn0WxmE324fFpANC9U/1dCHsmzqM9SJVWWTG+FrKGfenxr60zrrt8yAcBS6JP/XdVMJ0MG564PNXcngs4Tx9Pi1Cz08AkZuuVWUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DG7EqX7nioTWoPngzjp5cGpp+CDHXYgInom1ts5UT8=;
 b=IISK82FiXECqw82Aw+HuWNjDTzkV++TQCuGoJDDIZtObL0wcp64102aMbKGOdN9f5m9e3fmySjRfs7zTGhrGDQ2RbAIyWxJ0vpvYAFRGoScc/kyupsFIcrZN5lTl0aWWniTns3kzVlpnMCptQXuGiPZdetyq+yc9uCsFdtpAaDI=
Received: from BN9PR03CA0969.namprd03.prod.outlook.com (2603:10b6:408:109::14)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Sat, 18 Mar
 2023 07:56:34 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::c9) by BN9PR03CA0969.outlook.office365.com
 (2603:10b6:408:109::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Sat, 18 Mar 2023 07:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Sat, 18 Mar 2023 07:56:34 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:56:30 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/19] DC Patches Mar 20th, 2023
Date: Sat, 18 Mar 2023 03:55:56 -0400
Message-ID: <20230318075615.2630-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f8f533-154a-4fe2-4f9e-08db27864b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA65nbrupA/d70UIu7W39f88kscfL/tuWIBGbKo7oWrJZX6b3ufjkv5EyaOPlG/sxondrsZX1ytnkJjfmOLiSK53lM75mvXPFOAtxg2wTFSH4lQ97nArhyPe1+D8CAExCeNHSTmvlddh3dkw+WDuwVIrS9rhJPB58ttwvuHtipr9G1HRxuNukqJ/WKRDMgbkXqRdy8bx6oh1APApdXakuBcf50q9Pxt8Ei7Dsdes+2+63HeXAD6gksN3RtnSaUftrCV0kCx48G3Q/tiN2QJlNGMM6MI3vQ8WMyfSZ9uUm0l2S5KuE0Pi2eKfDiS5lWE55WliKsKIbEoQz32GZJw1dL7wLm62OYyWm6wYWEDnNsBbMS9SjYKmk5k2AAygjUUwQr08TL2wdHY2Zw7lf7Ves+xqr/Mf6JkrPTaQZzTC7k9yoB86HsSLftB5lZyqVbFIchvQpZN1VvWE6+OuClpQwYSWyvfJHXEZCTvh4ucU1/1j714MBLyaubSIzE7e9CIxUHqIpZHXBigxG4M4PmtheTZwFYS9v9Z0BtoEyJPFK8T8Rj2lBLg+xEX2iw1lqprsH0EhPCx6YnweOgksNy5cBrHmWcCnLFPa/p3CBENm6W9JOL1BrD5PmXeuFne5PpQdLWsMZITetRC9NmFCNAd3QORGuPIYcZclihaR93GCtqDBasiscF4CQZlyI8f+kv0B2Bpx9MiQeZMidHRJ2Hkg5+4gv0wFj7lrMPtgEFCFe7Ly0XTIDt2ovUHrey20d4QcmAalbsvbKPLB4F42O7W5ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(44832011)(8936002)(5660300002)(4326008)(6916009)(36860700001)(41300700001)(82310400005)(40480700001)(86362001)(36756003)(356005)(81166007)(40460700003)(2906002)(82740400003)(47076005)(426003)(336012)(83380400001)(478600001)(16526019)(2616005)(186003)(1076003)(26005)(316002)(6666004)(54906003)(70586007)(70206006)(8676002)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:56:34.5833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f8f533-154a-4fe2-4f9e-08db27864b59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- Power down eDP if eDP not present
- Set MPC_SPLIT_DYNAMIC for DCN10 and DCN301
- Initialize link_srv in virtual env
- Code cleanup and alignment

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
---

Alex Deucher (2):
  Revert "drm/amdgpu/display: change pipe policy for DCN 2.0"
  drm/amdgpu/smu11: enable TEMP_DEPENDENT_VMIN for navi1x

Alex Hung (1):
  drm/amd/display: remove outdated 8bpc comments

Aric Cyr (1):
  drm/amd/display: 3.2.228

Charlene Liu (3):
  drm/amd/display: update dio for two pixel per container case
  drm/amd/display: Add CRC and DMUB test support
  drm/amd/display: add missing code change init pix_per_cycle

Hersen Wu (3):
  drm/amd/display: align commit_planes_for_stream to latest dc code
  drm/amd/display: fix wrong index used in dccg32_set_dpstreamclk
  drm/amd/display: Set dcn32 caps.seamless_odm

Martin Leung (1):
  drm/amd/display: initialize link_srv in virtual env

Mustapha Ghaddar (1):
  drm/amd/display: Add function pointer for validate bw usb4

Paul Hsieh (1):
  drm/amd/display: power down eDP if eDP not present

Rodrigo Siqueira (3):
  drm/amd/display: Add const to a function
  drm/amd/display: Set MPC_SPLIT_DYNAMIC for DCN10
  drm/amd/display: Set MPC_SPLIT_DYNAMIC for DCN301

Saaem Rizvi (1):
  drm/amd/display: Implement workaround for writing to
    OTG_PIXEL_RATE_DIV register

Wesley Chalmers (1):
  drm/amd/display: Make DCN32 3dlut function available to future DCNs

Zhikai Zhai (1):
  drm/amd/display: skip wait vblank

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 27 +++--------------
 .../drm/amd/display/dc/core/dc_link_exports.c |  8 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 18 ++++++++++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h | 29 +++++++++++++++++++
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  4 +--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  3 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +--
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 25 ++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h |  3 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  6 ++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  4 +--
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  3 ++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  3 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  3 ++
 .../drm/amd/display/dc/link/link_detection.c  |  5 ++++
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../drm/amd/display/dc/link/link_validation.c | 18 ++++++++++++
 .../drm/amd/display/dc/link/link_validation.h |  4 +++
 .../dc/link/protocols/link_dp_dpia_bw.c       |  9 ++----
 .../dc/link/protocols/link_dp_dpia_bw.h       |  7 ++++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 ++
 .../gpu/drm/amd/display/include/dal_asic_id.h |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  3 +-
 27 files changed, 144 insertions(+), 52 deletions(-)

-- 
2.34.1

