Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D108CD6E55
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 03:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731331137ED;
	Tue,  2 Jun 2026 03:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fg53fHe1";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F921137ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 03:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyoyzVXxguv6eqCaTEVPw04gTQQqasOWYsZO9/cTCv3SzdTLqOo0q60rrpi9y9IjOc+joV2GlHXyfWhsegH9bZgd9M4eLhkG0U9lJjizS6xaix93cUFcXa86CmZzehhajAh1eL79oAk7AV0DSI24Gg8qailGFMUCXXw3HR/ZVNAos7qJTXn+bEu+88RR17oqBnYqdPcPbZA/hH827YLFQPkj4LRvBZmUKqR6pMjaVipQoLWDss45vX7v6U/7joaQf4yZ6q3K3+VCzg5dfY/qEMvvCO9+X3mvW01jxKyJfbIA0PLdFgHavN+NPeVT7o1A8cr7rPwNsls5MmOLO1FF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6reMNREYwLnnXFkkg01Wzh1/qA3qfVNetU0M2anGQc=;
 b=uxGvhI4SpFJuaw9alqNtDpzJysHeWndhoDLeiWVNiRT/Z8XIODZ03j9MzctWmqEkB8cBm5eCe1S1DEHamJYjAC3X52nJvffBDUXz7xfHHttq4EQhHNZsjgmfud+0uYI/3/j7DxTy6jAsBJFR+iHo0NE+1uhdHGPe8LyYKZDDkp5bEmKhDOftxALJvu1the9FVhpsw3YShylMomo+tMieIWMTKlHulnFnVO7yPXYOBSfqNSccxNNrOKJZ5QZ2OFLLCqmajbDuas+m3YWJG6A3UByIdOonTSALMIG6nIaPQ/itdU39S49Z8wcx9m6KEw3wtFYF8SUsHpAd6Z4MYoN/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6reMNREYwLnnXFkkg01Wzh1/qA3qfVNetU0M2anGQc=;
 b=Fg53fHe1MTOrVvAYm0Ut54A7KjHECd9bKIy5oQPEbDfdt85UY4VVV3k6uHxUoH9uWoBReu0p74AEo1L6cs5YChfQYMshEfJlgKHu8qyt7q8bTTDfpZQfvQvXv/RnYNFwDXXAN7p1I88gsEnDaxIAj4LdHzy1fwxmukH58irFyUg=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Tue, 2 Jun 2026 03:13:48 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 03:13:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Chen, 
 Michael" <Michael.Chen@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v2 12/42] drm/amdgpu/mes_v12_1: use mes schedule pipe for
 legacy queues on unified MES
Thread-Topic: [PATCH v2 12/42] drm/amdgpu/mes_v12_1: use mes schedule pipe for
 legacy queues on unified MES
Thread-Index: AQHc8YrPJH2+Hv0kg0eqVMnGJII61LYql1Ow
Date: Tue, 2 Jun 2026 03:13:48 +0000
Message-ID: <DS7PR12MB600589F018E465EB4806FB26FB122@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
 <20260601055034.3700921-12-Jesse.Zhang@amd.com>
