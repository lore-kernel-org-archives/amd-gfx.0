Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F8FC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 01:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77546239ED
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 01:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77546239ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB306E8A4;
	Tue,  8 Dec 2020 01:36:43 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B697A6E8A4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 01:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKqeskgQnC6bHKg823ALMPgBhOFtinxifVuYJUFraIWqBtcOVU4VocH27zaq9p4DFXiHUpkz64QKTR3HdnHlbdocN+/3+x5PTI4YLWKG0Tiez+qtBoSNG90n5n3l1xvMCmj4kGfvU8hSIuB1XxisAxTaADHC/E8nWT7+oho7P4OjqbcjsnCy7aohI12B88xS7mkPBnLDjifiENDikKze1jys3lxsshZ5KU51rCSBnUKvVLzyDgSkfAIj56YmzUoc1sIVz1IF/Iml4w/GWAiV5yzSZWzFme3n54GX1ImluLd9uFfGL8P9JE7pY/jA4si3JLg/DGOZ69KIcSpKwmVGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDbXZkRmNu5/Uv+dQDH6tvOsiX9YV2O/QPFVsNG3sPw=;
 b=Qhnb+QsfWRZ5cI7IYUGZBoC545ZLZgF5+lz8F/6FS6/bqeEnk2gdD+TeqNCYca7J4bQNackBhBL6MqJODp7NrJ7MAll+KSlNlASbeSfgySAsdyutNeptc6a1XsZc/D2UehkEIAzKV/J4+vJt12iBZSQdPaxKX8PcJQrflMXepeTYpRVCJTO6YS7SbgH+K+MO8i6VlCOgfAn/d5yB926Tj5yyei/5J+6CiJMUXM10Gtd+Atb182enOl1U+XqOQ69GjtFVizJPaM7jmzMEFHcdlbvVjOoF5SMFaQT6T6k6ZdTyRuNNn6m3upjmrJK7LoHb/t2IerkX7EtW5bqdhlROJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDbXZkRmNu5/Uv+dQDH6tvOsiX9YV2O/QPFVsNG3sPw=;
 b=QqG00p7jM1EV/D5sVRIEvHh4lgzrcdS6Bn1Z+3MRkfdRDII1YiQuhRGqybWY2jMBsg4sft3oTkWyBNTIf/ldq5738pnp9G6QTVMqWdqEqW1EVijPPyrSSHXvyG/5du3cC0I3tUbNFMyqex25/PIFcu1potcqAGV76Ccfcbic/1g=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM6PR12MB3961.namprd12.prod.outlook.com (2603:10b6:5:1cc::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Tue, 8 Dec 2020 01:36:39 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::5893:e219:4408:ec72%3]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 01:36:39 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/display: add cursor pitch check
Thread-Topic: [PATCH 2/2] drm/amd/display: add cursor pitch check
Thread-Index: AQHWyO9s06o5qPoHW0WIbjM9EO7Oe6nkU5+AgAAOTwCACA/RIA==
Date: Tue, 8 Dec 2020 01:36:39 +0000
Message-ID: <DM5PR12MB4679A4125CA7B11387B58FF5EECD0@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <7UvPE5okTSEaIRnrg3TJcnkyIBhPPRXCCuMa5wwC18@cp3-web-029.plabs.ch>
 <e1f8e29f-138f-9e1d-0ba7-ce10059f87d0@amd.com>
 <CADnq5_NmrL7=BsUZ-CGiA=0e7W83Sf5Dek9iOYCX7ji8aRJmQg@mail.gmail.com>
