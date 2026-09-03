Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDEC624DA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 19:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E2810E3E5;
	Thu,  3 Sep 2026 19:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ILOBiVFl";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC9A10E450
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 19:28:38 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666bed443so19149a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 12:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788463718; cv=none;
 d=google.com; s=arc-20260327;
 b=XgOal77lqnzh1luIICpKnqNtSiMfkFka+pPNalsdgswzm1Z6f2mce8/RUhPvFBcoTz
 7ku5cO2hv01Q+T6+s7c/zEMAlqwSouNND+7BoHwUu2s59yh8fdXaP4RzWMLxBoNsBLG3
 /cIsMDusPXJEY9PFsiXEcQ4orfowxFlF0lDVrISAhgA944iSXbXd/tu84mz1oCrnE4qC
 pTveKpD5lM08bi9YVhR964G49EO8J9sHwCQy9HuRkiez+k/Mj4WsEj8/TBVnOK76WGFI
 woAOGDCYM0kUMfy4EKY4zlR3omcV980/7zi5eXHZgG3nQOk/QLxzoTlhhXHPuRIR8y8k
 mVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RHE6gt/IfKa0w5j7MQSAWDt+M9A/JqK6eUGSBBa9Ghg=;
 fh=nV7O7ZvrEXClH0+OVsSKlRbbPPwH9zMzJ13ak4xFzAw=;
 b=qy5OIiJ+ZplVFF8cxl0kN4AiNCKZ5VhYvkuBCpERv6mH1t0IABBYFJztmAcV8cGR48
 BitfeRSeo3NpR7hLXbA/oOR9D63i2Z6V+yWrwxNqLMFolOVdNTbRqyHOlECvcBydc8Y6
 duTMwfR3HwynxEdDL+yHkNkezvYMonAT8QDCk3OOAhV24P2/jMjFi9gd/d5A8MAJgJNA
 vfJ7VcYAhbBLeLU6W4wCzAV+EgJ5h+2huRs8aGEXQi2/yD6bU5fl381ua9PSaOkj0+22
 0tLYfknGJhIIWHFU3h7Af3BQWbSbE2AgQN12SkFSSuHrfHzRIeJxB++lA5Y3ZsmWvviO
 z8aw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788463718; x=1789068518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RHE6gt/IfKa0w5j7MQSAWDt+M9A/JqK6eUGSBBa9Ghg=;
 b=ILOBiVFl2ouCZ26YD53uAxanls3AWg33U21jF5Z2S8cQK2K2lWD5Br3kYxvB0V3Yyb
 XU4+KtK9BuXeMJec8f0QSBdyHYNutwQIZR3jepe8v0gAbwVXM5RBxLdomlXNOOXBTft6
 S4N2tiyJ9c/a981FnkzFNx42BEtY6lJpye+EWXQiL7Zvb4PSNJNOvBG8FOMITRExflCn
 58CEPsreU55ZkU1OjvO74q9KzAzd0NZY9xgZRGWFNXM0qutcrVhouQFYMHE0FF8TWE5a
 +mLXr975+nTfSdbbztbnDDHSQXpMxAlHq0doy1+gvHV3EjE+dn/VAyYN67XNjLvi/wPj
 9fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463718; x=1789068518;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RHE6gt/IfKa0w5j7MQSAWDt+M9A/JqK6eUGSBBa9Ghg=;
 b=qO7wZ9xEHfQcWQzBmGnTgb6dFWUpvWFERtzqIRjEjn8Ne9hbBpYIbatuOuJW07vIZy
 69qTE4yhrJXiCd+p/E9JgsH+MGThh+ZxkypYZCaJUIy6uoTWtoJw+Cx042IWJ7xSYY/r
 BfY7G7Z1gpm38wDu/n+zjaF8R4yKs9gzaZPeKj/qaE4ZTtdEyaES+uW+1au55yUrakmc
 1Qn87ks/CR8kl22Yn7EvALFDPDhzfPnUfPjlMba3ItCEdlCx2+eUC2EkdpsXmBjYY64d
 iFp0gMqD+xM1xXQdTzuXqIN2e7UQ7e/1QW/Of9CpQAh3fpOSlZ7Ip1nkP8Gxiww69Jqd
 IfBA==
