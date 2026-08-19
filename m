Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B30EC5DF6D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4C810E1A9;
	Wed, 19 Aug 2026 12:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T0I4x2QB";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A6010E1A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 12:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfG85pHRXM0aHaeHlvoq/MrkZ90QQCT0Wfj5jJMgcD1DvAdUOTsznD0bp0woyUaywwaj6KLRffCSKnV/QH/5Aq82mHQLvn/8hbqxT0XXSbXjiS6pyu3DnBQZ/pwY3bPUW90r3Wk7VlsIBsvBdNDzRS5hZo7s3lx4+k6D6oC5LdGSZsYXQs7BGwYnchFUFbrf1jQD2hgS2kpWEwDN9c9+9Lq7WAI6uV5O7+mB9UUesLN3J+b16Fm+TxAkJK76ZIXpNzblxburZ1IiXhAbDUmaq054imkoPO7Mw4vhR7ciLgXc9ZeUCkmgI8QQJ8IOddCnnYeP8ZX6x6MSwh1Xg11ULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehx4RW4koizBd1E4sjJPnI87l/f5+dkG3oTF6UQsGnA=;
 b=RM/SxS/NQQPecCXDP+G8Qx2b6dA7QUomLMn1gfApKCL+JkELE0gkl1wK+Zvxt15MXh2w1FYc2L5tspnzBmZXCIadiJ0eUqZbEcRgJZngAAGgReWMs+02glhHlhRHZ0dq3GN+DTbKtI9OBu3t+1nez4LCiN3UTzyHNp0wCyEP2pWC2ANOVorgFQdh3BwCG/h78E7sHpnzUGjMrMMsj9UNGznIf7ZoxZeBzsFH1rvxVBluKbecWFHEpad7LVZ+GBPdFjMdG3VqgTWBIjvbLSsvlw8+BLsDeCpyH7lYg/A4CfCr0x2O4F6Jj3hNtNbaiyXTCGh9YNAYeFhnD25Ox/aRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehx4RW4koizBd1E4sjJPnI87l/f5+dkG3oTF6UQsGnA=;
 b=T0I4x2QBmc352BCErpFGDzsRkYljtEk2INO0/GnHwfN1I/od+UZquv3OWa39NB9q6gwYUcnYOUVaSNDw1UWOBgU7vOTACi/b0HR1BmRdh7VzqOcoNP46LgyssSNpzkpEi7dPAYsFDI8iZOfmwdztHS/TwfKEXBBzUxfMP9zOZgU=
