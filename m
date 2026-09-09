Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C37C79FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 17:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8BF410F1F8;
	Wed,  9 Sep 2026 17:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gsDXIWQr";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5177610F1F8
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 17:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGg2zWpkjoTXiOO+Ay/BmqigxQIj3WQZf46EPhxVjZZds6J4V/BiCDC0+GWOGfENJOSQpoqwpuhGpOcxTVR3iIyGGZxwXtrEYuxtBMdInZth5gCLjspZ9EkfLHxfJc8rFYLYxb1xkEfvlAdnFSo02tuMOoPY7LoGMOiHPTQW6vHKzf+KYUfq3E7rbRjM4suLFZdEoYnHS4lpzJJIpGb/6bQM0+JFHF8bdVSfA1OOE6tyFh3O7VMEUa/LRLOQaqhcSVhiqV9IVPzMfkxqxJ5kth22/X/nf9JMS3fNUaVfmEV8ho3l7Cci4BPG0i1iq1YAi5kM4p89neaEtM5sjMXv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kauDvDbTZrbw9ee8NNHUcV5kRh3DY85BHZzGBpfP3zM=;
 b=X4w2Pr0EhqIvq179fwXYPFSC1/sq8aVJzIZZ+RgwXcF3n18B09htVzgwxCD9FlbdTRtBm9iH52OjE0mZp2NzwHQScjQC3iHjGzhp1Aw0m8xpBdznIuBs2QtFYhCvfeeSSRmTKuYhHzYnDl8yF5bWOj+uQD8eYnKm/9DTAW4TiSMTuaFYj6iv8zDZdy+zSq/pGVGaym6EuzQWC3S4vXUy4jrP9PesTVb1Z5ssDECXr5GbpfO/hgf8izuiNHhYyFgi1ZOg3Gg4WHSyryZ/7DUvQsVtWadW6omvnhcyqLdlDZGUY9sbUXbSjoeKV8OINRorwdU+CYzbAJMmDRWldgrTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kauDvDbTZrbw9ee8NNHUcV5kRh3DY85BHZzGBpfP3zM=;
 b=gsDXIWQrsRTqtn05rsPrlQRHPA/RtSyDOYwmEENesZXgMXb9JYrTntXMqyAj6Pb6sFYprBq16bnMAPHYZ9lq+Bzaoe1rr4y0IzKI3ZcYjgTFSfYtYaQ0N5SMeQ9NulzjIGQRE24fmNCRvfiOb79hjfYH/kiP/3d9dSykovQhu9s=
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by DS6PR12MB967764.namprd12.prod.outlook.com
 (2603:10b6:8:4fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 17:13:43 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0382.014; Wed, 9 Sep 2026
 17:13:43 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
Thread-Topic: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
Thread-Index: AQHdQDATaULcXYgWTUyb69+6BzOgBrbGe1Bg
Date: Wed, 9 Sep 2026 17:13:43 +0000
Message-ID: <PHXPR12MB999256240CD7E1B296F833E70AEEB02@PHXPR12MB999256.namprd12.prod.outlook.com>
References: <20260909075121.598208-1-lijo.lazar@amd.com>
In-Reply-To: <20260909075121.598208-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-09T17:08:33.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999256:EE_|DS6PR12MB967764:EE_
x-ms-office365-filtering-correlation-id: 542a85a9-19d4-4afe-9b8e-08df0e95b360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: HycjVplod8XbuskUEJ7ldoAqNnovtUNS3VmXjByN8XK6KAiAG/Nnh39Xf3r9HDAamG7l6u9tu7saV5VZgrZXAryjD/S2glXIf8QyHUgVUex+jBZghx5O6Jyr83HfFNlDzn8LomFNOUSzLnC/CndeUYZNgPlRAN47IkefkN5HBGj9iEretA/wn3AK3xiTy0oxUNytWeizDlKTZxs0B5cG7N5IlDLjgIe+GxE8CpE33ChJ45eTsd9sdlpDRvLc3VYRVtC41pb22jhdxPpO2b9DicCY/SJ2YA9m50OpP8EZ6xalsYYQywNUOYh6IixJzaIHNfLjek6azl9opc/Jh/2ezfNQNkpqq/KA2GbcFZ+znSvMtBmei96vQLTsZZjIrwZO1rr1ws7e7uX5laXh/Ydf6rNrAMJ6XFk92AmbpQej9bE6c48MS+alfCa+uqigbnZjFmYJiZpg03lI7sVjet4h0mrNJhuWNTdCyZiRjB1vXP33li4hHZv6m6x7ndlJzneu4tn6X0KBnyO2u665zZUsnYUiscPc75cM/BqpEPX3rzdujEuemeXCPGkQOO17vAv4dn14/R069AvYKBN2GXsu74Yu0vT7nqJJe62ml5g1kYdOYBp/IqdD41AiFXOjMdVA6BJBEzyqqPYI1XhIskc7MN9Wiu9Dt2lG8wF1VkK44uOv6IkBGrhEeQ269Uuz3DHIh3TlenjzQlwBxGvg6fOZQRW9mOR/qI0HznFdd3rXvZM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lo1vOfaux+0fmLtn+mWrg5+MWI9+SsC83xbh9Np5GAWHL83hRljbCy1pMszj?=
 =?us-ascii?Q?9U935CGaIjjSOa7v3a9zEAcw0CNkXat6Ty2jWmf4p5NM3wUvJhNPilG35twS?=
 =?us-ascii?Q?PkwfoZN1oNQLej/Q2pYReA397v9bWh7MANcufTGRASNj0rmM21m4K9P0OUZP?=
 =?us-ascii?Q?aJnq7/oWKI9FCX6MPJHSphc/5bL/pQWv8tkQkR+EWsmNSMPDueMVdvTRMs8A?=
 =?us-ascii?Q?HNTGb5z8a1olLEPwlBN5YCuLuk6uy6Aru1SUB5YporrSHnmhts+bwyFcDaxZ?=
 =?us-ascii?Q?ZiHNReAYjoiM3Sky6/RJBz4udF32rMLXPFxl37FTFkNvH+XOpIzMq8tXT/0U?=
 =?us-ascii?Q?TsQ2O1N90dGDwRVLlVCMj2lV5XmJLESmU1L6Y53AXZ9J6I/5KNT2XkivN2um?=
 =?us-ascii?Q?T88T8lc5H4scrkG2boEHMrfzzfR0Im6x+1taPkGLIDsJzraq0kwZR/DtpRg8?=
 =?us-ascii?Q?8Jvn4hJh9qqXh9F9mJo+lkFz1qQu2UAVH7su4rGTYLbvUX/y086Dg4LEkAeL?=
 =?us-ascii?Q?WOldYwWki5kFtOlJFB3Qx/kx+cabAyrOcvePJWTMyPvoDEK+GQX5jkMFdwzP?=
 =?us-ascii?Q?xyGsDmdwslbKjhLH85SWzV5ljmlVNI7R0N77ADm93E8cnAmbwHhddukkhSO8?=
 =?us-ascii?Q?UWLQxuZhFTQuhcMu+WW/W0Q/hkagOR8w8O3yRWUElDwjYGdMadoYHV1Ti0PR?=
 =?us-ascii?Q?d/lxSglAg+pABs0mJw1u4Lltmic2ENOpRYCajnc4gyRP/mXvVMm6oSDOEhtO?=
 =?us-ascii?Q?dLWdlJDOdnWhhUmZ5rKZODPOPJb05upO4mDTB0cW4xkdhmrwwa726/QJaJJm?=
 =?us-ascii?Q?px3sAE1xGS/TPc8/qaRzuzgUekfoyPmNSZe2QR+V/OC+uU4DV4lmz0xvs6NK?=
 =?us-ascii?Q?v+zV/CNI41/KomHAUFt2vUqY0Yfu9rZse5kMLHLEZCiKLfRgDNz4nSmG9MFP?=
 =?us-ascii?Q?GpxQoiYB9PpoqKV7sFcUkEmWJgry5GxKuE4MIj5pKdlLEGmUYflIHM1K+WpI?=
 =?us-ascii?Q?7//+icOVTxsJg6q6BxMIrVYH3HGUD7Tnrk9taex8N8INBWQQ6CT5HPBgoUC5?=
 =?us-ascii?Q?sTcUsulRptHQs4MBqriFy8ZWr4qnYciejjEb2YFQbml9uDICB/5F0ATx1ES6?=
 =?us-ascii?Q?vN5aJK2Hd44hvtAnidbk0+th3WKeG5lI2ghkEzjqLG0m6naoyUM/diua5jFe?=
 =?us-ascii?Q?dbsz1Mqj7RLrqN1umGum0J2xtg56HfQLogiDDw/PnCHjoSo68Y5BfzCSXce5?=
 =?us-ascii?Q?lAKjkqCUB3BsAaHCdIc+onzFBHYADmyehPyE1a84MpcOuk0O5NuJt6uUkg2L?=
 =?us-ascii?Q?ruhgon9LzK9Qk1fm9kOLbVSM20rWO+KwSZIZITuE3f4w2czBFWBsJlQzwZQ3?=
 =?us-ascii?Q?0e+5Ag48YVfuaXQxW8hw5+g9n+PRb3S/DHug2xtFRJZBFrTXk9doQP1IRCfd?=
 =?us-ascii?Q?MWVLZL/j9O3P9fm4PGYUVeSk6RrnYb48WTjZ/8+wbgQFzP3oSsWsueSU1RJP?=
 =?us-ascii?Q?3dIT+xtEldc2tcNevzs64uFC/VDhLn6kDwvy/ZE8nHzqHomAQJ6FOEPFJqk0?=
 =?us-ascii?Q?BjE+x67F9dDfECzXxzNgHEvQwhrIwaHanZVNekN+WOqc5+Y25/EbUN/tfC2C?=
 =?us-ascii?Q?a67l0UUgYYsDCqyoxx+u1m0Vd3kBMyqpr/KYBZe6C8b0vFcdyc/OoJNZ90O8?=
 =?us-ascii?Q?anWYiyEFqJqdMrtcrrQgvOfXfGnQS/UE99WSjw1h0w/JlO/K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542a85a9-19d4-4afe-9b8e-08df0e95b360
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 17:13:43.1703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eC+TGINfYSKY4tq/qn7pBdbvaGbg5g3vlm8ARuv1LxLbK1L3vyCoc6RFcrf+UWrl9SlsjAPadw5gDPsvGEppQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB967764
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

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, September 9, 2026 3:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Joshi, Mukul <Mukul.Joshi@amd.com>; Liu, Xiang(Dean)
> <Xiang.Liu@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
>
> The compute partition switch locked the kfd device, freed it during the p=
re-
> switch teardown, and then unlocked at the end - by which point
> adev->kfd.dev referenced the newly reinitialized device, so the unlock
> landed on the wrong object and the per-device lock was never balanced.
>
> Add a dedicated prepare function to unwind and clean up kfd device.
> Don't use the global lock during teardown. A new device is created after
> partition switch; hence there is no need to do 'unlock' on a different ob=
ject
> after the switch.
>
> User is not supposed to run any process on the device during partition
> switch. Keep acquire/release semantics for init_complete so that the devi=
ce
> remains unavailable for a process till its reinitialization is complete.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   | 19
> +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h   |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c      |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c   | 11 +----------
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c        | 11 +----------
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c      | 10 ++++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c |  6 ++++++
>  7 files changed, 45 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 09feb45584ba..a2a368f1e290 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -245,6 +245,25 @@ void amdgpu_amdkfd_device_fini_sw(struct
> amdgpu_device *adev)
>       }
>  }
>
> +int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device
> *adev)
> +{
> +     struct kfd_dev *kfd =3D adev->kfd.dev;
> +     int r;
> +
> +     if (!kfd)
> +             return 0;
> +     r =3D kgd2kfd_check_and_lock_kfd(kfd);
> +     if (r)
> +             return r;
> +
> +     adev->kfd.init_complete =3D false;
> +     kgd2kfd_device_fini(kfd);
> +     adev->kfd.dev =3D NULL;
> +     amdgpu_amdkfd_total_mem_size -=3D adev->gmc.real_vram_size;
> +
> +     return 0;
> +}
> +
>  void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>               const void *ih_ring_entry)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 1b7dc0d3963b..36e222f3ac5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -170,6 +170,7 @@ void amdgpu_amdkfd_interrupt(struct
> amdgpu_device *adev,  void amdgpu_amdkfd_device_probe(struct
> amdgpu_device *adev);  void amdgpu_amdkfd_device_init(struct
> amdgpu_device *adev);  void amdgpu_amdkfd_device_fini_sw(struct
> amdgpu_device *adev);
> +int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device
> *adev);
>  int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
> void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);  int
> amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev, @@ -431,6 +432,7
> @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
> bool kgd2kfd_device_init(struct kfd_dev *kfd,
>                        const struct kgd2kfd_shared_resources
> *gpu_resources);  void kgd2kfd_device_exit(struct kfd_dev *kfd);
> +void kgd2kfd_device_fini(struct kfd_dev *kfd);
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc);  int
> kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc);  void
> kgd2kfd_suspend_process(struct kfd_dev *kfd); @@ -485,6 +487,10 @@
> static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)  {  }
>
> +static inline void kgd2kfd_device_fini(struct kfd_dev *kfd) { }
> +

