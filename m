Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B756EE8B39F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D0E10E8BE;
	Thu,  5 Feb 2026 14:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="f2U58zjs";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE97610E00C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 16:23:28 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-59b672f8ec4so46074e87.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 08:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770222207; cv=none;
 d=google.com; s=arc-20240605;
 b=Xlf5ol4rtj87M/ncgRjgsB7NqAGY68gehli+ZFiiwSsFvgXY/ZzP99sGklMLSyjTwc
 ZWPQd7m0vv+c2H0RlOL4MJOmeny72nIbtzEUXwffEVn2AtKsjZw2AV9WV70bPeH+9iUT
 XZyPFjQvns/jgq+/nSKl2EVS7jRqjBDkjKD6fyTVMA7U3PZXLVBrA16RIGPTX1ieATYG
 2wIMdSXphYT1BOJSSfBElLn52Qo0PDSdtHQ2eBFf/3hsmbylAAzS7lVsAXj23kQeMgUG
 IHQtA/9INffHeLNnUfUxp6ZYIlyIqkQHJrYeya5QuN3KNU355vw5O2YFS2r9BO2B198G
 r8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ab2t+mcWFGP06dFB6KRcl1ymh71pJERVjF8n14rySY4=;
 fh=rEwdqP5u5joQQhoJUCClDM20XHPd1SOVeIBnhOeVBjg=;
 b=kajqFo15HBN2VrBWjf8Ye+7CDrPYNVR5NHjcKB7YXYd12fvdZL8CCDIraFxShAE0Tg
 /4BCv29uLW7aQE7KO+gSd4atQ2yR7mwjEdwCiwR9eo53TNpZ39w12NrBScUbNNxa6JIq
 98bciD5yAcXYUNxnqa+1k9xFqs3psgPS8dDsm2odEI3IOA5Pxnl1GrxPltIQDvVPJ1lb
 Rs1xYsb4zr7jckuugS1OpgY8qnKFpsjNHISPAqtmolI1HSrr0wb0QgvuTcN2Kur7lV1G
 POYkEHosrIPkhVxvtS6XoiDjQEMBsPCcugLQfWXaf+PTPG5sPYxbK7bAO3ZdYf+OeWr8
 7Xfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770222207; x=1770827007; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab2t+mcWFGP06dFB6KRcl1ymh71pJERVjF8n14rySY4=;
 b=f2U58zjsvXbhMaP2ah6STt+lhLHCREptigNLrASCAnb4pjpaNyg8boyp7K75MTL+Ti
 egvkNxAXt2cGeFZs5qqj4U6bdceKHv1L+MTMW61Vb/BwMJlj1uOPL+pz/Vq/OhUXJ8uU
 wGnjbghAFD2cR2w5b96eMulWzJTRO4u126MgK285Gj0SqE2V9eAjaTHzV+hDaqf0rthj
 A3jPxitWYkLF+kZccuBjEXjcCDfmty7MuILKzEMJRfhu9cF5iyjyID24Zbr19TAQ29c0
 P9vjy/CPMvE5wUMRFylzjqRSjb4AU1owCS81iluUHcfe7nqrEQDa08eQ+Pm2Sh08WYSu
 X49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770222207; x=1770827007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ab2t+mcWFGP06dFB6KRcl1ymh71pJERVjF8n14rySY4=;
 b=GaL6qgQIsFWNKrKDq0COlBLutSwMqvn2VfmzSXzGmuNFtZNnvqrRRfNHpQMKJZGvJC
 ZaAGC44otgXtpOYGA9PW/Y3TcP88SzhraYUF5VS6TwpoHk9CLCTfZtnNUgI26BG9m6Iq
 Yi0lFDN5+DOioY8H6t5i2SWpNZe524GJ27MBYMgEdyN6NAY3Hs2yIGJL+AsESfEa0ssn
 XGuvPLiDbLkFldOBh5zSK4NvGAGjlKVYCwNPaZlBH51HZyinHx3F3+EUtWQ7Y3/O9uCZ
 GNT6vzZCsVVAq0B5YRd6V8zKa/sOMPNsxxGsxh2U0ARCraS0R/DzcnsxhUkxEE7QQiuO
 6HNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOIKoCBszMGAvwHeDSATd5fONjYQGp8pmkIxe7hCSfZ7spd3NoZhLFQWvrH4CXZEN9q5b268gE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi0OYdVqHjECeJxkJPoa/mXddFXmhnuJOYgwFrLcLZiz64nOqr
 2jvXOJnx3EXsU+O81Kq3fV6MymW5d05oPRoWCxswXeBKxr6U/o+t+5dTxI3fM8FczNsCIhTbsOV
 A/iABWPlpHoownABmGiwsFUY01mp0ScGzPNLKHfVDsw==
X-Gm-Gg: AZuq6aIDnlYjgpiS1n9vR2ZxhpulrJDd5tj5zbEG3QN//sVHQdvwvEcZIf4jBn7d9oR
 zCIFQdawLrW5laA/o4ohU+k6EM91g9SI3lpTZQqBuhbp4c6dpJXaZtMFaBfS3NZmEBv/oLZBMaC
 PYjoV9+1o03BPeoDlLYyfYLK3aVjCiSn6iVecxfGqTQNkHwDg2znSJiO6WX9SXbnMKzqrYbID55
 uk5zI80GaYS+4ZHkVSrnc+h+qI35oUMe2llYt7wMnKiTeJJxcJIL5bTm1t8feMq4chRl90RviU7
 U8iCTVUTlNglcIGocFbpGpruiP7S
X-Received: by 2002:a05:6512:2399:b0:59e:3702:cdc2 with SMTP id
 2adb3069b0e04-59e38bd022bmr1391764e87.0.1770222206822; Wed, 04 Feb 2026
 08:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
In-Reply-To: <20251224144708.61167-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 4 Feb 2026 17:23:14 +0100
X-Gm-Features: AZwV_Qj0hbru-qyZsN6yOLCm8UGRjKsemohDZ0bkezg1DSADm8lZKDq2GMAMm2A
Message-ID: <CAAofZF4fUyBj1pSD5T9TzyoEmnkzRsuhOb1s1m=z7iXM8PHwSw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Replace old wq name and add WQ_PERCPU and
 WQ_UNBOUND to alloc_workqueue users
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Philip Yang <yangp@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:01:18 +0000
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

On Wed, Dec 24, 2025 at 3:47=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>[ ...]
> Marco Crivellari (4):
>   drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
>   drm/amdgpu: replace use of system_wq with system_dfl_wq
>   amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
>   drm/radeon: add WQ_PERCPU to alloc_workqueue users
>
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 3 ++-
>  drivers/gpu/drm/radeon/radeon_display.c    | 3 ++-
>  5 files changed, 9 insertions(+), 7 deletions(-)

Gentle ping.

Thanks!



--

Marco Crivellari

L3 Support Engineer
