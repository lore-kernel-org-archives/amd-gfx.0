Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F871C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 08:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B3710E917;
	Thu,  6 Mar 2025 08:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCROB4cA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AE010E917
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 08:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsWCSQDanXH7cFARoujNijVUb4343IL0SI2szoRP0zH9WLu5NT7ev2lO1ukjafxUULJau6SHZ5emekmDunSiC4L4Ui1tEGFFpTp+lJ6VreZp8JDO0obklAeAVc09Ukvq6Wq0GAHbCEdXQubUy7Hh/k1kWaD61sr64iPsP0IabProra3U++pWUB3G4HPoc663pC9hst6eqj6xHspw967iJi9+qaGdeTQ7p35RnR46vhJfC8/rIjcFhVZj8Z9P6yqAJY3H79SrW+9s49hbzc9bJanGhrdkQNeybdX0XeF7PXQmpvo8InnLPigFzHHcOfXjNnx1lT0WTNG1oW/PJi0UBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZpBYBOG55A+ISHm+9zVQy84CGnw0S9TZabjAtYwm9M=;
 b=b6iIScKX9L2jk5IGL7thMWIg5R/pp/TRE36rrHkezTUbxbyBPmwR9UFOLo36LlP/Um8JYcgljMsOCKDf2p3eyq7SUyjiNtBMxluzalqwpYH2bOH56vbVB0dg+SBM3DOxJZaCK2s8CbYSBLkYIR7qJO5shEQmV3U9dINpj/bg3jPi1OGnOxBcynpZJM7EqqktOOZIPeI76EZvFaSrUi02TlptVpw6plpkhLBvILSHUILuydUXgxpgT7XCbsc92NlBVw/chZ6t7OxsL9m/TmHlXvYszjyEmJCFDNxvXV04dEpnhU/X49Ukx11OvyyilQwnkDzZhUfzYa15W6w6T1ZAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZpBYBOG55A+ISHm+9zVQy84CGnw0S9TZabjAtYwm9M=;
 b=NCROB4cAPI1077IkDXaU1iMvw4JFex9FJjIAZ6XjMtJ2c6YWBmxzoh4pDbXH3LPCnGKFFhqW3WmZ/7H/5EkSzX/V3k6nsvMHJ+w9R6couOn/Ve5i7n7h/6sC1rXlFdZPxzafYsxd7Ok/pygox+A2uy9kgtwutykOfJKeHyT8Zv8=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 08:29:41 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 08:29:41 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Use unique CPER record id across devices
