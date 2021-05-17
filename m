Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210E5C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 20:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E251360FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 20:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E251360FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810AA6E0F1;
	Mon, 17 May 2021 20:08:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050B46E0F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 20:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/gcnQWUOxNSNXgVfVWNL6KE91vfamHHi9rMAXi+i7X1Ud1WVmbtw+UHIVYGZEQExa34tedw/GYAEBsY5JYfLXWbKgm5FB6KS9bvyT9A/NmzQi6ChaEOZOjhmyHcX82Y4Y/aat52u/GPHveJyLX8tCSvv5ZnJoA7tOth8EmA+J4YkwSrIHIwOJYujSoCiQ1Pv1cSL6KxwECuAC5McHdDBfnOUHUU1wp7YUqiXfWfolnI+nLT4cgJfK0znNiIfJlmq/5lZiDQBTkJXSIdSWp/XihjD2mkxjcO8aox6IOHi3VxA3cGo7H+lUcA67jNBO4CAxpBUk+lft5izLeJphPkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ws9AUHKghgB4Diuo619qywZIbRTxxxdf7BfswlI3aw=;
 b=ngSrNDjGvxYSn03Hto+fmFp4f9cYdWAa9iSfzrQw5wVz+cg3Cztbki1I/UGeUFFuw7lIIsmkEtn9EhAhnjN/+BDC64nnCSBSRuvSWWvrYFueumpD2VlNaiADFDiszxbSINUhl/Ls6vYaAow5k5QpkvmVYEfXteNyJqAi3WOVCshtWu0fSWfFWxDMlN3na3ijiKOg9sAjCg1891u6TQ4Ehwiciz2ie+TfJ8dbeHPrRqtWnSvFLhstN9WJwAaVZi1iYlwwPUNC9K5A8Lrq5/5WurSZ+YfPmLaTLNz7j0t+NNmYTek/zlYG1EIYyELsoq58xWPxBFYwXB+6iR82P+LoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ws9AUHKghgB4Diuo619qywZIbRTxxxdf7BfswlI3aw=;
 b=bYmTM/z9y3CxlUktHd3zRf8WTOL6zN+jwXbaTPEX9uUv5P/5MALJpndZkbXKCMGJeQvOAzN8lcuV5rGGA7xztH3qDwfUMMhKEdg8wFMW7lPxelvaK+kFX7ee7rQkgNTK3O6V4H0ZDELsoTaJiPBrRngRhq0Lp+2zW7hLOmufGq8=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 20:08:35 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 20:08:34 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
Thread-Topic: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
Thread-Index: AQHXSuEcuETPwjKslkm6HnhXoDebuarnPLcAgADd+HQ=
Date: Mon, 17 May 2021 20:08:34 +0000
Message-ID: <BYAPR12MB284058062B8E32A58BDBA02FF42D9@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210517055413.28417-1-Jiawei.Gu@amd.com>,
 <4d02568a-0a84-1e68-23d5-23b0cb3865bf@gmail.com>