Maybe follow the pattern of having open and close branch on new lines as do=
ne for
the other functions.

>  static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_pro=
c)  {
> } diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index a8c79a66df1d..92fa15ace438 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -694,14 +694,16 @@ void
> amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
>
>  int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr,
> u32 flags)  {
> +     int ret =3D 0;
> +
>       /* TODO:
>        * Stop user queues and threads, and make sure GPU is empty of
> work.
>        */
>
>       if (flags & AMDGPU_XCP_OPS_KFD)
> -             amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
> +             ret =3D amdgpu_amdkfd_prepare_partition_switch(xcp_mgr-
> >adev);
>
> -     return 0;
> +     return ret;
>  }
>
>  int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr,
> u32 flags) diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index cddfe4015f53..699e797679ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -391,15 +391,9 @@ static int
> aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>               !adev->in_suspend)
>               flags |=3D AMDGPU_XCP_OPS_KFD;
>
> -     if (flags & AMDGPU_XCP_OPS_KFD) {
> -             ret =3D amdgpu_amdkfd_check_and_lock_kfd(adev);
> -             if (ret)
> -                     goto out;
> -     }
> -
>       ret =3D amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
>       if (ret)
> -             goto unlock;
> +             goto out;
>
>       num_xcc_per_xcp =3D __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr,
> mode);
>       if (adev->gfx.funcs->switch_partition_mode)
> @@ -413,9 +407,6 @@ static int
> aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>       ret =3D amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
>       if (!ret)
>
>       __aqua_vanjaram_update_available_partition_mode(xcp_mgr);
> -unlock:
> -     if (flags & AMDGPU_XCP_OPS_KFD)
> -             amdgpu_amdkfd_unlock_kfd(adev);
>  out:
>       return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index 757da0a30fdc..28eca48c6596 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -1097,15 +1097,9 @@ static int soc_v1_0_switch_partition_mode(struct
> amdgpu_xcp_mgr *xcp_mgr,
>       if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
>               flags |=3D AMDGPU_XCP_OPS_KFD;
>
> -     if (flags & AMDGPU_XCP_OPS_KFD) {
> -             ret =3D amdgpu_amdkfd_check_and_lock_kfd(adev);
> -             if (ret)
> -                     goto out;
> -     }
> -
>       ret =3D amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
>       if (ret)
> -             goto unlock;
> +             goto out;
>
>       num_xcc_per_xcp =3D __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
>       if (adev->gfx.imu.funcs &&
> @@ -1126,9 +1120,6 @@ static int soc_v1_0_switch_partition_mode(struct
> amdgpu_xcp_mgr *xcp_mgr,
>       ret =3D amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
>       if (!ret)
>               __soc_v1_0_update_available_partition_mode(xcp_mgr);
> -unlock:
> -     if (flags & AMDGPU_XCP_OPS_KFD)
> -             amdgpu_amdkfd_unlock_kfd(adev);
>  out:
>       return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 1c1e7878a2a7..76b308286095 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -952,7 +952,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>
>       svm_range_set_max_pages(kfd->adev);
>
> -     kfd->init_complete =3D true;
> +     /* Release pairs with the acquire in kfd_init_apertures(). */
> +     smp_store_release(&kfd->init_complete, true);
>       dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev-
> >vendor,
>                kfd->adev->pdev->device);
>
> @@ -977,7 +978,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>       return kfd->init_complete;
>  }
>
> -void kgd2kfd_device_exit(struct kfd_dev *kfd)
> +void kgd2kfd_device_fini(struct kfd_dev *kfd)
>  {
>       if (kfd->init_complete) {
>               /* Cleanup KFD nodes */
> @@ -991,6 +992,11 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>       }
>
>       kfree(kfd);
> +}
> +
> +void kgd2kfd_device_exit(struct kfd_dev *kfd) {

Open brace should be on the next line.
Maybe run it through checkpatch once if not already done.

> +     kgd2kfd_device_fini(kfd);
>
>       /* after remove a kfd device unlock kfd driver */
>       kgd2kfd_unlock_kfd(NULL);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 04c5e26f01ed..da61d939b35c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -396,6 +396,12 @@ int kfd_init_apertures(struct kfd_process *process)
>                       continue;
>               }
>
> +             /* acquire pairs with the release in kgd2kfd_device_init() =
*/
> +             if (!smp_load_acquire(&dev->kfd->init_complete)) {

Do we need similar smp_load_acquire() at other call sites of this kfd->init=
_complete?

With the minor nit-picks above fixed, this series is:
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> +                     id++;
> +                     continue;
> +             }
> +
>               pdd =3D kfd_create_process_device_data(dev, process);
>               if (!pdd) {
>                       dev_err(dev->adev->dev,
> --
> 2.49.0

