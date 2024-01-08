Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29389C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 08:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5339510E093;
	Mon,  8 Jan 2024 08:12:48 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4706B10E093
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 08:12:46 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3368b1e056eso1511455f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jan 2024 00:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704701564; x=1705306364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yQZ5LVa70IP8hBVnNDym3i45s5zdllej4L+wmyej/F4=;
 b=ZM9dCBecUzE16h4sKD/TpXXJ9FxppsSEcXTtaEt9Fg2CBXk98J0nyxLKPEIudYYFmq
 w/mM1KYuF/dxUq2Hza2peYPG2l+XhUCe4BIW/SjBtlk2DgNm8QCM0xQ9keuAW3xJxAid
 O4BHcR2DMTFiCYkiA7HhEAbQkssnSpTN1rty14qpg7l8i+YkVj+brON8L2Cx2uVSG60l
 kbPUllGoLSFj5aC4NqjP1sq+e7Kz6eoT6F7HiumjOgkpwsf6giBF6c7+dIkYCtFmDdBP
 OW70vZ6RR+iwQ3Cfa6EscbbYdtGW7A6o9ljzwyAmn5SUJ96hwHsQ7oLEht8nzic3p6WL
 QnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704701564; x=1705306364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQZ5LVa70IP8hBVnNDym3i45s5zdllej4L+wmyej/F4=;
 b=jmsAmMJGnZzroMQI0/RQpbKzsrUgarnsJngabz5Jnsu36OwBrf+GH1SzQ5VzCBz9A4
 jygYWtNskgrWdyKrPkdQprIQG035oBVZvF9iuH19yWjtmKYSyZPUGE12eTDNeFwbjXa2
 Ilmu3CwZ9d0SfZ+O7H8Ahb3wMpdqoh//OeiA31xXsJEpZmcaGyq76DjlZs4Z+kkkUtpE
 gRaReQoNF/yRgPJvQU9hiPtngDcDFniH4FDuOGvL+0Kzt01ZIs6uxqfI3xYeCY0/Bx2q
 ToTDTFa8j8ja3aiUXkVtN1kDajI3LnSkmnMZqB5mxYDg+SCwepGvJyd1Au0+54Rk0cX7
 LOiw==
X-Gm-Message-State: AOJu0YzXpC+jYmt2aRjz4NvbVh6uzW3bQWlXmlYL8CqAkd5LkC2VAlvK
 fuOdu/ioRkSyen9pxaClbLU=
X-Google-Smtp-Source: AGHT+IFNPkminktm7lff3vQsm0Y6bkbgnID6JIoCUR2UJq3hY2T9enmiMheA98zsdH6QFOWo5dWVxA==
X-Received: by 2002:a5d:4ad1:0:b0:336:85b7:167f with SMTP id
 y17-20020a5d4ad1000000b0033685b7167fmr1459326wrs.4.1704701564239; 
 Mon, 08 Jan 2024 00:12:44 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a056000108500b003366a9cb0d1sm7091501wrw.92.2024.01.08.00.12.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 00:12:43 -0800 (PST)
Message-ID: <101cb9a1-f867-4ef5-9d03-d9419f0cd105@gmail.com>
Date: Mon, 8 Jan 2024 09:12:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: make a correction on comment
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240102205653.909619-1-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240102205653.909619-1-James.Zhu@amd.com>
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.01.24 um 21:56 schrieb James Zhu:
> Current AMDGPU_VM_RESERVED_VRAM is updated to 8M.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>

Maybe remove the value completely from the comment, just something like 
"How much memory be reserved for page tables".

Either way Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index b6cd565562ad..b788067b9158 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -116,7 +116,7 @@ struct amdgpu_mem_stats;
>   #define AMDGPU_VM_FAULT_STOP_FIRST	1
>   #define AMDGPU_VM_FAULT_STOP_ALWAYS	2
>   
> -/* Reserve 4MB VRAM for page tables */
> +/* Reserve 8MB VRAM for page tables */
>   #define AMDGPU_VM_RESERVED_VRAM		(8ULL << 20)
>   
>   /*

