Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122D0D13570
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 08:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A091F10E0C5;
	Mon, 28 Oct 2024 08:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0AUQwSOF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C3010E0C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 08:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7wSVYNMZIPwWjILGD3Zz9V3PWEliJckgWVSJpdKzxKBmVsO/V5Ai/MamCwwnA/8MfGWTXmqMxGRzfI/0+JB24FFcHd4QHuvnzKiZvHA7T2hNXPFDT4PBbx4TDDT1HNN19NmFWDmScV2syPlpCgqGHg+KCnagvUieBI3s46lcCwDA2b1uqJlLVh47bWwsjZot2od+fw75x/v2x33sbMNdsLEx7xdNYWr4tfODBFaiX0l/MP4vmIKquhIt4QN+bYunE5mwkfr1UuBBhozi//Co4ObhCnCi8M8RNoOOrXnfcv2kaEnNhCNa2g6Sa+bmN7TP3Rv+3sgJWX/LLINQGgpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2BgN/Gx9DF/HDjpfn/g1h/1wlzX9GZnMBvEHQI4MQQ=;
 b=aCnP3EU4xul5XZG0KAwCL2RhXSVwAPfONwnRdJnnqHgLjnVox8NtrVb4msfUgruIgmUYS5sgM0loBUxqrwTNEtRxtGHxdflOtifgl5ZEKkP3WfAjZDz5ubi8t9bfTv2mI01bFk/cw/KG80W+ooz03rEJ7dkznNrRROZmXwHv9Ur+MFq9YL/emRMmNKx1/pXFkVEefLqtUkqG7QeKdQN5U2yz+I9LOh/9Tjcnms7xX+p6iYNG3epgJHV9SPg+Os+jFCEuN2ykfZRcDlC3vcxmEUZEKDsab2Q4bpsqaI/pt9CSuVHyb9WNCc0/l3ngbCwpuJI9bivk23fsX58PoQ7Wew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2BgN/Gx9DF/HDjpfn/g1h/1wlzX9GZnMBvEHQI4MQQ=;
 b=0AUQwSOFR7ayKc7K230kh3pp2cf/pGYjh6FmPujgtG40Xu6ccKDP/LPMGQbQaNBXwLTcO8s9KzkDWrWrF3DCYcSY3Kd/XTnneBrbEmBOk2zSiKnmNcdumXPVbO7u8mtNWPVZLV+HZRO0TEN2HalGvN1yowwfvJmxJpoXBllcMS4=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 08:47:43 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 08:47:43 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
 amdgpu_compute_sched_mask debugfs
Thread-Topic: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
 amdgpu_compute_sched_mask debugfs
