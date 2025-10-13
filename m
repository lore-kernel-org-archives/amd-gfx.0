Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F67FCCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 12:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C825510E456;
	Mon, 13 Oct 2025 12:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QEwuO0He";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AFD10E441
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 12:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSyueC8+uJK3LzrBbEFZnsnDAsOotmqCYgvvLHc3+eZiAeceGbU9pEcumBNx/nboLd15rkL0c+0PYkr8BFzrnmYil3y7hbOh/p7ouFByDJf6MzIz+1AOVU7Py/CcaxkK7bRRhUiYTVksHPJqcGGqRiBfEl5PJ4hvrFHAzciH2h6Aiokv0m7FCa1nB1l5EpkFedBQIgiWCz2DI509/f6ld9HNpsC0yRmb05b60c3fbdvsj5IGTpAyNcY5/4HRetUWhSURJTbQCTGqRlKiTFvwv/7h2n+3CIDulXnsvXEInuIyy/ySobcyou/RSB/mtdl7lKpEKCUUYASV4WfADfBtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWvRvyKm+avqWI7Kgg5i/FOpf4Y4unNDtyROoy9fFMM=;
 b=Tf/QKoBgUnqMbCCzPgZCSg6xyMFUO8j16qSFHt2mayyu/WK5i447YsRic9azQU21ayZ3vPyG53qLZQItikrEYPcAoB5b5229NR+XrI7FBa2gIiDSdPIpNA1lup/rgbc/2tx9Pbzy4f0rzdI0m7fTzvlB+J5J4x1B0IDPTarS31I2WntwsxGRGapXW+tW1jGM8Jr59lwHj+ZUfkTXlYt5oJvw/neS3/MKQoSoIxn1sfLy6aiTM72T0OKPifOvrj6k2+85T0yocFAClwGT7gd7G5bSADBXkdV5/r20nS3siiRcbzpPRQDzDDvaqi//oVPLMxaTNpEyEn82nNGVBiUNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWvRvyKm+avqWI7Kgg5i/FOpf4Y4unNDtyROoy9fFMM=;
 b=QEwuO0Hey0Ig03ziorkPuNafDV5ht10W50KHzjanNp0EXK+mgVSVCY5m6m71o7fDvJaPokeVuP9EFX49HJJf5aki0crCn04ur+51dPYfG67exYawwi9o3lpahzBShaCJzXRMxIQDvcaiITQPiVzI8vNglwvCoL4l/3W2wm2LKQA=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 12:57:00 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:57:00 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu/userq: fix SDMA and compute validation
 properly
Thread-Topic: [PATCH 7/7] drm/amdgpu/userq: fix SDMA and compute validation
 properly
