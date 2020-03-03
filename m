Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E473C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DBC20716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WbYqhQ1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DBC20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2286EA8B;
	Tue,  3 Mar 2020 23:27:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0F56EA89
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHnffeYrRahTAZKhoVwkZULvw/gOzmGKgxJ1NMcBelizRQsY50CVzOcmMmcWHR9UpsSv3ow+VDSOIHF7QRRCm6UcQhdOD+pJfHhPkZom/KMSM4rDgrqV9OIh1m9cEWuxx4cbK70bAOz3bzYmmNv42zKNuyBRV53CAfsDIrnurTPVREBTbnMpLGceyaznUPKjTQJU1d6us/vjLqDNdfRebDpBodXa8SAypXjfYitaMV8eqICmxM8/ayEtQsubxkwZsAbq7h6M/Ltp0Wym8sULsXo159JMq5oMzMn6Aea0Sfym3E7J3xGHhYrhUc4GhMJ3BXHbg5kmfTw6mXpPaORZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgUC6/958dx0oMc85ONDE0K/ebjRwJsK6xl1M9AMMI0=;
 b=nsPZg6VWV+v0fQc8vADCXYM/TDAgVymz8OXsdAbrfRGN8FO1pEfzCbml9y++qHb8niAhfarP8TPg1/PbN1zsqGVel3yoDA39fHRoy0mSh+gGcFM9z9ayfOIav3KlY7Gm4Qz1BjEta66yHUFKkLCb3ipcvZEzPM/sNrnNeLQ8Cy26Irbyl1kqOv1GPeWzHoU5bKc2ud1hiox9UJN7/iW0sJcMZkhuJ+ZC2WtpiFfvukeNVXBbVx83nQr/VoRfpvHgw+a81AfWSZcHqxusgYmS+hYaVk1pN7r3B9UCmfSNNe1eqYEGVUBnf0QvZtUDIqSpsPIPs31L8Orl8m2BHVKruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgUC6/958dx0oMc85ONDE0K/ebjRwJsK6xl1M9AMMI0=;
 b=WbYqhQ1RvNNHCIfVKwDYlB/xa0p6IXG+01tUYNCl9f/nlQUOvnvACQfvniZQH87Rg0o6jDexRQwcl2OX/c4k37jN8csGbmU9eKMiNmSr/BpwqXrOGuuRi78XoZq7ZFwdoYbOkwoG/EkQRgoldSzCZv5OlhgA/zzAsfI+OvNmirU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2362.namprd12.prod.outlook.com (2603:10b6:907:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 23:27:44 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:44 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/12] drm/amd/display: writing stereo polarity register if
 swapped
Date: Tue,  3 Mar 2020 18:27:16 -0500
Message-Id: <20200303232718.351364-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:42 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1cef100-dc71-435f-413a-08d7bfca78c1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:|MW2PR12MB2362:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2362AC29AA878B581F61388998E40@MW2PR12MB2362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(6486002)(6666004)(54906003)(66946007)(186003)(66476007)(26005)(16526019)(2906002)(5660300002)(1076003)(52116002)(66556008)(4326008)(7696005)(316002)(478600001)(2616005)(956004)(36756003)(86362001)(81166006)(8676002)(6916009)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2362;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1g8g2/WAcj1T8Zo7SgSUe63QlJNFW34Z81gF6z3aaElwYy3IG+OlSIGLXgCqwbUSyv50m9RXphlao/FSJ86pyn9+aBmliUYNaYDPWJQ9nGd96IEAHC/BlQsVzCfQHYDQO9BVQ3yR5TuSxQJQRPSIOaWGIecoySvkZYFu7hKlL07N2oWVDWqmVSDG8kuYMcWUEkoZ66xi49Bg5OSsSEZMHya9tgq6ZFBlq5tCIfpoVAGXsj2j4eBWEyXUeQ0hOIu17hoZkIWExtJaG9MQKGe57FwWTvb9DZ40FTpdOX+/gikWvldq0ql8a1OdUxLRUUGmSHE99+uUQlRx49xhIW6bl0o2wVGJh6Rzknh0FHopypmKgTdR12CoMfVJUikYi1o+bNLRPC7B2kWNt1n8t45OZOWXnttpCdocYcOiVWFM3FgTasOdNCcLB2x4ELqSsyEr
X-MS-Exchange-AntiSpam-MessageData: 6GSGG7NSDr7lakLRolW/bpu9EdFMrbYgJVHp+WciiRZ/eTQnHS8Rff+wJ8I9k7+VdSFA4nIObzl+/+3FUaqUKqijNfkbz/kOJq1B0yphhaGYTpAXn9+ScpH5n7WnJJcWHsZetkYDxfTfvgPTPPRGhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cef100-dc71-435f-413a-08d7bfca78c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:42.9262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SPF3a2HIVNM6tz7H7yYEjauv1k4oxMoPlo4dTyiE7Xv9s1C/hYD8+Wwv4KUAzvt/VXfcAJiUKgf3RaU7t3XSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Martin Leung <martin.leung@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[why]
on some displays that prefer swapped polarity we were seeing L/R images
swapped because OTG_STEREO_SYNC_OUTPUT_POLARITY would always be mapped
to 0

[how]
fix initial dal3 implementation to properly update the polarity field
according to the crtc_stereo_flags (same as
OTG_STEREO_EYE_FLAG_POLARITY)

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 94ac34106776..63acb8ff7462 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1193,7 +1193,7 @@ static void optc1_enable_stereo(struct timing_generator *optc,
 			REG_UPDATE_3(OTG_STEREO_CONTROL,
 				OTG_STEREO_EN, stereo_en,
 				OTG_STEREO_SYNC_OUTPUT_LINE_NUM, 0,
-				OTG_STEREO_SYNC_OUTPUT_POLARITY, 0);
+				OTG_STEREO_SYNC_OUTPUT_POLARITY, flags->RIGHT_EYE_POLARITY == 0 ? 0 : 1);
 
 		if (flags->PROGRAM_POLARITY)
 			REG_UPDATE(OTG_STEREO_CONTROL,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
