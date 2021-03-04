Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B0EC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 05:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE2B64EF9
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 05:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE2B64EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C5A6E9E1;
	Thu,  4 Mar 2021 05:48:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCABE6E9E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 05:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq1blTKCr9n0vYPuW6vfUNSvr/nMQOyj4d+DEDLTWhwDzwigk4Q7MD5cyfb7AFVh9ZT8mgUC94qrejKCbVBYttl92JixuLbHobnfYEaBK3f72mjmOHUqj7T6v6q5DDX5xEvC/zAo9fvWGOik1BFuUgbuTpG/I08zvPkJduuVGiGYBcF273ZTQSHHgTpjaC2CRgk2Hm20Z/sh5lcDk0CcZU4c6rorEwptthpxJlizZ7S7Ko0pZaCuKt6g3GZonhN/QU9myJ7L7q5klmQ4sSOWZi6/stedlWP8oVcecANv6mnvx+HI9YT1aQKRZNIA2kxXze1TLw7JzKRDDsd8ABAbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6am9ZTfwGsjHTfeBXr6LLJZqasd38bunnIWvLF4rtGw=;
 b=KvERdI0f8ENe8hgJ0Cuk6+se7k3YfJPB5SCf+Mjp/2jDosAv9xwuSEzVStkKatJ5/uUdCCE5B9Ey1yJWX1ptM/q+BHB6R9EGH5cRTHdvMPaPPB6bGdmSY3pBvSjHh82EJ9sYMk1jE26QxJOkenjiZfSMe2zbFOpN3RPRwX7iDt6Qiro8Hbu0sJ2f0NNVtnEOsJMNja43Xijw8/pa64ovaGDNJqvSHs+Kp4c/LEnvNKD03xko08XElACmCnJVq8+nqrsRDNVH1ttcL8j/7vb6o0Qna4KtV2KBssJepsdoEoXqJR97SnvHXaOv0tH/4LdBQKdLvveKSR5BzX2F8X2I8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6am9ZTfwGsjHTfeBXr6LLJZqasd38bunnIWvLF4rtGw=;
 b=xgTNxPRBg6c0BIgomUDehwxfWHTWpVrwgu1MhMtRRmcBtsZw9/VPT5Zo7UAjZBBt28C90dSOokez1jQk68i83rwQ81AZt0LcmKzNL4nCesvNVxkNNa42AgzaE5fXL7oo8sJTQGLo4y9QFvzvaXItXwtoNqFhy0qtqZ34UTyLjUs=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Thu, 4 Mar
 2021 05:48:23 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 05:48:23 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Topic: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Index: AQHXEKqlw1oN/UrV3UuQM6Qp29cRW6pzN7WAgAAIwNCAAApGAIAABKEAgAAC9HA=
Date: Thu, 4 Mar 2021 05:48:22 +0000
Message-ID: <DM6PR12MB46031113C9C48399095B1175FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210304035824.37796-1-Feifei.Xu@amd.com>
 <CADnq5_Njn_yvVasKGcQi61rZbi1cxv-G46iTCH0xojkfH4gFeA@mail.gmail.com>
 <DM6PR12MB460311EFEB28302D41C4CD79FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
 <CADnq5_OrL7bdJd-Qo9YAdsBGCQYt7o=Trf7iiTFjeP4uvif3tA@mail.gmail.com>
 <MN2PR12MB4549948B8D0BE20506E0515897979@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549948B8D0BE20506E0515897979@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T05:36:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6f2eb31a-f6d0-4967-a0bc-20146e01df57;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 376ef3e4-dd2a-4920-a35a-08d8ded11f7c
