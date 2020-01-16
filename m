Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9031C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC9F20663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q1hhQabD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC9F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724BA6E478;
	Thu, 16 Jan 2020 20:14:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66786E478
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve6x4f+vlZltCl7Kc1Jjt41etMnrXtFl5IQu68tUgTArUvpvof9rIcoIT6xS2RJ5tVBrVZmCGprO/kJQC2cGySAQqRL/BgMIUr7a/0eSyE+tvyPcinHLjIZTVlKBNY9PTA5v9p08HbWc9zy3C4zKitFMZ3mt8ZRRg3BPQz4fdplWA/7Rvf+/0Mojs5mleWkmUXWU+T1FZ13VD5gKEwzmBpQ75B0VHxkH4qvw8ipK9KbtghaFt6lBcOjsD3QPo/LOh8u6iLzBbbUr6JX7zVpD1d9cfnAyj/jqOCcGDtk+4NtBfzKeBtQh/Z8Vu0hh5IsQLACuK/2tTbJHHSxcGD/k5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta+6+0lt3UTSEiRE/plDvVO/+WSCh9xBTAIdJLPDGvA=;
 b=lXAEpbB2hKrsXlX1omjGCEXIkrKE+XuO4CVGWNikbJ/MWeeHzNLNYg60TN6Nbe0FBjyYEYm6ZIMj16hnGldao1mSCpbM6hClY7umIWQkA2n0E/IpXRRN/bg8VIDSJanlyIHneSd9qk+VQhkvAbey5XS7KQ4Bn1LPmxee1TPQRQSFcQuruUBL8jZhmOtBQygI6p90nHtNWZD1Nad5YSP/2htOXBd3Yp1IjZlGQIk0SrxrkWRTmrxGas/EWcKIAaJYh8VjGNKet2ubih99TK4kbU3h1shNVXnBUPQKqUNujJmg4oA7SP3fzrcDn3I4zo7rsSi0SgLt+D30BPuaHF0MSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta+6+0lt3UTSEiRE/plDvVO/+WSCh9xBTAIdJLPDGvA=;
 b=Q1hhQabDPrJybWE5GmaBE+hGNTKYAUdB9a89ugMkKDsSjiFeGxBTqzo/9ufQprdZ/H9pUA63jfpP5uEHuNGe+3CLddYZ1+NIvsWc1uQax/xDET02g4DQVv5B9bQiqMUqE1nZVe6412LuvIaK7bV+ZfQ8CX9CTwiyyBfClY2au58=
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 MWHPR12MB1167.namprd12.prod.outlook.com (2603:10b6:300:8::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 20:14:37 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:31 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:30 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:30 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/22] drm/amd/display: Reset inbox rptr/wptr when resetting
 DMCUB
Date: Thu, 16 Jan 2020 15:14:13 -0500
Message-ID: <20200116201418.2254-18-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(428003)(189003)(199004)(81166006)(6666004)(356004)(8936002)(81156014)(1076003)(478600001)(8676002)(26005)(86362001)(186003)(7696005)(36756003)(2616005)(426003)(54906003)(316002)(70206006)(336012)(6916009)(70586007)(4326008)(2906002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1167; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487792df-61ff-4515-2583-08d79ac0b5b7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1167:
X-Microsoft-Antispam-PRVS: <MWHPR12MB116750CFA06235AE53C843E5F9360@MWHPR12MB1167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOzi7WGIueLAMLTso5zeVH/3J7Kh9j+wnZqelZhKR0zUZHtlw0pRAi4IucFtSSUorUmnDNng/FteNTgzCoteN4drpZkJ6e5EG6dJugK1iP8E6vQpJ8IO+hB9CnRFtOJv7grLYDTWbk7HxWV2K9s03Vf1PWDhrSENNOC6L/6+lOu2b2H43C9RSgENcFyJANemv8a8VPqWdw/0cHA8XU5J8PnaBElsDv7OVfGblwgM/N4wW8uWXe2mf5cwe582/+NY9knuPN+nUReEa3WyOwdAyaTIRN1CKri4luVHSVeLbgTJGSmPifL2qkuF3cskuum1xSkpWnrYVMlDeB6nyYNqJrrDfJPuaCvCDK6IT5BfOku6xNJncenwXawvzm72Ox7xigNEIs0wDPP5gpVxRx0fGdgsh4EsQRymeUsdBuAG5ttCGE1pBsFVKSNU6fHcGG3L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:36.8250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487792df-61ff-4515-2583-08d79ac0b5b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1167
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
These logically make sense more to be set after the DMCUB has been
reset rather than when we setup the inbox.

[How]
Move them into the reset callback.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 9229012b93e2..b2ca8e0dbac9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -80,6 +80,8 @@ void dmub_dcn20_reset(struct dmub_srv *dmub)
 	REG_UPDATE(DMCUB_CNTL, DMCUB_SOFT_RESET, 1);
 	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
+	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 }
 
 void dmub_dcn20_reset_release(struct dmub_srv *dmub)
@@ -190,8 +192,6 @@ void dmub_dcn20_setup_mailbox(struct dmub_srv *dmub,
 
 	REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, 0x80000000);
 	REG_WRITE(DMCUB_INBOX1_SIZE, inbox1->top - inbox1->base);
-	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
-	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 }
 
 uint32_t dmub_dcn20_get_inbox1_rptr(struct dmub_srv *dmub)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
