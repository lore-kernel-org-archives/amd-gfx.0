Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE6AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8D87A346;
	Mon,  6 Dec 2021 10:21:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600F97327A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 06:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX35PW4y7e1BCjkK0iLnESQQ5yd71c5Q488QUNoCFyLUhMw6xT/hZrXsC0R08Pen8D8N3Ncav3KPvRRDjFbWe03PyjMdy8J3ov319gr844p3E4z/s99OlAMpAN9okzMHJOw3oqZaRhAyq2trciJa/MdaHNfV2hTrJj7RsDu9kNpY/UCSh5bS2cAysgFoYaCShq4/VjsFB783Jz1eYnLe8VNbWZ8yWNpieUVUiQnrzKe/HXMqqE9VNImrIvfyFV9xDKwgCJAd0+5KIft0Ag1nVr1YZ6mxfTYB7400Gk5glW8MMv8Hd7RuceZ/ghrw1H4hA4pSPX2XBOTkusymjxUVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxWyQeO/Z7CM7x++ertkk5uRqgrmueQZeYesfdEKJrY=;
 b=QQGSp5pH42dMemtUnM7OWXUcCkJGMfFMFDRijcA8PQXxMTBcn3RCZql8Peb9ORPpAHbyWl2pGFlkUKGnWXIaFYGKN66taojGZzSfpHcdNuIffavGUZr3e9AhYlh3ex4zy3G26UrpavNswGVrLdbLgqNODwBcIDPbfVT5cPeq+FzUfML8kqfCqw26JJ5QpQYBaeMFAjZ1BuDwSsT34aFPTH0WF/RzB8Qvfe/CJ+dntu9z5LTEVgbI7aAwfYMO6BVYgC6qkTp0NLSRfIm+lXcTTllYgDJ9MALmXp7JZBh0UgduIhAUJfrYMq94a3tDbzRww73ZzIs/mgGgKGPacQDY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxWyQeO/Z7CM7x++ertkk5uRqgrmueQZeYesfdEKJrY=;
 b=jCHBc3Sv4ZPNmt2m/05PiCf8Qbiz5XawUwN6nnVUJroDGa0gu3RbGECnD3HPNmLYG/Mf4ywTunT0LPeC4IN+KkhoISalF8d8PZFhEpCFU8AOf8ZHPvSsMqB8D9BHu7eDBRz7Fm9k9Donj+Zd9tQR33IQbJ8T+m6rkifGRweA90Q=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Mon, 6 Dec 2021 06:56:34 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 06:56:34 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 02/11] drm/amdgpu: Modify the compilation failed
 problem when other ras blocks' .h include amdgpu_ras.h
Thread-Topic: [PATCH V2 02/11] drm/amdgpu: Modify the compilation failed
 problem when other ras blocks' .h include amdgpu_ras.h
Thread-Index: AQHX5qGxPW6fJ2zrdEmXTJuYnzNSQ6wlD07A
Date: Mon, 6 Dec 2021 06:56:34 +0000
Message-ID: <DM6PR12MB46501EE5EF1932B03243BA53B06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
 <20211201105250.298525-2-YiPeng.Chai@amd.com>