Thread-Index: AQHbIQXKXYLkPmWrcEStW1ugDBFgL7Kb53FA
Date: Mon, 28 Oct 2024 08:47:43 +0000
Message-ID: <CH3PR12MB807459A43AF6702417569B53F64A2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241018023054.1601248-1-jesse.zhang@amd.com>
In-Reply-To: <20241018023054.1601248-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=00837aa2-9c4d-4866-a2d3-72d4ae4920ff;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-28T08:38:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS0PR12MB7996:EE_
x-ms-office365-filtering-correlation-id: e89c4c15-b50c-4f69-d1cc-08dcf72d3014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JN6i0bqkREVd8Cc5xSTfZtu3yamPdIwzg5D4oAvx4EwfvUUdqspeUeSKKg?=
 =?iso-8859-1?Q?Mnet6lv+Nv9GMM3WdX/8qm6cicccXtEjM8u8wu9uTyTRqUvfj9dThYYzbr?=
 =?iso-8859-1?Q?KTC5LGSwCZEjo5lc2nKvQJotpTCZ8V7MjYSdTr73kYTZfjCvbVaYbPlr/6?=
 =?iso-8859-1?Q?jUfu03oSGaieHE/9+qajJT3bMhD3rPqfeUZHlDjLXd2jTCxooYeIsn/jgP?=
 =?iso-8859-1?Q?BMG0LPL/3RY4AIrnPt83PVF/+thBsjKCpZUSUkXBEtNM65gu6LxGG8StNQ?=
 =?iso-8859-1?Q?DGa5aogr8h+juLzzSx5cg+LF/zWeVIGmsVjdsBt8FKbr8iM23jv8dIx1SS?=
 =?iso-8859-1?Q?EfpVj97ax1wPfyesde5YkN7J3SZQTYO5E77Pc1aH05NkS9l/YGxkDB4TVm?=
 =?iso-8859-1?Q?ArgIXnsTDQ248h5Xa5Wsj+iFc03P36pPxeC7RHHeM8a13yKm6hpR4vi1DE?=
 =?iso-8859-1?Q?B6jKt58f5XbMooHyZItduYv7b5+yhDmXVGouy7fNsMWUe8DOVU7bmGDlaT?=
 =?iso-8859-1?Q?0PWw6VqDl4t7e9QXNg9IHQqD6Q5ldgqMy44IueCGwgqJzyNRFkpwCF2Qg/?=
 =?iso-8859-1?Q?cCNFo/FF3Pq5BsxM5zRzMKAeTbq9t3fMX6MMPuN1uULojxuKfS9JPdeYjj?=
 =?iso-8859-1?Q?oteLLfj6+lXzK0UabX3KO0oKfFgjzJ7Pnwc2tDmor8GY6gavXbKFCWbyO6?=
 =?iso-8859-1?Q?q08xQUBv0mNBEWtz5306NOLhZe6I5QMVIiWtuFm+yBMfgzAuHSg5ApBTxc?=
 =?iso-8859-1?Q?T9ZULqPZ4UQPRtRpj4oJnq9A2pGJQeTHrgaU5i5Hf1SsFs9/rXvJIHRhbD?=
 =?iso-8859-1?Q?uUcoJP2R6zXFmtcglFwc/6l9Bim7iZRkz00ODZRhO6TURer18x1fA9aCtV?=
 =?iso-8859-1?Q?FUBa0ibGDqu8hA3m5BAjl4LBFdw5GIdjCShNCVTsbQV/GFWpySX9/rFAe7?=
 =?iso-8859-1?Q?oa1zhioQcuERO3DqiQHoPDV7IfBWmmRAkm+wDyP+ggdm13vHq3GMxvLcu4?=
 =?iso-8859-1?Q?kHWS4dLk/i1GnkVKQbNeV3xNEO7STNHfXg58ds7RULjgvUrsBNzCMeUx2Y?=
 =?iso-8859-1?Q?sVgc2FNFlFNjmQ1StTuVyTSlY9+VB0t1cUFa0EkyYkoGbNeiF81b2VZwVr?=
 =?iso-8859-1?Q?857wLMFi2XvhleoLW/4S3FV7z0JlrdJjG8IDmzYUTmH7fw3SQzQFmUiaVJ?=
 =?iso-8859-1?Q?9G9YVLX/RaZATQhP4vbDf+M1loKYHt1NCGhFFzghmIYtSLrnnciQ0maTw+?=
 =?iso-8859-1?Q?GxXy0Iw63eXLyxlYHw3L6cBjCFZuxbg7ZPrz7Mu+hGCnqmryM8l4IMSs3c?=
 =?iso-8859-1?Q?ntdpseVDyA2bKGgJ+sZQi2d6fOf3aJ6oeEVAM5oOR9a6stNNhMvRcYZxP9?=
 =?iso-8859-1?Q?h+ea2Y0Gdt04rA9QrqwEd+dcYmRHgku9HlgF0oYh1417bbXh21D+c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eGLhuy8dH2e4yGRQqH3MqNVGmVmGWr5JfCVQeSwkGlj8D6YsHcDAPPB+a9?=
 =?iso-8859-1?Q?wM7n85IGDKVT9lKfVRNgFx+d2D+Ozj+VgYCeJYSrUkuswRoIxad+/+rAWW?=
 =?iso-8859-1?Q?22JUl4nfikANCj6BxC4kqpJJIzRKDw2JkulLyw3Mh4OyYRUZG4mnzn1Q8X?=
 =?iso-8859-1?Q?QRj0iOLA/HC09EdUdUVcvF2pXVeT1XJsqeAvkMfnc6pHejmi0Cd0qiJ6XO?=
 =?iso-8859-1?Q?DB4eBSxrgp3j6fcQxF+t4jXYA3eamCGNn2B7RX8cAAOgbplU7WW96lElOE?=
 =?iso-8859-1?Q?gCTyiwHblw9QQyVq8+NMBD7liyNBxsH9T2/gBXENd6Dr/LHlpue8ITUU/v?=
 =?iso-8859-1?Q?wHableLPCaLACJU3UCUJJfshBNWF55CUS3jn42ehWZTge9Gce560yAvDuo?=
 =?iso-8859-1?Q?l5wPepck/aqg0ltBCdgzs2zAsfwyXLktTrSHXeTuLsTRFHN94447y0AtPx?=
 =?iso-8859-1?Q?z4kgPMkwLa5yM2o4SiZuaj8iQ52gKT1LD0FF5PVnFV0eTkVP50a2OmLH1A?=
 =?iso-8859-1?Q?j0btwZUcziZQaWh/XJzDOCc1CN/ewE2ffPTkzhIjwRBenm8nLXAlAN+N2j?=
 =?iso-8859-1?Q?TvDu+AZtvG8Sno1CLRIzeRTLRjpiPx6r3GA8japL8MGiFLnxznxFTHCGHB?=
 =?iso-8859-1?Q?IxIQkWA6vPX2pO6huULeCHq14VUmVGZMLaum3COtjZa16pRyBcl5p4U1SF?=
 =?iso-8859-1?Q?q85isbPc9bUZUUeIzdre4dACT6CioK3579TuSuNo6sz7Vo9fch7kTeOVd3?=
 =?iso-8859-1?Q?LlWJEG/ni4DXtqgoeHxGPHmg2mLrlk7zqhcbMB+sWaDaY2B1bCt20JtRyw?=
 =?iso-8859-1?Q?waBgFSlU2xIbbOfydb1qfBV945fQGYoeSzfW5NINtwOPlf2CMOnhiIiDAB?=
 =?iso-8859-1?Q?a7GHNOvQPGE0bBG40g7ZMu/oGP+hMeNLrmQdL16vmwb4h9OhifzTlCNTIk?=
 =?iso-8859-1?Q?61EkxW7IObt/LxBnV/NjwBSURsIgMTbhD6BYzJIyUnxXMwrLVbQktvbWdJ?=
 =?iso-8859-1?Q?2BusoeM4GbcBiokdjyydEEA7KiarD9aGdNCYHGQDJXDt08rUafTPs3D2y1?=
 =?iso-8859-1?Q?fiTIwB3EY43MQF+hI7Jp7iG644L/lTo0TN+NbKgFb3L6G8Mxw4b3b2sHY2?=
 =?iso-8859-1?Q?Nr52LQrEKlavKcTDBkw2FvcfoNA2bJld2JCt9LC6tUSAUDU14j4guSKSiR?=
 =?iso-8859-1?Q?mmboHVAVoM5CMpGawCMcFXFJbca4SeGSCEa2xfEGLGEUEelcLqk1TIO1Cg?=
 =?iso-8859-1?Q?cSpXfmIqXG+WwZfZewDsb+HsU/2MpkuMQOMgPwqBxCBU2YFuwXUZKptk3B?=
 =?iso-8859-1?Q?hRrUJm4jaebpB4VsnpaHyLXLjSBCRUGAmWlq/5VM69N8JCifoYo12mwMq6?=
 =?iso-8859-1?Q?JxOPc5dm8gdJ2qbL/mLSZMl1AQyaDzd2Zcjia5PJVApTKcCcJOddwPbqXi?=
 =?iso-8859-1?Q?C2DFGcE6SFFi61UGJ0k4wHXg6DB7YiE6/HGR/XOrj3BDqysAcAIgmy/07o?=
 =?iso-8859-1?Q?m+iSfGfxUVkLsE8MdjlJ7fGzkHvOQVq90dLwrkXTG+J8B6tiWnZV3PbUHT?=
 =?iso-8859-1?Q?k1L3OOje93mbsV+uiEc/xpsQCfyBJd1v1kWcfV2UXEUI186NBjsVowTQ3L?=
 =?iso-8859-1?Q?/kcwlDMm1whpY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89c4c15-b50c-4f69-d1cc-08dcf72d3014
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 08:47:43.1439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lud7a3LhPjRGN62g8TL0MLCC5QaMAdiuq8DU+JWRb3Bd2ibDR5Mva5DIxOherS0sBtEN1vPjBsGXCafgETj4YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse.zhang@amd.com
> Sent: Friday, October 18, 2024 10:31 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: add amdgpu_gfx_sched_mask and
> amdgpu_compute_sched_mask debugfs
>
> compute/gfx may have multiple rings on some hardware.
> In some cases, userspace wants to run jobs on a specific ring for validat=
ion
> purposes.
> This debugfs entry helps to disable or enable submitting jobs to a specif=
ic ring.
> This entry is populated only if there are at least two or more cores in t=
he
> gfx/compute ip.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com> Suggested-by:Alex
> Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 142
> ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h     |   2 +
>  3 files changed, 146 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 37d8657f0776..6e3f657cab9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2096,6 +2096,8 @@ int amdgpu_debugfs_init(struct amdgpu_device
> *adev)
>               amdgpu_debugfs_umsch_fwlog_init(adev, &adev->umsch_mm);
>
>       amdgpu_debugfs_jpeg_sched_mask_init(adev);
> +     amdgpu_debugfs_gfx_sched_mask_init(adev);
> +     amdgpu_debugfs_compute_sched_mask_init(adev);
>
>       amdgpu_ras_debugfs_create_all(adev);
>       amdgpu_rap_debugfs_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b6acbe923b6b..29997c9f68b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1868,3 +1868,145 @@ void
> amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>       }
>       mutex_unlock(&adev->enforce_isolation_mutex);
>  }
> +
> +/*
> + * debugfs for to enable/disable gfx job submission to specific core.
> + */
> +#if defined(CONFIG_DEBUG_FS)
> +static int amdgpu_debugfs_gfx_sched_mask_set(void *data, u64 val) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +     u32 i;
> +     u64 mask =3D 0;
> +     struct amdgpu_ring *ring;
> +
> +     if (!adev)
> +             return -ENODEV;
> +
> +     mask =3D (1 << adev->gfx.num_gfx_rings) - 1;
> +     if ((val & mask) =3D=3D 0)
> +             return -EINVAL;
> +
> +     for (i =3D 0; i < adev->gfx.num_gfx_rings; ++i) {
> +             ring =3D &adev->gfx.gfx_ring[i];
> +             if (val & (1 << i))
> +                     ring->sched.ready =3D true;
> +             else
> +                     ring->sched.ready =3D false;
> +     }
> +     /* publish sched.ready flag update effective immediately across smp=
 */
