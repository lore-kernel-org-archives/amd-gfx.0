Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD3CC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 17:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EE310FDB9;
	Mon, 18 Mar 2024 17:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ct7WuAb/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D15110FD37
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 17:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbYiH/1KA9S/1XYyYiosdmtItfZfKA9yVNaQweghRKCKLyJjXkj1BbCp24Xk7zX2GsJW0wXCAnp4TlCIvKNe+tU5d6Pm8zmNDB+mdR9v5l4iutsPjR8ch8diXXt97Yz4xiYBU1Vo62ANZ9fHCcRIuKrDQEarGWbkUI4zVb08GP5ehAJE1G/zb83A7k+5ZWjM934dGKJ2wBGlthRLS0TCMAUjKtZBAajwgy65IX5suk7pLLVCMXUz7Jf/Q4c3+Xr+lKm22witeOR4yWZ0qXsK2/he7xOs/LvvbppFXWzMW6N+xxcqiAXJMBvJkVANTEvzgkns51V/5iyhs4O6KGSLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iYC3Zh4Y6He0MceqowL1JmG8C5PFUQyIi1b+2gK4gU=;
 b=byzxH05cExCD1ul72CxD2Pm0XguP3uKj/jp+ihMap+8a/hO2/pRz8TRD3fDpJPsUi9PgIkg7BsaqKrml8c/rSln2DHe/JZ1qHErZKJlG3TpWT4lFlKNsSqKEEYXLhxl67NvzRYYv78V0Go+XWjARHdP357iAkD+VS4HtfMT42zKmz96g1J8jCHS/p3smmY+hBLO1CvSoWSo1C8bsJ5+roptYDOADQXf7AlBTK/kPwDTT4ivd9ZmlzeMASPAmnL54OsPPfxz95HutjB8Qx9dtslUZHOvOR/fge7+MJQaLu9Ny3WWGhuygajwkqm93aW9DlL/2Oy8rCT465cnhPovPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iYC3Zh4Y6He0MceqowL1JmG8C5PFUQyIi1b+2gK4gU=;
 b=Ct7WuAb/eVOCbi654HB+gEr+ZZkKozX5QHOgxj2mZqQBrglRNB9hVQCXieyx+Fs3ZzQewka1Mcqb5excDO4gGGO+7IZTufga2yPyRs/YkCb3Uh+/OocSuTIJgCU54RSwgGSbgjvWF0auSM0/a/JxvS+kWSx2Q4Gj++zLF6BDHYA=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 17:30:03 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 17:30:03 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma, Shashank"
 <Shashank.Sharma@amd.com>
