Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAEEC4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB16A22AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB16A22AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5016EC78;
	Fri,  4 Dec 2020 21:29:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346456EC78
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfmT524XgH/bLqrur4NSJSLhqY72vqEyU92ygytCE7suHmQeLgMrEK113izvqy5LedC9JJs0hv33Y0bni1QSDLzsPY8fNjTVUSJFlAyb7OucCurlUniYH328QTKNfkbLefSXg7VHbtzGrQkzWNKpd8AsE+Qzgyuf3cLGHX8IdInvESicUtMR1gm3z8mQe8pFr0c0XpySrWCN1F3hq1ISBgYiYm+YhM0FEnEZnnPZwQ+abSqwVc5ePePmD1cZEfytLwcAObVIs4E9bgbe4fmbOg7azEkZ6IWvWEi8KCFJOaNOf+Jo7rM6wnw18szX5jQJafqaa8lRdlJdgk/Ez83MaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ldt/5CNhRAYvuTvSDR8OJg+2J56PdPCHvDy4MXsdQU=;
 b=So1hT4558xqoYiCqbqbk13r7TeTrd9e2KokWrXClxBdqHPINJM4lJjatyUSo910z+5hzV9CPFbLmvCK2RbXClgVkkTdDf6IoLOySWFisU8GZ1e4glu4N5aamZdinz2SitQY4grD94ejTeI7jF0ZMv1wZw//Nx5ovHp5Yo/YK9LX/zcu2BQi0WTdNj3HImUKniSc7bEqRPT9Wvt7/Rx4/6wsI19rYA8MPW9eE4ce8KTP25X70CDXzElwl+8MZl2Iw15SJ1KT7z4VrtKQ7WTgrAlAwoGH470Tjx7ah+xJhmEGOXQvUvumQd4MqtUOHjaItRSMN7EUBqP5KWTXMQPqCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ldt/5CNhRAYvuTvSDR8OJg+2J56PdPCHvDy4MXsdQU=;
 b=eJsHEetBY+zmE5CciEDeDGVPUjylgghhPPMRPxoxA60Ha7u0FJSSUoMyFIZ3WiHLIQw5z5iX2HogrvRaZuVSZ6oi/GIEka2FPP7/Px2vHo1Wy7dEYlPNxwee5qSQ+A/E3klvKxYVsfbnTE8dMQ0ird6lSYvXMO04KWcbvg9FyKY=
Received: from BN6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:404:8e::32)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 21:29:52 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::3d) by BN6PR21CA0022.outlook.office365.com
 (2603:10b6:404:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2 via Frontend
 Transport; Fri, 4 Dec 2020 21:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:29:52 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:29:50 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:29:45 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/17] drm/amd/display: Set FixRate bit in VSIF V3
Date: Fri, 4 Dec 2020 16:28:35 -0500
Message-ID: <20201204212850.224596-3-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e751ec5-cc9f-4f01-f46a-08d8989bbc81
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32107F44A4467E11D4A803DEE5F10@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJP4oB6RRK/vp/aEBKOEYkkDif1QarM9EvhcZzLjAUULL5n3xK161Y0B4Ps0ETxgAt1zBlkYaP4TFRikilEX/X6wFag/REOV2gHV5rEh5bQCoqQtZuiRyBcXrpMUc5KApxf7KdjgvH31ZSAHRieoHIDIOt4R0JRCMcpeuLMiyDAcuCoGaDeAACiJe1N0H6AJwnPvH+QY+ApdcjKf1mRXeKsYv2rRBAiwjAxt6Y+7OPxVv/Igfzhb8UybbGFSjm8j1bpgt/yI5fqLJ8ycBlzEb+20xG0WlzBJ9uNn89MT5a6WeXDxQsmHZ9viovEvQzC3+OFU9JZjUhWsPgdJwZjlmUenIE+OATLACZGr97haWEuwMDD1ZgI8tHmjKzppoP1dzshthIIGyeG51El330Khyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966005)(6666004)(26005)(478600001)(82310400003)(4326008)(2616005)(336012)(8676002)(8936002)(36756003)(426003)(44832011)(186003)(316002)(54906003)(83380400001)(70206006)(70586007)(86362001)(81166007)(1076003)(5660300002)(6916009)(356005)(2906002)(47076004)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:29:52.2471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e751ec5-cc9f-4f01-f46a-08d8989bbc81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
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
Cc: "AMD\\ramini" <Reza.Amini@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "AMD\\ramini" <Reza.Amini@amd.com>

[Why]
Signal FreeSync display that we are in Fixed Rate mode, and
expand the FreeSync range to 1024.

[How]
Set the new bit in SB16:bit0, and augment the min and max
refresh rate with 2 extra bits.

Signed-off-by: AMD\ramini <Reza.Amini@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/modules/freesync/freesync.c  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 2decdd8a5e20..4762273b5bb9 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -610,6 +610,7 @@ static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 
 	min_programmed = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? fixed_refresh :
 			(vrr->state == VRR_STATE_ACTIVE_VARIABLE) ? min_refresh :
+			(vrr->state == VRR_STATE_INACTIVE) ? min_refresh :
 			max_refresh; // Non-fs case, program nominal range
 
 	max_programmed = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? fixed_refresh :
@@ -622,11 +623,14 @@ static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 	/* PB8 = FreeSync Maximum refresh rate (Hz) */
 	infopacket->sb[8] = max_programmed & 0xFF;
 
-	/* PB11 : MSB FreeSync Minimum refresh rate [Hz] - bits 15:8 */
-	infopacket->sb[11] = (min_programmed >> 8) & 0xFF;
+	/* PB11 : MSB FreeSync Minimum refresh rate [Hz] - bits 9:8 */
+	infopacket->sb[11] = (min_programmed >> 8) & 0x03;
 
-	/* PB12 : MSB FreeSync Maximum refresh rate [Hz] - bits 15:8 */
-	infopacket->sb[12] = (max_programmed >> 8) & 0xFF;
+	/* PB12 : MSB FreeSync Maximum refresh rate [Hz] - bits 9:8 */
+	infopacket->sb[12] = (max_programmed >> 8) & 0x03;
+
+	/* PB16 : Reserved bits 7:1, FixedRate bit 0 */
+	infopacket->sb[16] = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? 1 : 0;
 
 	//FreeSync HDR
 	infopacket->sb[9] = 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