> +     smp_rmb();
> +     return 0;
> +}
> +
> +static int amdgpu_debugfs_gfx_sched_mask_get(void *data, u64 *val) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +     u32 i;
> +     u64 mask =3D 0;
> +     struct amdgpu_ring *ring;
> +
> +     if (!adev)
> +             return -ENODEV;
> +     for (i =3D 0; i < adev->gfx.num_gfx_rings; ++i) {
> +             ring =3D &adev->gfx.gfx_ring[i];
> +             if (ring->sched.ready)
> +                     mask |=3D 1 << i;
> +     }
> +
> +     *val =3D mask;
> +     return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gfx_sched_mask_fops,
> +                      amdgpu_debugfs_gfx_sched_mask_get,
> +                      amdgpu_debugfs_gfx_sched_mask_set, "%llx\n");
> +
> +#endif
> +
> +void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev) {
> +#if defined(CONFIG_DEBUG_FS)
> +     struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> +     struct dentry *root =3D minor->debugfs_root;
> +     char name[32];
> +
> +     if (!(adev->gfx.num_gfx_rings > 1))
> +             return;
> +     sprintf(name, "amdgpu_gfx_sched_mask");

I recommend using the literal string 'amdgpu_gfx_sched_mask' as the argumen=
t for `debugfs_create_file` instead of a variable name. The same applies to=
 the other instances.

With or without this change,
This series are,

Reviewed-by: Tim Huang <tim.huang@amd.com>

Best Regards,
Tim



> +     debugfs_create_file(name, 0600, root, adev,
> +                         &amdgpu_debugfs_gfx_sched_mask_fops);
> +#endif
> +}
> +
> +/*
> + * debugfs for to enable/disable compute job submission to specific core=
.
> + */
> +#if defined(CONFIG_DEBUG_FS)
> +static int amdgpu_debugfs_compute_sched_mask_set(void *data, u64 val) {
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +     u32 i;
> +     u64 mask =3D 0;
> +     struct amdgpu_ring *ring;
> +
> +     if (!adev)
> +             return -ENODEV;
> +
> +     mask =3D (1 << adev->gfx.num_compute_rings) - 1;
> +     if ((val & mask) =3D=3D 0)
> +             return -EINVAL;
> +
> +     for (i =3D 0; i < adev->gfx.num_compute_rings; ++i) {
> +             ring =3D &adev->gfx.compute_ring[i];
> +             if (val & (1 << i))
> +                     ring->sched.ready =3D true;
> +             else
> +                     ring->sched.ready =3D false;
> +     }
> +
> +     /* publish sched.ready flag update effective immediately across smp=
 */
> +     smp_rmb();
> +     return 0;
> +}
> +
> +static int amdgpu_debugfs_compute_sched_mask_get(void *data, u64 *val)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +     u32 i;
> +     u64 mask =3D 0;
> +     struct amdgpu_ring *ring;
> +
> +     if (!adev)
> +             return -ENODEV;
> +     for (i =3D 0; i < adev->gfx.num_compute_rings; ++i) {
> +             ring =3D &adev->gfx.compute_ring[i];
> +             if (ring->sched.ready)
> +                     mask |=3D 1 << i;
> +     }
> +
> +     *val =3D mask;
> +     return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_compute_sched_mask_fops
> ,
> +                      amdgpu_debugfs_compute_sched_mask_get,
> +                      amdgpu_debugfs_compute_sched_mask_set, "%llx\n");
> +
> +#endif
> +
> +void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device
> *adev)
> +{ #if defined(CONFIG_DEBUG_FS)
> +     struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> +     struct dentry *root =3D minor->debugfs_root;
> +     char name[32];
> +
> +     if (!(adev->gfx.num_compute_rings > 1))
> +             return;
> +     sprintf(name, "amdgpu_compute_sched_mask");
> +     debugfs_create_file(name, 0600, root, adev,
> +                         &amdgpu_debugfs_compute_sched_mask_fops);
> +#endif
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f710178a21bc..9275c02c94c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -582,6 +582,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct
> amdgpu_device *adev);  void amdgpu_gfx_enforce_isolation_handler(struct
> work_struct *work);  void
> amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
> void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device
> +*adev);
>
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)  {
> --
> 2.25.1

