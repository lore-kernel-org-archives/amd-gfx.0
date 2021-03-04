Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C2BC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 05:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6610664EF9
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 05:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6610664EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD9B89A08;
	Thu,  4 Mar 2021 05:47:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3E189B55
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 05:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAlqq6CprtPnE6oEZsPfmO1oPLHSZLrv8O1BXEDg/5PCQidhj5wiS+oRjlAQgLastFAF8doYSQH2QcY0FhLHLm1CXlVbX2LazQaD6RfuClqoHymxPsqWrx8gQ/giOINT9FboKajR2jFndwdlxlLSD/iWMzcphbPV1jbl3UH+iohpy6buNsNXH7jC5+VUQU6q1b8pEZKMJgEBMVhKmM/z+gaN/FGhjUIPGc2jr/rOL5gFW9qoGEy64KEg2Q/jaaWDMWnfeXA3hOPQQmrDlgdyK8Z54ZPrRlwmb83F/619uhKHdgZ4xMLzu7Lq3zyopKH73GCULgswCtUQ04EsLQnxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in2bWaKI/F1JVGGI97zSJe4nseuxzcud8csicxJik14=;
 b=DObTt5PGufsq5TNP+0/GrfAHHrLuK1Ot1xs/uRyDqgW5yruEVD9EZ8lSH4iO11kpzz3nyZcpKcgYuIGNe/JNZPsGXnMOWazAhTW8CqGzc0W8j1d0+HauEvXlDwgZi3Mgzn0tfw5ZlT52rCzlyTvAVgJgyCh4fLwnOiIXCu5PMNhcpZkzPovdGC5OpX5TSgjIlTFdZa4vv2elW9PBZMNPJCWhZMGDS0fEeAz2PhVAVyqmJ337ROMmBQEnw0QNB9jasHBx6AE8GP97j4vezC7EQiyCNcYWdXLScHM/HVG3qVihRonVPOpI2S4pqJho1deSQQgt1rHL2p0sC1r23eGoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in2bWaKI/F1JVGGI97zSJe4nseuxzcud8csicxJik14=;
 b=CvC6KEzwyWCC85ImmDFp74csQz04P7egXzBGBjlWczNlycZUO+tsqvlsS0Nssaufjgs8sfmTrlibDX9ZM5OEskSw64hTZSC3Rru8zQQVc2rDts5WqyH7lX/nuWBMElwP2lKVXLmlTkuyHAcfptSGx09u0D3ztyMMvGVUHqrbGAI=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Thu, 4 Mar
 2021 05:47:11 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 05:47:11 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Topic: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Index: AQHXEKqlw1oN/UrV3UuQM6Qp29cRW6pzN7WAgAAIwNCAAApGAIAAB3Rw
Date: Thu, 4 Mar 2021 05:47:11 +0000
Message-ID: <DM6PR12MB4603B5064D850B5578936AA0FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210304035824.37796-1-Feifei.Xu@amd.com>
 <CADnq5_Njn_yvVasKGcQi61rZbi1cxv-G46iTCH0xojkfH4gFeA@mail.gmail.com>
 <DM6PR12MB460311EFEB28302D41C4CD79FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
 <CADnq5_OrL7bdJd-Qo9YAdsBGCQYt7o=Trf7iiTFjeP4uvif3tA@mail.gmail.com>