Thread-Topic: [PATCH v2] drm/amdgpu: Use unique CPER record id across devices
Thread-Index: AQHbjnD2T15QhR1LzUyRoJ0uGNTw5bNlxucg
Date: Thu, 6 Mar 2025 08:29:41 +0000
Message-ID: <PH7PR12MB8796C8A985C7C8BD255CB13FB0CA2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250306082233.307681-1-xiang.liu@amd.com>
In-Reply-To: <20250306082233.307681-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=45338ae6-7fed-4a6d-8179-2b3c6d0f38de;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-06T08:29:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH1PPFDAD84AB72:EE_
x-ms-office365-filtering-correlation-id: bc6e1aac-3f87-4db3-7c92-08dd5c890a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lQwLm1fPAFOpyR+6E3r4LyL/IaAb+ip7UKroVGsjeDSBb5L6zEXxRpe4dUKs?=
 =?us-ascii?Q?UmXBG5+xMbgSWb5chhhlJdozQVMgt9PBvrN040gyvioAWZJdNRgHSB3vbpkf?=
 =?us-ascii?Q?aUA1fw7blC+b28BZi0CHnzsDHt0OHAqupdfKbWx+qkCr0vTSgmagJ0y7NJA3?=
 =?us-ascii?Q?4Q3WeBoamB2wQM2dh2cua8Q/cL4Zmiamenr7AVTcLJtwIPmVHnKEMSGCQwbI?=
 =?us-ascii?Q?IzAc1wY1Ar1Katcs0f8QJcRl+W9BKF4eQyfEp+Vc4SzgK+rov4j9MVADUA4q?=
 =?us-ascii?Q?OGnk/N5+2ZnLv2JugKZSUcy+QqqefBDdhQB5kH8hyMUCjTFRLHsPuIJPSZnk?=
 =?us-ascii?Q?zMJZwKTa/9A3lTmbdY5ay5UpIB/NMP6jxAJLyX1oufvvSCCkKdbJf63VxWtS?=
 =?us-ascii?Q?hCxteMhU2vmR1oPb6HPkuXvqLhmQFsF5VrlUcYuAMxdx3vpqot3dsP/KhJVS?=
 =?us-ascii?Q?kiMUUqVWZjtfoDB+aQK0i5hDNo+1LlYjU6PDBlCrZIZiKX8JdqXDgGEgD5vf?=
 =?us-ascii?Q?V4pvkzAYSxtiE1NCJ02gft0p61ELMONc9EKt+I2JiIBibPYW0iU1e4dY8zg5?=
 =?us-ascii?Q?PNsLRIc+8Uw9+1Ckq7VtZP66MMJ8h+75KHCQZZD2InUqFR3TyMVwGZzrhpif?=
 =?us-ascii?Q?1GUSgCmoHHlVJJKiHs0rx6hmfs9e3CEDPeDOAWyq417KbnylyuyFIDpXJJoW?=
 =?us-ascii?Q?5ZadkE4TPOSiblRji5Ra8y7Om01egox3he8PI8Br+R3wcbNkN1TXnBAt+jrP?=
 =?us-ascii?Q?AC5Ao6szXliFzl12L5bE7QmH0ZBU8bvd1QS7eUgG3qhVkjrl89+LRzlzRFfF?=
 =?us-ascii?Q?6HxguRd+24zL2QGV7jtduMQhRlkYyP+WEczr964JyY4OUEZAoBzvyEGyb/eo?=
 =?us-ascii?Q?u+6mbs2RW/+g40L2QRSwKAjqukwpYFwWkRCMHfwLjqhvtv4yq6shkpNSELlF?=
 =?us-ascii?Q?SRlAXfrsBjHQRtkSgFWY7NrfAqylQ+EQZZZOZe+JsmbLChCt2duxCX57BQBg?=
 =?us-ascii?Q?/HZlMzX6pK37u0kxwvk32U4WDHX7oza2366Vs7dCuHJsjT5w+bqAtiPjMe3F?=
 =?us-ascii?Q?CAGpPbXyDaMAAKGTeZhCeZetSVu/L9T1UsbxoXBW50yS/MZwiz77qY3W3ss8?=
 =?us-ascii?Q?3ZhPeQU9BOcaoU2ALo04Kibo8HQxT+A5DQ2HdX+Yr4rUOjpBlYcm7gSABSr8?=
 =?us-ascii?Q?iHal2QRqvGabXt0JQaejqC+wqQSXCgKtMsATcDOt3F13SAOoyBR619uMCKGt?=
 =?us-ascii?Q?RyBgq2SiMEpi/4dP52LMG8BPRciuqqEfhg7T/8uoPYKBsVcl21ISn4unL5aG?=
 =?us-ascii?Q?RPh4Jo2Ypf2czNy6IaZ7v9GtU0dsHuv+Sthl6dOHfioIc+jXJTvGyGx8geoC?=
 =?us-ascii?Q?vJ8XEB5RF2iBtEnGQUgMNW4y3Z3KCzF+2fJKBtw8aScsYwElVJ3NE96KzNlb?=
 =?us-ascii?Q?CgJGwRh/hkLIWr2X8DTTUq9LBYvVGFZ/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l6wXJQbgcwbR12/+f7p0idom0oefxHnoZog3Ew2cIsk9R0pomY72PrhZEtfS?=
 =?us-ascii?Q?u4vPMFvFj+knvPMzvdZoDULHTM2AYs9iMhVCqqUazSZXigYHtHx2jGV9LX47?=
 =?us-ascii?Q?YrhhiZ5TFuGijWHOmgEWaqYzH8IPDCcxF8tmrbrKzTwEiW7Vnj9gDF/WLNfR?=
 =?us-ascii?Q?7JX5sJMZ6ZrNgMfmCjyv8m8Qn7SHUjjahUSl1tj8gBImX1blsI8wQxYEQ6Th?=
 =?us-ascii?Q?eRZb9zuYJxG0BBexxfbsaSXwa8wIM+4VRMeRb3Bi4sTYWee09sP6oXHNwsLh?=
 =?us-ascii?Q?OW5IT88W85oo37ai+lPm8x8he9kgxJgXmTasIZ4y8JZlqzETZjjUeWFWHMJZ?=
 =?us-ascii?Q?NbAi9uPGmFlLgRF4yJXfs4Dbn/lM4Kt7mQX+o5T13B7ycxrczHXdKVZ7GPmj?=
 =?us-ascii?Q?oXJHgdU+A468HIJ5n1fLWkiOCnR5ezApD2+DnfcWdqK/p6n0wuCr+jUamahb?=
 =?us-ascii?Q?C04mq3TI82ipLnOPJV2pl1IufpT5yA8mjsBWNWCn737Fqe8oZAWRfsfwS0fp?=
 =?us-ascii?Q?8swsliRLEZ4bqRHC7hzf1CuNt15RkFxM+IJmGEGiquldEQ/xZTjZ4Ra+Iv3m?=
 =?us-ascii?Q?O9MW5rndUJe/U58wVQ1f5ogq8h0ZsgUR1m6Bx2yYUq+XlXnYd8dRSWH1Incw?=
 =?us-ascii?Q?V2S/9g+OQ5TzW3Vlnx36PODEOiQagkbI9Y8+1BwDMmTow1tDeCj4uJepglSA?=
 =?us-ascii?Q?Jf6gYNiAp/h0PvGUHnW693MjzZjp8xgYxq3oyWYzLoSq+1evVfhiryIA3Iz9?=
 =?us-ascii?Q?54Rye1Q7wTHWnhv3VsDgKw4PSEV+GXXq0fx+kZPE1uXAsc2tsnA9AVz32yf8?=
 =?us-ascii?Q?pd+RxvJV0ZjFf++QHH/MNZf4RlD27c+dUICOVDHqH8Rm32kmrHxQTHK4JoSo?=
 =?us-ascii?Q?40mIIduaRmLex+ZwwtPQnLEd0TaId1mucPHZ+Iyllpy/JroFyQaXBMFOLasj?=
 =?us-ascii?Q?ttfrN4qwkcpmWztj0jDjWI/ydjsEajwQ16bUgvp0hP0k7qm8TSSh76vrThNu?=
 =?us-ascii?Q?DhrbXatT6wOP+H72WJ/ITfl7gQaT0mqUE2c9MawbvehW5L9Xxxtq5K9dmmDL?=
 =?us-ascii?Q?8H0fHxWx+snpUNrJs+DW7IOLug1AOQDmx0KkccAIaOots434e/EidsDHxC4D?=
 =?us-ascii?Q?cid5Z7m+C8AwJIDxsIJ4IM0Wlf6KfIIJfHrPsST0OqAdOmrTCbWOY3cC6kjT?=
 =?us-ascii?Q?tA9206d/KH+V8wjFs4AGnYygtRAhcLcQ9we3WgtDRRW0mgoMDZYlLeMOGU+o?=
 =?us-ascii?Q?NXvgfB6P48UrYOurw8kQvl2DwultUvjk6yz2VfhDCvzWml/f7rcPFskF+knp?=
 =?us-ascii?Q?A8jRiEwwp7LTqCeWYipmX8sB/yczQ6lTWw7RIU6f9bRGqK47jo33ia/+jpJu?=
 =?us-ascii?Q?rqZ3bdOgnYDQbzWdHxrnV3aKDaHUG9jtKDj+uVYV4Iyabk2LqjVQ9naCaR4l?=
 =?us-ascii?Q?RTh/Bl3PSa0XFMyBQWFupawG1uma4wmWdKDEGA8yL67pVy0HJsnD34rwTfYp?=
 =?us-ascii?Q?Od2002Y0/GBETERbXw1vj8J6vjSMd9ztwcmXaWKrUVpGFlTQ4F/KZ006JcOG?=
 =?us-ascii?Q?KUp740aeuWNkFw5/nDc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6e1aac-3f87-4db3-7c92-08dd5c890a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 08:29:41.2722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UacMKM4qY64CN7HkBaEHT9rMM4GsYp4+Dcpf4VIomoR/eSgDkr4fAkp/T/MxTRIa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDAD84AB72
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Thursday, March 6, 2025 4:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Use unique CPER record id across devices
>
> Encode socket id to CPER record id to be unique across devices.
>
> v2: add pointer check for adev->smuio.funcs->get_socket_id
> v2: set 0 if adev->smuio.funcs->get_socket_id is NULL
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index d77da7ca9a87..bc8473306063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -57,6 +57,8 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *a=
dev,
>                               enum amdgpu_cper_type type,
>                               enum cper_error_severity sev)
>  {
> +     char record_id[16];
> +
>       hdr->signature[0]               =3D 'C';
>       hdr->signature[1]               =3D 'P';
>       hdr->signature[2]               =3D 'E';
> @@ -71,7 +73,13 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device
> *adev,
>
>       amdgpu_cper_get_timestamp(&hdr->timestamp);
>
> -     snprintf(hdr->record_id, 8, "%d", atomic_inc_return(&adev->cper.uni=
que_id));
> +     snprintf(record_id, 9, "%d:%X",
> +              (adev->smuio.funcs && adev->smuio.funcs->get_socket_id) ?
> +                      adev->smuio.funcs->get_socket_id(adev) :
> +                      0,
> +              atomic_inc_return(&adev->cper.unique_id));
> +     memcpy(hdr->record_id, record_id, 8);
> +
>       snprintf(hdr->platform_id, 16, "0x%04X:0x%04X",
>                adev->pdev->vendor, adev->pdev->device);
>       /* pmfw version should be part of creator_id according to CPER spec=
 */ @@ -
> 117,10 +125,10 @@ static int amdgpu_cper_entry_fill_section_desc(struct
> amdgpu_device *adev,
>       section_desc->severity                  =3D sev;
>       section_desc->sec_type                  =3D sec_type;
>
> -     if (adev->smuio.funcs &&
> -         adev->smuio.funcs->get_socket_id)
> -             snprintf(section_desc->fru_text, 20, "OAM%d",
> -                      adev->smuio.funcs->get_socket_id(adev));
> +     snprintf(section_desc->fru_text, 20, "OAM%d",
> +              (adev->smuio.funcs && adev->smuio.funcs->get_socket_id) ?
> +                      adev->smuio.funcs->get_socket_id(adev) :
> +                      0);
>
>       if (bp_threshold)
>               section_desc->flag_bits.exceed_err_threshold =3D 1;
> --
> 2.34.1

