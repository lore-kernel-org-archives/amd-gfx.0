Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD224C55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 14:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5E610E04D;
	Mon,  3 Aug 2026 14:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shIeJp6Z";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A8810E04D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 14:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OawQpY0HKzFtb/eKlTdkY2TrKftvdnidFSNdpY5jbIsLmsELtnEVoHBZPPpLUXXo1oHvW/pvVSYegOdstmX5bP9kFbvx+37r3gJ3rx5TIc0PuFh1wk2fzymNMffwPm7JpDxLKTQnkZwWh7QbNuqM4Xb4UgSxOrx+NtzAO1iNlGXnh76rIeGMIukY2ATvMaNlTZsCeO4H9rGwiBNTpEhQGRuJWw07bObBgjce+ZWNPJ49HBsIGo1PKNTgGtPIshEFbzVwgxF8Rqr7BM/WKqI9uNolRcCc6Nn5IIvTTpDxw/qyQtdo12D2hHot4DpGKNA8cBigKCGrDt+pd/O44igi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2Vc5MTSRgSwMoXrN0Bjjg/CRYrnSspG2uWUMftUAvo=;
 b=TY0BnfYyr0jGyyGa6w/bVU5j5/Me7tUEMJhu+cBcU2ePtgKrsUaU1ZkZ0vHeChXtXevWbH5M7jZbHFGGnP8b/ZgFHFHkiLIuBazalREturBYWoeONoKHwrxg2s3DgiythmTJ2glOrptqnqflpeyRhYP7GnZQUdaBgRjmmoi3frh59EKoZMREPgN81Ha7ATgbtRKtLS8ej0e0ZlUr/TgbEsjjMstxxVORDoduUNVSdnSVnSvNftMNR7cu1e1aPclYv+b7K4v0YWhWc0XXroSd9E5MLvIecrAWtZg3o2Tn+9YwlgBxtK/Tpmh095Up2Chfoh3dlXSsGNM6cQ85VfjGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2Vc5MTSRgSwMoXrN0Bjjg/CRYrnSspG2uWUMftUAvo=;
 b=shIeJp6ZFVSOmkM+s07Afu2Q9MIa9uEId9WY+j0iM9GXlhbFp27mLLCubccO+9ublrI/5dIB8kQCkH53zkGsyqyFzn83vI3OvdxsTWSGQunfGE/d1uWfT8iR4/nVx8ePSWyUmeIkHpvM50oAZfpHFuc0SrVHIckpbc2kOtd+vtk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 14:14:24 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:14:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: rework the amdgpu_device_gpu_recover()
 lock sequence
Thread-Topic: [PATCH 2/2] drm/amdgpu: rework the amdgpu_device_gpu_recover()
 lock sequence
Thread-Index: AQHdHczOJXLEE9mBh0S7B37B2ZKKQraMaPgg
Date: Mon, 3 Aug 2026 14:14:24 +0000
Message-ID: <DS7PR12MB6005B0534D29455F2EA2128DFBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260727133505.190888-1-Prike.Liang@amd.com>
 <20260727133505.190888-2-Prike.Liang@amd.com>
