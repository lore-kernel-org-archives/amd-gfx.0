Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA01C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 19:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B89410E6AE;
	Thu, 17 Feb 2022 19:20:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A501310E6B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 19:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W60063X0wHqdTr6AO1EgIdaiSerPJsxs2EsvFqn0E6z5UGVvx+tS3gKx2L8kBQ9cnLW4CnGkoKmjl7CcHVEVAC2GOdcx7QrAtmY1M8Qi2cy939Z4yN5A0jFTeTFDEh1iFoDqz5gft2+bZ/U0JtTx6GD631i1+pXdGwkhJTIYMEiro49KydgzMOkjsqdbMjXdBU2jN/4XzR1BWF284/Ue7y1ONb1ntev6j77Lq0uFvKJDBRebLwHEM9pXLjV3lNd/nGnvtnFCwY8rLO4OUThP8TkU9JO+HXrcbhrhR5UrZh7VcBD1x9jOVSWjLDhqktaqldt/oX3niOYif+brV4ytwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvrj4ibY4ZR0cVKmc/eZfEDVMMHCMa4BvM2V88PL8KY=;
 b=XajhUX5dFU/LrC6G7UhfkqWrOx1HT1OhDjFiD8W/mHAq8IS+MdGEL4CyKel+C7nFyGWHJ/1NgNjnIIMNTUyzEPXwL2X2GaAVlIlhuc0ASI2Fjy5reJLCf4md+F0BfGq3X3GoExQCNRfF36rfQYEqSB8vSQeavUJcZGAXKBsqWk4bXq4AG2ji/fayWpQT2NxVRd+hrCtQcFOknvhHBteSlkOUgrPCgEWLzBad+7gAice8UGdaXHvmoYwU3uRjl1g4L+x9t1B5//KTSUnmwBJlzPlXtTx3cdU1jsMVYk7XOPCNiQDqgNgI/RQjOOYofZAvF2W6t2xdpnkIQ4mJEUyBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvrj4ibY4ZR0cVKmc/eZfEDVMMHCMa4BvM2V88PL8KY=;
 b=qVhlfshtmNwxGb6RVpnKAg0QPZiGTnQviUzOh1JjSp4cWsBQXtWKjL4gEy6WBqiUMdFGsF4/cUasdpXesAyjmhUFO2il7FTPQTKMs6IxqQH1CLSx2ji7qjnaJ2I/g54SIy7dXzz9KExCvmHeCketEKTWfRtGI/ETOKjg64/azhc=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by BN8PR12MB2931.namprd12.prod.outlook.com (2603:10b6:408:6d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 19:20:11 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4%5]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 19:20:11 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Dynamically initialize IP instance attributes
Thread-Topic: [PATCH] drm/amdgpu: Dynamically initialize IP instance attributes
Thread-Index: AQHYJBx7X53lKqaIpkuJIOYVoAIiFKyYDYAFgAADpoCAAAxsmw==
Date: Thu, 17 Feb 2022 19:20:11 +0000
Message-ID: <DM6PR12MB3547FAA765845791CDADC3ACF7369@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220217163556.6491-1-luben.tuikov@amd.com>
 <DM6PR12MB3547FD0D228E17F075341B81F7369@DM6PR12MB3547.namprd12.prod.outlook.com>
 <CADnq5_MwikUo68_NUpc5tuMPG5pB_S6zOgCk83y4OunzMzK=-Q@mail.gmail.com>
