Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26743C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C813261364
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 02:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C813261364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B846E15C;
	Wed, 19 May 2021 02:28:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4FC6E15C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 02:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCCIhR9Nw7q4Qg8zdVXd7jE20bXmLA70cpS9frGYyaLCiqLmBa5timuM1vW+wvKyKrb/cscCT426cmFeyMhueloHz+TP0IxN58F5Uy4iZ8D7WWa16Gz6GfmocsTfQM1odZKGWFuY+Z8lhyAPLLw67oVfAfSa9INbVfEiXA8+IrkYxFm960ZSKXzzpzzSo1T94fmcwAierytl0jHKpNOjx9tGxciRTC2uGwFlVQm1L4cDEs8qx1trcdzsZZADbgqVhizx7oMEZvNGSSOyT75QIplHTT0o0CQcfUgzFLKMdqlaYZngqaZf7ASuElrMpxhUF5QGeHV5TvlT1PKA+/YChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ad3yf2aQuTmgrk5xFUPyQgZCRnB5J0aHOfhDjEp9ic=;
 b=acEL9jZHXK86tp652EV7/1iPbKKlgnpV+XdCjjnstQjiyHdaRVyeeiLWV6HX67EizNatrMlXiVXccBOIdcRTUM1I04wGN9jY/z9JwhyMxE7AlttcSDi5pLa0Tabmg/NvZK/4x3Ye83STHmrIkfMME5cq7hFkLJoTHzSu4XHpm3hcvF1KynEikpXjBJEsF7m34G0AHYqrubwyKWcta/oGwhwcLRDV/cwfbFW3Kr2BDqd0+NaRdZbNZFZnna7L80bx9rKrMEhTiL9/f1UASJPC6L0g6idrhcVSJyiUJqW1PmghmZhh1CnmoAvnLDrCNNvvFb03X/2K9iU5QLJFgQASzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ad3yf2aQuTmgrk5xFUPyQgZCRnB5J0aHOfhDjEp9ic=;
 b=gU7IK4OVYgQJP4Hqvxx23a0NJDSJfHOu2YYyB11udOTdjlJfA6o/MOWSL0kW6hOS+ft8ccd8N33gVVu+P7HnOkIH/nEpQUb1Ek+VolC2BolOqBzJw9KS3MfMETB9i5CxHMByx71GB0UbN2LSsiTC1WLCceMYslnr/3gNwvIcDVM=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR1201MB2527.namprd12.prod.outlook.com (2603:10b6:300:df::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 02:28:37 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 02:28:37 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Topic: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Index: AQHXSJn3h1m5Loi44kKsLBABvU+6i6rjBYuAgAQ0pgCAAAnH8IAC1bgAgAABwPA=
Date: Wed, 19 May 2021 02:28:37 +0000
Message-ID: <MW2PR12MB46840D259987CA9265317F75FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
 <20210517062724.GA1853590@hr-amd>
 <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <CADnq5_OmpYjzaeGPUC4rUNkSo_CP+8zFfZQsF6d+2fLegtxUkQ@mail.gmail.com>
In-Reply-To: <CADnq5_OmpYjzaeGPUC4rUNkSo_CP+8zFfZQsF6d+2fLegtxUkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-19T02:28:30Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=efbab160-17ac-458f-b25b-7ae27c3177db;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9fed765-5a3b-4215-ac25-08d91a6dcef9
x-ms-traffictypediagnostic: MWHPR1201MB2527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB2527CDA6660D484034C36117FD2B9@MWHPR1201MB2527.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jq6CX7L5+jn3nidngyS0H7EZsTuI0W9BwOUZHnnXgoeGB9LRdrRQlk2AB2wFg2tNmp3Ft1h/8w3U4GsuilfzxfVHBqu9dPC70maCrzSO9hmXHNcbsaQUiWKWiS/AnC3rPJexFsqRKg2X30DhIlgJXamd5+pcHCfQvcJKkibjR7T09J6KzvEVNxmB+qbxlrvqhb/C7S9OwiRyKmD6JzZzshPNqWB0VGp17XpRqH6O3skWfxv6S3uy6+kU3Oqxi4fJSZbg+1czEmQbtbf0WNYmqW7Gk46nsH3P210wHkn9faXmcD2IhbyMncfJtH//fH0I4OSLt0PIBolTBkLSbQVlFaDI+G43h103rjLTZwpJIdw5VbVaYdeN1OsC4y/5CKXcyCx5eQ8jxiMc+WEoLv9MMUefYRmVZ95DBOt2x7LYNG8EOl06jYwR5PdrFaQGdkhSeLTblpIFci6w3HMTJoYzyWNpvCPIKnUeQ5wKB8lOoxTydJ5rLK1JsWIMZTCj749OM5OH7G5eJhgvNV2K0Kjk3GMdY4HqpZcPWrDrBVxX9cMJ281C5oV20m69O5eEanJUsl2vI9S8p8dkeIc55BQLAuX1BIKK5gw/NU0v+00Xt+fzpqXfV//auvWAn5Wshb+0hkb8QADSt8OA+Z1M73zjTvcBUEsdtja96apTUEDUr3IQLZ5xID6tbvwmxthTaJ9W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(71200400001)(53546011)(316002)(8936002)(478600001)(4326008)(6506007)(54906003)(966005)(7696005)(86362001)(33656002)(76116006)(66556008)(186003)(66476007)(64756008)(8676002)(66446008)(45080400002)(5660300002)(26005)(52536014)(66946007)(2906002)(122000001)(38100700002)(6916009)(9686003)(55016002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+ZDdeYGnRzXfC7tkoTaMfo46UeYqBC8czNucll+cm6ceEPFnnCJCqWz6iV9J?=
 =?us-ascii?Q?MdDhP1Iid2RCETMPMnY+gZuzvaK6ZOWPlqahrspo3TFKdWSTwJbW15F/Pijr?=
 =?us-ascii?Q?5juGKtGguy69jCxhN9WqrVESu8H/I+JxFLfoYuQZIJERqv/vSM8Vls8+dsgH?=
 =?us-ascii?Q?dV+kX1jM1NMtKZFfWfFqH9QPl2z7xnN/Ji4C48yjcWzP/AT6vvbfdEWvJCsT?=
 =?us-ascii?Q?xafnQ1roXi9a3jZeGxd4V8tOHavSWqRRnsZSdqpwXVb5KQDKikSt0nUmnpQt?=
 =?us-ascii?Q?kQsRY6TnR8apkH2bywHYnZPLOBNMk4NRxgGENekfqFN11/VY786A8LNf5j/P?=
 =?us-ascii?Q?msSBnCGos4heISNaaavnlGMwebt5Os+cvneEyT1+bBqcPFmv7gwXU6dSS0Np?=
 =?us-ascii?Q?1p6dFpj/Ve56+B7DKFTLsH3k1Nmd1M7InDXK5acFKMn/qi4bkU20nPx/+7mk?=
 =?us-ascii?Q?1xc3loync65j7CGQF+5Ykbu6+neMbpsoEl5BeSNzFx3qCHIcgHMi9pX6jaru?=
 =?us-ascii?Q?1HGoYKQjR1l1QH54tQrqep9ERx7Ii1yKaHZCeP1RZMpJX6nLCfdF1kAg2TJj?=
 =?us-ascii?Q?hYG6xv8I6qmjmlFAFLbDKlFKDXQ2+KeU2mNwVQ7NQZqh4RCm2tiEfDGgVyhp?=
 =?us-ascii?Q?sS+ysPJuzCqIbIpv1n60k9EK/dCJBmD8JI3k9uO5e+pv1fSOX/r3xvYpux6l?=
 =?us-ascii?Q?MvSDvF/wsoZtuIb+ebGc6Hm7oQ/jW6DVLahrHBZx3fb6poaCLK8cA0ISRUS/?=
 =?us-ascii?Q?jlyYD8RmthVn0uskeHGF7jazSOdmaDQPrKY1myAcphV2qPGgDTnEaKlvLE2Y?=
 =?us-ascii?Q?8tim8oYRr/ArPTqxPIvAqxpNWEoe/1AYcZgZkryKNnDAJsTa01mEgBNd+X5V?=
 =?us-ascii?Q?QpqzH0YIWyC0V53+HxpCUXH+nR89gXz1SDuYulxKQutkVhhdIV+qCnQHRCx3?=
 =?us-ascii?Q?uLKsrLRxL/rjSkEUeyNdvrnwBvTtten0MgWWwgtkZfSmOzSVOO3JxoU1tPjE?=
 =?us-ascii?Q?wTl1dtw4FP3+K2Tk1r3hOfIfpns+5KWz4taQ6/QREKqSzlEZG+MClRiXGS8e?=
 =?us-ascii?Q?ed+r/XvEjuM5HY3vd+yMPmdBxZcspeoSMXHabPzzReJNLYlQL6L4ya0YyeTF?=
 =?us-ascii?Q?p2DCoj8zd34B5dACs2l4JZ2FcF1IUOOtiKcX0EhQ7duMWcCm/MApJUBjChnd?=
 =?us-ascii?Q?ZOou2JhJwSxS4/lyNPjIsUF8TCd5Vn3iyjEQd+suoafZ+pPZqWGdHDCZR9dE?=
 =?us-ascii?Q?rgI1qmpzdeC4dfdTWBfpslkpyprgXOCTAgg5SricJDgPXjrrpIPkPYKC4Jaf?=
 =?us-ascii?Q?xnEyZBx8tkkymwoinsIqaLih?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fed765-5a3b-4215-ac25-08d91a6dcef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 02:28:37.3703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzLuZFyHqhTjNgdA6j5ZgD5g2bAh9ovWaBblZ4MoIirjRXxrV15I++fl2kFH1qbBehgQfLQYUtsbS355ipNMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2527
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex.

I have submitted the patch: drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid compute hang

Do you mean we have something else to do for re-enabling the extra compute queues?

BR,
Changfeng.

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Wednesday, May 19, 2021 10:20 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid compute hang

Care to submit a patch to re-enable the extra compute queues?

Alex

On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng <Changfeng.Zhu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Ray and Alex,
>
> I have confirmed it can enable the additional compute queues with this patch:
>
> [   41.823013] This is ring mec 1, pipe 0, queue 0, value 1
> [   41.823028] This is ring mec 1, pipe 1, queue 0, value 1
> [   41.823042] This is ring mec 1, pipe 2, queue 0, value 1
> [   41.823057] This is ring mec 1, pipe 3, queue 0, value 1
> [   41.823071] This is ring mec 1, pipe 0, queue 1, value 1
> [   41.823086] This is ring mec 1, pipe 1, queue 1, value 1
> [   41.823101] This is ring mec 1, pipe 2, queue 1, value 1
> [   41.823115] This is ring mec 1, pipe 3, queue 1, value 1
>
> BR,
> Changfeng.
>
>
> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, May 17, 2021 2:27 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Zhu, Changfeng 
> <Changfeng.Zhu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to 
> avoid compute hang
>
> On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:
> > On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com> wrote:
> > >
> > > From: changzhu <Changfeng.Zhu@amd.com>
> > >
> > > From: Changfeng <Changfeng.Zhu@amd.com>
> > >
> > > There is problem with 3DCGCG firmware and it will cause compute 
> > > test hang on picasso/raven1. It needs to disable 3DCGCG in driver 
> > > to avoid compute hang.
> > >
> > > Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> > > Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > WIth this applied, can we re-enable the additional compute queues?
> >
>
> I think so.
>
> Changfeng, could you please confirm this on all raven series?
>
> Patch is Reviewed-by: Huang Rui <ray.huang@amd.com>
>
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
> > >  drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > index 22608c45f07c..feaa5e4a5538 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> > >         amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >
> > >         /* Enable 3D CGCG/CGLS */
> > > -       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> > > +       if (enable) {
> > >                 /* write cmd to clear cgcg/cgls ov */
> > >                 def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
> > >                 /* unset CGCG override */ @@ -4959,8 +4959,12 @@ 
> > > static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> > >                 /* enable 3Dcgcg FSM(0x0000363f) */
> > >                 def = RREG32_SOC15(GC, 0, 
> > > mmRLC_CGCG_CGLS_CTRL_3D);
> > >
> > > -               data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > > -                       RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > +               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> > > +                       data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > > +                               RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > +               else
> > > +                       data = 0x0 << 
> > > + RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
> > > +
> > >                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
> > >                         data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
> > >                                 
> > > RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > index 4b660b2d1c22..080e715799d4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void *handle)
> > >                         adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> > >                                 AMD_CG_SUPPORT_GFX_MGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_CGLS | @@ 
> > > -1413,7
> > > +1412,6 @@ static int soc15_common_early_init(void *handle)
> > >                                 AMD_CG_SUPPORT_GFX_MGLS |
> > >                                 AMD_CG_SUPPORT_GFX_RLC_LS |
> > >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> > >                                 AMD_CG_SUPPORT_GFX_CGCG |
> > >                                 AMD_CG_SUPPORT_GFX_CGLS |
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > li 
> > > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C0
> > > 1% 
> > > 7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3dd8961
> > > fe 
> > > 4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnknown%7CT
> > > WF 
> > > pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> > > CI 
> > > 6Mn0%3D%7C1000&amp;sdata=lBzswAPBguL0mWFglEk%2Bg2eDCEuhir7JfFjov%2
> > > BV
> > > 7pSY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
