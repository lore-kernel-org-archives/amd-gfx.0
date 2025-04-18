Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2393C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE5410E213;
	Fri, 18 Apr 2025 14:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ud3le9xO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA18910E213
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9BQVJyXpZu6mxfApFSTTWHJlX/AcKHqQyZa9Vz7baN9YKRyTGHPQCoMKLEOfIltAQ3dp9SHeqZ/TAPvXvsM++gktwITKYQOqjBqvK1NiCgyeHe6FIWQFRVWeEh8Z4TdSmoqwX4T42R+DS4gwvS2rn10qgznGXSKToaLR5QZHbzdXkWlpRHoj6iSzpegh/R0zvqP/tCFRFB3roaYEpNAxKvnwh6DCnqg+7n9ONn+PC8kiDSZKoWQx8LuTaAbstHhjDdhmCg4dbnxrVizrA4NTofeCdzsKZSCr0Id6xarDhMHub4O8Xy0+dFVDS72oLmXgXIF5YsjF5q52aVjyQzWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAf/c0GAy8onNXE9TTHjX1/IXXNgKxcrh3w/9srYe50=;
 b=if+VOPUiuTnO9tDeisNWCYDrREaZvZRzdGPpq5TeYmG5c3KkXlpzgvvWbwEnR7FV7f4FY/VD8creE7Cge5DiWtG/YUZrSinSTGLIzaSbsqqps2Gkz+nKbCkWXrJTGd5K+w6mdV3xQuhe8V3+Di3R0qm7CA7XuTiWIGX2GKV77qDi5k0EJaHVxPUTlFamoIr2HO/G/9fM+5uefSJPUQOblYjDSPOFbWBfOdPYH0JE+LUAN7XmL1ds/PV1dUuUwdP5WCKY6M9Jyh8uVh5j34TDtDBg3XCpqelRGZ6G555ygc7g+LPD4QusUfwCEeTbD/kIUK75kTiM9WGXZwBLcOpzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAf/c0GAy8onNXE9TTHjX1/IXXNgKxcrh3w/9srYe50=;
 b=ud3le9xOUbY81MlcQNxyC47w2R9CsQ4GN8qsYvpq9gZf+AiWARL6DxcjZ5EbJpO497UQ6Ql6fcnscE7kqFDZnPRyyKEjfBrvTOuHmzEEvz4hyU4r84acBMUO1l72dKb1seR4KSlwzuA/iWyMOU9HR/Q986xzVbkOtTvuoni4t4k=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Fri, 18 Apr 2025 14:20:08 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.024; Fri, 18 Apr 2025
 14:20:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu/userq: use consistent function naming
Thread-Topic: [PATCH 7/7] drm/amdgpu/userq: use consistent function naming
Thread-Index: AQHbrx3icxdB8uf8S0eqeqQPbsQ0KLOpe6yw
Date: Fri, 18 Apr 2025 14:20:08 +0000
Message-ID: <DS7PR12MB60051E598768269A5994BF3BFBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
 <20250416222046.1142257-7-alexander.deucher@amd.com>