In-Reply-To: <CADnq5_MwikUo68_NUpc5tuMPG5pB_S6zOgCk83y4OunzMzK=-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-17T19:20:10.873Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 636cf2a7-f7b5-970d-c461-21989a5398f4
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ceb08ba-8915-4045-f0d7-08d9f24a8486
x-ms-traffictypediagnostic: BN8PR12MB2931:EE_
x-microsoft-antispam-prvs: <BN8PR12MB2931D0D7A48DA24E414760FCF7369@BN8PR12MB2931.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FdLr9d11RVK9avytc5AGCpC1PvZRDum4P5uffioKM8mlEI35IgGftfGQd7xQtP1BUK5vYBlDSkX3f54FirZbSUFQzSN0/7lyeshubyGqldtbYoC45WVhKqoDSFISpxcxMeoXkOctdgBRBWwNBW5RZGMUGtTVw2iQyTegdgSfjV9hUtqdZdil1MYOnNT8fQr4jD9FpA8PzUh8N+jEfxGFaUmiB3HfoM2aZg4PDlD34tOS0VyIUtU7b31y0pGsJyq6dDHn9VeVKkgcERRflcbiTMlSOToADtrjCO5u1ciQoDXTTgiOscLMw1QcfOlEkvWitzMEQBIb/QsuxBXqzuzyM8V+errJZRRyPAWHwG73rvKZd42mxoyoxqUreqC0vWJq0MVUtdDO5i8hvqcuX8YqDK8Dqvx4f5yMfdiapIJXUrQjLJEYCEBwBmY5wwrB6dmyDAA1T80TEx1Ro2jhpPBffzVkn5ETcxyt+USu0BEfg4SDPR1y5aFumHpZOqeK6KZGUEPwUP2hgYnFjLgfvCuLkzchgq89zrq/+JNc337y3cfVLCkqe9y1bhAJ/1lnLmqL/AhAJR71zPxwxlUfDTBqyt31gqEujO130gKdkD/G2DZHm76DzBg7dZuAyDJgi3oJkQUN1XTHgm2ZIIW+JFs2bLwI8fdMBtlRWL4SvZnQ6hgO5QdAUtNSiuc+zdTTIZcrFy/2GeJ9n/aYLQhTqE8m38TBG9clPycPYVngfPW+DF0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66476007)(508600001)(66556008)(186003)(122000001)(38100700002)(38070700005)(53546011)(66946007)(4326008)(8676002)(64756008)(66446008)(2906002)(6916009)(9686003)(54906003)(33656002)(91956017)(76116006)(7696005)(6506007)(86362001)(71200400001)(52536014)(55016003)(8936002)(5660300002)(316002)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UwfEQjcs3lUdtk0mgpJaPskbRgBNtHSWehaVrrBGdny4DXUqDZeu9Y8dRo?=
 =?iso-8859-1?Q?7kL4o72/cX2685epT4g3RAcOIdsbyhUn28O2llIKnh63a8G74DUfa0FGJd?=
 =?iso-8859-1?Q?AWyk4XLXZN/r3BYLBZrRVqXuKytaA80VQQ2PmOAR0eApsrZb8mjtfez5tA?=
 =?iso-8859-1?Q?wxdU1i437jcgpPzwpGc+2bYz4dA3LmPefYz7WrzJzvtGxgrAB+qBMXXo9c?=
 =?iso-8859-1?Q?kM1KenMtoU1zCKimkdvSJTRxhZgrrGrD8O6fZsm0WRa1YWhv/nk3EPg3Pl?=
 =?iso-8859-1?Q?ncgfaXj3G68pAzh0ROA+sAM8JS9qRgJ+KfT2eCtQwfaIrPulCD80QXkDpR?=
 =?iso-8859-1?Q?xtgNWx0UdrsGg263ac2ENVVlIOg0sVv/l7tKU105gdG5b63d4Rcpz+Lz4j?=
 =?iso-8859-1?Q?DklcighVsKzhZVk/Eg9CYf7nR6jeCWmsZUgjKjdjiUojJV0q/fpLcDRVZB?=
 =?iso-8859-1?Q?mSpGUiScSNBr6b858S9A+0sCztIKjaY4A1Q9Jsf6rMI9Wa4swveRonmiM9?=
 =?iso-8859-1?Q?h9IjvxMwxI6jvhZhp8saQOWAPAEatYNK4Krtw9yNP5bxhb17c1Z/xpoMjM?=
 =?iso-8859-1?Q?sP0I/7p412xPkyVyn2xbuDq3nbYHTXa9wEPwJ7kk5RMI4PJQ2niOpEr0ax?=
 =?iso-8859-1?Q?COEfROesmA3z5vif5c2iGI/14a9Viy2HnP4omPJTzA76gXjc2jlotbuCi/?=
 =?iso-8859-1?Q?V5GhgBJHImEeL5Rzi4UAsaq2Ft/yAiBzzq8+2RD5NkE5BDjNfz5g4W4wEf?=
 =?iso-8859-1?Q?c3BS4SD8O9jgnCR6Ly5N5+b/6rO5C87/GA1SBSKUsHL2nlyDOEH1/r85Jw?=
 =?iso-8859-1?Q?HgFyGsV0RI0VlrZ7FqS0UnqGEfrwl4JrGkebgLSzNhFR9kR3faoO6z5DTs?=
 =?iso-8859-1?Q?A1gPLsUR086nlp0LMTlqGkV+GU7/9UbLBcYgEiyoMTProdlNGrYbsXenAN?=
 =?iso-8859-1?Q?kE0Jl4VIcG2mPtr3ZcIeUnssXsfrU8aFyob2UI1KrCK2BtHsVq/sOajlAq?=
 =?iso-8859-1?Q?p4cuECAMnlyvik9bRYmTLORlxxAOFjqjBQsiOcMmJ7S/N6nJ5k1ylL9kZK?=
 =?iso-8859-1?Q?klx2s++N6s1wph8vN+TKceULS1e8B5MQQgD9Dzj+qlNktV2bDpVjM5D/8F?=
 =?iso-8859-1?Q?5DKBrOFK9xP6E7IfXDREu+3AI06Suev3AuP2XR+NcdFEcLUM6lJZLwGpHN?=
 =?iso-8859-1?Q?SOeCDmAo6bhrkkyR/SNortkGlTPX6I0TdBpP+JdqTDNyBID2K7wPJ2lk5X?=
 =?iso-8859-1?Q?BVSYnJvB+LDynfChUe4ZV67fJzN4vOo3kocqbXX64c43MlkcivhPPzGBJy?=
 =?iso-8859-1?Q?HPAmJS0ii0vDAc+kB6ci2z+UDnAGVCESqQKKMJ5pnRQpGn4WAf+vVA0Oep?=
 =?iso-8859-1?Q?Em1lP12Ttia/PpOQ0HCMSPsOMaXK7Hg1n8eGzZ0EdU2Hdw8rkhsafmD3YL?=
 =?iso-8859-1?Q?k/+8Es7LSMIImpgEtR8yZtFGuT3jEJ/J5Rs90z+2sLYD8ELJTKTCr7xWm9?=
 =?iso-8859-1?Q?Nm3qr9/sep3iGDG3Tl4JvWwLoscnci/R+/XPBj7JQ8hzNzSjjR+zbR+Vop?=
 =?iso-8859-1?Q?2lazAiwQseCznBTtMealdfZodae0icm9d2395aW6+VZkQSEAhyftmmeFX1?=
 =?iso-8859-1?Q?eK6Np1SeS9WAJwkTNCWse8lbySjSDkcESuw0zjNKFlnSQQZU/I9UCJtyi5?=
 =?iso-8859-1?Q?olTfsIDjGaYtcR6+8LmL6Wn2YMDQRDgRZxM+VWJbkz23cwdsd72Z1oXX+g?=
 =?iso-8859-1?Q?JFvmcoyb3c+qjfzo9SdN4Gq+Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceb08ba-8915-4045-f0d7-08d9f24a8486
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 19:20:11.3792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLYA4D+NzD8KlumGhcFSYTMLnD66OCfl6xGzYoDxlnM5SKcjkZeDLm/LyLqpn/8EG6Y8Pn1Y+mMBQb6XpzkJ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2931
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