In-Reply-To: <CADnq5_NmrL7=BsUZ-CGiA=0e7W83Sf5Dek9iOYCX7ji8aRJmQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-08T01:31:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bdc95465-126a-4432-b3ce-0000a277e6c1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-08T01:36:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 26bf8843-2084-4514-bad0-000047b2a923
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a8dd3f7-9b7d-4037-8461-08d89b19b5a9
x-ms-traffictypediagnostic: DM6PR12MB3961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39612B4F33246567C757192CEECD0@DM6PR12MB3961.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xaa3yPe+mMAzufLQsu4qoQDRvH7PPbFazH1/mKcNQ7Y181MA6bU832FNjNpaNnwHCas0Y9crNZcr/HnH70y8OILGxBhwkOgBkTes2P4s8wz1NMMFBLgv/sj8HLn7FBFfJxE5KlOTey7L9sq+qHMd6zDQJ4rx6YkelZXYNjmZvRtATM5JrmenedrZlY0L0wptWeeisIT+yjdJdJBojYo1+8qovw+qrWDcntpr+AdAlRVBxwSD8+q0zudigLiVy1SBMPc4QV8SojBcyhmU+L4988Wj/ZAkKkbyeXYgKHs/OzHhl1NZv82JmrqCm36L+Ko0EI11cKGnBj6dLm7GoGFBPD2S23rnGpmn+Ib8kp1stemkDGs/HcLOBN028QUq+YPVpC6LgutONBbQUVf2cYVgCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(45080400002)(6506007)(53546011)(54906003)(8936002)(8676002)(55016002)(26005)(186003)(110136005)(9686003)(966005)(2906002)(7696005)(478600001)(6636002)(86362001)(64756008)(71200400001)(52536014)(66476007)(66446008)(76116006)(316002)(33656002)(5660300002)(83380400001)(4326008)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xjdaULjRhPrF759PGeljqK3kbGtuLAgc5LSSwCuLa4hmrOEoOQseHbmV8oxK?=
 =?us-ascii?Q?13L3BZCStl6aW0MN45PZ6E6p/6UHQIey+eCAxuEnAYuKEFvk6x+KYGn8VcuR?=
 =?us-ascii?Q?b68dKfMWmdi6hjamSaKp/d92WuAWOwMW1MpSEQX3LLMCxU57iRoVJI1FngF7?=
 =?us-ascii?Q?diCAfSVKjN+irDhp14yutVdoLxrqpGBkKyxVaYNttEL/miy/jogLd0bWdreJ?=
 =?us-ascii?Q?dVgt543WIq7xYaLVn3LwBN7mbe6jlJPhqZsYVvr3v+Pe6QVbfh7LhdiHL640?=
 =?us-ascii?Q?5+DrmdEgo6Tr8SlwC29F4QdxMZGFLCor9q5dL97VvynfPpv7gkg+7l3XcjTL?=
 =?us-ascii?Q?scJVdOn+aWKJrrl28Z15KC4tUecGTQfalhp1S8KOPhZdqt4w15JN/Itv97CW?=
 =?us-ascii?Q?A2JWfltXPgRBGnRpT3VUOqwB8Y4dARlwsFQLDTPLE0pYYKvzts2MMfTxxWg8?=
 =?us-ascii?Q?tbFMxNolEb8MMc+Fd3ro2UvdNQiyTNTGgKB0kvOdIShgbdyrnAdXPVohIhwz?=
 =?us-ascii?Q?paR30aCQlZYcOhu0mP0CrnwU+ejjazURokuFUC7V9DhesgN/h03BzMa7lkO2?=
 =?us-ascii?Q?8rI9/z1xy2afXFa9uk9UgR4NuuN9HxEJfXrswTW8jiJamK1uLCr3uTl11lwR?=
 =?us-ascii?Q?hSmzPgeKayN4+oFkutGLWlLJNGdkq1PcB7ddeyziaz0wL5UihffmnLDR378c?=
 =?us-ascii?Q?dz5PxnBogy4dBZjq/8vczD3E8Be8qB32yQS2oywgqKULuKOPdNhJ/TYXUkUf?=
 =?us-ascii?Q?hqigSO2HyjeXaRSsoOF9G+m4xGkA1eC3peJrZCqFffpv+SIHFnnKxRtrluoh?=
 =?us-ascii?Q?umkd0S8z+Y2vLTZ1na2wzEwPhnQGubNptAkHrhHpQMb0Xv0S4NnwpZ8IKyia?=
 =?us-ascii?Q?MkzSxertQQ9PeZeUrJ+AGJjpQK/1DvxhIJakm4c2VaZYnjiCk6wL2oL0aDgr?=
 =?us-ascii?Q?i70ii8SRJMNjYSrLJ6B7S6WJaTMJOV4oIZfWzja3Wac=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8dd3f7-9b7d-4037-8461-08d89b19b5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 01:36:39.6149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLMN+X28ePJqwbC5Y2muBtGyrsSpmc59xZIVMeu2s8Me4RKNTY7+S1+nbaYXd55PH39l7NCp0XXunPsNkyR+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3961
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Simon Ser <contact@emersion.fr>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Simon,

