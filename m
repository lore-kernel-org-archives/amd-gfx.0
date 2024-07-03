Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF4C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 08:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432AB10E75D;
	Wed,  3 Jul 2024 08:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bXGH+uct";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FB410E75D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 08:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwENzS6SxQrwRIowJ278/QWJkxESkMELoCldaiF+BSDfjovDQ3DzbCg+oGQ3LHJj2obx/7oDd3sjJaDSep7O5Cfl5IYlPukklY7SDGrWE+U5OESibc29JxRgGakXTpSuqMo1KkdbAhDn7Fm6bWWupj2AsRvsowCmU/edQsy4XlYAmzSkCsGidflDSF6Ft+xUz34liIrphDspX3n4m/e9Ixkr5uv8cl5FB43N/V3FzO2OGLe/xpWbjMpiwzDgepoAppi7cU3d7oaZB+4NUwynTu5juUKIFNEaIAYKvKmiT3hnGrcEUEHDKLgIc18qZWFD0IEwpYLXg6kucjXRuSSj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnB9EFdmbtYe9Sg8JmHt3ITcCCmSotMUivsy+86nXXw=;
 b=hFcPWBCb+KgHDV0sExDUXxqxAPreHZpwXlTYR8RiOabbO315hPdyxcEPD2U0TdJqX8sA/5REp/RRNzljeT4l0v8Jhv2fytack8i5rtn4VheyooWdMIG8D8/RuzbFadwqXYk8d4BSMMdqRsNzUgNq9p/VWiIhJ0HSOUfXlZKJEavsZUXUJ4e6EEednRVRrjqvaEfyHWbODivmiUPzZSj8JkTZfu0BOHfYT1FEAGamrO8BdDInhGglBvIXfQUVFvsianjOrZ6S/jrYM4W+OQj/nA26DkX/qXCMLZD2YnVstU6LZ3RzvKyLLxFErzMWJ3pl1R2uqJdslAj4W4a2tSugIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnB9EFdmbtYe9Sg8JmHt3ITcCCmSotMUivsy+86nXXw=;
 b=bXGH+uctrG7Rgs5o2W5Z4qPacqhoB/ATGA29RZrkpWd2oDqCc/tIZuheRSZOoFNyEso3Y/HahlD1KF/dC6fDhhIsnwENKXWkaAlsnYflezn22PsUipqlSPgkPYnINASdd4QvgF8FGNX5UmqNE6dZXb2RiA1DPzHDe1MFcYmTLJg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 08:28:20 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 08:28:20 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
 support
Thread-Topic: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
 support
Thread-Index: AQHazQ0p5B1dzU1iSEWQONEJm4d/HrHkqndw
Date: Wed, 3 Jul 2024 08:28:20 +0000
Message-ID: <PH7PR12MB8796042B81B22FEBF0E9634EB0DD2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240703055200.1610956-1-kevinyang.wang@amd.com>
 <20240703055200.1610956-3-kevinyang.wang@amd.com>