Thread-Index: AQHcOisgZop1ZOKgaUyn3W3L/+vkk7TADFUw
Date: Mon, 13 Oct 2025 12:57:00 +0000
Message-ID: <DS7PR12MB6005C42065FC3D9DE1392DE9FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-7-alexander.deucher@amd.com>
In-Reply-To: <20251010211510.1528572-7-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T12:53:18.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW4PR12MB7213:EE_
x-ms-office365-filtering-correlation-id: 1f8f3d09-7084-4e85-3a27-08de0a57ffde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?41f6ycfoKrtgHoeu5s81LlZa9qBfgwTfmy5MLE/E4wAh/tA5UHIOyy2xj3RI?=
 =?us-ascii?Q?iQ4ocqJyOSe/QXoXltdcKRTCjqiKZDEP0No32WbYmsDrFMBU3+4I+U2Pdlzi?=
 =?us-ascii?Q?O3fLOD/ppnTb5MqHTKLKkmxSIhrNaE47KeaS6irwqv8OiOOq8FkMpgMC2FYw?=
 =?us-ascii?Q?Imlt1kv9b7/S1P1mMK01LtdHKZW1Z5TCNIHG/kt1iCELi0cBTGw4sajFCCjr?=
 =?us-ascii?Q?S9jAWWQWT6PMXRWoz293ImZ5qWpm8fi/a8p+keRAFleNZIPseUYglXCpeYaW?=
 =?us-ascii?Q?HZJ9edHc5/5kQTolVgEdL73MM9tM1aRua2BCwMUQ6V1VaFr5vhqk/7CNOjvr?=
 =?us-ascii?Q?eau5YHbn0d1PM6nyvK2+aeBWm0x2SxFxfEsH9kX/YxvPpQJtJa6Q9EtMlvVL?=
 =?us-ascii?Q?eHBXlBmbyQhImuRlWP26JHrJuH+zt4NQ4UT4QaZ8HTHUgxRRxcgP2HoqYe3P?=
 =?us-ascii?Q?pUoCVyfCD1iMXnl9PNZCdoHtU9eW3EXfWgZ5C73CovpMaPQRALv4K4k+Dmmx?=
 =?us-ascii?Q?62mv9aznhDrWp+fuVZ4xNdm2ugOOkgySLFB6CytnOTeWCq5fZp3cz98O7dQn?=
 =?us-ascii?Q?mIHRW7juWq4yaguuxGlgKt5tS8egg3YylGXaIjuZKG4rOW6+i6owClYmpk9m?=
 =?us-ascii?Q?6KZij6rDh2AoJzWM4XU2IURIsJBsHd/d6nwxdWOa5ghSjPbPdISH5NTfJD+h?=
 =?us-ascii?Q?QHr2GvUm62YpzSTCtTGL7uea9bSdnQo/d/oLmyKnbcOdxOa6PpTAtKfCPufX?=
 =?us-ascii?Q?jIO6ITyyeXeyZBHy6hrWEniX6lM9+gbS443ZAGvPJhNU3eXXWHc6D1MI9hKH?=
 =?us-ascii?Q?MouXyLkohc+f9P1UVjev3IRnbkxhc0mzwyPxUskAi6VgnUST+3wVFyjnQm9o?=
 =?us-ascii?Q?zEGDNV9zj1/eXK8hg0+BeNk09cTCznA50CtWzjVb8mWBApywc8lvZpIVlXd0?=
 =?us-ascii?Q?iLZPl8hZrdZLFXELXXGI2FuSYb/i9YtRCvEvVVNeRv/VmhbX4xWdo1GUXfLk?=
 =?us-ascii?Q?M632y1kxnUB+wagSz+Il4/Wkdt5cQjXDrz446WuHhJuMIds79/ktkjv3mNmF?=
 =?us-ascii?Q?zXwNm/PDrrWRgW98qOUflLTqCgAiHOspVRDQbb/cBG02U0ixo+9tenxzAS11?=
 =?us-ascii?Q?E3iIodADymFHUhwEwQC8NSlQ4VE2g4S7eEFtIMDk+k/u9YlAeK3F1ezgMQwu?=
 =?us-ascii?Q?rIqnCqva6JeMCee9c8xHg2ar1GclF+XCgozt7gUDngvmfCPwWa/nF/2SU2Bt?=
 =?us-ascii?Q?KympHkvYzi7cLzSvEKK8bsiGaYrF8hzbsiE+nEXVttSat/P6fb2Q8WctJ9SV?=
 =?us-ascii?Q?egmpW4V3CCyDvI4upp4sz2S9bqzk3JWZGyDOsS7UnI6EMm6RF14cMb3kVqx4?=
 =?us-ascii?Q?PWmcWdUU8ktb/FswoUN8/IIARooIsVdw1U/k1z52F2uSaF/R4sbEe3n+qiy3?=
 =?us-ascii?Q?3V1M6xuwjOdq1UlGnyZhoujdC5g81IngJslM9Owyzjp2MBLl0hL5Eu6J1Wq1?=
 =?us-ascii?Q?wo7KSfe80Dmn7/Qkx4chDK6yV/XVQuGs0Hs9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GTzWWPslw9odjCQ7hqyYayDIP3pCCTun9SuBKeamgiAHOikTKI+yGK03nFLa?=
 =?us-ascii?Q?/XLyPLWeCOLpPv8v7PPug0+vuyoFCTjJCpPCq9O8qOR7JmN9nSAMM7u1IV0B?=
 =?us-ascii?Q?2T95V+Cc6HREvjDHHAbbfplEHf6j1yAKA8aghvxNtRbjItvFVGH6AYJCg1fm?=
 =?us-ascii?Q?2wofckuR4gJwuZ+ZWd9efl7vMnVwwJadEMeZ7OtYU1OHi2lRAg6cJNcZj3f/?=
 =?us-ascii?Q?/7bBH/X6qLW4GRt2eDkS5kviykceK0iuXnfbApBTF/wc/Um1rIzvpM5i4FhE?=
 =?us-ascii?Q?DYiuTA48Iy7cxH25T59/vxMQOyfPbt9fDXCt0FUSSpdGyMvpGxa482nQajcM?=
 =?us-ascii?Q?2U0JNJd1bA0gViVYXzCrs2e9WOqlZQyXmb6T6P2Eqp8Z6LQN17m+WIaFHdRY?=
 =?us-ascii?Q?svTNiYGC4uQCA2WVLdyEkukFxE64E5BNfq2T5qB3k6TEI49SFa/x7LKEYMtY?=
 =?us-ascii?Q?yYB8NfIqAvsJcnYK5wIJGw1M9lFh+vD8QV7sFwh3CJniwhbJm3MCCyfP2mxG?=
 =?us-ascii?Q?XO8Q6bju9YFSVHI87Fq/LHnFxc781YAvvxy+G8xt2N3nW5IbuLLi9/uIDQac?=
 =?us-ascii?Q?W1K5I5j7EoLuaBMnyF2sjMeA50tuxhNHMj5/rodf8GKbmeXRnZYuLiFYSaMC?=
 =?us-ascii?Q?GQpfImvZ9E9H3hxYxnN04Txa+hDB7qYLAPwmYYGWNbeOZXXm6b7v9A2b8Hvq?=
 =?us-ascii?Q?2i6CZO9hN2s/hfaDzObj8rx95Epo0QuieRhma+XcF4MeEXC6ptk6pn3aJrQj?=
 =?us-ascii?Q?usjuQa21AmKDA1LbGupRrCOSWXUEcdOSV6PzuTjAbKUtnihOFZzcDVGFABdM?=
 =?us-ascii?Q?c1uw652zicMr52r4KDWJJbGNdtw7775Bxc5xFktPqENloUtcqVScLY2h0FSB?=
 =?us-ascii?Q?0EHhbcMFCm37Ch69ptJU0ruP6YdHz6mZzTvzFXG6e2M65lzm79sX4eoMzvJL?=
 =?us-ascii?Q?WyOHH/plVaIwD5DA6sjPzfLqjjSWGRw2S82/DcokBFyh6/ZW5CFvJITCDE8S?=
 =?us-ascii?Q?0Nl2OetZkZoAeefhNYDixc6cW+xCTnzZQtmH5f9RoFe115cA3AoN5Z9FLUwj?=
 =?us-ascii?Q?V9CalW3UqenzX0xJSd1986eRkUT7Voh5dCY/ARHgbCwkCAYhItRmBKfFuRWE?=
 =?us-ascii?Q?fWSA9/Qppi20NxX+EmjB2f6hC+sRrZXmVeJDdqDGaoDxv68Z19tALnn26qx+?=
 =?us-ascii?Q?rlaZEOnJT1jabkvSExBCiMvG7Fu/unSyMoY0sE1At2X9dRjBLuRSERbTTbRq?=
 =?us-ascii?Q?n1JvPzIKivP7OrGWvn9zyeQJa9ZGRAKfPYtqka/85MfW+1IGUve9cJ3dYdtz?=
 =?us-ascii?Q?fPMhydbvX3LYJRRyLJ0hFFIIDXnk+T47RtNFvmPqWGH98/dgkpMSKnv7fOfu?=
 =?us-ascii?Q?GRtTGgUFj4htw4tV9BAqQY/j6iT6BxxxpjWDMBVf/DM0o5mm0Toq0eNIQIS3?=
 =?us-ascii?Q?AavKv5j3M2GcnOrO8Ndn17QF71/DV7+KkcJHsbwLOqiU9mnrd991XVyIU9tB?=
 =?us-ascii?Q?z2m1JEhYOJdlgoCon9QDpc6nsr7Sc/Pz3MHQSB7inqJLh/oyQxTIyy2V1iS+?=
 =?us-ascii?Q?eU9hlZN3NjBq19YUGoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8f3d09-7084-4e85-3a27-08de0a57ffde
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 12:57:00.3902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BMxpssVpLPgCgaCvz2sBAxd3hOsF87AWh0589FwA7mSnTHNIjkYvG1ek5Js216o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, October 11, 2025 5:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 7/7] drm/amdgpu/userq: fix SDMA and compute validation pr=
operly
>
> The CSA and EOP buffers have different alignement requirements.
> Replace the hardcoded sizes with proper queries to the IPs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index ab392de2a2388..17a386969b663 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -281,6 +281,9 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>
>       if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>               struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> +             struct amdgpu_gfx_shadow_info shadow_info;
> +
> +             adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, tr=
ue);