In-Reply-To: <20260727133505.190888-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-03T14:13:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB6209:EE_
x-ms-office365-filtering-correlation-id: 63547d49-97c1-4727-66d0-08def169855a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: kV/OVIGTCS4RY7mx0EAh4s6PEGSCfSh9Q2/JAMA1wy36lsK+h1AiC4myuqFFC9CA4Z0HECTEvA2f1tovUGRxRyp9cWxjmxzUA8Q1fjF7g8j/uv5YptaxKnx4kKVRkxvqgjO5IkLbYS4DcplSCLb/Nl34GwSChZyukhncOwMTa8Sp1Ss1nZPKDY0yhzdKWM1m5NjHAwj0/yY07WNkXi+g1jzfN8g6kgYh/a+ml3wM/YdTjntmI5bXrZkRn+aXcA+4f9ZY+yx8uKJYcPtLcnUcVDkvOOADJO+SLCOrE1lSHDkGDNStx9ieXZRPKJRg3Bn64BulhA3ggIOm02kMiCT/VDU8fYGh6aLtrAUSSxAVd2HwyJ0VveJY8zYcRWT9VTggaDDmANlNXJRsUfftw4UHgH8R/uI5z3E2akdKpJWq+tJA41kyx+t7m/jwd7Pi4R0gLxB4BMkCK1LCy5DoMym5hXFKeyeAvuhRureFju40chzKvR6SlP5ojLgUG8c43c5WRXj8ycL8QD+H6xO50qpHvdvW1w8buzA4NK8HWEl2QNlIO41DJEgYX21gHE14d37VxFDXkk4Ap5ZRDzv1gn+yY1UCb8zorbdpMLiJP+wF+NNjDPyx6ecjrVyc3OkgPMW/eAMADq5PdJKMOlZWzzFKYRNOcncFQnLryftjw17eQi84Gv4lviqdC6w0/7VF4sI9Ka5SRqrXGDP6CuapKML0jjDoySSoKvE+eCo/U6XZBdw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pA7K/ouSWRNKc2K+XRdNnbsRiKnFwIZ+vgs6n/V50PSHL7rNT2iCUdd78t8r?=
 =?us-ascii?Q?2I85yFqqL7iiCMJZcyrJWf6I+3vs787MLeUHryMW0h6LedWfQxmZBHy4jzKY?=
 =?us-ascii?Q?DoCkIagVFUa4v+4erWYqT0pRhkhY2Snzw3edNx1PmXxFBfk3v3HCprMTqklV?=
 =?us-ascii?Q?Pw+E2t8Vn5ZmSkSTa1EmN/Bul5L4IhvncUQNuC3B1j3X1XrmL5ZKADsbQKLM?=
 =?us-ascii?Q?/ur1wXZWaFtY8pPLVZHeYhJfA1pSbvkyNExYcsOzpnMwEL8FHqUuDc7eBU2x?=
 =?us-ascii?Q?g9nPGvnEx12WB9oRzHeTTjJ9qTb6sKIWHHLL4UnJJOI172khHoFOZih6mukO?=
 =?us-ascii?Q?ElZ3vs15oNaZ3hJbURhV00MBodtswWJDdv6DhiqdAdVLxjUR5zV0tWJKPDzb?=
 =?us-ascii?Q?M1Ebk6slkEwQFk20bGniYd5YQY3RhaFTd2C3PHv4cCZ9mZ77DnAWF6j6Fq+J?=
 =?us-ascii?Q?NvohEHljbVKYbYqj5XYhKTZgr3Bo0gyfPs4rUMFZPEvCHEkUgTzzBO5rrQks?=
 =?us-ascii?Q?bEToSaqp/D+QFEgSzQfAndelvFHqXnBTLkMEyhLzD4RqhjaVifiJpRz63uUF?=
 =?us-ascii?Q?Rkw6zv/v14TvGGDJYduT8UOHVEBTM9zIon2TEh6kCzktKRu0MVeT057CBIj3?=
 =?us-ascii?Q?jX/PMyQt8DnCOHT01/nryj/9AvE3eNJ+0GXuERVXkl02XAGuNCYlAatHmIsp?=
 =?us-ascii?Q?g1mgDZqIYWWhsYqSexC0fcGVvCN7mKofqzKaKSB2e2qtD9Ok5PvywHDL4wv1?=
 =?us-ascii?Q?iNt79KyS1mjZL82eM3E2/VJcx/IGU1qQT7KsC4FL/0gLCC5iZIGgQkxB3U9q?=
 =?us-ascii?Q?63+V1hBQYlUgVV2/Nt2n4ZsEGS1TtPciN1V2xqXijLNaJ9UmaGfhpjSToGFJ?=
 =?us-ascii?Q?yMgqYlDAJ3iyiKIgtIeCSA/tz8kH2en/VSuqnuIDQ18ezqQX/fnXH2htx3IZ?=
 =?us-ascii?Q?cTe99udP8rL66ZVEPkMFs2AGziOyM/jz9f5487+OHSmFZt/CqypbDKgFY5aY?=
 =?us-ascii?Q?QapwxH8xcHooIIZrSrKTg+c3TtOr903fyUSbKyr66uzUrBKQGdFRn0zk3BTu?=
 =?us-ascii?Q?81Ryxa8SvhVYKhjETpqOf1S/dNCwjfFLAaXIgkvBwuQgQxa7KWzxYLgXHr9O?=
 =?us-ascii?Q?gbqmN1PDiDZeOeJ3ULlg23v7s3V+p++Pz/lIgGTXAXv3dj4SgipTV/3dMurP?=
 =?us-ascii?Q?6mnJddEK31t1yLuUH0keXevEvVvKHeucl5njcR2oz1PizvJJhnzIsidisv10?=
 =?us-ascii?Q?evFbOEV4RUo9+u3+9NEqKu7KgcrCRmNvHOzZaxzHbgGIPX2zH1thlhSLjQl/?=
 =?us-ascii?Q?dZlyjbWAqcyRFXJhcGQUnIgTApetcdRFgo2y41zirqH2/Z9rgB7syXf2gUjr?=
 =?us-ascii?Q?zIBmtlEvSWDr3ZA3ojBgs8pScDgrJn9hMgoc4o/JnVVcM+Y6G2ugjitEjbC1?=
 =?us-ascii?Q?TXahDcuOZm37SgF+50/rGWCH3A9r38drQR2f3L+zJOnEeu1+kz83JiMc8bGs?=
 =?us-ascii?Q?70Lu8yD8ludw7Om/34v1s0WQe8HOQlbwJ6u1qcSG9AkzBEw55qFgGnYw8Wea?=
 =?us-ascii?Q?4yKLCj2iv8Zaf4VpIE0GcvLdqMEEYLI8YUL6NGGlbudYdEoVj9J7QCoQ7XUF?=
 =?us-ascii?Q?Zx0rA/m4BHeFphb68N0AHz4tU8SWv0tZkoUc5LWgMtV/gXVHeksar3nOKogb?=
 =?us-ascii?Q?2g/nqyh9vZPPEIcbIKb9udCALalv4SQxFg4EDcJLmJhErnYq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63547d49-97c1-4727-66d0-08def169855a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 14:14:24.3687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LePPPzn6j8cW+XVUiTWJtv+iHsrOw2b+OwpjsNpltyeZSGrdyEuLrwv9WAZLmv7o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
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