In-Reply-To: <CADnq5_OrL7bdJd-Qo9YAdsBGCQYt7o=Trf7iiTFjeP4uvif3tA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=39de24ce-884d-486c-87a5-21dde329ef12;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-04T05:46:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1183cf7-6b94-43b1-55dc-08d8ded0f516
x-ms-traffictypediagnostic: DM6PR12MB3867:
x-microsoft-antispam-prvs: <DM6PR12MB386702BAF1AAA2E588B5309BFE979@DM6PR12MB3867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ly3Hgw1JqLVkri4Rg0UeAuaBAxbkMUqFpqurE9qBIfTr3FFqLaSvFWebeLtb7yOtRlS9sfVtjzow0ROGpy4QvyrKn4epLnqEzipgzEd9UvbTPuHmwceXWXYPS4hLk6zV+RrBkOKcU5MnjO7p5c9A1QZGfSb3wAXgw98dx6KSodsF4U4u0yJp06lsgMoz6rkkrGwQTy8Vd/LI0OgmgjuvNWZqUEyrFRAVOkSE237UVpzMGDrE+hM0doO+318L4p9E5BNXgTcyI9F2yY14WeHQr604zQvcBQQamUtyDJiiA2x/kqeqJ6KtfHujg+r6y1++qrdSiReOSvPHvjDfneGhde2wR/lTZUCpbAJuQ1+OBiyLdg6vo8WEnTQ0NJPyQNqEKrsRQQQqRbg0VfbbXBdrlWT3dI69+69IlaJKLEh+eXnrt04e2KDnwfbKjc58xYqWLELILpSJjxqIOEyDXD3ThDpaJWIf9tYg1pUGrAqFuYADgAXjcLgtWVRsfNeBacctEEDQ3VBMf+mS3qlB9op37MODcm1iGHvHYLVClFUlLFFp1ztZqxY1tw+pWxrR4w2cUJCa6PAze4fVNVq1V0GKVfuKnhSMhlirlTWRIuZOCfs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(76116006)(45080400002)(64756008)(66946007)(26005)(66476007)(2906002)(66556008)(52536014)(8676002)(478600001)(6916009)(5660300002)(9686003)(966005)(66446008)(83380400001)(7696005)(4326008)(186003)(6506007)(53546011)(33656002)(55016002)(316002)(71200400001)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oQx+ilsYQB2U5tN4Rc+JD7Xvfc9ARS43XnKh0+0MlRtWvdvoKPRW90UQFVv0?=
 =?us-ascii?Q?OqfZnj8XY4dPubBececzNOoZ+CDzpjJElnhpnQTT7Sg3CVQiyTUKHR3l5hHz?=
 =?us-ascii?Q?trDQroCAqHlO0eViHkZT+vcAjn6ebjTJPBKi2lyMd+fCUoC7zfD0JTgj0KWq?=
 =?us-ascii?Q?K7zSKxQ+BB0m1dmaaFPuhfNRXXUQMTEMPnI193dGsbNCZQl+Xm47R2LBhFBh?=
 =?us-ascii?Q?W5jxmKGWQa3YNaXJbROqOym96dLqyzRGw509C/8myKUupMAc3SFkBjLVWUFS?=
 =?us-ascii?Q?gmqriK0YibcDdloKMxPEqZVSM7COwiRDAoF1luQMJSDzVQc/nT5Jqg8ROcEQ?=
 =?us-ascii?Q?z8bCUsFgmVv8H01hCSrHqSuvXF3jxyQhhmVJ4yN2ksu1YnmYs45M0CuuNoDc?=
 =?us-ascii?Q?9J3r2PdL3ua73WFnY2n+o2lUeKhT7eKeJ3Sn5zxyuYud27snaWgIg6q/RVTI?=
 =?us-ascii?Q?dY6c51j+eCsV2UluIjA9l+xax4d/qgsK3H6msLsnhyuIV/6F5Jqd7J6SbK3i?=
 =?us-ascii?Q?9SkGmAORjhN6Ku+nK5L/gjWG9jNrUk6ZUuGear8hDopcAQGckbctrfreoW7s?=
 =?us-ascii?Q?E2XYPn7FCxQyFWmm2ljV0M1FaTZWUoC6JJiQknYtHxoc9LfJ1+1z1owLyQBk?=
 =?us-ascii?Q?Fq60GjxxKgF/s+PVc+aJyL/eqPF5NoKTIvWTK4266remqDuCzZSQ3Z9NNDaI?=
 =?us-ascii?Q?VxFvW5gELLeuwhIg0IlknOtxp7AumKZcQDwp8XkEeAEmi8CKN3G+lxVbWwzA?=
 =?us-ascii?Q?5t8qfdFXjDx8wwQsED+2rNk1wTsHxMaIUb2IhAUnEMTWHx2v8MIywOsxWmux?=
 =?us-ascii?Q?NXmIsgw0ng2n7HjYtlO1q21lbsXIZVt4E3AzqJvr5Oudw0qKP0lDQnlG/a6J?=
 =?us-ascii?Q?cvhoMsZOThJ3lTIKRpBYCMjN4OCKKHP48f80R5nzq4ybbbyXlLaFrcBOZ8eg?=
 =?us-ascii?Q?gUEblA+/WVqUdgUorHQRHHY90+9YEAEAZJLeqyGmbUhgxDfFZNCgYD3MQ9y3?=
 =?us-ascii?Q?phP6SuaHAM9UYnu03z41edI9mLBeKGEvTRz5rwAG0l87yOfxTrGrJlB0GcZr?=
 =?us-ascii?Q?Af7DREGEvSOaaLrbfKacee3JjjuTabrTAGByduUuH2SVobTHiKw88/2M71DP?=
 =?us-ascii?Q?ssd0a09BbbsMil2kEt0jyIQ0QZrdYdXa6J3bccHAXnCSyr3+hyOb8oSkcZJs?=
 =?us-ascii?Q?tbMHqv3fBkZOsDMKdgQAFU2s7lGn1nx5YdFSK1kgsr27VX36mFMlgqJ5hwOv?=
 =?us-ascii?Q?RsL13TNabasksEs+lJaTZyb7OKHH/Qmw8RTrd9iaDPrqOmLKwSBhIUohCfmu?=
 =?us-ascii?Q?UZDodGDuh5VpYwZSHnC21yV+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1183cf7-6b94-43b1-55dc-08d8ded0f516
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 05:47:11.8661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5nidvrkWVdPmXgzQIR8Nv+EMFh6OeJtXFp00oVztQkvH+vXvaHWSd610Cc1YI56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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

