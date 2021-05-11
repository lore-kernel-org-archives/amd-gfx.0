Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1991C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 16:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A976117A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 16:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A976117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E35F26E7D2;
	Tue, 11 May 2021 16:35:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5FB6E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 16:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewHuk286DsWGlBmCUi+xbQzeFTMdetj1B8JE3TZTqBGUHrX4VnXw3Ga11HBnwhUxBwn8VsdjA1PyqOWY28IzRLzd37/X2J+Sa8bHl/yQ4hZMuYyu57IfPezfwd1ti2Z0ffxjiXVehp8JCMG5SG5wtDyZJu/xBAJAr2ZQbT/K6zFrNu5F9sO79XCbfSJqS+o/yiuoYAfddzIZPh9K3A+W6SGvl5xcQBxlI2SMibcYXs9VkQyXD9RlWyXRNJAiKeXr6eS9thj6JhcopSRK5+zTANzLmrvcgWETvcMFrejtXiVG3iIggh4jAVo6OCmiu6FXz1G64AdjrMfP9Lo5N8RDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axzgfq/bWku8CD8pwPTxAgRcKqKcb+1AXbeTlhRfDDg=;
 b=Lb1AyZgl+7/ZOxsVKnFWNL1pUzyNukuKDMnEeNHlVKTSwEXLYn0Ly7i09Su+prwUAvEbKvW6NKAort2sl2C5Ak00mkUKacXG+/TbFtv6I7D5itZNORa+hpAn/Vrw32VnZadfSvFGJkPYSDUN82WVpdrbI+VlwVma5Ivt6JZN5Ds8Eb7lWnf1kvFs5Fn8SISXxmsdgu3GE6sxTywrPbnqyFt9p6OaCrKP2R78hTsTQ3wcVd7xB4o3VqzaZiqMo3xDQ0XbAO027PAxpplYmXltsoDpH5IGGJOr3fmhCjBSSALleNuD7f7AZHDV44mhoD0hmJ+t3KMZSaLPZFUm4SSOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axzgfq/bWku8CD8pwPTxAgRcKqKcb+1AXbeTlhRfDDg=;
 b=Ndlas3L/XC+ctgFWNGlrhO7aREgQinPBvNQLqgfRmhPW6+M+LKQKRFKts19aevv38CneE5QyohqWNUHTro2xozmr1hx/Gf5MonKhv8z3X+fM8Qom0u4aTThWvmJKga2RtJGe36m6rC/lsLWxqmhvzR/6ekEYusDlTBNH1UHlXMM=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3464.namprd12.prod.outlook.com (2603:10b6:a03:d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 16:35:42 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 16:35:42 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Index: AQHXQ9Yf8LVbEME0wESo6KxpkiJJJqrbUMIAgADxAdCAAAjk7YAAA0iggABtf0iAAANEgP//9+aAgAE2iQCAAAe/gIAAYKSAgAAA0wCAACc9sA==
Date: Tue, 11 May 2021 16:35:42 +0000
Message-ID: <BYAPR12MB2840E586673207558B7FC136F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
 <88e868eb-347b-611b-8d88-ba8d9d61c23b@gmail.com>
 <CAAxE2A73V5PLVgrcd+_KYYbK=n+POZajdVYMcMdj8A38KvTerA@mail.gmail.com>
 <MN2PR12MB4488E0D428871797E08DEE2BF7539@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <454dbf38-3337-de8b-6a29-30f417475121@gmail.com>
In-Reply-To: <454dbf38-3337-de8b-6a29-30f417475121@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-11T16:35:45.267Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [198.27.247.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 685c5e5d-a608-4993-2834-08d9149ad1a0
x-ms-traffictypediagnostic: BYAPR12MB3464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB346497432A42D29C98AEDDB6F4539@BYAPR12MB3464.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGNv2oDdfi+N5Vx5CC7Ylj4lcBvSixzXUzNfLXCLygKLv98sZLU0g+XGf+JhG62ULh3DwMlPd89PxwWF7FzKbkEOzxqq3ayZTveo+Qys2nvMgEe1JQOEFUUfCvSJLcDFHnT9JVDYBdCY3oaeAB2PbxbK7Y1Vk8dTwI5tdQomN9h4f+2NyjkHCeXZg2yn8UFjReTo4X3Ke2CFYbBqAfbtLKWtrblJB95ZiPZ5yyL9tnA8qHvQ1KL4/lmU0QjK0n09L93tWfbWxitSH8OnlINqRikjLDMGD59nR5/PkgK8isZ17aGMLuTTyxAN7O0LYRA7V6ip0SVnpRLyvZNX3CeSzCIMOGjOEy3NlCepkwN/ANL1O065EOuCyD6X89yt+IkDMkqv0kR6b1AcyyzpaE2xr0un0TtmbSMtBkKLeGrnzNnkhizhrSRNm3nAH1KQepWp2uIpO3D/NN1Qugy9fQX8oBo8AGJc7Mmk2SmE2+Fi//xWtOcif60xypyBIuK7S2NzrIuKGFp5yXp6orWHd0tbKCY10HR58FrGZX5HlMZcFXOg0g0AlMVJ7uKQ1hkTGPvCWdd3Bz0J95p4TSlhaeiZxevGfyPz44QPvWdZaFN745sJ6XzJwhSllaaGTgF92f0JWryZOF4O1cRmVuJM3hJ+Qg4czbSxCZWDy0bw5tYlmfXyXkqVKLxjOVfTF5a4ZzbH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(38100700002)(186003)(122000001)(2906002)(86362001)(66574015)(316002)(33656002)(26005)(71200400001)(54906003)(166002)(53546011)(7696005)(478600001)(966005)(45080400002)(6506007)(19627405001)(8676002)(83380400001)(8936002)(9686003)(110136005)(4326008)(55016002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?QoAL4S2vkjsOzSnwzGOxNe5GoJVg5SvltwbWKTzMOl3XmYNG0tIM3LtQ?=
 =?Windows-1252?Q?U6XOSskloKJ9vxB3bKRoeLXdO7DT/GJ2tpuy0/RbGdnd2oz5zJHpRY4M?=
 =?Windows-1252?Q?Jrta+CI9wv5XXlVefoWfoUn5tcXLRRx2Ra0/kxS+Uj1/+xYpbp79eLY+?=
 =?Windows-1252?Q?oF9YygTJcG9fbx0fJvy1W8zWPGBvF9hkYsXO3FJ2eedQeCD0xXysnFgA?=
 =?Windows-1252?Q?Ska8VI4yiE+pwIWxzR5mRDcp7Pi+heeZ34Ah+39y0N9OrsGo39c0C4h5?=
 =?Windows-1252?Q?QMfuLZBa3qfjn0QprXqudR1tE+ssy289Q6sVnJubw2ljvP3iI/syZa2V?=
 =?Windows-1252?Q?65utwfHqBNxYwhxTv06Cet008Q50LCYEZUlcZvfadYGk1RII8btYVeBb?=
 =?Windows-1252?Q?db7pTdV26KqbUtWzWa8MJMypS+Za3LioRj0qFmQ+YLwrTtnfGsYh6uVp?=
 =?Windows-1252?Q?1u1NfVYaEHe/eoC37FhRuF93p+K6rnOjTGmCCvDh21ojw36AcPydhgIQ?=
 =?Windows-1252?Q?iInCqUkTrEKk18Mpx2DA+voiFU9+uzh+wV01ZE1ORbWh+RGo2QlL+4mg?=
 =?Windows-1252?Q?mdjQrMlDJEZHbW9JWTDYXOsrZR9U02khf2urw7O6dw2Ol8P9MxJDZll2?=
 =?Windows-1252?Q?vkIZFJQbVSZRf//O4RRBjm7px3+7jyUgN9slBajfjO48uiAXdntiE0CO?=
 =?Windows-1252?Q?kWByKneqqi1EKk3wFXj1xFuzZo3XWe5tnVbh90BOBunrMSRokv1TkwtU?=
 =?Windows-1252?Q?QSX1Ocfb3SyPVgC3GMtvWkME5wvHBwTLRekkccrm0jCibj9b5RSTQ/LR?=
 =?Windows-1252?Q?3lX7B/LFSTCuP0DYHgIIszvHM+qCes0Y7/3sGA6rVFxspBTxd3Tm7iIs?=
 =?Windows-1252?Q?YdslY2IfSV9dRumpUKfUQ8f5ZlGKCVUusg+PVeHOLMHX6EQpm3RcwzZj?=
 =?Windows-1252?Q?P5qA4C6lIDQVugJdECaaRKN80DsZqxpm5snNhUGvSzWLiegcVfbbku2Q?=
 =?Windows-1252?Q?7vD12gDRWKxf+dF0o503873Ox0UfJjO9Yvf1v99QUMA8clE9W9euEDRV?=
 =?Windows-1252?Q?SL94pCsD/2uxiXNfNDxw/CH628tJMU9+73eZ9LAdpOxeMoLHhrhkzASS?=
 =?Windows-1252?Q?3+/UY7fCMlG14j8AUiQz9AiPBg9q93sooxCiihHrJincDMrOFwagjryG?=
 =?Windows-1252?Q?fVavOiaqcXKq8h4UiyxkyFGsryHJPK+yjNoiKrz/ohlhfexUT6F/2UYI?=
 =?Windows-1252?Q?Pih3zUCd/7CQuwS7MFGW3yzx9bZ7pNOB9ZW8V5wHud9ppsXeN6qs0ko7?=
 =?Windows-1252?Q?4Fvd78+SX7qTSkjmqNf6W6iVxFHbGyO7n/tqUs30EPXhfpbGyEz+HHUo?=
 =?Windows-1252?Q?RP5jVzW1kwU/V3BEj3ucsO8BFdbNeQbXkpWnhfm6SI4AZbNS5hQBcDkG?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685c5e5d-a608-4993-2834-08d9149ad1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 16:35:42.2809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eI+4Zmrbz58PRAeWE0AzHQyIn0qdHsy7UdmkIzezm9aOQpQr04JmlLOmvPilyRgM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3464
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Gu, JiaWei \(Will\)" <JiaWei.Gu@amd.com>,
 Kees Cook <keescook@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1385299932=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1385299932==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2840E586673207558B7FC136F4539BYAPR12MB2840namp_"

--_000_BYAPR12MB2840E586673207558B7FC136F4539BYAPR12MB2840namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

The point of having the device ID in the structure is because we are readin=
g it from the VBIOS header, not the asic registers. They should match, but =
an user may flash a VBIOS for a different devid and they may not match.

Regarding sysfs vs ioctl I see value in providing it in both ways, Mesa use=
s IOCTL and other DRM based tools may benefit as well. I recently went thro=
ugh the trouble of having to add sysfs string parsing for some data not ava=
ilable in ioctl, and while not very complicated, it is a programming inconv=
enience.

I understand that being uapi, changing it is not easy, but this is informat=
ion extracted from a VBIOS header, something that has been kept stable for =
many years.

David
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, May 11, 2021 7:07 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Marek Ol=9A=E1k <maraeo=
@gmail.com>
Cc: Kees Cook <keescook@chromium.org>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com=
>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily <Emily.Deng@am=
d.com>; Alex Deucher <alexdeucher@gmail.com>; Nieto, David M <David.Nieto@a=
md.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios

Yeah, but umr is making strong use of sysfs as well.

The only justification of this interface would be if we want to use it in M=
esa.

And I agree with Marek that looks redundant with the device structure to me=
 as well.

Christian.

Am 11.05.21 um 16:04 schrieb Deucher, Alexander:

[AMD Public Use]

It's being used by umr and some other smi tools to provide vbios informatio=
n for debugging.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Marek Ol=9A=E1k <maraeo@gmail.com><ma=
ilto:maraeo@gmail.com>
Sent: Tuesday, May 11, 2021 4:18 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.lei=
chtzumerken@gmail.com>
Cc: Kees Cook <keescook@chromium.org><mailto:keescook@chromium.org>; Gu, Ji=
aWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>; amd-gfx list <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>; Deng, E=
mily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>; Alex Deucher <alexdeu=
cher@gmail.com><mailto:alexdeucher@gmail.com>; Nieto, David M <David.Nieto@=
amd.com><mailto:David.Nieto@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios

Mesa doesn't use sysfs.

Note that this is a uapi, meaning that once it's in the kernel, it can't be=
 changed like that.

What's the use case for this new interface? Isn't it partially redundant wi=
th the current device info structure, which seems to have the equivalent of=
 dev_id and rev_id?

Marek

On Tue, May 11, 2021 at 3:51 AM Christian K=F6nig <ckoenig.leichtzumerken@g=
mail.com<mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
Marek and other userspace folks need to decide that.

Basic question here is if Mesa is already accessing sysfs nodes for OpenGL =
or RADV. If that is the case then we should probably expose the information=
 there as well.

If that isn't the case (which I think it is) then we should implement it as=
 IOCTL.

Regards,
Christian.

Am 10.05.21 um 22:19 schrieb Nieto, David M:

One of the primary usecases is to add this information to the renderer stri=
ng, I am not sure if there are other cases of UMD drivers accessing sysfs n=
odes, but I think if we think permissions, if a client is authenticated and=
 opens the render device then it can use the IOCTL, it is unclear to me we =
can make a such an assumption for sysfs nodes=85



I think there is value in having both tbh.



Regards,

David



From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Date: Monday, May 10, 2021 at 6:48 AM
To: "Nieto, David M" <David.Nieto@amd.com><mailto:David.Nieto@amd.com>, "Gu=
, JiaWei (Will)" <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>, "De=
ng, Emily" <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>, Kees Cook <kees=
cook@chromium.org><mailto:keescook@chromium.org>, amd-gfx list <amd-gfx@lis=
ts.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios



Well we could add both as sysfs file(s).

Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?

Regards,
Christian.

Am 10.05.21 um 15:42 schrieb Nieto, David M:

Then the application would need to issue the ioctl and then open a sysfs fi=
le to get all the information it needs. It makes little sense from a progra=
mming perspective to add an incomplete interface in my opinion



________________________________

From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Sent: Monday, May 10, 2021 12:13:07 AM
To: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>; amd=
-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.=
org>; Kees Cook <keescook@chromium.org><mailto:keescook@chromium.org>; Deng=
, Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios



[AMD Official Use Only - Internal Distribution Only]

Hi David,

What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios, n=
ot the whole struct.

struct drm_amdgpu_info_vbios {
        __u8 name[64];
        __u32 dbdf;
        __u8 vbios_pn[64];
        __u32 version;
        __u8 date[32];
        __u8 serial[16]; // jiawei: shall we delete this
        __u32 dev_id;
        __u32 rev_id;
        __u32 sub_dev_id;
        __u32 sub_ved_id;
};

serial[16] in drm_amdgpu_info_vbios  copied from adev->serial, but there's =
already a sysfs named serial_number, which exposes it already.

static ssize_t amdgpu_device_get_serial_number(struct device *dev,
                struct device_attribute *attr, char *buf)
{
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D ddev->dev_private;

        return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
}

Thanks,
Jiawei


-----Original Message-----
From: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Sent: Monday, May 10, 2021 2:53 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>; amd=
-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.=
org>; Kees Cook <keescook@chromium.org><mailto:keescook@chromium.org>; Deng=
, Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios

No, this structure contains all the details of the vbios: date, serial numb=
er, name, etc.

The sysfs node only contains the vbios name string

> On May 9, 2021, at 23:33, Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:Ji=
aWei.Gu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> With a second thought,
> __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs serial=
_number already exposes it.
>
> Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex
> Deucher @Nieto, David M
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>
> Sent: Sunday, May 9, 2021 11:59 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.fre=
edesktop.org>; Kees Cook
> <keescook@chromium.org><mailto:keescook@chromium.org>
> Subject: Re: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
>> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiaw=
ei.Gu@amd.com> wrote:
>>
>> 20 should be serial char size now instead of 16.
>>
>> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiawei.Gu@amd.com>
>
> Please make sure this keeps proper 64 bit alignment in the structure.
>
> Alex
>
>
>> ---
>> include/uapi/drm/amdgpu_drm.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da
>> 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
>>        __u8 vbios_pn[64];
>>        __u32 version;
>>        __u8 date[32];
>> -       __u8 serial[16];
>> +       __u8 serial[20];
>>        __u32 dev_id;
>>        __u32 rev_id;
>>        __u32 sub_dev_id;
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis
>> t
>> s.freedesktop.org<https://nam11.safelinks.protection.outlook.com/?url=3D=
http%3A%2F%2Fs.freedesktop.org%2F&data=3D04%7C01%7CDavid.Nieto%40amd.com%7C=
f24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0=
%7C637563388684906500%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DgKeRCQ485gWespGfo1O01t=
Zz8fDy1zPGHIDEvCqyp1I%3D&reserved=3D0>%2Fmailman%2Flistinfo%2Famd-gfx&amp;d=
ata=3D04%7C01%7CJ
>> i
>> awei.Gu%40amd.com<https://nam11.safelinks.protection.outlook.com/?url=3D=
http%3A%2F%2F40amd.com%2F&data=3D04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fb=
dd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63756=
3388684916541%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3D8pM7WTh9%2F23KCF6DuXOc4%2Fi7rD=
USxmH647BdpujXgWo%3D&reserved=3D0>%7Ccea31833184c41e8574508d9130360cc%7C3dd=
8961fe4884e
>> 6
>> 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
>> d
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>> C
>> 1000&amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;res
>> e
>> rved=3D0



_______________________________________________

amd-gfx mailing list

amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fb=
dd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63756=
3388684926488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DHdhx2ogsQt2C3OIKNC%2BaswtNkiIW=
bV6Ot8a%2B3YFqa7w%3D&reserved=3D0>



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fb=
dd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63756=
3388684926488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DHdhx2ogsQt2C3OIKNC%2BaswtNkiIW=
bV6Ot8a%2B3YFqa7w%3D&reserved=3D0>


--_000_BYAPR12MB2840E586673207558B7FC136F4539BYAPR12MB2840namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
The point of having the device ID in the structure is because we are readin=
g it from the VBIOS header, not the asic registers. They should match, but =
an user may flash a VBIOS for a different devid and they may not match.</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Regarding sysfs vs ioctl I see value in providing it in both ways, Mesa use=
s IOCTL and other DRM based tools may benefit as well. I recently went thro=
ugh the trouble of having to add sysfs string parsing for some data not ava=
ilable in ioctl, and while not very
 complicated, it is a programming inconvenience.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I understand that being uapi, changing it is not easy, but this is informat=
ion extracted from a VBIOS header, something that has been kept stable for =
many&nbsp;years.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
David</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, May 11, 2021 7:07 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Marek Ol=
=9A=E1k &lt;maraeo@gmail.com&gt;<br>
<b>Cc:</b> Kees Cook &lt;keescook@chromium.org&gt;; Gu, JiaWei (Will) &lt;J=
iaWei.Gu@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; D=
eng, Emily &lt;Emily.Deng@amd.com&gt;; Alex Deucher &lt;alexdeucher@gmail.c=
om&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</font>
<div>&nbsp;</div>
</div>
<div>Yeah, but umr is making strong use of sysfs as well.<br>
<br>
The only justification of this interface would be if we want to use it in M=
esa.<br>
<br>
And I agree with Marek that looks redundant with the device structure to me=
 as well.<br>
<br>
Christian.<br>
<br>
<div class=3D"x_moz-cite-prefix">Am 11.05.21 um 16:04 schrieb Deucher, Alex=
ander:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#317100=
; margin:15pt">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
It's being used by umr and some other smi tools to provide vbios informatio=
n for debugging.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of Marek Ol=9A=
=E1k <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:maraeo@gmail.com">
&lt;maraeo@gmail.com&gt;</a><br>
<b>Sent:</b> Tuesday, May 11, 2021 4:18 AM<br>
<b>To:</b> Christian K=F6nig <a class=3D"x_moz-txt-link-rfc2396E" href=3D"m=
ailto:ckoenig.leichtzumerken@gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Cc:</b> Kees Cook <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:ke=
escook@chromium.org">
&lt;keescook@chromium.org&gt;</a>; Gu, JiaWei (Will) <a class=3D"x_moz-txt-=
link-rfc2396E" href=3D"mailto:JiaWei.Gu@amd.com">
&lt;JiaWei.Gu@amd.com&gt;</a>; amd-gfx list <a class=3D"x_moz-txt-link-rfc2=
396E" href=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deng, Emily <a class=3D"x_moz-tx=
t-link-rfc2396E" href=3D"mailto:Emily.Deng@amd.com">
&lt;Emily.Deng@amd.com&gt;</a>; Alex Deucher <a class=3D"x_moz-txt-link-rfc=
2396E" href=3D"mailto:alexdeucher@gmail.com">
&lt;alexdeucher@gmail.com&gt;</a>; Nieto, David M <a class=3D"x_moz-txt-lin=
k-rfc2396E" href=3D"mailto:David.Nieto@amd.com">
&lt;David.Nieto@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div>Mesa doesn't use sysfs.</div>
<div><br>
</div>
<div>Note that this is a uapi, meaning that once it's in the kernel, it can=
't be changed like that.<br>
</div>
<div><br>
</div>
<div>What's the use case for this new interface? Isn't it partially redunda=
nt with the current device info structure, which seems to have the equivale=
nt of dev_id and rev_id?<br>
</div>
<div><br>
</div>
<div>Marek<br>
</div>
</div>
<br>
<div class=3D"x_x_gmail_quote">
<div dir=3D"ltr" class=3D"x_x_gmail_attr">On Tue, May 11, 2021 at 3:51 AM C=
hristian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" ta=
rget=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_x_gmail_quote" style=3D"margin:0px 0px 0px
              0.8ex; border-left:1px solid rgb(204,204,204); padding-left:1=
ex">
<div>Marek and other userspace folks need to decide that.<br>
<br>
Basic question here is if Mesa is already accessing sysfs nodes for OpenGL =
or RADV. If that is the case then we should probably expose the information=
 there as well.<br>
<br>
If that isn't the case (which I think it is) then we should implement it as=
 IOCTL.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<div>Am 10.05.21 um 22:19 schrieb Nieto, David M:<br>
</div>
<blockquote type=3D"cite">
<div>
<p class=3D"x_x_MsoNormal">One of the primary usecases is to add this infor=
mation to the renderer string, I am not sure if there are other cases of UM=
D drivers accessing sysfs nodes, but I think if we think permissions, if a =
client is authenticated and opens
 the render device then it can use the IOCTL, it is unclear to me we can ma=
ke a such an assumption for sysfs nodes=85</p>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<p class=3D"x_x_MsoNormal">I think there is value in having both tbh.</p>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<p class=3D"x_x_MsoNormal">Regards,</p>
<p class=3D"x_x_MsoNormal">David</p>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
<div style=3D"border-color:rgb(181,196,223)
                      currentcolor currentcolor; border-style:solid none
                      none; border-width:1pt medium medium; padding:3pt
                      0in 0in">
<p class=3D"x_x_MsoNormal"><b><span style=3D"font-size:12pt; color:black">F=
rom: </span>
</b><span style=3D"font-size:12pt; color:black">Christian K=F6nig <a href=
=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Date: </b>Monday, May 10, 2021 at 6:48 AM<br>
<b>To: </b>&quot;Nieto, David M&quot; <a href=3D"mailto:David.Nieto@amd.com=
" target=3D"_blank">
&lt;David.Nieto@amd.com&gt;</a>, &quot;Gu, JiaWei (Will)&quot; <a href=3D"m=
ailto:JiaWei.Gu@amd.com" target=3D"_blank">
&lt;JiaWei.Gu@amd.com&gt;</a><br>
<b>Cc: </b>Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a>, &quot;Deng, Emily&quot;
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a>, Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>, amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span></p>
</div>
<div>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
</div>
<p class=3D"x_x_MsoNormal" style=3D"margin-bottom:12pt">Well we could add b=
oth as sysfs file(s).<br>
<br>
Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?<br>
<br>
Regards,<br>
Christian.</p>
<div>
<p class=3D"x_x_MsoNormal">Am 10.05.21 um 15:42 schrieb Nieto, David M:</p>
</div>
<blockquote style=3D"margin-top:5pt; margin-bottom:5pt">
<div>
<div>
<div>
<p class=3D"x_x_MsoNormal" style=3D"background:white none repeat scroll
                              0% 0%">
<span style=3D"color:black">Then the application would need to issue the io=
ctl and then open a sysfs file to get all the information it needs. It make=
s little sense from a programming perspective to add an incomplete interfac=
e in my opinion&nbsp;</span></p>
</div>
</div>
<div>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
</div>
</div>
<div class=3D"x_x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr width=3D"100%" size=3D"0" align=3D"center">
</div>
<div id=3D"x_x_gmail-m_782079725653541167gmail-m_3184748164637597930gmail-m=
_-3452308432024396062divRplyFwdMsg">
<p class=3D"x_x_MsoNormal"><b><span style=3D"color:black">From:</span></b><=
span style=3D"color:black"> Gu, JiaWei (Will)
<a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank">&lt;JiaWei.Gu@amd.co=
m&gt;</a><br>
<b>Sent:</b> Monday, May 10, 2021 12:13:07 AM<br>
<b>To:</b> Nieto, David M <a href=3D"mailto:David.Nieto@amd.com" target=3D"=
_blank">&lt;David.Nieto@amd.com&gt;</a><br>
<b>Cc:</b> Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>; Deng, Emily
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span>
</p>
<div>
<p class=3D"x_x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_x_MsoNormal">[AMD Official Use Only - Internal Distribution O=
nly]<br>
<br>
Hi David,<br>
<br>
What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios, n=
ot the whole struct.<br>
<br>
struct drm_amdgpu_info_vbios {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 name[64];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dbdf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16]; // jiawei: shal=
l we delete this<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_ved_id;<br>
};<br>
<br>
serial[16] in drm_amdgpu_info_vbios&nbsp; copied from adev-&gt;serial, but =
there's already a sysfs named serial_number, which exposes it already.<br>
<br>
static ssize_t amdgpu_device_get_serial_number(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
dev-&gt;dev_private;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, =
&quot;%s\n&quot;, adev-&gt;serial);<br>
}<br>
<br>
Thanks,<br>
Jiawei<br>
<br>
<br>
-----Original Message-----<br>
From: Nieto, David M <a href=3D"mailto:David.Nieto@amd.com" target=3D"_blan=
k">&lt;David.Nieto@amd.com&gt;</a>
<br>
Sent: Monday, May 10, 2021 2:53 PM<br>
To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank=
">&lt;JiaWei.Gu@amd.com&gt;</a><br>
Cc: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank"=
>&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">&lt;amd-=
gfx@lists.freedesktop.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescook@chr=
omium.org&gt;</a>; Deng, Emily
<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank">&lt;Emily.Deng@amd.=
com&gt;</a><br>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios=
<br>
<br>
No, this structure contains all the details of the vbios: date, serial numb=
er, name, etc.<br>
<br>
The sysfs node only contains the vbios name string<br>
<br>
&gt; On May 9, 2021, at 23:33, Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.G=
u@amd.com" target=3D"_blank">
&lt;JiaWei.Gu@amd.com&gt;</a> wrote:<br>
&gt; <br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt; <br>
&gt; With a second thought,<br>
&gt; __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs ser=
ial_number already exposes it.<br>
&gt; <br>
&gt; Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex <br>
&gt; Deucher @Nieto, David M<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Jiawei<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com" target=3D"=
_blank">&lt;alexdeucher@gmail.com&gt;</a><br>
&gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
&gt; To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_=
blank">&lt;JiaWei.Gu@amd.com&gt;</a><br>
&gt; Cc: amd-gfx list <a href=3D"mailto:amd-gfx@lists.freedesktop.org" targ=
et=3D"_blank">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook <br>
&gt; <a href=3D"mailto:keescook@chromium.org" target=3D"_blank">&lt;keescoo=
k@chromium.org&gt;</a><br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Align serial size in <br>
&gt; drm_amdgpu_info_vbios<br>
&gt; <br>
&gt;&gt; On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <a href=3D"mailto:Jiawei.=
Gu@amd.com" target=3D"_blank">
&lt;Jiawei.Gu@amd.com&gt;</a> wrote:<br>
&gt;&gt; <br>
&gt;&gt; 20 should be serial char size now instead of 16.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Jiawei Gu <a href=3D"mailto:Jiawei.Gu@amd.com" targ=
et=3D"_blank">&lt;Jiawei.Gu@amd.com&gt;</a><br>
&gt; <br>
&gt; Please make sure this keeps proper 64 bit alignment in the structure.<=
br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; <br>
&gt;&gt; ---<br>
&gt;&gt; include/uapi/drm/amdgpu_drm.h | 2 +-<br>
&gt;&gt; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h <br>
&gt;&gt; b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da<b=
r>
&gt;&gt; 100644<br>
&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[20];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt; <br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank"=
>amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flis" target=3D"_blank">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis</a>=
<br>
&gt;&gt; t <br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttp%3A%2F%2Fs.freedesktop.org%2F&amp;data=3D04%7C01%7CDavid.Nieto%40amd.com=
%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%=
7C0%7C637563388684906500%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DgKeRCQ485gWespG=
fo1O01tZz8fDy1zPGHIDEvCqyp1I%3D&amp;reserved=3D0" originalsrc=3D"http://s.f=
reedesktop.org/" shash=3D"DS30wWYLWPzlfg8eUR2itnBbPnYcxEIhscto77bCc2N+dut9g=
8GcCgcCYLy4oSIXsiMH62clQ5Re7GLsQl6D9wt/bU0dehDZDS3kR3CItIXojER1LV4n7pJMB4jw=
7v4w3Jr036y1mf0jQRkSXFyWC+Bt6Db65aZJy/5Hht3PgQI=3D" originalsrc=3D"http://s=
.freedesktop.org/" shash=3D"btj7NLDddPgpMAMLB3quP6ykf2ispDn5lwhdGkwRIrZZVTy=
HyNq1ssBpJhnsN4laG44hB4T0TgfxG02TLc3I6IjzSHPptuHwBRq9Sp6n9Q/XMg8Ct49Cm1151n=
K1BGGldJQWTEAuULIrh/XGNTux7Thy4JSZ7ROPWWOrUswWfPk=3D" target=3D"_blank">
s.freedesktop.org</a>%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01=
%7CJ<br>
&gt;&gt; i<br>
&gt;&gt; awei.Gu%<a href=3D"https://nam11.safelinks.protection.outlook.com/=
?url=3Dhttp%3A%2F%2F40amd.com%2F&amp;data=3D04%7C01%7CDavid.Nieto%40amd.com=
%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%=
7C0%7C637563388684916541%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D8pM7WTh9%2F23KC=
F6DuXOc4%2Fi7rDUSxmH647BdpujXgWo%3D&amp;reserved=3D0" originalsrc=3D"http:/=
/40amd.com/" shash=3D"FiUngW+kcDcVRzWZVXROcfpv2mFem+fC5TqnS2m5TH5Dbumh2JH8q=
sPnDTRydvnGgA3TE7hqNXrL+lDeRPcD3FPX2xYNDFRhiTXx1AZ93ocUiGGAegBuzOMCau7TIs+L=
EQB7DtO/cBjRelCuvhnWjVVguuK4jeAyl4Oz92wB/h0=3D" originalsrc=3D"http://40amd=
.com/" shash=3D"cf/ygK275ZVbFfF5lVmCbvCl/B6PwIUkYnUG9wgvvtwcT2mXzRcsorOK9cw=
k01GKm9po/lqDU+gc9/3q+tUApaBm9jr04e4tQJONRS9Cx/Fdk4qcFUfsqBF1b9BLLYuiTck/Wc=
+Ck9ZATqKU0mMol8jES2vgx8WcF8g28sj3Zc0=3D" target=3D"_blank">40amd.com</a>%7=
Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e<br>
&gt;&gt; 6 <br>
&gt;&gt; 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZ=
sb3<br>
&gt;&gt; d <br>
&gt;&gt; 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7<br>
&gt;&gt; C <br>
&gt;&gt; 1000&amp;amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3=
D&amp;amp;res<br>
&gt;&gt; e<br>
&gt;&gt; rved=3D0</p>
</div>
</div>
<p class=3D"x_x_MsoNormal"><br>
<br>
</p>
<pre>_______________________________________________</pre>
<pre>amd-gfx mailing list</pre>
<pre><a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a></pre>
<pre><a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04=
%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3DHdhx2ogsQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&amp;reserv=
ed=3D0" originalsrc=3D"https://lists.freedesktop.org/mailman/listinfo/amd-g=
fx" shash=3D"HUKtqi0vwls+VKcHTyIzyFw8V4cNinaZNPX94jYpKyqN7UrWUh2ITnvOzp9TJy=
hr4ZbiL7clKV4vx3tsUXH89ug7bMnmBUzUAC3XTcpXAtGB3CPfrt3Wdl8S1d2Z+PT7VE3SAMdwq=
81E2LEfDg06+ArFXMvhcAets/Q/Av7G8+M=3D" originalsrc=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx" shash=3D"t9pEoIbGR/QdCWU78obt+C/sor4ABye=
kPVkQZPvb6duz54OJw/r6a/+75rBqHRpRw7idemSamNqzLoxesO+7RfIFrwyePU1Pbpr+go0REF=
s637qa4YUetwBREc5Ilu6Qsy5QX9jw41+/xFzr9+NOAGQBImNZ7pzucKWWycA5vVs=3D" targe=
t=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pr=
e>
</blockquote>
<p class=3D"x_x_MsoNormal"><br>
<br>
</p>
</div>
</blockquote>
<br>
</div>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp=
;sdata=3DHdhx2ogsQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&amp;reserved=3D=
0" originalsrc=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" s=
hash=3D"HUKtqi0vwls+VKcHTyIzyFw8V4cNinaZNPX94jYpKyqN7UrWUh2ITnvOzp9TJyhr4Zb=
iL7clKV4vx3tsUXH89ug7bMnmBUzUAC3XTcpXAtGB3CPfrt3Wdl8S1d2Z+PT7VE3SAMdwq81E2L=
EfDg06+ArFXMvhcAets/Q/Av7G8+M=3D" originalsrc=3D"https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx" shash=3D"t9pEoIbGR/QdCWU78obt+C/sor4AByekPVkQ=
ZPvb6duz54OJw/r6a/+75rBqHRpRw7idemSamNqzLoxesO+7RfIFrwyePU1Pbpr+go0REFs637q=
a4YUetwBREc5Ilu6Qsy5QX9jw41+/xFzr9+NOAGQBImNZ7pzucKWWycA5vVs=3D" rel=3D"nor=
eferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/a=
md-gfx</a><br>
</blockquote>
</div>
</div>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2840E586673207558B7FC136F4539BYAPR12MB2840namp_--

--===============1385299932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1385299932==--
