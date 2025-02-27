Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CD7C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE2B10E244;
	Thu, 27 Feb 2025 15:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VPGHWaoR";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9870910E286
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:31:46 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fea8d8c2f1so170920a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740670306; x=1741275106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mfoCKe+YBC5fgAzxVTWJ0cscYaccE9ZurDgpHfZPMo=;
 b=VPGHWaoRkkixHvzdBx7cBQaDGHHEeB7yLvoIFU4xjWeYEe8MrRzMZW9j931NHKbV7Z
 1vjIynGLqHk6zt+lKr21zm5oANpTcb0QFAW4R3gIBTYGg6ooZCk2yZXpJUTiBbLfPWjA
 vG5zBS4Fifff5yHzsPDh3BtIqA/kAc1EEFDVS5VimE4V+n+VNHBRdDdWJU657Q/2o9Ve
 oiMOhZDqI6WD8tzXjAaBzJou/JqEJjUinVjsQTJ/HJljuzQ2Lp8DE2ue+m/QPZYOFwG+
 s3CmYlRcG8CX+RwlRZcY+2fQBAM4nXozjEYCIv1kTZAD/XEn7eHA4dthDqYsFX0+h/lU
 qgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740670306; x=1741275106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mfoCKe+YBC5fgAzxVTWJ0cscYaccE9ZurDgpHfZPMo=;
 b=WiDOm+BeslJSQYaRLbbpv+9mOJgLOlbwd3vZHk4/4k6gZgbU62RZ2WpBfgXfzJfoDI
 x8AKuH7KIemH6I2APla/sIk+kKSmrJkQqZW3xfoWP8HrQk0hOSL1z9adv87pS9P0dh2m
 Id+/kCb5Z2ncK1YG9GJjJnaiamQfRpWZCJBfkH54yJU7I4lBvtHx6C7E8cv6RQb970Zu
 W0r30Le4nhtheJz3yMr7FZMHKmaKaYhva+D5EQD7E92LrP784zRiI73bHPr6EllgM4RX
 I8uhQGtnmz8cI1DYYzX3OSsEAcd1Ja5D9u+S/OJTqAc+EBih7KqeRSiTTkPh7tQhaXZM
 sDAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDdrQ1bgKo74FbEo7TudFIfx2SVIdq1TABwQYNwrmXiQjJzHUvM9y/BvW2CapwqrPqz8JxNBF7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTB9w0v65GOxC6EklXhQviIR2LuC/7uJ5yCpVGMGxEvfsM+1uL
 KavDgHPrlwaSBLvOBBiEmkL9RVDPWuNiyAnrdi4y0XHscD4vV457sekmx+qKdHkOKKCpmagfYUj
 Jmnd+PDtUJEfSDnCk93EBkDMNoA4=
X-Gm-Gg: ASbGncsqkCZYi2MmdgraJA1u/cKHPRUYOJ6vkVDhK9/tIzbSe935z4oM8VXyuDZ+L2x
 Tux9DVuIbUFyhf2Op4MpLGoDyNWqLLoNsMjvvARF5dqz/equfOLjbrUy9ubQsakpWNC2K9j3sbz
 +iRuRisjY=
X-Google-Smtp-Source: AGHT+IFDPTzgGWnK040dFY+yXwePpApw9fBF8BvsPgm+yGOdN74SFnSvoBCkaOlZmvO26gsepxFy2z3ooq8AIX9W1/E=
X-Received: by 2002:a17:90b:3848:b0:2ee:6d73:7ae6 with SMTP id
 98e67ed59e1d1-2fce7b6adcamr15322348a91.7.1740670306053; Thu, 27 Feb 2025
 07:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20250226015138.2441786-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250226015138.2441786-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 10:31:34 -0500
X-Gm-Features: AQ5f1JqDQjw2KiIBUqM4JjB_5Y_bmBCVF6iTmPHjK7NQCzX_pPkhJed3tIhqEM8
Message-ID: <CADnq5_MNkKHwu53Eeo31v296dOeyOq7=GWEa5PZVBXQjxVdKhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix parameter annotation in vcn_v5_0_0_is_idle
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Feb 25, 2025 at 8:52=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Update parameter description in the vcn_v5_0_0_is_idle function
>
> Fixes the below with gcc W=3D1:
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1231: warning: Function parameter=
 or struct member 'ip_block' not described in 'vcn_v5_0_0_is_idle'
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1231: warning: Excess function pa=
rameter 'handle' description in 'vcn_v5_0_0_is_idle'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index e07b500235b5..d99d05f42f1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1223,7 +1223,7 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struc=
t amdgpu_device *adev)
>  /**
>   * vcn_v5_0_0_is_idle - check VCN block is idle
>   *
> - * @handle: amdgpu_device pointer
> + * @ip_block: Pointer to the amdgpu_ip_block structure
>   *
>   * Check whether VCN block is idle
>   */
> --
> 2.34.1
>
