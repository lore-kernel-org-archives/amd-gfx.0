Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621D4C7EE2C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 21:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDE810E27A;
	Mon, 15 May 2023 21:03:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B1A10E27A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 21:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZGk5qyeejLh1Ls1yv2Q41k4k2IyFcTS8pIUlPUlIryKD7/9c3HDys9LhlMblgv+9+cbMNhMQdEvQNJlR1CqDvM450oDPvacIkwEGJ/a2wkPhMh7fb8qJhnUP3MBJPPIlT4ErWM7JuBlI/mCDDcSC9w/DhBEHZHyQ13a0k+Sgx1akaVCC/q4+kiKNLE2ViGXniseDLCGxem2H326gLsYqACjxvcq1Y3IKmKPnKrBgT0ZSVat4KOCUNlB+DC9moIYUL43sKgppSpVqIl9M+7rDvFXYDxA0y4oQVIY1KvQqYEQGOJXFqlAR65FzbkePJT4Lj206Ndce4kinsgzgnXVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+1wWEnSbT5libE+uBWY5yMddExdg8zzwVPNXwavbHo=;
 b=eCuxyig3L4E+fpE00Di8vCCkhT2Kkm6RBQ8CMA0L6TNYWVblju1n/e96658PTUyTam/YtKryiqPaGj1/sJuFHy+5VIaY6y71LqFFS1an+RYvGs7oOzzfliZlDESBb6EWmTZNEpUral+e8pppHA7+UpTw3bWJ0oZuNWhYYsL4BEsSeluz7dalYP1JOVziIU5OjJOKHYPnl9wB9wd1pDigPiDTTlKrOn/e520BXbgsafFZ6HiMe1VBA62yFXY0ovPFL917eN6aQzz97l2cZ3cLaGVxmrr/nNicawXZAesDro6gl/87xVwZ1Y6e8XlTUg+yeTSQLFeO8NhQYY6dP5lZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+1wWEnSbT5libE+uBWY5yMddExdg8zzwVPNXwavbHo=;
 b=csNbcYURzbtpaR7Nhvamjh8dlZluxVMAH7HSiZSvfGcaOBqW8tk7vcISLPq8iMitIBoIdxNeH0kOzEcrXExAyNMV2beHWoyvIXuHUwTsbzIAFQOLIuylFvwXEvsyNcmqa4NbytjW8kgaLZ8x2VjFHXWXgSSQyk6y8xG332Br6wE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 21:03:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 21:03:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the EPERM error when get user pages
