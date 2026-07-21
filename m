Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6344C44515
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 02:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529A610E18D;
	Tue, 21 Jul 2026 02:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w0wMZ3Ox";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5775710E18D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 02:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp8HeeUqEdX2rM87NorP3r8G3gKr5Ri6SyiqVrm7fuJNLU8W39bvgboaBZFeOXvpbfT5NZZUAJKhAE3zln6IeQsQx1ZK/Z/SmY4q3deD7qAsgI9XPF+ofUZ1RmW14D3be5vh4eEYos7lTv2sEf4Auf3OTFnfHXSJWCxl/MggcKEtirr3pHwkI6YaBOYrHe/kAdzpZBHI2cve+36OY5ej9k2PSxyXIHUtkeqjiSpG2unZOf41pFBMNrQTxd76yL5J3XxuMAXtpS8Ots4Q+NnKqg9Mx1IO/w5Fgdz2p9J7+EllqZSAF7m3cuhS9QHDjORIS7QyZyGq5roZxCjVV+GygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C/2J81o/CFiVNdS0TljxoKJS0IRfPptYhAHPh5ZiSM=;
 b=ZKRynjlHaVMKYrOAFawEMGm6URyaPFjszdEwh8sT2QA/KxbeiBmkVcBmA5x0cxSNmjJ1Go6a9QPdkuOW2XytnIE2wf39PF6e0XlAAdu59RBE8ABIs5mb0olvc1KWxvQKLBCQah+P2kB7b51KbTi654QlZTFjLv0A8vb1UV/ZyIJFw9bDasN23vRcSqqLv6Kh3DUmck1yBb41hSu/dbiKVUQ61Mp2lm3qyudW9uRIRSW/EVQQB/yaVNWkKI2u1Ts5eSEdx5vT8PLmJAJdlUXfXrmVXZW4bTYS//jQqvFPLP6h7B6LnCzL6BnuL1kLP8sWmncvkurw8IY6FmDluslPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C/2J81o/CFiVNdS0TljxoKJS0IRfPptYhAHPh5ZiSM=;
 b=w0wMZ3Ox050qrk8l1IlJhHUNuZiEGhsJnLbsIS2cttLYMUpDPX96+JgGV2smjdzBGvNY+UEAvTbAvyP1bbtyTiz09jJh8O1ppvy+ypiFA7FWRR3yPFcrgnghs4/Ns45PJ63LkTiAxbeD/cbArTGdv+A6+cJnMkLAdxC8aI2TKFI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 02:10:51 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 02:10:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add missing MES helper parameter descriptions
