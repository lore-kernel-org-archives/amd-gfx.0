Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA296E81BD3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 14:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEE110E146;
	Mon,  9 Feb 2026 14:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q1uiPCYY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5884010E146
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 14:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZhyvF+1YIOYjXeRrjJDjdYwr2b718p6JJWvSpUzvKFwQuEiYpg3ZYcPa2DsqULj8ggLojdnhuKIBMWgrl635254/qo2tOcFZbhWbIToDclZsdEY36clyGaAezFRu8FJWnjW0W/dEAQdemZAYANBYU9OMUBeiMaDGA75Mhmeb2qtqCdqNap6onNf6at9C7VjJsIpkTKca4i4hC2KV171ssLzEqldqcYoaqBNmYbnz3ueqsAtLqJPe5rc1e8TbZw8FG951Wuu/+v5/GiX2X0Q4Z6HKboms8i9sqoKIeKUC7tvA6Mk3zZufgKvQ79HcuA7El5XsES++X+4M2svBI5EFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfDh4aXkYgAlG2P1eiaNqtgd9uEoK/1Jb8tnLPpAm9I=;
 b=hxF9Nl94xx341B5iKtHUIUpxd+Pu5Nt+udgvW73S6UDCNzAVQ1+JehE7eNsnfzOPsajtemGthje8E6yUeEDv5giUSsbdH2kmxHJ1maq4ytkfgxyF6e3nooS1bR1yMwSWY4gDq/A849iHg3jeGl3gRq3uHHMfkIRDmasYLexgO4ba9VS5SN4qs9lNPPAsGxBUpqJDIDTQeVSnMG9Q+ykxmI75ZTAWWSCy6QE4ZJ8wd6qum6vSLNAYKQkpEenYfR7YbDHY2Lonti7oLJm51Mz9q+Q70L8w6UYFbfla+x9K9pUzkyEaeRlKujuOB5J+Ki+Lqy/svDjCwAUPbnbLJc6Acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfDh4aXkYgAlG2P1eiaNqtgd9uEoK/1Jb8tnLPpAm9I=;
 b=q1uiPCYYhz+fLK2P+PjRH0ZtpQv1KIeBjOl+2AGkZIyGLN3eUKNHEui/bvBg0BrGavTZGvCmFoJFexKCn/Ss8XdgsAfoLcADdlnFCy5c08IDhdhYYZAvpWHymPnjGradPyF5nU66GIvCYDrk+f0BkxEjn+FwWmDu6uizvCq1ePI=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS2PR12MB9637.namprd12.prod.outlook.com (2603:10b6:8:27b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 14:53:07 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 14:53:07 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH] drm/amdgpu: return when ras table checksum is error
