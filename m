Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D314DC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 01:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEB821775
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 01:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x5/0NVN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEB821775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8036E849;
	Thu, 22 Oct 2020 01:10:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301EA6E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 01:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+XZLktdx6+HeJ76FR70gi4u9IlRJiJ5wnaQLULDLhI9Xi/00U3k2P0AdUXGLtN97g/P9dbbfChHCHeohpmimAcAgQ4QVPNdajRR1yhDqbF3+j2lj4WbqgnUUO5WuSFQ+tNWgZu2/xzKE5QbXOVr9C2Fby6KNDbHOk5VKNeAKdgLa3g5Lb39q1AUjHH2V8f34HAGvV4YYLLW7wDQwq7vkv/rrcjxHZasp9C4ryaxC0St3h6NYwh/NOKIpo2AaDa/sLRRPqw+kssMbPdfkg5H0xj107jQRA7/Ceb70+2IWIcHkIs69dT3o9KzU1p86tOqcDU8Qz192vZBKrUoiedWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NICPMr/LPao6S1bYgH4vODDkWkn+E8EJ2uZNJ5mt/dw=;
 b=FOGmjtgMKlHQcHUlimzrkhdBCQUmQk4Sc3a/BEPgj5pLTnJm50YjBkJxOGNf5J0GhkxCuYHRHwXtwDOZmeLV7IZp9945UYWAPv6cGDhode7fllw3nC9KLSfVHQICeSkNJOmh0jSO/APZXeCKdfryHwyMk9HgDqJV6WN2fUJwRNrD8J9APAZI4xZdxCf64aXXSns0jw5d5kA6qb9SaPxT1CR1R64AN6PDDM5p0pAif5vU1KAgrllUm++ZyAlPg2VNRz8SECVaEQ7FkVtKiCHUeQ4dkwORYxxUoQNX0fk/CZKJ9UktmCh5UAUaiCVHvzBRDWijMbL0AzZ+9jLvyfwtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NICPMr/LPao6S1bYgH4vODDkWkn+E8EJ2uZNJ5mt/dw=;
 b=x5/0NVN+uXTzEnR9GXjfiqsB3IUDaFP4vpG8TYLC8CE17iNT7BmkF4l2Bn7nVQQowt0669dsMFDp/2g0HYqaM8u7hMvZvIvPBEtGAzsJxMGWl9oxr84nqv2GtDcobLHPn03jhq/4uvUTZelnYX7RgkssPGnTN1KVtb4QCnRcYn0=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Thu, 22 Oct 2020 01:10:44 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 01:10:44 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Topic: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Index: AQHWp3W2tpMmU4s9tUCXALqpnAXt8qmiBbyAgAAKuICAAFWsgIAAZKRg
Date: Thu, 22 Oct 2020 01:10:44 +0000
Message-ID: <DM5PR12MB16579B5849FB6719ADFE7C2D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201021064455.14935-1-kenneth.feng@amd.com>
 <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
 <CADnq5_NLyQ2jOW0ZkYMXcAX-snqHvUzNRYtrDRZbhN7qe0_5Zg@mail.gmail.com>
 <CADnq5_M_ry9EHp2b1ycBzD4oTsfVJxFtSGoRvq2EfJiN6Qczmg@mail.gmail.com>
