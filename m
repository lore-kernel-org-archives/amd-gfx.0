Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196DAFD9E34
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 06:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04FC10E115;
	Fri, 27 Feb 2026 06:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dw8FsNbn";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6D710E115
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 06:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jylg3RjwFjnEHO+Zycutw6LP0EClGOK8D6Kb+VG33mAIWgMTSx3rAVfh3p1olpGcIU5/h0YiDb4RF04Xwm8xVlWx7m9rS8/9didtalz2khRX8wqbjsa7ii3ljEAWUFsk3fIr6Ci0KYhUvsXtphrg52qMyygyoU73Ne0LGmX9lK5nBfZqMOqSlafb6xRR8EIVpWpuqBejwMzP9uFJQ9/3qVJbKPI5Pb2EyL1anZvlO9k8dRrHmEIZNnspQn5ZFfPN+Yyh7HUnAQbLoZvyHkltX7tMaWOa4rpLquxAOgz3sjGDQCGuM8CLYYwE0eLlLmuYqMzN5w4Nmhk4BwltWhWeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1EwROVqSDY0rKaos+WWHUXsGnWClWfT6y7qnxuN+oQ=;
 b=qqIXra5RBs0to/vfz3p4yE5akLgiuNjJ34TfJ2NgFw1wyJHyRm3e62qxGExsnpCpS7yJC+hYeRjRv/Sa+tT+n1doDJ7owHMYv+PYbs+pH0dNnQdyrh/kAK/VY2QpjqlQn2kpkAdNcNkNTQ7ICbQUXQASyuqiveAfEWvkIgKcbqiunaFQWgh6aBrUUJ9Vp5KNYY06t3v6zmeUWSfkvrtisvrZBMkKu5lIC70lD7Uxt0QisSR6/TWW5aWBT44Qc1IZ0aMyj4Wege5sYgnXQGTYs0iFUyobDH/XLYN2vDQJLAua4EwfGi2d5n2M0HHVV6H9Im4/cCG1v8cNLKXUCir+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1EwROVqSDY0rKaos+WWHUXsGnWClWfT6y7qnxuN+oQ=;
 b=Dw8FsNbnAS7MfYmjNuDMX1lTSbXs/2ZwqoCLxyrmTBkRDYsbacK2yvQwDcYa604BioNurTUjbZFRSXD9A2In8QQO4n9jlc71ofOef4M0Eg8LAZG3PIVN5JbWDf3MwQbUtJ0Vn2V5QMu3GOvDBZl2cKxyQ5LfkfaV/KMIF0gXhqg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 06:15:06 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 06:15:06 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe"
 <Jinzhou.Su@amd.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amdgpu: Fix static assertion failure issue
