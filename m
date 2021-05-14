Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3076C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 03:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792A06141F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 03:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792A06141F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA98D6E19A;
	Fri, 14 May 2021 03:47:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3482D6E19A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 03:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn8HToJcQUhOKa8PYmoVC54k3ly2FBiT+eIhy+bbykaaJJZFVOoSp0El8sufglwvUwwLC4gky4ncLosdaoStlCf7WT6+xBXe3XXSv88ks8gxhShImp1KUB0yEHv8bUdxjWBa40VJrGmrrmz0Hdit4dIeD69pHp4FsO8pplOWjlL/B2awOTK5KgN5vdUIuTPot4206fxm0DeSzmdZlXHKlMhvxyVsm7nh1R4SRdXsAiTRzZyJZS8rJGRdAT7gpY6OPFkxmQBxBJT/xUopBzEhdLZAc1UY2vEJS6tE0YOTEHf9JWfg6qf9VIOB/X50mxpnX9ij/f1i2triK58LCpWBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NenYegzbL0XwwEOeferZFJkOA2F01AFZofDBkI9Xvo=;
 b=SiJ2O4LM7aP//7LTs9L/T+IsLkhWH+de2yWtZ2uEeHuwa4RBc8kDYOhtm7jUTMT6gpzlLzo5eStdDUJbHOvfpchnZmR1cHJSCkrpa+h8F7/kBScSkPtz7T/EZ4c68jGiGNKhF9iil2W/UfwN450U5Kgs56RNwKjg6pUlQLzKdvfR0r9AAfCQMbz0TCpBzGxgBV9U1L5QBpMEtu2+BOPlw/KFxM5LzIXPYYnKqeKednJtg7vCkcHG9p1ZBKTgkEJExw2VQtNpqVVq/UXrbqSQIY7GxZWdeM+hkQZABSdBdrRS36mhTvvAmX8d8rlsD1QDB4MmysKFXp/f96J8X3jmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NenYegzbL0XwwEOeferZFJkOA2F01AFZofDBkI9Xvo=;
 b=1EmlM9Ma+Nll4wtV2QFDg9kOEFXN20jXQ2N+eRGER5vHoecIFO+UoXz1+fSwtwS3fNSv0LJOM0pH+oMY6eUK1GUU9bEYTmlulSAfC5fqRsxAHT/BaZnKNFk4km8XeAhy/lySrxA3BDgHIE/D4AQWmEPCt8f3nJLxOhHZV2MZeHA=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 03:46:58 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4129.025; Fri, 14 May 2021
 03:46:58 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Thread-Topic: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Thread-Index: AQHXR8L16W5YG33TlkyouVsmvlLg0arhPsmwgAEGMWCAAA9LgIAAALhg
