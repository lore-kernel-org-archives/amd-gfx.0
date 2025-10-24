Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2017CCCF9E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 15:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC21C10E20E;
	Fri, 24 Oct 2025 15:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UA7snkfk";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F1510E20E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 15:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buFfFOJhKkaTLRE86xPGkqIAo2KAzxrYrsw2roPxRZoRbmuM7k7inaibyQflSJodlsS8+68/YdyJxAE8x5P93iP9IVDaPnM+6lhlJFvNuBH0Bj9vfszdUOKorOwiZ+JZd03/41kIZW2QqLeHXZvZSRrz0+Z/9kOWXRfQeaQ6142E/Ym9EWmnpMF7oYomEQV/h5XTIF9IlJJ81qOPryL0mCzxSE85s9DGH/MBywd95yEIxJEnV7GJek/YM2RoSUK493lmzLo2PS6IO/7ItML7XGbRlUYc5DS8ZBoHd2kBS2H5sv0/ANRK2zEiWDdsVPqTHcJuUhGVP+zB2k/U9+GOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs1Uo1juNCxkaQekVGyYDxozOkvUFgn5+TfnCKOlqnc=;
 b=UKUuO1aN8KoC4FjXorfNsZ8DC6gIETrw0Hz+FtNVPg4SxuehgRN972cC7diW2952rB4iAt5B3o8oxYgRaydv0BPlZBysCvIGRZ0cyT3Se+39NQFIO5RgfPE4oO6XLH4yPHBJ1dBhhapqA5QFu+o6ss2hGDM3gs4VHiEKmyoLTm51R3sCt0jtl4o4eoOr9NaXq1IRxsaEvgS+J5YAdw9bj799YyoN5O2PGfXZA9Z+CB4VOoXuE2iePNQQJg1ZbCgHuDDYP2mNtBPOIBk/ZvxC2TolaRsOLbqZrRGhZOxFJURfkLz/ZTwnDggC2WT5qXcU30EZW88IvOBJJXbyB++x0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs1Uo1juNCxkaQekVGyYDxozOkvUFgn5+TfnCKOlqnc=;
 b=UA7snkfkMSQ1MeKOsbGaQEzZotsVVSYoaXdNCHNWE/zS7oVBmEOMCAeSDep3oHTZVj1rJ60btJmRDMS9O5AAGHfmtnPjEZzfPy8WQl3cXAdoIAggVHtSU2jfnJqfKzov1f57PaSvVccZSb2O1d8QU68HjZgSSxkq2/9e9otAmqo=
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by SA1PR12MB7104.namprd12.prod.outlook.com
 (2603:10b6:806:29e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 15:54:23 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::1492:d9e8:b79e:250c]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::1492:d9e8:b79e:250c%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:54:22 +0000
From: "Clement, Sunday" <Sunday.Clement@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix nullpointer dereference
Thread-Topic: [PATCH] drm/amdkfd: Fix nullpointer dereference
Thread-Index: AQHcP3LvtTOV0n6l0kCTfgx7XXoHorTGq48AgArL0aA=
Date: Fri, 24 Oct 2025 15:54:22 +0000
Message-ID: <SA5PPF8ECEC29A97EE8691605DB2ADAAB4A9FF1A@SA5PPF8ECEC29A9.namprd12.prod.outlook.com>
References: <20251017143239.1483587-1-Sunday.Clement@amd.com>
 <CY8PR12MB7435B8B4D3B7F5A11E80600785F6A@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435B8B4D3B7F5A11E80600785F6A@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-17T18:27:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PPF8ECEC29A9:EE_|SA1PR12MB7104:EE_
