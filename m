Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40CFCD8C85
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jun 2026 06:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25799112D4D;
	Sat,  6 Jun 2026 06:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zQrF4t7e";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6217F112D4D
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jun 2026 06:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxw3sAjo5StwslFCZYPm4F1+EMATjgfDQDVxXEw+3nsk/Lp4OAdiN4FpmerVA5Si2IcdxTY4DM6EAt7ra7n1rwMf72Eite6hMkckq13g1wbPH2nYdG+bvNyastwFj1BZVcmGmqK11BrvChIzGatTJh+cYjSJNwzC/Aa2gd8CPRBjC9oZg30qbtU3HpDCD1rVB0PnMHfbzllZOQn+t7UItzssnLnaDUD1r2Zt2f9UIytPE6L06QGCyev2e/dY7pRmweyt7aSTVAeC6OaoMSyxasVqZSrh2iDkgnaJwVW52ilM4Gf43dW+nVkE7vosqQXMgKNNrP2v3jfU4c+TIOwqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A1G3VBvRoxCNtOKf2EHFKdP1pTZl4zDmuVFJYMyrMc=;
 b=BlCWwYxyYsG7kGFF1iZ3TQtEbuXPXZ4qepQp8v19nLXGSbr7ORy4XMbP/cBjKCFk2deZUyKQeLDJfWntE0zPXDSyxXpJUjqR0fmxHv2pNzOfKr6Yc+4docj1xkxTS9pwPcZk5YG7+wpzokMsnOgk6S97DZyZLq9renruF1MuU7PeczFMm5ekU+zhc0fc2QQz6UdVBB3aqsajkNPTx2klBcFsJDv9BLInnqvsJrs7GGCyJ2WN7GGiczoTkA4GzS2IqrV6TWw/kigtMGLNdnvGHvj2X2fv2qF6d/t1EeTWgLLEOHP7xhJYjXVj3f8huLqkqIAy3mW7Xy3sSuzZUqHaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A1G3VBvRoxCNtOKf2EHFKdP1pTZl4zDmuVFJYMyrMc=;
 b=zQrF4t7ehKGX2xtJamobtSBU7Os6iu1U6yahZWQhc6NdTAIdQ2/whT1MXmx8ZdCbRxOHnZ7zvqB5k5jCPQi5ZHlQ6u8rudCTOiJJpolYjlZUsGvVF1/b0yJMVJfKDNsp52JmnhZno2lBO9hDIHTUIF1HRUisHD7tA52Qq8Pa9+0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Sat, 6 Jun 2026
 06:16:17 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0092.007; Sat, 6 Jun 2026
 06:16:16 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add gfx11 queue/pipe reset support to topology
Thread-Topic: [PATCH] drm/amdkfd: Add gfx11 queue/pipe reset support to
 topology