Thread-Topic: [PATCH] drm/amdgpu: Fix the EPERM error when get user pages
Thread-Index: AQHZhvSJLoJgKq9LAkmhjpdg7FujYa9b0zTw
Date: Mon, 15 May 2023 21:03:25 +0000
Message-ID: <BL1PR12MB5144B04839C7DF2ED7741A97F7789@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230515061342.3328610-1-Jun.Ma2@amd.com>
In-Reply-To: <20230515061342.3328610-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-15T21:03:24Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6ef56a9e-002f-4205-866d-bdb7d4fb782d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-15T21:03:24Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b47b1e22-37e0-48a6-8fdc-518cdbbf5a7e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4240:EE_
x-ms-office365-filtering-correlation-id: 1ebf55db-0eee-4bed-90e3-08db5587d320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Lv11m1ZEf5XNjBlBZkjbdeiMFVRsp3+eIaMCeu5V76A0nQI8r6sYw9SNsY1WSx64OL1A2XoahISkHDqqBdKCKPvmw9Qi/Fg5go89M8xC8Vin6S//7PD77Jsl0Y2MCEztWVxp35q+RHvshjIxc06SJYF42cVOSi3vN+4WLSK5hch4k0OEIsK8LOrSA9VJZ0t/R6C4DfZmv5MC917TpOng8o40AewxR6Cft7a5WdI9la8ZPO86p9KSN/e+uN3jkXjlCWEvAqv1MYMuQDLqjeyfCTA95L2+FLg2Iu9F1yt6LZQJPlvsnJy1C4h8gn/dbt2UPLB4P3ulcFe+YqVOZ6orRKyhN3j1wuLhLlI4IuPO+jpdpZ9ktnSGsg8Orj0DcT0bZ7mZH8ADac8x0TY8a3m58Xm17O1Gqajg5G1uHIhWdzbwKLzAlir8E+0IcK4K9w9HnpZrgZF5IzC5uMiz38krmVL8VLUr7a4rOCvD6ejvqNKHL7faGnoGiEHGA3XdKjFL4f4bcb4LPNzZ0uQm/CqM8Zf7o6dYkZMPtKV8XUZFHdM+5lkqvZQzWDC45cYA6bysrFKN7rbgS1HQftFhbyXSyzBXMme6iyPw6HNzEKTKNXHId8M1qA9Uy2Vzu+m4Q+A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66556008)(54906003)(110136005)(478600001)(64756008)(66476007)(4326008)(66446008)(66946007)(76116006)(71200400001)(316002)(7696005)(8936002)(2906002)(55016003)(8676002)(41300700001)(122000001)(5660300002)(26005)(52536014)(33656002)(86362001)(38100700002)(38070700005)(83380400001)(53546011)(186003)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fk6PLKBqPkArW/unN90ZMxaBc9QapreHY/i/lH/A2PM0wmpkQeeTEmpxA7ld?=
 =?us-ascii?Q?fU1ypOdRxvZqQ/pd0dZ6tc26n/ijgTw7sV+Ogrxc0JPr56BCKRZTq/oFDuHk?=
 =?us-ascii?Q?TVtRjysOMVxGi787+4RQHfLLxZ89yWEA28KTCqrYFaGHf177JQLfR9jWnl1M?=
 =?us-ascii?Q?YlLSmrQ4xVHi/odsAfTfQ5EO5BSpiyfeATmPM7zhD2HBUixslm7cWFoKr6AR?=
 =?us-ascii?Q?PDyW/SC/MAm0gYxKlwhoxtkHHbcEVVu63o3/AJK5WrChJegovWiaxbwvPue8?=
 =?us-ascii?Q?PGXCmBwP+alKmrMj2UQpTRwrKZ/dCgzG9B6GYOObFcPz5EvplZDqpTcc2QIg?=
 =?us-ascii?Q?mAj8O+csqW9WZOGHHEhDFNRvTNct3BjJepGu1WWK893lNJFsPYN3U8LtrVJz?=
 =?us-ascii?Q?/PKLsBI7Yn475j3n5igmJ9pJwiACta2dP1phO1UBLOuUmK01HneM77eQFmqO?=
 =?us-ascii?Q?dWE7stXNAvsNIhROCBoZsAy6eFTUDryHyu25oh/9OMxq7eg2qMV5PvWjiwmf?=
 =?us-ascii?Q?XFphBhEo22MuDD2aFcnCroDZw3YMYQMLefUNEYVw7Ddv+LtVK+EKA0q1uieS?=
 =?us-ascii?Q?YgYJDtm2eCIRKDmAYh5vVGMgXAZXdgvup0CRBjNo8HTqH4ZjPu7PmKaVy1j/?=
 =?us-ascii?Q?9y8RQrS6pTq8b2knWvbLrfxvk0LVX4sobxr4Q88njbJpRQ0mwPZbSrWthU4z?=
 =?us-ascii?Q?XBKZhEqg4r+FLZJHfozaFe07Zxd4ZuuVOBL6FNz89OfDTrTI2DLVv4fE8W9X?=
 =?us-ascii?Q?5MaTEpexM957HC9I2GSEnr+K7exampW/8SC8srVLc/F92X/zzyb9nqKPutWP?=
 =?us-ascii?Q?zEesFxbDvZJnLfeBRTICyGL2Diu+CY9R9fZCm1OMxCtnLFw55VFCpBNVriCn?=
 =?us-ascii?Q?uXLFkurVNyRnUWMdkDbODbMo48qFn1826Wb73z9YVu/4+uhCKWAT7YczvQYH?=
 =?us-ascii?Q?KgHfvzPNEfRR2ahkvkwpNNEncw8LoZLxY4wsZ3htxH/7ceOqCv6ivMPG1bto?=
 =?us-ascii?Q?CJWdXtywPfJZZ5BhZObXdoySB1Lww0R1I/DyHKMj9hgI5oDWDJ5B6XYkAoy0?=
 =?us-ascii?Q?oRByyWfocXR1enKUFMWi/CfjjM0zl/Y5NY6CnirzFZYOS4nl0+5F8YNaccW5?=
 =?us-ascii?Q?scZEnaRJmkmOHAU56q+9h1cfn/CeZrhW8eaQASXecwFNaw1Ea0pkhGW3e0LC?=
 =?us-ascii?Q?FQsdUUgXt290nNJl+ByJiiGbCu0F//sgmPncu1Xz1eVpQAdCNUsFRv2gIsvK?=
 =?us-ascii?Q?AV5BCp2zvYW4dHjPvKVokt1wDKXMgQXkw14FNs7v8l7pAxIf1IwwbLlUh3ZC?=
 =?us-ascii?Q?9RsYLP5ixKgSpJ7Qp2X4rKx2QiH00mIJ1EbGn7fZ2e3HjY97yXqOlFScxpE3?=
 =?us-ascii?Q?4wq0kUANqftAwI/8R948+VcsZSBYMProrOXw7/W05APLvuN8oHg81uSWD3gQ?=
 =?us-ascii?Q?Rg9/Wsy9UJUXzp5o0moYFZoHVgSBBVlk6fHTlj5gIgA+YiGWmLMqBNhg/Gaf?=
 =?us-ascii?Q?RH9hfTGDUYL3EV6+ZqVxbzuAhV2q4wX17dHT+zCyObApYmf70yleW8Dro46C?=
 =?us-ascii?Q?KQyiUexpwj22o+0lJJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebf55db-0eee-4bed-90e3-08db5587d320
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 21:03:25.3943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lBrfW23Fba/PVqp7rYgRrgQXEorGIkscBE2iGfraCEMvjUoSnSQqsxGkvFy9lc7A1rvqjPk1/y5P91VZHileA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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
Cc: "Sierra Guiza, Alejandro \(Alex\)" <Alex.Sierra@amd.com>, "Ma,
 Jun" <Jun.Ma2@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma
> Jun
> Sent: Monday, May 15, 2023 2:14 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Ma, Jun
> <Jun.Ma2@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix the EPERM error when get user pages
>=20
> Check and pass the readonly flags when set amdgpu_ttm_tt flags
>=20
> for readonly ptr pages. Otherwise, there is EPERM error returned
>=20
> during the KFDExceptionTest.PermissionFaultUserPointer test on
>=20
> ploaris10.
>=20
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d426333e865a..85d1087439c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1036,10 +1036,17 @@ static int init_user_pages(struct kgd_mem
> *mem, uint64_t user_addr,
>  	struct ttm_operation_ctx ctx =3D { true, false };
>  	struct hmm_range *range;
>  	int ret =3D 0;
> +	uint32_t tt_flags =3D 0;
>=20
>  	mutex_lock(&process_info->lock);
>=20
> -	ret =3D amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, 0);
> +	if(!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE))

Space between the if and (.  E.g., if (

Alex

> +		tt_flags |=3D AMDGPU_GEM_USERPTR_READONLY;
> +	else
> +		tt_flags =3D 0;
> +
> +
> +	ret =3D amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, tt_flags);
>  	if (ret) {
>  		pr_err("%s: Failed to set userptr: %d\n", __func__, ret);
>  		goto out;
> --
> 2.34.1
