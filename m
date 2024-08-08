Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4267AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 08:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D135710E877;
	Fri,  9 Aug 2024 08:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVn7qG3X";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083AA10E040
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 14:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohhyk5KfUllLTiuUBjE8aTUNZW60N3hmUPGXhY1YAPklhoiyLfhwjUjw7JjKv7vsJamGyy9/hAesAd6+PJal4oOFw/+gsbCpfXPELc9sPBlpFcXhOi0LnVS94fFN3/9gKETbOW6ZxNbdiSym4mj1pslUJzpXcGiduXUR/TnVDTXwhqLEGGymUVhVoF0ocx2qAKsuZFcnlvSl2bAzzF6F4c4x/ZgVLf1fQuCkZM8DLHbrt0atXIC6GnioqXt5ulMZTjfaMDLHlyOvLsh6cuU+7zSBwUP17oSbGztabliGITiSFUW+HjLh6WfYcGFphZMHu6Ef7fZjNundZQuvvgoI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wAiAMTTVV7CGjzZFli7H+FGQ5kmAe8BA+OvxQB5u3M=;
 b=L5zOEtZlPgJcugnFwuBlSTB8hUTfEyOj16hujxSavRS4deHFMjbSnBk6dum5ETpQesgqk+ks9u7eJKE4eY+31KM5TrkpYMTP6SyZUG83QXphrrzlpCd5ENep69t76G78flbvKk11QmySGE0771uOoCpOuR788Qx68loni6g4N4wR/hrOnVgta3R8AQUlYX+yIK/MbJ3TiVX5xdzoVi6njH6SeCs6hvWyq4pjZhXNfikaNk9x0j/wPyAlH4lIDNAQa8gUoug4Kv/4IGf+pgBYvdXr6nl8lYFTXle33y2ByMxfbZhPhuefy+Bx2SuLCi6iu98f3K5DgYGgHkvJTQVBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wAiAMTTVV7CGjzZFli7H+FGQ5kmAe8BA+OvxQB5u3M=;
 b=nVn7qG3XrnFfi/H62LTJtIbfEGq5hlJfjf/QkgQ8iw/kgs7wJU3Los6NpnWr55/2naHV1LuTkOYcIR8J5TuAfM9GRScreAjwXivoSUduwOjeOADObQ//eOsLYXWnkXup0pmIPI9isqTvq1oOENQXAiSGGFQgunTRY4zkqbakb/Q=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 14:34:58 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 14:34:58 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, brahma_sw_dev <brahma_sw_dev@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add node_id to location_id generically
