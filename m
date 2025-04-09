Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152E2C369A6
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C69C10E9A4;
	Thu, 10 Apr 2025 13:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W3KKMJ+S";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E89C10E8CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:56:51 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso4181670f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744207010; x=1744811810; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2KhGefPiMXnLVMM2ovp7nBVf2mWzMUXA0dYdZ6nMa4g=;
 b=W3KKMJ+SSovFJ5/fZP1J7UkLcupe5oxM1l7+UOnotZOhI6yE1jrqSrILfzrjh52H/6
 VttideT2oo4CWsDYYL2vzTBDk1M127zSivoL98PLtRRsmGgn95jxDsqjKGj6cWfku4az
 lVQwzcGgHn+TPXlZm1O43ejkZVrYdl/6p++U12g4S2Qtm36QVNoJY6vNj/niFtQH9wst
 M7o+xNuBezU5GfUUcnF6lz3B5yumqMMkhcSt7jgYH/Y1Y0vyVgTdPcbZSrWLNqXDJ/KO
 k84y+AJUzQvhbk5ic8h8jVhoRLa6eNN5HchF74nB199BKdhxUXQei0uUPAIZTQqu8Z2o
 yYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744207010; x=1744811810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KhGefPiMXnLVMM2ovp7nBVf2mWzMUXA0dYdZ6nMa4g=;
 b=M4c2sacmP3nICkG7q2u5OmcUE/IeYlHomteTC2xeZjofA1jhIXxJXKMeIvKqM0/zFu
 nRX+CGv983uCdUWEDVnSUJ0bDQ+QsNA0gWz/PgFiYFXLIhOmdXJIrQg+4DWu2/kEYtTe
 lUv+HACm/0qVSNSjiQNOHVEHuPnWTS34xtdT8HmBFMtqJxeHbjSniZO/E6FKOOcCnMw0
 1yHWWgkQogaabFLb7XRx/ywjUMdGb51u5NNhvEO2o7JRcVrxkzFUgJHSnskWLdrJGBns
 GFs+kyh/l14Y6iXAKR8KCiyiNqEDpNQr5ESpLC8WqlM1ELevCQO/o8DVwhLcoSAowFAj
 WWhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX5pcX8cw/u51StcDq8mqMYaXwuukNjNQk7ifvKublo5ckyVSseHlFqMgwDQdGF3Y9JESFrBD2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcDcc+BSYF9WxCtWi8P0H39JC2M/pDnI2+WWfDdJQLwZ4U9RyZ
 m6KgLCnZ6KQBK/XNpyIEADgV7t60avdjjTZZhaLbeJ1SdEGZ+uJMOw4n8FzWZT8=
X-Gm-Gg: ASbGnct1WM1+mdWxnrd9NwL4tTdf/b++RTbwCmRopWqKO2sZOlj7x7OZwGKZKNyC1TL
 xwB7gl6IQ/PBae8CvSN1Phszc9caj/t7jJRF8hts+Zn4G0gjuBTSQ1UCGBKSKhHexKiW16X9NjX
 ni1j8aa4e1kDnkin6ztCn6sWDzRFmMLsJ78l6InuYWEEyX/A5u2vM7MJClZwHIvtpbu2d8edqLz
 YuPoMpOpJ8cNSj1EPpeUTktIfHhlzqpt0jGTUPINCXbu0x7S6TV7LQOPNs7BX05WMjRTC5Rbq7t
 2/owoEg6Y5ao8XzcQJiVkWGjFXIjCbCb1baCQv/i+3YlWg==
X-Google-Smtp-Source: AGHT+IEohHlZ85DUwuSFSGD1pk1w5ujoX+pwAIxYbtzA3G9O232e3I5wT4SlYwuuqqwwTGTCOcljrQ==
X-Received: by 2002:a05:6000:2585:b0:39c:3475:b35a with SMTP id
 ffacd0b85a97d-39d87aceed8mr2822123f8f.28.1744207009847; 
 Wed, 09 Apr 2025 06:56:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39d8937734esm1727458f8f.32.2025.04.09.06.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 06:56:49 -0700 (PDT)
Date: Wed, 9 Apr 2025 16:56:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Replace tmp_adev with hive in
 amdgpu_pci_slot_reset
Message-ID: <a6e37b47-a089-436d-be55-da298e844d14@stanley.mountain>
References: <20250409133955.26169-1-cesun102@amd.com>
 <a79917f2-0883-4855-9802-9c1f127c8f02@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79917f2-0883-4855-9802-9c1f127c8f02@amd.com>
X-Mailman-Approved-At: Thu, 10 Apr 2025 13:08:33 +0000
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

On Wed, Apr 09, 2025 at 07:19:25PM +0530, Lazar, Lijo wrote:
> 
> 
> On 4/9/2025 7:09 PM, Ce Sun wrote:
> > Checking hive is more readable.
> > 
> > The following smatch warning:
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
> > warn: iterator used outside loop: 'tmp_adev'
> > 
> > Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Ce Sun <cesun102@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 60269fba5745..6fb234832ff3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6784,8 +6784,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
> >  	struct drm_device *dev = pci_get_drvdata(pdev);
> >  	struct amdgpu_device *adev = drm_to_adev(dev);
> >  	struct amdgpu_reset_context reset_context;
> > -	struct amdgpu_device *tmp_adev = NULL;
> > -	struct amdgpu_hive_info *hive = NULL;
> > +	struct amdgpu_device *tmp_adev;
> > +	struct amdgpu_hive_info *hive;
> >  	struct list_head device_list;
> >  	int r = 0, i;
> >  	u32 memsize;
> > @@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
> >  		dev_info(adev->dev, "PCIe error recovery succeeded\n");
> >  	} else {
> >  		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
> > -		if (tmp_adev) {
> > +		if (hive) {
> 
> This doesn't look correct. I think the original logic is to have a
> single device list or multi-device list when there is a hive. Now this
> skips the step for single device case.
> 

I don't know what the original intentions were, but what I know is that
this code will behave exactly the same as the original code.

regards,
dan carpenter

