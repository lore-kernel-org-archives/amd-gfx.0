Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684CCC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 14:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CA610E819;
	Wed, 28 Sep 2022 14:06:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 910D610E819
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 14:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csiDyRpOVpazV72eG4kPTRNltyI+pPUf0igvBd3Pwoqg9mDkj9XBZVcnwDHnBTM0fFBFxuzCWEldc1pWyh+GtBydNxnkIeHi+pNA5aR5BgrWEvIoJby4neMhvOAqCvzq9HceNzTdU0jfxFZKQyIebHFX9Wyqh+QDFRpBEZ1Ss1vHg2JoFFB9IOgDEIpbL9dsSl9iwjlBwoUVQEMGZ5ndk+zuSLMEufyWn5fomJdLROH/YjX8zBOnRbqUdvVHIo1L130y55X1vAPjnKzQRfJR+KxwSMkhnNmSeClCog5J5zKa3B7KxV3xKAqOeH6xscmzvwFNQW64F2jLtqnHGeo2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG8dHPvlu4ve1t9eeBq6rrnRVWzJADvetJxKNnJFYk4=;
 b=ocTA30YqJwJtyjQs2VLowc5LRjS8hCmvnh4KGDfzefx6HdFTl78kiSd+OZVp9ttMkR+bWarOJkFRoWw97BGC3zErE2KeC1514p3CZ+6mPinetJxf5ouslQIoEg3SxhIN3kse03bNZ2fDDXDOPorn+XQdcMFGsYPE3fmnRuu/q8FviHnozRZPCzA3UixbML8V8nXN3VSBav0ZnxQR7HP3DD2iFUSzKN5BLNEI5MPdaXKx8cSDx91W3CxrP5d0os04m8MS0XHrY6MPC3QX6uAaSZrFjyWJ2Jxv0RmipavghG9x5P2pHQX99b/2oZDeUsNvditU9OxuHl2AuyjyNkP1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG8dHPvlu4ve1t9eeBq6rrnRVWzJADvetJxKNnJFYk4=;
 b=YMp9FbxoMT2cbe0Ha30ZXkjIF6RRoehMkzvuJlxmHU1oHeQVjJSHeA5RXYDjWZUeKelAtEi05uUlhw8LlXcQ7e5gvNegghN5xQMkZXGI8le8VCs+A5pnRIc364P/X9SUGLbiflJsrUhUaTkSxsVql7AU+3XSyTzEUUEda5AQWuA=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 14:06:46 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3c76:8e77:b067:49ea]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3c76:8e77:b067:49ea%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 14:06:46 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Topic: [PATCH v2] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Index: AQHY0fhVlW3bztKHP0GNTJY26gijTK304ivg
