Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D1CC32771
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 02:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AC310E02D;
	Tue, 27 Sep 2022 02:14:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F1410E02D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 02:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlcNX7ZmFjcJpOThCr6ZiEMI6wfdz7v1mpLd74lVOTCY9IXlZrbjht9KblTHAbGgTe8rRz2A92sdXfoqyzLtFGKvilpwHg9UiLgu+QdLmlgKahAagTr3eu08ySCt/31hL2+kKbKKa0qiM2KvOn2ZlAgc5arz0Dw8je/ezWtyI29lIN23wXlgjYPwrLcpsMXa2FHhNgSIznTIJmDcoEp/lcd10zfP1hmD4IwyrNeelEawoU+CHOUUy9yLAJ09XHI/yVsFRHdfAc+H371xllTfXEGd63jrTqcJ0FaVu+Jj0E+wbylTFY9KIHnQ8WL7P+Dj59rHIOQJ8KHbiAcGES+DiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq/F8RYL2RPg7nCPs4tmBg5GkihNmDGZXxZoBMI++Jo=;
 b=IS4wSieBAivdl4wRdfsTvC9bMrivmRAhQrkTrf7BBeSqnXr5SiUUfsm4xw1Z0TUZgsD26KsGvB4Liu7tarsP5NQLznPu/vpq9dOgTq5E7qwOYgZED7FY0zKW+u1L9OQdmG/zoREVYP2XNhQNNTTXWeUlqc3nOMBFF1I0/neFseCFxqQISxaQmMJFjsIZqp30zdEmvRXqGCFnolO/05gpFq0tSQ0kXeMoqtcZVlbOsv7UQ7Xg2gPPklx5LSvF49nBUAwHLc5A9Xl0/N1wlEZIywwH8XSYuOqO83Kjsa8JXgHMV2TfnRj+ecJ4x0TTI7LBKUP8tTl5CRWGwCsr8VahPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq/F8RYL2RPg7nCPs4tmBg5GkihNmDGZXxZoBMI++Jo=;
 b=bq7HHpSMw1Y4aotpnTXWs+aDq2BgcV8on7DfqQTqG4vHpLF7nqe0cjIWFUTWen0DLSYQctvyFnI3k2hp+GGE+V0s+H7ESReXa4IBBtXV9W0DlFkBavaGFIL0Nvuv2hZ6BBPssIqxHiSxqoh+DP599Cv+apO8O9wk3JXuO0A3Frk=
Received: from BN7PR12MB2612.namprd12.prod.outlook.com (2603:10b6:408:29::14)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 02:14:15 +0000
Received: from BN7PR12MB2612.namprd12.prod.outlook.com
 ([fe80::46ae:361e:23ee:ee3c]) by BN7PR12MB2612.namprd12.prod.outlook.com
 ([fe80::46ae:361e:23ee:ee3c%7]) with mapi id 15.20.5654.020; Tue, 27 Sep 2022
 02:14:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Thread-Topic: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Thread-Index: AQHY0fCtOfiUP9SMsEGlKnCwxdq3Xa3yh+Zw
