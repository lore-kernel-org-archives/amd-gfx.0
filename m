Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C2C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 03:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB09464D9F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 03:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB09464D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCD389CB5;
	Thu, 28 Jan 2021 03:47:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7A389CB5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 03:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7VN2WzCLLY4Rz7G+jsAJS0W6emHMbPUVeMBdwOz2qVfanviauaEOHMNsIpVqQK9eSBmucBCteTzZBSzOVIRiPSw9N9JrHi1XP3bNnKvkk5S8lrcS7Sdb2giXTS5F+gIF/LpJYYLWwI6E8Jf7B/KGD5G9p/9m3Q0NkWX0sdBwizPyEg/0TNYURi6/SamTpNUCL6m+BhcyWMx7va6/tGMJ9X9RAhouB0nf6q6gzDX/nxDWIBDBp4iO9cD/V9D+GyYHTiTjZ1Jd0OlVk9QPp5iVBV3q8+xme1VLYi0EPHP6efk/c1mrn4OIXs30f0+fTSOf6o+u5YuzixFYmxAIcIt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nnfi7E0vuTAE8G5Mflr4ZZCOGss4caqwt33+WdCZmzw=;
 b=WH+l32V/qNLA4rzP4pILvjiEqvuuFoMbInRmHwyUXCdDBmbjj+u4RZsqv2pN6iqlpMRak2eYaVQjLtF4+jLoBfD4A1Lw/CfLCMNmdElgNOytBAfQBhda+HyFYOyjJgFECHWQ99HaLBXtEj79uUeOivTH4Gcm26VdSiCWOqXtZM3pZhGEFKmpb8ghJqNk7jQv4dz5b3godCu37brW4Eb5C+ougvbZBWJfdXWGL8WYMesV0esLQkxEvhSqyNtsZYwQKcxvO+2otvVmrv9bP28cviZVjeq54eNhFKaAt8k+qCp4ik1Vuq7gcwACaHiJsn/5MqyDDTRbWMPBFZQ8XIvgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nnfi7E0vuTAE8G5Mflr4ZZCOGss4caqwt33+WdCZmzw=;
 b=2MIdKsSlyY63XWYULNNBSLWBo0mVn89tmPI4MUqwwHsvcwUdCdyeQiChmzuq7m4pLBtF5+OncFvYv7VGWgO8YRYr+51WmJPVMQbyGHPeY624oHABfjwrs3+Gn6WI3tsiQd28kbf+trqVa8stExRcWLjYCHtvsHHtZrkoR9pclsg=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB3160.namprd12.prod.outlook.com (2603:10b6:a03:132::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Thu, 28 Jan
 2021 03:47:26 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::f16f:c71:adf4:cde7]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::f16f:c71:adf4:cde7%6]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 03:47:25 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Topic: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Index: AQHW9E2qObVGf96Irk2a5opCE7pOHqo66HuAgAANueCAAMp2AIAApz9g
Date: Thu, 28 Jan 2021 03:47:25 +0000
Message-ID: <BYAPR12MB36401A787384A08BC19E5D718EBA9@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210127014146.10902-1-kenneth.feng@amd.com>
 <CADnq5_PXPj6Fyzpe2wV_Bejx+JtihrbeatM605ATCuYNuzK-Vw@mail.gmail.com>
 <BYAPR12MB364028EC632E6071469468AD8EBB9@BYAPR12MB3640.namprd12.prod.outlook.com>
 <CADnq5_PY7MaeHb1suBuzFoZ9PMN2SnKDJG7Gd6xBZPt-FxWODg@mail.gmail.com>
