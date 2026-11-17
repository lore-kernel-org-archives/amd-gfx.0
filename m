Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5E606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k2Rs7Ypq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F232510EAE6;
	Tue, 17 Nov 2026 02:23:58 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F9510EAE6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 02:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS9fh6btOnnq3yw9QXhfO8d0DbsOGaDaO2rF2Jg8qOuf4pZJDJ5omqP3/PT4aRXZ+hawG4qQuHYqseRxwMpy1SFF/UbgxV6lW1QpTE+CYGm1mZBRelvF5m/VKJPWKqhiMgaNL8XXtL6iK9QKD5viY+KEf12AIwhJbz1wSAe/20I0medttZAQe0pJOIamrncawT/FgcDSJCtK0qVNDE4ZXoAGwjEJG1gA1ELA3tJVvimzqe8KaOD/+XSU2YlcQ2Dc4/YzUjERSYUSTECntdJM6N1qn6bFxJoeZCIPsRruTA12PS049I6JI7yqX3tK0aEKXXYDFs6MGMPdmjddFZ8idg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohAffHuE3+bX9ClTLGYyUkZB9XP4HJXw6tLhPyXnj78=;
 b=T9fYVUnBxIxeuEN0WsahXuchotHy5BSuV1HygUoxIKV7GZ7ZRGze1eyWhKFrMO9sONsSi8f/Lqxh3otaPq7mytjWIlF9vn1/pT+/WrACm9H4gGqcj2eTvtAf5lHyN3CtxCIMMIupF1ZXswyEFy3kmLqUUJCJ/6Bbox48v7VMqrPFjz7B578RyELu++n7cP4ZdbQtkVQUj0ZIqJU58nQAHP85R61rBet9hO/R1aEt5QaufueqiQ/thGE+v9cxFMYqnRMJBa6qiLu7GD+X+RFY1teRaOBsTpVcaiPkZrM9Xhkwf2zAlQoEKLCr3/PuAc4lo6xH7K+XUD1SBBZm/IUzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohAffHuE3+bX9ClTLGYyUkZB9XP4HJXw6tLhPyXnj78=;
 b=k2Rs7YpqU0M/FYbkynNEU3R3zucwzIY+xnv2d0r9J/vBjthopC3ZtpD2ZyPumfrHQkeBS/13oHnJ/tuosDSoFz69ZMwgENEo7yM26KGZC9InTrgGyqd9UZ//85GO4CWG+WuVGdkJlr34vl2i2QH+mgdCm6E7OGpjWzBqnLQ12zI=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 02:23:50 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 02:23:50 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chen, Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH 2/6] drm/amdkfd: allocate the MES process context slot
 with its buffer
Thread-Topic: [PATCH 2/6] drm/amdkfd: allocate the MES process context slot
 with its buffer
Thread-Index: AQHdcRQZXKwBmdmr/EWLruglvKxlprcw7YyAgACjn1A=
Date: Tue, 17 Nov 2026 02:23:50 +0000
Message-ID: <MW4SPRMB0025897D43A110DEE2F6B0FDFB7B2@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
 <20261110130440.474374-2-Prike.Liang@amd.com>
 <CY3PR12MB96318D3A9D1D45BEA9A1F25CF47C2@CY3PR12MB9631.namprd12.prod.outlook.com>
