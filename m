Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D4CC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 10:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F9510E837;
	Tue, 14 Feb 2023 10:03:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1B610E837
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 10:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1SxWFnle+9YZyxPlkzw/yWBTTsVWM7rGwuQjr1JywV9bRvlB5VE8VzGFN5jB5jxN5/8T9BMjrdctu0FFNdJJTfok/aGiUkjx7S6jSOBlw+ZdT6F4eFLMK1yVBL4rTDxFCWW7VYuWDx4vbHj3jQOiHMLD+o6/93LohQD9BdsoztPiZHVZy9oWhHosfP0iB1EKp2kRBU5GjCjQFweXTNqa0gJVc4CeOvWDUE5O1p0cdTl5vsCTToND4MStgIgCXE5AZc/zx2glyVoJlHQsDvmvep7CypKX2MUPrwiMwCi9+DxQF2h7FFwD1yDbP/Y6RVgH5W6CkLoAC3+cfb5QBRXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI+j6DqrrPx6DddSq+C9fpeWMH2ZXL+pimUtBKZcdm0=;
 b=YY/aqpDLiKe+9UgyURszPJtoc+l5kCWEi4O7E1zWnK7VgcPDUwbjsE8rQo9y/f3XapslE4A67voKfFjLxuVtyeMHAjlrwg/DFDE2dnkfWyuOr3/IGCs6rvIG/jBYbv51OgYkVu38m4g5eMA8PL2jnP5pa+exsgD4nRAkgvJ1s8AYVuZxqlBfk+x8XQMLPiKkTdkeqXZvbKMUpxQY1/9yoDf/PqHXogt9olW/hbiUiuCSIA09iadymyfx1n9aaGUEljw0LbdoYJB6Bo9e4/fNMO95W8XUiXFI9QIScSfJgLggh5RVXMNY5Re8yx9y9o/KgYp6bHDYOxAvuonY4kCy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI+j6DqrrPx6DddSq+C9fpeWMH2ZXL+pimUtBKZcdm0=;
 b=nGkYKgUqFqRaScCQ/HxVNb3FJw479GTnd2Uq0Bdj/uQDVer/+Ti2rbxDbsc3BCLE8w80CZCpc4odSwqmk4bniCtOEWc56IEkTtFwa6LdHWDE1Ze7SUozH0ooIuynkmKxCgzO6ZzWL1ZDY0p4WDmB3w9Hh2Z5Ye0bJRIRiWeWj8M=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 10:03:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 10:03:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Thread-Topic: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
 bad page
Thread-Index: AQHZPSwYegeab7zP2kyiDAgwGPEXPq7IRhSQgARI5wCAATKYgIAAdnDQ
Date: Tue, 14 Feb 2023 10:03:26 +0000
Message-ID: <BN9PR12MB52575D55D981DFD2ECCB790BFCA29@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
 <BN9PR12MB525702B9A9FF262B9FA0CF02FCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <DM5PR12MB1770029EB462C56B50984414B0DD9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <BL1PR12MB5334C9F3F4623B4B3E63250F9AA29@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5334C9F3F4623B4B3E63250F9AA29@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=024f425d-59e5-430f-b54c-3a849f1aea78;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-14T02:42:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7900:EE_
