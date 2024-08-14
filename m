Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5C4C52D7F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 19:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C2089149;
	Wed, 14 Aug 2024 19:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VU+5kdVp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B66F889149
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 19:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKXuHKPWVAWC4SFmZfhQAvGY3soRRjQWg4A7AR2og0kqN1fk4ZSfes6qsDGGtNY41CnnLipUSuR0pAXB05Jgx4l3hg8wKbD6EJ88l8/bamr5/ZCBo9A0fOj+Nu3HoN5xxfY8xnT048+J2sATdolOwBShikFDnalhK6UfGtTX9HtmiQuxzM7wZSsk5iBLtJFzhOUXiKwtrgSyuibtonb78MSE01mvvLE1ExAwi3znYgamfvB9KiBVFCEg0jQdntsImOBu1gkaXVgzxOC4FpQYUyQsldu/Vppukezk2Nihc026XlvV0T103MlOAS75q8Fmj94FRBbICpK9gclAVS4vNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8NmQzG4XkWJbIlvH/v4CpXXUoMShQSILl+S9oL78vE=;
 b=RGcfbIm7i5aPlkw18lAeR8I7Usqb0BHCNsyZylatXVSXKHwNggUC9la+tVb+lPkBpacX0gfkpkaPjU6G174SOnE4pj98RTYO+w3f+Rsb6w92944M9KIfL+JWR7F5oSeXTDrKKJ5QtZvuodX7Ybb7MIrv6yf7o6v1gjuQWqIWecg+MHDNa4R4cANbRlblnkpI1TYbU+bnAdZByKQfVqb8zErUy+eatai+BHMEs0H1gL2HCwIShYe2gvbazeEuhAgB2mPu4YmZQGorCMGKTjLGLekJiOnimSjPPFKfZplNrrvxwBS8f8zXGezSYEoOFWaLWee41y82iHagaLLl0ed45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8NmQzG4XkWJbIlvH/v4CpXXUoMShQSILl+S9oL78vE=;
 b=VU+5kdVp0AIDZ8Kp3h+iAekpCVDY5movs3EFblVWqxBP58UGOXlnUKPcJvKZ0S5B80xufKVPc6+i4vtwR++a97NDgCSOXFHbPC4vV4BWybYoCFAmUwA45ThPd4dYPc++u3mNkefWm2NN4xHDDRjI1REAt7ehUYM6y627SuqPmwI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 19:22:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 19:22:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Zhang Zekun <zhangzekun11@huawei.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amd/gpu: drm/hisilicon: Remove unused declarations