In-Reply-To: <4d02568a-0a84-1e68-23d5-23b0cb3865bf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-17T20:08:34.100Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.143.192.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca32aac8-60ff-48a6-ce59-08d9196f8d1a
x-ms-traffictypediagnostic: BY5PR12MB4308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB43089955C0EE751E5E8F6B7AF42D9@BY5PR12MB4308.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SlLgClJFYvMmp3WynWncwguWAQlX/zOZgCYmuAF4msOq4044QY672ceS9uXVH6KmJ3suvRxtQ4cMu/C9MAi+//A5O3TdidSkpZVqx6QgGTqTglRcowei/uCGRpk7uE+xq7MttS0XJya+9xfwTQmqlqlE5yXnkoQibK8PovPtNY5JLndkrdKFSzZrTUfGUDECWSsXXvTCouQoQPHbXGGKUwEPBSVquph33HIrtWPJ7FEeK2rseqdxT7hANxuxbIrhOtmD5hNns+HiabJMy8W09VbmLUDHflm4mbJ1c/iJVO9s5bdFtLeKjPOfL5Q0IHFCAkDeDY4hraEgCjMItLGihRf5VpLD0EVO3XZzWexLKfEFBj/4enNkV5jSxtxSMrFU6xmZQb1XMmJC7IFX9ybFyZ4QsfPzY5Lh3zi9SmEIKsZEdY4/qRDLgh9rpDJJ8uzBL3lZqB9t0eOY7pyFQYDDNkzu+Wf9fZwVCBPJMs/+3jp5TDoNAHrm+g8qQaijtTwU8zZ6c7Psc74fhv/OYgiUBiOCvwEBB7E8mDSG2wKRhkQrDU6BvMLIQUYxbRtpqdmZjJOTB/N1UpTlFt8buUuWH4XVsFci9Baox0OpfoTouPI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(66574015)(86362001)(26005)(83380400001)(64756008)(4326008)(66446008)(66556008)(8936002)(53546011)(6506007)(76116006)(186003)(110136005)(316002)(66476007)(2906002)(19627405001)(8676002)(7696005)(55016002)(38100700002)(71200400001)(478600001)(66946007)(33656002)(122000001)(5660300002)(52536014)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?nyTo4O6ASqYzoOeEbVOc6hPpRTIe+S6+uLXpafS6bNZFzEg0g2kfUcO9vW?=
 =?iso-8859-1?Q?O3AkNsku+SQFRS7tb7Nq7NL87k9wCFyje0YFot6OJN/rDSJ26GNNGAnWGy?=
 =?iso-8859-1?Q?YBqG2vssKN6S2iCBMUAv97KuggJeC8fDqkpJRCVeJW4bhHnkRkDfCND827?=
 =?iso-8859-1?Q?NZsdDoo8xJg4p0gPMfISOiQBEE9bdWa+TOZQTIdbqjSkgFvnDXrOLkXr+j?=
 =?iso-8859-1?Q?Tdg1avfzMIWyTfu7CLcUJ1e3q7nwK/pFY+WtKHLoZm3Ubzm+TMcAW1MdUq?=
 =?iso-8859-1?Q?uBQ8B5kFwRXcMHesjFjr1wcxROmTzxObz2iUng9K5/BZ0AnDSKDI1W/w3R?=
 =?iso-8859-1?Q?aS6Knd2W5ZCL2VX6ardT4kRfjz9DKxTkjxZ9jjzhpuvsgsEuFYOggAgWU6?=
 =?iso-8859-1?Q?37KrMPkDm5VO5UxloGvWgrY56Q4/NlKz+RSC96o0Beym6KjP7gL8Bc2gS8?=
 =?iso-8859-1?Q?tM7nvybS8vyRtMo9kGF8bf/p32PvgJCCWEFw9CTJkRY3EjsohaIK0eFC1Y?=
 =?iso-8859-1?Q?dtV+rMa/9EZIVY2R2gwTESeYn6kOYqkdXDpWuWv5upC/CvGxGJSmTj/E+/?=
 =?iso-8859-1?Q?hLe2tWeKb+lw+Rfy+gHECRgXG3JD2hArAMTqccuGCjYqT5mZ0/1LDds18I?=
 =?iso-8859-1?Q?UIQf5edLj4AemLFjC4DA3s9662h4Cr47Bba/XYVPp4jfgHx8ZYmgRFh2qY?=
 =?iso-8859-1?Q?4KDP81SP6tadznAajwQM+JI3R2Vcx9afZw7cMZ46EHloDcGTKsIGnR/MbP?=
 =?iso-8859-1?Q?E2gSJX7qF2JIW9iTB+7K+oj2vNeMUlcYmPUHgw+imvnqR8t2TkaOQyuO0e?=
 =?iso-8859-1?Q?8g1kJtRiFXy/FT3Kk5Yy9QhCibJaD+vuDb5epvNmJYWvELrCWD+cfNHqRi?=
 =?iso-8859-1?Q?+L3S4g50+x14wHcp9m0yzFxXlpEIvzUCmQu7wBUhNb51NVxyI9CVyXFy/B?=
 =?iso-8859-1?Q?lQETKb4uQeZ//jY4v9ACB3N2jryZwcRyWoUeuKZOU1DHVanWnTY7QH+oIV?=
 =?iso-8859-1?Q?PS0p4W4R6gMv2bbmJl+sgQy1i8qxCf8qfjRs/e4V/qlczEzLHYTMPdchZN?=
 =?iso-8859-1?Q?2gbwfxMR2HqGhQh7ixiTk/asYvtHwLzU/HbUbgaDCUsOCuwFOwHB5JpoRE?=
 =?iso-8859-1?Q?KsS/9+Vnx11/Z/wjxIL2kpB0FqzaIORNPBH7Pwtou3K6rnnAMDIiM7JMoX?=
 =?iso-8859-1?Q?oFxInMUFoe+kXKAu7YsbEILClZZX8DOhFiILX93z1TFh2oQwyYZzRSYGVK?=
 =?iso-8859-1?Q?EzQMrPc2ef3MNjAdexFLugqMeH0t32mTpVYMii7INtXf7uk6absFbJpR/4?=
 =?iso-8859-1?Q?yDTeGapQJz94PC0UNnNiapy3W6z3sJtVle74McB7Mi5SUS0kTN0I6SOCkw?=
 =?iso-8859-1?Q?f9994nTEg2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca32aac8-60ff-48a6-ce59-08d9196f8d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 20:08:34.6585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zo5u3lT7zys8MmqwmMPUkeMtuCdWx5VdHtpaVu0Isrvc516oWmqfc0OGKLi20FV5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: multipart/mixed; boundary="===============0978578308=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0978578308==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB284058062B8E32A58BDBA02FF42D9BYAPR12MB2840namp_"