In-Reply-To: <CADnq5_M_ry9EHp2b1ycBzD4oTsfVJxFtSGoRvq2EfJiN6Qczmg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T01:10:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fe1b1728-1b86-4958-9e26-00002e741fc6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-22T01:10:37Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c6c7429a-1550-4404-9058-000064048e7f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0400f14c-3130-4662-9fa7-08d876274d3b
x-ms-traffictypediagnostic: DM6PR12MB3017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB301735AD684602CF514C89478E1D0@DM6PR12MB3017.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsXUImRpoHkxcFujPO6VvibN7C2/OzK+jLp29Mn8aGOGFNokgusdKiT4b99w4+qQDj1JZKlcCTfyW/sDu2y4fwGmfIdefWqrBjAXRPLseAJh2vWrZGw1b3gPsCA7xKFojzudDTwBQFTJLcxVT1yCSRhwYVf1sXcDOR0emTVo7wAw9sGaCAeHxAa8qKbU95ChoQDRP2pogV6tI4+vEGYKjyhFagRxIrniTsMxiSCCoELBf96bCdDqU8axOGjObpfBG25sZBAmLx/OZpZNDggI6GZeUBPt0SVkQ7xKD+wshzHC+AXBnN+ieAYRIVAmkOnigB0FYQpPXUnYDZ4A1YjQPQOAwvStwD72Bfx0+Eu/wRmNCsk4ST8agNXsJeustddI6UaTyreJWZMMpQ8BR41w9mlk5pkKKCyPmfRDlbdwgJVZk7hggQT2CHFU5qXtaitq8f5Ykjwgs8ebZ/BoFTW4tw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(86362001)(4326008)(316002)(8676002)(66446008)(5660300002)(66476007)(64756008)(33656002)(66556008)(966005)(66946007)(6506007)(53546011)(76116006)(2906002)(55016002)(83380400001)(52536014)(45080400002)(26005)(6916009)(8936002)(478600001)(9686003)(7696005)(186003)(71200400001)(54906003)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HXXd40U3V1pG3dVRBI3w0N46t1c4MN7CMcjY15tgFZgAg83WWuYfUlYR9M18p+iLaMVOiNEr+cpYYeFeQ1GTijOFlNcuXOeqgsIXTFjVZlxtcy8QDgXozrbR64aUIN0BSOXBdlBQ8t4CF7T4DMEK196u7gzZgRgFm/d6G3PjhIhVVUJ17WBLO9oWAJlz+ryAA+8pQCKr0Z9XE2Iq9yUgHSLjc+pHUBYtLlt+qhN9cAtQj0kDIphcoICdVWyMcdEPdXvICvBNyTPXExwPCJ0YhyUdU9u6YVVARSDPmw4Wo5Mn1B+PGvraSftCcB4NS8KJONawQlC438GR3HY+UMYhSE89MssRrHMtVjWxvJIOIV88YMuQA/KvzdvGd/fZMpNg7SG5G+dr42w+XA0mlK+9jiFNAoPInxxHVIk4sRAGbD5JEwDZL3t83JVlkQbAaJ3ZMzOKYZijCmbm+hzVgnJeSsHMEW8QYwfNx8FG1FIwkgzzZ65/xXYQU0AsnjZukEKBN1zixiEXwpPdg2so+pRUfJBkO2itfSmQHjjEFNNfUE2y8A1+c2G/MZZrk0gH2svgq3ZP6T8Ie51l4zPalWqL7QEvxNvKybK7gRR5RcE9IWpYxuoSmNaVk32Z5cN8RPq93et1H1cbXqLoUhob/9Pk8w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0400f14c-3130-4662-9fa7-08d876274d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 01:10:44.3460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXzREGIDovA65LT3dvIzM4nmXmHl4ErMmME8PlNXsue+zXAirqZD8AwKMeHRYqte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,
Right, smu_v11_0_get_fan_speed_rpm() is not correct for sienna cichlid when it's in manual mode.
An example is that in my system, the rpm is about 1800 in manual mode, confirmed with AGM and the internal smu fw scoreboard.
But the fan1_input shows about 180000, which is way more than the real value.
If you see the value from the metrics table is 0 on navi10, maybe it's the real rpm since we still have 0 rpm feature.
I can double check the navi10.
Thanks.


-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Thursday, October 22, 2020 2:47 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun <Likun.Gao@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input

[CAUTION: External Email]

On Wed, Oct 21, 2020 at 9:40 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 21, 2020 at 9:01 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Wed, Oct 21, 2020 at 2:45 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
> > >
> > > fix the wrong fan speed in fan1_input when the fan control mode is manual.
> > > the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
> > > since the fan speed in the metrics table always reflects the real 
> > > fan speed,we can fetch the fan speed for both auto and manual mode.
> > >
> > > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> >
> > NACK.  At least on the navi boards I have, the metrics table fan 
> > speed reads back 0 when the fan is in manual mode.  That's why I 
> > changed this in the first place.
>
> Nevermind, I was thinking about navi1x.  If this is working correctly 
> on sienna cichlid, please ignore me.

That said, I don't see why the current code should not work.  Maybe a bug elsewhere?  Is smu_v11_0_get_fan_speed_rpm() incorrect for sienna cichlid?

Alex

>
> Alex
>
>
> >
> > Alex
> >
> >
> > > ---
> > >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
> > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > >
> > > diff --git 
> > > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c 
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > index 496abc31b07e..27b6cade9ade 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > @@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
> > >         if (!speed)
> > >                 return -EINVAL;
> > >
> > > -       switch (smu_v11_0_get_fan_control_mode(smu)) {
> > > -       case AMD_FAN_CTRL_AUTO:
> > > -               return sienna_cichlid_get_smu_metrics_data(smu,
> > > -                                                          METRICS_CURR_FANSPEED,
> > > -                                                          speed);
> > > -       default:
> > > -               return smu_v11_0_get_fan_speed_rpm(smu, speed);
> > > -       }
> > > +       return sienna_cichlid_get_smu_metrics_data(smu,
> > > +                                               METRICS_CURR_FANSPEED,
> > > +                                               speed);
> > >  }
> > >
> > >  static int sienna_cichlid_get_fan_parameters(struct smu_context 
> > > *smu)
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > lists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7
> > > C01%7Ckenneth.feng%40amd.com%7Cd8e969f4b63e4897a3df08d875f1b050%7C
> > > 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389028190609906%7CUn
> > > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> > > 1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KomP2H%2FadKJChDbNvNPQlTotmE
> > > WrhutsQCHfiRIjNUY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
