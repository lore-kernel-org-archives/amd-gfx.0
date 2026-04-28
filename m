Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBB0FF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 15:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A48910E33F;
	Tue, 28 Apr 2026 15:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tWlBSkUA";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9F810E33F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 15:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onXLye4OME2K9Zmx7r3v8b4hGX/YUXHx5WejBT17aNzlt/z63d+F7tSEzY41IhHDgJlF8PPVsPMNx5+BB6+9Y1tOlR1h2XNuTIdPZ6BihWTMJoaPgJbP+jaXNuELSofMMiAOg14S6tL+VW8x1huD3GYe5WX6AdWoJthFEprhHWs/wsiX0DzeaQQZ3cK+C/QTfv9WgWNyrq0Z7W3MFH5AQCiwDZUe9l2+DIey+o/7PjcAjYj3/I+mwzKuTotFOprrCGUvPfgEv2k4kXI4zpE/mSqjy+ekXzQeliP2n817Z0F2BXfpGlhUGdcPsxn6QOCR/thoHKOkQ4FQL06tcpyLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr5YrD8zTaa9bTpGessHbhW/TKniQB+zBEJHqyZ/HmI=;
 b=a7NsyPAJel8TOYVg+Lb1YKhmsYkyZhoT9eshpmWwgPpWHLKHx8QXQ417hrVlzDppejjwDRQ4dSokkQhrPg1I1I2Exwh22ttndZa2yoO963/47H8AqgyYerWVnffLhXw+6uZxsDzReamJCOq/wO854G1lBbsV4Lo1FYhWfBv9wtFRU7r8E/OZ7ej0zmOGt2Oy6tOEIsIzf+UpVdVk8TPGssQg2x8Sfp8NGBiSNlKhJIix3yV0xADBMBl7PoiCVLmKz26m4PXeM+6VJQE9oQG2rTkAvEsZAdA9TtWmI5E+CRV8lGq4aUTY7d8sxwfJrSihIKcho7ukXvPZRcAl7CFkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr5YrD8zTaa9bTpGessHbhW/TKniQB+zBEJHqyZ/HmI=;
 b=tWlBSkUArAkE+q7y5kH4QfYP6F7rRhEg8BIDSIzW4aVLaS6sUqkyxl1/KjuC6W9ybnqHEzFhUNys2dM2D8LZ+tfKYl6mh3Zqi8Z11T8r7o8TXXRZ/MMTnnthnOn8S4P0mQv2fITZbSJCniP26zHe53pz6+ryMEr9Z9ms0lw+4sE=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH0PR12MB999090.namprd12.prod.outlook.com (2603:10b6:510:38c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 15:22:50 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 15:22:49 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/pm: align Hawaii mclk workaround with
 radeon
Thread-Topic: [PATCH 2/3] drm/amdgpu/pm: align Hawaii mclk workaround with
 radeon
Thread-Index: AQHc1x9FHYXwIRNP7UODZUeU+Bvw1rX0l1oA
Date: Tue, 28 Apr 2026 15:22:49 +0000
Message-ID: <BL1PR12MB589817B73290014EE6D24D7D85372@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260428145620.1480646-1-alexander.deucher@amd.com>
 <20260428145620.1480646-2-alexander.deucher@amd.com>
In-Reply-To: <20260428145620.1480646-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-04-28T15:22:24.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH0PR12MB999090:EE_
x-ms-office365-filtering-correlation-id: 2b23d31f-0063-4b37-3a4c-08dea53a021c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 4alXxjHtPSPXYAJ3Lh8jLOIfmSY3+kZYgBB4179Ro0U9wGsr48kYJEWeLx6RlGVTiIMVh6AyrAp2AWklLFvnhvFwT6/5bIub3SCdmsBSQGgN7f5nDrEGSxyDkrk06T1Id/u3DndVhiuSkgBlVCbGi8ntZ76QRhXVNZ2X5wGAV7AqtBNO7/qpT1rAqnZYZTxVFXFgqgUS87n61Nv/UYS6zPs3GyP1H31eojDQiltMtuBCCS9QEdplSJDewkm7FuIObBBzc4g/R7hX2wuC5+P61r61LOFNLr7USh4QkZuk6+5vUli5bBSWx/Od8nXoxy3Vi7YxJbTlHSd/sxnTAxUKzIwqw79q9FXD6/KBmIjX3VlmpWNhiRAXFymcBhK6xEzzP3xnfbX2vI6pR6YOAr/FJxR9J/ACaeONNRfwbDuPFlpp974mFfgpbwzcH+S4wRucIgKqn82wuSe5mMO1IQNMBFKi3EDGpmD1c9Lglq35yIaGF64s2ZI5tacFQ7UfMAcZ4munyYgMp/vjcn0smwyLJXokl17P7jnhM8JijP8KFqnQ6Ozf35xZhtzNpCmP1cKuS58a6WRkBW+hV+QHAJu0+8FS8NhotoGbcGUhVDmua998fAXNMGjEU/WCZTGH0jZNAAitA0SS331y3FD0YsCXinJZj/HNmQQw0VdRV259KLw7wIRt+aUTrLzTwuv5XJnJo0hgMAYbAWt9B1M1GJ5cC1/I2qIL+jNTgCj4R7mISsItB0PU+xujxwmayv1KNNij
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VasCcXtW8Ha8UUteF/Zc9LOP+Agx+dhs8JCjh3q1rd692i9ZRZEK9YWac0+o?=
 =?us-ascii?Q?EbDSqNw4eE66L/DWvMjE2ysVnfbE/jURx8oMB4DCG2uCJcWHvdnU9kfAyLST?=
 =?us-ascii?Q?qzGOYHw6xABWmHusMTjiNiTtDj4b0BhcKVQqiPRuhvFoXkfoJNHgEgVcov9j?=
 =?us-ascii?Q?D1SXoUyX7/7PiLnQlLQnkTzQvfmlaUyWYi9Xo5Klz2le5FcBjqDUc4LKD9+e?=
 =?us-ascii?Q?ytptdTmOWt6+4xgnoNN33ulox90W3L1BZfcanHGpcvT5bfw8IHa08F73xAs9?=
 =?us-ascii?Q?n18sMgHwfdAcXdnvPLijMtq5oG7rGZqbpbJfcIYRnbQIvco0azEUt0xpxf9G?=
 =?us-ascii?Q?DBuILsC3w45mO06ryFXI7Vbp98F3bphNnp139MIR4xRUAgGUFNae1Zuxjlng?=
 =?us-ascii?Q?3LWKpJUzPXUbBZTUvjCRqp6fLQmIJtj0GihLbYK6hWkJes05/7y7FFsdR6/2?=
 =?us-ascii?Q?lMSgjtirdCtiSGvWIGtEb1L8GcWqJTco5a6EEcpwrBhxd/SrCk0pvhKkHOKW?=
 =?us-ascii?Q?K6oOJ19KVh3IYhSyr2VvKrVHfBYPk72lMCVnS/9p/5SBo3NFe060DsEu0UAc?=
 =?us-ascii?Q?+Vzjjj9VLIyI9vW/10MqaAZn4WuMSy63/BzOSDoqUJuTxeOxMaGAm5WStSe1?=
 =?us-ascii?Q?+d4rb9IyONVkwpZpe2IWUS8gOuocDUGBadfNYApqBtIx1JIfW03HkqXVpX+Y?=
 =?us-ascii?Q?f6nySESNtl5r0YdEJD7bYT6R0qKY04ssL8+jcrYgem+TXGux5BOhWm6LYO23?=
 =?us-ascii?Q?obkOuLxaUSIyTAPea5Fb7FnruCZWsrJKrgmc4pNa6cUWkmEOYmdokATV3F+9?=
 =?us-ascii?Q?0RwcqRqtjtZj4gzHs4lSWWZCKlxQt9xfPeLfGderBOQGXVeIbsEyk3q3sMEu?=
 =?us-ascii?Q?B3W4/Rgcq/ee6IVMPqHpVNoE4nXriajQZ9zEsMajAv3UzhUn5twHveh+2Ubz?=
 =?us-ascii?Q?eyCrzHeDaUnHh5qMJPOac6ZvKdI+CwdrPpNTGn6rquolCQyQf5WF1ju3V79o?=
 =?us-ascii?Q?uW+Op4xl4G1n7GaaMicpAjdbA5QGvu2PsIEaTfjF3cWe/sLin2Gh8vLo/c4C?=
 =?us-ascii?Q?Pk0nj76l9in7LNWjvHC8MtcL+m1gF8fpkm4i/5/zgvXoTVrPAxFzqepKwW8v?=
 =?us-ascii?Q?mFabrS/3j16TpyTnBMdvI6cPEueCaHS/O9uk/SgSbXNonzx7WGt0d3fUQdV4?=
 =?us-ascii?Q?IRPUOTHpNZ8RcSa0yRq+zV1gWFq2vgvKdLyzpfQ2y5gmnk2dOsD+5FUvvilf?=
 =?us-ascii?Q?91aYSpklp2JhC1OG3H2nRXuvdVyxeiAogYewBcIhiRRvvDHET8vfZABwBgif?=
 =?us-ascii?Q?OIL0bxPpxK+QwbAbjNX8a0Ngmj7uC3TqgOzHT2h4kOe81HfaqZDFT42PK+XE?=
 =?us-ascii?Q?yijS6Dwwq+FBMRXHZSZVdY74lbsTm1Y2topTpDu+CSHABn7E3fhSq2hSI0AQ?=
 =?us-ascii?Q?+tsIVsaEzuO8RwCoKDs7E/b5ehl7tH38hGxCP/hdAduJYoLgRIpA6lla/JnZ?=
 =?us-ascii?Q?9+eshg4XMCGa13ZDRnsE2iinW8S1W7cPj/JKu/QCpbeO7ItZcINL0j2CwaFj?=
 =?us-ascii?Q?hh4ZBYPfuEPuriq4If9FmxaZ9kGp/8UH8lBV+2lKTysMv5peDnnsS3/L9imx?=
 =?us-ascii?Q?SXNeGYSu3HE+EhOcc8UqfmE0cLIdfNRzQRN2ZTQMixLGkWwWCeIdZEhVSunv?=
 =?us-ascii?Q?EfSajnSaK7NhLChUB/dPKlzOpxWV2qSO5F0N6t/jqIv5XDt9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b23d31f-0063-4b37-3a4c-08dea53a021c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 15:22:49.4908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uy1YaiRr6caEhqOjKRgHvnN3t6yKAgIn7R4fX4Kx1yYm4CqGcTUr/tDGNp428XOUp0YV9zrob/53SGSzUYUAOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999090
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

Public

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, April 28, 2026 10:56 AM
> To: amd-gfx@lists.freedesktop.org; timur.kristof@gmail.com
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu/pm: align Hawaii mclk workaround with rad=
eon
>
> Align the hawaii mclk workaround with radeon and windows.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/1816
> Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (=
v3)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> index 6e89a032e3dcf..aea3ad523cc03 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> @@ -1336,10 +1336,10 @@ static int ci_populate_all_memory_levels(struct
> pp_hwmgr *hwmgr)
>       if ((dpm_table->mclk_table.count >=3D 2) &&
>           ((dev_id =3D=3D 0x67B0) ||  (dev_id =3D=3D 0x67B1)) &&
>           (adev->pdev->revision =3D=3D 0)) {
> -             smu_data->smc_state_table.MemoryLevel[1].MinVddci =3D
> -                             smu_data-
> >smc_state_table.MemoryLevel[0].MinVddci;
> -             smu_data->smc_state_table.MemoryLevel[1].MinMvdd =3D
> -                             smu_data-
> >smc_state_table.MemoryLevel[0].MinMvdd;
> +             smu_data->smc_state_table.MemoryLevel[1].MinVddc =3D
> +                             smu_data-
> >smc_state_table.MemoryLevel[0].MinVddc;
> +             smu_data->smc_state_table.MemoryLevel[1].MinVddcPhases =3D
> +                             smu_data-
> >smc_state_table.MemoryLevel[0].MinVddcPhases;
>       }
>       smu_data->smc_state_table.MemoryLevel[0].ActivityLevel =3D 0x1F;
>       CONVERT_FROM_HOST_TO_SMC_US(smu_data-
> >smc_state_table.MemoryLevel[0].ActivityLevel);
> --
> 2.53.0

