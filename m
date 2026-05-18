Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E4CD4F52
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 12:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2023410E5E4;
	Mon, 18 May 2026 12:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S2/7ySTZ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5767010E5E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 12:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cz+4aJkLKLC5bEGFEBYnJ87fDkx+mB9bggqBjXmBr4X26mJw69f8oozZCL4bIfzdNrogCvVZBU/NQATdMc7ZvaTKu/J0wO4ShsWDRRVnYpBupBJTlcF6iESKKOy4B4cisdC9rpegyPwrg/PZXHBmihheulWhUYDVUuMr60UJSLL7DnYeo635DKQq7azA9OYBKPgwxZ3abOeC4eJNZgftAhyNaEbvUyR3sTxWDP8Rl+FPOno8upWbtJp2zWHlkkLp/OOALgnk26fL9tXDL2NKnl+aHqEjnG0nEQE5QroFL25QyN+5PhOLUEhiXlPIIfpirreot1m+1nzZauhQbvxxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cbv/b1gHTkO/xk5JREWFqbLjef8OkUA0+WVe3wf8OQ=;
 b=jGc2yZzDnQuQYpflWdP9upojdYGYE1DCmTgKDxRCor/QOoG2i6ShiMr17wM2QE+4ckGnvIR0NyjeK3KO6lIwtUgbHxmlIKtJ0V9WoXAwnALo74YUtg6PozEbRhyeZg4plwo9sK6h7dX8lJdKgcbrZ4KRCKKUmVNHAQ5uMLeQLK+cFpMBD6kgD3L3v+8ovTE+1xx9ubmQ9HrKU7SOjfXY1fqDS90B4BzY0UPk8VIP2o/CTfQTmx63MuI30prjEPNVU6O1iifwJiMljU8F11E6SwCdduJg58SNKmBySl3zr23lGinlsiM6514lwn604cE3eahJy/nLzhr5bmTVscGfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cbv/b1gHTkO/xk5JREWFqbLjef8OkUA0+WVe3wf8OQ=;
 b=S2/7ySTZTjNEGZveYaaSr4Wo1don3xXaUOqSUEharargpaQOWc3hUv9NY1A+1PSNcyhV1+kc/QDDhQftTp1oOGb/VSwX5CH+PEOLfxX9Bx575yl5ZypzNSWWrfznMknBCPwh1l/gHuM/a/I/43yMc24fCmkSnnfK/1QYdXb7KeI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 12:03:10 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 12:03:10 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: Fix UMC error address allocation leak
Thread-Topic: [PATCH 3/3] drm/amd/ras: Fix UMC error address allocation leak
Thread-Index: AQHc5pKyi1TLA34haU+BTwT9XTYc0LYTr14Q
Date: Mon, 18 May 2026 12:03:10 +0000
Message-ID: <PH7PR12MB8796C3315033C164A06299D8B0032@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260518065030.2311-1-xiang.liu@amd.com>
 <20260518065030.2311-3-xiang.liu@amd.com>