Date: Tue, 27 Sep 2022 02:14:15 +0000
Message-ID: <BN7PR12MB261218AAD06042B10065EA56E4559@BN7PR12MB2612.namprd12.prod.outlook.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
In-Reply-To: <20220926214014.5450-3-shashank.sharma@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-27T02:14:11Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=691a8def-ce20-42d9-8743-e6c9f5868798;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2612:EE_|MW4PR12MB7120:EE_
x-ms-office365-filtering-correlation-id: 321f0870-6915-44a8-000e-08daa02dfa03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8j//WXAZR3Nl07AcxyHmSjlo5nfq3N9fnW/XJqj5GwGnLSjC6VXFG3ke8Eh31+Ljl0M93wxla2+MMw/zfM1t+eATDts65lGBdx43nQF1+XoRnJQ4bgCfKvGMy2/Q9ByWwEc3Hv2U2YecJip0l+1j9pz8FLg13TQoKJtkpXaHkVJPdu64WLhOxwBdjmodCdScAJ+Ntf3XyXJh/3u/wpzo883XTogDJ4ajbDo35fOe3dlIX8Jz7gtOGzR8tr6i6gQQXRFfBtqr5y/5t6VnlfTPcwdEAnsh3V8sZqjwO6SEoS55AYC9xpUh8NKIBNbBB6veasdPwljrPaQttZkHQ141SLS5x9A+Nqe4Wvjcqtfu7CRiGXYq09w4r8oHXRZI7VlvMVEWC5JDhCWdyJ2C3vAVewy2tXwQ/+4iufIzEOaFoPdlVu0q16DYSPCkUgQ8UXn7uSZ5Fzpni6PExibWeZ63MWcxCid17IbBTMhE6MAufskwxgAP7qE9M41wJEXpo2g+Oezq4LGZJydxkci+sN0SsLRT8DdBa0GV4du4sZlDvVoTGIt+kIFjrtUDDCBt7lQRTPxGBKRxEUedLKtb+ko/CTJahWrZ5uYCzPDBM/MtNmlGsmQlCwFCgP4abbpeIaLILIVQiZCAllROwAIG/Qd5s18NM9A32hlG/XroLCjcH9D5uchPJv/YZIXoCkiaFCuB2FuNjzu0yXax2BWN7hrWjXQMEZhovj6/bieueGtxAgYxGJCqz0/Ycj0J91W0xghtziIktpzA5nEUUTUSN1gM1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(186003)(71200400001)(122000001)(66899012)(38100700002)(316002)(110136005)(86362001)(54906003)(55016003)(5660300002)(8936002)(38070700005)(53546011)(64756008)(52536014)(478600001)(66556008)(4326008)(66446008)(66476007)(76116006)(8676002)(66946007)(7696005)(9686003)(2906002)(33656002)(41300700001)(6506007)(30864003)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dj7i/joHdllIUkI6GTVMsw2RYsPZYPQSsswOA1r4SGbhRgOppiFUioSy6hAh?=
 =?us-ascii?Q?u+SwuG/6T82C/V91d4zZUMl09q1Jd5voKDmjkaqXUx74oHD/Gz64c9Mjgdzi?=
 =?us-ascii?Q?bDGquAH0sUz53YhtvJKhRkWfiSVNDC1snnflJmKrEAocZwK3YbRLXHhmf5k0?=
 =?us-ascii?Q?QwKkW+0UNBCLxGUDu+8fqraZnw/QKSf9QwIERfh4O6JYj2yWQ/LPc+MNOnsN?=
 =?us-ascii?Q?coxhymJV6n2M02iEgx5TmWUyhO+MNBjarzJEawwryJMmRdQwFwMt7gaJzvg+?=
 =?us-ascii?Q?5saAZlnpYKZxVwZ6KrAAnOm73CEqc0UhCopDX0Fu0avWUJYa92aPQ/OOaF8g?=
 =?us-ascii?Q?wHcmuG4oZoIUy6upgcGl4UmEnba4jLou/Qs8GCVIIKJtF+72I8ipEe9AXcGu?=
 =?us-ascii?Q?xe/zsym6m3LPuouqNRyU/Mvr1QHEnI+HN9aJkQXUJBTxLXE4MLEog1ypRrGr?=
 =?us-ascii?Q?duHTGPkadbswTbiZEclRuuWmFm9KXG6EfDMLE3abeQ1xhkzu7iqrNR+oHnFK?=
 =?us-ascii?Q?tzL5484tX7fDX4ZOTMzSRSv1Ewv76tpl0wJ1JbBTa57qSrZHIuc3Db+a79mg?=
 =?us-ascii?Q?x0WKuq399JIK2AwJC83Gn2MWhCcYtsh9unDxDuEWKbW2vbdwoMLfFqf+kUkY?=
 =?us-ascii?Q?wRbjOHLq+qEBYfhqzEbYlkHTAWRktnQwVnyD+2JqcCcvXUvYSp+WMKfZiSIY?=
 =?us-ascii?Q?cfhu1OErCSoY+G7KwILBfgPX0kdks95c38X9E4Idq0vEk7ag192ohZTRajti?=
 =?us-ascii?Q?bZ3qaUh3FbAo8p+B+7dBuE9Aks/NHBmGSsE/gl6AiaacHPTwvaXPNsEjpsDV?=
 =?us-ascii?Q?KUwmVDAsdu+65rONdlypru9e6Tvu1OzKfSf6sYGE33Yq1dyGRuEpd68NgCay?=
 =?us-ascii?Q?GP/9dwx5czV/wU6vavVokfiQKhFrSPb/I+p+JrD9ycw71Os69YAJTFa7UAit?=
 =?us-ascii?Q?/Fb0kExbkUotM4rYj3IKrReq05nvqzVT4qIT/Rtvb94jgUI9658TMfhc1xF1?=
 =?us-ascii?Q?YLRypbZyadad4br1ziTYLdcdPY8lAAPo0nNt38mMvKAXT0sE6mQIb8UuhFD6?=
 =?us-ascii?Q?BZ/q/eWrEW0ffE0moWNhEIBj94FRLBFGzX6JlG0x/82KlO7N8VzXVmu7OPCx?=
 =?us-ascii?Q?R7ErbwJIii/pHD4o0poHo/Jvwf4NgcK81fCteUqK3KKp4Sl/vtKIoKmcZCH/?=
 =?us-ascii?Q?z5fjVzhwLPZo9+8skcVBiO3rlcxoG8Sh291xiF0NC2iTSwGFCs6WEQu+l3kh?=
 =?us-ascii?Q?SCA27UEHLdV73e1KTS/E3MY9aA4qi+Ere9GWj6+iVb4Kk0lCh4Ei2h3LOInf?=
 =?us-ascii?Q?yYuEviwJGICBsf7Yr5xnwjFI8p3aDqJzNvcSjU8fIlrGFj0X5NuVAN9SDj5w?=
 =?us-ascii?Q?jAnDTHmX9fSaXFe/3Wv4QyTupuRHuz4WmbQ4aMdFjuIkA7+74EkcghBcIb7K?=
 =?us-ascii?Q?yon75qiaZTvDh5nNvt9PAsO2tCFQ6EwDqnAEe7JXn2HzQw6RFI5W/vmOUgov?=
 =?us-ascii?Q?3N0QXTuGR/7GFkZ0USLEYOHiUhI+muO1K6cGJXR0myXJ/ODf4kz/WnTOX11s?=
 =?us-ascii?Q?JTswUJaPZ0O1C9iYqeg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321f0870-6915-44a8-000e-08daa02dfa03
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 02:14:15.4507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veL/UGgG6n9iQXVPrv+lE1tlKzYCvwx6NOtTCu7mgJKgBGNIF1UOcsN9Qwaw0yfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Shashank Sharma
> Sent: Tuesday, September 27, 2022 5:40 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram,
> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Sharma, Shashank
> <Shashank.Sharma@amd.com>
> Subject: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
> profile
>=20
> This patch adds new functions which will allow a user to
> change the GPU power profile based a GPU workload hint
> flag.
>=20
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97
> +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>  .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>  5 files changed, 158 insertions(+), 1 deletion(-)
>  create mode 100644
> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>  create mode 100644
> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 5a283d12f8e1..34679c657ecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -50,7 +50,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
>  	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>  	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>  	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o
> amdgpu_pll.o \
> -	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
> +	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o
> amdgpu_ctx_workload.o amdgpu_sync.o \
>  	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o
> amdgpu_virt.o \
>  	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>  	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> new file mode 100644
> index 000000000000..a11cf29bc388
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> @@ -0,0 +1,97 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <drm/drm.h>
> +#include "kgd_pp_interface.h"
> +#include "amdgpu_ctx_workload.h"
> +
> +static enum PP_SMC_POWER_PROFILE
> +amdgpu_workload_to_power_profile(uint32_t hint)
> +{
> +	switch (hint) {
> +	case AMDGPU_CTX_WORKLOAD_HINT_NONE:
> +	default:
> +		return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +
> +	case AMDGPU_CTX_WORKLOAD_HINT_3D:
> +		return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
> +		return PP_SMC_POWER_PROFILE_VIDEO;
> +	case AMDGPU_CTX_WORKLOAD_HINT_VR:
> +		return PP_SMC_POWER_PROFILE_VR;
> +	case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
> +		return PP_SMC_POWER_PROFILE_COMPUTE;
> +	}
> +}
> +
> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
> +				uint32_t hint)
> +{
> +	int ret =3D 0;
> +	enum PP_SMC_POWER_PROFILE profile =3D
> +			amdgpu_workload_to_power_profile(hint);
> +
> +	if (adev->pm.workload_mode =3D=3D hint)
> +		return 0;
> +
> +	mutex_lock(&adev->pm.smu_workload_lock);
> +
> +	if (adev->pm.workload_mode =3D=3D hint)
> +		goto unlock;
[Quan, Evan] This seems redundant with code above. I saw you dropped this i=
n Patch4.
But I kind of feel this should be the one which needs to be kept.
> +
> +	ret =3D amdgpu_dpm_switch_power_profile(adev, profile, 1);
> +	if (!ret)
> +		adev->pm.workload_mode =3D hint;
> +	atomic_inc(&adev->pm.workload_switch_ref);
> +
> +unlock:
> +	mutex_unlock(&adev->pm.smu_workload_lock);
> +	return ret;
> +}
> +
> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
> +				  uint32_t hint)
> +{
> +	int ret =3D 0;
> +	enum PP_SMC_POWER_PROFILE profile =3D
> +			amdgpu_workload_to_power_profile(hint);
> +
> +	if (hint =3D=3D AMDGPU_CTX_WORKLOAD_HINT_NONE)
> +		return 0;
> +
> +	/* Do not reset GPU power profile if another reset is coming */
> +	if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
> +		return 0;
> +
> +	mutex_lock(&adev->pm.smu_workload_lock);
> +
> +	if (adev->pm.workload_mode !=3D hint)
> +		goto unlock;
> +
> +	ret =3D amdgpu_dpm_switch_power_profile(adev, profile, 0);
> +	if (!ret)
> +		adev->pm.workload_mode =3D
> AMDGPU_CTX_WORKLOAD_HINT_NONE;
> +
> +unlock:
> +	mutex_unlock(&adev->pm.smu_workload_lock);
> +	return ret;
> +}
[Quan, Evan] Instead of setting to AMDGPU_CTX_WORKLOAD_HINT_NONE, better to=
 reset it back to original workload profile mode.