x-ms-traffictypediagnostic: DM6PR12MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB38676646FF2BB14BA1A90B61FE979@DM6PR12MB3867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JeDMzNaCRJt9CPmBj0RWkEPEcwdKMo5eaP0LNodm9xWWHeXXMW6DlIZXatwaoO+wL+JlASW2Zi1Jr8ZwDYXAZMv8NAiw+VawI/5UcdkCSepO0yE+6SCWvXu/C2/keijPypWVq6l8c4v+EqgCH2bZb/PH5Ag5Dpa5tJoojrmMfMlL7zx/1q62zulTLawExnAu1vtE0/3pfo3fKBI70XaHO6slf/vgYZJI4Q0rIaQnAG4EOgT8LvqxvdgkR5yn1kxSBqYMH6pqizmrnlgSOPVp40r+ytpB2NFv7RKVN3t7ZzJzD9c5G/9E5Yr0DJe3l05vpQLbR1cVMwoUmDitA1IQNsZWV15v3N4EXS6k3vO21/6C6kr7YQ3m7GJWNMMTunWR18bLEau/YzAyklw170uyfofGLi4oiACvQY0phhNyycDKxBA8rBLKgkaJJPfGFQVJqhAowrGxlNu++D/u7qCm0qTt3DguFRd/YnHIIgspZ/2Sy9P50BoPzdbYty0HJEzptpvYRNrVN4uNcixyTHL0CbQveIMPPtNqtWKzEXIgZrGEZM1QyB8u2zDpO4lDWy6jpZm0BEkg1RmADEX+wd1dEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(76116006)(45080400002)(64756008)(66946007)(26005)(66476007)(2906002)(66556008)(52536014)(8676002)(478600001)(5660300002)(9686003)(966005)(66446008)(83380400001)(7696005)(4326008)(186003)(6506007)(53546011)(33656002)(55016002)(316002)(71200400001)(110136005)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+0oSlMvNa1Rbb7AXFH48o+QReRQDThdX21Mjcq0Rkh9kryCvonTedB+8KuOQ?=
 =?us-ascii?Q?eptcKqSkaieFPeoYJT9v99YImx3yhR9nTc7HTuDzKZAvOovdcv64N3IWTLrC?=
 =?us-ascii?Q?ZWnmU1SAY9ulR4JPX+tr2viCCNldLQcZag7il1TVhH1bsFSjlast84hnWamX?=
 =?us-ascii?Q?5zXNj1nqVlhEmZpj0JKplakMpZfYiLw0reeQeMvJ5oVxL48ZJ46+W6vU5IPI?=
 =?us-ascii?Q?unQD2oYHwBWZrZkFwNJDyNmqw20N0OzNJ4MaQwTqTPrGraJ6NVLpPEmooxzk?=
 =?us-ascii?Q?rGqqF+yd5NEQT3p+lUvrVMrBtmxumArh7PZcO2jdy76N8GQQJ76WjZ33NOzg?=
 =?us-ascii?Q?qYyek7soSSvfPzme44mltrwGFEPZwlDnjO3Epphid3hcUeCDftPC+tV+0x/u?=
 =?us-ascii?Q?PkM+MYOjhDM4pvyRZ2ql7OpJ4EVS7Tyl4JuUS2IWfElnlcyF+DqELPu/uoyW?=
 =?us-ascii?Q?e87DmmB9n3L+ovw8sKnrPGaz+MhyygsC3cpEatE7gGZNFff54LdAcCg3gI4M?=
 =?us-ascii?Q?JliKkEw25p4Ei/pEfsAIgCDRj+WckE+8SUa+I69pqrfoIvrXzElWst+wSyMo?=
 =?us-ascii?Q?sDzhryasMhNBKwGY1iwFzMKp3/Ma4WF7puLsHGgn+llnzVW4mq+KR6c2Kewc?=
 =?us-ascii?Q?5XKeFjm1TUFBGt8keiNT7r5sAh6udik5QiZLR+oLqG44cydK9/dzae27+U8T?=
 =?us-ascii?Q?xACs9KKdyEF3FCJabTpHtFbFresLExv4YNrK+WGTiRhDRkwRROmLpLu73xPW?=
 =?us-ascii?Q?T4cWagRdHGp9jYKsQFuQ3SProTTdXNwTqYxzRhLUK8l/wF05u8UfWf20PUAE?=
 =?us-ascii?Q?eyea0zS8+GCdLcwPjS6pqlL0hSa6uopUcLOqigrdJfbnZNet+P1R+LgqVrJH?=
 =?us-ascii?Q?H5zf2Mxo57wtEi2CO22QTqwUsg0Dx+JDKw3HR+OxJVvPbjfNcnU6knIyD2aj?=
 =?us-ascii?Q?Wdk8V5gO7I20ycjeRdsiNgws+5F1KgEkKaegOguHUGwSnr0Gvnjiwv5eaNbR?=
 =?us-ascii?Q?Zs0GRLG/BphAC2py8bEUjF6IBJN5giV2eT9w0Tf4HUiV4KPqoCJ6JDFNEZmM?=
 =?us-ascii?Q?QJTVsod05WAjbfoyYFe1Iv9OGBZDu9EBKCZOkFEwPZxEraQYkp0UyOSRN7Jq?=
 =?us-ascii?Q?dC+c9Tv8jN+ZEpeWUWbcHHpKrLGgadk5LowDbxkLJISi+rryiilsea1+452R?=
 =?us-ascii?Q?HbPnRqbzgktr7pwjwPq62+AcKUYB7X+hCQmW8kZmKCSo1r4e0e8kyRT7PvKb?=
 =?us-ascii?Q?EjJ3k6VSHwSKUImCF+cibno0uCZjlP2G1hYdC/3n0Hp9hhzD7hjzhkYjCbY0?=
 =?us-ascii?Q?GKmOQ0MRJxJEv0WMaF4c2PLO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376ef3e4-dd2a-4920-a35a-08d8ded11f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 05:48:23.0038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLV6D/fVTPYQf7mEq7TqSUt4fE+hcK5znggIlByUfy1AvoVXkOWcwTVzgD6HMxBR
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

Thanks. Will modify to remove the check since all SDMA 4_x share the same setting logic.

Thanks,
Feifei

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Thursday, March 4, 2021 1:37 PM
To: Alex Deucher <alexdeucher@gmail.com>; Xu, Feifei <Feifei.Xu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.

[AMD Public Use]

There shouldn't be any check based on ASIC type. If a check is required, it should be based on  AMD_CG_SUPPORT_SDMA_MGCG and AMD_CG_SUPPORT_SDMA_LS. We set the flags appropriately for each ASIC in soc15.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, March 4, 2021 10:50 AM
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cbfbac27bc87349944bb208d8decd3447%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504320239632738%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=LJ5n33cyVrDmUCl%2FrJYUUtYP4RKP3tIiS1FKOSqdwyM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