Received: from CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 12:44:12 +0000
Received: from CH3PR12MB7572.namprd12.prod.outlook.com
 ([fe80::709d:234b:b2b:ba82]) by CH3PR12MB7572.namprd12.prod.outlook.com
 ([fe80::709d:234b:b2b:ba82%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 12:44:11 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Min, Frank" <Frank.Min@amd.com>
CC: "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: avoid force-completing uninitialized UVD
 rings
Thread-Topic: [PATCH v3] drm/amdgpu: avoid force-completing uninitialized UVD
 rings
Thread-Index: AQHdL6YJhQetEFUVC0WqlCF4+1Y7LralUW3A
Date: Wed, 19 Aug 2026 12:44:11 +0000
Message-ID: <CH3PR12MB75728A557927530BC91CE78BE5A52@CH3PR12MB7572.namprd12.prod.outlook.com>
References: <20260819064313.3609274-1-bobzhou2@amd.com>
In-Reply-To: <20260819064313.3609274-1-bobzhou2@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-19T12:43:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7572:EE_|SJ0PR12MB8092:EE_
x-ms-office365-filtering-correlation-id: 11972817-adc4-4fc5-2315-08defdef91b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|42112799006|366016|1800799024|38070700021|56012099006|10067099003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: MjBdSymKuhOMh6k9675nQX8MP/HVkHAA8PV05phgIei12BPTJUM5k+UsHUMZt8EYkUp3kNdjX9KZ9fTu9EWOgOBtCQ/xdKLO/7TpKAZ6Yl6tdqdi68YVtmUudiGSVqttU1l0EXvPCxz8V/ht7OEkgseT0dPesqLXgMv/X6xVvVM1LnJZzUlQ+DCKpAuiD1G1VpXmiTB+zdNxBgbAq9t0xrcTd8Yjw5zsrGRJcHRj16nye1uHkzwF8+ZOcyvXHfmcK+wUrV4LMkeGXmhd4DNaC4aed3R2cnYNGCvPZjOB2TzwBeBhRVJf/j1YEnkurDwLIl9t48dyC+k1L/R9ZOJB7iInxLqyM/YKtokPlPbpF2nXU5deN06TZsUGeQtEnZc2VtAhu6JaPDzs8Ea9z1oeJ0ABDRPtr9T9nznsgPDDu63CltnrU9uaG7NAJQqRK1Mz4dsR5NN9joOXbe/OqboIIM8GgaPX3/LlRghJLzQI/MlWV/rrHi5VplprJ86A6OXB/+qsg+Yl1ZReaw8b5UoC+PBJJxRkAJE0CK/qx301nYM/ArUY3UKrgevaB8Sj5XTViZfUgBmfHYn+lC6eNi0cXc1vKCkQeGsS8DGce3FJKPpJomb/tyAfcWONZaTz9VFJQ1PbG9Miz4d1KdlxtCS5FFkQv+cGGi0CJ2WW8Ct2INAHJVF6IBxvkPwPTMvoj06KgGetXEEduLjfqkWyz5YUPvprNdk1XcviA4M8pzJyhho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(42112799006)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dTJr6MxOVBIE7AcC0mE5K3fdoFbteE7BAaj/xhZmAc5YO5yWbAeJQmdMvscI?=
 =?us-ascii?Q?+d12XTtMbaDMl08dailMqRwboMGNjVcoD9phCMmV64tONbjwhpRe5MQ/5a3X?=
 =?us-ascii?Q?NyNBsy38uBhx1AGKLhQGkncu+PPMTAkdbkqQP6V7WxWd6pUp4V9P/kIaN5/f?=
 =?us-ascii?Q?LegWWQrJ0LXejotkPzcjGzwH6oNkyGhFo8KC2e4i544B5gB80bfk5QZfnyhU?=
 =?us-ascii?Q?LQ+NuFscicPo8aYmC5nRcrmULTXWZ6GheTyt5loV+wt0PgibqUgYCAoScC9j?=
 =?us-ascii?Q?TpCLEFV1OpLI84cER4dLaNB2RzsKcpIOgLgu091ByFCXhFxaHmx06j6VFusS?=
 =?us-ascii?Q?RP5VnU64U+1gGToZmRcB9ej4xaoygvroHRWI4saAyhTnlSBM8bVHbSaJT6PY?=
 =?us-ascii?Q?+20DakFEY46dyDoJHWYjVz0cS0HGePxHhI1M0F88M51osPGSbWFjhKXqPAB0?=
 =?us-ascii?Q?7R0C9suwkYeR2YClyrMUM98MMFH+WI0AhAAIxrqLZgXbNI8mAVWBjyGUcT7a?=
 =?us-ascii?Q?B9NbXV4/jqVKtMUOMiijN3WuQTA3dMMuPsiypvjG+WpYE9y9c5T3taVhs6Dp?=
 =?us-ascii?Q?LANyrxnXs4B6nJwgoP0zZ/7ndfHpZ7TXL0b/dHF4+GuHlsU69QQsbQkx6MJ9?=
 =?us-ascii?Q?yph3eNCgiXj7D3PILO8UfPJwGV7fNe2jrFNueimtj19+zztPNigOfzINJ27I?=
 =?us-ascii?Q?ue67R3g1sdyyYpEbbmqIYWOVYcJKHSaPrKI0/BfWuTSwUF8FL7zo5CgeuNMk?=
 =?us-ascii?Q?d0/vU+s6X2TyD5zsIhpJKHj7xTl7Ai5ez+TAGo/5n2L61OhKE3niCcT83axr?=
 =?us-ascii?Q?A2p1m3seS4umq3Gv4pQpezQPl+NfkE6gVEaj1NfPlVbDHlFNuVu1T6fXxV8/?=
 =?us-ascii?Q?07aXHaPnTK8CrYOYIR4+ee521iiI+uAr9sEf03AIXZSJbqBm8ktVTlbC/MQn?=
 =?us-ascii?Q?8Gs3DjGqAt3vxNPqykP4qAQ59Xu3X1hDdZMKsfg46XMZ4FDznNuowYZ+UGpV?=
 =?us-ascii?Q?DAJbf2oyCNu7NVSVmEuITFGaZNjV8RYoap/YZmZa2RKS6yWmr8NVoR1VIT//?=
 =?us-ascii?Q?m8GMeAIaTxQDNJraSsRZ5ze61iopSl8nWPaluJHMOlm50pPDfA1hmBaag0BV?=
 =?us-ascii?Q?M9oaIowysZE25a5l9GJcI3pPJ6lta2OoEPYgRCUH929loiIi192TbfRUeDIx?=
 =?us-ascii?Q?ZY2p6b4PRlFvd2iDrm5C8UuuUQzj11F5fPpEdvPRDoEFJ5+ge9q9HIm4TNXU?=
 =?us-ascii?Q?56H6fDH/15H0L56XNyE4uFY8yXS3w+8kVviXnoHghiQMLV3N+b6dUbB37tD+?=
 =?us-ascii?Q?kr4tNgYEoToyEFIrG7LxXvGoDUPT0HcFq8+vt3TIx4r8D8fX5BaK5snTeDbN?=
 =?us-ascii?Q?71MF6oNxPe4EEWy+buMVWQR4EJBWbhKzYVfKQgxW8DPjH6NcpMm3jRhBtao8?=
 =?us-ascii?Q?YIoqnnE39wJhRuXHA4ctyLTYdET8aewmnZkmRHF+BAZYQueMPS+6g2zMnJsO?=
 =?us-ascii?Q?wqY5yYqkkI4/EAw2fEHowjKQcR15h2FC7gvqq9hzYguFqyGGOZEYReya9DEA?=
 =?us-ascii?Q?Um4BC455j2H+5VSahMijUnsOh9ias7DhY4KfaMKhpB1NELu7NxqlQi8VmDhm?=
 =?us-ascii?Q?GfphXtDeBltsV9Az+JkpnlcJ7U7FMumxyC5HlPDaA3WLkp4jLqvSla6omirH?=
 =?us-ascii?Q?C7+8ONqLk1TcZB2uePELRKCRkDOmGt/cBQ0ShHi7WAL8ObGG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11972817-adc4-4fc5-2315-08defdef91b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 12:44:11.6158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Uc76iR9lC6kEPXpYtRTZLwsCcrG+DmjDm+i9q2M/ybUS42MJUBk8ANtS8IDC/yP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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

Acked-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bob Zh=
ou
> Sent: Wednesday, August 19, 2026 2:43 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Min, Frank <Frank.Min@amd.com>
> Cc: Zhou, Bob <Bob.Zhou@amd.com>
> Subject: [PATCH v3] drm/amdgpu: avoid force-completing uninitialized UVD =
rings
>
> uvd_v7_0_sw_init() does not initialize the UVD decode ring for an SR-IOV =
VF.
> However, amdgpu_uvd_resume() unconditionally force-completes the decode r=
ing
> when restoring its fence sequence.
>
> Skip fence completion when the fence driver is not initialized.
>
> Fixes: 043f2271e2d0 ("drm/amdgpu: mark force completed fences with -
> ECANCELED")
> Signed-off-by: Bob Zhou <bobzhou2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 228a405a94c4f..ecd7caa95d4b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -517,7 +517,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>                       }
>                       memset_io(ptr, 0, size);
>                       /* to restore uvd fence seq */
> -                     amdgpu_fence_driver_force_completion(&adev-
> >uvd.inst[i].ring, NULL);
> +                     if (adev->uvd.inst[i].ring.fence_drv.initialized)
> +
>       amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring,
> +NULL);
>               }
>       }
>       return 0;
> --
> 2.34.1

