Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07557C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEF620721
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEF620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A0D6E530;
	Wed, 27 Jan 2021 05:57:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D856E530
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 05:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfvPoG7S1G9q9h7+mZQMv+vQymF+LAOpaIQ8HwrYTKtxsUs06N8QMRMzT16NxxxgjGrUTyUn4cPjM1vVBvMekwJUV7Fx7G3FODoEINF9GlCaU0AhQs+m0kJzv4M8VN7I9BxY+LF6xaDCLHvvXlUk8dl4AeXk8eREvgoexJMW21UCPkfmFWTP45Y6HsPBtH7nZgnv6ra9MH66Tm34l+53YFsF1/4+lyKdQHsjknypR1HyvM+pa/LNULnxoAFs5Ly4h9m970ztcd86A6+Dc2r56F4QwFUTSSvx55/FOwedNuhXmuiPJ8ROMjnBVmvnWW8n2oCnjyR+WjbvpoZAUdbYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJDb0cakU6BpiSW4ITCP13nxnTNKQSbWOVcyN2bJAb4=;
 b=ZXX0Y1Vk/T+uulg32qW0x7KNDaKTaBTxR/OPyfHJVjMYVpOGsOp+fHfPpfUEuLgABxDRX7h0iBCm9N9EkMZdkWAGo9ULZrKDqD/TIC+41z/0XoAz8aIpDilTvvvWhtq7v6uC64mMYECQG76B5xRi08XiJ0dBPW0GNtrde+G9gLNOpTH97vB7naMCWR/5lpR3ygpwfV8mhcKyzKMrpzNqd+W/ZNq9DDqhnCocH9Lt7OxjR9268pCutxTRZ7QfmfxzB5YAs8vcxlhAKQY+KhEba42clDdHsREmMZ6Jli+/r5VkW5uXpPniTfVJGP1TtWjnriVcD16leShzh6zzZ6VN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJDb0cakU6BpiSW4ITCP13nxnTNKQSbWOVcyN2bJAb4=;
 b=ZoDrvC6ZCVcGZEM+BOEhBH++CwKvgI/Xay/0pG4W57PHUSnb41CAYBWkAwIhlzscDmQin9k6Dgc9DfOS78+mfLVFiYaHDRX9LBe4g23vB5K7OUYihD56AoHIyeXjE9B39A+pl2kwZXFdTuGirrDEje/RiFbLCco54HrBO72I9z4=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BY5PR12MB4642.namprd12.prod.outlook.com (2603:10b6:a03:1f6::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Wed, 27 Jan
 2021 05:57:36 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::f16f:c71:adf4:cde7]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::f16f:c71:adf4:cde7%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 05:57:36 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Topic: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Index: AQHW9E2qObVGf96Irk2a5opCE7pOHqo66HuAgAANueA=
Date: Wed, 27 Jan 2021 05:57:36 +0000
Message-ID: <BYAPR12MB364028EC632E6071469468AD8EBB9@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210127014146.10902-1-kenneth.feng@amd.com>
 <CADnq5_PXPj6Fyzpe2wV_Bejx+JtihrbeatM605ATCuYNuzK-Vw@mail.gmail.com>
