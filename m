Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A2D2A520
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 15:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E00610E730;
	Wed, 16 Oct 2024 15:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4tvVCvW4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4320F10E72F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 15:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxT8CFhKhIsNLAVOBRW/lVP/QFz/DCBu+9fdb1oTiHXrWgbvsd/OOPb4eXdXOUjyGCAqQhkwukrhFNVhAMJdFWUvs8AD125iv/HsZq7LWvIKI0oBExRlBZxAJT5P/VuH1RW8ubPuHARobtdvfxyEkk2QygKg2icI5F9Uc9oWI3X7T8Wj/qDnewjv/euiEofRZUNELYN4/z4pZ0nTkaITF5tqORP3JLcS4BWXgyQ5VOdqCIrd6c53O7SPDfonr80zK8TFW8a1reukJWrGfLg9mJtpLI4c6VmYCMlY+gKhRdtLGUKWULdOLYujk+IRkTCKRsQ7gmCmg7IPxb5RKe2Hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui3H3Y75oKNAdbxbqd5dasjJyziB1/tRyJRyf8jN/a4=;
 b=GC0QdWDaFZNwR9qJS/2/eCQ9nF6KytUcYXDSCee8TFDGSSdlaEw42vPfuetC0bmS+zXZ7s7Y15fQBAPAWF8+XRQCuoEFPBBs8izBkmMj4dlG/ge8LSCTVGY2h3GQX3+YcEWDPzba23RrO5JD1Y6tTqY4fAMMuwROBy+JEET8gXjy1DKzzrvNCqcRxiHBIlvnfdwCU7Qyvgw3jiO2mLRD5TC7Y/6DKm4BZl4T3VAEO5dDhMJVbsOIN9400St34jfY4o8ezsQr9pA4eIYLt1lLbblZaLKGG3qSBzIdMPFvoo+LB0CqJmkHCFdQfZTu7jA+mutYwRHkbe9sCGp7dwts3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui3H3Y75oKNAdbxbqd5dasjJyziB1/tRyJRyf8jN/a4=;
 b=4tvVCvW4EUx0U6y34R0pEcG+G4BO7zT5awVYO15PBA4tZLmLbWRpmyNSaIv1jlvF9HrlNLgpzuofgCiAKzvQ3n8j8ZKa9Z8/x8ZQnULORSyvtmfNIMhTI/WZ1NZ2FxwyorgjfEwBkLWBwvqXw4u6lSECrmwOXe9fVlQyFKVDQ3Q=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 15:11:38 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 15:11:38 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu/gfx9: put queue resets behind a debug
 option"
Thread-Topic: [PATCH] Revert "drm/amdgpu/gfx9: put queue resets behind a debug
 option"
