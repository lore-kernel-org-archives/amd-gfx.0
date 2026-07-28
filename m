Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A66DC54F4D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 07:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2D710E7EA;
	Tue, 28 Jul 2026 07:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/QSv70v";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BCD10E7EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 07:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ7vY64MhNfpcu85FFriRklIykuwJm/+mpXWs6HOhyhO8ILVZbORA6xrRJqBZvwGb98P7n2FCQHS4q6ZTyCERBQhI8slYaD7y5AEWMzmaGsUc2JdCTPlyOg2TFQepvSjEAAcX398qD4aFkt69AFU5kWpdVDTFt6rKMqBOdWb0DPyVSLpQmMaoHp12PUDStaL/n0zDjFjqeMYocizxqoWJ48wxKGpE78LhHnqQU+HRiF4CFgv/Q/lTMrRsV+iTwH8irhcvG3MsklYgdbUnTuz7TaWLnat51NhV/IepYjCgpaUJqUFLjWER2vOYH1uth+gPYGYB4LwG8tQv73EJe9Sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIYWeus1MbFoSv3au3AiCAtbBSLEsfUkxYgRREQ7rvk=;
 b=BrJtRhWh0JBmZ6UnfzQ3HjM27OaZ8JoDgoSGns0SzxyKUm5c6yD/8A4EXlpIyr7a1VwrTBMSruup0L24Ap82hjV+Ml3JayXRa0TqbKJGHibLD8kgK2nAoGX6U0WT7S8YlOoiWn54o9RbfXCNYVh1hAYvi3hOe8+gMVPqo/bpuKAeg1eCbHTyrw/NKPGPOdHNHtJsbdWdE4j/AmgfgpFwDQsHeDq3O6liIMTlUgGRROAGFHOHr2HOtqwrG+HU6u7HK0HKDHFEPsjQpR6ST+8b9lFKjOP9X2xU1udr1tKOBLEcTBeq4x2Nt8jobSRz0cOGdVDavrGuXLWntgzFfyyLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIYWeus1MbFoSv3au3AiCAtbBSLEsfUkxYgRREQ7rvk=;
 b=k/QSv70vBHNjOja5sm7XWVo7l0ihbKbgAjLJpmACuh16Rjf6BJ0YU19IETW/kaOLc4pdpR6XSn2FsuMt0DSpURjzLMRTNtzJCh6PNwaRW6ExdlzbaW550y3C2tR9LvJS/H3vWE9zy9L/epoFJw8MRWJ4vTuzfnZ9mNl8uVQGkdk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 07:32:52 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 07:32:52 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
Thread-Index: AQHdHjLzUfkZL7jeYESPiX5LUgoZCbaCeYIAgAAQZ0A=
Date: Tue, 28 Jul 2026 07:32:51 +0000
Message-ID: <DM4PR12MB515250C99F5D181D66A2C932E3CB2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260728014631.4001668-1-Jesse.Zhang@amd.com>
 <DS5PPF18A985A1013940619C970BC39BED194CB2@DS5PPF18A985A10.namprd12.prod.outlook.com>
