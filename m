Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28C7C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EDE10EB9A;
	Fri, 18 Apr 2025 14:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1VObbHpK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF2B10EB9A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypniFxjyxFWI7Cgjuv+SiX777XE7z+xx3eaf9/bMLgA1tX4Do8Hy6IVrKH9TMLaaLt5gqeMbv/KNVsWV21ZwHGfnsq/nTh5DvFrLsToCjyBkHPy4HIwJlQfdmvoiQSyKqsqrog9banTJ8anWVhiu6/j1ikyvdTget5hDr1aH2V9ViwOsh4imdvPp5TjMqqsuVHyoG3OR4oPa+ovEhuLN6tll+PsuMkmDFEp34bbgvNwVTBSLug4b8ZrFrZ+K6YAzphKHIid6OGM0UIVJ5kCr0/oHF/FfSl7Y65S6A7jgK1BXKsEdrdxC7aG5tgEZgl3mZuC8CV4XH5mDPpKA22eeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QGqwgrA9MHtq/9owNDjmVyoD5LLJZUjewWPDFsIAn0=;
 b=bb+oRGONyjjBqvNG7CyVguVgpFoXHrSg6l3zdP4Ln8iJKAuPPO4q6LWsNAWwWybdmI8L9Jut2ExYxqY+g95dRN8M+HjFoLU1s1jz9DET9IlpJsKA1CxFRSlFZ8BQlpcay1AputXugPWMTE2Or6KD3gTlres7j5X7qCRPtxkUbuN0lIqZ82gOS9UexFYQof23lVCulQCDUJaPNefHfZuktnDBo9/kfKQ/6TloIBfTeiUXF5pqsgfBYz1QPxaYcpl+yzwk+vL1G60rIBlmqRMevCpTa0gHeYBHbgzOvGYpSAy9ZNTKhvWEgoWDq1Yn1n/i3ieJG7cQ6WAxglt/FwivoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QGqwgrA9MHtq/9owNDjmVyoD5LLJZUjewWPDFsIAn0=;
 b=1VObbHpKQfRLPb41UOz9JS+q13sTR8vfFrU0Q9NfYLbUkFZpzuBEkS4oTuVMYjViRtiY+qZQ2CJpPgcuOW15PeS8shuqpewd3TA0jwKX6scguUXjnxf49KMZQIZTkksE5mLkB8RamGc6RFNU94TZRaThyk45LOnvhgrSpn/vqdc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Fri, 18 Apr 2025 14:18:31 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.024; Fri, 18 Apr 2025
 14:18:31 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 6/7] drm/amdgpu/userq: rename eviction helpers
Thread-Topic: [PATCH 6/7] drm/amdgpu/userq: rename eviction helpers
Thread-Index: AQHbrx3duWj5/kDxbUqFrltcLTvvHrOpeqqQ
Date: Fri, 18 Apr 2025 14:18:31 +0000
Message-ID: <DS7PR12MB60051C3F54127F28A941860EFBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
 <20250416222046.1142257-6-alexander.deucher@amd.com>