It looks to me I'm kinda late to the party to look at your questions under https://lists.freedesktop.org/archives/amd-gfx/2020-November/056032.html...

Does the commit below and https://lists.freedesktop.org/archives/amd-gfx/2020-December/057048.html mean the above issue is now on its way to resolution?

Thanks,

Nikola


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, December 2, 2020 5:25 PM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Simon Ser <contact@emersion.fr>; Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/display: add cursor pitch check

On Wed, Dec 2, 2020 at 4:33 PM Kazlauskas, Nicholas <nicholas.kazlauskas@amd.com> wrote:
>
> On 2020-12-02 4:09 p.m., Simon Ser wrote:
> > Replace the width check with a pitch check, which matches DM internals.
> > Add a new check to make sure the pitch (in pixels) matches the width.
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Series is:
>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Applied.  Thanks!

Alex

>
> Regards,
> Nicholas Kazlauskas
>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++----
> >   1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 9e328101187e..862a59703060 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -8988,6 +8988,7 @@ static int dm_update_plane_state(struct dc *dc,
> >       struct amdgpu_crtc *new_acrtc;
> >       bool needs_reset;
> >       int ret = 0;
> > +     unsigned int pitch;
> >
> >
> >       new_plane_crtc = new_plane_state->crtc; @@ -9021,15 +9022,25 
> > @@ static int dm_update_plane_state(struct dc *dc,
> >                               return -EINVAL;
> >                       }
> >
> > -                     switch (new_plane_state->fb->width) {
> > +                     /* Pitch in pixels */
> > +                     pitch = new_plane_state->fb->pitches[0] / 
> > + new_plane_state->fb->format->cpp[0];
> > +
> > +                     if (new_plane_state->fb->width != pitch) {
> > +                             DRM_DEBUG_ATOMIC("Cursor FB width %d doesn't match pitch %d",
> > +                                              new_plane_state->fb->width,
> > +                                              pitch);
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     switch (pitch) {
> >                       case 64:
> >                       case 128:
> >                       case 256:
> > -                             /* FB width is supported by cursor plane */
> > +                             /* FB pitch is supported by cursor 
> > + plane */
> >                               break;
> >                       default:
> > -                             DRM_DEBUG_ATOMIC("Bad cursor FB width %d\n",
> > -                                              new_plane_state->fb->width);
> > +                             DRM_DEBUG_ATOMIC("Bad cursor FB pitch %d px\n",
> > +                                              pitch);
> >                               return -EINVAL;
> >                       }
> >               }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cni
> kola.cornij%40amd.com%7C0837b50ac7d6455eef1b08d897111300%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637425446939520218%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=DVh%2FvXWkMo%2FQiuV3OclCptN1ctSWpJaPR1sND3jXvHc%3D&
> amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnikola.cornij%40amd.com%7C0837b50ac7d6455eef1b08d897111300%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637425446939520218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=DVh%2FvXWkMo%2FQiuV3OclCptN1ctSWpJaPR1sND3jXvHc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
