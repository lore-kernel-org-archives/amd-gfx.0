Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541EEFA3740
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 12:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A619C10E1AF;
	Mon, 31 Oct 2022 12:01:55 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A4B10E1AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 12:01:51 +0000 (UTC)
Received: from thor ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202210311301471002; Mon, 31 Oct 2022 13:01:47 +0100
Received: from [127.0.0.1] by thor with esmtp (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1opTUA-000eln-1B;
 Mon, 31 Oct 2022 13:01:46 +0100
Message-ID: <e5544150-5eae-7dae-b5db-dd9539df8198@daenzer.net>
Date: Mon, 31 Oct 2022 13:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: de-CH-frami, en-CA
To: jiadong.zhu@amd.com
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-4-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 4/5] drm/amdgpu: MCBP based on DRM scheduler (v8)
In-Reply-To: <20221018090815.2662321-4-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1A.635FB92D.0027,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: amd-gfx@lists.freedesktop.org,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-18 11:08, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> Trigger Mid-Command Buffer Preemption according to the priority of the software
> rings and the hw fence signalling condition.
> 
> The muxer saves the locations of the indirect buffer frames from the software
> ring together with the fence sequence number in its fifo queue, and pops out
> those records when the fences are signalled. The locations are used to resubmit
> packages in preemption scenarios by coping the chunks from the software ring.
> 
> v2: Update comment style.
> v3: Fix conflict caused by previous modifications.
> v4: Remove unnecessary prints.
> v5: Fix corner cases for resubmission cases.
> v6: Refactor functions for resubmission, calling fence_process in irq handler.
> v7: Solve conflict for removing amdgpu_sw_ring.c.
> v8: Add time threshold to judge if preemption request is needed.
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>

[...]

> +/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need to resubmit. */
> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
> +{
> +	int r;
> +
> +	spin_lock(&mux->lock);
> +	mux->pending_trailing_fence_signaled = true;
> +	r = amdgpu_ring_preempt_ib(mux->real_ring);
> +	spin_unlock(&mux->lock);
> +	return r;
> +}

AFAICT amdgpu_mcbp_trigger_preempt is used only in this file, so it should be declared static.

(I didn't audit the other new functions added by this series for this, just happened to notice this one)


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

