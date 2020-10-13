Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711D0C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 06:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31DA20714
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 06:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EBR82tuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31DA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF196E466;
	Tue, 13 Oct 2020 06:46:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770C76E466
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 06:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB5Tm8kCb3pMmYYtZMOmJuhQFdr+TVTQcBoH6BJqrJv7K84PGxtjCoOkCDBd7P2jszuZowuSXaHmdpq2Z6q51U0x0ZiTNoTHBYK+Z6jhZappDtee1nfQa5Zs68CozWo9IHloEecZ5IDiNqJB7boxrNpxX68QzHjm+IMMO043xlI0HNqgJYUmKxboWHIIQL/E9Qna5085mEZQQTNN4NV2/5xcRisAlNy28gnr5d9wFENsq/M137COVWhoeJ8YI96jBYjtUlmFqiYuLG5FmRHeF5kjIEhvfcte5glSc3r2gMHF97jALLsT3nBnF/7Tzj0r2LrvkUaf7ctGZMdfvUMOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvLxJJK0zj+B/anYFtFB/ACHfHehGwcQl3u4xI/j/XE=;
 b=lvIkoRRTPfvi07kJkZJxWb9g9FytoDLqSHZp5TIbZq+Ysy5NHvIltvA86CID0sEG3Ev95TPqppvriu/JGsQ/fyAEnyTPTprh5tMTKAZDCxxgl5WxPPXlvNTDCHPbwhW5WMRTApJxD2DiVINgaDaMr4DmVAb4sNcd+b6Rm6eLRpsbk0olvOHFaHGuY988Y5mywyFn/cIuC+76y8JAxix5DpkODbgyUFSKnFpeel/NMXUGUo9wvw4y2s9am74QRDe5G4S5KTotYaXyPWICLGuVjl3a02A3C+25B+CoObHS3qkhKiyjsac7biUbuyeNzum0dU6z61Iww9K4Gh2AV+4CCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvLxJJK0zj+B/anYFtFB/ACHfHehGwcQl3u4xI/j/XE=;
 b=EBR82tuuHiBoouIxK6HdfkyJGMp2ehV+rEeA78f4K6XdAvQdArOeLtpPaUApMkFV8goS49Spw/Ucis5ddGq+FlklE5MAAUIX9qfJZ/EeqM7KZnsaxFOv0ejubHfTjU3qj1QxVH9zOkITsAkzUUPoFNYwBHOSx2mEtAtr4ptsKr8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Tue, 13 Oct 2020 06:46:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.029; Tue, 13 Oct 2020
 06:46:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: increase mclk switch threshold to 200 us
Date: Tue, 13 Oct 2020 14:45:43 +0800
Message-Id: <20201013064543.22320-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0158.apcprd02.prod.outlook.com
 (2603:1096:201:1f::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0158.apcprd02.prod.outlook.com (2603:1096:201:1f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Tue, 13 Oct 2020 06:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1bb2ded-769b-44d2-d467-08d86f43a7a4
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB46789CFA94E1019593757B17E4040@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teMBu+hIk3Z+C2vWZd13KZ1Vvfme253I0IqjiW+fbtGUsazZ4BlPUwZNIdzOm9ouOcjuRrnyzdug6KVYr4YX48YESKfMkxzIcZ8OX/hfeKIF2bpcZbiAFgkrE7Pi2rgfcm4wROgEaiQLXyMxE8BYH/3V/LNI03DdoKuvjWEexgYk2KTyrzAIJ/aYA1AJrFbrHrCfh0xWf9LjNU5QtmwOflh/9ToTsoXSQ34lRx4u872u8bbh9pBIfCDuNRV1gN58B23SIz8AR0sGueXvscDj8Birdm+YIAFil/QkLGA2273wzzJ1rxIbK01YC5i0y/xutzWdvNbH9/emsjFg9cfuEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(5660300002)(1076003)(4744005)(83380400001)(2616005)(316002)(6916009)(956004)(26005)(6486002)(186003)(66476007)(44832011)(8936002)(36756003)(478600001)(4326008)(8676002)(6666004)(66946007)(2906002)(66556008)(16526019)(52116002)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4HTWoiPt4iYdO3ukZqIfrV/WNHSMaTwh6GvxrOm33hAMf2UKLdDbWyXTxdky5FhYXtxJpZ+6Jj0E3N0g13qCxsDJoFjGWKO8DLoSXzo8grXSmob7foNfl4k2UIh44xTKl2XDCrcxV63cWg+hx5rvoB5EOwxFWF8mU8d+7SEaCaYma7qa/73CxRPA/I+eEZRWAHCvzMpgX6AiaN9WKJ2kLPliksqCxnnjotQHuDNjc5hGcPCfhfPT4GsklQewYq89qtDrJGQieZ+9WaMC7Rqj7TaZ2n1+nrqwqZHopioWwvoPyH0FmBTxJKqoMpUsJgdOcNYtPmNLnb9NCI/Gl+GQFbdRqK1BzN+lopY3A13Vi651Ni0blZqs7JWKk/KSvqe2i5JTRza6ld8ZQhVSnUwkW32qNIxLub7oGsmAuagiw0nmlVGfr3hFxUya27APn3Yf/KikaNe8ojnHXp0wB793csyeoXWP+CZIavgcIfjPLvJzxKAz3FtJuGZI5Olh9dailmwaiFeDRPaR/Zmf2Ljc0cfhSrHIBonwKr1ZlwuHYyhlQK5gLioh7kFI7HE0V5mpQ7t+jQMcoXgQbVNbcQ8ij4E6l9c4IW0T9K/gaWRpOm99zP5x6umlTs3Gmv80zI76qW+6oGeMXG0fDdfkF9zjHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bb2ded-769b-44d2-d467-08d86f43a7a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 06:46:04.3651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0imC/NHN6lueElAz0phodx/LN/hxVe0dqs1xNX/NbO/Zo+O1Wr4R/ro4lXNvvPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid underflow seen on Polaris10 with some 3440x1440
144Hz displays. As the threshold of 190 us cuts too close
to minVBlankTime of 192 us.

Change-Id: Ieca0dc900f0b5764dc661e397e41e8c277ff13de
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 3bf8be4d107b..1e8919b0acdb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2883,7 +2883,7 @@ static int smu7_vblank_too_short(struct pp_hwmgr *hwmgr,
 		if (hwmgr->is_kicker)
 			switch_limit_us = data->is_memory_gddr5 ? 450 : 150;
 		else
-			switch_limit_us = data->is_memory_gddr5 ? 190 : 150;
+			switch_limit_us = data->is_memory_gddr5 ? 200 : 150;
 		break;
 	case CHIP_VEGAM:
 		switch_limit_us = 30;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
