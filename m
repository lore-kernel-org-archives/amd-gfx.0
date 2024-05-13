Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5364DC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 08:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5C410E4C6;
	Mon, 13 May 2024 08:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s9VpRWDB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B53610E4C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meBcLCQ0Q+lUJ18c2ZhhmhuZnfZUxipCCElNgvcOJv8FvsyLZW+rAIuJ2Y32pO85Mcm4oho3OK5mB8se/gCekzp5hxWojnAObU+KpPJnZm185uNZn1SpjKlmsCrc9x6KlxiO41/ayXaU+mAlflKduVw089yJJeevsbO3cPVNdXDb5E/++eYCniGcT/BcCXaV+pGSbNzDPCzPErMLx+O78IdulH2Au9RZd/ZM+6fddEA3VeT7hkMdYklJFp9zifnUmh0UDhqPDubnSNzLcf+AYu+hMoR1IyNdu4pc6vsy+7SxLKdGu0qFvYCQH/fhazbKpzE8NOVeGy3kGyHGarxOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ozmcLKKdCasRO15+mqh2hsg3iXqD56jLB2F/PFRj2c=;
 b=hl2E0ZX6caDLVPMG56J1UFqwSBMzhWRZv9Ez9fx80KQu/Af0M6xtWx9m33CamAe0lFsSP11zWbD2iltxWy1VR7z1UyQ2scMU/7YG43py/u5wnPtTaOp4PsEUNiTf9sI+YcvQuAE+bAuHzh+y/NSOrrFSISbZ6OpYttstUEQ6M9K391aRckg7p30INFg1jsteEtAJ0DJbDPcQL8Znof/MYAfdawN5kmqYuLkfX5Y2J5IDfYslcPCIMPT/9Z2bwCHnaAWo7riN7YDszYHcVAdHBXBy0he1IUQ7Wzd1JX4BdTlEZO5IhzRE9IAJyTMPhzFn3E0w0gp9Z9EfQa8dPlj9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ozmcLKKdCasRO15+mqh2hsg3iXqD56jLB2F/PFRj2c=;
 b=s9VpRWDB+F7QuZ/4X1VD8hndkl6LmvKbrtbZ2oWDNpFZp5WZn/Q4V9hXMicViCTTxXrjtxriNoTsunotNJip2VLM/2XZXJu6548LWv3x9PlP32hfXaFkxmSH95VoP+d9ZAwrJTBpv7egiycW12M+obuph6gzP1nWVan6woUdbYQ=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Mon, 13 May
 2024 08:10:39 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 08:10:39 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 18/22 V3] drm/amd/pm: check negtive return for table
 entries
Thread-Topic: [PATCH 18/22 V3] drm/amd/pm: check negtive return for table
 entries