[Prike] May need to validate the get_gfx_shadow_info() callback first befor=
e using it.

>               if (mqd_user->mqd_size !=3D sizeof(*compute_mqd)) {
>                       DRM_ERROR("Invalid compute IP MQD size\n"); @@ -296=
,7
> +299,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr=
,
>               }
>
>               r =3D amdgpu_userq_input_va_validate(queue, compute_mqd->eo=
p_va,
> -                                                2048);
> +                                                shadow_info.eop_size);
>               if (r)
>                       goto free_mqd;
>
> @@ -343,6 +346,9 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>               kfree(mqd_gfx_v11);
>       } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
>               struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> +             struct amdgpu_sdma_csa_info csa;
> +
> +             adev->sdma.get_csa_info(adev, &csa);
Same here.  Other than that, the patch is Reviewed-by: Prike Liang <Prike.L=
iang@amd.com>

>               if (mqd_user->mqd_size !=3D sizeof(*mqd_sdma_v11) || !mqd_u=
ser-
> >mqd) {
>                       DRM_ERROR("Invalid SDMA MQD\n");
> @@ -357,7 +363,7 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>                       goto free_mqd;
>               }
>               r =3D amdgpu_userq_input_va_validate(queue, mqd_sdma_v11-
> >csa_va,
> -                                                32);
> +                                                csa.size);
>               if (r)
>                       goto free_mqd;
>
> --
> 2.51.0

