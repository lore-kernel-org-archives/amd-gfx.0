Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8238BC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5050C6102A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5050C6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014C26E041;
	Mon,  7 Jun 2021 08:04:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C7246E041
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 08:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3PmlGWh4PwsbMwwmlJh103mpm9NdCG/6dScMMKKIO6t7qAzkt6nJBBEoUZfrf+tI2mqWppXedhQLqfOODcilTLTa2QJel4/LEt3IE9nohfA8FhO/qzR3RzUcL0wqGHo3l3R/DV+42Fr071hcCaRVaQEl0o2l8CIIIFccAl8rrJTYPYmVbGCeNmYxmIV7E00B/I0v92JAfstMj2FRzg/yFPepUwPQx79nZkAQTz/70aMM/310rP2jziPXTHSpX9/WwG/flcAV4rTI0UT7QUNAKltJI68fiu3KIiwgRHorgFEn5WSggYgDAmouccEXk4xEjtjoRQfE5FhKQ3/OCZdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JSE+U9yIuCbrW8nckTvvfEuz/TKXoBHInKxTKp7bpU=;
 b=IMAPUVTq20olPV9Q3YcmUi1QWw2+S5Y7dqumFk7vBV0hkhdaUItvMLE5o8nPUqaR0QLAadclIBBuLqFY9yhWadHON8jMICqv/ajLndthF5T9fnMUt/4lzfxZoglX71PBZiznq7TSePD5/lzex+0+pksLsf6EAW2c/jorqUGeKXuZSePPSzybMn2dTjyxE36PKYwrBLGQCh6oTaMVHcR4vGvW3GY+VyZvZzocR6ZlCnX6hbHdma5p/8g+0LEJNU7NfZqUBmaHS1S0z3U/ZQNk1cX6pPUR797r5nPYV9KcnYLYCkZNL36xYXiGjLS0Fsm8ZsJZeJ6VU9fpbxBRMSVHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JSE+U9yIuCbrW8nckTvvfEuz/TKXoBHInKxTKp7bpU=;
 b=JBiCXbtBS1sjN2o0hXRm4zr13+k5K1PcmR0t3zsxHEwupjW2x2YlxIxrEaQh8OL5dlx0ofhVcmlokenVrvniDDuPkqGD5L+sp0b8wsCkGX9ZDdo0IIGJo7CwXe3lzJi0aEGmB2/kczZF7QIo9X3zMlUmNWTiSlsRMBMc9p+03wY=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 08:04:31 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:04:31 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status
Thread-Topic: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status
Thread-Index: AQHXWShNb8nsgCc6J02D0BC4U3T4+asDvucAgARt4ACAAAOUQA==
Date: Mon, 7 Jun 2021 08:04:31 +0000
Message-ID: <CH0PR12MB534847E329700B54168C4A1797389@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210604095823.1403271-1-evan.quan@amd.com>
 <20210604095823.1403271-4-evan.quan@amd.com>
 <83d7ff01-061e-707a-0774-fc29e05c2684@amd.com>
 <DM6PR12MB2619D1A458C9D391A5A57EE8E4389@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619D1A458C9D391A5A57EE8E4389@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-07T08:04:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e3db6208-c94d-4b2c-805d-4f6d4b07e045;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.222.150.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea3d085-04ac-4eb0-38e8-08d9298ae1b8
