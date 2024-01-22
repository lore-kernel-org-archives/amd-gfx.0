Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB41C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 07:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB1510E5F6;
	Mon, 22 Jan 2024 07:16:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB83110E5F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 07:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt+S0G4NF28oBwe61cL4e6Cx4nN536gLbguHSv/PRyU3S2u7sqD0oSjMYG3FlLMDDbCb9NlW+jfADeESnZwnJ6ASSsWQ2F5SCG6cEMrp3xPOKVW7/DBKYWybjZLPkCjN5eWnuqgTc3sflGYT8q1D5LgMmW8+oEYC4RXNx+AeJ66yog9yvdBcEG61moK1avzbup4SzckiPXhYtMIo8sCHYAHSP9keJKNsTuOueZCR8wTiuYPLUrfoB90H6aqzAIgnajnye+N8t8iMNro73HhwWpNNQwzBM8lbTH9+vP4z/CvgRuS8LXodwM34fqzdByYdFXlayYm8CeEyzS1REk66Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPbkSKdaRnaiXArBDlMArKxC8K813k4LweNHEpa5Myo=;
 b=D3AVpyff3DTJ7sMcPsZuw/gsdc6bHA5LCxeoSVT3a8Fu9FLHLE0vBqSS3tiBE2/EhWzHJnZd3UC35ur07te2e5pEF69NuWNRHbO/pKcerNLDow13OdaK3Xh75HmFgtFwrv731xKeND8U7NNl9GxmFWRytd2Tt3RyEjptn9C3dwaDK2fmYTIl0m4f/gDjmxFyWuunIcKuh0z5tsTt6VRxEu8KWA9di52p3hCgTLgOKph3wk4590b3Ki5a3rZzic2ff2F7O5q6BJriOxme8Lc7xzCNhrCdo5cTzpM6q4nnLWCqdbqA9fJhi7EllfP5O1rUVvPIamuNT1mq9K7jCTZpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPbkSKdaRnaiXArBDlMArKxC8K813k4LweNHEpa5Myo=;
 b=Pt0UsbbaRMvDobgZOg1PPLX2xTF+MZRljQNnHhkQ8qgUe5FpS8vjJy3EdS+q3ZuvxiZEme3gAwAEskfaF7gwBL/PP5/wXIRhS0bnZQRRu2tlbzoMbAvup7BlKa7JCgvOUBjzDJNc5pY/5jne0C+jbYNidw6kK+OuH7Mkg21s7Io=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 07:16:25 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7202.020; Mon, 22 Jan 2024
 07:16:25 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip call ras_late_init if ras block is not
 supported
Thread-Topic: [PATCH] drm/amdgpu: skip call ras_late_init if ras block is not
 supported
