Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE46CC5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 15:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4D510E48B;
	Mon, 10 Aug 2026 15:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XTC0cVXs";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4D010E171
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 15:29:06 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-383fff6e8b6so113805a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 08:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375746; cv=none;
 d=google.com; s=arc-20260327;
 b=d8/cOhAUeVAigmbZxZtYH+ShwaQurArmDYwp3nre69thVUw0oQUIPRXhpR3oslAjQl
 OxtK26RDLzjXkOHoE56byTA6ET5dKnco0zRXJSlSKg5OMobREu+ddeApUL+w2TKhxVdO
 dF5MMrUOtyy3jAIYRdhaYyt2VOAxpuMowEQ6zd8RvrGsGEN5juuFe0xim8eHcb4Je597
 rlt10ynVDrUn+M7s6tZ+hDI1f52VITySxQxG/0xnc0tef0tNhu7zrgJQICX6MrLiRAOB
 PCFFIr5hrUUWRQ6rZiqJSJoL5lkRAW4cJOQnETtXNxkRrM1y/d2u2048UlxTg7uw33tb
 Pqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
 fh=nmMcbJqe+fZD4O2GBrWQowoUZ6l9K69irbW4yTCMvc4=;
 b=LDOYoWfRCXNDz/KAL8/5eXCS389xeMofJsJigXpE+941Xi+mMu/Jp/kuLq8nVN+N80
 kFOztmFn3CSbZ4qpDn2wqfNJ6sfJVqSQD7y2F0oD9Sx2xatktaN+J/0WVtynqA1/kwYV
 pI1cERTxAmsTUA0hEVmvu6rEmRA4Ftwhyp1QFrPNE20+nkfE8qIPyOw/KxGYmIW6Nf2J
 DDL5vp9tVtdgQtz1SKEty4zwXoUb99m52iWTkb0PZl//9sb1ujcm6sreRxgdkL/6izO7
 PfdI3Dy+ndfI2bR0OvnGt63fTQvb3EGgroyLAoVkdFLP/CKYOY/k4QPq1iBsK3tEpsWb
 t82w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786375746; x=1786980546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
 b=XTC0cVXsdQdHDRqOr/kjnVyj/V5I7wga34snOvyNP4+0OKxYJ/KoTMTNOy6pRTS2Y1
 R/3KvDqIbAAi1SDxa1+d4n11Vf/S2h9y0kcXJZ+1kWI2/5pw8R1Kk8tQgX8IBZt0dyhj
 bcD7eW5uj1lM04S8GSjR/IL8/su49MHrdLv4oefZxYfDk7B8ZVH4z1IxV1qdDFJlegSF
 v0tHc3cnk3V0KnCQce5b65ppRsAJZmsYVy6XYwRnkPG3ri1aHiUYubCGw43CC8P/1NyG
 JTR/YKw/exVBeK2OQnq6jpfM7Oi7YCTveL9RR7qGCoRmGebMaMzJoj1HQVGSKi9SJSBp
 Z1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786375746; x=1786980546;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
 b=G6ohHLZ5u+iWbZllGNngX2cVhy/CQewqEerC4lA7TfXEuFKuSkLsdJAORrQoHousW8
 MwN2oGojoQTP14QGqJe48ZgQIlqFhlBtWzlai0h71JELGplVvr9HWfPdTQglbCL624sc
 pdxYg73a9HfM1Sgu0FbGhoTsZb49AxZkOFVEAxb6YYfm+Pn+I2wVmrVExqQyZAnK26NN
 rxBgh3ocfCjfmLWfuFW2zgH6q2t7BtYb9eCF6uvrXKhlFHCu7auGO/9q3Ztf+Agw4WBk
 0bitc3SIqiLdJvQC0jX/em64mq2TW+1959KQwD71nzo90aimbC+lYxinV8xSUY0sjmJb
 gXNA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4nQ6PZYGhZAZDaqrC4/kbH9OcRC2R/jVwCzVYvRpQHxpybG354fxZAdlyNatN0mHFj0qArPHy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxO0qoWAfgTptULhijjV+7NRXrpK/Rv//RIBJsAnlTa2V79NSH2
 DK59oAaeJ/IG9pWAXusWm9QQAFl5IYziiygR9p/KZzqjaD8LzPBg/5GEINbyTZKR9LwLlk2/OZM
 uLdBMdAemAcrxVrpgRc5RkLDWpxLVd+s=
X-Gm-Gg: AR+sD12LqIMlpkfT54V2BRint4nVkKXKRWNPr9OI7ab2U4WWYZgB2fBDb3fK7DSGk6k
 giR/jNZo8wVZEGXro1EAsVc3ZIgbJwrmeb3Q/XPcTH0lAV4F6glh9JMHbO1mF3Q5RA/O1stuuKt
 uMYe/h6qgzr8+SWMfb+w5JwJhWVmXIPWQdXJ/zt8CEDba3itrcHYg/c5R3q5iYHuv9Ny09eodb4
 EUEziMYJ3LujSgoCkSRrDUSJ4bt9xuomqoRzomPfeYeU5La0IjsrkS/x7Oiim/JDhq27fe5eaAg
 c6U7Y9Cyz+R5Pj+CIhf1zAhK38zIGXQF8CtwdMtspRVQiE9jqmjlu5DfpCMevMO8kxolMivzIX3
 4xBNZfWO/MgJoQE2v+dM3/EIp8BGPPbE=
X-Received: by 2002:a17:90a:ec8c:b0:38e:549:9e04 with SMTP id
 98e67ed59e1d1-3903c5c101bmr32377324a91.1.1786375745798; Mon, 10 Aug 2026
 08:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260808135942.2880971-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808135942.2880971-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 11:28:53 -0400
X-Gm-Features: AUfX_mzxEVWjyMA91yyuAHYgB82GBMnbuh99tfXeZl3LTUv9kt3twL5mx0BLoL0
Message-ID: <CADnq5_MTp9ZJw6f0Pu52kS-sP4xrntBj4kBvZtkbmcd1LC6ewA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix autosuspend cleanup during teardown
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Applied.  Thanks!

On Sat, Aug 8, 2026 at 10:20=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> radeon_driver_load_kms() calls pm_runtime_use_autosuspend() for PX
> devices, but radeon_driver_unload_kms() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.
>
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
>
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> unload path.
>
> This issue was found by manual code inspection.
>
> Fixes: 10ebc0bc0934 ("drm/radeon: add runtime PM support (v2)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_kms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon=
/radeon_kms.c
> index dc43fd790a9c..4a99c09f4164 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -71,6 +71,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
>         if (radeon_is_px(dev)) {
>                 pm_runtime_get_sync(dev->dev);
>                 pm_runtime_forbid(dev->dev);
> +               pm_runtime_dont_use_autosuspend(dev->dev);
>         }
>
>         radeon_acpi_fini(rdev);
> --
> 2.43.0
>
