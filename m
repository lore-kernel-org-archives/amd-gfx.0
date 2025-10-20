Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC350CCD1A5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 07:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8911B10E56C;
	Tue, 21 Oct 2025 07:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="fRJY34Jg";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B8610E16D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 22:38:27 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7811a02316bso3364471b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kerneltoast.com; s=google; t=1760999907; x=1761604707;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWRTJlVR14k1p+t4VRxVrxCe+1iPDNnQxl1YGhAuvaM=;
 b=fRJY34JgkTm2yQuGdXs+jX+kAbSfMT+j8Bp/O0Ub2fVayN3epUuXshzowxh49uRrX6
 Cs3RIpLgMb5wEaDlxUX18Ub/qlxdJGvXi6oH7Ucb+HCKbHwRPiEqnMj61luHChexYMvO
 z9tLG3BoXSetDk4ZU2MUbDitA0NG58azS8rIhuDyR11KTvGfJDubfxxdqy0XMTLaIodD
 KJlvADFCCMnNHRZAr/cBZxhsm1sdiWfoX2fsGdPQpZOIbLPcBsM2WYhqlk5ncKFhgWXZ
 J9G7slDYKwQQIkosBMBrbEfzk7kmEnhjRqBFqTXQTCfHE3TQ1iRPHFu95FoAHrqeF+Za
 m7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760999907; x=1761604707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWRTJlVR14k1p+t4VRxVrxCe+1iPDNnQxl1YGhAuvaM=;
 b=h7ltnJYLZzYRTXt3qcuZDzrNtMFFaOYnSU9bKUGlIX08XowITGvNSwTDLlu7zo+c1d
 UW+xAHU1AxMGVguuvIOJR+uN3/2Xor3RNSQCYrNnu0FDKf85Dn+XFIl0oMjLMEB8AmMb
 dsVLB8h1zfgkNiZwygmWs/hG5hmTgXfUZ+L1KnbESXyhN6ENUag0FoRRDlEy6/7smnYS
 WcW6LurlXRgkqonDZsr6nTcGnrj4tOcILLATchfx5OkuoqZpCm0tKEUpCS6lcSIETSsK
 gJAfit80Hfhs4Fa0u+R2HqoW0rjnaE6b12fjxkkdp5ODDcDsJiJeAeLN0Y1iDJ4mjk8+
 B/FA==
X-Gm-Message-State: AOJu0Yx7JJ2sR1FO/D9Bb7DTlCSpfRVZo25bCn8V9ZXYsRNaKAEqI4hT
 pD+B2LiRJVNKEWZ2L7Lj1J74G1YjgXXW5cgfuT1iIhn5EmqSRACrwiJ7z3Nb32hNqGhb1aPo7Jq
 rse0QjnqC
X-Gm-Gg: ASbGncu54PN3Vjt9yPnbt1MEEixzPsMzuq+AeEFEFfoXzfN7S7KaGk2ceizWDwhlOlA
 G1+GFJTyBr5M1xtxhsGDjWimsR0v8a2pUAucF50RkXfutyXplmEaxQX71zD+EHHKXd1rXa08vAr
 uq3Os2I/NHLW2bys//Mtaxk5wi3k95Yz/VpnIIKwAj839UyUmeHxagn4IMB7tojhlfftSfJTL2t
 gYzsSpdZo28UbNMeSeSUii+Iq/I03d80VrpBdb4rOtImkzTBTrB5NuozLmGcZkCgVJw6zFXZJtP
 nXXmuzq4bnFTZcx7WUqyY84zsJqUKsOV+mv1g7dv9HWk2GfkfZUC/MKl+Ov62v4Z8RL89q4yN19
 Pm9SB0wiSc20vYKpDuG9TB3OorviWG9eE1yFYTxVVJuu0onlSwVp0VJEIuQ17tGhJ8EDQv3XcwP
 68RJQG4aTOggeb
X-Google-Smtp-Source: AGHT+IE0LQAIsZCu6j5Qdn8HCSh5MlQ2d0egKfnqGzGTZXmf5cDOmsKO8hmb5ZyKOB5MJuaSc4fszg==
X-Received: by 2002:a05:6a20:42a3:b0:32a:91c6:e085 with SMTP id
 adf61e73a8af0-334a8504812mr17300178637.11.1760999906692; 
 Mon, 20 Oct 2025 15:38:26 -0700 (PDT)
Received: from sultan-box ([79.127.217.57]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a76b349b2sm8861349a12.23.2025.10.20.15.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 15:38:26 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:38:23 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
Message-ID: <aPa539qN_yjj8_a5@sultan-box>
References: <20251020223434.5977-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020223434.5977-1-mario.limonciello@amd.com>
X-Mailman-Approved-At: Tue, 21 Oct 2025 07:12:09 +0000
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

On Mon, Oct 20, 2025 at 05:34:34PM -0500, Mario Limonciello wrote:
> Adjusting the idle handler for DPM0 handling forgot a return statement
> which causes the system to not be able to enter s0i3.
> 
> Add the missing return statement.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Sultan Alsawaf <sultan@kerneltoast.com>
