Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249F1ECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 17:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6909E10E06A;
	Thu, 22 Sep 2022 17:56:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798B310E06A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 17:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzfx2mLphYa/djZtSQMLM0sqi1DbykeeT7jhHgRaklW9gQxg97l7m0vVju2nfze+Z9/Cawc7qahxjtXvrbbguEanm518/yGIkkBGFxHPgAvAKPjPWvnkGyYruILtmerIbyU/piE1lkFwIIvm8j5ysUpz7pekxziZ9V9jIVEI1An7CAw4Obr9TKCoC0UYg0xh+MQabttQwM3RiW74hyB941lyzbUIxstRIBLlqc9pfGBY1wozyH7oRoWXKpEGGThjoEAaOnHEVP/dUnFzo5S82tTmSp55fzo1WVNPFgP1HoJ8jS3fkMvsnNV+qroublPb4RLugsrQdQZX6T9xK0+3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj9dMyySMj7z0N7t4JSTulNcX0zeKDpim5w6OpM4LsI=;
 b=XiwlsdGAYsPTjfKShzyoiI7QEODxELifFK/q3jXOG0s1OEUig9jjGL7Rgy/y1YJizGI1LdePkC1p4Kzn3EiuUhH+qwlzx0mvPS+Jr2qdGN5a/6aUVFBw5sz35RGJeEdjIphvMYhxxXaNtQstCOZokirrTXSH7TI7R/MVjtLUECp588QClWrnJXHxFVLCDjmt+xQKJ1u3UyKIO919fY3YxRBAtsXK3ivJ1XB+dPxzhAYhmUdP3sGX7KaS7hnbhxyIXlJY7pNqRFpGuIqUCKNfxXBCr8MgM/KokWWRJncBQyfFrH/A7K9EEjvx6sqgMf2fwRo2+eNoMy4c0Uld3XhfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj9dMyySMj7z0N7t4JSTulNcX0zeKDpim5w6OpM4LsI=;
 b=JgC3jr/TGctAj8OuksmIxJUtgdYIkLpMSY78be9toWzc8aVyS+WugDOoxsIU+AUIHBoaKg03fA9smyOWiq7O5ZHhKIqKBNxliMBWM4eliKUeVhUqq1S9RdeZzdcCRQtpp1+fPeQeKM25Fc6KtSliT4fpnb5+N9it9+VLAEXc31U=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:56:16 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3c76:8e77:b067:49ea]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3c76:8e77:b067:49ea%5]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 17:56:16 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Belanger, David" <David.Belanger@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable SA software trap.
Thread-Topic: [PATCH] drm/amdgpu: Enable SA software trap.
Thread-Index: AQHYzp7+6sRPfTKw7E6GpKL2Udng4q3rumcw
Date: Thu, 22 Sep 2022 17:56:16 +0000
Message-ID: <DM6PR12MB306708116CB46624BBA566B38A4E9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220922161703.916705-1-david.belanger@amd.com>
In-Reply-To: <20220922161703.916705-1-david.belanger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-22T17:50:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1b478eac-f379-4180-a6db-9140f63fb29e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-22T17:56:14Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 85ec3fed-96ff-4f5a-95d6-244bf2973185
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|MN2PR12MB4502:EE_
x-ms-office365-filtering-correlation-id: 5c864081-5a0e-4e6a-85a6-08da9cc3bf16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfpiXGMcKz1mgePCEzTs+EleLCQiQph9NA+QRUC3Y5RkfLrotFU6aqSkELl+Mb1tb2tB+pef52FPpUdgipWb9+Cwr1EM5wcx/23deQxc1ZI+T4RlanTiIkuoZt64US54/cRwMytlViN2m7k0/RVhHOH82ghXYY2kYfi7UblaYbzd5JQIkN5UfAwE39SGj9lQaX5b5ijeAW0AJNj01qGuvdde7ZQomVAVtxrbrTkYksQvmffUHzHfeaXmGeAaRel2eqPhM8ficXXfsE2gqkijqlcfDb7jIQlzGGJyLfhF2iseOXAApFAIIB+jKqV071xJrStGzSdsuvmPHZaP3X4DGqBpNbHMsiHo0NSXczCwgtkicywn2wRAJlKgYdVGC1/Ddr9MYh6nGHrzEHoTVwgUQISs3+7uL+lxOb74ZQN/0+fgv9Qp62CY4pKGAQcsrew09FJSts11f/ahHBkIa96P1iSFTJPc3t+ihs3XaIW0ASCu+tsXudQo+2enc1n3q6BmGCndNNyDcIZj0PhKauVQl4F3D8RjzT0ggmY+aXQLQQSZmqcfHsz7AZ/tdlxMgRmSRLgbDCO6DeKyVThUNZRo7C4eWrZtTEeBrdk3hVE+S1eiuMvkFi9rYjtn4F5a/i2IQ+/cNKK8xDLG6qtqvzKUCab+nRespp5kq65ZHbBSv32H77u9LsCH7nDadCMIfgpfR2Uipv8sT4qBIE8PVhHEt2QKPK3lshGcHvPWSJSkOy9XjiVBCi++HydcYRxcJuCi/u9nossQPR4RsYuJiX4K3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(26005)(478600001)(6506007)(71200400001)(53546011)(41300700001)(122000001)(38100700002)(9686003)(5660300002)(55016003)(30864003)(66446008)(54906003)(110136005)(316002)(2906002)(64756008)(7696005)(8936002)(38070700005)(52536014)(66476007)(76116006)(66556008)(86362001)(66946007)(4326008)(8676002)(83380400001)(186003)(33656002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9KL4lbh/xpQWs1OVGzH0H7oS6q3E+sJHsjaYT5k/nAZyde6Tbdu4IiPIxWkK?=
 =?us-ascii?Q?aM8yMCYorerpiBmnVM5Ib1zEUIs/YixHoYpPHfqwAF1Rir42xXAPnQXj5mTf?=
 =?us-ascii?Q?LLUuxDYeAqpLbFtQOql9GvDZTKsvqye9jmWFSdUPSu+pd5tUvcCafMNrHxcL?=
 =?us-ascii?Q?7/VXb0daaM5pZLb2ld6ry74qM4i+pfTl2hGX/WdnJctbFPDr5F0EHqyBHGqD?=
 =?us-ascii?Q?jNYdmXSMPc+AijTAcwe4NIffL6RPyOUGtNbNu/ja9cK+movu5+WDSou2iOjQ?=
 =?us-ascii?Q?DoiWDPbUzyqp1bFxj0gN84pAVbZZaIg6/rRlbr9Rg8X3IYBNdYre/pHG+2ZK?=
 =?us-ascii?Q?e8waPN3PzoGLbx/elzZS0FoUyCUa5wImD+F1GHkVSsSQtzT0Ypc8sHWA5PQA?=
 =?us-ascii?Q?qq3Rv+CmeXlDFbwtI5aol9vF8pDZ98iS4Kqd6OpMN1+5iUD0i8c59ebEjkty?=
 =?us-ascii?Q?JN0X9OHKQ+CVBpoZoj5zvHPGakiUO3mv6bo5RhHggzqGipFo02WEjHVkbR27?=
 =?us-ascii?Q?vueYUNnyVBOIJoUZY5WKtyNJ0My/29Jr8cQjAoX2j0hh0D7ZK5P37kowNgEX?=
 =?us-ascii?Q?lEmAhZKcDTP9t7fXsypusIF3KtK2qfe0V2fv6EhWSrCcKu4bv5HppIU78aHS?=
 =?us-ascii?Q?DaZOtghheo4P/QfMj3Mdcp9JnD0WlZHHJlyOp5FdBzeuYAtIp4Ka8R5CcWqa?=
 =?us-ascii?Q?QXJnGjSB+8bK7EUPrZvLU/tzKi65tk0cyCeOM2gCfg7Pr9JFyD7TiFKqqQcM?=
 =?us-ascii?Q?SHtIoqcXeBd2lewmrKGXeLNl5JxW/VMH/J3VHhLK8hn1EHv7H04uVVLMI1dP?=
 =?us-ascii?Q?3nfRzjMk1ESK65AE3JQ/6S6ricB+db4Fo/SbZ3vRGfGWyl3VtQdTRVCgfLBH?=
 =?us-ascii?Q?tCSQSfY99EB9s0u2+OMzMIJ+Km6voZ7EhWCudLPJomn7AAe1f6wK4MtD84XF?=
 =?us-ascii?Q?lW8V2PviNcMFSk1Nygr63IqfSGHe++XZGAX8UjUP1jdLKgCLoFUYQJPB4QMB?=
 =?us-ascii?Q?0jmqdnaQUuUOuYyg6wLzGaNCQxdEu2xyY/ta2zmvE3tw4JOvlq/yAnHB8mqz?=
 =?us-ascii?Q?hKQtG9Ypt8ngy9qGT6rk3/AJ/KlWrSX0UXCFPqLysnxT3EcQh4CMmgLhHde8?=
 =?us-ascii?Q?ESVmpII/kvIOnCraNl5xdvNsPRg9jUrAjNNC/eqhZpjIj5XKSH5SF9hBJRLp?=
 =?us-ascii?Q?iN0JudvsjOLST3qLvDQnTBZcTcQTzQUmVKliJQg+4jVAAUb1aw9R08ncoCmk?=
 =?us-ascii?Q?0fvGrzZ3Mz2TZwO93oCTmgPeInQcn0peJrrQeo58Nt03S0H6tev4V3ErYlpi?=
 =?us-ascii?Q?D/P6JN6piZJszp3fi6hOycdeTT4UWh7rRl2RHmliNOUIF2c8jKdIf3NhRQml?=
 =?us-ascii?Q?v3SvTQRqtjIK6d9j8oAYBxnIgmcLF9wrsg27AgOOyj8/+ADFj3NnUQMac5Y+?=
 =?us-ascii?Q?0wdSxDxRnM3sqWvHDe9C4DHVBwtYtPutWsDmJhxvEwzs9se1NYmGOs+5j2Cc?=
 =?us-ascii?Q?a3jqWfsfAUvXmEZBMqEoBjGjpXh5EZX2iZ16jjObJ4VmPp/BgG4QMGKPtE94?=
 =?us-ascii?Q?kIWvdY3hDp4JDUbofrA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c864081-5a0e-4e6a-85a6-08da9cc3bf16
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 17:56:16.4201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V559hob4NOh2uX8MmoD1oOwGIicnoZiSeCZWFsh40FDu9eu6QhRwi4Mp8pA6AM0ZXt2RK+APQhT5GyT+B+XxHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Cornwall,
 Jay" <Jay.Cornwall@amd.com>, "Belanger, David" <David.Belanger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> David Belanger
> Sent: Thursday, September 22, 2022 12:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Belanger, David <David.Belanger@amd.com>
> Subject: [PATCH] drm/amdgpu: Enable SA software trap.
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> Enables support for software trap for MES >=3D 4.
> Adapted from implementation from Jay Cornwall.
>=20
> v2: Add IP version check in conditions.
>=20
> Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
> Signed-off-by: David Belanger <david.belanger@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   6 +-
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 771 +++++++++---------
>  .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  21 +
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  26 +-
>  4 files changed, 437 insertions(+), 387 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index b64cd46a159a..cbc506b958b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -185,7 +185,11 @@ static int mes_v11_0_add_hw_queue(struct
> amdgpu_mes *mes,
>         mes_add_queue_pkt.trap_handler_addr =3D input->tba_addr;
>         mes_add_queue_pkt.tma_addr =3D input->tma_addr;
>         mes_add_queue_pkt.is_kfd_process =3D input->is_kfd_process;
> -       mes_add_queue_pkt.trap_en =3D 1;
> +
> +       if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D
> 4) &&
> +                 (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 0=
)) &&
> +                 (adev->ip_versions[GC_HWIP][0] <=3D IP_VERSION(11, 0, 3=
))))
> +               mes_add_queue_pkt.trap_en =3D 1;

