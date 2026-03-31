Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471F810FCADC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5367710EE97;
	Wed,  1 Apr 2026 18:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="LJsZFI77";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7765210EA4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 10:39:35 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b97bca3797dso852348166b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 03:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774953574; cv=none;
 d=google.com; s=arc-20240605;
 b=hJsVBENqkIOQX7INPzf6IHdfVkScFnRUxvnv9VqlAgXClUa37dgBZ/M/5nGfV4ZC2M
 52e8yak17HvfBjgea6xwlxk5stZNf6eEWrlE7I3uRNkPk4QZ6A3EhVH60ZIB2jm+PhHd
 TDHg4HyXMfsiKGIVxQWZzp+CDSlEYSM5Ebyx8xdVDJltPL+DBGg6ZODnF83FwuiGgoQ9
 ChSDDQ6v/dk8vw2kiG/gMRS3IfUhzJNyPIarKam940b/Y8/lZDq7I9uuTKC1lYwrDXuS
 Tl0xD5a/3m8PifUqLIKKIPCZtbEq4bf33IUZydBT8m/qeOqUjaQ9VH2tGU6KAsfhvOX5
 lGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kusDY7YZ+tFfW4Qh+6x4N1GmgE5KProC/ppWG6hzDqs=;
 fh=BmbtdYV0XXFArcoPhrFZTHGPljs9C6kcUfzmfNQ/cJI=;
 b=HthV6D1a32FFHtpitLjmCMxilzPc3MDZWmc05stxF8BGiCex0GPGFyVF/DkqcCSAmL
 awoZaJI0S6prlKp/Bm6gvk3h3wfk9Dx7ykzsqaX36KTCiD3ZVQATbgYsWFwf/C+zeQsB
 fr7jRT+hga5A2te7f8R2ogUR+K9MP6ssPHAwJyqVWEd7wftDJQUz7RAAN6w3OQWIT5Wq
 cHMZ3geal0KD9XkoDsNEUuWEvid/C2aK21rZ4IDgB7Z/84CEPg1/mSNmjXAyrZtEuJTU
 oMvn491kxkjdhRCOjjyPnj9vhvWQpeep5s0MTCopMAqlvZPDrzMrqs7VwFthJdZnc5vK
 rJDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774953574; x=1775558374; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kusDY7YZ+tFfW4Qh+6x4N1GmgE5KProC/ppWG6hzDqs=;
 b=LJsZFI77gwROhZ5OQwxKwSZpZZmdSRQADWm5lFUvrfyFcIiYzkm9e+cK2ghVpxUeHW
 TA2FKAC8hVdxAO3X5HzfkxQyuZ428x9kOAGX5T9SnRFKjQ5OZl/8y1a80ckRYuQ5ViMz
 nZXkUuKd+tfHnnR9butMCfhIluNXEg9Blhx7pybKbVvAXfgYwioyJbABwdizF/YC0fvu
 TkbO5ZfXmkFzFiej8X156UgnNNTSb2N3pKztPHrG+wSYKqkeJsiBJPomU7SLgFlfIka/
 kT5zuBZBiSSH5jXRRI4S/By6C2Ve22JfLQOk2iZlqWHldENJE9H7FNYhB/PZ6A5/9FuN
 5/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774953574; x=1775558374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kusDY7YZ+tFfW4Qh+6x4N1GmgE5KProC/ppWG6hzDqs=;
 b=qDOjLsH07Xp1tU6pRPINeDHcrvX/eMAzvc1PNJeW1jUcuZq3oypxJB12d84aIukbk5
 6R5GncjQHb5sCiEV7tOLzoUJ2RBrKzqeeYF6/jLRwyNWTa8v9WS6aGwBPmIwipdER/Zl
 bjLzTC8oBqZI4ygFEZu8NS7hwimBwQVKST6k2r+a5XuUqvzidzSH/awN2Z79dPBsdUJR
 DDW2y2hhACtNWJlLdjCOECI1xWk0DP7lx9FOxs8TVyM2R/PSavmHYstcvWxMlZsxzuDh
 u6J65eoZ32qElPI6taIIY9MbOltV9sOMNh5Pro+1GLedAYwyq48RQBk2Hk44BGDiOPEj
 4gJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUlOGKvGQNIr7Ura+szfFKHgjYRg6Us2Bg/VrGbQSMzZ3UTEPrtxHBKrWopjkKkCmgAnbZJl1K@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBHgPiOTSahfNHCHgIGnNjAGXqmBJWiuQZvIRtGJRie7S196TP
 a8N6HcxD4fRDU+Kq2GLfRGUQku+1jbzwDMLE7mWraKB4aZCcAneS1IACp2dT166E7u3fOb8QB62
 bp9Ub68/PU7Rmnqzmbx2DxavEuN7oVVIMYxcoXm+Cnw==
X-Gm-Gg: ATEYQzzErFGz6fKYSQ9EyALDHlY+/9Vr071sKW+EfOP6uwHB9tHxTInt2pL0HhgNQkr
 mlBfjXBlE1UVUSqiVr/KkwSK+k7qu6B6f98ofTlss8gLbLibGK1BZV4P/sVoDOF0uZESx3xT0oi
 cxqJXSxL0elcTkJgOGHzMLO0pbOcdH4diWWnvMcnEkJzGe8/PPn9tMSMDMqk3b7/Z4XY4L8uXyj
 rkwofe87XB5zTXTbuXESChLHepTOcizzj0v7obz73jPHTZXbV/B6FEstZW8AusHo0CfSuJKbS0C
 lnGGLSKvk5Xy1KS8PQ2BC6KCjZi9sgBiTBbumdQN
X-Received: by 2002:a17:907:1c1e:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-b9b5039c50bmr973724166b.21.1774953573829; Tue, 31 Mar 2026
 03:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
In-Reply-To: <20251224144708.61167-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 12:39:21 +0200
X-Gm-Features: AQROBzA1GCR73klIonCvm9thhdPK3tuRsxSEGKNlMoptMNB4fEkPwsTY0svwnfo
Message-ID: <CAAofZF4YKvKvBf6t1aeztkvkTWji1VbrW75dL7NgS7jkLhgNgA@mail.gmail.com>
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
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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
> [...]
>
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

Hi,

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer
