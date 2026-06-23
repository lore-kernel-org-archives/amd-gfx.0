Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8E1CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 05:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC4210E940;
	Tue, 23 Jun 2026 05:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L10wVNww";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F7810E940
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 05:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTIR2evXcfhiGEwTjCO2hNJzEjzIv19sukBAeT4NcyXfIhoN92ENcTBuQ0/CU60f0ROTA/Ajb1fiuSbJF7tGJmXQoG1D+6RqAFumx4uLrCxCDnDVarWoiApO91k79D5C1Mf3jluJNskaT1kahT2tlOAhFuc6LHVJVMIvURXB526zd/MrpYmY6PuzCvSR2X9pQrAdsDa0v+5TIRpEbSJv3qdC571VtjgiljDe2JD4cZ+zZOZC2b2zfMyPMLdtWpBTjBytnbjsppAEPPWBt7w2Wq7HJT9/UU1IsAhFLeS3bYYdEV2lEmbLJuDaLQC+ac4Ovzbv2zvqohKtNzkyad5IhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIq9qgGX74owovhjxqo8iOhQkYZLuwRZcW21WXnk9z8=;
 b=fcKdLJTsPL/MtJH/Y9O7j/FLKJdKoJBYwzeNbgGTIPt9Ho3j+WMqLA/WhMKwi3echwPKAor5aKVV7h4oAz5XE3at6vLWbI+I6/8NrtVpriLGRPEgJuKFV54cjqjMBkW9PXByvv5OsLrSlNal/TzLDM+7eMVuzl77A0GgPtCNJ/ku9ycS8YLvp8Il2n7PYNLBl6EIIrAdYveN88VNu6+p8A8cG4KBfUr3m4otXs/mXnxsCOO2LMwZPLm1oFvKAQmFlPbVaE8JjSQAjav9Zz/XY3CFdlAcdmosfQGIL1T6mcI/g857Zggvx7/tfahIfW5AH83Nnz8kbotBUX5lIcXj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIq9qgGX74owovhjxqo8iOhQkYZLuwRZcW21WXnk9z8=;
 b=L10wVNww+6dz6xFFNwzHq8LTgUbelr2ZMMptnjposrJpqpVFYtFnfEHIPcK2hr+PdCoHahIWlYEwZKTw5482wkKOV4Bv9WcF3uoXt/Vz1gXBB1Ay1m80OfV7rWMkSH1c+S2ltNKyXRTAW7uw7YBezCculwLiLBWqZ/EB6KjxHU8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 05:19:45 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 05:19:45 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/mes12: drop queue state on RESET_QUEUES
 unmap
Thread-Topic: [PATCH 1/3] drm/amdgpu/mes12: drop queue state on RESET_QUEUES
 unmap
Thread-Index: AQHdAMrMjep6X6qeA026Rr9mMsZG/bZKxPIAgADZCTA=
Date: Tue, 23 Jun 2026 05:19:45 +0000
Message-ID: <BL1PR12MB514414F4A3C0D040FD276A9FE3EE2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
 <CH0PR12MB53728BD74622166EAA305ADAF4EF2@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53728BD74622166EAA305ADAF4EF2@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T16:20:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB6849:EE_