In-Reply-To: <20260601055034.3700921-12-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-02T03:09:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4316:EE_
x-ms-office365-filtering-correlation-id: 72cc150b-dd12-4714-1a93-08dec054f6cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: BVmpJ4yFsBmEktrhEftTvDHhPh2NG9o5fOd5/+qc6wro3y3Q6azuQNL5D/mS+R+DdzV55EKxAzZwzSsvV9TB0tgUiJArrwOZ0A+qVtpeOOcU/xnPa0H11ynhiSDG/0fli9jmjKTmow/8mIjlyO97gbeaw66YMv8UZtvB9gpEjHAlmWDGk7NuKihQcOL8JnYgCzqm65Ux+QTzbtyyRIM+QLVziqZ8yrl8+1NkDa0+q/KFCT5y6+jrVmadYOJOOPAPb0r6XbqyjwalFxsbIyxfYzdyqO/crgPpjJ15483VzbbfrdP9N9D4+q75xx0AIvpApfKDbMTRHPmQHNqDVqlg/Nf+/trUyRj3J5zoBmzJuAicS9MkuAa5LEksD8DDvSZYUAKkA/fmom7HDstoB+My+DQSfZVW0eydjQ56VuVq0PDIlpVO4eRuEDa5aBjVy9DHBlfoSu6+nakZ9f2D4OqATuu0A7ooPK4opuc1fbwsERt0LW6H3ylSc7ygzoaqhm9e4422wABPbOJ28PVvn9Kk/nGd7/m3mPDQfeyDoqL3xlARrvFPXHQ//UkpF+Mts83tcZhT6Owf3yJnXj0Bw3PmuWd0JP7ZeMP4HvRVjyOQMlQ4Bi5Ni4/+MGNlxopgVMpj7cQFvR8pjJ0N26IEYyx3KMjXBWl54+I4EmKFagA0mwngrBbNDnqCyVUA4VmIJQd6/iuTWHqSInoAlitkw1UfP7MJzIcurtdi8sEvigQ2DFoFrUS0KhLXk/DzdIIPSs6p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hb4Sh6yNmTtfIWHHfu9yB6pCeUkwE7n/fYtI2dJKJs6AMC16KSJNIqSAOs+t?=
 =?us-ascii?Q?UiS2cL3iUlCUqUbXR7CvohDFrRX49NZ/LqqNfNdk7/sXVePS9pkegRLisGPJ?=
 =?us-ascii?Q?IR9VMf9aHeWknxsJoCgJ97CTeVVq2EkPeSdmfQsGu9Sigi11bTfGbs7WtpYu?=
 =?us-ascii?Q?4UmncXVRrWgL7cA4wVX0vTjklW6i0h+ur6r9cz6Bj/S1jwuwHhXas/1cIkvx?=
 =?us-ascii?Q?5dG+9Bt7ZJRvaowr+89KW//vEdo0sCDc0yZoJFYmZrVCeCPg7fGLrTVHoBYu?=
 =?us-ascii?Q?7Os8SZz8I9MBiPj2uiJZ2AZoE4m2CoGcvbeMQY+pdcZqdaeDitK3Et5l7Kzv?=
 =?us-ascii?Q?8xwgzfEIl6uVEPYeQoj4kgIiX/6resQqFN3e1/lPS08pkElx9gUMvMhfZxKh?=
 =?us-ascii?Q?Fains1OfBENZg2a7BMP04AsLt2nXVAUhMuW4lUKDWZruveTlb8SPUwjGJwbg?=
 =?us-ascii?Q?HX0/Z0cYH0albmNiaJMDXQ2c3gVHgFgVKIicB4TblI3MRUv+xv7MlboJd3rd?=
 =?us-ascii?Q?ifs+j9E0pjeINY27zkltyrxsR4O6f9Pgy3NTKpWcf+NRq0B1SiqYPsdUuHy0?=
 =?us-ascii?Q?9LsOC3V92XwzLO7wA4KbTYd8NGM8vCLLtgC5ysreEyLQo1iqdeDfm2dIDlmj?=
 =?us-ascii?Q?gy+eHfNObssMf9FPQ4covXKJxZJgvU2v3oWBisuEADgC4bXF5MK48tmGY4is?=
 =?us-ascii?Q?pGt3SGUFiN4H7NadPLeWq52xqo1spxaEQm966kYvIbZwY/YV7CqmBPd4LfHd?=
 =?us-ascii?Q?xmR8Wh4SPl3n/A3VOrk8QW81r8ct6cdcsasBZoJruSGys8hz4XPRVkqbh+na?=
 =?us-ascii?Q?jce8IMlZ/vAGJoKGMOvLDgpX5s/Fqa14qph7W6c8kjmrn0skMJDj3xF5GBOj?=
 =?us-ascii?Q?WZ5SOuLWkR132qT6ZcyAKLIs8JkPLmYGZ4Ms4+8LfzCQyjNAfpja/n073/GF?=
 =?us-ascii?Q?bGUDyffEH2OCznvDMvUJTh0+htohE9G+Kp+UQjxv0SQgAedGOCanQb0j/MCK?=
 =?us-ascii?Q?FV2F1YqzpoTJtXh5x32wSXMF6nG6PAzW2fegePFMNv6dMs4N7qp4cvRTazsI?=
 =?us-ascii?Q?f17Rcg+QTULNxJGcjrIBIG1uIAHNn54dmEw8GFPW6o2Gpryp6nM6ir3MB5r9?=
 =?us-ascii?Q?xk+CcDC61PQ9r2u3ZCbqhmvDYiiZASO1wpVFkaM9iCUfa/Hp/ZBG9ba1tgpz?=
 =?us-ascii?Q?BXRHUsM+A/3+st/XJBjnjgYdhyhP9j5knZCV2ygaOMENUr1UkpTpi8N4LAp9?=
 =?us-ascii?Q?Gl/L44xaLnpJacQH1/A1MWMg9nO5pBV5acIwHzhUl5ab6W7ebX0o/5VIXASd?=
 =?us-ascii?Q?+ra7v3iqHlI3FF7lhmeI+Z1ZlDzgtQyyBKhw2cjoONu8mL/fTiJjcD/WVti6?=
 =?us-ascii?Q?iNyY9uQglFVsWC++7Ei45mUw0c0pq18p0Rxl+OiDmXpT8fug3NSk+tOcAPCy?=
 =?us-ascii?Q?WQ4jssRVKkXYy5pxVjgwh9KKeKzo+OLVgR0q91OM2o8vDAAyokabsEkciRHj?=
 =?us-ascii?Q?D28M/QSVlPy7H+C6xNqMsaRTb2C+ml1QGifXcJAdNO798zWJfGxRRsA/0e7V?=
 =?us-ascii?Q?MIw0ivPRVYW5wMNXZxVvKQCovjwDkDQTMzTzqiEjeKABmKHzPMi8HXYefhy0?=
 =?us-ascii?Q?UOK8l23A+YA62qlI621rIbFsMyNO94GjMkXx5GQpXpaisJjPZO4HfAhCaNHh?=
 =?us-ascii?Q?5G77tmyesK9kFMU4pyIT4nC0PZVc0YRJz3OFjHfSD0SKYgfh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cc150b-dd12-4714-1a93-08dec054f6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 03:13:48.2879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDPR/84nSC/ntVEGfRKeVDz2n8kN4xliu8mfWt9MNgUZ9ZQuivp7XY/loUDkOG+8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Monday, June 1, 2026 1:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Chen, Michael <Michael.Chen@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v2 12/42] drm/amdgpu/mes_v12_1: use mes schedule pipe for
