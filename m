Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042BBD11185
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 05:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A127710E378;
	Mon,  4 Nov 2024 05:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XuU0iQM8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2728B10E378
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 05:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opQENsxtz1Be7XeTpPL+qkLyBgOjWoJRWdDWNvS6ZA+ESj3RomD5AldllJtESkTzyy5NgKw43DJlFSAreSmXN3ll24sCxYpODYTFZYJ4AH+/roYgw/FYU8Z86hLc7IMRp2a1kSvQ2uOpv374HTyZ0XwxXUdiC+me5Prc07MkAb3gqlxGeQ7fI/sK3G1my6p8vB3kwkuyEgU5UEfpL2akmZJUHLugEnxQPMCgTkV3yAKQgagjJZyZAOH03RpKWauHKeA/uQNSrFM3OIx+wJ8oyfbe1WGGELk4Xj7Mf6ZuaPIQGU3Q4Ei2eswE6SFW8y6srfm/Z7UrResYXZjQhxAihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn5IYyoNUHBl0GmiX/lI8pbVVgPdKaxbvpi4lbIyPyA=;
 b=Y2HMSI9oRNnXcquoLehPO5grS4VvH8THhgYjZU07OVp1h4lf9bmM8cf26mOnH6lIHsVCnLKDfdG4QfOvwwPCOl+31LVThgnkOLl1X87lk6mqEYdY3KI+hf6NLNJS6c0hazc+GafzXAWaicFbjKp/iZOAA4y5iBkHKzduKi2aA8hQtAMezo9xBygL9Qc/1VhrIfxdpDWtDz7mgGIHSyY7hfYfvu9ewKlOFrFQn1dRZh/Sg1Mg5do3Pr5fd9gX+8bTF+a1UPd/ZHGBFbf7fKDm2OW0ONZujFnYa/xfwi8hg9vUd46ynK1Xspeje4qkO6HHyNQzBLjpWpLYW3Y2B4smtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn5IYyoNUHBl0GmiX/lI8pbVVgPdKaxbvpi4lbIyPyA=;
 b=XuU0iQM8W+FsXD94J3mQ22jrP9THLQMy79Ws2f6XLrl/sVA6QQ6dXb4mtRMgMzgNBip7O5IcwawjSAuKCbhXSib/MwhaniHJ4QiIczPf0y714LdjBHrRyHUNG8y90NMihV22ZMIOKQOqzm6wnELHAJHUlbRluPazfvHTxj0jNDU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:59:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:59:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix DPX valid mode check on GC 9.4.3
