Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754A606A327
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bzk8Uyyx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB8710E576;
	Mon,  2 Nov 2026 08:06:53 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0971F10E45B
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Nov 2026 20:05:46 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3ab1bfd11f9so1994021fa.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Nov 2026 12:05:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793563544; cv=none;
 d=google.com; s=arc-20260327;
 b=bVWw/5OlP5MUqoORPJ7N28T5aMgLKtB8ranonh3bIubpCBL69IJ57Y1m/TZoQ57OlB
 FYOdQRjjkeirmy99iUR9y+bYDViMJaaiCaCuLcYgTjztisOyNLLMw7D2keZ6Ldp4ZUTE
 /+X1qvnU5vbMAHGVl1caSIigjRKIWioERgxEc5HAmSZDxfQA6MQx5qd3NbGH3/w6x8hH
 XKxPXiZ64FmKb7tYLCVdHG+GQ6gMNkCZpH1vV4U1SiH3QHxN+CGaJKrtXYVYyyEGig3x
 LanfbV9FyFszYOck6BylngwWohULV8DIcMx3PDYuCV41yaxdzNOtWuC0f0rq+RFBcf/I
 dNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=krh4+OoKKCXqNnJY5U556Q+DBROKCm2TWkvzeauItoA=;
 fh=SlT7rtRrqODLZyWKd9yBIFcXroR43G1WlaFIcNpLNTg=;
 b=iCs+x2sQa1vrQkKW7UkPvFKcZ57b+H99QH43iIGkwrcYyJSzHdG+6oRQeFU25Kj/q4
 7nBqylJO0c6FLA0Rj5VjuT8D2M+rh1PY5qErCS6znVvO1BD5GQM7LNU893cjH0oDNNvM
 /cA355++DTBOLEx+YGcEIABI+1ZbNqTZBa6W3fsDYe5aQMWVtuKHWVXlLaOyOh659Qwk
 Yn6lYGEebR/YxCjS6n5+qa0G8E5nvKW1GAWi5nzqsRofr8HzrPqxErGu4whcmtlllv1H
 4AMK5ZfmpMWfzEocurnUsleYnU1DBlUu/bhsshON3x3gd+wA5Bopjva0M3mhYyqH35Ot
 JEZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793563544; x=1794168344; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=krh4+OoKKCXqNnJY5U556Q+DBROKCm2TWkvzeauItoA=;
 b=Bzk8UyyxkmHdm0NHNY5GfRQ9JuBnpWpQgCm5uBMj7TAmRSvkdngtgFTo8xzl5e0Yjv
 R6yRntNgr+vkD8s5T030gNEeYQ3v6cmqa6N9fLkhip6LLPWNGTO5wkggqfeLK4yscyD9
 bFikNeadpcGZZSKPK0/iO5PK/fnAYJ370tRp0w6r8K0u2SGMcTpdJpWG5LR2mApzInNk
 PpiOcy46PXd0sm5eo/hCcoR4Y44W/bxriyKUDUjBcyMBbAq6FvEQrKGbtSmWRWIiNF1P
 wf5BCxCSNW3at2tRPWP4ByRgxVwm7fcwwAs6K8Ajx7suBja2ww8nXf29pXamNquv4+KR
 akuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793563544; x=1794168344;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=krh4+OoKKCXqNnJY5U556Q+DBROKCm2TWkvzeauItoA=;
 b=KtsoGjMpaCH+xcEJdCHsioUOcNfvZMTck/G952wvGxNj3lQHd/shv42SsN68HDnDAC
 FYl+Ccn4tW4aII+t4gUh2eJQaz/R2BGbL+XEAxx6vezDXAo9AKnvICI+NiO4VqQYFx76
 JTcNnWPy7vBhOBc3/hJxZLN97JEm94vhPyWQfBLyAieQT2Gb6gqzQeHsAbsO3A63KSue
 WRuPxW1n8begixlhlJtCt7VTf8En+1Hrr2cBJ3qI1v0ULL/uLUceLJ+B/Kn+fjS3bF9L
 fcmXDY62A28lV/M85xHyPBSJHQk67vWqJqxULKnAs3wUwu0AH/Lw9mdw//4Be05Sg9Ho
 a3vQ==