Thread-Topic: [PATCH] drm/amdgpu: Fix static assertion failure issue
Thread-Index: AQHcpxYaLKmtk5TsXkGkjTLKtTyM6bWWEo2A
Date: Fri, 27 Feb 2026 06:15:05 +0000
Message-ID: <PH7PR12MB87968751235E697792D265EEB073A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260226114944.610238-1-YiPeng.Chai@amd.com>
In-Reply-To: <20260226114944.610238-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-27T06:14:42.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB8449:EE_
x-ms-office365-filtering-correlation-id: d4d41231-0ea0-47f0-60fd-08de75c78d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: wtiA2Fz8Tb0SCYYOn71DIvUBKAxZCDg5wQ36CVz+ukaBDe18/SMCionzENFdiO/apOl0vxMYNoZfgAV6nFGJgW5Dz2w9VoAy+f3NHjkOO8Wxi8xwXoFF4iaqxZTHq8lzfTPYPu3XAwn3jb63QQzbPlLnl0V5CIBKfQm6cqLvZnzzR4vfcOomDtIzNBO+IJfq+//hIcL0vb9+g6oJJH/DuGuXW4GUlJBjoWe/FbjA6dwqmABeAn3D9MhAItOmJd6d0BCTFrQQbuYJ8Ve0hvaKTl2k8DoHgXiIpZqluL+a+ECUgvzjlhz9YlpAvXHHI7RkLtqMRrgfm80F99mZeEo5m6cJ/PvPdwKwtDqrQ19+MiJcCr78b5FQTxXFIJCdq2bwrLD9Sc0MLJaZIW9BOlSmT2SJwMnIm2OZUVrfiPw+l4YFA8/vzuBVRRuVnaHak5FMaXEws+Uisr7O37cBV/QrKoF6g22ufbEZOMKE41LImVL0d9ROMj5HNz5xGcrHjBnGtyMC/p3I/19wKYHLONzg40wX63IK9ZykvYPBZeUzGDDJdeiFvaDIZZEhAPwNPDwZVQ7016ldxL5ETKP5SKNnfdREDAl01J4vOc/DaU10so8HcWl2oVTjy2ajJ6L2jTE0xB+UrM0tlklfitjj/WXVTvalGgTkP2Nh1NcvxD/lF8+jqorOF8xa/3boL6sEnXajfhZ9JMVeLHcZH/UQjYzxBNPrO+ocw2QPh948LSL6hPhfDE4InCmTUykGh0LNXIletfABhx9E8M5P0MFSMAJoiPodUKAyamYnujEGOl/MlTw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVi+EL+Zk35Iv/XAdBf1+eA6qMVGlVugiYu0DUqXLOWU0FjQBL8xVpyl1uHN?=
 =?us-ascii?Q?mpGwmzOa9t9w+MVng4wdiTULviTG2Owp7nZZduWOD16RzabVQI/oeGSkjINE?=
 =?us-ascii?Q?4ilSeC9BkNg7ElUDjTl3+/dP0ZfNZoBW6Q/YH/CtB9dwNxOjCV5sveRlzLXN?=
 =?us-ascii?Q?PILwn9CEA4OhkLPsC2B4kmpg4TBMuZZjsV6saxSQsUWd8KSlT3esRbJ0c/8I?=
 =?us-ascii?Q?5eiHGJz4KTMIJRW0GKCX48SO2cvkGvOfkUG/4FRqaW67bOZnt5IAiFb/2uL3?=
 =?us-ascii?Q?3Ek6Lh0UD934TLY5IlUJiZYFJjoHHA6u+VkG4X1UL5aATDd7pV+YIOm/6obS?=
 =?us-ascii?Q?8YisUS8xYaOhEZKdG6tqCqXNbA+QL6b9qq2vjAmD+SqRpRKMg6oYFaSs28ZJ?=
 =?us-ascii?Q?zAFuxhZ14ovLzhnI6F0CHRpdOH6c9MzLccbmrJhVQFVZAoW5NzQGSPWxTDk1?=
 =?us-ascii?Q?3jKbX3SrK1QlcUjxa4eyo4LJbxZpOCsFpvEg84rEDYoGDJ16efx7O1hcqwW8?=
 =?us-ascii?Q?MzvMUhEJny3dCjuR0s+ChFAu8qa7kjXl/hpJNwGEKFq1qR1+7FfpIyIYhyI7?=
 =?us-ascii?Q?CrP85ralyLfNfgR14dGqK4UdMdYhBAtQbGVLV3gaFyp1zELuWK7b3TBDSduu?=
 =?us-ascii?Q?KT5O+qKGP5PQnAdbSHfjJSacXhKTkYwgoZvqdK+wLPFxNb5V3INQvLijGrCS?=
 =?us-ascii?Q?X4udLmEIBW1KWVHso9cR1R7RAq6CRCrraM/KpHQa6s/gvIC3zUo5yhdh5Xrx?=
 =?us-ascii?Q?ZYwW47AiwGKQ++zpm2HklYls/UrEkfiibr0AlRDgfO06DibpzhGURq6GL8xA?=
 =?us-ascii?Q?1sn+fYYTHLpy7xDHaLnfxCjQOsNdoKLTbM0yws7f3NbsVjQsnwJ8NuVlVBFD?=
 =?us-ascii?Q?pLba1wh5HvZ/2zqwOr9Pa9nYRjEcfBZVrSBkwrU7YhCr04Tx1iTCyWgEv1VI?=
 =?us-ascii?Q?J6+BYxLeBi4NIIsuTwhJs4v419QccYE+QdAnhiq9nSGuwjPa4nI6oh3XZyaf?=
 =?us-ascii?Q?CyFnziDYrS78tj7UCbEfxgG//dssiX6ILwV+GGVWY93UKE3CG14LchM/cb5B?=
 =?us-ascii?Q?A2t6Xg9tkXxAL6VYzjo4eGhsTRfSbcOD2bbD/Oeg9MvZVWAOoC2l4L6gXe7u?=
 =?us-ascii?Q?Xn7MXGTAnEGkLB+uPxkCn62Yc1sAGZSKPdG8l5yhepsDWZO5elrGx+OikDkh?=
 =?us-ascii?Q?lbE3V9+v7dtPawNLu/ByebqiAvuFxWnmqFbkGV0NiTu9ZMgVsuyGAuTvIq/w?=
 =?us-ascii?Q?yHZRe0jlmABk5AnTFF8lGMXkjbDlLTBuuHhANgoXjR1In8sKB9y6I8wQSoC0?=
 =?us-ascii?Q?NIFkQx89GKLov5O9ZQV3YRvq0OJNnU0oREzKo0JXU9LgKMo4Ss6LsQJwkdKM?=
 =?us-ascii?Q?sbn49z/gVI8uUCO3Y/9iyzL3B9+uoWhMh4xpMkJ05Bkx1CEY0qR4FNP5YhSH?=
 =?us-ascii?Q?YKAatqcDNElJ7VwLT6F77IlPLV9IYvNL50Ml/lIabELj7T1leBK7W4b8r+2+?=
 =?us-ascii?Q?82oPZ75v0KpDpcPQjRQdjJjfS3LeznCQK233d74ldZ6DyU/YMMjEpNmLMjQv?=
 =?us-ascii?Q?NwT3WiwTYerAQDmfIOHXXLfwRNx7KPYhjZFwhtHlX6k5URtScspWApH+6jqa?=
 =?us-ascii?Q?ALw7eTBNjmj3I9MtQwvJdN92hV6Wu7LGVl7L8gY7ecIFFHY1zMtuAlncGc5H?=
 =?us-ascii?Q?TbSMxiL+irt8eo8NDTF3dvuoOwasPMyZS9MtLLATRHMBSH6a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d41231-0ea0-47f0-60fd-08de75c78d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 06:15:05.9156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8B0e48zveDDbdWyau8d54UlvkHXY1sHOhNxS62301uCyinRH2hu9a4S2/ukjQ7Dg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, February 26, 2026 7:50 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; kernel test robot <lkp@intel.com>
