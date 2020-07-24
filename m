Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB532C433E5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC23206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HUuKX/Vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC23206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7626EA0A;
	Fri, 24 Jul 2020 21:07:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CA16EA0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBlVAjCVfyj0j5m/FOJ7ygBeLEsyvuIvcv+j/R8K39lEJOZCpnlDdu1qcPhj3xrN2fEB1JhcjyZu6dbult2TDPP9e/hb2HFPOqX8KjdlpBQDtKxD6DvN9e8dX/pXlgcpk44bW8mVC2DCsMhm+IgRokzQFufN0iySc/sgGb6CqOBfxjSh9ZvCKeqO+MEI5EGjrIlWGNozhFfHagDkq28eZP36fW+dfxZk1DObwM2WoEb+6IUkbeh9DX9lu04ILV6cRoVEEjoqgKWgTn4jOIuwaTllXkx1/PA1e90eJ99+xcgN1qugjMkNyT85NEa7Q608/rAIzx4P/K6uJCxwO2g4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8membIbfB0mjDRiJLGX/uRMDO/L0Qlow23b+TsKd+9s=;
 b=Kr6o4IbtN5xHM20UrPkibKVc/VDocQd7nUmBplGax3nSlDAZtLa3zUvN2VfXYfl4EuSM0AlSiS6ptaMllwztZ48qbIOWKUKIOb5DZL1vEDYGn/BMbtPIUMHm1mr0EXCYgcnvnc49kwbdNFi9ePCdNpsXtLSgut46w+lshb9beNbr10smM/gPwEbf52q+cx+b12yYuxrpiNzKTRP1VMHRAvfwu3j7C6PQk57QG2Fk83nqzNqPbuhbHOUxUNpFU1tJG7HYD5TrblFKz12jVC7FSq6RC9z7hXBVA7SngGqBx0BeQiGjBufbDnbazDusdCgTwPB3jvq0kvJmySq2glWe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8membIbfB0mjDRiJLGX/uRMDO/L0Qlow23b+TsKd+9s=;
 b=HUuKX/VvWNHWYphkgHeHr6eojG4wJ7Q56rUtZhNS/9WbPsQ3pX8WeCDJka3o9dnJ+7Q7vXz/TVu/QNB+E5/ub0D4ltjq/ZQldEMwGCJ/R0mFhYg10F3mZF58UqLs1+y46nGnVDJxkpdhrROHxnvkk6kOeNAMtiY8hAuFU4OBwa4=
Received: from MWHPR22CA0021.namprd22.prod.outlook.com (2603:10b6:300:ef::31)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 21:07:10 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::7d) by MWHPR22CA0021.outlook.office365.com
 (2603:10b6:300:ef::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Fri, 24 Jul 2020 21:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:07:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:09 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:09 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:07:03 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/15] drm/amd/display: Don't compare dppclk before updating
 DTO
Date: Fri, 24 Jul 2020 17:06:07 -0400
Message-ID: <20200724210618.2709738-5-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bec4ae35-f073-4e48-9b11-08d8301587fc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB436673D341F8DA1A443553A3E5770@SA0PR12MB4366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWjdSXmLOj2g67e/fM2XXHN+M6q8tFq7vI5PZ/74mOh3GPBzJ3T6WjMb/9Zw4sZu5YDaKYIaN3W9BM2Avv1RVY4BALhFc+P7tox4wqvvQJG7UEhsqDW5nK8P5lNtLpAAUUJnU0MmHw8Mw21Pu8ao/KUB+lbFW7FE8mKdOVPiZ+gILgiBnE2n7585S7nYRgSvUPcdswTbQ6loaTeADGoxUd9kanriRDJujfFzfo+wXP1jVppqpVKKdv0TOnyrOOp2OGJpOPZfgrJKznvq9fDr6nG6d7BpAHRbMmSs/0i3g54Ee0SLrV43HPNlSe1uvTIx8+a56v5bk2BS3fH8YI5xgpC6ARFbL/VZ/0QlwH7snTMNRrQPmMzjzak7i4rjzM6NH2KQTVQpUvur3HTxc4/tfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966005)(83380400001)(47076004)(316002)(86362001)(82740400003)(8676002)(82310400002)(2616005)(5660300002)(36756003)(44832011)(478600001)(4326008)(356005)(186003)(70586007)(70206006)(54906003)(8936002)(336012)(81166007)(26005)(1076003)(6916009)(426003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:07:10.5251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec4ae35-f073-4e48-9b11-08d8301587fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
In dcn3_update_clocks there are situations where dppclk is not
lowered (i.e. stays the same), but DTO still needs to be increased
before we program pipe frontend (i.e. in prepare_bandwidth). If we
don't program the new DTO value before we program the pipe,
we will underflow as soon as the pipe lock is released until the
next call to dcn3_update_clocks where the DTO is updated.

[How]
Remove dppclk check before programming new DTO value.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index d8af56a58196..b0e9b0509568 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -323,9 +323,10 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk || update_dispclk)
 				dcn20_update_clocks_update_dentist(clk_mgr);
-			/* always update dtos unless clock is lowered and not safe to lower */
-			if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-				dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+			/* There is a check inside dcn20_update_clocks_update_dpp_dto which ensures
+			 * that we do not lower dto when it is not safe to lower. We do not need to
+			 * compare the current and new dppclk before calling this function.*/
+			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