In-Reply-To: <DS5PPF18A985A1013940619C970BC39BED194CB2@DS5PPF18A985A10.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T06:30:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH3PR12MB9100:EE_
x-ms-office365-filtering-correlation-id: 3dc3abd6-40df-45dd-cee5-08deec7a6eb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info: E8aTccnWv2YLUY0MRWL0sPQ1dSD47z6CCWTIKB9RolH9vbmkLOp8L7NumObT0u9xcL54CCt2gxu2X4Qrn9S9sQuQRTXqUHAMiEL2eAKDDUvOoGTHNEJLq+jXwoXral9MLj8LVX3k9FBC1FZSnXxNkxSP6MIleynR25wc3/n8n/O0ur5BeHdDrqIOk4DEmHMKhr+rclKRpmvOjS+nlDzrCjb0vTk8yAP6J5yyrRdmKY+8DeJYuBsiifmSzXO5wuQqEgkl7jG336B8aZK8MYYy134ZRXcskc3QOj1q/tKVEoCwsvnL+gwroSfHYQFD6tidXdafMpOQqWRG3jqiqw0pPUhxRpVIYW1og6Eo1SLybsZMZzckGxoksylkoUKYdM2Oq5K/lRFUfI7m5AckkWTtLC5eIRUe1jBH1iDDTZ80lTYQYDbvW2ulmmUzeF4JUya7TLUrDaKi9z2vCz5v+zB1G3e6nyuvjCGe1fgIXzI3GlRYtnXXJxrBriVntRDtSFrLZ0xWkNUAAx0iN9QyWU86vm/NvNLTdp+//tgRc1xgfNKIsldJhJDrMzWNfmx0hUO3LH9u5ELX2yCJjESw4/FHB17uQNBmoFQM+L4yvReyOLxGs0m5wR57+mfpVPHiERYz2RTg8hJIFJP2MvZgWLIrJwg5W3rRwhw+2dS38ndUH4HwdwRCpcmiT+dN8AffOtwID0PLJMKM+PjhGW3ls+6/QxeQC+OcDmQBtF+9vbJaCtk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(3023799007)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fGJ3I9MIAwicj7zYYSMiSu2M8JckxGj7in7M0ZLUxER4V3EDqJUnUFiI1Xsb?=
 =?us-ascii?Q?nIlaKd4Pe26ik0IkRrwrHK1x9kOT8WmidghEKiyMHTVA370Y23juxyXhaUei?=
 =?us-ascii?Q?bjLWTDUE3WlJmDdTAzHxx8FPKJGfMUMwL0Ad/y6ytnwJ9sG/nSa9CV0KqSAK?=
 =?us-ascii?Q?BmHBAlly8AT6dMemW8NrU0YBTzmLFJn02l21i0Cw/DzXnaSVejBGwxWDNfp1?=
 =?us-ascii?Q?QREzxhf6gJ7OC/hfo336oKHB08bpOEntj32mwwxKyidDrS38UpVA/WNguFKp?=
 =?us-ascii?Q?sSaJCxFaqu0YOQenVbGfm54IyUSArVIYQfGJ8U5V4zCZZ+Wzom3B674Xl3mP?=
 =?us-ascii?Q?XgTXVHFLkoOLTJN3JQfalh/EzIuNfgd4TRE4dpHFK9odaaOSb0NpAn3vIO1x?=
 =?us-ascii?Q?KOt1JAKZgqqnEuAdGK0SHKuQab6f/Yq85n5pdY533hBzI8Slnvfm3fM5+3iA?=
 =?us-ascii?Q?e5oOGNz+Bi+a5ugPGkJxfftiugkMx/iafCmbBUOJd8xl+yvvf9FxQXJRgx7r?=
 =?us-ascii?Q?L4THBpSsZTmQ0a0EIN2IOZU6ViIdtg2u7hx73w57GigPSvMO9SY31142ytKd?=
 =?us-ascii?Q?NUap4j4u40DDzfHUTqeuq3M7wSZMwHPvv66RtjPytWXq9/jv9Y2cQ556CbqM?=
 =?us-ascii?Q?2cx4LId4ybsOM6WrxgaDVUtODdlzyiDYbaldSj+GACRq2jNhVuUdd3YKznoW?=
 =?us-ascii?Q?RgmRzWRWoNlf0SwT2GOAlh4hblAJ6JiGUwKcDshxUh/noPEmstBWKoLhYbkT?=
 =?us-ascii?Q?A4Dc1D6RqeoNgnMCVir0aHT58gXe7U9hXAa0zpDmrHW7ee+VCBjf8lQdTNBX?=
 =?us-ascii?Q?/qA2SZh/zgQKHc04cKkIKxEokilK1kJYhgJPQReHAzzM9JFV2P+YYKe0hzrX?=
 =?us-ascii?Q?jdOAamM3XLhxBIO+OAyPhSd0phFnypRdTCTYA6Jb6YOf0H+BCzHNFMbR9T0f?=
 =?us-ascii?Q?/gYFFWKanonQyiplhzzDQCMNTEvHUv6iqyCcEjub8fBUkgGuIcOqPDFZ0aFO?=
 =?us-ascii?Q?05Na2pAKv6Mpec1FCwmPgh96j1ZmOjPyjCKZn8p69UrYoT5+CEPhfZF3i87b?=
 =?us-ascii?Q?CJPxzpGe4uCusSczUmtqgfPlTLYANEc781khfHaDliYIyOTQ6/+ujd1Wn2/8?=
 =?us-ascii?Q?i/ztkRpmUKauNgk1ZfjGh6DwSsXzEQfOrdk5UPY5dZ4GMu+UBXNAV0qDhEyX?=
 =?us-ascii?Q?5wqbYaoEylAOzHLZDynZSX33zldr5yzj+eGY++6iVATovf9u02TCXSkr4nHu?=
 =?us-ascii?Q?aoKuvie/nE6NBJA0FwZ6mHwvhS8MSaM8OM5g2b43hLmJq+2wiUzxTNZwYIf2?=
 =?us-ascii?Q?q6VzZXaLif/RZbVw7tjypGrcfEUQ1WjDulfB/ibD5N7mx98zBXTrz8ELyUZ7?=
 =?us-ascii?Q?YcPsDjXEFPS0ESYzrshJeK4ofvfhkNq8vdVaPSBdo80MS6E3AN34exU/H1Ae?=
 =?us-ascii?Q?K54ncaozwZN6W66o8vyBtKBDkxt39RJp8KAW4Q6gXVrSe8zrvm/8th07zY+q?=
 =?us-ascii?Q?8aJlEwGJ5+1JTgsKnJj+2Rc5pMZ42Xd/4Xg7pYIvnLnErTjjixJYiq9KgocB?=
 =?us-ascii?Q?159iD97a0/oXPqPfpehlwqvx3so1w8+xSlnXcbk0wIZA4GcjHQtse5Iklsqo?=
 =?us-ascii?Q?MfTQk3PBIWMAImZF5KlEm+4Oafbm+HeLGF9YRoNR8x3AVDjzBuUAZXGb3PjV?=
 =?us-ascii?Q?NsKYj5tlmhdshFvKhMpTQ65uI8QBun3CvwAuamvFYYmfpHuF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc3abd6-40df-45dd-cee5-08deec7a6eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 07:32:51.9975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFDqMkpLsTqh21njtzSGZvO3PcrhoGPqUUOSD6BelcKSomzvygA31ZNsUDK7rXTUUxiF+TjKMchGnnVfu699sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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