Thread-Index: AQHapQxoobp7VmJM+UibJejHXhBdWrGUz7qw
Date: Mon, 13 May 2024 08:10:39 +0000
Message-ID: <CH3PR12MB8074C75949DEF7BD8C6BF14AF6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240513080555.3614502-1-jesse.zhang@amd.com>
In-Reply-To: <20240513080555.3614502-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=120e9fec-ee32-4e7b-bca2-53fd446f6e52;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T08:09:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CH3PR12MB8910:EE_
x-ms-office365-filtering-correlation-id: 0fbf1fdf-6120-4910-8cd4-08dc73242d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?iLThA4jvh7mbWTmbrirH5rCGnQfN/8FXOOj/uNpj+A8dPMb/PcLSQZlD9I?=
 =?iso-8859-1?Q?gZGnLiWEU8Sou2OK3nG6cx47bTmEDOTD6jyHrlZbk0yg6GXFj9Pf9yhaPD?=
 =?iso-8859-1?Q?PsKiLMccnyr//6nxOa8SBPG42K75QtZSrM14tVMfDc0+gmvw4eQHQkBYIm?=
 =?iso-8859-1?Q?Da5mx4kTY4Z4RBCWm75X5e1cMBFyfucuETLKoTHNHs9+fjMg7zLJUOfLL9?=
 =?iso-8859-1?Q?DYv1qZWKD6YzzrQHNFgcX0ApifqE/I5UmlJTXHX9/Lr47/EmQt4UhpYL//?=
 =?iso-8859-1?Q?CE+dp0PetM0hE9D8ZckBWapMCFKc9bLLs7jOi3eBqH5CSTSw2k7x6sTujc?=
 =?iso-8859-1?Q?yA8vzMwO3BIAytOBUHYrLjpQLtGf6968cJUgdezCdaYq1njxV96LM8eplv?=
 =?iso-8859-1?Q?YgWarEIi1XXEFcbRcqVlbQDrmjBYrpq+CbAK0jECoBx/QJp+SXcqJw6sUT?=
 =?iso-8859-1?Q?Kupb/NvF4II2nci4CVVnwf2Ky8k/StenDdTov9QgLe1mzMBEjqhzx8dME8?=
 =?iso-8859-1?Q?9JQ/Yi86ZQ6dwr5XyZmPsVX2Wx810SQhxeHiJ79tLBmSPIe6NLP/MKYY9W?=
 =?iso-8859-1?Q?r/f+QErPzhTj/ztXZW/E1r126BF0rCn1mrqUD8v2nuV4keInhEWDfL5UwW?=
 =?iso-8859-1?Q?93ve4z9FJtel4MrWBxuO2VT64RIy2vK9Tjmy9iujI3gYonT0cN45o+qG+S?=
 =?iso-8859-1?Q?av30vXkPAVo5GPCOdJI6DxGncZccPjTx2PzDoWA3I3iZqNsEcpcUCZ++zk?=
 =?iso-8859-1?Q?QnbMQXpKFEkjB1IrRMviYmxBKyJRhq5RxYmTGYDbp02eb0OynUGfeh3ksP?=
 =?iso-8859-1?Q?JrZPXwaPXW1MbTjJWsN+UX1k3dS/yT3PgF+H+p+RWIO+OxD+QjlLS0R4Eg?=
 =?iso-8859-1?Q?dd0/yfVcCLXulIG1yN4lsVxCtzYDsKrLvd2OiAQn4E395WjxbwUE0bNTdL?=
 =?iso-8859-1?Q?UzJEZ+BPsXbgrpRoqKv9SPE/kxMDtPVaM6AsUbq+dWG4XjPD9yjJGitkKK?=
 =?iso-8859-1?Q?JddCd/dMBh6m9vqTl8g6IUpS/U/drK+qaUqyhFVziOIYlUrehdrVn609Tn?=
 =?iso-8859-1?Q?YT7gSHvof15kzF6WgL6tndW41G4NqblW+5nOLrCBGjQ9fWYloBVwKmyc95?=
 =?iso-8859-1?Q?mqs2VvcoKewAAEybanjcoBUmihoWYDthtkpXXM4nHLU8+4xC/xRvuLR8v8?=
 =?iso-8859-1?Q?bLXEZdvKsvtgacDhdPSnbP15nGG74cboymrK2or/I3vzeHWI1n4cQ7oT4o?=
 =?iso-8859-1?Q?SlBcWYgBSIn6UXb502m31L+3Af3f6DgACmZWfT0z7xAZDKUR5BQwHpkvyG?=
 =?iso-8859-1?Q?InPw8PD3JwhI/opCCW0yh+kJtfGN4IwJ6PF1CWl3mrAhNTKJakwAYA57i2?=
 =?iso-8859-1?Q?LQ8QiK+Lyy9FeBd8i8FwsS3Snvof3g1w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bc6wEIqn42F2ludAbdLgrphOVcMZieSZeM8ksz6CtwwVLs827zRdlCer64?=
 =?iso-8859-1?Q?+V/6MXl/pPO0U16N3Y1WeGBWdGrn2XkXABgEnsFGS3rH6y4Qb6ND8gVEpS?=
 =?iso-8859-1?Q?boUbqqFGkURgS9CQvoX7ft8nUK54LOLEwASOgJHQojPIM9PXhHSLaJc17Z?=
 =?iso-8859-1?Q?ujYnAjoFaewF1hCet5VEaqnk46RpZu+ZVHGWs8WvfEDSiWSKSp7GdarM5U?=
 =?iso-8859-1?Q?ywZcs2h5DGC1U+jJyFF+604PRsSsQPw+oGezsv01G36Ui2JxARSYLLqFpU?=
 =?iso-8859-1?Q?1ycn76ls+PQ0WlBjjL01B25qek4Du23igSiyeA2aVD8gFU3XPeBxdblxcD?=
 =?iso-8859-1?Q?gaUqFky1ajAzmhni8sRJjIIr5HeJNV0f52PNDTLr2hVkLoNOCSGn9/1rX1?=
 =?iso-8859-1?Q?eQP9oTkcJ5Imqh88cFJkhIecf/MiNWeY4tW60dFji9R9S91agygRDDoFj6?=
 =?iso-8859-1?Q?ESF396zxh3+WYQ/FFMUbUoHb4MxWEXJpRcrrgW9lK4pKkbxtI8tYxm7bpB?=
 =?iso-8859-1?Q?pn+bijzAbgeJeLlPQuxYAYt6uSSaGiyykzk34WkzqYmEYuvMiInmWJus7b?=
 =?iso-8859-1?Q?s6E8WsH9nZDPFptHk7zSSSiyrttMUxppJKnk9rHXgGZXOc585iOOrqJ/Kh?=
 =?iso-8859-1?Q?1uSUr8llQToICUAfv1uzfadg5qwdblAkBDowUhbT/+MFfAjdO7vwbthimF?=
 =?iso-8859-1?Q?5fOVnN+ffB8k6LTNiFGHoJQ3sQXhMk7GhHZETSPLv9km4MVez6p5byqsl6?=
 =?iso-8859-1?Q?DXz71IEDcdPdMc1cXtQ4hu9EdYHfF8G7uuR0f3LuMRbEf3relYtIVduQ/2?=
 =?iso-8859-1?Q?4ec0L7M/O7L7kg1YHTErZ/RHOWJR5xdtD3Kr2jIkxSk5tWmRuRlmXpk43T?=
 =?iso-8859-1?Q?4QSNhRsJawc3GNC6VBqtXxV+Pf3OcBCKfQZ31I+NdBvNCOcuujXM36HGJQ?=
 =?iso-8859-1?Q?Gmt5MSDObEjmM1Xq3O0RJbOISUQ23wbfTh3oPLToic3jmk66kCsMdkDv8j?=
 =?iso-8859-1?Q?YvwUO2apOriOxF95WYd2Vmi3nDC6h3ooiLSeJSePoiA7kooFhAeqlknLNS?=
 =?iso-8859-1?Q?XGhCuXg7aCK/j6U7ptfMJMdsRv6RjErdFz0rRqu0za3ZI6KwOlLrelOY6a?=
 =?iso-8859-1?Q?/8p0HqPggQJUBeR5p4YXXpDsXmXFlMZXmSSofHca6BCV/62ZVUrmLXon4F?=
 =?iso-8859-1?Q?4voVUQHs/y0+cDhzjUTFQtyyGGs9PGpWl42b3Ui8f7ppoC+kiY9T1zw1Sb?=
 =?iso-8859-1?Q?x+9lHTPUSyV30O1dx9oeOEWmdWEIoyKrQnvGvgouA6ZcGxE+SHfKcEnbt5?=
 =?iso-8859-1?Q?sObTXnfgrTNaveo4uzr3EHzZUsbXf6ZejQ+4YphRUBoSVteptWhv+oU3s3?=
 =?iso-8859-1?Q?Y8xhiXMIqlG4+fhlj+nhA0I8Kxyy/NUSSd9CdArWD/k05Tb4w6JWLuUQnp?=
 =?iso-8859-1?Q?TycKmLiQob3LRd0X/69zwakAjR4dA2blY3cW+aifi7YnpSQMzcS7Tp1qaW?=
 =?iso-8859-1?Q?eu+itOWI0gb94pC7ZU1YFjO69m3dHSC7hJH3Y4IAYgoDJSFLAkekjPPwvd?=
 =?iso-8859-1?Q?1yAlFFXxpDNoXHukzTlgddEj1azs08VrrqlM6r4JcXoJ9M4qNXkVVRU37Q?=
 =?iso-8859-1?Q?a825RV+xa8rBE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbf1fdf-6120-4910-8cd4-08dc73242d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 08:10:39.5094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mx/f/6fh0jNCLfylEyeMuAq2isbZkuYOgwPc4a8qiTXh3slomgHrBtuZ3TUSJhkvvXTBzwOh85UAV0MnbW/9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, May 13, 2024 4:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 18/22 V3] drm/amd/pm: check negtive return for table