In-Reply-To: <20211201105250.298525-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T06:55:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1f28ac8e-6f06-4846-94a8-182b97659aff;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-06T06:56:29Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: cbf8074a-bc16-4c1d-950f-71053b24aef9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b9394c0-7225-4098-5ca6-08d9b8858a76
x-ms-traffictypediagnostic: DM5PR12MB1386:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1386CAC7E3BDC4C2FCA69C99B06D9@DM5PR12MB1386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5BsBLXW02s581jlWtB3KnhOBT7B6fWi89NbBVbSt1z6rs5QLx+D7PPrpvbJo0mlLmjXdO01N4dkk56bhiQxQ4dokM4RcdHoT49kTT05M//BZ0PXDwahLCrsJSNs47njh90p088I7X6mKfinagOCV3BX/moE7eRNB3zQ728prfvC086SX679MkOBgo1vMpfgUBLKyAxRXF3BgX3zHZTacM0PXDsVmSb8F1IMLLFzvxVkTVWksHVVizt9jWRedxpAyQWObdJxeQiVIjkwOzykohge8HMHsUBEljShU+ldyTVuPR9zKm7xcw1hlCU/pIFcn+KFavVQUsW6d8tPcNDXdTyBaWpBnNCQRbzobiNkwy7jzvNATEfz4ScNwCyJo89fUG8idoMmxl+YWJfiFDfvVmT4UZkBUf91Ir43APN6fMFOY9FVB7mJ9f3jqRSX0AiYwMGy+e75x7Jntv835QDj+2QZRX2i/vP0HecCloqhGqfJcqL7QDyYB7zC+EqUJJde5ymfeusKBfgouTn6a3aTdRUbNcW2ykNvrJ46hs1Lf+ZiOwOvj6fofVKlLL308+r67gxQWFiR8yN8RMpL3v+GTKExUIpksTwdgANr5vMvjdx2jB2L7pbox5zemhB7J8/xmeP4RTJwaGRRiW2O2y3PxZYZnPPZy+VA/DXkcBKlz7O85HMu6UW+TMPbDXFp1776EEP23iN1NuujTxX9kCxGyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(8936002)(186003)(86362001)(55016003)(2906002)(4326008)(8676002)(5660300002)(110136005)(53546011)(52536014)(7696005)(6506007)(33656002)(316002)(26005)(83380400001)(66476007)(76116006)(508600001)(66556008)(66946007)(71200400001)(66446008)(64756008)(38100700002)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C86e56dpbSfIy5hbNKxFO1CIxLMgiKoJiU7Z+m04Kd/Tt/KoZOrd7Bhoxmfq?=
 =?us-ascii?Q?MMqsy0B9N00HnMtJ1trM3wVCBsXxqKsa6hmdGlTX674RGu5KcrFEk5iYJF7Y?=
 =?us-ascii?Q?IPiWvDlUMffxjljMA8ZkSfLmFwOKf0UQGa8wBbZx6Z2eB/tzHOe3z6F5mK7w?=
 =?us-ascii?Q?xrm/vwtEVPbx8r9LrJK2Al7yx8nA5y4z3uWOs1ptm/gqKXyY/EjjwPcciAb7?=
 =?us-ascii?Q?X3HaxS1YgQULs04Eq0GO2ViO2X4mcldXf1cHnCVTTB3UtLD9noN1E96xEUG2?=
 =?us-ascii?Q?RoHAJeTGFruFkaVNF/XNMJW1Cpd6aJJIedhfgUiSZ0IsDQi+cIaEVxahLnhC?=
 =?us-ascii?Q?1av5kEj9Ca8eu3Ghzwp7K2SMPDrgKq7kQs+cQ+3Dg0Tk7FBUDoV61eg9SY/J?=
 =?us-ascii?Q?27wLNYivxZeoMurQKxb5NDZ0cTec/Z+iTncS3ZiNOsBcg9iwWx5FPOc6JC3R?=
 =?us-ascii?Q?h5/0t34I8a1mnTYOgXpOJoqobAG+uPsCEhNTT6u9co5eFPt3GXsa0/AsCEGN?=
 =?us-ascii?Q?eN1kY91EHCqtOrLuTMqtpLtretetLCQPb+lP+KvDDGIUaXV1GO38beJ9M6kL?=
 =?us-ascii?Q?QJUqv4PJF9iPyQjODH4zI0DicAh/rM55u6W/RE8ulcdx69FHF/5cpYsz58VP?=
 =?us-ascii?Q?LVoPziUmRQEclLOIrMynb94fWYW6hSfdqQGbwB4BUk1YgilxIhgPstmUQULP?=
 =?us-ascii?Q?6Z0cVFAqROoA1ZtN8jmwK5zkifqZhc0YkQr5C7mkNsubXrZVBbnnBbmGnDW/?=
 =?us-ascii?Q?lcYe4ry16iGXVF0bmobuLzSC0i9st4dkN2elmYjBYcsnlIidoVvX7OfjLq2j?=
 =?us-ascii?Q?YiNfEwSlEg0n0YtBPZ9av6MdI2gehtv50bdPluUn/RpZs/TUbdUxT4gRd6Ua?=
 =?us-ascii?Q?XOSoP0uOBPAJCKhDOwgiFa2AVhlHwdHS+wW3WZIV0f5fPVB0Trj4uL1ZDl+8?=
 =?us-ascii?Q?93ON49ZMjoHCVybj6ukaiirtKOxi0pfJ6CCx4/ZIz3e3/GluvVOVvgZadePr?=
 =?us-ascii?Q?mGldi/jrCFGja8kUHs+m2+Nvo/OUOliFilio/mJ1pZCOFKORRhytqYefICxq?=
 =?us-ascii?Q?0C+4cNBNOx+YFlNjGTfiuK45a7jdLx4NSBuIp1KwudXrRvvfwTicW5RDnehq?=
 =?us-ascii?Q?XybxsX+lPOQm3G+1qYG9Ar9mLiIspvcjg+DDSXrOJRTmZKbQOcKETs0bvuvV?=
 =?us-ascii?Q?qsOA4wMlXzdTllvsSY9cSP5L8mm3txynRvj0iUoq9YQynu/XQaFRWOLt9Bsu?=
 =?us-ascii?Q?Ar2ZMJ03q/mOMoYQRRjsqIiuWc4LUXfSKqiA7DqyZ0/KcqgVB/JwgYTVj4NY?=
 =?us-ascii?Q?DW4fPT86+/JLN9+ygjllWZo9f9CgSBpFfW+rz1Wk2Vvf+nv22OsxxA2mh2kw?=
 =?us-ascii?Q?mx9orKBH4ubNTuqr0e+f4fqDsxrVA3FnS0KjEgiGJlsSpZixO5t+qzMeDWPJ?=
 =?us-ascii?Q?ZXPdq/0uc5qsFexyz/Df+x8l51wNJlw/ElRSLkMB6Xg+UcndlC08sSDbRh9Z?=
 =?us-ascii?Q?TdIXO/z9dNeZ3EqZXgY/AFN57C8c/1MzGo5U2RFpTyRBL7fBrv56zqi/HHet?=
 =?us-ascii?Q?69bHCt6+Ix3ukHj7TU8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9394c0-7225-4098-5ca6-08d9b8858a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 06:56:34.1320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hvj013BckJXC3ORCqrQ9O6IXp6GejLpUWijNa3RZe6hrfIu9D66JE8xWpW6qnf9M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, December 1, 2021 6:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 02/11] drm/amdgpu: Modify the compilation failed probl=