> From: Zhou, Bob <Bob.Zhou@amd.com>
> Sent: Tuesday, July 28, 2026 2:33 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer deref in
> amdgpu_vm_handle_moved for BO-less mappings
>
> AMD General
>
> since the new bo && guard already ensures bo is non-NULL (and equals bo_v=
a-
> >base.bo), use bo directly instead of bo_va->base.bo - e.g.
> drm_gem_is_imported(&bo->tbo.base).
Good catch, thanks.
You're right: after the new NULL guard, using bo_va->base.bo is redundant.
I'll switch those uses to the local bo pointer (no functional change) and f=
old it into v2.

Thanks
Jesse
>
> Regards,
> Bob
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Tuesday, July 28, 2026 9:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix NULL pointer deref in
> amdgpu_vm_handle_moved for BO-less mappings
>
> The individual.needs_update loop in amdgpu_vm_handle_moved() unconditiona=
lly
> dereferenced bo_va->base.bo (to read its reservation object, ttm_tt and t=
o test for a
> DMABuf import). However bo_va->base.bo can legitimately be NULL for
> PRT/sparse mappings - amdgpu_vm_bo_update() already handles a NULL bo via
> its "else if (!bo)" PRT path. When such a bo_va reaches the moved list (e=
.g. the
> userq eviction restore worker running amdgpu_vm_handle_moved() while a us=
er
> queue is being torn down during a GPU reset), the NULL deref crashes the =
kernel:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000158
>   #PF: supervisor read access in kernel mode
>   Oops: 0000 [#1] SMP NOPTI
>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>   RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
>   Call Trace:
>    <TASK>
>    amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
>    amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]
>    process_scheduled_works+0xa6/0x460
>    worker_thread+0x13c/0x290
>    kthread+0xfb/0x140
>    ret_from_fork+0x1b6/0x2b0
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>
> The faulting instruction is "mov rax,[rdx+0x158]" with rdx (bo) =3D=3D 0 =
and
> CR2 =3D=3D 0x158, i.e. reading bo->tbo.base.resv off a NULL bo.
>
> Guard the BO-less case: skip the reservation dance and the DMABuf-import =
check
> when bo is NULL, and let amdgpu_vm_bo_update() take its existing PRT path=
.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index aac8ace9d7a6..fbb76c32bff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1631,11 +1631,17 @@ int amdgpu_vm_handle_moved(struct
> amdgpu_device *adev,
>                 bo_va =3D list_first_entry(&vm->individual.needs_update,
>                                          typeof(*bo_va), base.vm_status);
>                 bo =3D bo_va->base.bo;
> -               resv =3D bo->tbo.base.resv;
> +               resv =3D bo ? bo->tbo.base.resv : NULL;
>                 spin_unlock(&vm->individual_lock);
>
> +               /* PRT/sparse mappings have no BO to reserve; just update=
 the
> +                * page tables (amdgpu_vm_bo_update() handles a NULL bo).
> +                */
> +               if (!bo) {
> +                       clear =3D false;
> +                       unlock =3D false;
>                 /* Try to reserve the BO to avoid clearing its ptes */
> -               if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.=
ttm) &&
> +               } else if (!adev->debug_vm &&
> +!amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)
> +&&
>                     dma_resv_trylock(resv)) {
>                         clear =3D false;
>                         unlock =3D true;
> @@ -1659,7 +1665,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device
> *adev,
>                 /* Remember evicted DMABuf imports in compute VMs for lat=
er
>                  * validation
>                  */
> -               if (vm->is_compute_context &&
> +               if (bo && vm->is_compute_context &&
>                     drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>                     (!bo_va->base.bo->tbo.resource ||
>                      bo_va->base.bo->tbo.resource->mem_type =3D=3D TTM_PL=
_SYSTEM))
> --
> 2.49.0
>

