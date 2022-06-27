Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3099DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 19:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8B511AEC5;
	Mon, 27 Jun 2022 19:05:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D303811AEC1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 19:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6YJwMauDxTeF94/aXowFNVBlZcuSgwAYLc5RX/rx0l2mqNMu9ulUCx4m78C3jKDoUjpiuZOsKOdnotEwYdz9qvSCFTCuVssYFjO7itV+JmECd1s2fT3JwlcbJhRYN7Ku2WhkSIYdRk4QkoNyh1F64rH3X+MvdgEmqb8VPqrJHC7nnIWaA7teqs54eZry2CM+P2L0DSVrZ1TXPt8Sq7Cn0MiHsR25F0GsZVU35pvCO0xViH5WgLQK8yrKVa1jMmZbJ1Or/kjA1c5hKePs849P2CQuMBhc8UYIyZL/AGF25WhRb0iQTm26l3VHvlLlHid3kjEe4UCiGCnuMHgimw7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6Q7dTBYkS0fYESCRrkhaLaKbm2w7psUxh3YbySUYls=;
 b=Mb7EKwlGgXf2PyKDMPNxxWScqIIkbSKPFLKK7jw1hsqhFRiDNlq3EJzYSqlZRzKSwh8J6khah0EIWW3ctrz+ETJZ0iJ6Vc89GLfhimtwPrYVm3hvGkP2YGjfLISyxP3GP51ObCZt/QTpanweWW8OW10QYIHY0+l1AqlcI26R/jz007BEIkTTATeJcLQNqlbNKhqnqa0b7yVAhTvf14iJlCJRDzYSxV8waUFiEF+MjyhYyg5TWLoazyxtdHssGmh4mm6Fg/C2ELSQ2gGDpZDqZYUqhD8pPAVmemmT5FgQOEpPfCkwmS72Sy2V+cRLcYd2dL1PB0bjNJ8FDYsnrAWKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6Q7dTBYkS0fYESCRrkhaLaKbm2w7psUxh3YbySUYls=;
 b=Iy/IFz0ULlWZoAbsek9XbaeHb7uvA7328HvVCS0A9uFcSABN1UbuGrEihYUFqNboBZDOJo1m20fTsxn/5AiwhS7FgFOo404zhivzqbKMg3QRtUUnGK2I1LAwD6BGneUXx1mMfWVgqzdJHM8BDA0bz7C6K2NrbvpF6Vh7ozV/V44=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 19:05:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 19:05:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] Revert "drm/amdkfd: Free queue after unmap queue
 success"
Thread-Topic: [PATCH 1/1] Revert "drm/amdkfd: Free queue after unmap queue
 success"
