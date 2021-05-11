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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D8C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 02:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D95B61400
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 02:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D95B61400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D394F6E9A4;
	Tue, 11 May 2021 02:52:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F156E9A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 02:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCgl/ex51Hep8eyP3bEmdlClw3Wy3a/5SIrwUsza6gpDtFl33ZKF6eF7QVaHl5ngqRzWzok7ve6J/79hqczmZhbEidancliMu+v5IE8CuhJdFzVJSIsaH999wSWAdX41cKXGE+DnC769VVDbT/A4SH0hOihMn89GZRrbGrsXvQwf4VLm+LWgIA9FLdL7dtYCefKzqWlyTXZ3DWvFpiUvGE8oSl5Ewp6tqqfh4Pu7XO1oZL19emTGLSilounNfMryC9ygWcfVuAZvTnlCWVaQH8SVBnkHWzkob5JBaCIDpZhFQ9PJcywfyJQFrQITuVdvjstTD72ZgrY1UDcVPo8NmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtidKCknHIa7rp0t9vYt5BgnoV8kC1G6awEIZ7KhzhU=;
 b=Usq+qzETjQ/nfcg7SJ2KKyHfv43cv3S5OSYUcVXWb71EGweKz5lWoAHGzo+nTg+rXQxcOJEuBaMdEXNghaFA3nD0AT3AL9o9KkiTP99Vugc0OQOmJmvuVl1w7rSy30IZy1evvvcCc/GOVrVwaOlH+d7jggfGebvAY8bkY0k4LE8Gkhdrv3z+wWf8PCrZPjIxjwo9AF0iu/pjShXBIHJzV0E+WeFo0gPjnzwyApTJ9A59arpwZCfhv+ajhZKrCG8YAbnP1QSyeginsxfgoBDv9wAd9xzzpECETnhkFb+XOumqXxOqY215Y6qQ4/nYy637ITjPWVTjyBXWJC2a8HBCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtidKCknHIa7rp0t9vYt5BgnoV8kC1G6awEIZ7KhzhU=;
 b=Oo8QOIjNnNlVDn0ZDwue5ZOjghz/3pWuHmvOnsNBfwALshBepSRqEi5Ev6DJ0GiD8uURlDGRXB2i8GD14Wxkugl7Db9tms98FKn0PAN1kF2Vt9cfPt9jj1I05bbD3WN92SLZnD7cqiVf/wlvk4Q2nb+JxVqtmhcdr5F/PKyPAhc=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3239.namprd12.prod.outlook.com (2603:10b6:a03:137::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Tue, 11 May
 2021 02:52:29 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 02:52:29 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Index: AQHXQ9Yf8LVbEME0wESo6KxpkiJJJqrbUMIAgADxAdCAAAjk7YAAA0iggABtf0iAAANEgP//9+aAgADU3gCAAA1l1w==
Date: Tue, 11 May 2021 02:52:29 +0000
Message-ID: <BYAPR12MB284050850E3DD885927F97F1F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>,
 <CH0PR12MB5156416E8409EB41D0858D64F8539@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5156416E8409EB41D0858D64F8539@CH0PR12MB5156.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-11T02:52:29.227Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.53.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 340979de-1416-417d-ed4d-08d91427d14d
x-ms-traffictypediagnostic: BYAPR12MB3239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB32395545DA01BA24EA3A7DB2F4539@BYAPR12MB3239.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFVJQ5GZaPfGj6iM1mgQfRwgNEXt98lzn6Yo//azZKaMynmXdMfpJ9eRCjmarc2GJWfTEhHlT6jIdXg+VQatPp3tPp6pNS0gJ7j7KR2ZDxvVCayhFFgXXYK56CfZerVioQAWxSB1M+NwhqF8wbO9q+xzW7ERyTmuYDs3agdr0aJzYJgYvm+Y5OoaVs0N6u1tnJFQ4PdDfQR/U/ri+wAAd9prrbYEr/n2udwxYgUiRUam924Q/eeUK6VGUwB8kR+UpV62n5NdlnmTby5XK1jZuHKfuPEypihQZ9XeUKFayIc5fyo3e6YrNxMCMGxDeGllgGA0dZvpWkPcsKxEFmFsrM60nTj4a4Cvu5RbO22YDv5Rqhox6ZnyKBTwIt4+4faTjVzerFWzovUi9LHJ7UmAJoWYxTMvurXtXGPBJkF3VJW/t4nB5QMkuoZnCnVXIq14DztzvxyG01MHqXZ5Et9T0gk7gMvsQeSeek3hp23TvANI9TSE52tkOEaDEl8fPhDu7hSChLw6ai8rACw14jVyCLRxQinuFg4x5be8r8X8sVoJ5jIkklXBiPPzlXSTzY/vkAWAq9MrrxpuMFSTOrxBfUD+bOBaJ+dgglHAVm4yFpYUqm4WwsdYrG3BudsNz4y8O4s/G20nFYCT2t571zPxwc8hwFELGI4TJFd0tWAhJTXR+LhyEaOEDvpiPLNSgJdu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(33656002)(8676002)(26005)(19627235002)(110136005)(66574015)(54906003)(186003)(9686003)(55016002)(5660300002)(83380400001)(122000001)(4326008)(19627405001)(8936002)(2906002)(38100700002)(86362001)(66446008)(64756008)(76116006)(71200400001)(66476007)(478600001)(52536014)(6506007)(66556008)(316002)(166002)(966005)(7696005)(53546011)(45080400002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?vYgEsiPVUjIkppLI4F8GGT7qb4FWNmMr0rMeTXhLyYoYLxFywuZB0EO5?=
 =?Windows-1252?Q?ZmQ0ICxCBVBTy+YiDxBj/bczfVf9wOLiJixzftMdWhMqiCGYzLTRtXrn?=
 =?Windows-1252?Q?Pc1NYH+/0cxMPUbAdlLZdWXlK0jtRY6NYCPWZR3NyPO5ErS6NkgsnGrC?=
 =?Windows-1252?Q?bGjq5UCzViQ29mHP5EgafpXcl4KxeWUL36aQJYqApVQfTTltia9pGlnz?=
 =?Windows-1252?Q?wBvc1K/BZik85n0WhEopM4P41wzE/ObV/cttuf6KYa/6B8r5ZNmYVzvF?=
 =?Windows-1252?Q?fEuTmPkeMVsuyQLR9s+OuhCXtoF8WIOM+2NbuvnPCB3oCxlRedDmyzDR?=
 =?Windows-1252?Q?D3QcZitzs3frTX94UU+BAhBB7ogWEsvLor4G7DEUQz7BkOeoakiEg1/N?=
 =?Windows-1252?Q?PiLilvKph72dRkF4N6fgA4YV67ESleq77FjGVWPIIc6x+Q5+EBb6AcSv?=
 =?Windows-1252?Q?3ZjM9fFeXN0n0C7IFnwn/9NEysTyIxmLV1ik7YY5x/taMg0tB5XNuhrI?=
 =?Windows-1252?Q?UAiUdsMXLcJ6zyV+ned/C+BDqlDqs4TWIFYdwn5hJ4IvRUOJHapOxHfC?=
 =?Windows-1252?Q?O2yEbJUQixSB/MApFgNkW5SvTd6ilFU9tyxUYsZqpoOS13xAsyxRIugF?=
 =?Windows-1252?Q?Czoq899UhlWPaVg9HDRorcTbc8j12gZHbgL5i9eRAd6CAIeo2ARBuma+?=
 =?Windows-1252?Q?gW0yLNJNzKCoikSr9Hk4tJjRMa5HmLBUro2Lt1LIP7GcY4RfdU7lmrZb?=
 =?Windows-1252?Q?aDtwhRcbLM4uXlupVO4JQ5HYe9FFgLdBwMWCzpzwmrNKFqYEm5vAqczv?=
 =?Windows-1252?Q?+fdXD3+PK9mYVOGzbiGqFz6ynjyqHxRd4xc05GpFoABt/7MgGFGIqDtc?=
 =?Windows-1252?Q?jJ36wwu4QitydOx4WEJcvNY+4C4o27oCireX6GPKPzctageIzLgmMVMJ?=
 =?Windows-1252?Q?vIKMOLjWxU10FE0hT81dEVi7Eyof5iMgFbr5MlZy3tYTP8bvxn2dEsJb?=
 =?Windows-1252?Q?dS/NW220Dck1eEaCxzI+Z9ButVWN1UAINyWKvcfdmn64KgbzdNeePhuW?=
 =?Windows-1252?Q?p2mUNATjNZc2SZlyLC1x/LnrfO/d22GP7Yxjcqev5eWSpvqr62oG2TCN?=
 =?Windows-1252?Q?O7CBR7tICfTMONko5q1UTnYcRfWPdn8ymMoxE9Or1Usp7rst++lYvo7X?=
 =?Windows-1252?Q?zTgHWs2rmKdeHHr6SFUATjpxDqD9HrDNJqfPPH7lE6U93ZkfyOvqwByZ?=
 =?Windows-1252?Q?cs0Fzv/igZ6KY29TwEduAiLG4qr1Lz5ySODFdQwfHhWLRY8b0V3GFID8?=
 =?Windows-1252?Q?IV8343N/rmhiGtKLGaDQPIiS4aQJgrFKP8AlKHA5U+ynMtSTBY7eGsBy?=
 =?Windows-1252?Q?EzSXGfbh8k5dopOGpDgcWA3vVkZYTeSTfJPFXgb3DmcNRgZ8wmtvQQD+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340979de-1416-417d-ed4d-08d91427d14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 02:52:29.6581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +G+6Yf6jsX1PCyiG9Xqazk5KyA0h5DaLZ76yoL4RUStMlpTgCRR8vfhJXTT/WMC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3239
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 Kees Cook <keescook@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2025523940=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2025523940==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB284050850E3DD885927F97F1F4539BYAPR12MB2840namp_"

--_000_BYAPR12MB284050850E3DD885927F97F1F4539BYAPR12MB2840namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I agree that the serial number should be on number form, but I think we are=
 still missing one field, which is the vbios name, which is located after t=
he P/N, ASIC, PCI and memory type strings (skiping 0xD 0xA

David
________________________________
From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Sent: Monday, May 10, 2021 7:23 PM
To: Nieto, David M <David.Nieto@amd.com>; Christian K=F6nig <ckoenig.leicht=
zumerken@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>; Deng, Emily <Emily.Deng@amd.com>;=
 Kees Cook <keescook@chromium.org>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios


[AMD Official Use Only - Internal Distribution Only]



Got it. Let=92s keep them both.



Another idea about drm_amdgpu_info_vbios is

Does it make more sense to fill the =93serial info=94 with uint64_t adev->u=
nique_id, instead of the current char[] in adev->serial?



Sorry about that I was not aware of adev->unique_id exists when I defined d=
rm_amdgpu_info_vbios.

I think it=92s clearer to use original numeric variable than a string to ex=
pose serial.



How about that?



>> struct drm_amdgpu_info_vbios {
>>        __u8 vbios_pn[64];
>>        __u32 version;
>>        __u8 date[32];
>> -       __u8 serial[16];
>> +       __u64 serial;
>>        __u32 dev_id;
>>        __u32 rev_id;
>>        __u32 sub_dev_id;
>> --



Best regards,

Jiawei





From: Nieto, David M <David.Nieto@amd.com>
Sent: Tuesday, May 11, 2021 4:20 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Gu, JiaWei (Will)=
 <JiaWei.Gu@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>; Deng, Emily <Emily.Deng@amd.com>;=
 Kees Cook <keescook@chromium.org>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios



One of the primary usecases is to add this information to the renderer stri=
ng, I am not sure if there are other cases of UMD drivers accessing sysfs n=
odes, but I think if we think permissions, if a client is authenticated and=
 opens the render device then it can use the IOCTL, it is unclear to me we =
can make a such an assumption for sysfs nodes=85



I think there is value in having both tbh.



Regards,

David



From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Date: Monday, May 10, 2021 at 6:48 AM
To: "Nieto, David M" <David.Nieto@amd.com<mailto:David.Nieto@amd.com>>, "Gu=
, JiaWei (Will)" <JiaWei.Gu@amd.com<mailto:JiaWei.Gu@amd.com>>
Cc: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>, "De=
ng, Emily" <Emily.Deng@amd.com<mailto:Emily.Deng@amd.com>>, Kees Cook <kees=
cook@chromium.org<mailto:keescook@chromium.org>>, amd-gfx list <amd-gfx@lis=
ts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
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
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CJ
>> i
>> awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e
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
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nieto%40amd.com%7C3c0071a8=
a2a74127027408d913ba53e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63756=
2513264718308%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3Dg11aunC78b48N19Q%2FFXJBK%2B2Z0=
PZBWdqp%2FzhsPiqQ8Q%3D&reserved=3D0>



--_000_BYAPR12MB284050850E3DD885927F97F1F4539BYAPR12MB2840namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I agree that the serial&nbsp;number should be on number form, but I think w=
e are still missing one field, which is the vbios name, which is located af=
ter the P/N, ASIC, PCI and memory type strings (skiping 0xD 0xA</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Gu, JiaWei (Will) &lt=
;JiaWei.Gu@amd.com&gt;<br>
<b>Sent:</b> Monday, May 10, 2021 7:23 PM<br>
<b>To:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;; Christian K=F6nig &l=
t;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Cc:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Deng, Emily &lt;Emil=
y.Deng@amd.com&gt;; Kees Cook &lt;keescook@chromium.org&gt;; amd-gfx list &=
lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
@font-face
	{font-family:Consolas}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New"}
span.x_HTMLPreformattedChar
	{font-family:Consolas}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheader4d111418, li.x_msipheader4d111418, div.x_msipheader4d111418
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader4d111418" style=3D"margin:0in"><span style=3D"font-=
family:&quot;Arial&quot;,sans-serif; color:#0078D7">[AMD Official Use Only =
- Internal Distribution Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Got it. Let=92s keep them both.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Another idea about drm_amdgpu_info_vbios is</p>
<p class=3D"x_MsoNormal">Does it make more sense to fill the =93serial info=
=94 with uint64_t adev-&gt;unique_id, instead of the current char[] in adev=
-&gt;serial?</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Sorry about that I was not aware of adev-&gt;uniqu=
e_id exists when I defined drm_amdgpu_info_vbios.</p>
<p class=3D"x_MsoNormal">I think it=92s clearer to use original numeric var=
iable than a string to expose serial.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">How about that?</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&gt;&gt; struct drm_amdgpu_info_vbios {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 serial;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt;&gt; --</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Best regards,</p>
<p class=3D"x_MsoNormal">Jiawei</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Nieto, David M &lt;David.Nieto@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, May 11, 2021 4:20 AM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Gu, =
JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;<br>
<b>Cc:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Deng, Emily &lt;Emil=
y.Deng@amd.com&gt;; Kees Cook &lt;keescook@chromium.org&gt;; amd-gfx list &=
lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">One of the primary usecases is to add this informa=
tion to the renderer string, I am not sure if there are other cases of UMD =
drivers accessing sysfs nodes, but I think if we think permissions, if a cl=
ient is authenticated and opens the
 render device then it can use the IOCTL, it is unclear to me we can make a=
 such an assumption for sysfs nodes=85</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">I think there is value in having both tbh.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">David</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-top:solid #B5C4DF 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:12.0pt; color:black">F=
rom: </span>
</b><span style=3D"font-size:12.0pt; color:black">Christian K=F6nig &lt;<a =
href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gma=
il.com</a>&gt;<br>
<b>Date: </b>Monday, May 10, 2021 at 6:48 AM<br>
<b>To: </b>&quot;Nieto, David M&quot; &lt;<a href=3D"mailto:David.Nieto@amd=
.com">David.Nieto@amd.com</a>&gt;, &quot;Gu, JiaWei (Will)&quot; &lt;<a hre=
f=3D"mailto:JiaWei.Gu@amd.com">JiaWei.Gu@amd.com</a>&gt;<br>
<b>Cc: </b>Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;, &quot;Deng, Emily&quot; &lt;<a href=3D"mailto:Emil=
y.Deng@amd.com">Emily.Deng@amd.com</a>&gt;, Kees Cook &lt;<a href=3D"mailto=
:keescook@chromium.org">keescook@chromium.org</a>&gt;, amd-gfx list
 &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a>&gt;<br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span></p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">Well we could add b=
oth as sysfs file(s).<br>
<br>
Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?<br>
<br>
Regards,<br>
Christian.</p>
<div>
<p class=3D"x_MsoNormal">Am 10.05.21 um 15:42 schrieb Nieto, David M:</p>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:bl=
ack">Then the application would need to issue the ioctl and then open a sys=
fs file to get all the information it needs. It makes little sense from a p=
rogramming perspective to add an incomplete
 interface in my opinion&nbsp;</span></p>
</div>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"100%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Gu, JiaWei (Will)
<a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a><br>
<b>Sent:</b> Monday, May 10, 2021 12:13:07 AM<br>
<b>To:</b> Nieto, David M <a href=3D"mailto:David.Nieto@amd.com">&lt;David.=
Nieto@amd.com&gt;</a><br>
<b>Cc:</b> Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com">&lt;alexde=
ucher@gmail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesk=
top.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a>;=
 Deng, Emily <a href=3D"mailto:Emily.Deng@amd.com">
&lt;Emily.Deng@amd.com&gt;</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
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
From: Nieto, David M <a href=3D"mailto:David.Nieto@amd.com">&lt;David.Nieto=
@amd.com&gt;</a>
<br>
Sent: Monday, May 10, 2021 2:53 PM<br>
To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@am=
d.com&gt;</a><br>
Cc: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com">&lt;alexdeucher@g=
mail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesk=
top.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a>;=
 Deng, Emily <a href=3D"mailto:Emily.Deng@amd.com">
&lt;Emily.Deng@amd.com&gt;</a><br>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios=
<br>
<br>
No, this structure contains all the details of the vbios: date, serial numb=
er, name, etc.<br>
<br>
The sysfs node only contains the vbios name string<br>
<br>
&gt; On May 9, 2021, at 23:33, Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.G=
u@amd.com">
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
&gt; From: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com">&lt;alexde=
ucher@gmail.com&gt;</a><br>
&gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
&gt; To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWei.=
Gu@amd.com&gt;</a><br>
&gt; Cc: amd-gfx list <a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;=
amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook
<br>
&gt; <a href=3D"mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;=
</a><br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Align serial size in <br>
&gt; drm_amdgpu_info_vbios<br>
&gt; <br>
&gt;&gt; On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <a href=3D"mailto:Jiawei.=
Gu@amd.com">&lt;Jiawei.Gu@amd.com&gt;</a> wrote:<br>
&gt;&gt; <br>
&gt;&gt; 20 should be serial char size now instead of 16.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Jiawei Gu <a href=3D"mailto:Jiawei.Gu@amd.com">&lt;=
Jiawei.Gu@amd.com&gt;</a><br>
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
&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flis">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis</a>=
<br>
&gt;&gt; t <br>
&gt;&gt; s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04=
%7C01%7CJ<br>
&gt;&gt; i<br>
&gt;&gt; awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe48=
84e<br>
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
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp;</p>
<pre>_______________________________________________</pre>
<pre>amd-gfx mailing list</pre>
<pre><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a></pre>
<pre><a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04=
%7C01%7CDavid.Nieto%40amd.com%7C3c0071a8a2a74127027408d913ba53e4%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637562513264718308%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3Dg11aunC78b48N19Q%2FFXJBK%2B2Z0PZBWdqp%2FzhsPiqQ8Q%3D&amp;rese=
rved=3D0">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
</blockquote>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp;</p>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB284050850E3DD885927F97F1F4539BYAPR12MB2840namp_--

--===============2025523940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2025523940==--
