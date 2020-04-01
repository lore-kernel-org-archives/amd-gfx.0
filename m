Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D91C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 05:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4792074D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 05:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1bM22y+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4792074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9196E8D4;
	Wed,  1 Apr 2020 05:29:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367E56E8D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 05:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUkynCrqympM85tmSc9ARgs4Jc+OXUV16Gfp0XtGfdldvIenxvEfnDXVQoVJCOScUFthWqpcyI3hGKex/94ex5k/PrRBCovJfS+9mcBWfBsJF5ZlAjf69ogNgyJyOmb7HXfu7dpFZ1nI10QTsxMI23xvusFQYbML+LQZohQex8FO+qE4G37HSpqxyjiMyj2S8Hj1wrfB2EeMA24VJHJx3EN1JgxJOwgDLBMDiqWw1P7g6lwLtL/oH+D5g+jx6nHttRjPlfq7KdAjKQ3x7ejoxsJCRVdyasQQlhVDwMGjASUa5Kppl7geELgfsTL5fk4GV594sepzgn/ILaSvEeBjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZuujkKWa1Na2gsJcvuJi+aDB+VOFlw7IzigH9V0tjk=;
 b=PjwyiYjs9vWNMlAypVt0zcfaVzw6pS6G/87GxN9bTp4iE18ybKkVb7WLI0AxAfgdIVHemsh6uz+YUQ4erB7Lh5bGMsC/IqEuNWDTI5JMKuFrdlOdxQH8EqlVIxwl187+4sGvanZ1I82C0IVC9boVUEZXq3ZCnk6bMjuHSxY2zx6GlNgrxJ5TMwHg9jtRKUnC0ghe2jUjaN+VrAob6r/LRfS8V9WtkBW4vYfzerUs5zx64XKwvoRxop+BB4u5W5bgeqhaBZABnURlFiEws1SuSRytWH0b4+/JWXD0SfrsGmC2+g0789TKvWxIKmAxFbidDU7961Cxj8qT++37kHvOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZuujkKWa1Na2gsJcvuJi+aDB+VOFlw7IzigH9V0tjk=;
 b=1bM22y+ulxzYDw+UAGdYp6tqD40gXLN9DtNZ/NMEIeAXQT5nnHcKPNLX0NZnLCGy04jLZv14DwO9X+j3mmNACavOUC99jZoIGq4817st6ibvZdkHOw+GyDyjPINPGV7Xd4zmSWlKPR92tns8rAWLEL+xJASm42DUeUR5HJRE4Hs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 05:29:20 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 05:29:20 +0000
Date: Wed, 1 Apr 2020 13:29:11 +0800
From: Huang Rui <ray.huang@amd.com>
To: Yuxian Dai <Yuxian.Dai@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set
 the MCLK for DPM states consist of three entities :FCLK, UCLK, MEMCLK all
 these three clk change together , MEMCLK from FCLK.