x-ms-office365-filtering-correlation-id: 3eb74141-01f3-4a35-b523-08db0e72b6fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1J8TrZdvjvjMun+F43Wqy6yfgoAzlbEjGtZZy9heDeTUIo9a29ihCwY+QAZ60bRpd/xL0M+TuWNv5Navn512h6F3GaKbfZzHACRcw/AuJ+XZlRlkyXsus/0kzbe/6m+NIj6VUMkGKgBszTQR94xOt+f9JDSvj89ah9hSQ4iELZI9J+whQrZbhKPa33f8hui710YT2W2zPVwXqJ72Cv21y1+2Ubvn84bm46wLzlWNWnnOaXtIFW1YSbWADaSMwGxGs9mueGtHTev3/B2dLiI+DucOONH94YgHsfgPQcxHfq4OlR+8QA+neS6rJVEyL2MEvE1+AMo7x2+wmnldDDk9nBoAUVwCWe9Liw8PLzd+85bRj5+6DKywsPQcPwFPr0c2uq21prIvo3HXG4e6n6/zHN1Irpeb1jVfMoeAu2jSo38EXl27SL6IUUeuVr8PN+MJLgroGGYLRXHAkvf6kZESu6Nyq9i8o3jQnsCwGjxT2RPpXgu172ZKR3/Ik7UOg01kEY21ACas1xPZqHYl9iWLA36bCnjIleiI3SOTS2DaZsI/RxHADMu2Jkt4vMYTWoYJHTZUkeF/tbuvDeiDBEZUdPM04eCOhTlOzORO7E17hdon5U929Vsp4TD/r3YgwY8dn09RgNv5gltmwjrRx+SE7NYScF6ohHJBnra+rs6y9NLME/Awz9mY/l8YsrdciFpw9LbfghiTjzqBWU0sa96oAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199018)(5660300002)(55016003)(83380400001)(26005)(186003)(38070700005)(2906002)(6506007)(86362001)(110136005)(53546011)(478600001)(52536014)(41300700001)(33656002)(7696005)(71200400001)(8936002)(122000001)(9686003)(6636002)(316002)(66476007)(66556008)(66446008)(64756008)(38100700002)(76116006)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QkzxeEDStq0uh+GlUrtbsVa0tK8TsOt+98E5gzkhmqd2R15Z9eI29/1fH13D?=
 =?us-ascii?Q?N6uOPuZP4fvtCwugm7qfCg5ftutXPx+a3ulLTySBaks/0+oHZN98ln8CYlYE?=
 =?us-ascii?Q?cMl1UQrX/4WJHY6lFczq67t5AIxxm8hZXHSx2zGZk7UuifCOC2dnN79w5yXG?=
 =?us-ascii?Q?ylVyOT3ELuo6b5cqnuw4G0KZdVTPKQnR9c3ntk3bD0m81Vj59CWW26CXjmRf?=
 =?us-ascii?Q?3CsjDxDMCwnnCF5ejJsj5A9mcQfVGMCyUQhJd4HXtgdS0R+uf0qbTsSjdfWo?=
 =?us-ascii?Q?N6zHFhMHXjnv3kJgF1sIBKaJjvS1ZCrXl92gHrOFitHailZHCDRsfHO51YEE?=
 =?us-ascii?Q?fOqlaCciG0y62RESDDwNiNF6dTVNuZgprzvrrP95KLztkdBDazsub1Nwiu+7?=
 =?us-ascii?Q?QnhBWKzps9foWAkvSeurqUlfasIsKLv+dn3Xol9C/enCkYKwiA30Ukrpjn0R?=
 =?us-ascii?Q?dp4yBIU/4F7TisZjs1JL/lFpcvTc4rkL/vffJLAA/V2rC/Es+MTvGK+UsqZU?=
 =?us-ascii?Q?gKPDpq5jCrjDIJZcz7F473ni9z49Q1l2SWvtNlDKZ2n5v3JwETsPstaIrTec?=
 =?us-ascii?Q?vkqZI0TkBfqiufjzvvw088fIvlB3YF5yAvswoodrCve+yXsYgwCX/Avvko4P?=
 =?us-ascii?Q?a16ibRWluiQEhwlGcLZoek2gC15wmVqXaQWM/drx7dug0BPdbhEQ+rGMAFDu?=
 =?us-ascii?Q?mULrCW2/3SxnoVqFw4yR/fA4W58VfyInOcbtaI62c0GgZkuCn7j5L45tJuPJ?=
 =?us-ascii?Q?KiwvhD+ietrGIxGQ4VHflyBEp8AT1QcO/N7qlGQjW2zxGUNGejxaNFP5q7UZ?=
 =?us-ascii?Q?yU9ec7vtZqxRsxA1Kw72EtDRaxl//viOkSSv9v/XO0//96S/cj20bffXFl9n?=
 =?us-ascii?Q?RE/pINzcUEQsSyowmS070s9AV2joewVZmP1/mrNZm0RUxQtSEHhlCuEM4Y1C?=
 =?us-ascii?Q?ozu3198LzSZ+Q0iwFCcBjXhP8mhr2+a9J5sHD8NSJU8I1UfsuYN+tSbvOzDT?=
 =?us-ascii?Q?VWSrVFohb7iYHHBGzP2YxFBlsv2RNZFT2dlGlQgDJr+xhnSygx/N7O/FBSXq?=
 =?us-ascii?Q?my7W/x+Lg4PotBzrWjTfULfBZecCNzH7B3dMq80ghcwGqe6o7sraefkFdejm?=
 =?us-ascii?Q?+8/LlT1vRag2ON88a7+fxW/wHvpKuW6l8lhk40Z9xOX81asK0fPbfNYfVaJb?=
 =?us-ascii?Q?6E97gcCLeOTTELNOVZdmuoufTxbPKbYNP2nbi5oIr5QuJ07Wjg0C9BsL3rj6?=
 =?us-ascii?Q?PuX+WR4ka4Uxap6rCHC3WlFzRHvDqPjyANWQpNjIIUuV6Nk/3Z9DnRLKfBCj?=
 =?us-ascii?Q?DeHN1M1KUu8Zy9D01IPRGLg3W1UYsqTPy2vBOhA9HDs3ZyF/pnbxNzwQUzOa?=
 =?us-ascii?Q?UG/8i6ub5b26X++UR8EVc7FUzaYrbWVgAjc+BlTTRMVe3NjCOP6SNuYIuPAB?=
 =?us-ascii?Q?lbei7BoEDM/N56QvraCw++fHJAAYnwSXlR/MVj/2D4hj7mZLwZePSRvaE337?=
 =?us-ascii?Q?125TjnEPMIUWbtUwShiEMWVcBOS+pjY3u2QAalznV/uuF59MXQrz/rbKSD//?=
 =?us-ascii?Q?/dKr9i+Lrpn/nV2x2tYZgauMzVoqlTjzAodPX6EP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb74141-01f3-4a35-b523-08db0e72b6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 10:03:26.1820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNW2S9b8uBIHFqEeu/I0LsvvzE4D4aKqx+of+YzjPZsPH+7kTkSSoNlh0htPkvE/4HMoeV9QvBX4mzVtY7gO8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-EINVAL looks better than EEXIST, but it still doesn't fit the case? Altern=
