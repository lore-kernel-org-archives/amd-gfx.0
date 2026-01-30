Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC102D49C73
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F04210E927;
	Fri, 30 Jan 2026 08:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDooqL25";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B744910E924
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhgA2C+yDgdegyuM54olTRcztuxfpIQUPdB9psPwVwguTGOfcCQtq29ap3MgtnDRNft76qDJ34+GIFvS7UrAI9YD/iRsqEa2iP2EDiBiPUw12o3yvFp/StJbN4Y1V0Jfsb42BVbyfMAgqp9sFgEu8FRfneuDaTkl7Chgj+WDj0pha71EgK5HovkdrPJlSao58BIctellZLR7ITHGBM2LDlvWI1k+0OX559sUVt2JQqmpzfRCBdQ3e+dDoe0oabl4ndL+YalT2ztpu0keXO7n5J+netmdOmgFc70H2ptsXux24RiOU7MUpyX8T+tVlSjcTZ01fKT1TawDBnabcXtgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRJo64FZA6kCi1VnZjf7TaddT5dPj1C/cLY0nmvJn1o=;
 b=T/wLNKdz7WTXfBIjW0HAv3ixYFdTMXEcCzcrcUQ6YgnXdQqqT3K92TgdBAfH2Z+chscjSkiatbmg4v/a+nzdvbL6Z3IEtIDh6XF7hpZ3e/VH3mbIbeHcuFDmvfe84bal4NOeJHcDSQWwLwL6V6exHnnwOYdQLtqrgfw3t9mCz1UGu4MdsO9fBvdBSX8ccYKYryvvD+MwtwCAkT3PD7zN31Nk83d/rDaeohzWO6XT7FZJQV7JLMDsuPUaI7adBSWqqt1wzL62JhhLK2QwQaro5a9Z2hzYjx29wUeWrw5IwlLgBJTWUOtpizbkC2XD7a+XN46tW4OLodOpv0SCNmsGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRJo64FZA6kCi1VnZjf7TaddT5dPj1C/cLY0nmvJn1o=;
 b=UDooqL25YeqjZLg2/HPapmIk6eusnX6xzoZVVxFgJd1ARu6pET1dOsasNqtrEDB1kA2SiAq9OnZ7zwxT4D33d31SFx4KU4dtAISHtd29quWwrRg54ZeDE7K9eTB0amkQrRzQyWe5Eh8AFg85fyos5zi5lKT8omRg5oxRG03YzDE=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:30:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 08:30:03 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4 6/6] drm/amdgpu: add MODIFY operation for compute queues
Thread-Topic: [PATCH v4 6/6] drm/amdgpu: add MODIFY operation for compute
 queues
Thread-Index: AQHckEVHRHxct1PWu02aVf3q8DhZ3LVqZKfw
Date: Fri, 30 Jan 2026 08:30:02 +0000
Message-ID: <DM4PR12MB5152665E85B411E57FBEB0A8E39FA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
 <20260128105847.2898288-6-Jesse.Zhang@amd.com>
