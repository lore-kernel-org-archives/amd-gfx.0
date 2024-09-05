Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB799CD4F58
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 12:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79CA410E884;
	Thu,  5 Sep 2024 12:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iJSf46tk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C09710E140
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 12:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVvsYT7R0d9Ff08eQyXPKCdnCgND3DBuWd061zDoYBWbluay2rdmqoMo6wpoIxBxv7uW0NowMSOn7Vblf1qcrIxE8mR7ul+xbobPJUokX43WQBHElxZ97fmhv+eUDyYvp4cIF5xnBNO+izsex8z5f4oyXZPQC1mO+Ybg9sXGm0b4crJ0cOKjezG3KrnM+0V97j7l/3TZhPpgp55tWZVS9mU9nJHiYg+Bj4pH8GnM47RAWlg0vM6NdzT5pviK3tTIr8J+nIkRUAdojgeFVmt4GYmZXjRWitqw6SN4fYijWDGn5HSAvvj4cE/7icXcvH4OQ98IfqgXTmRmDRm4vVciCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/BopBWYiDO/s6MuXhhg34HEhTKTkR98SKO5O4n8rsk=;
 b=q+0vGM6mEdMEyria85s5SktxZc0j3nLLnI3tHcTt8V+kIjhOfutEM6YF/lTkMSc6gzxJpEG1EOXs0q/btXi7TV+mKOmEr48DttLUc7Gr+xagh8yP9BkPaUXgMYnvXw6of6i9tnzahyRnM4u+xsI1WXxMvgl2OLgsK5vau66Eie49fSZF2yHwwOZ/HIPmHAu2fV/5n9xtAKquGOejVIGBvOuUqB3lyH4Li6Ib9Wu00W7VwdpZUWcPINHezFr+JU0Vmp1rpMZlRa/w5aoDuyFKrkZnAEMLFq9RIV32v1eWPXKpUihWugYY6KhSFAAu5045p7cAclZrWDDIzorWF6BSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/BopBWYiDO/s6MuXhhg34HEhTKTkR98SKO5O4n8rsk=;
 b=iJSf46tkhyTBJ6DrCPlpk71PQB55ooU3s87zAnLU2CLwic0YNxzv29Kgs0j9lqJ8xPmLnIa6wnuKuPhmDixdnNGcwme787jWxtn7Qkki9ppvhpJTxqVQtJw0+TKFomwYvN5kXBOj7I+MLxY1lvJHMRx+JYGLEopL6S7mrUo77oI=
