Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6615C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 08:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B1B10E045;
	Thu,  9 Jul 2026 08:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bwltUyhJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27E510E045
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 08:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcuLOVt5+HrQdXKzADWQNIWRfcYhlys+Aflkne1oeybTYbbBG46N29sx0aA0LFWRuZF798LYjUgIsZ1qgV9bMNIF2FX8NVEuHuL71enEgralgDPC14RoRo+oe5/pEg5ic/qYM1Q7gUR7QjgUlWSkV/PQZN//FwgeBCK8VbQ1FwKzj+tervzBcUfTJFkyQQrFo+E9r5ls0hQ/YurIdQaM8xSb8kdXdizFc2VZw3LH3PrQtnqhwM2YUbpdMw82lwvO+uhURbl9tKwidpsEHsRdr4exCcjQxCl1oQZEDCJhs8/1fk6yoe6Gf770NokGD3t456a1V0tqLHje0MXCR7tAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+h77vRcECR+UTS2Qsx1WuajerUu26NQlJIC2RIvmj8=;
 b=VbZ80FqZYoQ2zeoIGwzdNoWoTQ0y/ugnV8TWrioZD8gJ6oK+68G/yNlDtvFq0c0aOcxmy8J4OKtrPL3UZDUrwtqYGSl/BhtLC+RuedbtR6xg+w0qlxPYEhJ0xKs9BZG98oWvnTZKkiL+PuR3uudIEICNmRpB/O8Q17kLMNcaYLWc9jApmVg0C1VjkCz+hBfqldKKbCfWa9yhBt3tX2j3cQ42YiX25TAevJG2mo4CBONg5a0/EI/KP769fINcBAzJUvlaPYv9VGrJME2CX8JUQbVWmOGTnB1Yv1F1o/lWbP4cqzZoWBDMvEzM/wxySusqTldYPU4AVLA72dgeGoFr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+h77vRcECR+UTS2Qsx1WuajerUu26NQlJIC2RIvmj8=;
 b=bwltUyhJdTfhC1mcnx5QWqcVXCPSzS/DOYR3lG2vzK1lDd/AB7Vh5p6HMsM9Va7luiBTsN8QUXSyutjPduoT6gGIaGpLFcYWvkPCj7uC5ftcOjWiyNijd8eUUFDWj8qYgNuTqutc6329FsNo+6RWWlxjCVn9tWlwFNnDdn6ptag=
Received: from BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 08:37:00 +0000
Received: from BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077]) by BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 08:36:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use IP version check in sysfs creation
 conditional logic
Thread-Topic: [PATCH] drm/amdgpu: use IP version check in sysfs creation
 conditional logic
