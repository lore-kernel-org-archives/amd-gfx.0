Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E4CCD196
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 12:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C810F10E79F;
	Wed, 15 Oct 2025 12:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="MYoewjL/";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C211410E7A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 12:04:31 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-856cbf74c4aso1238756085a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1760529871; x=1761134671;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIkDzOp9lOkC64phyHj+bKX1qlxxtXvg/X9w367rNpc=;
 b=MYoewjL/vwDYq3coel9hzz+PwQ17hKdmPqn9U5l3tr4IK/YQM7nYSfkiGpjCOf6vWU
 jBmJqWtGS9Log4iljNq0wCLe+Q6ZfRTd1m5b9YtXd4oW+pzcXjQgPPQ6Erltlg2+i0ee
 iquKRXCXhLqf4xtXhTSYzis79paR+2gUbMdg8Qg99Fj/IPBk6qo6m1MEmuUjwgQwASIf
 qhCAJocJx/V75IBrDE+bL4DVwQh9TUAizsT3NfMd2pb3Xl+0vsjHCCK9nj0zaWAVZGk5
 SqRxwkuKSp5fqP6yWO9N3EOH7nhW7XUv13KP824M1dKwPX9Z6fJhh7Q/d8QDGZpXheG+
 /7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760529871; x=1761134671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIkDzOp9lOkC64phyHj+bKX1qlxxtXvg/X9w367rNpc=;
 b=rR+cslzXURff+2MhxeO8FxTiw2nh4diqMDR2R6XVsZje9qSa+/Dwy0VSWlskKFbzdW
 dBbZ7VeitVlIRtaelElDz+2aU2QTx+IZpjRRoltZNfmkRj/SoU53hQSkBcRWilCGH1wG
 U5VY35cojNhJztaGL1lUKMGxV+89jqYf0IGU/HMa9YOuGtdlObM/glkPQE8ekfUJYok3
 xuoolulK0WrCZ+9MJmd7HfVopDaTWKpVWRinXxhLrTNagQF8EhnGPq+Zwlo7buP+to1u
 2aCzU33G2VPBd/ezO6z1CTWKBtJPTVawcaQKpt7uK5unnwj7w+20ZbMWrOngV8QAVi3H
 jsNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEzrtPYS3Zqf95g6bZmhKmihi2fu8W4Wfd/l/4D7Gg4Hb6egllzXIbkWrEfJJaD7s+gwHcdk0C@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfMhz53ZqDqnndx0T3VlkpaccTlw/JpWfSpXQhnsKd0rrwAfem
 Uh1Oa856qBPQNFfIvAS7maZ7wiABaqzuD4NhJmWeyDAX4xOv4yWCBjwoyPC7C/8vWsgN7DEkWb4
 lPUuCu+ADZ65cRYBnFreDQG9hcSmgvuheELY6yuFMug==
X-Gm-Gg: ASbGncve3YKUzv8xIySd9cLDs5x+TfllupYhvDVMEqX46k0aOtGxa1sSnwZbui3k+vL
 TeNwpY3QmgGxvf26rjFxwCp4LEYGQ0LgGg3jmJ7ZGKLbycg4VEhh0NuplgqJ6VI0QQahbzarCgu
 mLD3BQcKL41qrvvBR43L1jz/rIDfWQnkU4hgh40zY0yYPzmkeSQtBxZINZp5MVQH/MjZWo4P+5T
 uGBOfImBdpQti0i1ZyjjAMzSZy06AacUQ==
X-Google-Smtp-Source: AGHT+IGsy4ghNUujV8ICs5xCd3l4JFRIFi1WBGAyKhaZaEA9CMFYjjgZCN0vS1WL/9stf48sqTR9sa0kj6mJ0PU2Rkg=
X-Received: by 2002:a05:620a:800b:b0:85b:5fdf:69ef with SMTP id
 af79cd13be357-883524cb7c1mr3776426285a.30.1760529870781; Wed, 15 Oct 2025
 05:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20251013060212.14583-1-vignesh.raman@collabora.com>
In-Reply-To: <20251013060212.14583-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Oct 2025 13:04:18 +0100
X-Gm-Features: AS18NWBrg_BqO2tS4RN_x8d2btqMDE8us2R2sNEBkP2IYKjicDOGCIjh3Jp7IkM
Message-ID: <CAPj87rPDppYBRuQ99mh=VqrsSErGKcw-ZRY+zPuGrDj77G5k6Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: disable broken MR check in sanity job
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
 robdclark@gmail.com, guilherme.gallo@collabora.com, 
 sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
 lumag@kernel.org, linux-mediatek@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org
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

Hi Vignesh,

On Mon, 13 Oct 2025 at 07:02, Vignesh Raman <vignesh.raman@collabora.com> w=
rote:
> GitLab recently changed the required permissions for the
> are-developers-allowed-to-push-to-my-MR check:
> https://gitlab.freedesktop.org/freedesktop/ci-templates/-/issues/81
>
> Until that=E2=80=99s resolved, disable the check - it=E2=80=99s mostly ob=
solete anyway.
>
> Based on https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37782

Thanks for fixing this.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
