Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206F4CCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 12:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB2C10E42A;
	Mon, 20 Oct 2025 12:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="UB1um/PY";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B6610E076
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Oct 2025 14:32:39 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-63bbf5f77daso3063045d50.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Oct 2025 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1760797959;
 x=1761402759; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u33yGeffbuYdlvlzL4H50ccSYsAIsX3t6iP87kPjVYE=;
 b=UB1um/PY28UFZ6nAnbTNtCOxbBPZzBLv7Q2doaok/f6Fv/850ac5Xj2b13plkVvPE7
 vQkbTSP9ofwFejPRTpf71+JiidB0POisqVM3SkQD15KjDvFSwYrRb+LKXzV1fEk7Cwbg
 s0wi3ljqvW6uiIn2h9N5g/IC2ZnV7ADS4T1izS1T1e52KxND8g+ersLGBoqzWHhk+Jr5
 efyaaml7CEkQ830LZ52k8aVDoelMomW2OUejAcTd+GKRtFA8TYRRkqIwQ8uW27Jyr3t0
 CljY+NG12P8NOqURxDTsZa7as/si/UKlHubOeMLk0908oFqyNwtGmt0pi8V4dEeQ+7X6
 1KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760797959; x=1761402759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u33yGeffbuYdlvlzL4H50ccSYsAIsX3t6iP87kPjVYE=;
 b=m8+slfBqRZrHWsjpMgInG3dUBIYbwsPZycDTI/dhIsC6k65pHDs4yMJ/hxEYtw5XDH
 zpxEMeH/Eb0KzfYjB8MsyWtowaec+liENQE/tTlE5KiSa1yT6hlydDDrmCZJ6UaXA7gW
 uLXz9IyWLRhhtzJ8ERXZaj+MjjB2Iv29NsynV223vLeIzcvJxFWT71GYDLomZoZfREMs
 GFh9O8dbJ+LgvFFpfXA7iwMYDOHdt+Jlo4mbb7B4Z/aaWDKzMyjnDO94RMJ+bfYsLNCN
 4KMRII7PT0XsSbwIc9MPxWhw176d/Y0keUPSkDYD1SKFhQyU5nlrM4/fGXfj6+seWlN0
 u7yQ==
X-Gm-Message-State: AOJu0Ywmo4zRD1zJPaJM0o/8qEcGVP7R7TWV84g35w6z0Octgp/hFnve
 6vpyLjMTsfSW8ccjUa+prSO7b+nTv4Omr+WUc3x4smETAwXiqlcyQ/VQYIoSrBIAg/hnlgMrCPX
 8K/F/Q94=
X-Gm-Gg: ASbGncvK4GjrSAs1d7Va1JNF9E1zckgG6lvHcTDd9F1f/hXeg66UwsPD1MvUyrm4DKM
 DlII9FnBcsI/Ff7jq74LA3CCvQVYVDEUxyuyRb4VlnU6Hm9npGFsYB282X7pzOiHhhEtIYIhyda
 cTjOiN7xsyDQfaArnBplmOm9hIrkZflFtC1iQ6RUM0AEQQYLoUws+jvmp0fRmv/l9fCzbfwT2hE
 bumALjfHXtinXjKmcP6kMSIkij1gcRUSUjOMp7ujOo8fkZwiWuyk5hayePKa6zck4a8L8/sQUsO
 8SGqmZ8ig/3h5napCkmlRMUvmcCqSQCXtx/zNXlaC8EqXWqjTTVPC8KnZNI5huSiijxnstR2yzL
 E6Y1lKF2XSMRA/a5Rk8h4nBLuBQkuVJk2LbkkXpLd/0GjhX6D8RtniRCycUwMHD8CgUqPhQo8Y9
 VPVVYaoAd1OM3s5cWxQ6HUA1OVLPYUwWkKGo0GbFxgs9kH2dx9ED4/vw==
X-Google-Smtp-Source: AGHT+IFF/uYaF5unMA2JrnG83glsTGgmsXzLJXAhREcADJm1ByIhJXYy/E/u2GiQDhtQixvIBaCmUg==
X-Received: by 2002:a05:690e:11cc:b0:63e:1943:ce4f with SMTP id
 956f58d0204a3-63e1943d222mr4804190d50.6.1760797958795; 
 Sat, 18 Oct 2025 07:32:38 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com.
 [209.85.128.182]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-63e2680b19esm817724d50.23.2025.10.18.07.32.37
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Oct 2025 07:32:37 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-78488cdc20aso2719837b3.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Oct 2025 07:32:37 -0700 (PDT)
X-Received: by 2002:a05:690e:1401:b0:63e:2001:96e0 with SMTP id
 956f58d0204a3-63e20019897mr4605587d50.32.1760797957548; Sat, 18 Oct 2025
 07:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251017133644.44747-1-tvrtko.ursulin@igalia.com>
 <20251017133644.44747-16-tvrtko.ursulin@igalia.com>
In-Reply-To: <20251017133644.44747-16-tvrtko.ursulin@igalia.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Sat, 18 Oct 2025 16:32:26 +0200
X-Gmail-Original-Message-ID: <CAAObsKDY1zs9R2HwnO6ESP7585rEzhBiTQr8eZFDtTCsbcQx4A@mail.gmail.com>
X-Gm-Features: AS18NWCAB_kOwXa5sb329LHfQOFfSyknwHwT7YO9iNYjXbmCM8gGwoS9osAfhMw
Message-ID: <CAAObsKDY1zs9R2HwnO6ESP7585rEzhBiTQr8eZFDtTCsbcQx4A@mail.gmail.com>
Subject: Re: [PATCH v2 15/27] accel/rocket: Remove drm_sched_init_args->num_rqs
 usage
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, Oded Gabbay <ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Oct 2025 12:48:40 +0000
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

On Fri, Oct 17, 2025 at 3:36=E2=80=AFPM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
> Remove member no longer used by the scheduler core.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> ---
>  drivers/accel/rocket/rocket_job.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index acd606160dc9..6ff81cff81af 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -437,7 +437,6 @@ int rocket_job_init(struct rocket_core *core)
>  {
>         struct drm_sched_init_args args =3D {
>                 .ops =3D &rocket_sched_ops,
> -               .num_rqs =3D DRM_SCHED_PRIORITY_COUNT,
>                 .credit_limit =3D 1,
>                 .timeout =3D msecs_to_jiffies(JOB_TIMEOUT_MS),
>                 .name =3D dev_name(core->dev),
> --
> 2.48.0

Thanks, Tvrtko.

Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Regards,

Tomeu
