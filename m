Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6C0E6918F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 19:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A17210E084;
	Fri, 22 Nov 2024 19:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/+Vhsor";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E90D10E084
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 19:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKD4vQCJwt0ef6yUa3HBWNSom03NGk2EB382V+oyopN6SEWMT2Fjp+9lDDbCrqvMKEcL/+f3Fq5j1uqvrZds3CRv2kr02XpbPhcCFJNVXxyYezFXE6avi69/m+/Q+JthzlLDYMJmt25Q9psPttNQNQBzeq8Z5SpOabeNueOj7F1JKOvLNEm8yrvZG6HrlbijLef2DN6THD8xCS6RWHVSf9gGAsA3ZEpKgP4J9hBIBcBS12x//14FsfpgMhtX/yflLwR4FJZSQEs087c+5IprV9jJ7GYmP1/qwr5aNKwQAoawYFGC+9r62FL7T5wxSsoHu4f2G46m4fvh2BwuxhAmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfop0ju/Vor4vbEwewdwGGMNXEHEU6E7Suese+7YkUM=;
 b=I19RGc5r919JWonMFoVOQWMGzlZJazWgM9+sBtp6kkFiH+0UmqCh6DvpnmRhCRGaR5j8vDUqWdEnyCsZ665dE2s2e12vFuAmPuNcIo+pxx2BjpmkgFNgY5/xHdts5xh2KT9AGmw9+92ZhlHSHbgFkcHj3xrLWaZZ4alPP5EIiV8rbkoHlozeXQJUhbkGWy7AOIC6mplLXd6qzcyR39UqH8mbN04cz10SBsCELJ6EWSPgCOWjhbD1IlghovDu8EMYmd4i5IBXd6Z977zfWSYndr/ONFlOUl5NJVnG+gJHJrST6JPjIFpefQ7XZuV6bqHCr1UYoaabnHU48gnUmJMZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfop0ju/Vor4vbEwewdwGGMNXEHEU6E7Suese+7YkUM=;
 b=E/+VhsorqVtKz/2oF47rysH3PaHiZ9iDRywR1IcSepkHSDE/qFU9mXzjawGQOwHQsp2CgRrMZYiLLE1zGqRdqjfmFXatZ+Akp/DNhvN2QYz4Feb4YiLvLDlzDvFmhsPDsdcHSXT7dt66okku2noP9rVv/Kjmnt9PWW/FDOlfADM=
Received: from DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Fri, 22 Nov
 2024 19:34:09 +0000
Received: from DM6PR12MB4481.namprd12.prod.outlook.com
 ([fe80::2f5a:1dde:a3d6:942f]) by DM6PR12MB4481.namprd12.prod.outlook.com
 ([fe80::2f5a:1dde:a3d6:942f%3]) with mapi id 15.20.8182.018; Fri, 22 Nov 2024
 19:34:09 +0000