Thread-Index: AQHdD2uisioxYgsBsEuDWpkcLqEoKrZk3HnQ
Date: Thu, 9 Jul 2026 08:36:56 +0000
Message-ID: <BL1PR12MB5127DA43C232075AC7F9872DB0FE2@BL1PR12MB5127.namprd12.prod.outlook.com>
References: <20260709062429.1036266-1-cesun102@amd.com>
In-Reply-To: <20260709062429.1036266-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-09T08:33:46.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5127:EE_|PH7PR12MB8154:EE_
x-ms-office365-filtering-correlation-id: 047b34ff-3eb1-42ea-656c-08dedd953c85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: iFZup6cHWYGb2tZegkbzqGuEFuoYvvUd8jaWuGzkRQvjDI+GzGygXSjIp+pA3SKo0/NMDOQWEOCx1kHI1BTuU4WNwODfCnV/D0u2F+BnC4KZWUvICjmdzu2vL/XkHcCo1J6YKqrJOlLPvoUo4QV44vyZ6UW/uJRKj96aJZqMipZY0eOadmGipE+4tWM7KQJVT/KaMMCZDmwG6t0ggdF4vo69xTnDw52NvsB0hCF31fbWBX+WTfabeTLKbitHc2rKUa8YDn3KAm4GLPwT4R2B48FBsb+fugrWcvWn/+F1lDc3gpnInJo4jN94XMF0RlHxh5y4LnA1QsmYO2s8B323e2+cbkAm++mE6KlFYTS03JatQyeGo+94TD1gTjZ1Jnx5VUs/y7piMHezkpiHmcufAoB3MKq3TPxDyf14j5EHFIZQnvknlB9ny9mpoYsf0zoFu4j1Xia7a5c5EC2aVhJXV99JCYsfKV0pLwWdtj4m1p8LUQV5igVb7w3qXiBkT9qdzrFkSmj1+Yd+f8Mv5G3DtwV43j4ekq4ctzs4dG70i1U0yTkQ8JEzp/njuy7+XZiWJgKfzG9g6k/2aRQdOEFoV+YY3nc8FDmh51YLMPenhlbypuu+a5NMDw+DoxfPgPvJU4zwEPuiWtpT10On4poR+8w7sfev+8p+XIA1fUHh57ZO/gDDtoxNwYPqABopTpAH7S/WALHdHpU/4gfud/v4hdc7ioDoQg6c14q8bdcu5ps=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bOG3sIppsIckpSLJgnOG8g+JF2XPM3pP8nCpeYslnLh6HZ5pl2XmDkKbC+Dy?=
 =?us-ascii?Q?1VxX22c4+35Rli5hAFnlIZk2FSYoHcuNCnCDXy1/9l2HhCaGxBWRJNDFYjfq?=
 =?us-ascii?Q?hpuWiQLkhGMjrCiHAPecRsdcso+7hBGxrA1qMf0wRkxoCuYDh7JXgwZWutTF?=
 =?us-ascii?Q?how5M3mP+gA6G11tZ4ZRX+5H1IZ9HU1vpzdx44khGMDjiCWlqlbNkxQoURvC?=
 =?us-ascii?Q?TAGyca8hGzrgztS2G5rASn/s7V/GW8PZwUsSojabCof69BbnPqR30ZLMp92i?=
 =?us-ascii?Q?XZTKwP9XrWA07UKQTr3CpRG5A/3+L/cYOXlgNcDah7u/KCyVD/UpOydkd21c?=
 =?us-ascii?Q?JpzNNB/izzJc45qYhhXWPA7EMPYNnbaPYefYTM3fJwyncEDtWX1H6cE2UidF?=
 =?us-ascii?Q?r1a6uHezf6CTVjtIwBcYwuoVFjZR3d144xp2aITQuunvu+ZSMB89lzQwmcJt?=
 =?us-ascii?Q?1xeydK7cVerYMULk/QXYwwFTMmTCL6q0BcwOalqBHB0TxDQqCxqVfhC2hbxU?=
 =?us-ascii?Q?8NXT6hKxvre0QAyDYt+BKuaUwbpQGBekvseIJJH/9qZG5tbb1vuA7Y2Fshxu?=
 =?us-ascii?Q?Yg7ZKUs1Zoo11pEJeK8f7FvbcQbkmmkpSeLBs7bDhCd/LkNHNP6/xoXQR33X?=
 =?us-ascii?Q?nZOoAUDbdopHa83V4aXW8gEfIFKKY87ohs9qdgOUIR7rylw9n5S8b9q+uxLV?=
 =?us-ascii?Q?P7r3kejD7VQVwZfx/c75jr4hgp0pl78inEvKRmO9bmfnAb5bi57EjPqlaBWx?=
 =?us-ascii?Q?Ccqt2GRvJpMS3kTpH/9zs1F2VQjZZu3IADrx9Tl/DmWu2oySOCP9CyoaTfxg?=
 =?us-ascii?Q?Q7/eP6AC4GQ6IT56ltvcQ5oS3FX1ePvPTrKHQ0WRIblZ3VMNHvUnTsgz/sCK?=
 =?us-ascii?Q?LPYWOSBt1hX1jA/MGzHkg9w+waYwM3vV6MKemIyhMDwr15ItXMz9DUlagqk/?=
 =?us-ascii?Q?rNc7p7EgcNRn0FIg12bTyJ5Q0APwn7sRY3pO9vDNAOKjOk8zyvyBpVXwqHYD?=
 =?us-ascii?Q?iu7hM/7bQQ5iuipCBcOXDLKutfBo0lNk7kO8pk758KOjlXJV5FMOMCW7O3cz?=
 =?us-ascii?Q?eImCz2AZuiGAFZ2kVcB9TShA5a8FzLYq4XGARDiK+qFbgk5iGPPuWHEjV/51?=
 =?us-ascii?Q?PbfEaqP/mtH8fCKmuGS61/AduWauPlIOJkdO7LefFPE5wvRi9WodKAwDm3QR?=
 =?us-ascii?Q?G+x8gYF/TbNK68z5c85Kg3XPdLOv6SBXcVRxXsyC9Iw23+tb+9XsybxpknJ/?=
 =?us-ascii?Q?fNLqDmPTaKlEUtII5UwZnBmvW8XXRzEUbmeWWrGDrN97OqLhvRDoela9TBjU?=
 =?us-ascii?Q?2qI8vEzoSsu2VlW5zcESvbdOKv42m9O8qMOnyEwXtrgHmXC+931SLsg3NMAX?=
 =?us-ascii?Q?0hlPPLGEhJ9zOYo0qenI0i1ZXmBXcKsq045kADMY9OyREnAIvXM/CJjVoIhc?=
 =?us-ascii?Q?SLDTCumpQeBvqJ9F4VKkjPQuqNZb+mF/loSr8laIhT2+fSX2hkXPSc+X5zOF?=
 =?us-ascii?Q?fqLfECldUUunnpVbHh/AuurW3kgjIj09vYD7Be1M4amf8whajJ+ZZYLHKNRU?=
 =?us-ascii?Q?DFcp44x+6hScvvQCBTB7bGfAQfCkjhXK5GILsn3KSTCgC3VyziS1wqLcakWA?=
 =?us-ascii?Q?lVIiXWR3uFi7SjONd0kQF6h4OjmQbc2aANErvtrN/yS+AUHRJIg0NKwvv2LL?=
 =?us-ascii?Q?SFCX0FfluIzSOTKMNAlWSdsk9Ty9I2fMsBdD7RwtmxFiWLmB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047b34ff-3eb1-42ea-656c-08dedd953c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 08:36:56.8332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXeFbh/EJqwjQlJotRTAApr/UlbW/NDnM67lF2ANh28yc4uAVjb55Xk7uNIjpMK5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
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

We can set uniras_enabled earlier in the next step, anyway, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Thursday, July 9, 2026 2:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: use IP version check in sysfs creation condi=
tional
> logic
>
> avoid sysfs node creation faults when performing NPS mode switching
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 0183b2622d50..631afb5c10b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3788,9 +3788,11 @@ int amdgpu_ras_block_late_init(struct amdgpu_devic=
e
> *adev,
>                       goto cleanup;
>       }
>
> -     if (amdgpu_uniras_enabled(adev) || (ras_obj->hw_ops &&
> -         (ras_obj->hw_ops->query_ras_error_count ||
> -          ras_obj->hw_ops->query_ras_error_status))) {
> +     if ((ras_obj->hw_ops && (ras_obj->hw_ops->query_ras_error_count ||
> +          ras_obj->hw_ops->query_ras_error_status)) ||
> +          amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
14) ||
> +          amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
12) ||
> +          amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
6)) {
>               r =3D amdgpu_ras_sysfs_create(adev, ras_block);
>               if (r)
>                       goto interrupt;
> --
> 2.34.1