In-Reply-To: <20260518065030.2311-3-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T12:02:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BY5PR12MB4321:EE_
x-ms-office365-filtering-correlation-id: ab97e38c-a96a-45fc-1344-08deb4d56e1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003|4143699003|11063799003;
x-microsoft-antispam-message-info: Q47/5l7ED0HAVzAzdhhqf/neAkm/Yyf7yqJgzxaB4m7axMRU0Q2YYP8O8owNWaJY9pTdVNAYcpjQB9A2FY0D4aogZV5LH7yNoyb5S8W5Q1/t4ZCrR9/2igIA6ZURc2WyUC3MzXxZ79OX3LS4tTouu5in/UFh+o/zRTmOqxsXcfengp2Q+p7z8JE6qaBtxFepK7AM1hTKQdjAIY89ILDM4ybZ/MVUhbyc8aoaVO/xaLXuqzHu2FEmFkpGrY3jtOBapyfjYmXBIt2dNWFhxYAi8csBws4PexniW2X2B37YgWVGShOO+Y4+3C6Y+mJeq04ppNe1zoZw+5W4EIUFDh7IgdGN8C6XDen2KUAUjL8xmNQb2/Wnvf8tS5lspYJ4YdWxh714OhvhsM527F2JqrYy7VeQN9Lnl8F1Bw0FVG9nIx/rkIIVDLvhkvOtYiuIuWa8azGjWrMM55PJ2h8e7gj3T/LTaQOpTXgAy8pUlLtosrQ+D0BZwC8J6i+VB4imiavJ4Dh8KrecE3f6mTJLsaDHQ5dqHFBo9YpN9MXZvRaC2neB1Hk6SHn1vvvjbCZeVfZqzUZvZfcOabCanx+KTWJoQzvCbIiL+Lxd1VwZfPcVAd+QYFlPjVajHhUETpKc4eYP8J8Mljm6nwaT5wpulmjTjzTh8pG8mGZLGrtoOm+91C3USGv4G/ikchs7DUEYQSWG1ACGq5k7EYfjTKxishgVtoYUc+Qbv+/YDGVzbqDKNMD9mOCE8Re7qNK8hoSwJnDJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b/3wC/Anur16NXYD9/uamjQatDJuMAsMpm31+RW9PHUy7ElI5cNYHmB1EElQ?=
 =?us-ascii?Q?N/CpHqFEqCw9pAZYoTapUMmt6wMczZDVfOnD5gaAZvK9E3w5J+7j6yVDhPWj?=
 =?us-ascii?Q?1oWa6+ewQRsAv4N1mRZx37F9EePU5pdEUyo5f7dPVaSFSkwMnpSmQubtPE+R?=
 =?us-ascii?Q?toapl+uCKV3SBU0xQurHhFJg01ognqcFfQia7hbHqLgqpDiP8nBnw1QDBHbd?=
 =?us-ascii?Q?A6e24jBAaJXhZHYiVNY3FibmOH7Ci0za2Mcs2bKlPKCKlxofQclNBBznmjOk?=
 =?us-ascii?Q?vcmhpnej5wnDEkL+PvximqNiVBXfFhXIuxIZUQwgGrS4pUvle0QgW03e+KWu?=
 =?us-ascii?Q?MiaRCjf7QFPOj/DeR1Q3anjw2MLMDE2tzsg5fuXE170g7lUNMkLShJoY0GgN?=
 =?us-ascii?Q?KKA8Z0zTxod3+0jJRhBNEpHxbof150fDRTgI/HUK+gVwmaDEUcjZMSrFGOyy?=
 =?us-ascii?Q?VTjDxvzCWKYdKhbiUiYK6kkX6zhqD+l2CN+jT7sK+xdTDF+1rBwlpUxzXlKA?=
 =?us-ascii?Q?t/iXDgcrII5xkDl29G9g+J27lvXoqM9LyK9XJy2kJd4mvvkL7UY0T3SQApk9?=
 =?us-ascii?Q?Odz+KW0Tx4Y2Ml1dG/WH96Rsgyx4ajN8yu77ujN6ndXfjjKLSakqdu7j5/0n?=
 =?us-ascii?Q?LTlf3YszXlEmPs9613VUOXa0wskh+/QT4HRNXBWwGdUm7pVWMy03nhw+hK6d?=
 =?us-ascii?Q?OSsJG670JFB9khYH1kP9qQAwMyc2ObV7qgU3qzVnXLq0CnzP6p/BWKFGWpBK?=
 =?us-ascii?Q?AdGOSnlC6AsQS3iyd1okK6FZIizfaYYFCBUmksvDBOD1ThnAzTVto1vNIuDj?=
 =?us-ascii?Q?F/qotgD3u2SnHwgWirD+tZb4fsvu9hxijbCv5T2Et831OMJRK71U/CFVYPlb?=
 =?us-ascii?Q?KzXJEIsFV3IICVCaRPve9RFsufikbGiChbaf7hFttkNB+9wfL/UEbBTQ+wXY?=
 =?us-ascii?Q?dcr/vMtxT5wn/4TY4edGJWB2GyMiGoPsU2b5dEZw9TDEhFrX3QWkHRsHCEWD?=
 =?us-ascii?Q?6O+AU434JUPDWW6rs1OG9pWFVeLZOIacy7KYMjDUhqUtdlxsGZvC0VQBWscn?=
 =?us-ascii?Q?iLsu0N6Si0tYlCQh30SRSeNHAWVGoNR9ns0ZKlcLepT5i6LYHf1cE5WJnh0e?=
 =?us-ascii?Q?G3Ln1lOmr3ie36hO6DIUHPXAbj6YJywh1aztvgRYlo9LtrqwtmhdJSbdC+N/?=
 =?us-ascii?Q?0NICgBkUx9xWeaCP+d+0bdTAeqNEQ8CpEYfs1Ky5Decqp2320WOSesuc4fDT?=
 =?us-ascii?Q?+vIiesZ3DOpzgkZRT0cOLFRJAQucscz8o2VBZf9BAnbaN7mRbDB4dIcFzGqd?=
 =?us-ascii?Q?geo6nsmb8kQiCfG0x0uDSzFugRci0iLCsrtlqEjlTuPTaI8rKO9rQv4yKbUs?=
 =?us-ascii?Q?VtDYjYbPfdBXs3NbEtyyBDKml/seQrIuIfbqmgzF4TlkDChzpm2om8u4YLNn?=
 =?us-ascii?Q?H8q9PW/v+wC3Xn+LPJ7O1aoIuFpj5KG6X1QuO/DxTJ2LGe/CUCbIcLGFvIG0?=
 =?us-ascii?Q?yS2lBOwMY5Fbb/iwqsthTgK8hqE+0sZ5aLvd97ko2odD/lO/Pr+eOJq406TO?=
 =?us-ascii?Q?wipXdLO370pSK47ch4h/CFGaZo0H0YjmLj9I2KkCIfyLxHxLZr1vLwVogdPf?=
 =?us-ascii?Q?LJJJLeAumMh5SOzg3kS0h/u51kS7u9EIW+phSU3HrbLkGf7wLXJhKx0ukKCx?=
 =?us-ascii?Q?9JC/7GgHewigJNHuC9jxH5TpBha1UCYeAPw+qfaO5Cr4XqX+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab97e38c-a96a-45fc-1344-08deb4d56e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 12:03:10.1414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTDTBbAsTHB8vneMLDdqPiHM/w91H/rmhOgqXtZ+9SFae6H+PlnPeGbwvD3QbDcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Monday, May 18, 2026 2:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 3/3] drm/amd/ras: Fix UMC error address allocation leak