I can do IP name substitutions but that's kinda not the point.  We put head=
ers called "vcn_x_y_z*.h" in the source tree but call the IP block UVD.

As for SDMA ... the IP discovery has entries for SDMA0 and SDMA1 IP blocks =
on my navi10...

[root@fedora umr]# cat /sys/class/drm/card0/device/ip_discovery/die/0/SDMA0=
/0/major
5
[root@fedora umr]# cat /sys/class/drm/card0/device/ip_discovery/die/0/SDMA1=
/0/major
5

If they're "behind the GC block" then there really isn't an SDMA block righ=
t?

Right now umr just ignores anything it can't pair up but I imagine it'll ca=
use some confusion later on.

Tom

________________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, February 17, 2022 13:32
To: StDenis, Tom
Cc: Tuikov, Luben; amd-gfx@lists.freedesktop.org; Deucher, Alexander
Subject: Re: [PATCH] drm/amdgpu: Dynamically initialize IP instance attribu=
tes

On Thu, Feb 17, 2022 at 1:25 PM StDenis, Tom <Tom.StDenis@amd.com> wrote:
>
> [AMD Official Use Only]
>
> This works, now I'm facing other issues.  Like we call the VCN block on n=
avi10 a "uvd 2.0.0".  Originally I was only accepting exact major hits whic=
h meant my navi10 model had no video enc/dec block once I programmed it to =
take the closest match it hit UVD 4.0.0 (pre-soc15/etc) and that's obviousl=
y wrong.
>  Shouldn't IP discovered video enc/dec be name VCN?

