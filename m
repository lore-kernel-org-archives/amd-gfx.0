Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AD5D3B9BE
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 09:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D2210E259;
	Wed, 10 Dec 2025 09:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fHewf6gF";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5DB10E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 06:07:33 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so50573615e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Dec 2025 22:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765346852; x=1765951652; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ri822VzjYDr3Ifnp3sqU9vlVsIVum/589CYMOiJyV5c=;
 b=fHewf6gFdXhYNqvCKLBNkwEMT5Xsbp36Strlpeq4Tppx7H4HHT/vpLIgExFsl4YltO
 03pvv2T0hXmMeMYcKUwTsPupxTY/rUmP83x6hO5FLNcurXr2MSRoFMAudwvL8nnpXmKV
 m42Cdj772+XS30ScqR59GveajJrAYUFKSRFdYE02tO3f4bQ9eQu5N6Imm88upgCnVKXE
 vEVHWrwBdkEnQCISyzDmkylkUjsvxFMaxhh8RylVbcwj3ko6+UcLe7tFN9FAzkcLue3j
 QkzXHYi3UxPmwuSxex7GlGs4ZOtN7WphVxdxASKKuT7t1ErLduJIi+gpErTh3fMaHfSo
 gp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765346852; x=1765951652;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ri822VzjYDr3Ifnp3sqU9vlVsIVum/589CYMOiJyV5c=;
 b=XJRZoUDdNBotF6hDSvuRHK2GJ8eeApTZs8t+kdUOcZGj+Hv64x5EeSS4P58eBinoIT
 uIgt7AzMUsUnpsQ4QAPh3wK2c4pbd1+yfkGjT+I3YIrpKMCXpiD5SYhGhwemOxnfQh3q
 p830dpk0rQGTtUIZRGfm56s0TGwW6o0Z7ZBHL/9LQgyEeER1mbUKa8MviuuREdpNJAVr
 avP7crUtOsHrUfwC9iJvXtVoGSCWm9FPKebfl/1maB+++nQL37I0UeTrLHq4Ykdf3qeb
 xwacUC9RvGDc4i+SoBnDfFRR3DJCGcRok44++I4KRwRrWlqfQvk4gV09Sb3ypVWupD0u
 1tmA==
X-Gm-Message-State: AOJu0YyK+kUg0G7O0BDJfbvt0lwLYES9Z7DhSKDbtfkTIpuFXuUBGCUw
 FO2+lY6pt5ZC1QFe5Mi1Rhpu8XwJ56j+xZK8RVkzb5HsrOs08HEtHQDAxyvUmlKhWzM=
X-Gm-Gg: ASbGncu8pA2XrMG35GAe3nkhUjVHi4aKskWXfwRNRGqRinN0TE/m22xAvAxgGKFPX8V
 smFfLMVeX34irVZegxLwoMc/IBpXByKF5okr7OGWF35OzGkHO37Avv3U8XQgGcD2YmhesjV9YZB
 k0njdUr3EJSmjc4x6N2IU2EJHJxHH5tfz1notnlWk+q/q7RIZ9mLOIaxK/bdaOcXxY2Q3HnCXrG
 hvlHgoBvz8QXP7+8/0uuG8OItQK1ysPfvtO+UzjIgcVioLeUVKfpjL8gSxaLbzVgfuF93YOizg6
 hmPziLo6mGB2hZeYvSq6+n4UstvDA2dQiOvwDLLcRz3voThOUni3YwmheWALxiJYpSc9UQmxtDX
 0MT0MRzoR/sgAY/xVXcr9hniK0BWs5WdBPgKyVeSrnZD1zx1nhJzbu9vTHGvNj+ouTlQZBQuiAd
 0OMOUbSC/Tu2hjX6wn
X-Google-Smtp-Source: AGHT+IHVw/InySkeINSyoo9sjUmtR3HGssKhDJwtEACzPt1UMAMcr4AlVl1k+OkodnROET79ZS/8hQ==
X-Received: by 2002:a05:600c:1913:b0:479:3a87:208f with SMTP id
 5b1f17b1804b1-47a837a00dbmr9347425e9.36.1765346851428; 
 Tue, 09 Dec 2025 22:07:31 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d26f5asm25553365e9.5.2025.12.09.22.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 22:07:30 -0800 (PST)
Date: Wed, 10 Dec 2025 09:07:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jack Chang <jack.chang@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Refactor panel replay set dmub cmd flow
Message-ID: <aTkOH9pNfVCtNIR8@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 10 Dec 2025 09:16:53 +0000
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

Hello Jack Chang,

Commit 74ce00932e7e ("drm/amd/display: Refactor panel replay set dmub
cmd flow") from Sep 3, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:1459 edp_pr_get_state()
	warn: passing casted pointer 'state' to 'dc_wake_and_execute_gpint()' 64 vs 32.

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c
    1448 bool edp_pr_get_state(const struct dc_link *link, uint64_t *state)
                                                           ^^^^^^^^^^^^^^^

    1449 {
    1450         const struct dc  *dc = link->ctx->dc;
    1451         unsigned int panel_inst = 0;
    1452         uint32_t retry_count = 0;
    1453 
    1454         if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
    1455                 return false;
    1456 
    1457         do {
    1458                 // Send gpint command and wait for ack
--> 1459                 if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, panel_inst,
    1460                                                (uint32_t *)state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
                                                        ^^^^^^^^^^^^^^^^^

The dc_wake_and_execute_gpint() function doesn't take a u64, it takes
a u32.  It tries to initialize the state to zero at the start but
that's not going to work because of the type mismatch.  It suggests
that callers are allowed to pass uninitialized data to
edp_pr_get_state() but at present there are no callers so this is
only a bug in the code but doesn't affect runtime.

    1461                         // Return invalid state when GPINT times out
    1462                         *state = PR_STATE_INVALID;
    1463                 }
    1464         } while (++retry_count <= 1000 && *state == PR_STATE_INVALID);
    1465 
    1466         // Assert if max retry hit
    1467         if (retry_count >= 1000 && *state == PR_STATE_INVALID) {
    1468                 ASSERT(0);
    1469                 /* To-do: Add retry fail log */
    1470         }
    1471 
    1472         return true;
    1473 }

regards,
dan carpenter
