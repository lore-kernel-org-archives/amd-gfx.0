Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96782C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 12:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8E264F59
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 12:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8E264F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA206E15E;
	Tue,  2 Feb 2021 12:05:03 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EBE66E15E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 12:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxZOmSM3GyhVlT9U/w77vg0kz80htfVG0xMFQbYLLf9eQCPeSx/MoPu5zrfhwheOdvEV2NdJmChz3LXcB5pvCdxPs4YNHMly6LPolQLqtZujNcbsvJcLfg2w/llWH2dWFHCsaVFANKpBNLRrk7E+XXf1qkHCW69zTPrq0+l9XtEd4dDDpvquDXzEtEit4NA+4F7T/8Igjk93VVPakuBn6m9MkZE8/mwtAdRsBMbQ4CUUKlav7/Dv0tPHD+urx6aBmJ+0Cst0ZWZmzDM2sZHr+NGLcuvbFyY+ogE+AnNvXmIgFxbldYmpGdg3DG/B+6PnQH3Ta/MzmLnFJMsnxIMqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBC5WfFQHuomSUyCx78Uw4K1oT0zfdrEzBYFAePskA4=;
 b=myV673H3kC3ivCWtI9pZpfDyFhi1NRnw4aBXX3jZGX7l8L8BBbsZMWvsTLhTToaJuQb89gV7NizymqZs1EvKUILCFjBZu+3u10Fg4IGBEUQqRlNZe64wCVV8/isVebZsT63CbVCSGMr+E+Un3VhmVLwRaxmKAQHSaQ0T20y3ptNmbAZOdSiIJyuuXIIo0vj3WCVphwXQ1aDSocUymM1H8ETNN3KWHZk1yktJzKeOefNHiLeb+t/TEtJ4ZE5CH59VVEEt1HLhMlaaTL4AlYJsQdDYh5hx37ZXy/jTMmT9TDISeTkT//Y+3eD8RKN6vXNzmgkorjm+yNEfuVdqWGlthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBC5WfFQHuomSUyCx78Uw4K1oT0zfdrEzBYFAePskA4=;
 b=pepjAKI171+2HYPAXaEigF2kFKbOCsw9rW7N3KveToUXKLJct+UOlRx4bGNAAkD60Wsj3rt28GnLvfcKroB6KKv21U6IbyTvSI7UmKW2c2FW+pTEF5Bgts9xsLLZIKF8Fs0HH3giq7X+Gz6FKNUw8Aox+RYnpMNK2wHrk/Thg1w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.22; Tue, 2 Feb 2021 12:05:01 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::1490:780f:1494:d66]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::1490:780f:1494:d66%3]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 12:05:01 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Disable GFXOFF when GFX DPM or PG disabled
