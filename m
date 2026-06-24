Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF7CDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 05:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A1710E029;
	Wed, 24 Jun 2026 05:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZNH6DRes";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C53210E029
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 05:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTgdl1AFevILM6Nh8chCY/Fhy4vR3Qf08ix1jkvNYqNy/ZGWZcglLO+iQISklseiewWfD6SHHOyWdRUtCe8DVgl2Noq3dZIhbKhzpkK1im1HpCxec1qylpns7LiEe7it1tRhNmyEZiK99/cW0q+j/DQMOtfiXGXXEynptN45zXWPGHxWauKZmoFHparPOXwESQ8ibGd36zRfGU+9pRKF12vnNRggnweQrzyJqqFVR13HlqG81ribNkVsZtI13hUIxJRecjMGDfBQvtGqiumgD10PDl48mGj60R6us7xz+WonWX9JjW9/aSZO9EAmfme5ZwcBLjqwKCfr5ZSogunjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLQprZxCN4kLZ54McYbmiQ5pcnhh4IwmEXlpHTsIkpI=;
 b=M1tVx6PWCZ/jILJFQS1pf/owPp2qwGeAHLmEGg3wZvfhE+AaY+XDnRfmLiMaa8GVsOG2VXXIhxHCP5PRRjD42qVKVmiBvx/RuWQT2pNlLVB51XLbClYRY3tPLA7kza4A0gDsyW9UB6t9wNK33k59pD4mXbRN7eDcX0AHbCx87MV2wXEKJWNlnNNbSNCmA3itBwql0co0qnLz7HBj3df92j/2zH9BnUELwbNIDbzain6h2ZWLi345cXl/71GbzJ8DfyOLS54jSI/e3epbYs9aE0W5B2hQG6sp7Vqp/ig0c/dRSKR/uvT8nk0S1+QRFEeo/JOqhGx7Ozom5CE1yqVHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLQprZxCN4kLZ54McYbmiQ5pcnhh4IwmEXlpHTsIkpI=;
 b=ZNH6DResH6oeqvYJEx22xMmaW/gzr3DoL13M3ne+IKXbf5l3RJ9jJ61j+D7hFyV7s0f7ERcie6EKa2+u8rgVxPylIiqloAgNbgrSUpt88Jdwv5EQ4d8i/oC1l1/N9J+vS74oMUTwwTBacQxu4IYK42eLAryHSFEha/45BqENm4Q=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 05:18:35 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 05:18:35 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: fix VoltageObjectInfo zero-stride loop
 and OOB read
Thread-Topic: [PATCH] drm/amd/powerplay: fix VoltageObjectInfo zero-stride
 loop and OOB read
