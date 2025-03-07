Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E318C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 08:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7A110EB0B;
	Fri,  7 Mar 2025 08:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="krOMLMq1";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA77A10EB10
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 08:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp3erJuWrSXgLMtZ2y+WyXhlMERshQBJRk2aTA+8D4kFELW/ctrDccHJHwyWzSXludYYZhqAHJv8ooGfSiQBgTNrgo5HIey+P+SwgHKFi8jurGYbJ0TeICNbZvaDJdm7rywzpAuMXYCx4RC7YkexqsxqkAdHpJyuFQxcNASLBiYn4a+fBA+GxL+S7rTEBy2d01kdtyf0ZGkX2YibLoTB2qIGvNLb/pNiXv9UHvth6y5F5aDHOx4MXw638+Dh8TP0sTK7JYzaPSqf1uzS7fqfyNujnrS5QiaGefV2Pi7pZ1wBSElICaHngWsdhGHbYGPgQ7K4+t+/x8b/Hsf2MLnqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/eAfAEtYkVQxS/AkTCklKEQnNxbjH7HcVv+fQVeds4=;
 b=GrplbeaI/O2noRLMHlnK43Ko/guIr4zuZYZ2Mhaa3/FE0lJ2L7N0ssfukt3Qfo2onN7VfFkiJCY2JoExkpmPDxR0OnBjuqEzZkKDjfUhghgj0zqm1WRuxtU+4TXx0yKnOimP7zuyWZYz96Yw7oWFbNB/NYDUxCyORSK0+i7h1Pg4L/PhGZhmSCb84ExU6xyECH4jZO9AZmYxs8Owxcn0DLiebhIrKf/kTdoCpPMdJa3ng6UrLXrykWQFmrC9TxWu7t5NvPEnRcMg73R7qkLP3mynNbxX+JWGbHV7hJWoN9iABsirxSTFKDcuS4t7yDDGnEzAdXEaxpgUaxLsdIRC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/eAfAEtYkVQxS/AkTCklKEQnNxbjH7HcVv+fQVeds4=;
 b=krOMLMq1bvD06g9++XiUpt61lygZHIl/SESjTh+zHOJB4OVhwaihhZPdLGG58EeqZO8k/Pmu4FqKLvej217r2v2NPU2W6GxTLb2ZkAxQvJH8z9CrlevURQ54jbo4kc0JzE2sKxgFOcYQ/8cZiO1kkBiIp2ypPccvRlLBp4xyuCQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 08:40:51 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8511.023; Fri, 7 Mar 2025
 08:40:51 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Thread-Topic: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Thread-Index: AQHbjyy28hogP7xqrUaqoBArYwJaeLNnSNqAgAAKolA=
Date: Fri, 7 Mar 2025 08:40:50 +0000
Message-ID: <PH7PR12MB87963B4294E9CC47449C3614B0D52@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250307064639.273141-1-tao.zhou1@amd.com>
 <PH7PR12MB7988E52CFA8019C506A46AA59AD52@PH7PR12MB7988.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB7988E52CFA8019C506A46AA59AD52@PH7PR12MB7988.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bb6828aa-0ca0-4f27-be9e-8b942e310789;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-07T07:32:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB6682:EE_
