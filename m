Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B58C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B5820748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XpgL5aEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B5820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258C56E18E;
	Fri, 10 Jul 2020 20:34:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431016E18E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXMJWkGv+9BRZmpTJonWSUQGfq4TNRSscJx4sWHRvawSPZ+W8YP96VHuyu+D+dPDexLwNhSvfOkSP6IDpE/CLTVrIKo5VLbTLEA641xZhYThNZ4KFNdqCTatxU2Ux1NpsVhlHxhsCADAo9ej8Hmdnmcoyw1cksPAxiVB0aBNUF7kKE0Yfkt+b1I2epWGrLe3x2211/Cem1GIdkzmrxZmCIBnLUOcxp01fIo5uPSI9wxqSU5IOB3Ijs9F5OFJ8aGRGzofmVkQFXgEja/R/IfJwvJn476GMQCCAij+u1ocRZ88O767vAy4VNA+88QTEUPD6dF5x3zAaTOw8PD8IIIV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y+3wOvytf5ojtpAfYtBXvsumTDvFGINKFVnOMkq+Qo=;
 b=YQ2hfTWB7yUn+YSW16AeABm1kCiOmaYXgQ891D6FTQN0mJWNgX/uWNFXLiDcTlX1hPTSlBumUf3KmjkCBLGW/SX+qc11IWHxohNZ7DjKz/UQHHinkgH8Fnos52MNzBZ717qr6azZSfplFZSRpPnvmfbvh0iNWJ7ntg9YXUj9qwJq4UpU3U+igqV8SIThtjGV20nWja7IWnkYc4716hTEbiPS2sSxeRGcRqG6z2Q11LFmOrfX3O5C1twRXKdp31IW650E5ZtjpFr+ZQNZ9gwg5RSIErrp6yudctrnGv5bq7UOtvfOENUBG/pxOdlf8hhEetRre5HlzrVyH4+nreNMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y+3wOvytf5ojtpAfYtBXvsumTDvFGINKFVnOMkq+Qo=;
 b=XpgL5aEMAqNll2gARtyvnF7zndw2mLviil22Fl5dUA2S6ivd5u/iyRAgyWxHbF0HVjNSUeJ+5125+U7rXqxiXOJSfVqGWSD/zMRz28RmAbanJevfBEfougkzRg1jp0jxoP8g50bGPQANCEnKlfUF47NtPCVO0E7EvAdYVgz6fV0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:33:59 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:33:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/10] DC Patches July 10, 2020
Date: Fri, 10 Jul 2020 16:33:15 -0400
Message-Id: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:33:58 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb8e54dc-f536-431d-cc8b-08d825109329
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42311D04ABEACC5A617A22BD98650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXyUJD4xCli6Izpa+xlT3g2A26bX9xtlP8H/G7xtG3zo4lWSYN0x1eyB2vsQ8lPEitSgUY8sY28PSWcxsLN8lG1KxUMv6zVDtrfjcSSC1dACcKzJYtNLReJ6XjuCNftULaCq/akg6VLqiH+tmk4ah5wYRfIzzvf5iC12J2HGVG8iBpgJuRlAJLw4/8od5/gMYfCAXAQvZ5Lror9vnSw7cYhS7m55OP/5GKDsegLN6GgkToQr059qL1uDUEabVTZhxmfLV1TD3/K80pg0tPYLxik8VfyeOjjkcRnfzG5yYKn+//rwZzAbNNEmIeV9j5bU7eDsx1L62CKdVI5mQRiMAjvVa+xjCfczXe+L8t/JE1dhN4HeO1VgI8LMvojSrgNZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LgerSSVXek0gr3Tq+xh08D01J7sIPhCUSzrD548uTuBDFDeD3knRPQZjQ3w6nqrXVjbMXEtagX8qRQxZRP4BoUQ0oLV8ZYNuNs+8HBisSRGJALSdVAZZ8uAXWZztZIPBo3H0c509uS1b177GDC7j4nbT0Mb2re/Ne21ntH2ntsqObGVyKO+3a3AtoxPOhnCjKbTKfQzeo1hS/RXfeY6xadz/DCCUr5XejXH+UtRfpJFn6P47bDETiFw3W1XlmrSpW/Om4sZt81u1c6VN0AxF6TNrHC0dXEe8QnHV90sjMsRqEKWmsdUCfjCeLcvdTDwKCLsZcD4wWfgw/S1RZtqB24174eNPhI0xjHln7lt03VzXC9/WurjcIXR9iAU7TM+hUCC8TYvXwqG8pgVpUOIjgmCdCDj9Jxb81nd1rLd6RNhfRID6SEwNu1IBumi86YpPFl2D50jhoKou3Xb5H8b3lijJs8SIoO6UC4N3YUiO59Wry9YmS8l+6Bjs16Smuhwn40JwO21VFRx63kzWXOgNeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8e54dc-f536-431d-cc8b-08d825109329
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:33:59.3133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Me8p40DYIdsASI06EE1ZywJdH+Zqn6WtFJa2DjZS9LBM+6JMtJvEFbfB7QvwNEoLFl+PB6fXKY/kc9ZEN0KGqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
* Updates on DML code;
* Bug fixes;
* FW and DC version update.

Best Regards
Rodrigo Siqueira

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.24

Aric Cyr (1):
  drm/amd/display: 3.2.94

Chiawen Huang (1):
  drm/amd/display: reduce sr_xxx_time by 3 us when ppt disable

Dmytro Laktyushkin (2):
  drm/amd/display: update dml var
  drm/amd/display: fix dcn3 p_state_change_support validation

Josip Pavic (1):
  drm/amd/display: handle failed allocation during stream construction

Mikita Lipski (1):
  drm/amd/display: Reuse parsing code of debugfs write buffer

Sung Lee (1):
  drm/amd/display: Power down hardware if set mode is not called before
    timeout

hersen wu (2):
  drm/amd/display: OLED panel backlight adjust not work with external
    display connected
  drm/amd/display: p-state warning occurs while changing resolution from
    120hz to 60hz

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 259 +++++++++---------
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  43 ++-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  13 +-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h   |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  19 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 105 ++++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  46 +++-
 .../dc/dml/dcn30/display_mode_vba_30.c        |   8 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   2 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 19 files changed, 335 insertions(+), 187 deletions(-)

-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
