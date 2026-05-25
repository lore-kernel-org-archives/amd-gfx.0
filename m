Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68236CD6E43
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FE110E541;
	Tue, 26 May 2026 07:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="bV0z8hXP";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321AC10E5BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 08:51:30 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1353c2f35cfso3920110c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1779699089; x=1780303889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eF11QkB2Y87ktOl+VvZUh+WU/9ax0WPXerxK1GF9DNc=;
 b=bV0z8hXP3SDrV5MgEfdcOc4C3Is/8B9U1KhS3PG3E/DwSZxtRRa9w/CmZxaO32A36+
 c8sIZTyknjpYFJgkJ0HnAoqj95UwtlmbY7GrHEoIKoAf8IUhlIIxxaX0peeUGa/KxVxE
 1U8Jgzxme6RycoycPecN7A/uuTRr+q/UxiTxe7MSmIqBbLAwOey+GvhDVlH+VWt6jF4J
 3/T/bnZrxG8tnkwFxtrE+DOLWlxlrSigFbGeXXSBaH5xrIyKFzPNz/3eGc9mQnplaWKP
 YyBXg9xA0mx6HW4t2sL4O4dqpSbTpTNJl15PCP6LnyQb0lvcWvvwWgq18IWXfTHHPdyX
 SyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779699089; x=1780303889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eF11QkB2Y87ktOl+VvZUh+WU/9ax0WPXerxK1GF9DNc=;
 b=X6d4783By1xt2pcfmBPgKvZlltywJ3EH2TUMNe+q3iFqmHLtTwCs9UOMeG8Egm/bS/
 CvozGdCfpmVlZjtA/VGfQMlUhlXsw2HTC8qQY6m3WZGJUGkMP2DXQVBOB9/Fsr5e/9Lh
 x95rmgjnxl91IwFDCVirS/VqqBPd2FCwTPjPhfxWnElkLUX+9QTefatBpIijgyVNlHUi
 zyTD2vX+RKWF4oxKtx/bI2K6SzfvV4e2uPHnZQmfPV8Q+Z/c3i9xatoHR/QJDMBTHhlQ
 hAdatW4FId2nozXN5kYDPMUfdwYvici7zIeSmOHH02Re2YEY4OEclpX2OXRXMPB7562F
 Ogbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ85Gogfok0f2voDceQZAv9tTtbSTuDDn/D/gzdyUwabYMobrq6v5KWHqZni79eyOpgxWAAhEhmR@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9zwy7fL4FnN/wfFw41Lfb4hXlIr3WLHPrsXhQ35sD3eFYTokC
 HuUCH0+Bi6iB6NsMwNtil6Xvumopdo7g5aO4ZqXKd6OEmVG4nc+AW352mbD79EYxreI=
X-Gm-Gg: Acq92OGTzOY5mGdSuRO0cMcGiSGSqvRbdosnXR1Cfao+jWFYljxN0gGsUnVYEIjShXV
 qYQgIjMzRceX3ZVYTnpogX9B+abvoSOymWHNCfd57dswpO+xmFL3O7Jp2vo/FemNClDkFzz9VtE
 Jxpp9t34LGmz0jLrfFzyWHE66tEm34FQ82YbvuiyMfbyqwfRj4fRwyjw42dU4P5ssyZhN7/mJmK
 JwKLRzlrhDjq8KU+vh6n/dHluAcuqu4OsplV7pMXcnglBg4MmzJqODeupCokKdQvWaPT3aIPVYD
 Ay043DYngthekjErAnEkjgLSNKSe+fSrz5mk6TScbqtVWGh/BKLrzVtumGwsLDVxR3dLSTmAaoR
 TwxrW3cBgMz1TZ7AUjv7ZuwRJMEH9eAlS/W/VHjBvlUHcfLRxOgVO+sEGopgpejD+DxUJl5c5hf
 FnRarBcxkKUWzXoiYeuENmwNvdP2NtC3Pjwny///WizHD0Hp6+qBnQk1aRMBwFgkR/ZYu+lmasA
 APVbOLg21ERrX3na/Dko+orinVxliPau/V9tyUzGAkbuedxOTGJ
X-Received: by 2002:a05:7022:799:b0:132:2486:acb with SMTP id
 a92af1059eb24-1365f81e585mr4905784c88.12.1779699089379; 
 Mon, 25 May 2026 01:51:29 -0700 (PDT)
Received: from [192.168.30.115] ([186.220.219.33])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a509602sm6080008c88.8.2026.05.25.01.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 01:51:28 -0700 (PDT)
Message-ID: <96a6ce62-d015-4cc7-8584-bb73171f23a9@usp.br>
Date: Mon, 25 May 2026 05:51:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
To: Ulisses Paixao <ulissespaixao@usp.br>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: Felipe Sousa <felipesousa@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260505175006.13519-1-ulissespaixao@usp.br>
Content-Language: en-US, pt-BR
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
In-Reply-To: <20260505175006.13519-1-ulissespaixao@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 07:53:08 +0000
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

Hi Ulisses,

On 05/05/2026 14:50, Ulisses Paixao wrote:
>  
> +/**
> + * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
> + *
> + * @adev: amdgpu_device pointer
> + * @me_id: micro-engine ID of the faulty ring
> + * @pipe_id: pipe ID of the faulty ring
> + * @queue_id: queue ID of the faulty ring
> + *
> + * This function handles privileged instruction faults by identifying
> + * the faulty ring (gfx or compute) and triggering a scheduler fault.
> + */
> +void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
> +					u8 me_id, u8 pipe_id, u8 queue_id)
> +{
> +	struct amdgpu_ring *ring;
> +	int i;
> +
> +	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +		ring = &adev->gfx.gfx_ring[i];
> +		if (ring->me == me_id && ring->pipe == pipe_id &&
> +		    ring->queue == queue_id) {
> +			drm_sched_fault(&ring->sched);
> +			return;
> +		}
> +	}
> +
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		ring = &adev->gfx.compute_ring[i];
> +		if (ring->me == me_id && ring->pipe == pipe_id &&
> +		    ring->queue == queue_id)
> +			drm_sched_fault(&ring->sched);
> +	}
> +}
> +
>  
Looks like the same pattern already exists in gfx_v10 as well.

gfx_v8 and gfx_v9 are slightly different though, since they directly
fault gfx_ring[0] for me_id == 0 instead of matching pipe/queue.

Mentioning this in case it’s useful for considering whether the same
cleanup could be applied there as well.

--
Kind regards,
Guilherme Ivo