Thread-Topic: [PATCH] amd/gpu: drm/hisilicon: Remove unused declarations
Thread-Index: AQHa7LRbURCpB3YUSEq0xU0wxFbmmbInJRbQ
Date: Wed, 14 Aug 2024 19:22:39 +0000
Message-ID: <BL1PR12MB5144C8FAE35EA44F04A56E33F7872@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240812122415.39664-1-zhangzekun11@huawei.com>
In-Reply-To: <20240812122415.39664-1-zhangzekun11@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c1492c9b-dc1e-4b43-b452-95b70d66b923;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-14T19:22:15Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6334:EE_
x-ms-office365-filtering-correlation-id: 7d4496c5-2ace-47b8-16cc-08dcbc967662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?n7STVxab2nC7j48MA75fFyJHvcc/fFV/mgC3pqahiSzbxoYhm9FCJP9ElET0?=
 =?us-ascii?Q?bR4cc76MmPAM3BrCi4QTl2X95B3hb7GjVSP9+ENDei/uqORXE9qiPrqhuVnj?=
 =?us-ascii?Q?EoIeb0SR64l9UEPvyJvjXFSQAJWoCOMON9Ac50wUWC3RgyEEuYF2qKQD0ARM?=
 =?us-ascii?Q?+lUDooV7TFXG4erMc5jgAE2I1lSzKcOUfcH/0TC2hs3u4mKz8VuBFrrdoOj2?=
 =?us-ascii?Q?Xp1688qmooCx9Brj1U2U180QCcXdTt1xvqBjecnfQVK401iyUN7wijan8djH?=
 =?us-ascii?Q?LXTGhLTn1a9umcsc1/BS2VF0eJliXbs4ojz4q/Lh/ZaBLTIiapJgNJf6qUXN?=
 =?us-ascii?Q?eTiXlvDL1sAnbcCgDOsdoqh8HsRAgA6g6h6acfzbUgcp87Mu0cmjOA2QlY60?=
 =?us-ascii?Q?fHhVnRKhL/Qm5zvNUvY5/TqkxRO0llNTRYod4nwdXauL/cp91l95H5gtQWSD?=
 =?us-ascii?Q?uW0goD8MPKLkzWz4sCFtq2PJRBj6mpF+6evStoe/b25mMnS3ywtN+ogQHhN4?=
 =?us-ascii?Q?JQkil/JIPvw558d7nUcirLuEHvVJHIbRcA47gGrc+2QY/W5kJPaBgY25LS5j?=
 =?us-ascii?Q?7rbEk+7NknbfWZI/EPTC5lW458/swPlv3VRrpm8fx7Jnzl78dKR8K6ewf3Mh?=
 =?us-ascii?Q?UCrQ7dwGVUhViJ1M978qx5o+h3vUi0KedK/RWkRbICfsdYSukDPslIgUlB+v?=
 =?us-ascii?Q?07/ORKZ7c3kpZ3P2aHwFdQlgZIWcmMNu7hsTqIm9ap+lTJzo79ztwtvQdIm9?=
 =?us-ascii?Q?5vu/WMNXLCrzqd1xMMj815WH1xn4Ade3S57WHrKTsPdTJJq4hAsHUpMQ2zIJ?=
 =?us-ascii?Q?RuGDudNAbfl8N15udnsNPlf38R9hz/DxmgYvAKwkixK0SrK9fGHyC0xyEJGH?=
 =?us-ascii?Q?Kv9R5CEyRsawbKTHeX4587n0vYc4oPMmqXzvT+UB/7aiiu9ExWcZ5tW2PKEi?=
 =?us-ascii?Q?058s5/7RQw6H8n4MOx/1F/jdxdv+vlP7+qx/n4hQxPdWxRrRNwBPhl88S8eR?=
 =?us-ascii?Q?OoC04k5Z4zxEyA7wuoQbAds2W3l60JxqT9JnToOtKwAT5KarWplM8l6Slfas?=
 =?us-ascii?Q?U2SSvmG57ztY0h4/FbEqtE5qYEiqz4xHpP6JSDWQ6V3Wdm2haHrpt5yza65i?=
 =?us-ascii?Q?JvQ+gfLheBmD6vx/sUKbTJrqQ4trBUA9q4kPUKY+2k/zDKBqIbRL/Z39Q4ut?=
 =?us-ascii?Q?rNProEXEipG4S+ENg/AJVNQHLZEMNd4j+5ZfEkx017/+casG4BfyRmoiRf0m?=
 =?us-ascii?Q?8oA4K2pN8WBp+OtYC/cLe2L2+peN7uHzSJOvbNHDB/U+WX5xxj2DppyhEJj1?=
 =?us-ascii?Q?kk/Dc1YB3c+gsSQwj6BthrKcqrmIGCtiNrX8wg9WFi4FHYHfsJBWf3ykLAVz?=
 =?us-ascii?Q?f6EvIzApD+PCk8eK0rrranPYMdSyl12iKCuAmFOOhIZGUfsCTA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CzVBUQqkcNcvyQD6VcEHgaHkuKWt8fpKHiJkgt4Pk5HDZ2scbhUr83cAPjyi?=
 =?us-ascii?Q?kBdmtlGxXOQHXX8Wgv2CVMx0UJhRoKRoCoOGy5xq6bMSkJI4lDpmyIQvMP0C?=
 =?us-ascii?Q?GT3yEBI5CPMzgnM5oCWXhEd94sxXq+REUPlpBVXp+Byr99e+xuH8OE222N7G?=
 =?us-ascii?Q?BL7pbCc9rXo2kAJL/nyQBH/bzF9UBeJC14lXSSv9QrLbWkkLFIX4uw0XY9dW?=
 =?us-ascii?Q?cjAKbsHqCOULEm2NZBjYjIpYQdHys4MynkYDpLxUSkkrYcmOqES/ZQRltNOJ?=
 =?us-ascii?Q?SOsHnrFmaPCNjoKQNkYdKjsM5wZUPntPeamZJFvk3jp1x3WhnCjZ+YdCW6dQ?=
 =?us-ascii?Q?WgJA2iTfFE4+qQJdxh05xuEVwncfvDlkGQf49qX2zrmcdSjLHvsAA951aWH7?=
 =?us-ascii?Q?U+iRTynfVEfr+tVdXJnJALB9fkPmnOOaMEEW2SP+HEcmEpncILpYI7NDn9Zb?=
 =?us-ascii?Q?/MSSbXDHDtjqzS1n5fQ2Er5x4CPJADjeGVz2u17Pi5AJdArX/PMVxLvb0Vx6?=
 =?us-ascii?Q?Jb4XzaBUxFf+Q0wrIAimuVqTuTeWnukjQaDcX3hQH1Ufvs6xT6BBki/b+AeC?=
 =?us-ascii?Q?mKOSbVy18wnOaeIl8zce9RPMGepKVw2vD/4xrb+HfnJPG+K8J+CoEfpiL+zn?=
 =?us-ascii?Q?/+97ehEgNzNH/YELC0xr/iY7wPweZb6yLkXn0WwuuTvXk9znOOIY0mWMIY/k?=
 =?us-ascii?Q?Q27M5lxxxQ4lkc4kPK5cRhETekSMo8BrcTW97dGe/O7+ii605HTygsR7LjFn?=
 =?us-ascii?Q?Ppykk3blC9/Rvz2z6bIL1FFDJlu0I79kg/S0ZliP6AOXh93PxtRalcsM4px2?=
 =?us-ascii?Q?2nXXLZ5Xh3TqE21sefy7OAs7PQDelxNgsZ9fuy9kz5vt8MXl7CMVGk4Kue2R?=
 =?us-ascii?Q?NvzppcBwHvJRRjIJf8wQ5KqbX2Kqx8rcimHoT8QKszHlmpkZOoqnIQYQ4zy5?=
 =?us-ascii?Q?LGFGqcRkH8d+T0qJjRTCN6WYnMgI1CeVuVZPmLKmevM9aIxK19Flxn058JUq?=
 =?us-ascii?Q?ivg+MvWKhMt7hHwiWrpLvYP5PaPVZ/lyioLPP0BwHql9/yDbdoI84q8SalMR?=
 =?us-ascii?Q?Hjt6iQthv21Xfh5/rK9VWjqp07PDuwP9+JmQ9TdW1q2GSWfq9kZQtFV0yPst?=
 =?us-ascii?Q?fphRzpnYyDzK0AS9NCEMmfH8lk+3SxcRXAded1tzlBHd1lzqrUzLAsWIIxu4?=
 =?us-ascii?Q?uoZNaf7+TgxAqP8OBSg+Claeu+Pv2I1GZjjmf2OQgKyWYGAmYVqIF3SRiiCL?=
 =?us-ascii?Q?Gi4rLZS6KJIwyTWz0jLy7/0gVcw0j5bgiYAXQo/sFxsvEn4df7xpzpxIj5sQ?=
 =?us-ascii?Q?fUzod8kKPWa61ZgfoxQ/o9qSg574f2n3sMZrlacDRnnQDP6ZWpQ1oYW0LGRJ?=
 =?us-ascii?Q?fRkDEh+3gm50QCZrRy36AqylbUUSt9/KvE6oca2h0IMG7q8VUXmWIJvud1kV?=
 =?us-ascii?Q?iTyeFhAskQtB11X1gLE1QhD8boStF6FzVyLW5rsgmXP7xL4Ud1SWOzBBxphx?=
 =?us-ascii?Q?uR9SttsAHkpkK/4aeFMg77JXlhLJvDC7j/FHpPqxjUciImrV2KPR/Og68BrZ?=
 =?us-ascii?Q?i/wJ6SjE7/t8vs4bHZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4496c5-2ace-47b8-16cc-08dcbc967662
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 19:22:39.6533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYbs7fUxKUHkOTFELWuGjOiZRlfmmrC/CyprLQ31mdUFowqtANwBVV1ofzOh6M36/RBMA0P6wxuC74oPPputXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334
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
> From: Zhang Zekun <zhangzekun11@huawei.com>
> Sent: Monday, August 12, 2024 8:24 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> airlied@gmail.com; daniel@ffwll.ch; amd-gfx@lists.freedesktop.org
> Cc: zhangzekun11@huawei.com
> Subject: [PATCH] amd/gpu: drm/hisilicon: Remove unused declarations

