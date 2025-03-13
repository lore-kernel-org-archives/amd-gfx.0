Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32412C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 06:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E9610E1F0;
	Thu, 13 Mar 2025 06:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MEY6AOqx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987E010E1F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 06:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOnpBBwV/fM6733nDHU+6tPixr3AW+j3Sxm0+X2v3Ti+C6cNo+h9v6K0XtxG5+li0ic8ccMWv8D6kMcN8hEvWe6hd4yjEuGBX9jCJNHDlzleDQ5VbwX7jFlJ5XBNmN0hB+K23iz5TE1sKAj8A6o1Y71S8gmhlxymJf5MRoMorrs/YIw+dUrCx7iQ55Dg83Q7DbRNThyfWTJRV2LHvwIosp0Q9EGJZ+n6wo7UsJ5OYZ2SM8Ho6n3950C6L3OZDyEN1o/zC2d0+vB3U89JcNWmLqZwfvQs4Vup72XyH/0Ij/CRfijY3PeZhRsBLqf0L1zKPZjLW4mOcdCq+GsDQu5peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agAg/dlwi7sjCms4ZNO3UcylHdhz+f+a8W17hW7KRes=;
 b=XHhTKEh+O7NJaS0OQBWXVbbp/kUCrdM3E6+bZN/XDNrDcE2i6j+FdWDQFrdLRfrJao0R498eVnX95SkQTXg3wyqSlksFMS1q44yZ/zVHwuYhnBdyWWz9IZBbwDoTjCNiYvSUl3Y3JQdrlJHTpDAaf3HLet//7jiMubIx+tRG9ml5teIinQB/Ayk52d6+MJdauHfud17cH2+YEh8BtZpr1OrPdxAXnOkFQdDc782YCVOVugcfYReSnPHY5CBW6vadxRWa834NKhM/SuXhW/+xVL9zyHSrqs+8Dlx67S2888guamwu8du63AbwPI7cr+Rsoe1DOLNFpsI76E6ldwSPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agAg/dlwi7sjCms4ZNO3UcylHdhz+f+a8W17hW7KRes=;
 b=MEY6AOqxrEaW4pKtQU8fZnZBINiU04UM3vB+nC+TEuWDh9d8wdhpMjk7oXSh9jQrrHzD76SXhr3SmiEoU6SgyeKna7Nj1pLyQ6AKIsF/80/1vwoyfv0rdRhvSp54XWm4DT+YZfzBtK4PGrekblcbGBQYNHv+QPDOr30Wttx8hsk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 06:51:59 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 06:51:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
Thread-Topic: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
Thread-Index: AQHbk8nHpIdrU5wZekeXoY/5fqNYgbNwnznA
Date: Thu, 13 Mar 2025 06:51:59 +0000
Message-ID: <PH7PR12MB879608D53A16C101CB81EFADB0D32@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <mailman.1086.1741774146.1020.amd-gfx@lists.freedesktop.org>
 <MW5PR12MB568415D133F1AD9683B4FABBE5D32@MW5PR12MB5684.namprd12.prod.outlook.com>