atively, Can we compare the count before and after amdgpu_ras_add_bad_pages=
 to decide whether reset ue_count to 0 or not. That could be straightforwar=
d than struggling for returning which error code in this specific case.

Regards,
Hawking

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Tuesday, February 14, 2023 10:42
To: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 amd-gfx@lists.freedesktop.org; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Can=
dice <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new =
bad page

[AMD Official Use Only - General]



> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Monday, February 13, 2023 4:25 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no
> new bad page
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Sent: Friday, February 10, 2023 11:02 PM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org;
> > Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> > <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if
> > no new bad page
> >
> > [AMD Official Use Only - General]
> >
> > +                       /* if no new bad page is found, no need to
> > + increase ue count
> */
> > +                       if (ret =3D=3D -EEXIST)
> > +                               err_data->ue_count =3D 0;
> >
> > Returning EEXIST in such case is not reasonable. Might consider
> > return a bool for
> > amdgpu_ras_add_bad_pages: true means it does add some new bad page;
> > false means it doesn't change anything.
> >
> > Regards,
> > Hawking
>
> [Tao] but it can returns -ENOMEM, amdgpu_ras_load_bad_pages and
> amdgpu_ras_recovery_init also need to check the return value. I'd like
> to keep the type of return value unchanged.
> How about -EINVAL?

Stanley: How about return -EALREADY?

Regards,
Stanley
>
> >
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Friday, February 10, 2023 16:45
> > To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>;
> Chai,
> > Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no
> new
> > bad page
> >
> > If a UMC bad page is reserved but not freed by an application, the
> > application may trigger uncorrectable error repeatly by accessing the p=
age.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index e85c4689ce2c..eafe01a24349 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct
> > amdgpu_device *adev,  {
> >         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> >         struct ras_err_handler_data *data;
> > -       int ret =3D 0;
> > +       int ret =3D 0, old_cnt;
> >         uint32_t i;
> >
> >         if (!con || !con->eh_data || !bps || pages <=3D 0) @@ -2060,6
> > +2060,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> *adev,
> >         if (!data)
> >                 goto out;
> >
> > +       old_cnt =3D data->count;
> > +
> >         for (i =3D 0; i < pages; i++) {
> >                 if (amdgpu_ras_check_bad_page_unlock(con,
> >                         bps[i].retired_page <<
> > AMDGPU_GPU_PAGE_SHIFT)) @@ -2079,6
> > +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> *adev,
> >                 data->count++;
> >                 data->space_left--;
> >         }
> > +
> > +       /* all pages have been reserved before, no new bad page */
> > +       if (old_cnt =3D=3D data->count)
> > +               ret =3D -EEXIST;
> > +
> >  out:
> >         mutex_unlock(&con->recovery_lock);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > index 1c7fcb4f2380..772c431e4065 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > @@ -145,8 +145,12 @@ static int
> amdgpu_umc_do_page_retirement(struct
> > amdgpu_device *adev,
> >
> >                 if ((amdgpu_bad_page_threshold !=3D 0) &&
> >                         err_data->err_addr_cnt) {
> > -                       amdgpu_ras_add_bad_pages(adev, err_data->err_ad=
dr,
> > +                       ret =3D amdgpu_ras_add_bad_pages(adev,
> > + err_data->err_addr,
> >
> > err_data->err_addr_cnt);
> > +                       /* if no new bad page is found, no need to
> > + increase ue count
> */
> > +                       if (ret =3D=3D -EEXIST)
> > +                               err_data->ue_count =3D 0;
> > +
> >                         amdgpu_ras_save_bad_pages(adev);
> >
> >                         amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> > >eeprom_control.ras_num_recs);
> > --
> > 2.35.1
> >
>