In-Reply-To: <CADnq5_PY7MaeHb1suBuzFoZ9PMN2SnKDJG7Gd6xBZPt-FxWODg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-28T03:47:19Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1d800f4e-6b9f-48b8-81a9-2dd9430deacd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35072a6a-80a2-4d4b-c2cc-08d8c33f6d45
x-ms-traffictypediagnostic: BYAPR12MB3160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3160E54865535B105151A74D8EBA9@BYAPR12MB3160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lykiY77Y0jKBDdwVQUUhbSt+GZYyD9gUc88o+xO9hbFLImi6cJrDIy8JVDVunb4ezcOVv88bx/dQm8x8WItSh5IJZlfmm7zq7unqaTOvcLIYopx4FXDla2aDS447+d1k9DlkRL76NyOyEj0KRDEbVVMyKE4ET/vtBUxqlV55ewZRJSTRvYuNT837fcMXmo7nT93MfH7C5YYsEfa+yDrE7LyRYXGO2YqY+6sk4olovoMjZHnio6Bg9TW4phD8N3Hy/IAItegC4DI6iWTqvqFSPEud8Jm/Hsz17eh8buCyykGBboYMwCLyd9vI5E80/f904jfHN8A8+HQd6t+MLCukXc+8vJOhQpvbhxnQpLUGHBr+kIrITnMfIz1gOrYNM/VZ4XX0TDUVPJi5Mj6sUmAjxra1I0lE7YSpcUA1AoFP8wd/HRbG2c3/8rV87EmF8DcXKwWwLEWxyReLI5nyfRYISO6aaxmRtncn/AYLSzaEXqwW9Am8qroS/ELo5vyl09rwFBd8ldk7IfMNPxo4fbUPZxVfLsyl4flfhQHpJgCQ07u6HWHUjUQLDMVbptUMxc7y2j6fgVmsGNDnQHdPp5pE8yyJPOsd98GHkjZM9iXv9s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(54906003)(53546011)(86362001)(71200400001)(966005)(6506007)(316002)(83380400001)(26005)(4326008)(55016002)(64756008)(66946007)(52536014)(76116006)(66556008)(8936002)(5660300002)(478600001)(186003)(9686003)(6916009)(8676002)(45080400002)(7696005)(33656002)(2906002)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uG6mCKbXPqcs0GF4t0+JvKwYhI+aXYp4Fd3A0FuNtSHf5AB/mkrbfZH0MyIp?=
 =?us-ascii?Q?l+RwlKHQKqc+QyKajFLWdGMQJAA5WyUJzTpqCMpCkzjMNXatHH+GKngS65/f?=
 =?us-ascii?Q?4YqZ+Yxb6E+PXG0hzHxThkRMGdfTACt8Odn8k/WCsY3QLQ764yzKw0Zqv7e7?=
 =?us-ascii?Q?50+iXf7kHvQErjVqSrcyAvyAvglqwn+KGqc3MqHR4nPvPL5EpHR6kRg0KPK6?=
 =?us-ascii?Q?8eQhNT8NDkkV1oR54fYOmuIT2zYsWc23fa8zfQMOjjJ1xc9aFPJukChYItil?=
 =?us-ascii?Q?/l15eMJKHhtCB6oOf92mvqjFHFdgL/IkBnSVS+NF5U+zBK94fNBE5D7hPW5u?=
 =?us-ascii?Q?u6fShgRW3Zhu5eiJxEzbPLiigj3HtAjeYKctggtnT2h4/kzbzIRJHNqqAzql?=
 =?us-ascii?Q?89B1hz671gTIU2amKt4NfZm54IaBiJGiZTiWyJeSLIdhlt1NauQzZe9eEsgs?=
 =?us-ascii?Q?4iMFlpag1q239j9BS/6TcDOgINoYPWAi97LsllYrkU/2U7W0EyetMesT/qt+?=
 =?us-ascii?Q?t8gFFesBIlIWpywaHuD+BAy9Vkm455Og2NT3H+G1Behw6PQYH0+HMclUwYAl?=
 =?us-ascii?Q?NM9450kkABJMwplMBGibsmFe3Qq26uXTb7qNvTkSIZCS+D1/THk/sC4trg+E?=
 =?us-ascii?Q?10Ol5mjYhRMK9NrDKdlDccMN+vAxf+s22vS7tVESkRY440QW6KDm1zWdJTXw?=
 =?us-ascii?Q?Z+e93GpSGjJouyGqBmTv6wXqHkgfeeiQZITKN+Njtx2RoM9XbXgjLxT8Hcqt?=
 =?us-ascii?Q?de76rJEGaYreMVfsrN1ob0qVEXAWjVn8/oF7kJEn/Aq1/MvEoGBVr1SmsGTP?=
 =?us-ascii?Q?VlsrDuWrZkMVrs1kL7JIRreM7GcAoYtLMSNpI8WFUoj+u2RsTtgeuii4C7ad?=
 =?us-ascii?Q?jfNo2KDJK+JtEp/2LdLInMe/ipPsURy3pGAb9KJdJr9l4fdRkZ2FNK3wrRY9?=
 =?us-ascii?Q?Nwc/JrzMnVpnnON0ftuEiCGvdrZYWVO4fI270vuUlqglz4w9tnVMGzisPkIG?=
 =?us-ascii?Q?rAO7Alvajyfctk4jHp23pGoJaUR6Yaa78yG7W562eZsYt91mlo44JEqV14U9?=
 =?us-ascii?Q?heQJ6I8S?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35072a6a-80a2-4d4b-c2cc-08d8c33f6d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 03:47:25.3631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/2eHEQDbaMTsWDdCI+/HJpIhqsOhONL+Lsc/T4hGHBMqk90Vqt1SKBZsSJUW3yU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3160
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,
Yes, SMU acts differently with regard to DCS when we set different workloads via the workload interface.
The mapping is as below.
Default, power saving, video, custom -> DCS is disabled in SMU firmware internally though it's enabled from driver.
3D fullscreen, VR -> FA DCS
Compute -> Async DCS

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Thursday, January 28, 2021 1:49 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Enable gfx DCS feature