>
> amdgpu_umc_handle_bad_pages() allocates err_data->err_addr before
> querying UMC error information. In the direct and firmware query paths, t=
he
> pointer is reassigned to a fresh allocation before the original buffer is
> released, so the initial allocation is leaked on each handled event.
>
> Free the existing buffer before replacing it in those query paths so the
> function exit cleanup only owns the active allocation.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1be722ba6c9e..a250109edb63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -130,6 +130,7 @@ void amdgpu_umc_handle_bad_pages(struct
> amdgpu_device *adev,
>                       if (adev->umc.ras && adev->umc.ras-
> >ras_block.hw_ops &&
>                           adev->umc.ras->ras_block.hw_ops-
> >query_ras_error_address &&
>                           adev->umc.max_ras_err_cnt_per_query) {
> +                             kfree(err_data->err_addr);
>                               err_data->err_addr =3D
>                                       kcalloc(adev-
> >umc.max_ras_err_cnt_per_query,
>                                               sizeof(struct
> eeprom_table_record), GFP_KERNEL); @@ -160,6 +161,7 @@ void
> amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
>                       if (adev->umc.ras &&
>                           adev->umc.ras->ecc_info_query_ras_error_address
> &&
>                           adev->umc.max_ras_err_cnt_per_query) {
> +                             kfree(err_data->err_addr);
>                               err_data->err_addr =3D
>                                       kcalloc(adev-
> >umc.max_ras_err_cnt_per_query,
>                                               sizeof(struct
> eeprom_table_record), GFP_KERNEL);
> --
> 2.54.0

