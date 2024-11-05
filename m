Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18A9D1CA28
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 05:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382D310E00F;
	Tue,  5 Nov 2024 05:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bUAJ072U";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06ED810E00F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 05:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFZQX0F7r6JhMKe+R4zWMG9sl6AcaxZiCovKBQT93R2dJWjj2gPGvghMuZN104VTaRo782/nRNXThl0zxyzCQqjnTqctDLIzHSXg7gCyEFcjR34wDFW1pBD95TeKxWxuZL7Ygu3AJCzCr/YFP5/kiv8tU/Ox2WG3BWp5q96t6LJRlvZf2GlyLvKwBXJqx7ccP5xOpwdaL59KO4q7LaKcpgnpgPuXZ6hwlezadZ4mJxPID6SK1CPqfRcfU5ZkcKtwioZ18Sak68wTjGm9yFYtK6orcCd7HlYr9t34seoIW/og1G4ZmboGFF+x8MQDw5ZTbz9dZS5yUmPQIcGSrO85/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teOx7sVqH6nm/MchsgsYlAFQgplWh6tQKD77lkTx9t4=;
 b=J4KuHOd1TWxpTcd5zpVAFwGl6y1XmrqgvFE+A4GT6dHPcJ1F+oEpcXOv9VYRZHnPwUo1Wlyr2zZDhbA5oqDAiPAvlZn7NkKtv6KFVANpL5aid1YF7QWIs7IzVfBtdoTTkgOmwA0v9+FSfxlp964sU0Pm+WMgRMC+bkQo2utYI12X8oQzUDe3TxChqJedFVPzUCsqm6C0Ar/vq0Og07dfFEcDKw31e0Sf7tosnc8pPxBPoYSibLhoCpM0i1gP6qPLw7suA8jhf44MC4X2eF8DhBkeFM0RXC8gzI6A6t0V+mpSRO5d/NRx7XYnmkr901egRrKAWm+gYK/3VM0ocAtuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teOx7sVqH6nm/MchsgsYlAFQgplWh6tQKD77lkTx9t4=;
 b=bUAJ072UdYAjfNjXAQtCz0Dhb1Wfdg8orZBTLRn54sVietzz9jirmGL2v57PKIDfEuZkHujWZYfZ+Q4exHhEIT//hdYD84a8PjUiIP4a1K+m8bbVFSxuJhBs+jGzSLib7e+6YcrGvwP+fieES24cPB0LeBq6b+lCc6rp8c5/hTc=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:05:04 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 05:05:04 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Chong(Alan)" <Chong.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>, "Yin,
 ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix return random value when multiple
 threads read registers via mes.
Thread-Topic: [PATCH v2] drm/amdgpu: fix return random value when multiple
 threads read registers via mes.
Thread-Index: AQHbLy4Lt4ibeQgir0y8xS/qpzNFdrKoIgHg
Date: Tue, 5 Nov 2024 05:05:04 +0000
Message-ID: <PH0PR12MB5417507798046D9A532F3AE98F522@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20241105025210.30636-1-chongli2@amd.com>
 <20241105025210.30636-2-chongli2@amd.com>