They used the UVD name since VCN was derived from UVD.  Not sure why
they didn't rename it.  Still, all asics that use IP discovery use
VCN, so no need to worry about UVD/VCE for IP discovery.

>
> On a semi related note we have no SDMA v5.x.y headers in the tree but nav=
i10+ uses it.  I guess the driver just uses SDMA 4.x.y headers because they=
're close enough but it means umr won't load in an SDMA model.
>

For navi10+, SDMA moved into the graphics block so the SDMA registers
are part of the GC headers on navi1x and newer.

> Which then gets us into weird conditions.  Right now I'm programming umr =
to find the closet abs() major hit, then minor, then revision.  But I imagi=
ne we'll hit cases where say version X.Y+1.Z is better than X.Y-1.Z and vic=
e versa (etc with the other fields).   There's no way for umr to know if a =
newer or older header is better.
>
> Tom
>
> ________________________________________
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Thursday, February 17, 2022 11:35
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben; Deucher, Alexander; StDenis, Tom
> Subject: [PATCH] drm/amdgpu: Dynamically initialize IP instance attribute=
s
>
> Dynamically initialize IP instance attributes. This eliminates bugs
> stemming from adding new attributes to an IP instance.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Reported-by: Tom StDenis <tom.stdenis@amd.com>
> Fixes: c10b6aa7417b0a ("drm/amdgpu: Add "harvest" to IP discovery sysfs")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 6c7ec058125e1d..5848fec5c39251 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -482,16 +482,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] =3D {
>         __ATTR_RO(base_addr),
>  };
>
> -static struct attribute *ip_hw_instance_attrs[] =3D {
> -       &ip_hw_attr[0].attr,
> -       &ip_hw_attr[1].attr,
> -       &ip_hw_attr[2].attr,
> -       &ip_hw_attr[3].attr,
> -       &ip_hw_attr[4].attr,
> -       &ip_hw_attr[5].attr,
> -       &ip_hw_attr[6].attr,
> -       NULL,
> -};
> +static struct attribute *ip_hw_instance_attrs[ARRAY_SIZE(ip_hw_attr) + 1=
];
>  ATTRIBUTE_GROUPS(ip_hw_instance);
>
>  #define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj=
)
> @@ -789,7 +780,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdg=
pu_device *adev)
>  static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>  {
>         struct kset *die_kset;
> -       int res;
> +       int res, ii;
>
>         adev->ip_top =3D kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
>         if (!adev->ip_top)
> @@ -814,6 +805,10 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu=
_device *adev)
>                 goto Err;
>         }
>
> +       for (ii =3D 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
> +               ip_hw_instance_attrs[ii] =3D &ip_hw_attr[ii].attr;
> +       ip_hw_instance_attrs[ii] =3D NULL;
> +
>         res =3D amdgpu_discovery_sysfs_recurse(adev);
>
>         return res;
>
> base-commit: f736148ca7bf82654141a4411409c2d7a9e2269b
> --
> 2.35.1.129.gb80121027d
>
