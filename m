Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB34C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 20:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437BE11A886;
	Thu, 25 Apr 2024 20:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqBlnHNI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD7F11A886
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 20:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb1eAjDszgUb4UU8ajL3XgFAxI0NQ433v9GNBfjZX+HOhby6Ed7TCtnKonc+6MVuruv266DR4JYczgn8bnWnxVreJiEjw9Z6NTHHDGnErmDJnQ9Pr9BVbADC8aAJxZKgh8B4I/1BB4L6NOVYQjr+4O9FFJ07G7mB6pj3RZt2FGXyJbA7PNXIr1Mct3SxaLdCMWHVKFDhH9OADUFu/HvEedA8yBgHE++AYs47u/oRNL5iLCtx4PDBYNhrMYpgcRypecSR1QS9l/nz/ZxKUjBGpLFwN3HWptmrjosO4LoEt/zuXib+nnYAN3ekgXwnGNaD/4uu1X/Zz2IE/6dQP/PeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXsmuvJ2G62xzhenEFL6uiK1feHuNwZjInV2jLz4ndo=;
 b=WvnFHrsjulGvnU2v8LCFuKZXdkvePiU+BetPcll9KJWFrM3utnwMC7nw1x5IouAQmM4E+JsBIHJlOYO9e4hkzWovXT8qDiZtl5zhsA1rGWGoreSmpor042rk8N/0btB0BTjhGMRb+Krns2pK/b9NglWll72aJOjW1pTTZIrF0NH0IfkRDu96aFZN3pVdRPfOcyHCdvQbbTVGC5IdJ8kZ0fv7NmxdE4jwDodZOgJW5Ez4haR2AmmyPuoP4rqqWiNALOmLRJKjnmcUH4berfBGk55x7IpSXnYeAivN964llFOilEPni+bRW5I5brVDV93mwF27f+dVRkHerFeSwNPPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXsmuvJ2G62xzhenEFL6uiK1feHuNwZjInV2jLz4ndo=;
 b=vqBlnHNIW0t1l8LPQde3kCzqsihzP6+x+jLkHbCWgCt4TgUvJEa+0seRgUjmOxV/hGYWUJFRYxjNvFeYgKc6NGFy6hdgoQFo0tx4znNCgvQiKYUbbsel0wiWQ+4H8KQo5od99f27lFHhEFe0WSaxvnS1Z9G/CrPWRdyNvOIQtsw=
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:12:12 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::daf7:af35:c454:4c1a%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:12:12 +0000
From: "Jiang, Sonny" <Sonny.Jiang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: IB test encode test package change for VCN5
Thread-Topic: [PATCH v3] drm/amdgpu: IB test encode test package change for
 VCN5
