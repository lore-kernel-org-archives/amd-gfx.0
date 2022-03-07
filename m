Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE35C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 07:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279E210E197;
	Mon,  7 Mar 2022 07:17:18 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F6810E197
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 07:17:16 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id g20so18541194edw.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Mar 2022 23:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=i7SJdcrAW9vRzU/5/Dx/MJncbcSpd0FCPAOZjsGulyY=;
 b=MuirwCAbY+oAtSxqLNYTBI/vFW781UVXMUlAcpAE+hhy1a6fwcUGoirENZGkDRNyBw
 XM4T/86F1nyv6g5duRPotb1UTdZOOE2hLjc6KEZWom6ssJS0LN/gf/8sj5pEBqeU0tUD
 m86WYmu6u+F6/bbU/K7qRWY/OUPBEMY+42liPXDA5IJ35kCB15SlG2353MAJUAnXku5g
 pXg+l7v41hIhakEd27QFlBarQRAHPWJV84NUNt8n28ZV+wgwv5bocJ3KmPQZ3RHK4eqC
 +xt8abLjAaPzJITpU1vQd7aO30TOwdEET42dxVrdlfNmY8xFzwh2hG28rsyx0Zx592bp
 PfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=i7SJdcrAW9vRzU/5/Dx/MJncbcSpd0FCPAOZjsGulyY=;
 b=ZesWJJtHM+ZosEKp5F0Au9gfvrALxa5Fbt+HmBBxQm5HmihMy591hTJB/51RzcnGsE
 YGW2awA72qDKn9/X+0T+HaKZR4qiGDEvnk+oVGTfQLRw3ap5PgR3Yi4stUyp8XK5Vtus
 /XM+uJC8ybGhol36RLfXB+6Zfp3cKn30wDtQCWvC8/m6UlyuFNsXda01f9P8U4L5AEIZ
 5pNb5FZUjdVtEz/r/Nx2aMob3HO5Qnr0YKCErbJhKpZ+FQ4ouVvVgtG3EOr9aklaPoK2
 coIHWsnt5t1zsy8V6hDwPuqIhFwXUIxqegDYQaBuBvCoHPtRdOOSZk6OzRqSiegnKB8j
 jpqQ==
X-Gm-Message-State: AOAM533FpFKENaflMcH9DiGOq4rqVVQU7uYvsL8Ow3+SxT4VpMHAU6v8
 i/mbV53GuGNaaUeXrwvUiiQ=
X-Google-Smtp-Source: ABdhPJwPxxlKcCY34T/3cJ+mU0Gib4reE3KlLeuNWpS5zmyjRPIzvWkre+WOxX1MilkNErJeKC8KuA==
X-Received: by 2002:a05:6402:c81:b0:410:a329:e27a with SMTP id
 cm1-20020a0564020c8100b00410a329e27amr9934347edb.142.1646637434688; 
 Sun, 06 Mar 2022 23:17:14 -0800 (PST)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a50bf4d000000b00410d407da2esm5834165edk.13.2022.03.06.23.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Mar 2022 23:17:14 -0800 (PST)
Message-ID: <71297da6-39b6-c5f3-855f-806ac9285554@gmail.com>
Date: Mon, 7 Mar 2022 08:17:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: fix a wrong ib reference
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220307040309.350870-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220307040309.350870-1-Lang.Yu@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.03.22 um 05:03 schrieb Lang Yu:
> It should be p->job->ibs[j] instead of p->job->ibs[i] here.

Rebase fallout, thanks for fixing!

>
> Fixes: 1027d5d791b7 (drm/amdgpu: use job and ib structures directly in CS parsers)
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 662cb66493a4..e8a3078a85cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -783,15 +783,12 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   				memcpy(ib->ptr, kptr, chunk_ib->ib_bytes);
>   				amdgpu_bo_kunmap(aobj);
>   
> -				r = amdgpu_ring_parse_cs(ring, p, p->job,
> -							 &p->job->ibs[i]);
> +				r = amdgpu_ring_parse_cs(ring, p, p->job, ib);
>   				if (r)
>   					return r;
>   			} else {
>   				ib->ptr = (uint32_t *)kptr;
> -				r = amdgpu_ring_patch_cs_in_place(ring, p,
> -								  p->job,
> -								  &p->job->ibs[i]);
> +				r = amdgpu_ring_patch_cs_in_place(ring, p, p->job, ib);
>   				amdgpu_bo_kunmap(aobj);
>   				if (r)
>   					return r;