x-ms-office365-filtering-correlation-id: d25bffeb-6247-4688-9b20-08de131599cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VNYPdFS9ZhrvJU/8Vg2v4AQHfWhJoiqQdGbgIJ26OgXHh9UK11IxASdjDIMV?=
 =?us-ascii?Q?I00WUDxXJ8twT32VC+M6aTYC8QnL0PjV5rj2jEcoAx7AFS6LjWmpxnqig++i?=
 =?us-ascii?Q?pW2X0lN7lQTr4toaNu58UUtA6bSo1dIABNa6y1J8qEzaofaaNYqYx0/j6Yiv?=
 =?us-ascii?Q?zPJ2t7WVVfmtFkQeIOyeQSuJ0F4t/IrFsM9NTzWLaS3oBvXMR3zjZBo9MPxz?=
 =?us-ascii?Q?HB3Vyoj28NLZBuxfC3HztPKa5g3ON+sLWzd89/CsQ903pmA+/u3EGuNnfT9w?=
 =?us-ascii?Q?Pvx59MsW0In92Ci0bgyQU6Uo9IuCx2Z9MU5qMKLDhbHO3E/XUOhkIMO3eJvt?=
 =?us-ascii?Q?UqkIjQEFLFkrR0mJHvjyRkVZENaRTb2BFxRL/TyZSH102Uv812CapVrZffOj?=
 =?us-ascii?Q?RqACsUoHv2Nr9HW9aem5UIKXXiIcLSOOqPtW6OqAUmrA3lq0vN/Mz8X4cziX?=
 =?us-ascii?Q?JGqZmO6Damhxft3qy8V75N75nS27n7eFdmXUqVd2hlPecnYbX1NQKA7luX5M?=
 =?us-ascii?Q?axBkBwyXRvwD7KXlzybqr7/JrX6rhFnsKaLCt4/rdVhWcyuvdDvMlqiouxYW?=
 =?us-ascii?Q?oAOCuxF5zQ7Fayxu6fOLnHHiFya3Mrs+gkgfx89Cl0FORRvX96Q7QMiFB1I9?=
 =?us-ascii?Q?KQu27Dg/UbgptEbUpFOx7Hft5TV23+SqQMZU8O+uunco5mod64YYHb8Nmcld?=
 =?us-ascii?Q?FNysZPZAtZXL/7K9M3XZWDJnwTt/loHxjK8h3UHkwcS/2hQ0h34C4XEALpm9?=
 =?us-ascii?Q?6PT1x1pyg9foL0namSuTWYoOEPpsC/KTcmS02qUifguHFiXeVcCeRFFnWYgT?=
 =?us-ascii?Q?/aNFyDWIdrZCnI2LePeHBENWFHTKfZ2S03dIy8kWyIQisJEAEJZonnAcZHxT?=
 =?us-ascii?Q?S6knzabvxBHmkl2zVIXg0oWZT/o+oec6pvXXht2m70J/ZQ3UOsDP4rr7PP1P?=
 =?us-ascii?Q?+FsrVaHiUvdT8S9nLsenfZrPEoa4Tsqcbxq3iD8xuLiEBmcPNkKNb2CfZnMa?=
 =?us-ascii?Q?50FlF6YGMLS3yc061tbtp2CK4VFDQT2omVyoJo1SPwHqXwNKNbI+JDH42US4?=
 =?us-ascii?Q?Jy2/RgLwf6MD+DfEPmd2DtfAWp04jE+rnY30G7QQ4/ndW6iZk05eBQ8vUM6y?=
 =?us-ascii?Q?r/q9tqBMzgILysynzwr0FkiOp1GV0HpKc4LxyN1hWbgK4QMRzLyO6UOofXpY?=
 =?us-ascii?Q?GaU9kJqJ0dHVa9VJlw9FpIXjJBPJoPWZdqTNutvMJJ3Aw2quT4aKsXW1ZIYJ?=
 =?us-ascii?Q?1Z3ZGToQHhW3ByZEV/ax78RHGZdquKAcXEacC8B3LplPR6oA1AxZcRg/PE1r?=
 =?us-ascii?Q?ac9D/IK3bIIkYNATiskLyZAbda83pE/xffEbjewKhceswWa+LXIEoO0GLMp5?=
 =?us-ascii?Q?/nz//OmwywqIS0LlwgOjh/E6JhagPbRFtCCUdrErXXD7iMlyefpdeZCyj/d6?=
 =?us-ascii?Q?7bKKEV0Z+w6uuQ1aXLOlXf8XHW8pMowX4IFUr3YOOdq+KqC0Sv53d/HkTLZW?=
 =?us-ascii?Q?54OobQp0XWFJxvTq8wt3Np7+OrCQJCf8RaaK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BCPm8bo3zCMlFXjoSFYMtllTAHmx2iFyGBLg3Nuo32avu7dTO+ozO+2LN8y4?=
 =?us-ascii?Q?0T9Ld44vCXti0egQ56q4m4KIhaHbiEJHKMwH2Wgyj5N6Znh3qNArIaOS0bdU?=
 =?us-ascii?Q?grbzM9vjDb0yRT1itaCiHVmt/pYNvZZzuJVeGzxUWWD39czDf6GB+nlWAe+F?=
 =?us-ascii?Q?hL89Ni2zxVKSwxOpVqXkC6mtqI7cgXTSiDLCdRiQOHNsXp4XrX0okkxEMRsB?=
 =?us-ascii?Q?soSWREUWKzmrXuH5tXNqucMmeynNgw2f3eGzTSPih5fc4I3UthKLnynVEom5?=
 =?us-ascii?Q?7Km0khCCxIJF0SaSoXzvQIkrrcD/D6MaSoKQJqm9xWkJzUg00qYRhWOFB/sn?=
 =?us-ascii?Q?dve7CR2LwtwtqIGSc4fe19zeEnqGp3HQZP7yAWBtn/A+PfAkeR5L739WzqiY?=
 =?us-ascii?Q?6AasDvn9C5pC11cVhafQUr/mcCvHpKH5LUAQSolVzX7JuIuYCHzV/25LoDTz?=
 =?us-ascii?Q?yQazHWNWI8saqUbhc7t+1VhHjYdx5lKVN9VGIMIhVlwic79XavJkJsI/r8nP?=
 =?us-ascii?Q?q+lXXtFlBVPm8MPppZdZRwG2k9WcaU3qxbeBy71i/Hri7AxDaTOV9tfYEF6G?=
 =?us-ascii?Q?+SshjfeQuJxE4fffa7uzMovKvmwS5klVirrvIGySAtVgVTjmwQdm4Cc6fGvk?=
 =?us-ascii?Q?i4MtFQYEDHJUqI26PYdqJ7NGGgzw/MaNv7i69x3WhRNc1TyO6ZO9Jh56D2FA?=
 =?us-ascii?Q?/WVN3Bi3ZdQNqetEXe7PuBxMl4S6lSwWsAs7NVbQ9ynYnmISLFm3ekhh+NvH?=
 =?us-ascii?Q?WPpaZoonIzgqHhrz7i3BAwCDgrAwy4jSlwRUIJLXbBfWuXpaoMFtXAAhIVUR?=
 =?us-ascii?Q?v+LQjulM8+qlo3+z31Eph39KE5lV0CqO4Lm7voxfEOGkNSXr0ZrFY2K5H1Am?=
 =?us-ascii?Q?BCk95BM4xCAR18loV3d4HRb778DpdNoQPQSdcFRm3ZRFbeYl8RmOxKMndRNn?=
 =?us-ascii?Q?isWClydzThAQHmcmoI/5yFoFu4uxylaX4LCBUh04zdBlpjl6C7e9kEDDNzi8?=
 =?us-ascii?Q?9C/XXvu3rg0ARWIbNaTUB9rG1KQ0F24nD9p8+ekSFPO3iPs0wfnAzKR0OOpQ?=
 =?us-ascii?Q?PRlNukfjxHiBtcwjPVwqxsmHTx1vOHbhx/yI+2kM19XPhvQt/ZyEO+dDVfT6?=
 =?us-ascii?Q?6stQ//9tvQJ6VFkvDTyqBtePA3Wv/jWnKsgGLxIFsm2UHX5jvlo6ukYxj6Ll?=
 =?us-ascii?Q?G06mgdMuo/LhuJToQisnbe5QNpiMnVEolWyhm003r0JlkJ1J/a0+7rYiZOuG?=
 =?us-ascii?Q?3tPe99/Q+jjiivPsS/DG3/9UcWd/zJFpoYLA8N7uG8ZlrRE4t2MeZMw1VA0Y?=
 =?us-ascii?Q?saMihv+IGmYFCM9pTDMEQ6hASHxVOuWyjBC+RCbyYpPGAJS5NhWlwJENIfD6?=
 =?us-ascii?Q?l6ALn8DrvQSwIyTS7uttCZOX/xnVBV9sapdVyqOa4pi5yg7HprJ/VDCyo3X+?=
 =?us-ascii?Q?zX231+BI6wvmUOiBnhttZ1XrK/kcn37ZWffGyTMb3rywmitvInZnJ+yy7x2Q?=
 =?us-ascii?Q?W97BMnPXQtx5SaSg5urg68imdw633UCc/kzlvtdonR4GfHayHN7UjQ0z8aUC?=
 =?us-ascii?Q?1N0Eyap9hxSJPYGFJ+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25bffeb-6247-4688-9b20-08de131599cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 15:54:22.8085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oayvepBhikXG07QxWMIOSHxWvC0fl10mI5OjVvnjihVs6V5R/NwgNsBwMYxLspDu3pq8YscPNPDeSgaK65E2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, October 17, 2025 2:38 PM
