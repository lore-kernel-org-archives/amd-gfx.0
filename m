Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0694C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 02:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A5F64DA1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 02:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A5F64DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12B56E8BC;
	Thu, 28 Jan 2021 02:09:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B8E6E8BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 02:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAxInXqSWCrGZzA5Ri0zzBBC/v6QPiKDAEvxilfs1Fkd6dLRwIzvIpNFUG1ZGCEjAxUiN6ULNwOTr9M/AemRsPEyIxtryCL1fSRzNqMFQTfDFBTZesrAfbBYYNcuH/Mzht7JTlKUX9ntDxAw4YFsccN8k5b26AyEIsQIz6EEvVfJWGWgDauO4kNHvOJzpjo5b1CMrwzJcLBgdcKWYm0tL8ftwcyyiwQWKRf8pyihcvJ9Dj9zNdWJ0K6Xv/R9Gw+BKvWWUALkQmsplJjiFeaPc7YUhssG7WM38TF9+rZ5MMUDCX70fL9N4vuANOdvNr37inNt+23zZpQjQfAky7zcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCJlEOV6r8fu6h502wkWQJyrbOYfjVBKj0N/WkyhLQ8=;
 b=Fpi+RZ8+CZxq00lINYzMLFzRGnsOEwqPpLpzsVQVAhvcjwnItfJ/noQJ3I6IvH/q4Gsq49ZmuCqRDS2ZdPcmn0n91K6kf0hpDu8tlooaLDZEfxsQcTglyokgIkOv58kcFM/HxWsYeN93HJbrQ4wm39uzR+rhV4xM5FSyr593hErSCj12j4fAHhdM/Br3vs1AILlV7vd0+ujouDQ5/1CCz9kqrwXTuEcdwN3bedlhmrYtlC52pTEFLV/drSIXS09VGUVZ+Q88xHLHJWWq4uShBKGcTMMBDGOcepz3KYnwLbSCtf+SShId+rVRA6g38EFcjl0DJqS0BXP+mzJYtlF9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCJlEOV6r8fu6h502wkWQJyrbOYfjVBKj0N/WkyhLQ8=;
 b=FwLojvZ9XJvKX4mKboSewGC0UPWXqmQevRsMgLfQ63+BVBqZO4xEWc4Tio0ZPOOHqdm6dBpU/GS60Yw7Wk1uEglZFN/4o4iTdT4G9QTOMusCQITSxsWfESwfyNkvslFZsvQjO2Zd27k9cKwRbYrSV8X0F+C2pB08ymbspHUm0Qs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Thu, 28 Jan 2021 02:09:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 02:09:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Topic: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Index: AQHW9E2qquG/cmOSpE60CnjZ8TMv86o66HuAgAARiQCAAMamAIAAif8Q
Date: Thu, 28 Jan 2021 02:09:10 +0000
Message-ID: <DM6PR12MB26191B7C82CF19C38179FF43E4BA9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210127014146.10902-1-kenneth.feng@amd.com>
 <CADnq5_PXPj6Fyzpe2wV_Bejx+JtihrbeatM605ATCuYNuzK-Vw@mail.gmail.com>
 <BYAPR12MB364028EC632E6071469468AD8EBB9@BYAPR12MB3640.namprd12.prod.outlook.com>
 <CADnq5_PY7MaeHb1suBuzFoZ9PMN2SnKDJG7Gd6xBZPt-FxWODg@mail.gmail.com>