In-Reply-To: <20250416222046.1142257-6-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=2188ff16-f734-425c-bac3-c89b78f7f980;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-18T14:16:27Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS0PR12MB6536:EE_
x-ms-office365-filtering-correlation-id: 09cb1156-94a7-46d5-3387-08dd7e83e5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cbp/WNmZyWgiARmBQP6S0/I4eBmA0oePi/TGP2ANjI8R6SVS8UNv7rKY9D86?=
 =?us-ascii?Q?IHx5AF+seMZnnHc4HyxyrFpbiscxZ9wZaqoH1aqGRT2LqGTA/IBPiiaK2pBQ?=
 =?us-ascii?Q?+BfJ99y0BuFknJmHh+XvdLPllNELeSv40Vz8Z3LIzZaJ4mJ7vx7yYjWBv/YW?=
 =?us-ascii?Q?h/C4O1t1bMJpx5qOZYWDbcKFQbLUrIXaarOup74qpLLY3XjQkuSHpzlXth3d?=
 =?us-ascii?Q?fzHBmTkpggiZe/abSBuCJTKeyTKQswpi0VujTPiSVTTWXXLbebwmwQKB3adU?=
 =?us-ascii?Q?s3Rj3dRfNqXarWw4kcrY3I7gZANoMd1DvFwKXHnxDfle5OANmyMvpVfm7aCp?=
 =?us-ascii?Q?Wpf5S4jyOiX+sQwoanGuBxvJ99zTLrwoW10X9p9yU36+yOtPLo1voZN9zV1D?=
 =?us-ascii?Q?pMSKwdTeRplnBPPJWuisu66rr4k/s7gniPO3lzUJGUlmAsp2sBlEgdTzRuC4?=
 =?us-ascii?Q?irR2B/hx6zoHElB3324kh//JdM/5AZrCPErndYwWzcxRwPRaxA1yNJlfxMsc?=
 =?us-ascii?Q?Q1u2XchA4oHqh6w0VGa2T/YWgHWP2K2rNEBfKxhOj2NaknMZLaW7BRQSensa?=
 =?us-ascii?Q?M4bX8vVA2pTCj8gZlkjp667HQtmMmfNT8nWpbJZm21Lm4a+xkm7N+WolhtOz?=
 =?us-ascii?Q?SncR1rMm85W8cjqR3CndVg8nF4341hY6YZdYzMpszGkXlYLBG26w1BJmYf8f?=
 =?us-ascii?Q?1m4bC6c1+4GqrdMIfkKcsE7EGdcKDz3h4e24DcUxVxwDUzNtUhzYRN6FU0VC?=
 =?us-ascii?Q?uHiOi7A5thydbe0AR/kb7wrz/kvyf4VkHMnpUI08D2H18iaL9kL7BVeYcdgp?=
 =?us-ascii?Q?j78Hku5PSEKJ7mZCxW6jvv4xpsvhHuoZzA9glnhtip2lNfz82jA0mdt8aPbY?=
 =?us-ascii?Q?NjJIb6Y1605cDSJ6rpZa+cOWhkHEuXVix+FYXYghqDcSlYH3g3Wyi7yYdJ26?=
 =?us-ascii?Q?9Su+ZCLspGzWGDJqXXAg2QyPUSSimS/x577qZFbt1UPaLQGakWzsBFElG/73?=
 =?us-ascii?Q?63ZE7qT2HFMeADFjpE/+Jb+mm0FOFCPVMSVEjKGhoad/gGXy5Y2EECUHYEm0?=
 =?us-ascii?Q?+Ste5CTxe1Bq9bSUGpWvnITxYV4T9qRIhX20f6yGKqhgfFTnpCJClkMBu2l8?=
 =?us-ascii?Q?lmKXYnYLfmCrHR9xMMvomA0HMx4dwsSx83t/LR2pnkNJCTckknXgsEcGDt+F?=
 =?us-ascii?Q?PZ+VwhrFWRCe3chyFaTx7fi43A9xhlsZmAhrcuJKnswpjMn9tKc/1S/JNuCP?=
 =?us-ascii?Q?AdL4mphJxtNlwg3ey1L/jEb7WpMokpVHZatYNx3MeXnXxQ912PPR9U4STCoe?=
 =?us-ascii?Q?DQX2PoBoT3kjwY9PcaYZbLPx/x4J0iuE5SpZOnDyfmaUEMDlgiMkVTaqifhj?=
 =?us-ascii?Q?4vEuuiPxt/g+EPKrrP1tEnF9Sy43w2Yxqeoip9+o+pGNzuAz/o8Np5K1X3HS?=
 =?us-ascii?Q?oHkiy1VAQx3RKj4rYjltu2NM5vsa1bNa8WT9Qmh/RfUXUxIIqoo9UIPwzPuj?=
 =?us-ascii?Q?SLut4DmgXNHw9s8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M3TpwdXjKUQuArcVilchwmnow2lRvNJnHdab6Tb949X9M393BLKRcwCO5euQ?=
 =?us-ascii?Q?Lz4v1v3TmHPV4pdKXh/chPIGn6o/I3X4x/RM47Yq0KJf/Kwlz3Ul7PdmtgrA?=
 =?us-ascii?Q?oXv/Gbc4IlYd+laCx7+PYgeUT0XH1rlZRXa80M+GStxtQn/LyHSNjbjtDRqG?=
 =?us-ascii?Q?vu38OhlG6OC6NtVGZr/eUH6Cv0icQocXv7BCzJLJ1ylsTxAUvfKPu+9DAjqz?=
 =?us-ascii?Q?qAoFdfVfu6G5Coo8XHRJ6RN26cvIQFhbW18KK0mqMO0NlBSTVrrv9GO3NXN8?=
 =?us-ascii?Q?KvEd4eVhZ4nIKHWn2vcDpKW6f1c1R3rBawWF4bCwMztbf2OVxFMwOyvtFlU8?=
 =?us-ascii?Q?6UlfbEvKiO+X1zv3ZBKpfQdNLLPSl8m7RpmFdkbtS7F/qlJYrBKHxFSIvsAS?=
 =?us-ascii?Q?NodBJLQJco687pKOEOkao5ADgf1lqcmYuReiihN3Gzp2lcHmlvPAPOycHviL?=
 =?us-ascii?Q?/asSTWLzfHiFWfQIeUIiDAJy6KQlNr7fbLsD8ZgOU4jIrV7UCMtJJ2osR01u?=
 =?us-ascii?Q?R9xpwoXHPMmPIvA3I4RRCAFax0WtbNYdgnOjBazEmfiNjlHFcRq9/fH1Al3s?=
 =?us-ascii?Q?vd2zx9ZnYhLUeMLrttybbh3vXbpqwXKHwES5fvGo2p6zB8ejBtUu9O9f5Btp?=
 =?us-ascii?Q?QsJUoDC/OV8IYvRVECryx22AF3TfW9jLyFHhJGXhsLUO1b/RP+kjnT35q5vc?=
 =?us-ascii?Q?YDTjqXa+PAjxCKtVAN28vcG9gGI4pidP7gJwH6+wUvKVqiJJezFFWWJkofn+?=
 =?us-ascii?Q?V3nsgQgG3m7JXjP5HwDMsFn85C4STcd3v7p8UfsdOUWoXDNptZOeBilhqdEF?=
 =?us-ascii?Q?SqnS/G5dwvRuKz5Tvr4MnpHGr5OuV1/sqJsMX/c+jEwUM/zZYQ4+mHsm8ie5?=
 =?us-ascii?Q?qEPhvPW0e1qGmzKr2wbrtSzNUzY4VfyILXdYAupQplVab8DOp+72DxFcF7ZT?=
 =?us-ascii?Q?ISavneycDPAnPDuJKEtZHgJdSkmTQI05iR6CFHswzHtmpuKPnZuGxuuTttc4?=
 =?us-ascii?Q?Vmc8qB5DED+0T1lyCaioAOoxZPAXh/roM69nj0LYeAm4k7i0kf1Ha3/AVqui?=
 =?us-ascii?Q?1yNdFnWk2ApLGoPEWRsrnH6DJFTVS2PtsFkbp4LDabWOgmd5OzpcB1uf56Uk?=
 =?us-ascii?Q?N2Nw1SGVsDClQxcVbK0fpCMwky6a1vd7GyYg6+oQX018utWEKtkEbGRTTlU4?=
 =?us-ascii?Q?0G7Lk9e62VQmjyWw3xWpN6ybSx6rRJyCpl0RepzbH/No1IxlBEn3cByXxCud?=
 =?us-ascii?Q?R3qUOqCXREgLShXTaIAeDVlke23gW7WhemTWD2kWdWXyLdyidc624qcH3AFB?=
 =?us-ascii?Q?WAwKaqWkddQTwOpvr9omDuF+p/S6eyNyTSShKY4LWqKrWki21SyyN0fq/0p8?=
 =?us-ascii?Q?11Zamo3EA1a1wrcNVKDeasjobs2sRUH6I7qyeS3vcuYCvtEzpvTG4t4tT9f1?=
 =?us-ascii?Q?c+TI2NkJA7RuBMju4g4TYIz/ZQnLKYXZB8x2Mi2Mxh9QBGt3qBrP7tPbxc6l?=
 =?us-ascii?Q?fB35eCCHEuGJsHJ2eb2zwJ5Wp0QpLkYVEaa2x+oEKfQiRAbS3TnYmbgD6HKy?=
 =?us-ascii?Q?8MwVjD8hc2mcsAVTJnE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cb1156-94a7-46d5-3387-08dd7e83e5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 14:18:31.6557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYrb+eVawEXadhdlrf2KjCfsyjpgD1GnUg2kqukSNgbhVvQlU0TSpHYyCoDh9LgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 17, 2025 6:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 6/7] drm/amdgpu/userq: rename eviction helpers
