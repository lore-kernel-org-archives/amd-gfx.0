Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E0C64E7B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 17:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1B620789
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OcdeT4ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1B620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11BA6E5C6;
	Mon, 30 Nov 2020 17:22:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928116E5C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 17:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMyori5pKfgUmzueYLA58nrrwTq8SnOmxkGmaB2TRCyOAZ7H4pm/DNaPWWBAydX3G9K+5Y1L8lFORbtAU3GLUiAHzZQowPyBANvtoBaj+CdaNMfGjGn8g6DSUWbMN9eZ/rxP0BDuFJQFiJjBmrfVDbvvFnADU2mIFuwVKXQ4sxZiJWZe5PDquIq+0hXjxJSuaml21/mJuT7Dl0frYojjNqeAygIYYHOV479gJHbwv1dt5QjwnH77Rg7VToisZmDeNH6zHBYzMSAODVj7lADZEbQo8oU2Q+7lOik7lWvbVf5m8PR2Ar72ZeTDHae10diXIWqW8dYvfPq4O8N0qLuoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMCxw+FrVWtj5c6odDyJcGlrzGUeRAFt+T0S46TTQ0Q=;
 b=WUgeB+6m63ub56IyJmd6Mo5RLyH4WlvM+xkLTSnjoPOtSjuq4MpyHWBNWCiJ8B7x3SIv1n1Ht+XA7YdOMldZ6+rzNOJmToQ3Pu6OvwOCrrMMBu31upJFIagvDTlW9tkjfaxHstwP+BvQAopXd/QP0j3FOuyTtFdqfscKOpbQvdrH47XrPSM2YP6Dxg7BwS7YZh9uT0s310pWsvpdZLh1GsHNGn8uAnFbQSVi8/RLoXtmpjuZEt/TXtIJ/K4xgUFQnmwJPOcAHhd0ZxxTbYgh9KXqY45tvE+HAzLljp4M9c2UV34FxIeFyEo2jZwGAuahJxWUT+f0G3z9AaMa70FzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMCxw+FrVWtj5c6odDyJcGlrzGUeRAFt+T0S46TTQ0Q=;
 b=OcdeT4kuY8suMvBcocJc1SiafxPZg5psVUISP6A5ovGL3lnE3gtzYZQuKcNkvF+f8XUdI9oSxAIHOUEKCAYgsmr3YEpS1M0JrSno10YT2Arqh9Omz2Y08sBsGXTo7H63SlevtzRQGGbR8ioI2ImKXqLGcDRUItpED78aOwgSwcM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 17:22:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 17:22:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Bas Nieuwenhuizen
 <bas@basnieuwenhuizen.nl>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
Thread-Topic: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
Thread-Index: AQHWoqSec5nJ1KQjIUC8hFaEyC9WcamYujGAgEXQZACAAHELAIACOQiT
Date: Mon, 30 Nov 2020 17:22:05 +0000
Message-ID: <MN2PR12MB4488508A68085217363A0F64F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201015033557.3046-1-Jack.Gui@amd.com>
 <ccd27274-44e1-3bfc-24a8-e24750889efe@amd.com>
 <CAP+8YyF59Hnq=NgVbfV__GqMZ8y+HyNYRqoPo3hOBDUj1+CtZA@mail.gmail.com>,
 <CY4PR12MB1287D8AA91368C4BCA99E47BF1F60@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287D8AA91368C4BCA99E47BF1F60@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-30T17:22:04.902Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1382cb44-cd4f-4b44-9556-08d8955475b1
