Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20D606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALjCqxzW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8313110E7A3;
	Mon, 23 Nov 2026 15:37:05 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7176B10EF26
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 15:36:49 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-86346e86670so94946a34.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 07:36:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448208; cv=none;
 d=google.com; s=arc-20260327;
 b=KED87EC7gS0FdPeSsghvgmo11Dc2iwT9t6Wd9cGL1pBkHshBb8a+T5RiKWNBY8mdpO
 kHywVn8SsJkRUn5sF6MvLQ+AfUF5ac8b/SSkBuHatba1GBhAo4Xol9Vt1CGZHFCLBjpk
 Ij+J69VstRZKAvtfYj5UCJid+SR6M49Id8y7Sua4aerUGss8JwBCYUzyre7ZxkqvPZHJ
 8pZ2n4Yqd0G2W0seQjTThVbMFjt2bfMna3W76dx5RPcUb1JWB13vFhGN9n7xfUZjKN6a
 IBVUWQGAl64+E4fPu6D28eSYlI3vfpNFDlpOvEb2TB6p8r9oGtAQinhmM3kFFY3U/sKA
 tXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O+ZsCUKlDNFkykdhaFUY00lREXOJ7VO+hfzdF9elZiI=;
 fh=ml3YVJRnvfwHGLZNX8sLCtUzzae8KA3ghVI/QbGoZkw=;
 b=fms67a1rIyBmon/Tzxhfyyg5eD8yOVZ1pD3uZ5tuWEW6LX36g4xvUIctlqpSPEfAHC
 OptWS3QqnsMNFbRXkKrGFRkRyXZ6+k6Sx/pt8iGKKNdqH8f/cEJbEezSOhX6zYgGl/Yf
 35ZoZCHkSSQWmx6Kg4CJ475HiKqa0g1cbmF2XWpFb+fDRJPgAHc3y4SU9kNSftgWDwXA
 vAnzsLK9ihj8P2cFNS3BaOkhAfzPzD23X4/bp6uR5n7UOhYRyYXSUNRgOckatZU3Uiea
 sgI+wu9EmyqH6A4qj23bGyARGkpirQK4po3cmm4C7uKs0bncSHnvfCwoMaNIVL9halQb
 OYhA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795448208; x=1796053008; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O+ZsCUKlDNFkykdhaFUY00lREXOJ7VO+hfzdF9elZiI=;
 b=ALjCqxzW6NBAbCpZT0hCAc+NO4ou7ceF0TxCi/WAfUbszdzP8tgJ+OosC9SHgHtfPg
 SD8d5VLH+ZekOhHJu6Aen/BFnVBDNK+yIbp5bZEb4zk/JsWHyhfuJCNz/8nAXD7f0KSA
 +GgtYzKWQAXPweAHxV3VxdakQh99dzgNr96bOwA+YdM+wkWe01KlUnSZBqYmbVgdnBh6
 5a2ynDZUjfGcc/MG1FOe0GGcasJ9Y2DVswoo6kNgipd4S8BpjyDiFqlukzTNR/zePHEa
 Fy8Tml4lg4uebFh0mDVHFSce87Ad0CHmKJsgE0nOUks4uQBsSogj+3Li0nZ+J0BjnrVx
 lr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448208; x=1796053008;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O+ZsCUKlDNFkykdhaFUY00lREXOJ7VO+hfzdF9elZiI=;
 b=kdYqlfJ4KjhFX/hFnKKyLKL90M3BvbPwId5q1Oscqa1h4/nkTySf6B67AZkmYqfL9a
 zsBltcCjxsArr/AWGWX3nHybp81rh8kc0dRTcbtLap5DmD5vI3f4kdN9fkY6pzzV3LS0
 QBndA6/NiuCzSfAG9LoHXXFvHpfHP9ezFgaHR7x8Zo0jJHwiKl/N3TH69tqQUS+Pa3ts
 Qq57VXibAp0M6lrXpiKF4HVqj/cegvSlQXopb7wkKAfoHy/Z+XQq/DzvZ+NKktgdqbsn
 mZwNVaSnLfkaF/k2Goek+aoFDiW69mYrxbyszKOYmKUGO0l6Zh2tDZDj90Ta1EpKJpxL
 2Vyg==