In-Reply-To: <20250416222046.1142257-7-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=948ebc2b-20de-417b-9949-3cb57b6f95ed;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-18T14:20:04Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW3PR12MB4476:EE_
x-ms-office365-filtering-correlation-id: c688ab3b-fd41-49fe-b9c7-08dd7e841f59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?r/HtsmPb1nUU+WhKkv/kTdu/NFEDVbrrzPrSMC/+09P41m3rU00mFEE70ptI?=
 =?us-ascii?Q?BUcNJ1fJmBZCKHfmjSkngF0oXdi+6P93bApkHBJRt9Iaw9Boi6K4hqfxutjL?=
 =?us-ascii?Q?g2XTdTYkPKdZuTv9/3Na8lD27OmlqWAQ3ZR7XKQorDkTKGJetMVXQRppRKah?=
 =?us-ascii?Q?mkCLbuWuOWuHnMJtTCRZ5Gy+jH7GB+wwpIRJm5t8mu0aQ+5q5UHK8H/O7yeo?=
 =?us-ascii?Q?hGjlImGiqe3QChTjddEHFvXjY4zi+EsB287Ym6c4DQRtuxDcEaGC+/IIPQEe?=
 =?us-ascii?Q?7D53SdjaIU4o6vk7ajM8l0/u/l1Ocz4n4F2dzkXvFe2l4/KSYG/pwbBEh+KS?=
 =?us-ascii?Q?ltl/+L7ae5ymdzdZ+VTK2TUmpJx/i8msoN0BTARCjEEgxhnnGqDq4C8fXKhT?=
 =?us-ascii?Q?AtTpr2D0USeiYi5tjT+tVrgLBvciQ8HNiQE9GcJDfP7dTkwGoJZLvOz8Mll3?=
 =?us-ascii?Q?QQaugaCgJRycxtq8mgNPifx5QBPC7dEwr7lBTIloP+R8gyZSf89xeIQO+vQJ?=
 =?us-ascii?Q?GaMt0kNEqlrfrzQ7mZqTyBt/FDna6jN2tHqc+H2x9JYSPYn5L39TQGwL4ynF?=
 =?us-ascii?Q?Eo9lU+IEaSRr1QDkuq3VusGiCkwrxZv7ISiU9XCQAp8ZTGOonQJXVIYaIeHq?=
 =?us-ascii?Q?4/QTcRppcwEXM2Jq9/O1FySv2J1osJ/KLhkjbvLCAIECzPsW87+58JO/tBxs?=
 =?us-ascii?Q?vKHj41IVF/NAJCYL8QpBW+6lhe2a133GFwLcwm4DJe7nuwxtLCIHbVQLsOoF?=
 =?us-ascii?Q?SeiZT7iT00BNInW3Fal5T7Uux9oggjpVQxFQQVVv9yAsSZ6acZMK23SMeKGO?=
 =?us-ascii?Q?r2GYRrix6KwrELqvaWPaabjQv8nt9/10FuXYy0y+nNk1z8UVRQaB1iYAkNwJ?=
 =?us-ascii?Q?+lpZ+jg2gnMPSbaWMwzVol5qrYtyXIrY8vacVMe3jY5MkC5606Jioi5ps7sd?=
 =?us-ascii?Q?DrU7s5zNe6LgF9Bklcr2W5OyZnJbgyOoUBtCwyzX60/WBSDVgi5wxKVAlBcG?=
 =?us-ascii?Q?N+4l1Y37A3nDEfkx1GXIXwCezZONGqShIKGl0U5a6XPsM93KEbEEc+cwXmWF?=
 =?us-ascii?Q?Xe2a28DUe8IGBDhCEyXpMkg6w9aUHr567Uc1oOOKn+9diideBdsoRJjrzTjx?=
 =?us-ascii?Q?sF9XV8ool18oc9dG+Bw+wspxXFFGy7exK26lSn97SFadnAqKVMdNqwU7+4vX?=
 =?us-ascii?Q?cuALcNLvsOo1x3BMam1y2ldOg8PwZlClvMqsD/jA7HZIWYS0goW8dIH8hN3R?=
 =?us-ascii?Q?2NQmLs+pxsYHhlMqFKSdsLOA3brYK5myHY+l6PPen3hNPbIgKF3f1JT+Nf/l?=
 =?us-ascii?Q?Ap9w8IQOSGRit2ju838Tj+VCxVUhccL7LokehC6RrAIm6oi4QEU7WrDthVko?=
 =?us-ascii?Q?u/HeFts5nbG5TlnJvA7cQPphPyKvBXiPcB5td0AGptu8t+toDvcKR0SBYaLL?=
 =?us-ascii?Q?tYlOWqTW4EbsxzJFAyP+ZHYn2COY+0BIZ11j3Vo1YUOUd53FDcFysg5twpit?=
 =?us-ascii?Q?5f9qyfoQDX0rvcU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dQkVFPk1FGyPHnSh58t/qx3lZ1BNCfhUU8YQhUlfET59K77xh1yLtrvGOKNC?=
 =?us-ascii?Q?TJSVn6ZcChD2jvqz1JFmMBLiksODMbMsufL9C9hAlQMlALjqk7O/+x9x7HMN?=
 =?us-ascii?Q?VlOTMEOkpahA4xjZXsiX6mIMYvWVTjoYkZREVxxfJpd6LhfcDV6mDZJx9Z5P?=
 =?us-ascii?Q?zn0FG95l9IVu8c5ZEHlgYL91YySdB5UoNHv9Pa+rK9N46fvlkkpWOndqXvIl?=
 =?us-ascii?Q?AdZF4MSCcwDD1ZbZYx4wZsOGyaVSvmdnsPTdewGnZNXliTuW5gKlkLfYqTg+?=
 =?us-ascii?Q?i6gRTyB6az8VG0UtqVRXV8KLkvTt+JGPOed96HkvXzJ8luDkYOYh2J9BOMLL?=
 =?us-ascii?Q?fQJsKor9WAWT2e3MS/d8y8Z6YAdscO93r6YiA0luQkO3OiltIOZmWJLo5HU3?=
 =?us-ascii?Q?0wJXInHFXln7RMS0rnzkp7IgnhfiBWgVB7Fnlt1lBHaK5uZKjPC5KEDBGlFS?=
 =?us-ascii?Q?+/wVjJ1ZTwTmIQDY4NlfI4xkzm9yeW+PuWmkE5hmjZt3T+l4mgulCE2UedBl?=
 =?us-ascii?Q?TUkQYwd6sY6xwwNEIZI7OefVi82ZE+Bjjna0IsGrZC3HW4sdlw0iZo4PHnKy?=
 =?us-ascii?Q?aRHupatyo7Ni5QrLr7L6GKehoA2Shwo5ebC/HyaPFAAAK+V3Yd+TnGbOlIHz?=
 =?us-ascii?Q?YrZ88v3p7ieYCBKIdDyB2p7osVe4XKi42LRxKneASd2vYjHQyimZ9DZOzC1D?=
 =?us-ascii?Q?CPlcyHwH34KSQTCNoB4kY7kGfjNqSO09ol43WdgLAjAYb9Etp7zK9+CmwdGn?=
 =?us-ascii?Q?e7kJeAF3cYbuSRl2kd6D4lKWHrsjaDgpFoaBurpd7QCpa6q7ZxBuYZ0/aAnD?=
 =?us-ascii?Q?8KbjJw+kzbtIkJtA2Q9OAQ7hKDToLhkoprnDrBjqMqghJ8NTQaO2NIalS1ZQ?=
 =?us-ascii?Q?aEHhBVVpApTOaDLUgh+EG0AAfis681p7F0shP8HDUZ+AVh0sXHNmNjUv0ToF?=
 =?us-ascii?Q?WFiz0l0IcQYyQklfhFP8ZFSZMks44RtKU5ADrfbW3E4Qw7B166Jv21Lko61k?=
 =?us-ascii?Q?sxHr87ocKCSRAHe+6gaoZ43g3R6/1+LpJuqZCywwSYLkZN0d4Z2Q9lHTj/83?=
 =?us-ascii?Q?Uw0ieH9LhT2Q534iQUqtZVeE1heAZNE6IUPZWpmyQfQ2i6YmotvrJzhoYR3/?=
 =?us-ascii?Q?03La3G/kagxEqxVC2X6oVhmrmrpd5l7khCBAy1XJ3Bro7QcJSlYJ1kyEoLH8?=
 =?us-ascii?Q?LDksteF6dM6txvx4TZ24jIjswHeJ625Q+ka1iieWbdVY4VfQvwDFNucj1SZd?=
 =?us-ascii?Q?Vypv84etfo0FKlizTnGLbCVbKi40xLV2LXH8T254+oyp4enSvMm4YENBdmhX?=
 =?us-ascii?Q?P7YOiEOCmg9bxF6i3iUVH58zLHFi4AtXXr4d5kpBxQWHLGjhehoqXQ9mA0tR?=
 =?us-ascii?Q?KMymzOyhkt/KdSexphdSxI3juRIt00atBt5Zeb8rP3y0mIBgLookcyeBAQdZ?=
 =?us-ascii?Q?h2KZeXSaL8/hvTrhs0wQz3H3gqRc6BiddNdyT/A0I3ZRuLFdxhiJbKCIxdZX?=
 =?us-ascii?Q?FcFnkZDoR5eOxOMyt6EsYzw5lZovB5WqBt2Xxmhp4kKJmEQ2hT4zUoHMWpmE?=
 =?us-ascii?Q?sVmwjNWo9MMYby/H3lM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c688ab3b-fd41-49fe-b9c7-08dd7e841f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 14:20:08.2810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q619iCcpLMroVqMuPqClZTGNjt7DtbHVVbvTEZXlWkImbUXUn0hixdFh5BDycg2k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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

