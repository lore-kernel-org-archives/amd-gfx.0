Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479AAC25B5F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 15:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E4210E76C;
	Fri, 10 May 2024 15:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yw5TruY5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1118C10E76C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 15:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgywg2s48o1PyH0PVIFeMB/oZJOeh7+a2Km48aphhvsPSRsJm638dnkP4zNzlxYJ8INOsBaK2JtMcC5QqZCIUCm8usbECNzpJE5LyYx8qNQ2qrXLrb/AHCi9EbgQC4OelZQOTUyNoVTSDCAIpuuytOcn73iaAk6ga51N32qbeWOYbY8VGYc2DNDYluubIF81AIrNCmhGmF5Ki7OQkmpYVSGWVRckFrdiNQUuN2+Ai8493zhtqY/maVcy3O6/6L6izdTbxkQMDuiKW+f1pusWrs/ZlfYN/Tqk0xAvSHRP2Oca77huXo/+m6ih5cqzB3TDFX6Gii6UNJSm0e5kh8qOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nlPbXs+wOByum+eFLtRE/4Gb0AD+i//87vK8eebTQI=;
 b=I7KcRG6LjU87u2/LaMcEwBgS3WQd8OZ4kDFN2D90cjUTloA/+hOBuhEfkQRfxHaEpg77P3xTilYvH9tueY1HbxifnIa6vZmkouPdhUVxFC4wRs1Nb6M7UXlg4cJk0IlhoCQtaAFlX410mtEs0h7R1CDjP3hjlqKkRWW3Fj7O3dRvPqM8UXQrJHgapFFgHO8D0SLk+oJsvWzobApkUQ42SLIfT0gGGKgoF72BFYNHXyh0eI/iRDWwL0mjbRs0+6fzSxBKrR+knGdu/iwZtiuNlaDLBEqveUi8FN1ervq6C/URC4RWoAOqaQBYVaqrp6AQxnaP6InXr5GAqURxlXBJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nlPbXs+wOByum+eFLtRE/4Gb0AD+i//87vK8eebTQI=;
 b=yw5TruY5q2CFZF1tnZYYLu2DUYOuPatiheSxc/fYAuFLEJOa5G/i1y/g7IUge2UdzNrvrQr/TI9B99U1NB//x+z5HOZ28BQJo3/PwQsc1/ZfrlA5YoqJEd4J9SQmuVr45OMhz1PUpeEzX4g95wkiFkk6dYQWZS2BX1pN+FssvXw=