Thread-Topic: [PATCH] drm/amdgpu: Fix DPX valid mode check on GC 9.4.3
Thread-Index: AQHbLngKjYVbk+axiky46fCkBuw4ZLKmoApg
Date: Mon, 4 Nov 2024 05:59:00 +0000
Message-ID: <BN9PR12MB525792A30DCE5A86FB344532FC512@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241104051031.3204728-1-lijo.lazar@amd.com>
In-Reply-To: <20241104051031.3204728-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2b39274d-bf73-4b02-a543-51e29f0ab379;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-04T05:57:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4413:EE_
x-ms-office365-filtering-correlation-id: 256fe9cc-0a0e-421a-b224-08dcfc95c787
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7SrbhSVusb7tKzK4n5khtkqYURPsPK+h0lcG6YIwzmC2AP+GLbHRpFWEThhf?=
 =?us-ascii?Q?6OrVgPROmIJX5JqIuAhHRGS1NIFEVo1L2ynjFzmgV/s4l29zrI911yGVq1EH?=
 =?us-ascii?Q?s3/z8Dceqk9mlgoF9bbRBEoQXWrOPP5DIAXgDQyTGe9fX2FKjEJgEkTFOy0x?=
 =?us-ascii?Q?bemwe40V5kNVfqkJEpbBPLXldozPw8JhVAClR03shuS8aspBbElU2cIeh6FO?=
 =?us-ascii?Q?EsMEUHiF0q47xMtWa4O0eP0LYVf53E/lxQIauaLVkdOYrscam4QqT4p+/Fi2?=
 =?us-ascii?Q?37x9iQfUaxVy8qY3UgLxn/pHyZ67v91R0SUkTJqwxk7N1sRdlWhgaBGo9VTC?=
 =?us-ascii?Q?nuICbu9FK2QGG/mC8qI/xzc7kLBanpI+t3+HKWy/nbzwpTphYTt3BG00XBVl?=
 =?us-ascii?Q?Zv5UsjZImoT9qDarnyijlVN2tGbFTL6OpKmXPSOp1EEEhyROXfRVuh2VjZLX?=
 =?us-ascii?Q?DK0U/E45JGFI9JTcYZn2y6Dn76H5qta9PsClCxWK6pgvmyOuNJX5Ge2qT0Eb?=
 =?us-ascii?Q?02x7kNBz9ZIjsUdRh7piDQSXq6aqZd2lxCgS6JpZ4t5jyBULmQ9BsT9UYfBd?=
 =?us-ascii?Q?6qQW9k0Nx09l7kQAFhA+smgOkM55DF4XleOiQUiWKc0Ia6/Aqc5VeqyBObc5?=
 =?us-ascii?Q?UllmzAAhGDtZy6HHBJTcVIEemhQrXtcjR5GfEZx3onzzBQa4NXq28EHP4vE6?=
 =?us-ascii?Q?vkOwzL5jcQH/gb/31twmwFk9XipddIpDqA3U45dODw0bqmvO5xvSpKZzhA3W?=
 =?us-ascii?Q?q5SwjlKYUjeie1FEPpSB9CEX/7NA/sPj+KhEfAHtVP45pTEEUSpEBPGlvxBo?=
 =?us-ascii?Q?Ga0pKn8VBGlssSKE15K3V8c7sCAyGLPMHOqTFB7sGk9aEgFfzqWwcUy+Xhd3?=
 =?us-ascii?Q?OQ6Mycb+7EZF0poPRLUluuTP9txmVbDUWEEX4BPHxy0nOkzn8YehybWYmTgE?=
 =?us-ascii?Q?26VxMaczh5qZjzUf7It3Cz8Wx7FGA9fRnsYc6d/E9Yb5fIGXyCp/KZCE+I1h?=
 =?us-ascii?Q?su0DGd3pGQ8NmUkuzXBrKCwnTCMn1vZtBWMgv5XVyTAnjg2n+SfFW2tN6GNS?=
 =?us-ascii?Q?/oX4psnsfxcwpwPonBURpscLkUryFaiKDa05OEmFu/pqpNXIggv3T62bpqyu?=
 =?us-ascii?Q?WLxCcOLWpbqniI+Fjofh7UkGYB1e5OWOvAYvv53aI7OjSL+LCzmUDCnZQZny?=
 =?us-ascii?Q?YdLJ0rWfaLYRfDtTXnhj1rnsgDXQ8MGREPiYsLMvSEgsh0hrDmAB6ku21qvq?=
 =?us-ascii?Q?to145pQUHMs/VehtuIh3n3hNtQnWVpQqmPNRGAr+wRQGdWZwmt34l9RBN8Ld?=
 =?us-ascii?Q?GUFUTg8RPWe8aZkgNGM7EhCImqDPeMXeO7mw6SOUpzhnma2BnNQmPCjM6J02?=
 =?us-ascii?Q?uq4KXDM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AWi/Fsjjs4wJdD+jNsAyzc5UpxDvrFXnw5EK0zt9XEeECBS1UCA4Qwx8hxVm?=
 =?us-ascii?Q?vPuVnqro3xyRtNKujP3goeEXBzb+c6mX39Ihh8TLTS/DTYgGavrcgL7esAry?=
 =?us-ascii?Q?kfIsAEX90qUN++FovXWb1sDcbKzXxDKV06m1K6hq9589BTp6xuaNyFoRJ2EL?=
 =?us-ascii?Q?/5AQ2mvgYubVUnwYqCSJiIi8sT//Ne4D3v/Ho++fhxnopn/UDV9/l191D5x+?=
 =?us-ascii?Q?9Mwh+wio2yISbLcf9RLqdYsMVLcm27eGvjLhCn4o42lHnnW/AWEE8/Cnjphv?=
 =?us-ascii?Q?X8crBQ6dUq+7/fOXcuYWFkBFM4V5uRxB1Cr7gwmqovybBGJdJ0wb9cEvPf6h?=
 =?us-ascii?Q?KZgG4bCiSQL5NvoTGvhwPMIJgIDlBa5do4mCa4s5jL4HftMS7a9au7QRgWBy?=
 =?us-ascii?Q?QEq3wmCpMHJiweSG0GUSYKFQcur1Tj3pcuPh5MLrWkUH+8VE+3FMhSayXL0h?=
 =?us-ascii?Q?v5opLH2InpiCNtF5fhgBxNWLE1IqmV4K9ok2lMhJoN/6JILOnEHDJ9s38y05?=
 =?us-ascii?Q?7HJm7+59hfInDYEcCtzUXC7samUy9AoT19NUjrXu2FHxCFI/ZObe7K4fbq4h?=
 =?us-ascii?Q?g9xavW1gIPJubBZeFausa52/5Zc0K+sWULoV3zXijJMtRxljkt9vb3nHhWF9?=
 =?us-ascii?Q?hV+GRL2AaidsR7yqTVNqEXvHrvkymVFUNRz3B7wAsMkstFtt2k5l0doTlRaw?=
 =?us-ascii?Q?sccs7HEnvwXkiwpZz1X3R80eiwe9g+uajyGUKoX27iAUBcnGjQj+ReEVH0Fl?=
 =?us-ascii?Q?QbdY73UUJcc/eavw+VAymzEmJGju9E8T3Wrg6WjZLQ1l2x2mRUIUt6QCmalv?=
 =?us-ascii?Q?QmGsQuxhwZ25SgCEO1DB4xyuQeOoikwd43glQ2eSExicVP2m74YMctq7DEFX?=
 =?us-ascii?Q?TyPlLLKhulJ8lZDHt6tTY6RfP4XPDAlZvoTqF53JBtkPMH4k+kuzSIqi6nAA?=
 =?us-ascii?Q?BJMvBpf+WyePFwu/UyPDyWiD8Blt7cQr0bLr/x9A9fXaBNEDPpdLAFSIH80g?=
 =?us-ascii?Q?qdNfDM3HAv7hDvCKQsAKc84J75bhFX2ShQm4xp5+vvjTw+D7kViNdg8hxjLv?=
 =?us-ascii?Q?gleuLviWS6kA82tfB0aBQLEzKRyQAJ2U/P7eSkA4wL0STpwVb50cH9Ak//KI?=
 =?us-ascii?Q?gUmTpXcuM1CXE/WM64nwxZLk0AV/kwAhWGv6o6y26glGuzvJPWuErZNuVQWP?=
 =?us-ascii?Q?pn5vb7zOh6S3cON/koO/IFGGiV7Ueygj7etm7cz6lrUxAf2T5iI+TTIyY4wg?=
 =?us-ascii?Q?oOdFaHcJmEetNYn14pXCuDxQ23ylSnWP0SdLUMrGsDRNS/j6EUMoKhJ54/4o?=
 =?us-ascii?Q?EsyKpi8tAhRNo/dXMdcnjIQwKziPtT/wyhqibmviHgW0bqccQr7HiWBTwW9c?=
 =?us-ascii?Q?l+pVUQSN7jXeGNeuwVc/tvjhTtldHIc0+IZ9AG6gXhXcTFNdtLx4R8++qh2m?=
 =?us-ascii?Q?IMaGBtBBk8tpUbf6FXc/QDfmASrf8k+7r2NmgA2EdTD2nfYphTcMRxj7auh5?=
 =?us-ascii?Q?Oueljq2Rvf4uPSm4G6BOAjC7kzOzeHTaSF1app7oeFKLgXhXvn/0xpcVQcqN?=
 =?us-ascii?Q?PNuJpoTi9UhkYysHyDE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525792A30DCE5A86FB344532FC512BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256fe9cc-0a0e-421a-b224-08dcfc95c787
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:59:00.7406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWRvm6OG+jtrqk0BTr86Vrsom9liPUqvx3BqW1/jtvkcJMntSMj2UlS0a4MIVousI+4SaTkACZHWYiAUJp2elA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