> To: Clement, Sunday <Sunday.Clement@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kuehling,
> Felix <Felix.Kuehling@amd.com>; Clement, Sunday
> <Sunday.Clement@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Fix nullpointer dereference
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Sunday Clement
> > Sent: Friday, October 17, 2025 10:33 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>;
> > Kuehling, Felix <Felix.Kuehling@amd.com>; Clement, Sunday
> > <Sunday.Clement@amd.com>
> > Subject: [PATCH] drm/amdkfd: Fix nullpointer dereference
> >
> > In the event no device is found with the given proximity domain and
> > kfd_topology_device_by_proximity_domain_no_lock() returns a null
> > device immediately checking !peer_Dev->gpu will result in a null
> > pointer dereference.
> >
> > Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 4a7180b46b71..6093d96c5892 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -2357,7 +2357,7 @@ static int kfd_create_vcrat_image_gpu(void
> > *pcrat_image,
> >       if (kdev->kfd->hive_id) {
> >               for (nid =3D 0; nid < proximity_domain; ++nid) {
> >                       peer_dev =3D
> > kfd_topology_device_by_proximity_domain_no_lock(nid);
> > -                     if (!peer_dev->gpu)
> > +                     if (!peer_dev || !peer_dev->gpu)
>
> Is this a real failure?
> If so, we should figure out why our assumption that proximity domain ids =
as a
> counter for valid devices should work but actually don't.
> Either way, probably better to throw an error (something like -ENODEV) ra=
ther
> than continue since IO link data has now been assigned garbage and we
> probably don't want to keep building the hive at this point.
>
> Jon

I think this failure is not real or at least could only really happen in a =
contrived situation, like a race condition of a GPU being Hot unplugged(I d=
on't think this is even supported) so the topology dynamically changing whi=
le the vcrat for another GPU is being created and that messing up finding a=
 device by proximity domain if the device was removed, probably not exactly=
 a realistic scenario. But like you said instead of silently continuing I c=
ould do something like the following and return -ENODEV,
                if(!peer_dev) {
                        return -ENODEV;
                }
Thanks,
Sunday

>
> >                               continue;
> >                       if (peer_dev->gpu->kfd->hive_id !=3D kdev->kfd->h=
ive_id)
> >                               continue;
> > --
> > 2.43.0
>

