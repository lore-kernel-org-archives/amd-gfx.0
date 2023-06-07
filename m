Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52018C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CA810E1FB;
	Wed,  7 Jun 2023 17:34:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166D410E532
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3/xCGui+eY/hxTTwGBcpzueOX4EQzoiIIOPISN9YwYGnBpMCpHj4a0QTAFHKgFPX248dP7Q3YZfqoRBrj74mUjB4z56vjb7wXP22VW80StqI9P7lfANdEmyfjQSKEPMMbCKsDBBSql7OEL45dRdXTp5HcmklDGP9yk4tTvqWHpyt6KhDRFrtv5FcmGvafGPVt4YbFjBMGNeW6mIpCusaEaJZbgi8izMgvSmEm3Z7sBW6at1nZsK8Y9msDvUd44FwNuGwezeWxHEEnLkY27FpouDqrzlZarOPfHFSyCz8e7m+fkIYtYk7o5X4RzLcX+A0+OdTvTMjFlB6TszbpHgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cGDUA7cVYOCXgUqhjXah8wp/r/lbgH0kGKR7ZhZnBY=;
 b=JkYaIaWTws/xR0PIr38y0AEBHz+c5AShZJ/aIapw8fL5bmcouzD7ZMFF5bwjU3zcaeukj1OnzcN3PsZvI7HPp2veJVM0Z7AtTXE2ODDrr09kjbfF4KvWUZPmLCFU5s2p3leWumx/Au2Xjuv/fSknkRJPQqje8eZoPruZd4mHHra8abmeg+jEikhs53JJDc2JI4vBpPqnAKUHhb9z7uVrBbZGlkdPzUo/beqCpAtqcVnywe1Xr6XYmRMOg7gZO9WtE90iY5TFoSHR/+ATfHqlX2idIcPuptC6ZAJAsvhpl90No76VGoqNVO3LikiVQeH+We8KgD8+EOhkjo6Bo+B1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cGDUA7cVYOCXgUqhjXah8wp/r/lbgH0kGKR7ZhZnBY=;
 b=Ii6W7mXICpaBWz6fTyTXOB/clBCM1vX690FNEZnNM0inAaE1/Xt0Xl3tlRMrd1mf3YUZ2m4DLdLsdjEm6+9f9UCUFBm44w6F9rDrgNYXF2EgYw+YrvCQqGvzStXhVzVTpwGP9MBwpeeSxQn+Z3uxcrzjq+V0133Z5dITWfvuDJY=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:33:54 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:33:54 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix and enable debugging for gfx11