[CAUTION: External Email]

On Wed, Jan 27, 2021 at 12:57 AM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
> Actually the FA DCS is dependent on the workload type.
> FA DCS is applied only when there's 3D fullscreen workload or VR workload.
> So we need to disable it if there's a request from the sysfs/user to set the workload type to 3D fullscreen or VR type because we don't have FA DCS so far.
> By removing this hunk is ok functionally, but the DCS will never kick in though the DCS is enabled. That might be a little bit confusing.
> Thanks.

For clarity, does the SMU act differently with regard to DCS when you set different workloads via the workload interface or is this just using the assumption that at some point we might dynamically adjust the workload bits based on hints from userspace?

Alex


>
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, January 27, 2021 12:55 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhou1, Tao 
> <Tao.Zhou1@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Enable gfx DCS feature
>
> [CAUTION: External Email]
>
> On Tue, Jan 26, 2021 at 8:42 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
> >
> > Background:
> > Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
> > When the current/power/temperature exceeds the limit with the heavy 
> > workload, the gfx core can be shut off and powered on back and forth.
> > The ON time and OFF time is determined by the firmware according to 
> > the accumulated power credits.
> > This feature is different from gfxoff.Gfxoff is applied in the idle 
> > case and DCS is applied in the case with heavey workload.There are two types of DCS:
> > Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D 
> > fullscreen and VR workload.
> > Since we only supports Async DCS now,disalbe DCS when the 3D 
> > fullscreen or the VR workload type is chosen.
> >
> > Verification:
> > The power is lowerer or the perf/watt is increased in the throttling case.
> > To be simplified, the entry/exit counter can be observed from the firmware.
> >
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12
> > ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 24f3c96a5e5e..436d94cbb166 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
> >                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
> >         }
> >
> > +       if (adev->asic_type == CHIP_NAVY_FLOUNDER || adev->asic_type == CHIP_DIMGREY_CAVEFISH)
> > +               *(uint64_t *)feature_mask |= 
> > + FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> > +
> >         if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
> >                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> >                                         |
> > FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> > @@ -1437,6 +1440,15 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
> >         smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> >                                     1 << workload_type, NULL);
> >
> > +       /* have to disable dcs if it's the 3D fullscreen or VR workload type */
> > +       if (smu->adev->asic_type == CHIP_NAVY_FLOUNDER ||
> > +               smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
> > +               ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
> > +                       WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT || workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
>
> Since we don't support FA DCS yet, should we just drop this hunk for now?  I think the workload profile stuff should be independent of FA DCS.  Also so we want to add a ppfeaturemask flag to easily allow us to disable this at driver load time?
>
> Alex
>
>
> >         return ret;
> >  }
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > st 
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7C
> > ke
> > nneth.feng%40amd.com%7C2f961319cdd141723c1808d8c27fb554%7C3dd8961fe4
> > 88 
> > 4e608e11a82d994e183d%7C0%7C0%7C637473201048667755%7CUnknown%7CTWFpbG
> > Zs 
> > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > 3D 
> > %7C1000&amp;sdata=2%2BC7%2FgINP5n9k2M6lXChHQj3scXU279dp6pR2SdRiq4%3D
> > &a
> > mp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