x-ms-traffictypediagnostic: MN2PR12MB4424:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44244FBB0DC63F3830474AEAF7F50@MN2PR12MB4424.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7TEY5TG5XbwCRjiM8HWo/wDGM61Gatz3gqP+doHWlf7lPGtJdWSDCMRPTSyXPA4jIzWhOrnfXoyt8IbHaF0fs0645dIcWsCSmQTppTGu6Rl+HM9nA5AyGJkVkE793AxNUn+IZIqjMkY55NGHN2/nJKe68gTJT+xGZTyM2LBGSJYsDfLpZmd1u2oOopLtxGoWgVcOatK82J0DF8Pip07oa4aJOg8ONHnIPATaJ3rXFNsUW54MHUSdy8xcD3/e5xAQAoCEQE9c4I5onBUfV3fTU83Luq1ENtU2XYQDi1GkM64XbREFW2sZDVqzW8e/9gnfoB/4+dGNNGb2ehfsMyy+JlmQTTNeWKcCiSNToW+SuMkKzz4fmMMP80WU4LkRnaTWG2UKJsDsEaXVL5kN2ij1L0iu06ssEWiN1hCeLb+yoMxEWu/ifrc1cbSYrbVTKC0IgmTLBiRbh6sPthZEvIf5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(26005)(52536014)(71200400001)(8676002)(166002)(64756008)(5660300002)(66446008)(86362001)(83380400001)(186003)(110136005)(19627405001)(54906003)(66946007)(316002)(66476007)(6636002)(66556008)(2906002)(966005)(7696005)(4326008)(33656002)(8936002)(478600001)(6506007)(53546011)(9686003)(55016002)(4001150100001)(76116006)(45080400002)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rYS38CxAjzWAIBs+PpbNeHdxSPtM6Zlht7LbVNbEjISPnxECPL739/MKlupj?=
 =?us-ascii?Q?qRpjDrkwrosyXENcPOeKc8tXNWVBfu+kP+aKsHQSQ793zCHmARe49BIaEp4E?=
 =?us-ascii?Q?5phmBk0tukuiRjKSU+bAGC/cqZAIi5NXc6u1uSH3/qmcHuJUdW1bJaASD/0Q?=
 =?us-ascii?Q?YDVX0rbcgKV2aNyohtpIY0hpBIAWzSMlBTvduGeWSOMhsVCJ5a8ZvPbOy/kK?=
 =?us-ascii?Q?J4a4dL62MgqXjfxivDhNO+2WuWBwlWLc6tR7/YYD7X8eFWi41ZXjbgsUnVsI?=
 =?us-ascii?Q?hIZai/7pDHYuDCdtcOKNsLA5WmZRZqC+aYc5qiRKsgY/0T/iNYNBDJVfUywZ?=
 =?us-ascii?Q?zqKGi5wpmM/GOSja9lYFT4Y+uOYWt4K7jhZGojZzMgq9wu7xi+khJAk28INY?=
 =?us-ascii?Q?B9JGDUqDzDDECE1WZ6S+VCvPNkJN6tp4UV6hPhLXB7ONltABV2XCp9923OeC?=
 =?us-ascii?Q?RVWHsMJk60C7gp80n+mxJqLNsuZNmZPZxOZZB8WEB6F4jb4c/je0TlN8mPUd?=
 =?us-ascii?Q?llPpxOWl+DAqvb744My2rODeO/xI7acInQvtla75Ds/1AgzXckBxvoIdCQOk?=
 =?us-ascii?Q?cA+Fxn3+Nz1kE5gqikqOozkomVndYe9s8R/g0o5ERxJMtgDjYMfIEwq0xZlT?=
 =?us-ascii?Q?zYJeOYjoArrYlRfZXyaeL0jAH2rrDFTtK9dbOWKAzhGBSqz8FGVR85u8z2Ui?=
 =?us-ascii?Q?/4AewWEnHj1V8m1EEn138JZVy+YJEf7YAJ/PWeg7Bn1Uj7TEDUIMpE6bDGO9?=
 =?us-ascii?Q?FLCHubygQq/ObNgzwm3B3KXYmBS2ssrogfmsmjI1fGCIiCI7DrozIDv7PeYM?=
 =?us-ascii?Q?6CXAoLywq6YLfA8Q2GfIkrnyxhv0XBrnPCaRTekNfdWwMI0/A0n1fkn7VTfs?=
 =?us-ascii?Q?6YvfIXj4gOfp/yWE3jG7qzdwEziEN9C06AcHnC44itdfpnnrnHMKYTWRrd7i?=
 =?us-ascii?Q?lfoMLSFsbBsPoI5OLg2Sq4yaCK9gKGFDIP1HNJYP/W0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1382cb44-cd4f-4b44-9556-08d8955475b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 17:22:05.5696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avbHc0vCGrkpJ98Mf2mLOf75qhAAFA2w5IzWSl9RPfKf5R/WSmrZOtQ34IBUj6W87NsVuf5lvqp42G4uKPLq2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Gui,
 Jack" <Jack.Gui@amd.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1951090374=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1951090374==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488508A68085217363A0F64F7F50MN2PR12MB4488namp_"

--_000_MN2PR12MB4488508A68085217363A0F64F7F50MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

We need to figure out what the root cause is then.  If we can't figure it o=
ut soon, we should revert the change for navi1x and continue to debug it un=
til we can find the root cause and we can safely re-enable it.

