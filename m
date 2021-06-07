Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1207CC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 07:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4D661263
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 07:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4D661263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7371E6E4B7;
	Mon,  7 Jun 2021 07:34:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAB06E4B3
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 07:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA9JZNFTV1JRw+z5Jj9AK08frIlfCc9EYLCCJG7g0c2R5x/kUzBVHBCOMqMl6mgSNnTTvuuj5o+IKqBZ+q01Ht5rKRyoSYkXKQf9FaTNvhZPzf541s6chWC9uj8pstX8PFonRFpDrsDq1ZoIB1VaN0oH5xHtZ2rr4yZqmCNhkMn3S9Tbj+1Ym3I0AI1O5187LoDabU70mUtdIUNcrWysbWVhZeARfWpYUTVFFpufeGreoJL76k7aDusnQYJrFe+HLPoN2NyZ+18YoNrzHAfQn1/d1ajVVjT+bjV10XVhYFEFCIyeVqau2hWsS1yYkxeshe1yrksCpq9QXvhZpVbd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FjtdvDBx8LUdTmHBTiYteKQgkwWxDNWCpRqu32knkQ=;
 b=LHxC7s+fCCYuckTabZ9GT9LwzQE8LKEfSBKZuGcs0GDY2v6oJ6yvsI1aSi0ayv1YVWOMsivEo9fNiDLkgI2TeakTQXOHPa/sWHHtmLz7VGrQzZBheHHVpVKQLP5dtk99cBV3hAkr0Oxcdh8qA3yFGe4SXjNy3wfUwbTRw1tnhqvcBiUUafmK7ciRgWjaC6LLrL+VxYFzzAqE/moN3EEHeukb5KrTUaYQZYbHMQXHDVBYu3Qv3N4DgJW0c6BuQf+GXD5D53ajHxiIZC/kyf3FaI52p1jrIgGzeIqE1+IT76T9dTvIWNif8w1nMPgLLFbzeSvNMdXZkkW7one8kJAecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FjtdvDBx8LUdTmHBTiYteKQgkwWxDNWCpRqu32knkQ=;
 b=1RckhghBGGwTtfYf1jsUv1sMtPy18vmaG/MH5Yzn1hWl3mh72sxDnjwnsUvdTsYGgvBo+wAwC85V6SWwpK2K7cgyjszf1RXlcEw+8Ur/qlHFv5WcciVjqnzXjXnBZi+vAPTiVMBwEBMF2n8UQO1TALsUdm8RXwBacPmjP4bgOEM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Mon, 7 Jun 2021 07:34:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 07:34:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status
Thread-Topic: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status
Thread-Index: AQHXWShNz4RQ8JhOG0ijdNT8ThOKqqsDvucAgARnz5A=
Date: Mon, 7 Jun 2021 07:34:28 +0000
Message-ID: <DM6PR12MB2619D1A458C9D391A5A57EE8E4389@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210604095823.1403271-1-evan.quan@amd.com>
 <20210604095823.1403271-4-evan.quan@amd.com>
 <83d7ff01-061e-707a-0774-fc29e05c2684@amd.com>
