Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303AAC282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 13:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF33A10E463;
	Mon, 10 Mar 2025 13:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tay1jwIL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D4410E463
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 13:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QskV9rIXZkKhR+/iXe4mK7atbrG46iesbevHc83vhibDH/82yy9pIjlL/W+TYJ3GP7IQCrBM8I0oAduwI+pU8/Ils+gJWllr3oEuDy+5YgEB6srYjVp1riVkNeUPhRce1h9whAV1cb5k0ozhI3VpKHxvusw+jVo8j060+gC3boYqqfruukM6YN/Ef15eVL6FvKtUJr1L5rFvyLTQZ/76Id6td588EsS36eHPHRWlg7B0G6Y8NdBGHcfhv4KvBp8SPrDM8LfuLm605pCyWP3RRrqd4hhAcXiAO8ZQFDDBlGRTrObQ7LZulBpZkqfXY62zZpNpvBP9sOZdYmjZ8YBRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU6oaUtg2sG8PBlPO72tXRDG9d5TRG16c3KACtUhUvw=;
 b=Ty0VY10l2tC6rFTPYgbbV6JbagGr4G19hfCaxAWbB6eFOoR50g8a70BeVLRgjaN1VRYzQUvbjr+CY8QWvKK27rAsjIJ14JCyhHUO+axxIVsm6jfZ0Z+oVYGQEQyNZroMItaYKotghKLAH1P+t6Hq4RqeWIcNwtIFnhAw8XsUq08VQg+eGIJNrO3mXkXUd2Q6eqahN0reXP7hUYmEFB08iqXQ+LWLLNr2xIEUk2ETktBcSai1XSGxF9OgvZ3EesbjTc2gWCR/5h9TzcnpSZSAiA8RDkqlaMGaQHV3cs1sHzKVPqDY5NyvcfA+WZCwtmUcpkm26/I26YLpzOCnrrGcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU6oaUtg2sG8PBlPO72tXRDG9d5TRG16c3KACtUhUvw=;
 b=Tay1jwILuM8t3ZIFUEbB20+BIDgm9aLwJRmXzXobiatqF2YM5oPuZSITqUQZPBbijG7rcIo0GtUyE1TJdfRpH6L8tjJRhCtyWrXhrKuWDkvlbxJ7armDZtBv9UcadHWdPhr2r+AMKy9t7jc8EFSO1YLotWCMUn6RlYNwPvzWG/Y=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 13:30:31 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 13:30:31 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
Thread-Topic: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
Thread-Index: AQHbj3PwRxTTkjsXp0SE4kE1o4M7drNsYi/g
Date: Mon, 10 Mar 2025 13:30:31 +0000
Message-ID: <DS7PR12MB6005D459ADE1CAD284DCF2FBFBD62@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
 <20250307151605.946109-2-alexander.deucher@amd.com>