x-ms-traffictypediagnostic: CH0PR12MB5092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB50924A8D9B353FBE358C555697389@CH0PR12MB5092.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q4n+dg1z5YgIBXemN9vGgctQVRSIL4JStjjPPnQKf06PuuMxND41bJ2mg4cQKlcTOHCCQmcdH1IsrbvJ+iVdgvxTr1txq+Ye1JXtwpgRVA93fUnW9Kdu/cVm0QzlnmPOMsMQW5f3mEWH+32emo2VGoNuUrw/2TjfrlT+C3vLRnTZ5kQOX9cnGUenaqN1mUt39TIycBpfJsaPo6Xbv69ZHssxAtoLmTvYFtqvnqWa7XEmW+ia5VHDtILy3dB7Nf2uvR/O6wQrE8lxpiH3ArMcTy7EGBJDJE7Mig3zyFaPxmOxzkb7whxca4ymdd0oN4h/Z/nBWHyT3CnSrq7d7UOEHNGRzm+JTI1Bbor2pD4yR5IRWKU5DFaLPKkUIZqsBESlvOP2f8HvW2hWUX7HozRIdJNnFupXnjgVRVsoUT4EWKxMBEy6aHENAu8bNkJOGjWaili2oH6e/29p//5Wnu/6CZf0YX/6X9RTDCJrLoWNlvrsDZGR7RbNXum3HOj4mhre5QxPNu4f13mLsu+Tjq/WDaYmzY8ffDhpq34Vvl0P9Lzjk4SzV6d2hKPIJP8USIPYIrtEL6XKJvIaStTUmy7GJLl0Cdrt6H1Y/L8ky1WIQZ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(76116006)(33656002)(478600001)(83380400001)(7696005)(6506007)(64756008)(86362001)(8936002)(71200400001)(122000001)(8676002)(38100700002)(30864003)(110136005)(316002)(26005)(5660300002)(2906002)(9686003)(55016002)(66476007)(66556008)(66446008)(4326008)(53546011)(52536014)(66946007)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RndOZTQ3R1grU3BlY0hiZzMwaVp4V3ZVSjhEdVAzN1NscUlYaktBQytnQ3Bq?=
 =?utf-8?B?K2E2czN5eHJPU1M4QWIxL1BrK05qTm9TUWhUeVVVYzRYb1RkNHdubTY2SVI0?=
 =?utf-8?B?SWhFWWxqQkM1eXhGU296UUZvdHVqSndwNE53NXJkbDNGT013dTVyOCs0OFBi?=
 =?utf-8?B?RVYxRmdEYzlzOWg2c2RWQ2xOeGttMDY2eUZ2a3BxQzFZOXZiMXJGejZGVkln?=
 =?utf-8?B?K0FCeHNNV0VONWs0cXdhV29hcHVyVEhJYkFOMzVtTFUwcG4rQTJNL2QrdjZF?=
 =?utf-8?B?NmRBZHNZYUNaU0J5cHlHUS9rRE1GRExRYktrbkVvOEVmcW1adTFxenRheWdG?=
 =?utf-8?B?Z3VtK2ErTlhQMXdIUGhUTysxYkFSblJCOWZtemYwNnJBcmlZNGZDM2pWNm9p?=
 =?utf-8?B?WElBSHp6NEN0MWpsc3M1aVNTTW4wb01BR0hZeXM5L1lOajZYRVVHSUVWNjVz?=
 =?utf-8?B?SnRUUDd0aDNqN1JaWWVrdzNEWTNXaEdsSFEzWWFqWXhxeXBDK1JDR3B1emxL?=
 =?utf-8?B?eFc4NVJ0YUQ4RWZ6Sm9oWnBRTmdmOWV5MkJmanVGS3h4K2R6b0N1YjdqYU9i?=
 =?utf-8?B?ck9tUFNwa2FmNmFjWnk3SVRtL3pqNnM2UVRLaW9NZWpsU2lYaC9Gb1FERXFV?=
 =?utf-8?B?WW9EWS8reHN1S1N4bjZhR090NjN3aGk4UER4ZHZRYmZoajJXQ3h2NmdVMFN2?=
 =?utf-8?B?RE84WUJld3FRNjlFOTI1cERmWjhCTTlLd2JHNXo4WTZ6dWRSU1Q4eU9NRllM?=
 =?utf-8?B?Y0dBV1Q1S2V4cE9kRjNWblBZUkdUUzJxRHl3SS93ZkxqYWJVbEl6NkN5WTAx?=
 =?utf-8?B?WEtqdWxTbnFnOXJOb3U4cDNvby81MnlQL0p3eXh2Tm5QbGd0VzhvSzFhRVVQ?=
 =?utf-8?B?SDZITGlqcUtOZENHK2tDSTIyVE1LbUd4ZEE3QlBWeUNCaFMxa0hTeUgyMWtR?=
 =?utf-8?B?T3NuSlBZM3QwV204Qk1mM2FtTWl2dTFmWUdFT2lxZkZHUkZ0U2tZZnhjc1Vy?=
 =?utf-8?B?YUxxQlNiQWpwcGZyZmhaZmZVVVJoSTlTbXlkMkNxYTV6UWxOV01pRkY3eklo?=
 =?utf-8?B?Zjh4K3VmbHVFYTQ5U0p3R3BwTDVEaTRLSy9SQnY5UkhkMzVzbFA0TlFJVU5l?=
 =?utf-8?B?WTJnblhnd1V1dGIvTURvTitiZFc1YTFPbjRQU1pJVisrZHl6Y2dhMnhMM3Zj?=
 =?utf-8?B?RVZpVy9tTDFoaGNnRDFWOEJjbmY3SXF2WWNUZ25PQWlQRG44d1lSYlUwVDFo?=
 =?utf-8?B?WjVXcHZGdDVQOEpCNlk4eWduM0JyNDhhakNNcmd4eXZrS1F1ZVdkWWNiYW1r?=
 =?utf-8?B?WStpOEtPWlMxWEFRYVBwSUUwT3BRVEV3Sk00VW9rTGg3UmU5Y1NOSlZYcGdN?=
 =?utf-8?B?WTRqN1BncVJlN2RkTzJCcHZaSzBjVWkxWE13cVhKdDM0QW43OFgyYUdKWFlm?=
 =?utf-8?B?S2VXQlVCWUt3Q1hJdWUxUjkxUHY1aXh4SFRTNzd1aGUwdFhkdnVzOVpBUmo0?=
 =?utf-8?B?N3dqcEhQL1A5Y01mZVBTQUg3Yk9mUjZWUkdjeWpPd25DejA3dXNaVElUU1d6?=
 =?utf-8?B?RUl4c24rQ0Y2d2Q2QjlNa09IQ2Z5NkJYK3JXbERVUTh2NHEvVkhhUHl3dE15?=
 =?utf-8?B?eDhoVG9kbHNhdzNOdXk2c0pZZHl3SGxIRUJpaGZpbWZsUmF3UmdFQUltV3Vq?=
 =?utf-8?B?a242bXhsV3F6cjY5a09ydEtnTjZDSGNNaTFxSHZ0SGg4OHFSc1Nna1gxZWZM?=
 =?utf-8?Q?IH5CDWJ13XTBIBhvXnilrPQn7NA4XoM+wmOVnzN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea3d085-04ac-4eb0-38e8-08d9298ae1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 08:04:31.7414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Sey7c3HpbuMWuQXvAk7roLbECMQdipAdKwILLvZbezcM6zhlD+f2mBMz+ipCnl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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