Date: Fri, 14 May 2021 03:46:58 +0000
Message-ID: <CH0PR12MB515632660C14957DC10353A4F8509@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210513064051.12930-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51566C4310A9E3644BCAA9E0F8519@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CH0PR12MB515669BD1D8D0402206D641BF8509@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CADnq5_M6C7dNsWxNzJXeRWbMF10sT5BVcq-3S5bGvavM96pFcA@mail.gmail.com>
In-Reply-To: <CADnq5_M6C7dNsWxNzJXeRWbMF10sT5BVcq-3S5bGvavM96pFcA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-14T03:46:51Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9894e23b-18f8-4a2d-b51f-9fc8bdd19c92;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad4f393e-504d-47d2-ad16-08d9168aed11
x-ms-traffictypediagnostic: CH0PR12MB5316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5316B736A23483985A1AFBA1F8509@CH0PR12MB5316.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4a60P3Br+6TowL/iC99j/zcXMVYPZ3aQrPKZ1Sn3T5WQLPv75iNUfOx//qJ4wnekw0pRe3jGzvj4RtfDtI62+NSugRP/2EMYenVxK6B5nicw1begVAiJTG400vEje43Bl9N0B+vyhmo2SZPrhjWMJmTtbstQa6qbmg+D3pD9R4LlDdjpKQ+uCiXW5xrNVK7n9RcAy2BO9gOoIwHlNbqb8JbdyGavqm4wY3iZ8nZZfLCbRwoplsZuOrT611HQzdueDQ2j8puBx9V8npd3TUQjTRNTUObBQ3Qj3bEzmdlLdKsEkmFkcpDFRabqPjyG5aiXJnz3q6pd115t8POQz4liE5bpeCcEae7FxHY8On9JMQYOKVk0SSQ/BWBdnBXMEyJA8dXfGlaGmmY0mBn6wpXvzuA9Ba4cNsSaQOhBFYiNWzmx1cbeT0aCO6HthrgTobC7wOEEVnuCSxDel7c+YuX+gKdVLxPP0F28ddA4o2BqaTqJrBJTyFbGODPw8S08znkoNYe/X678KC86uFjOvf/HZDOxhNrVB61wHmu0P/caN9e27GKGF7HyGyVsHV8aWGFfc7it2BrRPVCaCQk7dOctU5NLJvwu8H1lWovRg+qkA2ZNA1jAJmVCWyh5vF0i/Eon6iRD/Blgm8OWeJZQxK/NCK3rxOCAo6EWooDnw/ZRYshlYBHaK+BRIhjcha/PBQOq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(71200400001)(7696005)(53546011)(6506007)(26005)(966005)(122000001)(38100700002)(8676002)(54906003)(86362001)(8936002)(33656002)(4326008)(66476007)(66946007)(478600001)(6916009)(83380400001)(45080400002)(55016002)(52536014)(5660300002)(66446008)(64756008)(2906002)(66556008)(186003)(316002)(76116006)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t/gaMHa+vFbtJFsuiVmvwnGMdY7Jb81WiTOFbZuphjVjWZjP+LLcWYrU/euK?=
 =?us-ascii?Q?Zzq0bY0mD8jN37YB+YYtFIPSkVzHBMmXxmyIbVF+UORH3QVN4UAgK7z34bGk?=
 =?us-ascii?Q?LcnDsf0Cs0M2E1obnfo43A5xJXhFwWTiKd7Gsw0oBAp2ExPTtfzV0DAJTt3k?=
 =?us-ascii?Q?knZUZXFf2Jh4cySmbsslJcau0UZEtCI8US8bLq9ABDxrdxJDlMxGuK331ym0?=
 =?us-ascii?Q?KKIj3/6NnspoaHyVv3RPXHy+luMejYM7+2uuo8Py3MC5GI/kaW9ZQNhx/3YW?=
 =?us-ascii?Q?fnNcPdse4uytYDcu2l0fQfZwDpq2TAH4p/ePVzsuuVYKREvONAe9AiUHUmFG?=
 =?us-ascii?Q?PQXHGb/H0q05ZVG5yRVFb9MPTqNJ7pK9IwCn3zGA0I+deDARTJPgsYtgp2MC?=
 =?us-ascii?Q?DhXcbYnAImV/wDL7aox4kNIeyqouFMlSlcv2riMwdrE/rVYN5iNCjgNTKR1O?=
 =?us-ascii?Q?NYohpm6sFMwv4YJUj+YSjjZzGjLXEHW+PxhmiLmIb3/shKFvRackuOh8p+6b?=
 =?us-ascii?Q?+uH420TAzgjug8EK4FKh6Li9s++KT7Dr+8hLgHjq1DYqzj96PRER5Uemfa4Z?=
 =?us-ascii?Q?Xre3kRaoaISQzw3PfYSuFIFzjpGaaDFoXCV0/EogTUxzJmqu0OxwqPr3Bt/N?=
 =?us-ascii?Q?HCajIjl8A8icGlZyMdpSwS6vUrdib2xEdj+uv7F3RdY5MLJ+WLFK43kyfc4r?=
 =?us-ascii?Q?qOoQYTEI5I0ZntBBm4w8K4+hQl9RQfguLD7EYr9Yx/Mp/WOMUVDvqE1lUpni?=
 =?us-ascii?Q?dQOsO1lrLK6+hy8sLUhGPlsq0/Z+ypnn6Kon6c/4o/HBLf8m2997iq+p497h?=
 =?us-ascii?Q?dmDvCOUjz1RgudQNj64BrHVqntBatUmFUd6fKJvdv9u5wtY0NYMyNdB8cXUq?=
 =?us-ascii?Q?OABU2M7mYQExoyE9lcBIg/hrl4YbHEN8OoM1W3l5FYMAkL0AzU8rXgJIMMB/?=
 =?us-ascii?Q?sSvU6hGv/91ot/CBPX98Joec3XWe9W/2tSsISefMcCWvPEJpqremws+E8sN2?=
 =?us-ascii?Q?A3YU6YfMFqvQvY/vySOLtjdjFCR/U4zAFFqQa9Gzbhcuc6MC03FRszzeXHWD?=
 =?us-ascii?Q?g6nDp/KTXb9DC/9qrhpIaUcD9xsxknxRuFmpHNQPsJy+yCtblDbasJbvuf9a?=
 =?us-ascii?Q?O4zbCQoXuGpipYSXXz0+svam6CdOSxKaxWmTHPEEcz4YwElPCpr4gcKQS2Q6?=
 =?us-ascii?Q?R1rjVtxyvAyS+IAWjMHRmTRh8YqPfH7lPENijnIJ0GrjRSSfRHYnrOn7zdD0?=
 =?us-ascii?Q?WnWApUa4cXwFurQg3Joepysy2m7olzrMnwyZ6yVAAyGHNj40C7fmfSTQVVOQ?=
 =?us-ascii?Q?9YMUGQwmxf9BOZ7zoqI0mvdD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4f393e-504d-47d2-ad16-08d9168aed11
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 03:46:58.6719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgbmSLuDPp82S+YUKy5CqZf8BYz/2iNY4xPX/olVr/Fx2OTMOkbW98v3KwA2fqQ5JU66ypQRGjktJgWLlfRgdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Nieto, 
 David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