In-Reply-To: <20250307151605.946109-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=0c1864a3-f671-491c-9692-3f283676c0cc;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-10T13:30:24Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA3PR12MB7879:EE_
x-ms-office365-filtering-correlation-id: a5cf1438-7f1e-4fdb-65f3-08dd5fd7babc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ivhoXxBdY0TdNgJ+RCtRq/Fu3z0Qm/Ssd7tshjiiibkNlraBIMCgJykaMqru?=
 =?us-ascii?Q?dvT1gIOsCm0ydo6+UeO2FcmedgOebhIApx9uBAAYF/XCju4B8px6zXAawh6I?=
 =?us-ascii?Q?SHmJjsGBxoBbC/xlbB9aGmuNdHXTVcvx8f5wejAGWcUQQ4hfxLF7XHGZnUNu?=
 =?us-ascii?Q?WPr7IffDXZ7CGa2nZ4g5zlzDXdOM56eoZbJpioI0fj7RgI79J89KAeWXoT0t?=
 =?us-ascii?Q?Av90uT/tuszVjHyvv85ynpaZ9sFv6kd5cko0/5Mx0T2Pg4eyCqfs1amZxHVo?=
 =?us-ascii?Q?loHh14Cx5cIoV16IJNN7goKrrFk/GGYKzi7Zbv1wp5XXiFoXLEM6P7e9cU/o?=
 =?us-ascii?Q?jCpT5OyA4N1joYO7nJaig9FYxqCNMeWqKZQgDcQVGXWV202IuZ7zG0Y0wOWg?=
 =?us-ascii?Q?7HI4VLW6Vv0KhquUcpJs/uoOJOjwj1f84jmfTG/GHAa3ZSvKjuVpEOg8s9rf?=
 =?us-ascii?Q?wQ5IHMndjvxm8wavc6Jr0tPKRQtMBVgzFh7mQ1UTsvPigRwCnEPPBA93R5GZ?=
 =?us-ascii?Q?fPZTG68bZuIcHLB2hXbLfPtCcTGPBGwcY6aLyW0Nq30vtXo5+lPpGtdD4ayh?=
 =?us-ascii?Q?GOD1gc/g1X6I09yX49PFmcVQV3crppM+Uke6nT9NXdfVeykyIYGuWRedlQMb?=
 =?us-ascii?Q?2WT7S7v8lI/8ktvojuzPbRnbvhe5BDSE7FqoLqX9lXuPLOGPIqLniXMeVC9Y?=
 =?us-ascii?Q?Im0N6LMXvm0byuj3xg/4mRr27XbhEUq1WDsLHUF4D1XwC52RHeBJ2uHidJCK?=
 =?us-ascii?Q?bLdPlRgXl/8l6u4iawN6KmWtXldRBKhM2n1MDX28P3+2A1l+mZ6nyLzlsrpF?=
 =?us-ascii?Q?xB2RePJeAAMSnQrDqmcZKOguw7d2kFma51eUuO3QLANJEe8ETEAOSeYl5cz3?=
 =?us-ascii?Q?tkVr+zwwjejAJ42XI0kbgUwcCo0m5JkmoCVeiJ+HVT1l4WxX3hKJabhRuXDK?=
 =?us-ascii?Q?16Vv4pSL3tfEJt31IN8TuYvOTE1p/ML6FXONF2PYlmza8Com86je2xW1tmN6?=
 =?us-ascii?Q?KGB7ox7Ywll4VVixQaEAuiULUOkaJr9aqpiKEItKBqZHsUPLJ/YgbHxMj3nV?=
 =?us-ascii?Q?gxRGQpSvKZXXV5oWpV73Qs15R6BAkYf1XfzRHNjeFuX8bkjD3kig0YJiDZsN?=
 =?us-ascii?Q?ZAE/MV3Uj79Y/z0PYN3nO01hM+OKYIe42UyXQw+fYGCkJctX0v9+rIbyTV7N?=
 =?us-ascii?Q?4lgJuFdC4h7x3ijrgAccEmRwg89zCSXsLdtSr8YI6KnCHpF7dciJGLbNE+2S?=
 =?us-ascii?Q?/PoaoJwWTrslnrMMzvOXkp6qpFbcI0+iZuPwmiVeaK0VR3tTA0UGqbe7zD66?=
 =?us-ascii?Q?oBXy2vkMVLbWQefYf9fTvvK4wOcxK5SsRgkQzoi3NqOmSVm7lcZoCj+LrR43?=
 =?us-ascii?Q?kKeKcsHK7R6SIITojDXy/SL3jxnFpDe3qYGeMiVwpwjX5Y10TKh//PA03VfN?=
 =?us-ascii?Q?63eSB/5ZzO92sn7K89gRMm7MNXYfFy+H?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?21Q0vLhyh+UpCELhyKMEx0nkGi9miyt4jP3k/FtrwNJ1TvuQ4cqWUJQGdzYp?=
 =?us-ascii?Q?USqNcIyE2Uzx7uyUDn7/JD/UW67KR1eJSygIQEHzQe9JDdxF9due5op3uxG3?=
 =?us-ascii?Q?OOUIKsRNMX5gUBaDTMuHFaUPvUiwapWXu6DJv7pVym9uFR4DGE3I69LzmR4y?=
 =?us-ascii?Q?Bolj6S7WUknCiheuJvbMWooxRmyt1m9HA0j2DY0qom8M6QAouYlgSSLE23Nm?=
 =?us-ascii?Q?zWQHUfX5TEZppatnozNLhd0fQCTanN8fM0VrkP9BaNKXZn8LZ6NKchEo84lI?=
 =?us-ascii?Q?knzLP2eBvPeQ4MP7wvzutQhSNB/cG189VEMJZ52o+XmWT70y9hZNGIq0ms5v?=
 =?us-ascii?Q?ruH45+IIAzFWx1QAkR3oIJJwLAHKA9f0cL3vHE2egnUCFTyDoAijM34f3CDu?=
 =?us-ascii?Q?bXVK2mCLPRBb6v/ASvt8wcudUXh12FkK8CjOnqmJRyaCnt4Ahq16Oy9lhCpz?=
 =?us-ascii?Q?ZCZbXSF46krJII2uPwYKemoNU4Md+imQTMv86zTizMTmTF0KeImM5Y2UzOkJ?=
 =?us-ascii?Q?hFrZUDEjoEbeucteCe+ysO75KM6/nML0Vg+Q5lCfVf1QpJ2fHv6gaTXm2U6x?=
 =?us-ascii?Q?vfBGqg7Is/so7OfPfgezJZOWb7ADsnsbVtdE9AgHwmArL3HejpUk4ivlOJiK?=
 =?us-ascii?Q?xZJz1HAmFunMIhPIrALjEkNOpUvzTxjZzxSVqDLP9xZx63rHI5sQk9aNdXN0?=
 =?us-ascii?Q?b2BRzTd3JucRLNQb1cVSF/ckiW1E4IL3CR+bDmiEU8vrBKPcFapA/w+hLLVi?=
 =?us-ascii?Q?FqU0gWnAe9r+vwY+ieJvZvaIgezi5P95nDTpNGnKneuxKus8exvCG1VsONbC?=
 =?us-ascii?Q?2KXUCl+cOY4w4515sRqAc4VdEbmxWMCbGF6beLTtXyMVxNHMrEhpuJh2Uv2m?=
 =?us-ascii?Q?0nmQrifeOE3J6v427K9S7uF+TDhitxXSygTAPqA4IV08x90DRnteJ462YIgb?=
 =?us-ascii?Q?xgr8BHU3so1lqJi8ryeywalh7Hkw6HIOOWCSD2C6+fHtiokEqlelHawlJ70W?=
 =?us-ascii?Q?H62FmqR9AHgOFCBUm/BoFxP9BNP75LkfQ66Cc2p30Xw76HxUkS7SkH0ShTK6?=
 =?us-ascii?Q?VxVLwXh5Z01vkyNBQmRvQhM0tSD8z8ffOioykx+QK87Fx6ZG1R/qasUuheIn?=
 =?us-ascii?Q?eZCBXyJoW7HD+/TnKcG5IfW5iN6povo/O9pMQ7a4HV9BcuOD11dz/GC5zyEu?=
 =?us-ascii?Q?7X+tI+PYiW6FAub7EDPRKnsEs0VlQIjjvVkHb/sY9C9vnpZdSplHBEAIj2ux?=
 =?us-ascii?Q?jNZ9864PPv0A5oPHkOmg8qomeczZ5Df5D4z/deV7y/1vooZuafOp8Z6kdLww?=
 =?us-ascii?Q?1eE7Kpmo4pTH0eAd78w18RLCgt4aR3Dm41otdT6s1/838W47K4tReDpWNGxc?=
 =?us-ascii?Q?uv8DEikQaSrPGOOwABXx9T+467/yBbZvJ9pb+ZLCa8RxFN3Gj4vHTkM9PR2r?=
 =?us-ascii?Q?KCw09FUT6F1fZO0JCzmeKkl5OTPXzjRozX171SPBZAj7bR4NxpAM6kW4ma+c?=
 =?us-ascii?Q?JIz8S2ZFVqpMDEYUtwoN67RfXdMTBoHQqgUMIb5d04qe7ewi/yQhVEQR9qxC?=
 =?us-ascii?Q?OkIM79l03oLHZqYUP7s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cf1438-7f1e-4fdb-65f3-08dd5fd7babc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 13:30:31.1522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XtntoKZhfP8MY7D9T/GP/iCrs5lfVK7PzzeQh6hrOP179hZ3PvB780MjUN8HAdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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