From: "Zhang, George" <George.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/jpeg1.0: fix idle work handler
Thread-Topic: [PATCH] drm/amdgpu/jpeg1.0: fix idle work handler
Thread-Index: AQHbPRFXDu/a6bwUhUSk7wI/Jv6airLDsLyA
Date: Fri, 22 Nov 2024 19:34:08 +0000
Message-ID: <DM6PR12MB4481530D16AF3A7491B512AD94232@DM6PR12MB4481.namprd12.prod.outlook.com>
References: <20241122190337.1145702-1-alexander.deucher@amd.com>
In-Reply-To: <20241122190337.1145702-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=41829f42-f350-46ec-a72c-3f9962514edb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-22T19:33:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4481:EE_|CY5PR12MB6431:EE_
x-ms-office365-filtering-correlation-id: 20a112db-bc05-4434-86e4-08dd0b2ca295
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ocxfIn4gjHP6zc2yLqkvx3qGv6S6H4DNxPXU7Yxuqa588WkNx8yKXVUA1Uzf?=
 =?us-ascii?Q?3olBDP56XR/5Q6Z8CeUO+uGY2ncbJfpF9W3sT2rISBchGi4xNPmIhVqaXoC9?=
 =?us-ascii?Q?rQrUibVbPuHvYVS8ljWpmDWwEmLCyw0R61QsrZSUfzJWi07gVk1pOqAyxadw?=
 =?us-ascii?Q?01bhSYBWbiDXuOfi5t2IGKUc21fveywjugypbQ2uK7wej02jJ9eVsE16lqo4?=
 =?us-ascii?Q?DMy6T1kqDitkG4Y8W7Ru3sLhJP9KV0oWZLcM/F81rOEAQnbCX8vQZXEmR0gl?=
 =?us-ascii?Q?qEbWlhXUErGsAUVllInTwdFCgCjzep3ZWbA5Bba7uoZ5Jan8XqmsDFFSjRDd?=
 =?us-ascii?Q?DFGeLXjccPkpwt4Hi6DIQgpK+ys1x3/57AmeJOmxaTE8NPiZZ9nxy8Jve/8S?=
 =?us-ascii?Q?TqRTQADL99ig1QuDrUSs21jeEdNUQpQ1YvLAazlrtrMHpcbFJs3OYL4yJ73u?=
 =?us-ascii?Q?2uU2C+2l4y5Da37pu6S2cM7G26omSnCGrMLUjxAB3FxyaN/7TqLq9WktNZ7i?=
 =?us-ascii?Q?fjEQv+gbF6qrOyjYn23QyqZm8utMtYISd2dNilYNp8293weEcO7dy7UoqKnW?=
 =?us-ascii?Q?3/41qx4oOBHco96Hw+nJyhcileYHGs8VllGxgIH9nyRdP/9qBNK0Xe/X/BQO?=
 =?us-ascii?Q?SWT4crU0yy8mHFP2sYUksAU7Xa7mfRqDef+kwHE10g5cQpW62JpDT5bGvDt+?=
 =?us-ascii?Q?2Y9tzjf5Jt3fcFaUqGDQ8jtkU3+oFfS0BAZYdRKIMW6aglv/I1Tzw3qzuD/S?=
 =?us-ascii?Q?XojdT+3ez+HqHNeHCedTt7Nn3Ezth1OGvJE9lCAKf4ap5EjOjiDF3QxKBHJ9?=
 =?us-ascii?Q?e2w09/5eUm57NAWp96WR6ZSr8pwNf6Z5x2Aqsn1xlXrA1oKTtKPIF/sZaZQq?=
 =?us-ascii?Q?HlcN8EgG4G2nGbS+9ImSsSd0ADS8cqQozO+M2jsUqV2eWNTNYqejA1QR7Efx?=
 =?us-ascii?Q?G4WL1IVlho6Gl9+ou9mU0z7uPUNlytRottecYQBAWydFVaFEsQVuE8f3+dBK?=
 =?us-ascii?Q?Jo5caZGJMZxJ7GTzet6WY53u+l9OTcHeZK1Z3EMpIqFAWNMPRsAZOFvwxbBo?=
 =?us-ascii?Q?yn5Osd6GtQ2ACg7lq1SIqD5IP6+oTNkBxKNjgcJPNoc7xf29YusMZQbE45DB?=
 =?us-ascii?Q?SduurTXpdmdmauwEFBRo2r6Fp7pUYyr4sOXEzU+x4vwPaoOiGosLBd5nJYQN?=
 =?us-ascii?Q?u3IrMjsUvIlQ/EotoYQgww/QazALXAeU3av1k8e8oWhB6PbysGnqAyh+5awS?=
 =?us-ascii?Q?vCBzoCK/MQjKmU1Ou2wSOGwnQnixKheqo4ec66B+FVepwd3FtiNBsOK5eAwv?=
 =?us-ascii?Q?bVJ7VIgoyM6jbpQy16t7NVkjpYuBD60TvSjNGi1Wkcn8IdT3lSWsfSmAWaDL?=
 =?us-ascii?Q?sd3ZctQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vveCududXy2voNfIjFEfOEc62lM7DiS6+bcLdFSHxKdTgscAd/mqH0lTLMHJ?=
 =?us-ascii?Q?kQZ3DOlMovjGnSUYxPW0hukys6K3neZQ0k3cdy1VhGQ8TXJZvm2MxcG+TYqz?=
 =?us-ascii?Q?pWanCsMIF78QOWgnkbcc1+qV5jns0sQaPMNsaAeKrx9BJiPo+QAhgFzhb+E+?=
 =?us-ascii?Q?IeeXHpbWcGpg3PU0wv5OtKTvmgkLrJgUXOR/hVq7CADP93CGr8gb3i2m4WfJ?=
 =?us-ascii?Q?L990g5MmUeRaB4gEt9IPZKJahLuNrsB3XGhVaPqMlHnCv1ev3oCrS9KwXSrU?=
 =?us-ascii?Q?n8UBEV3RxJuZGp4QAHLn92pAFpoRRwBOQP+d4JENGedhkhJDwFYYHNzuzPh6?=
 =?us-ascii?Q?Es1H9LSBfbEULTW1nC2a4k3Is9SWB6y+XetGrsF6AIVoQaksKiS/pBDmkxtP?=
 =?us-ascii?Q?Nh3uiMd8zfeJC/IKd0VM013w8aJJyjXrkk5n7y/qDcHaOdPUUf2NyWlYi5J+?=
 =?us-ascii?Q?v0XwR4zFEDzpG1GTfeu2UkNQmsduj0lsStrfO1IjtdYMcj8NISp8shK+jywh?=
 =?us-ascii?Q?UyNmgri46BjyEELoJ+jDoQlypurMiyfEnhRHhyn4pUY+90cUpp6F2HEBpX8r?=
 =?us-ascii?Q?Wdxvpg5nOanWMdsJpm7tNkDGvTggDc6WxLjrmV6nxp8KDAcNG59tqgu24BEc?=
 =?us-ascii?Q?xKS3ahf31KAlKuWUhFazvAvRUkgwvzXXRV6cubquPQobV67kz+4UPHiD4Sw9?=
 =?us-ascii?Q?S8bvGJOnMjJKvmAVvCdTcncQ239M6/o6wFkDdsD25qkuuhCi2XA2o/oa7yqQ?=
 =?us-ascii?Q?bNNn9VlioaR0kXhtaTPLGHNUObdKevdx2HfOxn5tp95BMoW13zN7Du0Y8qr4?=
 =?us-ascii?Q?XQVp3XygKkN24OzwZq+uABUaVwRyldS/CrbWPT6J1qaV+uYOO2PBBjZ6+Ac/?=
 =?us-ascii?Q?GEnBrKQybmDY4m88LXhTGgw/7Rk9qRSJJo06PhnJNhd5wU5sg3piuftSMyiZ?=
 =?us-ascii?Q?Zd8OWZbhXudmXLWQPHumJNXW3/hJM495c6+A5Ik0klPWGh9X5uLcSMuVVVQI?=
 =?us-ascii?Q?KePkJG+kPDXEmQZ8BA5AbLxNczSqaxLsBfC5TeM273JfbB2nU4WWyjKUnHSa?=
 =?us-ascii?Q?jst1qVWUrdqte2GYqTB3iBjOvd5UoTWIC6bfTv1P8bhE8xyqV53VL312AdMs?=
 =?us-ascii?Q?bpWPTJfCxFW3MMEku+AUBJOaVTK5FvARWgws+OwLATMVUBqBYYoeZqqjJNO0?=
 =?us-ascii?Q?rKpxlRHmOtUZGSNCJP0syibT4J+Pbj9Pz9MphcoKHx6L+/UGaE0grrth8Gl0?=
 =?us-ascii?Q?u/cLPbfYJo9ETWPIIiQtrZGpi3xCWgLPHtqLFGHNXH9/OVxyhEQsUGbJGZdN?=
 =?us-ascii?Q?c6TtXwThM2H1eER1twR5nnOrlaL6r3J5XKbQQ1KltL1Lvkl3F6skvdQHQibC?=
 =?us-ascii?Q?jh5gTax6AY/NLMMHkyYQyyrQahVUpdHvr9zBlSqjpK2u9qjSdFY4zcLcARW6?=
 =?us-ascii?Q?qeA/um8HmT5iyjOwVJk2AY/9I+S7MR8rlJWLqQVZeXrBHmjdqeMRyL+BvoEW?=
 =?us-ascii?Q?fxsQbAof1uh//K+zMNV45ZuI15+M14hqwIRk/EpczaamNl480MKpZ6mBFYRU?=
 =?us-ascii?Q?BBGlCJEs6Jioo1WxLR4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a112db-bc05-4434-86e4-08dd0b2ca295
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 19:34:09.0087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMY/8Awc59xgOnt7EYvFpqQae6xDrPHSUwBSGgeePYO7t1fCnF6ijc+LsyrgNnGQEvAy1cZsNwYCqSLbtapeqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, November 22, 2024 2:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/jpeg1.0: fix idle work handler
>
> On VCN 1.0, VCN and JPEG use the same worker thread so cancel the vcn wor=
ker
> rather than jpeg.  On VCN 2.0 and newer there are separate workers for ea=
ch.
>
> Fixes: 93df74873703 ("drm/amdgpu/jpeg: cancel the jpeg worker")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Tested-by: George Zhang <george.zhang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 7319299f25ae..03b8b7cd5229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_dev=
ice
> *adev)  static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)  {
>       struct  amdgpu_device *adev =3D ring->adev;
> -     bool    set_clocks =3D !cancel_delayed_work_sync(&adev->jpeg.idle_w=
ork);
> +     bool    set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.idle_wo=
rk);
>       int             cnt =3D 0;
>
>       mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> --
> 2.47.0

