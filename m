Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA2CD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB67810E30B;
	Mon, 18 May 2026 14:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QhDjYmUM";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3286C10E31C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:26:36 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2f16c892babso103204eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114395; cv=none;
 d=google.com; s=arc-20240605;
 b=DEw/8/46eeSC4LRNwe1qJWx4aRzA2TElyuIc+MRqx9ZAF4pXgygVqs/52L4EZ0rT/W
 8div6c2g9nXE+uu6uE9jfyF3qa9WbiHTnJbBFdboJF4Ojht6NI5x38PELQh2czaAY5G+
 EGlMyaHKunl90ap0Fp/IEJzsNHuxK4zB9G0csxYQMhqlOGizzUqpLABK25XB3k9rftBI
 Vf3KJFqQW8W8ut94OqKW6IqEmAAJ/TWoUZREu5Pr7zRrcb4pxqyl6ScLkjsnV0RtlStg
 zucW4VmGOPerz0w/JrG+JJyFoB3Ie/RI7vCU9gIoMZS1v5/hYjf7g/YHKcXF/6lquQUj
 a5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E9ePutv8hI9TYI8G2iFJXpmM8At0fz3YEO455yV6PBM=;
 fh=8LiGOm1a7bQ8ToghhMxBM07lVrF6/1bJZSwOujKbRjs=;
 b=i2bpmcHhxQ4elwe4AUaHMqUOAOO8MSTLeTgA1nY7dZoc3DMWtmXnzXuLHC0aR2JrUR
 kE8qyGnPx2PpiNsFM6gQuLSLhlHn+r5mIYh3Z5hAOMRs3R3LFlUjRv6z1Vv0jJ6+Ke+l
 cm3RdARoPXEDdhhp7uJwF6sVBJj2DoqgegCX7smraO6Vzlo98cjaOYx/nrk12k5RmI/b
 lmjb5J5UzCitlehMwFR6fKkT6F/YjV5ySyphoGPJnpia/OtwlS2g106mY7mDc+Rd6PEr
 ldY0LUv5rDWK81HDaMs19bRN7CE4zztgEKJcss2yMM4vQtDNY/LTkVeaIfAv+61r0yqG
 J33w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779114395; x=1779719195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9ePutv8hI9TYI8G2iFJXpmM8At0fz3YEO455yV6PBM=;
 b=QhDjYmUM5/FkqxjjNCRdxyqIHpBG0fFUzem025ijL6yEvfw3ybSHWJz+OcAy1yEI1Z
 2rEyFkAs2w0113Dpq3pNG/MZk+m5mD0FT5NILUUc4XvrtzPCPTAS1AAzmcMk0mhtvcsX
 5uyGgfUS9KAdh1GAhvFIvCBRWLfCCiGIyvUHxo5wwp20WV0B5G5F6m1lAkBt+OpuPuXq
 pxYldm9KJDWAvQWxKdfr9g2hASMnEPAQ0GPOSL7ugm4EvAPNiUKmCg/Di3Rq6pjnQT0s
 Nm6NP4LZJr7r8Dwsf2fTMPNO93c1k5Ebyg3T3yD9XWZrmwrjD9UyB9BGh7RjxhPIUP3q
 KcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114395; x=1779719195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E9ePutv8hI9TYI8G2iFJXpmM8At0fz3YEO455yV6PBM=;
 b=hixLoeM6KKa4jKu1AiMre0lyjnePPvENWde5vd9+xO2JjtTKto0AJfLaiNcO84c64v
 wQobntrT7IOUInfU6VxX+ZJ2GfdWhlm67LNZ060W0UJm2UzM4cqiQjxkP/sazavnC11x
 f/X/EyshuLr++L0gCEX94g9hXQ5/a4z0AUpIaIHrujCJyvWloLH5djW4ZZ3Qdka36+8d
 AB1xzshWfwBPSl0V4yleoByoRhBaRmHEKqtO92tXGatELlYe1B68swj5iPMgiFio99ui
 T46u0A09gJgGwd6NnodVWpuXBx9b0Tisn19gojTxh8WxfUoCFecJtzGHzziZRY2d6Mur
 Gj9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dNWDoEkTepzMqTENSD1sVecyqDguL5enUa52v+cdWOEnSDsUUKsTepdTyM35NH3UR3z//B29T@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEOTMQ7vTH22sZk9qyDpJdj9dt18vaE/A1LZVuVDBOn4yWtaO2
 jFJSqlxey0pa/Ysi9sZZWAYQVCnxeKvw/blKrZNINA8Y1akzuSleHvO0jRZJbsf62wHhoD2MY2r
 VosHAARwXDj2nd/NTz7pkW0yGOrIvY+U=
X-Gm-Gg: Acq92OFtVwTaXkhKcGrV55EgdtVQ3bw65JMIirKGBt/Nxivh3xO9f/V3IS8xx6RkqOy
 ZTk1vsu/kMj7MQrINQW4C6sOodN5efJruuG0/LyjqnFuL+DWpmtnPWGxhjMahPyrhbNAhP4aDjf
 ttaZSvbNEN1omGpx8t7KQodMRsZUhx8Wp8m/EYv8NTQEkAhIFW+W+2MILokYIe9ZjOx86jGNkze
 gfSLXWNLDNiXbX9AlDZYPakS26CukSjkeNnrmXbFPAZuDiwsWsyTVnNo2jIcTyyqPckpXKru8gA
 e6t3Dy7JFCNRB17QpJEeCp1uQ7Hf+zzZRoAus/yao/bD5Bk5hzE+aTdVUMuL0NO08xzhDg==
X-Received: by 2002:a05:7022:2507:b0:12b:f616:1a31 with SMTP id
 a92af1059eb24-1350494fe45mr2848035c88.6.1779114395331; Mon, 18 May 2026
 07:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260514103815.190628-1-marco.crivellari@suse.com>
 <20260514103815.190628-3-marco.crivellari@suse.com>
In-Reply-To: <20260514103815.190628-3-marco.crivellari@suse.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:26:22 -0400
X-Gm-Features: AVHnY4JdeStjA0W-g_sbQQfxFYHywAp-4OmUxt9niF4OTbAXFonBkSs6wkLrJlU
Message-ID: <CADnq5_OZG_vsEuUWgTPJtz-4zf4s=bA9Q_r9-w+KMQVa4RkMzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Replace use of system_unbound_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 14, 2026 at 7:04=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> This patch continues the effort to refactor workqueue APIs, which has beg=
un
> with the changes introducing new workqueues and a new alloc_workqueue fla=
g:
>
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The point of the refactoring is to eventually alter the default behavior =
of
> workqueues to become unbound by default so that their workload placement =
is
> optimized by the scheduler.
>
> Before that to happen, workqueue users must be converted to the better na=
med
> new workqueues with no intended behaviour changes:
>
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
>
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can b=
e
> removed in the future.
>
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied the series.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index d386bc775d03..0811593fca7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -586,7 +586,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>          */
>         adev->coredump =3D coredump;
>         /* Kick off coredump formatting to a worker thread. */
> -       queue_work(system_unbound_wq, &adev->coredump_work);
> +       queue_work(system_dfl_wq, &adev->coredump_work);
>
>         drm_info(dev, "AMDGPU device coredump file has been created\n");
>         drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredum=
p/data\n",
> --
> 2.54.0
>