Date: Wed, 28 Sep 2022 14:06:46 +0000
Message-ID: <DM6PR12MB30675BD7F94C8EE8DF33C0718A549@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220926223531.956693-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220926223531.956693-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-28T14:03:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=608ee4c3-3d7b-40d8-8120-b3d08484e4ee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-28T14:06:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: aa4209f5-da04-43f8-b517-5985f09592ab
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|CH2PR12MB4247:EE_
x-ms-office365-filtering-correlation-id: 18ea05fb-3e8f-499d-7556-08daa15aade3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGshr0LQEHeqTYjUKAf1411BiBCwolD8qIUHdhbFlslKpnjzA5tyVM12e52aH63q8X7qI3KR148ORqayA4hVivXC+b67BZVyDyIGWnqQ4MJDMMieK4712FpZz+IGJfkGkhZQjmAVrOsNFaGw5Jqa5phWRUn5iKyglSm6JUB0F9zMQHYJiNGaTafHgy/ZrYLfQrSQsNvAqBC0KhAWviX2R1/hgwiWIprOIkAUty6JY1Vc1/lkObW+eQTnNbHJk6Y9T1euiOKbiwONFlo5wqNXeL1Inay0UBdhXZXp5cWTpzhzLxx7NtlfK8Qm+1l2b180QbMqv/uJpYQ3Q9UE85E9uj/Ujls6mZbyHlAGP/UUsfnYeIh00ZWX9vbqA5qRYbfpj7j37FgeNcJU7V3LpZP7uFDHl8ApyFJPaqf0hM7uPp7blDAvRsCnjoAayOdQjzSwoxKvOLNdirvV2qKp7KXyFtasxAJ+fHCw7jK8xsRi3ZeMfeiAcRqrwO1SgDDPRmy+XIdBetuKhcGxrPq1XS2wklvIDxhVYvNUgTgs0Mpp8hida0AStPVYmBGrjSMn1YfKqX6yXs7TRqIuodwi7yjLPxMgIAPMOJRLFOieG5llz56vJLWHaEnKuGzhtg+fSDrH29RzktbYBNGfwk7N5Pb0lWvz6g1Y75NdB77nAafVcQ98wy/qPVzCseJSZIQ5i5GEfGCKLwSFE+QEJXnApacviiKXSFbhr5HLpWEpyn59QHRc9p58/W4qnNO/hQN/oWrSdvkS+CPR37iGmGXW6RJexg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(186003)(8936002)(316002)(4326008)(7696005)(33656002)(6506007)(52536014)(53546011)(8676002)(76116006)(5660300002)(86362001)(9686003)(110136005)(26005)(66556008)(66446008)(38100700002)(64756008)(66946007)(66476007)(41300700001)(38070700005)(55016003)(122000001)(2906002)(83380400001)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wf9zjg0hz7wbDC8FGjU3Q8kggh7GiZgDn1bgf1b2WpuPJWQZza36TGamMaDr?=
 =?us-ascii?Q?RfPsNhj3jj4a19FZJo3ptXJzKgRGrOBKSaBzeOhAJk9fnpwKdP130jeOoeqB?=
 =?us-ascii?Q?TseDp2aIQ+Nqo5yVQcBgW1qLD8WZT/Fxycd15YklfPlkiVFXR7g0D2of6ebL?=
 =?us-ascii?Q?fqrf9nHX2+/00MaqNmwfJZ054Ywc34Bjz0K1yjHWE/l+hDoWotSKBsxZmX6v?=
 =?us-ascii?Q?zDydGXXQvzKsJxdQuWUQqx2j+K9Y45OFH67mGhcNZdmL+pamvFgRtd6MTEd4?=
 =?us-ascii?Q?RgUoVFd0il1AQ91yavnbXfFUVgzgNTxgNZAiE/qfxlzawxzoOzjthBYSQePO?=
 =?us-ascii?Q?Ss50i9ayCP4h5DpT9xpf6BTkB+kgFo0XU7n9h4TutD8OxqhKq5VuHf0OLo53?=
 =?us-ascii?Q?tnmoD/bGF1P8zeJQ/kPKtXijElNAH3mEeg3Eg95QRZIeh2dqmChz9Mp33L7Y?=
 =?us-ascii?Q?nMWAJt6McGyXWDYoXqu2jQsC02JfhxGsV+olSVV3ruALLBkuFuCiEW04Bs7A?=
 =?us-ascii?Q?rI+rJHS/WGphLmPOBZEuz+4/I+PnPmyn5S209xy4hWISNgGkncDj0k7OvJnl?=
 =?us-ascii?Q?o7zF1IYosFtk+3txFiH3qPIFaXrb5JH3vM31nagueGhlsesjZffYv5gy7+mo?=
 =?us-ascii?Q?UaMOYxKfg0qNAfS2QgGspQOtzsACGKFle1OjpwDbLdz7Fd7q3RR0qxUzqNz8?=
 =?us-ascii?Q?NncfiIadp7yG4J+zoOPcv5vtAsEVFOnve43Hedhu5t2mp6gIUAZLNVqwhaXh?=
 =?us-ascii?Q?cvLUBRsMxRjYskby3sfabAfTQrUGhykOMlu+2P9KIj+QL9HJ6AJgEEwEsfG8?=
 =?us-ascii?Q?8VImDuLa6AjN6s1Um1qH4NUWPUwP4Ipq/ksBkwmdhDGv2Jj1vudkI30cssdm?=
 =?us-ascii?Q?dqqbqRSfeUggZ1EG3FvBumoWLXQOg/OqZH4KjDJpCg09VL04n0FQ6evAF0CR?=
 =?us-ascii?Q?tVVtcTE/+O4zwxVPkzqvkkpSMl1G4ja6MTr2H1W2DIe9krsR+ItRrSUXAVO8?=
 =?us-ascii?Q?TC3eS0k7/w26YAS5z0YAe2GIOppf9cWv6y+dI2vwX8X6sDJORoJICWKV/2RQ?=
 =?us-ascii?Q?U0otww8ZhPxkcz8WBRqA47yyI9DO5SEWUVIQOEnYpD9VmyU6jlBS5VS7854w?=
 =?us-ascii?Q?L4rc3DDjrV94aPIQnkFLzy+rM5QGvul1IPUDDHt6DIHZMvJ2v4rTAqvcOzdr?=
 =?us-ascii?Q?guDKU7eJ/wtosQanZpDMwAMQpcHz4gLGH3UBaPyGUw7XkuHy3ygVzE8qra2e?=
 =?us-ascii?Q?2xN+ppFMyW+equhtNnVTlRi0L4YjILPFf3wa7uv0lb1WQ0+yWdBr93NlWnfp?=
 =?us-ascii?Q?s57uzfAVtLteHalge2O+nxq1uT07aH3GSPn+F60gcVm5Ox9PZRLEg4qIfvZp?=
 =?us-ascii?Q?hwEgbDivhLOqiNTbOBA93Nj0N8aXqz01pQ0p066zZsBo45nyNUU6j/nieVZj?=
 =?us-ascii?Q?JQGFyaT1LPYK4GjOWXJ0ZeDs3LE16iafRQ1/VYS+/RMd7+I+Cq2O0wUrycXr?=
 =?us-ascii?Q?/UltFbp+cm6Rahe6HJkJJfGOlMetJZK8P98vPw5pcHTTKbJWqjEe/yIouPhz?=
 =?us-ascii?Q?VvrdwD0BXHR3TUzrNfM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ea05fb-3e8f-499d-7556-08daa15aade3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 14:06:46.2215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11Sx00U40b+wewFu/M2dtVeCxIJAagQjc7ZL+vTUdfb650MCR9shk51HlRpfSZhIeBs+gtIXnUG1OgqqVi6nAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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
