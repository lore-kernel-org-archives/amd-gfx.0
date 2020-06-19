Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1A3C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990F1208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="chfGH6xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990F1208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346FE6EA65;
	Fri, 19 Jun 2020 20:13:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C7A89D5B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVc78RrN0YxwSDteUur92cMPoWcOdbqX6f84sAp8DnAjc/aPm4Uy1Spj0lyzmq6Dv9wCytHF0FD3MICcoCFKeNrA1ouf8dGhq4L64eUsYc1v434UqOu4EFPugE5fm2zX++JSx4apHQKMCOkyCzT+ZQAFj9E2JQHXzUGfSDpi7MULioYTJyHAh3RJv5x1BAu0Jm/7E8q+S/HzAzoPjNgswMFpQJIjreWfDnKj0iScx1ZbPKPwk13UDbVhpj26KDwkqOOt5yqF5+L3drw23Rqw11JiBimgujuvKYvGrQlOvHfOO/bc80r/OkDvCv4WnsmocEvH8Km175vplTTBemmdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smKHDMkIAaQPydsH1lTJKazkfUPSd+7Xq78+1nwuCns=;
 b=bYc11M3bhGoZok3MlsgHVoMR8s18X+7mFoaOMz2iK+08L8QNiY64WmVZrZ2Brz/85GmtwVwZy6CePV6F7V8NigNgYJ6pabRpNkoXVdnHDGxN4bvdrIk/Wo1Jn1/uEKj03VzUgMqKzpWLcgQLzvuZQcabYKUBNfvqbDXGePvZQg7aYENV3Q0fl5cLt0zoX7nhTw57TKEla+Mv9lOqcWcUQtnrTFphKzSQZxy5UJRj1nSAPxy+C7rgBT6UE4wlgc71BRARtd3eRocttwdPaBCCMmGWKdxtrouktp8zlAt/EoaI/4Mp2SBWSrtkDlnH24mMkx2N9blpZIU3k0wHet+Haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smKHDMkIAaQPydsH1lTJKazkfUPSd+7Xq78+1nwuCns=;
 b=chfGH6xzLkRcKI0dcsShctCjysIzplYxRHjvV/3xPR9kX7m58+HyX33mL0svXmrT8YtqD47cNOBMKoBsgpEhcSSGBXkoCGYdAJkZ/22F9y+FxcaUUqIye0r9gzeFyncdf3fDLYyN85JPqkb/9h5E0lRAqsBZ3SYAT4M1L34DOVo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:03 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/30] drm/amd/display: Red screen observed on startup
Date: Fri, 19 Jun 2020 16:12:15 -0400
Message-Id: <20200619201222.2916504-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:03 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2c3d7f7-85e6-43e2-38e1-08d8148d2c15
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40870945DC44A963BB8C5BD798980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FtUSSE4nps+KO1ICNzhduTDAGX/4AzVjenz9b3bGQo+NqDoDQEf9nmNWSc919YgV/mMJK03FPka6F3uiwRqKHKBiqlsTidPf7ZA00Nc8ynRNllshNmPD5X3+SEk0wnUYVfjlFq+wucT4cOIdWaL9cqUYz+5pqrIHeeqCQeRoO0kUeCQ6JE3aDtzFL+rlFi5V+mvU0vDE12vdGHR+mKKVc24q9Qpo+cKRpJzXnyJT2y/VDMmIf/EVgtTyA4IvXMTtsAys3QosHTJSWTsVo974xCzBAqb+nRWWqeX9J5uIXKnqkLt6TkAGYatwOuwXza7RLUfXb9eCoRjDB2zBcPGxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O2qOpg8UDuUTN555ciBHFc0CxO8VJsTxvdbMYF0oH6rbeGXUnQ7njxwPoWzj1SI3TtwSZSWEmxBhJ8ToHpg4VkneuK79aC0La7VDFPN1z3QTADXi8gFzSZu4Gkhx6SXhnNFoXAq7Wk5QRkqrjOcSdB0fA9/wClxGByFelVawC86loetdpSgnOC5gvcIRf5juNst9i7NGFV7faEYHK2B1MjY+cKgyg0ccftvJ7X+Vre83YE1GCZotXPMxpPh9XjC/3qQjuEYHc1kYjoVlnVl3SEaB65FvAswDTTqlzL1AC/bvgi9+twqHnmqh1uZqJATy+sl3iHUnbv09OfVSF/4M4EJlUEaeeruFe9LZX1Fx8C3aIHr53EJIG/+LK4qkiafWilGBIUHz0rJEKWe99gM+3e3hQAxhAE2nllsAD2+ChiAE81UEDgPmuJaUutCaL6iH2IDXptfEsuZe7TbGW5hGB2xoBYVzo//Fg2LMHP5AgKHuzk1FegbwPwQw9e4AU02sf0PYIcWQUfsLR9TlzufoeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c3d7f7-85e6-43e2-38e1-08d8148d2c15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:03.7837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3d5PvpmLHFBIC+LWzn8VBFKFQYCIh3McPtXz71ZcKVh4Tu6YAVNU9Xxx9rlOmdLhe1nXuAA98+Yd+Fss2qlbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Peikang Zhang <peikang.zhang@amd.com>,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[Why]
We try to to change new_clocks->dppclk_khz to 100000 when
new_clocks->dppclk_khz is 0

[How]
Don't change new_clocks->dppclk_khz value when new_clocks->dppclk_khz is
0

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 24c5765890fa..39788a7bd003 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -153,8 +153,9 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
+	// Do not adjust dppclk if dppclk is 0 to avoid unexpected result
 	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-		if (new_clocks->dppclk_khz < 100000)
+		if (new_clocks->dppclk_khz < 100000 && new_clocks->dppclk_khz > 0)
 			new_clocks->dppclk_khz = 100000;
 	}
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