Thread-Index: AQHYikv8I4+4Diob10yprI/nLss8UK1jnNNg
Date: Mon, 27 Jun 2022 19:05:27 +0000
Message-ID: <BL1PR12MB5144901899EFC626052EBD0AF7B99@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220627173226.8485-1-Philip.Yang@amd.com>
In-Reply-To: <20220627173226.8485-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-27T19:04:29Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=197c5fb7-eaed-43a5-99b6-05b53d15d02b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-27T19:05:25Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 24ada3d8-6ff2-4c51-b013-e56ec65c0615
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6c208c5-9294-4eb4-c154-08da586fff1b
x-ms-traffictypediagnostic: DS7PR12MB5743:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/72nAP00BuVbFlwQbCMyiqjemp7tkASqA2KyLZ1Vb9+w3Rk02bpMX/hp5XoDjGmAy9tQGnxniX4uoachChZapg78uSWRfcyURgpDB8K5xBWI/J41cnk/EOndj3IP4x/fGTCG2irlSYzcCqwkTmTk2jGjcKBvTslHpCvX8tJO5sP+4N1oudVJ7jprHrXWqlYYXGGhnJ8KABzRXWWMy4FcMNMt3zi6TVCewfVT1fcYkLhU7ljZbmCHXGf8P1CWrdpyOoIXIyWTRbDc7q4JJfZ4k1NgAGiEjF+ZLt8Ukjh9HhGpE73iRIsRTZn70u8S5QjrEeGfwsh136M4XKJ4hm1FPJ3KJcGYJ1coIVfcrvMbs0iVQEkDWcPVayv+g7bUg5SvZsl9mGQvgFpEsfNFJsMvZBJ7/EanA6W6V/QDxGq9A5lDrnnwGO+z5rJ4rQw96WLo7Jkw9tfieIRrQOG69rnq+qvattY0MSSFH+yVoLex+RU8U8Rno8U4WzBjOFYSpkKJwX6b+Y+17m9eJkUT5iXA4d1QfbOT3oHXfmOycqohYTFKDYV0ncb41n0kRsAprEiB1S5FS0lp1pupyr6xIbT1Ne8Jnh0UaIpCa5MLlWeHpKod1WXrC/ev+h7F1cXzdn8cKczAFGjVrHPFTi4ZeFC/vNptMQH83ZdXh5PppQQ4u32SFAzTOX33hGP0nhE99VWBl2uBnBjjYUTkcY7o3AI3D0sre+KdInTwUh7mTEC+UqkWBl1zYfE7dWKXyWoVmgcUi1kZC6SoY4x0T8s97ysEDWH2xzlxR4U89NNPmjFOU4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(478600001)(7696005)(66946007)(66446008)(66476007)(66556008)(5660300002)(4326008)(76116006)(64756008)(55016003)(110136005)(9686003)(71200400001)(316002)(26005)(41300700001)(38100700002)(38070700005)(6506007)(8936002)(52536014)(86362001)(53546011)(122000001)(83380400001)(33656002)(2906002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSa+V/mBDU32o3yFbLuVFVe+rW0OYDb+K7zF5GJQXAR+C40bg+PU3Nx7CLIJ?=
 =?us-ascii?Q?38veW+K/qjxEGhtxrQf7Bs4uF7/Fpj+0ZAJo1x3GXsd5RlZvF/y3GpqX1KdN?=
 =?us-ascii?Q?itgLPUENmfb36oT4rgJFOmuLdUV7SL66nROW0DYga1krdiHABzQcegvlFEjp?=
 =?us-ascii?Q?jSrFfc0XPSvg+k5+teTlycZtYbytUljoklAPHphVpbSOl8VCy/xp8138XSY+?=
 =?us-ascii?Q?8tNlqYVIxXAvpYs1O9U9Pr04tGqcjJnQG1hxYCbDJsD6KfQy1KbpI26hitUG?=
 =?us-ascii?Q?O3mVz9DGZL7Yjkl1eUiHzr4i1X+tWMCeZehGmTMgAG/ybfchn16iDP558lJD?=
 =?us-ascii?Q?It/1kac5rsL+PApmPRH8q849Kq846k+cB4567W56oJnAFgYuxBl2HSJHl9Cp?=
 =?us-ascii?Q?Bf48OuKMPdpZ7G7OLl+aIFIWQbo15CBhtH8cZfwW9rK+PDwhlyittS+VG7Ea?=
 =?us-ascii?Q?1xRceoWA7p0gMJwNsQu6O+k1R7nfLWzr0eMalTrf9mu+12JEnQjrznqJ+rrE?=
 =?us-ascii?Q?E7QCykhOHCg+S7nNPd8GvERm6MV7B+AO0lcV4NWvhUE9oZht87tEKMNixd4B?=
 =?us-ascii?Q?hSz9xTxrhfQw8Bf93R33Hx+4DVP+5X1XIlAM3Y83GOEmRm7RgmE+gFppd5cg?=
 =?us-ascii?Q?HkdoeJyi2wJqP8Eii2ZMCT9bhqco8Z7akZDT5fsVtqmeCop4yDP1Ddg4WBFf?=
 =?us-ascii?Q?s+tFIStHEMoK2uUUQUwTnanUO/pC7vcQzKrXQru07VW0IgmTyScIB9TX/zkH?=
 =?us-ascii?Q?0YdtXMvTBNK+6GVq9jKnOEgPhzG2BimOLdMog2PVZyZ5tv/LLqm31oCBOKVG?=
 =?us-ascii?Q?oLRoDfvNAEoq5GHKNcQIXg0wULcJziAaM5QoEc2zznVLD+FC3wJFNszfUo3y?=
 =?us-ascii?Q?GN7mUj4VAfaNCuwT1t+fb4d/jIbnxk+QErm5HoFYTBhP2swwtXg1OZ2Tm27z?=
 =?us-ascii?Q?8D8jsaE4tteXmnlp5b9CIy0NIPED4wF3rNZ7Q2ZQqJfFg4/YoP/Dg82knbEo?=
 =?us-ascii?Q?QLQdinkmt+QPhabCGKKbGNlYlKQQjuF6Q6aFdVgJht4hT6bfbOlZWTpxYvG1?=
 =?us-ascii?Q?hE9ZZ1NnE3AqFXHmCu/L6jaxctWpKv1vOtMqLiJEtviC8g2ucVYCa/r7tlf8?=
 =?us-ascii?Q?qyAKHBQTkaFn4x7j2EEpzNEdwlYC2kkMzLFFz8Yd/X37ng1UxHtmwGDbmFTP?=
 =?us-ascii?Q?qGrB1G7uRvWTD6vb9PCF41SqucP9/1HWH+9uPSeUwARIImIaGRiSofqmj+wA?=
 =?us-ascii?Q?w/zECABB5fC8w+70rokGuYSFER+FaRyAE4Bl5Dt8a5Z61DI+J9E6t1Q+B22f?=
 =?us-ascii?Q?ca1p4xxi7/Y+b4P6Zd2J2dL4wXfJf3aiWM83vPj+d8fsVyhx85aiOR/hywqc?=
 =?us-ascii?Q?h0tKrgaf1XdOP95obVWH0VGhemfruGuHA4rSjm7cHyGRXpaum0lOIJSqu1Fy?=
 =?us-ascii?Q?flvBpVWollMADKdCyIOBAc+yZJ0eMp0C0Rktdqd5x5HKG1CU2XZ7r+3+6yUH?=
 =?us-ascii?Q?WN4gc1FPcRj5gHGWFw+lulRYUK24u9rJHbJ2ylmML7/8w1iPY7N075x/ARim?=
 =?us-ascii?Q?kNbCknCEjDNQQiUDzylllJaV2CMsz48jdFPbj7kT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c208c5-9294-4eb4-c154-08da586fff1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 19:05:27.0344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jhXiKwxZMd7iww+sOnu5lU9QwsiD2+qRITAPyrDJrUhRVqtLGsebVAvP/urzeOaVjudaT+QUKteyrJUDiIP/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip
> Yang
> Sent: Monday, June 27, 2022 1:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Philip <Philip.Yang@amd.com>
> Subject: [PATCH 1/1] Revert "drm/amdkfd: Free queue after unmap queue
> success"
>=20
> This reverts commit 150c1266d78fbaa0fc5f89461daafae416db1c3e.
>=20
> This causes KFDTest regression on gfx9, will submit new patch after fixin=
g.

Which test?  Also, missing your s-o-b.  With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++++++++-----------
>  .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
>  2 files changed, 12 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 21e451acfa59..93a0b6995430 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1881,22 +1881,6 @@ static int destroy_queue_cpsch(struct
> device_queue_manager *dqm,
>=20
>  	}
>=20
> -	if (q->properties.is_active) {
> -		if (!dqm->dev->shared_resources.enable_mes) {
> -			retval =3D execute_queues_cpsch(dqm,
> -
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> -			if (retval =3D=3D -ETIME)
> -				qpd->reset_wavefronts =3D true;
> -		} else {
> -			retval =3D remove_queue_mes(dqm, q, qpd);
> -		}
> -
> -		if (retval)
> -			goto failed_unmap_queue;
> -
> -		decrement_queue_count(dqm, qpd, q);
> -	}
> -
>  	mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>  			q->properties.type)];
>=20
> @@ -1910,6 +1894,17 @@ static int destroy_queue_cpsch(struct
> device_queue_manager *dqm,
>=20
>  	list_del(&q->list);
>  	qpd->queue_count--;
> +	if (q->properties.is_active) {
> +		if (!dqm->dev->shared_resources.enable_mes) {
> +			decrement_queue_count(dqm, qpd, q);
> +			retval =3D execute_queues_cpsch(dqm,
> +
> KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> +			if (retval =3D=3D -ETIME)
> +				qpd->reset_wavefronts =3D true;
> +		} else {
> +			retval =3D remove_queue_mes(dqm, q, qpd);
> +		}
> +	}
>=20
>  	/*
>  	 * Unconditionally decrement this counter, regardless of the queue's
> @@ -1926,7 +1921,6 @@ static int destroy_queue_cpsch(struct
> device_queue_manager *dqm,
>=20
>  	return retval;
>=20
> -failed_unmap_queue:
>  failed_try_destroy_debugged_queue:
>=20
>  	dqm_unlock(dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index a46e2a37b4a6..c9c205df4a14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -422,6 +422,7 @@ int pqm_destroy_queue(struct
> process_queue_manager *pqm, unsigned int qid)
>  	}
>=20
>  	if (pqn->q) {
> +		kfd_procfs_del_queue(pqn->q);
>  		dqm =3D pqn->q->device->dqm;
>  		retval =3D dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>  		if (retval) {
> @@ -445,7 +446,6 @@ int pqm_destroy_queue(struct
> process_queue_manager *pqm, unsigned int qid)
>  				amdgpu_amdkfd_free_gtt_mem(dev->adev,
> pqn->q->wptr_bo);
>=20
>  		}
> -		kfd_procfs_del_queue(pqn->q);
>  		uninit_queue(pqn->q);
>  	}
>=20
> --
> 2.35.1
