Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C64DC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 08:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B28C10E10C;
	Mon,  5 Dec 2022 08:31:05 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D7710E10C
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 08:31:03 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id c17so6149414edj.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Dec 2022 00:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pkmxL+GrqQmSvldMYpZ6t6RWDsaKl1pwj2zoHi36F6c=;
 b=TnsleAKs2LYMFB7Cv5e06NY56EGGLNl/u0a03JiGAwPKEIkXGaLIdSF8BArCdxdR4J
 M1c2GbY87qiD533kNCcYKUHw/kjLa/ufpRzFo89u7v4PtJ4TDntWSNCafq/TlT06gHRy
 n6jLUmXfJBKgkmr6omG6ItYlqrJj20CUwmcwcGxEODDbYo4OwIBMt0Q9Q8DCUzX3YbhO
 E2hF9IlihhG27/nnlc4BDeuQm9Bii092kJLgyJXMx2H53YU2/nwUnSuXy/6YC581iRC1
 D1kjameQPqqw1208IWPwrDJXevutwgubYsTQrLYQPGbNPc0TggOyTTI004IJtJgk4kfF
 pEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkmxL+GrqQmSvldMYpZ6t6RWDsaKl1pwj2zoHi36F6c=;
 b=L5CcgeO5SDDyB1Xq/N3EiJEoOGVlIRGSUiJnRYwZ+SF0zluucvEMuuJtmJdMHYW82+
 AoLIDS1ahF16U1wKvEFVQNwJt9HxoZUF3f5BUBCBkddPmrvUDbDDrWHsRscsG/+w9Uqv
 vroFW7OyS1tvAsB+d45PEDKum096DgCYszgSkxKC0Yv70JqAZotXX11/Y9G79ckJbCjZ
 7oiFrC3GoYJql09KrofRHsHZ+lyrd8WcqoGsjVXyljFa8QL0ThRwrVprkGJyiF4rNiSk
 GjO3sb9cHAaoq9eOWE4vRt7zMVbq7bHliIjx8aiqinPZru6hbRmBHA78gWUEHNoj/gwX
 ejGg==
X-Gm-Message-State: ANoB5pk2LgRJiGpl96cqLwUQazIuJ/UYMX7WTggyr4UA5nW+xXrgNNZ7
 Dry1D02fGEv1Z0apaBBDbyU=
X-Google-Smtp-Source: AA0mqf5oJ3zh3Pq0dSyjHst8CWDtYVjhVXGRvBJ2V7kpv/RMA19VCFAuwjnBdOs2N/8XFFTSnI5IVw==
X-Received: by 2002:a05:6402:5413:b0:458:211d:cbe4 with SMTP id
 ev19-20020a056402541300b00458211dcbe4mr24403912edb.11.1670229061936; 
 Mon, 05 Dec 2022 00:31:01 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:bf89:3d76:c640:8687?
 ([2a02:908:1256:79a0:bf89:3d76:c640:8687])
 by smtp.gmail.com with ESMTPSA id
 ay10-20020a170907900a00b007c0efbaa8a0sm1308330ejc.4.2022.12.05.00.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Dec 2022 00:31:01 -0800 (PST)
Message-ID: <2fb37eb8-80e2-a4c4-39ad-96d16a20d613@gmail.com>
Date: Mon, 5 Dec 2022 09:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Make amdgpu_ring_mux functions as static
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221205022744.1024401-1-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221205022744.1024401-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.12.22 um 03:27 schrieb jiadong.zhu@amd.com:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> lkp robot reported missing-prototypes and unused-but-set-variable warnings on
> some functions of amdgpu_mcbp_mux.c. Make them static and remove the unused
> variable.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index 3348337379da..62079f0e3ee8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -350,7 +350,7 @@ unsigned int amdgpu_sw_ring_priority(int idx)
>   }
>   
>   /*Scan on low prio rings to have unsignaled fence and high ring has no fence.*/
> -int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
> +static int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
>   {
>   	struct amdgpu_ring *ring;
>   	int i, need_preempt;
> @@ -370,7 +370,7 @@ int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
>   }
>   
>   /* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need to resubmit. */
> -int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
> +static int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
>   {
>   	int r;
>   
> @@ -434,7 +434,7 @@ void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
>   
>   static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
>   {
> -	uint32_t last_seq, size = 0;
> +	uint32_t last_seq = 0;
>   	struct amdgpu_mux_entry *e;
>   	struct amdgpu_mux_chunk *chunk, *tmp;
>   
> @@ -450,8 +450,6 @@ static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct a
>   		if (chunk->sync_seq <= last_seq) {
>   			list_del(&chunk->entry);
>   			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
> -		} else {
> -			size++;
>   		}
>   	}
>   }