> Sent: Friday, March 7, 2025 11:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>
> Subject: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
>
> On chips that support user queues, setting this option will disable kerne=
l queues to
> be used to validate user queues without kernel queues.
>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 87062c1adcdf7..45437a8f29d3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -270,6 +270,7 @@ extern int amdgpu_user_partt_mode;  extern int
> amdgpu_agp;
>
>  extern int amdgpu_wbrf;
> +extern int amdgpu_disable_kq;
>
>  #define AMDGPU_VM_MAX_NUM_CTX                        4096
>  #define AMDGPU_SG_THRESHOLD                  (256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b161daa900198..42a7619592ab9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -237,6 +237,7 @@ int amdgpu_agp =3D -1; /* auto */  int amdgpu_wbrf =
=3D -1;
> int amdgpu_damage_clips =3D -1; /* auto */  int amdgpu_umsch_mm_fwlog;
> +int amdgpu_disable_kq =3D -1;
>
>  DECLARE_DYNDBG_CLASSMAP(drm_debug_classes,
> DD_CLASS_TYPE_DISJOINT_BITS, 0,
>                       "DRM_UT_CORE",
> @@ -1083,6 +1084,14 @@ MODULE_PARM_DESC(wbrf,
>       "Enable Wifi RFI interference mitigation (0 =3D disabled, 1 =3D ena=
bled, -1 =3D
> auto(default)");  module_param_named(wbrf, amdgpu_wbrf, int, 0444);
>
> +/**
> + * DOC: disable_kq (int)
> + * Disable kernel queues on systems that support user queues.
> + * (0 =3D kernel queues enabled, 1 =3D kernel queues disabled, -1 =3D au=
to
> +(default setting))  */ MODULE_PARM_DESC(disable_kq, "Disable kernel
> +queues (-1 =3D auto (default), 0 =3D enable KQ, 1 =3D disable KQ)");
> +module_param_named(disable_kq, amdgpu_disable_kq, int, 0444);
> +
>  /* These devices are not supported by amdgpu.
>   * They are supported by the mach64, r128, radeon drivers
>   */
> --
> 2.48.1

