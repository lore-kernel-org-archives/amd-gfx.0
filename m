Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AE7C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 09:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2C110E15F;
	Wed, 15 Jul 2026 09:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="WV8QhpUr";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF2410E15F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 09:38:43 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493f431e317so14456085e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784108322; x=1784713122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AbxlUXBEQTQDQ6dtK3BtbH2dZAbiBjbDwaTSG+TsdFc=;
 b=WV8QhpUrE8ALPXiWUT7AIGflWgQckND/5QSUzlQ5qaIivNLWkwtq1ulngHtjdI7NAw
 bou1pdaMztRXBK45zPVEQT7Ul0p+7MZosR9ymRqaqnQiFpbFPKyUQE3vkgXd0qJnAqY/
 HT7xSbrLd6/e1Vqfe74v5qROsQnFHRMfe3KPpYFXyVB+yYaKfIudiynZoqrYeots/gKu
 pn1JnrfB8yVYjGaZ39ebZwsO9+VxbN2NBiLg3TqDn1QocMOYQZDr+wL2/aw7NP5ZCn9F
 ZnFVCX3oTLYE8wmVQiH8JJjGLa6E+aEzYBS1dfd1X0AjdCgVPYM3NGh2Bav4TzIw6m7A
 45NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784108322; x=1784713122;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AbxlUXBEQTQDQ6dtK3BtbH2dZAbiBjbDwaTSG+TsdFc=;
 b=nDFnDE8oTsbl5DBRwQlK7xdoy4DPkrPVbNDgobu26p+kZdRM/edQNm9+PrGtCQ/fuX
 atW/8kUnjNw3vmKUZMuU2iwOJtp8Eh8VQh0mwyBXH75q822K5r9QCGSwcmypwpGJ4/cN
 YZovIkRNBRQnZCKRB3ZdBZ0nLARTzQlxO2z/r1WfXKkVIHGJEMOTAJ1nteU+xw+Ywl0o
 3XM/eZ83xSJTeKu50E8Pgt25tEaEao3Wp9zWw6EdUZLC/b8JjgL7P8+zlHke4VQs9QUg
 C1n5YgoXGpUV1JbNeF14klH3q2odUN0Lb8e4PSMaWW25/9ovasr0Q5zN8Kt1b+GKTIrn
 dlNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOF8+g4Q/zhgEQKSnlL0kDoyJLJs7QfRn6ot6yRzG/09voMAXR0POeaH5horO6Tz5W+VJ30log@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUZFOaFjh/qZTzp8RuYM2Ds9BQ5xVlGDf/M5uUdJo2wIo9QReF
 /ItShpR986hY0P2K4PG5nHxLrIYtLGvTWbwRcWiuDsRi1646xnsGAcQPnAo0rZ05I8jwHPXvZyj
 YYBxKzSs=
X-Gm-Gg: AfdE7clepoFlZO/aLWrn18L9zGDDScp5ByrVVROVFa3CBNfZgC0wSGk7gOLmpvdl0e/
 R8pQk/voynqe4SAir6rOmlXVd+NO23Uj8TV/moli3EyO4TUoFeBtLqFDGlfN6oF3tykcVg+bp7a
 liFzobQcLAjcLgy6IPP2V8nClraxzZ4h+6vD/Fw06P+A2x7NOmPnX5Sv9X6iwy/wessXeCBs9hw
 BaPaocpzVZmUbeQV5sGQoF52QCDfAvUzXrhUUQX1AKeOsvSsNdFmrJZwuL1GYHVybykaADMJfAc
 aU3+KitftTtzIHu7+Ed33QE5lUU2M8Docahro4/pnWWCY54HOpR0HfDywqA+C7RWKabzk8i9uf8
 775IOpSyDqHEkOmHG6hqb9EN2Xj2mRFDUVLFfuOWZjK5NrCO9bvJd0QtkvGGqY1Xq3WdZ2PrkJJ
 E3KF0nGFM+XthWPOOGsHTa3a3yCYMR3oySsuHpRhg73xoG