Thread-Index: AQHbHzzLzJYzwYXB0UqpctkjJXFUOrKJfLtA
Date: Wed, 16 Oct 2024 15:11:38 +0000
Message-ID: <CY8PR12MB7435916726934329CA4EBA2485462@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20241015195933.2500409-1-alexander.deucher@amd.com>
In-Reply-To: <20241015195933.2500409-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=227935fe-0e13-4a60-9c2c-85a87830fc47;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-16T15:11:28Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ0PR12MB6806:EE_
x-ms-office365-filtering-correlation-id: 2b48ae26-2b44-447f-fce2-08dcedf4d55f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JbYVpn1CDO+hTc53MYV1tFqDp5RzX6TsFJnpkQhGKXs8Gb7kImZGZS6RcEOG?=
 =?us-ascii?Q?5Lt+4F2JI7mICBVNZ+TMeCFGDlhxn71U6+M5Ob/cRqR+Vo1fedM4r+NjZATX?=
 =?us-ascii?Q?H/NgRRJnDYdoa9YRaCqxlpZ5EMgjqIFAQv5Fguef079MhGxZKtC3AijK1aiy?=
 =?us-ascii?Q?RPgW6b5+x5iXTGoQZllVs1PgS7NVOQA4nIyqUHlAHekDg/IGIvVOsrz6nGmg?=
 =?us-ascii?Q?lj7QstQAfGk//rZ/2w3aNmr1qpSI+tBMMFZJhCdSNIUMxxY4J1BLONxsdXTf?=
 =?us-ascii?Q?FXdl6U/mb54QfTxYymATDiiRjPfCGtzHTXgAaeFK2ymi2bQMrzYI2sr5GNma?=
 =?us-ascii?Q?Gqxeueh/TFgf8i/xwuQHeorPbSWAt5kmVkuBcDkwh70b2wE+JmIwzSHatsQg?=
 =?us-ascii?Q?Bpk2r/tTInKq9ldS0ar1cLZtEGtCfKDsTZ/SkMOB7xDE9bPLwaee11JGIozU?=
 =?us-ascii?Q?g7vpZKS/iKdDa1uHstLC89k4PTK4nMESXH+dieqanwkLjh6Y6jWbOcj99llN?=
 =?us-ascii?Q?BjlisOTvPWomq64GPIzedGC+px2ZhjXXvi3dduT7B+GippIKmWpzz5KvLJ+c?=
 =?us-ascii?Q?mVgeoChtgUX5ictYQ0YUhSh3KJ1puAeTPeoLN/ET7TmiFhDGtIIdUiwyZxeG?=
 =?us-ascii?Q?eSUpP//zD4S7mAH8Np1L3WzZrJGcg8JmteeBsB0Z4HllIBhvL/nHUdIFrOqJ?=
 =?us-ascii?Q?u1r5GGK9mSGftVzPA1OIb0pzTLe6fuf/o5I6sD4d1j4T6Jekvl0gyrZjKufq?=
 =?us-ascii?Q?ZfIZZ8h3Ga1aiE6ZBS5GemyPWWlOwYBd2Ju98V3Dqe9F4Bw/A+E70MtWAunU?=
 =?us-ascii?Q?GWs/2isDmN67QiFb3Kev4FXi1BCGKhyzEuwCcUVWIvDISfvbD8FPRdic7ky6?=
 =?us-ascii?Q?M+u3CyhWX//YePWLJ+IzFz4PfVy0KJxsZ4+wikSgnRptXOEpOuE9W0n7a7PJ?=
 =?us-ascii?Q?jsQbsg3I0pz1+veOt5lPbTOzHbZUZLGdo3zSm9/qaee6LAKD1Y7fcLypXD/b?=
 =?us-ascii?Q?M8SZTtKkSh4DNGWrTIrUwUEDWW8Y5wkblJeqbQ1Z9YgUMDppS3cTKXLqfAQP?=
 =?us-ascii?Q?VsefQlz3QNGfUfh29HXfNvxEJA1ixHiDCofkY88PQSxrjr2jBmF4iBrRUCa1?=
 =?us-ascii?Q?0Kkq4WnY3Yb1wANyiw2mZWmvruC8fgMP6t0/Iw+PIWdurNfrKo8ZeMu/kKvc?=
 =?us-ascii?Q?QvEKZccwM89PSdIg0ZikS3e+BPolaAY3J/ic1N9d58l/xCFFd8JmF+HaU91S?=
 =?us-ascii?Q?rTJjXqmmDIP2iNgM6hh9xwQ7v2UiZ9vmrmqUKMSAeoCIDbjpZocrR0LKIq+A?=
 =?us-ascii?Q?hqGPQpEQWmt/lhG4u+rc+ia8UGJhGHtGeWuexb5FTkIKOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DLL02x+hYdA3KXktIA0mkp/WpFcskkrvD5H4VT9SJfA8Y6t04Jn0Ow83xjky?=
 =?us-ascii?Q?k4QJ6C/PVtVrOS0Iolcudwa4lXxlg8eyKkLVt8jka0Gfb7VtNTVydi0V+KiZ?=
 =?us-ascii?Q?hLjzrjREyxrGUurP5CbszBXGfkdCfr4o+qOgtQNacc/GS0h6RdIcjvtDaKwJ?=
 =?us-ascii?Q?IybU1zZglYYAtr7Mb5LtOrtnWOfKeLtxylzGf9D2MeKNLy4reiOEne21Crq+?=
 =?us-ascii?Q?raofCPgTp5ngSuT+mTXfLBUnmUQT1Zm+cj1zR7ZKQzsiOya6YYEwOojp7uJ8?=
 =?us-ascii?Q?/Ln8mJGVabGM/yKnZdFY8io3r/WjErz6nifDFZLAkw9NTcU4EPZK8uPC4auE?=
 =?us-ascii?Q?etVa59iXTKlPLIFaYRCoKFGWlNW/vPrjamzxOrDctoKs453omTfPzylXWGvF?=
 =?us-ascii?Q?fBLhpBiGzolA06qPUzsR3iEcLyQWMoG5eLAdnVyoAOhHZS8dthXxtINF+g7U?=
 =?us-ascii?Q?GbKE9g/P8qGM0IKIRzDOozFgbQp5S8O4rv11bosrnYksksqn00AuPHNp5FXx?=
 =?us-ascii?Q?m5X/GUp0O/VUaLxHzpfU1y254Gy+E6F+f5unEYoGixujzFBT9c8BCJPHLZA8?=
 =?us-ascii?Q?uFyJ1XkYyk3zciyfcNwgr8kkFQQYTUPxlQE1yu/FhRG3CpEGp43UZUKa5o4P?=
 =?us-ascii?Q?8QAkMOejQa+J8iUtcailAsaZJaaVvaT9jmNK2Rfx0z3ALAxUC+jvpmHKOig3?=
 =?us-ascii?Q?Iwlm+qqJY5B2CnltMLt9R/7nxlWJd0Jb2JBH3vcWtIsvdgkat7TQ3drBZN1X?=
 =?us-ascii?Q?whFxd+AswJuoMJDBXOfY3IFl15tCgD11GMcutoQDPiLH6GXEfKokzdLq8GyD?=
 =?us-ascii?Q?dZ/JHaTulBKVjWXQS9CzLGiBtTqGy+EaISRgctlAg7YI4UGhfL1FFTeuYl01?=
 =?us-ascii?Q?0Oy0UktZSBKVgs7fC+TrjOzdGxm7j0Mss7z/aBuSU/jOAfBPrJSHQUcNp332?=
 =?us-ascii?Q?GAssXYavq4n+Hnjfy5qJryBZiL856OpvgIWrqGjPY4vm8lQizz1PH84sRq1R?=
 =?us-ascii?Q?1sPpWW6lCPlBi/sAcNMVScXzdMYyDNkHO6m/7d9TKPh8kVm3K7qeCg1mZvae?=
 =?us-ascii?Q?t3HWM5rftGa7Q7EGaOn0v4GyL/v2Xs2O2ONhHfiy+WSIUt8Q/jprHzD9I327?=
 =?us-ascii?Q?oFZnlxFpAdPrijG8kPIL4qQPiafdUEW82RDwJr9Euvu5sELGoNSQagYdAVhz?=
 =?us-ascii?Q?9RE9FWbS3Y172Wvs388QR7Xkz0bZMBGUwFQzvnuA7DnpMWi9xDZ14WLGRy19?=
 =?us-ascii?Q?UQEwDyv/ywJepfkXDrHgVMGsR78l8nChb3xopGZZjv9tsAT3Bs4jUdKZ7xZB?=
 =?us-ascii?Q?N9mL2gL1fugf6UkZObsjtlEiTtp5iga1ELWoIhZYZVwdFUMtx4sWzMH8FtaC?=
 =?us-ascii?Q?Oxbwd1Men6CHmLB1iaHwdATgS5ECbf1renPWi5WidZhyOJG3fZQ9kiRIe0D7?=
 =?us-ascii?Q?nU5BO1XD1PbN5qADf9h2Vv9mhMclLCmIQW8zpRjbNyaC3dUcHsputbpEipHo?=
 =?us-ascii?Q?1wx4WvudZFhXu/9Or0p2eVLrqGDSIbr0D2ROfy/PfD8xAzCBaO4/VH3PDRSo?=
 =?us-ascii?Q?xsxqCpZOxYw57bliUF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b48ae26-2b44-447f-fce2-08dcedf4d55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 15:11:38.6807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ba+NwTcqvy5XAeup4yopdIZQgsE60vg/rce/HDJi6HXFzY7ZaEax3J0pSxOnQXYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, October 15, 2024 4:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Subject: [PATCH] Revert "drm/amdgpu/gfx9: put queue resets behind a debug