Thread-Topic: [PATCH] drm/amdgpu: Add missing MES helper parameter descriptions
Thread-Index: AQHdF6Usin17VU1n+U++dJVhBqq3wLZ3PIkw
Date: Tue, 21 Jul 2026 02:10:48 +0000
Message-ID: <DS7PR12MB6005C8C9C61904AF2C242129FBC22@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260719173627.3598744-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260719173627.3598744-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-21T02:09:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PPFAF4999BF6:EE_
x-ms-office365-filtering-correlation-id: e0115b73-21e1-492b-081e-08dee6cd4839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: S0GSw+t1k7lpdXYOFkAXZSBNnM/9fattakYlv8KxQfRBjO7x8uQfKI1dAc2uBCGhUX++D3FSgULTPhhRcV05hABajPIHYMpZO7T79W29SK14nKhirsbCpAafEamyCX+LXBZyjLFueGElaUC1FrTp5+gd7x34zrHT0oo8O42RCD8xa799a93WE4m36vTar0+Qpd2lh9FS9X/G9l+S/4onqhc5CAtTZ7mTxVToDwva3FFY0A7MQPTXFz5RXfFxWZjQiq60cg0z3l35gaAcPepv6KL/fIYEphNjfxrANMJvV5fcOdT3z5zL8Z5u3iqaX8RWJTDAcIWKtQV8cC0zI8vwu99JoHEC5T/M1QugIBGj1VJC7c2LNOu4A+60kaBFif6uYmBNuG023E11+nHuJ3V+NtOH/DSpK11zHb3fxgIoi8X3p0QgrR8ykfIDZ8Pni3nCk8nxlHIqK1cHNAPsx0gpB62kmegbizqu/8+BBq2riAjz7hughNCO/yF5x4e9dBI1t1fWHhbFx9Xo/IOgw/DGm9hY9yjM0G1flY4zN18qBg+9zDnf0cdelIaPFZfDAonGCG6lN6jKDUrz06d9zvYwYXuMiqm87bb0iij0mDx3emdPiNE3ukSiz9+QUZrqyaE63m4E9DnAXZjZqNrghXL+TNsT0UouHc2KbDwNsuNhBOZpxfKJqEw45U1liImq6FX+0k9wCMJZlF2VE9hRG/Ww9QtziICW38YVomQXq3WmKXA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CvrNfODRAmMRYpYyXkGM0WIl2nurTvCpZB96we7WrwjFkU9Jm5qQ3wJFO+sq?=
 =?us-ascii?Q?AfPQacJhBqWDj7sBqwx9qXnBo5mQNY/VovzQvAwNap3k9z0oDlUtpZScdhkk?=
 =?us-ascii?Q?lGHfB+p83OmbUXUr0qvx8Mh3JRrnGdkdkrGmTH9MyyYHO2LWDcPAuJEdeW5i?=
 =?us-ascii?Q?+mPe9DfcKXqQ1TQ0XXou/phtyNOY+bWoB7FyGBvuc0e56EV4a86i5iLCkF4S?=
 =?us-ascii?Q?n68d5WiVmwxOQV4jb+QbUeWgUUA00/AtiFLZ4E1VWIcb2udvJtf10eK65sZr?=
 =?us-ascii?Q?cYegyZXhmQFmhZN37InymOshFa1ZucQFBKmn6ThNznU1E7XQv0/zNo5qNckE?=
 =?us-ascii?Q?yN2IVePGhujKKu+W9MePPVLLXYQts7KvmoXSCbO9ea4Z0NXpRPn6l8cTz+Vs?=
 =?us-ascii?Q?39Ko0ieeNhfJspVUcxRcmm5Bgct5DtKOFrEKYDxYYc81/6QHGyp1jfNWNcEt?=
 =?us-ascii?Q?VL2grjXoW41kVAqb4zBbNMzXAdQUS7pFsBLfw3/qkR5sDN/tAkQN8rYUhClP?=
 =?us-ascii?Q?Ivk57+H16iAX5Or1DG7h2ZRIffQj1IHBJSNnXVroqXmHoRT0q2wx/qSzADeG?=
 =?us-ascii?Q?BNEkBLTRvXf9RAdZJSnYd36Yi86dZL2NhFcYC7Iccvocf2fuR/Qw5PU6k3kd?=
 =?us-ascii?Q?ktxKtIPDA3r6+iW5ELyq3IYAX12TPeIZwUMkb7wxZOFuNDC+uJQJ6I/76enf?=
 =?us-ascii?Q?JoaYpqCtzYtngc2HGsHyk8ayJzPCLsSAVABJ1v9mthTNHr0C8j/l+d7ao82r?=
 =?us-ascii?Q?2y3t48VNzzDC92PgES3pVcKyu+4g5ys4yI1yoF1IMoXuyQVRBywsffP0b9Hh?=
 =?us-ascii?Q?LZOv/9ZEDHK0ENX85Oig1xeSmeod50YBWM0UxCF/gFHzdTATFIKdt60aVaCR?=
 =?us-ascii?Q?3fxP3eB3qQ9oOweifV+NZ149dCV8/iuHpxWmA/RIFVZ3RvSmhAfIoUfni5rI?=
 =?us-ascii?Q?CKnNkbADHcrQ192qDQTTGZJIiMfgHCZ48qOQkAMDbHtO8JU8Heh5c4GQM/3X?=
 =?us-ascii?Q?JeqyLDqtkqBeVnYVex1NQej01uenKyUzPRvomu2U8FEeNq1MAOVWJlDlQtxy?=
 =?us-ascii?Q?Fc1yaMLvUT6ML8q8tF8Dc9sXa5KyeTZoWAcGT4ELBleSJOIlni4QED96UYbf?=
 =?us-ascii?Q?guBqUNXM3c9A6yfdUTpPsQgfMBmdR64VY3rE+0hpb7095ACrbATSuJamjXOQ?=
 =?us-ascii?Q?Z8TI6IAztXShuUwwpke5m+Qw3d0emmMhijouKPA+SVIwTnyhTybvepviMhYq?=
 =?us-ascii?Q?eVQ3j6tEGOEo4JnLIY/kQVlHAOoL9U2lvH/xdPS6FTYKHhpr9WT3RYC/dGx9?=
 =?us-ascii?Q?0+D1FPpoOIPt2qYxiPto+GPOF8mZhhe21DVP/U6zwm/i+pthsjopC1UeL6aw?=
 =?us-ascii?Q?jtXwqNIaPRlDV3r+2uOWWuL8Qe3U5yXrJ4K2O877cN/qB3+40LfncVBeUttJ?=
 =?us-ascii?Q?TIirqpgpApWrk3zSJfjFvq1eaqbu4kwlnHT0LwCaEW/1736XDZYlVtEWznOW?=
 =?us-ascii?Q?fwYK4LM2JtlfnYVR+7Vm9vEnkL1m6wBuwbquRRLDtjzH3gWMyLwHjaH3IQhh?=
 =?us-ascii?Q?eagvWSMoprC7Faw8GXwhWKF8jVTO5kHJJyrlUomVwxxFmysF1I+myoV5t3bu?=
 =?us-ascii?Q?/MfwZnmuyLOmx8pwqE6kViXxk/Bntg0SI4hPOxlXyPUq4WoKi2WtZZrW2xd/?=
 =?us-ascii?Q?mGimg9Gqa3TxJtT2ptk9c00cAPxwTIxs2dHf4HWnYwlQ/a9d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0115b73-21e1-492b-081e-08dee6cd4839
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 02:10:48.6949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdiPbYpSIpLQdqPufe9cR4zYloMU9LpqFN0ZI8sxemchE1OVLOzMeS9EF+h1QuZn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6
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