X-Received: by 2002:a05:600c:1548:b0:495:3e2e:11e5 with SMTP id
 5b1f17b1804b1-4953e2e1373mr11731875e9.13.1784108321806; 
 Wed, 15 Jul 2026 02:38:41 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495087366c0sm251005525e9.7.2026.07.15.02.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 02:38:41 -0700 (PDT)
Message-ID: <2a8374ee-bd72-4306-9524-a8cb3cc0d5f8@ursulin.net>
Date: Wed, 15 Jul 2026 10:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/amdgpu/gfx7: Use COND_EXEC
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-8-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260713125838.30607-8-timur.kristof@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 13/07/2026 13:58, Timur Kristóf wrote:
> COND_EXEC tells the CP to discard the dwords following it
> when its condition is zero (false).
> 
> This is useful for GPU recovery because it can help reduce
> collateral damage during GFX IP block soft reset, meaning
> that it reduces the likelyhood that we fail some jobs which
> are not guilty of the hang as the IP block soft reset
> mechanism clears the condition before doing the reset.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 915612628f9a..6d52b8710437 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3162,6 +3162,22 @@ static void gfx_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>   	}
>   }
>   
> +static unsigned int gfx_v7_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
> +						      uint64_t gpu_addr)
> +{
> +	unsigned int ret;
> +
> +	/* Discard following DWs after this packet when gpu_addr==0 */
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
> +	amdgpu_ring_write(ring, lower_32_bits(gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
> +	amdgpu_ring_write(ring, 0);
> +	ret = ring->wptr & ring->buf_mask;
> +	/* patch dummy value later */
> +	amdgpu_ring_write(ring, 0);
> +	return ret;
> +}
> +
>   static void gfx_v7_0_ring_emit_wreg(struct amdgpu_ring *ring,
>   				    uint32_t reg, uint32_t val)
>   {
> @@ -4943,6 +4959,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
>   	.get_wptr = gfx_v7_0_ring_get_wptr_gfx,
>   	.set_wptr = gfx_v7_0_ring_set_wptr_gfx,
>   	.emit_frame_size =
> +		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
> +		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */

gfx8 version /appears/ to make an effort to keep the additions here 
sorted in the emission order. I think at least. Not sure how much value 
it adds since the whole emit_frame_size mechanism is "fragilotedious". 
:) Another task for a rainy day - we see if it can be replaced with 
something more manageable. Anyway, digressions aside:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>   		20 + /* gfx_v7_0_ring_emit_gds_switch */
>   		7 + /* gfx_v7_0_ring_emit_hdp_flush */
>   		5 + /* hdp invalidate */
> @@ -4965,6 +4983,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_switch_buffer = gfx_v7_0_ring_emit_sb,
>   	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
> +	.init_cond_exec = gfx_v7_0_ring_emit_init_cond_exec,
>   	.emit_wreg = gfx_v7_0_ring_emit_wreg,
>   	.soft_recovery = gfx_v7_0_ring_soft_recovery,
>   	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
> @@ -4979,6 +4998,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
>   	.get_wptr = gfx_v7_0_ring_get_wptr_compute,
>   	.set_wptr = gfx_v7_0_ring_set_wptr_compute,
>   	.emit_frame_size =
> +		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
> +		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
>   		20 + /* gfx_v7_0_ring_emit_gds_switch */
>   		7 + /* gfx_v7_0_ring_emit_hdp_flush */
>   		5 + /* hdp invalidate */
> @@ -4997,6 +5018,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
>   	.test_ib = gfx_v7_0_ring_test_ib,
>   	.insert_nop = amdgpu_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.init_cond_exec = gfx_v7_0_ring_emit_init_cond_exec,
>   	.emit_wreg = gfx_v7_0_ring_emit_wreg,
>   	.soft_recovery = gfx_v7_0_ring_soft_recovery,
>   	.emit_mem_sync = gfx_v7_0_emit_mem_sync_compute,