Alex
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Sunday, November 29, 2020 2:22 AM
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>; Kuehling, Felix <Felix.Kue=
hling@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx m=
ailing list <amd-gfx@lists.freedesktop.org>; Huang, Ray <Ray.Huang@amd.com>=
; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: RE: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to=
 1 for some dGPUs

[AMD Public Use]

Hi Bas Nieuwenhuizen,

I don't think direct revert is one right approach, though it's able to fix =
your problem.  noretry=3D0 will cause other test failure on several ASICs.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bas Nieu=
wenhuizen
Sent: Sunday, November 29, 2020 8:38 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Zhou1=
, Tao <Tao.Zhou1@amd.com>; amd-gfx mailing list <amd-gfx@lists.freedesktop.=
org>; Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to=
 1 for some dGPUs

Can we revert this patch to fix
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1374&amp;data=3D04%7C01%7Cguchun=
.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
Jxa2V1TuszoBKtF%2FPbIA3YwOrXHgLreBY%2FXej1HTZ4k%3D&amp;reserved=3D0 ?

On Thu, Oct 15, 2020 at 4:30 PM Felix Kuehling <felix.kuehling@amd.com> wro=
te:
>
> Am 2020-10-14 um 11:35 p.m. schrieb Chengming Gui:
> > noretry =3D 0 cause some dGPU's kfd page fault tests fail, so set
> > noretry to 1 for these special ASICs:
> > vega20/navi10/navi14/ARCTURUS
> >
> > v2: merge raven and default case due to the same setting
> > v3: remove ARCTURUS
> >
> > Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
> > Change-Id: I3be70f463a49b0cd5c56456431d6c2cb98b13872
>
> Acked-by: Felix Kuhling <Felix.Kuehling@amd.com>
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 23
> > +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index 36604d751d62..f26eb4e54b12 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -425,20 +425,27 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device =
*adev)
> >       struct amdgpu_gmc *gmc =3D &adev->gmc;
> >
> >       switch (adev->asic_type) {
> > -     case CHIP_RAVEN:
> > -             /* Raven currently has issues with noretry
> > -              * regardless of what we decide for other
> > -              * asics, we should leave raven with
> > -              * noretry =3D 0 until we root cause the
> > -              * issues.
> > +     case CHIP_VEGA20:
> > +     case CHIP_NAVI10:
> > +     case CHIP_NAVI14:
> > +             /*
> > +              * noretry =3D 0 will cause kfd page fault tests fail
> > +              * for some ASICs, so set default to 1 for these ASICs.
> >                */
> >               if (amdgpu_noretry =3D=3D -1)
> > -                     gmc->noretry =3D 0;
> > +                     gmc->noretry =3D 1;
> >               else
> >                       gmc->noretry =3D amdgpu_noretry;
> >               break;
> > +     case CHIP_RAVEN:
> >       default:
> > -             /* default this to 0 for now, but we may want
> > +             /* Raven currently has issues with noretry
> > +              * regardless of what we decide for other
> > +              * asics, we should leave raven with
> > +              * noretry =3D 0 until we root cause the
> > +              * issues.
> > +              *
> > +              * default this to 0 for now, but we may want
> >                * to change this in the future for certain
> >                * GPUs as it can increase performance in
> >                * certain cases.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cgu
> chun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=3DVFqegGwPCj10q3Y5BdZsVq2a%2B4Tb358mYVDaNkA9zLU%3D&amp;
> reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DVF=
qegGwPCj10q3Y5BdZsVq2a%2B4Tb358mYVDaNkA9zLU%3D&amp;reserved=3D0

--_000_MN2PR12MB4488508A68085217363A0F64F7F50MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
We need to figure out what the root cause is then.&nbsp; If we can't figure=
 it out soon, we should revert the change for navi1x and continue to debug =
it until we can find the root cause and we can safely re-enable it.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Sunday, November 29, 2020 2:22 AM<br>
<b>To:</b> Bas Nieuwenhuizen &lt;bas@basnieuwenhuizen.nl&gt;; Kuehling, Fel=
ix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Cc:</b> Gui, Jack &lt;Jack.Gui@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd=
.com&gt;; amd-gfx mailing list &lt;amd-gfx@lists.freedesktop.org&gt;; Huang=
, Ray &lt;Ray.Huang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@a=
md.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v3] drm/amd/amdgpu: set the default value of nor=
etry to 1 for some dGPUs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Hi Bas Nieuwenhuizen,<br>
<br>
I don't think direct revert is one right approach, though it's able to fix =
your problem.&nbsp; noretry=3D0 will cause other test failure on several AS=
ICs.<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ba=
s Nieuwenhuizen<br>
Sent: Sunday, November 29, 2020 8:38 AM<br>
To: Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
Cc: Gui, Jack &lt;Jack.Gui@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.co=
m&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; amd-gfx mailing list &lt;amd-g=
fx@lists.freedesktop.org&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Z=
hang@amd.com&gt;<br>
Subject: Re: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to=
 1 for some dGPUs<br>
<br>
Can we revert this patch to fix<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1374&amp;amp;data=3D0=
4%7C01%7Cguchun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DJxa2V1TuszoBKtF%2FPbIA3YwOrXHgLreBY%2FXej1HTZ4k%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1374&amp;amp;da=
ta=3D04%7C01%7Cguchun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C1000&amp;amp;sdata=3DJxa2V1TuszoBKtF%2FPbIA3YwOrXHgLreBY%2FXej1HTZ4k%3D=
&amp;amp;reserved=3D0</a>
 ?<br>
<br>
On Thu, Oct 15, 2020 at 4:30 PM Felix Kuehling &lt;felix.kuehling@amd.com&g=
t; wrote:<br>
&gt;<br>
&gt; Am 2020-10-14 um 11:35 p.m. schrieb Chengming Gui:<br>
&gt; &gt; noretry =3D 0 cause some dGPU's kfd page fault tests fail, so set=
 <br>
&gt; &gt; noretry to 1 for these special ASICs:<br>
&gt; &gt; vega20/navi10/navi14/ARCTURUS<br>
&gt; &gt;<br>
&gt; &gt; v2: merge raven and default case due to the same setting<br>
&gt; &gt; v3: remove ARCTURUS<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Chengming Gui &lt;Jack.Gui@amd.com&gt;<br>
&gt; &gt; Change-Id: I3be70f463a49b0cd5c56456431d6c2cb98b13872<br>
&gt;<br>
&gt; Acked-by: Felix Kuhling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt;<br>
&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 23 <br>
&gt; &gt; +++++++++++++++--------<br>
&gt; &gt;&nbsp; 1 file changed, 15 insertions(+), 8 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c <br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; &gt; index 36604d751d62..f26eb4e54b12 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; &gt; @@ -425,20 +425,27 @@ void amdgpu_gmc_noretry_set(struct amdgpu_d=
evice *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *gmc =3D &a=
mp;adev-&gt;gmc;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /* Raven currently has issues with noretry<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * regardless of what we decide for other<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * asics, we should leave raven with<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * noretry =3D 0 until we root cause the<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * issues.<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /*<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * noretry =3D 0 will cause kfd page fault tests fail<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * for some ASICs, so set default to 1 for these ASICs.<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (amdgpu_noretry =3D=3D -1)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc-&gt;noretry =
=3D 0;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc-&gt;noretry =
=3D 1;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc-&gt;=
noretry =3D amdgpu_noretry;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /* default this to 0 for now, but we may want<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /* Raven currently has issues with noretry<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * regardless of what we decide for other<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * asics, we should leave raven with<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * noretry =3D 0 until we root cause the<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * issues.<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * default this to 0 for now, but we may want<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; * to change this in the future for certain<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; * GPUs as it can increase performance in<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; * certain cases.<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flist">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist</a=
><br>
&gt; s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C0=
1%7Cgu<br>
&gt; chun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961fe4884=
<br>
&gt; e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZsb=
<br>
&gt; 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
<br>
&gt; 7C1000&amp;amp;sdata=3DVFqegGwPCj10q3Y5BdZsVq2a%2B4Tb358mYVDaNkA9zLU%3=
D&amp;amp;<br>
&gt; reserved=3D0<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DVFqegGwPCj10q3Y5BdZsVq2a%2B4Tb358mYVDaNkA9zLU%3D&amp;amp;r=
eserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D0=
4%7C01%7Cguchun.chen%40amd.com%7C6d626e2a3bae4877024f08d893ff15db%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637422071085800476%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DVFqegGwPCj10q3Y5BdZsVq2a%2B4Tb358mYVDaNkA9zLU%3D&amp;amp=
;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488508A68085217363A0F64F7F50MN2PR12MB4488namp_--

--===============1951090374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1951090374==--