In-Reply-To: <20241105025210.30636-2-chongli2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2ef38df7-0a5c-4bb9-a5a5-27faf2f01091;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-05T05:04:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SJ2PR12MB7846:EE_
x-ms-office365-filtering-correlation-id: e9db4a4e-6798-4c2d-164b-08dcfd5768d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cuyOFpfoktoqBjzIAnUNhjNVIgAC8a+JgoIcJn0SUyvfRGQT1HIfiS/KBwGs?=
 =?us-ascii?Q?0R78fYmrk75A/F23Z+FU9G4RyLWMtY+5r5kOov5z8yXhshFkypx11cSn4xKo?=
 =?us-ascii?Q?rbIXC8z0OMUIMK/asc7eJhUrKq9b/JVlc4zh8+sq7PesWJvpQd0vY9eiElMn?=
 =?us-ascii?Q?P5/3MxCS6fxxLjbOJxaFW5gtzGzq3FUjv4l5Fb8YX77uQryzPcyd411P4GYu?=
 =?us-ascii?Q?EfMQW5t1AlF9ZsEt6ZWDddaOFwJkAKBJsbHveR/rB2FkovR6gaN/VaNOiwz/?=
 =?us-ascii?Q?LJTalQZXARW48d6RPP/OHCK38/MLRNYyjVT086dow4MFLs+mIr3UNHKjvD/4?=
 =?us-ascii?Q?LTZllftbnfcVDZBawL4b1flbh86wXXzce484hbghMtn1Iw/07OQFZRkpg1Sb?=
 =?us-ascii?Q?173IxsIwxf3jvHSm5I2pN33SkUwAb46PDEaEy8nwU/PsTjCz2XbONrjXGiUm?=
 =?us-ascii?Q?A++PcY1iYIERbUdddfnA2593cGDkaF6MxFyiO71e5dVW8ZynBapg4brl9Vs/?=
 =?us-ascii?Q?QDoEWLqHMgNBjgi0pisW2SjpZvpNBlVeg30MG3sdsgSh0rDyF6NYd456Z5e7?=
 =?us-ascii?Q?u3l7yeussl4xsP7vPV3sTAs5Esxuphc4na6AwoKuYOsutJR+enlsqqt0Za+K?=
 =?us-ascii?Q?0JHQWURTBb+ercM5xUIci1Wa+1HhFMHrOZjGk0qhdRu7RZ57Gd7eEEiBH0l3?=
 =?us-ascii?Q?wNwb6DGJzSC+nHsCASRN4mSvZUUr6M93ourfzilCPPS378xaecBlgXEaAq+w?=
 =?us-ascii?Q?IqjVZNFzdpeQnRdA91ncGgZlD9jQ+0+JYUmdrYhbPhA+SG7CS/l+7/8sXp68?=
 =?us-ascii?Q?NjAEAawC3rT8d4QaYU92y4+GosXcWO5M4ry1DGR/sbJvGKfCYCqBBMGyMDIR?=
 =?us-ascii?Q?NRAp5L5W/YYxgfheRs3VERjpwfl+m2/AP/jOKUDCPrk4b5qIvhreI3PN19k7?=
 =?us-ascii?Q?WidEpFiRN9Xy8NT2p0x6m2ahXoT9IVC/IeXmn0y/VflJLaS/7f5ffK7CjEgr?=
 =?us-ascii?Q?3YWNB6yeJrGM+38nFdoWo1krwRfoUhLlgeCp73NwtfwQNtsnR5kg81bYuYgI?=
 =?us-ascii?Q?l0RwkzK3pgPe9EeWWMPtglGojk7c6m9rYCbu4i+PkY3YR5pgBy7StoxDzAdy?=
 =?us-ascii?Q?n3Z6KMVMi4JBEcKKlhUJOpBW07XkkypAqRa4gUsoscb8IvO6vrB7qI6svlJS?=
 =?us-ascii?Q?OOZZ4BycLch8aspKDO3XR3OeiDeT8Pc/rk7RBYFXoh9GQBfmQv31NHOkCkva?=
 =?us-ascii?Q?tV3O68r9XEJkIARwgBMznv8eRP6uM5OzsLPJfnHnnr0rFUL8ppH8L/cvtys/?=
 =?us-ascii?Q?le9YzkfwXdnLAUFCzc+nCvm+qCXOeaoqJCOYFQ0UBOscMi5vyH1byH6gdRWQ?=
 =?us-ascii?Q?AwokrBE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HM9NZGO2PmbJOq1aypW2fyQMTtCLuJTHVp1SBDUVDWSxJTA2adDvpIbh8x2O?=
 =?us-ascii?Q?hi3m8+djgQzfQI+9DFpOqwbqwucFN9NkeqNkts/6g++T1NG6+oJbrclUt1+N?=
 =?us-ascii?Q?GedsrXZGa8OclTCRQXAqokEyM78UxvFpZhFdiadL40ed+kHOje6RjIWO4r4A?=
 =?us-ascii?Q?wGJXf5+Q6Zzwn9lv9fwBiuQRdJM0Yn90N9qyiHr8V5yUO+4fp1s2Yzkb/47v?=
 =?us-ascii?Q?E1uC0GONvrwi9toVcLkiCmsuEXLrytte6uhNdtCH8UfZmeyOsYnI65jkxC2d?=
 =?us-ascii?Q?BplSiruT2qXuQlZCSiTiFkwMLjpBB+ISdvKynZgvqKQg+2VfkfAGIUjEP1Qj?=
 =?us-ascii?Q?vcDcgRCsfXY51I/WMtbF9ZdjoTJa//L6BdBNATptVwM9D5eYyjFDegFNeqsz?=
 =?us-ascii?Q?YkfvVd6OVKwwVdV5wR5w6gj2b549G7P2fxhVWF70nWDq/BsVt5F59v7lOTR5?=
 =?us-ascii?Q?rY87RWCdTApUGDTkL5CdD/aybslMN5C1b4wtdIkw2J/LCZlfZjp/eFvxmuqc?=
 =?us-ascii?Q?tEjZL6LUigj/SolAHjSRxgQXtSkGCm06ZpwE9Em/UKWtem1OLJjn2AiOoGDL?=
 =?us-ascii?Q?vfOLy70VL78orLYx7MkSHzzyz/6e6tWwA74Alxd2A5NIh9sc0vC0hROLofef?=
 =?us-ascii?Q?hcbDvyptjRoI2x1CvcBGxcWe3kR7JUU80t4sai3zfG/yP6zJlB6X9fTsEE6+?=
 =?us-ascii?Q?VUIN9dQyeD1JVVLaJezCmGfeBGUsY4QhP3PJPPphhRTWUQturEfOJH3wgZ7j?=
 =?us-ascii?Q?NysEKmd8FeKEQF1v0eRwQh9gZqgBsO4VUgtj1KXJ89GnsS/1QiyxvJRLFEaL?=
 =?us-ascii?Q?CR098JCWhxYaIOPkHZXxjNimlgNgivGEzXylvrUYTucG7VTmCYbmcXrk+rxe?=
 =?us-ascii?Q?yQ0a1CpQMQIAjCn0+CILrnlV03ZcT7CLurQLuJaafB/76FgiJ6FoV3rjm2Mv?=
 =?us-ascii?Q?NYrn30t1F1/YuCHxb331XZ6j6STWpS1l5S2aN9ZtWy61idarvRk1S5B5TnSv?=
 =?us-ascii?Q?TkmdTQof8WV8cwu4zWaWK1DyuJYQ1YrHtb6uCg+XQoe2YVfxd3bIt/Q3Gkt+?=
 =?us-ascii?Q?XTOZR3Hu6eGXP09j5l1uN+Bx1MIMIM+rD/yfHwgROK1Fs7mbbwooMqTb0/aG?=
 =?us-ascii?Q?3fbwBJM/Fl7K0UMRgTBf05S2RIqDOsgpjTEv2DuqIpkJRJJyCKPGhphrQpmd?=
 =?us-ascii?Q?H6z5HeLM3aGX5k5mtVmY6WUXxCRR2BK4tEX3+1pS7YEZuN+nkODkk6vgS8IN?=
 =?us-ascii?Q?H7owUzIHPLd8cmgKADGKaFDA+w3UxngEhGqUPF0UC+Vy5sQCRNyAcQZqUT7f?=
 =?us-ascii?Q?v3BL5dBO5WDdJI3ckFcbwyW3PK3jlcW9F3JS/LdzxvZU8RjFKwnOT0XEJUGY?=
 =?us-ascii?Q?aE71ClKjf/56hsix5ewcGyaWPRTuWu068MlWhlrFLKCZRLKOZN29K+PFJFfP?=
 =?us-ascii?Q?9zpW29l3p//n0gJlsmQuvP1dmIY0wRND7P9Uygl6cBmN2TYeRSBQ5pVaXXD6?=
 =?us-ascii?Q?Mk2L12iZW4QyDpfh56fmuidnhw59BO+jD3nIH1/m3TrgCPWaKJI6OHKngvJc?=
 =?us-ascii?Q?IP9rRJGwl2JDaV4PijI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9db4a4e-6798-4c2d-164b-08dcfd5768d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 05:05:04.2145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOn62MefgeTAS/t8XFgDcWWByXfu8SQsxlX2YZqNdnB3r2elg1QapOqvQZ3IfOxt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
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

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

