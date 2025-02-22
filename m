Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD9AC021B5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7487A10E2DD;
	Mon, 24 Feb 2025 13:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gLHCEKpZ";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862F310E052
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2025 17:40:41 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-38f2b7ce2f3so2323722f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2025 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740246040; x=1740850840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:subject:cc:to:autocrypt:from
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1ttL5pHI1p713eH7OoYs5qTbz5rBQ8zpC4b19SPCFU=;
 b=gLHCEKpZaVYWPNJo2/9mxSSiqApoJYmy7MGgB7BZC9lHCIeM/aT3kDaPH58lVALYWT
 e3d2KdTXuMJIj3FQfeJVttomwXluKNkWlxCUig3LMtBpDi1D93acO+uW1P51cKpjVL4i
 2EvTxxkvXDTQtkfKtXbnG1sNM8O7OV8Y9jTGlrNoOMGQFRC9p+jaocqwEVE7NIA01UT1
 QE4K9Hr6eDJFAhitRinjefk8UTW2wPjgjWyJYQyyjqzKnYcfvkq8QeLfzUveulwJqUHx
 aR1kMf5zzfUbHcgBhT2zvLGQlALb/wbELj+OKCJl/sBJALMnZ3KV0MnCq+hd/jcNmeKj
 8ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740246040; x=1740850840;
 h=content-transfer-encoding:subject:cc:to:autocrypt:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1ttL5pHI1p713eH7OoYs5qTbz5rBQ8zpC4b19SPCFU=;
 b=tPlUVnTiMo9IaEyb1UieBnIV6Im7lO8hQu4sdm6claKdg13Tehx3TAbg04YqxYCry6
 uoOtbMH1Yfo61ZUg9QFQ6Z0sGPicGah8VCUaeWb1GynNwui5X7qlxeE/CO22JBxXiqsM
 bFqw0JRrzbdBTioLlFwUvzBtWN4z0t7ZD2nDk6qU5hV34gwCYJxPBY/ZA9qsLGV7YjuR
 oJDNkbqSqvX6lDbrQcuwc6rgZ+bTtQ6FLyDb/4apyWnV84l2zRhrXzrElDr0qkEv8+IH
 +Auzoz8aHcpC97Q8T+AOiqDvQVSa+8xkb3A/e1PTVdPnMfQ0547FjukYEmMche7xGMHx
 fbtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPrhC66FPR3IryvGWqiy/0NhCwBMI6GnnSUTAzZ5O+LGIp6EwQNvlGVuA0Zz4fYsiIXQnfLUPF@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4SQUPsoOWOVwucPr5i/8ROAr0BhnejZm2hBAzVkDUeBm8n5o2
 D61KWXb1zNs/sE0sbqfPWF2iQYsvmf8z8eYwDmmiHuDZ8dTNHM9T
X-Gm-Gg: ASbGncsFcO2hKnhP9lWZ9FBjuW/XF1Q/J0nj4cYVj3whHhL5qGoBv/mMXpCyCm4s9zK
 2iwuQRA4D+o/6YBBmhsPuhCityYr+DnPtjazMsS0lWpFnpaSBJKR0G82sh3DgxEIY1NpVas2Qnr
 S+ezAy8dH/G1NUPoK6YV/0REMr75e6FXhAKB3sbTxcVgr0TTzq1RZ3+SREYELKJJWX4fRW6nYck
 z48ZNfe0XuOE1A8+wsLs4FuOrNy82OtMz5bp5Vq9YVSV7nGsudLxLNi1wZ0IPUnus74yU1l+Fnu
 0BM3eBYco82nN7J2jpJ3mhb/9FIrB2YZd3uL1VvCexa0f03r8nYfL1wAVRbFYqzJPlh3KW4BPr6
 qJfJ5xn+Gf+Za5mvBioc2tX6t6DvWVwXpSkrUTcNbxjvufGpPyv6JSNx7DKbmmugsFsfJZjqwFn
 NWsH+p+4cQTPhrQV4W6g==
X-Google-Smtp-Source: AGHT+IG/QR9+S1hGghueMFFW+x8PcwPifBvebaXQ+uFfS3ddt6rIymhObJltwL2SgEH+8hGe1v/FPA==
X-Received: by 2002:a5d:6c63:0:b0:38f:2a7f:b6cd with SMTP id
 ffacd0b85a97d-38f7079a134mr5334761f8f.20.1740246039698; 
 Sat, 22 Feb 2025 09:40:39 -0800 (PST)
Received: from ?IPV6:2a02:3100:a1a4:5e00:9561:7632:4077:4896?
 (dynamic-2a02-3100-a1a4-5e00-9561-7632-4077-4896.310.pool.telefonica.de.
 [2a02:3100:a1a4:5e00:9561:7632:4077:4896])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f258dab74sm27112460f8f.32.2025.02.22.09.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Feb 2025 09:40:39 -0800 (PST)
Message-ID: <cd2859a2-693f-4de7-ba4f-351b1dbd0d69@gmail.com>
Date: Sat, 22 Feb 2025 18:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Frank Min <Frank.Min@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>
Subject: Wrong LTR-related check in nbif_v6_3_1_program_ltr()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Feb 2025 13:35:11 +0000
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

In nbif_v6_3_1_program_ltr() (and maybe other functions as well) you have
the following:

pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);

if (adev->pdev->ltr_path == (devctl2 & PCI_EXP_DEVCTL2_LTR_EN))
	return;

if (adev->pdev->ltr_path)
	pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
else
	pcie_capability_clear_word(adev->pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);

The comparison to (devctl2 & PCI_EXP_DEVCTL2_LTR_EN) looks wrong, as this expression
can only be 0 or 0x400. I think what you want is
if (adev->pdev->ltr_path == !!(devctl2 & PCI_EXP_DEVCTL2_LTR_EN))

In general I wonder whether the code part is needed and why pci_configure_ltr()
in PCI core isn't sufficient for you.