Applied with patch title fixed up.

Thanks,

Alex

>
> amdgpu_gart_table_vram_pin() and amdgpu_gart_table_vram_unpin() has
> been removed since commit 575e55ee4fbc ("drm/amdgpu: recover gart table
> at resume") remain the declarations untouched in the header files.
>
> Besides, amdgpu_dm_display_resume() has also beed removed since commit
> a80aa93de1a0 ("drm/amd/display: Unify dm resume sequence into a single
> call"). So, let's remove this unused declarations.
>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 7 -------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h | 2 --
>  2 files changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 137a88b8de45..f0feb199b6e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1588,13 +1588,6 @@ static inline bool
> amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return  static inl=
ine
> void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
> #endif
>
> -#if defined(CONFIG_DRM_AMD_DC)
> -int amdgpu_dm_display_resume(struct amdgpu_device *adev ); -#else -stati=
c
> inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return
> 0; } -#endif
> -
> -
>  void amdgpu_register_gpu_instance(struct amdgpu_device *adev);  void
> amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index 8283d682f543..7cc980bf4725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -55,8 +55,6 @@ int amdgpu_gart_table_ram_alloc(struct
> amdgpu_device *adev);  void amdgpu_gart_table_ram_free(struct
> amdgpu_device *adev);  int amdgpu_gart_table_vram_alloc(struct
> amdgpu_device *adev);  void amdgpu_gart_table_vram_free(struct
> amdgpu_device *adev); -int amdgpu_gart_table_vram_pin(struct
> amdgpu_device *adev); -void amdgpu_gart_table_vram_unpin(struct
> amdgpu_device *adev);  int amdgpu_gart_init(struct amdgpu_device *adev);
> void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);  void
> amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
> --
> 2.17.1

