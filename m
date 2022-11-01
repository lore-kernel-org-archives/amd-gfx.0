Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5053FA3740
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 01:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2054C10E2B6;
	Tue,  1 Nov 2022 01:04:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7E710E2B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 01:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3ziYqQUy2azVNvVGypncTU6a0BHV2JzwsPoa0LNWZyewubxCBzrcwFhEdIX4hb0NKCWZ6d2sDStWTBNMz59/jMbwifHb07gZXUyVb7UN6B3KaxDc2NkPWfFNn85bJJKoZnrkhJkOLJFSUlifQy9EgMJAMz51ggL4deNQri9EMSs/WTSXihQ0e/MPZIYJ6NmWHMsKBZSMo3kBa+Wt5rOyPFps1LJTywlBodxX9Sj/0S6aLme4A9uD/ThZ11hJT3dZSGnDgXkOXX+XBd++ZmbxeXyJgLw/lOmpssSUQwl7k7QH2nI7ivrwexB1MaZyxvMtSzTJ8oobD0d9P7reW4SwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBsUxj7nN04AeNB7rrKLcIlzhLmJ/tD5VFHhE8VGzNQ=;
 b=R/iLCOd0pmLZa0Gu0jt2OD8X9Ko9yDd7r2ieOIzdS8SQt/XWeEITUF4doKgCXgtuePgSqQaUAS7E8JTJ7JFQ4QAvwBuA5ANCXlIOpIYOIDhNxmP9jWoos/6kkCIWLD6B5GSd0DXkow61Uxup/TMRqB3EEl3GqnvqAJrnGd7sI1g/5X0X02rdgn2UE7l72rJdvXDrIpLjhPKbhg8ziY7oH23e3YFZcOtqgDG4iP6OdhqQvywYYu00lauf37amR3F6NjdxWauxscGSGRSZRhRZv6Bb18nrbqNfi2IVmnjRm1t1bWeVMprB6BlOpIg/WFE2jFVh8lMaeIC+JPyglNuijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBsUxj7nN04AeNB7rrKLcIlzhLmJ/tD5VFHhE8VGzNQ=;
 b=YAotCvXOnUIpKvhOJyoSSXAQCnmM9xI2HwWR+yW1EZZp6fMiCCMyaqzfIQwkw3esRS9v//FK4fMkyJPI561rRWIDZCu6ThtkVuAjCgV1DL3/n2SIx/lQTOSJHLZkdmwiVxmoPYcuYLhwjBMzah3hp1rl76VJFDc/Qq9zqyze8Cw=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Tue, 1 Nov 2022 01:04:11 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::9fe:10b1:7abb:dc01%9]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 01:04:11 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Subject: RE: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Topic: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