Message-ID: <20200401052910.GA30750@jenkins-Celadon-RN>
References: <20200331101016.2960-1-Yuxian.Dai@amd.com>
 <CADnq5_OfZKpAxCPQ5jJ3Xq=4vJYaq7OnpBHpocODOmAYE+9Lhw@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CADnq5_OfZKpAxCPQ5jJ3Xq=4vJYaq7OnpBHpocODOmAYE+9Lhw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HKAPR04CA0017.apcprd04.prod.outlook.com (2603:1096:203:d0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 05:29:18 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0075b551-5433-4c92-e307-08d7d5fda0dd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:|MN2PR12MB4095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4095D5B8227B11F85A79556EECC90@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(110136005)(186003)(966005)(316002)(9686003)(6496006)(5660300002)(55016002)(54906003)(45080400002)(86362001)(478600001)(52116002)(4326008)(66556008)(26005)(53546011)(66476007)(956004)(66946007)(1076003)(33656002)(81156014)(81166006)(8676002)(8936002)(16526019)(33716001)(6666004)(2906002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFa150iu9iC4X08u7THKKC01NP8ZVsz1iUue4wpoKDQluea1l/jG7FmC/NIpaKMa8AryG+xPsRliM2k8z4OOdRb+BSrA85+w7XWKXeDq4wZWIX71xaRsT56D9jyd3u36RtGBYxYS6eHLT6BuJrwE9Hco4vyOCUC5rEYE7Cv7K33Fwtgu6zOqkkcr6SDnHlJSva5Dru9Q5CqJWixtifMu6D+ZrZo7iefTg5grhrNcXQ2FnhvtAglgJy8gwStfNg19B9nRenNqq8wKy2L/47K6UDeOqpx+XpkG7+uJtnxMHKyl2idpfTmipm3XTulNB+YNswU4hW+AEQaSCpRCOZvruiuPm5XIymWN0stRmpiX1n21TIshaCZRwigeZjQonECPe4j+JCBHgRymjtip9y+7QpODJUo9ZcOqHYnu9blwLc3Hybg/ux5BJF4GOtbYa5ZhHkugD2wrulALH7s4Qiv/v0RRU/KqBhuI20y/1Qjsbss=
X-MS-Exchange-AntiSpam-MessageData: Nsbk2tSDZtRTNpJI4NjoOTQ+RF8JalD50GqUqnBj7XuEDeemm4rNkSajcu+wVu1s9KRQHfocuJKoO+WqWe5bk6zZxqCHoSSlAbjGLltIUO8Ov/WIyiL77d6BcaOQ3T54kpih58tVby44VsPERWOR+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0075b551-5433-4c92-e307-08d7d5fda0dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 05:29:20.1990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /clvYxJQDphjBDpOJj0/xgD+PasdPYwfMxq/OOLSAsc9QB6GXeVMpiNZ1xp9Jper3sO/rJKIu7GpIbmNYF0RGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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
Cc: "yuxiadai@amd.com" <yuxiadai@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 31, 2020 at 09:41:44AM -0400, Alex Deucher wrote:
> On Tue, Mar 31, 2020 at 6:10 AM Yuxian Dai <Yuxian.Dai@amd.com> wrote:
> >
> > From: "yuxiadai@amd.com" <yuxiadai@amd.com>
> 
> Your patch title is too long; it is basically the whole patch
> description rather than just a title.  Please split it up between the
> title and descriptions.  E.g.,
> 
> drm/amdgpu/powerplay: fix MCLK DPM handling for renoir
> 
> Using the FCLK DPM table to set the MCLK for DPM states consist of
> three entities:
> FCLK
> UCLK
> MEMCLK
> All these three clk change together, MEMCLK from FCLK, so use the fclk
> frequency.
> 
> With that fixed, patch is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 

Yes, and usually, we don't leave the commit message as empty. David, you need
describe the detailed info in the commit not the title.

Thanks,
Ray

> >
> > Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
> > Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> > index 2a390ddd37dd..89cd6da118a3 100644
> > --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> > +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> > @@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
> >                         freq = table->SocClocks[dpm_level].Freq;        \
> >                         break;                                          \
> >                 case SMU_MCLK:                                          \
> > -                       freq = table->MemClocks[dpm_level].Freq;        \
> > +                       freq = table->FClocks[dpm_level].Freq;  \
> >                         break;                                          \
> >                 case SMU_DCEFCLK:                                       \
> >                         freq = table->DcfClocks[dpm_level].Freq;        \
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C541f2e15da804d81c5b508d7d57949d2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637212590166168794&amp;sdata=7x4pBWEPuVHbb8ro%2Fpy5%2BgiJhrxWbLrxGqHSro9KUV8%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C541f2e15da804d81c5b508d7d57949d2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637212590166168794&amp;sdata=7x4pBWEPuVHbb8ro%2Fpy5%2BgiJhrxWbLrxGqHSro9KUV8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