Thread-Topic: [PATCH] drm/amdkfd: fix and enable debugging for gfx11
Thread-Index: AQHZmWVFtd//ncFigEuqvSy1Af3/kq9/mXvw
Date: Wed, 7 Jun 2023 17:33:54 +0000
Message-ID: <CY8PR12MB743519F31C3261D12F8705A48553A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230607172647.1824726-1-jonathan.kim@amd.com>
In-Reply-To: <20230607172647.1824726-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8f5874cd-3bcc-4e05-8971-6bc592bf975e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-07T17:33:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|IA1PR12MB6235:EE_
x-ms-office365-filtering-correlation-id: b8c08ef7-be77-4330-44c5-08db677d5e00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjvCMKsYL4lyDgJp/moGUV0R4k1z26tB+BaieVym9q4K9TITl+Ke0K4XMCSb+fXXQ15QaDINNUIlkUT5dk4zJ95fZwMe+j4CucnA+aPs9EoXAzYpaqZXz2dGu8STs+vVmMTaw5c1+GzdeptIrNuEXkUdGGwmDEC+wM+IOEHZmJMRdO1+kPg0ODfNuv04Q2DqSjDInCdlQ2otBwaemKpnXQ/hKUu3p/lw+3gkRcZbMacVwMas0w7aeGD71DighdZt6yQDW9DFeooGieWqocRZgCepc7z/85FSAndmqkkizBNvU8oECbcJalCAgz/VJ+h/94aD5olTV29IO6P8V5QvU81r8yrtvU13VTybCbDx6cH5EOByA33WEH1sHXsdnCdvTwk0enEQ5Bd0d9WG+xhhbWkLAKXMwGpfc+HTDgzHZ4yxFyeO4J/wz0BNelv09ogBifUq0OVo9Xv0Olpikqe6URuerp5ZW9Cl1f6YFP8JIBsrLQmPYWkikgEklHdrnri5JrU5cNDF4Jd7cYWPjHmOza2WTgNsEWDVJ/eX/y16N8SSshKEdZoD+FDYrb8WJlzJWjhQt5oSG2V+fUY9Y1nPORNiIcZo71yokrE2SiGmaGbJxZl9/IgrQfZYeM+4Vj8soMQXNn8THcWUBXofwkxZfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(55016003)(7696005)(54906003)(478600001)(316002)(6916009)(8676002)(8936002)(41300700001)(66446008)(76116006)(64756008)(38100700002)(66946007)(4326008)(122000001)(66556008)(66476007)(186003)(71200400001)(83380400001)(6506007)(53546011)(9686003)(86362001)(52536014)(5660300002)(38070700005)(2906002)(33656002)(66899021)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LVoulL1V2T3OeEOieFhNKy+9uMnnkzZy9qGJ73HewNXR5bHe9YrExdPfidNs?=
 =?us-ascii?Q?C3vQ+u9g6YCk1eLZC4agdtON8zO6ddq0bOKKjFrTQPctok0gp/jQgX4shpBA?=
 =?us-ascii?Q?RDIKBdsQKPyj5G4wt6fxsjuKkVPeFDn45Uo4lNM2CxvINNk4CkW0h03amy0L?=
 =?us-ascii?Q?TXDUqEV2oOR/9ImP6mXgGG39OEnNsQcmLx2ZrnZVyb43zyaqYTr2xjwhJKqW?=
 =?us-ascii?Q?ZY070O8CPnhSq197zBxWooa/L/8vhwIom9ABI4V7qPctqPdLdYg0NVbY8HMA?=
 =?us-ascii?Q?S71okLrWLJn2scSSbMADHoFuptOWfCR4WgueVpFlIPVYPNrWJAEkQmT4ucC7?=
 =?us-ascii?Q?l2JoNw/A3IYRJdgIaWVFnVo6ltp6JZM336Gu2c5Ol3PDZL7BvwM2l2ZYsm4b?=
 =?us-ascii?Q?RBBG3ZXoPj9bOy0DgiPXGQij2c5fFDksu5QmuMDk6oJz/Qle3JPiR2qhs4Pj?=
 =?us-ascii?Q?PMkwTB8eiI0zK25Pz6GXxhG8SOLJcson5UiK+mK8h5G2xHWfmfe8/w6S6ImK?=
 =?us-ascii?Q?g6+aRKc0nETIjnG1eaOxfQwuVLnO17ofXvrFKI1jGPvvXluQXb+V9LdXLMP4?=
 =?us-ascii?Q?Jxq4FqqAWs/EIdU5BT4x2uaBrl5pTtY2YTuYrAwM4rCCJEhb+ts8AgSJKghT?=
 =?us-ascii?Q?vpIFmQ/iROHt4nSLGYyCs5sc9jMUM8BBvMDnq1F3BHbxt5n6WY8xKzOI1CWj?=
 =?us-ascii?Q?0LeNzJ4eaAC7KDs9iF2f6BTmpmMsovr9AVbqqAblBn6L1GAdPo1e87TVpx58?=
 =?us-ascii?Q?x3K6d+4romq1KlQQHM52oJwLEwUZvoVQqex+SawX6jyx9bn3cMA/AjdpPBcH?=
 =?us-ascii?Q?MqDOQ/fpVVduLbI4U6MhkFN7+MOTiDuGAbmWsSPRucNg8kEwOHwky2CX0IRI?=
 =?us-ascii?Q?itQKcqL6GT0CG27znxGG0Nr74QlcHk4cC539WUZxXBE33+Ll1F4A20SNeacE?=
 =?us-ascii?Q?xW+xuQmjksUX62our71PHFfzJMw4KsScLCQPTcrUyIcMGE8gRggb5KD8bWSU?=
 =?us-ascii?Q?/XsshFIiGzeLWnsUq82E7zjNRBkylWyC/6/jvloe01awLy4JeX4TAfieb/p4?=
 =?us-ascii?Q?QHdBLV2R3Q37EjObjwSCtnExnS0YGgSaw9k2ESxy+/+slIepq6KjNAnrifTD?=
 =?us-ascii?Q?ajRG55zF55GxO+rS9ar2+WESBA3hP8oznt5d+7ncXb2GSd1nKfOfi4edFnlj?=
 =?us-ascii?Q?lgGuAOr7JDmMUnUfBGhjVFSxOiHaTwDJYoAEBt4WgfA9gT+pSvxa23rgWD9Y?=
 =?us-ascii?Q?xMHkRnKFC5Y6K1E2xJmcdvGD+R83qQcbkssVqYiohfZqC+4+N9vtH/3YiOgN?=
 =?us-ascii?Q?xQqGcvSE5iS8pFPIph2VMjutLaqgX2wuZ/b5N8aKm4rhIuvTIw+q10OHbith?=
 =?us-ascii?Q?pWh/XU4H2Fx5xSuxc1hE3PBR8bErgC8U++6T/xC842sAlPD9yIRQGo1+K0Xf?=
 =?us-ascii?Q?7ddKIs3yl2heDpofinIy3xmImv2pusPyys/Wkn2wGF/42BNGmDvPFseRNrPI?=
 =?us-ascii?Q?XjD9wsFEPYruXBII+GMcrEjdEYpjrFUS8SE7GplxWZ7xkieQPfOH8FcEHQuA?=
 =?us-ascii?Q?pvog8BGQM/KfEtLeizPZiQB/Vn3txppdCZuh57M3OJRvKzNKAOjZpZkpVxlK?=
 =?us-ascii?Q?+ojz4GLChBrK9/SxFW440DI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c08ef7-be77-4330-44c5-08db677d5e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 17:33:54.8492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkOFADn0EGNkQGgo91sjtZII0ygUKYilMJ3AHst4mGDeJNLsVg1AGk1gvLE+5BhQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

