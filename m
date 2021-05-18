Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A91C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 20:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2A16100A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 20:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2A16100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535036ECA1;
	Tue, 18 May 2021 20:37:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D0F6EC9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 20:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaZ2lnjexpK4BwehH5wpBBNUrZUvSy06asBenr96xS+otvL+Lv0m0zrlrZR+KDHb4isLVmI+7H1ikW4JAdrcfp6ay76nplUpk90hM/fhGQ5LeGJlNeKJ7EH2OMmA2g9XHG4kdFTjGhvZfb6ii4vN6Q7YygoMKsXEB/DU3pvrBQklFq83ikFNA2hhtXmQ9rh5SxMtytdwus6f1CIcayemRYAXb/cYx6C3R3qJBqDdKaFbeaHbFEeQbb6kxobn32UexfOi6KIVRuyxedfUV3ngpDbRm5n8lHJtnQSr+yemWRHj2Jh/kpjNIlRMviKagCf3g1eYgpdEB3cZFzXtgN72Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Eea07EF73I6Pm1ki+sUcqqW/VByPXCHEQFSGA/v7pw=;
 b=UjeB4tOIMSiF2/n7tk4tMt7KjKT28wHVhwndgbahqJ4QpEhP30gn1MwRNnJTEBSwDy/2Zp3VknG/kMIYaVA7zyHp9MwgZrmwXoNIktXeLiwDzxsE2ViCT+0p4XyFEUn7QxYqRIhKAibJSNyTxExywZu6nmRYCWlzioTtYXCobzZFNgNQMmpCvnXwGnuTFo6Lilau2uMGvk4u21bE9XKpqMtyoZ/IyV67i7RTJbODw9mrHQ9jgbb/v54FxWkiJtQpoZxycpBMOtgyCVmv0kwppNnAu9PwYV4XI+48Ddqc6xyvTNHAzvjg9wG2dQL9UEovIVzXJv8DZIzenhEZDzoYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Eea07EF73I6Pm1ki+sUcqqW/VByPXCHEQFSGA/v7pw=;
 b=e2XCU8ugnaRdHxaPNA8qwTsuA5pAPz9nFOCBoVLZDUx3CzLjjf0p6STH9aJh8FybT96dG/SCpUJDJ1E1Hf6qPNdRwnn1I2j/GynRLoqhbOB0jmPM/TkBk+ZgquAG9dU6dHnVZPJaqfnkjHZnLrhY3MOStZfzDY8eAFMmUA5foZU=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3605.namprd12.prod.outlook.com (2603:10b6:a03:ae::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 20:37:06 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 20:37:06 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Gu, JiaWei (Will)"
 <JiaWei.Gu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
Thread-Topic: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
Thread-Index: AQHXSuEcuETPwjKslkm6HnhXoDebuarpSgcAgABpw8g=
Date: Tue, 18 May 2021 20:37:06 +0000
Message-ID: <BYAPR12MB2840D36066EF94573527A8F4F42C9@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210517055413.28417-1-Jiawei.Gu@amd.com>,
 <CADnq5_MLzM8+f3LU5QbDsn0haUNvKECQe3rR9HdoYpcooUpN6w@mail.gmail.com>
In-Reply-To: <CADnq5_MLzM8+f3LU5QbDsn0haUNvKECQe3rR9HdoYpcooUpN6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-18T20:37:05.652Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.53.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55ca6618-51a8-42fd-2631-08d91a3cb38f
x-ms-traffictypediagnostic: BYAPR12MB3605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3605679F07CFB8D77687212DF42C9@BYAPR12MB3605.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPoiSOFDpz/KlA0ehR0QuvqqAA2UPt/B9kWm5YkpTDko7rt2WxdDM/Shua7mzwxBIvok4ub1Iy+elIf2JKQ20tkyH+ehkc3A/2nmf2uHi6qNKlbmPVm+OoiC0YPmNRzCiGwlUSyYxs4MXjZnwWd/WvERN4lus2Q7qum1AuEQuDJyqRe0jj6h/zkTUgMlnO/oKUEuFhKhjM+Bioli8zq15IxUKOoVNWrsu14FvmKQggfh5VI8jXWcyP6lhIRQMWFIDGrF4P4AoVkDGsrKqUo3SippMkzs1ijMJ2sn24Q2rI06kSvr296rSUKv5MUu0Me7rYdIbezbe1ApanJUWPdNmirfniUZw8hcX4JVxjvhuH9onxwbHp1r7dtUf5N+i9D8FtetVlO7GGj1G/M7DtserP2tbaZ1KAnCcW4QJQdaqpyW/lv4AvNQVRJlE7nUS3T+HAIhMJFENXureXDk9UE8iRY77p1CiqCMWU5r+Vq90nEHzwjY/HTw6Q6bORV3x1XOdH/T6ciV1piuDP3zyrrJRRr50KmrZI4uLkWhDfX4FYUOsYWArUj3pHq30D74JybTBXhQV+rcrTyxvk88q8Tjv+zLpOBRR8Tcsc+8fW+MQIDyoBMLlEZNcOW0g09y6TJDPhus4vlnKfQu5+3xeQNuyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(4326008)(83380400001)(166002)(71200400001)(6506007)(53546011)(8936002)(966005)(6636002)(52536014)(64756008)(478600001)(5660300002)(66946007)(66556008)(66446008)(7696005)(66476007)(186003)(76116006)(45080400002)(26005)(8676002)(110136005)(86362001)(2906002)(19627405001)(316002)(54906003)(33656002)(55016002)(38100700002)(122000001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n5XhPgZcOxFAapGEzvgXcMs6E0xXLdH08UWESkwkTQ/ItsUf7iQ8aoxjpZUG?=
 =?us-ascii?Q?+cddxXPi+j1PdanSgvVlOzB19BV8k0Qsz063+rW0Vsg2Js59/vx2mBru106P?=
 =?us-ascii?Q?X2AcEiDWM0z/8XYHnL4sHt+uoX7nanf8Ib15lg5MCegTsplkqQL1Dzr+v7Wi?=
 =?us-ascii?Q?xb4dYodfs9Uun8b50ZMDxazfmre8pZJlV2FbqY42jYZ2kPxbINrag/gdAdYL?=
 =?us-ascii?Q?dgd06YX2wFulH2smx0uezDIJvC1xd1VxIaisu1gEU0Y9i9j26jLIpNZiZWkv?=
 =?us-ascii?Q?RCN8VzQYpbWwv6GIcQ9U3Yn4YtmQTboc1b07jhtPfI0uwONK41YJR1ivQhFt?=
 =?us-ascii?Q?4Ziw4Rk7j1F/6pnPay/jVDSnfkDm4hrBKUZQcEM5SeusQlH31YlFOnePno/e?=
 =?us-ascii?Q?0wKYxXNtZ6cXl2SpXAuMlC0gcP/VlvFpfMtk6g6ixXzstEEKgvghERGqMINT?=
 =?us-ascii?Q?Mzzjmrhj2b4cYMW73cPSrUa9fE971Xv4+0Qd0M8IWY73jEn/3ix5Ic/MgkCQ?=
 =?us-ascii?Q?ZGjCSlPENINzwNV0IB1IBw+VVdbTZiLB4OVbp9g0arm/rmjH+D1hv0i2Rb0y?=
 =?us-ascii?Q?1npMmteLPEDmAoyOqcS01YpjxOGeHofLihOBOTOLjsfkvCcC2CgnJ7S6RAIh?=
 =?us-ascii?Q?VYmdnMaGkJumpdEHNWVVsteCmOa1M41dPL/dIdSjx7XTVIGKEoZPvnO1qiL4?=
 =?us-ascii?Q?s16ZzlgujVFmYciHvn3/uwt3BRYiLt/BZqfKdUyLNO5GF0ZekV6rH+ICbg4T?=
 =?us-ascii?Q?TIsjFRCPBWtnmxPNsruXvmvViroo3Z0ClZJpeyu4GVm4owFu5S2A9I4b7dUn?=
 =?us-ascii?Q?dlxT6SRJ8MpDMoWX1n1I8BEHPgsvAGN8YcyQOEkowG9WaGUE5VmjUF56fKnJ?=
 =?us-ascii?Q?vmm7Ax7K6NytgFVbJ8OOrP2+jyUr0xx2Fm/++c8Zv1slmqlh++k6XwbKu6Oo?=
 =?us-ascii?Q?1jwmi4UNvfken90qNmwCGn878axFI4EY2KqhdDse52BrLMIxBD91LcD1KzOs?=
 =?us-ascii?Q?1RqMqf8e5L9NMK+Z5De+wQb1VjaO8qpiuPx0+9cWGCNDlvcT3tMVOwSxFD5y?=
 =?us-ascii?Q?xCQ4t/giuVXN2055a7M/2rKhDPqI+zksdxrEbJlUi98gc0Q8455iKZ9HBQI3?=
 =?us-ascii?Q?C4CM/Q3wRrzofir5Ux9Y+St794LaOqdq8E1YnPz116IiyH9UqmPFZ2CNlojf?=
 =?us-ascii?Q?I/kVNzDJ6198z4zHOhFHYKZ8jkCEKSkZu0J8OJA0GHOcPLEA98Ybi2CHoSqC?=
 =?us-ascii?Q?UWDqVN/V3bortZq9Y1YoFjfj9+Kkgb9BPda0JpWe7AeAmhBuCx0F4ZRfWJ9X?=
 =?us-ascii?Q?C+5FGwDI1Zz8NN0gXfM+V+g9?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ca6618-51a8-42fd-2631-08d91a3cb38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 20:37:06.1839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ovML/jyxUdrJgtWQvK8y9vgMTgpIQC06Td4wI8Mao6YqDCuou38sBnpIfd6YHdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3605
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2079452540=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2079452540==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2840D36066EF94573527A8F4F42C9BYAPR12MB2840namp_"

--_000_BYAPR12MB2840D36066EF94573527A8F4F42C9BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I think the sysfs node should be moved into amdgpu_pm instead of the amdgpu=
_device.c and generation of the unique_id should be moved to navi10_ppt.c, =
similarly to other chips.

Thinking it better, generating a random UUID makes no sense in the driver l=
evel, any application can do the same thing on userspace if the UUID sysfs =
node is empty.

So, I think we should do the same as with the unique_id node, if the unique=
_id is not present, just return.

David
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, May 18, 2021 7:12 AM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily <Emily.Deng@a=
md.com>; Nieto, David M <David.Nieto@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID

On Mon, May 17, 2021 at 1:54 AM Jiawei Gu <Jiawei.Gu@amd.com> wrote:
>
> Introduce an RFC 4122 compliant UUID for the GPUs derived
> from the unique GPU serial number (from Vega10) on gpus.
> Where this serial number is not available, use a compliant
> random UUID.
>
> For virtualization, the unique ID is passed by the host driver
> in the PF2VF structure.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 36 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  4 +
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c             |  5 ++
>  drivers/gpu/drm/amd/amdgpu/nv.h             |  3 +
>  6 files changed, 146 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3147c1c935c8..ad6d4b55be6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -802,6 +802,40 @@ struct amd_powerplay {
>                                           (rid =3D=3D 0x01) || \
>                                           (rid =3D=3D 0x10))))
>
> +union amdgpu_uuid_info {
> +       struct {
> +               union {
> +                       struct {
> +                               uint32_t did    : 16;
> +                               uint32_t fcn    : 8;
> +                               uint32_t asic_7 : 8;
> +                       };
> +                       uint32_t time_low;
> +               };
> +
> +               struct {
> +                       uint32_t time_mid  : 16;
> +                       uint32_t time_high : 12;
> +                       uint32_t version   : 4;
> +               };
> +
> +               struct {
> +                       struct {
> +                               uint8_t clk_seq_hi : 6;
> +                               uint8_t variant    : 2;
> +                       };
> +                       union {
> +                               uint8_t clk_seq_low;
> +                               uint8_t asic_6;
> +                       };
> +                       uint16_t asic_4;
> +               };
> +
> +               uint32_t asic_0;
> +       };
> +       char as_char[16];
> +};
> +
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_device {
> @@ -1074,6 +1108,8 @@ struct amdgpu_device {
>         char                            product_name[32];
>         char                            serial[20];
>
> +       union amdgpu_uuid_info uuid_info;
> +
>         struct amdgpu_autodump          autodump;
>
>         atomic_t                        throttling_logging_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7c6c435e5d02..079841e1cb52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -37,6 +37,7 @@
>  #include <linux/vgaarb.h>
>  #include <linux/vga_switcheroo.h>
>  #include <linux/efi.h>
> +#include <linux/uuid.h>
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_i2c.h"
> @@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_setting=
s(struct amdgpu_device *adev)
>         return ret;
>  }
>
> +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_info)
> +{
> +       return (uuid_info->time_low    =3D=3D 0 &&
> +                       uuid_info->time_mid    =3D=3D 0 &&
> +                       uuid_info->time_high   =3D=3D 0 &&
> +                       uuid_info->version     =3D=3D 0 &&
> +                       uuid_info->clk_seq_hi  =3D=3D 0 &&
> +                       uuid_info->variant     =3D=3D 0 &&
> +                       uuid_info->clk_seq_low =3D=3D 0 &&
> +                       uuid_info->asic_4      =3D=3D 0 &&
> +                       uuid_info->asic_0      =3D=3D 0);
> +}
> +
> +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,
> +                               uint64_t serial, uint16_t did, uint8_t id=
x)
> +{
> +       uint16_t clk_seq =3D 0;
> +
> +       /* Step1: insert clk_seq */
> +       uuid_info->clk_seq_low =3D (uint8_t)clk_seq;
> +       uuid_info->clk_seq_hi  =3D (uint8_t)(clk_seq >> 8) & 0x3F;
> +
> +       /* Step2: insert did */
> +       uuid_info->did =3D did;
> +
> +       /* Step3: insert vf idx */
> +       uuid_info->fcn =3D idx;
> +
> +       /* Step4: insert serial */
> +       uuid_info->asic_0 =3D (uint32_t)serial;
> +       uuid_info->asic_4 =3D (uint16_t)(serial >> 4 * 8) & 0xFFFF;
> +       uuid_info->asic_6 =3D (uint8_t)(serial >> 6 * 8) & 0xFF;
> +       uuid_info->asic_7 =3D (uint8_t)(serial >> 7 * 8) & 0xFF;
> +
> +       /* Step5: insert version */
> +       uuid_info->version =3D 1;
> +       /* Step6: insert variant */
> +       uuid_info->variant =3D 2;
> +}
> +
> +/* byte reverse random uuid */
> +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)
> +{
> +       char b0, b1;
> +       int i;
> +
> +       generate_random_uuid(uuid_info->as_char);
> +       for (i =3D 0; i < 8; i++) {
> +               b0 =3D uuid_info->as_char[i];
> +               b1 =3D uuid_info->as_char[16-i];
> +               uuid_info->as_char[16-i] =3D b0;
> +               uuid_info->as_char[i] =3D b1;
> +       }
> +}
> +
> +/**
> + *
> + * The amdgpu driver provides a sysfs API for providing uuid data.
> + * The file uuid_info is used for this, and returns string of amdgpu uui=
d.
> + */
> +static ssize_t amdgpu_get_uuid_info(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);//ddev->dev_priv=
ate;
> +       union amdgpu_uuid_info *uuid =3D &adev->uuid_info;
> +
> +       return sysfs_emit(buf,
> +                                       "%08x-%04x-%x%03x-%02x%02x-%04x%0=
8x\n",
> +                                       uuid->time_low,
> +                                       uuid->time_mid,
> +                                       uuid->version,
> +                                       uuid->time_high,
> +                                       uuid->clk_seq_hi |
> +                                       uuid->variant << 6,
> +                                       uuid->clk_seq_low,
> +                                       uuid->asic_4,
> +                                       uuid->asic_0);
> +}
> +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);
> +
> +static void amdgpu_uuid_init(struct amdgpu_device *adev)
> +{
> +       if (amdgpu_is_uuid_info_empty(&adev->uuid_info)) {
> +               if (adev->unique_id)
> +                       amdgpu_gen_uuid_info(&adev->uuid_info, adev->uniq=
ue_id, adev->pdev->device, 31);
> +               else
> +                       amdgpu_gen_uuid_random(&adev->uuid_info);
> +       }
> +}
> +
>  static const struct attribute *amdgpu_dev_attributes[] =3D {
>         &dev_attr_product_name.attr,
>         &dev_attr_product_number.attr,
>         &dev_attr_serial_number.attr,
>         &dev_attr_pcie_replay_count.attr,
> +       &dev_attr_uuid_info.attr,
>         NULL
>  };
>
> @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         amdgpu_fbdev_init(adev);
>
> +       amdgpu_uuid_init(adev);
> +
>         r =3D amdgpu_pm_sysfs_init(adev);
>         if (r) {
>                 adev->pm_sysfs_en =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index b71dd1deeb2d..2dfebfe38079 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_de=
vice *adev,
>  static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  {
>         struct amd_sriov_msg_pf2vf_info_header *pf2vf_info =3D adev->virt=
.fw_reserve.p_pf2vf;
> +       union amdgpu_uuid_info *uuid =3D &adev->uuid_info;
>         uint32_t checksum;
>         uint32_t checkval;
>
> @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_=
device *adev)
>
>                 adev->unique_id =3D
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->=
uuid;
> +
> +               memcpy(uuid, &((struct amd_sriov_msg_pf2vf_info *)pf2vf_i=
nfo)->uuid_info_reserved,
> +                       sizeof(union amdgpu_uuid_info));
>                 break;
>         default:
>                 DRM_ERROR("invalid pf2vf version\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index a434c71fde8e..0d1d36e82aeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {
>                 uint32_t encode_max_frame_pixels;
>         } mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>         /* UUID info */
> -       struct amd_sriov_msg_uuid_info uuid_info;
> +       uint32_t uuid_info_reserved[4];
>         /* reserved */
> -       uint32_t reserved[256 - 47];
> +       uint32_t reserved[256-47];
>  };
>
>  struct amd_sriov_msg_vf2pf_info_header {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 32c34470404c..16d4a480f4c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)
>                 if (amdgpu_sriov_vf(adev))
>                         adev->rev_id =3D 0;
>                 adev->external_rev_id =3D adev->rev_id + 0xa;
> +               if (!amdgpu_sriov_vf(adev)) {
> +                       adev->unique_id =3D RREG32(mmFUSE_DATA_730);
> +                       adev->unique_id <<=3D 32;
> +                       adev->unique_id |=3D RREG32(mmFUSE_DATA_729);
> +               }

