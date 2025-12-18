Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3CBD68BDD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 05:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D396F10E381;
	Thu, 18 Dec 2025 05:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L95+TKl8";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE3710E381
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 05:15:28 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-450ac3ed719so225079b6e.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 21:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766034927; x=1766639727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6v39nJYUEpnIieIeOUO2Tsd2/PCH4FckO5WSeFV4R0=;
 b=L95+TKl8W7S2qZWTvCfrwJ0YbDzcfiBcJIxz6yWCxFFi2tiDXnIwZ8xnApq8L7deag
 6q+xyVPsaCd21D5yg5ETVQa5sjez/pwPdMwNcTIesA9gUhZs8AJHV8Nqnfaa5ywI+/Ep
 Op4fWrgRG7MGuZA9h9xqKhBOtC2TTqlJOrXTP1ZPSiaW8bwpTA7VCYarClOLsMH6zMBE
 1atGSmXNgezTR0r7CqoTNP7nRkVRRTG89BZ5Pozi/MZpO+4mUsz038nx3MD0eyp2yger
 pz7NgTAhmqhD7AUeCfiDxHyQS2GjGGulnnagXNPiO1y9AuT48LA4frpRizuoCqOwmH3C
 DB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766034927; x=1766639727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R6v39nJYUEpnIieIeOUO2Tsd2/PCH4FckO5WSeFV4R0=;
 b=UVU4PQhgVs52Xr3v/NTpMFccR+TI+ZbDBJDl6WWwqX+do3FxRqeGFB3xBO4A2PW/wv
 0zGYA20Z9wYNTlSiRPWDCtGf8pjAh/5BMGuhfggiAIQswfqBq2DHl1SBQtE8ntPdKzG/
 U8Bp1AS05Z6gwTzm0KxiSgfTzfwvMqrEk9DL/irRxk6ApRygbmXyZTVuXK9ZsHYcJGnq
 7loLRtEd6pQvnkJ+kiRR7STlmAno+ahs5eEq0KNK1QjlMdVmOWacHjzI24Km8nd3PUEU
 XMxBjMpJI6gzLoYb3CnbYxsBenLtf+rBZmMDmIev8/zkXK7eIGpf4cOgke7yuKCueRvj
 VDQQ==
X-Gm-Message-State: AOJu0YzrOs2VqQr9ae5o/4fW//lmJ98ublVA6RGIKl5yRBRs1vmO411M
 OReuZ3wEOlO+tyCY359F+LU+BfxdW4cNEJ66lX99hJmjU7lWGNjmfq7wM/6B/z29jfQ=
X-Gm-Gg: AY/fxX6DINCNcI2vg2vkZrBY2sOEMI1I9cMOfr41mcJ98FMsRQJNHZbiVbDGNDfqUdX
 WwQxXpzZXqDRxA9n0aDOnv2Oe4KqQRRx2SCx5DrqZXddL6rj+ro9/zbc1VOsX18hTJRwtFZi5kp
 x/MmklGl1Jlcc7GDGJOg6O4m548TUk/hLBi+LRlQTGU3eVl34cMqJzHNBuzCK26rMaii9XfZ+nv
 E70B+c/xzR0GT965M7UndLz6OOAoQ+/wBPOhMMshyTa3YF1elKWFbmnOMnje5c4aRhhUDCml8Ec
 GOGxn/wOocln9cN4R2f+pyYcCNBNv05bzj5Lbhk1nqvoog3p+DtytEyvrR6ccmV0F7vKZ30Fax7
 obvAxi2Uey4rug8KOyZIkBoIFQxuWi+cqhBBER+mZuLL+WYK5Mq+Vt79Qgwx1uYEWZC3LoI9dmp
 4I7NBesToy/OY6tMgTWkAKR5ANJq8=
X-Google-Smtp-Source: AGHT+IGlsyDPsJVG4YQ18qCl9beGgK9EpHgjnIwLoJFve7fscHVLTSWSgmY2HBMsYZ8w/F3VHgg9jA==
X-Received: by 2002:a05:6808:178a:b0:44d:b8d3:3214 with SMTP id
 5614622812f47-455ac80c4bemr7464101b6e.3.1766034927407; 
 Wed, 17 Dec 2025 21:15:27 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-457a45d1891sm716243b6e.21.2025.12.17.21.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 21:15:26 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: avoid a warning in timedout job handler
Date: Wed, 17 Dec 2025 23:15:25 -0600
Message-ID: <6025413.IbC2pHGDlb@timur-max>
In-Reply-To: <20251215160711.11832-4-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <20251215160711.11832-4-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 15., h=C3=A9tf=C5=91 10:07:09 k=C3=B6z=C3=A9ps=C5=91 =C3=
=A1llamokbeli z=C3=B3naid=C5=91 Alex Deucher=20
wrote:
> Only set an error on the fence if the fence is not
> signalled.  We can end up with a warning if the
> per queue reset path signals the fence and sets an error
> as part of the reset, but fails to recover.

Can you please elaborate why this is necessary?
I don't entirely see the point of this patch. Why don't want to set an erro=
r=20
on the fence when it was signalled by the per queue reset? I would have=20
thought that the next patch does that, and also fixes the warning mentioned=
 in=20
the commit message here.

>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c index
> 67fde99724bad..7f5d01164897f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -147,7 +147,8 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job) dev_err(adev->dev, "Ring
> %s reset failed\n", ring->sched.name); }
>=20
> -	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> +	if (dma_fence_get_status(&s_job->s_fence->finished) =3D=3D 0)
> +		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>=20
>  	amdgpu_vm_put_task_info(ti);