+ Felix (typo on email)

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Wednesday, June 7, 2023 1:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Felix.Kueling@amd.com; Huang, JinHuiEric <JinHuiEric.Huang@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: fix and enable debugging for gfx11
>
> There are a few fixes required to enable gfx11 debugging.
>
> First, ADD_QUEUE.trap_en is an inappropriate place to toggle
> a per-process register so move it to SET_SHADER_DEBUGGER.trap_en.
> When ADD_QUEUE.skip_process_ctx_clear is set, MES will prioritize
> the SET_SHADER_DEBUGGER.trap_en setting.
>
> Second, to preserve correct save/restore priviledged wave states
> in coordination with the trap enablement setting, resume suspended
> waves early in the disable call.
>
> Finally, displaced single stepping can cause non-fatal illegal
> instructions during process termination on debug disable.  To work
> around this, stall the waves prior to disable and allow clean
> up to happen naturally on process termination.
>
> NOTE: The AMDGPU_MES_VERSION_MASK check is a place holder as
> MES FW updates have been reviewed but is awaiting binary
> creation.  Once the binaries have been created, this check may
> be subject to change.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  4 ++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 31 ++++++++++++++-----
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 12 ++++---
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h |  1 +
>  7 files changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 20cc3fffe921..95d69f9c7361 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -928,7 +928,8 @@ int amdgpu_mes_set_shader_debugger(struct
> amdgpu_device *adev,
>                               uint64_t process_context_addr,
>                               uint32_t spi_gdbg_per_vmid_cntl,
>                               const uint32_t *tcp_watch_cntl,
> -                             uint32_t flags)
> +                             uint32_t flags,
> +                             bool trap_en)
>  {
>       struct mes_misc_op_input op_input =3D {0};
>       int r;
> @@ -945,6 +946,8 @@ int amdgpu_mes_set_shader_debugger(struct
> amdgpu_device *adev,
>       memcpy(op_input.set_shader_debugger.tcp_watch_cntl,
> tcp_watch_cntl,
>
>       sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
>
> +     op_input.set_shader_debugger.trap_en =3D trap_en;
> +
>       amdgpu_mes_lock(&adev->mes);
>
>       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index b5f5eed2b5ef..2d6ac30b7135 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -294,6 +294,7 @@ struct mes_misc_op_input {
>                       } flags;
>                       uint32_t spi_gdbg_per_vmid_cntl;
>                       uint32_t tcp_watch_cntl[4];
> +                     uint32_t trap_en;
>               } set_shader_debugger;
>       };
>  };
> @@ -361,7 +362,8 @@ int amdgpu_mes_set_shader_debugger(struct
> amdgpu_device *adev,
>                               uint64_t process_context_addr,
>                               uint32_t spi_gdbg_per_vmid_cntl,
>                               const uint32_t *tcp_watch_cntl,
> -                             uint32_t flags);
> +                             uint32_t flags,
> +                             bool trap_en);
>
>  int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>                       int queue_type, int idx,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index c4e3cb8d44de..1bdaa00c0b46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -347,6 +347,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes
> *mes,
>               memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
>                               input->set_shader_debugger.tcp_watch_cntl,
>
>       sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
> +             misc_pkt.set_shader_debugger.trap_en =3D input-
> >set_shader_debugger.trap_en;
>               break;
>       default:
>               DRM_ERROR("unsupported misc op (%d) \n", input->op);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 125274445f43..e7bc07068eed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -349,12 +349,30 @@ int kfd_dbg_set_mes_debug_mode(struct
> kfd_process_device *pdd)
>  {
>       uint32_t spi_dbg_cntl =3D pdd->spi_dbg_override | pdd-
> >spi_dbg_launch_mode;
>       uint32_t flags =3D pdd->process->dbg_flags;
> +     bool sq_trap_en =3D !!spi_dbg_cntl;
>
>       if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>               return 0;
>
> +     /*
> +      * For displaced single stepping, the debugger inserts s_trap
> instructions
> +      * from user space.
> +      * This can race with the CWSR workaround during a non-IOCTL
> disable and
> +      * cause non-fatal trailing SQ illegal instructions.
> +      * As a work around, stall waves indefinitely in this case as the
> process
> +      * queues will terminate anyways.  MES will automatically clean up
> the
> +      * SPI debug HW registers when all queues are unmapped.
> +      * IOCTL disable will not hit these cases as the program needs to b=
e
> in a
> +      * non-continued state to make the disable call in the first place =
so
> +      * debugger insertion of s_trap in debug memory will never occur.
> +      */
> +     if (KFD_GC_VERSION(pdd->dev) >=3D IP_VERSION(11, 0, 0) &&
> +         KFD_GC_VERSION(pdd->dev) < IP_VERSION(12, 0, 0) &&
> +         !pdd->process->mm && !sq_trap_en)
> +             spi_dbg_cntl |=3D 0x1; /* Set
> SPI_GDBG_PER_VMID_CNTL.stall_vmid */
> +
>       return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd-
> >proc_ctx_gpu_addr, spi_dbg_cntl,
> -                                             pdd->watch_points, flags);
> +                                             pdd->watch_points, flags,
> sq_trap_en);
>  }
>
>  #define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
> @@ -557,6 +575,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> *target, bool unwind, int unwind
>
>       if (!unwind) {
>               uint32_t flags =3D 0;
> +             int resume_count =3D resume_queues(target, 0, NULL);
> +
> +             if (resume_count)
> +                     pr_debug("Resumed %d queues\n", resume_count);
>
>               cancel_work_sync(&target->debug_event_workarea);
>               kfd_dbg_clear_process_address_watch(target);
> @@ -598,13 +620,6 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> *target, bool unwind, int unwind
>       }
>
>       kfd_dbg_set_workaround(target, false);
> -
> -     if (!unwind) {
> -             int resume_count =3D resume_queues(target, 0, NULL);
> -
> -             if (resume_count)
> -                     pr_debug("Resumed %d queues\n", resume_count);
> -     }
>  }
>
>  static void kfd_dbg_clean_exception_status(struct kfd_process *target)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0c1be91a87c6..ff0a28760494 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -227,8 +227,7 @@ static int add_queue_mes(struct
> device_queue_manager *dqm, struct queue *q,
>       queue_input.tba_addr =3D qpd->tba_addr;
>       queue_input.tma_addr =3D qpd->tma_addr;
>       queue_input.trap_en =3D KFD_GC_VERSION(q->device) <
> IP_VERSION(11, 0, 0) ||
> -                           KFD_GC_VERSION(q->device) >=3D IP_VERSION(12,=
 0,
> 0) ||
> -                           q->properties.is_dbg_wa;
> +                           KFD_GC_VERSION(q->device) >=3D IP_VERSION(12,=
 0,
> 0);
>       queue_input.skip_process_ctx_clear =3D qpd->pqm->process-
> >debug_trap_enabled;
>
>       queue_type =3D convert_to_mes_queue_type(q->properties.type);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index faa7939f35bd..90b86a6ac7bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1863,13 +1863,15 @@ static void
> kfd_topology_set_dbg_firmware_support(struct kfd_topology_device *de
>  {
>       bool firmware_supported =3D true;
>
> -     /*
> -      * FIXME: GFX11 FW currently not sufficient to deal with CWSR WA.
> -      * Updated FW with API changes coming soon.
> -      */
>       if (KFD_GC_VERSION(dev->gpu) >=3D IP_VERSION(11, 0, 0) &&
>                       KFD_GC_VERSION(dev->gpu) < IP_VERSION(12, 0, 0)) {
> -             firmware_supported =3D false;
> +             uint32_t mes_api_rev =3D (dev->gpu->adev->mes.sched_version
> &
> +
>       AMDGPU_MES_API_VERSION_MASK) >>
> +
>       AMDGPU_MES_API_VERSION_SHIFT;
> +             uint32_t mes_rev =3D dev->gpu->adev->mes.sched_version &
> +
>       AMDGPU_MES_VERSION_MASK;
> +
> +             firmware_supported =3D (mes_api_rev >=3D 14) && (mes_rev >=
=3D
> 64);
>               goto out;
>       }
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index f3c15f18ddb5..0997e999416a 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -575,6 +575,7 @@ struct SET_SHADER_DEBUGGER {
>       } flags;
>       uint32_t spi_gdbg_per_vmid_cntl;
>       uint32_t tcp_watch_cntl[4]; /* TCP_WATCHx_CNTL */
> +     uint32_t trap_en;
>  };
>
>  union MESAPI__MISC {
> --
> 2.25.1