--_000_BN9PR12MB525792A30DCE5A86FB344532FC512BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, November 4, 2024 13:11
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Fix DPX valid mode check on GC 9.4.3

For DPX mode, the number of memory partitions supported should be less than=
 or equal to 2.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
Fixes: 1589c82a1085 ("drm/amdgpu: Check memory ranges for valid xcp mode")
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index fccccea0d2d0..e157d6d857b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -548,7 +548,7 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu=
_xcp_mgr *xcp_mgr,
        case AMDGPU_SPX_PARTITION_MODE:
                return adev->gmc.num_mem_partitions =3D=3D 1 && num_xcc > 0=
;
        case AMDGPU_DPX_PARTITION_MODE:
-               return adev->gmc.num_mem_partitions !=3D 8 && (num_xcc % 4)=
 =3D=3D 0;
+               return adev->gmc.num_mem_partitions <=3D 2 && (num_xcc % 4)=
 =3D=3D 0;
        case AMDGPU_TPX_PARTITION_MODE:
                return (adev->gmc.num_mem_partitions =3D=3D 1 ||
                        adev->gmc.num_mem_partitions =3D=3D 3) &&
--
2.25.1


--_000_BN9PR12MB525792A30DCE5A86FB344532FC512BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">-----O=
riginal Message-----<br>

