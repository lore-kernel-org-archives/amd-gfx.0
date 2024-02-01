Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A2DC4828D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 14:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAC510EE60;
	Thu,  1 Feb 2024 14:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bsCyB5Yb";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6403210EE3D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 14:04:02 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-55f19a3ca7aso3975745a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Feb 2024 06:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706796240; x=1707401040; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rFDVRJNBRsaRzHz9IblUYxmWZQpYsWhtku96dG0sauo=;
 b=bsCyB5Yb5uUWiQvt3JlG0nq0r/HMf+Ph8cOlCGiIeLsoF2CyFUH0ARxSFS+NZ+/htb
 naDV1Nq9UPHw2aIJwlilUEBw1FonxzXn2pypymllzrZAN9lnN8WCYkJX93y0I3d1jvor
 KQL6oIaScD7W+k43wofRGE2UALSwNR+HDQGdpr2v1At3mmKJ0LegJCz9ov7bxfmAptR1
 hoxBomLoWOPfSwd5i7rZZOSRSNHMxRVNCkScgcqbF/s8LxPlqioTC0JtWwN1X/R8389f
 ybTxjjUyPOxwHUWlYqWXmBhS4XBVNzlI05adb1FD8dp+r6dLcPgF39ZqcfW29A2EMRFF
 UkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796240; x=1707401040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFDVRJNBRsaRzHz9IblUYxmWZQpYsWhtku96dG0sauo=;
 b=fWT6tIRJh33QNgBJJVcj4uR+MRAy/R0yIkNJxx/jvV9j6ys+O9Os1wMUb0ubpZE7yv
 KzCMebvXZOAJUM/KdXWRKSJWHIovWz8Q6sdfLpu3dGLG/4rRgp2gOy01Vc3WrPolQfn4
 9G6q3IXBrzi+I7MKtGzi2oD7syl38Yxzy+d030g7ho7FfwAzL5SUS1lnrmcbkShpZ5sd
 /B2s2z+I69rEay/XfzQXGvmYVViSriia5Uu5htFdmo3Lz7BynCgbWH0j648QM4metg9r
 QFyt1MVu8Z14RXRTNTaZirZL0EiQqiy+dh2IweNLqsngGO6TkK2Swqr6ORNLYDGJI0JI
 KveQ==
X-Gm-Message-State: AOJu0YwhkYO8sk2HxLXlKAxjiwCFlxwOJCZgQtH0Ygwxog3ahTVJ+WaT
 7Z50Sb13VaxljHHDD9GIgRVe13IKF7nRzh/lDi63XMpcYG5qPQEQ1QNGCNerirw=
X-Google-Smtp-Source: AGHT+IHyEVnbywVMnW3si6EXMTH7Lpq1yKcsKHLU5Gbz02t3cBtlm1g85oXrlv8j+qWlMftyIMLtWg==
X-Received: by 2002:a17:906:b0e:b0:a36:804c:ee36 with SMTP id
 u14-20020a1709060b0e00b00a36804cee36mr4369087ejg.0.1706796240598; 
 Thu, 01 Feb 2024 06:04:00 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU6eoCsEEn/9JLw+iUVSKKFvE44QNeaUaSRsGdlxvooufJ9lGGhqkohOwR430FVWZynk1rUTMJDylWL+GaFw9DWofgiIll4OdA=
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 vk6-20020a170907cbc600b00a36cd7bb2casm419168ejc.120.2024.02.01.06.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 06:03:59 -0800 (PST)
Date: Thu, 1 Feb 2024 17:03:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [bug report] drm/amd/display: Simplify the per-CPU usage.
Message-ID: <e2de2a0c-8e02-44a1-bdfb-403e7b91b64f@moroto.mountain>
References: <e31dedcc-1aa8-4430-a2f5-9e37ca25410f@moroto.mountain>
 <20240201135342.4dhm3bWG@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201135342.4dhm3bWG@linutronix.de>
X-Mailman-Approved-At: Thu, 01 Feb 2024 14:17:33 +0000
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

On Thu, Feb 01, 2024 at 02:53:42PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-02-01 15:18:04 [+0300], Dan Carpenter wrote:
> > Hello Sebastian Andrzej Siewior,
> Hi Dan,
> 
> > The patch de5e73dc6baf: "drm/amd/display: Simplify the per-CPU
> > usage." from Sep 21, 2023 (linux-next), leads to the following Smatch
> > static checker warning:
> 
> Did I introduce that or has it been made visible?
> That change adds preempt_disable() to DC_FP_START() but this was there
> already, just hidden. For x86 it is done within kernel_fpu_begin().
> 

Sorry, yeah, the bug was there before.  I don't know why this shows up
as a new warning.  Probably it's because AMD driver files were renamed...
Smatch parses kernel_fpu_begin() correctly and sees the preempt_disable()
but I didn't know it disables preemption so it's likely human error on
my part.

regards,
dan carpenter