In-Reply-To: <20260128105847.2898288-6-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-30T08:29:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB6397:EE_
x-ms-office365-filtering-correlation-id: fcf6ca8b-b837-41eb-a6c6-08de5fd9c3ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?apf8IMfJPqeBOtgQQuyXXBI+gcEO+yJVvP7gpxOdBZifnhBVsn8L2cByyRbC?=
 =?us-ascii?Q?lK1CUB1GSyVSvU0QcUKJgL3dsgzp1TDrf+8iC/wkHPrSjwqc1CewOShpVxW2?=
 =?us-ascii?Q?9h6yq+4nBhpt+0qYsfOhZ6Y7omE0aTpSEz1fDe8s3Pcx0BVG6I+MATsQi9yU?=
 =?us-ascii?Q?xzjPnMQi8uLSmwH3mdO2gxA/Ufzz3DhQFUlG3FGKw+2F+HAFPdWyWDG4M1Uy?=
 =?us-ascii?Q?9YNwvSnyqRlnFhUPvAJqMB/lc+/d8nYMchRpKlM1R46NkNhQJyw8OYrHS5hF?=
 =?us-ascii?Q?0kdgV/if4HCgFC0eoeQrxfFFvXFitFgYrKE0IbrTUBR9DoKkzJsA0WW5tsv2?=
 =?us-ascii?Q?ISy+1nmLSCAJKq1jmj+YJnxLeZEeaMX6vi60k6AJkN2AeoWK3yYDIxy5j77N?=
 =?us-ascii?Q?XdDC50Q8nJTYyOjRaduDj0ETqLoN7Hz+0eUUHg9JLzCJyom5vgUA5nlZmjQb?=
 =?us-ascii?Q?nQhR8m0CcXS7/LJ1gEOd9eygq5df69dBAcjs1xKm41VNJ5B5F6HxetZLbB25?=
 =?us-ascii?Q?PfgmkEwy2AWr027csp68PfRrpoU/XEHsYf1z30UPZSXLi2+n42nOyJQSCfRe?=
 =?us-ascii?Q?/h1ADvs6xu/RUqC6jSe+jgmdZSxsA627+uwg/HwK+O18QZcQNsv5guDXHrMU?=
 =?us-ascii?Q?/v6Tl8HV9i/mvre6Z+AJZho7aHWW/HsmBpVpWx8qJqMq37RfhG1eFg0tU1tD?=
 =?us-ascii?Q?m01hKjR2DQGeThv/olCXnif/pzFYR/FeD1K4sH+yeIt6bLt8XXhi7cXJmF4H?=
 =?us-ascii?Q?8N/mBuUQyoE08tR3xRL8MJOu19jquPjka/p3O21gUN5ImNoYzYiWNaJb783A?=
 =?us-ascii?Q?n0OXLmNTlkexEQueuslIp06xlMMUQn0CoDzo5LTKkv33usxU+ncibwQswZcQ?=
 =?us-ascii?Q?rl+WyTL/DRM/uV03XGt7TnrqM3DFU1TBRytIMhZptb6CEvYJBlAQb/9e2Agx?=
 =?us-ascii?Q?KBkxcVJtSjmB21+9XL1XEosudHNgRCKMMWaqa9OOzbpBKD0Jy+TPCxSbc8eO?=
 =?us-ascii?Q?WAA5b+pmN52pjrolv3xjLGfzALwZce0xuvu+oxIyJvDlvSenBHlOZ/lqWDka?=
 =?us-ascii?Q?oF+md1oO5lSWGGV6JluarDtB+4lG0n6Fla7jQtof9zpT2zzp5AmcBDMsWyZ6?=
 =?us-ascii?Q?AJ+6gj6g+AlsyLh1OUFvmIZhrVzG2TfY4ADQKD0E/jGsACRwBN2Tkl5i3leY?=
 =?us-ascii?Q?3rJH7ed6myIu8W7cTdtVwAUVb9Y8PCZE8nao3kanwE6AWcoL6jRBFw8EO1W/?=
 =?us-ascii?Q?JDtR19Lnjf7kXrSX/n046O5+zVsxKEu4LkDdH+znTXUlfL+1ujo2M2r8JbyE?=
 =?us-ascii?Q?6dPjlVf3JEx1dSK9HIaFiAEFypy72tIZ8MAbtxTLoaAkc2i5WsedPvoJi6aO?=
 =?us-ascii?Q?LCm8gsaAGAqvEYXtfrTSQoUrDxiK/XVVW53JFMBZ+52oU2rS8cr0uP9/VnYd?=
 =?us-ascii?Q?2Dky4HawKnQlKCvWH6YbXFvqGJR8Lm+2NcaztECbLoQrbLr4asFq2JJ6EnWc?=
 =?us-ascii?Q?FvPhBG8KcQ4OBvxe7N52NF9eXV/3N/lAgVFCEF7MlHmpGirhw8Ru3MajqPTJ?=
 =?us-ascii?Q?apXb75DHvR4XIkJUtf7IEsyoDOhNVm+0d22GXWfcMnsZJNKTyK/im3Rkr9bz?=
 =?us-ascii?Q?1y4IrtKye3JquHg/lLqmDaU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hhfa1g2mvPWp8B/0YsCjEDGZ1nPJ7ZR5bVrL50DBTXL47v2p59z/yvXUHSH/?=
 =?us-ascii?Q?AFU8dZjuMiA3iHyfajXrfqL1+PDVj2r49geTGrb2mRXIaVnFtqcrbiM7DZM5?=
 =?us-ascii?Q?YjRlTTSJrsISiQv0O04G1xxvq7yPZcG7Q/6jui/qQTJ7wQx5Q3POP+MlWIiH?=
 =?us-ascii?Q?2F27BvJ6FiSAXVFzpAf7HqP3yFUlHFUvSBl9lYC68YyOrI8TTdUHpbINObmc?=
 =?us-ascii?Q?jh91Y661oHkErFmTTEf1VZhmAltgX/tRV1ftr3Vq3Moz67T7oJTr1q75RLzI?=
 =?us-ascii?Q?M6DLlAqOzl1ZqMQ2Oafbw8ThVQ8soy9pNoYNlqBe7DCNqsHKobT2fr/++qRt?=
 =?us-ascii?Q?RHVMkMRrtt2DiKtepFgcIz3+dFnePhaVgEKVRCLti5++ekHv3kwx5AgGR/Z2?=
 =?us-ascii?Q?/cH0Zk3UplSk7TRWGHFzGsqLQVphLHAXpCsQDW3X+s3GzRHMrq6GIBR1cguR?=
 =?us-ascii?Q?yGVua4OG3C3yWti+A5+Tnu5k/R5XX1obKmFDaEjQGvZhXfBhkr8fkZlmGpEM?=
 =?us-ascii?Q?VN4BW51p1Vp0TSepoZO/yO3HraqdHF0ahvYrF+gVR+MsgMGQrNa7yPTwX/JU?=
 =?us-ascii?Q?4Y2A0jvnGYFk8ueLYU2oEaUoPIarw7fH3Oj5BVl1mQzSZq5npJRTUHHzwAD4?=
 =?us-ascii?Q?3ad6+gypv4KF0cXHrjPbD9NVeVtKfQ7qnAhBatGWy6kYrpej9ezkTG20PD5D?=
 =?us-ascii?Q?yt8R+zsSqA+zIlEFWzfthyk1rZ9CzjAm73XpBkEbd2vuEuUpA8KzRImYXX32?=
 =?us-ascii?Q?2K/WLa60bMjXQ9mEEa2v7mkgYRiIfzbcqJJ0h3MubkeTpybVx2ktN8QxM8QS?=
 =?us-ascii?Q?VEJY5QE1CAnCs3fTz1ZEz/caS1EmJBI01mUtD5z1m7nTcNBWHL1kzjsI3dY+?=
 =?us-ascii?Q?LKua95yuy+dwKTzN8LLjv0QXo9mwh0/Vt9P/HtQHlD7V2B7BwsS+uycJrok4?=
 =?us-ascii?Q?Ka80NmdW5iNhZaUZ12TBgqzIHRMk5Vci8N2vChguE5UJWPl8aeaPyl8VwfgS?=
 =?us-ascii?Q?EPfFA8IjIFnIQ0bg/lVAV/jBJwbXAtzum43HWg8KCll6Z19Z5ztF16HkCPEV?=
 =?us-ascii?Q?S1ezu1QUWbdmBziasuX6W8ddlzzwRJ/WCWtDIF8hovcmFkL4nonkgBRX/qd7?=
 =?us-ascii?Q?le4cu5z+VaLoGVy3kIlgrqIP4OHI1zml/SxvZ/RjxDp7qTyo8EcTjTb2C4XG?=
 =?us-ascii?Q?3BLP0v55mI5PssWokkn6MVuS6bzaLhSxOhvCFCbtn65ENgLXtgdvC48qM1vR?=
 =?us-ascii?Q?v9RrShW0luZxKXYq/Q6SvvQ78DEjNpTW6UbWyPiD3AQ003P3zwN8g2ED9tP4?=
 =?us-ascii?Q?yILH5ybXCeF0+5H+LACh/BreU/sR1MsBh/slUlamZsDkp9DeE3NBrI4XjR/f?=
 =?us-ascii?Q?DVIIAW+jNztiLeOIaiV6wG/jSdayRN7QmVSFwEGmCtxcZ2pn/ZpJJ3jS7KFx?=
 =?us-ascii?Q?sC5B2RyWFKlc//A2MdNHCoF5iK7VnCk3ypzSYRxFfeZtPWjwpDcPF6h7Sa5c?=
 =?us-ascii?Q?wfWflTrahnbk0uqAwcWl+KERkZcr0dCclPxzQYqumnCrjnwAYniQbDVYWE4A?=
 =?us-ascii?Q?95V5/TG4eCWNpkkP/and8jO/uFKYkxSpp3f61Q71y4MsSW4k5rRL8sbDAJc7?=
 =?us-ascii?Q?8XM4gDMDOmfc3EKLUS9fc9pN91v0JxixHNyqycaztFsRE1ARsDewFbaNjXDJ?=
 =?us-ascii?Q?m1eURJ4IssDwYRbqfESDnUbc80/TaSVKxa/XIGu9at8B54Sl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf6ca8b-b837-41eb-a6c6-08de5fd9c3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 08:30:02.8199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+xmgGZP2WoSVffjCI/OcX+s3ERqV2rJ3kaInnkT9q1i1jwDcFH2vSvRCr3gyOrDR63Zo2TEj5N7gxzsyabKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping ...

> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Wednesday, January 28, 2026 6:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH v4 6/6] drm/amdgpu: add MODIFY operation for compute queu=
es
>
> Implement the AMDGPU_USERQ_OP_MODIFY ioctl operation to enable runtime
> updates of compute queues.
>
> v2: move queue size validate to a separate patch
>     remove the check for AMDGPU_HW_IP_COMPUTE  (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 61
> +++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3
> ++
>  include/uapi/drm/amdgpu_drm.h             |  1 +
>  3 files changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 256ceca6d429..3003aba22e1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -837,6 +837,7 @@ static int amdgpu_userq_input_args_validate(struct
> drm_device *dev,
>
>       switch (args->in.op) {
>       case AMDGPU_USERQ_OP_CREATE:
> +     case AMDGPU_USERQ_OP_MODIFY:
>               if (args->in.flags &
> ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
>
> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
>                       return -EINVAL;
> @@ -901,6 +902,60 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
>       return false;
>  }
>
> +static int amdgpu_modify_queue(struct drm_file *filp, union
> +drm_amdgpu_userq *args) {
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     struct amdgpu_usermode_queue *queue;
> +     const struct amdgpu_userq_funcs *userq_funcs;
> +     int r;
> +
> +     mutex_lock(&uq_mgr->userq_mutex);
> +     queue =3D amdgpu_userq_find(uq_mgr, args->in.queue_id);
> +     if (!queue) {
> +             drm_file_err(uq_mgr->file, "Queue %u not found\n", args-
> >in.queue_id);
> +             r =3D -EINVAL;
> +             goto unlock;
> +     }
> +
> +     userq_funcs =3D adev->userq_funcs[queue->queue_type];
> +
> +     /*
> +      * Unmap the queue if it's mapped or preempted to ensure a clean up=
date.
> +      * If the queue is already unmapped or hung, we skip this step.
> +      */
> +     if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +         queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +             r =3D amdgpu_userq_unmap_helper(queue);
> +             if (r) {
> +                     drm_file_err(uq_mgr->file, "Failed to unmap queue %=
llu\n",
> +                                     queue->doorbell_index);
> +                     goto unlock;
> +             }
> +     }
> +
> +     r =3D userq_funcs->mqd_update(queue, &args->in);
> +     if (r)
> +             goto unlock;
> +     /*
> +      * If the queue is considered active (has valid size, address, and
> percentage),
> +      * we attempt to map it. This effectively starts the queue or resta=
rts it
> +      * if it was previously running.
> +      */
> +     if (AMDGPU_USERQ_IS_ACTIVE(queue)) {
> +             r =3D amdgpu_userq_map_helper(queue);
> +             if (r)
> +                     drm_file_err(uq_mgr->file, "Failed to remap queue %=
llu after
> update\n",
> +                             queue->doorbell_index);
> +     }
> +
> +unlock:
> +     mutex_unlock(&uq_mgr->userq_mutex);
> +
> +     return r;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>                      struct drm_file *filp)
>  {
> @@ -920,6 +975,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,
>                       drm_file_err(filp, "Failed to create usermode queue=
\n");
>               break;
>
> +
> +     case AMDGPU_USERQ_OP_MODIFY:
> +             r =3D amdgpu_modify_queue(filp, args);
> +             if (r)
> +                     drm_file_err(filp, "Failed to modify usermode queue=
\n");
> +             break;
>       case AMDGPU_USERQ_OP_FREE:
>               r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
>               if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 833468b58603..7cd1ea94e368 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -31,6 +31,9 @@
>  #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, bas=
e)
> #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr=
)
> #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr,
> name)
> +#define AMDGPU_USERQ_IS_ACTIVE(q) ((q)->userq_prop->queue_size > 0 &&
> \
> +                           (q)->userq_prop->hqd_base_gpu_addr !=3D 0 && =
 \
> +                           (q)->userq_prop->queue_percentage > 0)
>
>  enum amdgpu_userq_state {
>       AMDGPU_USERQ_STATE_UNMAPPED =3D 0,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> c52949ea8c1e..aa9b31578c6b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE       1
>  #define AMDGPU_USERQ_OP_FREE 2
> +#define AMDGPU_USERQ_OP_MODIFY 3
>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> --
> 2.49.0