[Public]

What about separating to smu_cmn_utils.c/smu_utils.c or similar which is meant for software based common/util functions?  In general, it will have sw based common funcs (not ASIC specific) and may be used outside (for ex: in amdgpu_smu.c). smu_cmn continues to have the hw based common/ppt_func routines.

smu_cmn_to_asic_specific_index is also a good candidate for such a function as it fetches the sw lookup map (may be moved later).

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, June 7, 2021 1:04 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH V2 4/5] drm/amd/pm: clear the cached dpm feature status

[AMD Official Use Only]

Hi Lijo,

I got your concern. However, the problem is what amdgpu_smu.c can see is SMU_FEATURE_xxxxx_BIT(e.g. SMU_FEATURE_BACO_BIT) related.
While the bit mask stored in feature->enabled is FEATURE_xxxxx_BIT(e.g. FEATURE_BACO_BIT which is asic specific) related.
So, a SMU_FEATURE_BACO_BIT to FEATURE_BACO_BIT transfer is needed and for now this asic specific operation is performed in smu_cmn.c(smu_cmn_to_asic_specific_index).

The possible way to get this optimized I can see is either 1. try to fit this into smu_cmn_disable_all_features_with_exception()
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
> > PMFW during baco reset and custom pptable loading. Cached dpm 
> > feature status need to be cleared to pair that.
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
> Since this is a just a utility function which clears sw bitmask 
> without touching hardware, do we need a ppt_func? In case that is 
> needed, we already have this - 
> smu_cmn_disable_all_features_with_exception. So, can't this remain as a standalone smu_cmn function which can be called from anywhere?
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
