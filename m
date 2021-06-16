Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FEFC48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 05:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E7F61164
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 05:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E7F61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88FF89EB8;
	Wed, 16 Jun 2021 05:40:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CFE789EB8
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 05:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQa8OOUyTjVxvys2i6EAESVYHoiNxoUJ2IpwpOFRM7GHr3wZJ8afs9TYOyZw/ppyM+pDLa+Ea68AA9lm86njCx2nTNE6x6+PAhzifirGCQ1hR9QfvUKaR5ZpFDvDih8/Zslm2AMHHLsMahWND3DxJ8zxWbrZhfto39eqBSyV+S8qgi0RD0IPko9igTT+EziEBI6/wWqsd4VK/WkdPJIiBlGwucu+nBgSQbtdet18V2vSKnLmgEBag/incvvky/4P13OmmVPlzAtAubFHv/poAHkaOQTEK+DdwXQ1HFgePi53NXFp+ZgRWIXSmRKj+U07qFf32YjZFpMYmTjpM5uHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S9SdOwZnVSpYIfd8atZajnwhVoht+OvFAGjZHnh9Pk=;
 b=fRDkzl+yQ6b4LbEpdFTqEeH4wQYrVORGMK4dt8EXIjfd4X1JCKUEe1dEliD2bxXgi0CdA0X+vyDscGnvLPB4SXlx6HK7qqwOlpF6Ov3mf01yCX3oND3a4fyE7kA+ynlxMYrdo6kNI53WzSu/YQPn5IU1P16yH6RkLuuooXw3X0NuLON036ritrtw4oLHilUZVNJaDD1Ic4qqzyE4s3FNNIqzZj/Nf6O2OS7+97sNJba9BlMQGoSD6rd5sGtIjTMjIowwa9vP8Jqgv+AYCSJJaBigdZYHevrZfNsJaH3qO+I9vkZplOGSMt0k0Txwqi79R/ZBYbwdD8rOWvIzClVsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S9SdOwZnVSpYIfd8atZajnwhVoht+OvFAGjZHnh9Pk=;
 b=mmBH0akNwCoY5CNc1KpRno1ecKdNl5yQO9dDp8fTIwGwU2bZH+7ewu0YA4Oz2WlDuq2VZiEPQY3XoeVik85gywBTkjUZVDpt1jgpVQ9cQBRz0SHbypE12YvRwdpHmov9g2aLuzYi2j3EQIuhP5y02J2dBpZmQzcqUAVu2qqo5cs=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Wed, 16 Jun 2021 05:40:26 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::89db:544a:c071:d9e6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::89db:544a:c071:d9e6%7]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 05:40:26 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: Use IP discovery data to determine VCN
 enablement instead of MMSCH
Thread-Topic: [PATCH v2] drm/amd/amdgpu: Use IP discovery data to determine
 VCN enablement instead of MMSCH
Thread-Index: AQHXYbqVsTHRGQpWekWpvbiI4lDiqKsVddwAgAB4BJA=
Date: Wed, 16 Jun 2021 05:40:26 +0000
Message-ID: <DM8PR12MB54781D5962DF650411375AD3F80F9@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210615074632.31507-1-PengJu.Zhou@amd.com>
 <CADnq5_PBj7frnYown4AY3jcdu7LHCg6sEKeQ5cHU8U1U6Wb0VQ@mail.gmail.com>
