Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F0C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 03:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2DD20678
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 03:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a1r50LCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2DD20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB70189E32;
	Wed,  5 Aug 2020 03:25:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6080089E32
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 03:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YamD32Oy06jmnENCD6VvPWwLNBkznUkJqi2K04RD2DowV3SeyXS2cRCb71tL4nyPJFp76rH4t/hkyK2uBzL+ClSyXhbdA49NC5df/4mVOn1W1DJEDcxyvMWJh7tFynt1Jmu2NG1OkFk1PBEWQ0nCtiuNnZKblXErrxqBONSQzuipdbbnVIrJHALH7QKF71cJlAZl6rVphrGEorU8SilsvzeAZGzRWoudHIa13n/pBcmmQagNIDQp7hF3SFuiFYXDWTZoVw5JDdC7wtORGuF4aYzdFZvUprDTllrNepKo+XKbXsS4QdNqpM+6uwJ+OzYOx5xFTRcmcNddLV50F+U9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adsZkar343xQ924VvDN1TQFNYJXoNZrGkRBcAr4lVVs=;
 b=RoKZq3nRQ44q/dQz2UIBCT7eir3FkHvZAQ59Ezl5S3FrshX8loUjX1Hp1L8QdUcbI8qtyLxt2RyuAxm046M6VjlHut9cSBWlu8rjUF+NHy09tB9b1tGmfhLPrYuPf/tBkV3UtHrf+RpQFsFtR3q7S0xPhM7d/oL4E/FyWkbHuOg4r3WG9DBXq49wFsrZaXcbF8x93lxCcAYRCsVE5razRakHDEdbAsrZXB8nI269SvoMcnsmN5yaw/xq4LF25AvL/UYfCX3cpHeyps47GcWp6iH9caGQOOwLOjXQ5XPEb+Bi0NXXWY8iFX2b+uVAKPiLd3tomKBY6YbHbJE4dvvUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adsZkar343xQ924VvDN1TQFNYJXoNZrGkRBcAr4lVVs=;
 b=a1r50LCFV1xcboIoDPaGmndjojyGpUeWXqXoafdofI3wthff94Zh1h8yGEw9Te7SNwHD11sLpm5acfDe2vdJTojMyStFzUvZTecNnAn6Q1WsRTILC4tbja4RZbWVEA+nC0Aq0dI40Een06HG67jY2gHCy+2cog95DxlB3za7TfY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Wed, 5 Aug 2020 03:25:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 03:25:12 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: grant Arcturus softmin/max setting on
 latest PM firmware
Date: Wed,  5 Aug 2020 11:24:26 +0800
Message-Id: <20200805032426.26924-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0134.apcprd02.prod.outlook.com (2603:1096:202:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Wed, 5 Aug 2020 03:25:10 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbf2fb2d-1572-42f1-7536-08d838ef29a3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258575A5367882C75A8D548E44B0@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTg2lLgKF5o+Eh4fEdsSgBYfDUQ4d6UFnQXwCNSjoNNvbYF/u97082aq9/IyavZXQKerlI2ta1lwK1Cn9KfbFSdTWSFwq3lbHloUuqw4n+C8poOCoq/zqg7TmAnHbL7z6KL+mdmdyAoF5Za3CX0xvqxr/bDCfzgaPc2QWnHjsu9CEsPCbfRT2Rn0Ld0wtOuUnr0M70LytMA7GEw4SS+74eQsWl0yH6If2Eo69spGbqIupBIWL5nWjl3XAYFkghUtWXpbULlQTM4dGAgsmcgQan5pCWF6fh7Cy8bov/HzhXgeQk5SJ+Mvyx47WjbNPW479pYPvXYq5QkvPrSvDOrJgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(66556008)(2616005)(66476007)(8676002)(36756003)(6916009)(956004)(6486002)(66946007)(1076003)(4326008)(2906002)(6666004)(44832011)(83380400001)(478600001)(5660300002)(26005)(316002)(16526019)(186003)(7696005)(8936002)(86362001)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Y4se3YI3qHDdflT7Cotu9U7YJMLJqu9VwIf0Pke71yr7GUMPN0lZzrM48gySgl9/KdZrZuWHC7riLvkRCvhqwKP6iaMiLEoWNExN9ixZlqV/2/PqoBpzmp16Gp+LHVNh4yNRoCRVIFY+o/QdDy9cgJep21Tm3U9FGxzRYXwhZhgjwG8pn40yMtpqETfZ3VjcFmLMpWCyrMW5FLci4/if//umo3XPVMcOgwkGIrD3lUfcmrZPYq0KYk3rrY6vQoBoBxyzHE1M/4Yz9odY1vvPxt0qVu6/qK8xurGZdljGlVQ6Np0dtl8aJLtvxKANY/XAkqEz0i1vUyqNlI8EoSrJnkv9SjGoGY8iy2u0TiVVUB0QmNrm/ovMo3CmrEmAd8F4gOLl1VtKcrWAu1aZbaserVDg1szuuze690j9TZyEmrIIveIoVP9gmr32VdIq1mgJeC77Jwl0edM6q/d0tBtb4FrEDfKJs+o4L6cnHxAzgEt2UoaICnnI2QEx8ckg3c/wqu0Fxa70Znp43X9HJeXnwi+e1H3VS5YoRHcA4yqLK8lHeUxhmViB44b44TiKi7q96PEOSpc4/wKOfcRgwc0pBHIm2J39EaMaPsFaOKDC6Txc26/YrfJfn9l6GviVsu6PtjZKFCpNInQWjJyl0uDOJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf2fb2d-1572-42f1-7536-08d838ef29a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 03:25:12.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46djjsIPaqppKdlzw8dlk/mI0rF5hKLFjY2SPhS/AOd3/ml7T8ipxv9ncJjVaV5o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Arcturus, the softmin/max settings from driver are permitted on the
latest(54.26 later) SMU firmware. Thus enabling them in driver.

Change-Id: Iff9ac326610075aa7f61cb89c64d2c4128678755
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index a2ba6633fc21..73de3c013834 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -942,9 +942,10 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 		return ret;
 	}
 
-	if (smu_version >= 0x361200) {
+	if ((smu_version >= 0x361200) &&
+	    (smu_version <= 0x361a00)) {
 		dev_err(smu->adev->dev, "Forcing clock level is not supported with "
-		       "54.18 and onwards SMU firmwares\n");
+		       "54.18 - 54.26(included) SMU firmwares\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -1437,9 +1438,10 @@ static int arcturus_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		if (smu_version >= 0x361200) {
+		if ((smu_version >= 0x361200) &&
+		    (smu_version <= 0x361a00)) {
 			dev_err(smu->adev->dev, "Forcing clock level is not supported with "
-			       "54.18 and onwards SMU firmwares\n");
+			       "54.18 - 54.26(included) SMU firmwares\n");
 			return -EOPNOTSUPP;
 		}
 		break;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
