Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26578C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 19:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FEB10E0BE;
	Mon, 10 Feb 2025 19:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K7P5aDYK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2658510E5FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 19:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8LxUwiKdLc11ZXsDCZlV7s0Mk4i6bV2KbZvHWrY4Y4zk52SEk9UtoqhFzTZ7AAhl4pHfSEPnyYI2w1Btj/v9WgdQtbiP8Tn/4VUsjSCUjNHJcT1z6zOmwYBxRk+MfWG/Is8Ug+AzSVLPNFtcx8eVuiLRtkW6FA3meoWSPgkxkvfHeCIfm7fF2aMQSfsbttuTv0XKgWvC3rKrvwz6HDq+I5casru4lu95I892IVhfardI0cHhGIIF7TMy6bw4rrGgQxjmM2+y0P6XxiwWs3AcqnYnNFc4iiqxNKJbX7xmz6EepQJ2fmk7NsVemhou/XfbZYP2oPWqcY5l9W6Wla/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGufofPri7ZHFfDfD7bJsO2705o/10aZMyz2YLvDU6s=;
 b=JOuBRJPV6XvWLm/6hcXxPcZ8nGDCYeA32ouGI4GFJ1Yb+EVBuh59dU/Pw6whvnoo3e0k8llSO9XpCMo58wQ6uyI3X11RLdQCPN1MFOEBMdTUejAMcZ+bmBugwK7PzeKy5HJ7iN5TREF3oI1zyXT1xVQx1Mns6loJTrrtAfQustz7ukIUbvdJElc9hIzW7MYwNRhnyCY2/6W6avXpShJX62bRuWIUd9AKKcP6rLmdLqj2EU1EcmVwcx057cqgdUORD7grBnPfs/egyqMod8N6/cfvmARon3McJKkN3rZWFO87hhpBq3rT+am5lT1EURVwEt9LfHGgirIoDOOtA5s5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGufofPri7ZHFfDfD7bJsO2705o/10aZMyz2YLvDU6s=;
 b=K7P5aDYKM7biiAsZzB6mRqRdR5c6getYU8VBiEy/D2OigK67Eio2HQfhyiyo8oiEcfTT/mD1jJYH963r9KAFqP6I5IJ68Md+vm9cKV7R7P7cOYDQOs6TbEGqr4x/2sxATPFlvtvOnLuEK+y/kDO/kSsU0GkGbIJwdYzTafL4/io=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 19:24:58 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 19:24:57 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 4/4] drm/amdgpu: Use xgmi APIs for init and bandwidth
Thread-Topic: [PATCH v2 4/4] drm/amdgpu: Use xgmi APIs for init and bandwidth
Thread-Index: AQHbe4mLs+aQUrSSQEGkvZSmkndW6LNA6JMQ
Date: Mon, 10 Feb 2025 19:24:57 +0000
Message-ID: <CY8PR12MB7435BBAB0F7A0DC2340C3CED85F22@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250210070034.1998011-1-lijo.lazar@amd.com>
 <20250210070034.1998011-4-lijo.lazar@amd.com>
