Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB701C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 10:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B506710E36A;
	Tue,  1 Nov 2022 10:09:48 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE6110E36A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 10:09:43 +0000 (UTC)
Received: from thor ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202211011109405300; Tue, 01 Nov 2022 11:09:40 +0100
Received: from [127.0.0.1] by thor with esmtp (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1opoDD-000oTM-0f;
 Tue, 01 Nov 2022 11:09:39 +0100
Message-ID: <92da389f-3c26-6fe1-0525-d38730b6924a@daenzer.net>
Date: Tue, 1 Nov 2022 11:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: de-CH-frami, en-CA
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
 <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
 <DS7PR12MB6333A815A3C3EADFFA303E4FF4369@DS7PR12MB6333.namprd12.prod.outlook.com>
 <5a11969c-0996-8755-472a-11f9cf1705d1@daenzer.net>
 <SJ1PR12MB6338730B8B54AD01E4FEF86BF4369@SJ1PR12MB6338.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
In-Reply-To: <SJ1PR12MB6338730B8B54AD01E4FEF86BF4369@SJ1PR12MB6338.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F24.6360F065.005D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-01 10:58, Zhu, Jiadong wrote:
> 
>> Patch 3 assigns preempt_ib in gfx_v9_0_sw_ring_funcs_gfx, but not in gfx_v9_0_ring_funcs_gfx. mux->real_ring in amdgpu_mcbp_trigger_preempt presumably uses the latter, which would explain why amdgpu_ring_preempt_ib ends up dereferencing a NULL pointer.
> 
> It's weird the assignment should be in gfx_v9_0_ring_funcs_gfx instead of gfx_v9_0_sw_ring_funcs_gfx.
> 
> [PATCH 3/5] drm/amdgpu: Modify unmap_queue format for gfx9 (v4):
> @@ -6925,6 +7047,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>         .emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>         .init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>         .patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +       .preempt_ib = gfx_v9_0_ring_preempt_ib,
>         .emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>         .emit_wreg = gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h

Ah! Looks like stg applied patch 3 incorrectly for me. :(

I'll try and test with this fixed this week, and report back.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

