Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 11:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CF910F037;
	Tue, 11 Jan 2022 11:01:28 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D96010F037
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 11:01:27 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id e9so30711100wra.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 03:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=DMwf7Nb5ALC4I6rcr+iZ7pNo/02mNwlQ9CF04BzLgIA=;
 b=LR0NV05Vt8tjJBaJen5UCQ3MBLPeHEcZjqKOqQG7BbJkpMnGd9QysfmYPC4OT5q9dd
 Tkxp1FtxtJvTx8NRt6ZErxsIIq84TZWn067uhDGl5a9CWNVQQkT6MBRPs1QwLEZRwYsT
 F2UtNJUlxXoR544RN/uzTcz98O9u6rsIaf+km+/Lw5YNIy/myqu/ZoYYNDBHkq44vcRP
 6CMGTs7Vw3TA0iDup1S4fqSZ5JABGA2WJhtuzvRggvIszjDarOqNTsCvtAr1MNczdNzQ
 99VYJ3YPbAlC4iF0zWnfM1G+s1spYc5zzRzc1goDSu9hYxeRde6VT64U2WTT3ccfkz5+
 sAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DMwf7Nb5ALC4I6rcr+iZ7pNo/02mNwlQ9CF04BzLgIA=;
 b=HV1ZMSC9CV5RtowqEo6WTInxut+lfd1UB8xXiXUWpxZe8h0xnT1shqvV7mfblG3azl
 jO81DE1R11UfGlIDvXqiaAqZ6EzJasPQWHAOu4RHxOWus0nviZwPkTGh+tuQfnNbGzOW
 3K00aQrPWpxGHB0jwfhLwEgwnkkU0fq+8DwB74+/qVvtmT1Kn9sDNVDxlSu3JjtcbYwZ
 VhfmP9FxKAReRRTJfHaRungG137Myu/w35GgqXTquT6a7+zS+YKWkgnYMIJ6PuqVGFBX
 sCdtU+YgEjPqk7c0h1m6aLaF6IWKR4C1bb56sJmiJipGuRSRyv99VnRYjHl7r1uwNONB
 /gPQ==
X-Gm-Message-State: AOAM531YxssOuqSbGtxth/Fh+SO8j0wVXwUJthKzMQZI38FuX9nsEXc+
 NzNUEP5aaxzzT54YOzXAXcH0b4Vl4U0=
X-Google-Smtp-Source: ABdhPJwNJjxUBof2Fq+yUAZL75M4QUFcEt4CiTtAtdFdV+EpaCwMFWi6u5uKBGXwDE737MT0xUPwAQ==
X-Received: by 2002:a05:6000:1567:: with SMTP id
 7mr3369226wrz.513.1641898885679; 
 Tue, 11 Jan 2022 03:01:25 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id j9sm1247566wms.0.2022.01.11.03.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jan 2022 03:01:25 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: limit the number of dst address in trace
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220111070943.5370-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0bcd420e-7591-db90-cb82-ef837a24899f@gmail.com>
Date: Tue, 11 Jan 2022 12:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111070943.5370-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 11.01.22 um 08:09 schrieb Somalapuram Amaranath:
> trace_amdgpu_vm_update_ptes trace unable to log when nptes too large
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0e7dc23f78e7..0630bd43238c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1632,6 +1632,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			 * silent to stop fault floods.
>   			 */
>   			nptes = max(nptes, 1u);
> +			nptes = nptes > 32 ? 32 : nptes;

Please do something like min(nptes, 32) in the parameter list of 
trace_amdgpu_vm_update_ptes instead. I'm not sure if the nptes are not 
needed any more after this.

Then please also remove the previous workaround in amdgpu_trace.h.

Apart from that sounds like the right idea to me.

Christian.

>   
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>   						    nptes, dst, incr, upd_flags,

