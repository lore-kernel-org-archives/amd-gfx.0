Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D481DEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 04:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A4510E106;
	Fri, 14 Jul 2023 04:06:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BFA410E106
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 04:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzncbgeQX9r0i1PvMdRY5OS68CVSDS0FoVsYmCoiTCRcda0zDCNKaT8TS3scC2bYD38UXAPA8w8YWl4rmJ87i3o1/LY1XcLnaGJe/OwwcXtBPWKw41s6OICjZdgZa+HXABfAeDN+dNYXkg5LeKXnfE62ewpt3V8BSEsGVUwH8Xovc6mCghiddLYA0Io7Izl18Q1Q3CrcKwOLVgAz9BQArtZYNUD27fV+4FqQna8oBOXjG/Fa8Tds9tIcCsPROhceFkNfHiU8bofGGwvRiABwymqisLHt0tGacquBhs3iIYx+UHBDAiMSu6CxyIX+ZPM+hhbTD3bv8fOqHH1OLOiSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGYxO2FbXUUXdYJN8n4frbKOlPNGIiti7smjtWZG1fw=;
 b=HRLoZMJArmd/FMR5hEOPTwKrur+M4J2UknsB0wJkJqX8xLKcorqExShyn5/WnCQqgEdudSjJb1d0FSMsjT/d9QHuisrFgvcRx2n+AWju0r4+AC2075JUgwZwKWooygFkvz9PlYBH1IX1oHoAYBiOKq8Zmu7fmkfH6kr2lJGXgR5P1nqjMP4Exk64VOpepcd4FZ7GWB/S3dKFpjpRvurnxifKlLLtoTXLfFXYpj/jenK4odae9qwmHSQTwgYHiZPL/HIhJ0LYveHlJ4gf6KBOK9CjuPH4TzWz2R+5lXWsdpwh+EZ7Dlu+O7uayqtri6LelEHZxxBql17JYKvgPlNFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGYxO2FbXUUXdYJN8n4frbKOlPNGIiti7smjtWZG1fw=;
 b=KiRQUlgdouwHwcYNSluE0/IFQxASHmr/68NkYB/uhMJsmKV9v8prganhrrUmTCrR2bv227HFrOR9Qn9C27nOXCe8sk2NOceHAZbQM84svL7lrW+kWirjg4yf4H3uFlKHhJIj/tnNg4HTazZOyVZDtRvaI1+aLJLoa+jqp6VMTog=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Fri, 14 Jul
 2023 04:06:09 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::b918:c914:98d9:2975]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::b918:c914:98d9:2975%5]) with mapi id 15.20.6565.016; Fri, 14 Jul 2023
 04:06:08 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review V3 2/2] drm/amdgpu: Disable RAS by default on APU
 flatform
Thread-Topic: [PATCH Review V3 2/2] drm/amdgpu: Disable RAS by default on APU
 flatform
Thread-Index: AQHZtgU2dY62jUKgKU2z+JrYByLblK+4pNqA
Date: Fri, 14 Jul 2023 04:06:08 +0000
Message-ID: <PH7PR12MB87969EC0DFA1B1428967A18AB034A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230714034216.500658-1-Stanley.Yang@amd.com>
 <20230714034216.500658-2-Stanley.Yang@amd.com>
