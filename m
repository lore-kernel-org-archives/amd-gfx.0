Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE079C4828D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 14:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5050410FA03;
	Mon,  5 Feb 2024 14:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XYBTCKL4";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A24510F58E
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 12:22:11 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5114a21176cso620444e87.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Feb 2024 04:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707135729; x=1707740529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsTopB40v8e+57R3FP+15KsfdhxipZbBAJNJON7l3mE=;
 b=XYBTCKL4WHyA1iza8ey5d/HDTNvKBZWAI91gPxd9nSQBYG0ATZ60tJC6q1Gs407wa2
 u9cuY3y8vWQzMTi4dAFml6ufIKIH1ZFk3VuOBrHihJPNpOUSFNRhh2m+3jebTaW6aJT8
 bOfuBzVwJJZR9qYiKgn0x5B5GZRIZR35VjfOg9ebvAcjr2RRf+FFSRj4e4bXkC/3fi1C
 /6q6ZFkADBjbD8dISxxRZJuV8usKYynxWaNsqMS0gBECde4kQyPtTWhvv5nDQAzK8+89
 udc0a2ztjxLbyM2wk3X6cBedH6Z21QIXCLb8/hDEnnwE8mZk2BKsnIOAxe4Q83tPy+90
 Hf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707135729; x=1707740529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DsTopB40v8e+57R3FP+15KsfdhxipZbBAJNJON7l3mE=;
 b=ZPQO1vhSds0t6HyQ8Uq8qPwa+hKK8zK3Ll6GsxldJ/YtepC6cnV2yrddB1HR9SkrMS
 9p0RD2CCRTWkg0lqlgb/Ekmw4ID9WbCPLHlW5PYjxTHFRqq+6qeXlDHP0pWz/AHasNDU
 z66WqC0oS/SVeV99yCgCp2+SbLO5fDk0fbuSiCkJJwDBzp7FT0RhKluIgm4TZGT7VDgQ
 sVKvkKIYcK1i4TJ63Tk9s1iNSwWXdRJWWgttmlKvKZ45iawTbnODZs06Em9TfTn0dkKO
 rRD8Mo8PAsk4YoVnt1dkHFAqq/VYC0Gwn3ZJpBmSGcEZKtUCavzP5sVdvvetsIugvbrc
 c0OQ==
X-Gm-Message-State: AOJu0YwTyKjVyBg9tj90OR6Y66AlikbcMUI0JMF1rlQ7/amXiy44Mlv4
 OyYQvELQ3q5MMYD3O3dDiuO1m4N+jFQeMulHq7WlAWX+t3pzXnMq
X-Google-Smtp-Source: AGHT+IEOF08DEpMV/aE/bR6THEAkaKyqbsTR+aZvoSd+B423zZBGK06bqHI29Me8zUQgNkJYYs7TIg==
X-Received: by 2002:a05:6512:1055:b0:511:536b:89e with SMTP id
 c21-20020a056512105500b00511536b089emr1248133lfb.0.1707135728790; 
 Mon, 05 Feb 2024 04:22:08 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUhuGx+c5f52OKpYK4sIjM/j/qWUhfNP+BN/x2fhUnmjyAzVzpkMsHvapI0lc9LK4pbGDi3BGiiv1Ui42/31CQYcszxMRDVgM+61GVxVdDlh4vzLszfdlRR7gvACXgCSXb0WU7Ug/ZdPF3oiugFfnbr13PshUReJyFZl7XFrubNFxuT2iPzsm4L1p23j8e16x6ieuHxCeik5Ok2K87jhnv+JehO17/7b04fUeVDyw==
Received: from localhost ([193.209.96.43]) by smtp.gmail.com with ESMTPSA id
 w13-20020a05651234cd00b00511560092e3sm27526lfr.298.2024.02.05.04.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 04:22:08 -0800 (PST)
Date: Mon, 5 Feb 2024 14:22:07 +0200
From: Zhi Wang <zhi.wang.linux@gmail.com>
To: Emily Deng <Emily.Deng@amd.com>
Cc: <amd-gfx@lists.freedesktop.org>, <bhelgaas@google.com>,
 <alex.williamson@redhat.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add vf reset notification for pf
Message-ID: <20240205142207.0000685a.zhi.wang.linux@gmail.com>
In-Reply-To: <20240204061257.1408243-1-Emily.Deng@amd.com>
References: <20240204061257.1408243-1-Emily.Deng@amd.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 05 Feb 2024 14:40:05 +0000
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

On Sun, 4 Feb 2024 14:12:57 +0800
Emily Deng <Emily.Deng@amd.com> wrote:

> When a vf has been reset, the pf wants to get notification to remove
> the vf out of schedule.
> 
> Solution:
> Add the callback function in pci_driver sriov_vf_reset_notification.
> When vf reset happens, then call this callback function.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/pci/pci.c   | 8 ++++++++
>  include/linux/pci.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..aca937b05531 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4780,6 +4780,14 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>   */
>  int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  {
> +	struct pci_dev *pf_dev;
> +
> +	if (dev->is_virtfn) {
> +		pf_dev = dev->physfn;
> +		if (pf_dev->driver->sriov_vf_reset_notification)
> +
> pf_dev->driver->sriov_vf_reset_notification(pf_dev, dev);
> +	}
> +
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return -ENOTTY;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c69a2cc1f412..4fa31d9b0aa7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -926,6 +926,7 @@ struct pci_driver {
>  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs);
> /* On PF */ int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int
> msix_vec_count); /* On PF */ u32  (*sriov_get_vf_total_msix)(struct
> pci_dev *pf);
> +	void  (*sriov_vf_reset_notification)(struct pci_dev *pf,
> struct pci_dev *vf); const struct pci_error_handlers *err_handler;
>  	const struct attribute_group **groups;
>  	const struct attribute_group **dev_groups;

Hi:

I would suggest you can provide a cover letter including a complete
picture that tells the background, detailed problem statement, the
solutions and plus the users. As this seems very like a generic change,
it needs a better justification to convince folks why this is the best
solution. Without a complete picture, the solution just looks like a
workaround.

Thanks,
Zhi.
