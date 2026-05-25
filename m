Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A3ACD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 09:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9128310E0E4;
	Mon, 25 May 2026 09:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mlC9dTgn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0980910E0E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 09:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN+ES9dogFLocNHzS6mO4j/DoxnigmamNTqgdszUh12Z0QABgvUotdnWhnY49+/VbgRI4lZmCetZFOJKa6bmDnU6VYCtF86x/2EA1Tc1fhu5mpmJxkn//Sox8ONtzmus4zoqpaLoD4A3rh8pWaASc1IW2HmL9nVl1a9+Le7O80QeDLEnaurs7L4aLmMe1mZ5l8D3gKs4jgwlvdLQ8PCRdovJMdmXba6y3tfyCTqthdUy3SXSc959WTIbHOQD0K96FGgK0Gkar5pgdRLbaj7s4Bu0nNyYK2tiIBshd9rADqiCQVy1/2nAwD7DXkhyiOvbKlpQoqg1D3qlF4gwPM14cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJa870cflk2I/JtHh+4h7tjF0J6sI0/09VSkn+Le2Ds=;
 b=Z9PQqlrOS1wiz0Uq+a3u4suUW2D/NvX0xGSC2k1ChOF3nu2qiynNjJBBz4BJ9spAvDOXS1X1DuvZIZFMlB/XY0faIVcRlnYxlHVgzTKbMbm5Nw0AhnFEuKuaNE5ZvD9A5oVFiMxv5Ep+2QY74iUb3XyDityZ063bNpACmxBXmfsTvtRJE5ZXUDooSRjtmwlPGaMEgPMROkrqy28GNkE9X63NImcQb6P9Fw/hPQhTxUqQbKF2fF+yGj5BUGx+tDjGMKoRrH1V+Qx4nX+AlTBJhzf/HY5u9ZnLzY5g9r8YQwT5+PZi/0uJr7d+MKw2H+nrjPKtY7q4ZcPkwUE72tD5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJa870cflk2I/JtHh+4h7tjF0J6sI0/09VSkn+Le2Ds=;
 b=mlC9dTgneup6jB6J9r904sro00QxY7ggoOc3UqmhX7jeFSEgU/sGNuxReITMGrGpN+dNUITo4orHRQF+9zSvL07xTjgbNopt86BAfdleQBcusao7cKbh9cWIIm98CQT6s55HZ6ImQuosVXzYAo//CUv9w5Z162Rcn1n7J/1PH/U=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 09:22:24 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 09:22:24 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 21/42] drm/amdgpu/userq: add mes userq reset callback
