Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D30C2BA80
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5584206F8
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eXzd7lwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5584206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEDE6E2C7;
	Sun,  5 Apr 2020 20:42:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B0389EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEfpbvEC/XiIWMsS7F6AMa1BKDBZw56NeVYkxOVxV7EUpCk3AQb2NMTigmgEvt3LSur5zY6nQDDT4zFpM22TxbJQnHszEVgyKWufmQIKTMZU8tUq5rlltdZe3r83c9uQWBVV0FnLL/HyZ0mLkvDTufBYhSlAKSRfP1S8CdQxY8kv2+4u15wD9GYo5rvhtxBbp0p744Q7VMuEQfpDFGWmKqwYKOC9AMkzSc+OsgejqnqKGCe0TkhQ/Ad/qlglxhXFwuQn9WqlcC2pUt0l1oDJZivzf5isBlaxIYjB2f2afOzsv0l1+VESNhTS7yJjMJgB6Gz5yjj0MTYIN4aeKEPi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu+JM8hgDQjwU8Hutvw4O+uo9ZU3sVOgGAPd7XC68yY=;
 b=MXRkKvJOMNYWE8/IYAiKMrMXVcukxOr8sbP1fBivhPy1d96HgZRS+hb3dHWbxQ2MCa0kuI3jThv5A8K3ftcYC+oWWxqTKDgQP37B6IidZrvf9kYpZ63o5XSebhUupfINU0lKYRoVD2R0rfgnLrU2lUJCZiOUwp51SabEXoI1JZZXbONXESGMftdtTPs83CS0uBPo5C2Qic1UZFa5vAbDhSCPpatsKqsubdJ60KXy3smWh42Y4XiMoCftbAQmCVhpAp1yqUesvJnn4vKkxAqTxXLWtaPdOocUPseSjPfePQ0l94Caeohk2eauagA3+AcZyBtA/ZmxDewXLTSK3pwPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu+JM8hgDQjwU8Hutvw4O+uo9ZU3sVOgGAPd7XC68yY=;
 b=eXzd7lwXHiOt2jRVJe88X54xmhlEbq9SB0VlxpTy2WGciq7rH59Jyt3mzFxVx24owLlLXgKWceG04aE5NmUY1NEZqSTieDxfeyRbJntMLIQaqubBLWHgw/tcOBQGQD09zilJUDnPnfxZiLlmPUFa3QprI4dmZzbdGk5t8Z1+W3I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:39 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/36] drm/amd/display: Check for null fclk voltage when
 parsing clock table
Date: Sun,  5 Apr 2020 16:41:12 -0400
Message-Id: <20200405204115.683559-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:10 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8133f4b-2a02-401e-0c88-08d7d9a1d0c8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255591926C62D09A949A92CF98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEbBIdAe3PZ+jOefaaugej+ATQDooKwvxW7Xm3sQl7gisfqxnPtXiZto0PVVwmBzUqTcTLYPvoqfsf2CGGJbglFWsif413j44//fDeTEeiWuIVPgULBhQD+1ogRdi4q8pWhSKyZT0RwrF5ePdxoWgFCIWPHr4NTsBHRJI614cfr8DN6TYB8khk30+9ZeAGRhxvxussTQqheBSZHZSNiTHb4Bt5vGo692r82NdmW+PmwB909EkRUg/bKuXIit+jl59tL15DagY73M1iI+DDh/yaGtYxgJu1r1dUps+C+II660K2OltKTnQDShXyT8UDOy0fG21NoSXt3jZQ9y59pzQpvzqdEHj15Np2fUDgRSnVUMLqYpOFrNiOxpGrp1ZexhzVJ6Cqbj9vp4klIYP73cgg3acYsF6AYTVXmIo2axDvbhlpURwnbWudyU4wkk8ncI
X-MS-Exchange-AntiSpam-MessageData: aKd0WreTd/4Y8rKyTvO2VnrA+1GwvZAkSL7uMeijjFZje/D6Xq3BO9iXxXg5kOdcPCrkZKJhmrtluf2L9Z5G6t9vHzfJGfoKPPtqzl5KIm4DL32nL4YeXoWUF9olSbLQnzevpG4gmp+X96vS9zpN5gqxVr01kMZbVu6sPA+CEHc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8133f4b-2a02-401e-0c88-08d7d9a1d0c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:11.4776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bbGcdW17fQlIDoiQZQ16Pt8TKI5WbLnpcMhgHCCXOH4mO2Hmy/VSXV41v51kLiTFwVlvYLXbnMUmJCSiFh1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Eric Yang <eric.yang2@amd.com>, Michael Strauss <michael.strauss@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
In cases where a clock table is malformed such that fclk entries have
frequencies but not voltages listed, we don't catch the error and set
clocks to 0 instead of using hardcoded values as we should.

[HOW]
Add check for clock tables fclk entry's voltage as well

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index ab267ddd4abe..24c5765890fa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -643,7 +643,7 @@ static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params
 	/* Find lowest DPM, FCLK is filled in reverse order*/
 
 	for (i = PP_SMU_NUM_FCLK_DPM_LEVELS - 1; i >= 0; i--) {
-		if (clock_table->FClocks[i].Freq != 0) {
+		if (clock_table->FClocks[i].Freq != 0 && clock_table->FClocks[i].Vol != 0) {
 			j = i;
 			break;
 		}
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