> entries
>
> Function hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr)
> returns a negative number
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> index f4bd8e9357e2..18f00038d844 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> @@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr
> *hwmgr)  {
>       int result;
>       unsigned int i;
> -     unsigned int table_entries;
>       struct pp_power_state *state;
> -     int size;
> +     int size, table_entries;
>
>       if (hwmgr->hwmgr_func->get_num_of_pp_table_entries =3D=3D NULL)
>               return 0;
> @@ -40,15 +39,19 @@ int psm_init_power_state_table(struct pp_hwmgr
> *hwmgr)
>       if (hwmgr->hwmgr_func->get_power_state_size =3D=3D NULL)
>               return 0;
>
> -     hwmgr->num_ps =3D table_entries =3D
> hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
> +     table_entries =3D
> hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr);
>
> -     hwmgr->ps_size =3D size =3D
> hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
> +     size =3D hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
>                                         sizeof(struct pp_power_state);
>
> -     if (table_entries =3D=3D 0 || size =3D=3D 0) {
> +     if (table_entries <=3D 0 || size =3D=3D 0) {
>               pr_warn("Please check whether power state management is
> supported on this asic\n");
> +             hwmgr->num_ps =3D 0;
> +             hwmgr->ps_size =3D 0;
>               return 0;
>       }
> +     hwmgr->num_ps =3D table_entries;
> +     hwmgr->ps_size =3D size;
>
>       hwmgr->ps =3D kcalloc(table_entries, size, GFP_KERNEL);
>       if (hwmgr->ps =3D=3D NULL)
> --
> 2.25.1

