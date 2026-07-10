Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18956C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 07:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F60310F7CD;
	Fri, 10 Jul 2026 07:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b0HZNLsJ";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D85410E130
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 07:04:24 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-489f3611e0cso365020b6e.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783667063; x=1784271863; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PNpUIB+yWBxGmrsO6ToHU/OY1f4TQqqjXVWxYss84FA=;
 b=b0HZNLsJXZhrSw+RhJM5KqyZxVKlkILKF+ezefUDbfaqxjBcfXngYFarnw+fEEZviB
 ZlOWVih6FbXVVHZOzDjaXJjY0pTLcGFxqec/X+wjRezXWuiF3uOStZV6K6tylPttFd76
 GFkMN4fB3IMnX/eKhz3hAZJ0SafjLmWk74/UA9JWF+e7RIgOzsdL0h0yPVMM1vJ1vheF
 e6/vYrX7qdMWaUS57rZT3Mx/gBdLTZQ1ZWu5iV4DChQIM/JK8IeFY+n1oikmcyp1Q0Tk
 0O1qPT8HVUba8JbeO/9Ut+uuMOMy6DH10+dI0pWc+4nuY4sVrEtwKK3BrDWPdknl7pIu
 JfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783667063; x=1784271863;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNpUIB+yWBxGmrsO6ToHU/OY1f4TQqqjXVWxYss84FA=;
 b=mz1JbPU1F8Py8PxoEoZP1dCvfOc8ENY4Wi4i3SxgniiSuiRy5yVpjIgzGyicMtkAhN
 bIDKnxyfaCLUjwlsZgymEUWUjBsLkAPWsMP3+DkEr8P0PY3OdTEBPB5s7elrQAVC2z2z
 CYCzob9Wd9Ilgoz0mTME+jKK9GI4k/DNaatCCU5Bq+iacjuTkHx7ngry3fUdCem2sp6r
 P19mYLepuUDgaQBKgj23+u3izr+YXQunjsIfcbulw8fTsxH7j81jrJ/oNDhtOzIRBvtL
 jwXDPunjUECFd3aiECerhZ33n3ybQo5+BAUy2MjHESZEUsfTnbiNFpBqST+6qCcU+QDc
 w8QQ==
X-Gm-Message-State: AOJu0YxILMPhsUnm5FllgSaC8HLUL0uV9rMzW1SmbQP2lT5lBzPH5yiH
 C0aKSpxqXRR1dNEzHUI0UmH17ad99cApCY5OfpPyqa9vZy6CkuZYORF5
X-Gm-Gg: AfdE7cmADyEB7/o7qu3u5wZ2vWM/7fOgOA1knDzq+d29IlU9Y0UzyYx82Dg4VjGnrGD
 zmeBnul3YZ/NRf8RChSmOcJBul9MpN0gyziZ0jgnYmEvgUm2mXIVQ3iP0csRnsWet+tlrZqJjp4
 Qp9s1AcMOI4PJq3l4OW+rRz9nAg7tianEw7Yu7VGCnDX5uq6jsoeBPi5/aaC9rjHU0JMOB5RYYJ
 fhDK/LXe6+16b3ssfVIUcvb6arZLTHggXK95H3j28n0ks/9THPRhLaD4w1f4pEANHylaEqnJ1xQ
 f3xJGjRgFe+RpscqAuwlOgX4rk5ZmDWJB64Y+oMLApMNv4gCgm+T5UCg+Szq3ovNG+zHBkBC4ip
 ruVw0FGDtBmwwLMQdi9zyxd5G0aZs/quUq1BwJK+foiX0PyTKCQgvUpbKkQ+ZO/FLOBLqvdOk1z
 G/HRN6
X-Received: by 2002:a05:6808:179f:b0:49e:d43f:1b8d with SMTP id
 5614622812f47-4a202fa9833mr9933489b6e.1.1783667063254; 
 Fri, 10 Jul 2026 00:04:23 -0700 (PDT)
Received: from localhost ([74.80.182.70]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1adca6bedsm5513802b6e.8.2026.07.10.00.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 00:04:21 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:04:15 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu/gfx9.4.3: add support for disabling kernel
 queues
Message-ID: <alCZb2hYNYr0lUmJ@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:19:09 +0000
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

Hello Alex Deucher,

Commit 832f0aa050ff ("drm/amdgpu/gfx9.4.3: add support for disabling
kernel queues") from May 27, 2026 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:2334 gfx_v9_4_3_set_userq_eop_interrupts()
	warn: count down condition reversed? 'm <= 0'

drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
    2287 static int gfx_v9_4_3_set_userq_eop_interrupts(struct amdgpu_device *adev,
    2288                                                bool enable)
    2289 {
    2290         int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
    2291         unsigned int irq_type;
    2292         int m, p, xcc_id, r;
    2293 
    2294         if (adev->gfx.disable_kq) {
    2295                 for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
    2296                         for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
    2297                                 for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
    2298                                         irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
    2299                                                 + (m * adev->gfx.mec.num_pipe_per_mec)
    2300                                                 + p;
    2301 
    2302                                         if (enable)
    2303                                                 r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
    2304                                                                    irq_type);
    2305                                         else
    2306                                                 r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
    2307                                                                    irq_type);
    2308                                         if (r) {
    2309                                                 if (!enable)
    2310                                                         return r;
    2311                                                 goto err_compute;
    2312                                         }
    2313                                 }
    2314                         }
    2315                 }
    2316         }
    2317 
    2318         return 0;
    2319 
    2320 err_compute:
    2321         for (p--; p >= 0; p--) {
    2322                 irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
    2323                         + (m * adev->gfx.mec.num_pipe_per_mec) + p;
    2324                 amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
    2325         }
    2326         for (m--; m >= 0; m--) {
    2327                 for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
    2328                         irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
    2329                                 + (m * adev->gfx.mec.num_pipe_per_mec) + p;
    2330                         amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
    2331                 }
    2332         }
    2333         for (xcc_id--; xcc_id >= 0; xcc_id--) {
--> 2334                 for (m = adev->gfx.mec.num_mec - 1; m <= 0; m--) {
                                                             ^^^^^^
This should probably be m >= 0?

    2335                         for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
    2336                                 irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
    2337                                         + (m * adev->gfx.mec.num_pipe_per_mec) + p;
    2338                                 amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
    2339                         }
    2340                 }
    2341         }
    2342 
    2343         return r;
    2344 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