x-ms-office365-filtering-correlation-id: 47ef9ee6-c700-40f8-e94c-08dd5d53c40e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RT/fpKfStcqw0+6x4G2svy4HHVYprc5GzxaSDmfaAcuLNEHD1CWFMboVElZ0?=
 =?us-ascii?Q?LXoXMD2hXTNJXrcsEm92A8ILrhoWT9LMiiyt1CpA6eOf5mzuyQHNG1UyDJ7Z?=
 =?us-ascii?Q?ktOFdbuGKT3EtPf3DGzHtl8V/JFdobCSnxgHFoHk/KcS043bFxSAXHFQvGK5?=
 =?us-ascii?Q?FUUb6K4JT6vOVUfgUaV0u1Z3TDJ930+5y/Y89GRcMthMArSljwD4ew+jsI7K?=
 =?us-ascii?Q?n4+BG4jp/gG9YW6KOAC0wHRTYp8zTDg5Nbbj7gq+S3NVa7nHzLsPu/vOGA4q?=
 =?us-ascii?Q?UuuYxda5lYN7HzKtQgT2TnmDhM/YoFCBVACYrzpr5xT7aUbGH3QqiZ81f5Qb?=
 =?us-ascii?Q?YTkpF81mwyWe9iKLtoaPjIPJVM/AF6/ov1R83CfiggQqStwQrq9tagc4AHWi?=
 =?us-ascii?Q?Q8hI5LoeGlJasyzWEUsFdbYR5A4fkfl2k1UuxON3cDc5MMgYD94iAWP/iQ8P?=
 =?us-ascii?Q?BWE0uYSyZvoj3jDXE444fq01w0AQ3bjt+H9kJh8rrZzUn5ovDTtHG7opsfKx?=
 =?us-ascii?Q?GcZKJ9fm+cK4Z9hSpwiIfpJb9Lht9kqme7wjpS4KDIHtYEegh94HnI2NnQHq?=
 =?us-ascii?Q?2MWCj/mosDd1bs/cO/RVWKZSKyovITVe+Aqg8JfzIiUwRw+vkmYjqEmypo+Q?=
 =?us-ascii?Q?sMKw980w19h0r0HkYBsAVUkYtbSM2AaQq52QoviRkRJyzVH21zggsqcW1wdv?=
 =?us-ascii?Q?31Tq+hLNwkp1EAcYolFrVSgewX0CruJjtpdk1CS6wfJTwf50kfsXI4s6mPVu?=
 =?us-ascii?Q?WTRThcEg2+ZqJMh0y2WuHYSjTS1QCvsXSUnwh2QBcpKs5JX2Arln5eMa1BeN?=
 =?us-ascii?Q?nJuzef6b73GuJLKhZfFEdulK+LcS97Jti2B785N4PyKrS7xBug8G/RdoZENy?=
 =?us-ascii?Q?9tfqAhhewwiw3qpz+FO8XVtOcmM17RTb6YUCREq/YNCstRNnZhVU2T9YMYha?=
 =?us-ascii?Q?MT4SswrbJvx4OQKLlY7Oz4VdwS7I7+721/MAUzwcV2GBhB3Qs1oY2HsbTgeg?=
 =?us-ascii?Q?gpdjdOg37Lk5nJhSlDfoUAUDQXvF2s3FhzeYNz45EsJc1Xkfg4TrQ3wrbcaF?=
 =?us-ascii?Q?1QPIUJbqNPQTvGp+hF/5pg0AhSg85vMGOENmd/2kN4ODaTPLl2Q42a+R8KRj?=
 =?us-ascii?Q?UlLC90q91M/EE9uNBD5jYQ8aj6N4vwWayaBUBYvmONUHYljk91hyYk8pde2s?=
 =?us-ascii?Q?jr4Z4Ee3p1HuMsjrSSXbPWQA3sApZF6hyzkMf83msBglAuD8FIYoB7f6mRtv?=
 =?us-ascii?Q?smDlWTmgc73YurJzlbf6o/ooZAxTbVYNcMLFW1yV/zKxFWGFxJX5j1tCGWpn?=
 =?us-ascii?Q?q4hjnu9xd0m9ElRloMu7VFD/qrWHj4zMKzDnCQ/Ik1YRSeSIkBcRvGsWJW73?=
 =?us-ascii?Q?rS5WrYbsBeMymkEk/rQAgwJhhx/i3yymUvyfLGtLs1tUyi8wDI1RlnOO1KIS?=
 =?us-ascii?Q?jS+2QUaK2n6NqFpBYuMLpce2FGjJHvFS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d4W4EJmBlxGUJxzhmMNR+kb7jMp6uCroAL/qYlxrQkP96qDW9dr5e9pULh2a?=
 =?us-ascii?Q?pOczF35Wcv1y/whj6+Tvh3A3cl1getW25+n6zQT8fKRWz+mVxdGe1Zg9v9AV?=
 =?us-ascii?Q?u2KNeCL2tuz5DNJcXD1TEFy+M26zYQip31R18vzEbnVmCQC+Abza8EDCu/qu?=
 =?us-ascii?Q?Bga9adigP/bTw/2RJBOC8+4UdZnwad6eBpBEDTumB51hhmBgHzam4osD1Kwu?=
 =?us-ascii?Q?8e2QBrLy4PKyFZ+Y1y8hMp3YiY2EjRPls2Rvu7kjfVtJAXGB4O93aN2rjQQb?=
 =?us-ascii?Q?FS6drx1qzyBm4q17N6VpLdV2t+Xy3U7iJQP4IZBlbUCtNGG1FuJ8V2eCG8fe?=
 =?us-ascii?Q?9odpzxhXPb00vHq3JCI/v8o7Ck/iffcUGwhLePDKAcqrv2KQZsZWeuK8bUAw?=
 =?us-ascii?Q?F9nnljbrsmfmJUbnsmddTDzAWse50w3FviRJxpo7yrKoIKz8RgI5971+Wvz5?=
 =?us-ascii?Q?mqBISVUY1IdlyYrnXEQd1Dg7XNkAekU3zjldMrx4qIhB6fgmXs1TFQMS1kPf?=
 =?us-ascii?Q?20VBjP1mdzZ3fDNz+CIU+Bo9cqWCfCJ3KtYvleL34yKmSAlk5MbXE6F9PlTd?=
 =?us-ascii?Q?u9q6HbvWJazjr9vvJzG06CJc+RoNPPMMmADSOJpI85mggfjwSOeA5QABVo5n?=
 =?us-ascii?Q?SmHqncjLed7n9KGe7oWIcqtAkZ3kNLYwOgK5hXi/xLWCD5Uq1DYODAo1SUVL?=
 =?us-ascii?Q?M8/J/N7jhZ8zHoecDzJekr784A/vmOKr9+uKw486cYZenH8ShXlY7UyRIeDh?=
 =?us-ascii?Q?Lkt1ej8v54x/VTeKkbGED2iEAqTbXXPtOyCpBUkZx1lpOQFd2/u0GR6PS5DK?=
 =?us-ascii?Q?C2ojbOIdqbM9hGP5Zaa+C58L/q3guQahXd1qqVUvC6D1ZVGRtLZqyZEoQZvi?=
 =?us-ascii?Q?l2CBdS4G7n6W/oD7S9XVle0vBtSj6HMT6DbwoZxs7JAvxOxyFdFHYQ8xPJYn?=
 =?us-ascii?Q?TTcy4rsB9cGoE2gSpk5b8spUKnoHPucaS8Kv6vhXZR0lif9s/YhWF2yA1c7o?=
 =?us-ascii?Q?rz9dxHuBXJM35lr43QgIx4YWbd3OFF8s8ezmcri8oCi+Rz1Bbc8LVIqo1a5e?=
 =?us-ascii?Q?koeuxNbA0DmRtHiNtqGo38OmFZ8KpuA3vdAnyqPgoNT76+Mrq5ckvxsLYGVc?=
 =?us-ascii?Q?nSYdXMhcocQT9kTizqCodYCERyOAX+kLTO+23ZU5F9UpKf0DVD2zoUk14peA?=
 =?us-ascii?Q?weUJll3CdveilsV1by2ljvo9rsM8PdNsfwjLsafmjZzD2Jbp+VV5yO2wq0nE?=
 =?us-ascii?Q?SCQK4KAKG65reHu+jCgtmzNKiZC+pniGGcwzgGSYwqyrBj4S9aSHLzpTxJlv?=
 =?us-ascii?Q?Jqph4kNn93ks4O5p9Mkwuj2MSNwpi1LiS+5J2U4j7EL5ynJGF7QCeqAQgJ6N?=
 =?us-ascii?Q?R+5kMcF5AMe+4TsS9bR4eTN2g3ale6MhbP68q+Z+TC/fBII7f4tBDfgvG445?=
 =?us-ascii?Q?hvyQrC95L9ySVDQsr3uiYCrqEF8iWGqnG76VkYBHRtQakPNdIfP9hMC59Ddi?=
 =?us-ascii?Q?Zi7iwbJVKhl8LWwuiDnMpqcZ0Df+HLy/d49qWfQ7wceQtHF/QsvDMPFPDiii?=
 =?us-ascii?Q?Hoi9NlKAFs/GNEu92BU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ef9ee6-c700-40f8-e94c-08dd5d53c40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 08:40:50.9140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZ31N5UlLGUy4qnn5NhtfACCyMCD3s/oAOV/qtX/Fr+ve1kukud/omrbYoy30n6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
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
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Friday, March 7, 2025 3:36 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 versi=
on
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> > Zhou
> > Sent: Friday, March 7, 2025 2:47 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
> > version
> >
> > Clear old data and save it in V3 format.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 ++++
> >  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++++---------
> >  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  1 +
> >  3 files changed, 20 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 837f33698b38..266f24002e07 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -3465,6 +3465,11 @@ int amdgpu_ras_init_badpage_info(struct
> > amdgpu_device *adev)
> >                               adev, control->bad_channel_bitmap);
> >                       con->update_channel_flag =3D false;
> >               }
> > +
> > +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3)
>
> [Stanley]: should check ip_version here, this affect all asics that eppro=
m table version
> is low  then V3.

