Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2679DC25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 13:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C264F10E5CB;
	Wed, 15 May 2024 13:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UJxyhOgb";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB8D10E0D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 06:53:11 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-420180b58c3so20256535e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715755989; x=1716360789; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=asJ+9pW+1fRgwj/2u8znp52dd6XAzwkGNnDVnKx1Brw=;
 b=UJxyhOgbIvoUCwI2D5fxir1ex3N9r4sEf2cTINqtmDelgHI62WaZOJjnI/a03qxQ5x
 hkNH+IF/YAJGlQrGaK9vBV6NM9nqTlRwjbYbYZokoqP+LecU7QGHIzaHI+36DgfNHgSl
 xvc61tzXfwbRg0/LFYxQdUHK9vhUTVBVoIgGwAu5UEKnMJLIOgkgzXQfJlsq1+UR0vtG
 M2tnqS1dKhVRr+2bb5pVd5zzDxYLd+b9TkkHorHrAGt5dtgibBYTw+NaU8xYtjI54isC
 CGFbB0teu97VgDp8btnY19LwtyNzfguAADeLWbqfi0WV7DxnB/jSDTIC5pEp8Wc3rqJd
 M7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715755989; x=1716360789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asJ+9pW+1fRgwj/2u8znp52dd6XAzwkGNnDVnKx1Brw=;
 b=BFlDDqyGP/4LVB6d6un74cyTZ80ohyJSXBs55ltA+wJzrALn4Gi22yt4fAEFSw0xwQ
 s4v3nsbCVPeLFYOhQVIMYuWEpQPlIO8lkcUTUSe1twyywp+OhnxNSSU4xHzu85r0ZMUN
 LUMEfnfxY26b87hFc0gZtb7gmhZlZg6C4QjOiygIpuyVFkyF20uyjK5IO60zV3Cv0JVS
 T7t9G1RvggKEUyd4yDPFUNZ1xgADSWj/o36oOcU8+V0MppRMtuhtV8+xLXHPTyc9m6in
 WXJIHODfk+AnnKB9hEWg3TwZPrSYT8almqNOyOaqzapaxUJ9sQSaGOb11pQCpOdzD2hw
 yMXA==
X-Gm-Message-State: AOJu0YwT3rTpNj95GccZUNgdWttnQjcCUflfv7P/omSE/W+If4W2NSAJ
 z75cZNWrTxmif6ZY/aoOVjUisRZ255CECE7/g8122q2yyT4R7we8PyXJo3W+RPo=
X-Google-Smtp-Source: AGHT+IEBp5mRKtc591+J2rQ/Z/5jJ8GaHLTa8LuXcPs+aNSd7z5Ro3lkK+Zj+GGBdkc0oK52jhpkQw==
X-Received: by 2002:a05:600c:1d1c:b0:420:98d:e101 with SMTP id
 5b1f17b1804b1-420098de3c7mr91638515e9.15.1715755989000; 
 Tue, 14 May 2024 23:53:09 -0700 (PDT)
Received: from localhost ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42017166c64sm92278865e9.8.2024.05.14.23.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 23:53:08 -0700 (PDT)
Date: Wed, 15 May 2024 08:53:05 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com
Subject: Re: [PATCH v3] drm/amdkfd: Remove bo NULL check in
 gmc_v12_0_get_vm_pte() function
Message-ID: <01da1678-91ca-498e-b317-f340ad6eb677@suswa.mountain>
References: <20240515003103.634408-1-sreekant.somasekharan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515003103.634408-1-sreekant.somasekharan@amd.com>
X-Mailman-Approved-At: Wed, 15 May 2024 13:54:13 +0000
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

On Tue, May 14, 2024 at 08:31:03PM -0400, Sreekant Somasekharan wrote:
> Remove bo NULL check in amdgpu/gmc_v12_0.c:gmc_v12_0_get_vm_pte() function
> to fix smatch warning:
> 
> 'drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c:518 gmc_v12_0_get_vm_pte()
> warn: variable dereferenced before check 'bo' (see line 500)'
> 
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

This is fine, but you're overthinking these...  The v1 patch was also
fine.

regards,
dan carpenter