Received: from IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 15:07:03 +0000
Received: from IA1PR12MB6305.namprd12.prod.outlook.com
 ([fe80::6787:bd0d:885b:5a83]) by IA1PR12MB6305.namprd12.prod.outlook.com
 ([fe80::6787:bd0d:885b:5a83%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 15:07:03 +0000
From: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commit
Thread-Topic: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commit
Thread-Index: AQHaopZrYzr7g4TujkmKGpsMB4eidLGQcxWAgAAe0/M=
Date: Fri, 10 May 2024 15:07:03 +0000
Message-ID: <IA1PR12MB630579FE2AACB62605A5CA33FBE72@IA1PR12MB6305.namprd12.prod.outlook.com>
References: <20240510045541.533908-1-sreekant.somasekharan@amd.com>
 <20240510045541.533908-2-sreekant.somasekharan@amd.com>
 <BL1PR12MB58988832B0D636510D2D190985E72@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB58988832B0D636510D2D190985E72@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T15:07:02.400Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6305:EE_|PH8PR12MB6699:EE_
x-ms-office365-filtering-correlation-id: 348263c5-c505-47c1-0a53-08dc7102d9af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?w4YYfOmja0nT/db0mqfOBl/LVEMtfCxuVXL4NPuVz2pnOmILFv0cRszjRQnf?=
 =?us-ascii?Q?DTdA374ky9XR3EO254g3Lt6tbuHg8MFeAhHZgr/odAXzQffbg/vPq+bqetCk?=
 =?us-ascii?Q?YTJ8iKwnNvNYKdEXEqbSgYpENrIqsGUFKE5MccwKwlRTXNpEsGrFY1rst72R?=
 =?us-ascii?Q?fkfXD0Foyd0glmMc1B6jEv9AdkJ8Kc2wrp760/2uLGoDGgWdpw73S3xh6eX1?=
 =?us-ascii?Q?IKjgsOOR066p2LtvN7igE8itJjdkdhfSK6J3PPGnD8DD1Nfd1/1UwVN8f/JM?=
 =?us-ascii?Q?XQ69zMiW6JvdRffMBGEC/afkxahg419k6RD8j+DwEPEvv2XGiKAWOdrLO+Nx?=
 =?us-ascii?Q?v3SYbYqWzi1eFQYslyXIcUu/ttbrn1ID2UOyY3+r5O36noPnhXsHeeg/HjX9?=
 =?us-ascii?Q?Pmgi9PGMvGyBPqWPf47S7n94A23DbiBtOK3PzD/quTd+T2Hr4TRyUwqFQDs7?=
 =?us-ascii?Q?Ru+r2PE/+UXZnQhGlW0ThuVnoEfa1aMUjnUxapnlWj2uZlpHYguvXfLqniIk?=
 =?us-ascii?Q?MPJvnn4iiXF5h9qUmlV818+JAGLKotcmcDO3Z5yMJ6Uxfw3fm/f+Y+GJDgby?=
 =?us-ascii?Q?uNWyf9Ub0vflP/R1o6v5yh01vHqkwgRp4+zKR7l9P8/LLPCcY26IXLxdz8W+?=
 =?us-ascii?Q?+aNolVE6cffOKI2z894yA7/tyapVvlLFXzCSBGj4+AODgKflGhMTymxP0qxS?=
 =?us-ascii?Q?zmr7lDV/6LwjMeW77FurOHlbSmE4OAvTF3aN/Iy86Y9vplETEDMCxMIVJwW7?=
 =?us-ascii?Q?uPugqrJa3gsnyNW+w4qJaRtZall0iF0llTUSUIPBPhzkAqEGWVqPiXzG+3yE?=
 =?us-ascii?Q?IQShtqrcuCarg1AEeBq4fo7MXJu7BUHMI+YDNN50zcA+BwYzaYwBlv8nzxdA?=
 =?us-ascii?Q?bOjUcznjPrYHl/bD2WGxEK2jwcIv7i3N8N4IaSgCJUZQB4qsbSfOdzSsxv+a?=
 =?us-ascii?Q?5B1vTqMmdnsCk4PFcLvtTeCYVJSrRah7kYCq0LKD4tn4vAibiyYRB49dYXra?=
 =?us-ascii?Q?QXCilR7C8KQBUw7GWEbrhQw2x0WAAuVKpGUDP8I2b35xQm2IBxLH46UatHvD?=
 =?us-ascii?Q?9PwSAdttAFErV2OJo8Pun/JfoQAh9X8WY1iaiHHba583Pt9TXb3t4xfWccJX?=
 =?us-ascii?Q?DlJvsjE3x4vc3rgQfsE6LVy0GLsQRFhB0Jy6hU5JH6Oc72M8n6XyYYr4qvGf?=
 =?us-ascii?Q?aHc8s4NSFtpAGCRibAt3r6sdTax8eCTLI3uoLVod+eDZbpZ/SN72Bwkt6yL0?=
 =?us-ascii?Q?IUPBNhpOjSpdkGfKz2gL9ac9sIU3fJbd1dods0LreDon9pt4kju2+MpSZGTK?=
 =?us-ascii?Q?abxkRKf1e+BFSAUwladdkCzLJXv/ZfrzlspD/xF5boLoAA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6305.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/MIDs0SZDRIE3AVvs06epMJPEoan4pT63+NHSwpjJb4+GH0JSYvq+oVF56OK?=
 =?us-ascii?Q?c2WaH5sV+Nb/mTr0ktI5s7fEhaLerpXuaLHcCko1hfybg1/voPJbLYVKLpc6?=
 =?us-ascii?Q?v6w6+jHKhHeL0HBNyeq2bVLwyYuCNt0GyXwCnZlGuL4nJY8yHbimO9lcDszt?=
 =?us-ascii?Q?Ciyz7E7B+Por5kJufirC14dREzC5zBVg72q8MCitZjLgU4OilUCvcg35QvNU?=
 =?us-ascii?Q?zN094eYOpK/NQlp+B3WhX7eGVfgFT/Wn5TCLj6aSmTE4w3VTPsVB2j1jg70i?=
 =?us-ascii?Q?vZnueQ8GLmUFoUBIC0IdFQPXC6Sru+32UywHiE+2HhgujBBmWJIuKykkDM8B?=
 =?us-ascii?Q?2N13RC2JzlaZygsHSUDRlPQGCuPcS4auNgRBDluBAVTbNfHDqjJWfVRVtzUc?=
 =?us-ascii?Q?7amxcBA/3AdW1M+puTriz2YW6urIRJCURRXC4zrOvee8ZuhE25wqjHc1mAhH?=
 =?us-ascii?Q?HbwxHRZILtyeL/eGZd4l8zlY0FZOI7jxUfaiAPPLB3gfbOhSJhXwWuCIfAxG?=
 =?us-ascii?Q?xl1PhBquiNkEgz0+4+dFxULSP0EJ8D/taA0tsNM/Y/bInlT7r3MCX+ldqqQy?=
 =?us-ascii?Q?fXDeef2Tj7t1/hFtgtAtbJqurPpmm5wxkwf56QP6QNLi2HJLluUmvjP6bm0P?=
 =?us-ascii?Q?QG7H30LRQt1jcQdegig/JNhTbFP+f9JAYoJrubNMPhNhBD8W+fLBxGEKxdrY?=
 =?us-ascii?Q?nHMqs+H+qQdiSwGszXAznDrNr0C0x0tPBDXp0JRtzjwra86eorXHoZmVihAb?=
 =?us-ascii?Q?viWnlZynvnEoe/QVz1HKkDi1w8wqrMSDHpJXJgyLOi40aHDMFA8bE3bdbzsp?=
 =?us-ascii?Q?MuJbIrqxR0n62b8cX9JzjIjhke36VhRri/i5mAsVfYFDZPNshLHzy+sjGDEc?=
 =?us-ascii?Q?w0cU0exvbkR27msY/si3NryjYLIH8OrpKjHUwnmWHlFQ1FaU041siawIVxgt?=
 =?us-ascii?Q?BBqcJQQqpCgCR9Pkw45ddmJxM/Un+pGvfA2SbaMqakAhn0/We97E8tdXvafu?=
 =?us-ascii?Q?hyqmt21FQUzik3WY5hWmW4Q2m3FE/yeLipTO8QTrXVLlJ2fQ6PQTsofqUjgW?=
 =?us-ascii?Q?g2URNpFEK/YBA235MSYWSj+g/C9/dMzRjHJKD2FZCDVYOBOrOKx1FmVUJwZ3?=
 =?us-ascii?Q?1oyoNRLha2lsUOeZftULqov/h3iBhtL+lqolvFHY0pqxUmE3VXHa+j6eG9HD?=
 =?us-ascii?Q?qUjx/l1B4EbBva57Jwts1GP5OYb4HPGlCSJ/0WzFJYbNU/U++vkhEyic04Y/?=
 =?us-ascii?Q?2T2BEGS8DsWKSD3y6sgcjoy0TYeKi/2xsvZohsKR7ysWdKR3ltxKWGUfAlpo?=
 =?us-ascii?Q?9Q97oaiLBapHfl6FjKmcnRfyI/6o26Hnjs6tfxY5z0mqyAjev7je8VSJtO1z?=
 =?us-ascii?Q?QBOzdZxmOxuVROZNbPJAdm8EtIzdwNaBGU7eTx9Taz17dotex1wz4qQG4Aps?=
 =?us-ascii?Q?xq4UnEgPNHLb//dmjuhivPmANUAKfqTKBcyipKlaKawsdMHuSxtRmCNzPgkj?=
 =?us-ascii?Q?6qmSNNBRdfRo2b5hGxC7iyS+MUnuo4MGh0DtSRtQLG10DDCIXbu+FXqqYGl+?=
 =?us-ascii?Q?Dh2+YjD0IHPcFBl4tV0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB630579FE2AACB62605A5CA33FBE72IA1PR12MB6305namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348263c5-c505-47c1-0a53-08dc7102d9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 15:07:03.5693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbzS253mncR/srPXwBwv2QwyOGLCdYNw7HoVmGDcdaApMc1SznK9MJf3Mtm9jGrXscfktJ8gomK7PIf3ZMqeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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

--_000_IA1PR12MB630579FE2AACB62605A5CA33FBE72IA1PR12MB6305namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Done. Split the fixes to 2 different patches as well.

Regards,

-Sreekant


________________________________
From: Russell, Kent <Kent.Russell@amd.com>
Sent: Friday, May 10, 2024 9:15 AM
To: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>; amd-gfx@lists.f=
reedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somasekharan, Sreekant <Sreek=
ant.Somasekharan@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commit

[AMD Official Use Only - General]

You should add a Fixes tag for this patch.

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreeka=
nt
> Somasekharan
> Sent: Friday, May 10, 2024 12:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somasekharan, Sreekant
> <Sreekant.Somasekharan@amd.com>
> Subject: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commit
>
> This patch rectifies mistake in previous commit:
> 'drm/amdkfd: mark GFX12 system and peer GPU memory mappings as
> MTYPE_NC'.
>
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index df0363ad1a51..6eb370609d01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -495,7 +495,8 @@ static void gmc_v12_0_get_vm_pte(struct
> amdgpu_device *adev,
>       struct amdgpu_bo *bo =3D mapping->bo_va->base.bo;
>       struct amdgpu_device *bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>       bool coherent =3D bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> -     bool is_system =3D bo->tbo.resource->mem_type =3D=3D TTM_PL_SYSTEM;
> +     bool is_system =3D (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT) ||
> +             (bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_PREEMPT);
>
>
>       *flags &=3D ~AMDGPU_PTE_EXECUTABLE;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2aea33d2c4d4..6175800f50f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1253,6 +1253,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>               }
>               break;
>       case IP_VERSION(12, 0, 0):
> +     case IP_VERSION(12, 0, 1):
>               if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
>                       if (bo_node !=3D node)
>                               mapping_flags |=3D AMDGPU_VM_MTYPE_NC;
> --
> 2.34.1


--_000_IA1PR12MB630579FE2AACB62605A5CA33FBE72IA1PR12MB6305namp_
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
<div class=3D"elementToProof" style=3D"font-family: Tahoma, Geneva, sans-se=
rif; font-size: 10pt; color: rgb(0, 0, 0);">
Done. Split the fixes to 2 different patches as well.</div>
<div class=3D"elementToProof" style=3D"font-family: Tahoma, Geneva, sans-se=
rif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" style=3D"color: inherit; background-color: inherit;">
<div style=3D"background-color: rgb(255, 255, 255); font-family: Tahoma, Ge=
neva, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"background-color: rgb(255, 255, 255); font-family: Tahoma, Ge=
neva, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"background-color: rgb(255, 255, 255); font-family: Tahoma, Ge=
neva, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);">
-Sreekant</div>
<div style=3D"margin: 0px 0in 0.0001333px; font-family: Calibri, sans-serif=
; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Russell, Kent &lt;Ken=
t.Russell@amd.com&gt;<br>
<b>Sent:</b> Friday, May 10, 2024 9:15 AM<br>
<b>To:</b> Somasekharan, Sreekant &lt;Sreekant.Somasekharan@amd.com&gt;; am=
d-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Somasekharan, Sr=
eekant &lt;Sreekant.Somasekharan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous=
 commit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - General]<br>
