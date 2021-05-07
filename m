Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4BBC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2E6613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2E6613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69C06EE44;
	Fri,  7 May 2021 14:59:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862A86EE44
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH2G/+1TDjvIoCnVX+JcAHvyaPuKMdgEkmseotTIlzQTG633nVsXbuC2NOdo79BmF6kXgg846Nf/5BiKsC6FzEl0BAxOd/dRsf7ubXCfj5itgaGSEXNXjps0z6RQ6WCFG1xc4RT/zh45Ab/l3teYdiEEMH92LGT8IA8Dd4m+5QRtgEnPvRqmIKhBlFu7JOzN5/bbeLW/iiz9GjtzfxhiBCt3gpg5M7rVDZygBphKJ44VVQt+Ts1COdRGQy43TDj4ybuik/9xzsZBrq+O7kkjTe4Mg30E29X+MqPdwf6Yh9HNWZPo4FGBCa/8ypMfZDsJmqTvz8Jc8yaOkxzLAErGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7WRJzhJXr3q6gvFCvUpkSRfEjvdbLynL0jqOPt3/rs=;
 b=dmXCpJuUZ65vh6atxR2w4nseo/gPtNK/gJGBH8D3NlYuvEn2BCFUBVw8PVqQ2jyybkFZBjevcfgTcwtuj1xU857bcCQmHl/0AxC6dazuGqeJgz64hll6qvXpRzrWtkNNqChxrOANB2yw9H1OF3z7BCkjr0KFSmeyh7qOBGWCzjLpz2DNsExG7tnJWGPAndmLoxGatAJiBwGR64MOi/RH6ybiEaAXpwoTHYeoUTfCH0QbvSUYgDVcwojY6dYOnyxKY71n8lfyEPxA9IjjNrMExJu/NIk+fyvtSXju7HJLjQG5nwQraNWH1+lv0UgDIvWFshc404UK0sJ1qiQk0znifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7WRJzhJXr3q6gvFCvUpkSRfEjvdbLynL0jqOPt3/rs=;
 b=09HDbhOpkEFBDX5GtpbmP4W/R75RrcbKcNTjnVG9rgqSevQnNZuHzk+5/58RNFPyQvN5a4rXCsCDqwyAMzjx6w4kt9uNPtMSRel1kmLpCgHizRywulJUt15G7MEotwIISH1lfTq63gxjJw2KlUmW7SgrFBKa90JafragP9NaEM4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Fri, 7 May 2021 14:59:28 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:28 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/14] drm/amd/display: Add dc log for DP SST DSC
 enable/disable