Thanks for the fix, but I already had a fix for documenting the MES rs64mem=
 a few days ago.

Regards,
      Prike

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Monday, July 20, 2026 1:36 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike <Prike.Liang@amd.com>;
> Chen, Michael <Michael.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: Add missing MES helper parameter description=
s
>
> Complete the kernel-doc comments for the MES RS64 memory, process context=
,
> and gang context helper functions by documenting the missing function par=
ameters
> to keep the kernel-doc comments consistent with their function signatures=
.
>
> Fixes: d160cbf3e4db ("drm/amdgpu: add RS64 local memory context array ini=
t/fini")
> Fixes: dded4c22699e ("drm/amdgpu: add mes process context alloc/free")
> Fixes: a755b0cf3ef3 ("drm/amdgpu: add mes gang contex alloc/free helper")
> Cc: Prike Liang <Prike.Liang@amd.com>
> Cc: Michael Chen <michael.chen@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 43 +++++++++++++++++--------
>  1 file changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 1e3a23c81552..9af7c97af5be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -952,9 +952,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes)
>       return 0;
>  }
>
> -/**
> - * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
> - */
> + /**
> +  * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
> +  *
> +  * @mes: MES instance
> +  */
>  void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)  {
>       if (mes->ctx_array_size_bo) {
> @@ -1038,9 +1040,10 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct
> amdgpu_mes *mes)
>   * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
>   *
>   * @mes: MES instance
> + * @queue: Usermode queue receiving the allocated process context index
>   *
> - * Returns 0 on success, -ENOSPC if all slots are used (caller should
> - * fall back to system memory path).
> + * Returns 0 on success, -ENOSPC if all slots are used, or
> + * -EOPNOTSUPP if RS64 local memory is unavailable.
>   */
>  int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
>                                   struct amdgpu_usermode_queue *queue) @@=
 -
> 1064,9 +1067,12 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes
> *mes,
>       return 0;
>  }
>
> -/**
> - * amdgpu_mes_free_proc_ctx_index - free a process context slot
> - */
> + /**
> +  * amdgpu_mes_free_proc_ctx_index - free a process context slot
> +  *
> +  * @mes: MES instance
> +  * @queue: Usermode queue whose process context index is released  */
>  void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
>                                   struct amdgpu_usermode_queue *queue)  {=
 @@ -
> 1080,9 +1086,15 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes
> *mes,
>       amdgpu_mes_unlock(mes);
>  }
>
> -/**
> - * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
> - */
> + /**
> +  * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
> +  *
> +  * @mes: MES instance
> +  * @queue: Usermode queue receiving the allocated gang context index
> +  *
> +  * Returns 0 on success, -ENOSPC if all slots are used, or
> +  * -EOPNOTSUPP if RS64 local memory is unavailable.
> +  */
>  int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
>                                   struct amdgpu_usermode_queue *queue)  {=
 @@ -
> 1105,9 +1117,12 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes
> *mes,
>       return 0;
>  }
>
> -/**
> - * amdgpu_mes_free_gang_ctx_index - free a gang context slot
> - */
> + /**
> +  * amdgpu_mes_free_gang_ctx_index - free a gang context slot
> +  *
> +  * @mes: MES instance
> +  * @queue: Usermode queue whose gang context index is released  */
>  void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
>                                   struct amdgpu_usermode_queue *queue)  {
> --
> 2.34.1