Ping..

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, July 27, 2026 9:35 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: rework the amdgpu_device_gpu_recover() l=
ock
> sequence
>
> Suspend the KMS/DRM clients before locking the reset domain.
> drm_client_dev_suspend() acquires clientlist_mutex, which must be taken o=
utside
> reset_domain->sem. Acquiring it while holding the reset domain lock inver=
ts the
> ordering established elsewhere (clientlist_mutex -> ... -> reset_domain->=
sem) and
> can deadlock.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 472e96ae884e..c670d5cfe3cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5371,8 +5371,6 @@ static void amdgpu_device_halt_activities(struct
> amdgpu_device *adev,
>                */
>               amdgpu_unregister_gpu_instance(tmp_adev);
>
> -             drm_client_dev_suspend(adev_to_drm(tmp_adev));
> -
>               /* disable ras on ALL IPs */
>               if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
>                       amdgpu_ras_suspend(tmp_adev);
> @@ -5535,6 +5533,22 @@ static void amdgpu_device_gpu_resume(struct
> amdgpu_device *adev,  }
>
>
> +static void amdgpu_device_recovery_suspend_clients(struct list_head
> +*device_list) {
> +     struct amdgpu_device *tmp_adev =3D NULL;
> +
> +     list_for_each_entry(tmp_adev, device_list, reset_list)
> +             drm_client_dev_suspend(adev_to_drm(tmp_adev));
> +}
> +
> +static void amdgpu_device_recovery_resume_clients(struct list_head
> +*device_list) {
> +     struct amdgpu_device *tmp_adev =3D NULL;
> +
> +     list_for_each_entry(tmp_adev, device_list, reset_list)
> +             drm_client_dev_resume(adev_to_drm(tmp_adev));
> +}
> +
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
> @@ -5613,6 +5627,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       /* Cannot be called after locking reset domain */
>       amdgpu_ras_pre_reset(adev, &device_list);
>
> +     amdgpu_device_recovery_suspend_clients(&device_list);
>       /* We need to lock reset domain only once both for XGMI and single =
device */
>       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>
> @@ -5649,6 +5664,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart=
);
>  reset_unlock:
>       amdgpu_device_recovery_put_reset_lock(adev, &device_list);
> +     amdgpu_device_recovery_resume_clients(&device_list);
>       amdgpu_ras_post_reset(adev, &device_list);
>  end_reset:
>       if (hive) {
> --
> 2.34.1