Thread-Topic: [PATCH 21/42] drm/amdgpu/userq: add mes userq reset callback
Thread-Index: AQHc6YEJf3jxGD2BwUKiByV92BDIorYee/4w
Date: Mon, 25 May 2026 09:22:24 +0000
Message-ID: <DM4PR12MB515279360273798EE8A982ADE30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-22-alexander.deucher@amd.com>
In-Reply-To: <20260522002048.98506-22-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T09:18:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PR12MB8423:EE_
x-ms-office365-filtering-correlation-id: c6bcbb71-27a8-4b98-25ea-08deba3f218e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|38070700021|4143699003|11063799006|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: mNkJOtSuRWRxx0DyLBks+hh02b9KQ5dzLXrAwKXsuuAmuhZ/8ND8kGoqWFeBo+E3fU/WC6RGaemM+cfz5DL5eDbHcQcXNrH7OjmhuwovAO/myvMp8H+yE5zMAroluDsrzsBPj5LRpeDyOnzTfRJgQtFCehBSKoJaE7IpxIlbIba33DGcWsE8CmWlQP5YdxJguXW+tlAwrwwwv+FyNfPNC9C9kptggr3PpbCX7cBo2RMDS0dhlbFHPYc2aQpGeH8iO3PGAChwfgFhxBHzP+5pCL+dwMYCd4D653tzqDjt8jvdFrzxe95oOhCSTX9T4RryNFNYckSRR2qihHueoaClk9JWyEm3UhsC+Whi4jHFhJ7kIE7McLSD+Eq08I7OauXk6ckl31ZvSgidHgpdIVp3/3dmq344j3xAbhw0jzn6e3xOGKNC7NLRKWe9BSlgeImsowuhsJDYzjF+toZxgw3d7FrU6ETv2fD9vk1YuR2WURQz2zYSOF7w5bA5tncVDLQ+sjzi+2iQhAsX2XGYEcjzEVNCvZyjJxpRc+L1C6pFJXva08yETJCeLthkWB6agbhkb9GeciAQkDMSvMnYMzANCUtkYV9GpNf75vO7rJSXMkmaeUf4uPeuP8MOGzk5eQbk3293xql52W1pYaSb/YaTSYpLn85ax6EF5h9uaL58mbdD6kgwBFtxSBtqjFNUnqWLhleyeRCUrIp5zk83XApYA5b5I2ky1Um/ExujjIbgbP62KE9T3Q0StLpSn+fLZjwfdnRGJBD7ytMZJISJsQ6voQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(38070700021)(4143699003)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2b2ngSSRnI91tLeDMUQWiErfoqknFESBZfvk6IaPtcjB+1X3x59xoQFV9GUF?=
 =?us-ascii?Q?EJxJUuGOUah7cmEwZcBh6PcqNMzuKCAjse89zE7PD3I1gEFUO5849ipj8r35?=
 =?us-ascii?Q?SRYu8/HRsWZQMJh6jOCWZV4gEpkISZctrTEUzMADjj5UNzBQoIlPavE+lnPN?=
 =?us-ascii?Q?zqDmGrmVXQowC0gnY3I+/M10VnfYlHBJdUkBlwbyX+zvUfc77mzPnKFpQzxl?=
 =?us-ascii?Q?VYM+cLPfE7tb7JwnG979uUDDC6FQYQurqIznFpuoeBUMe4vUSRubPBEm8Btk?=
 =?us-ascii?Q?Fo/OOq+9wEjQ026QpzGSwo5ctJ3wNvyHpHBJzx2dXr1TVVOQ65tMzUrTY+m6?=
 =?us-ascii?Q?27icWS2Nn1rTSONDo+kAG497vEynCoZVajqOChXsUsM6T5+4yfPqD546/MSU?=
 =?us-ascii?Q?cqQVT8SLymHyL/41PKwTNLIGYwuPUTDdq9SnMcBbtbnF4VwpAtXb3kLLo7Di?=
 =?us-ascii?Q?l2Pv8ckUxvt3wDlVMO1JyXdKlpO9/J6Zws2Fsd0z5uTwR3okVSfU071wd4dp?=
 =?us-ascii?Q?qoLNoJcX0UNN8Wc2Bu/lMRBl6mtOXYDe9sNcbGHur2017svhuhWLooh4sdHe?=
 =?us-ascii?Q?GOXMspO31AvcqM/62iSA8JB6jA7rksZC7Co4VrX1qJDFk+/+0XbJCBUXJVcU?=
 =?us-ascii?Q?LqR0E5e72KJNioNME7tQDVMW3PzisGsqsyyeHOu85wwMliMuUNC0n6G8znbS?=
 =?us-ascii?Q?rQH6lobrBil7MeGHwuXtlPMLei2SRl19wMq0XZvrZ5oJKmp1EuC5hoDiFZ0c?=
 =?us-ascii?Q?J6BSRMOx3WNGtJ/zSH2ERX0Zs6FPN4xbceZNnmIwsCeFTrm1tK6IaM8jCpWk?=
 =?us-ascii?Q?+j95BycL5U9CKSHjDwFJ/GhCH8wlMV6yZyP0UOSO7xBseekdCHWC89rUdF6i?=
 =?us-ascii?Q?GC687Qg+VENwtOmKWNA7INNUnnw6E+4vOib1hKqdJJrQYKQUmgmYuckSdM4w?=
 =?us-ascii?Q?/aSpMKQ7FnS7eEAdtZw02q4Az5gQ3KiPAnBGDFA7ZAR5n98aOWzr8udc1ANl?=
 =?us-ascii?Q?Rm9lFiZQYKUGqhvDqnA2iwm0M1ho6BJM2oi2NEz8seO0uDZ2CWfFe35Cp/4V?=
 =?us-ascii?Q?zWx4n8SInAs4NTBbIANg6D6Du6jocnisA+waYgf9C9hsKp3ePoJgNisGaL2V?=
 =?us-ascii?Q?vxCPS1Ys9VjUuWSrNy0LM44y3bl7enGwABqXgDyH1BGlmsQvQX8xHNQMRzbE?=
 =?us-ascii?Q?/s9dfBxgdm7He59OAEQ4vSmsEi+BM5fGUX+w11AmLybDWhGDHOZ3NqFzm7IR?=
 =?us-ascii?Q?TDuUV5jhqzeE3k3o1ZyHcDm8BRznFnLdDhe5sjOX/83MXvdX3rkIO1456PVL?=
 =?us-ascii?Q?djvkFKpSb0R4YWlo4ipXm3JMZ89WNOFquaF0bSiWHJuR7sEAdc0auTgPZUgZ?=
 =?us-ascii?Q?aylYG47ih/zuSyJl2oEZEkyI8+AiPGdvRkdhLEKuu63GA3A7mO+JsQhuItqA?=
 =?us-ascii?Q?a09t3i4WMUIzUm01h90BCNH1dbEeP7M6DUi2SPFWqBsdIN/A1tKBRN4XD2Zi?=
 =?us-ascii?Q?vY4PwQhYxCCt4o9toEdNtH6/Drq7QV2gKr/wMxDsQ1bqcpPQpomPEm7RWgIp?=
 =?us-ascii?Q?qdzneb28hJ7cwuGcrrS4aokXfOauNxSHb6VzV8Z2rim+QAdewvhYH2of1cDu?=
 =?us-ascii?Q?oqruWBXysi4qezmMGj/KSPsycaLc4ntiJTR/ITn7x+wrRuqf9+fmMyDJfmZd?=
 =?us-ascii?Q?yjkVsvGF0/63GPnHD91x7rV9vXdG++lWtoD4t4gJZ3COWAPE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bcbb71-27a8-4b98-25ea-08deba3f218e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 09:22:24.1113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qf8UG0HIddXhprwba0r80kG8YCzYQG0cReWFhGZvf4JW5Rag6csWJVnNNmTB7PlkkWpx1G11U3yiDaB9EDAMgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, May 22, 2026 8:20 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Am=