--_000_BYAPR12MB284058062B8E32A58BDBA02FF42D9BYAPR12MB2840namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

It is for unique identification of the GPU in system management application=
s, the 64 bit asic number is only available in Vega10 and later and not com=
pliant with RFC4122.

David
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Sunday, May 16, 2021 11:52 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org <a=
md-gfx@lists.freedesktop.org>
Cc: Deng, Emily <Emily.Deng@amd.com>; Nieto, David M <David.Nieto@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID

Am 17.05.21 um 07:54 schrieb Jiawei Gu:
> Introduce an RFC 4122 compliant UUID for the GPUs derived
> from the unique GPU serial number (from Vega10) on gpus.
> Where this serial number is not available, use a compliant
> random UUID.
>
> For virtualization, the unique ID is passed by the host driver
> in the PF2VF structure.

The question is why this is useful.

>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 36 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +-
>   drivers/gpu/drm/amd/amdgpu/nv.c             |  5 ++
>   drivers/gpu/drm/amd/amdgpu/nv.h             |  3 +
>   6 files changed, 146 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3147c1c935c8..ad6d4b55be6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -802,6 +802,40 @@ struct amd_powerplay {
>                                          (rid =3D=3D 0x01) || \
>                                          (rid =3D=3D 0x10))))
>
> +union amdgpu_uuid_info {
> +     struct {
> +             union {
> +                     struct {
> +                             uint32_t did    : 16;
> +                             uint32_t fcn    : 8;
> +                             uint32_t asic_7 : 8;
> +                     };

Bitfields are not allowed in structures used for communication with
hardware or uAPI.

Regards,
Christian.

> +                     uint32_t time_low;
> +             };
> +
> +             struct {
> +                     uint32_t time_mid  : 16;
> +                     uint32_t time_high : 12;
> +                     uint32_t version   : 4;
> +             };
> +
> +             struct {
> +                     struct {
> +                             uint8_t clk_seq_hi : 6;
> +                             uint8_t variant    : 2;
> +                     };
> +                     union {
> +                             uint8_t clk_seq_low;
> +                             uint8_t asic_6;
> +                     };
> +                     uint16_t asic_4;
> +             };
> +
> +             uint32_t asic_0;
> +     };
> +     char as_char[16];
> +};
> +
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   struct amdgpu_device {
> @@ -1074,6 +1108,8 @@ struct amdgpu_device {
>        char                            product_name[32];
>        char                            serial[20];
>
> +     union amdgpu_uuid_info uuid_info;
> +
>        struct amdgpu_autodump          autodump;
>
>        atomic_t                        throttling_logging_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7c6c435e5d02..079841e1cb52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -37,6 +37,7 @@
>   #include <linux/vgaarb.h>
>   #include <linux/vga_switcheroo.h>
>   #include <linux/efi.h>
> +#include <linux/uuid.h>
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_i2c.h"
> @@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_setting=
s(struct amdgpu_device *adev)
>        return ret;
>   }
>
> +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_info)
> +{
> +     return (uuid_info->time_low    =3D=3D 0 &&
> +                     uuid_info->time_mid    =3D=3D 0 &&
> +                     uuid_info->time_high   =3D=3D 0 &&
> +                     uuid_info->version     =3D=3D 0 &&
> +                     uuid_info->clk_seq_hi  =3D=3D 0 &&
> +                     uuid_info->variant     =3D=3D 0 &&
> +                     uuid_info->clk_seq_low =3D=3D 0 &&
> +                     uuid_info->asic_4      =3D=3D 0 &&
> +                     uuid_info->asic_0      =3D=3D 0);
> +}
> +
> +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,
> +                             uint64_t serial, uint16_t did, uint8_t idx)
> +{
> +     uint16_t clk_seq =3D 0;
> +
> +     /* Step1: insert clk_seq */
> +     uuid_info->clk_seq_low =3D (uint8_t)clk_seq;
> +     uuid_info->clk_seq_hi  =3D (uint8_t)(clk_seq >> 8) & 0x3F;
> +
> +     /* Step2: insert did */
> +     uuid_info->did =3D did;
> +
> +     /* Step3: insert vf idx */
> +     uuid_info->fcn =3D idx;
> +
> +     /* Step4: insert serial */
> +     uuid_info->asic_0 =3D (uint32_t)serial;
> +     uuid_info->asic_4 =3D (uint16_t)(serial >> 4 * 8) & 0xFFFF;
> +     uuid_info->asic_6 =3D (uint8_t)(serial >> 6 * 8) & 0xFF;
> +     uuid_info->asic_7 =3D (uint8_t)(serial >> 7 * 8) & 0xFF;
> +
> +     /* Step5: insert version */
> +     uuid_info->version =3D 1;
> +     /* Step6: insert variant */
> +     uuid_info->variant =3D 2;
> +}
> +
> +/* byte reverse random uuid */
> +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)
> +{
> +     char b0, b1;
> +     int i;
> +
> +     generate_random_uuid(uuid_info->as_char);
> +     for (i =3D 0; i < 8; i++) {
> +             b0 =3D uuid_info->as_char[i];
> +             b1 =3D uuid_info->as_char[16-i];
> +             uuid_info->as_char[16-i] =3D b0;
> +             uuid_info->as_char[i] =3D b1;
> +     }
> +}
> +
> +/**
> + *
> + * The amdgpu driver provides a sysfs API for providing uuid data.
> + * The file uuid_info is used for this, and returns string of amdgpu uui=
d.
> + */
> +static ssize_t amdgpu_get_uuid_info(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   char *buf)
> +{
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);//ddev->dev_privat=
e;
> +     union amdgpu_uuid_info *uuid =3D &adev->uuid_info;
> +
> +     return sysfs_emit(buf,
> +                                     "%08x-%04x-%x%03x-%02x%02x-%04x%08x=
\n",
> +                                     uuid->time_low,
> +                                     uuid->time_mid,
> +                                     uuid->version,
> +                                     uuid->time_high,
> +                                     uuid->clk_seq_hi |
> +                                     uuid->variant << 6,
> +                                     uuid->clk_seq_low,
> +                                     uuid->asic_4,
> +                                     uuid->asic_0);
> +}
> +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);
> +
> +static void amdgpu_uuid_init(struct amdgpu_device *adev)
> +{
> +     if (amdgpu_is_uuid_info_empty(&adev->uuid_info)) {
> +             if (adev->unique_id)
> +                     amdgpu_gen_uuid_info(&adev->uuid_info, adev->unique=
_id, adev->pdev->device, 31);
> +             else
> +                     amdgpu_gen_uuid_random(&adev->uuid_info);
> +     }
> +}
> +
>   static const struct attribute *amdgpu_dev_attributes[] =3D {
>        &dev_attr_product_name.attr,
>        &dev_attr_product_number.attr,
>        &dev_attr_serial_number.attr,
>        &dev_attr_pcie_replay_count.attr,
> +     &dev_attr_uuid_info.attr,
>        NULL
>   };
>
> @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>        amdgpu_fbdev_init(adev);
>
> +     amdgpu_uuid_init(adev);
> +
>        r =3D amdgpu_pm_sysfs_init(adev);
>        if (r) {
>                adev->pm_sysfs_en =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index b71dd1deeb2d..2dfebfe38079 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_de=
vice *adev,
>   static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>   {
>        struct amd_sriov_msg_pf2vf_info_header *pf2vf_info =3D adev->virt.=
fw_reserve.p_pf2vf;
> +     union amdgpu_uuid_info *uuid =3D &adev->uuid_info;
>        uint32_t checksum;
>        uint32_t checkval;
>
> @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_=
device *adev)
>
>                adev->unique_id =3D
>                        ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->u=
uid;
> +
> +             memcpy(uuid, &((struct amd_sriov_msg_pf2vf_info *)pf2vf_inf=
o)->uuid_info_reserved,
> +                     sizeof(union amdgpu_uuid_info));
>                break;
>        default:
>                DRM_ERROR("invalid pf2vf version\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index a434c71fde8e..0d1d36e82aeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {
>                uint32_t encode_max_frame_pixels;
>        } mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>        /* UUID info */
> -     struct amd_sriov_msg_uuid_info uuid_info;
> +     uint32_t uuid_info_reserved[4];
>        /* reserved */
> -     uint32_t reserved[256 - 47];
> +     uint32_t reserved[256-47];
>   };
>
>   struct amd_sriov_msg_vf2pf_info_header {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 32c34470404c..16d4a480f4c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)
>                if (amdgpu_sriov_vf(adev))
>                        adev->rev_id =3D 0;
>                adev->external_rev_id =3D adev->rev_id + 0xa;
> +             if (!amdgpu_sriov_vf(adev)) {
> +                     adev->unique_id =3D RREG32(mmFUSE_DATA_730);
> +                     adev->unique_id <<=3D 32;
> +                     adev->unique_id |=3D RREG32(mmFUSE_DATA_729);
> +             }
>                break;
>        case CHIP_SIENNA_CICHLID:
>                adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu=
/nv.h
> index 515d67bf249f..520ac2b98744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.h
> @@ -26,6 +26,9 @@
>
>   #include "nbio_v2_3.h"
>
> +#define mmFUSE_DATA_729 (0x176D9)
> +#define mmFUSE_DATA_730 (0x176DA)
> +
>   void nv_grbm_select(struct amdgpu_device *adev,
>                    u32 me, u32 pipe, u32 queue, u32 vmid);
>   void nv_set_virt_ops(struct amdgpu_device *adev);