In-Reply-To: <20230714034216.500658-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32827398-d376-45e9-a0d3-eba2bd026327;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-14T04:05:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS7PR12MB6358:EE_
x-ms-office365-filtering-correlation-id: 68d68894-1d80-4e13-6762-08db841fa6fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SAN09+qxd+TWOfl58+SynZKjoIh78GEztuQyO+yxOOgCM098R4oJNBGAvnmzR8QbN9O47kFu1o6TAMir+y7UIEb5dcfHqXIl9z9Lzc9C96LxFK1XNGivGN7xBuTaVR4FbhPO/LmqZ9D/D9g2HDvjFkPfmxfBPOR28PmT5B1GdHIcXWnA21CX9ihkZxgMDNmFSb8YXv938TvAbeOLu4za0EPNqhs1SJG4poZC8q5hlSJ2yhjMBomld0Z6QYmRO/24OdlwH5n09gkbs+LAHSkr3r3SggcYv1l8dITfdPQwutTGJQov6ddL9i/fw6ilGKzZizuo59DT700hVggXLTlxy5T6aTzte336NH2azn0hBhWOfxoCQtMinVhpkmZVUfu4tU2Vzz+ZMDoM2as3mshbnZ2nhliHC9mL4UtWFBiguRHRAagpA8oMyui0Si4E96LEa0q47ATX317cQriUBxHY4qAWboitH+pjKHiP/VyScUsM3UhN6DXO4wy9Jegz/dy4ULpFiQuCf2hXSV72ciqsaQc59G40WtQPk2D7TZdjfZ5LN7kVcHMz9WcSiOCpAb16jiG2TSYy381Qw48epnD5JHEl5UELxsJkexSpNQcjipH+PVdaQ0MT1hwU+dORtmgb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(9686003)(6506007)(53546011)(41300700001)(26005)(83380400001)(186003)(110136005)(122000001)(71200400001)(76116006)(7696005)(6636002)(66556008)(55016003)(478600001)(38100700002)(64756008)(66446008)(66476007)(316002)(66946007)(4326008)(8936002)(8676002)(86362001)(33656002)(38070700005)(52536014)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6UMZ3LN+iV69/DfnEuolqrEPQOxN7Cb+MnzkJaJI/uTeltUD6bfXcTDU27Ig?=
 =?us-ascii?Q?EIm7dujEdNPje9znQLLvovhbQuTkmVWOYoPZFjtV0uzKT3vWUsLcnxNg1E0Q?=
 =?us-ascii?Q?d6j2fiRJlarFsFMr85gFxz51FSvN29sX5qVNPd/l6+ZJ0pej9BRW3X/oSQCf?=
 =?us-ascii?Q?2X4NeplRbQl8ufGJTY1tz+iGtQaJhiqiJL5xvQCiiqXA4Iw0KoRbMUI3pQUC?=
 =?us-ascii?Q?HxZJxn1vy+W85NOR5YZR6w9a+ZBy2bO8iTe/MuBNl8DG9cwvuviiu4updK+n?=
 =?us-ascii?Q?eKr69ajRN1BJYxWnDGkHcuZD2hRkKQb5VT76i/Yna+99RKzD/bOQDF7QfiAU?=
 =?us-ascii?Q?qVca9q1YCChV6i6ZS/o/kvobj5nb2sEDYOFGpkPiO4OPiRah2IA8VQJn3IzO?=
 =?us-ascii?Q?0NTGHpwM6tatuGrNPDt6tFFzTFfrpklQeOJ5805so7k8HcGVdm24ANbwOevy?=
 =?us-ascii?Q?uCq4BadwnyPyDxgXEjVsLWCHGCQvO/WmLHmJjz2oUrl6Wn39wcEgFEc3vwX8?=
 =?us-ascii?Q?1oQ7DQCRe4CVbV4JH/DkY6QdAnVYe2SdkOAZ0EnWbEKOCN7hIliHXUhf4Ve1?=
 =?us-ascii?Q?FtngP2yB7xgY0fb8uBPchiGftyEw54/PynVE2HX6a26rHe25rw4mImTCwQ7f?=
 =?us-ascii?Q?JiJGcAwqkrPAoQSm502p1H+Ma/atFpHztsO7HSQhtER+7A+lgb3MeKPQ8jda?=
 =?us-ascii?Q?jONHZSG1IN9jwXyneiKwG8irK9Ud//AhgX8S756D60m8FL5hl+ngkFSj+vj9?=
 =?us-ascii?Q?u9agQNJPUb+tkvCl5eDv/nta+LOESDhz6csbuC3SHMLNrg3xoeGwBBg714dZ?=
 =?us-ascii?Q?F23SN4LyqJYoZ9Hf11C2A4AEB+Vqquy0mZGWPpxJ2eNF0hLZ5AZh4NQQfYuy?=
 =?us-ascii?Q?9Fu3jFkAcAkPW39JkgLnQ/S1/6KAu505Jmv+2PA/cyFK+Oqcv8cReoLmruPs?=
 =?us-ascii?Q?JEQAw54/HCzOLyHE/k2kPTciAgAd8XA5vrVDXxEFlBRTWWr+dv7NLXw5UBbE?=
 =?us-ascii?Q?+vhF6+B0ev5tmAxnOnxbJ4iY9ylTlCpJ0+Iu3qfgNfP0nBDhOz59HAwqOulK?=
 =?us-ascii?Q?nBa/Yl5Rn06SgsNq84tae4QiWBO1kw+5SPbql1y4pNq3hxZvOam1EcjPS9cm?=
 =?us-ascii?Q?C/B9qJIH1xb6vSb70jC0+VvcY4Rx8ptPGtRoaQBhDdFTOS9qifg5ERbRiekD?=
 =?us-ascii?Q?sla9GGvpGP8x6fAbpXmWeSrdWnaGf/OZiAISRpOsmmo+9WqkLwJYiMY1W/N/?=
 =?us-ascii?Q?6u8l/+m3GSH5q/UahgpvwmPmB4WuAorhFuuYlYWCb4YBCxq/12ZZ4SlrL0h0?=
 =?us-ascii?Q?EwnvDt1O1TfxrTt2zbrHU7uAIQJT4MPCdP/2kuBLcAR+I3yYcqRCqd5SHa0U?=
 =?us-ascii?Q?JdkGmcZ7AwVtqC8FnJ7JFRiuM9qQgoDKvSibQzN6HFxbRrDb6IVPz+omxOKm?=
 =?us-ascii?Q?IE3ECOHqmRLCZ7pyHtDa5WS2XzQznpTIXPjbmxEyTbPDAnm/X82h5SCDJwxS?=
 =?us-ascii?Q?brKY8CxiEqpvG/QeHEcoxN49J8rU4tZpLYUpQIOuJNQ8mOUGrohxfGTkSN5E?=
 =?us-ascii?Q?BHmnoEKrUVDV9ui+luw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d68894-1d80-4e13-6762-08db841fa6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 04:06:08.3399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1LkGb/r3wc9e1fljYlG+MGkz5cp+qjaIk7LvCqmhlAn+xHUVm1WxkSxUUQk418u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, July 14, 2023 11:42 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review V3 2/2] drm/amdgpu: Disable RAS by default on APU
