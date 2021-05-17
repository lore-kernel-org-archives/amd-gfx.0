Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9477CC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C49961185
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C49961185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8646E8E7;
	Mon, 17 May 2021 08:09:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9816E8EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 08:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsdNEuEpdTZ1IYTsiS7jhqbyauz6/7ORMAGcAsrcC9v3FfB6ZEdf8i8x+s5i0ahpvRGGjgwsyodEamPN6NG11dfvhmWdCX71DvQV1K2BLjASpSBDiBKPql9HMn4UWp4VNHrrLNBqVA1x6Bah+G+OGlV3dWp74nUj+EKMpnQFHjgKvOS6/IcUes8VP+MmrIcH6qoZGzR0zWykWQrxv0XCLzXjWrkQZX47/HAT48R0ua4ToJUPaHkIFo/HCLkpUb4SNmK728FA6liA16ZNk4S7j4Hj8NEW8v3+P7g8a3TrY0TZnR0xo7CxAUlGCVzVzRwYpWli1QIOVLueWcIxz9Hf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZFshqFdsIaUyZHAAXUzyGqRuu2Ap5I9aRitHTEL7G0=;
 b=ItqTRfSC0Emo7a4NqSDVV4jBzxnPfF7F28Ef7Qng93qymlFz+P5rkO7iqqBZj+vpFxf/ixDAToH/3+eEz3y4JWVXXhhNmNMboeKGC4HRYH84sMi0IJbK+n+lZ/fdvovexG4/oMAsmIKp31HP0T3OuYCrbPLbJLgD4vV25qdRyEOjy8ZwfSc+S5ivAEGjjBjZzDw/sqtgP5+ea7jXtR7F5zy0qQiB0kbh0gt6r/1MSwYbH6XfAx0iVg5WLyWNUgcrH5iop6LeB7qqplYZyz3eMCCCjELLd1FZaJ5zwGw+VxEAx+vBwh0IQix4/EI+g/7tbxVsURseSMzvuM9RqQLmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZFshqFdsIaUyZHAAXUzyGqRuu2Ap5I9aRitHTEL7G0=;
 b=4J/E5fs9PmxcU0KJV/aZ4Xszyaaefy+lTOJ/tsN+c/qhCuEmo30xJ60Gqu5Io94s0GcI6LX0OGDuB89bKWWtQOTxZya/fouYaXnOFyyMatgX63lxXnocF4Q5rXkc9c34ftpjuAlrQpXhZz9a++47jj4Pq3k45wvvmw1BXWQ//3M=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1632.namprd12.prod.outlook.com (2603:10b6:301:10::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 08:09:15 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 08:09:15 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Topic: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
Thread-Index: AQHXSJn3h1m5Loi44kKsLBABvU+6i6rjBYuAgAQ0pgCAAAnH8A==
Date: Mon, 17 May 2021 08:09:15 +0000
Message-ID: <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
 <20210517062724.GA1853590@hr-amd>