In-Reply-To: <83d7ff01-061e-707a-0774-fc29e05c2684@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-07T07:34:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b83fddb7-8de0-4217-9a73-b4f5d71e2a05;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3e55e4c-e244-40b9-5c3a-08d92986af05
x-ms-traffictypediagnostic: DM6PR12MB4941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4941BEA83C38236D4A6951ECE4389@DM6PR12MB4941.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgoz8cRjz3EZIkDRumBeDcMukPKH1+xJGJPPvoE6CADe4dllQx5QT5/G8EkNrWk2OEF0lNTpCNyh2OypTgLXK5CLmO7H8jQAauV9dKKCfhhsUMpLS5ai+eRyY/2H2c70VMZe4WwKB1gESMlSKgVxm83pRHn8TcuJvfNfIP9gSqUEzLwcoVSVBQebnrwVWd2317rnL13xXvZtB8jjgFKdcAaPCl4szoRitKlzuusMYja1frHeozjZ8mUn965mIqIJSQ3pt9Su2eq1kme+wsw2i5jxsece3f6eOV+dTEaY1pt+Wu8LrGOttZvzgKM9Xf5qJNRfdB3JST2VOPNQI/8lWXR1/vNRTBUiJ/nEFB3x3Ynq+uzdvnKjHjRsbdpXcrjKNodQ+ZFVt8M8nrLhv0vYLsx7Ci4tFJoI8GkVT6kG1B+STLclQcv31dVc3YrSbGm2IteGGdkDjloNzhWcLbccJJvHdlpiu6Du6eoxL0jEbOOKDODBNm5pLxV7B6SMuYreWMxKWSrWhpkZxiMMk4KYaMhovkFuN/B8oSLcdZ5XN4JLsEUkWF9HYFX2LcWj6ub/NiRXjUzAagNp/VYsD+6fc1k638pKXNzA+SWA15oY5iU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186003)(76116006)(316002)(4326008)(64756008)(8936002)(8676002)(26005)(110136005)(83380400001)(86362001)(66556008)(66446008)(66476007)(66946007)(52536014)(5660300002)(71200400001)(7696005)(478600001)(33656002)(38100700002)(53546011)(2906002)(6506007)(122000001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?T0EzeXJ3MWZ1OEp3VXBVeHpxYnhMQldmWHNlYlNFVXFiNEFyYzBoTHd3WjNB?=
 =?utf-8?B?S2F0dkRYWlg4VmNpdjNZTDlPamVSM0p3YnptclpERTB4dFV3KzJYSlZ4TkRa?=
 =?utf-8?B?NHVEVkxVVmZGSlNKcHB1NUlMKzU4enRMNW5zTWU0RXBubzRKQUVjU01Cd2pJ?=
 =?utf-8?B?cktBS3N0WXYvVmVQTVRLdHIxUnBUUkU1MXdJVVMxR3JiYlVKckR2cGYxcUp1?=
 =?utf-8?B?VkROY0pSdVdUdFJza243VHdJS092NnJZNXdra2RHTU94TGNqRGo0MFljRnU3?=
 =?utf-8?B?SEI3Q0VjMysxUmI1NkJKb1RtZy9CdjlnTE8yV0pQZVhqbHJxRHF2QjdZalZr?=
 =?utf-8?B?S3Rpb3ZDMDYzQ05xczcrbDFMR21FSDRxQ1Qzc0FjbGNXNDkvTnlrL3JrM3cv?=
 =?utf-8?B?K1BoTXZTUEY4TW93YkNlVm1HRnVOTnBEU0ZTd0FZQzF1M3ZKcEt4d0orWnh0?=
 =?utf-8?B?Y21KbWY3ZGJ4Q2ZqL3pwQkpMbGxPY1NRMXdoRmFxcUE3YWtZRjQ5dnV1d3ZP?=
 =?utf-8?B?NkpOYUxqMGdFa3k5WkFUVjBLT2ZJUTZkUlUxMGV2aFBUa2drR2pxN0xXV2Uy?=
 =?utf-8?B?d0hYdUhlcjFzeEt1QWpQdDMrSkUzQnBNQWtOR3Bxa2hYM1VPdzRmMWdZdFJX?=
 =?utf-8?B?Z1hXajdaNXg5b2tXbDg3SDUyeExiUjN2dWFWclNmMmZ4Mk1kR2oxaXBHbWln?=
 =?utf-8?B?TmhBRmxnUlpycTlYZnRFeUdsTDJmLzRIT0l1Q0FJTkpUSTRvTGtZTGxaWksr?=
 =?utf-8?B?SU81VnVIS01oWTlmaWdydnc1TUgvWlhQdVEyYXZCUE45QUVTSXpXSm1TTVh0?=
 =?utf-8?B?WGVVVFU1UUI3Vlg5REtUc2RJUVIrK0RvQXVZWHNtallRQXI3T1F5TlhUM3cr?=
 =?utf-8?B?SHplb0g1NXRkcGdBTnZ3YnpveElHMDcrSnBaV21zeVJEb0swQ2xVaHNPT25L?=
 =?utf-8?B?eVZwVFBqdmx5WG1adUtWRHQ1MVphREVXMG53ajM0WEdsMWQ4S3pvS1ZJZGdo?=
 =?utf-8?B?Wkp6emRwdEJNbnVsNUVLVmpHQ0NWbEF2cFVta3RYaWNLTWJyUGw4a2NiS09K?=
 =?utf-8?B?djliRXlqRmEvRGFjWWppdzZERG9lMFFjc29MaFIrcFc5Zjk0eGpDK3pmTFNW?=
 =?utf-8?B?Z0lublVEZHJOd202clN2SXEwbWkxS1l5MTlNcWZ1NGN0RldZekNkTVJ1MGo3?=
 =?utf-8?B?VGJiY1AvL3k4Njl2eVIxdjRyWXZHOGxwOUNVbTdvK2xXR1NvU0ZudlY1QllI?=
 =?utf-8?B?NGp1Q1BYMG5EK3JVMElJelViSTlJcDdzQ1FOL0xVVmJtemR5SjJxVURBY2du?=
 =?utf-8?B?SlhTbFllT29USGFQelRlSHR5c0hMWXF4b3dlTlJTZjNnZlM0dldkbzJRZlRy?=
 =?utf-8?B?TzZiRWtnNEs1YUpiUWJBOHV6cFFIN3dBYW02czZNMlpjSXNnd0tPUXVEWFpW?=
 =?utf-8?B?S0JLRXZINC9VWFpici9JQWhQZEdHMVJKcVZLQnZ2NXk2S2hWdkhiYkJQQlVn?=
 =?utf-8?B?SnBMZ2YzYUpBdFk2VWFudVNCSUtuUk9WQkFZbFQzeFlNcW1haTR5RldQcGNS?=
 =?utf-8?B?Ny9zejhVTWozdFdMdGE4bjR4cm9JZ25EVERPR0d1cWszOGUyQ2RqSFRVUmli?=
 =?utf-8?B?c0hBRHErb0U0Tit6WUN0V08vNWRwbVY3UDhROFZUdnFhbTlvbTZPNFRjajZW?=
 =?utf-8?B?Y05ybXVRcVZVZjZiVm1Wa0xUclpqUHVrZEVpTEQ0M2k1eTM0OEdrbFhhczJ6?=
 =?utf-8?Q?NGDjAYppS0nF6eIri5A+sNgnkXv5UZqw3db05oN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e55e4c-e244-40b9-5c3a-08d92986af05
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 07:34:28.7796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9MpL4+ooqkcdedcNf/x+xbEShtEuQkU3FmX600BKLoeB4BQAjhMbbbyOUcpI3Z0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Lijo,

I got your concern. However, the problem is what amdgpu_smu.c can see is SMU_FEATURE_xxxxx_BIT(e.g. SMU_FEATURE_BACO_BIT) related.
While the bit mask stored in feature->enabled is FEATURE_xxxxx_BIT(e.g. FEATURE_BACO_BIT which is asic specific) related.
So, a SMU_FEATURE_BACO_BIT to FEATURE_BACO_BIT transfer is needed and for now this asic specific operation is performed in smu_cmn.c(smu_cmn_to_asic_specific_index).

The possible way to get this optimized I can see is either
1. try to fit this into smu_cmn_disable_all_features_with_exception()
2. make the bitmasks stored in feature->enabled are non asic specific ones. This will involve extra efforts and risks.
I personally prefer the approach 1 above.

Any thoughts?

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, June 4, 2021 7:56 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature
> status
> 
> 
> 
> On 6/4/2021 3:28 PM, Evan Quan wrote:
> > For some ASICs, the real dpm feature disablement job is handled by
> > PMFW during baco reset and custom pptable loading. Cached dpm feature
> > status need to be cleared to pair that.
> >
> > Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> > V1->V2:
> >    - correct the setting for baco bit(pointed out by Lijo)
> > ---
> >   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 +++++
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 ++++++++++++-
> -
> >   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
> >   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
> >   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 25
> +++++++++++++++++++
> >   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 +++
> >   drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
> >   7 files changed, 54 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > index fb7438224872..3f9b2a839a37 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > @@ -937,6 +937,12 @@ struct pptable_funcs {
> >   	 */
> >   	int (*disable_all_features_with_exception)(struct smu_context
> *smu,
> > enum smu_feature_mask mask);
> >
> > +	/**
> > +	 * @clear_cached_dpm_feature_status_with_exception: Clear
> cached dpm feature status with
> > +	 *                                                  exception to those in &mask.
> > +	 */
> > +	int (*clear_cached_dpm_feature_status_with_exception)(struct
> > +smu_context *smu, enum smu_feature_mask mask);
> > +
> 
> Since this is a just a utility function which clears sw bitmask without touching
> hardware, do we need a ppt_func? In case that is needed, we already have
> this - smu_cmn_disable_all_features_with_exception. So, can't this remain
> as a standalone smu_cmn function which can be called from anywhere?
> Nowadays, I get a red alert when a ppt_func gets added :)
> 
> Thanks,
> Lijo
> 
> >   	/**
> >   	 * @notify_display_change: Enable fast memory clock switching.
> >   	 *
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index c9a31556e077..aba475d06507 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1352,6 +1352,16 @@ static int smu_hw_init(void *handle)
> >   	return 0;
> >   }
> >
> > +static void smu_reset_cached_dpm_feature_status(struct smu_context
> > +*smu) {
> > +	struct smu_feature *feature = &smu->smu_feature;
> > +
> > +	mutex_lock(&feature->mutex);
> > +	bitmap_zero(feature->enabled, feature->feature_num);
> > +	bitmap_zero(feature->supported, feature->feature_num);
> > +	mutex_unlock(&feature->mutex);
> > +}
> > +
> >   static int smu_disable_dpms(struct smu_context *smu)
> >   {
> >   	struct amdgpu_device *adev = smu->adev; @@ -1374,16 +1384,21
> @@
> > static int smu_disable_dpms(struct smu_context *smu)
> >   	 */
> >   	if (smu->uploading_custom_pp_table &&
> >   	    (adev->asic_type >= CHIP_NAVI10) &&
> > -	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
> > +	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH)) {
> > +		smu_reset_cached_dpm_feature_status(smu);
> >   		return 0;
> > +	}
> >
> >   	/*
> >   	 * For Sienna_Cichlid, PMFW will handle the features disablement
> properly
> >   	 * on BACO in. Driver involvement is unnecessary.
> >   	 */
> >   	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
> > -	     use_baco)
> > +	     use_baco) {
> > +
> 	smu_clear_cached_dpm_feature_status_with_exception(smu,
> > +
> SMU_FEATURE_BACO_BIT);
> >   		return 0;
> > +	}
> >
> >   	/*
> >   	 * For gpu reset, runpm and hibernation through BACO, diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index afd4bd850c63..8c3ea20fb0f6 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -3083,6 +3083,7 @@ static const struct pptable_funcs
> navi10_ppt_funcs = {
> >   	.get_enabled_mask = smu_cmn_get_enabled_mask,
> >   	.feature_is_enabled = smu_cmn_feature_is_enabled,
> >   	.disable_all_features_with_exception =
> > smu_cmn_disable_all_features_with_exception,
> > +	.clear_cached_dpm_feature_status_with_exception =
> > +smu_cmn_clear_cached_dpm_feature_status_with_exception,
> >   	.notify_display_change = smu_v11_0_notify_display_change,
> >   	.set_power_limit = smu_v11_0_set_power_limit,
> >   	.init_max_sustainable_clocks =
> > smu_v11_0_init_max_sustainable_clocks,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index b4a2bb0f3f4c..14a14c30ee5e 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -3886,6 +3886,7 @@ static const struct pptable_funcs
> sienna_cichlid_ppt_funcs = {
> >   	.get_enabled_mask = smu_cmn_get_enabled_mask,
> >   	.feature_is_enabled = smu_cmn_feature_is_enabled,
> >   	.disable_all_features_with_exception =
> > smu_cmn_disable_all_features_with_exception,
> > +	.clear_cached_dpm_feature_status_with_exception =
> > +smu_cmn_clear_cached_dpm_feature_status_with_exception,
> >   	.notify_display_change = NULL,
> >   	.set_power_limit = smu_v11_0_set_power_limit,
> >   	.init_max_sustainable_clocks =
> > smu_v11_0_init_max_sustainable_clocks,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > index 0ceb7329838c..b9c38abc9d37 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -594,6 +594,31 @@ int
> smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
> >   						   0);
> >   }
> >
> > +int smu_cmn_clear_cached_dpm_feature_status_with_exception(struct
> smu_context *smu,
> > +							   enum
> smu_feature_mask mask) {
> > +	struct smu_feature *feature = &smu->smu_feature;
> > +	uint64_t features_to_disable = U64_MAX;
> > +	int skipped_feature_id;
> > +
> > +	skipped_feature_id = smu_cmn_to_asic_specific_index(smu,
> > +
> CMN2ASIC_MAPPING_FEATURE,
> > +							    mask);
> > +	if (skipped_feature_id < 0)
> > +		return -EINVAL;
> > +
> > +	features_to_disable &= ~(1ULL << skipped_feature_id);
> > +
> > +	mutex_lock(&feature->mutex);
> > +	bitmap_andnot(feature->enabled, feature->enabled,
> > +			(unsigned long *)(&features_to_disable),
> SMU_FEATURE_MAX);
> > +	bitmap_andnot(feature->supported, feature->supported,
> > +			(unsigned long *)(&features_to_disable),
> SMU_FEATURE_MAX);
> > +	mutex_unlock(&feature->mutex);
> > +
> > +	return 0;
> > +}
> > +
> >   int smu_cmn_get_smc_version(struct smu_context *smu,
> >   			    uint32_t *if_version,
> >   			    uint32_t *smu_version)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > index da6ff6f024f9..12ad07132d15 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > @@ -77,6 +77,9 @@ int smu_cmn_set_pp_feature_mask(struct
> smu_context *smu,
> >   int smu_cmn_disable_all_features_with_exception(struct smu_context
> *smu,
> >   						enum smu_feature_mask
> mask);
> >
> > +int smu_cmn_clear_cached_dpm_feature_status_with_exception(struct
> smu_context *smu,
> > +							   enum
> smu_feature_mask mask);
> > +
> >   int smu_cmn_get_smc_version(struct smu_context *smu,
> >   			    uint32_t *if_version,
> >   			    uint32_t *smu_version);
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > index 33101dc93bcc..b12dcfab55fe 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > @@ -58,6 +58,7 @@
> >   #define smu_feature_get_enabled_mask(smu, mask, num)
> 		smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
> >   #define smu_feature_is_enabled(smu, mask)
> 	smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
> >   #define smu_disable_all_features_with_exception(smu, mask)
> 	smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
> > +#define smu_clear_cached_dpm_feature_status_with_exception(smu,
> mask)	smu_ppt_funcs(clear_cached_dpm_feature_status_with_exception,
> 0, smu, mask)
> >   #define smu_is_dpm_running(smu)
> 	smu_ppt_funcs(is_dpm_running, 0 , smu)
> >   #define smu_notify_display_change(smu)
> 	smu_ppt_funcs(notify_display_change, 0, smu)
> >   #define smu_populate_umd_state_clk(smu)
> 		smu_ppt_funcs(populate_umd_state_clk, 0, smu)
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