Date: Tue,  2 Feb 2021 20:04:43 +0800
Message-Id: <20210202120443.2685-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0088.apcprd04.prod.outlook.com (2603:1096:202:15::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 12:05:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42abad1b-719c-4357-c6bf-08d8c772c494
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB243818E2BED822A1A985EFE290B59@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLMoAePbQYSK8Zuxcsqc+z7PBCxmIk84eWVDPoiZssLOqYziRRAo31qPe49iMMLqqf5WH0w4Jf3qgOjiJPkUVJlo8oph4XLHEHZvEcJvQLbayDh1TURHc8pqv0sCCH938b1YVNoouF6Ilp94vvyf7Puzqd9SZyrmxHr3WagxA8TzYGFgpaL8uln2YZ2LtScTatV9V/qUrofgFE3frm+Csdqi4k1Ii9HecjxkrryoRiTefJOYYn1yYPZ3r3p093GM+WIXyoQGWqVmF9Xbs48L1KJha7DvDGIoH/OrJ+7F0qvSJJeoyAeHyusvK0OwLRSDU5178iNLQfd7jwWX4DgIrm4MMtaqymo+q0s3SCbrXrf2cwrfKiC5p3/Jgn5/5T0SJcALPJlTICQ4MGHifDlMJ1R6l33VAOUUgoQk2WPFOmwazJC+H8yuzK6HbJ0oUUuve5qL7Mfkiy0b9rFari/FmMPG69jKT6Fy3zad0Z3tXuRXs5vFwYyxsKLupRVtGRvMag4sP5+T63opxyMNHjpiXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(83380400001)(66476007)(7696005)(478600001)(66556008)(8676002)(36756003)(4326008)(2906002)(16526019)(2616005)(86362001)(956004)(26005)(6486002)(316002)(6666004)(186003)(6916009)(52116002)(66946007)(1076003)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QYAtomzsR+BskUPj0UUkBUAk5+VwyTDzZRWnpc6V1peVAfFir+G92tywL7lo?=
 =?us-ascii?Q?VXDDMh0cMTjSwFeGJ+YnCwqxqB7TsyADJylF3cr3wj84l6R00W52sNEXwdko?=
 =?us-ascii?Q?59WSymJi6MsfPbut+HyoEF/q43ymVdSiPHNEmmeAUQRnP6aTGzxnpeVI42Tz?=
 =?us-ascii?Q?nFgsfO1ZSKVNkLo2SR89vxAkJ1j5m51seZwWZXWExmBLqDmXkflHcKaktdDD?=
 =?us-ascii?Q?UnCe8ripRgU14w0LrD6xhpfNTfP8je3CvoAswE7mOXF4mNcCpG4pU/wMZHDJ?=
 =?us-ascii?Q?B7odCKy3KKMo2HqCjnk7KvWxr2os8YZzcM9isCduwqbU0aRB54UQ8hwosRlO?=
 =?us-ascii?Q?t/Zl8Y9bDcEJjgSwjVSZaa7x0UUQCUlfCyhZhWWM2P+FBrd4sCLlpVUGcKh+?=
 =?us-ascii?Q?hquZiTWUhhuMJ3AsnY3K4EZnXD8ZtFOh5cvjebkff6mc/s998PtYrQtLws+q?=
 =?us-ascii?Q?DslJKgz5kqp5nyuLh3FLEHIFTfpElawqNjXTvudefTOByessyyptg9NXlA03?=
 =?us-ascii?Q?dnG5qeo59WxB3SmnaHveYf7u+Eqyo+Ir//SXHO80sHKra84Xf2fiplGXytRB?=
 =?us-ascii?Q?gfm58tGnLJ/CSLeVj2T20kiXw/koAdOAbFOCsPcO/zrs8S/qRpFIH6+XsyXj?=
 =?us-ascii?Q?6FWwG3l1IzmZw/n+oM2S4HjtKD0a67RjxNTHsqfXecsyPLfSxsXYwkW02ymm?=
 =?us-ascii?Q?A4c/Gp1N6pjsRNp/V9jBaT3FyU1xZvIBCpxnWXw7ZWAJVlQJG81Iyh0f00mf?=
 =?us-ascii?Q?5lvyu1SiTcDVGX3n8Mro+BurYjicQRnEfBv9FZPUZnqNZZhEgqYAGuEoUO/A?=
 =?us-ascii?Q?ciFqTxqp1t1swDdIDzI8zzAI+0xWclWxePj/ZJD+KiAdJTTye/HsS913iOhy?=
 =?us-ascii?Q?AtQVVDjnxSwmK4UlOaJBPjSDnDejhEThfYml/TUZQypYuXdQOR+ubwDpr68F?=
 =?us-ascii?Q?y4Xx9KfHlqgCqmBxnzUvQrENWj4Noi6dJpBz/iXPZbyk6jV8S7C/uX+oZKuW?=
 =?us-ascii?Q?5uP+ekLaonvNajF+R0nyKjo+F4Z7l485jurrN+XMDvS0fSjrWvaYMFJy76uT?=
 =?us-ascii?Q?f33V1dFnjsY+M4cYpY6wG+uEthJvxw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42abad1b-719c-4357-c6bf-08d8c772c494
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 12:05:01.5246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04GyfcVUuBP89VerfAFzMyIeVILzjiJIZzk6secR7I4MUvEBEYi64ii1Hl1DAdFSv6U7Oq742Fz3RHf6/RPTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check GFX DPM and PG bit before enable GFXOFF on Vangogh
smu post init.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 4726cac8d824..f0f06ef47b9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1712,10 +1712,16 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
 
 	/* allow message will be sent after enable message on Vangogh*/
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
-	if (ret) {
-		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
-		return ret;
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
+			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
+		if (ret) {
+			dev_err(adev->dev, "Failed to Enable GfxOff!\n");
+			return ret;
+		}
+	} else {
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+		dev_info(adev->dev, "If GFX DPM or power gate disabled, disable GFXOFF\n");
 	}
 
 	/* if all CUs are active, no need to power off any WGPs */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