Emily Deng
Best Wishes



>-----Original Message-----
>From: Li, Chong(Alan) <Chong.Li@amd.com>
>Sent: Tuesday, November 5, 2024 10:52 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deng, Emily
><Emily.Deng@amd.com>; cao, lin <lin.cao@amd.com>; Andjelkovic, Dejan
><Dejan.Andjelkovic@amd.com>; Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>;
>Li, Chong(Alan) <Chong.Li@amd.com>
>Subject: [PATCH v2] drm/amdgpu: fix return random value when multiple thre=
ads read
>registers via mes.
>
>The currect code use the address "adev->mes.read_val_ptr" to store the val=
ue read
>from register via mes.
>So when multiple threads read register,
>multiple threads have to share the one address, and overwrite the value ea=
ch other.
>
>Assign an address by "amdgpu_device_wb_get" to store register value.
>each thread will has an address to store register value.
>
>Signed-off-by: Chong Li <chongli2@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++--------------
>drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
> 2 files changed, 13 insertions(+), 20 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>index 83d0f731fb65..d74e3507e155 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>@@ -189,17 +189,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                       (uint64_t *)&adev->wb.wb[adev-
>>mes.query_status_fence_offs[i]];
>       }
>
>-      r =3D amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
>-      if (r) {
>-              dev_err(adev->dev,
>-                      "(%d) read_val_offs alloc failed\n", r);
>-              goto error;
>-      }
>-      adev->mes.read_val_gpu_addr =3D
>-              adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
>-      adev->mes.read_val_ptr =3D
>-              (uint32_t *)&adev->wb.wb[adev->mes.read_val_offs];
>-
>       r =3D amdgpu_mes_doorbell_init(adev);
>       if (r)
>               goto error;
>@@ -220,8 +209,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                       amdgpu_device_wb_free(adev,
>                                     adev->mes.query_status_fence_offs[i])=
;
>       }
>-      if (adev->mes.read_val_ptr)
>-              amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>
>       idr_destroy(&adev->mes.pasid_idr);
>       idr_destroy(&adev->mes.gang_id_idr);
>@@ -246,8 +233,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>                       amdgpu_device_wb_free(adev,
>                                     adev->mes.query_status_fence_offs[i])=
;
>       }
>-      if (adev->mes.read_val_ptr)
>-              amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>
>       amdgpu_mes_doorbell_free(adev);
>
>@@ -918,10 +903,19 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev,
>uint32_t reg)  {
>       struct mes_misc_op_input op_input;
>       int r, val =3D 0;
>+      uint32_t addr_offset =3D 0;
>+      uint64_t read_val_gpu_addr =3D 0;
>+      uint32_t *read_val_ptr =3D NULL;
>
>+      if (amdgpu_device_wb_get(adev, &addr_offset)) {
>+              DRM_ERROR("critical bug! too many mes readers\n");
>+              goto error;
>+      }
>+      read_val_gpu_addr =3D adev->wb.gpu_addr + (addr_offset * 4);
>+      read_val_ptr =3D (uint32_t *)&adev->wb.wb[addr_offset];
>       op_input.op =3D MES_MISC_OP_READ_REG;
>       op_input.read_reg.reg_offset =3D reg;
>-      op_input.read_reg.buffer_addr =3D adev->mes.read_val_gpu_addr;
>+      op_input.read_reg.buffer_addr =3D read_val_gpu_addr;
>
>       if (!adev->mes.funcs->misc_op) {
>               DRM_ERROR("mes rreg is not supported!\n"); @@ -932,9 +926,1=
1
>@@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
>       if (r)
>               DRM_ERROR("failed to read reg (0x%x)\n", reg);
>       else
>-              val =3D *(adev->mes.read_val_ptr);
>+              val =3D *(read_val_ptr);
>
> error:
>+      if (addr_offset)
>+              amdgpu_device_wb_free(adev, addr_offset);
>       return val;
> }
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>index 45e3508f0f8e..83f45bb48427 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>@@ -119,9 +119,6 @@ struct amdgpu_mes {
>       uint32_t
>       query_status_fence_offs[AMDGPU_MAX_MES_PIPES];
>       uint64_t
>       query_status_fence_gpu_addr[AMDGPU_MAX_MES_PIPES];
>       uint64_t
>       *query_status_fence_ptr[AMDGPU_MAX_MES_PIPES];
>-      uint32_t                        read_val_offs;
>-      uint64_t                        read_val_gpu_addr;
>-      uint32_t                        *read_val_ptr;
>
>       uint32_t                        saved_flags;
>
>--
>2.34.1