I think the value for trap_en here is backwards. It should be set to 0 for =
this condition and default to 1 otherwise.

Best,
Graham

>=20
>         return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                         &mes_add_queue_pkt, sizeof(mes_add_queue_pkt), di=
ff --git
> a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 60a81649cf12..c7118843db05 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -742,7 +742,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
>         0xbf88fffe, 0x877aff7f,
>         0x04000000, 0x8f7a857a,
>         0x886d7a6d, 0xb97b02dc,
> -       0x8f7b997b, 0xb97a2a05,
> +       0x8f7b997b, 0xb97a3a05,
>         0x807a817a, 0xbf0d997b,
>         0xbf850002, 0x8f7a897a,
>         0xbf820001, 0x8f7a8a7a,
> @@ -819,7 +819,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
>         0xbefe037c, 0xbefc0370,
>         0xf4611c7a, 0xf8000000,
>         0x80708470, 0xbefc037e,
> -       0xb9702a05, 0x80708170,
> +       0xb9703a05, 0x80708170,
>         0xbf0d9973, 0xbf850002,
>         0x8f708970, 0xbf820001,
>         0x8f708a70, 0xb97a1e06,
> @@ -1069,7 +1069,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
>         0xb9f9f816, 0x876f7bff,
>         0xfffff800, 0x906f8b6f,
>         0xb9efa2c3, 0xb9f3f801,
> -       0xb96e2a05, 0x806e816e,
> +       0xb96e3a05, 0x806e816e,
>         0xbf0d9972, 0xbf850002,
>         0x8f6e896e, 0xbf820001,
>         0x8f6e8a6e, 0xb96f1e06,
> @@ -2114,7 +2114,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0x007a0000, 0x7e000280,
>         0xbefe037a, 0xbeff037b,
>         0xb97b02dc, 0x8f7b997b,
> -       0xb97a2a05, 0x807a817a,
> +       0xb97a3a05, 0x807a817a,
>         0xbf0d997b, 0xbf850002,
>         0x8f7a897a, 0xbf820001,
>         0x8f7a8a7a, 0xb97b1e06,
> @@ -2157,7 +2157,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0x01000000, 0xe0704100,
>         0x705d0100, 0xe0704200,
>         0x705d0200, 0xe0704300,
> -       0x705d0300, 0xb9702a05,
> +       0x705d0300, 0xb9703a05,
>         0x80708170, 0xbf0d9973,
>         0xbf850002, 0x8f708970,
>         0xbf820001, 0x8f708a70,
> @@ -2189,7 +2189,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0xbefe03ff, 0x0000ffff,
>         0xbeff0380, 0xe0704000,
>         0x705d0200, 0xbefe03c1,
> -       0xb9702a05, 0x80708170,
> +       0xb9703a05, 0x80708170,
>         0xbf0d9973, 0xbf850002,
>         0x8f708970, 0xbf820001,
>         0x8f708a70, 0xb97a1e06,
> @@ -2475,7 +2475,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0xb9ef4803, 0x876f7bff,
>         0xfffff800, 0x906f8b6f,
>         0xb9efa2c3, 0xb9f3f801,
> -       0xb96e2a05, 0x806e816e,
> +       0xb96e3a05, 0x806e816e,
>         0xbf0d9972, 0xbf850002,
>         0x8f6e896e, 0xbf820001,
>         0x8f6e8a6e, 0xb96f1e06,
> @@ -2494,438 +2494,441 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D=
 {
>         0xbf9f0000, 0xbf9f0000,
>         0xbf9f0000, 0x00000000,
>  };
> -
>  static const uint32_t cwsr_trap_gfx11_hex[] =3D {
> -       0xbfa00001, 0xbfa0021b,
> +       0xbfa00001, 0xbfa0021e,
>         0xb0804006, 0xb8f8f802,
> -       0x91788678, 0xb8fbf803,
> -       0x8b6eff78, 0x00002000,
> -       0xbfa10009, 0x8b6eff6d,
> -       0x00ff0000, 0xbfa2001e,
> -       0x8b6eff7b, 0x00000400,
> -       0xbfa20041, 0xbf830010,
> -       0xb8fbf803, 0xbfa0fffa,
> -       0x8b6eff7b, 0x00000900,
> -       0xbfa20015, 0x8b6eff7b,
> -       0x000071ff, 0xbfa10008,
> -       0x8b6fff7b, 0x00007080,
> -       0xbfa10001, 0xbeee1287,
> -       0xb8eff801, 0x846e8c6e,
> -       0x8b6e6f6e, 0xbfa2000a,
> +       0x9178ff78, 0x00020006,
> +       0xb8fbf803, 0xbf0d9f6d,
> +       0xbfa20006, 0x8b6eff78,
> +       0x00002000, 0xbfa10009,
>         0x8b6eff6d, 0x00ff0000,
> -       0xbfa20007, 0xb8eef801,
> -       0x8b6eff6e, 0x00000800,
> -       0xbfa20003, 0x8b6eff7b,
> -       0x00000400, 0xbfa20026,
> -       0xbefa4d82, 0xbf89fc07,
> -       0x84fa887a, 0xf4005bbd,
> -       0xf8000010, 0xbf89fc07,
> -       0x846e976e, 0x9177ff77,
> -       0x00800000, 0x8c776e77,
> -       0xf4045bbd, 0xf8000000,
> -       0xbf89fc07, 0xf4045ebd,
> -       0xf8000008, 0xbf89fc07,
> -       0x8bee6e6e, 0xbfa10001,
> -       0xbe80486e, 0x8b6eff6d,
> -       0x01ff0000, 0xbfa20005,
> -       0x8c78ff78, 0x00002000,
> -       0x80ec886c, 0x82ed806d,
> -       0xbfa00005, 0x8b6eff6d,
> -       0x01000000, 0xbfa20002,
> -       0x806c846c, 0x826d806d,
> -       0x8b6dff6d, 0x0000ffff,
> -       0x8bfe7e7e, 0x8bea6a6a,
> -       0xb978f802, 0xbe804a6c,
> -       0x8b6dff6d, 0x0000ffff,
> -       0xbefa0080, 0xb97a0283,
> -       0xbeee007e, 0xbeef007f,
> -       0xbefe0180, 0xbefe4d84,
> -       0xbf89fc07, 0x8b7aff7f,
> -       0x04000000, 0x847a857a,
> -       0x8c6d7a6d, 0xbefa007e,
> -       0x8b7bff7f, 0x0000ffff,
> -       0xbefe00c1, 0xbeff00c1,
> -       0xdca6c000, 0x007a0000,
> -       0x7e000280, 0xbefe007a,
> -       0xbeff007b, 0xb8fb02dc,
> -       0x847b997b, 0xb8fa3b05,
> -       0x807a817a, 0xbf0d997b,
> -       0xbfa20002, 0x847a897a,
> -       0xbfa00001, 0x847a8a7a,
> -       0xb8fb1e06, 0x847b8a7b,
> -       0x807a7b7a, 0x8b7bff7f,
> -       0x0000ffff, 0x807aff7a,
> -       0x00000200, 0x807a7e7a,
> -       0x827b807b, 0xd7610000,
> -       0x00010870, 0xd7610000,
> -       0x00010a71, 0xd7610000,
> -       0x00010c72, 0xd7610000,
> -       0x00010e73, 0xd7610000,
> -       0x00011074, 0xd7610000,
> -       0x00011275, 0xd7610000,
> -       0x00011476, 0xd7610000,
> -       0x00011677, 0xd7610000,
> -       0x00011a79, 0xd7610000,
> -       0x00011c7e, 0xd7610000,
> -       0x00011e7f, 0xbefe00ff,
> -       0x00003fff, 0xbeff0080,
> -       0xdca6c040, 0x007a0000,
> -       0xd760007a, 0x00011d00,
> -       0xd760007b, 0x00011f00,
> +       0xbfa2001e, 0x8b6eff7b,
> +       0x00000400, 0xbfa20041,
> +       0xbf830010, 0xb8fbf803,
> +       0xbfa0fffa, 0x8b6eff7b,
> +       0x00000900, 0xbfa20015,
> +       0x8b6eff7b, 0x000071ff,
> +       0xbfa10008, 0x8b6fff7b,
> +       0x00007080, 0xbfa10001,
> +       0xbeee1287, 0xb8eff801,
> +       0x846e8c6e, 0x8b6e6f6e,
> +       0xbfa2000a, 0x8b6eff6d,
> +       0x00ff0000, 0xbfa20007,
> +       0xb8eef801, 0x8b6eff6e,
> +       0x00000800, 0xbfa20003,
> +       0x8b6eff7b, 0x00000400,
> +       0xbfa20026, 0xbefa4d82,
> +       0xbf89fc07, 0x84fa887a,
> +       0xf4005bbd, 0xf8000010,
> +       0xbf89fc07, 0x846e976e,
> +       0x9177ff77, 0x00800000,
> +       0x8c776e77, 0xf4045bbd,
> +       0xf8000000, 0xbf89fc07,
> +       0xf4045ebd, 0xf8000008,
> +       0xbf89fc07, 0x8bee6e6e,
> +       0xbfa10001, 0xbe80486e,
> +       0x8b6eff6d, 0x01ff0000,
> +       0xbfa20005, 0x8c78ff78,
> +       0x00002000, 0x80ec886c,
> +       0x82ed806d, 0xbfa00005,
> +       0x8b6eff6d, 0x01000000,
> +       0xbfa20002, 0x806c846c,
> +       0x826d806d, 0x8b6dff6d,
> +       0x0000ffff, 0x8bfe7e7e,
> +       0x8bea6a6a, 0xb978f802,
> +       0xbe804a6c, 0x8b6dff6d,
> +       0x0000ffff, 0xbefa0080,
> +       0xb97a0283, 0xbeee007e,
> +       0xbeef007f, 0xbefe0180,
> +       0xbefe4d84, 0xbf89fc07,
> +       0x8b7aff7f, 0x04000000,
> +       0x847a857a, 0x8c6d7a6d,
> +       0xbefa007e, 0x8b7bff7f,
> +       0x0000ffff, 0xbefe00c1,
> +       0xbeff00c1, 0xdca6c000,
> +       0x007a0000, 0x7e000280,
>         0xbefe007a, 0xbeff007b,
> -       0xbef4007e, 0x8b75ff7f,
> -       0x0000ffff, 0x8c75ff75,
> -       0x00040000, 0xbef60080,
> -       0xbef700ff, 0x10807fac,
> -       0xbef1007d, 0xbef00080,
> -       0xb8f302dc, 0x84739973,
> -       0xbefe00c1, 0x857d9973,
> -       0x8b7d817d, 0xbf06817d,
> -       0xbfa20002, 0xbeff0080,
> -       0xbfa00002, 0xbeff00c1,
> -       0xbfa00009, 0xbef600ff,
> -       0x01000000, 0xe0685080,
> -       0x701d0100, 0xe0685100,
> -       0x701d0200, 0xe0685180,
> -       0x701d0300, 0xbfa00008,
> +       0xb8fb02dc, 0x847b997b,
> +       0xb8fa3b05, 0x807a817a,
> +       0xbf0d997b, 0xbfa20002,
> +       0x847a897a, 0xbfa00001,
> +       0x847a8a7a, 0xb8fb1e06,
> +       0x847b8a7b, 0x807a7b7a,
> +       0x8b7bff7f, 0x0000ffff,
> +       0x807aff7a, 0x00000200,
> +       0x807a7e7a, 0x827b807b,
> +       0xd7610000, 0x00010870,
> +       0xd7610000, 0x00010a71,
> +       0xd7610000, 0x00010c72,
> +       0xd7610000, 0x00010e73,
> +       0xd7610000, 0x00011074,
> +       0xd7610000, 0x00011275,
> +       0xd7610000, 0x00011476,
> +       0xd7610000, 0x00011677,
> +       0xd7610000, 0x00011a79,
> +       0xd7610000, 0x00011c7e,
> +       0xd7610000, 0x00011e7f,
> +       0xbefe00ff, 0x00003fff,
> +       0xbeff0080, 0xdca6c040,
> +       0x007a0000, 0xd760007a,
> +       0x00011d00, 0xd760007b,
> +       0x00011f00, 0xbefe007a,
> +       0xbeff007b, 0xbef4007e,
> +       0x8b75ff7f, 0x0000ffff,
> +       0x8c75ff75, 0x00040000,
> +       0xbef60080, 0xbef700ff,
> +       0x10807fac, 0xbef1007d,
> +       0xbef00080, 0xb8f302dc,
> +       0x84739973, 0xbefe00c1,
> +       0x857d9973, 0x8b7d817d,
> +       0xbf06817d, 0xbfa20002,
> +       0xbeff0080, 0xbfa00002,
> +       0xbeff00c1, 0xbfa00009,
>         0xbef600ff, 0x01000000,
> -       0xe0685100, 0x701d0100,
> -       0xe0685200, 0x701d0200,
> -       0xe0685300, 0x701d0300,
> +       0xe0685080, 0x701d0100,
> +       0xe0685100, 0x701d0200,
> +       0xe0685180, 0x701d0300,
> +       0xbfa00008, 0xbef600ff,
> +       0x01000000, 0xe0685100,
> +       0x701d0100, 0xe0685200,
> +       0x701d0200, 0xe0685300,
> +       0x701d0300, 0xb8f03b05,
> +       0x80708170, 0xbf0d9973,
> +       0xbfa20002, 0x84708970,
> +       0xbfa00001, 0x84708a70,
> +       0xb8fa1e06, 0x847a8a7a,
> +       0x80707a70, 0x8070ff70,
> +       0x00000200, 0xbef600ff,
> +       0x01000000, 0x7e000280,
> +       0x7e020280, 0x7e040280,
> +       0xbefd0080, 0xd7610002,
> +       0x0000fa71, 0x807d817d,
> +       0xd7610002, 0x0000fa6c,
> +       0x807d817d, 0x917aff6d,
> +       0x80000000, 0xd7610002,
> +       0x0000fa7a, 0x807d817d,
> +       0xd7610002, 0x0000fa6e,
> +       0x807d817d, 0xd7610002,
> +       0x0000fa6f, 0x807d817d,
> +       0xd7610002, 0x0000fa78,
> +       0x807d817d, 0xb8faf803,
> +       0xd7610002, 0x0000fa7a,
> +       0x807d817d, 0xd7610002,
> +       0x0000fa7b, 0x807d817d,
> +       0xb8f1f801, 0xd7610002,
> +       0x0000fa71, 0x807d817d,
> +       0xb8f1f814, 0xd7610002,
> +       0x0000fa71, 0x807d817d,
> +       0xb8f1f815, 0xd7610002,
> +       0x0000fa71, 0x807d817d,
> +       0xbefe00ff, 0x0000ffff,
> +       0xbeff0080, 0xe0685000,
> +       0x701d0200, 0xbefe00c1,
>         0xb8f03b05, 0x80708170,
>         0xbf0d9973, 0xbfa20002,
>         0x84708970, 0xbfa00001,
>         0x84708a70, 0xb8fa1e06,
>         0x847a8a7a, 0x80707a70,
> -       0x8070ff70, 0x00000200,
>         0xbef600ff, 0x01000000,
> -       0x7e000280, 0x7e020280,
> -       0x7e040280, 0xbefd0080,
> -       0xd7610002, 0x0000fa71,
> -       0x807d817d, 0xd7610002,
> -       0x0000fa6c, 0x807d817d,
> -       0x917aff6d, 0x80000000,
> -       0xd7610002, 0x0000fa7a,
> -       0x807d817d, 0xd7610002,
> -       0x0000fa6e, 0x807d817d,
> -       0xd7610002, 0x0000fa6f,
> -       0x807d817d, 0xd7610002,
> -       0x0000fa78, 0x807d817d,
> -       0xb8faf803, 0xd7610002,
> -       0x0000fa7a, 0x807d817d,
> -       0xd7610002, 0x0000fa7b,
> -       0x807d817d, 0xb8f1f801,
> -       0xd7610002, 0x0000fa71,
> -       0x807d817d, 0xb8f1f814,
> -       0xd7610002, 0x0000fa71,
> -       0x807d817d, 0xb8f1f815,
> -       0xd7610002, 0x0000fa71,
> -       0x807d817d, 0xbefe00ff,
> -       0x0000ffff, 0xbeff0080,
> -       0xe0685000, 0x701d0200,
> -       0xbefe00c1, 0xb8f03b05,
> -       0x80708170, 0xbf0d9973,
> -       0xbfa20002, 0x84708970,
> -       0xbfa00001, 0x84708a70,
> -       0xb8fa1e06, 0x847a8a7a,
> -       0x80707a70, 0xbef600ff,
> -       0x01000000, 0xbef90080,
> -       0xbefd0080, 0xbf800000,
> -       0xbe804100, 0xbe824102,
> -       0xbe844104, 0xbe864106,
> -       0xbe884108, 0xbe8a410a,
> -       0xbe8c410c, 0xbe8e410e,
> -       0xd7610002, 0x0000f200,
> -       0x80798179, 0xd7610002,
> -       0x0000f201, 0x80798179,
> -       0xd7610002, 0x0000f202,
> -       0x80798179, 0xd7610002,
> -       0x0000f203, 0x80798179,
> -       0xd7610002, 0x0000f204,
> +       0xbef90080, 0xbefd0080,
> +       0xbf800000, 0xbe804100,
> +       0xbe824102, 0xbe844104,
> +       0xbe864106, 0xbe884108,
> +       0xbe8a410a, 0xbe8c410c,
> +       0xbe8e410e, 0xd7610002,
> +       0x0000f200, 0x80798179,
> +       0xd7610002, 0x0000f201,
>         0x80798179, 0xd7610002,
> -       0x0000f205, 0x80798179,
> -       0xd7610002, 0x0000f206,
> +       0x0000f202, 0x80798179,
> +       0xd7610002, 0x0000f203,
>         0x80798179, 0xd7610002,
> -       0x0000f207, 0x80798179,
> -       0xd7610002, 0x0000f208,
> +       0x0000f204, 0x80798179,
> +       0xd7610002, 0x0000f205,
>         0x80798179, 0xd7610002,
> -       0x0000f209, 0x80798179,
> -       0xd7610002, 0x0000f20a,
> +       0x0000f206, 0x80798179,
> +       0xd7610002, 0x0000f207,
>         0x80798179, 0xd7610002,
> -       0x0000f20b, 0x80798179,
> -       0xd7610002, 0x0000f20c,
> +       0x0000f208, 0x80798179,
> +       0xd7610002, 0x0000f209,
>         0x80798179, 0xd7610002,
> -       0x0000f20d, 0x80798179,
> -       0xd7610002, 0x0000f20e,
> +       0x0000f20a, 0x80798179,
> +       0xd7610002, 0x0000f20b,
>         0x80798179, 0xd7610002,
> -       0x0000f20f, 0x80798179,
> -       0xbf06a079, 0xbfa10006,
> -       0xe0685000, 0x701d0200,
> -       0x8070ff70, 0x00000080,
> -       0xbef90080, 0x7e040280,
> -       0x807d907d, 0xbf0aff7d,
> -       0x00000060, 0xbfa2ffbc,
> -       0xbe804100, 0xbe824102,
> -       0xbe844104, 0xbe864106,
> -       0xbe884108, 0xbe8a410a,
> -       0xd7610002, 0x0000f200,
> +       0x0000f20c, 0x80798179,
> +       0xd7610002, 0x0000f20d,
>         0x80798179, 0xd7610002,
> -       0x0000f201, 0x80798179,
> -       0xd7610002, 0x0000f202,
> +       0x0000f20e, 0x80798179,
> +       0xd7610002, 0x0000f20f,
> +       0x80798179, 0xbf06a079,
> +       0xbfa10006, 0xe0685000,
> +       0x701d0200, 0x8070ff70,
> +       0x00000080, 0xbef90080,
> +       0x7e040280, 0x807d907d,
> +       0xbf0aff7d, 0x00000060,
> +       0xbfa2ffbc, 0xbe804100,
> +       0xbe824102, 0xbe844104,
> +       0xbe864106, 0xbe884108,
> +       0xbe8a410a, 0xd7610002,
> +       0x0000f200, 0x80798179,
> +       0xd7610002, 0x0000f201,
>         0x80798179, 0xd7610002,
> -       0x0000f203, 0x80798179,
> -       0xd7610002, 0x0000f204,
> +       0x0000f202, 0x80798179,
> +       0xd7610002, 0x0000f203,
>         0x80798179, 0xd7610002,
> -       0x0000f205, 0x80798179,
> -       0xd7610002, 0x0000f206,
> +       0x0000f204, 0x80798179,
> +       0xd7610002, 0x0000f205,
>         0x80798179, 0xd7610002,
> -       0x0000f207, 0x80798179,
> -       0xd7610002, 0x0000f208,
> +       0x0000f206, 0x80798179,
> +       0xd7610002, 0x0000f207,
>         0x80798179, 0xd7610002,
> -       0x0000f209, 0x80798179,
> -       0xd7610002, 0x0000f20a,
> +       0x0000f208, 0x80798179,
> +       0xd7610002, 0x0000f209,
>         0x80798179, 0xd7610002,
> -       0x0000f20b, 0x80798179,
> -       0xe0685000, 0x701d0200,
> +       0x0000f20a, 0x80798179,
> +       0xd7610002, 0x0000f20b,
> +       0x80798179, 0xe0685000,
> +       0x701d0200, 0xbefe00c1,
> +       0x857d9973, 0x8b7d817d,
> +       0xbf06817d, 0xbfa20002,
> +       0xbeff0080, 0xbfa00001,
> +       0xbeff00c1, 0xb8fb4306,
> +       0x8b7bc17b, 0xbfa10044,
> +       0xbfbd0000, 0x8b7aff6d,
> +       0x80000000, 0xbfa10040,
> +       0x847b867b, 0x847b827b,
> +       0xbef6007b, 0xb8f03b05,
> +       0x80708170, 0xbf0d9973,
> +       0xbfa20002, 0x84708970,
> +       0xbfa00001, 0x84708a70,
> +       0xb8fa1e06, 0x847a8a7a,
> +       0x80707a70, 0x8070ff70,
> +       0x00000200, 0x8070ff70,
> +       0x00000080, 0xbef600ff,
> +       0x01000000, 0xd71f0000,
> +       0x000100c1, 0xd7200000,
> +       0x000200c1, 0x16000084,
> +       0x857d9973, 0x8b7d817d,
> +       0xbf06817d, 0xbefd0080,
> +       0xbfa20012, 0xbe8300ff,
> +       0x00000080, 0xbf800000,
> +       0xbf800000, 0xbf800000,
> +       0xd8d80000, 0x01000000,
> +       0xbf890000, 0xe0685000,
> +       0x701d0100, 0x807d037d,
> +       0x80700370, 0xd5250000,
> +       0x0001ff00, 0x00000080,
> +       0xbf0a7b7d, 0xbfa2fff4,
> +       0xbfa00011, 0xbe8300ff,
> +       0x00000100, 0xbf800000,
> +       0xbf800000, 0xbf800000,
> +       0xd8d80000, 0x01000000,
> +       0xbf890000, 0xe0685000,
> +       0x701d0100, 0x807d037d,
> +       0x80700370, 0xd5250000,
> +       0x0001ff00, 0x00000100,
> +       0xbf0a7b7d, 0xbfa2fff4,
>         0xbefe00c1, 0x857d9973,
>         0x8b7d817d, 0xbf06817d,
> -       0xbfa20002, 0xbeff0080,
> -       0xbfa00001, 0xbeff00c1,
> -       0xb8fb4306, 0x8b7bc17b,
> -       0xbfa10044, 0xbfbd0000,
> -       0x8b7aff6d, 0x80000000,
> -       0xbfa10040, 0x847b867b,
> -       0x847b827b, 0xbef6007b,
> -       0xb8f03b05, 0x80708170,
> -       0xbf0d9973, 0xbfa20002,
> -       0x84708970, 0xbfa00001,
> -       0x84708a70, 0xb8fa1e06,
> -       0x847a8a7a, 0x80707a70,
> -       0x8070ff70, 0x00000200,
> -       0x8070ff70, 0x00000080,
> -       0xbef600ff, 0x01000000,
> -       0xd71f0000, 0x000100c1,
> -       0xd7200000, 0x000200c1,
> -       0x16000084, 0x857d9973,
> +       0xbfa20004, 0xbef000ff,
> +       0x00000200, 0xbeff0080,
> +       0xbfa00003, 0xbef000ff,
> +       0x00000400, 0xbeff00c1,
> +       0xb8fb3b05, 0x807b817b,
> +       0x847b827b, 0x857d9973,
>         0x8b7d817d, 0xbf06817d,
> -       0xbefd0080, 0xbfa20012,
> -       0xbe8300ff, 0x00000080,
> -       0xbf800000, 0xbf800000,
> -       0xbf800000, 0xd8d80000,
> -       0x01000000, 0xbf890000,
> -       0xe0685000, 0x701d0100,
> -       0x807d037d, 0x80700370,
> -       0xd5250000, 0x0001ff00,
> -       0x00000080, 0xbf0a7b7d,
> -       0xbfa2fff4, 0xbfa00011,
> -       0xbe8300ff, 0x00000100,
> -       0xbf800000, 0xbf800000,
> -       0xbf800000, 0xd8d80000,
> -       0x01000000, 0xbf890000,
> -       0xe0685000, 0x701d0100,
> -       0x807d037d, 0x80700370,
> -       0xd5250000, 0x0001ff00,
> -       0x00000100, 0xbf0a7b7d,
> -       0xbfa2fff4, 0xbefe00c1,
> -       0x857d9973, 0x8b7d817d,
> -       0xbf06817d, 0xbfa20004,
> -       0xbef000ff, 0x00000200,
> -       0xbeff0080, 0xbfa00003,
> -       0xbef000ff, 0x00000400,
> -       0xbeff00c1, 0xb8fb3b05,
> -       0x807b817b, 0x847b827b,
> -       0x857d9973, 0x8b7d817d,
> -       0xbf06817d, 0xbfa20017,
> +       0xbfa20017, 0xbef600ff,
> +       0x01000000, 0xbefd0084,
> +       0xbf0a7b7d, 0xbfa10037,
> +       0x7e008700, 0x7e028701,
> +       0x7e048702, 0x7e068703,
> +       0xe0685000, 0x701d0000,
> +       0xe0685080, 0x701d0100,
> +       0xe0685100, 0x701d0200,
> +       0xe0685180, 0x701d0300,
> +       0x807d847d, 0x8070ff70,
> +       0x00000200, 0xbf0a7b7d,
> +       0xbfa2ffef, 0xbfa00025,
>         0xbef600ff, 0x01000000,
>         0xbefd0084, 0xbf0a7b7d,
> -       0xbfa10037, 0x7e008700,
> +       0xbfa10011, 0x7e008700,
>         0x7e028701, 0x7e048702,
>         0x7e068703, 0xe0685000,
> -       0x701d0000, 0xe0685080,
> -       0x701d0100, 0xe0685100,
> -       0x701d0200, 0xe0685180,
> +       0x701d0000, 0xe0685100,
> +       0x701d0100, 0xe0685200,
> +       0x701d0200, 0xe0685300,
>         0x701d0300, 0x807d847d,
> -       0x8070ff70, 0x00000200,
> +       0x8070ff70, 0x00000400,
>         0xbf0a7b7d, 0xbfa2ffef,
> -       0xbfa00025, 0xbef600ff,
> -       0x01000000, 0xbefd0084,
> -       0xbf0a7b7d, 0xbfa10011,
> -       0x7e008700, 0x7e028701,
> -       0x7e048702, 0x7e068703,
> +       0xb8fb1e06, 0x8b7bc17b,
> +       0xbfa1000c, 0x847b837b,
> +       0x807b7d7b, 0xbefe00c1,
> +       0xbeff0080, 0x7e008700,
>         0xe0685000, 0x701d0000,
> -       0xe0685100, 0x701d0100,
> -       0xe0685200, 0x701d0200,
> -       0xe0685300, 0x701d0300,
> -       0x807d847d, 0x8070ff70,
> -       0x00000400, 0xbf0a7b7d,
> -       0xbfa2ffef, 0xb8fb1e06,
> -       0x8b7bc17b, 0xbfa1000c,
> -       0x847b837b, 0x807b7d7b,
> -       0xbefe00c1, 0xbeff0080,
> -       0x7e008700, 0xe0685000,
> -       0x701d0000, 0x807d817d,
> -       0x8070ff70, 0x00000080,
> -       0xbf0a7b7d, 0xbfa2fff8,
> -       0xbfa00141, 0xbef4007e,
> -       0x8b75ff7f, 0x0000ffff,
> -       0x8c75ff75, 0x00040000,
> -       0xbef60080, 0xbef700ff,
> -       0x10807fac, 0xb8f202dc,
> -       0x84729972, 0x8b6eff7f,
> -       0x04000000, 0xbfa1003a,
> +       0x807d817d, 0x8070ff70,
> +       0x00000080, 0xbf0a7b7d,
> +       0xbfa2fff8, 0xbfa00146,
> +       0xbef4007e, 0x8b75ff7f,
> +       0x0000ffff, 0x8c75ff75,
> +       0x00040000, 0xbef60080,
> +       0xbef700ff, 0x10807fac,
> +       0xb8f202dc, 0x84729972,
> +       0x8b6eff7f, 0x04000000,
> +       0xbfa1003a, 0xbefe00c1,
> +       0x857d9972, 0x8b7d817d,
> +       0xbf06817d, 0xbfa20002,
> +       0xbeff0080, 0xbfa00001,
> +       0xbeff00c1, 0xb8ef4306,
> +       0x8b6fc16f, 0xbfa1002f,
> +       0x846f866f, 0x846f826f,
> +       0xbef6006f, 0xb8f83b05,
> +       0x80788178, 0xbf0d9972,
> +       0xbfa20002, 0x84788978,
> +       0xbfa00001, 0x84788a78,
> +       0xb8ee1e06, 0x846e8a6e,
> +       0x80786e78, 0x8078ff78,
> +       0x00000200, 0x8078ff78,
> +       0x00000080, 0xbef600ff,
> +       0x01000000, 0x857d9972,
> +       0x8b7d817d, 0xbf06817d,
> +       0xbefd0080, 0xbfa2000c,
> +       0xe0500000, 0x781d0000,
> +       0xbf8903f7, 0xdac00000,
> +       0x00000000, 0x807dff7d,
> +       0x00000080, 0x8078ff78,
> +       0x00000080, 0xbf0a6f7d,
> +       0xbfa2fff5, 0xbfa0000b,
> +       0xe0500000, 0x781d0000,
> +       0xbf8903f7, 0xdac00000,
> +       0x00000000, 0x807dff7d,
> +       0x00000100, 0x8078ff78,
> +       0x00000100, 0xbf0a6f7d,
> +       0xbfa2fff5, 0xbef80080,
>         0xbefe00c1, 0x857d9972,
>         0x8b7d817d, 0xbf06817d,
>         0xbfa20002, 0xbeff0080,
>         0xbfa00001, 0xbeff00c1,
> -       0xb8ef4306, 0x8b6fc16f,
> -       0xbfa1002f, 0x846f866f,
> -       0x846f826f, 0xbef6006f,
> -       0xb8f83b05, 0x80788178,
> -       0xbf0d9972, 0xbfa20002,
> -       0x84788978, 0xbfa00001,
> -       0x84788a78, 0xb8ee1e06,
> -       0x846e8a6e, 0x80786e78,
> +       0xb8ef3b05, 0x806f816f,
> +       0x846f826f, 0x857d9972,
> +       0x8b7d817d, 0xbf06817d,
> +       0xbfa20024, 0xbef600ff,
> +       0x01000000, 0xbeee0078,
>         0x8078ff78, 0x00000200,
> -       0x8078ff78, 0x00000080,
> -       0xbef600ff, 0x01000000,
> -       0x857d9972, 0x8b7d817d,
> -       0xbf06817d, 0xbefd0080,
> -       0xbfa2000c, 0xe0500000,
> -       0x781d0000, 0xbf8903f7,
> -       0xdac00000, 0x00000000,
> -       0x807dff7d, 0x00000080,
> -       0x8078ff78, 0x00000080,
> -       0xbf0a6f7d, 0xbfa2fff5,
> -       0xbfa0000b, 0xe0500000,
> -       0x781d0000, 0xbf8903f7,
> -       0xdac00000, 0x00000000,
> -       0x807dff7d, 0x00000100,
> -       0x8078ff78, 0x00000100,
> -       0xbf0a6f7d, 0xbfa2fff5,
> -       0xbef80080, 0xbefe00c1,
> -       0x857d9972, 0x8b7d817d,
> -       0xbf06817d, 0xbfa20002,
> -       0xbeff0080, 0xbfa00001,
> -       0xbeff00c1, 0xb8ef3b05,
> -       0x806f816f, 0x846f826f,
> -       0x857d9972, 0x8b7d817d,
> -       0xbf06817d, 0xbfa20024,
> -       0xbef600ff, 0x01000000,
> -       0xbeee0078, 0x8078ff78,
> -       0x00000200, 0xbefd0084,
> -       0xbf0a6f7d, 0xbfa10050,
> +       0xbefd0084, 0xbf0a6f7d,
> +       0xbfa10050, 0xe0505000,
> +       0x781d0000, 0xe0505080,
> +       0x781d0100, 0xe0505100,
> +       0x781d0200, 0xe0505180,
> +       0x781d0300, 0xbf8903f7,
> +       0x7e008500, 0x7e028501,
> +       0x7e048502, 0x7e068503,
> +       0x807d847d, 0x8078ff78,
> +       0x00000200, 0xbf0a6f7d,
> +       0xbfa2ffee, 0xe0505000,
> +       0x6e1d0000, 0xe0505080,
> +       0x6e1d0100, 0xe0505100,
> +       0x6e1d0200, 0xe0505180,
> +       0x6e1d0300, 0xbf8903f7,
> +       0xbfa00034, 0xbef600ff,
> +       0x01000000, 0xbeee0078,
> +       0x8078ff78, 0x00000400,
> +       0xbefd0084, 0xbf0a6f7d,
> +       0xbfa10012, 0xe0505000,
> +       0x781d0000, 0xe0505100,
> +       0x781d0100, 0xe0505200,
> +       0x781d0200, 0xe0505300,
> +       0x781d0300, 0xbf8903f7,
> +       0x7e008500, 0x7e028501,
> +       0x7e048502, 0x7e068503,
> +       0x807d847d, 0x8078ff78,
> +       0x00000400, 0xbf0a6f7d,
> +       0xbfa2ffee, 0xb8ef1e06,
> +       0x8b6fc16f, 0xbfa1000e,
> +       0x846f836f, 0x806f7d6f,
> +       0xbefe00c1, 0xbeff0080,
>         0xe0505000, 0x781d0000,
> -       0xe0505080, 0x781d0100,
> -       0xe0505100, 0x781d0200,
> -       0xe0505180, 0x781d0300,
>         0xbf8903f7, 0x7e008500,
> -       0x7e028501, 0x7e048502,
> -       0x7e068503, 0x807d847d,
> -       0x8078ff78, 0x00000200,
> -       0xbf0a6f7d, 0xbfa2ffee,
> +       0x807d817d, 0x8078ff78,
> +       0x00000080, 0xbf0a6f7d,
> +       0xbfa2fff7, 0xbeff00c1,
>         0xe0505000, 0x6e1d0000,
> -       0xe0505080, 0x6e1d0100,
> -       0xe0505100, 0x6e1d0200,
> -       0xe0505180, 0x6e1d0300,
> -       0xbf8903f7, 0xbfa00034,
> -       0xbef600ff, 0x01000000,
> -       0xbeee0078, 0x8078ff78,
> -       0x00000400, 0xbefd0084,
> -       0xbf0a6f7d, 0xbfa10012,
> -       0xe0505000, 0x781d0000,
> -       0xe0505100, 0x781d0100,
> -       0xe0505200, 0x781d0200,
> -       0xe0505300, 0x781d0300,
> -       0xbf8903f7, 0x7e008500,
> -       0x7e028501, 0x7e048502,
> -       0x7e068503, 0x807d847d,
> -       0x8078ff78, 0x00000400,
> -       0xbf0a6f7d, 0xbfa2ffee,
> -       0xb8ef1e06, 0x8b6fc16f,
> -       0xbfa1000e, 0x846f836f,
> -       0x806f7d6f, 0xbefe00c1,
> -       0xbeff0080, 0xe0505000,
> -       0x781d0000, 0xbf8903f7,
> -       0x7e008500, 0x807d817d,
> -       0x8078ff78, 0x00000080,
> -       0xbf0a6f7d, 0xbfa2fff7,
> -       0xbeff00c1, 0xe0505000,
> -       0x6e1d0000, 0xe0505100,
> -       0x6e1d0100, 0xe0505200,
> -       0x6e1d0200, 0xe0505300,
> -       0x6e1d0300, 0xbf8903f7,
> +       0xe0505100, 0x6e1d0100,
> +       0xe0505200, 0x6e1d0200,
> +       0xe0505300, 0x6e1d0300,
> +       0xbf8903f7, 0xb8f83b05,
> +       0x80788178, 0xbf0d9972,
> +       0xbfa20002, 0x84788978,
> +       0xbfa00001, 0x84788a78,
> +       0xb8ee1e06, 0x846e8a6e,
> +       0x80786e78, 0x8078ff78,
> +       0x00000200, 0x80f8ff78,
> +       0x00000050, 0xbef600ff,
> +       0x01000000, 0xbefd00ff,
> +       0x0000006c, 0x80f89078,
> +       0xf428403a, 0xf0000000,
> +       0xbf89fc07, 0x80fd847d,
> +       0xbf800000, 0xbe804300,
> +       0xbe824302, 0x80f8a078,
> +       0xf42c403a, 0xf0000000,
> +       0xbf89fc07, 0x80fd887d,
> +       0xbf800000, 0xbe804300,
> +       0xbe824302, 0xbe844304,
> +       0xbe864306, 0x80f8c078,
> +       0xf430403a, 0xf0000000,
> +       0xbf89fc07, 0x80fd907d,
> +       0xbf800000, 0xbe804300,
> +       0xbe824302, 0xbe844304,
> +       0xbe864306, 0xbe884308,
> +       0xbe8a430a, 0xbe8c430c,
> +       0xbe8e430e, 0xbf06807d,
> +       0xbfa1fff0, 0xb980f801,
> +       0x00000000, 0xbfbd0000,
>         0xb8f83b05, 0x80788178,
>         0xbf0d9972, 0xbfa20002,
>         0x84788978, 0xbfa00001,
>         0x84788a78, 0xb8ee1e06,
>         0x846e8a6e, 0x80786e78,
>         0x8078ff78, 0x00000200,
> -       0x80f8ff78, 0x00000050,
>         0xbef600ff, 0x01000000,
> -       0xbefd00ff, 0x0000006c,
> -       0x80f89078, 0xf428403a,
> -       0xf0000000, 0xbf89fc07,
> -       0x80fd847d, 0xbf800000,
> -       0xbe804300, 0xbe824302,
> -       0x80f8a078, 0xf42c403a,
> -       0xf0000000, 0xbf89fc07,
> -       0x80fd887d, 0xbf800000,
> -       0xbe804300, 0xbe824302,
> -       0xbe844304, 0xbe864306,
> -       0x80f8c078, 0xf430403a,
> -       0xf0000000, 0xbf89fc07,
> -       0x80fd907d, 0xbf800000,
> -       0xbe804300, 0xbe824302,
> -       0xbe844304, 0xbe864306,
> -       0xbe884308, 0xbe8a430a,
> -       0xbe8c430c, 0xbe8e430e,
> -       0xbf06807d, 0xbfa1fff0,
> -       0xb980f801, 0x00000000,
> -       0xbfbd0000, 0xb8f83b05,
> -       0x80788178, 0xbf0d9972,
> -       0xbfa20002, 0x84788978,
> -       0xbfa00001, 0x84788a78,
> -       0xb8ee1e06, 0x846e8a6e,
> -       0x80786e78, 0x8078ff78,
> -       0x00000200, 0xbef600ff,
> -       0x01000000, 0xf4205bfa,
> +       0xf4205bfa, 0xf0000000,
> +       0x80788478, 0xf4205b3a,
>         0xf0000000, 0x80788478,
> -       0xf4205b3a, 0xf0000000,
> -       0x80788478, 0xf4205b7a,
> +       0xf4205b7a, 0xf0000000,
> +       0x80788478, 0xf4205c3a,
>         0xf0000000, 0x80788478,
> -       0xf4205c3a, 0xf0000000,
> -       0x80788478, 0xf4205c7a,
> +       0xf4205c7a, 0xf0000000,
> +       0x80788478, 0xf4205eba,
>         0xf0000000, 0x80788478,
> -       0xf4205eba, 0xf0000000,
> -       0x80788478, 0xf4205efa,
> +       0xf4205efa, 0xf0000000,
> +       0x80788478, 0xf4205e7a,
>         0xf0000000, 0x80788478,
> -       0xf4205e7a, 0xf0000000,
> -       0x80788478, 0xf4205cfa,
> +       0xf4205cfa, 0xf0000000,
> +       0x80788478, 0xf4205bba,
>         0xf0000000, 0x80788478,
> +       0xbf89fc07, 0xb96ef814,
>         0xf4205bba, 0xf0000000,
>         0x80788478, 0xbf89fc07,
> -       0xb96ef814, 0xf4205bba,
> -       0xf0000000, 0x80788478,
> -       0xbf89fc07, 0xb96ef815,
> -       0xbefd006f, 0xbefe0070,
> -       0xbeff0071, 0x8b6f7bff,
> -       0x000003ff, 0xb96f4803,
> -       0x8b6f7bff, 0xfffff800,
> -       0x856f8b6f, 0xb96fa2c3,
> -       0xb973f801, 0xb8ee3b05,
> -       0x806e816e, 0xbf0d9972,
> -       0xbfa20002, 0x846e896e,
> -       0xbfa00001, 0x846e8a6e,
> -       0xb8ef1e06, 0x846f8a6f,
> -       0x806e6f6e, 0x806eff6e,
> -       0x00000200, 0x806e746e,
> -       0x826f8075, 0x8b6fff6f,
> -       0x0000ffff, 0xf4085c37,
> -       0xf8000050, 0xf4085d37,
> -       0xf8000060, 0xf4005e77,
> -       0xf8000074, 0xbf89fc07,
> -       0x8b6dff6d, 0x0000ffff,
> -       0x8bfe7e7e, 0x8bea6a6a,
> +       0xb96ef815, 0xbefd006f,
> +       0xbefe0070, 0xbeff0071,
> +       0x8b6f7bff, 0x000003ff,
> +       0xb96f4803, 0x8b6f7bff,
> +       0xfffff800, 0x856f8b6f,
> +       0xb96fa2c3, 0xb973f801,
> +       0xb8ee3b05, 0x806e816e,
> +       0xbf0d9972, 0xbfa20002,
> +       0x846e896e, 0xbfa00001,
> +       0x846e8a6e, 0xb8ef1e06,
> +       0x846f8a6f, 0x806e6f6e,
> +       0x806eff6e, 0x00000200,
> +       0x806e746e, 0x826f8075,
> +       0x8b6fff6f, 0x0000ffff,
> +       0xf4085c37, 0xf8000050,
> +       0xf4085d37, 0xf8000060,
> +       0xf4005e77, 0xf8000074,
> +       0xbf89fc07, 0x8b6dff6d,
> +       0x0000ffff, 0x8bfe7e7e,
> +       0x8bea6a6a, 0xb8eef802,
> +       0xbf0d866e, 0xbfa20002,
> +       0xb97af802, 0xbe80486c,
>         0xb97af802, 0xbe804a6c,
>         0xbfb00000, 0xbf9f0000,
>         0xbf9f0000, 0xbf9f0000,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index 250ab007399b..0f81670f6f9c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -43,12 +43,14 @@
>  #define HAVE_XNACK (ASIC_FAMILY < CHIP_SIENNA_CICHLID)  #define
> HAVE_SENDMSG_RTN (ASIC_FAMILY >=3D CHIP_PLUM_BONITO)  #define
> HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
> +#define SW_SA_TRAP (ASIC_FAMILY >=3D CHIP_PLUM_BONITO)
>=20
>  var SINGLE_STEP_MISSED_WORKAROUND              =3D 1     //workaround fo=
r
> lost MODE.DEBUG_EN exception when SAVECTX raised
>=20
>  var SQ_WAVE_STATUS_SPI_PRIO_MASK               =3D 0x00000006
>  var SQ_WAVE_STATUS_HALT_MASK                   =3D 0x2000
>  var SQ_WAVE_STATUS_ECC_ERR_MASK                        =3D 0x20000
> +var SQ_WAVE_STATUS_TRAP_EN_SHIFT               =3D 6
>=20
>  var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT           =3D 12
>  var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE            =3D 9
> @@ -183,6 +185,13 @@ L_SKIP_RESTORE:
>=20
>         s_getreg_b32    s_save_trapsts, hwreg(HW_REG_TRAPSTS)
>=20
> +#if SW_SA_TRAP
> +       // If ttmp1[31] is set then trap may occur early.
> +       // Spin wait until SAVECTX exception is raised.
> +       s_bitcmp1_b32   s_save_pc_hi, 31
> +       s_cbranch_scc1  L_CHECK_SAVE
> +#endif
> +
>         s_and_b32       ttmp2, s_save_status, SQ_WAVE_STATUS_HALT_MASK
>         s_cbranch_scc0  L_NOT_HALTED
>=20
> @@ -1061,8 +1070,20 @@ L_RESTORE_HWREG:
>         s_and_b32       s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff
> //pc[47:32] //Do it here in order not to affect STATUS
>         s_and_b64       exec, exec, exec                                 =
       // Restore
> STATUS.EXECZ, not writable by s_setreg_b32
>         s_and_b64       vcc, vcc, vcc                                    =
       // Restore STATUS.VCCZ,
> not writable by s_setreg_b32
> +
> +#if SW_SA_TRAP
> +       // If traps are enabled then return to the shader with PRIV=3D0.
> +       // Otherwise retain PRIV=3D1 for subsequent context save requests=
.
> +       s_getreg_b32    s_restore_tmp, hwreg(HW_REG_STATUS)
> +       s_bitcmp1_b32   s_restore_tmp, SQ_WAVE_STATUS_TRAP_EN_SHIFT
> +       s_cbranch_scc1  L_RETURN_WITHOUT_PRIV
> +
>         s_setreg_b32    hwreg(HW_REG_STATUS), s_restore_status           =
       //
> SCC is included, which is changed by previous salu
> +       s_setpc_b64     [s_restore_pc_lo, s_restore_pc_hi]
> +L_RETURN_WITHOUT_PRIV:
> +#endif
>=20
> +       s_setreg_b32    hwreg(HW_REG_STATUS), s_restore_status           =
       //
> SCC is included, which is changed by previous salu
>         s_rfe_b64       s_restore_pc_lo                                  =
       //Return to the main
> shader program and resume execution
>=20
>  L_END_PGM:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index a6fcbeeb7428..4e03d19e9333 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -358,13 +358,35 @@ static void event_interrupt_wq_v11(struct kfd_dev
> *dev,
>                                 break;
>                         case SQ_INTERRUPT_WORD_ENCODING_ERROR:
>                                 print_sq_intr_info_error(context_id0, con=
text_id1);
> +                               sq_int_priv =3D REG_GET_FIELD(context_id0=
,
> +
> + SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
>                                 sq_int_errtype =3D REG_GET_FIELD(context_=
id0,
>                                                 SQ_INTERRUPT_WORD_ERROR_C=
TXID0, TYPE);
> -                               if (sq_int_errtype !=3D
> SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
> -                                   sq_int_errtype !=3D
> SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
> +
> +                               switch (sq_int_errtype) {
> +                               case SQ_INTERRUPT_ERROR_TYPE_EDC_FUE:
> +                               case SQ_INTERRUPT_ERROR_TYPE_EDC_FED:
>                                         event_interrupt_poison_consumptio=
n_v11(
>                                                         dev, pasid, sourc=
e_id);
>                                         return;
> +                               case SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST=
:
> +                                       /*if (!(((adev->mes.sched_version=
 &
> AMDGPU_MES_VERSION_MASK) >=3D 4) &&
> +                                                 (adev->ip_versions[GC_H=
WIP][0] >=3D
> IP_VERSION(11, 0, 0)) &&
> +                                                 (adev->ip_versions[GC_H=
WIP][0] <=3D
> IP_VERSION(11, 0, 3)))
> +                                               && sq_int_priv)
> +                                               kfd_set_dbg_ev_from_inter=
rupt(dev, pasid, -1,
> +
> KFD_EC_MASK(EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION),
> +                                                       NULL, 0);*/
> +                                       return;
> +                               case SQ_INTERRUPT_ERROR_TYPE_MEMVIOL:
> +                                       /*if (!(((adev->mes.sched_version=
 &
> AMDGPU_MES_VERSION_MASK) >=3D 4) &&
> +                                                 (adev->ip_versions[GC_H=
WIP][0] >=3D
> IP_VERSION(11, 0, 0)) &&
> +                                                 (adev->ip_versions[GC_H=
WIP][0] <=3D
> IP_VERSION(11, 0, 3)))
> +                                               && sq_int_priv)
> +                                               kfd_set_dbg_ev_from_inter=
rupt(dev, pasid, -1,
> +
> KFD_EC_MASK(EC_QUEUE_WAVE_MEMORY_VIOLATION),
> +                                                       NULL, 0);*/
> +                                       return;
>                                 }
>                                 break;
>                         default:
> --
> 2.36.1