In-Reply-To: <20250210070034.1998011-4-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=0447306c-9e7c-4d9c-91b1-272c2f315c1b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-10T19:24:32Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SA3PR12MB7829:EE_
x-ms-office365-filtering-correlation-id: 19505c72-1a71-4193-c74f-08dd4a089b16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?go7HCsXR0iSTWGPRJEd2ZaG//NpRN8XwlHKh10bFq0aHwixjfRi6bsrovDYL?=
 =?us-ascii?Q?AZpEfqFHZGEwvaUH/mfCaKjiCQAz9KQHKUxde0hNfPSMb7ADS2DBYRPkbS9r?=
 =?us-ascii?Q?sA6jOZMOn8TUqzqQgak8jq3+p32Fraa0nWiUjJ1EECz9ZpvL7DzevBTXM3t9?=
 =?us-ascii?Q?y4QtLKtX6wXlWw0+6p65FQ83HZwduiMPo2Ucenisu5tJhj49+XeJsgHCKksM?=
 =?us-ascii?Q?vzIMRZXA0Zc44PGX9dkupB+BfW+E5CO8oA5Mnbc7zEsAPAB44lbQ3Rl3Ctp7?=
 =?us-ascii?Q?8xlEuu5yhjQT0Q8Pzr5U9ZmAvZnhYdYAqXgig2/kjyPFTw2ptw1eAPIoaHy1?=
 =?us-ascii?Q?mwoJhCkTjQyp/MACT2nP6SYuL1/U+LSCNJp+V52RdH3A7PdhP13XlOJ/GAYy?=
 =?us-ascii?Q?yg4476hYOKiTEbetNMNXZ0/Gq2PDGNWmaJYBaQ5I53jF/kHFEfMkbJLsyPvZ?=
 =?us-ascii?Q?EXrQIz+Ww7i10WVrD6yJUbL08RaS7H3EXjNwxfoFVe6C0z4/MMcMvCxFy9MA?=
 =?us-ascii?Q?IOXEyUVaJ3OS7c6wK2BFOo+XtZ2tPLZqBl0icIfWobfSJ5WgZEqPCfbfOzHS?=
 =?us-ascii?Q?Qs6SAa5Wu3yz4cVYZr3PRjO6FI7/dF/Izb4l9I5MKNIv6mv+tkXkh/UMn/Lq?=
 =?us-ascii?Q?VppWyOhSaZmcdDtE4DiIhSVFyzALI2J7phdA5VeqR6a4iqwTep8XXkXjbX3F?=
 =?us-ascii?Q?QY4eLGVmyryQYK0WU1G5A3cf54Z79guCAsteq5DM3C0gqbwZOVfCLLLmcy7Q?=
 =?us-ascii?Q?sFCdH3OD3V0ZczNPAnXD64JnNxFJTzGyBeO3kUojy1WE6pUxN60Jg5ElLV5o?=
 =?us-ascii?Q?X1KBio2gWZzfGCrW6hW+fyk2Rf9TnwAUrSwk+0enPZuWe2HlYrX1Ig8BXEIF?=
 =?us-ascii?Q?Y4fJKiooIsd1REOQLCDtpWb/Vom03y1zGtvwgEYmWGNfiUvjlQqWlC3EYdnH?=
 =?us-ascii?Q?HLiZTRm6lnH6d3SddqdZXRNAlzhXYZsGLNXgRmTjNi7G7svAnpNmrVacBj56?=
 =?us-ascii?Q?RtTNrI0N43/anRU1DUY48bNN3c0NmT/Pyhp9Tu2mH8T8CSwRMumksnPRLsAd?=
 =?us-ascii?Q?vPGbs0iOW7CBB8Et2ZaigO6UUQqObvayUN1nYeI9lugNwzofMdOH6xtnwC0n?=
 =?us-ascii?Q?1ilEC49mq8JzpyD8E9YmpwSGz2WeiZtDvcM+QQXDg1mxEH/1wJiZozhq4vQu?=
 =?us-ascii?Q?i2tzLGmF6DEFuKB6QJw0QzePgxEr4WTnApS70Vxu4RKnauP5dKLELIBVo94S?=
 =?us-ascii?Q?nNF6q2K9Hg5gopEvC7PIP9+VqjCjJldnPmY/y4YS7zNQnzPxubGYK3NkgmsT?=
 =?us-ascii?Q?BqM37PTh1TbqwWSiWRk4AUTXnK51NNB4bEU+uYZqxnp2CTT0I6CtJc8ZAgFH?=
 =?us-ascii?Q?pGvWUPKhggmkxmcv25qIg1TLQuSSJkwHOpWxyW8NTjsJMx4mOZYgTjS6Y6fA?=
 =?us-ascii?Q?mE7oZ2G9qXqbOP2MhYfapRjEEmfWYM5l?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HCV223Jf64yz4htzEk+GcYHM8xqAY+/+9Ug7dNQek8//9XC82d8mt5DSgGJ4?=
 =?us-ascii?Q?0B13WoUHRagrCXeIOPlM+lXyHvP9WPDbB5ighBT5bXi/FDX7rD5aw8uw0mVb?=
 =?us-ascii?Q?Mtc5bPRrb9lSVu4AfxBCSi0k3VwAJL8Bzz/Nlrg06uD8FsBRbDUq8Tfr9pEA?=
 =?us-ascii?Q?sO/X+zpE4xyWk3u5LgrU5OCT69ZNMxxvP/RfqRBIt/E7MKitQq3ugK9sCR1f?=
 =?us-ascii?Q?gZHR81ZWvoI0lXmn+8sREAJYuBMLlgwcp24ZPOHjEcQnVhKTDD91B8Qfbjsp?=
 =?us-ascii?Q?Jy+5CKwquQM6ZtrXhXA05T69XoSalEt2oXomrOFwDejOj7HoRovEZ9Tllmsx?=
 =?us-ascii?Q?vrd0QqXFgSVSgMoRDyQB/2nkClMAhR5YolNhqvfLXEh7DYvtkEQVX6bnO5Sg?=
 =?us-ascii?Q?4bdNI2ER3SdS486SPTI+FEw0pelkorp2mHQ+ZeLJueZ+SXUMlKmfSdWHbk/L?=
 =?us-ascii?Q?2F3EU01C+QtLOCoHuY1bc9Op0iUh/KsND+BRXN9RP3Rsx4V/BGJdQ737Mk77?=
 =?us-ascii?Q?xjapsr70YgkeMGPiOlMzQ06ntQ34Mjh1Bes7hiFfPcNbYA5Q6AvjTx0315LG?=
 =?us-ascii?Q?8IIUy0EyHI1fJYn+Q4Esw9bmb1/hvRIW7WPkIEjRUTClQoO9tKehM3qvSN57?=
 =?us-ascii?Q?cJqOf7o00JpYrkP0PELtt38pwjnYDMvGwThcggLOmXpBK9HQRf76jEb/fWFl?=
 =?us-ascii?Q?vN4UUovve4K3lV2IoiF5Ldi6IqYYnUnJWIkPkOxxWRhjpkMfhRAwJ1QCgHUI?=
 =?us-ascii?Q?vQtXPXb1mMGSsy5Ua41AhQnGlca9t0Pjfw165mpBxs1+0v1qvoVLJp2wrfvQ?=
 =?us-ascii?Q?wUzaqofLLmNBvsyUk8LBLDlrmxqGXIY8kM5plOuk4i+GeA/4t4OvMsM36j14?=
 =?us-ascii?Q?4V9YfUQ1vBpU6USiIzINv8OMKmU3/74EE1yJwvWfC1a9JDpmxHRtrN7nZfFB?=
 =?us-ascii?Q?tXnqipZoguW4tg1ke48QNm+xy6RkjOi6lqzUmOgrSOOZuRU1EGXkpAg6+WDx?=
 =?us-ascii?Q?VmitvOhfL+R8+WmXKo2DobmvEAYNrNHd893NbqYQvsgYz27A4L9UhLke03ie?=
 =?us-ascii?Q?yxXA5H+2Ts4ZiDqDb64N1aDRvDpOjkN2QucBtKaLLrTU4dLND4zFt/pHHaTr?=
 =?us-ascii?Q?bze6scAceDSCpOJgy+2qT7IQMSdDtOXofQf8o+ec8LsWs3E6iyaDhg64UibL?=
 =?us-ascii?Q?pPVqr5umm8znNe4bM68eAdlzCqZKnatJL6sSmFL9TyT9pRVwwGTRerT+kbnw?=
 =?us-ascii?Q?vvGnnvs+NxhkvcklBsCef8m/rgQs8JxFWcaDNLiYTWaFDT6VXsSlGokFjrBm?=
 =?us-ascii?Q?jwbrQBYdtBcgspuJLvohc0rUAgsuuYRu5+//vn4AjDHb8j3ysfj/TV+gOqDp?=
 =?us-ascii?Q?+N67c20zkQCv7P0ivNyiHEJ0xRq5TM5wgvwcjUjKVbpjdi+xNmrFKxQTno9S?=
 =?us-ascii?Q?mYfFZv2D1sQKRfZaEYzUVzj7wiUh4PmsW8F0UFwv9Cks4qwXjmQZ1Fe/+RnZ?=
 =?us-ascii?Q?wizQ0peR7ckbpC4mZ3mkQUiGsES2Yo5hbINm4GKsI/YzXDEk/+psgyCwAfS/?=
 =?us-ascii?Q?8GSiAVO9iquxDEqwbP0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19505c72-1a71-4193-c74f-08dd4a089b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 19:24:57.8350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrixThQb5WcmnaBOlXaQ0WISyfpMve1atrHDonu++EW9JHRVeAcnIr2z5luLM6Jd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, February 10, 2025 2:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH v2 4/4] drm/amdgpu: Use xgmi APIs for init and bandwidth