em
> when other ras blocks' .h include amdgpu_ras.h
>=20
> Modify the compilation failed problem when other ras blocks' .h include

[Tao] 'Fix' is better than "Modify" here.

> amdgpu_ras.h.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 23 ++++-------------------
>  2 files changed, 26 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8713575c7cf1..1cf1f6331db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2739,6 +2739,28 @@ static void
> amdgpu_register_bad_pages_mca_notifier(void)
>          }
>  }
>  #endif
> +
> +/* check if ras is supported on block, say, sdma, gfx */ int
> +amdgpu_ras_is_supported(struct amdgpu_device *adev,
> +		unsigned int block)
> +{
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	if (block >=3D AMDGPU_RAS_BLOCK_COUNT)
> +		return 0;
> +	return ras && (adev->ras_enabled & (1 << block)); }
> +
> +int amdgpu_ras_reset_gpu(struct amdgpu_device *adev) {
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0)
> +		schedule_work(&ras->recovery_work);
> +	return 0;
> +}
> +
> +
>  /* Rigister each ip ras block into amdgpu ras */  int
> amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object* ras_block_obj) diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index d6e5e3c862bd..41623a649fa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -514,16 +514,6 @@ struct amdgpu_ras_block_ops {
>  #define amdgpu_ras_get_context(adev)		((adev)->psp.ras_context.ras)
>  #define amdgpu_ras_set_context(adev, ras_con)	((adev)-
> >psp.ras_context.ras =3D (ras_con))
>=20
> -/* check if ras is supported on block, say, sdma, gfx */ -static inline =
int
> amdgpu_ras_is_supported(struct amdgpu_device *adev,
> -		unsigned int block)
> -{
> -	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> -
> -	if (block >=3D AMDGPU_RAS_BLOCK_COUNT)
> -		return 0;
> -	return ras && (adev->ras_enabled & (1 << block));
> -}
>=20
>  int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
>=20
> @@ -540,15 +530,6 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>=20
>  int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
>=20
> -static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev) -{
> -	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> -
> -	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0)
> -		schedule_work(&ras->recovery_work);
> -	return 0;
> -}
> -
>  static inline enum ta_ras_block
>  amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
>  	switch (block) {
> @@ -680,5 +661,9 @@ const char *get_ras_block_str(struct ras_common_if
> *ras_block);
>=20
>  bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
>=20
> +int amdgpu_ras_is_supported(struct amdgpu_device *adev,	unsigned int
> block);
> +
> +int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
> +
>  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct
> amdgpu_ras_block_object* ras_block_obj);  #endif
> --
> 2.25.1