In-Reply-To: <20240703055200.1610956-3-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=418ea63f-08fd-49bc-a4df-6152ebcea2a8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-03T08:23:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB6352:EE_
x-ms-office365-filtering-correlation-id: 2fb78e3f-6942-41d0-5c62-08dc9b3a1898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wtPyI9SC0HHDII4UBH+6S+Ab1eAxcxknapOHH4WGrfIJqB9AIdygKBsy/RBr?=
 =?us-ascii?Q?51Z+4XunfOEtPxUor9Y7A+0bO5Pji3uhTb/mFE82Xq75dm5CIHgeUoMyc7hy?=
 =?us-ascii?Q?I3sQ6ZWpI228fYF8KJq/TfihdGAv5SwY2CLR7TbEptwYybTYG0xkltio5E/L?=
 =?us-ascii?Q?NJFXmEo9zlEIH6apMJrKkQ26U1Uqr5hxJZE6iO4uypo4lY9CtoQKojGVfXje?=
 =?us-ascii?Q?P+85GyYAKE+hhQ5Rc+c1XPPolBf7RX0YkYNd6NdQdNWZf7Az/YSKYQxzloK0?=
 =?us-ascii?Q?eTAQRlMgUt9MiZvqgXIIU/2VjfLyiRZ3aEQEm3Q9sLzAthgCB8jiB5UwkXu6?=
 =?us-ascii?Q?roxpZzIzz2VRI6w4nnuF3TylY5rDtj8uitc359CRnelPHYnN656rzXRk+ZJB?=
 =?us-ascii?Q?GOlNMvy6Px+D5lwSGSOCj1DqNKBUtBfSNTbi/ReCp6Ptf4+veDPRRw9At+rv?=
 =?us-ascii?Q?tdMtana8Y3pOJQSzJa4fDMarq664QObZNIzKi6oMUE0b0i3NOqGA/MtkQ4RA?=
 =?us-ascii?Q?Y35ml+LX56hQyPrBlfSTQ/ttqvKsiGMAFgQ0pXuAxHmXPEJRUigpfFlU2x3F?=
 =?us-ascii?Q?wH538F1P9dJxqtnZI4OI3CX7u7mI9FPKx3Nhd6XfZGRh/r+1CC4xAJy24Xyb?=
 =?us-ascii?Q?EmBNPJyaNpu5ONpx3NMdf3orNld0QXbk9L5BMOZaBmgwx2NnVF5GsrsrVYFN?=
 =?us-ascii?Q?lwwo6gw+6WcwgX4kiFasvlUPe9JEKQaPXO3kJkRHGwYLrlRjEC3Lk7Bp51bu?=
 =?us-ascii?Q?FLbTDRI/2SXCh5awVY6vr2QIWo40ZhfiQFf75IspfQcoxyB+2xN+JwEOzZFm?=
 =?us-ascii?Q?DrdzjBI1n0RgFNH3LeHMq8WAd8/bB9eii7xROYp059Sm/l2jRrSjcP0z+VbV?=
 =?us-ascii?Q?kwJwUY0frhUz236KsGy+ag1+hQVM1tIo7JqZjgCxaoH6Hea3ID4v8JFE31wQ?=
 =?us-ascii?Q?mq3T0O35/F+kqwYa7MwEufw+lu4UQ2JnlhgNiXRYa98fWwIEaFRAx3epjP1I?=
 =?us-ascii?Q?41x4MWu7B3EezcK8Co23VhHS7GdyKB0hT8HGYht6b5orrYjl6Varow9k6eMz?=
 =?us-ascii?Q?Lc+/HKhm/faiD4V86AX8aue0jCZao0Xvp8Jfrj1nfhtzpHaAieRG3SQLFCeO?=
 =?us-ascii?Q?VuvKPsKrjYh0Z0kCT9wRTkOfVhmDGayxPBvyEJEpCmO86T5ZSIBhbJR4Blr2?=
 =?us-ascii?Q?ovXuWJuqMwbKtPfSae3/kbxWxOtZTPpp+qGpx6MlqtsOlZOFhfx8Kzk4y6dw?=
 =?us-ascii?Q?SSrlz+k0X3H5voZcRxhLeihoYw+O2TBi+UZwPhXd1hK+0alp2Lgd/VF8+ie4?=
 =?us-ascii?Q?SEnCED1GD0LpD+IsHbXp/j/xofWy4K7giO4BERidIO9Alj7Zsj4J9+VJQBpa?=
 =?us-ascii?Q?e57C/63BjakujtBxwIISEZHA5A0WPo3jUxgZmYmOmgdZCwm7Dg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b7Wc+KRnLFXiYfHNfJGibRRRMM85gnRA0oIL7PNmrqIaQ4pgn+02qqA+fgIs?=
 =?us-ascii?Q?OFHzZfsCj0KdD2tM7Y2nfwpz2U0CYJhECfa6sPg0LF/Z0colc4OXclJcXA9J?=
 =?us-ascii?Q?TmjZGKZVDKXMEWMzYgaT/OXyardaVkRr3OzBV7aoh5/KxSuzT4i/HwB8E8lm?=
 =?us-ascii?Q?/GgW9pw/wGhUvN0VBF6VKiIhWq00wjps7GXsBq01aB7BMpR+POkkdcqYIW1L?=
 =?us-ascii?Q?dkomvd6j0FZBFufvD0kFV1L6r/POLbeKX27KP7YoucAXdkj0aFYFjoaDEg/Q?=
 =?us-ascii?Q?8v6PGxc4XHTBf0x7thxFscdkhFGr50LsXy9gKYsWNIHZMOwZAa+L1c5XvPOO?=
 =?us-ascii?Q?iLJfqdAnDqoY1RtDyoX6u5zJVGryFjSLR629NtcbkDmcbdCEl4mRvbrhytXr?=
 =?us-ascii?Q?2yepf6148y4uqCZ2HeaFqn5nzLy2F/zJG42QRzfEt+uVVUAI6BqH0w7o+dwM?=
 =?us-ascii?Q?y3cFhDMJe9bkAJW1IMrDC522cmzVFjZagD8CvkUrdG1ixnmEnBHXWUP/7AFl?=
 =?us-ascii?Q?Ab2RfMjC3151+ASG5Y9710KxgUsnWmZMbjiXgF4tS2stlsX9A08wiIczCWfZ?=
 =?us-ascii?Q?Z96iXJcvIjxof4SUUgIe8pyCI6fChsYwEdE1w431h4aMBREvaKcjgSrZ9o0j?=
 =?us-ascii?Q?vz+6b/mTSb3Oa4Z8cU1dtJcMY4eCDTLvLdGsft9gJrZpeKB0fFdpUEIBVysO?=
 =?us-ascii?Q?x72IGKLOHGZSMg8FjyZpH74oU7ZJJVKOOADOZq8KhEO1jVRSmOZUuAMgoQe/?=
 =?us-ascii?Q?6OtQMkIQxCINHLoDp5cClD7QYqVr+lPy2zZiJiSNQbMXdyihtoA5N71zyP+p?=
 =?us-ascii?Q?PQjtrHnfKooQBGeI2vWhke/xHiCEXfT/g4S3hgF7yeHiJLYolXKGnwqi4kW9?=
 =?us-ascii?Q?pzqxRWxXjD+hIMi7DO5qkFfAmNb5vukZALjCsFYbbgALCgHW/FuUpyjFOlPA?=
 =?us-ascii?Q?jLNsW8xWtD9ApL2plcvFfVYey5b0IqO5hiIdA+1jvfJ4sSUgsP9UXEN3+yCA?=
 =?us-ascii?Q?8lJHT2Kj9lLOblH9YrpUrfXqchzjJvWaXbb9oB8c8VBnR6JHunEY2dOCa5zL?=
 =?us-ascii?Q?Xp7AvhlqOPzY8csKpx/PFV6/CZY9WZ+Ph4uXyxKYvjhePrMkngEeEFXrBk9Z?=
 =?us-ascii?Q?FO39IrILRWLnEhHr56oQKXhleTquUdvtJjXk6CdkhEyV4A6Q0VBnl22KLiq5?=
 =?us-ascii?Q?m2QlW5fRaaWEB1QmKij+14Bmbz4FG/h5EecS/Jg/81gtSaYJyWBpDWrsCNae?=
 =?us-ascii?Q?WKl0A2jpd468LHo9Jq49vxf8PbECPfA7wlr1xSt254yvrAzi7bkBv6eAU9lM?=
 =?us-ascii?Q?jV+aGL7CWyuefe90E0h2dNpxXhssgTQ1RtW8/bsxMhhnvqudaEfPiVoByXRo?=
 =?us-ascii?Q?Hb314R5Nj2LG8i/AK3HZuW7L41aBvH3MHXzPv0SfL1uxu6NoxwOd604p+P/M?=
 =?us-ascii?Q?9gbEvmheep0lPoFh2eSHDPP2zzlDOqtE6LUesXjcu882yaDUpZh1qBcME4qX?=
 =?us-ascii?Q?DpZM/jukxmAA8QT5NgUWCrKyWjd2dLKOga8BgIHM9MYEljSFzV/irCht4yfn?=
 =?us-ascii?Q?mj+qC+kW/v5WV3JDFqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb78e3f-6942-41d0-5c62-08dc9b3a1898
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 08:28:20.2362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VZxVZUZ+MESRa84PLpSjcLoRo6BmfP1Ly+oz520xTahBnoV/ZDQBgkH+zF4Z4pX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, July 3, 2024 1:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
> support
>
> add amdgpu ras POSION_CONSUMPTION event id support.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c         | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h         |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 15 ++++++++++++---
>  3 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8a98611d2353..11f8c37a97ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2076,10 +2076,17 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>       struct amdgpu_ras_block_object *block_obj =3D
>               amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     enum ras_event_type type =3D
> RAS_EVENT_TYPE_POISON_CONSUMPTION;
> +     u64 event_id;
> +     int ret;
>
>       if (!block_obj || !con)
>               return;
>
> +     ret =3D amdgpu_ras_mark_ras_event(adev, type);
> +     if (ret)