OK. Thanks for pointing it out. I will modify to remove the check.

Thanks,
Feifei

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, March 4, 2021 1:20 PM
To: Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.

On Wed, Mar 3, 2021 at 11:44 PM Xu, Feifei <Feifei.Xu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks. The VegaM still need to be rule out.

VegaM is SDMA 3.x.

Alex

>
> Thanks,
> Feifei
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, March 4, 2021 12:12 PM
> To: Xu, Feifei <Feifei.Xu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
>
> On Wed, Mar 3, 2021 at 10:58 PM Feifei Xu <Feifei.Xu@amd.com> wrote:
> >
> > SDMA 4_x asics share the same MGCG/MGLS setting.
> >
> > Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > index 3bede8a70d7e..f46169c048fd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > @@ -2271,21 +2271,11 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
> >         if (amdgpu_sriov_vf(adev))
> >                 return 0;
> >
> > -       switch (adev->asic_type) {
> > -       case CHIP_VEGA10:
> > -       case CHIP_VEGA12:
> > -       case CHIP_VEGA20:
> > -       case CHIP_RAVEN:
> > -       case CHIP_ARCTURUS:
> > -       case CHIP_RENOIR:
> > -       case CHIP_ALDEBARAN:
> > +       if (adev->asic_type >= CHIP_VEGA10){
>
> Need a space between ) and {.  That said, do we even need to check the asic type here at all?  I think this applies to all chips that have sdma4.
>
> Alex
>
> >                 sdma_v4_0_update_medium_grain_clock_gating(adev,
> >                                 state == AMD_CG_STATE_GATE);
> >                 sdma_v4_0_update_medium_grain_light_sleep(adev,
> >                                 state == AMD_CG_STATE_GATE);
> > -               break;
> > -       default:
> > -               break;
> >         }
> >         return 0;
> >  }
> > --
> > 2.25.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > st
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7C
> > Fe
> > ifei.Xu%40amd.com%7C67eba26e9d7a4ea88e9b08d8dec3af22%7C3dd8961fe4884
> > e6
> > 08e11a82d994e183d%7C0%7C0%7C637504279325196042%7CUnknown%7CTWFpbGZsb
> > 3d
> > 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C
> > 1000&amp;sdata=jUa2v%2BB6NICmTSr9Zdt0MQdjd1oIXYOzDYloTzUstz0%3D&amp;
> > re
> > served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