> legacy queues on unified MES
>
> when suspend_all_gangs is issued to pipe0 MES during system suspend or ru=
ntime
> PM, pipe0 can only suspend and resume queues it has tracked.
> KCQs registered with a non-zero pipe slot may not be correctly handled, l=
eaving
> them in an inconsistent state after resume.
>
> v3: fix the schedule pipe issue
>
> Suggested-by: Michael Chen <michael.chen@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index b169e577e583..2099beedd575 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -417,10 +417,15 @@ static int mes_v12_1_map_legacy_queue(struct
> amdgpu_mes *mes,
>               convert_to_mes_queue_type(input->queue_type);
>       mes_add_queue_pkt.map_legacy_kq =3D 1;
>
> -     if (mes->adev->enable_uni_mes)
> -             pipe =3D AMDGPU_MES_KIQ_PIPE;
> -     else
> +     if (mes->adev->enable_uni_mes) {
> +             /* Keep scheduler queue on KIQ pipe; map all other kernel q=
ueues on
> sched pipe. */
> +             if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
> +                     pipe =3D AMDGPU_MES_KIQ_PIPE;
> +             else
> +                     pipe =3D AMDGPU_MES_SCHED_PIPE;
> +     } else {
>               pipe =3D AMDGPU_MES_SCHED_PIPE;
> +     }

The queue scheduler pipe calculation is generic and also used in the other =
places like as the queue reset, so how about create a common function used =
for calculating the queue scheduler pipe?

Without it or not, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.c=
om>


>
>       return mes_v12_1_submit_pkt_and_poll_completion(mes,
>                       input->xcc_id, pipe,
> @@ -457,10 +462,15 @@ static int mes_v12_1_unmap_legacy_queue(struct
> amdgpu_mes *mes,
>                       convert_to_mes_queue_type(input->queue_type);
>       }
>
> -     if (mes->adev->enable_uni_mes)
> -             pipe =3D AMDGPU_MES_KIQ_PIPE;
> -     else
> +     if (mes->adev->enable_uni_mes) {
> +             /* Keep scheduler queue on KIQ pipe; map all other kernel q=
ueues on
> sched pipe. */
> +             if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
> +                     pipe =3D AMDGPU_MES_KIQ_PIPE;
> +             else
> +                     pipe =3D AMDGPU_MES_SCHED_PIPE;
> +     } else {
>               pipe =3D AMDGPU_MES_SCHED_PIPE;
> +     }
>
>       return mes_v12_1_submit_pkt_and_poll_completion(mes,
>                       input->xcc_id, pipe,
> --
> 2.49.0