Thread-Index: AQHY4tFVpYvpMYHRLUurvXDdtV25kK4oe3YAgADSeqA=
Date: Tue, 1 Nov 2022 01:04:10 +0000
Message-ID: <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
In-Reply-To: <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=249c1250-1037-4ce7-95a0-ef6a656e83ea;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-01T00:35:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|PH0PR12MB5436:EE_
x-ms-office365-filtering-correlation-id: bd88d120-6efe-4c33-8955-08dabba4fc6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xn3OuAo77k06BKq2lv3RDURhPmSZgFC8T0k7si4RtkmC1lrjYbLTtO6e7zV4E7teEcs0BhZOd18VEJu2z9lS6R/rXGoNsy8ayvxWHxhA1+fe+WeZTAjM0QmjnFcQZE2qQqKMKsBT70DGAHkfq4f1+GP5wIUKbAak+JphSM62IJJI30W+wcAYk9wEnEh7aDcEDmhUPhw9XTs46eVyPttyXayQpEbh5PZiQeoSV9OKUfFkdvQTpNRaCxPYCzRXM2ssL4Ats6K4K5yZdPfXtbZe/iLS9Nd4j8O6WfrKLQBPelWQ2iKOe2d+JTSXplxq5E5seKIc/NhM4RsxN81W4L663JLoql6Kzi0S/nVgXMV3EjFYNUhWy/hgg8rCWDNKcUrJS9DXtdlpmJ1NlkVk4mHM1IFUS0d0tZ1xxjxRZnCk66GVoyk9VkJu0zL+7cOdF0d/wqbfRpAOx2j4o3DP/xbaHXH8sYYQCywudRmwaxTjKGavUZ+i54iKx9TcXWV+s7CB6b5JAW/a7zQQ5SXs1bRm9d17wF89PMT2fkJriEJdvImNIuDVnMGKBmvqVZT6ydZkCvWfa9LKjO0CR7qNFrP0YaT8hH19GI//OuFHOmZsfhhFEAYrR8jT0G2/g0zEfQsSpP1yegEajHdlzMhX6DeeafM5p+c6WAgT1FhtPhRTa38SnLnn7y5T2csY3nuKcf0GXUOnPKRR3aFuYQaWuEjUSZdHjKJHFIF1uN06ZCana9+IzAjrBqsYY4u24mcVnIjzUrSuqE540YH5WlMSfA8w8SMPYCxfZBGqOESaJ1cRM2g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(478600001)(5660300002)(186003)(966005)(71200400001)(7696005)(316002)(8676002)(83380400001)(33656002)(6506007)(66446008)(4326008)(76116006)(66556008)(66946007)(66476007)(64756008)(55016003)(54906003)(45080400002)(6916009)(53546011)(26005)(8936002)(86362001)(52536014)(38070700005)(2906002)(4001150100001)(9686003)(41300700001)(66574015)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kpftrGYvJKlwKCwNSKN3Mlj9CseC+sf17hR+6MkqdRz23kWBDNPsB32KHX?=
 =?iso-8859-1?Q?0uh2EZ8pgBMefgB04kt2r8/PfFQz2TWYzQt1pwYS1fBzro3wQ5TWbEwTzK?=
 =?iso-8859-1?Q?1b1m8Bay0sspQufFYRp7epbExfEYapwm2ZTiKY5aDVLf62tjZ/sOzDGVSr?=
 =?iso-8859-1?Q?IVpkV48Xk8ZkhGvtlvz8zRgxEI0V1poX8pyzspVfp4sTrLtnRtpZaR5OJa?=
 =?iso-8859-1?Q?d454ugXPZvHRH37wVMKJVrd8YFju/nfl0nkzGPAbiX8Bf18sLRP0YP7cUj?=
 =?iso-8859-1?Q?XYl5Pb2Jq7mI9mY+olnWDzetE4cI9xgFkYMqRVk3qj46eRGag2LRnnX0ut?=
 =?iso-8859-1?Q?J23kzmBF+7OXDn84Dciha5uJhnmppyCAeNHsYLeZsh40hT5jhqizEl8GQv?=
 =?iso-8859-1?Q?LgYSdZ4Dt86qw8A+TS9WJ17zCoIjGd27M4bezIvxq/k81Hu1NVWmY/SHth?=
 =?iso-8859-1?Q?F7XwvqRYnYCdT3YQKEKZOuMzc8Aw+v5X2lGkGtu+XZi8E1gn5eEhMN0Kev?=
 =?iso-8859-1?Q?c2DSOrrMsmOeH9Scpc6NxioxPNLegYtrGSFsWUt41h218M8EOn0FMEwu8n?=
 =?iso-8859-1?Q?1OShYc+Fdjo46oqDhD7hD586RhR+xa7CfPbg+RYncE5FCeQl/bmii1N7L+?=
 =?iso-8859-1?Q?udRnJo2r/wSLHsUG96+00JQLMR/hXFx3+Lgxh55aCZDbwTCNHMiGMqUbcy?=
 =?iso-8859-1?Q?cdo9wpTGgUHntM7PH0Czr25VGEfGsGuVj3+y6DGqTcyZW7FlBB8XbyVQlB?=
 =?iso-8859-1?Q?uNNYfZFjSO8rmzw8k0SpWrt7fsGE9VMyYIsr7EwNHPyDRDoz7+VJ3hwzvs?=
 =?iso-8859-1?Q?eZRAx9NitQDOP1+MWBX45zbvUtamMsWU7/Kv4flvBrYw8rGc5YjEzHNF7u?=
 =?iso-8859-1?Q?mT0RAm0QED6iuqtydEx61vZf1oBepw9i8PIAgfnp23j1sC8OJpR/Hb+r/E?=
 =?iso-8859-1?Q?uHs+0WRknGF9OE0Tmz9/XWRzDoSt6kJ6m9hO5x+QP1fQ/StKCZiDK5v+OO?=
 =?iso-8859-1?Q?2YZxNmIym32x+NYDijyhZ+HRXltvMjSyEu7oZscpbfM58AKkI/kdyj1iMr?=
 =?iso-8859-1?Q?5dDuRjttMAxGqrbMA3V81kzGQrELtuGffCeIUnWNhRFwS44pbfJQnj+Ij3?=
 =?iso-8859-1?Q?gmO0m44+HgmBXWkfKEoTmGCqajQWu+CW/qdM6sdEKcGbbT4oeRUBHv0S69?=
 =?iso-8859-1?Q?O7a3ktc1KP/algMfqCyVoKLMM9biTZrpVadJX3gAu6HQ+L9BPEkOz8VGH4?=
 =?iso-8859-1?Q?frlH2wfNXsw+7GAjSop17UcZpzFtpkIRTV4buPHddaMFWGPgN9yuQooFUK?=
 =?iso-8859-1?Q?IDNE6suKAbpg+oYNuaU2uYtcWgqkZWRDKc4lsqg5HyO3Z3bWzOojjdrtea?=
 =?iso-8859-1?Q?dRWWZs7YxjTyx16ZwkMj0vagl3R7yh/0NSLvgFg4H+4F1IWiHh2dPEQd8P?=
 =?iso-8859-1?Q?h1XUxaHP4lFLtF8Lah0frJYqS4IF2JwKZEsb1cRufPtB8cvExGvQDKi9ec?=
 =?iso-8859-1?Q?wkhtMcyohDDkkg7cbxqKT4RyWj7SGnQHsQo1TJFPi1is0JydUAVpEGRInG?=
 =?iso-8859-1?Q?LfGysk3gaun8ezyfyHrq0OGUg0Q7v852eP2bt+N66PVlFt2GD2rQmpT/s4?=
 =?iso-8859-1?Q?edsL8dgwhjPylLfiED7egP2FrKuuz8Kd4P?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd88d120-6efe-4c33-8955-08dabba4fc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 01:04:11.0126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZ5IsSIGA4/y4LOCRHgMEq0VQinm+UcwjWjpNHTtJilixp1AQosQY05sT4isvBJ5OMQuNp043u7ENwRifS1TLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