Date: Fri,  7 May 2021 22:58:13 +0800
Message-Id: <20210507145822.248029-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba86a938-395e-412c-b077-08d91168b5e3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB385232417F9AEF1577E4309EFF579@DM6PR12MB3852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoMHc8v6PpzwthhoHXZ2RSN2Ajvq+w3iWcJdcWh97W7zMwbKSavizjBRg3QjPQyC7b0vnuJljjTX9ao8MB6cN6Jc6PVi3L36z8YtdY+1/svi+fnCVmsGr9J/STwrAeQxgjJrJn4aZoRRL8k79C8qfJ1oVj8jKkaM8M8oByTDEA2fHFGZut8NMl9MZLECTJ4Xe3IBpxxXgt1m6lfOqUHF5hKgzjtMrKT4jrv4KX3qTT7xPLUQeDzaenXmQZW9UpWsPglfGqvu2V68LqPhmV6gICrKV7XHFmywjJ4M8RdnnPiM99y2kwvsdNzwPpmWQy1Ox21ykifla6/C1LL07SrS0wrQD7R/v+21LLWF3Yoec/FUTW2NerjI2AruO5uDLIkKEQhhNOfvYdm05pEzZixH7rwDrVHMvkXYONUBSdCTD+7kl55moOnUcTMsOYoiZ9yIiU0wxUv63ltxnoU54+eL9ZFv9DJlMOsw7bdgqhu67C8rmy4ibVVMLPYBUgrgAbM7nMY3MPRYEBo6PscG2y5+5HxeBpZ9Vxqn8wJJDELoCFOCj03F92DtK5ZKc4VLOa0ESXeS5i55AsrJsih/Ygz0LT1LuhurcEU5PV13e80pByda6xs2d0/XYZ6CDeH4a9kl+EsZ1u+hEDi2V7aIWnOVFzixWtqkz+YDNP8ndOkzzy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(316002)(86362001)(38350700002)(38100700002)(4326008)(8676002)(478600001)(44832011)(66946007)(66476007)(2906002)(26005)(52116002)(54906003)(7696005)(36756003)(8936002)(66556008)(83380400001)(6486002)(2616005)(956004)(1076003)(5660300002)(6666004)(6916009)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0o2KB+CzufbYwJbxMB8Y6qzsamhm2u+97IdjaatsdwaPmWCT2IhUk+QvBXy2?=
 =?us-ascii?Q?6ah/xz9QiLYxGmUhkSilFkEM825gSeEzfC7g0apVmPwfYohWeTKR0zSKNDQ6?=
 =?us-ascii?Q?4RkWrny9DyeTn66gXCC3VSDzdiItamcNVzyFXvWl+7K6A6ty63uoCtFckJK1?=
 =?us-ascii?Q?iFejgW8STTTk8RXEvQcQwaKK4Cj+PkHQSj+7SpfzIlxhCXYPEPD8Fr8A6wxt?=
 =?us-ascii?Q?qYPHf/jaLQO1R1a2aXTHtKJtp2Sw9FvPIh1sBJyPNRkkgY4+z3OGe0erK6of?=
 =?us-ascii?Q?U9nGPngzg1pVmM4Sj6rsJ9+QHuGp+w7MNSwSPs7uZcFKx/tGAuxA70HgfdvO?=
 =?us-ascii?Q?qMeb3xccB1U6mw0+3QCbwgC7nVDYVQvP0thmjodj5vmwTMVJ6NcdVoczojvx?=
 =?us-ascii?Q?VmbJfn/3zDKaeqHabuc9l5wXSQFriWkyV7O8oNlMeUxi3NDb++t67IZltCsH?=
 =?us-ascii?Q?R95yMKhMkayu/BVU04MxXchyRz5ckCFk5Mmy33/k/aGFR/JuofhOeBifZDr9?=
 =?us-ascii?Q?i9tPkXxdItMN6W4AeRRVh2qXGgbulruNnaFaLSyk6mw9yRAba8+nIY5F9trM?=
 =?us-ascii?Q?rKjd4pM2dlMGqptlv9OfrFoFqVYwtwGdx2OQnb+137KgIbLbUm73qWDbqBTu?=
 =?us-ascii?Q?Rxbm5U94rLCszrlb0yYA+KKAW5GW9pWEX0rG5DvI94iBiNtAGeF/Xuw62L2s?=
 =?us-ascii?Q?rmpsi11b1HJyAWR8q2TaLGbecqaSxXAGvQk2qdSHANAfOwjVNzlTCaNXM/o3?=
 =?us-ascii?Q?CYDQ2765DpX0wZvG6b7Ja6IHJAGQOI2PLpjrfVL4/sj1OSerUJxL6b1s2nKq?=
 =?us-ascii?Q?a2mcAeL2aZ3yQGdhgkLejKbh+m3xWskfiUGxb7ibOqHuGxwACLFBbSNqjjd0?=
 =?us-ascii?Q?dFrOHro+E17/PBcOkdVto9VveGbxk7P9xIYvApmTNjkfqNCJrDP5k+OzeVhW?=
 =?us-ascii?Q?g48p7zduwZsMlQJxe5qJIX2cFtZDRACUVW8TVVOffv2m12/HkVlz5KbtFEyJ?=
 =?us-ascii?Q?JGDT0BxTGqXzsKDb7s4JLnAgQPmfavBuL31+OzlKbVHfuWLOdFjSNvzUmS3M?=
 =?us-ascii?Q?VhUbHFc6K5dlvogijNAJMsauP7GEaDDYdbXcub6wzlB6fheOgLbQih9ivASA?=
 =?us-ascii?Q?Pt4x6+U+11rP1eKkfKElQj93feZ+3YRo2+wkE964ilpXsygdPLKS/OWixh9V?=
 =?us-ascii?Q?bK/7aPULpsFGP9gMylZgHK+rgmRE/UJUgMpD+D4Fwy6AsG674t9S7k9C8N+p?=
 =?us-ascii?Q?4tcOhzu9xEWhMxBps2k+U0MH6WrXX4cGIDDcyKNOWeBGDzQpPgirU0UA60rv?=
 =?us-ascii?Q?oU5kzPT0MPKSARyM3Ninunjo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba86a938-395e-412c-b077-08d91168b5e3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:27.9243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPjdQ9bQIamGQRmRmRshMEb0sns+qPsCRnsPCWT8V5qiyOcHTS/f+IZGcuapgZkU9nPGQXdf6sRHGnFbrNdwcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 90eacdac0ea0..4646b0d02939 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -544,8 +544,10 @@ bool dm_helpers_dp_write_dsc_enable(
 		ret = drm_dp_dpcd_write(aconnector->dsc_aux, DP_DSC_ENABLE, &enable_dsc, 1);
 	}
 
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT)
-		return dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+		ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
+		DC_LOG_DC("Send DSC %s to sst display\n", enable_dsc ? "enable" : "disable");
+	}
 
 	return (ret > 0);
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