Received: from CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 12:38:37 +0000
Received: from CO6PR12MB5441.namprd12.prod.outlook.com
 ([fe80::8937:4064:f4fa:2454]) by CO6PR12MB5441.namprd12.prod.outlook.com
 ([fe80::8937:4064:f4fa:2454%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:38:37 +0000
From: "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prica, Nikola" <Nikola.Prica@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence
Thread-Topic: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence
Thread-Index: AQHa/3HC/oM5fdy9wUGTBgs8g1+KG7JJC32AgAAQR3A=
Date: Thu, 5 Sep 2024 12:38:37 +0000
Message-ID: <CO6PR12MB54412BC4A08D1335062D28C4E79D2@CO6PR12MB5441.namprd12.prod.outlook.com>
References: <20240905085841.18189-1-Dejan.Andjelkovic@amd.com>
 <c93d6652-08fd-40fb-a629-d52bec489ede@amd.com>
In-Reply-To: <c93d6652-08fd-40fb-a629-d52bec489ede@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-05T12:38:37.534Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5441:EE_|MW4PR12MB6731:EE_
x-ms-office365-filtering-correlation-id: f282b762-77bd-48fe-46ad-08dccda7a9ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1F4WyyBHPl2GtHE6mwbuK+GmdzRaJN1E6jftbpnVFdt8vBo8ujpAObNgQ3na?=
 =?us-ascii?Q?XmDCL+6gzeCw1whee6pbgQPCIsyv9ut/VLIeHS5MEddvqSCZDQJgwruG9QqQ?=
 =?us-ascii?Q?BXrEMty8NR3Qq8iCAJlrW6iOUJBJmhcNP03wMMOBNanjV+kGk53xP6eTo1QV?=
 =?us-ascii?Q?NhEXX2soXe54i43AMP6GjngiIASPdvPBGDNklhPKiF0GUUG2f0ympP9rtE0I?=
 =?us-ascii?Q?GqlKZqWzK1kLFBMwqwNm2WtjQ5DzS/HUaflYWCFaulhvZuViUnn6a3jS5Aw1?=
 =?us-ascii?Q?YTvhWfbUwDA0ynxiNWWHA38X6QfY5JZ6iK+ocWA75Lox5d5pL1p4bekS214g?=
 =?us-ascii?Q?G5vfgceDK0D5SoR6yvTy1XME21zXlV+nMauWeRgcSaH8dmUlluUi/oRqdLUS?=
 =?us-ascii?Q?0YxyPJvHy/L/+uFU+qpYfFJqUjNf2RXHn8j5x2hB3VWR0zGD/Z6siRwCvWw5?=
 =?us-ascii?Q?P8WFLiMDv2IqU5Whve2mylgsuWrOxehBEh6PCpPGK7bOu9LraSE51YEKeLM6?=
 =?us-ascii?Q?CXCN7UIWj6gSYicUPkeVAjMXoTCQzpbwQdEbOidVchTZjij8n6Fi1K7Dwyin?=
 =?us-ascii?Q?g5p6a3twI6rNw2/ofcetsX6+EPakqGh8U3oRv7tb0tYKnULboXpb4FGF8NJK?=
 =?us-ascii?Q?k4ooPfVOUUr326AjGtwQuSR8Q0LOkfz2PQLCTt86rKkRO8flIrqnhyN2LBBX?=
 =?us-ascii?Q?oJtvHz9Rja3PaPDESyjJ4fV9YBvSyUAUatc23r1UiVqqkH1b/tOelNvTSo+P?=
 =?us-ascii?Q?MjNwJSru9x9VOQTctSTvT12ytJz83VwT/6xDyjIIm+T/NV5JbuHIkRwUIW5N?=
 =?us-ascii?Q?wy0OUUXIhhr0Acy3BSmJ+bhu/igt/9tk98FBZF4qfHyx2pYGttBO0Q7s0KNU?=
 =?us-ascii?Q?Sz94KuwnEHwVVNvJm99Kxo12iLgGtIvES6PIXX/IDNUCzBEZhXxl5D1ICYSJ?=
 =?us-ascii?Q?iNzrvb78uF7MKQ/Q1cx8NtVFbCYiSVUUX3Iiq7PNs+MUzFErkJqeQVXsUVyG?=
 =?us-ascii?Q?caLU94f4j5zlf5fN17sC6Ln5HnLACXGunh4MOaCEz4CrvB+aNJw0XwrkXY0a?=
 =?us-ascii?Q?AuP2hCHP/X/VR4nyZBpPjHaBWSGH78SqZgO+IyOSBX8hq6lUempLsDla5vPz?=
 =?us-ascii?Q?HNpZb2Aa1yCta9YFkXSC+JsyB8SXOmwkTiKzSgtQCayreKzWpWMHKiOJbNEN?=
 =?us-ascii?Q?Pvu42Fy/2iX00SGBwAfMCOyBRaheZj7rHH5JfWi+zSC2ZaEcNG8OS/zYQuIX?=
 =?us-ascii?Q?ZqG73TCZ9AAFypf5/sE0fg7uct0uRfKBP+F6d3Iv4ZEIOe2xcowPFIyo0UHx?=
 =?us-ascii?Q?ijcsMCmdnG4/AKqRfgKGC6ko8xKGCoHGcAlDrG1RL0MWIwLnajElrIZ9AJqG?=
 =?us-ascii?Q?RUU3iPcXX+DDR8M5nk3AUfQgFMoVMEdz4vKV456361m5NIxlYg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5441.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/cZFsKnqShYOelllFMtD8oeMPxq8BYZkrIG1v35NQFgO+gmCwzl3L6/bXjiB?=
 =?us-ascii?Q?STYM4ILZMlzwDnTaBkzeI8jfEx2T/iviB8H1YJbHktivQVI9NLggUG7vBpFi?=
 =?us-ascii?Q?rfKQNWbKY74kGk/6eBapXCqEgDuO5J3FXQhQPIMwK83tn2DkeQ+F4mfvYr/u?=
 =?us-ascii?Q?mzlOtZ8NCl8kQpmC5Ly0ZPzkUAleYZto2oAAFxu27nByNVVInVOXWHCKzq1t?=
 =?us-ascii?Q?avd+i+KorYZ7QuhoEOPcIrctkYOgtTVBFCNmvvOsh+vNQdU6i+8IqL7/+MNL?=
 =?us-ascii?Q?iARw4egyBiFykdQ/4J0IWd6E1K7t2c6+VwFbzUwqB70+g0rabD0AgIPKD6nw?=
 =?us-ascii?Q?S8z+d4aYLx0n4muiZmBgLWbIC+W7lPEXtUNvV1AXHKfnNPlSggbOY/41vVwB?=
 =?us-ascii?Q?ESvlXCO2+TGVXo3sNUfBgOCnfRMtkk/eKvSjuRldEBc7vNnNKlpCftU48iGW?=
 =?us-ascii?Q?ckWNwriSJ/IH3wApZkKxHvPtXOIQG+rfhjcTLF1zFbRpiPCL7/TUUyJZMe2P?=
 =?us-ascii?Q?FR0Z2+d82nowTdoAXcpgZ+uvf8h5xKpZHisY/mDbJb/PAe4xDb/OYgibEtAq?=
 =?us-ascii?Q?7Nx7qUveNu6u0qgdUjKpbrdh/AFB+5DEkaUN6pHai3ll3pRwC3i4RSi6i8+v?=
 =?us-ascii?Q?D0mY76BzsYSi8g6/9Y0GlVncrBXp5/4FVnc/n9VzZGIlf+uzXIaSwI87Jblt?=
 =?us-ascii?Q?XE3uRNnX+GUADXcQEIK6S9W7jcJWbIQg/YT0wLT2+XDzZbSLk8emH9DEoL7/?=
 =?us-ascii?Q?aod0THGFCPjjGVQuYu1hMw/Lvs+87B/26iZ9xozoKe/ZwsgWRKWWCpdbmUUF?=
 =?us-ascii?Q?ozvfFD7k/56nvTDngHnNlA0LnnembeUDCMYmz9dUsEKtFlC8eAvv+JzYuUV4?=
 =?us-ascii?Q?UxuGnZlBf5mTFseg8KAV56zoq4JbsYGOVaf/rI8eutj3PKIiyx1uax79MzP+?=
 =?us-ascii?Q?EPLBO9twhqWq4Ak3xpMXxas5QZnk9pwjdtBnFMF+gcg5eXGdCL6PYrPaehHB?=
 =?us-ascii?Q?snEhmdOg6yspIH6w70C3vfZfgYZwf9A/A6ctKrNswHqBkJrIPikQYNiOY8LR?=
 =?us-ascii?Q?K83Es/dGqTpLVkTtY/ytF8X+cqdSbVh2Tz27rhslnFpVk0S0kyNzkAImKvWZ?=
 =?us-ascii?Q?b2qfoBh2f8QjDj1jInPEe7AcZO3wPyTxmBqdyVUfcxmQb70XVbv39jqXnTtl?=
 =?us-ascii?Q?e6nxLvRvqWhZhhi8QXDlNrtFV73gBh8XPiVfeb7Zh9hD481XwOXyG8ybNuOi?=
 =?us-ascii?Q?QtXxlO+zY+/zSKcHTsEDCSeSDk8Ah1zZ8jn3zVRk8udLy1dkmv5aQ85ZJqM9?=
 =?us-ascii?Q?c5Sq2DqCYWj+XmgMBSk1pm9tabeGTidXQY51/TtGTIo+JFnsYpvkTFLwxgQT?=
 =?us-ascii?Q?3NAZSiOYZuW2puaUpVIQPulB6j13+dsYSh+UlnP/cdIgVKQM5Bw/bEEmlrYq?=
 =?us-ascii?Q?cgUBGDvrDfwGoOs2/nbUQ0BhxmTLoBy1PTbLwa2T/HQaUG39mYKQnSfDuLMa?=
 =?us-ascii?Q?1WO2rpCdLJ3BXTosBVsfC6r5deJf36rJub0PbiBKDdJV81i3LCGp46UVNZFc?=
 =?us-ascii?Q?70BQvotveED+pkPIkik=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54412BC4A08D1335062D28C4E79D2CO6PR12MB5441namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5441.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f282b762-77bd-48fe-46ad-08dccda7a9ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 12:38:37.3363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7N1S+7GzRz/Kd1UGVWJYS3zGQ/7vz6ubQXoHF3bOtGhJih+O/O/KjuiusS2tfgxhfxfiCZR8RLMZ0jZ3Y43pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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

--_000_CO6PR12MB54412BC4A08D1335062D28C4E79D2CO6PR12MB5441namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi there. We're running into a page fault issue that's very easily reproduc=
ible on a SRIOV environment when using SDMA for page table updates. Going t=
hrough mapping logs and trace files, it seems TLB flush is occurring premat=
urely. Changing the usage to KERNEL completely stops the page fault from oc=
curring with no performance impact, which was confirmed with extensive test=
ing. Looking through amdgpu_vm_sdma.c, namely within amdgpu_vm_sdma_update =
when waiting for PD/PT moves to be completed, fences are iterated with KERN=
EL usage specified which are then added as a job dependency.

Best regards,
Dejan
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, September 5, 2024 1:17 PM
To: Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Prica, Nikola <Nikola.Prica@amd.com>; Kuehling, Felix <Felix.Kuehling@a=
md.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence

Am 05.09.24 um 10:58 schrieb Dejan Andjelkovic:
> When using SDMA for PT updates, a TLB fence hooked to a buffer
> objects dma resv object with usage declared as BOOKKEEP leaves a
> chance for TLB flush to occur prematurely. This will lead to a page
> fault. Raising the usage from BOOKKEEP to KERNEL removes this
> possibility.

Well that's complete nonsense. The usage model is for implicit syncing
and not even remotely related to TLB flushing.

What exactly is the problem you run into?

Regards,
Christian.

>
> Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index f93804902fd3..8efc2cf9bbb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *p=
arams,
>
>                /* Makes sure no PD/PT is freed before the flush */
>                dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> -                                DMA_RESV_USAGE_BOOKKEEP);
> +                                DMA_RESV_USAGE_KERNEL);
>        }
>   }
>