In-Reply-To: <CADnq5_PBj7frnYown4AY3jcdu7LHCg6sEKeQ5cHU8U1U6Wb0VQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-16T05:40:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=90d824bd-4632-4646-86e1-631f87086220;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecb424d2-fd47-442b-bd27-08d930893e65
x-ms-traffictypediagnostic: DM4PR12MB5341:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB53412DBA5EAD42C086A936EDF80F9@DM4PR12MB5341.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n8IM+1FcXeUjzSdR65PX2D/BuUIIlKMo0nC876ni5D5stNvWWMix+ob5Kajws/9F6ewttCHkjJKqtVxK2t9A7x7NAJH4IE59BsSX0psBtp1H7ulwUAdSrdbmSZhFWZ+JzHfb2jqeN23Wls2GFOp4QYp7Onw2NASM8RXh92IpHtbI5o8o/R0s3YKMI7UZskuMLoBGcmklGqt1S2LWXw5nECt8nLbP2aWceoNU5O8p+23G0LTcPB5tbT3YoUyNqB3evXC7qgbYjwLTiy8vVLFeBMvv6mmcmsYwfOhfzvTplhWPYvwR3XrZwgtIIwC2bR9kRvoQPWAZolbGHTUZlFn0v2gjVwuS5kTKQ/AUlLl7f0ahWe389S6KCLwHojebrBYfEYrYQsCMMeLSNqbj590upUW+prUlziREdyTsqycCYvcblBPMw1VA5Kd5TWTuuF6XJLw5bd/tn+4dHaGT1HNihe6qOgEZzCoU904dXgvRV054mQ5Ob9qB4SPhC0QP7b8fZb8FSZyRNUHGh02BlOaDRFSF18UBinNwN0Fm3QntukNcmKKXAAjhnst2A6mcqaz2/aUF9hQeVu8gDqyWmsZan2Xs8h2TOBFs+JkayIhcPeMcyFMItWsGCxvG+6VeMLaTfRoe1EVZs3E3FGu6i79cuNKyFL0v+c4YwTs77iTU/4FEE03kiHG17jojE7x8c86BAXYfYPlUoln8ZAL+8gooLSzPTO/Ij/S/FXKvmseMLNE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(966005)(4326008)(53546011)(6506007)(2906002)(45080400002)(66476007)(52536014)(71200400001)(66446008)(76116006)(33656002)(66946007)(66556008)(478600001)(7696005)(8936002)(5660300002)(83380400001)(8676002)(55016002)(26005)(64756008)(86362001)(6916009)(186003)(9686003)(38100700002)(316002)(54906003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UuzHTxtP6VfzdjnizZh/yj1C/QJ0NP2K3p1dWSD6Fqtp8bwqFm6rY/vuxrFo?=
 =?us-ascii?Q?YxDhSc0kWGYBoLMjni2CTU04y+9xdj0VtpSeFsyz9ZiBzW8GQ4woU3VaGspJ?=
 =?us-ascii?Q?Z82EJWOvSCZXh5fB+EO42PR2wfIxqgIjysJaTDq29TVIjyIoniqJBaWeJnJN?=
 =?us-ascii?Q?rZk/f5W3lcc245dez/HXA8i4gNj7pGri+7uqtIyspoIgoVqqTXZcbEeDQuGX?=
 =?us-ascii?Q?w3cK5w3DiGAcNNA0OOCVVlFej6tuZ1N6/VE4bKs6XaN7Uc1IYxbE3khLSaPf?=
 =?us-ascii?Q?TlHVv4H3peQFWpua4ZcQ4+7L2F1a93RSv6/v06RZA46q9foeVF5fBW5z7J63?=
 =?us-ascii?Q?287vW9xw71Qu1o+pEJXg79F2lHuqvwmxyRVLyNo1Jz/1jE96AMBt+zNCyS7B?=
 =?us-ascii?Q?QWHqX/eFfe4j58FOoIY1PcPVdTgAHQNCwb/lC8xCc+5CYB4pDf/iwxqpzfnb?=
 =?us-ascii?Q?nRK9h3FqGws9M+OOIG6grxfT6uuNRiB5CePCX7BL9q3hLLbVjWigzYwDhkhb?=
 =?us-ascii?Q?/1FjJ2grJWopFOM4HZ5AlO3YLAV0ES2gi7GducsEcPojwpQQ5x06N5tu/6eM?=
 =?us-ascii?Q?rinns5fWlLiu+KvUBtfhn8pDghjOhV0WDjPXpMP7GgMhlnFnTQJthO6inSF+?=
 =?us-ascii?Q?qRNRpZI0fSCuZkgcsQzrFZXMBQEWugkN5fCJktvaOUM6/rTMM+vbw/VX6X4e?=
 =?us-ascii?Q?JEc2krkhv4ziYON9mk8F5NdUSzAJgAy7cq59PbMpST59THqJgQgHgOAm0JUH?=
 =?us-ascii?Q?iyirfvx2Ozcsa4OWMGOg3uAz/Wz6hIqfuIM19Hq0xTsZvAIxC2WUXth5lSXI?=
 =?us-ascii?Q?SbJKzbHg//c8RTuJ2ezwms/7/tVIlbKVY5wHOfBuT29QsC4nAbCvBD/j4oHf?=
 =?us-ascii?Q?aEJEFAYymPiHQ30gewt6c19yrK+kCMK5TbsjbvUKAYvxKGiRZMaaPRc4KtNs?=
 =?us-ascii?Q?flUn7LdXZGXVYkbVi49jg65gDcApwljTk88WVtLVDzlzHy7lc2A0mlMTn9AU?=
 =?us-ascii?Q?+dIeVxymIRhU3P6pvEbM9UxFypr4USgGKGI0pCDAyIg5QcObN6YpvuCpWMX+?=
 =?us-ascii?Q?ZurfV6dlaqgmy8OBO/GLZnujHUjQxgm5LFXO/gac5pG/gzNJO0j9eEnjtVfm?=
 =?us-ascii?Q?hWM4g/FjVYXnplIburPiOxKkrv/kA9/eHb91Sy4aD9FQcbOK20IUxdK+xSLD?=
 =?us-ascii?Q?+El+Dfoh5AEszCElJz/x6jGf5aTa/VCmXSUZcUYyS0ShOFW0xV5pCCQxc0Dl?=
 =?us-ascii?Q?zt0WaEDq2gL8cWd96WZpGGav0/AhOAlFWkr6SMFRT3Y5FAl1ndSxwlQBzlHv?=
 =?us-ascii?Q?TNbLWjefTQl1yUIIL/fiv2Tf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb424d2-fd47-442b-bd27-08d930893e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 05:40:26.3431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPyoTcIUuZvYY4EKgNUxPPRpybqDNmmBaPMrT1P/dtZnfLBX/JTdJQy1c8JwMnpcNwClsVj98mqiSlh+K3jf0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Alex

Update inline

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, June 16, 2021 3:29 AM
> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Bokun
> <Bokun.Zhang@amd.com>
> Subject: Re: [PATCH v2] drm/amd/amdgpu: Use IP discovery data to determine
> VCN enablement instead of MMSCH
> 
> On Tue, Jun 15, 2021 at 3:46 AM Peng Ju Zhou <PengJu.Zhou@amd.com>
> wrote:
> >
> > From: Bokun Zhang <Bokun.Zhang@amd.com>
> >
> > In the past, we use MMSCH to determine whether a VCN is enabled or not.
> > This is not reliable since after a FLR, MMSCH may report junk data.
> >
> > It is better to use IP discovery data.
> >
> > Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
> > Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  8 +++
> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  3 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 23 ++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       | 13 +++++
> >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 52 +++++--------------
> >  5 files changed, 60 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index f949ed8bfd9e..e02405a24fe3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -373,6 +373,14 @@ int amdgpu_discovery_get_ip_version(struct
> amdgpu_device *adev, int hw_id, int n
> >         return -EINVAL;
> >  }
> >
> > +
> > +int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int
> vcn_instance,
> > +                                    int *major, int *minor, int
> > +*revision) {
> > +       return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
> > +                                              vcn_instance, major,
> > +minor, revision); }
> > +
> 
> I think you can drop this wrapper and just call
> amdgpu_discovery_get_ip_version() directly from
> amdgpu_vcn_is_disabled_vcn().
> 
> >  void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)  {
> >         struct binary_header *bhdr;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> > index 02e340cd3a38..48e6b88cfdfe 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> > @@ -32,6 +32,9 @@ int amdgpu_discovery_reg_base_init(struct
> > amdgpu_device *adev);  void amdgpu_discovery_harvest_ip(struct
> > amdgpu_device *adev);  int amdgpu_discovery_get_ip_version(struct
> amdgpu_device *adev, int hw_id, int number_instance,
> >                                      int *major, int *minor, int
> > *revision);
> > +
> > +int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int
> vcn_instance,
> > +                                    int *major, int *minor, int
> > +*revision);
> >  int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
> >
> >  #endif /* __AMDGPU_DISCOVERY__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > index 9492b505e69b..84b025405578 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -287,6 +287,29 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device
> *adev)
> >         return 0;
> >  }
> >
> > +bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum
> > +vcn_ring_type type, uint32_t vcn_instance) {
> > +       bool ret = false;
> > +
> > +       int major;
> > +       int minor;
> > +       int revision;
> > +
> > +       /* if cannot find IP data, then this VCN does not exist */
> > +       if (amdgpu_discovery_get_vcn_version(adev, vcn_instance,
> > + &major, &minor, &revision) != 0)
> 
> Just call amdgpu_discovery_get_ip_version() directly here.

If call amdgpu_discovery_get_ip_version() directly, we have to include header soc15_hw_ip.h
I have 2 concern:
	1. amdgpu_vcn.c is ASIC independent file, but soc15_hw_ip.h is ASIC related file, Can we add the header to amdgpu_vcn.c?
	2. From design perspective, is it better to use a wrapper than including a header file which may increase the size of hex file?


> > +               return true;
> > +
> > +       if ((type == VCN_ENCODE_RING) && (revision &
> VCN_BLOCK_ENCODE_DISABLE_MASK)) {
> > +               ret = true;
> > +       } else if ((type == VCN_DECODE_RING) && (revision &
> VCN_BLOCK_DECODE_DISABLE_MASK)) {
> > +               ret = true;
> > +       } else if ((type == VCN_UNIFIED_RING) && (revision &
> VCN_BLOCK_QUEUE_DISABLE_MASK)) {
> > +               ret = true;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  int amdgpu_vcn_suspend(struct amdgpu_device *adev)  {
> >         unsigned size;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > index bc76cab67697..d74c62b49795 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > @@ -280,6 +280,16 @@ struct amdgpu_vcn_decode_buffer {
> >         uint32_t pad[30];
> >  };
> >
> > +#define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80 #define
> > +VCN_BLOCK_DECODE_DISABLE_MASK 0x40 #define
> > +VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
> > +
> > +enum vcn_ring_type {
> > +       VCN_ENCODE_RING,
> > +       VCN_DECODE_RING,
> > +       VCN_UNIFIED_RING,
> > +};
> > +
> >  int amdgpu_vcn_sw_init(struct amdgpu_device *adev);  int
> > amdgpu_vcn_sw_fini(struct amdgpu_device *adev);  int
> > amdgpu_vcn_suspend(struct amdgpu_device *adev); @@ -287,6 +297,9 @@
> > int amdgpu_vcn_resume(struct amdgpu_device *adev);  void
> > amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);  void
> > amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> >
> > +bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
> > +                               enum vcn_ring_type type, uint32_t
> > +vcn_instance);
> > +
> >  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);  int
> > amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
> > int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring); diff
> > --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > index ce3c794c176f..a79ae86bc752 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > @@ -85,9 +85,12 @@ static void vcn_v3_0_enc_ring_set_wptr(struct
> > amdgpu_ring *ring);  static int vcn_v3_0_early_init(void *handle)  {
> >         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +       int i;
> >
> >         if (amdgpu_sriov_vf(adev)) {
> > -               adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> > +               for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
> > +                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
> > +                               adev->vcn.num_vcn_inst++;
> >                 adev->vcn.harvest_config = 0;
> >                 adev->vcn.num_enc_rings = 1;
> >
> > @@ -99,7 +102,6 @@ static int vcn_v3_0_early_init(void *handle)
> >         } else {
> >                 if (adev->asic_type == CHIP_SIENNA_CICHLID) {
> >                         u32 harvest;
> > -                       int i;
> >
> >                         adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> >                         for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> > @@ -154,7 +156,7 @@ static int vcn_v3_0_sw_init(void *handle)
> >                 adev->firmware.fw_size +=
> >                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes),
> > PAGE_SIZE);
> >
> > -               if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
> > +               if (adev->asic_type == CHIP_SIENNA_CICHLID) {
> 
> Is this change safe?  Will this break anything on harvested boards?
> Other than these comments the patch looks good.

Will change it.


> Alex
> 
> >                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id =
> AMDGPU_UCODE_ID_VCN1;
> >                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev-
> >vcn.fw;
> >                         adev->firmware.fw_size += @@ -324,19 +326,17
> > @@ static int vcn_v3_0_hw_init(void *handle)
> >                                 continue;
> >
> >                         ring = &adev->vcn.inst[i].ring_dec;
> > -                       if (ring->sched.ready) {
> > -                               ring->wptr = 0;
> > -                               ring->wptr_old = 0;
> > -                               vcn_v3_0_dec_ring_set_wptr(ring);
> > -                       }
> > +                       ring->wptr = 0;
> > +                       ring->wptr_old = 0;
> > +                       vcn_v3_0_dec_ring_set_wptr(ring);
> > +                       ring->sched.ready = true;
> >
> >                         for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> >                                 ring = &adev->vcn.inst[i].ring_enc[j];
> > -                               if (ring->sched.ready) {
> > -                                       ring->wptr = 0;
> > -                                       ring->wptr_old = 0;
> > -                                       vcn_v3_0_enc_ring_set_wptr(ring);
> > -                               }
> > +                               ring->wptr = 0;
> > +                               ring->wptr_old = 0;
> > +                               vcn_v3_0_enc_ring_set_wptr(ring);
> > +                               ring->sched.ready = true;
> >                         }
> >                 }
> >         } else {
> > @@ -1303,8 +1303,6 @@ static int vcn_v3_0_start_sriov(struct
> amdgpu_device *adev)
> >         uint32_t table_size;
> >         uint32_t size, size_dw;
> >
> > -       bool is_vcn_ready;
> > -
> >         struct mmsch_v3_0_cmd_direct_write
> >                 direct_wt = { {0} };
> >         struct mmsch_v3_0_cmd_direct_read_modify_write
> > @@ -1496,30 +1494,6 @@ static int vcn_v3_0_start_sriov(struct
> amdgpu_device *adev)
> >                 }
> >         }
> >
> > -       /* 6, check each VCN's init_status
> > -        * if it remains as 0, then this VCN is not assigned to current VF
> > -        * do not start ring for this VCN
> > -        */
> > -       size = sizeof(struct mmsch_v3_0_init_header);
> > -       table_loc = (uint32_t *)table->cpu_addr;
> > -       memcpy(&header, (void *)table_loc, size);
> > -
> > -       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> > -               if (adev->vcn.harvest_config & (1 << i))
> > -                       continue;
> > -
> > -               is_vcn_ready = (header.inst[i].init_status == 1);
> > -               if (!is_vcn_ready)
> > -                       DRM_INFO("VCN(%d) engine is disabled by hypervisor\n", i);
> > -
> > -               ring = &adev->vcn.inst[i].ring_dec;
> > -               ring->sched.ready = is_vcn_ready;
> > -               for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> > -                       ring = &adev->vcn.inst[i].ring_enc[j];
> > -                       ring->sched.ready = is_vcn_ready;
> > -               }
> > -       }
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPe
> >
> ngJu.Zhou%40amd.com%7C03db0d21b4954eb34a0308d93033d2b5%7C3dd89
> 61fe4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637593821403612572%7CUnknown%7C
> TWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%
> >
> 7C1000&amp;sdata=CTur5LY8Nc8OlpJ5a1G4TlJe96CXEZ2%2BRpqaLc%2F%2FiP
> o%3D&
> > amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