In-Reply-To: <20210517062724.GA1853590@hr-amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-17T08:09:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a56fb383-9045-4472-8828-24a5c96eeab8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e89ac9d-71ee-4f40-6551-08d9190b0feb
x-ms-traffictypediagnostic: MWHPR12MB1632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB163291E4EB466EFE6E6A21B7FD2D9@MWHPR12MB1632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X8XxGvnV5Bab+Cf9X9ePEZ7D+2uDwgRdhEGvMSZB/cpk3runLjIKSRbszHkM9UnlUb88AcxNAgqtXwKg07qQgUUmUeVsaMeAk82Gq1A1BQmzBPpLjI0k6dWp8CEPB7llhZ+iFi7uYjxYtAwmtMHBQGrSJokjvVK74FzkxL/PBNLuhpl+U9lcc7rnobY2kcRJA1Weq0PmSIlD3fo/iAXZk833ZKhjPZNuenQt/42Zfv/dwgd6mPXX1mr+X9H0x+kSkJMVkdiy5tN+fk1TjGbgMvwdXypqeFnXzevWfdD26jZRL2mI4jixQvDGzYPBcCjb69k5rwK1SJ4OSdbq+SWWe3SMKdGYtTfZXj9CLcoeeYWyAgpBDx6+c/N+OwF7qQ6T0h0vPe/mYK4y+t4pf84LnsAm+xMl7b5eKzIcJSy7/2+zynTrCjUDkTuaPkQZ8FUPKjvYwKFfLzjC+i14HH0AF+KIeG9NqSTVCUGTCAe8hLtjGyB4IexviKLSKvPEJYxxyMUIm44dRnbG9mvSv9ZI3kQOipb7LALYR3/VNbcPvSZxcPY7n1Vxe7/Beu4xW2h5b0BwjTe6k3yQmzI8yVmvuchwmZr0q1PNQEq6KOdfTFZwk1quGnV+iICi8JJzOkFfHo+TIgmv0HWpuUjnfnbYgQ+1REx6bVbdQlSDLrg+dpsno7S4uC13nVt5GdKx7laGLG5KY66Lqz1G6bLnASsWE0u6TUNSKcLyADw6znp2eWo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(83380400001)(86362001)(478600001)(38100700002)(33656002)(26005)(122000001)(71200400001)(8676002)(8936002)(966005)(45080400002)(4326008)(7696005)(66446008)(66946007)(76116006)(64756008)(2906002)(66556008)(66476007)(316002)(110136005)(5660300002)(52536014)(186003)(55016002)(53546011)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8HRYiZOzKURbVNFVjeGoME9CmXxWLmwUP4s80RzVbFs8q35wKGB1IWoFpAKK?=
 =?us-ascii?Q?XT20Wib7KKnrbp8DSG/09+776P9Vs9XejhgARlLQ9QMotpykUlYKhbxcITOq?=
 =?us-ascii?Q?+Xd/dFLzgr8rrA/J9uGePgaihprGSPL8whDqIjBxb/WG/HdkZbLyplpJmZxE?=
 =?us-ascii?Q?ORz0TPR11RNfVl0lQbX3EidMwrZiuRwZrhxiQykf9DXea1qjWqPjrChdGwls?=
 =?us-ascii?Q?juzlRQ+u5LwBKMmZml383UyUcIFlw86ZytTqoVk4HF2LDiNSbWrYJEMFcOy0?=
 =?us-ascii?Q?Bwkq2mgSUBiV6py7/Y5wmNOU6Vaprm0lvlAg31m9gRNyMWtpLhrvmtvWgw2m?=
 =?us-ascii?Q?Gqn5dEpUXPpNK8LcqVUN0OjYW4E2FOxXxSmfc296sAAt1bZpxmsCDLQipXoS?=
 =?us-ascii?Q?76eNKBqnXXWPuF2NARoDkvIXSrcO3FvJKr8grOJtiOWK1X13SzgnvjGP8XKE?=
 =?us-ascii?Q?OS6GENye1MTfpj32jVSraZPoIzD46Bexfwa0WNYyz7co37cIPbf1oTFs8BV2?=
 =?us-ascii?Q?Xyrepdx62WFtlCmHP4TB+JwLXDggsb61Md2ajuLwJDoIXuNaoAtwl5ucwLA6?=
 =?us-ascii?Q?H3sdJSycY8/h71WxesaUtKRTW8fbjlMLn9QoUk16AkwJrkposdl+IlfLwxUH?=
 =?us-ascii?Q?GFThMoZKuyHC6dy7Lf+HtJTDROE1QoPFjdjyloFxHDZM44ehwYnw8NfLXxyC?=
 =?us-ascii?Q?dRSoKe6xveUp16K37ktVABcKD5y7/0pZvMnRRERlZRLOIEu2+fWCVmH+CxKQ?=
 =?us-ascii?Q?waMMGLPyKlp3lU17zP75BHwz8/Q8iQjmrYjmr9mLdmmDF2qH+NJQl+MwF8dO?=
 =?us-ascii?Q?uk9qZh4XJ8SijDERVmdIc4Iep8ATUb9v+BqVCirexE5Ohoji/d2nR6QIF6qb?=
 =?us-ascii?Q?udwnZ1qdLhmZhsHyeRCQ5+frNizG0ljQa5twt7+QoNNwRXDK2rWI5y5XDXGz?=
 =?us-ascii?Q?DCFHsIEtgzsUNLVgvJj5GCH8hSdSap0EURKUTULFI/50FGdsIQOXna3R7NeY?=
 =?us-ascii?Q?ZrUuyFcMk9ALXdDePQScTrMALYJru203hQ6j8ZW3xMoyqOmK93+0g6cCFNTb?=
 =?us-ascii?Q?xPw2NWJ1SO0N8ydqNT2BJfRA+1YHdJG1dojMVQOTTF4urUb93EjJ/drcapG1?=
 =?us-ascii?Q?EQTK2daal0eY7td4PeujmsXmHghAR2KV763/xdTKKI0jfea0bGgbG7T2iu6f?=
 =?us-ascii?Q?xbcWF6ZdaugrWeF0LMeppizABZeCVG5gXNloxMsNEVImVBQt83cQc4xYwhiB?=
 =?us-ascii?Q?ZZ2qVRdSFy4GCYjM8XZOsywFXzqQULefKX5AKZB0EWd6tj/b3SpmFqzCJIge?=
 =?us-ascii?Q?aLZkSw6emaU74iKI27Lj6810?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e89ac9d-71ee-4f40-6551-08d9190b0feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 08:09:15.0556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pNZWh5AQ/qylnig9kPsGdRHkiDXeR74i14363EUltedIDIZdK768Z04QK5Rztm4YmKMxv0Gl7spW6bRvoGS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1632
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