Thread-Index: AQHal0y5jYAkLzWwX06e/WdK29BgQ7F5aupJ
Date: Thu, 25 Apr 2024 20:12:12 +0000
Message-ID: <BL1PR12MB5126C7B6431803722AC813A8FD172@BL1PR12MB5126.namprd12.prod.outlook.com>
References: <20240425201058.3240622-1-sonny.jiang@amd.com>
In-Reply-To: <20240425201058.3240622-1-sonny.jiang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T20:12:12.197Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5126:EE_|CH3PR12MB7571:EE_
x-ms-office365-filtering-correlation-id: 005e1855-553e-4a8f-62a1-08dc6563fe7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?titAnjpXUuRXSa9Uf0qVcQt9tt6ghbUnqByrKCNnxWUl+yGl92PW/eduoVrC?=
 =?us-ascii?Q?IbjHrrmm4DPsezwiIl+7fzDXH9evbG3d0S5YOeNmlCXjEWNYvZCzbjaK2uy9?=
 =?us-ascii?Q?EajhWOKgKwOcGh1ZAe8o8ppiMUF7SN7XNzceigKBZ6Js76Cv1pgqIlVprksG?=
 =?us-ascii?Q?xFrw5hGAVIjhFcuNNcVbWKa2oahPF+XT64uxPFXk92na9dRe6mZSjThpbmZ2?=
 =?us-ascii?Q?BB/1zS3IPcAtVAiGqiCbP+lnBYk5rCFtF4Z+BN1AXjMg4S5BUQe+J5biI/s5?=
 =?us-ascii?Q?+a3pAO2U5FlEabFBAF/l3BMaptNxMFAjsjdwLTqfU9VwW2c9RkM+UjRFQhON?=
 =?us-ascii?Q?sXSuYyJrKJRD8hBvtyv4/zYPzVPa6GdjanvLkiTPBL70sKvUX5+wYF8hxzx/?=
 =?us-ascii?Q?41CptxwMWYSzkp6Pvl9LyGNyJhHt2FR/caeF3ZCg+csiEv/FyJ3uMIB26psT?=
 =?us-ascii?Q?IIUGkUfbtKXtTLWiMic65xx3LbPtCxa0L6RKQg34wpnvAg7qli1FLp9+6sOk?=
 =?us-ascii?Q?oYDTYshLoXvHUIKKlgPXvSDLHdBsnebwkokCWmsLXEUnGEhhsemqD1QxCxLV?=
 =?us-ascii?Q?a37eq/HXpJ97DIRCMPldAbMC4Mgl1+X2WpWYuC8QJ/lnMX0ZifLQYRIoFsdz?=
 =?us-ascii?Q?+n2Vg3G4rxlUn4l5B2vvjdcx0ajzk1/+naLEgtaGG9PDyrTCWPW5LarOiPXX?=
 =?us-ascii?Q?eT3O9MbUqNho7VMQ4nHOgtaE8Rshum2qaqsBWSisqkbNq4b9VGfb68A4tqcj?=
 =?us-ascii?Q?/2sdHiBbgzCqPRK7kyhOBFeaF3xWXUqh8KzAjwFdVXZaZzaq6e6lQDyaxliD?=
 =?us-ascii?Q?I2TbzKM8Q52nfVnGmTQ5mbsYEJqK85K7fdHP1P9g0i0oSfbMCd3gHWCWIvcJ?=
 =?us-ascii?Q?byI7MRv2bhaEIHrsd8aQs8xVwsOBe0MAMAg/L0jXBCP6t0DIqVMR/zi+G9Lc?=
 =?us-ascii?Q?J6HEyiSNezc4e+Ky+2s/8mZNAJBazDQW9YiZ1X104LN79hy/6bTHRrUYqMtg?=
 =?us-ascii?Q?q9VLsEjwwYtrxC/jqbcb9aQvASUXpvRfpAQsubIU1N47jASgaX24dkEOyy+e?=
 =?us-ascii?Q?h+BGggkjSbyIEUId5/HfgGbh7f1Pzo8bKx0tmXEnmZ3vdq+RE+mCA+0vkLUJ?=
 =?us-ascii?Q?SQgt8EOu/L6bdDj7pLk6UrZ7DsEhTKVhSv5ceMwARBivH/ZVdxmYL6QcdjXO?=
 =?us-ascii?Q?ieETNJWZo44Vbu4QwWRvdQt21Au7aSLxpf3f0Bn0qo54WpNJw6DrStwWrX/A?=
 =?us-ascii?Q?9NuW4WQxxoCyVMrysmxaCMP3vd7AeiDQuconRFnPwSfqELCw38/43GIhD3kM?=
 =?us-ascii?Q?3+rmxTGQQ4XrYlCzkVetXpvo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4dwtjyp1dCdqi3/VXC2hWdUeSVIcgcPCjHNYgrI7Ko3L3WMdub1cthak3RQ8?=
 =?us-ascii?Q?DU1dFvhKoUMQaqT3XTUvqmx8NHaL8MH1F1frcammTb9Hko/oAUBCnEyxgI6z?=
 =?us-ascii?Q?zaPf3R58pwg207iatLLFMgSko14I/h5IaB+ojH05R8uDV4fMO59c7v2w3odL?=
 =?us-ascii?Q?Y0PvLYiqJpKIrEVWCok1yIvcPy+3nxdNGOGAsKbgqG/lPq23bOuKZES9/tbq?=
 =?us-ascii?Q?zQcr46Er9/VFFowRUL3saELqK466yXoV2I4W18ZsMC/gO5Y3nUFZyhaTnATo?=
 =?us-ascii?Q?FpiINAU1iH9/tvn00vZkujKZbkhxJRThNLeIrtTHZzuAq3qotEX9eRrshlKP?=
 =?us-ascii?Q?5AcZF32oPpNfQf0f0+Q9DqCO2Pf2vhE8Z/EmlRTjhxj/NUuvXykKCcur1vbJ?=
 =?us-ascii?Q?+IJ8EG5T57zIa+f9oqyTeC/3+gpYwk/HkbGRc/Jn/nsBFHwcPlBEcYlgW6Uu?=
 =?us-ascii?Q?NBsSFMY1mY6CONQwTZuvZZ9uS3Yc/80rhUz/xx9K8g1p1KuNp5f6fLxfBZAE?=
 =?us-ascii?Q?BWH9oRVYgJDjTqTjjKVGVcCUlk0XBYpYxOrJzR0INWdNTDo0nNYBvT2rxcrH?=
 =?us-ascii?Q?TC1OWs7BeAZTBAj4TPbZwpbmYHQr2isa93Fxvk3qJ7BT9g8qb1pXJOoA8tGC?=
 =?us-ascii?Q?gOC0zqqMMgdts0y+dKUtx+H/QJBo8nZmWuzQtTbRv6H+n1QEoRWa3oWcQGiB?=
 =?us-ascii?Q?q4yO5/9478FzsWkXBcKFuPy1k0lr9WjVKFoMvGBQS01E5/g1EA0d65XA1kIu?=
 =?us-ascii?Q?16puyhzx+Ph13Zmi6ONeEqouuLdyQErNa5eXUCD37UowYcq8wtThshwGSMTp?=
 =?us-ascii?Q?t/I16Yc/5j1p6rex3uk9lnDKECiT9aMP23uO2SVp7FlT8Auv9k09qPZfhZEe?=
 =?us-ascii?Q?4mpVfZX0sXNiInAUqNWaSMhJoKRy7sGwISxJLssmoXfz+zqc1tMSca/wwfn/?=
 =?us-ascii?Q?Nzj6IFK/LC1H4hhnWW5jKo+2F/ITvpu9+txHThLF5p1dATytlX+v2HQQq0Cd?=
 =?us-ascii?Q?ozeFqv3f6HGNLAf8HPCqLWg2iU5tCB6w5/WU6TGDTnFJH3etqTS55LzK3anM?=
 =?us-ascii?Q?30LU9XEwkt2mGpCCGN3rocpa1IcFcRmPCiT2NPOwl4A+C3GuayMLHqVWI4Fm?=
 =?us-ascii?Q?eEiZbJ4sH/BToWg9oZBFCpaw5Mlrw+36nN69gqy5liJg6d6IaH1vx9uGBBjC?=
 =?us-ascii?Q?I8ug0NkLLrMTzTWxgxjr2LHKFu5H0zYqCyLdtF/am8kUdbXIbCAajuPoo2Iy?=
 =?us-ascii?Q?ySdgIy4V+E1DZRUbn7VEKwO//kRK2poFuixvOe8bcElur9l3TnbMyGDAyaxA?=
 =?us-ascii?Q?3Y+Ex7V3mFiu4FySWL41H8s4oeQSb67kjX6VNZ5m5TlYsvF8wz12vXT6o5Hi?=
 =?us-ascii?Q?+Wl2UUN5YuEwZAwpG0D/0EHhJwuJ8nR6aa7Zi4ZAH3dpt4MTt0leXct8BMls?=
 =?us-ascii?Q?rd9NpT1uwYClRo5nKk2wPk9fB3iR1dU/a5EJALEb/SjtpdbtDBl0+40ap+8o?=
 =?us-ascii?Q?oFzoJ+RsHBHmD7Wfeimcw5uMMGZFb5zT/pK8i1cdWDN5xJWtAhI8MHJe+ooZ?=
 =?us-ascii?Q?Cikms4y/7rmmz8sGIYY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5126C7B6431803722AC813A8FD172BL1PR12MB5126namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005e1855-553e-4a8f-62a1-08dc6563fe7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 20:12:12.4900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w670Yr1viyHsfR8o2JMrl2vZ65QD7md0ninfTjNKXuArw1+Vqi4c8Y950D4NqrHRjFtBl9t/lkBh1uJODKpuYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