Subject: RE: [PATCH v9 1/2] drm/amdgpu: implement TLB flush fence
Thread-Topic: [PATCH v9 1/2] drm/amdgpu: implement TLB flush fence
Thread-Index: AQHaeU8KZO8VvI9L2U+jrTOYExcN/bE9v+BA
Date: Mon, 18 Mar 2024 17:30:03 +0000
Message-ID: <BL3PR12MB642593F5E2264E6ECF645021EE2D2@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240318161140.2101-1-shashank.sharma@amd.com>
In-Reply-To: <20240318161140.2101-1-shashank.sharma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0f87d7a1-0a74-4773-8b57-e9f65dc1d0f1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T17:25:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|MW4PR12MB7359:EE_
x-ms-office365-filtering-correlation-id: 6b05f698-41b9-41cb-279e-08dc47710be8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwi+RUZ/qX0A6QXXXQOtjLsTg/Qpxq/yAfa34By3dA8a23+ZCIj38gm241L8ZEX3Ta5AkwjSLCt6Ti3BBwdeGNFHfpSwucBh60/lUHEPqXz1C2FO4a48bSSYJ5h4KD/U6yJoYE8FWlAaJwA+fBLK78sMIpUbKrFBAZ1PHliH3JVybDNSTEA939quuemhRU0gHudMpCjiEIXHcVoik3jYeDYdZCm81MuE21duReEfEHpUTYdfpAHICgg6+2ZM/5mBM3Jt1amtlZFzq38TeR5DSz0kLupvoJlKT0qgFgxl72f2Eo2NiDL7wqI6sQt//6YgcL1eJ9L+PrVEMnHkPr+ueECJerks+8ETxMndN00iSb6vyrE3W74sfG4ziPGllILPCg/azgsM6Dv3b4pZvUPGp/JIzSmJRdo38vprX3J4sKmM/J7eZolE2RcqkPFSwfwSLArG0JMl12amfh92gej7jwgYAztkOULZbEVYsyNhavr+BBUmAsn9ynP/wa4dWmSGvXvJ+HXcxnyt13SH6FYkPblCt3CsGFhBksTnPDP9bmmYaDx9wZI34NHlW4C4Sfd0fa5K7Q/5Zk3LYpTKY3DQvQvKfXbs0t8WIW9xWm+3v2UtsgPeKRk3lyRrd4P1UrQG/jif6zyIkxZEWBO46xhlevgdK9cfmM5+y2z7foeFoKh4/++5IyJ0bDF/ALD10XgBFMVT+6ItP4DhMawiSCs1gg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pp7SPB5xV5abXXZ4JLxLHSPI6TjmDTyRkvhRl1GaZeqUMPemZ3Kn0itUsUwA?=
 =?us-ascii?Q?Qk70s3iLurbTJZrHOQoQMEj4vBsn+VlZTUH/4n5Ta3DO7c5BNsMaxkCNrs2G?=
 =?us-ascii?Q?qi72eEJRcgQIofll/X8k/QGCuWUBZvlCf7t7ZfVL96od6Qo1v/D6mwUPnKuz?=
 =?us-ascii?Q?WFGe2Q/T0pJFjxNk4SxTLN+7YxnthI6Er/SVCiUhmAIEDeCru9KChu0gvKUf?=
 =?us-ascii?Q?6YaFthTwarFxj1yPdirMPVwa2INIsE+yjlPL5H1Jij32Pmb9hWbmetP1oYSR?=
 =?us-ascii?Q?xZa0bHP/MTUQOCnzXytp3qxLE0LzKZwqbckc3cNuIbeUa6FENTevun7xK/nk?=
 =?us-ascii?Q?GFoC6Jr5+0GK+hIZFN1Lnd+sdkvY2g6yUPdTqa/6HHMR7N3s749Vplh/sJjF?=
 =?us-ascii?Q?zCaNciWsGuLnKIQjoFRYhnzXLwRlIBzanRVkMw84etf16+EEPkRw22WlVXgI?=
 =?us-ascii?Q?IeUSVkF2h+iEhjbXhEJr/KKEDClPlz9TyRP4OApnhilvxYIsvRSdmnsCoddw?=
 =?us-ascii?Q?Xn/f9r00dF3NggSW3Yci0bgzsREKUqolYcnw6M3lrrFyTceF+u6IMIfB9eHc?=
 =?us-ascii?Q?6cUO7ip7bdQ1Y40hNrStZ1TJjEf4VdshRQw03XABVrqYVZBsjkUslLxo83iJ?=
 =?us-ascii?Q?ZRHgV0r7x5BIGaf6xFrLgIYh4W9CY7aFghmm5Sa0wH5O+qZy0uAFAS5QcTgD?=
 =?us-ascii?Q?Z0r5tKKoss8VEpWuBnAz75JBekvyTfV9TEdQBRyyB1QuOEvyHBxh+UR7SI/L?=
 =?us-ascii?Q?iuXk/ZJ+KvHo5+njdib8vtzyNlQ0NHoVMD3TyuEoE3dr9NU/BQKs+PILToqz?=
 =?us-ascii?Q?fCmF19dJ82xU5zyGXl93Nk9va8ouon3lifjWavdHbZYFnoUEnLWvmdJITplk?=
 =?us-ascii?Q?WkTsLrjzmXhA6be/2Pe94wkYAWlsx4RRkRvgL3VE4vxzbrh7RJwEJzxw2Rvi?=
 =?us-ascii?Q?FgrTk87b2nS+vur5F6FNixhnBlIDfEwcvFY25i8g25ic+1hby8FaNBSAxW59?=
 =?us-ascii?Q?clwODJpH1v384kyTMYlwVEIQW6l2EDecdiq7i51ayvIGY8Y6D0DADhKnBv3h?=
 =?us-ascii?Q?1u609nZiWP3i9ccsOt+NHhf1jkH/pmgpsBNSAL5M1ioOjqbBP8c9bSjkErFO?=
 =?us-ascii?Q?vvH8VFvoQHu71+na0n/rNm6ZOb3/4O/LUH/XzGt+SMKT0eQRJMxyItu5/LwR?=
 =?us-ascii?Q?jmps0xl5FAo6kAJ/xwr/BDLybEGK/wFTKLfGC2omJgYP80JsuuK16jwuotsD?=
 =?us-ascii?Q?1HQbPHmU46XwdOqerz7o8wtRCLQViP+gtUg5vu0Un/oHCie3pBNBesYcnM55?=
 =?us-ascii?Q?jGtItBHm3qIzsoHY6WsJl/kA2/FKSBgygq3xzf2RlhyaWPxcn/DEM4pirt1i?=
 =?us-ascii?Q?be9HC2FZpSopfWY0DTHE0WwyNL7WRii5wzDnVaeucFT1wTLaOKrdwWJjSROd?=
 =?us-ascii?Q?vQ7SFsSMT7pODmROJOWpWnU7OE+KrtA4klQDK70F3Fkwp1x08mso2Uzp+wFD?=
 =?us-ascii?Q?uCSLZNqv75udmOzLUiGmg2cLc3DlGSjmmI+ibPiHWg1QFRyzl15wxK4GVuyr?=
 =?us-ascii?Q?EUlPfO6PuKGiEgEuCVU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b05f698-41b9-41cb-279e-08dc47710be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 17:30:03.5808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkjP+zOBl/lPG0J0jCvhcu+XkPcGWvGbjZtFK6ntkveKgkZXJrFXDOammlSqI8iaiwMES+UxQn/eo1EDtemtGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Shashank Sharma