Cc: Ellis Michael <ellis@ellismichael.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Graham Sider <Graham.Sider@amd.com>

> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Monday, September 26, 2022 6:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sider, Graham <Graham.Sider@amd.com>; Ellis Michael
> <ellis@ellismichael.com>
> Subject: [PATCH v2] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
>=20
> This was fixed in initialize_cpsch before, but not in initialize_nocpsch.
> Factor sdma bitmap initialization into a helper function to apply the cor=
rect
> implementation in both cases without duplicating it.
>=20
> v2: Added a range check
>=20
> Reported-by: Ellis Michael <ellis@ellismichael.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 45 +++++++++--------
> --
>  1 file changed, 21 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 007a3db69df1..ecb4c3abc629 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1242,6 +1242,24 @@ static void init_interrupts(struct
> device_queue_manager *dqm)
>  			dqm->dev->kfd2kgd->init_interrupts(dqm->dev-
> >adev, i);  }
>=20
> +static void init_sdma_bitmaps(struct device_queue_manager *dqm) {
> +	unsigned int num_sdma_queues =3D
> +		min_t(unsigned int, sizeof(dqm->sdma_bitmap)*8,
> +		      get_num_sdma_queues(dqm));
> +	unsigned int num_xgmi_sdma_queues =3D
> +		min_t(unsigned int, sizeof(dqm->xgmi_sdma_bitmap)*8,
> +		      get_num_xgmi_sdma_queues(dqm));
> +
> +	if (num_sdma_queues)
> +		dqm->sdma_bitmap =3D GENMASK_ULL(num_sdma_queues-
> 1, 0);
> +	if (num_xgmi_sdma_queues)
> +		dqm->xgmi_sdma_bitmap =3D
> GENMASK_ULL(num_xgmi_sdma_queues-1, 0);
> +
> +	dqm->sdma_bitmap &=3D
> ~get_reserved_sdma_queues_bitmap(dqm);
> +	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap); }
> +
>  static int initialize_nocpsch(struct device_queue_manager *dqm)  {
>  	int pipe, queue;
> @@ -1270,11 +1288,7 @@ static int initialize_nocpsch(struct
> device_queue_manager *dqm)
>=20
>  	memset(dqm->vmid_pasid, 0, sizeof(dqm->vmid_pasid));
>=20
> -	dqm->sdma_bitmap =3D ~0ULL >> (64 -
> get_num_sdma_queues(dqm));
> -	dqm->sdma_bitmap &=3D
> ~(get_reserved_sdma_queues_bitmap(dqm));
> -	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
> -
> -	dqm->xgmi_sdma_bitmap =3D ~0ULL >> (64 -
> get_num_xgmi_sdma_queues(dqm));
> +	init_sdma_bitmaps(dqm);
>=20
>  	return 0;
>  }
> @@ -1452,9 +1466,6 @@ static int set_sched_resources(struct
> device_queue_manager *dqm)
>=20
>  static int initialize_cpsch(struct device_queue_manager *dqm)  {
> -	uint64_t num_sdma_queues;
> -	uint64_t num_xgmi_sdma_queues;
> -
>  	pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
>=20
>  	mutex_init(&dqm->lock_hidden);
> @@ -1463,24 +1474,10 @@ static int initialize_cpsch(struct
> device_queue_manager *dqm)
>  	dqm->active_cp_queue_count =3D 0;
>  	dqm->gws_queue_count =3D 0;
>  	dqm->active_runlist =3D false;
> -
> -	num_sdma_queues =3D get_num_sdma_queues(dqm);
> -	if (num_sdma_queues >=3D BITS_PER_TYPE(dqm->sdma_bitmap))
> -		dqm->sdma_bitmap =3D ULLONG_MAX;
> -	else
> -		dqm->sdma_bitmap =3D (BIT_ULL(num_sdma_queues) - 1);
> -
> -	dqm->sdma_bitmap &=3D
> ~(get_reserved_sdma_queues_bitmap(dqm));
> -	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
> -
> -	num_xgmi_sdma_queues =3D get_num_xgmi_sdma_queues(dqm);
> -	if (num_xgmi_sdma_queues >=3D BITS_PER_TYPE(dqm-
> >xgmi_sdma_bitmap))
> -		dqm->xgmi_sdma_bitmap =3D ULLONG_MAX;
> -	else
> -		dqm->xgmi_sdma_bitmap =3D
> (BIT_ULL(num_xgmi_sdma_queues) - 1);
> -
>  	INIT_WORK(&dqm->hw_exception_work,
> kfd_process_hw_exception);
>=20
> +	init_sdma_bitmaps(dqm);
> +
>  	return 0;
>  }
>=20
> --
> 2.32.0