Thread-Topic: [PATCH] drm/amdgpu: return when ras table checksum is error
Thread-Index: AQHcmaeGjBijlMsmF0aVVEXLlY+1D7V6dD4g
Date: Mon, 9 Feb 2026 14:53:07 +0000
Message-ID: <BL1PR12MB58988C76AD02BEB8DB3B5A918565A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260209093543.1341791-1-ganglxie@amd.com>
In-Reply-To: <20260209093543.1341791-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-09T14:52:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS2PR12MB9637:EE_
x-ms-office365-filtering-correlation-id: 25f4126f-558f-47f1-3735-08de67eaefbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GabmsV5vrp6MkdgTAzQH6cZHt8DWp9YdzuoFnpJnh73gKsj7b2usG2etx92f?=
 =?us-ascii?Q?h8tkTw+XfyQkTGce7wp/J9Jg+ZmGmRvoVd5WNohGLZyg939aN3dN6aOq6JK+?=
 =?us-ascii?Q?NJ0Nn4u4WdUrjlGvAmvuZM0fcGCaY2cUFF6nFQkcOMSoQiaV1UILc5OSs+tG?=
 =?us-ascii?Q?j0jvBvqQEHEkikC7MIGCBiLO7wsevnPycDvYt0ZaPoRECEY97vjEesRz3lAx?=
 =?us-ascii?Q?XRPqFbXUu9PMRLCrzAUuo16bbD4x6sJcmwo+oxXe4gRhWg2+suTSDrxuqe3M?=
 =?us-ascii?Q?drfuBmyee97eSHgKV2NStuWHuvvkkDEd4tULcDUFvz79/8Y5LSmHCaha2MNk?=
 =?us-ascii?Q?+kL+e93VTnr8GyXiUXHA20CpQxc5K+ZvgnVtoN8tSGwKiMj0M79xqpg0QZW5?=
 =?us-ascii?Q?B/q4GoJZjUrD21bklT9KsWKnHZ/8/RpUDTlA8mOaSaAdyuwKsBAQq0NXm3Ig?=
 =?us-ascii?Q?U0J33hnJqaXoTvv2bxTHbzC/gKCT+jLhLemjWF4s5wMhqy3aNvVu9l4yGrG8?=
 =?us-ascii?Q?VbnsS313sSUlXawSHb90FjWeJkb6/U31yCe1/iq8InmgbvUexWsx6B11ymSP?=
 =?us-ascii?Q?4P4+8GvWLz3xYIe3tOLd1m8s79xdKWVRZWPlvOTWlPO9w8mkD9/4G6ArpaMy?=
 =?us-ascii?Q?z0FGdQnH8nBnsdluA2oM4caoP6JHgLW11kWMHG5ixbvdpb8TSd8iKDZqaO98?=
 =?us-ascii?Q?ki3Qwh4z7RjVy+CznKRM+H5gAHYRsi0TnKBoFqn1MTvFjM13SRXCqoXqM6b5?=
 =?us-ascii?Q?EK1PGRx7XjRWQD7+nKNFy2jQdIcxc8vjgQrl/YLBLlaMskmF2M2+lrZb3Al4?=
 =?us-ascii?Q?JQFdb9Q+kPSnVHOPDYobjJd1yJfTHaYFZsVlTB+fOfu1BF/K2Yus7SXslq67?=
 =?us-ascii?Q?TNT5niZCOX2G7FhI81so4RBmqpSrrHDAb1Jsl8jQOB1obhg2f26K2diKHgJP?=
 =?us-ascii?Q?GHpw3E38mPPMzaG+ogq5CovnlUoY6qBelxUhS2see3FvXupgVVLFHTAZ3Jc5?=
 =?us-ascii?Q?f1oOIPsrvClZad8uloP5Dq8D2C94jh2wmDDPajt9+GFVkAxxnTAyuylPmm66?=
 =?us-ascii?Q?0SQaT1XwmNCk6Cr1dUQg1tH+NxA2CMGQe4lmFzpcMhPs+gSjZpMoUsGgaexT?=
 =?us-ascii?Q?xl6YTNuwrKo2xmJowJLXiCwy9iYqJOWKKdEbf6TGXBRKgyAWI82qDJKvxjmN?=
 =?us-ascii?Q?rqyPVIi1UeFKRn4aOFVsP/42E43GLGdcX3Wt7m1/7boKKSjDyzp6OdtZ0nrt?=
 =?us-ascii?Q?kh4KywNiVBo3TFIp2eIpkj/MvCp0JMXbtqfAAi6sBLEU7lMRhYo/GuWXGF92?=
 =?us-ascii?Q?YfMWe5H4MoTGYdlUGNjXkwnLTKeRsBz8eUenmXut1jlS2S5XPr8sZ7d+/1Ud?=
 =?us-ascii?Q?cVqFdcWwzTIctzoeNgr4wYK0n4V4w+lXap0JLnSDqFcnLAcGjin6WRksrCEE?=
 =?us-ascii?Q?FfWVP3xpwMT7MyrQLIahJi4zO8fJUWxTpt4n6hwOpX0T1S7NMPCDUpBC68F5?=
 =?us-ascii?Q?ofHCBC5HBDxm8bB2wTE5IUx7JDjzVbShP3OpvLFNkB6EBGTB4i7FPCaqF1aT?=
 =?us-ascii?Q?PXYDfwMPadyoKYkII0CsSMjHGme45AwZAUIPJs5YInJfJmE9jjfksljfb3er?=
 =?us-ascii?Q?Cb/6nTJUWJ6/HjjaU/xSfFc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wtxiZEf+9fPhOTEX429FNy1LnUkPnsmgOEmKiGvpvHjhLZwkaP0QNaCdOS65?=
 =?us-ascii?Q?pv/TAV9Nu8xQhJ9GdPFjUr41iGcfk6Pn1uO0z4Fbq3ksWNkCDMk7VMr2kBog?=
 =?us-ascii?Q?at9TqpbfGlNGWhnLfTUGcs3B4rz13Vlv/gdDuVPiaC2Bwx/PdLT9U33hPN47?=
 =?us-ascii?Q?FG23EqbiXLmmJTNPkrjKt7qNZyRSLXJ8BJAuwqBkQ54+8avTW/ixztdzfpKd?=
 =?us-ascii?Q?Us8i6ImiQQDzJbUva5E/lU6WYAaxsTgVDGPrPcwsm/wkMogLBR9vOY9YxvQI?=
 =?us-ascii?Q?ihaZQ1IKeNhyUhZlOEzt9FdNzBaW6NUt307qgGXxh5BOFGytGQnlKYmuIOWM?=
 =?us-ascii?Q?3dMy9JzddyDE84IAP8ALRm1OIjvCz5bP2vlhIOXpm6LtIrlgS8zSMRsyVV1Y?=
 =?us-ascii?Q?A29KPCNAg4xDoM9YdbFmLtyHRlLRJBPcSed2VtssELBoX4PrQ6R4cg5KtQi7?=
 =?us-ascii?Q?40999TX6HRCxBMSncR8zBsa++219Fg/sV6geG98V2g8Ntay0tBtgkZsH3c/Z?=
 =?us-ascii?Q?2dCwWlK4rqIOzimtGlfBsq4Y9L15NDKH+GZh9wfH8gzk6kGebdN2/B6zTXwc?=
 =?us-ascii?Q?u9mg6MY3XKaKL9ia0b1UtvHuMd/ESlcQK61FNNozT99uzU0JGofvhk2siT1L?=
 =?us-ascii?Q?P03/8W/+UyeiYf/20F6iy4rWrhYPgrw719J0Qw19cwXWmyjDJ5DBPCDqpQd6?=
 =?us-ascii?Q?bdEheMRjzYuuBGIZSX5t6j04Z78IakXJiEXJlfzIIWbSH4TeXZJCgqIMtL60?=
 =?us-ascii?Q?/c5qyODIiL4MXfeV9i3LV3LcBnfvior2VAF/JrtmCmHiYk7s/9ss4Qu2lJf9?=
 =?us-ascii?Q?Y7Vka/iUMhqnK388oR3MAMfUOAP849SjuqXH8GfGrLslttC8B5bNgenvGoE0?=
 =?us-ascii?Q?vLjrCixJHRQ/S9TN2geoipWwmkNRgoe/E7//AhDayF6HntfLgbINMmHqVynH?=
 =?us-ascii?Q?KC4RQjuiyFJ1Ub3O8aq6DK3tSW11Hkn6AryTPOWKtfeu/25kxJPpgKSm36Zq?=
 =?us-ascii?Q?WwpLAasgBzT/EfJDJVKWlD5nXQNEt+IUobr9JQb8ZHi+PRKsAkIrSEu3iurD?=
 =?us-ascii?Q?H0UTHx7YEEFg4cH4LtlWb3ZkRfgQ/gQOnurNixGU/TWy+CTDlrUe3C0oabcf?=
 =?us-ascii?Q?w9Py7XH3vUDkbRrzs8msac0O2mkwySar8tw+Ob4ZNI4SJ9UgCCzTM/LZS6/0?=
 =?us-ascii?Q?eRIw+VhphhvJdWfT7MPsvOvfZwctvJALrgzRsU/qcLJGFSaWDPydhMoYDoJs?=
 =?us-ascii?Q?u3ywEygtEeAdWB8IrEwlcA3EAAG6KLjMQGEzX2LyohIr3GT/QDUdMcs5zkZV?=
 =?us-ascii?Q?9Axmt8PEb3rfiyVkkmU7TjfG/pytcQMXM42+3Wmr06ymeXm2CpQB+rkSdMC5?=
 =?us-ascii?Q?vUK9XcSSe0XDh+cVgkcpr2gnvhQ9H4QgtxqfRBiY5wparilAd6RIoH0SfFVj?=
 =?us-ascii?Q?qW/XODHmrs7iBAQxaG53WUMfYu0rUFvime71Y9dqb02ZpN0FDOBuda8Gkkrq?=
 =?us-ascii?Q?+mH619Q7LLkMt1DsD7lNub1m8lwIobOdHplaHJ4YENsr9T7w+9Rf5DUwzzBN?=
 =?us-ascii?Q?QxMcJqgfNWL6wBwAL82PqImWveOA+TbUy03NXH7loCpDJs71ymmL1bHpxcNM?=
 =?us-ascii?Q?ioJt+Q/jm7hMPPFH2oxIyhAzhoMbv9w9o6VvsgOCY7Uf/441WTmjFugM2OyI?=
 =?us-ascii?Q?wOZKupYoJnnbv44f2SUlT98z1gx7lN4g3oFGLIqawxlPrNgY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f4126f-558f-47f1-3735-08de67eaefbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 14:53:07.4941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKx+p0m7vccQ920/WJTWhf197i0NSPvOJfeqoUZSDtSfZ3AJi2jn96f618htenvjGBfkzxN/FrzTkjhst1X4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9637
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gangli=
ang
> Xie
> Sent: Monday, February 9, 2026 4:36 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: return when ras table checksum is error
>
> end the function flow when ras table checksum is error
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2c5d7f87e593..6fba9d5b29ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1701,10 +1701,12 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>               }
>
>               res =3D __verify_ras_table_checksum(control);
> -             if (res)
> +             if (res) {
>                       dev_err(adev->dev,
>                               "RAS table incorrect checksum or error:%d\n=
",
>                               res);
> +                     return -EINVAL;
> +             }
>
>               /* Warn if we are at 90% of the threshold or above
>                */
> --
> 2.34.1