In-Reply-To: <CY3PR12MB96318D3A9D1D45BEA9A1F25CF47C2@CY3PR12MB9631.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T15:39:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|PH0PR12MB8774:EE_
x-ms-office365-filtering-correlation-id: 59b2b814-f747-491b-035f-08df4451d12f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|38070700021|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|261009223027099003|3023799007;
x-microsoft-antispam-message-info: fac0BPHi3ifdeMY4Vpa53Wr3e11dPrdWcaEs/CXjHliLtt9N77PZVFp48yOykF8c2+AbdKYepRqbl09FCXPW7iVqbW5ss/koyijpmjWyGqqLDwI+7x5Cgvi/SaTukJHk2fv6mmraWzKzUN5W2m0pWa+dsRIPK5Fl2RqnQ5XeK3KT+vWPCFWwpujB0TS2N95z/1AdhBRNK6R5r+FiCODxwuYs5N0QuPktHbsiSpQBl3Y7rhMNAE/fsUyiRgKm85C9j3Stc7SDrAp0uMgSXhRL6fx2O80vF8N1KbSQBrzLOdk1Qfd3vLGFA/wYN27XVRWEH9Hym041Jj7Sc87tqKl7Z037iVW/+OhCw17EWwX56df93eY0+RSDHjyHpoYBKFtyK5CjtHhrqG+fWyJ5iqYWq8LSvA/MN1iL9hY/6NlGfSxJOFLfAKeOh0ogWN34IOPlqAeZkZ3LZy+9pYvZhPm7G7aALfM2NcRYfPuXuIVnGGcMNnGjw8syVAJY8zII2pPyK5JXdzGCBd0gUfj3B/5Ta8Hzsx6PTNuZlMvv1SqQ637wzZJH8UaQ7DdEIl07+X53q3hjhAV0d2VTdA/wV5qNma5pHFFwsV1Fn6r5AK+lzxCdpRlkVSH1Cm8BmFaoGH9bvhViHYRwtI9vlTwaBd7GNU4FXLwgOxOSy0SNVcKMRuVyGgid5dZYE7xULKHJeE6eF0s3lfkLVOS36J+Nl6LlNMUxobc9fllNG5o9SLbHRiI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0KmW6ZJuwnDOfLdfCVc8XpVcOS3Ki4fn6bC1Vgz4ncpcSpbokeNHpCFQmhyT?=
 =?us-ascii?Q?0AtLDPIFYCHUlumq41KHa+/Ff8EGLyUbXgpUTJ5piDxhl1/F481/ofzUO8SQ?=
 =?us-ascii?Q?R20k2r/qZn3CHCHL3vUmbq55MyaR3oSCD7Z38CbFSDQuaKd/pLVuQNKMQp1p?=
 =?us-ascii?Q?jLFKhTjWt7HotjMrEvVl82UXT+tALkYP9WI4wfcUHnset6Wpmn8B9jrSiuzK?=
 =?us-ascii?Q?DHQiuDzkQGj8KiklH65gQOgxSn4WQJXCbelM1DA5IZWavQ14F86dGO+ALok3?=
 =?us-ascii?Q?xFa37N1+NZ7v312t9VwgqGBphsVVz8JDqoLNcqWaYqyBm0oK4HxMJUlB7Wu0?=
 =?us-ascii?Q?4NLTAegSg7K7gIC7VLIvPCafNiWNeqoet8V0vtLbjXDlRoQKjofejvdHrDfy?=
 =?us-ascii?Q?lGfvAfcdPEYjuoHdlibJJ+rCsLbHaCnvlBoRx7YSeU9cnBFkbXNmyhrE8FRi?=
 =?us-ascii?Q?6FTycq4jromsxc3ISdu5uDApAW7TSlLZ0RpCBcaPAqT3P17eO2LM7k0vdVDE?=
 =?us-ascii?Q?iqfA5AF7+xRXRKy+Mat4lg+a2GTZ0MsJDxJnDFn8m8eoW0EhgnDvjvEzIYem?=
 =?us-ascii?Q?Sk9GD0OmMPPyf1Huh8XG1yQCP3y0VwOrHlAuKl7I+3WzCWCc33sK/blJhdby?=
 =?us-ascii?Q?DiYaSKLk9m30I6D/OiAS2FQJTnPq96gkkx74LjkqO/N77Yz9B/vd0nFOlgNv?=
 =?us-ascii?Q?MWf1BkURaQxsr57Ajgr0wwDQWr9jtTjGpoJBbdLUoplvaqDDs/jewJTyLjQb?=
 =?us-ascii?Q?M1kwfTj802N6DY1YRl1ijf5ICC9RkUPayUA/i52a504orAOZOSJbK+HGoF0e?=
 =?us-ascii?Q?vHZo2YTxCLjFGav1iDVOOapEaf1y2bphOvhxIfyRjs2crtzTDL/VGGDfE73o?=
 =?us-ascii?Q?Kzn+iDurK3ZZq94lCVRLrn6CRD7nV04gXzkbdhn08GZXIPWAso+TCW62QV2f?=
 =?us-ascii?Q?xOyktPGNjKj0DKq1RAvVsmEKpKdicNZ4u5r3E9FtlLZXnSw/Az2gjUmwgRfX?=
 =?us-ascii?Q?yMPL8tH03cdXmpbC/qrtbc3LfEQatB+nbCXifuH+qO/P54care/x4bp8/ndU?=
 =?us-ascii?Q?hkIrpPpP9+Ehay9DU3QeNMen8gIAJDCttuLDpu2geVk1IjDQFWRacN7fftB0?=
 =?us-ascii?Q?ByvyRbVBxzpK8RHfigGmYSMB9skyhQ8RuOBJUXBWcFl1sGcdlJ017nIL320B?=
 =?us-ascii?Q?UyzIlInbUV4YQel5R1F7UhNauU0L7AkeF/N66oE31wS43hueSxh1dsojfj7l?=
 =?us-ascii?Q?Vrmb38eN3YwTBtMskftyjPiZvFKddZ2oItJWP/AkEbBB982fNSAQ8xDjxWt7?=
 =?us-ascii?Q?jUaonjunjqIZ4FZXOr56dP9tXAZM+wtWUefzbfneZz82m3fglaWmJEusHkC7?=
 =?us-ascii?Q?IiFn6E6642Kyd9jxl91d+M8LXwcEu+HeP4RGQfdYhHV1c0ZOmFmFFdtSMLFT?=
 =?us-ascii?Q?a+h1MBnnXtWp95eRL8WlCFYJWNzRxCXF6AN4maxbJWy8Otj3CzPUwu4PvvDm?=
 =?us-ascii?Q?w71IbFSacZc325lQ5XEUBs7pBrgr3JhF7Xaf3zhURwWvIuxIKTLprQ1rGmUb?=
 =?us-ascii?Q?xITeDZOe5Utr+a9on3Jfg1c8oJXC5nWZ96eqvmKJv1SRlsG3rcFcD3pb6dG0?=
 =?us-ascii?Q?WZeeNp0nvA2PVvNxdzRWRdMf/im3cdIcLa7kX2YsFN0VTF5eUWJaW4hEnB67?=
 =?us-ascii?Q?fE7aVMmwuMQMEh9qTa8mgcmcKvohFCm/hP588Lv7bW8XErfm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b2b814-f747-491b-035f-08df4451d12f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 02:23:50.1640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0O7UXQ6iSttaj1/I+oWg7h2ggxpt1AaToCoObwNCO3617ZwaLfW5dtxgXtmbe60X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Tuesday, November 17, 2026 12:31 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>