Thread-Index: AQHdA5TPYM+f0bZTBEaf3kf/yqa/LrZNKorA
Date: Wed, 24 Jun 2026 05:18:34 +0000
Message-ID: <DM6PR12MB2972EED5F48A879A3DD71B9E82ED2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260624044857.101938-1-asad.kamal@amd.com>
In-Reply-To: <20260624044857.101938-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T05:18:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|PH7PR12MB7842:EE_
x-ms-office365-filtering-correlation-id: 84b04b6d-dd8a-4b14-6527-08ded1b00a3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: /aEcuMr3g2RPcXOQFoQxGOcslYwkZseQNhltIhtOahIJYPD3Y0RRalRojQO0MgAmz7dqqtOlib3dfywjdOf+HtTCK7vkoyv4vTA1p5m362uDcI1Odu+eIz/mdg1RZc/z/+TD/O0JISS8wtqWm9h10u3U9O13JNKrX33qVuOnXmXNEdJsDfSOHBLy0fyHmphbKiHmGMRXSsSutk+vtwMGlou5AglDFxcRchk3juwL8mTjCBtI3zofXUwybqoVxvP7c/0Ndj2VBcF2DhOOckYdoRWVXfb/F9/RLwikXr+tqKzw5M+FiUFOsK584bVhk4E2D+VJIgRpiitKkPKOd1iOYI5cSAhyMTbMugGk95MMQScF/qtekzuNbFvXv+Lx/Z8QInCOX1vRVdnxy7nKEWN6ZyRyvPjNriF3J4uVzX9ZG47O8vG+aXqmuw+SQ2Kdohr7B14ppwmwUlwiKSs3i+RFzq3WOIGn7lv9VNo4sdkGTMB3tna/oaeLGgyuY58ftlRzWQ4xwkTWE6wFNX9dvAwQP9WVtOHyToL7BEOoqgReHTXf3GNlZR8XWAeWPdgHKSnoKIx5zT9VLS9IhSMYvrZ9lLq0ffj4UIyRYi9SVpfVdsSxwNb36aFIGvW8OJvb5v9kJhSkys8YTMRxypNolRicOfFejO1jI9fbYYjbL52U4dSbG1T1LuGyLN2CxTXxE8RS1UR2+xpeZ4kjahvEmAja9x0Pejbi+wPQ8VGgeezc+d4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VdAPw5iwmB1UIwald7Oywd3aT/W2gvIeqMeM1fSoewdxeKl9EH1waqnnarGG?=
 =?us-ascii?Q?MxHTbJ5t0Swydc9NkN5dQUi/oMV4DX45CH9bupkFDdXxlpODlXqMirEC5fu1?=
 =?us-ascii?Q?qt3JaVDZuP8INrtB02vctfavGKxnDOiwBNKEBOxsaSkQ6TkAx/NFLyU+0PBQ?=
 =?us-ascii?Q?a+GuIgsz7GAvdOynbiKwcdcn1OVzZSruHXllnACAt4mW4wFwbZA2hj8wvBaz?=
 =?us-ascii?Q?N04e00L48pKwCyN9JNV1gGX7JREgpZeUxGFqn4K23nYbVsp2RDvuMdMYB8qF?=
 =?us-ascii?Q?U3cSnS40c+oqvUA9yJ02isACoGq30DmighXU7vafa6KQVK1Cr5T7JZO8Y55z?=
 =?us-ascii?Q?G1veX2F8V1eilzGETQglK8mEXlU8dLKK6Buk+L+uiuT7c/jyZ5SUH6IFk5HK?=
 =?us-ascii?Q?1PBrKcRIeRDoDBeHgovqHaZnbA8lD4sxZ+3aXCK7iztAkBsu3HQUY+x0xgmg?=
 =?us-ascii?Q?/SIOp6YUsukdKa5wr01T9zb6HjXhjKEf/xY6RPXS/3vytShnjCy1BkfAncZ/?=
 =?us-ascii?Q?jZPD6YsAngTcjdAUIKB9U9ztCpCsirkpelyyWq97Vk9+EgC+LQrP6V54pSA0?=
 =?us-ascii?Q?Zwskf1fmsZO9lMdWfig8rSc/2oysw0lsFZ6E3+enna3xkXNe+9OyhmisReWJ?=
 =?us-ascii?Q?WRluKHpfDz+vtppIElHsNtlf3BeIYaNc1pJCetgRhjTvBBxTK/0C69yjmojZ?=
 =?us-ascii?Q?QK64F8xaVpxjHa3mc8WzMr/ZxmBvp9Y6V5Q/5THZF/7oRaJDAm09W3010BBK?=
 =?us-ascii?Q?6WNUOfT8BLLn622rNlR2NcXMCUYkGMMB/w8uVrqsXbFyNDzdlKwCg7nAg0Te?=
 =?us-ascii?Q?rR6b3fKMZPE0ybDvIrMauhjruJZtV8MCFdj019wzRivnQLwACVeIafldHqD/?=
 =?us-ascii?Q?pb2QpT5OU9W1ovj0Lrocj18ivhUt5jhxVO1COmqFmWOK0oiiecpRm4ap4XpX?=
 =?us-ascii?Q?Fr3NGC3NsgZHrxSrRGCkjDoXeAqVZtAK0ZB2x5LOUIr0KUzxlKrJ9HUjFtmk?=
 =?us-ascii?Q?XL+T0CtbIdZONBQO12XLXUY+E+KNWkczaUYQfIpelepg/wu0JzVw62ji0rGs?=
 =?us-ascii?Q?vbozuGfZSQ9CKN2zeAyXpQlKbbhbaTGJQk4gvjAYsi/RsVwOUvF5B72DBbar?=
 =?us-ascii?Q?QdQngoq8/uEY5YbfiTl9iV12M2gMlG5L8O75A7tEeUeTlkhGJAAwFa+aW8Tx?=
 =?us-ascii?Q?8e9bIPWZlpcSbEd2kFHZYlonAYOgA20LzJiB+vCX7HSbEqLLELriABSROZpY?=
 =?us-ascii?Q?InxpegL4vhSbl63RwJciDJhzXLmYRCzu9p+F7OTtvmrZlbqC5UjfmPszhIxb?=
 =?us-ascii?Q?hBxyG2lZ87wlGMv8b0v4a9zFTwej17R+vTnc3F9/m8YwjQ7+qTVhQOFuP4eZ?=
 =?us-ascii?Q?JqNhSPXuCrjRzbEufUEOntrYlUN0XHjO4sYPYkpyUIKd+GipPzbGbO2e4dpV?=
 =?us-ascii?Q?+AfTzsVVwWnWzLgkJtIFCbwYgr9gDKnXs72UHMd9UMT9A4dbEsc4QV+LoGKa?=
 =?us-ascii?Q?0bISmpFscn+l5Fn6fgAj7RwFjp/mbEwK43He7xuo+da+qpJLTbi95gKHsuvq?=
 =?us-ascii?Q?O26Me/alIJhpKK84Mx1w0XRfKpVeoP8nxY2cQzoZjovU1su7nWgqhpQu78Uz?=
 =?us-ascii?Q?GOXg8wtGEH/rPvJPC8KJd9l01KJCL5rKmDBxDeXM8nbQlrhqUptPxaBhXOxu?=
 =?us-ascii?Q?l52OS/wfpYkZ5UuijwDWOsMc9K7CKLnQLg/mpEPYQ+E+63X1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b04b6d-dd8a-4b14-6527-08ded1b00a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 05:18:34.9344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5DePKbaC2eB64x8hW1x7nz0wMnS008+KAuYtl7afz+yhOJH0fx5hiEIgyTG4vWo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Wednesday, June 24, 2026 12:49
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>
> Subject: [PATCH] drm/amd/powerplay: fix VoltageObjectInfo zero-stride loo=
p and
> OOB read
>
> Reject voltage objects whose usSize is smaller than the header or would a=
dvance
> the cursor past the table end, preventing an infinite loop or heap OOB re=
ad when the
> VBIOS supplies a malformed VoltageObjectInfo table.
>
> Fixes: c82baa281843 ("drm/amd/powerplay: add Tonga dpm support (v3)")
> Fixes: 0d2c7569e196 ("drm/amdgpu: add new atomfirmware based helpers for
> powerplay")
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 10 ++++++++--
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c | 11 ++++++++---
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index ce166a7f8e42..1fff7567bca2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -268,15 +268,21 @@ static const ATOM_VOLTAGE_OBJECT_V3
> *atomctrl_lookup_voltage_type_v3(
>       unsigned int offset =3D offsetof(ATOM_VOLTAGE_OBJECT_INFO_V3_1,
> asVoltageObj[0]);
>       uint8_t *start =3D (uint8_t *)voltage_object_info_table;
>
> -     while (offset < size) {
> +     while (offset + sizeof(ATOM_VOLTAGE_OBJECT_HEADER_V3) <=3D size) {
>               const ATOM_VOLTAGE_OBJECT_V3 *voltage_object =3D
>                       (const ATOM_VOLTAGE_OBJECT_V3 *)(start + offset);
> +             u16 obj_size;
> +
> +             obj_size =3D le16_to_cpu(voltage_object-
> >asGpioVoltageObj.sHeader.usSize);
> +             if (obj_size < sizeof(voltage_object->asGpioVoltageObj.sHea=
der) ||
> +                 offset + obj_size > size)
> +                     break;
>
>               if (voltage_type =3D=3D voltage_object-
> >asGpioVoltageObj.sHeader.ucVoltageType &&
>                       voltage_mode =3D=3D voltage_object-
> >asGpioVoltageObj.sHeader.ucVoltageMode)
>                       return voltage_object;
>
> -             offset +=3D le16_to_cpu(voltage_object-
> >asGpioVoltageObj.sHeader.usSize);
> +             offset +=3D obj_size;
>       }
>
>       return NULL;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> index 6120f14caab0..69aee8661d1e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> @@ -36,16 +36,21 @@ static const union atom_voltage_object_v4
> *pp_atomfwctrl_lookup_voltage_type_v4(
>                       offsetof(struct atom_voltage_objects_info_v4_1,
> voltage_object[0]);
>       unsigned long start =3D (unsigned long)voltage_object_info_table;
>
> -     while (offset < size) {
> +     while (offset + sizeof(struct atom_voltage_object_header_v4) <=3D s=
ize)
> +{
>               const union atom_voltage_object_v4 *voltage_object =3D
>                       (const union atom_voltage_object_v4 *)(start + offs=
et);
> +             u16 obj_size;
> +
> +             obj_size =3D le16_to_cpu(voltage_object-
> >gpio_voltage_obj.header.object_size);
> +             if (obj_size < sizeof(voltage_object->gpio_voltage_obj.head=
er) ||
> +                 offset + obj_size > size)
> +                     break;
>
>               if (voltage_type =3D=3D voltage_object-
> >gpio_voltage_obj.header.voltage_type &&
>                   voltage_mode =3D=3D voltage_object-
> >gpio_voltage_obj.header.voltage_mode)
>                       return voltage_object;
>
> -             offset +=3D le16_to_cpu(voltage_object-
> >gpio_voltage_obj.header.object_size);
> -
> +             offset +=3D obj_size;
>       }
>
>       return NULL;
> --
> 2.46.0

