Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA86C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2BE60F39
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC2BE60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB176E200;
	Tue, 17 Aug 2021 17:20:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7335C6E200
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 17:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdEUl0h2Km35az2wkEfBtXWvlzDxeAuQ7B1KcusQscg9LHsvUxgeW90nvYeL8HodR4P6FbSqNkuTd8jSgNKAAXjYErRQVCiUv4Z0ZvLRC8r9788whFtTJHD5KG1Mlx0+w3Ue68A2ZxmsG9LV8+CY8yTXKx9624+nMYLtZJks76LMDvCsHgUiA8FP2gImijWfBJ2ylNvRKWjXkNoQgrNuFqn6iYVA8zdANbFMpmHS6ImqNbr7QB2NvyFuPWopWsq5rCFWd+mtyP0zMJGMtSkFKNSjcF7Of9nNH4fLFMbxAqt6h4ferapwn1hkOgZ2XCkzd7UZm49orXKxzljjTpm/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4L6wvHFG6uy50Qapx82pMqD9U6fs2tC8DWpj7VP+i8=;
 b=H8Y14P01ofgF4E1wdcbAShmfy1eV4CzyyrbXZEJxVcOSwn0D2jLDhRiG9ePrLcI38Bq3lIsgaDz2KnDKZorPaTwwiwBmh1YHtm/9INHUHpzRIzw3SVpNtcQBnt+tXg+PBdEXaM2JXODrPYoYwDgS/IhWAkhBprGY0c/FpBgKSQX83cUrHdZ60rUowrTQ9G1IBxS7fPRbciWxup7oR6yN3SM4ryZC+W9SlZn02TZQOAhoPhaDtJYM9v09X/E7gtHcgR+FVTT7H+Ex9qYNFI8bjbfF/TqhpKodOH0tb6hEktSONIHEdUoMn95OyTkpyC+bprV7i1Kja4jTwdKmqMeKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4L6wvHFG6uy50Qapx82pMqD9U6fs2tC8DWpj7VP+i8=;
 b=A2VjxTS19xuH+ISbZGgdTuqorbCWlFs3CJ+Xe+WQK96qZSjnBnQQ1f7Sa0R8OKlg8lYFz+JnaxsQ4YWoBiXXeQjVRrVsj9MnkN0E/Uy805Um/02gJyGLzlnrcFoopvjUPZ8OAWuGfUqKG6wQ4YpbgLc33sIXtP2NIByfmNNRIm4=
Received: from MW4PR03CA0269.namprd03.prod.outlook.com (2603:10b6:303:b4::34)
 by CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 17:20:18 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::c3) by MW4PR03CA0269.outlook.office365.com
 (2603:10b6:303:b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 17 Aug 2021 17:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 17:20:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 12:20:15 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 12:20:14 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v2 0/6] Add DP 2.0 SST Support
Date: Tue, 17 Aug 2021 13:20:00 -0400
Message-ID: <20210817172006.777655-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 419555bb-61f5-4f82-a551-08d961a34944
X-MS-TrafficTypeDiagnostic: CY4PR12MB1287:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12870AD017677A7D0F5869CEE5FE9@CY4PR12MB1287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gq9xZUiIbVhI2+cNyTbBpI4d0xHxOOuq2rOboV5hACOj4EJRYs0uzgSzdNk6It4blYMHFuor/vn0TB2+whIHI6JmAJ2vqrdWYL4tARlMkjoGYIotu5UViq+NKHU3b/QYYIXQuJXhqKfbRUIsBuh0SvcF4dmMDXwjcH5tcAD9msOpawDTpL8Qy1UufAmoyaYAh+/AswAdG7ZDjn8C+Q3qpda0Ek5kCYZIRak9PZXteNvH72p06pdQg62wP3qhvvvyvBK1spp4vsytiqr24tb2wlFwOnooo2SaEowfTKxtDajZjeB6FM42WDlFMcbSMqp43l7LibZN9YaXn3/sZKK8IZHN8Jl6Ps0ikp3igJnER/xZSRm9ny8XdIzjeOuIGtlJ95ZpqUp+C7mV15QSbXl8BkOoNEuP67xYnwXnoYtLcIBUW+tFM6w0/XgIdr51TKVFUYFIJxiNvje1MZQSe3Md6He2TTzKFSCyJSEtLj6uxje7j6JV6yhgmOmLEoAhwdnkCOLl1bevYTfkiXrkzqE3kwWroVwl3+1EjAB2pFqJV72hJGaHxhHBOmsYeJ5yk0yF8MeoYmE63SwPqv/fVSO8LPpRxcs2mkKGrZUKXY7+/Sq4yNECDYgPDja7jhyGdKL/g8rs8mlSP3af/3IVP6zIxiIRKQ+qKgxVjiFU9ZT+boW5KJa56vDwszsIx0W+vwEr0mUjGvsqJy2nsW7buDuxRp/eB8CbJYjEqdbJgjyf13J6bEJgfSDaDTjC5k/24UD1Wua5UrokS4qBfjXadOK7Kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(1076003)(26005)(36756003)(186003)(82740400003)(36860700001)(86362001)(316002)(8936002)(8676002)(478600001)(47076005)(5660300002)(2616005)(70586007)(54906003)(6636002)(83380400001)(7696005)(2906002)(6666004)(356005)(70206006)(81166007)(336012)(426003)(110136005)(4326008)(34020700004)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 17:20:18.4605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 419555bb-61f5-4f82-a551-08d961a34944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1287
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch series adds SST UHBR10 support

Fangzhi Zuo (6):
  drm/amd/display: Add DP 2.0 Audio Package Generator
  drm/amd/display: Add DP 2.0 HPO Stream Encoder
  drm/amd/display: Add DP 2.0 HPO Link Encoder
  drm/amd/display: Add DP 2.0 DCCG
  drm/amd/display: Add DP 2.0 BIOS and DMUB Support
  drm/amd/display: Add DP 2.0 SST DC Support

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    6 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |    8 +
 .../drm/amd/display/dc/bios/command_table2.c  |    6 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   17 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  503 +++++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 1071 +++++++++++++++--
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  291 ++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  104 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   17 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  199 ++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |    3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   15 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   86 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   65 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |    9 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   26 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |    4 +
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |    4 +
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |    3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |  173 +++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.h  |  115 ++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  162 +++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   18 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |    4 +
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |  620 ++++++++++
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      |  222 ++++
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  749 ++++++++++++
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.h    |  241 ++++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  181 +++
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    6 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   22 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   21 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    2 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   89 ++
 .../amd/display/dc/inc/hw/stream_encoder.h    |   79 ++
 .../amd/display/dc/inc/hw/timing_generator.h  |    1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |    1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   12 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    2 +-
 .../amd/display/include/bios_parser_types.h   |    6 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   14 +-
 .../amd/display/include/grph_object_defs.h    |   10 +
 .../drm/amd/display/include/grph_object_id.h  |    6 +
 .../amd/display/include/link_service_types.h  |   31 +-
 .../drm/amd/display/include/logger_types.h    |    2 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |    4 +
 48 files changed, 5006 insertions(+), 227 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h

-- 
2.25.1