> Subject: RE: [PATCH 2/6] drm/amdkfd: allocate the MES process context slo=
t with
> its buffer
>
> AMD General
>
> You can add me as acked . The code changes looks ok to me , but  I'm not =
sure
> whether the behavior will be changed since according to your description =
original
> driver always use slot 0 , now it has its own  slot for each process . No=
t sure whether
> it's matter .

Previously, kfd_dbg_set_mes_debug_mode() did not allocate an MES context in=
dex slot, defaulting to slot 0. Consequently, when the KFD debugger freed s=
lot 0 on teardown, it inadvertently released a slot that another process wa=
s actively using.
Fix this by ensuring a valid MES context index slot is properly allocated f=
or the shader debugger.

Regards,
      Prike

>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, November 10, 2026 8:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 2/6] drm/amdkfd: allocate the MES process context slot wi=
th its
> buffer
>
> In MES RS64 mode, pqm_create_queue() allocates a process context slot rig=
ht after
> the process context buffer, but only on the path where it allocates the b=
uffer itself:
>  - kfd_dbg_set_mes_debug_mode() allocates the buffer as well, without a
>    slot. A process that a debugger attaches to before it creates its
>    first queue therefore never gets a slot: its queues use slot 0, and
>    it frees slot 0 when it exits, while another process may hold it.
>  - If no slot is available, the buffer is kept without a slot, and the
>    process's later queues use slot 0 the same way.
>
> Allocate the buffer and the slot together in one helper that both paths u=
se, and free
> the buffer again if no slot is available.
>
> Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++--------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 35 +++++++++++++++++++
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 26 ++------------
>  4 files changed, 42 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index cb830f985536..d5c87de519ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -350,27 +350,14 @@ int kfd_dbg_set_mes_debug_mode(struct
> kfd_process_device *pdd, bool sq_trap_en)  {
>         uint32_t spi_dbg_cntl =3D pdd->spi_dbg_override | pdd->spi_dbg_la=
unch_mode;
>         uint32_t flags =3D pdd->process->dbg_flags;
> -       struct amdgpu_device *adev =3D pdd->dev->adev;
>         int r;
>
>         if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>                 return 0;
>
> -       if (!pdd->proc_ctx_cpu_ptr) {
> -               r =3D amdgpu_amdkfd_alloc_kernel_mem(adev,
> -                       AMDGPU_MES_PROC_CTX_SIZE,
> -                       AMDGPU_GEM_DOMAIN_GTT,
> -                       &pdd->proc_ctx_bo,
> -                       &pdd->proc_ctx_gpu_addr,
> -                       &pdd->proc_ctx_cpu_ptr,
> -                       false);
> -               if (r) {
> -                       dev_err(adev->dev,
> -                       "failed to allocate process context bo\n");
> -                       return r;
> -               }
> -               memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE=
);
> -       }
> +       r =3D kfd_process_device_alloc_proc_ctx(pdd);
> +       if (r)
> +               return r;
>
>         return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
>                                         pdd->proc_ctx_gpu_addr, diff --gi=
t
> a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_=
priv.h
> index 158fa70a1a8e..0a4e8639c4b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1140,6 +1140,7 @@ struct kfd_process_device
> *kfd_process_device_data_by_id(struct kfd_process *pro
>
>  int kfd_process_get_user_gpu_id(struct kfd_process *p, uint32_t actual_g=
pu_id);
>
> +int kfd_process_device_alloc_proc_ctx(struct kfd_process_device *pdd);
>  int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>                                struct file *drm_file);  struct kfd_proces=
s_device
> *kfd_bind_process_to_device(struct kfd_node *dev, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 546721b4d59a..102fcb401646 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1204,6 +1204,41 @@ static void kfd_process_profiler_release(struct
> kfd_process *p, struct kfd_proce
>         up_read(&adev->reset_domain->sem);
>  }
>
> +/* Allocate the MES process context and, in RS64 mode, its slot
> +together. */ int kfd_process_device_alloc_proc_ctx(struct
> +kfd_process_device *pdd) {
> +       struct amdgpu_device *adev =3D pdd->dev->adev;
> +       int r;
> +
> +       if (pdd->proc_ctx_cpu_ptr)
> +               return 0;
> +
> +       r =3D amdgpu_amdkfd_alloc_kernel_mem(adev,
> AMDGPU_MES_PROC_CTX_SIZE,
> +                                          AMDGPU_GEM_DOMAIN_GTT,
> +                                          &pdd->proc_ctx_bo,
> +                                          &pdd->proc_ctx_gpu_addr,
> +                                          &pdd->proc_ctx_cpu_ptr, false)=
;
> +       if (r) {
> +               dev_err(adev->dev, "failed to allocate process context bo=
\n");
> +               return r;
> +       }
> +       memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
> +
> +       if (!adev->mes.use_rs64mem)
> +               return 0;
> +
> +       r =3D amdgpu_mes_alloc_proc_ctx_index(&adev->mes,
> +                                           &pdd->proc_ctx_array_index);
> +       if (r) {
> +               dev_err(adev->dev, "failed to allocate process context in=
dex\n");
> +               amdgpu_amdkfd_free_kernel_mem(adev, &pdd->proc_ctx_bo);
> +               pdd->proc_ctx_gpu_addr =3D 0;
> +               pdd->proc_ctx_cpu_ptr =3D NULL;
> +       }
> +
> +       return r;
> +}
> +
>  static void kfd_process_destroy_pdds(struct kfd_process *p)  {
>         int i;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index d3149e6d40e4..4646dfbabe75 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -387,30 +387,10 @@ int pqm_create_queue(struct process_queue_manager
> *pqm,
>                 dev->dqm->ops.register_process(dev->dqm, &pdd->qpd);
>
>         /* Allocate proc_ctx_bo only if MES is enabled and this is the fi=
rst queue */
> -       if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_m=
es) {
> -               retval =3D amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
> -                                                    AMDGPU_MES_PROC_CTX_=
SIZE,
> -                                                    AMDGPU_GEM_DOMAIN_GT=
T,
> -                                                    &pdd->proc_ctx_bo,
> -                                                    &pdd->proc_ctx_gpu_a=
ddr,
> -                                                    &pdd->proc_ctx_cpu_p=
tr,
> -                                                    false);
> -               if (retval) {
> -                       dev_err(dev->adev->dev, "failed to allocate proce=
ss context bo\n");
> +       if (dev->kfd->shared_resources.enable_mes) {
> +               retval =3D kfd_process_device_alloc_proc_ctx(pdd);
> +               if (retval)
>                         goto err_allocate_pqn;
> -               }
> -               memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE=
);
> -               /* Bind one MES process context slot to the whole process
> -                * (per device); every queue of this process reuses it.
> -                */
> -               if (dev->adev->mes.use_rs64mem) {
> -                       retval =3D amdgpu_mes_alloc_proc_ctx_index(&dev->=
adev->mes,
> -                                               &pdd->proc_ctx_array_inde=
x);
> -                       if (retval) {
> -                               dev_err(dev->adev->dev, "failed to alloca=
te process context
> index\n");
> -                               goto err_allocate_pqn;
> -                       }
> -               }
>         }
>
>         pqn =3D kzalloc_obj(*pqn);
> --
> 2.34.1
>