> flatform
>
> Disable RAS feature by default for aqua vanjaram on APU platform.
>
> Changed from V1:
>       Splite Disable RAS by default on APU platform into a
>       separated patch.
>
> Changed from V2:
>       Avoid to modify global variable amdgpu_ras_enable.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8673d9790bb0..c46e0ed9165e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2524,8 +2524,17 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>       /* hw_supported needs to be aligned with RAS block mask. */
>       adev->ras_hw_enabled &=3D AMDGPU_RAS_BLOCK_MASK;
>
> -     adev->ras_enabled =3D amdgpu_ras_enable =3D=3D 0 ? 0 :
> -             adev->ras_hw_enabled & amdgpu_ras_mask;
> +
> +     /*
> +      * Disable ras feature for aqua vanjaram
> +      * by default on apu platform.
> +      */
> +     if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))
> +             adev->ras_enabled =3D amdgpu_ras_enable !=3D 1 ? 0 :
> +                     adev->ras_hw_enabled & amdgpu_ras_mask;
> +     else
> +             adev->ras_enabled =3D amdgpu_ras_enable =3D=3D 0 ? 0 :
> +                     adev->ras_hw_enabled & amdgpu_ras_mask;
>  }
>
>  static void amdgpu_ras_counte_dw(struct work_struct *work)
> --
> 2.25.1