ber
> <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 21/42] drm/amdgpu/userq: add mes userq reset callback
>
> Enable per queue reset for MES managed queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 14db2124ff81c..4f285a8218ddb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -177,6 +177,26 @@ static int mes_userq_unmap(struct
> amdgpu_usermode_queue *queue)
>       return r;
>  }
>
> +static int 4(struct amdgpu_usermode_queue *queue) {
> +     struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     struct mes_reset_queue_input queue_input;
> +     int r;
> +
> +     /* XXX: add a FW version check for SDMA per queue reset */
> +     memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
> +     queue_input.doorbell_offset =3D queue->doorbell_index;
> +     queue_input.queue_type =3D queue->queue_type;
[Zhang, Jesse(Jie)] should we use mmio for userq ?
queue_input.use_mmio =3D adev->gfx.mec.use_mmio_for_reset;

> +
> +     amdgpu_mes_lock(&adev->mes);
> +     r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> +     amdgpu_mes_unlock(&adev->mes);
> +     if (r)
> +             return r;
> +     return mes_userq_unmap(queue);
> +}
> +
>  static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>                                     struct amdgpu_usermode_queue *queue,
>                                     struct drm_amdgpu_userq_in *mqd_user)=
 @@ -
> 528,4 +548,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>       .detect_and_reset =3D mes_userq_detect_and_reset,
>       .preempt =3D mes_userq_preempt,
>       .restore =3D mes_userq_restore,
> +     .reset =3D mes_userq_reset,
>  };
> --
> 2.54.0