[Tao] how about "if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)" ?

>
> Regards
> Stanley
> > +                     if (!amdgpu_ras_eeprom_reset_table(control))
> > +                             if (amdgpu_ras_save_bad_pages(adev, NULL)=
)
> > +                                     dev_warn(adev->dev, "Failed to
> > + save
> > EEPROM data in V3 format!\n");
> >       }
> >
> >       return ret;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > index 09a6f8bc1a5a..71dddb8983ee 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > @@ -413,9 +413,11 @@ static void
> > amdgpu_ras_set_eeprom_table_version(struct
> > amdgpu_ras_eeprom_control
> >
> >       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
> >       case IP_VERSION(8, 10, 0):
> > -     case IP_VERSION(12, 0, 0):
> >               hdr->version =3D RAS_TABLE_VER_V2_1;
> >               return;
> > +     case IP_VERSION(12, 0, 0):
> > +             hdr->version =3D RAS_TABLE_VER_V3;
> > +             return;
> >       default:
> >               hdr->version =3D RAS_TABLE_VER_V1;
> >               return;
> > @@ -443,7 +445,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> > amdgpu_ras_eeprom_control *control)
> >       hdr->header =3D RAS_TABLE_HDR_VAL;
> >       amdgpu_ras_set_eeprom_table_version(control);
> >
> > -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> > +     if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> >               hdr->first_rec_offset =3D RAS_RECORD_START_V2_1;
> >               hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE +
> >                               RAS_TABLE_V2_1_INFO_SIZE; @@ -461,7
> > +463,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> > amdgpu_ras_eeprom_control *control)
> >       }
> >
> >       csum =3D __calc_hdr_byte_sum(control);
> > -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1)
> > +     if (hdr->version >=3D RAS_TABLE_VER_V2_1)
> >               csum +=3D __calc_ras_info_byte_sum(control);
> >       csum =3D -csum;
> >       hdr->checksum =3D csum;
> > @@ -752,7 +754,7 @@ amdgpu_ras_eeprom_update_header(struct
> > amdgpu_ras_eeprom_control *control)
> >                       "Saved bad pages %d reaches threshold value %d\n"=
,
> >                       control->ras_num_bad_pages, ras-
> > >bad_page_cnt_threshold);
> >               control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
> > -             if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1) {
> > +             if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
> >                       control->tbl_rai.rma_status =3D
> > GPU_RETIRED__ECC_REACH_THRESHOLD;
> >                       control->tbl_rai.health_percent =3D 0;
> >               }
> > @@ -765,7 +767,7 @@ amdgpu_ras_eeprom_update_header(struct
> > amdgpu_ras_eeprom_control *control)
> >               amdgpu_dpm_send_rma_reason(adev);
> >       }
> >
> > -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> > +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
> >               control->tbl_hdr.tbl_size =3D RAS_TABLE_HEADER_SIZE +
> >                                           RAS_TABLE_V2_1_INFO_SIZE +
> >                                           control->ras_num_recs *
> > RAS_TABLE_RECORD_SIZE; @@ -805,7 +807,7 @@
> > amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control
> *control)
> >        * now calculate gpu health percent
> >        */
> >       if (amdgpu_bad_page_threshold !=3D 0 &&
> > -         control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
> > +         control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1 &&
> >           control->ras_num_bad_pages <=3D ras->bad_page_cnt_threshold)
> >               control->tbl_rai.health_percent =3D ((ras->bad_page_cnt_t=
hreshold -
> >
> > control->ras_num_bad_pages) * 100) / @@ -818,7 +820,7 @@
> > amdgpu_ras_eeprom_update_header(struct
> > amdgpu_ras_eeprom_control *control)
> >               csum +=3D *pp;
> >
> >       csum +=3D __calc_hdr_byte_sum(control);
> > -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> > +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
> >               csum +=3D __calc_ras_info_byte_sum(control);
> >       /* avoid sign extension when assigning to "checksum" */
> >       csum =3D -csum;
> > @@ -1035,7 +1037,7 @@ uint32_t
> > amdgpu_ras_eeprom_max_record_count(struct
> > amdgpu_ras_eeprom_control *co
> >       /* get available eeprom table version first before eeprom table i=
nit */
> >       amdgpu_ras_set_eeprom_table_version(control);
> >
> > -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> > +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
> >               return RAS_MAX_RECORD_COUNT_V2_1;
> >       else
> >               return RAS_MAX_RECORD_COUNT; @@ -1280,7 +1282,7 @@
> > static int __verify_ras_table_checksum(struct
> > amdgpu_ras_eeprom_control *control
> >       int buf_size, res;
> >       u8  csum, *buf, *pp;
> >
> > -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> > +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
> >               buf_size =3D RAS_TABLE_HEADER_SIZE +
> >                          RAS_TABLE_V2_1_INFO_SIZE +
> >                          control->ras_num_recs *
> > RAS_TABLE_RECORD_SIZE; @@ -1383,7 +1385,7 @@ int
> > amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
> >
> >       __decode_table_header_from_buf(hdr, buf);
> >
> > -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> > +     if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> >               control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
> >               control->ras_record_offset =3D RAS_RECORD_START_V2_1;
> >               control->ras_max_record_count =3D
> > RAS_MAX_RECORD_COUNT_V2_1; @@ -1423,7 +1425,7 @@ int
> > amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
> >               DRM_DEBUG_DRIVER("Found existing EEPROM table with %d
> > records",
> >                                control->ras_num_bad_pages);
> >
> > -             if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> > +             if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> >                       res =3D __read_table_ras_info(control);
> >                       if (res)
> >                               return res; @@ -1443,7 +1445,7 @@ int
> > amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
> >                                       ras->bad_page_cnt_threshold);
> >       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
> >                  amdgpu_bad_page_threshold !=3D 0) {
> > -             if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> > +             if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> >                       res =3D __read_table_ras_info(control);
> >                       if (res)
> >                               return res; diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > index 13f7eda9a696..ec6d7ea37ad0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > @@ -28,6 +28,7 @@
> >
> >  #define RAS_TABLE_VER_V1           0x00010000
> >  #define RAS_TABLE_VER_V2_1         0x00021000
> > +#define RAS_TABLE_VER_V3           0x00030000
> >
> >  struct amdgpu_device;
> >
> > --
> > 2.34.1
>