It is a macro defined in amdgpu_ring.h, calling function pointer preempt_ib=
 directly:
#define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)

The real ring's hook is assigned  in gfx_v9_0.c:
static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx =3D {
...
.preempt_ib =3D gfx_v9_0_ring_preempt_ib, //please have a check this line e=
xisted.
...
}

Here is the eglinfo on my board, I have once built mesa component (22.3.0-d=
evel), which may update the libEGL_mesa.so
EGL client extensions string:
    EGL_EXT_device_base EGL_EXT_device_enumeration EGL_EXT_device_query
    EGL_EXT_platform_base EGL_KHR_client_get_all_proc_addresses
    EGL_EXT_client_extensions EGL_KHR_debug EGL_EXT_platform_device
    EGL_EXT_platform_x11 EGL_KHR_platform_x11 EGL_EXT_platform_xcb
    EGL_MESA_platform_gbm EGL_KHR_platform_gbm
    EGL_MESA_platform_surfaceless

GBM platform:
EGL API version: 1.5
EGL vendor string: Mesa Project
EGL version string: 1.5
EGL client APIs: OpenGL OpenGL_ES
EGL extensions string:
    EGL_ANDROID_blob_cache EGL_ANDROID_native_fence_sync
    EGL_EXT_buffer_age EGL_EXT_create_context_robustness
    EGL_EXT_image_dma_buf_import EGL_EXT_image_dma_buf_import_modifiers
    EGL_EXT_protected_surface EGL_IMG_context_priority EGL_KHR_cl_event2
    EGL_KHR_config_attribs EGL_KHR_context_flush_control
    EGL_KHR_create_context EGL_KHR_create_context_no_error
    EGL_KHR_fence_sync EGL_KHR_get_all_proc_addresses
    EGL_KHR_gl_colorspace EGL_KHR_gl_renderbuffer_image
    EGL_KHR_gl_texture_2D_image EGL_KHR_gl_texture_3D_image
    EGL_KHR_gl_texture_cubemap_image EGL_KHR_image EGL_KHR_image_base
    EGL_KHR_image_pixmap EGL_KHR_no_config_context EGL_KHR_reusable_sync
    EGL_KHR_surfaceless_context EGL_EXT_pixel_format_float
    EGL_KHR_wait_sync EGL_MESA_configless_context EGL_MESA_drm_image
    EGL_MESA_image_dma_buf_export EGL_MESA_query_driver

Thanks,
Jiadong

-----Original Message-----
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Monday, October 31, 2022 8:02 PM
To: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Huang, Ray <Ray.Huang@am=
d.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)

On 2022-10-18 11:08, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> Trigger Mid-Command Buffer Preemption according to the priority of the
> software rings and the hw fence signalling condition.
>
> The muxer saves the locations of the indirect buffer frames from the
> software ring together with the fence sequence number in its fifo
> queue, and pops out those records when the fences are signalled. The
> locations are used to resubmit packages in preemption scenarios by coping=
 the chunks from the software ring.
>
> v2: Update comment style.
> v3: Fix conflict caused by previous modifications.
> v4: Remove unnecessary prints.
> v5: Fix corner cases for resubmission cases.
> v6: Refactor functions for resubmission, calling fence_process in irq han=
dler.
> v7: Solve conflict for removing amdgpu_sw_ring.c.
> v8: Add time threshold to judge if preemption request is needed.
>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Michel D=E4nzer <michel@daenzer.net>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>

[...]

> +/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need
> +to resubmit. */ int amdgpu_mcbp_trigger_preempt(struct
> +amdgpu_ring_mux *mux) {
> +     int r;
> +
> +     spin_lock(&mux->lock);
> +     mux->pending_trailing_fence_signaled =3D true;
> +     r =3D amdgpu_ring_preempt_ib(mux->real_ring);
> +     spin_unlock(&mux->lock);
> +     return r;
> +}

AFAICT amdgpu_mcbp_trigger_preempt is used only in this file, so it should =
be declared static.

(I didn't audit the other new functions added by this series for this, just=
 happened to notice this one)


--
Earthling Michel D=E4nzer            |                  https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
5%7C01%7Cjiadong.zhu%40amd.com%7Cfaca0a3e35964bcbb24708dabb37b284%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C638028145150743814%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00%7C%7C%7C&amp;sdata=3DBcnmJQ5jUdI%2BGnKvUpn3agyxTD4iTSweGxEQKUlQpxI%3D&am=
p;reserved=3D0
Libre software enthusiast          |         Mesa and Xwayland developer

