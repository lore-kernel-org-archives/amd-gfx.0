Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A97C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 18:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1349664E83
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 18:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1349664E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6718D6EA0F;
	Tue, 23 Feb 2021 18:00:06 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690057.outbound.protection.outlook.com [40.107.69.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BDD6EA0F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 18:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSxEzl5RmEcx1ahWKJ/x/SsVhzDBML+52QE5w/Xrr+mjCrYHee2jqrJyoGaFxd1MDX6vy7DCEO/cG15c71vQUaj5xd/7FBdfPyRFfqpf36l6bNGVqQNAWI62byotNgH5LJmIMyHh0VWEAq6tB8CEUHPp6/qXeBKxjLAPKgvFwNC+c/dsNcRLUAeCfYcEnbJPH7S1de4qHCElJafaZKZh8QNqKxaxOcpQ4Rj8VJM4sc6Ww0Mot2gaG0YAnptTw7UQOO8SZ60bi5kjGxRNEDYpadYsDGKBHotFak5piseVSDKPHuhys+3TE2TJx6ptcUpaLVS0MeC8C8sUUSnvajZWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qjA+T+7z+SpxOq1s9splheKQ8ZZl6c43dSS5dQ8nTg=;
 b=OjGlcDBghZSYwHGhpU2cBcnbjXMJJqSRSdTD0cPnpa82tpB1/HStbJAkodUoSCK13gosSV5iLy+42XN0i8OaN1sRfqvf1AxT6YkgwCdhTQtWt5mLOljMW+pD7AO4MGQRlJ/uPhpqK/Te1Kn2iMKd7XGAvp8A1ssnsI9F/LyMhqCIdcBlYpv32AEcw8ID7uTJ5oEkdVcRaBypxoZBxJimLIlUUnLWrE04rCDDNOD+bnentFB4Q8Ss+IzuRDPTgWKZDUfuyy2BcL7zmiXcRzm8hlqJaySpwzgky1l1gNHxLTKpvsEizhYpZ4TaHHbWWQNGeTuQnXUKROUBSbI0FTRS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qjA+T+7z+SpxOq1s9splheKQ8ZZl6c43dSS5dQ8nTg=;
 b=W7oyS270+PQd9GPNFa61ue9d85jVXTZN1+RyiGX7xfN0uz1QkkAN0lCbm7SCNZp3NfkfxW1JrnRhSgOg6A1lVv+clWflFGwN60thP8jwKUNbQHZGj8o+YGmunMeUotMUtphfLlI3c/k7gxqi+vx8n7sK1Zy5m14WQzwaK+JwTSw=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Tue, 23 Feb
 2021 18:00:03 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Tue, 23 Feb 2021
 18:00:03 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init
Thread-Topic: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init
Thread-Index: AQHXBl1DZPzDdb8rM0+OGe/1p9c/UKpl9IsAgAAFiPA=
Date: Tue, 23 Feb 2021 18:00:03 +0000
Message-ID: <DM6PR12MB383559EFE1D662B8479B13D3F4809@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210219011913.28464-1-shaoyun.liu@amd.com>
 <CADnq5_PXYRnX25Y=k+5dMxHuQmviD83_dei7oQDLOQDirjX38w@mail.gmail.com>
In-Reply-To: <CADnq5_PXYRnX25Y=k+5dMxHuQmviD83_dei7oQDLOQDirjX38w@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-23T17:59:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6f2f4896-149c-4141-adce-217c60b3a8c7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:c0d5:387b:19b:615f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b6a5b96-613f-406b-b218-08d8d824d892
x-ms-traffictypediagnostic: DM5PR12MB1338:
x-microsoft-antispam-prvs: <DM5PR12MB13381603FD44363C090F583EF4809@DM5PR12MB1338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W1cABcsE3Haa3sc8nJtU9U4diSjx85mV6rUTcSoC5Miubs8Nf3Oc8TgYW3yUpbzcWeiNri8DzefB3SZEXJW5p8ev+T2tU+84K1yFom3I8HxE/YhI3WSz9pHifFrSq/g5AUxuwChb9z2K1k8nKl6Ev5UpfC0WCPaNYX9Jxafv3uPEeDRPhH3zMxAVzWlb+l1tgrZKpP3pe2sq3hKhd8iRKDNVj69+WNQMefeVdsnflKTlSHFHlKC5UhH2dfFnNRGDE3TB58EiEV23Dkft1wbx9os+Xlk6ku9WCX69nWw/ekGGpWy5ANLtATcdfZkBOh/Nz1XF1guTzaBMNtCJ6cCCL7pz1jZrNNwJ0lNzpUNrEaNrj0DkwO1KogDf0Xah1ZS8xyWNdIUupwfqvIRBvx++0XoQBC7xoO44Wxa15BOaFZ7ro7RZ9SS7vjqaoqRA2Bfgpu4lTkNgXASwqSFWjlLcEzP71ahmWcqM+ggNT72ucMyR5kZAagr2qqr58h5OsfSfh2zBF+vBdLANk21xSovJ7mnEJBePW3zcmMzzZsKOA9o4Du3Qvu6WhiuBMIrvhYfb3SOqQsybRCBTdB8CExoykrBpFpXJyA1TOavmYuPWRtw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(5660300002)(64756008)(55016002)(66476007)(66446008)(66556008)(2906002)(71200400001)(76116006)(52536014)(66946007)(186003)(8936002)(8676002)(6916009)(4326008)(53546011)(33656002)(6506007)(7696005)(316002)(478600001)(86362001)(966005)(45080400002)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JlaxL+VusGCWQuvt9QA9X+dpy9kraja4kRXmSL0l4mYmjri17mk+hc+deGUp?=
 =?us-ascii?Q?7WFeJ7fu8kYDWxBZmOiTVbA8+FLMdhpWa9kwVkLnrNLvELZ+PDuzsZlnnW8M?=
 =?us-ascii?Q?H2ZSwda5cZtMF7q/vIwt0x+0rPz9jLEFFfBIonynHRc8AsrDVQCqQQST8VTF?=
 =?us-ascii?Q?SOBkdiX8/wMIlpiimS8hhOQqVGOnoSkew+eM4AkSqi50WHuW1syWml6rTpWj?=
 =?us-ascii?Q?w/29Jx5kO2zu9VXaH2gIWK+L/7lLwdHpD/5koECmHGR2ptId1/UTVS53e6HW?=
 =?us-ascii?Q?Igv/ilJMVuhALtTzksM9gDbV7ECFCU+iu7lYGulU0PbjEySE/Sd0UHmNaeeA?=
 =?us-ascii?Q?1Yx5bUwcE2CRizMHF6Th4APj4CEB49o4d6AgY36jab3z9Jzglm0SrRBflpgc?=
 =?us-ascii?Q?Bpq0DYtMz6Og2Cr3xLkrlExsKJ2BgDgKsqxyt/2cQDCIAxSF31OzffUHH0wA?=
 =?us-ascii?Q?7XsEoPNU8je+gN9sBTwE0S76OCiGgSW/XUstNyCwVdaC8r5OLWuRtkMtmsY5?=
 =?us-ascii?Q?cKdlnLzRA2W8VWxbi4l4XGxoA0UY7m2v7vQQ9QlLgm+O1D5Lgh2ftM47BjmB?=
 =?us-ascii?Q?Mgs7lh+74oeMBoXj8XrkbKOGEft/ScGh7X9VudxCpCkUB3c/9Kfph4U9yrBd?=
 =?us-ascii?Q?QLKuWo9q+npkXcr6cDTASZQglV27E9EEifmpTfvIefAv8Syx7qJae6Zd8/vo?=
 =?us-ascii?Q?K1zQI/4hXSePt6hPOQIb4ZQECFCmF087cuH0ighWGohQ9FUDVbKdEwpQIsR+?=
 =?us-ascii?Q?/sYi31qji5nve8Dc/l/L33V9Yc+MUmV2rngX2ZoeFwV4pedLscdo1RZWXSIl?=
 =?us-ascii?Q?duLLdfjSFjbVk4fJoCG9F1bwE2A7BgL1dR74e/UsW18zn9QnNVRRS55kirl7?=
 =?us-ascii?Q?FQerV6oj3FaQJBVvPM+9lcATJ0UimDkF2GFO31f/1Pobw735lCmjoSTjjzcW?=
 =?us-ascii?Q?SVOeqNdVR+0fxmSVYSfSw3Eld2ZgQEES7klZtBqdmnkDEhdDc+gsYzc8WnbF?=
 =?us-ascii?Q?79BFs7k0RtagkAQwuikEnwJsJQaLzB20/+Sm2Av/OGZTo2npr/lCoBykZ9mU?=
 =?us-ascii?Q?ea/oAFbElKD2iIs4SPEjwHy6y7lVrTld/OMiJEwJwBlf0W+ub3wygtRQJoTU?=
 =?us-ascii?Q?UISynZ1SEefpponyXesR5QzAiX/AIQexHOXLtwdexaILv0ftTkSNcxfGAXh8?=
 =?us-ascii?Q?wOD5qweyxtv5pntsGtBsz3k6qi2Iv6OrW3bfB+SRUxkK+RtIsSHCHBRwXq6+?=
 =?us-ascii?Q?xR3dY24j4H4K4wublFhm2ZCFpgKXAijCn0DnaYc+Qt3B78A87fODBnaWRRHm?=
 =?us-ascii?Q?VIHm2BkQe5sttxBuaK0F4bOLBwk4ceJJCxCKPC2KOEIkIMmazLaFkPZtxnuv?=
 =?us-ascii?Q?aRk540QKT0xsjsBAGUzJD8Xdp+wr?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6a5b96-613f-406b-b218-08d8d824d892
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 18:00:03.6130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8I6NwDCm0spRn6lm8mIMRKz6LuRIqae8MV4gHirsaDHAxdVvERBC0DADWbYPuPNmLRUDNqkXNV+KKTHTA9qMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks , Alex. 
Whole four patches are needed for the XGMI reset to work normally .  I try to describe what  these patches for in the first patch. But  If you don't mind this , I can adjust the order as suggested . 

Thanks 
Shaoyun.liu

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Tuesday, February 23, 2021 11:26 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init

On Thu, Feb 18, 2021 at 8:19 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> Driver need to get XGMI info function earlier before ip_init since 
> driver need to check the XGMI setting to determine how to perform 
> reset during init
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: Ic37276bbb6640bb4e9360220fed99494cedd3ef5

I think this patch needs to come first or patch 1 won't work.  With that changed, this patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3686e777c76c..3e6bfab5b855 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1151,6 +1151,10 @@ static int gmc_v9_0_early_init(void *handle)
>         adev->gmc.private_aperture_end =
>                 adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>
> +       /* Need to get xgmi info earlier to decide the reset behavior*/
> +       if (adev->gmc.xgmi.supported)
> +               adev->gfxhub.funcs->get_xgmi_info(adev);
> +
>         return 0;
>  }
>
> @@ -1416,12 +1420,6 @@ static int gmc_v9_0_sw_init(void *handle)
>         }
>         adev->need_swiotlb = drm_need_swiotlb(44);
>
> -       if (adev->gmc.xgmi.supported) {
> -               r = adev->gfxhub.funcs->get_xgmi_info(adev);
> -               if (r)
> -                       return r;
> -       }
> -
>         r = gmc_v9_0_mc_init(adev);
>         if (r)
>                 return r;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Csh
> aoyun.liu%40amd.com%7Ceb081cfaf9c94e59521008d8d817ccee%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637496944032343059%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=CrS5Nv4uCh8sFRILLGM%2FRgxpVlEEs%2Bft%2FHTdoeQyyqo%3D&
> amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