Thread-Index: AQHaTPPkIDw2oEkfTE6yb622AeBMirDla+BA
Date: Mon, 22 Jan 2024 07:16:24 +0000
Message-ID: <PH7PR12MB8796AA0E7E6DB9A4239E940FB0752@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240122052834.2995698-1-kevinyang.wang@amd.com>
In-Reply-To: <20240122052834.2995698-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=910d18d4-e4f6-4ff5-8923-d5fdca557201;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-22T07:16:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB7945:EE_
x-ms-office365-filtering-correlation-id: a5ad2d13-519c-4555-9f9a-08dc1b1a0b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6O1VvIAM9QXeEL+asJUL1EE1qrt5bvWdGWYM7Bo8GJXyANgW0seyj5hrTCPsHXwtwQKTymOWCahkLRpYy7g9iaZPdSOWrYWH6gpLx8qedWML9EIdnLJgq9frjoS/XoxQyQ27d9GUzoghO8+8eSsX7SBcP9UvkbxxtGWuewnhym6SBdr+Iny0Kk8ogqx3TZK2LjDM2nNp6SHgUflUgYiPOgC/d4Z9YeqktkmCrh7qqWlNR+SYAnuH5PHUwscOmHPBcclOPejy39x9K9rN4N/bBwQki9QDgtoqLG9VOZcK1VLxKbAsAla4szPrsFvD04ILCcPvg4ku8gt4PCKzc+G/7foPjm+dMnrZJINMs16YJRBhSUWRps/4rsu2jByoCL94bbJ72wyp3zAESJaBDPylizdJEpvPlzqGknWXNC1M+RmxffqL+6uCmHop7jny10cq2bBJ5zVFb9F7CkwZUBRrY+/PO/0emUZantqEnc09uHoJWmA/MpP9nYeYOiwtyRvDNIVi/dsTg+QWHdzTGXIzdrYmoPgFTNPGjIbwaF7Su6OX5c0Zi55wDgCLPHWfvBWOuqEU/jlmgH8DqWnL4oqARRLrRGBJ6aIbsQsHsnVDJ8ENhsTT5s8Y8gRGGDu2ya2XTTo/9QfHMuD1mBzgbI/I2A7IkxggwE1fg8uXCkQvnI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(38100700002)(26005)(71200400001)(5660300002)(53546011)(122000001)(9686003)(4326008)(8676002)(8936002)(41300700001)(52536014)(2906002)(478600001)(66946007)(64756008)(6506007)(7696005)(66446008)(66476007)(76116006)(66556008)(316002)(110136005)(86362001)(33656002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LX+na1Lo2TpT+TANIHqFUlLRhkeqRJY23a4zUfM/kNu9Q7O/vxeg9WcdV4Nl?=
 =?us-ascii?Q?KU1kGOmI7CMXrWAZYPWwplAfh5GRhQboKMdP+VMjgWeO2DzuPhMWc++kFxsN?=
 =?us-ascii?Q?clPkjPbgkgVfdQVx7zsr9DEW8YjZhHw94JX61M12pt/j9GixW3CsNX9K2Qil?=
 =?us-ascii?Q?HUdd6VHYfkU2y5QH2WUlEdhKkcKCiwizCMc/fAWQ7XTeS5NwMMna93KkW58X?=
 =?us-ascii?Q?xyr5R+dzBUjPaMrSlmi68UXVXpIZfuy34WEnKpUS+8XqKSg0B6jzDn1OuYe9?=
 =?us-ascii?Q?yPiG0e66yDQleptZ9TV3NbvT+XfHwKkm0lewwTYeTzaTvjCByVtU7kT6aLJW?=
 =?us-ascii?Q?Y91ug4At/Tm/bPAlmy34bYeIg7tM1YGUgpl+Mu5tRF25Pe8JqrmY76TZI6kR?=
 =?us-ascii?Q?sl6r8mgb/LBb3J94toysDTdHHT2gOPDkfb1QQ6PpnUqjEVUE1d6hRGTZjt9g?=
 =?us-ascii?Q?nuUEUR4/PRdLiFq6hgYOu7h3BUYY6pFkPPu1wZEmPQ7eRegBYcXr0hkunXHy?=
 =?us-ascii?Q?9xwlPJYnohkLKbo1cOXJtCvvu5tx1viVH1X4SOTdbX1FBxzPikKmE0LPEmEL?=
 =?us-ascii?Q?jynfDS644C/kTT+QezfuQIxaEpUbBTlRUYfAfnjGRm/4uXN0vkKgwDM1YFtY?=
 =?us-ascii?Q?FQ79XJDebsSlO2hYp/qhCKHbPrB3ebyEq1klz2YxuOhKgrFxswzXscuM4CJV?=
 =?us-ascii?Q?P+aR6NzaGQvQld2rk9LIQPyRA/L8tExxjBCs76K7BZACpvWIpjakK5YD/A6V?=
 =?us-ascii?Q?sNQ6qVF5RlLAzXhu/AjLTPlBwgafYTbPMgaAXj1AwXrCpTU5LptWY3t3mYcf?=
 =?us-ascii?Q?uiwslDHSPd1wFHUct9qUjOSyujhbPd8no2Ez9RXX3HzZhj9juIB/DINy7VwH?=
 =?us-ascii?Q?r+w0rJFt6PETkpACavm+UoVLmGdZl19gCaPbmGzmw5Z1SEgCAxe9hCZstT8Z?=
 =?us-ascii?Q?nkWSkXWpvZAU+AR2O6Ru8fkOpi1yDM2yW3ghbvE9HqaCFdmHQvExbFx8LQxC?=
 =?us-ascii?Q?10SkN6WoMZLX29PH/Ebqgbom1o7qtxemHHwfTaWCSDU9jE+FVFUXjZxjUJ7J?=
 =?us-ascii?Q?8J0O0UHmXhSyvnTS5mWhqGYlvs71XOE6eTsyPFfeeYsoZ95Gs/7wIVP7lH8x?=
 =?us-ascii?Q?ttJFsN6qrNbrMYXUl/wWN/bbcHAEX+NCBIFaFrtD57AkOBdcew9mSISvioeC?=
 =?us-ascii?Q?M82yPqAsXkZk/lUArrWYd575bSWQcjb7hy47T1zYS2dV/bLhYhl0mFjS2HK9?=
 =?us-ascii?Q?ZnTSug7aNpEbJ6qc9MveLGTLncUvQHy7hS8fHQafxWsYxCh+lnbr8joJuQ8j?=
 =?us-ascii?Q?X3BCGjB+5dJtUbRqa9TM2Fnu2ZB3yQ/umfm007CenfCNSGI2SbJkRO03rmZA?=
 =?us-ascii?Q?yeGn4oYuhmWWhCWLPaQ0zbyTEse72XlA9w0ZP+r18CsMpxpabVH3DT9hqup6?=
 =?us-ascii?Q?T62t2EQb7ndVJIowxleP83JTtlR6OWXT4rncFbaHDgsLv96rE2r195KZ+sBY?=
 =?us-ascii?Q?p618jSJdh6aE6R7Y5XSMkUKRD3oNBK7+lWnm8PdMVz2FbppE60+mS80K/z2F?=
 =?us-ascii?Q?P1aefEPKLx5Smt9yw7o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ad2d13-519c-4555-9f9a-08dc1b1a0b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 07:16:24.9178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AF4GNF1IIavqSJauc7Lsq0pUONVUZH6Gr7GrNMFbblj2IQsJ7wtOt/Ykao+4/hmg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Monday, January 22, 2024 1:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH] drm/amdgpu: skip call ras_late_init if ras block is not =
supported
>
> skip call ras_late_init callback if ras block is not supported.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index f4fcb008d7ba..61ba7cd8345d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3346,12 +3346,15 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>               amdgpu_ras_set_mca_debug_mode(adev, false);
>
>       list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> -             if (!node->ras_obj) {
> +             obj =3D node->ras_obj;
> +             if (!obj) {
>                       dev_warn(adev->dev, "Warning: abnormal ras list
> node.\n");
>                       continue;
>               }
>
> -             obj =3D node->ras_obj;
> +             if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
> +                     continue;
> +
>               if (obj->ras_late_init) {
>                       r =3D obj->ras_late_init(adev, &obj->ras_comm);
>                       if (r) {
> --
> 2.34.1