>
> suspend/resume -> evict/restore
>
> Rename to avoid confusion with the system suspend and resume helpers.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    | 16 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h    |  4 ++--
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 0075469550b06..02164bca51a7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -112,7 +112,7 @@ amdgpu_eviction_fence_suspend_worker(struct
> work_struct *work)
>       if (!ev_fence)
>               goto unlock;
>
> -     amdgpu_userqueue_suspend(uq_mgr, ev_fence);
> +     amdgpu_userqueue_evict(uq_mgr, ev_fence);
>
>  unlock:
>       mutex_unlock(&uq_mgr->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index a2b92b549c0f9..c7b215337d55a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -529,7 +529,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,  #endif
>
>  static int
> -amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userqueue_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       struct amdgpu_usermode_queue *queue;
> @@ -660,7 +660,7 @@ amdgpu_userqueue_validate_bos(struct
> amdgpu_userq_mgr *uq_mgr)
>       return ret;
>  }
>
> -static void amdgpu_userqueue_resume_worker(struct work_struct *work)
> +static void amdgpu_userqueue_restore_worker(struct work_struct *work)
>  {
>       struct amdgpu_userq_mgr *uq_mgr =3D work_to_uq_mgr(work,
> resume_work.work);
>       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr); @@ -676,7 +=
676,7
> @@ static void amdgpu_userqueue_resume_worker(struct work_struct *work)
>               goto unlock;
>       }
>
> -     ret =3D amdgpu_userqueue_resume_all(uq_mgr);
> +     ret =3D amdgpu_userqueue_restore_all(uq_mgr);
>       if (ret) {
>               DRM_ERROR("Failed to resume all queues\n");

Please update error output information as well.
With that, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>


>               goto unlock;
> @@ -687,7 +687,7 @@ static void amdgpu_userqueue_resume_worker(struct
> work_struct *work)  }
>
>  static int
> -amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userqueue_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       struct amdgpu_usermode_queue *queue;
> @@ -728,8 +728,8 @@ amdgpu_userqueue_wait_for_signal(struct
> amdgpu_userq_mgr *uq_mgr)  }
>
>  void
> -amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr,
> -                      struct amdgpu_eviction_fence *ev_fence)
> +amdgpu_userqueue_evict(struct amdgpu_userq_mgr *uq_mgr,
> +                    struct amdgpu_eviction_fence *ev_fence)
>  {
>       int ret;
>       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr); @@ -742,7 +=
742,7
> @@ amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr,
>               return;
>       }
>
> -     ret =3D amdgpu_userqueue_suspend_all(uq_mgr);
> +     ret =3D amdgpu_userqueue_evict_all(uq_mgr);
>       if (ret) {
>               DRM_ERROR("Failed to evict userqueue\n");
>               return;
> @@ -770,7 +770,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr
> *userq_mgr, struct amdgpu_devi
>       list_add(&userq_mgr->list, &adev->userq_mgr_list);
>       mutex_unlock(&adev->userq_mutex);
>
> -     INIT_DELAYED_WORK(&userq_mgr->resume_work,
> amdgpu_userqueue_resume_worker);
> +     INIT_DELAYED_WORK(&userq_mgr->resume_work,
> +amdgpu_userqueue_restore_worker);
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index 8f392a0947a29..a9f0e46bcec05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -108,8 +108,8 @@ int amdgpu_userqueue_create_object(struct
> amdgpu_userq_mgr *uq_mgr,  void amdgpu_userqueue_destroy_object(struct
> amdgpu_userq_mgr *uq_mgr,
>                                    struct amdgpu_userq_obj *userq_obj);
>
> -void amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr,
> -                           struct amdgpu_eviction_fence *ev_fence);
> +void amdgpu_userqueue_evict(struct amdgpu_userq_mgr *uq_mgr,
> +                         struct amdgpu_eviction_fence *ev_fence);
>
>  int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
>
> --
> 2.49.0