X-Forwarded-Encrypted: i=1;
 AL+hErGzO/lrYJgu4l4w2QoxCMl41FzYOGRRJQoAAFhErZdI1Nfcug7uihitMwE6qsjZFL+z/p9NVPW0@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+iHvAa/Y0N39+MtrzBEJ4iSHeEccu/6EXywsQ+Ao7SgUMI1q81
 YdS8E1t14xIcgHA8f0gwiIQMQ432zlmUK/fnIefd3z/71bCJQjZ6AHFuJFOXfb2A9St8D+Fg4fu
 SgCyx0Gz/scTmMYToJjYBBYGYnQ6ctv4=
X-Gm-Gg: AZFdTZdcXweXiRdDCwYfRb0utwMwj04m7p5OsmkFt4xwOROQJbS9mhIHqOacxfFcRcQ
 LwVa1jIyCa54fY+/xvCAJwjTnyAftrpBWRBsn0Nge3MtH2FK1NIAeH0ZoHgV0FGwEgYo2Yq+Oma
 6e3U5mGPLrJdMl5kbsOPDWQ1TC+kifgrNyvcOeAovcoBaSF9bnU8A1i0DDeXdD1nRczYt/xSkjd
 +JUf+8ja3SJUcwLzr2o4PJWrGjBiC0qQwE0YhKGQV5H73wtNYJKgQBq7Di4mtdg5NTQq4UpsutE
 UueASr20XPjp2FfGYKxA7aO/hHR09wLB8xwsSnKAkuO/YuQ2u6SOXGF/FZ4xJ6b3o7+aq71JLDg
 +iPnAue3lZDGj3pMYzln2C3lxn+eBAP2iKEZQDl6LvoITHnRdk/0UeSwUq5lQOWxizNBq64iKOk
 91ORtPp8JB1Z1iWYvDSZPM82ZdoEvP8LPHHtiv1yxpcXXVMHJclyZCaUK+aDU=
X-Received: by 2002:a05:6808:1383:b0:549:e9e3:9460 with SMTP id
 5614622812f47-57a025ed532mr17234457b6e.0.1795448208292; Mon, 23 Nov 2026
 07:36:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122045319.18651-1-irogers@google.com>
 <c7a81b11-73de-49dd-b38d-76aabf193dc5@amd.com>
In-Reply-To: <c7a81b11-73de-49dd-b38d-76aabf193dc5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Nov 2026 10:36:36 -0500
X-Gm-Features: Aa3M54rvn7dkOhohcibCJnEbcJ8Ls1D79SvQUldxYdV48pGWUDZbdwQoEIZo65U
Message-ID: <CADnq5_P23gnpD8eXOF-hOE3bjHcffEOQdwvfjY9xMsF_Awbx9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/amdgpu: Initialize r in VM and TTM buffer
 helpers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Ian Rogers <irogers@google.com>, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

On Mon, Nov 23, 2026 at 6:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for both pat=
ches.
>
> Alex will probably pick the patches up, if not please ping me again.
>
> Regards,
> Christian.
>
> On 11/22/26 05:53, Ian Rogers wrote:
> > Two fixes in drm/amdgpu for uninitialized return-value regressions
> > found via Clang -Wconditional-uninitialized on an x86_64
> > allyesconfig build:
> >
> > 1. Set r =3D 0 in the 'else if (!bo)' branch of amdgpu_vm_bo_update().
> > 2. Set r =3D 0 right after the while loop before 'error:' in
> >    amdgpu_ttm_clear_buffer().
> >
> > Build-tested with LLVM=3D1 W=3D1 (-Werror) and -Wconditional-uninitiali=
zed;
> > not runtime-tested on AMDGPU hardware.
> >
> > v2:
> >   - Keep 'int r;' uninitialized at declaration in both functions so
> >     future missing-assignment paths are not masked; instead set 'r =3D =
0;'
> >     inside 'else if (!bo)' in patch 1/2 and directly before 'error:' in
> >     patch 2/2 (Christian K=C3=B6nig).
> >
> > v1: https://lore.kernel.org/r/cover.1795106955.git.irogers@google.com
> >
> > Ian Rogers (2):
> >   drm/amdgpu: initialize r in amdgpu_vm_bo_update()
> >   drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
> >  2 files changed, 3 insertions(+)
> >
>