I would suggest putting this in navi10_get_unique_id() in navi10_ppt.c
for consistency since we query this from the SMU on most other asics.

Alex



>                 break;
>         case CHIP_SIENNA_CICHLID:
>                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu=
/nv.h
> index 515d67bf249f..520ac2b98744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.h
> @@ -26,6 +26,9 @@
>
>  #include "nbio_v2_3.h"
>
> +#define mmFUSE_DATA_729 (0x176D9)
> +#define mmFUSE_DATA_730 (0x176DA)
> +
>  void nv_grbm_select(struct amdgpu_device *adev,
>                     u32 me, u32 pipe, u32 queue, u32 vmid);
>  void nv_set_virt_ops(struct amdgpu_device *adev);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdavid.=
nieto%40amd.com%7Cb6a43b8c156c4a6964e208d91a070e84%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637569439877514988%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
7lpRnRgRwKASGUmfr3RChO0P6QfRbcpMFggQl6HO%2Bss%3D&amp;reserved=3D0

--_000_BYAPR12MB2840D36066EF94573527A8F4F42C9BYAPR12MB2840namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
I think the sysfs node should be moved into amdgpu_pm instead of the amdgpu=
_device.c and generation of the unique_id should be moved to navi10_ppt.c, =
similarly to other chips.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thinking it better, generating a random UUID makes no sense in the driver l=
evel, any application can do the same thing on userspace if the UUID sysfs =
node is empty.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
So, I think we should do the same as with the unique_id node, if the unique=
_id is not present, just return.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, May 18, 2021 7:12 AM<br>
<b>To:</b> Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deng, Emily =
&lt;Emily.Deng@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, May 17, 2021 at 1:54 AM Jiawei Gu &lt;Jiaw=
ei.Gu@amd.com&gt; wrote:<br>
&gt;<br>
&gt; Introduce an RFC 4122 compliant UUID for the GPUs derived<br>
&gt; from the unique GPU serial number (from Vega10) on gpus.<br>
&gt; Where this serial number is not available, use a compliant<br>
&gt; random UUID.<br>
&gt;<br>
&gt; For virtualization, the unique ID is passed by the host driver<br>
&gt; in the PF2VF structure.<br>
&gt;<br>
&gt; Signed-off-by: Jiawei Gu &lt;Jiawei.Gu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | 36 ++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 96 ++++++++++=
+++++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp;&nbsp; |&nbs=
p; 4 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |&nbsp; 4 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +<br>
&gt;&nbsp; 6 files changed, 146 insertions(+), 2 deletions(-)<br>
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
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rid =3D=3D 0x01) || \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rid =3D=3D 0x10))))<br>
&gt;<br>
&gt; +union amdgpu_uuid_info {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; union {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t did&nbsp;&nbsp;&nbsp; : 16;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fcn&nbsp;&nbsp;&nbsp; : 8;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t asic_7 : 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ti=
me_low;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ti=
me_mid&nbsp; : 16;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ti=
me_high : 12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ve=
rsion&nbsp;&nbsp; : 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_seq_hi : 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t variant&nbsp;&nbsp;&nbsp; : 2;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_seq_low;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t asic_6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t as=
ic_4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t asic_0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char as_char[16];<br>
&gt; +};<br>
&gt; +<br>
&gt;&nbsp; #define AMDGPU_RESET_MAGIC_NUM 64<br>
&gt;&nbsp; #define AMDGPU_MAX_DF_PERFMONS 4<br>
&gt;&nbsp; struct amdgpu_device {<br>
&gt; @@ -1074,6 +1108,8 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; produ=
ct_name[32];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seria=
l[20];<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info uuid_info=
;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttling_logging_enable=
d;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 7c6c435e5d02..079841e1cb52 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -37,6 +37,7 @@<br>
&gt;&nbsp; #include &lt;linux/vgaarb.h&gt;<br>
&gt;&nbsp; #include &lt;linux/vga_switcheroo.h&gt;<br>
&gt;&nbsp; #include &lt;linux/efi.h&gt;<br>
&gt; +#include &lt;linux/uuid.h&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_trace.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_i2c.h&quot;<br>
&gt; @@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_sett=
ings(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_in=
fo)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (uuid_info-&gt;time_low&n=
bsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;time_mid&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;time_high&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;version&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;clk_seq_hi&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;variant&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;clk_seq_low =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;asic_4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;asic_0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t serial, uint16_t did, uint8_t=
 idx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t clk_seq =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step1: insert clk_seq */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;clk_seq_low =3D (u=
int8_t)clk_seq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;clk_seq_hi&nbsp; =
=3D (uint8_t)(clk_seq &gt;&gt; 8) &amp; 0x3F;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step2: insert did */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;did =3D did;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step3: insert vf idx */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;fcn =3D idx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step4: insert serial */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_0 =3D (uint32=
_t)serial;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_4 =3D (uint16=
_t)(serial &gt;&gt; 4 * 8) &amp; 0xFFFF;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_6 =3D (uint8_=
t)(serial &gt;&gt; 6 * 8) &amp; 0xFF;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_7 =3D (uint8_=
t)(serial &gt;&gt; 7 * 8) &amp; 0xFF;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step5: insert version */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;version =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step6: insert variant */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;variant =3D 2;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* byte reverse random uuid */<br>
&gt; +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char b0, b1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; generate_random_uuid(uuid_info-&=
gt;as_char);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 8; i++) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; b0 =3D uuid_info-&gt;as_char[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; b1 =3D uuid_info-&gt;as_char[16-i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uuid_info-&gt;as_char[16-i] =3D b0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uuid_info-&gt;as_char[i] =3D b1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct device_attribute *attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch=
ar *buf)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
rm_to_adev(ddev);//ddev-&gt;dev_private;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info *uuid =3D=
 &amp;adev-&gt;uuid_info;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &quot;%08x-%04x-%x%03x-%02x%02x-%04x%08x\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;time_low,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;time_mid,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;version,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;time_high,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;clk_seq_hi |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;variant &lt;&lt; 6,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;clk_seq_low,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;asic_4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;asic_0);<br>
&gt; +}<br>
&gt; +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);<b=
r>
&gt; +<br>
&gt; +static void amdgpu_uuid_init(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_is_uuid_info_empty(&a=
mp;adev-&gt;uuid_info)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (adev-&gt;unique_id)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gen_=
uuid_info(&amp;adev-&gt;uuid_info, adev-&gt;unique_id, adev-&gt;pdev-&gt;de=
vice, 31);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gen_=
uuid_random(&amp;adev-&gt;uuid_info);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static const struct attribute *amdgpu_dev_attributes[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_product_=
name.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_product_=
number.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_serial_n=
umber.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pcie_rep=
lay_count.attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_uuid_info.attr,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fbdev_init(adev=
);<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_uuid_init(adev);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_pm_sysfs_=
init(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm_sysfs_en =3D false;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.c<br>
&gt; index b71dd1deeb2d..2dfebfe38079 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu=
_device *adev,<br>
&gt;&nbsp; static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *ade=
v)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_p=
f2vf_info_header *pf2vf_info =3D adev-&gt;virt.fw_reserve.p_pf2vf;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info *uuid =3D=
 &amp;adev-&gt;uuid_info;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checksum;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checkval;<br>
&gt;<br>
&gt; @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdg=
pu_device *adev)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;unique_id =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
(struct amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;uuid;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(uuid, &amp;((struct amd_sriov_msg_pf2vf_info *)pf2vf=
_info)-&gt;uuid_info_reserved,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(unio=
n amdgpu_uuid_info));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;invalid pf2vf version\n&quot;);<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu=
/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; index a434c71fde8e..0d1d36e82aeb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t encode_max_frame_pixels;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } mm_bw_management[AMD=
_SRIOV_MSG_RESERVE_VCN_INST];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UUID info */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_uuid_info u=
uid_info;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uuid_info_reserved[4];<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reserved */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256 - 47];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256-47];<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; struct amd_sriov_msg_vf2pf_info_header {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c<br>
&gt; index 32c34470404c..16d4a480f4c0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;rev_id =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x=
a;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;un=
ique_id =3D RREG32(mmFUSE_DATA_730);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;un=
ique_id &lt;&lt;=3D 32;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;un=
ique_id |=3D RREG32(mmFUSE_DATA_729);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
I would suggest putting this in navi10_get_unique_id() in navi10_ppt.c<br>
for consistency since we query this from the SMU on most other asics.<br>
<br>
Alex<br>
<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHL=
ID:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amd=
gpu/nv.h<br>
&gt; index 515d67bf249f..520ac2b98744 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.h<br>
&gt; @@ -26,6 +26,9 @@<br>
&gt;<br>
&gt;&nbsp; #include &quot;nbio_v2_3.h&quot;<br>
&gt;<br>
&gt; +#define mmFUSE_DATA_729 (0x176D9)<br>
&gt; +#define mmFUSE_DATA_730 (0x176DA)<br>
&gt; +<br>
&gt;&nbsp; void nv_grbm_select(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 me, u32 pipe, u32 que=
ue, u32 vmid);<br>
&gt;&nbsp; void nv_set_virt_ops(struct amdgpu_device *adev);<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cdavid.nieto%40amd.com%7Cb6a43b8c156c4a6964e208d91a070e84%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569439877514988%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D7lpRnRgRwKASGUmfr3RChO0P6QfRbcpMFggQl6HO%2Bss%3D&amp=
;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cdavi=
d.nieto%40amd.com%7Cb6a43b8c156c4a6964e208d91a070e84%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637569439877514988%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sd=
ata=3D7lpRnRgRwKASGUmfr3RChO0P6QfRbcpMFggQl6HO%2Bss%3D&amp;amp;reserved=3D0=
</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2840D36066EF94573527A8F4F42C9BYAPR12MB2840namp_--

--===============2079452540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2079452540==--