In-Reply-To: <MW5PR12MB568415D133F1AD9683B4FABBE5D32@MW5PR12MB5684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=48f76271-f2c0-4938-8fd1-0dc6c22c5998;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T03:33:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB8697:EE_
x-ms-office365-filtering-correlation-id: 165e296a-ef68-4327-e99d-08dd61fb8d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|4022899009|1800799024|38070700018|7053199007|13003099007;
x-microsoft-antispam-message-info: =?us-ascii?Q?fwuzx8Z5nwXXX8r77LcWUVk8pWDueXmFXpV0uNWLRMZwaDMCnQwr1443TUPT?=
 =?us-ascii?Q?Unv9GYt17OzJ//BtAKruJu/kZS+AibeB9Cj3cv/QwfzSCeZWtIRue56IsigK?=
 =?us-ascii?Q?iSxEyZRn11UPXjlvbKWri1YRbtJsSetH8RuHwjfkF11xGBSxgjakHMYv68DK?=
 =?us-ascii?Q?7Bn4w8OEC/43rT40IM2sOciHHa0ckv/p1VYoApHBbGrvFpRGfuOFf3EWrGu0?=
 =?us-ascii?Q?Vcy6cINP/GlI+lqPK0Gkqv9rswIsJ8HpA75FYRc8gQljDKcj0uZhZmu1JA0v?=
 =?us-ascii?Q?UBsQL3qb5/yTirvh4/iVXLDw9GkiJw/zHTe5YwnERVSvKkj8b/yVVJSM75Pd?=
 =?us-ascii?Q?gY8Fs+7JHYn2hpmutR4x0aX9rWVMAusmQKv6JC405LL6tEyhaHV3zvlmaO7p?=
 =?us-ascii?Q?dQI0WgCGmYU7ZfatO8ariJHeYZ09o/YIRYzP3gz+Sz7GHRBFJ2il//1tOWSK?=
 =?us-ascii?Q?6sIoZ57+BfxlZf7Ur6QNLhiAfweFzDXJwDYyKH8a61oWE0soZkuI9cECiirj?=
 =?us-ascii?Q?ULjYNs4YX/LoYZ8FASnoFr5qui4hUHAfIb8Q21g0UA+GTYG0jMfhEYbRYyF1?=
 =?us-ascii?Q?21kR/vmJ4lClvtx/DkmAUjNLHMaNHLObPKLexcARWAHbxJwUmW1V05Cebv0T?=
 =?us-ascii?Q?hDZxoFPMu1ntH5ygDUxSpBO+Qfi42W2Y6WukPwvSSNd+/1mFe51jayYfHXGI?=
 =?us-ascii?Q?u+ZhERZaHl67wXgatfSw0zP9Dg1w9GjUdav7fY4TQMVbUsGbQYNVuL9tb5DK?=
 =?us-ascii?Q?ZviIgEsyfNg+CxPTE+5SBA2UyIrZxtuxH5GA4kGH9MgqY1ayAFdJcLo3uy1d?=
 =?us-ascii?Q?t9XibgDosR+W/qyUH9KiZqdbuuie2bAsEv2KGsr5FBUeHttGwwF89o9DpE49?=
 =?us-ascii?Q?D92kmJv/hxESjnVgvsXWXEei0da4fqnnGIVX27C6ifI9rMJ6d+9gSLf/4J9K?=
 =?us-ascii?Q?+Du7AS4JnSd/NUDV/UsFUdJ7XYTo08mhHDMoo1hDawl8wKlpukN6LgQPaCsw?=
 =?us-ascii?Q?G2WzEWwrqIKGPEBSlvOo5h0Vt+eB1mrYtp0hYpSGd2mHKgYRALFTfO/TeGdO?=
 =?us-ascii?Q?YGsj8VyQ4p3ZgI4dUqfaZRW4JigHGdcjzZe5DL6zPpcCc8bylI1R8/X3n37L?=
 =?us-ascii?Q?Rh6fOrvOLcOr0CTljHnlYhTDzvh0Z2UdBhChdbGZqRJb8K2RreJi3fMKaoZ1?=
 =?us-ascii?Q?hVsfbSaO75s7we5ciR5s3Ila1NP2lPCy1Orq/2zJrE8U/TSEJ88mV21lKKS0?=
 =?us-ascii?Q?DwOdNQaa2tt43HUdffUvC727JXvrxQxWXon6d95POeZtNNnbcjxhzYUt75vn?=
 =?us-ascii?Q?jS+B7Ff9o7NTEwkPetu9wuJnOIaaxMCeAu3eWNVvIrz2WnWmEq7tyywWqSdu?=
 =?us-ascii?Q?XwIGgRLy782+zupsBXREC9ICrHzB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(4022899009)(1800799024)(38070700018)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r9pU7JMAqEmxW6o0pMpKyD5swuL/r+i8zkJnGiewVm77KeyY8ts1hM/Wf81T?=
 =?us-ascii?Q?6841H4WeUsilc0gLYQ537KU9N47F/ERGXcBFnoz1cS5eElNBpCkwR1x1ALMZ?=
 =?us-ascii?Q?taK6TJDZRVyt4eZ1/sdL8StKAbGzbvSQQ4iyb0bFUyHThBGTLwyrSWjadBwT?=
 =?us-ascii?Q?IR76OVDlDrPrL0toTv0sVhzQH0M6vDqcDnxU5J8xvInTwhWYFzxtktTbxggQ?=
 =?us-ascii?Q?KTAp9agUk9ikKcHWnEzoDTh/+cgHGd+WVwB//i31LbM9s5kwKCMl7YUDt2c+?=
 =?us-ascii?Q?UcKZUSbra4wleTYoH4nc5WrUEs+PtZtQsm5D924XIYHrRQA2ycxkIfzN+C0N?=
 =?us-ascii?Q?4nRitA1TrwTzRbqnQFmqH7EIcs5kHSbQMXdGVV+5mZJGaRt1iSNG1LOqTXzD?=
 =?us-ascii?Q?I23e8kcJkEs1G0BL/e39CKdrMfRA79oi3I1eCDOHyKvqsouRM9xWwFzB61Yh?=
 =?us-ascii?Q?ToOAzrdnjFS3Z62+L4mLHUcHUxP5oNQJHtYo3B1RzcZiGJ1E0P/iOAtrlcsg?=
 =?us-ascii?Q?XJru+Z6nUAUhoNfyBRdZigoO1lHELklT+AUVekoUie0c+mzssJcghCfp2ihu?=
 =?us-ascii?Q?peseS4ZM0T2UQVAPj4fLepzXif4JnqLoGjfyCZSpBj36U+/fjArH0J3snElk?=
 =?us-ascii?Q?qmE4nmSxnC8507ISOSDUsbg5QuEDkpWqIZoV6SGZf4J4ZqRqqN7VgC3P1/Zv?=
 =?us-ascii?Q?82NnkOayPogzjCKDXSm4ZiKuG5gDq/PUwrd/tOXKaEJ6LTy/fhTaFMnrnS0q?=
 =?us-ascii?Q?6zqj8gTRX6hnPTuBpfCpzdCxiV3N37B4dh8jbkB6Ecxt5tGd7As/EpHVVHoF?=
 =?us-ascii?Q?Qg2ot7ubtMO6Yu5tZ5QwrvhGTBDa0ECZL8o1yclU7k7GUJg9EFKA2sevt0Yw?=
 =?us-ascii?Q?LX5YVLIMnviAIZzN8k/Lk8KXv1HxZ+od6WK7fdvWoyX88dg7WsTBgi0TnjXC?=
 =?us-ascii?Q?KYYMwarS5qV7+lrbTxR3fzmPVuxydW6WGC3wqX1+nS4qZCPfUjhA4qlFKzVJ?=
 =?us-ascii?Q?Rt4cK/Rb4CLcliTfuiiBePS3KN+aMJNXgM4TwDRtnZQVMaQzNOMHsp0U0isA?=
 =?us-ascii?Q?ETwZqs3sH3wxD/mHhwDWFWT6TXzqA7sh/BnW7QUwflKy1VRDHuVZDrBPHG5u?=
 =?us-ascii?Q?/fiQJS7EFYFElVkPJPpITLEFUnxj3XaNY7HWjMWW+/Z0065W5ZX7CtJ0yJ20?=
 =?us-ascii?Q?FHGavtQGGMzrKfmok8xhJ26ShicJznCOYRy9uwBA1i7rwtAvsSySK+Zk2XlK?=
 =?us-ascii?Q?gsDGQi+cmeZhEbAcNJW+ctkFFyU5fvwvGuE4Y0/HSKrVHUJMLYhhdA6QtXOy?=
 =?us-ascii?Q?MHq9bRKgndUDeYg4ZRoY1Aoi2daYzjMDIf3d1fPQ0I9Q6fPo07tg783jddXm?=
 =?us-ascii?Q?c9l0dGhawk0fXmR/r4hTnfWV5Ejzzn527M0tJECpw0NEQa+HFAcTNGyFMFc+?=
 =?us-ascii?Q?RbRpueLJUdfVg7Cl96qd+jp1mk1XImS6mi8wGFb0EI6jcd+mp6YlWx/UeMyw?=
 =?us-ascii?Q?/kqveV4B0LhhUa9n42QI4OCdouTPVcYj8UyZGecen0yU4LD2RuD1XZxqvkdz?=
 =?us-ascii?Q?Rb29loH1AwwBh+QZx8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165e296a-ef68-4327-e99d-08dd61fb8d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 06:51:59.0750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAtzftJHHsU5Mv/rkvkjKrveirmvxiKS/OTnvp21iVW+dSdLDSUxMAMUjSFfmWgK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697
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