--_000_BL1PR12MB5126C7B6431803722AC813A8FD172BL1PR12MB5126namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

By tests, I didn't find error on VCN1 to VCN4.

Thanks,
Sonny

________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com>
Sent: Thursday, April 25, 2024 4:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH v3] drm/amdgpu: IB test encode test package change for VCN5

From: Sonny Jiang <sonjiang@amd.com>

VCN5 session info package interface changed

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 677eb141554e..b89605b400c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -885,7 +885,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_=
ring *ring, uint32_t hand
         ib->ptr[ib->length_dw++] =3D handle;
         ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
         ib->ptr[ib->length_dw++] =3D addr;
-       ib->ptr[ib->length_dw++] =3D 0x0000000b;
+       ib->ptr[ib->length_dw++] =3D 0x00000000;

         ib->ptr[ib->length_dw++] =3D 0x00000014;
         ib->ptr[ib->length_dw++] =3D 0x00000002; /* task info */
@@ -952,7 +952,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu=
_ring *ring, uint32_t han
         ib->ptr[ib->length_dw++] =3D handle;
         ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
         ib->ptr[ib->length_dw++] =3D addr;
-       ib->ptr[ib->length_dw++] =3D 0x0000000b;
+       ib->ptr[ib->length_dw++] =3D 0x00000000;

         ib->ptr[ib->length_dw++] =3D 0x00000014;
         ib->ptr[ib->length_dw++] =3D 0x00000002;
--
2.43.2


--_000_BL1PR12MB5126C7B6431803722AC813A8FD172BL1PR12MB5126namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
By tests, I didn't find error on VCN1 to VCN4.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sonny</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiang, Sonny &lt;Sonn=
y.Jiang@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 25, 2024 4:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;; Jiang, Sonny &lt;Sonny=
.Jiang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amdgpu: IB test encode test package change f=
or VCN5</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Sonny Jiang &lt;sonjiang@amd.com&gt;<br>
<br>
VCN5 session info package interface changed<br>
<br>
Signed-off-by: Sonny Jiang &lt;sonny.jiang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 677eb141554e..b89605b400c0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -885,7 +885,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_=
ring *ring, uint32_t hand<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D upper_32_bits(addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D 0x=
0000000b;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D 0x=
00000000;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D 0x00000014;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D 0x00000002; /* task info */<br>
@@ -952,7 +952,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu=
_ring *ring, uint32_t han<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D upper_32_bits(addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D 0x=
0000000b;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++] =3D 0x=
00000000;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D 0x00000014;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_d=
w++] =3D 0x00000002;<br>
-- <br>
2.43.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5126C7B6431803722AC813A8FD172BL1PR12MB5126namp_--