Thread-Index: AQHc9Tr81FHvzpzM+EyMCuurCDTpoLYxDM2w
Date: Sat, 6 Jun 2026 06:16:16 +0000
Message-ID: <DM4PR12MB5152B6DC57ED0A7B01F40BE9E31E2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260605223037.3767958-1-Amber.Lin@amd.com>
In-Reply-To: <20260605223037.3767958-1-Amber.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-06T06:13:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CYYPR12MB8856:EE_
x-ms-office365-filtering-correlation-id: 8e4acb52-a659-43d8-3e86-08dec3931e3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|6133799003|11063799006|56012099006;
x-microsoft-antispam-message-info: od0jgJ5KqvtYDFr52Lq3cTThYeCfN5bCukdjsqhzdzBL0Fztih/WURhSWdYfTqSEED43rrqpmbBpyH4kpsG/AciVMLhLtpVQ0uNbJkQPrpvJw+8evVm545/FKPnmavTby5g/e3BngekVDk43mJMIkxf/6dKqCBP2b1/MxTgtkws5KyXeys0NU8Z+RkKxWduv1mJU6QDuL9wnYd1Pr1Rdpa0r1y4SqkQxE5vcXAjJBz/SaS1EZUrKh7blujq51GphC+mgWybHfwRU6y/B78QXrzoGxYCR8wv1uStQkNYmI1ybboeXPI80T5Y/T+mgq374K2gzgAIX70329BTyyycmj/lHC5yyRA8GVkhQtWZmz1vQn6QwooyWbAWMG/PfMU6P5iAm00GcBhATya2HzfWEyIWdIlBJAwLXjC5BuhnbyH4RdTbl17PvzCyW7Fkavg/+MeyC9aJn4XohTO9sIITR7w8+84DczLtZA3FUOovBn8ikHpJJDeeOXXY2KMCwZNHpr76wyP4dZZWnohWH9cgUVISG5/Q9kN9CnjAPdFFs6NuG1Rujzb5UNbwcGX+K2h91lfV0ZCI3xo0p0G/opLzs2O8ygqMppLW9bLKDqfN+0eiMl+8pL0NacxP29YjPkxbuY+IIlRtDU6/D9ZPVdyxDMtmeiT3KmqCJ4hsgIyeMDOsLkR96TSYaUF7aUtXte9vSfHnu/vlbnkEKdYbU3L3NKpiAFhc4ZT8YoMEKqkBQd3rIH64dkADeq/Q/3DUT0UaQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYbdrG46V7bEMRFb9Q5Dpz0gpXdF8M98vLWJuzze/v21GjDkCcD7y+V7v1Tx?=
 =?us-ascii?Q?nuOsappwH+gW5Hg085Vdk3TkC+rBHNItGD5aI7Hhy6eGCuGJYBoE9cnI+tlk?=
 =?us-ascii?Q?Fd8J0FE6cxW2Ju0nhzTcU7LvkObQ/kz7+UwwYMZyvWJgKygMUepmJ+U70NPS?=
 =?us-ascii?Q?iwqUpmTaL8vZColOdw7hCDfUK5GwdLUo+nmpMMFgWsaoTAN8L2f0NyqfNYg0?=
 =?us-ascii?Q?cIZqpPApG2clizukzh7Wndb4u8T2loPcOIL4ip46PTTEDbi7ylfZaHXB4AHW?=
 =?us-ascii?Q?LYCm/Ja0QGvsKkM+6eGXhjpkpAnphorL/JwAgmu1689yCT7HkjdWFUReeeW8?=
 =?us-ascii?Q?r8gH7TrKTmh2fI2ov0XYFB8awjH7LEQx6+2U4n6Qu+o0lPO79KBcxn/4sGwn?=
 =?us-ascii?Q?00bAwaLDFSZKSVF0m9Q2ppwupNNWsUrE3WS8BexU26vePYHILcZCLdMI/UJV?=
 =?us-ascii?Q?1Dei0SbOFunQTi3HN4CD76QeoO/VrUreXPr6JtzFA6jRkRULyUSdpkrJh3dr?=
 =?us-ascii?Q?wfveuIMpt7mkQBEKZC+4QY5l7Q2WWI14IZYQLkC4uDlBz2tC4r/DHgaecV25?=
 =?us-ascii?Q?k7gOM9QyhUH0VFbUoxrtSbEBgnVtN27Y3Ev4j/Na3p1rl46nkfrQg5tWvWhe?=
 =?us-ascii?Q?2A9StwCPfvU9Pt/HYlHxG/Za4LQNkAJf1kx+iq07aP7w//GJ4w2zvJgPIQsL?=
 =?us-ascii?Q?azjo0QvTELa/z5dko4nDHYrcg+6KqLweayMdv8oNM1c8BJyKQ6CDAq1phBF1?=
 =?us-ascii?Q?KNS+yjtATXWe/0VkmVH9oJhnIXBWlxEWXHTnmTM7NUCgFIWyCQYSk4ELt7Xg?=
 =?us-ascii?Q?iVBTL97dlw/1+ODGCfWuj5DuYEHP8h7O4CidT4OTIqt/EDugnLoiokfMWg4Y?=
 =?us-ascii?Q?WLQ1EUjOymorbgDpqTRNHQzYkgfrbWDvaSl9FdnZAFoC6Bl9W6TY2LrKPvdR?=
 =?us-ascii?Q?NKUbNekiUwhQuFaj4vbBFaqqHNr34fRnXxHYXqZSlEKU0bbdYQcGDyMdG6NS?=
 =?us-ascii?Q?QB4hhufhvRG7cz4Bi8M1feUJ8C1utbxuVTdpemQHYtLbtdARIBw13msY5baL?=
 =?us-ascii?Q?GTwuOLZQoxA4CHaNb4CsoPtGZdYxdOYeuOXpdylMj4lQyK8z5YAJPr1+k745?=
 =?us-ascii?Q?CXbzSX3/m7SNfgIQJ5ulkTHCiY2FTHxQWbWOVd8ZaBmqm/Yx2DzwgWgu98+I?=
 =?us-ascii?Q?MZ9AG9DtCfRLYdmSeIdFBIb1KXrMRIwAkDV5qQm/NGZkyfbQq2TPA9aRBpYy?=
 =?us-ascii?Q?W2sirNXrQ0PB/iH/f8hcAY3bze3m7heyZoev3B9j6V82MmsexeKY2UOtOBUx?=
 =?us-ascii?Q?nYK1vCEVKoNmibpVkIQ11JkpShFQWMhm4A7DKyqEvtiqUFUTj4XKTpXZPb1u?=
 =?us-ascii?Q?hFSGkHRfkvB0G/vHP+PK+1lD2i6ukfUVUtFnmPxBNX+UP/dDxiYD24Z0O4FF?=
 =?us-ascii?Q?+hGXFxaFsqdrWXn4T71vxSJnLYtyBqzIbFhwwvfHgmS2itJt5ePEsbM5S54p?=
 =?us-ascii?Q?P91D+NvDUsLIC7+zfiQYAWfxlZBv6obFkhTgw5gq88vlgtYUDgrHR8QYRmDN?=
 =?us-ascii?Q?qlLTETnmQK7Z52jWGCYTx0g8qhjS1EGuIVqU45f7+D6aIa5iuBNbzwr1JtA+?=
 =?us-ascii?Q?wJLaranWU4tmXnB1BXOo28FK+MBQyHrDJ+MaNsq/yFRUeXazDUPB49hc8dp5?=
 =?us-ascii?Q?x3isVviD/1XDSVKhan32isoJI+YW2rUMBqJC2z/5XDKSgVxo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4acb52-a659-43d8-3e86-08dec3931e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2026 06:16:16.7748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: engDAb7s92GtuQsmCLrihVdNBZOr1Ojqx0mHa1Z9JavSvbQ45r3gw385Fe2oVNClGSbNqH85mwzc+oALIVMw7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
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