--_000_BYAPR12MB284058062B8E32A58BDBA02FF42D9BYAPR12MB2840namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
It is for unique identification of the GPU in system management application=
s, the 64 bit asic number is only available in Vega10 and later and not com=
pliant with RFC4122.</div>
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
<b>Sent:</b> Sunday, May 16, 2021 11:52 PM<br>
<b>To:</b> Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;; amd-gfx@lists.freed=
esktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; Nieto, David M &lt;David=
.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 17.05.21 um 07:54 schrieb Jiawei Gu:<br>
&gt; Introduce an RFC 4122 compliant UUID for the GPUs derived<br>
&gt; from the unique GPU serial number (from Vega10) on gpus.<br>
&gt; Where this serial number is not available, use a compliant<br>
&gt; random UUID.<br>
&gt;<br>
&gt; For virtualization, the unique ID is passed by the host driver<br>
&gt; in the PF2VF structure.<br>
<br>
The question is why this is useful.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Jiawei Gu &lt;Jiawei.Gu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 36 ++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 96 ++++=
+++++++++++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp;&nbsp;=
 |&nbsp; 4 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |&nbsp; 4 +-<b=
r>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +<br>
&gt;&nbsp;&nbsp; 6 files changed, 146 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 3147c1c935c8..ad6d4b55be6c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -802,6 +802,40 @@ struct amd_powerplay {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (rid =3D=3D 0x01) || \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (rid =3D=3D 0x10))))<br>
&gt;&nbsp;&nbsp; <br>
&gt; +union amdgpu_uuid_info {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; union {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t did&nbsp;&nbsp;&nbsp; : 16;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fcn&nbsp;&nbsp;&nbsp; : 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t asic_7 : 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
<br>
Bitfields are not allowed in structures used for communication with <br>
hardware or uAPI.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t time_low;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t time_mid&nbsp;=
 : 16;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t time_high : 12=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t version&nbsp;&=
nbsp; : 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_seq_hi : 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t variant&nbsp;&nbsp;&nbsp; : 2;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_seq_low;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t asic_6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t asic_4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t asic_0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; char as_char[16];<br>
&gt; +};<br>
&gt; +<br>
&gt;&nbsp;&nbsp; #define AMDGPU_RESET_MAGIC_NUM 64<br>
&gt;&nbsp;&nbsp; #define AMDGPU_MAX_DF_PERFMONS 4<br>
&gt;&nbsp;&nbsp; struct amdgpu_device {<br>
&gt; @@ -1074,6 +1108,8 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_nam=
e[32];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial[20];=
<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info uuid_info;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttling_logging_enabled;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 7c6c435e5d02..079841e1cb52 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -37,6 +37,7 @@<br>
&gt;&nbsp;&nbsp; #include &lt;linux/vgaarb.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;linux/vga_switcheroo.h&gt;<br>
&gt;&nbsp;&nbsp; #include &lt;linux/efi.h&gt;<br>
&gt; +#include &lt;linux/uuid.h&gt;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_trace.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_i2c.h&quot;<br>
&gt; @@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_sett=
ings(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_in=
fo)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (uuid_info-&gt;time_low&nbsp;&nbsp;&n=
bsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;time_mid&=
nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;time_high=
&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;version&n=
bsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;clk_seq_h=
i&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;variant&n=
bsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;clk_seq_l=
ow =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_4&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_0&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint64_t serial, uint16_t did, uint8_t idx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t clk_seq =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Step1: insert clk_seq */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;clk_seq_low =3D (uint8_t)clk_s=
eq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;clk_seq_hi&nbsp; =3D (uint8_t)=
(clk_seq &gt;&gt; 8) &amp; 0x3F;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Step2: insert did */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;did =3D did;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Step3: insert vf idx */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;fcn =3D idx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Step4: insert serial */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_0 =3D (uint32_t)serial;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_4 =3D (uint16_t)(serial &=
gt;&gt; 4 * 8) &amp; 0xFFFF;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_6 =3D (uint8_t)(serial &g=
t;&gt; 6 * 8) &amp; 0xFF;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_7 =3D (uint8_t)(serial &g=
t;&gt; 7 * 8) &amp; 0xFF;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Step5: insert version */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;version =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Step6: insert variant */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;variant =3D 2;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* byte reverse random uuid */<br>
&gt; +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; char b0, b1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; generate_random_uuid(uuid_info-&gt;as_char);=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 8; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; b0 =3D uuid_info-&gt;as_char[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; b1 =3D uuid_info-&gt;as_char[16-i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uuid_info-&gt;as_char[16-i] =3D b0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uuid_info-&gt;as_char[i] =3D b1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + *<br>
&gt; + * The amdgpu driver provides a sysfs API for providing uuid data.<br=
>
&gt; + * The file uuid_info is used for this, and returns string of amdgpu =
uuid.<br>
&gt; + */<br>
&gt; +static ssize_t amdgpu_get_uuid_info(struct device *dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_=
attribute *attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_get_drvdata(=
dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to_adev(d=
dev);//ddev-&gt;dev_private;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info *uuid =3D &amp;adev-&=
gt;uuid_info;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &q=
uot;%08x-%04x-%x%03x-%02x%02x-%04x%08x\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;time_low,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;time_mid,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;version,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;time_high,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;clk_seq_hi |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;variant &lt;&lt; 6,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;clk_seq_low,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;asic_4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uu=
id-&gt;asic_0);<br>
&gt; +}<br>
&gt; +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);<b=
r>
&gt; +<br>
&gt; +static void amdgpu_uuid_init(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_is_uuid_info_empty(&amp;adev-&gt;=
uuid_info)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;unique_id)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gen_uuid_info(&a=
mp;adev-&gt;uuid_info, adev-&gt;unique_id, adev-&gt;pdev-&gt;device, 31);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gen_uuid_random(=
&amp;adev-&gt;uuid_info);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; static const struct attribute *amdgpu_dev_attributes[] =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_product_name.a=
ttr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_product_number=
.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_serial_number.=
attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pcie_replay_co=
unt.attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_uuid_info.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fbdev_init(adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_uuid_init(adev);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_pm_sysfs_init(a=
dev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;pm_sysfs_en =3D false;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.c<br>
&gt; index b71dd1deeb2d..2dfebfe38079 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu=
_device *adev,<br>
&gt;&nbsp;&nbsp; static int amdgpu_virt_read_pf2vf_data(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_pf2vf_i=
nfo_header *pf2vf_info =3D adev-&gt;virt.fw_reserve.p_pf2vf;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info *uuid =3D &amp;adev-&=
gt;uuid_info;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checksum;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checkval;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdg=
pu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;unique_id =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((struc=
t amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;uuid;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memcpy(uuid, &amp;((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;u=
uid_info_reserved,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(union amdgpu_uui=
d_info));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;invalid pf2vf version\n&quot;);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu=
/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; index a434c71fde8e..0d1d36e82aeb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t encode_max_frame_pixels;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } mm_bw_management[AMD_SRIOV=
_MSG_RESERVE_VCN_INST];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UUID info */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_uuid_info uuid_info;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uuid_info_reserved[4];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reserved */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256 - 47];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256-47];<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amd_sriov_msg_vf2pf_info_header {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c<br>
&gt; index 32c34470404c..16d4a480f4c0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;rev_id =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0xa;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_sriov_vf(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;unique_id =3D =
RREG32(mmFUSE_DATA_730);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;unique_id &lt;=
&lt;=3D 32;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;unique_id |=3D=
 RREG32(mmFUSE_DATA_729);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amd=
gpu/nv.h<br>
&gt; index 515d67bf249f..520ac2b98744 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.h<br>
&gt; @@ -26,6 +26,9 @@<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #include &quot;nbio_v2_3.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +#define mmFUSE_DATA_729 (0x176D9)<br>
&gt; +#define mmFUSE_DATA_730 (0x176DA)<br>
&gt; +<br>
&gt;&nbsp;&nbsp; void nv_grbm_select(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 me, u32 pipe, u32 queue, u3=
2 vmid);<br>
&gt;&nbsp;&nbsp; void nv_set_virt_ops(struct amdgpu_device *adev);<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB284058062B8E32A58BDBA02FF42D9BYAPR12MB2840namp_--

--===============0978578308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0978578308==--