unique_id is fetched from FUSE_DATA on hypervisor.

Under my experiment, both multi-VF & single VF can still read FUSE_DATA to get it.
But per David's info, guest shouldn't be able to read it (though it can currently)... 

So I guess in design, the unique_id should be only fetched from hypervisor in SRIOV case, and guest should always get it from host.

Hi David,

Please feel free to correct my statement / provide more background.

Best regards,
Jiawei

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Friday, May 14, 2021 11:33 AM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg

unique_id is normally fetched from the SMU on bare metal.  I guess in the SR-IOV case, this would come from the hypervisor since the SMU is not normally handled in the VF.  That makes sense for multi-VF, but what about single VF?  Are you sure the ordering is correct such that the SMU value won't overwrite this?  Maybe that's ok because they would be the same in that case?

Alex


On Thu, May 13, 2021 at 10:39 PM Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> pinging
>
> -----Original Message-----
> From: Gu, JiaWei (Will)
> Sent: Thursday, May 13, 2021 7:01 PM
> To: Jiawei Gu <Jiawei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; 
> Nieto, David M <David.Nieto@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from 
> PF2VF msg
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Add David.
>
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Thursday, May 13, 2021 2:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) 
> <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF 
> msg
>
> Initialize unique_id from PF2VF under virtualization.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a57842689d42..96e269cbe326 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
>                 adev->virt.reg_access =
>                         ((struct amd_sriov_msg_pf2vf_info 
> *)pf2vf_info)->reg_access_flags.all;
> +               adev->unique_id =
> +                       ((struct amd_sriov_msg_pf2vf_info 
> + *)pf2vf_info)->uuid;
>
>                 break;
>         default:
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJi
> aWei.Gu%40amd.com%7C8c5b87447e364531b89008d916890f54%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637565600188355261%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=Go8nw1HMA5I4wLJv2jk9hpSm2%2F0BR9nRzwwdAlJfttc%3D&amp;re
> served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