In-Reply-To: <CADnq5_PXPj6Fyzpe2wV_Bejx+JtihrbeatM605ATCuYNuzK-Vw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-27T05:57:29Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9c752782-59df-4f04-ac80-13a9158108ff;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a491cc37-b0aa-4929-6799-08d8c2887261
x-ms-traffictypediagnostic: BY5PR12MB4642:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB464272E0F26B69C6497FD7328EBB9@BY5PR12MB4642.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAXBhUBaJ2ofpiyC7/hvJ1a9sG/erR5g7kZL8Xd69Gx/paxUIiKY6QBSONWCLeP2JPCX3ciU8lX6waV7LrvBMMWlep/RlYTUdwXi5rsikGFgyCA+9qBzlADuEQ5vdy8+IAub1It4Bg18mOr0PB4P9L+0nAzp9JahywBSDNBNgZyTuDeGbb1UIfZcD4vlv5VLuQxPVi8iUt5IwW+46+qxtMpk2WUeUT32Za+e7ZkpsxJVuiSoC5URghW1FUks25PoAu2Zk95/T5LqGY1zgQhxA0IDxLoiC8OFa3IDPkqsyq4mV1SxT0uFHbvoea/Wc3+lJisbsHJ56kRAyKIoZzL+9xPwDnI5IOZMsStLSub5ZACZ0s1ExyhNqJZDA9Yu589LA95jtiUbBgIlc5gooWWlLZkKwEypILlN405LaqoIMrS0pNmwKm9b+0x9dHWtxMklmcRplSMTixiFu/hbQYV/UA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(83380400001)(186003)(26005)(4326008)(66946007)(53546011)(6916009)(71200400001)(9686003)(55016002)(76116006)(6506007)(2906002)(7696005)(966005)(45080400002)(8936002)(33656002)(66556008)(478600001)(316002)(54906003)(66446008)(64756008)(66476007)(5660300002)(8676002)(52536014)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3Qp6xpbcG+/pOuhrO5F+rSTuF8kn1BwDQ4NIypfGVZE7uHK44yVZHTNhNNZA?=
 =?us-ascii?Q?q9dZZyKP3PAx+ptRZ/YTUpDtd5+R2pl2n8AZBbhw1YvZysJDy7mXImyv9g6t?=
 =?us-ascii?Q?5GXeS+8eIp/tnMUvWs7SDWMXyWU1MvOEbIN4Xgfo3qqknpswZxIf8XXdNEmj?=
 =?us-ascii?Q?ONa0BDyZDlC6yxg9eu/EyjAGi2eooa/wIfiRJh2Khdl2BlW7qFf2BAmI86Lz?=
 =?us-ascii?Q?Q7hrdwIv4TF088yrfAJi7rjbfsgPezLGseZ/GbAbiQPbsNuCWA34wpG/fN1I?=
 =?us-ascii?Q?hJ9VU3J9a9D1M4xUZeGOI5q8+mIqVih4na7MEpoEBYNWgI7wWD/2aJ503F3h?=
 =?us-ascii?Q?v5wgaXwebTfRMshi8h9Z10rlouXK9XOgnwumbAqqmPrXwwADKQ432dtTOpVR?=
 =?us-ascii?Q?d5wu9sbfxEgCi9qRe1FQwn2lM/LReVAHkLtzirzqNQ4ygiB8U6LOkmSSV7Un?=
 =?us-ascii?Q?NjuCzoKK3RtAmiZbXIFE2/1gEVIQdSmaOudhU6wqe2/pUmyLgd/5ajmnizOi?=
 =?us-ascii?Q?m5iPnzJ7tk3qMgwgFm9qCzvGgG4lv31e8kuqfszYrxmOfMmOn3vCv/2ZpTYn?=
 =?us-ascii?Q?QsUxDd5W4eIhZYx6U8kEba9c2NMuLilSHx3vvkoEHgnSsF2JRLPdZ734JE17?=
 =?us-ascii?Q?X1HED6a7lGsGRqquHF/qpzMnc1Rrch51TpOND1sy9m3DGD5bQry06T5YmwwO?=
 =?us-ascii?Q?OgG4RBmmO4WjSKQA/J+ezZHvHyftmhdEOc07HUEWIc9r2DMPXzoQXc8FHeFs?=
 =?us-ascii?Q?pyZsG/NycB/gmPMpWsH2jNLKRJ9U9Xkm7j9I0lvG+6oz+8Q3DvFBy7Qub1/p?=
 =?us-ascii?Q?EK+tqZW7Mqlr1qjHQ6wNp1i+sVaf6NKwYXaGPwE3ykjH4ygvGHZvdnRiXhw7?=
 =?us-ascii?Q?WlRjI8DRRRPAPeIsHbvf9HjVBZ8yqLAXHTOFhLVYJmY6Is7ErBHdv80FGy3b?=
 =?us-ascii?Q?+vaJ19TwF0XSgTDqYgn8OOQtW5S6/X22z5H1xh2syVUUuJ0ibSv71u63ghQL?=
 =?us-ascii?Q?2tt359I3ONC1WRnD6OSBItph4etvDU5X8VFwjFLM55/Fq+3ihrqTLUVduwC6?=
 =?us-ascii?Q?5bEWhm7A?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a491cc37-b0aa-4929-6799-08d8c2887261
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 05:57:36.1673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVssZcl32zNvDE7oSq2a8rh2EMIse57ISsxe37vfLr78j0L4wT3oeKU6JlnhrGFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4642
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
Actually the FA DCS is dependent on the workload type.
FA DCS is applied only when there's 3D fullscreen workload or VR workload.
So we need to disable it if there's a request from the sysfs/user to set the workload type to 3D fullscreen or VR type because we don't have FA DCS so far.
By removing this hunk is ok functionally, but the DCS will never kick in though the DCS is enabled. That might be a little bit confusing.
Thanks.
 


-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Wednesday, January 27, 2021 12:55 PM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Enable gfx DCS feature

[CAUTION: External Email]

On Tue, Jan 26, 2021 at 8:42 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> Background:
> Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
> When the current/power/temperature exceeds the limit with the heavy 
> workload, the gfx core can be shut off and powered on back and forth.
> The ON time and OFF time is determined by the firmware according to 
> the accumulated power credits.
> This feature is different from gfxoff.Gfxoff is applied in the idle 
> case and DCS is applied in the case with heavey workload.There are two types of DCS:
> Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D 
> fullscreen and VR workload.
> Since we only supports Async DCS now,disalbe DCS when the 3D 
> fullscreen or the VR workload type is chosen.
>
> Verification:
> The power is lowerer or the perf/watt is increased in the throttling case.
> To be simplified, the entry/exit counter can be observed from the firmware.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 
> ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c 
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 24f3c96a5e5e..436d94cbb166 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
>         }
>
> +       if (adev->asic_type == CHIP_NAVY_FLOUNDER || adev->asic_type == CHIP_DIMGREY_CAVEFISH)
> +               *(uint64_t *)feature_mask |= 
> + FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> +
>         if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
>                                         | 
> FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> @@ -1437,6 +1440,15 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>         smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>                                     1 << workload_type, NULL);
>
> +       /* have to disable dcs if it's the 3D fullscreen or VR workload type */
> +       if (smu->adev->asic_type == CHIP_NAVY_FLOUNDER ||
> +               smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
> +               ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
> +                       WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT || workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
> +               if (ret)
> +                       return ret;
> +       }
> +

Since we don't support FA DCS yet, should we just drop this hunk for now?  I think the workload profile stuff should be independent of FA DCS.  Also so we want to add a ppfeaturemask flag to easily allow us to disable this at driver load time?

Alex


>         return ret;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cke
> nneth.feng%40amd.com%7C2f961319cdd141723c1808d8c27fb554%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C637473201048667755%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C1000&amp;sdata=2%2BC7%2FgINP5n9k2M6lXChHQj3scXU279dp6pR2SdRiq4%3D&a
> mp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