X-Gm-Message-State: APuU4Z+E/4Fk4LEEFWFtudhfJv6vNp+s9L5EcYhiKbGsxIBXeOewEaf7
 51IkW9ssbdQVgPOTFcplPFCkgyvPFQ088YSHPJUlsiHVkU1O4NoDgVrEp6O0hrK2WKmdlvx97D1
 KIC6/HQz2atama4qYhrpehPS9+VKKLjCwVw3E
X-Gm-Gg: AYBFou3rLc08Obz/ktSHHZKfjMTID5iiBDZDlmfQVojQOlOB7PIAkXwUYwOihwwiord
 FaDnkvFdiU1KE4ioJvFDGCmv1DMLjXz9+3jbfv4agQhioq7p4pQKddy6z4xDjY06nJ78Mcx1E95
 28e0ECb5ofFDw7XTIAb6HB6jypj/wA4e0iKlNh45vQAqu/VxKXowOTbAKGlC4vC9iRaCU60ohhn
 KbDEcu5x4sY7A3ASiBe2x1G1aVJ6b2DYBmSbLVln5QHX8TYVQ0CCYKGyOmNxC5DvpKYQvHZfjQ7
 ygrtPO+1H43+vWpEfSC9Cap+sQN4JjlqqDgCNd7lhg493QKBd6jLxYoVgf8fExswm56r56Z/PE5
 geATCMasPHq23Q5ZasdF6kHvzpH+6d1IGZ/E7ODShhTd5Fj4RphK8uyS8xk+ISPblCuVnOfD906
 IEMi5/F+UPrvGoiKtVZcop4YZ54uOJCRtePnGF5LE=
X-Received: by 2002:a05:651c:435a:10b0:3ac:b2df:c518 with SMTP id
 38308e7fff4ca-3acb788bd42mr13845031fa.0.1793563543902; Sun, 01 Nov 2026
 12:05:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Nathan Blomquist <nblomquist@gmail.com>
Date: Sun, 1 Nov 2026 15:05:32 -0500
X-Gm-Features: AclHuK-cGdQD9fLfRHMjBN8yhdOQqn7YylAdQSjHpyU0SL6gVHBUJ857D77rcnc
Message-ID: <CACOV87VBmya0PKjni5xEYxUaEczk9X_UoUHXSR_HDS2kSJnM2g@mail.gmail.com>
Subject: [REGRESSION] amdgpu: Navi 23 passthrough fails after ef5fcf2a6c32
To: amd-gfx@lists.freedesktop.org
Cc: regressions@lists.linux.dev, alexander.deucher@amd.com, 
 christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I can reproduce a Navi 23 / RX 6600 (1002:73ff) passthrough failure on
unmodified upstream Linux 7.2.10. It happens during the amdgpu-to-VFIO
handoff, before any guest code runs.

Revert/add-back tests on Proxmox kernels isolate ef5fcf2a6c32
("drm/amdgpu: fix autosuspend cleanup during removal") as the trigger.
Removing its added call from -20 works; adding it to working -19 fails.

Tracing shows amdgpu_device_baco_exit() returning -ENOTSUPP (-524)
during runtime resume: the live BACO feature reports supported but
not enabled. The exit sequence is skipped, and a later bus reset
leaves both graphics and audio inaccessible.

The candidate below keeps the autosuspend cleanup and allows the exit
based on the selected runtime mode. In two clean baseline/candidate
build pairs on upstream 7.2.10, the baseline fails and the candidate
restores reset recovery and guest graphics/audio initialization.
Sustained rendering and repeated-reset stability are not yet tested.

Is the selected runtime mode the right condition to use here?

Full report:
https://gitlab.freedesktop.org/drm/amd/-/work_items/6076

#regzbot introduced: ef5fcf2a6c320676bf8be2dadac93d9023b468b7

Candidate patch:

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6412,8 +6412,16 @@
 {
        struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
        int ret = 0;
-
-       if (!amdgpu_device_supports_baco(adev))
+       bool runtime_baco = adev->in_runpm &&
+               (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO ||
+                adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO);
+
+       /*
+        * Runtime PM selected BACO while the device was active. Firmware can
+        * clear the live feature bit during D3, but the matching exit sequence
+        * must still run to restore the runtime D3 policy.
+        */
+       if (!runtime_baco && !amdgpu_device_supports_baco(adev))
                return -ENOTSUPP;

        ret = amdgpu_dpm_baco_exit(adev);

Thanks,
Nathan
