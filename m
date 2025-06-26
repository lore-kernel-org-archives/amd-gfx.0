Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDF2C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 01:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5493410E162;
	Thu, 26 Jun 2025 01:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4Ir7zBL";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F360310E162
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 01:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVKm7nxfyubOZIYbghi08hhEB/7PMSTh4aucUAxwohaH/CclGG8pK6DV66oxDpzwqinzXSEp6WsvMVuRnwsH4BxkHtZcV84sAqEhtoYeyavhVraWUndtpyvm6yN3m6cMFjhx6XijL29XHb2G1PtFpgS/YgeTUyR9a/YP/Tij4hdpzuT5RTCnpwJTF/fdDBnqok3hQVitcwv1T4+WMkAK/CVg/rZnR9Bd3AXc2FdHetjOkEAx75mk7tTFzjc9LtpftyHMy2f+/IB0kYnR2L63vJR1aNvDmq/nHqy+cFH/VtRwX79u6eASy2tqqwcEhxckQda8xbtdzIKHbNnp/bCWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5bx2lR8JdrJMOpDNNhaPQ0JpSkBHuRy98azWM1s0Uc=;
 b=LKffS2T8cm2i8wDtYi9+osDl5B7ZnF16Ye/H/njh3P8MclANLLOA1GgbB6albYlzfgjWPSykiqyG9KLAlxMN9rzv4RICbiuCRX56v0x0rY+f4CJI1VUQ4QRG6xzsQNZApppiEXxnzyh0JS4gRa65I0If/CmrOg/vmU+PA2kIMQBMk826UsVPSQGap+M+qObWs7uXBSYbt9g8bmCQ2zRG/WPVm9fpw9udU8ntSOW/KMV88Gedm/6x4QRpK0SMwF3ivhwsv7cZF7D8/f7mci6IVHNsPClRxeTpoJCdI2c6vLkMZ/KD5K/FCKVDd3/K2ODvpVo0N+fqJxzHJvD+3kO8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5bx2lR8JdrJMOpDNNhaPQ0JpSkBHuRy98azWM1s0Uc=;
 b=D4Ir7zBLMedWT5xjSIMX+/Fx+qHy1QtbjqMhbue7QdR0DKFv1BJZRXPyGjTNUDA1e3BRm5OuvphmodbSz3GZV+iYHyQ0iN35jSAJUamtI9ERPJV0IoX4kx5Uc74GYW1i2Vauxoxy/mv6+uho3PpYbVY/YtHXChWPOIsM+OKoj0E=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 01:35:23 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 01:35:23 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: Johl Brown <johlbrown@gmail.com>
Subject: RE: [PATCH] drm/amdkfd: add hqd_sdma_get_doorbell callbacks for gfx7/8
Thread-Topic: [PATCH] drm/amdkfd: add hqd_sdma_get_doorbell callbacks for
 gfx7/8