[Tao] add warning? Or you can add it in amdgpu_ras_mark_ras_event.

> +             return;
> +
>       /* both query_poison_status and handle_poison_consumption are
> optional,
>        * but at least one of them should be implemented if we need poison
>        * consumption handler
> @@ -2104,8 +2111,10 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>        * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
>        */
>       if (poison_stat && !con->is_rma) {
> -             dev_info(adev->dev, "GPU reset for %s RAS poison consumptio=
n
> is issued!\n",
> -                             block_obj->ras_comm.name);
> +             event_id =3D amdgpu_ras_acquire_event_id(adev, type);
> +             RAS_EVENT_LOG(adev, event_id,
> +                           "GPU reset for %s RAS poison consumption is
> issued!\n",
> +                           block_obj->ras_comm.name);
>               amdgpu_ras_reset_gpu(adev);
>       }
>
> @@ -2498,7 +2507,7 @@ static enum ras_event_type
> amdgpu_ras_get_recovery_event(struct amdgpu_device *a
>       if (amdgpu_ras_intr_triggered())
>               return RAS_EVENT_TYPE_ISR;
>       else
> -             return RAS_EVENT_TYPE_INVALID;
> +             return RAS_EVENT_TYPE_POISON_CONSUMPTION;
>  }
>
>  static void amdgpu_ras_do_recovery(struct work_struct *work) @@ -3975,6
> +3984,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev,
> enum ras_event_type
>       switch (type) {
>       case RAS_EVENT_TYPE_ISR:
>       case RAS_EVENT_TYPE_POISON_CREATION:
> +     case RAS_EVENT_TYPE_POISON_CONSUMPTION:
>               event_mgr =3D __get_ras_event_mgr(adev);
>               if (!event_mgr)
>                       return RAS_EVENT_INVALID_ID;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 1343cfbc913b..6086da67fa4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -433,6 +433,7 @@ enum ras_event_type {
>       RAS_EVENT_TYPE_INVALID =3D 0,
>       RAS_EVENT_TYPE_ISR,
>       RAS_EVENT_TYPE_POISON_CREATION,
> +     RAS_EVENT_TYPE_POISON_CONSUMPTION,
>       RAS_EVENT_TYPE_COUNT,
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 816800555f7f..8a10a0e42846 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -27,6 +27,7 @@
>  #include "soc15_int.h"
>  #include "kfd_device_queue_manager.h"
>  #include "kfd_smi_events.h"
> +#include "amdgpu_ras.h"
>
>  /*
>   * GFX9 SQ Interrupts
> @@ -144,9 +145,11 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>                               uint16_t pasid, uint16_t client_id)  {
>       enum amdgpu_ras_block block =3D 0;
> -     int old_poison;
>       uint32_t reset =3D 0;
>       struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
> +     enum ras_event_type type =3D
> RAS_EVENT_TYPE_POISON_CONSUMPTION;
> +     u64 event_id;
> +     int old_poison, ret;
>
>       if (!p)
>               return;
> @@ -191,10 +194,16 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>               return;
>       }
>
> +     ret =3D amdgpu_ras_mark_ras_event(dev->adev, type);

[Tao] I don't think it's necessary to mark it both in amdgpu_ras_interrupt_=
poison_consumption_handler and here.
Another question is, event_interrupt_poison_consumption_v9 is used by sever=
al ASICs, are you sure the event id code doesn't affect old ASICs?

> +     if (ret)
> +             return;
> +
>       kfd_signal_poison_consumed_event(dev, pasid);
>
> -     dev_warn(dev->adev->dev,
> -              "poison is consumed by client %d, kick off gpu reset flow\=
n",
> client_id);
> +     event_id =3D amdgpu_ras_acquire_event_id(dev->adev, type);
> +
> +     RAS_EVENT_LOG(dev->adev, event_id,
> +                   "poison is consumed by client %d, kick off gpu reset =
flow\n",
> +client_id);
>
>       amdgpu_amdkfd_ras_pasid_poison_consumption_handler(dev->adev,
>               block, pasid, NULL, NULL, reset);
> --
> 2.34.1