> Sent: Monday, March 18, 2024 12:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Bhardwaj, Rajneesh
> <Rajneesh.Bhardwaj@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Sharma, Shashank
> <Shashank.Sharma@amd.com>
> Subject: [PATCH v9 1/2] drm/amdgpu: implement TLB flush fence
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> From: Christian Koenig <christian.koenig@amd.com>
>
> The problem is that when (for example) 4k pages are replaced with a singl=
e 2M
> page we need to wait for change to be flushed out by invalidating the TLB
> before the PT can be freed.
>
> Solve this by moving the TLB flush into a DMA-fence object which can be u=
sed
> to delay the freeing of the PT BOs until it is signaled.
>
> V2: (Shashank)
>     - rebase
>     - set dma_fence_error only in case of error
>     - add tlb_flush fence only when PT/PD BO is locked (Felix)
>     - use vm->pasid when f is NULL (Mukul)
>
> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>     - move the misplaced fence_create call to the end (Philip)
>
> V5: - free the f->dependency properly
>
> V6: (Shashank)
>     - light code movement, moved all the clean-up in previous patch
>     - introduce params.needs_flush and its usage in this patch
>     - rebase without TLB HW sequence patch
>
> V7:
>    - Keep the vm->last_update_fence and tlb_cb code until
>      we can fix the HW sequencing (Christian)
>    - Move all the tlb_fence related code in a separate function so that
>      its easier to read and review
>
> V9: Addressed review comments from Christian
>     - start PT update only when we have callback memory allocated
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  64 +++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   4 +
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112
> ++++++++++++++++++
>  7 files changed, 175 insertions(+), 22 deletions(-)  create mode 100644
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 4536c8ad0e11..f24f11ac3e92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -70,7 +70,8 @@ amdgpu-y +=3D amdgpu_device.o
> amdgpu_doorbell_mgr.o amdgpu_kms.o \
>         amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>         atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>         atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
> -       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o
> amdgpu_pll.o \
> +       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o
> amdgpu_vm_tlb_fence.o \
> +       amdgpu_ib.o amdgpu_pll.o \
>         amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>         amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o
> amdgpu_virt.o \
>         amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \ diff --g=
it
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 81fb3465e197..104bf600c85f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -885,6 +885,44 @@ static void amdgpu_vm_tlb_seq_cb(struct
> dma_fence *fence,
>         kfree(tlb_cb);
>  }
>
> +/**
> + * amdgpu_vm_tlb_flush - prepare TLB flush
> + *
> + * @params: parameters for update
> + * @fence: input fence to sync TLB flush with
> + * @tlb_cb: the callback structure
> + *
> + * Increments the tlb sequence to make sure that future CS execute a VM
> flush.
> + */
> +static void
> +amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
> +                   struct dma_fence **fence,
> +                   struct amdgpu_vm_tlb_seq_struct *tlb_cb) {
> +       struct amdgpu_vm *vm =3D params->vm;
> +
> +       if (!fence || !*fence)
> +               return;
> +
> +       tlb_cb->vm =3D vm;
> +       if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
> +                                   amdgpu_vm_tlb_seq_cb)) {
> +               dma_fence_put(vm->last_tlb_flush);
> +               vm->last_tlb_flush =3D dma_fence_get(*fence);
> +       } else {
> +               amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> +       }
> +
> +       /* Prepare a TLB flush fence to be attached to PTs */
> +       if (!params->unlocked && vm->is_compute_context) {
> +               amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
> +
> +               /* Makes sure no PD/PT is freed before the flush */
> +               dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> +                                  DMA_RESV_USAGE_BOOKKEEP);
> +       }
> +}
> +
>  /**
>   * amdgpu_vm_update_range - update a range in the vm page table
>   *
> @@ -916,8 +954,8 @@ int amdgpu_vm_update_range(struct
> amdgpu_device *adev, struct amdgpu_vm *vm,
>                            struct ttm_resource *res, dma_addr_t *pages_ad=
dr,
>                            struct dma_fence **fence)  {
> -       struct amdgpu_vm_update_params params;
>         struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +       struct amdgpu_vm_update_params params;
>         struct amdgpu_res_cursor cursor;
>         enum amdgpu_sync_mode sync_mode;
>         int r, idx;
> @@ -926,10 +964,8 @@ int amdgpu_vm_update_range(struct
> amdgpu_device *adev, struct amdgpu_vm *vm,
>                 return -ENODEV;
>
>         tlb_cb =3D kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> -       if (!tlb_cb) {
> -               r =3D -ENOMEM;
> -               goto error_unlock;
> -       }
> +       if (!tlb_cb)
> +               return -ENOMEM;
>
Do you not need to call drm_dev_exit() if this tlb_cb allocation fails?

Regards,
Mukul

>         /* Vega20+XGMI where PTEs get inadvertently cached in L2 texture =
cache,
>          * heavy-weight flush TLB unconditionally.
> @@ -948,6 +984,7 @@ int amdgpu_vm_update_range(struct
> amdgpu_device *adev, struct amdgpu_vm *vm,
>         params.immediate =3D immediate;
>         params.pages_addr =3D pages_addr;
>         params.unlocked =3D unlocked;
> +       params.needs_flush =3D flush_tlb;
>         params.allow_override =3D allow_override;
>
>         /* Implicitly sync to command submissions in the same VM before @=
@ -
> 1031,24 +1068,16 @@ int amdgpu_vm_update_range(struct amdgpu_device
> *adev, struct amdgpu_vm *vm,
>         }
>
>         r =3D vm->update_funcs->commit(&params, fence);
> +       if (r)
> +               goto error_free;
>
> -       if (flush_tlb || params.table_freed) {
> -               tlb_cb->vm =3D vm;
> -               if (fence && *fence &&
> -                   !dma_fence_add_callback(*fence, &tlb_cb->cb,
> -                                          amdgpu_vm_tlb_seq_cb)) {
> -                       dma_fence_put(vm->last_tlb_flush);
> -                       vm->last_tlb_flush =3D dma_fence_get(*fence);
> -               } else {
> -                       amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -               }
> +       if (params.needs_flush) {
> +               amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
>                 tlb_cb =3D NULL;
>         }
>
>  error_free:
>         kfree(tlb_cb);
> -
> -error_unlock:
>         amdgpu_vm_eviction_unlock(vm);
>         drm_dev_exit(idx);
>         return r;
> @@ -2391,6 +2420,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm,
>
>         mutex_init(&vm->eviction_lock);
>         vm->evicting =3D false;
> +       vm->tlb_fence_context =3D dma_fence_context_alloc(1);
>
>         r =3D amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>                                 false, &root, xcp_id); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8efa8422f4f7..b0a4fe683352 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -257,9 +257,9 @@ struct amdgpu_vm_update_params {
>         unsigned int num_dw_left;
>
>         /**
> -        * @table_freed: return true if page table is freed when updating
> +        * @needs_flush: true whenever we need to invalidate the TLB
>          */
> -       bool table_freed;
> +       bool needs_flush;
>
>         /**
>          * @allow_override: true for memory that is not uncached: allows =
MTYPE
> @@ -342,6 +342,7 @@ struct amdgpu_vm {
>         atomic64_t              tlb_seq;
>         struct dma_fence        *last_tlb_flush;
>         atomic64_t              kfd_last_flushed_seq;
> +       uint64_t                tlb_fence_context;
>
>         /* How many times we had to re-generate the page tables */
>         uint64_t                generation;
> @@ -611,5 +612,8 @@ void amdgpu_vm_update_fault_cache(struct
> amdgpu_device *adev,
>                                   uint64_t addr,
>                                   uint32_t status,
>                                   unsigned int vmhub);
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
> +                                struct amdgpu_vm *vm,
> +                                struct dma_fence **fence);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 6e31621452de..3895bd7d176a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -108,7 +108,9 @@ static int amdgpu_vm_cpu_update(struct
> amdgpu_vm_update_params *p,  static int amdgpu_vm_cpu_commit(struct
> amdgpu_vm_update_params *p,
>                                 struct dma_fence **fence)  {
> -       /* Flush HDP */
> +       if (p->needs_flush)
> +               atomic64_inc(&p->vm->tlb_seq);
> +
>         mb();
>         amdgpu_device_flush_hdp(p->adev, NULL);
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 124389a6bf48..601df0ce8290 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -972,7 +972,7 @@ int amdgpu_vm_ptes_update(struct
> amdgpu_vm_update_params *params,
>                         while (cursor.pfn < frag_start) {
>                                 /* Make sure previous mapping is freed */
>                                 if (cursor.entry->bo) {
> -                                       params->table_freed =3D true;
> +                                       params->needs_flush =3D true;
>                                         amdgpu_vm_pt_free_dfs(adev, param=
s->vm,
>                                                               &cursor,
>                                                               params->unl=
ocked); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 349416e176a1..66e8a016126b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -126,6 +126,10 @@ static int amdgpu_vm_sdma_commit(struct
> amdgpu_vm_update_params *p,
>
>         WARN_ON(ib->length_dw =3D=3D 0);
>         amdgpu_ring_pad_ib(ring, ib);
> +
> +       if (p->needs_flush)
> +               atomic64_inc(&p->vm->tlb_seq);
> +
>         WARN_ON(ib->length_dw > p->num_dw_left);
>         f =3D amdgpu_job_submit(p->job);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> new file mode 100644
> index 000000000000..51cddfa3f1e8
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <linux/dma-fence.h>
> +#include <linux/workqueue.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_gmc.h"
> +
> +struct amdgpu_tlb_fence {
> +       struct dma_fence        base;
> +       struct amdgpu_device    *adev;
> +       struct dma_fence        *dependency;
> +       struct work_struct      work;
> +       spinlock_t              lock;
> +       uint16_t                pasid;
> +
> +};
> +
> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence
> +*fence) {
> +       return "amdgpu tlb fence";
> +}
> +
> +static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence
> +*f) {
> +       return "amdgpu tlb timeline";
> +}
> +
> +static void amdgpu_tlb_fence_work(struct work_struct *work) {
> +       struct amdgpu_tlb_fence *f =3D container_of(work, typeof(*f), wor=
k);
> +       int r;
> +
> +       if (f->dependency) {
> +               dma_fence_wait(f->dependency, false);
> +               dma_fence_put(f->dependency);
> +               f->dependency =3D NULL;
> +       }
> +
> +       r =3D amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, =
0);
> +       if (r) {
> +               dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
> +                       f->pasid);
> +               dma_fence_set_error(&f->base, r);
> +       }
> +
> +       dma_fence_signal(&f->base);
> +       dma_fence_put(&f->base);
> +}
> +
> +static const struct dma_fence_ops amdgpu_tlb_fence_ops =3D {
> +       .use_64bit_seqno =3D true,
> +       .get_driver_name =3D amdgpu_tlb_fence_get_driver_name,
> +       .get_timeline_name =3D amdgpu_tlb_fence_get_timeline_name
> +};
> +
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct
> amdgpu_vm *vm,
> +                               struct dma_fence **fence) {
> +       struct amdgpu_tlb_fence *f;
> +
> +       f =3D kmalloc(sizeof(*f), GFP_KERNEL);
> +       if (!f) {
> +               /*
> +                * We can't fail since the PDEs and PTEs are already upda=
ted, so
> +                * just block for the dependency and execute the TLB flus=
h
> +                */
> +               if (*fence)
> +                       dma_fence_wait(*fence, false);
> +
> +               amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, =
0);
> +               *fence =3D dma_fence_get_stub();
> +               return;
> +       }
> +
> +       f->adev =3D adev;
> +       f->dependency =3D *fence;
> +       f->pasid =3D vm->pasid;
> +       INIT_WORK(&f->work, amdgpu_tlb_fence_work);
> +       spin_lock_init(&f->lock);
> +
> +       dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
> +                      vm->tlb_fence_context,
> + atomic64_read(&vm->tlb_seq));
> +
> +       /* TODO: We probably need a separate wq here */
> +       dma_fence_get(&f->base);
> +       schedule_work(&f->work);
> +
> +       *fence =3D &f->base;
> +}
> --
> 2.43.2