> option"
>
> This reverts commit 7c1a2d8aba6cadde0cc542b2d805edc0be667e79.
>
> Extended validation has completed successfully, so enable
> these features by default.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Jonathan Kim <jonathan.kim@amd.com>
> Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 6 ------
>  3 files changed, 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 2817198d4b55..740525407154 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1132,10 +1132,6 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
> amdgpu_device *adev,
>       uint32_t low, high;
>       uint64_t queue_addr =3D 0;
>
> -     if (!adev->debug_exp_resets &&
> -         !adev->gfx.num_gfx_rings)
> -             return 0;
> -
>       kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>       amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b5102da25798..508a2dcc0b1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7260,10 +7260,6 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *=
ring,
>       unsigned long flags;
>       int i, r;
>
> -     if (!adev->debug_exp_resets &&
> -         !adev->gfx.num_gfx_rings)
> -             return -EINVAL;
> -
>       if (amdgpu_sriov_vf(adev))
>               return -EINVAL;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index ccd17dca0396..4fd7e9c5856c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3055,9 +3055,6 @@ static void gfx_v9_4_3_ring_soft_recovery(struct
> amdgpu_ring *ring,
>       struct amdgpu_device *adev =3D ring->adev;
>       uint32_t value =3D 0;
>
> -     if (!adev->debug_exp_resets)
> -             return;
> -
>       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
>       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
>       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> @@ -3573,9 +3570,6 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring =
*ring,
>       unsigned long flags;
>       int r;
>
> -     if (!adev->debug_exp_resets)
> -             return -EINVAL;
> -
>       if (amdgpu_sriov_vf(adev))
>               return -EINVAL;
>
> --
> 2.46.2