--_000_CO6PR12MB54412BC4A08D1335062D28C4E79D2CO6PR12MB5441namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi there. We're running into a page fault issue that's very easily reproduc=
ible on a SRIOV environment when using SDMA for page table updates. Going t=
hrough mapping logs and trace files, it seems TLB flush is occurring premat=
urely. Changing the usage to KERNEL
 completely stops the page fault from occurring with no performance impact,=
 which was confirmed with extensive testing. Looking through amdgpu_vm_sdma=
.c, namely within amdgpu_vm_sdma_update when waiting for PD/PT moves to be =
completed, fences are iterated with
 KERNEL usage specified which are then added as a job dependency.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Best regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Dejan</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 5, 2024 1:17 PM<br>
<b>To:</b> Andjelkovic, Dejan &lt;Dejan.Andjelkovic@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Prica, Nikola &lt;Nikola.Prica@amd.com&gt;; Kuehling, Felix &lt;=
Felix.Kuehling@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TL=
B fence</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 05.09.24 um 10:58 schrieb Dejan Andjelkovic:<br=
>
&gt; When using SDMA for PT updates, a TLB fence hooked to a buffer<br>
&gt; objects dma resv object with usage declared as BOOKKEEP leaves a<br>
&gt; chance for TLB flush to occur prematurely. This will lead to a page<br=
>
&gt; fault. Raising the usage from BOOKKEEP to KERNEL removes this<br>
&gt; possibility.<br>
<br>
Well that's complete nonsense. The usage model is for implicit syncing <br>
and not even remotely related to TLB flushing.<br>
<br>
What exactly is the problem you run into?<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Dejan Andjelkovic &lt;Dejan.Andjelkovic@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index f93804902fd3..8efc2cf9bbb0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params=
 *params,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Makes sure no PD/PT is freed before the flush */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv, *f=
ence,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_RESV_USAGE_BOOKKEEP);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_RESV_USAGE_KERNEL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54412BC4A08D1335062D28C4E79D2CO6PR12MB5441namp_--