AMD General

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: Lin, Amber <Amber.Lin@amd.com>
> Sent: Saturday, June 6, 2026 6:31 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Lin, Amber <Amber.Lin@amd.com>
> Subject: [PATCH] drm/amdkfd: Add gfx11 queue/pipe reset support to topolo=
gy
>
> Add gfx11 queue/pipe reset support to KFD topology
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9adc852e5c2d..3a8bd3eaf12b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -210,6 +210,7 @@ enum cache_policy {
>  };
>
>  #define KFD_GC_VERSION(dev) (amdgpu_ip_version((dev)->adev, GC_HWIP,
> 0))
> +#define KFD_GC_VERSION_MAJ(dev) ((KFD_GC_VERSION(dev) >> 24))
>  #define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >=3D (IP_VERSION(9,
> 0, 1)))
>  #define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\
>       ((KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2)) ||        \
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 0ff793a17857..6c3734db38ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2024,6 +2024,9 @@ static void kfd_topology_set_capabilities(struct
> kfd_topology_device *dev)
>                       dev->node_props.capability |=3D
>
>       HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTE
> D;
>
> +             if (KFD_GC_VERSION_MAJ(dev->gpu) =3D=3D 11)
> +                     dev->node_props.capability |=3D
> HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
> +
>               if (KFD_GC_VERSION(dev->gpu) >=3D IP_VERSION(12, 1, 0)) {
>                       dev->node_props.capability |=3D
>
>       HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPP
> ORTED;
> --
> 2.43.0