In-Reply-To: <CADnq5_PY7MaeHb1suBuzFoZ9PMN2SnKDJG7Gd6xBZPt-FxWODg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4bd5a9bc-2566-4981-a7ef-cc31950c1030;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-28T02:02:30Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27af9dbf-f1b0-4848-e45d-08d8c331b3b9
x-ms-traffictypediagnostic: DM6PR12MB4433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4433DC0FD85471B082830ECCE4BA9@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fttrZYWD5olw0pSCin6py8H9V56WYBZazFR5veHCyNdXYn6BcPwJ8BlGuPDaZOUWSgD5GAkUVIni5E4c6rO8FiGSmZyA10zzhDKBC0FzKcSjwv2AZFkQak4ZhBc2vizk0YAzEWDWA0TcIJYMnQ0kmBEhkQNEiir6HkbqAz7f8B9SNToJapcCPVakEyVqGoigWl1cf2wpha2baYbp71wR34fr91LurLAoeabqO4+hQ+7B3SdCE2gUQ8kD7x0As1Ucd2ufyH3+SbuwsVlVJjMczDlGJCVtLbvyEfh7YK24uPTfjVbkoXD6LQiY7/KeHB8dk9CBgd8URa4tcRrCWQqSvcfJJ2I+sRPdOQPUIb0CVzG/HzEmSW5LkvOJ6+J/25lF7DRJlp33iYmEaxGTobNbz5ZBqw+4N5ZKknIg3RMJCBlWVRAqUH6yC9T6PREwh8hdFK/qmnRssUHse7D4aL4ZuH5H0DQDYSj5WkC/unsremBYZk22MLQ6wYlgBTavZ/7+aBsN/zT96dA/Sgi83JuPywy5Tnk+r8Oyfo8Zi0SqQ1Z7wR901slyr74YRDCahuEMFkXfVrR4cRO7/ouzPV1JSCcrv+T8N3TjX6tmQ9IQQ00=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(5660300002)(71200400001)(86362001)(83380400001)(52536014)(76116006)(64756008)(186003)(6506007)(55016002)(66556008)(66476007)(66946007)(26005)(66446008)(6636002)(8936002)(2906002)(9686003)(7696005)(45080400002)(8676002)(33656002)(316002)(110136005)(478600001)(4326008)(54906003)(53546011)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K0FRjdtHFQzoHpVTlx1eFpiZypbj8pkTzBaozqcPmnrzCn3MqdwfsQGXoZNV?=
 =?us-ascii?Q?nPHTVNB2dDDHvC0sCA1fjYWMcyBc5ja8B8d1HUae4chn6SdxbaaPxkyQ3402?=
 =?us-ascii?Q?4LOu6nN+nVOythhUGukmCzEtesgwp4aKWCZYGc4VoBI/EwpZNVNQZumJs874?=
 =?us-ascii?Q?6o8FCoC/5sBdcXPTBJlLM2UTRYdlIh50+cgU+XyTrus6ITVqge2N/I1nHJSO?=
 =?us-ascii?Q?Eu4o9E3M+9ZmqSXMOtnqlr/XdKhItzvtePCGyXPp7rrMLzLYTH/C7euslS4F?=
 =?us-ascii?Q?jdyRPqurYARXRNQFk8ZtSPGdNTE+rn02gY9AhbeGgav4SIEb3t2EvgVDPDcu?=
 =?us-ascii?Q?6mhyUVMDIb1f+LDjTIasXtATtjLR0HeatsNUCiMzDDme805Qwf31BA1WNGE9?=
 =?us-ascii?Q?Yw6xUCS2hcIwbPjiy6/ECqO+FjL6t1+xX1Hw+ZQcYGSkQAgMNBcPueyEpFEF?=
 =?us-ascii?Q?p4mVsnRcKEcjwSr0xuoQehokIdv2p33edJs55C2atGrp2oDTcHpby5rXO2uI?=
 =?us-ascii?Q?srRwFo2SQl3IA4L2d3N/yUhvhZKtTIWC1LH9ZPeXj8AnH5Ed9qIckSiq82fj?=
 =?us-ascii?Q?F5we68GaO/jX94b6jPCDBv8BqxsbyYpGoTK2XorVoH0THtlHQ8RKaRUzZ1oT?=
 =?us-ascii?Q?Y5qZ/9m0+HMHVtW85dfwIGMsbhhQ9lgR/YynGXhhWPYhJFc5kuhetny38ksv?=
 =?us-ascii?Q?mAG+ZTvtFUtNMdWxpCXy/LdfnEY8rnA8UG6oi5JX3X994K3NmD+NGJBfogPx?=
 =?us-ascii?Q?L+lYy16oIrvcsJV8nALonhE91Au++BO2pJylYGfypAl+pibg3HF0XSrawS/h?=
 =?us-ascii?Q?FtbgtkuxtE/Vjxh0abPecLqrAkq91HT1yvNf6b/E+tpL01+6itTPcassZSnl?=
 =?us-ascii?Q?6FnocVOHI3LQkFnCc/JnoImMpmLwcNDPh+JOww9JAV2VlpE6Jx44L9R9SfoV?=
 =?us-ascii?Q?r3hzPOf0VzIWZs38W3A+cgPrZpZceMTohQLdjsuimxevpxWDnGUlpGT5CH/z?=
 =?us-ascii?Q?WqCKA6Rvvriept64KFa7acocVkzo+hHQ90fzCnMVB0l+bDiIl5Y9KB5qJ2QY?=
 =?us-ascii?Q?V4Vbz1/d?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27af9dbf-f1b0-4848-e45d-08d8c331b3b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 02:09:10.7474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2LVoahuyMRpprERCo5YRIoKK7OcwvfB7WZRy7UZuFoelIGVXcoInLElSjqLYo2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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

Yes, SMU acts differently with regard to DCS when you set different workloads via the workload interface. So, Kenneth seems right.
But I think the dcs feature disablement needs to be placed before SMU_MSG_SetWorkloadMask(some code as below). Otherwise, it seems the DCS mode switching happens first(during SMU_MSG_SetWorkloadMask) and the disablement comes afterwards.

+/* have to disable dcs if it's the 3D fullscreen or VR workload type */
+if (smu->adev->asic_type == CHIP_NAVY_FLOUNDER ||
+smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
+ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
+WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT || workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
+if (ret)
+return ret;
+}
+
smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
     1 << workload_type, NULL);

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, January 28, 2021 1:49 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Enable gfx DCS feature

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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cdc140485274e4987f52208d8c2ebcf5f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473665346134041%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=F4lLhov5HScYsfrECmUGzqCXRvBc%2FK8EkzrfpX4SLXY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
