Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22151C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC19A10E3D6;
	Fri, 22 Apr 2022 16:45:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA0010E3D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndfz0FKGu2UtR54eYwi1vi2oUG8qKVSNtP42mAtnKilrY5QDdG+pHpA7yKRVYo0u6zMdTkvUL4zpdzdTDVBkRPMRa4QPowmc1fcXH8sKwRdTY6ht6kjC7HZNfgxWDuTODkD6/tZBVrn+g/rnmS0O36sa1HZEqNbWnmutFK1IdUi+cI3Jq7KItYP2DYrykTDs5SEnL08q5mvvcu3H071epBneRVl8dce4epUkZFgDChFhbGUzFkRqCYVRJEVr86Z9ig2AyLqUK6YkYomry5Dw9tmrPRYuzmkPFEl8N6emaoVQuOQH26pe1IGWdIRvNam0wrixmUJIvuYZEn5aQYV3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reX3U5mTFJKtN5Xd8YfShPgiPytZWNFulzRAcZqypjc=;
 b=UISTJCDO8SAvB/63GWBwrBkpJWCzzylhx23jYP06NLCBiRz0BCswn6yxXSKhvppTErXlJrpD45+4PvHiI2LcPPbQcz2NNUoqXy2MxL7PmMhhM6eqDkWJFfKEL14SB1tmd/utgNe722wdZNdkjucdOyTU+l/5guoEQRX3rQRGKQhMdtxIdUvoNOVNyt/0o8hgcwBqOazMKfuItkJiqQjgrZ20lWSmq4fOCBlfYoSEAPU/ufOLeUn40q34x/CMq+7xX0/bfjiSYncH5DeOhgslZhhUM7PodZw97xHXl1gehK4qUfDVXhq/gA0VgTM5q9YDuAqV4dRjaUaTjzpDI7PXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reX3U5mTFJKtN5Xd8YfShPgiPytZWNFulzRAcZqypjc=;
 b=jJ9Gfyc4JVGwcWUYTK/zy9+z67ftS1Tz7PKsGwSby99SCduK13EIv9pQIBb6W+yWUn7Y2UDBDNDKoRzVCTcb5fv/AQEu0UGZtWG1L6S6iRpRiEFja9edjfz/TmnTrAaWUBYjtudu2BR+Wsg8fhlFUnLjpC2UcgVmLLzbD79sO7c=
Received: from MW4PR04CA0224.namprd04.prod.outlook.com (2603:10b6:303:87::19)
 by DM6PR12MB3564.namprd12.prod.outlook.com (2603:10b6:5:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 16:45:43 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ab) by MW4PR04CA0224.outlook.office365.com
 (2603:10b6:303:87::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 16:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:45:43 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:45:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 09:45:42 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:45:38 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] DC Patches April 20 2022
Date: Sat, 23 Apr 2022 00:44:44 +0800
Message-ID: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df14795-b7e5-46b7-07d1-08da247f8ade
X-MS-TrafficTypeDiagnostic: DM6PR12MB3564:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB356442B8A2917365644B5DBEE6F79@DM6PR12MB3564.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dk20g3MxWSi8ZZHQw2840XXXtoc6Sh1advir7fyu0GOcdw7BiyJ2wDCJgLyxDx6XO4Wxppzj4zAK4g4YcYg32GGU5oz2uiEz/BOZsCMkR2AA/LK5O98mFy+m1ObKH5Rv+ql2iyz2pFaYSTle/d91McV1CYu/6otTiSl3RB2E4tfmKdUAIfgZmrd3s4ZFir2+N//+IPdcPOnMJX0JrivwuRQOfH5J9s8Woy2KAQJlva1Z/bvHIIUhmV6ycQ114k/rHXyneIHPZuCziX5H5HdKWsrDHSlTfvt3YRs+nirsKMucdm8+aCPEPelOLyOmA8O+tesMADe00ACX4/zES2tPwd5hxQ5Ys3ukVqWTjW6NuwhPzphTFz05s/lBbXEhCMyD/pv+f/0YGYD04b47fFF3Fl41n1GAGzrWcswznKz58O9rUJVR2/9Mzrd348dEIaNiCmKsjj/mS2tN2oIZZRnLcMzasUoMZhlCAfru/7xTXktsrP3vjUCuQL26cdZSOkxpVoaczqgdXXrxwGaIG3AHGPGIha9GP5U7Wjd4//77ybvuseyDuxQg+CUz69R+qlIXkH4mwEybQ2D60tyWxFR9Ra8/6630e45VCnjQbSDUYvN1m6IqbFEj3etxChqZio9IpZHoiQdbknNVARVOANXB9tKckq+3aMkDeE3p88OS1B6ljQcfhnn3dnw2+0GDCiD3SmQdcyOmGXLNPXxKGpVZdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(86362001)(83380400001)(26005)(316002)(356005)(47076005)(426003)(8936002)(5660300002)(81166007)(70206006)(4326008)(70586007)(8676002)(2906002)(6916009)(2616005)(336012)(6666004)(40460700003)(186003)(1076003)(36756003)(7696005)(508600001)(82310400005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:45:43.3724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df14795-b7e5-46b7-07d1-08da247f8ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This version brings along following fixes:

- Keep tracking of DSC packed PPS for future use
- Maintain current link settings in link loss interrupt
- Remove DDC write and read size check
- Read PSR-SU cap DPCD for specific panel
- Don't pass HostVM by default on DCN3.1
- Reset cached PSR parameters after hibernate
- Add audio readback registers
- Update dcn315 clk table read
- Fix HDCP QUERY Error for eDP and Tiled
- Insert smu busy status before sending another request

Aric Cyr (2):
  drm/amd/display: 3.2.182
  drm/amd/display: 3.2.183

David Zhang (1):
  drm/amd/display: read PSR-SU cap DPCD for specific panel

Dillon Varone (1):
  drm/amd/display: Remove unused integer

Dmytro Laktyushkin (1):
  drm/amd/display: update dcn315 clk table read

Evgenii Krasnikov (1):
  drm/amd/display: Reset cached PSR parameters after hibernate

Gary Li (1):
  drm/amd/display: Maintain current link settings in link loss interrupt

Ilya (2):
  drm/amd/display: Add Audio readback registers
  drm/amd/display: Keep track of DSC packed PPS

Leo (Hanghong) Ma (1):
  drm/amd/display: Remove ddc write and read size checking

Michael Strauss (1):
  drm/amd/display: Don't pass HostVM by default on DCN3.1

Mustapha Ghaddar (1):
  drm/amd/display: Fix HDCP QUERY Error for eDP and Tiled

Oliver Logush (1):
  drm/amd/display: Insert smu busy status before sending another request

 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   2 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 114 +++++++++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  15 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   6 -
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  15 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  10 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   1 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   8 +
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |   4 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   9 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 145 ++++--------------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 .../amd/display/include/ddc_service_types.h   |   2 +
 14 files changed, 172 insertions(+), 162 deletions(-)

-- 
2.25.1