Hi Patrick,

I know your concern, but I think the sudden power off is not an usual case =
in server platform.

Regards,
Tao

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xie, P=
atrick
> Sent: Thursday, March 13, 2025 11:41 AM
> To: amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi, Tao:
>         I am worried about host reboot or power down during the eeprom fo=
rmating,
> which will make the bad page info lost.
>         If the issue needs to be considered, I suggest save bad page info=
 on host disk
> before eeprom formatting, and make a mark on eeprom
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of amd-gf=
x-
> request@lists.freedesktop.org
> Sent: Wednesday, March 12, 2025 6:09 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: amd-gfx Digest, Vol 106, Issue 157
>
> Send amd-gfx mailing list submissions to
>         amd-gfx@lists.freedesktop.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> or, via email, send a message with subject or body 'help' to
>         amd-gfx-request@lists.freedesktop.org
>
> You can reach the person managing the list at
>         amd-gfx-owner@lists.freedesktop.org
>
> When replying, please edit your Subject line so it is more specific than =
"Re: Contents
> of amd-gfx digest..."
>
>
> Today's Topics:
>
>    1. [PATCH] drm/amdgpu: format old RAS eeprom data into V3
>       version (Tao Zhou)
>    2. Re: [PATCH 2/2] drm/amdgpu: Make use of drm_wedge_app_info
>       (Raag Jadav)
>    3. [PATCH] drm/amdgpu/pm: Handle SCLK offset correctly in
>       overdrive for smu 14.0.2 (Tomasz Paku?a)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 12 Mar 2025 18:05:48 +0800
> From: Tao Zhou <tao.zhou1@amd.com>
> To: <amd-gfx@lists.freedesktop.org>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
>         version
> Message-ID: <20250312100548.283389-1-tao.zhou1@amd.com>
> Content-Type: text/plain
>
> Clear old data and save it in V3 format.
>
> v2: only format eeprom data for new ASICs.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++++---------
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  1 +
>  3 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 837f33698b38..d3b9b4d9fb89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3465,6 +3465,13 @@ int amdgpu_ras_init_badpage_info(struct
> amdgpu_device *adev)
>                                 adev, control->bad_channel_bitmap);
>                         con->update_channel_flag =3D false;
>                 }
> +
> +               /* The format action is only applied to new ASICs */
> +               if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) =
>=3D 12
> &&
> +                   control->tbl_hdr.version < RAS_TABLE_VER_V3)
> +                       if (!amdgpu_ras_eeprom_reset_table(control))
> +                               if (amdgpu_ras_save_bad_pages(adev, NULL)=
)
> +                                       dev_warn(adev->dev, "Failed to
> +format RAS EEPROM data in V3 version!\n");
>         }
>
>         return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 09a6f8bc1a5a..71dddb8983ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -413,9 +413,11 @@ static void amdgpu_ras_set_eeprom_table_version(stru=
ct
> amdgpu_ras_eeprom_control
>
>         switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
>         case IP_VERSION(8, 10, 0):
> -       case IP_VERSION(12, 0, 0):
>                 hdr->version =3D RAS_TABLE_VER_V2_1;
>                 return;
> +       case IP_VERSION(12, 0, 0):
> +               hdr->version =3D RAS_TABLE_VER_V3;
> +               return;
>         default:
>                 hdr->version =3D RAS_TABLE_VER_V1;
>                 return;
> @@ -443,7 +445,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>         hdr->header =3D RAS_TABLE_HDR_VAL;
>         amdgpu_ras_set_eeprom_table_version(control);
>
> -       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +       if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
>                 hdr->first_rec_offset =3D RAS_RECORD_START_V2_1;
>                 hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE +
>                                 RAS_TABLE_V2_1_INFO_SIZE; @@ -461,7 +463,=
7 @@ int
> amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
>         }
>
>         csum =3D __calc_hdr_byte_sum(control);
> -       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1)
> +       if (hdr->version >=3D RAS_TABLE_VER_V2_1)
>                 csum +=3D __calc_ras_info_byte_sum(control);
>         csum =3D -csum;
>         hdr->checksum =3D csum;
> @@ -752,7 +754,7 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>                         "Saved bad pages %d reaches threshold value %d\n"=
,
>                         control->ras_num_bad_pages, ras->bad_page_cnt_thr=
eshold);
>                 control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
> -               if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1) {
> +               if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
>                         control->tbl_rai.rma_status =3D
> GPU_RETIRED__ECC_REACH_THRESHOLD;
>                         control->tbl_rai.health_percent =3D 0;
>                 }
> @@ -765,7 +767,7 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>                 amdgpu_dpm_send_rma_reason(adev);
>         }
>
> -       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> +       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
>                 control->tbl_hdr.tbl_size =3D RAS_TABLE_HEADER_SIZE +
>                                             RAS_TABLE_V2_1_INFO_SIZE +
>                                             control->ras_num_recs * RAS_T=
ABLE_RECORD_SIZE;
> @@ -805,7 +807,7 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>          * now calculate gpu health percent
>          */
>         if (amdgpu_bad_page_threshold !=3D 0 &&
> -           control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
> +           control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1 &&
>             control->ras_num_bad_pages <=3D ras->bad_page_cnt_threshold)
>                 control->tbl_rai.health_percent =3D ((ras->bad_page_cnt_t=
hreshold -
>                                                    control->ras_num_bad_p=
ages) * 100) / @@ -818,7
> +820,7 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>                 csum +=3D *pp;
>
>         csum +=3D __calc_hdr_byte_sum(control);
> -       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> +       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
>                 csum +=3D __calc_ras_info_byte_sum(control);
>         /* avoid sign extension when assigning to "checksum" */
>         csum =3D -csum;
> @@ -1035,7 +1037,7 @@ uint32_t amdgpu_ras_eeprom_max_record_count(struct
> amdgpu_ras_eeprom_control *co
>         /* get available eeprom table version first before eeprom table i=
nit */
>         amdgpu_ras_set_eeprom_table_version(control);
>
> -       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> +       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
>                 return RAS_MAX_RECORD_COUNT_V2_1;
>         else
>                 return RAS_MAX_RECORD_COUNT; @@ -1280,7 +1282,7 @@ static
> int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
>         int buf_size, res;
>         u8  csum, *buf, *pp;
>
> -       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> +       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
>                 buf_size =3D RAS_TABLE_HEADER_SIZE +
>                            RAS_TABLE_V2_1_INFO_SIZE +
>                            control->ras_num_recs * RAS_TABLE_RECORD_SIZE;=
 @@ -
> 1383,7 +1385,7 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control)
>
>         __decode_table_header_from_buf(hdr, buf);
>
> -       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +       if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
>                 control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
>                 control->ras_record_offset =3D RAS_RECORD_START_V2_1;
>                 control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT_V2=
_1;
> @@ -1423,7 +1425,7 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>                 DRM_DEBUG_DRIVER("Found existing EEPROM table with %d
> records",
>                                  control->ras_num_bad_pages);
>
> -               if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
>                         res =3D __read_table_ras_info(control);
>                         if (res)
>                                 return res; @@ -1443,7 +1445,7 @@ int
> amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
>                                         ras->bad_page_cnt_threshold);
>         } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
>                    amdgpu_bad_page_threshold !=3D 0) {
> -               if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
>                         res =3D __read_table_ras_info(control);
>                         if (res)
>                                 return res; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 13f7eda9a696..ec6d7ea37ad0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -28,6 +28,7 @@
>
>  #define RAS_TABLE_VER_V1           0x00010000
>  #define RAS_TABLE_VER_V2_1         0x00021000
> +#define RAS_TABLE_VER_V3           0x00030000
>
>  struct amdgpu_device;
>
> --
> 2.34.1
>
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 11 Mar 2025 19:13:15 +0200
> From: Raag Jadav <raag.jadav@intel.com>
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: Andr? Almeida <andrealmeid@igalia.com>,
>         dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
>         kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
>         intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, =
Alex
>         Deucher <alexander.deucher@amd.com>, Christian K?nig
>         <christian.koenig@amd.com>, siqueira@igalia.com, airlied@gmail.co=
m,
>         simona@ffwll.ch, rodrigo.vivi@intel.com, jani.nikula@linux.intel.=
com,
>         Xaver Hugl <xaver.hugl@kde.org>
> Subject: Re: [PATCH 2/2] drm/amdgpu: Make use of drm_wedge_app_info
> Message-ID: <Z9BvK55_Nim54eOu@black.fi.intel.com>
> Content-Type: text/plain; charset=3Dutf-8
>
> On Mon, Mar 10, 2025 at 06:03:27PM -0400, Alex Deucher wrote:
> > On Mon, Mar 10, 2025 at 5:54?PM Andr? Almeida <andrealmeid@igalia.com>
> wrote:
> > >
> > > Em 01/03/2025 03:04, Raag Jadav escreveu:
> > > > On Fri, Feb 28, 2025 at 06:49:43PM -0300, Andr? Almeida wrote:
> > > >> Hi Raag,
> > > >>
> > > >> On 2/28/25 11:58, Raag Jadav wrote:
> > > >>> On Fri, Feb 28, 2025 at 09:13:53AM -0300, Andr? Almeida wrote:
> > > >>>> To notify userspace about which app (if any) made the device
> > > >>>> get in a wedge state, make use of drm_wedge_app_info parameter,
> > > >>>> filling it with the app PID and name.
> > > >>>>
> > > >>>> Signed-off-by: Andr? Almeida <andrealmeid@igalia.com>
> > > >>>> ---
> > > >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19
> +++++++++++++++++--
> > > >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
> > > >>>>    2 files changed, 22 insertions(+), 3 deletions(-)
> > > >>>>
> > > >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > >>>> index 00b9b87dafd8..e06adf6f34fd 100644
> > > >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > >>>> @@ -6123,8 +6123,23 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
> > > >>>>            atomic_set(&adev->reset_domain->reset_res, r);
> > > >>>> -  if (!r)
> > > >>>> -          drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, NULL);
> > > >>>> +  if (!r) {
> > > >>>> +          struct drm_wedge_app_info aux, *info =3D NULL;
> > > >>>> +
> > > >>>> +          if (job) {
> > > >>>> +                  struct amdgpu_task_info *ti;
> > > >>>> +
> > > >>>> +                  ti =3D amdgpu_vm_get_task_info_pasid(adev, jo=
b->pasid);
> > > >>>> +                  if (ti) {
> > > >>>> +                          aux.pid =3D ti->pid;
> > > >>>> +                          aux.comm =3D ti->process_name;
> > > >>>> +                          info =3D &aux;
> > > >>>> +                          amdgpu_vm_put_task_info(ti);
> > > >>>> +                  }
> > > >>>> +          }
> > > >>> Is this guaranteed to be guilty app and not some scheduled worker=
?
> > > >>
> > > >> This is how amdgpu decides which app is the guilty one earlier in
> > > >> the code as in the print:
> > > >>
> > > >>      ti =3D amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
> > > >>
> > > >>      "Process information: process %s pid %d thread %s pid %d\n"
> > > >>
> > > >> So I think it's consistent with what the driver thinks it's the
> > > >> guilty process.
> > > >
> > > > Sure, but with something like app_info we're kind of hinting to
> > > > userspace that an application was _indeed_ involved with reset. Is =
that also
> guaranteed?
> > > >
> > > > Is it possible that an application needlessly suffers from a false
> > > > positive scenario (reset due to other factors)?
> > > >
> > >
> > > I asked Alex Deucher in IRC about that and yes, there's a chance
> > > that this is a false positive. However, for the majority of cases
> > > this is the right app that caused the hang. This is what amdgpu is
> > > doing for GL robustness as well and devcoredump, so it's very
> > > consistent with how amdgpu deals with this scenario even if the mecha=
nism is
> still not perfect.
> >
> > It's usually the guilty one, but it's not guaranteed.  For example,
> > say you have a ROCm user queue and a gfx job submitted to a kernel
> > queue.  The actual guilty job may be the ROCm user queue, but the
> > driver may not detect that the ROCm queue was hung until some other
> > event (e.g., memory pressure).  However, the timer for the gfx job may
> > timeout before that happens on the ROCm queue so in that case the gfx
> > job would be incorrectly considered guilty.
>
> So it boils down to what are the chances of that happening and whether it=
's
> significant enough to open the door for API abuse.
>
> Considering this is amd specific accuracy, it's still an open question ho=
w other
> drivers are/will be managing it.
>
> Raag
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 11 Mar 2025 22:38:33 +0100
> From: Tomasz Paku?a <tomasz.pakula.oficjalny@gmail.com>
> To: amd-gfx@lists.freedesktop.org
> Cc: alexander.deucher@amd.com
> Subject: [PATCH] drm/amdgpu/pm: Handle SCLK offset correctly in
>         overdrive for smu 14.0.2
> Message-ID:
>         <20250311213833.870840-1-tomasz.pakula.oficjalny@gmail.com>
> Content-Type: text/plain; charset=3DUTF-8
>
> Currently, it seems like the code was carried over from RDNA3 because it =
assumes
> two possible values to set. RDNA4, instead of having:
> 0: min SCLK
> 1: max SCLK
> only has
> 0: SCLK offset
>
> This change makes it so it only reports current offset value instead of s=
howing
> possible min/max values and their indices. Moreover, it now only accepts =
the offset
> as a value, without the indice index.
>
> Additionally, the lower bound was printed as %u by mistake.
>
> Old:
> OD_SCLK_OFFSET:
> 0: -500Mhz
> 1: 1000Mhz
> OD_MCLK:
> 0: 97Mhz
> 1: 1259MHz
> OD_VDDGFX_OFFSET:
> 0mV
> OD_RANGE:
> SCLK_OFFSET:    -500Mhz       1000Mhz
> MCLK:      97Mhz       1500Mhz
> VDDGFX_OFFSET:    -200mv          0mv
>
> New:
> OD_SCLK_OFFSET:
> 0Mhz
> OD_MCLK:
> 0: 97Mhz
> 1: 1259MHz
> OD_VDDGFX_OFFSET:
> 0mV
> OD_RANGE:
> SCLK_OFFSET:    -500Mhz       1000Mhz
> MCLK:      97Mhz       1500Mhz
> VDDGFX_OFFSET:    -200mv          0mv
>
> Setting this offset:
> Old: "s 1 <offset>"
> New: "s <offset>"
>
> Signed-off-by: Tomasz Paku?a <tomasz.pakula.oficjalny@gmail.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 59 ++++++-------------
>  1 file changed, 18 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 5cad09c5f2ff..62bd9647541a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1193,16 +1193,9 @@ static int smu_v14_0_2_print_clk_levels(struct
> smu_context *smu,
>                                                          PP_OD_FEATURE_GF=
XCLK_BIT))
>                         break;
>
> -               PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> -               const OverDriveLimits_t * const overdrive_upperlimits =3D
> -                                       &pptable->SkuTable.OverDriveLimit=
sBasicMax;
> -               const OverDriveLimits_t * const overdrive_lowerlimits =3D
> -                                       &pptable->SkuTable.OverDriveLimit=
sBasicMin;
> -
>                 size +=3D sysfs_emit_at(buf, size, "OD_SCLK_OFFSET:\n");
> -               size +=3D sysfs_emit_at(buf, size, "0: %dMhz\n1: %uMhz\n"=
,
> -                                       overdrive_lowerlimits->GfxclkFoff=
set,
> -                                       overdrive_upperlimits->GfxclkFoff=
set);
> +               size +=3D sysfs_emit_at(buf, size, "%dMhz\n",
> +
> + od_table->OverDriveTable.GfxclkFoffset);
>                 break;
>
>         case SMU_OD_MCLK:
> @@ -1336,13 +1329,9 @@ static int smu_v14_0_2_print_clk_levels(struct
> smu_context *smu,
>                 size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>
>                 if (smu_v14_0_2_is_od_feature_supported(smu,
> PP_OD_FEATURE_GFXCLK_BIT)) {
> -                       smu_v14_0_2_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_G=
FXCLK_FMIN,
> -                                                         &min_value,
> -                                                         NULL);
>                         smu_v14_0_2_get_od_setting_limits(smu,
>                                                           PP_OD_FEATURE_G=
FXCLK_FMAX,
> -                                                         NULL,
> +                                                         &min_value,
>                                                           &max_value);
>                         size +=3D sysfs_emit_at(buf, size,
> "SCLK_OFFSET: %7dMhz %10uMhz\n",
>                                               min_value, max_value); @@ -=
2417,36 +2406,24 @@
> static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
>                         return -ENOTSUPP;
>                 }
>
> -               for (i =3D 0; i < size; i +=3D 2) {
> -                       if (i + 2 > size) {
> -                               dev_info(adev->dev, "invalid number of in=
put parameters %d\n",
> size);
> -                               return -EINVAL;
> -                       }
> -
> -                       switch (input[i]) {
> -                       case 1:
> -                               smu_v14_0_2_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_GFXCLK_FMAX,
> -                                                                 &minimu=
m,
> -                                                                 &maximu=
m);
> -                               if (input[i + 1] < minimum ||
> -                                   input[i + 1] > maximum) {
> -                                       dev_info(adev->dev, "GfxclkFmax (=
%ld) must be within
> [%u, %u]!\n",
> -                                               input[i + 1], minimum, ma=
ximum);
> -                                       return -EINVAL;
> -                               }
> -
> -                               od_table->OverDriveTable.GfxclkFoffset =
=3D input[i + 1];
> -                               od_table->OverDriveTable.FeatureCtrlMask =
|=3D 1U <<
> PP_OD_FEATURE_GFXCLK_BIT;
> -                               break;
> +               if (size !=3D 1) {
> +                       dev_info(adev->dev, "invalid number of input para=
meters %d\n",
> size);
> +                       return -EINVAL;
> +               }
>
> -                       default:
> -                               dev_info(adev->dev, "Invalid SCLK_VDDC_TA=
BLE
> index: %ld\n", input[i]);
> -                               dev_info(adev->dev, "Supported indices: [=
0:min,1:max]\n");
> -                               return -EINVAL;
> -                       }
> +               smu_v14_0_2_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_GFXCLK_FM=
AX,
> +                                                 &minimum,
> +                                                 &maximum);
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
> +                       dev_info(adev->dev, "GfxclkFoffset must be within=
 [%d, %u]!\n",
> +                                minimum, maximum);
> +                       return -EINVAL;
>                 }
>
> +               od_table->OverDriveTable.GfxclkFoffset =3D input[0];
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
> + PP_OD_FEATURE_GFXCLK_BIT;
>                 break;
>
>         case PP_OD_EDIT_MCLK_VDDC_TABLE:
> --
> 2.48.1
>
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> ------------------------------
>
> End of amd-gfx Digest, Vol 106, Issue 157
> *****************************************
