Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAADED132A6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 10:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6829510E3BE;
	Mon,  4 Nov 2024 10:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AM5Vy5bE";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A798D10E3BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 10:18:14 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-37d6a2aa748so2287228f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Nov 2024 02:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730715493; x=1731320293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BWx4GAIsiMDwfn3rjqqZH/H0QqYb6wC2rhlO6TCruA8=;
 b=AM5Vy5bE1nYA1O5N+tOhhCG0ZImByu27wxnwhDaK8VNXZT62BbBh8W0aZ2Vg0Q2I7E
 Jbqq3Y54/1ORAYfhCWjiVms2Jz0M/hjEEhcYxCx+vWrY0jPmWgizta+NIntikdBNnaX1
 K/DYJyrI5P+iaQalayaeF+GBbv2y3yQtvdqIaHcXxNkE73AcJetrjg/qR+QjWvsVSTCb
 oDRRu9our7T2rDgvqOSo71CeqG9zNBVDvySsDrqgSVBIfqpA9OTUv6BnFeee6KIPqhvN
 jX8uBVPmtRwXq0jvcPJ7tZrAsN6j6xcz1AxgeNHuwNp2huxS5KG8niDH3/GNmMtiF2Bg
 xe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730715493; x=1731320293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BWx4GAIsiMDwfn3rjqqZH/H0QqYb6wC2rhlO6TCruA8=;
 b=rJ3IAWgWzbxMMcWpoXDFIN9dYHAl6LJWyLBNNul0vc1jOisu2joH7tFw6ZDxeYmVoB
 b44zM5LCj8C1oPwX8OlvWg1IqgQVwiCFQsoM2e2ZNLZad1yx+XfJW2fHwKyRBOlLADsP
 iwh/Yf9SgyyMBxI5CVETqvlQrIbNgJ/nfZ2dLhJ8IwU7N1R7bOod8vpJIUYwHcmJvA+F
 w9fc5xExak6Fv46wI1nm7yvxDMduDA2VT4L+J0NXnXUj29/7wJp6xcYusukbLvz97OFQ
 cBggNW3jRylOYBqpg+5aXuF5sIcxW2A+NA8TMqXap33eAz3GWA5vnQ39M7YLtwFjzgKy
 /Ppg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpqm1WG3lCbKGFDZi78zNiysNpiuwyTvDW589olE6UgaGzbuf7yABSOwBGgwVzYY21lgatWhrd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywcurfxu9InWZ1iWrsPT5ftXFr5oNkiqeYeWxDZ+mUOw2+7flfC
 l21pZKZUExpOWZ+RFYF5K1S6zGKeYQnEmociwJDI+XFN3styX0oI
X-Google-Smtp-Source: AGHT+IHnTjOii3Fn+QJKoSYGQCo/PKToQFMsbo6KmV4HLdI2deqLwXb62bNWEwoByA0N2d4ktDEH4A==
X-Received: by 2002:a5d:6dab:0:b0:37d:5338:872c with SMTP id
 ffacd0b85a97d-381c7a3a4a9mr9847383f8f.1.1730715492636; 
 Mon, 04 Nov 2024 02:18:12 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e67csm12778856f8f.75.2024.11.04.02.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:18:12 -0800 (PST)
Message-ID: <c81fdd83-f765-47c3-9883-7fa9f93d1f61@gmail.com>
Date: Mon, 4 Nov 2024 11:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix identifying prefix and postfix SET_Q_MODE
 packet
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, yubiwang@amd.com
References: <20241104091800.97627-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241104091800.97627-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.11.24 um 10:18 schrieb ZhenGuo Yin:
> [Why]
> In legacy mode(no MCBP support) shadow_va of prefix SET_Q_MODE
> packet is set to 0, matching the value used in the postfix
> SET_Q_MODE packet. A prefix SET_Q_MODE packet will be skipped
> unexpectedly when mixed running jobs with shadowing on and off.

In general it seems to be a good idea to use the VMID instead of the 
shadow_va here.

But mixing applications with and without shadow is *not* supported, so 
this patch here doesn't really have a justification.

Regards,
Christian.

>
> [How]
> Both shadow_va and vmid should be set to 0 in postfix SET_Q_MODE
> packet. Combined these two conditions together to identify the
> prefix and postfix SET_Q_MODE packet.
>
> Fixes: 8bc75586ea01 ("drm/amdgpu: workaround to avoid SET_Q_MODE packets v2")
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..01b9dfe5b307 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5862,6 +5862,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	unsigned int offs, end;
> +	bool is_postfix = !shadow_va && !vmid;
>   
>   	if (!adev->gfx.cp_gfx_shadow || !ring->ring_obj)
>   		return;
> @@ -5886,7 +5887,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
>   	 * the postfix SET_Q_MODE packet. This is changed below with a
>   	 * WRITE_DATA command when the postfix executed.
>   	 */
> -	amdgpu_ring_write(ring, shadow_va ? 1 : 0);
> +	amdgpu_ring_write(ring, is_postfix ? 0 : 1);
>   	amdgpu_ring_write(ring, 0);
>   
>   	if (ring->set_q_mode_offs) {
> @@ -5901,7 +5902,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
>   	 * When the postfix SET_Q_MODE packet executes we need to make sure that the
>   	 * next prefix SET_Q_MODE packet executes as well.
>   	 */
> -	if (!shadow_va) {
> +	if (is_postfix) {
>   		uint64_t addr;
>   
>   		addr = amdgpu_bo_gpu_offset(ring->ring_obj);
> @@ -5928,7 +5929,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
>   	if (ring->set_q_mode_offs)
>   		amdgpu_ring_patch_cond_exec(ring, end);
>   
> -	if (shadow_va) {
> +	if (!is_postfix) {
>   		uint64_t token = shadow_va ^ csa_va ^ gds_va ^ vmid;
>   
>   		/*