> Subject: [PATCH] drm/amdgpu: Fix static assertion failure issue
>
> Since the PAGE_SIZE is 8KB on sparc64, the size of structure
> amdsriov_ras_telemetry will exceed 64KB, so use absolute value to fix the=
 buffer
> size.
>
> Fixes the issue:
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:522:2: error: static  assert=
ion failed
> due to requirement 'sizeof(struct
>  amdsriov_ras_telemetry) <=3D 64 << 10': amdsriov_ras_telemetry must be 6=
4 KB  |
> sizeof(struct amdsriov_ras_telemetry) <=3D
>       AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10,
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:522:40: note:
>       expression evaluates to '115616 <=3D 65536'
>  |   sizeof(struct amdsriov_ras_telemetry) <=3D
>       AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10,
>
> Fixes: cb48a6b2b61d ("drm/amd/ras: use dedicated memory as vf ras command
> buffer")
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602261700.rVOLIw4l-lkp@i=
ntel.com/
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h           | 5 +++--
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 4870c03627df..a841f342a3eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -476,9 +476,10 @@ union amd_sriov_ras_host_push {
>       struct amd_sriov_ras_chk_criti chk_criti;  };
>
> -#define AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (PAGE_SIZE * 13)
> +#define AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE 4096 #define
> +AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (4096 * 13)
>  struct amd_sriov_uniras_shared_mem {
> -     uint8_t blocks_ecc_buf[PAGE_SIZE];
> +     uint8_t blocks_ecc_buf[AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE];
>       uint8_t cmd_buf[AMD_SRIOV_UNIRAS_CMD_MAX_SIZE];
>  };
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index 3e8b500caec1..81553230dca4 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -63,7 +63,7 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct
> ras_core_context *ras_core,
>                               ras_telemetry_offset);
>
>       if (cmd =3D=3D RAS_CMD__GET_ALL_BLOCK_ECC_STATUS) {
> -             if (mem_size > PAGE_SIZE)
> +             if (mem_size > AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE)
>                       return -ENOMEM;
>
>               shared_mem->cpu_addr =3D ras_telemetry_cpu-
> >uniras_shared_mem.blocks_ecc_buf;
> @@ -504,7 +504,7 @@ int amdgpu_virt_ras_hw_init(struct amdgpu_device *ade=
v)
>       memset(blks_ecc, 0, sizeof(*blks_ecc));
>       if (amdgpu_virt_ras_get_cmd_shared_mem(ras_mgr->ras_core,
>                       RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
> -                     PAGE_SIZE, &blks_ecc->shared_mem))
> +                     AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE, &blks_ecc-
> >shared_mem))
>               return -ENOMEM;
>
>       return 0;
> --
> 2.43.0