X-Gm-Message-State: AFuF++kIru5fz5ErlnygcGi3fh1IlmLHRsltZe7msBlYHms1dej2mZHV
 vUZP/tHJ1M9ruP1AUyasLB8Yl+v8NhB7YyEZXrk//aNvmIBEUxvNyAtKlATPHoDEDHB2xSoUrwB
 yxEXPu6Tq0ZSTn8+jmJeo1Zc60PT0H2I=
X-Gm-Gg: AYBFou37clvgEeE6tW/13l40ITb2PB3IZBz3WpTOVYG9XMI1dfGndZU2W82Wv50DDw9
 qzODsmOc25E7aLbRSimJytG3L5WVuHFv8AWS3E/yGldrOdm9x1AqTwmrC+yVKe5MY4uOOAsFtaU
 C/eyN5LhvhWdEKNgzW2mdjtknj4xr4Xou165QcYXkyNdOQB8XoUF6a2GqQzTuB+6h6EM48deYYx
 1Wh44WtnWxRpsYa1O3hbEU7d7OLjM/r4NiiLgfjseGLpDZTDzQP2jM1keswZQqTsDW7sEtjwLF7
 B0Ek6wbbnViaMCkDkNMmud5tU3OeJzndlm8seCKnfVUIpGoM85Tx+cJH//o5if5CTeaLkpV4XYD
 qZdFO9wKUNJEK+yKsILBX8Q2QKKUJrQo=
X-Received: by 2002:a17:90b:5306:b0:398:bada:838b with SMTP id
 98e67ed59e1d1-39b26afb764mr459855a91.6.1788463717609; Thu, 03 Sep 2026
 12:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260902125001.621629-1-Prike.Liang@amd.com>
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2026 15:28:25 -0400
X-Gm-Features: AcwNN1XYNLKzjFYOFYTOGAhT7UJCJXReeR3lO8T9Jf3qozSimDndMi2RLjKOQPs
Message-ID: <CADnq5_Neiu-GKP_xoahHVo2kk0deyU-Q11=DTF1gHRUhXAU9JA@mail.gmail.com>
Subject: Re: [PATCH 01/18] drm/amdgpu: Remove separate guilty compute userq
 reset
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
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

On Wed, Sep 2, 2026 at 8:50=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> wr=
ote:
>
> amdgpu_mes_detect_and_reset_hung_queues() already detects
> the guilty compute user queue and resets it through
> mes_userq_reset_queue(). The additional reset via
> mes_userq_reset() is unnecessary, so remove it to unify
> the compute userq reset.

The problem is that amdgpu_mes_detect_and_reset_hung_queues() won't
reset the queue in some cases.  Detect_and_reset() attempts to preempt
the queues and if they fail to preempt they are considered hung,
however, there are queues which can be preempted which are in a state
which won't make progress so the protected fence will never signal.
That's why we have this special case.

Alex

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
>  2 files changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index a6f95ff47d24..5c3be851ac84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2384,11 +2384,6 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_dev=
ice *adev,
>                 deferred_end[n_deferred].fence =3D guilty_fence;
>                 n_deferred++;
>         }
> -       if (uq) {
> -               r =3D mes_userq_reset(uq);
> -               if (r)
> -                       goto out;
> -       }
>         for (i =3D 0; i < num_hung; i++) {
>                 struct amdgpu_ring *hr =3D NULL;
>                 struct amdgpu_fence *hf =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 7f334f718cd8..83a438d8e117 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -249,8 +249,6 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
>
>         xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
>                 if (uq->queue_type =3D=3D queue_type) {
> -                       if (uq =3D=3D guilty_uq)
> -                               continue;
>                         if (uq->doorbell_index =3D=3D db) {
>                                 uq->state =3D AMDGPU_USERQ_STATE_HUNG;
>                                 if (use_mmio)
> --
> 2.34.1
>
