Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC59FA373D
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 09:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B6410E302;
	Tue,  1 Nov 2022 09:11:38 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F94A10E33F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 09:11:35 +0000 (UTC)
Received: from thor ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202211011011026141; Tue, 01 Nov 2022 10:11:02 +0100
Received: from [127.0.0.1] by thor with esmtp (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1opnIR-000o44-2P;
 Tue, 01 Nov 2022 10:10:59 +0100
Message-ID: <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
Date: Tue, 1 Nov 2022 10:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: de-CH-frami, en-CA
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
 <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
In-Reply-To: <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F15.6360E2C4.0060,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


[ Please don't top-post ]


On 2022-11-01 02:04, Zhu, Jiadong wrote:
> 
> It is a macro defined in amdgpu_ring.h, calling function pointer preempt_ib directly:
> #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
> 
> The real ring's hook is assigned  in gfx_v9_0.c:
> static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
> ...
> .preempt_ib = gfx_v9_0_ring_preempt_ib, //please have a check this line existed.
> ...
> }

Patch 3 assigns preempt_ib in gfx_v9_0_sw_ring_funcs_gfx, but not in gfx_v9_0_ring_funcs_gfx. mux->real_ring in amdgpu_mcbp_trigger_preempt presumably uses the latter, which would explain why amdgpu_ring_preempt_ib ends up dereferencing a NULL pointer.


> Here is the eglinfo on my board, I have once built mesa component (22.3.0-devel), which may update the libEGL_mesa.so

Looks like EGL_IMG_context_priority is supported (it would be interesting to see if it's listed for the Device Platform as well, but there's probably no reason to assume otherwise). Strange that you can't reproduce then.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