<br>
You should add a Fixes tag for this patch.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Sreekant<br>
&gt; Somasekharan<br>
&gt; Sent: Friday, May 10, 2024 12:56 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Somasekharan, Sree=
kant<br>
&gt; &lt;Sreekant.Somasekharan@amd.com&gt;<br>
&gt; Subject: [PATCH 2/2] drm/amdkfd: Minor corrections to a previous commi=
t<br>
&gt;<br>
&gt; This patch rectifies mistake in previous commit:<br>
&gt; 'drm/amdkfd: mark GFX12 system and peer GPU memory mappings as<br>
&gt; MTYPE_NC'.<br>
&gt;<br>
&gt; Signed-off-by: Sreekant Somasekharan &lt;sreekant.somasekharan@amd.com=
&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp; | 1 +<br>
&gt;&nbsp; 2 files changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; index df0363ad1a51..6eb370609d01 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
&gt; @@ -495,7 +495,8 @@ static void gmc_v12_0_get_vm_pte(struct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D mapping-&=
gt;bo_va-&gt;base.bo;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev =3D =
amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool coherent =3D bo-&gt;flags &am=
p; AMDGPU_GEM_CREATE_COHERENT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bool is_system =3D bo-&gt;tbo.resource-&gt;m=
em_type =3D=3D TTM_PL_SYSTEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool is_system =3D (bo-&gt;tbo.resource-&gt;=
mem_type =3D=3D TTM_PL_TT) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (bo-&gt;tbo.resource-&gt;mem_type =3D=3D AMDGPU_PL_PREEMPT);<br>
&gt;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags &amp;=3D ~AMDGPU_PTE_EXECUT=
ABLE;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
&gt; index 2aea33d2c4d4..6175800f50f3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
&gt; @@ -1253,6 +1253,7 @@ svm_range_get_pte_flags(struct kfd_node *node,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 1):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_node !=
=3D node)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDGPU_VM_MTYPE_NC;<b=
r>
&gt; --<br>
&gt; 2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_IA1PR12MB630579FE2AACB62605A5CA33FBE72IA1PR12MB6305namp_--