>
> Initialize xgmi related static information during early_init. Use xgmi
> API to get max bandwidth details.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
> v2:
>       Move XGMI info init to early init phase (Jon)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 2c1b38c5cfc6..e6bc70fb1eb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -576,6 +576,7 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct
> amdgpu_device *dst,
>                                           bool is_min)
>  {
>       struct amdgpu_device *adev =3D dst, *peer_adev;
> +     uint32_t link_max_bandwidth;
>       int num_links;
>
>       if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
> @@ -593,8 +594,9 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct
> amdgpu_device *dst,
>               num_links =3D 0;
>       }
>
> -     /* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for
> bandwidth. */
> -     return (num_links * 16 * 25000)/BITS_PER_BYTE;
> +     link_max_bandwidth =3D amdgpu_xgmi_get_max_bandwidth(adev);
> +
> +     return (num_links * link_max_bandwidth)/BITS_PER_BYTE;
>  }

I have a WIP patch that deprecates the amdgpu_amdkfd_get_xgmi_* calls and c=
onsolidates them into amdgpu_xgmi.c.
This should hopefully reduce the middleman and make life easier for both pa=
rts of the driver.
It'll take a day or two to fully test, but I'll send you a compile tested v=
ersion offline in the meantime to give you a sense of what I'll be doing.

Jon

>
>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, =
bool
> is_min)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 315ab2d6717a..09aac4542ed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2749,6 +2749,9 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>       if (!total)
>               return -ENODEV;
>
> +     if (adev->gmc.xgmi.supported)
> +             amdgpu_xgmi_early_init(adev);
> +
>       ip_block =3D amdgpu_device_ip_get_ip_block(adev,
> AMD_IP_BLOCK_TYPE_GFX);
>       if (ip_block->status.valid !=3D false)
>               amdgpu_amdkfd_device_probe(adev);
> --
> 2.25.1

