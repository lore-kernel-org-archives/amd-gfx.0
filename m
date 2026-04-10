Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A338EBFD10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 08:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BBB10E35C;
	Mon, 13 Apr 2026 08:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b6BYKUZr";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E69110E9E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 18:04:10 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so16794655e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775844249; x=1776449049; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9l/oix7dnYVXzfahKGR2Cy0MP70M99Q53kRWCfw0mow=;
 b=b6BYKUZrXt3hKCTly79qv3A6die8BH23OTSh4hHfLX5eI/OQ1s+bA9uo+y836Z498k
 UdgJ/Q8zmLx/p7eURr0TnR+yFHHqJVOempMztGW1jq+WvY+CHiqDw8e578JVt9aKX6kI
 BFGs+6iaqwP3vAGL8j9ZojT9fc/D75rE4mB8xQboGemZlOWO8P5JeKiFUgfzkxIdT1mQ
 gtfCu2iQjwrnIh9t+INB3Kc/YW9Mvh+4tLEe363iIAZwp4UpQW7tGp3/+9jasMUHXuDb
 3TyD4sw9jnOfW5PNYVugCVmS9zT1GUvycSaKWh/ykQe8ym9JOy39QxCiHCRMeYJOn7Bd
 0rGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775844249; x=1776449049;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9l/oix7dnYVXzfahKGR2Cy0MP70M99Q53kRWCfw0mow=;
 b=U6wDsZ64GxjKSOlCmLUjvPxsw13dOn8/ow0rqlbLKcRta794tfJlwd0jr6aMBzAJYG
 BIlJnOCXqVL7C6GKlXFbNJtpfUvdAy7uy8q5AI3F9rcLgE4aApGr2dv46oqxHTZO9pV+
 G5Lrb6h8f/fraxp2Rsy0WgrCl1HTcPAaLHFxpvfrpwoSCgJ9Xb1PBFULXS+bthBRHM2s
 S6cnQZe6xk5tGCl2CeZ3XhDr8Ymwei6TNfuezq8ywPWfOShzvPQOkdXq4a2JvSiPL5jd
 sUlTu43aU0SckAHnMW6YRaUydaynWlnaR4L9KOvyK47IcCD32fzhcMO4Loj2Ax+o5M96
 0wkg==
X-Gm-Message-State: AOJu0YxQ/RJizuy82UCdYWpQvY9fH8pWQExWFDUiNFYjPt/7/uLcaMYn
 XFExUN+9uEpzHrBnjBxqdavW/gaPkMJY9dS9yYzYg5CgiNbWO9kGrn+c
X-Gm-Gg: AeBDietJIJ7bAA/+v+TkcX8DAH13pHFh62Tnzo6b+mG5pARJA9eDTQ/KHC4ZvE+l0vE
 lxAmi5Dzv8PcGTgMq4nYQ+T2XGpTvnLMrrCF3+bLwwIkRFX7UqbGPdgTsz9CAsX7cW8AGgHEWQ0
 y801eSKLM2/FJc4mhCE4mtXY8zfyjfmvaJuZRVdToJSS/NBNYTyqEKg2EuwbMarI5r3Slscq34b
 71Fc6wAuQES3wzWkO6YwbXJlif6ygCctJzNBaa0CRObSOOy4izAvRFlPKVRTCH3CAFTAwd0Kw3m
 kTHPSueL5Go6h30XX/sUgyDiumUqcZYNLpvGLnOVEU7aY8OecKtAueIVv6UIpGtkTI9jGXLzCMh
 8kzsePjG/UqfANmPCq289XDH4ZlAf/37/RDAkgRiXms8AkVt5CP6vP+ce5+y2mjak/AWNgQdr+S
 VhCbOAdSoaPaCl7SR7ots=
X-Received: by 2002:a05:600c:5487:b0:488:ae26:435e with SMTP id
 5b1f17b1804b1-488d683d4f0mr52241845e9.16.1775844248944; 
 Fri, 10 Apr 2026 11:04:08 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d533e596sm93964575e9.6.2026.04.10.11.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 11:04:08 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:04:05 +0300
From: Dan Carpenter <error27@gmail.com>
To: Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Move FPU Guards From DML To DC - Part 1
Message-ID: <adk7lVaJt_bX9LCs@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:02:59 +0000
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

Hello Rafal Ostrowski,

Commit 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC
- Part 1") from Feb 24, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml2_wrapper_fpu.c:558 dml2_destroy()
	warn: sleeping in atomic context

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml2_wrapper_fpu.c
    551 void dml2_destroy(struct dml2_context *dml2)
    552 {
    553         if (!dml2)
    554                 return;
    555 
    556         if (dml2->architecture == dml2_architecture_21)
    557                 dml21_destroy(dml2);
--> 558         vfree(dml2);

vfree() is a sleeping function (unless we're in an interrupt).

    559 }

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c   380  static void dc_state_free(struct kref *kref)
   381  {
   382          struct dc_state *state = container_of(kref, struct dc_state, refcount);
   383  
   384          dc_state_destruct(state);
   385  
   386  #ifdef CONFIG_DRM_AMD_DC_FP
   387          DC_FP_START();
                ^^^^^^^^^^^^^
The patch adds this, which disables preemption

   388          dml2_destroy(state->bw_ctx.dml2);
   389          state->bw_ctx.dml2 = 0;
   390  
   391          dml2_destroy(state->bw_ctx.dml2_dc_power_source);
   392          state->bw_ctx.dml2_dc_power_source = 0;
   393          DC_FP_END();
   394  #endif
   395  
   396          kvfree(state);
   397  }


This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