From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; <br>

Sent: Monday, November 4, 2024 13:11<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander &lt;Al=
exander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: Fix DPX valid mode check on GC 9.4.3</span></f=
ont></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">For DP=
X mode, the number of memory partitions supported should be less than or eq=
ual to 2.</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">Signed=
-off-by: Lijo Lazar &lt;<a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@am=
d.com</a>&gt;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">Fixes:=
 1589c82a1085 (&quot;drm/amdgpu: Check memory ranges for valid xcp mode&quo=
t;)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">---</s=
pan></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> drive=
rs/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> 1 fil=
e changed, 1 insertion(+), 1 deletion(-)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">diff -=
-git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amd=
gpu/aqua_vanjaram.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">index =
fccccea0d2d0..e157d6d857b6 100644</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">--- a/=
drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+++ b/=
drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">@@ -54=
8,7 +548,7 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_m=
gr *xcp_mgr,</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_SPX_PARTITION_MODE:<=
/span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return adev-&gt;gmc.num_mem_partitions =3D=3D 1 &amp;&amp; =
num_xcc &gt; 0;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_DPX_PARTITION_MODE:<=
/span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">-&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return adev-&gt;gmc.num_mem_partitions !=3D 8 &amp;&amp; (num_xcc % 4)=
 =3D=3D 0;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return adev-&gt;gmc.num_mem_partitions &lt;=3D 2 &amp;&amp; (num_xcc %=
 4) =3D=3D 0;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_TPX_PARTITION_MODE:<=
/span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return (adev-&gt;gmc.num_mem_partitions =3D=3D 1 ||</span><=
/font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gm=
c.num_mem_partitions =3D=3D 3) &amp;&amp;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">--</sp=
an></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">2.25.1=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB525792A30DCE5A86FB344532FC512BN9PR12MB5257namp_--
