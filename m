Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6052CC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 05:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0971B60230
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 05:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0971B60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811276E9E0;
	Thu,  4 Mar 2021 05:36:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C28A6E9E0
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 05:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWklRIqtnAYlijQk36G/0BxvPS8f4BEJdbxDYMNRXp+cO/2D1reaw7E5Jgq2gEx/Hi9HwLKj073PtGEU9Qglp/tZe5lb65xA9dLpcVnFHmiVLTni9eWo+D6a8q5s0jemnxqF7WnulRiHAHYyx5PCPsFEX8NVIBbTnPOVylNBgyKcahDeLMTlpWvQ3dJUxN9O6fc1ZAEI31kvZkTQg9g8kptUykzuZ32803woAKWAvzHSXGd9z/UvCU97k9wie8ufvTxknD+DkfSVQj+cRgu11tmw9uPXIKuDtG6jiWNTWu6SqaNKQ8l0rkaIN346/PHUMf0tyUhV+aCmZaytjy8+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dq2OE9Y2fO2mr7589d2UuEsqUX4T0RfTYJXVXr9FrU=;
 b=OdySunKDWyu/Bsayo0iGw/DJnMQPM465lrdiJOwtH+kp/o0br7YXY0eQ/p8AvOyaiqWo3mQE3zws+7GnQiqcHpROb4GXKgMAhnFa38jYg5nrmyJz4VO/xPoBpSoLKkSpElR62ipOKMGLa9sbetb6mSuzR9lUpfDZLnAFGz57fNMh2TJwdaSqj2S1gyIKzwBoT4H7wP7dohIIGoVqZH3fCD35OUc81HG9QA9fZjLQVBMcGkGSFhH6TyqMTJyZqS2FYE4+WUAGzKzEeJf0ufaz5ClUrbL+m2Fs8INv06XeaUT02gXnl7e0f+hS7MuVpsNZiqkiZH3ZXEi84iGDUcAxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dq2OE9Y2fO2mr7589d2UuEsqUX4T0RfTYJXVXr9FrU=;
 b=f6S7bE/iJrkqWYfEERRq3xrnkwbaOVNRpTZ0IDzYVjOLLwWdeTvCq08ZMibEa2/wmSojsC4Zw3Kw9yDyPpaw7Qxpcgn/wxyuU+K3DkPO4OoVuotEQMPz3CCfbtzxy84XxEecm8/j3g0LuaJsK/iKmwlBGkv/6DmGiYnbcqGcI04=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3790.namprd12.prod.outlook.com (2603:10b6:208:164::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 4 Mar
 2021 05:36:38 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 05:36:38 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Xu, Feifei" <Feifei.Xu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Topic: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Index: AQHXEKqngUlNEhC3jk6AVTZ75qgveqpzN7WAgAAJL4CAAAnXAIAABBpQ
Date: Thu, 4 Mar 2021 05:36:38 +0000
Message-ID: <MN2PR12MB4549948B8D0BE20506E0515897979@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210304035824.37796-1-Feifei.Xu@amd.com>
 <CADnq5_Njn_yvVasKGcQi61rZbi1cxv-G46iTCH0xojkfH4gFeA@mail.gmail.com>
 <DM6PR12MB460311EFEB28302D41C4CD79FE979@DM6PR12MB4603.namprd12.prod.outlook.com>
 <CADnq5_OrL7bdJd-Qo9YAdsBGCQYt7o=Trf7iiTFjeP4uvif3tA@mail.gmail.com>
In-Reply-To: <CADnq5_OrL7bdJd-Qo9YAdsBGCQYt7o=Trf7iiTFjeP4uvif3tA@mail.gmail.com>
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.217.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fbfaa4b-0f66-4bc1-6166-08d8decf7b6e
x-ms-traffictypediagnostic: MN2PR12MB3790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3790FA9D89480E64C61818AF97979@MN2PR12MB3790.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7SHdwB8aK0IIIJ9y9vTQewsEQKkgUIqtuMnwGEjnOU3yzBuJTrBYfnE5d7yCR0B1QLnEfHihn1Rf/fIrA6oscpaRZKb5lGrluuNU/HC4NSK5KCpk/M3IDcGfUUlBDawxofTk3Xl46ZAfoXBM0TQf7ieAb1cLqYyg2SOSVWUVnN3r/NVv9P1mFxOotXgsmmzVbQCQY5tw3uZTDkUk8FaANyKymXOhHK3ZV1trrkoXKnWk4Vo1Oqp6QA3tLenExEDvVQldMeJBBYemoAdHt30y+41M9UeDGm2vEKbNGuesc9Yds0rXcgOeaqshrHBeLCrfeL4e9PXF1yUO4FL+zHksT8D7iJ6qXzABYK1NP+KBQ6oLu6gwAKZUvFNlp8cUN2ExdoyQAI08y3fN32ML/pp4D6Waljo+n0nw16o25YjmxG5akynEoo8UWxkHiwXJL1GeyQkVrjmO4AZqkt8ap00gK0jiRRaY5Ts7aMSlJoAjLa9GFrSWJqxlAiNtruPJo+rIEv3CHJ2CNkNcQgF25Ie24f7p4jTLpryTwx4G13dqwHMo7pu/XQLwC9wzVN89bXN6xSLaXFDL9zCfl+HC7YVoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(83380400001)(6506007)(52536014)(8936002)(6636002)(478600001)(33656002)(45080400002)(4326008)(7696005)(53546011)(5660300002)(316002)(55016002)(966005)(2906002)(186003)(9686003)(86362001)(76116006)(55236004)(66476007)(110136005)(66556008)(66946007)(66446008)(26005)(71200400001)(64756008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+3laAeNn0JBA8JohZsOQ+lbiOZccWf0hsjOjk0jwZ/u+JLIFMcpjfBpn6knO?=
 =?us-ascii?Q?3S3VEH0XOQ1y5HW529kG3EK5ran3oajKpIdN3VXwzE2MyHaqgTatIOQlrEI0?=
 =?us-ascii?Q?9Flfb3iGxtIagbLn8jGqMcGuMWKTjawLL8puhAUg79OyMf/pPA/eo4shf9CO?=
 =?us-ascii?Q?3rQgZ+UHWn1AF80DktO5KM2Be0QJUfWChMzsBczhEj/kj7wn2xeTic6ShJc+?=
 =?us-ascii?Q?uT1qy1ZJsU9UwIx33UvUBwzTyTGruF7B68Du9KlE2ZKxjF3gbY/xjewJLaon?=
 =?us-ascii?Q?MZ2+g3FXUrMZj4wXu9lRf0Okpkg9FuKfNHJg/hlqkmBDSGuqz3e2qBR74dOe?=
 =?us-ascii?Q?42JOr8hOsXZOpPt/vuQYczxY6eF3YMRlaDiwtDy6VBFxTgU44paqyxH7YUu5?=
 =?us-ascii?Q?oIfZjjKSsb7KIeHPJOMSlO09enkZuwYDW1t5hXtwbAPspGPHmKUM6SolcaEt?=
 =?us-ascii?Q?RpJWA+bac/OPbVFiTO9xAFnaMVVl65Zak3KkCiwCry7Zv1Il5/wdZ3nPmUMh?=
 =?us-ascii?Q?Kp0dn5SLbQeMUyXHBCkIHF+EY4Tv8wd8AGKsXZRq95SNwq2mMN59843nzr1D?=
 =?us-ascii?Q?rOJ2OzdbqsDT0kiDtvslrn8E3Ap3qUAzGJ022vxOh4+UYgyyX1YDBVFa02SI?=
 =?us-ascii?Q?JKbE59c0U0pU6zgymbXHB88RTc0QRHL2ZQ49TexHW4B99MMsmVIQybCggnLY?=
 =?us-ascii?Q?3ZwXpyJcDVzc7S7EukoY5X1xKTilISqs6n+R8l7E6gQrjXsyJmHDyOekO5Zy?=
 =?us-ascii?Q?C1OgkxzVoBRkdZXPOrodMHTQfygYVyVON5d8lzGeM+vWtX5IG2QJetAku4j5?=
 =?us-ascii?Q?9T+2g3U0KXKFgUjhRT2qNftT5BjXXRbODncb25hL29q33NgYG6LHayqnLEaV?=
 =?us-ascii?Q?WqrG+/ho0rsKGBse5YpGMGj3jDHvKTjgGkgcOvg14L0Ven9RFJkMyaH42/Oj?=
 =?us-ascii?Q?7WZM7sWIsvrzw2EnBoPjJiHtUjpzlFv2ZV1ZGXHoSCJJxBg53ddhXgh3Ya9n?=
 =?us-ascii?Q?YPCPozw75X0kYAm0ybo6eBannAAT1bB7LViOObS6EERoyWqpWN53Y9nJ+aes?=
 =?us-ascii?Q?gyp6pO3RwJBZQ8G0OcuufKpYsBsDQx25YdUGDKis452Ya/6647M/jWAO/g7u?=
 =?us-ascii?Q?3agafgWJZesk7c7WKdvfq/tU8JW1d2CAWiMwXsn2AVw+QUKEmqEnWvDUvxoT?=
 =?us-ascii?Q?uc2BKEvV44pLylYbXcOiFQTDuGXR+7ebvUzY4NwLLN7jNPEenX7VRNnCu/eB?=
 =?us-ascii?Q?T0jCcjF32FkhxILVlNciqgxEL5nHZK3J1lv842HRdAg1POXv9yDKCnEDncN4?=
 =?us-ascii?Q?Y+RZgf7DBygTUk+Id5HoJTwv?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbfaa4b-0f66-4bc1-6166-08d8decf7b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 05:36:38.2218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Om9nSlol4umcIsfwAFCuJQZ7GNcdRX3RKvkOoCYiVq1CBoPxnnFq2b6Ce8cGr3nH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3790
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