[Public]

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 17, 2025 6:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 7/7] drm/amdgpu/userq: use consistent function naming
>
> s/userqueue/userq/
>
> 1. remove the mix of amdgpu_userqueue and amdgpu_userq 2. to be consisten=
t
> with other amdgpu_userq_fence.c 3. it's shorter
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +-
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   4 +-
>  .../{amdgpu_userqueue.c =3D> amdgpu_userq.c}    | 122 +++++++++---------
>  .../{amdgpu_userqueue.h =3D> amdgpu_userq.h}    |  34 ++---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   4 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  12 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.h    |   2 +-
>  11 files changed, 94 insertions(+), 94 deletions(-)  rename
> drivers/gpu/drm/amd/amdgpu/{amdgpu_userqueue.c =3D> amdgpu_userq.c} (86%)
> rename drivers/gpu/drm/amd/amdgpu/{amdgpu_userqueue.h =3D>
> amdgpu_userq.h} (80%)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 513c4d64f5542..8595e05c691b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -257,7 +257,7 @@ amdgpu-y +=3D \
>  amdgpu-y +=3D amdgpu_amdkfd.o
>
>  # add gfx usermode queue
> -amdgpu-y +=3D amdgpu_userqueue.o
> +amdgpu-y +=3D amdgpu_userq.o
>
>  ifneq ($(CONFIG_HSA_AMD),)
>  AMDKFD_PATH :=3D ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index decf66c2a7187..cc26cf1bd843e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -113,7 +113,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_seq64.h"
>  #include "amdgpu_reg_state.h"
> -#include "amdgpu_userqueue.h"
> +#include "amdgpu_userq.h"
>  #include "amdgpu_eviction_fence.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e24b0c730baf5..b9a1ef343c79c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -51,7 +51,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_sched.h"
>  #include "amdgpu_xgmi.h"
> -#include "amdgpu_userqueue.h"
> +#include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 02164bca51a7d..faa3f59b20c5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -112,7 +112,7 @@ amdgpu_eviction_fence_suspend_worker(struct
> work_struct *work)
>       if (!ev_fence)
>               goto unlock;
>
> -     amdgpu_userqueue_evict(uq_mgr, ev_fence);
> +     amdgpu_userq_evict(uq_mgr, ev_fence);
>
>  unlock:
>       mutex_unlock(&uq_mgr->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 151366ecc0af6..8f992314c5a1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -45,7 +45,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_reset.h"
>  #include "amd_pcie.h"
> -#include "amdgpu_userqueue.h"
> +#include "amdgpu_userq.h"
>
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)  { @@ -
> 1009,7 +1009,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a,
> struct drm_file *filp)
>                       }
>               }
>
> -             dev_info->userq_ip_mask =3D
> amdgpu_userqueue_get_supported_ip_mask(adev);
> +             dev_info->userq_ip_mask =3D
> amdgpu_userq_get_supported_ip_mask(adev);
>
>               ret =3D copy_to_user(out, dev_info,
>                                  min((size_t)size, sizeof(*dev_info))) ? =
-EFAULT : 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> similarity index 86%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c7b215337d55a..cf5737b177b6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -28,10 +28,10 @@
>
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
> -#include "amdgpu_userqueue.h"
> +#include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
>
> -u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev)
> +u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>       int i;
>       u32 userq_ip_mask =3D 0;
> @@ -45,8 +45,8 @@ u32 amdgpu_userqueue_get_supported_ip_mask(struct
> amdgpu_device *adev)  }
>
>  static int
> -amdgpu_userqueue_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> -                           struct amdgpu_usermode_queue *queue)
> +amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                       struct amdgpu_usermode_queue *queue)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       const struct amdgpu_userq_funcs *userq_funcs =3D @@ -64,8 +64,8 @@
> amdgpu_userqueue_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,  }
>
>  static int
> -amdgpu_userqueue_map_helper(struct amdgpu_userq_mgr *uq_mgr,
> -                         struct amdgpu_usermode_queue *queue)
> +amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                     struct amdgpu_usermode_queue *queue)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       const struct amdgpu_userq_funcs *userq_funcs =3D @@ -84,8 +84,8 @@
> amdgpu_userqueue_map_helper(struct amdgpu_userq_mgr *uq_mgr,  }
>
>  static void
> -amdgpu_userqueue_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
> -                                  struct amdgpu_usermode_queue *queue)
> +amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
> +                              struct amdgpu_usermode_queue *queue)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       struct dma_fence *f =3D queue->last_fence; @@ -99,9 +99,9 @@
> amdgpu_userqueue_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,  }
>
>  static void
> -amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
> -                      struct amdgpu_usermode_queue *queue,
> -                      int queue_id)
> +amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
> +                  struct amdgpu_usermode_queue *queue,
> +                  int queue_id)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       const struct amdgpu_userq_funcs *uq_funcs =3D adev->userq_funcs[que=
ue-
> >queue_type];
> @@ -114,7 +114,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr
> *uq_mgr,  }
>
>  int
> -amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
>  {
>       struct amdgpu_usermode_queue *queue;
>       int queue_id;
> @@ -131,14 +131,14 @@ amdgpu_userqueue_active(struct amdgpu_userq_mgr
> *uq_mgr)
>
>  #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>  static struct amdgpu_usermode_queue *
> -amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>  {
>       return idr_find(&uq_mgr->userq_idr, qid);  }
>
>  void
> -amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
> -                              struct amdgpu_eviction_fence_mgr *evf_mgr)
> +amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
> +                          struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>       struct amdgpu_eviction_fence *ev_fence;
>
> @@ -161,9 +161,9 @@ amdgpu_userqueue_ensure_ev_fence(struct
> amdgpu_userq_mgr *uq_mgr,
>       }
>  }
>
> -int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
> -                                struct amdgpu_userq_obj *userq_obj,
> -                                int size)
> +int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
> +                            struct amdgpu_userq_obj *userq_obj,
> +                            int size)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       struct amdgpu_bo_param bp;
> @@ -216,17 +216,17 @@ int amdgpu_userqueue_create_object(struct
> amdgpu_userq_mgr *uq_mgr,
>       return r;
>  }
>
> -void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> -                                struct amdgpu_userq_obj *userq_obj)
> +void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> +                              struct amdgpu_userq_obj *userq_obj)
>  {
>       amdgpu_bo_kunmap(userq_obj->obj);
>       amdgpu_bo_unref(&userq_obj->obj);
>  }
>
>  uint64_t
> -amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> -                                  struct amdgpu_db_info *db_info,
> -                                  struct drm_file *filp)
> +amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> +                             struct amdgpu_db_info *db_info,
> +                             struct drm_file *filp)
>  {
>       uint64_t index;
>       struct drm_gem_object *gobj;
> @@ -293,7 +293,7 @@ amdgpu_userqueue_get_doorbell_index(struct
> amdgpu_userq_mgr *uq_mgr,  }
>
>  static int
> -amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> +amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  {
>       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr; @@ -304,17
> +304,17 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>       cancel_delayed_work(&uq_mgr->resume_work);
>       mutex_lock(&uq_mgr->userq_mutex);
>
> -     queue =3D amdgpu_userqueue_find(uq_mgr, queue_id);
> +     queue =3D amdgpu_userq_find(uq_mgr, queue_id);
>       if (!queue) {
>               DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
>               mutex_unlock(&uq_mgr->userq_mutex);
>               return -EINVAL;
>       }
> -     amdgpu_userqueue_wait_for_last_fence(uq_mgr, queue);
> -     r =3D amdgpu_userqueue_unmap_helper(uq_mgr, queue);
> +     amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> +     r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>       amdgpu_bo_unpin(queue->db_obj.obj);
>       amdgpu_bo_unref(&queue->db_obj.obj);
> -     amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
> +     amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>       mutex_unlock(&uq_mgr->userq_mutex);
>
>       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -339,7 +339,7 @@ static int amdgpu_userq_priority_permit(struct drm_fi=
le
> *filp,  }
>
>  static int
> -amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *a=
rgs)
> +amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq
> +*args)
>  {
>       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr; @@ -388,7
> +388,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>        *
>        * This will also make sure we have a valid eviction fence ready to=
 be used.
>        */
> -     amdgpu_userqueue_ensure_ev_fence(&fpriv->userq_mgr, &fpriv-
> >evf_mgr);
> +     amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>
>       uq_funcs =3D adev->userq_funcs[args->in.ip_type];
>       if (!uq_funcs) {
> @@ -414,7 +414,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>       db_info.doorbell_offset =3D args->in.doorbell_offset;
>
>       /* Convert relative doorbell offset into absolute doorbell index */
> -     index =3D amdgpu_userqueue_get_doorbell_index(uq_mgr, &db_info, fil=
p);
> +     index =3D amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>       if (index =3D=3D (uint64_t)-EINVAL) {
>               DRM_ERROR("Failed to get doorbell for queue\n");
>               kfree(queue);
> @@ -457,7 +457,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>       else
>               skip_map_queue =3D false;
>       if (!skip_map_queue) {
> -             r =3D amdgpu_userqueue_map_helper(uq_mgr, queue);
> +             r =3D amdgpu_userq_map_helper(uq_mgr, queue);
>               if (r) {
>                       mutex_unlock(&adev->userq_mutex);
>                       DRM_ERROR("Failed to map Queue\n");
> @@ -490,7 +490,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,
>               if (args->in.flags &
> ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
>
> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
>                       return -EINVAL;
> -             r =3D amdgpu_userqueue_create(filp, args);
> +             r =3D amdgpu_userq_create(filp, args);
>               if (r)
>                       DRM_ERROR("Failed to create usermode queue\n");
>               break;
> @@ -508,7 +508,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,
>                   args->in.mqd ||
>                   args->in.mqd_size)
>                       return -EINVAL;
> -             r =3D amdgpu_userqueue_destroy(filp, args->in.queue_id);
> +             r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
>               if (r)
>                       DRM_ERROR("Failed to destroy usermode queue\n");
>               break;
> @@ -529,7 +529,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,  #endif
>
>  static int
> -amdgpu_userqueue_restore_all(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       struct amdgpu_usermode_queue *queue;
> @@ -538,7 +538,7 @@ amdgpu_userqueue_restore_all(struct
> amdgpu_userq_mgr *uq_mgr)
>
>       /* Resume all the queues for this process */
>       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -             r =3D amdgpu_userqueue_map_helper(uq_mgr, queue);
> +             r =3D amdgpu_userq_map_helper(uq_mgr, queue);
>               if (r)
>                       ret =3D r;
>       }
> @@ -549,7 +549,7 @@ amdgpu_userqueue_restore_all(struct
> amdgpu_userq_mgr *uq_mgr)  }
>
>  static int
> -amdgpu_userqueue_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
> +amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
>  {
>       struct ttm_operation_ctx ctx =3D { false, false };
>       int ret;
> @@ -564,7 +564,7 @@ amdgpu_userqueue_validate_vm_bo(void *_unused,
> struct amdgpu_bo *bo)  }
>
>  static int
> -amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>  {
>       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>       struct amdgpu_vm *vm =3D &fpriv->vm;
> @@ -620,7 +620,7 @@ amdgpu_userqueue_validate_bos(struct
> amdgpu_userq_mgr *uq_mgr)
>               spin_unlock(&vm->status_lock);
>
>               bo =3D bo_va->base.bo;
> -             ret =3D amdgpu_userqueue_validate_vm_bo(NULL, bo);
> +             ret =3D amdgpu_userq_validate_vm_bo(NULL, bo);
>               if (ret) {
>                       DRM_ERROR("Failed to validate BO\n");
>                       goto unlock_all;
> @@ -660,7 +660,7 @@ amdgpu_userqueue_validate_bos(struct
> amdgpu_userq_mgr *uq_mgr)
>       return ret;
>  }
>
> -static void amdgpu_userqueue_restore_worker(struct work_struct *work)
> +static void amdgpu_userq_restore_worker(struct work_struct *work)
>  {
>       struct amdgpu_userq_mgr *uq_mgr =3D work_to_uq_mgr(work,
> resume_work.work);
>       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr); @@ -670,13
> +670,13 @@ static void amdgpu_userqueue_restore_worker(struct work_struct
> *work)
>
>       mutex_lock(&uq_mgr->userq_mutex);
>
> -     ret =3D amdgpu_userqueue_validate_bos(uq_mgr);
> +     ret =3D amdgpu_userq_validate_bos(uq_mgr);
>       if (ret) {
>               DRM_ERROR("Failed to validate BOs to restore\n");
>               goto unlock;
>       }
>
> -     ret =3D amdgpu_userqueue_restore_all(uq_mgr);
> +     ret =3D amdgpu_userq_restore_all(uq_mgr);
>       if (ret) {
>               DRM_ERROR("Failed to resume all queues\n");
>               goto unlock;
> @@ -687,7 +687,7 @@ static void amdgpu_userqueue_restore_worker(struct
> work_struct *work)  }
>
>  static int
> -amdgpu_userqueue_evict_all(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       struct amdgpu_usermode_queue *queue;
> @@ -696,7 +696,7 @@ amdgpu_userqueue_evict_all(struct amdgpu_userq_mgr
> *uq_mgr)
>
>       /* Try to unmap all the queues in this process ctx */
>       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -             r =3D amdgpu_userqueue_unmap_helper(uq_mgr, queue);
> +             r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>               if (r)
>                       ret =3D r;
>       }
> @@ -707,7 +707,7 @@ amdgpu_userqueue_evict_all(struct amdgpu_userq_mgr
> *uq_mgr)  }
>
>  static int
> -amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
>       struct amdgpu_usermode_queue *queue;
>       int queue_id, ret;
> @@ -728,21 +728,21 @@ amdgpu_userqueue_wait_for_signal(struct
> amdgpu_userq_mgr *uq_mgr)  }
>
>  void
> -amdgpu_userqueue_evict(struct amdgpu_userq_mgr *uq_mgr,
> -                    struct amdgpu_eviction_fence *ev_fence)
> +amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
> +                struct amdgpu_eviction_fence *ev_fence)
>  {
>       int ret;
>       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>       struct amdgpu_eviction_fence_mgr *evf_mgr =3D &fpriv->evf_mgr;
>
>       /* Wait for any pending userqueue fence work to finish */
> -     ret =3D amdgpu_userqueue_wait_for_signal(uq_mgr);
> +     ret =3D amdgpu_userq_wait_for_signal(uq_mgr);
>       if (ret) {
>               DRM_ERROR("Not suspending userqueue, timeout waiting for
> work\n");
>               return;
>       }
>
> -     ret =3D amdgpu_userqueue_evict_all(uq_mgr);
> +     ret =3D amdgpu_userq_evict_all(uq_mgr);
>       if (ret) {
>               DRM_ERROR("Failed to evict userqueue\n");
>               return;
> @@ -770,7 +770,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr
> *userq_mgr, struct amdgpu_devi
>       list_add(&userq_mgr->list, &adev->userq_mgr_list);
>       mutex_unlock(&adev->userq_mutex);
>
> -     INIT_DELAYED_WORK(&userq_mgr->resume_work,
> amdgpu_userqueue_restore_worker);
> +     INIT_DELAYED_WORK(&userq_mgr->resume_work,
> +amdgpu_userq_restore_worker);
>       return 0;
>  }
>
> @@ -785,9 +785,9 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr
> *userq_mgr)
>
>       mutex_lock(&userq_mgr->userq_mutex);
>       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> -             amdgpu_userqueue_wait_for_last_fence(userq_mgr, queue);
> -             amdgpu_userqueue_unmap_helper(userq_mgr, queue);
> -             amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
> +             amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
> +             amdgpu_userq_unmap_helper(userq_mgr, queue);
> +             amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
>       }
>       mutex_lock(&adev->userq_mutex);
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) { @=
@ -
> 804,7 +804,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr
> *userq_mgr)
>
>  int amdgpu_userq_suspend(struct amdgpu_device *adev)  {
> -     u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
> +     u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
> @@ -817,7 +817,7 @@ int amdgpu_userq_suspend(struct amdgpu_device
> *adev)
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               cancel_delayed_work_sync(&uqm->resume_work);
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -                     r =3D amdgpu_userqueue_unmap_helper(uqm, queue);
> +                     r =3D amdgpu_userq_unmap_helper(uqm, queue);
>                       if (r)
>                               ret =3D r;
>               }
> @@ -828,7 +828,7 @@ int amdgpu_userq_suspend(struct amdgpu_device
> *adev)
>
>  int amdgpu_userq_resume(struct amdgpu_device *adev)  {
> -     u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
> +     u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
> @@ -840,7 +840,7 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>       mutex_lock(&adev->userq_mutex);
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -                     r =3D amdgpu_userqueue_map_helper(uqm, queue);
> +                     r =3D amdgpu_userq_map_helper(uqm, queue);
>                       if (r)
>                               ret =3D r;
>               }
> @@ -852,7 +852,7 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
> int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *a=
dev,
>                                                 u32 idx)
>  {
> -     u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
> +     u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
> @@ -872,7 +872,7 @@ int
> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
>                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE=
))
> &&
>                           (queue->xcp_id =3D=3D idx)) {
> -                             r =3D amdgpu_userqueue_unmap_helper(uqm, qu=
eue);
> +                             r =3D amdgpu_userq_unmap_helper(uqm, queue)=
;
>                               if (r)
>                                       ret =3D r;
>                       }
> @@ -885,7 +885,7 @@ int
> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
> int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device
> *adev,
>                                                  u32 idx)
>  {
> -     u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
> +     u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
> @@ -904,7 +904,7 @@ int
> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev=
,
>                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
>                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE=
))
> &&
>                           (queue->xcp_id =3D=3D idx)) {
> -                             r =3D amdgpu_userqueue_map_helper(uqm, queu=
e);
> +                             r =3D amdgpu_userq_map_helper(uqm, queue);
>                               if (r)
>                                       ret =3D r;
>                       }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> similarity index 80%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index a9f0e46bcec05..4d3eb651acf1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -22,8 +22,8 @@
>   *
>   */
>
> -#ifndef AMDGPU_USERQUEUE_H_
> -#define AMDGPU_USERQUEUE_H_
> +#ifndef AMDGPU_USERQ_H_
> +#define AMDGPU_USERQ_H_
>  #include "amdgpu_eviction_fence.h"
>
>  #define AMDGPU_MAX_USERQ_COUNT 512
> @@ -32,7 +32,7 @@
>  #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mg=
r)
> #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr,
> name)
>
> -enum amdgpu_userqueue_state {
> +enum amdgpu_userq_state {
>       AMDGPU_USERQ_STATE_UNMAPPED =3D 0,
>       AMDGPU_USERQ_STATE_MAPPED,
>       AMDGPU_USERQ_STATE_PREEMPTED,
> @@ -49,7 +49,7 @@ struct amdgpu_userq_obj {
>
>  struct amdgpu_usermode_queue {
>       int                     queue_type;
> -     enum amdgpu_userqueue_state state;
> +     enum amdgpu_userq_state state;
>       uint64_t                doorbell_handle;
>       uint64_t                doorbell_index;
>       uint64_t                flags;
> @@ -101,26 +101,26 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr
> *userq_mgr, struct amdgpu_devi
>
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>
> -int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
> -                                struct amdgpu_userq_obj *userq_obj,
> -                                int size);
> +int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
> +                            struct amdgpu_userq_obj *userq_obj,
> +                            int size);
>
> -void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> -                                  struct amdgpu_userq_obj *userq_obj);
> +void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> +                              struct amdgpu_userq_obj *userq_obj);
>
> -void amdgpu_userqueue_evict(struct amdgpu_userq_mgr *uq_mgr,
> -                         struct amdgpu_eviction_fence *ev_fence);
> +void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
> +                     struct amdgpu_eviction_fence *ev_fence);
>
> -int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
> +int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
>
> -void amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr
> *userq_mgr,
> -                                   struct amdgpu_eviction_fence_mgr *evf=
_mgr);
> +void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
> +                               struct amdgpu_eviction_fence_mgr *evf_mgr=
);
>
> -uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr
> *uq_mgr,
> -                                          struct amdgpu_db_info *db_info=
,
> +uint64_t amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr=
,
> +                                      struct amdgpu_db_info *db_info,
>                                            struct drm_file *filp);
>
> -u32 amdgpu_userqueue_get_supported_ip_mask(struct amdgpu_device *adev);
> +u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
>
>  int amdgpu_userq_suspend(struct amdgpu_device *adev);  int
> amdgpu_userq_resume(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 0a3032e01c342..c622832fff755 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -293,7 +293,7 @@ static int amdgpu_userq_fence_create(struct
> amdgpu_usermode_queue *userq,
>
>  static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *=
f)  {
> -     return "amdgpu_userqueue_fence";
> +     return "amdgpu_userq_fence";
>  }
>
>  static const char *amdgpu_userq_fence_get_timeline_name(struct dma_fence=
 *f)
> @@ -514,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
> void *data,
>               goto put_gobj_write;
>
>       /* We are here means UQ is active, make sure the eviction fence is =
valid */
> -     amdgpu_userqueue_ensure_ev_fence(&fpriv->userq_mgr, &fpriv-
> >evf_mgr);
> +     amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>
>       /* Create a new fence */
>       r =3D amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence); =
diff --
> git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index 7bbae238cca0b..527fb7f7299a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -27,7 +27,7 @@
>
>  #include <linux/types.h>
>
> -#include "amdgpu_userqueue.h"
> +#include "amdgpu_userq.h"
>
>  struct amdgpu_userq_fence {
>       struct dma_fence base;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 4c01c3a030956..d6f50b13e2ba0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -189,7 +189,7 @@ static int mes_userq_create_ctx_space(struct
> amdgpu_userq_mgr *uq_mgr,
>        * for the same.
>        */
>       size =3D AMDGPU_USERQ_PROC_CTX_SZ +
> AMDGPU_USERQ_GANG_CTX_SZ;
> -     r =3D amdgpu_userqueue_create_object(uq_mgr, ctx, size);
> +     r =3D amdgpu_userq_create_object(uq_mgr, ctx, size);
>       if (r) {
>               DRM_ERROR("Failed to allocate ctx space bo for userqueue,
> err:%d\n", r);
>               return r;
> @@ -222,7 +222,7 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>               goto free_props;
>       }
>
> -     r =3D amdgpu_userqueue_create_object(uq_mgr, &queue->mqd,
> mqd_hw_default->mqd_size);
> +     r =3D amdgpu_userq_create_object(uq_mgr, &queue->mqd,
> +mqd_hw_default->mqd_size);
>       if (r) {
>               DRM_ERROR("Failed to create MQD object for userqueue\n");
>               goto free_props;
> @@ -327,10 +327,10 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>       return 0;
>
>  free_ctx:
> -     amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
> +     amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
>
>  free_mqd:
> -     amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> +     amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>
>  free_props:
>       kfree(userq_props);
> @@ -342,9 +342,9 @@ static void
>  mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>                     struct amdgpu_usermode_queue *queue)  {
> -     amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
> +     amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
>       kfree(queue->userq_prop);
> -     amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> +     amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
>
>  const struct amdgpu_userq_funcs userq_mes_funcs =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
> index d0a521312ad4b..090ae88977705 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.h
> @@ -24,7 +24,7 @@
>
>  #ifndef MES_USERQ_H
>  #define MES_USERQ_H
> -#include "amdgpu_userqueue.h"
> +#include "amdgpu_userq.h"
>
>  extern const struct amdgpu_userq_funcs userq_mes_funcs;  #endif
> --
> 2.49.0