Thread-Topic: [PATCH] drm/amdkfd: Add node_id to location_id generically
Thread-Index: AQHa6OU/Nu36Mk1miE+iIXcDUqLs6rIdblPg
Date: Thu, 8 Aug 2024 14:34:58 +0000
Message-ID: <CY8PR12MB743521B22E907D89CE5E33A985B92@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240807161638.1647935-1-lijo.lazar@amd.com>
In-Reply-To: <20240807161638.1647935-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=64757a43-619c-4bbd-9828-4bcba583c93d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-08T14:34:31Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB7847:EE_
x-ms-office365-filtering-correlation-id: efd6035f-9a9e-4f60-0326-08dcb7b7473c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OySVvTsS8CwbOFCCtvsfMRnI8ESFOXkxAyEaut1cIHsEZWkj3fJmmWa4KeEI?=
 =?us-ascii?Q?jYljfIJY24wvlmocTelxcS1F3Evey+PQazjIDVEGPmwnZkUV6v6I2s+fCbXR?=
 =?us-ascii?Q?Vtkrd4aXr0/FOB9RFtdDKByRm6vqg3gvtN2hQePUult7RLshfQfMquc71aAN?=
 =?us-ascii?Q?XYfu9lhswpKQT5CJQlFpSU54EeW7n7cyE5TW8gQXOfxKjgxXlLTEC0HEKKyo?=
 =?us-ascii?Q?iCDIx5GXGm12Fxd1MxlnUE+AIambvYf7yA7xHKwvEW7E+ZEZJYYmyUov8gy3?=
 =?us-ascii?Q?nzZkMhw9LRZRK6u+hjQW8zU+xwGvBUD0ei8JY79JOqDaMPirYiv86kq07nre?=
 =?us-ascii?Q?q9Wu7Q1jtwJL/28QVpxzvrVakSmZ1eaUecFU8dB0SrsL8Q/48sMOB25rP0GG?=
 =?us-ascii?Q?jzUCRgzJjWjM7Uiz8TagSwTogPCgLlq65Nwklg3+gCd6hhLgHM6R5TUa7L2O?=
 =?us-ascii?Q?BaaEXtezEwwq4eU2cqQrkI+2BffW3N3zLY0p0PHu5CE3c1lfVcLyEr2rbZsU?=
 =?us-ascii?Q?RTxrZtRjLZdL4TpE/2Z5GiGUOnSNRIsIBbwDkKjPykRbmzrBfYvi3b/s0a+j?=
 =?us-ascii?Q?TFVsi0QNC/JxjnM87ydSW1wMgYsycBu6mD//8IQrG6JMptB0ffDJEeJ9afiC?=
 =?us-ascii?Q?Sy1ZELjj/w7UC+ioGq8dhp8gRDblPEJydvoc5MKWnnoyoKpPf1OyPY0MAgTP?=
 =?us-ascii?Q?woPAFqdqKwwQF68ppauyrDHEU/QvFs8W6gfEhEdXldsx8M4KI1f47vKY50R3?=
 =?us-ascii?Q?o+66CGekrawYWWcJPSQ18s4kelk24intenkq9Zm+3wgE73UOtqGZHGp6JzpT?=
 =?us-ascii?Q?X+DbLw/846Jhze9eBcK+X4GUL+/T9axLxPAMypfpFMJikaQH1i9tx3mOy6AF?=
 =?us-ascii?Q?CRZJ1QJnjrMVOZ53JkFxAXDFplJtlwC2ssAUizK3MoRPqg/OItaZdmwUwZ9f?=
 =?us-ascii?Q?im8w0xozx+UnjbxUVtMQFRGM9QkaYphJ5aX66ufy32nWAML3v3GWw46Ywb4A?=
 =?us-ascii?Q?pplG22vt8pv/pDLfbs6ZwFYqHaoPGwQWBeAoENoEAvdHoIrXIgUrR5vPOGF0?=
 =?us-ascii?Q?XrTKd6wHoBf9vLZby7zv8xo4takCxy8Cv0vxFBHyIF0bam3PIGjM6QWWnGnk?=
 =?us-ascii?Q?67WlUAzPKbQ+duC9vRw0YQqvA56bOuuxM4VB30J8ph8d/zp/k80WHQ+7/n8C?=
 =?us-ascii?Q?GANp1GxGQZUL0JhrnLEPy4lSax0ZN4INgPClrTr4HMKewJgd5zEtzGjS5EtS?=
 =?us-ascii?Q?NjFwplkawDZOv/nDrtTSG/Gj54Mcs5ZSzt5K20rKE1aEuXLoGlI+4pY1D8Zg?=
 =?us-ascii?Q?uQItW1cusgXrltwOvEYRuY5WlMw7sRTcQG6UiWyc39XK4sdNNamNE2TmB7fo?=
 =?us-ascii?Q?nnrUiWK/+nEEGvCKEEZnmt1s7PhTmd3vRTyU0qkAhsYsvlHS3A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k4SPkL4rYPY5jwrdp/l8KqW7lqCBzo/MS4rbXVzFmWXs5arhls9xJ+E/h6Kx?=
 =?us-ascii?Q?WFB/6oWGGHlpa6oLDSU8IiYzqMaIKeNmVdLTBDdRWUn77rzF+ewP5PxuliK7?=
 =?us-ascii?Q?R8FW+YBWTeLfxfqqep0wuy36aSE79FniZV4Pr7o2r0g+OvAqd+rlw+6wlK9q?=
 =?us-ascii?Q?CR3cTntqwS5mIj+xKCnds6oXVTwQYSL+21Pp7XV/ChA74BweFfyDtWA4BWxF?=
 =?us-ascii?Q?vNIdJhZ+I+809drz0biYJhGr1VNJ4hfVPJ1X8mvGyrUHRL5YNDmbFRQEodL6?=
 =?us-ascii?Q?C8dNZyIMYApql4VOF0VAcRp9yXH+g7PteHvq5A4j5+aIMm+qerYfxEyx28gF?=
 =?us-ascii?Q?WHBGnvj55ODm1yMoioB4tXbXqzMLX7qgIocHLawMpbIhkioQLfjwf0U2FRNw?=
 =?us-ascii?Q?OSUf7D2kbLMs9G1JQvWyXzssAue75WnFTZkZldnv0zfAtfUIjaYnwFbuI16V?=
 =?us-ascii?Q?Q4d5dRn7+rqqRvm7JT8WwufEiuKOls23vyA3OzsxLH7yW+ABtSIHsftkmYZG?=
 =?us-ascii?Q?r4t2ouG/8e6SMU8cJE5tFGVByB7O5JL1dR1WpuPifxqs+mhQ/QCHHbZr4OE9?=
 =?us-ascii?Q?GTfpqHKbi/o7RJS8tfwqYogtwAwJ7rbKNP7pUqJ4aN/Rx8HweT6MxJKOHKow?=
 =?us-ascii?Q?advx1qukzChkrhxEmZdJ49DLQnqADRsNX0/aTmyq91vTppYqiQKO70xaonfv?=
 =?us-ascii?Q?E82/JoVxSNcb7eNIPEjYM9o/Lqy6TEIUuPU1J1MvH0H//XrBiFg4dSacNmQw?=
 =?us-ascii?Q?X6E0E+3N0ScCCBPAYvLUk+ppBntXm51IfN52s0t9jD41ecAbHMNRtR+e42XX?=
 =?us-ascii?Q?aMQoNl9m+Qjd0Yza4dBpdIkzJzBw/Fui89kZSp7I0v8lE1b5jc78waHlffLV?=
 =?us-ascii?Q?A0HJ0ZRC87JjNE2K9q29KrnMwYwZnS6/7oHHb4lM4OVNNn2OcIFGoWNJ1Zi3?=
 =?us-ascii?Q?KYVvbI8SoHZzsH9461uEFi5Efwj8huwruv2odEHrRxS+9t2MXXlPSO1d7aBi?=
 =?us-ascii?Q?RPbsEtEcXdrsCtWcVezoFyA/gKCy7nrdwy3PJwtaNhmbW19XepQX9VQIeNSi?=
 =?us-ascii?Q?JNCNfs5aX9XAaDLHiq7lYgZVZPPKKrZp8YsD9jKISCJ75oqOkNGdwQjANIEU?=
 =?us-ascii?Q?Gzor9Bvx8QjBfIckIRxCVyM0f64lP7VoPLH0Jzns8e7pPtdsM1+sTupZC7Od?=
 =?us-ascii?Q?WQowJdLJm0VlAsnb+SNolZ3PLkaBXJTo/8tyEOCx+fLjiInAbWiJRSnk2Yol?=
 =?us-ascii?Q?G60GVkrNiEVsEDp2Or2/aJB9uth68oJMzIBlChg+qZu37bAdSMlDPSnYB165?=
 =?us-ascii?Q?9EQVDAIAyhhCjVoU5e7xxg9S5WVrOB+G7UjGAUNsx4b3RDQKU0Ty2X1cTwiE?=
 =?us-ascii?Q?cLdpSYGt06Pjv8DEU4wT15euy5gDCVdxaeayKfFUSZhUI/F3VWhZprZpDoIT?=
 =?us-ascii?Q?goQaRJIpEi0xZ7XC67Dlo5jrJ4mcY3v1TmsJfVmhFN9zNRLUCgOwkQ3Yvtqj?=
 =?us-ascii?Q?hPAklyVK0HTfFY8iUpHWrmXdzJCFlH46bcHH7Ctfw6DQMkLx4EfWWZkWPRmB?=
 =?us-ascii?Q?+LTmBfIi7k8SIq3vZdg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd6035f-9a9e-4f60-0326-08dcb7b7473c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 14:34:58.1617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iddYYmj3yTrUeTo1ZnAXAElaGFKo+b+digovqWEaSRwrl3PDqtwP3rV2BtkZegQj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847
X-Mailman-Approved-At: Fri, 09 Aug 2024 08:47:54 +0000
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
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, August 7, 2024 12:17 PM
> To: amd-gfx@lists.freedesktop.org; brahma_sw_dev
> <brahma_sw_dev@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH] drm/amdkfd: Add node_id to location_id generically
>
> If there are multiple nodes per kfd device, add nodeid to location_id to
> differentiate.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 40771f8752cb..e6caab75e863 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2079,7 +2079,7 @@ int kfd_topology_add_device(struct kfd_node
> *gpu)
>                       HSA_CAP_ASIC_REVISION_MASK);
>
>       dev->node_props.location_id =3D pci_dev_id(gpu->adev->pdev);
> -     if (KFD_GC_VERSION(dev->gpu->kfd) =3D=3D IP_VERSION(9, 4, 3))
> +     if (gpu->kfd->num_nodes > 1)
>               dev->node_props.location_id |=3D dev->gpu->node_id;
>
>       dev->node_props.domain =3D pci_domain_nr(gpu->adev->pdev->bus);
> --
> 2.25.1