x-ms-office365-filtering-correlation-id: 876547ac-eb04-4e75-7ba0-08ded0e709d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: 5tEG+g5wacbznRZ08+HVFtQ72RsQGF/07shcJIaS+hG/WZYuDKNBYC1ueMgf4OGy0ukYO+I3LVavWvbxPJ4fW7UoZbClz3ao7R1pgW1DTECtN+ClQGGI/+PXb6XjZiauifvdc2lWl3Vb1zLN2UCwi20MdbINkU25ggnavJV6PkHipbDlQR1xSts5B9P3tpsOlR/5+PzKqtDx+15262PDIRJmtjLURz+1PNWnyWNmeMEoIrl197zh9nVQVKuso4qGYefQLcn5KIF07yQYrS1W8QN/3aIh/l7DxPZA0NqLm9J0MYS5wizxyWMA1LdMjymiAhaKWMzQFl7YT31GRidCxaLQ/oZ7JYSrme5SCaXnliPBH6yRSOz1WMGo5fQxR2AYxudjkDgsuE7PEimUXoxjEmejuJpo3dMoVr0ndCQm5CV6eqxUuaUDDMrurM8ShkAwBdEWrRa6T6o0KeUSC2Q2/ckxeyaMTb/ArkU7kFwvLcz80CRY4+ylou+5M/Qw9J/nM8V/Uh4J8oTS19zJ5VhTD81+i2jI82CDjoSnZXB/NZVnw15raWLYPGIhDRIsKimYPDWIlXwu0nsdlNSIrsm7UFhfE2Ju1qEFXrI37A4ct+Nm772dDqL2GSJTBBt8y+xSLg/W7CgRHFrl6rRluCT6fwcT+oW5PsC1wbwNQZtnXuT3e/0hvvQRrGaDlb/+Vt+dPkC96MIZrT3ksyLLHDsQkeAdV0rU1GNpVgKlohsbbkU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5dfRqxBbQVT3jqdcLjfDhRQzbSMVYZEtdHwn0yL9WJHgMkoyaOe2BsXL8kzE?=
 =?us-ascii?Q?73lUKSltuLoN1AlSWxARGwIBeC/sGLPYviNJsa1FJ8mOIWYAFTBEogUPgR1q?=
 =?us-ascii?Q?W8VJunYzqTFMp+CgItCw8diJXPEgEhhADmnz51TwViLM41LmDlx6Eg6hAAn8?=
 =?us-ascii?Q?X2s3aJ9blAVNecgcnExBe6/X3krpPE1pIj5GsSJoea+GoWT7IWjRKQ9QhcgN?=
 =?us-ascii?Q?OMLE3S0hIO7l0S8vWwX2pq+skRsobS3HJr5wWu3Gf/uGjjejhIps3E3u9pZw?=
 =?us-ascii?Q?r5dsTVBqBd7Q2mtRipu6fHFVR+zlv1vxq2Nd+0PisNMJ0ErfCIlcUYGIqW8q?=
 =?us-ascii?Q?tMm9wQ4Ro0ICey4Wvj8W9VyeFSsrM7nwZc/0byCzCNAFPp3VarFTCrm+7KOt?=
 =?us-ascii?Q?hH9LQ2yV9dTpHQtkMDXxh6U05C8T4X0rYruaaZpEmh34wDBThV+SbdJk6Mug?=
 =?us-ascii?Q?YWGHR0WEs525gz9nK3BSQmV1nCXN8M2IhMpZwbnBkAIACSh31+cXdSweAn/r?=
 =?us-ascii?Q?MWeekOj4REbToIfl8FfXpG9VjdZ+RjitSQk4bRJE2shYWSUoah7Nju5+EWFr?=
 =?us-ascii?Q?qQWNh8maE0sDlBamZ2WUocQcj+hA10JiKt8zYR5l9p3lufBzagJMU2KVpibd?=
 =?us-ascii?Q?wbHkg+1BDiD/aGuJtP5oyPPIv1jnCdSrOh07vzEz1/UmHgoVZ/oOiEsQLAko?=
 =?us-ascii?Q?hkkRkGfTytqn1uQDObcySa6/TbL62EMGU23R8GsUK/4OYfP3quSO21O7SF8P?=
 =?us-ascii?Q?08wpLNyDA3JoXLtI2fZZGk2SoV793JIwg+61r8viavISnrX0swT8JB6xWcPu?=
 =?us-ascii?Q?RjZdpF/qYPIYRBvTsjJsS99TfsBkkcgnrfPC/tfvPlVp6ocAYXYajeIR/K1L?=
 =?us-ascii?Q?3x69JGzLAmGbAtIMqGbWLocnwoFFvH5jlDzmZjh0eNu4KXuhnsG4u/41lXHD?=
 =?us-ascii?Q?kTd2RZaK7wYQdYaEkwE8MJsbC13ehYT5J4NEHjYwk6lXT97e/eJ51S6SstYH?=
 =?us-ascii?Q?SjHQdFtrDIgX6dHt6ES01Ko6moqh0wpo+2vMsRMMwf9ei2DD0G1oki0DOxDI?=
 =?us-ascii?Q?EmKYeYcpAwzLYscG6O6mtYzA4rbxj5bZcoeQQ0SyOliU4/Wg7sblAaG4iwHr?=
 =?us-ascii?Q?92zHr+90EA51A7NWLJCaljoK7f/l0nKTH0AstbN0d3kFLJTEJbaRzKRyh1ic?=
 =?us-ascii?Q?5srcF52X02EnPI7pLuXOn+Hhw8vxjfCK7EGcoW4hZ94YoUJHtnzg2AEkI3rg?=
 =?us-ascii?Q?rKdA3NA+9tlKR5AF3QjuHQ+Sb3yJZhQHKhRC7YytNSXKcTjhmH0oFytBXVbQ?=
 =?us-ascii?Q?RmbI158ivESt0vFaKjdwC1A/l/rBa961GkCiPdjGI60rUTF0qfAsjcDnEhDz?=
 =?us-ascii?Q?ZZhwW/2zSARBccypqDEx+WGrnt1wLqZNhtaQaKl4kvqWYNrdjY3+hpSyXobY?=
 =?us-ascii?Q?64AAvndMooo1eimzmToby9Iq6VNm53AhyaSgiJSuqwLWC0iZqq5bgOYZUIjM?=
 =?us-ascii?Q?VeHPIphy995FSFPB6ysmKj4Z6h8xonujkyGmsHy/XeCv6uVu+YZx4kzAm/Pe?=
 =?us-ascii?Q?QryPg0HSCs9HmpiJWkvPoqnSpAsPHwwNTRTMS8kYYQBALoWX4SKCapc7LpAt?=
 =?us-ascii?Q?HeQM7vN812ocpWFPaukRx56jpHvym5ua82RbZgHWmYzwu3nOvbryUq6KZW2+?=
 =?us-ascii?Q?J4egMl+MxRs2mE2mBJf4y7PtTvlOs41hBZ77Y8Bzkxzp8DKY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876547ac-eb04-4e75-7ba0-08ded0e709d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 05:19:45.3959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79xkUE6eTGGdKldt9w1zOxt39bS1PptQOKbHWdvrKp59WY0PDirjzQZYGMfA0sZ0DQ5ohKA6KAx85XBevc9g0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849
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
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Tuesday, June 23, 2026 12:22 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lin, Amber <Amber.Lin@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH 1/3] drm/amdgpu/mes12: drop queue state on
> RESET_QUEUES unmap
>
> AMD General
>
> Shouldn't this apply to mes v11 as well ?
Thanks Shaoyun. I will prepare the patch for mev v11 .
>
> Shaoyun.liu
>
> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Saturday, June 20, 2026 11:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Lin,
> Amber <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu/mes12: drop queue state on RESET_QUEUES
> unmap
>
> Set remove_queue_after_reset=3D1 (MES >=3D 0x5a) so MES drops its interna=
l state
> instead of re-unmapping an already MMIO-reset queue, which can timeout in=
to a
> GPU reset.
>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index d80a983b1b6c..20f4fd57b1da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -749,6 +749,17 @@ static int mes_v12_0_unmap_legacy_queue(struct
> amdgpu_mes *mes,
>                 mes_remove_queue_pkt.unmap_legacy_queue =3D 1;
>                 mes_remove_queue_pkt.queue_type =3D
>                         convert_to_mes_queue_type(input->queue_type);
> +               /*
> +                * A reset-time unmap: the queue was already reset via MM=
IO while
> +                * gangs are suspended and it is on the MES hung/fail lis=
t. Tell
> +                * MES to just drop its internal state for it. Without th=
is flag
> +                * MES asks CP to unmap the already-reset (still wedged) =
queue
> +                * again, which times out and forces a GPU reset.
> +                */
> +               if (input->action =3D=3D RESET_QUEUES &&
> +                   (mes->sched_version & AMDGPU_MES_VERSION_MASK) >=3D
> 0x5a)
> +                       mes_remove_queue_pkt.remove_queue_after_reset =3D=
 1;
> +
>         }
>
>         if (mes->adev->enable_uni_mes) {
> --
> 2.49.0
>

