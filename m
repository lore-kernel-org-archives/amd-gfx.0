Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB14C5B559
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 08:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3159110E6CC;
	Tue,  3 Jun 2025 08:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H70i6qe5";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6786710E16C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 12:22:44 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so9634145e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jun 2025 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748866963; x=1749471763; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kpRv4sjfHKTvuPnSVgXcrP/mwberr0dX9jL8T1PNq18=;
 b=H70i6qe5NJIaU/5riYRDLCT9G1S+XfgoPMP62an459oDeqBLhJK3aA5T7frKeSm8FS
 Gm0sHZryvDVYzAeERx3WfNmw3/tvKB84VBRCMNLCnea1TLiREAb59/+QFgxjCOWbxHv+
 i9TGQQo59QevecJrnttZDRIgwq+Q9nI2EofwVaGU0qk/6ovanPP3VzRRaHLpgC+b+XmI
 GliSUZAnh9lCpU9E3QbKVI02ckWsbni1gZJtg3shJyMHcvO+GAED3c+4Fp1HfGz19yi9
 dkynlFBlGUXPD7t6/gptJkZfzwRqBaQ2ggdNHzrXvkPQzB4RjIVFMvwlxUT4OXchSz+q
 m9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748866963; x=1749471763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpRv4sjfHKTvuPnSVgXcrP/mwberr0dX9jL8T1PNq18=;
 b=SbZ+8N0MakkJJg3nH0mNMeduxoMgSGzPzDpmXCPXV0UPx9o16/QJFJzbuhvOVZofMl
 y7DqKTzpCjUZP8cUW6RPJDrtfw9NxMy8nBOZqBP4o6Ry2Wg122ijtIKjE720dr6SDVij
 yu8GknM2vfdPl0TqpMfjpJJ/JfDy08S972Sj9V8zTnTCsVNHgeOAs57Nu8Hk6pnTzTBi
 tpaky8wqeaPTbzwXsU+vApJ89A7BzIlGIW+MuZMsVxk2K/d2VsqQHCX4xGgZ4OJ/CuKg
 3KVYHkee9LBkJO6Bb71r4t2FEIyHAGimMfE2xJTp3HuCEWoAPX07pHWeeKzIZ43gP+7w
 IeWQ==
X-Gm-Message-State: AOJu0YxVHwgdNrs1JFaGGqo9hlHE+EKWHcnI7IRJqoD9gDpdZD0e1qoZ
 v2PEQCnMNKDypbKo2PpLsCSmIUP7SSIZbG609urrOkipPrfJFGcuaQFA
X-Gm-Gg: ASbGncvL4PKzBCRpf9wpPadGatJw5svN3Kwp7E3hnEWlhYI03l9Qdo6GKF8aT0Ip5Xt
 HbmK+4aeC1d9sbTRa7+5caYLhfBj3pcJpdEG605R5524/Hm3/mZghvr4mb60Q6hrT45M9Jn2/Qy
 p8fIfqaKFUtZebNmI6dqpVP3rZKrTkGKWGlVsBe3Bvv73boappdNFIRY2ojFRg0fFT7tkeU/Gyg
 ddlnK1Pwt4PiNGM+xzWrnj0DeXSbKCpZ8cy/nRCljrYvzC8SPcNpjOvHDMtjd+3l+qeFbAMeVZW
 g5X0Ri3N2lY7wVtikIE6482PI9NwcONAQ0AMT+gGIlQCt4ainOD7B318eTpENTiW
X-Google-Smtp-Source: AGHT+IHohmnGp+3O3v4KD6SwbpDSVf/AVhYLSeKh+AGUWHTFvG6BkkGzkCa4PFB+vqA+ik/2DZOAaA==
X-Received: by 2002:a05:6000:2512:b0:3a4:e841:ee6f with SMTP id
 ffacd0b85a97d-3a4fe17b248mr6414494f8f.24.1748866962734; 
 Mon, 02 Jun 2025 05:22:42 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:eaf:3101:2d68:caee:7294:3fe1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451df07ac73sm20370905e9.9.2025.06.02.05.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 05:22:42 -0700 (PDT)
Date: Mon, 2 Jun 2025 13:22:40 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 0/3] Handle aborted suspend better
Message-ID: <aD2XkPjk6OfEDz2-@debian.local>
References: <20250602014432.3538345-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602014432.3538345-1-superm1@kernel.org>
X-Mailman-Approved-At: Tue, 03 Jun 2025 08:18:53 +0000
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

On Sun, Jun 01, 2025 at 08:44:29PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Chris Bainbridge reported some list corruption occurring around the
> suspend sequence when an aborted suspend occurs.
> 
> I couldn't reproduce this specific problem, but when I tried I found
> some other issues where the cached DM state isn't properly destroyed.
> 
> This is because there isn't a complete() callback to match the prepare()
> callback used by amdgpu. Normally the PM core will call complete() after
> every suspend attempt (succesful or not).
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4280
> 
> Mario Limonciello (3):
>   drm/amd: Add support for a complete pmops action
>   drm/amd/display: Stop storing failures into adev->dm.cached_state
>   drm/amd/display: Destroy cached state in complete() callback
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  22 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 125 +++++++++++-------
>  drivers/gpu/drm/amd/include/amd_shared.h      |   1 +
>  5 files changed, 103 insertions(+), 48 deletions(-)
> 
> -- 
> 2.43.0
> 

I tested with 30 suspends and the dm_prepare_suspend /
amdgpu_device_prepare error did not appear. The list corruption error
remain but that bisects to:

aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children").

I applied your patch series to the parent of that commit, tested, and
there were no errors. So this issue looks fixed but the other issue
remains, email sent: https://lore.kernel.org/all/aD2U3VIhf8vDkl09@debian.local/