That can make it compatible with existing sysfs interface which has similar=
 functionality for setting workload profile mode.
/**
 * DOC: pp_power_profile_mode
 *
 * The amdgpu driver provides a sysfs API for adjusting the heuristics
 * related to switching between power levels in a power state.  The file
 * pp_power_profile_mode is used for this.
 *
 * Reading this file outputs a list of all of the predefined power profiles
 * and the relevant heuristics settings for that profile.
 *
 * To select a profile or create a custom profile, first select manual usin=
g
 * power_dpm_force_performance_level.  Writing the number of a predefined
 * profile to pp_power_profile_mode will enable those heuristics.  To
 * create a custom set of heuristics, write a string of numbers to the file
 * starting with the number of the custom profile along with a setting
 * for each heuristic parameter.  Due to differences across asic families
 * the heuristic parameters vary from family to family.
 *
 */

BR
Evan
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index be7aff2d4a57..1f0f64662c04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device
> *adev,
>  	mutex_init(&adev->psp.mutex);
>  	mutex_init(&adev->notifier_lock);
>  	mutex_init(&adev->pm.stable_pstate_ctx_lock);
> +	mutex_init(&adev->pm.smu_workload_lock);
>  	mutex_init(&adev->benchmark_mutex);
>=20
>  	amdgpu_device_init_apu_flags(adev);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
> new file mode 100644
> index 000000000000..6060fc53c3b0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef _AMDGPU_CTX_WL_H_
> +#define _AMDGPU_CTX_WL_H_
> +#include <drm/amdgpu_drm.h>
> +#include "amdgpu.h"
> +
> +/* Workload mode names */
> +static const char * const amdgpu_workload_mode_name[] =3D {
> +	"None",
> +	"3D",
> +	"Video",
> +	"VR",
> +	"Compute",
> +	"Unknown",
> +};
> +
> +static inline const
> +char *amdgpu_workload_profile_name(uint32_t profile)
> +{
> +	if (profile >=3D AMDGPU_CTX_WORKLOAD_HINT_NONE &&
> +		profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
> +		return
> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile
> )];
> +
> +	return
> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
> +}
> +
> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
> +				uint32_t hint);
> +
> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
> +				uint32_t hint);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 65624d091ed2..565131f789d0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>  	struct mutex            stable_pstate_ctx_lock;
>  	struct amdgpu_ctx       *stable_pstate_ctx;
>=20
> +	/* SMU workload mode */
> +	struct mutex smu_workload_lock;
> +	uint32_t workload_mode;
> +	atomic_t workload_switch_ref;
> +
>  	struct config_table_setting config_table;
>  	/* runtime mode */
>  	enum amdgpu_runpm_mode rpm_mode;
> --
> 2.34.1