Thread-Index: AQHb5h/H0B8V1iE9a0Sn1CPd8yPD27QUqJdw
Date: Thu, 26 Jun 2025 01:35:22 +0000
Message-ID: <CY8PR12MB7435EFAB95CB6459A9E00A96857AA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250625222312.439685-1-alexander.deucher@amd.com>
In-Reply-To: <20250625222312.439685-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-26T01:35:08.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|LV2PR12MB5992:EE_
x-ms-office365-filtering-correlation-id: 72bd713c-4b04-498c-bc2f-08ddb451b81e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8nl5Y9HmBeuD1ZTKj7zohq5gTQlWtk+XEgrUZEUf0frlZXR1+hnT39Gx0Jnc?=
 =?us-ascii?Q?HkA0uDqA4Wx20DdwxQq4VbnSFy/TxiutCEpBAIuIBEUuy6dnfveZ1g2FD8l5?=
 =?us-ascii?Q?Lnt/tDCM/GkseJUkmyYSEUoz7VdebmHY3ng5h1UyIJBEf4+mjCQiciAZLnam?=
 =?us-ascii?Q?yEbgxlocOCqWUamIWmvn0R/PA1EiNjGU3uzgwXC2B++RR9RQocLycy3o6qB0?=
 =?us-ascii?Q?/BGpXD2ky2yobIo4O4F3Yt5xCnJqDEfc0Pil+eZ8v56tA5tVOZYCSuDD5GKI?=
 =?us-ascii?Q?NbiZkULwlky39NxdowYDtrKENOgR8r4EyECM8Z+xQY82XmP0HvyND9/zEh+P?=
 =?us-ascii?Q?16G06Y6Glm59UZpjxPha+MHnx0j8BKAm6j7PDOf4Ufiugm3I2hifusKmhx/T?=
 =?us-ascii?Q?VCx/uLS4m5NOV05m87yjxJS+QmjpwJd3YQoKC2oWMtyKtP7YodPGp8XycCvI?=
 =?us-ascii?Q?Qtuppfnmbto2h4JC36M9QoXJu7qBjoGEJs128TYsD4QLDqLhHtB1nRGA96/o?=
 =?us-ascii?Q?4A0Wv1OOvYzt88DuLmWUYRNmbG8HwQVc6UntvR0YUvc0jWj6XwFmfK7c0pKo?=
 =?us-ascii?Q?GESKvDNAYZaXBX36rssa0CPkqWmhrbI43VtPAQA8SZVheiojk5bwUMW+EqN0?=
 =?us-ascii?Q?aToXgY7bFC1a3HNd4M/Zg3BNuS1QxaiugXQxVhqs26lZVin2ioCc53ybljSe?=
 =?us-ascii?Q?wJTjXa7LrXHNRpQrsQlNsf5fHsSv6yOWmRQSUL/Lkm4xAHLVuZIZIKk92ZRe?=
 =?us-ascii?Q?28k2LUsMIPLJiX+A8ZVHlYQrc2C1ylMZBexuQGfIyTtBa0vKRAP9UH8iAukp?=
 =?us-ascii?Q?cQ05ljsRwYRDrBnjxRcS53+kjEeJSBbLwjtsGmeEzD13gcD4Np2vIpBGIZBN?=
 =?us-ascii?Q?Tu5WV/AFvEgSePP/X4ST9nqBA8UGp0nVDgBeTpYtk1umLkvPzOAqYY4ECpvJ?=
 =?us-ascii?Q?/YP1IpjvgcctkD5YOym2G2CvJSAzmKYK7K75/1c5J6gub8ZnT9BmCGXUBWGW?=
 =?us-ascii?Q?vC+m/lVeTD9/8SwwbnPpaaxyJSCwFvHFNHvKs7vVqARwDkTTZUJ5/F1KQLXl?=
 =?us-ascii?Q?RCRlzOE+8g3nythGqd2K0QF/skWhG1h5KqZzb6rUrL5vlWnsC/wAuNb7cdQb?=
 =?us-ascii?Q?JfOMAoTrqMoMlHKxTuJhGBYxlxWI19IJLkKmtIDqK5wGCtJ0sq+7wHVLYUNT?=
 =?us-ascii?Q?/yU95946bsF0eptiAxVucpJY5BvZ+9gnwCaQIdS1aINcHk0sEgsb3kcPP7OU?=
 =?us-ascii?Q?/lmMB6ZLU4yH2bd8BXh4OKcfwCN7wq3HE8q5w+3P50TpY+mTUOZyS0WKlDEi?=
 =?us-ascii?Q?046FyttqKubi8tBped6SUF9SmTXyWrJ3VnoSWA31lGgsA/TvOdUV7ZTVs2ut?=
 =?us-ascii?Q?NQeGl2cPNv5tPuX/MTileE+kYsLzGZZvY6PN9Hu+tmRNbfeI3H56g5BckHZI?=
 =?us-ascii?Q?lGnKlVrHUK5TfyourHIuswBWao1Hy4vByU630wMrL3gqQDDHNULsBQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iIqU/KzzCSMVg8yhswlw8MJFLenTfEsNpDByBSVvXmWXODv9/RBM+WH4lpYC?=
 =?us-ascii?Q?msa2FvyB8xwEEwf55SpY2ppdAKqgRDYDn5t9H4Iy8XEAu2TiVGsgDzDczI/P?=
 =?us-ascii?Q?9hQxozFmRYeSzsT8j8iY8z5B0J5nSI6feZVw5Tt6x21JEXs5M2NtdQcAfxdB?=
 =?us-ascii?Q?Mbb24NHMSh7jA+zoOjjVi/+uv9F8Fj4UAu0cNHNYdkRxpoz1dOI2etpkUtsU?=
 =?us-ascii?Q?9UHCFMyChLjognyi2WZU8VSGOMDpNI2sZ1UF5vzYfMYTDAqac3mCbQqiQphi?=
 =?us-ascii?Q?NkO1TajPKyxspGPOzOjdRnghC6knpl5fiZzqDHgZBaDlFff+5eowsVt4yVB8?=
 =?us-ascii?Q?G7u/GnqdEatf1J/jGlUj15Zu+aer2fU2ol4MvQrkvmZ4r90/p8ZUQt4XAmrJ?=
 =?us-ascii?Q?J0zDdW6Ir0mL439GCWgoUocubTI03wUk5ZYZL8r2UsO244xrc67sioH73wVx?=
 =?us-ascii?Q?/rvMhy/YnORRlMK5xwtZMnMuCZAi58CSOV8nKmVRGSBUbo2ZtU6pNxlmJNgT?=
 =?us-ascii?Q?R9sMjk6AnfbmaltLYzCQKGfaILXNPqDFPzJ1eZDfmAHAhH/geRyVkdTsQJ78?=
 =?us-ascii?Q?Gd+3UJDW6AxX/4NfRDpsW6KkNpfHdBIIISQScZ0/69xXKJqgx2S9Gob1FydM?=
 =?us-ascii?Q?v55EqFeM+kG9EffGOCuQVPxUyFd217HIDSOiqAY2d/Y915pWpSEhPY3XaV1F?=
 =?us-ascii?Q?9g7HdSJRhqjELzhSDqcwEu1pxmkK1zhRMVTc+ILLG6tzpC2gUCMutnxc3yDA?=
 =?us-ascii?Q?uyeFxxzc0Ub4MxGJmYWE7w2Q3Spg+2SqeDzPq3bhaCcN2cAxpCTzC0bcBaQy?=
 =?us-ascii?Q?Et5e/A+0JE0zY5zey8FNwYMOOkEkAe3S7jItOXAxplxS10ZoLfxmWSdSc53q?=
 =?us-ascii?Q?MgI9Cz3xmktLuvqSFqCFZ77Yz0A0ztcrP11FQm6Sxs4fBIhRSjZCIHzMN0Tx?=
 =?us-ascii?Q?BCdTl2MiG95cndyeOZQ9JY7ggHU1RL82OhfcqY0p0Kjb/xUBvI+h9q1AVXse?=
 =?us-ascii?Q?4kgRHKSLHSTN0K7E1tt6d98og4HM/q9dS/2LljD4EKqRMZ8SRccZZplwVkeJ?=
 =?us-ascii?Q?LM8Yala4P7jtBlgPP3MOC/Z6bBLTfj8mAkB7mmWIine0AgLebi5ErGfddNqO?=
 =?us-ascii?Q?B5eZIGWeRCsqD7rEVNnmh7VF8kxlLzGBP4KlxowdMCYDFjTKLwUpf6ZE42vc?=
 =?us-ascii?Q?a2Zsgu4ezfvrifzJIT8gbeAaxjAEC2w1L0prcaanez5RevoEJSBbH9LUW+Lj?=
 =?us-ascii?Q?oEY2g6mwfnYAAwxdvzZm7bdh4wQyI56lKSqL7dvVwKEBcyhHDAsR8BaigrCt?=
 =?us-ascii?Q?cn1or5fEUBY68HpQxw5gthJCfrJBjI/S9/bYS/57h0kghKl13luoTVluQEV0?=
 =?us-ascii?Q?j7EjzS4r9Jd0JwRvsQ3ZgDPI8vsfWFgYOGa8351AV8/E4c9z2T6oUWKxNC9k?=
 =?us-ascii?Q?e1o04HTeU6k8KEyzJIUbnvLRmUK168ULT1MKJhEgufhnAucVk5MTAa873/Vh?=
 =?us-ascii?Q?3+Vrx+NbjeyhA0A0nGNucDJBar+nZRu6uYdjjlQfAJGCUkJU+Y09DXT0aLPh?=
 =?us-ascii?Q?Fea2bD7wnv6zMDM1GmM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bd713c-4b04-498c-bc2f-08ddb451b81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 01:35:23.0759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LisbQsub48KpsKJjbmSiXgfVJWbMRQwjziDvk2eLPOn7/JtofEzo6kZ4Edemr15
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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
> Sent: Wednesday, June 25, 2025 6:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Johl Brown <johlbrown@gmail.com>
> Subject: [PATCH] drm/amdkfd: add hqd_sdma_get_doorbell callbacks for gfx7=
/8
>
> These were missed when support was added for other generations.
> The callbacks are called unconditionally so we need to make
> sure all generations have them.
>
> Fixes: bac38ca8c475 ("drm/amdkfd: implement per queue sdma reset for gfx
> 9.4+")
> Cc: Jonathan Kim <jonathan.kim@amd.com>
> Reported-by: Johl Brown <johlbrown@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index ca4a6b82817f5..df77558e03ef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -561,6 +561,13 @@ static uint32_t read_vmid_from_vmfault_reg(struct
> amdgpu_device *adev)
>       return REG_GET_FIELD(status,
> VM_CONTEXT1_PROTECTION_FAULT_STATUS, VMID);
>  }
>
> +static uint32_t kgd_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
> +                                       int engine, int queue)
> +
> +{
> +     return 0;
> +}
> +
>  const struct kfd2kgd_calls gfx_v7_kfd2kgd =3D {
>       .program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>       .set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
> @@ -578,4 +585,5 @@ const struct kfd2kgd_calls gfx_v7_kfd2kgd =3D {
>       .set_scratch_backing_va =3D set_scratch_backing_va,
>       .set_vm_context_page_table_base =3D set_vm_context_page_table_base,
>       .read_vmid_from_vmfault_reg =3D read_vmid_from_vmfault_reg,
> +     .hqd_sdma_get_doorbell =3D kgd_hqd_sdma_get_doorbell,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index 0f3e2944edd7e..e68c0fa8d7513 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -582,6 +582,13 @@ static void set_vm_context_page_table_base(struct
> amdgpu_device *adev,
>                       lower_32_bits(page_table_base));
>  }
>
> +static uint32_t kgd_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
> +                                       int engine, int queue)
> +
> +{
> +     return 0;
> +}
> +
>  const struct kfd2kgd_calls gfx_v8_kfd2kgd =3D {
>       .program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>       .set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
> @@ -599,4 +606,5 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd =3D {
>                       get_atc_vmid_pasid_mapping_info,
>       .set_scratch_backing_va =3D set_scratch_backing_va,
>       .set_vm_context_page_table_base =3D set_vm_context_page_table_base,
> +     .hqd_sdma_get_doorbell =3D kgd_hqd_sdma_get_doorbell,
>  };
> --
> 2.50.0