Hi Ray and Alex,

I have confirmed it can enable the additional compute queues with this patch:

[   41.823013] This is ring mec 1, pipe 0, queue 0, value 1
[   41.823028] This is ring mec 1, pipe 1, queue 0, value 1
[   41.823042] This is ring mec 1, pipe 2, queue 0, value 1
[   41.823057] This is ring mec 1, pipe 3, queue 0, value 1
[   41.823071] This is ring mec 1, pipe 0, queue 1, value 1
[   41.823086] This is ring mec 1, pipe 1, queue 1, value 1
[   41.823101] This is ring mec 1, pipe 2, queue 1, value 1
[   41.823115] This is ring mec 1, pipe 3, queue 1, value 1

BR,
Changfeng.


-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com> 
Sent: Monday, May 17, 2021 2:27 PM
To: Alex Deucher <alexdeucher@gmail.com>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid compute hang

On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:
> On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com> wrote:
> >
> > From: changzhu <Changfeng.Zhu@amd.com>
> >
> > From: Changfeng <Changfeng.Zhu@amd.com>
> >
> > There is problem with 3DCGCG firmware and it will cause compute test 
> > hang on picasso/raven1. It needs to disable 3DCGCG in driver to 
> > avoid compute hang.
> >
> > Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> > Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> WIth this applied, can we re-enable the additional compute queues?
> 

I think so.

Changfeng, could you please confirm this on all raven series?

Patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

> Alex
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
> >  drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 22608c45f07c..feaa5e4a5538 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -4947,7 +4947,7 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> >         amdgpu_gfx_rlc_enter_safe_mode(adev);
> >
> >         /* Enable 3D CGCG/CGLS */
> > -       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> > +       if (enable) {
> >                 /* write cmd to clear cgcg/cgls ov */
> >                 def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
> >                 /* unset CGCG override */ @@ -4959,8 +4959,12 @@ 
> > static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> >                 /* enable 3Dcgcg FSM(0x0000363f) */
> >                 def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
> >
> > -               data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > -                       RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > +               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> > +                       data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > +                               RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > +               else
> > +                       data = 0x0 << 
> > + RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
> > +
> >                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
> >                         data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
> >                                 RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
> > b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > index 4b660b2d1c22..080e715799d4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void *handle)
> >                         adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                                 AMD_CG_SUPPORT_GFX_MGLS |
> >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> >                                 AMD_CG_SUPPORT_GFX_CGCG |
> >                                 AMD_CG_SUPPORT_GFX_CGLS | @@ -1413,7 
> > +1412,6 @@ static int soc15_common_early_init(void *handle)
> >                                 AMD_CG_SUPPORT_GFX_MGLS |
> >                                 AMD_CG_SUPPORT_GFX_RLC_LS |
> >                                 AMD_CG_SUPPORT_GFX_CP_LS |
> > -                               AMD_CG_SUPPORT_GFX_3D_CGCG |
> >                                 AMD_CG_SUPPORT_GFX_3D_CGLS |
> >                                 AMD_CG_SUPPORT_GFX_CGCG |
> >                                 AMD_CG_SUPPORT_GFX_CGLS |
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%
> > 7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3dd8961fe
> > 4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnknown%7CTWF
> > pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > 6Mn0%3D%7C1000&amp;sdata=lBzswAPBguL0mWFglEk%2Bg2eDCEuhir7JfFjov%2BV
> > 7pSY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
