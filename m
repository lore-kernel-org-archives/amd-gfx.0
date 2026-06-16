Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E79CD98E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 14:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8C110EB18;
	Tue, 16 Jun 2026 14:27:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mWy3E1uL";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EEA610EBEB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:27:19 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-13644e164cbso141706c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 07:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781620039; cv=none;
 d=google.com; s=arc-20240605;
 b=WnqoL9AS2alHTphAl2Hdxk3oTwSEDRMLtFKmxJNlhzQevYxp2B10OM1+I7lgRwGeqf
 0xgARxg4cArmKuWn+SOa30G59ho503md3agQMpZTFau6bH/XKQOzNxAKdNb6gnNbC/o1
 4jYmzpvgd/NzfAOmZ7A5A/DLYz02HK/lcb7FYmpIhHAyDfOOZhgPlRrlx7h+LgvRV0Mq
 VFlIMb84TeD4+GCJYcg+ojM45LQcIEZ3s1ABEi+jbApsQc2TK56IWwhbrLHhdegDf3Ta
 Hwx0C2evOwJ95gLQ9UeczZdl2h83HlzLH06WGRDd1G11MhfiuTVSTB4QlShDWcrckhdZ
 VRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1+oFeeOuxVc5Sw4qP2HvLrjZpmPoenX0pvkLapx6U2Y=;
 fh=ZALIDHo8pLRdkfs24V7vMF67xNVOyg3fIMVdLwiGvIo=;
 b=Dq9sXacSKCaPtQ6O4Dj2F8FipCgq09Cm6Xs6FlR2b2J/MbnPRlD9iEOQD9M5CV1LDO
 w0r8EoMtNGsOHrQbk8twFEi1OVnCxr3FRUDfyzXVlldglwns/B0MuADZlXp4zkjeR4tz
 Rvu7OB7PB3s8A1FhYhqFwVpYGv9EaMtpQnuxEBvPv5C9zDDOM3g5q9aO7lB4ANbNWN3e
 ZKZJKj5KBuA0ILeIRm5VKcsLYOAMm3JHs2lcwFyrujr1nWhhXgQTOUN2k6aRFyNYJBd3
 Nc5hrUVIBX3nGDkBMn0qBmS2BtL2ULJlpBOMu85/zQa4hYBPYe3Qyl8yP45PWII0k6XV
 CYwA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781620039; x=1782224839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+oFeeOuxVc5Sw4qP2HvLrjZpmPoenX0pvkLapx6U2Y=;
 b=mWy3E1uLCI8Cx4k0UTU2RYyBPEGJqjZcvsSeRWyT56hTHNJN8LKu6mGU1zchci0YCc
 9t4BvX7vSodTBZkmQMeQxvVrFTG1x9Y+PH1S8uXN15K14RnVIgvT3paXqdqBZVo1NmGJ
 4OUjKTAp8189uvNWfRHsEVtVgAZReC570vLALq9x3vbXaFiUW24t3Q8I6NJ4Yd8q7Hwe
 LL9lhRVaSWxXFTUXRiYeiLB4/Ugdjthp/4pC8HlgVe0H0/Xp3+Oy80wsYnxGNPVPwinL
 cP5NN53CrflTD+nCqwQkOjWZ/v3s1QujQJ+HOjKM+CO0hlBtMVO7Xhf6RTKuvz6sE4RS
 2rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620039; x=1782224839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1+oFeeOuxVc5Sw4qP2HvLrjZpmPoenX0pvkLapx6U2Y=;
 b=bNYSOsnMcuO8H8l1Zm6Zpi2HZlHt46RWHqspuat8QRmlC8NPTd/WZ0qxfwfQd3/KM2
 GfBasrfnZU0CCXG5FpbK4tHT62oGYujtl9UZkrSR0dkXQcc+MIZaJtTDWkayQEXOTzbH
 6q75JKfVnhKBdZCLV6pOTErdJyCMo2oa1MOTCzh0KVakQl5bNlwXeAi5JYeLvOwuEPF9
 4UXHKXvOEZpkaAcNQfVXXuTgUUSHH3SCGYKSkd6VnIGiPuIpVya8X6sAsPaXZE0o8/JB
 ksd5YpKubWCNgm1iJ5YQBZmZZLSimV31QMxhxKip+II5XSJFmkHkBTWVhWkAquXSADpa
 +l3A==
X-Gm-Message-State: AOJu0YzbZXhQ2wjn0syekR+DuzqqlTW00m1SvIIXSzLPdIONq/T8LQ9c
 +eoqKLB4cJl1Wt0BzRRLpNNc9+bIf3niug3MCCzI4Iks3gYvz3czzhvzrNCFK5g8V90fguL6zzN
 BJZfQooR3sg1DKJXJF3w0Gma/MfjJSHk=
X-Gm-Gg: Acq92OGwFkkj7zlgX6+d5cORV5idx1HghFXsJlrJuFMeQyXrb7f52uUSBmKjp4GszSi
 W5CfSteUTmuIBpl+usoM1K7gC/Wy+WNT0QmXliZTYjjyXZ2Vku7bDu0tEku/EvXttr0BMD7yEA8
 VF+0vXOVPVlzPbMt2fOwvQF43jBjvGr9UWjo7zdni52FQCCCYyK5JikSTHVfT8kPzoFDsOeZZ1t
 8Jzyj1Wb8a+dXmcFgnSrv6rKgOqfnfE7BMhy/NuyMFavq9QgNLJx8CWLm4Smqg4uGD8cVxseTa2
 C1ugKGIn4d+S3D3YvD5SeViDQB8WcnB4abUe0xdtcn48NTk/A7GVRLr3iDEkDstuStMKdA==
X-Received: by 2002:a05:7022:f99:b0:137:fdce:fec2 with SMTP id
 a92af1059eb24-1384bb6ec69mr4180663c88.4.1781620038568; Tue, 16 Jun 2026
 07:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260529093436.82149-1-tvrtko.ursulin@igalia.com>
In-Reply-To: <20260529093436.82149-1-tvrtko.ursulin@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 10:27:06 -0400
X-Gm-Features: AVVi8CcObXEno-KdBG0LcF585XeNKSYKiFlt-Wtov9AGjlnaEtEBA5DpSvJK-MA
Message-ID: <CADnq5_Pixo5NX8UCLOZ+oX4V3d7yRhfzT4RLcS4vNOr=_FGoxw@mail.gmail.com>
Subject: Re: [PATCH 0/4] BO list handling cleanups
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Alex

On Fri, May 29, 2026 at 5:34=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
> Resurrecting some old cleanup patches which have fallen through the crack=
s.
>
> Series needed a gentle rebase but they have all even been reviewed.
>
> I *think* the reason they haven't been merged was that before I have been
> "bundling" them with the context handling XArray conversion and the combi=
ned
> series was failing the internal (AMD) CI. So maybe try separate now in at=
tempt
> to isolate the problem.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Tvrtko Ursulin (4):
>   drm/amdgpu: Drop support for variable struct drm_amdgpu_bo_list_entry
>     size
>   drm/amdgpu: Remove the bo list mutex
>   drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
>   drm/amdgpu: Remove output parameter in bo list handling
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 169 ++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  22 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  67 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  11 +-
>  5 files changed, 109 insertions(+), 164 deletions(-)
>
> --
> 2.54.0
>
