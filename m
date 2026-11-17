Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C0606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHLubJkJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3034510E259;
	Tue, 17 Nov 2026 14:41:59 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2CB10E61A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:41:52 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-8231ccb04a0so534221a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 06:41:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794926511; cv=none;
 d=google.com; s=arc-20260327;
 b=hjEOZeWEyBAGakyCFKwh3czzLQITXjWh4kmcT4SHC8O2KCvvxcUCxOKR5eVKcSETqO
 UXm0ukd61T0UMW+hEnAuD0lP3UC59iCoT7MopY2ySM/QE9CAA+bwAyBnT+j9uIs0Wrvb
 LXoqJyCPYzjGyxSk3pccJMcU1UTkQBJbt4FpadV4ouU4ff0zWEgFtorviJ20QKIN8cGu
 b8+4Q8FPk0Z0CrR5L9seX7pegnwMAtUJCZHJ1s/rC4Q7+gUuBa1aDxqFrQBLzLK3KIRH
 WFVUdNX5Nj6CiMgSOx+bWLHOLiNDKXYlarpvOo9M/RViNy8qgyylNA1YJWI7Awj1d0C7
 17pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iZ1WITdH/c1geDBibv7Uv+Kn7Pyb4iHI4cWcVnnfvu4=;
 fh=/E0Fzk9PbHpSYLTBPKRhY3alKtpG372bjvCZZ/g3vYA=;
 b=PHLZVbjyAnWcQy9LK8bf8Qzccfv0b8atRezEMhw2gKKcw1sigPDwm1/Lx/KCSDK42d
 mfCTx5acCVDUrkvywW98yQXz7vOLjNPcDN3WIuqd+o45xoelhijh9/lQgk6qmcYVzZsY
 CN7M3aSkVoKAfyvHKCM5FWwtjefLGnq1QWvNx1DGOK/jEA6MsytBNN2ASp6iKCJIX1/9
 2Y9BFP4UHJdJCV9RkRbsDB4BUqY7GOlS5Knw4s9ra29MMDOuCSwfB+SHlIbv7DJMsrm7
 FiPcPQh8ZA0vJZLsX9otgN7FG/kZc57fy90qD1OLPmDvlNWO5rspOy0WKZgc5PeFjguZ
 Almg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794926511; x=1795531311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iZ1WITdH/c1geDBibv7Uv+Kn7Pyb4iHI4cWcVnnfvu4=;
 b=LHLubJkJBatgeMAAA9UxSvLbxPTb7Cg8v94MwTlkBfyKvvq9O2HjB9u2JKZ+8hqVFh
 XMjHoZ8r89fFSQuQQmPW9sPXDRQgw6pK0hToKw1Ze6Z2FqnC+mESb1Ce10TkHnegPhej
 pEXr4yS6/rvWZvK/kmrHIbwx5r7+buu0vnyizBQyXLNwK1TXY4BrdSVu8v6+/+uPsAHT
 +mC6yljRj7/iO323eHqGhPhVU/JEVrQyKkBY68fVbwH9roLVm7uqpXXTpoggdDVxGoMD
 Y/P0rRufAOSvuxWy0KfNOFcsPKvkZZ6QltsxqVhXkJPsPf1/aF4dveA0C62GYm39+yxM
 ZgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926511; x=1795531311;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iZ1WITdH/c1geDBibv7Uv+Kn7Pyb4iHI4cWcVnnfvu4=;
 b=fFTqbhrgJpft6bpljOH0B4BPEHJLY4g0TQWrhf51n+yacvUECn8y4C0Qam00Oui9hf
 9/Vvqq1Dp1yDV+TU+WnkUkaHL6ONwQIEbNKAl/6bkgf3cOVRDJx9QGQ+4prky5Be0cTg
 VjmbwVzQvwMagIq/frytslClyqwLib5RZ9gdYHCCDRZTL8/YNcSWzccJDOahzBU7jfA+
 9vUTDwBv0nPnX7yiX3Cyv/WBb14SKHJ0YGBHhZaZP5ncXm3y1bYF2HV/zweepz/rynr4
 iuG2WHH7L+NqnUWndPkKd0W88tQkFo3uS5guQwh5etNmYkCKxwGRNNj+Q7ohTjGGcvY+
 PjBA==
X-Forwarded-Encrypted: i=1;
 AL+hErEnMLxcn5qTAjC3VNBGh7FimEEXP94AspClE017BONaPrmqplbMzWlqueLTOYd8UdUD84eCiQZm@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Vgj+GLuY/1FgZeYXJz+8LS9DTW9ew/ttznsPbVPFSEdClcsWp
 f1CNSEmkWr2t5p0cKJmLGMhWqA76NuoiLnym2SNuh09QJONGttdGQ/aUv32PD/7l9bcVMfTo88C
 7eY6S7guTbfT3FgZ7RLDaXbMfsobzQik=
X-Gm-Gg: AYBFou1pF1F38pEji11G0IjL1/HUHRr5YgbAjmMoxbMhZnXcvLE+T2j0zZn8EwRebPm
 DeUTbGcAC14dGEzxXWKS8ABW9+282bnj+LhBqYsC32h5svZQV7bTkhFE+4gX1LvzzAha5E/aflJ
 vgity3OkC4+JOFfBxdqBeSzfddCsEufxZp9/QmSNpHsZI5dkp5PHVh63BN9X0vgBuM7Tt89t48+
 yM+ufI4Rm4rF+twvgftDjLT+qtsXYyDbIsKnL2roWqF2mGXB5HAwg9W1YHoXR+r/RlncjG9a1Z9
 iCLgVAlIY9/es8QfxPMIMrLNHPfP8jP7MI6QRRUx8uMBAoCwO/8mWVispCfEqGI5v4/BPtzwC12
 mu6HuX5QHnrkkE+EkNirN+23yTD/Lf11jXXKU4CZBOrdMFfHV6pMZDWr1xn9KJ5MHJrZ5S3TjkF
 sI8N3ftT3dSmrtB0I+E2xA2oKlHJ+Maut2bEZhSAoaztXesLyg/xxfnIjG8l0=
X-Received: by 2002:a05:6808:1914:b0:55b:f88d:baa5 with SMTP id
 5614622812f47-56e66a9517emr17257457b6e.6.1794926506718; Tue, 17 Nov 2026
 06:41:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793787406.git.Priya.Hosur@amd.com>
 <abbf127cdaa05bc133605a961ef912dd773dab29.1793787406.git.Priya.Hosur@amd.com>
 <c2f078b9-0b5e-4592-b53c-9644307397ab@amd.com>
 <20261112123110.30048-1-Priya.Hosur@amd.com>
In-Reply-To: <20261112123110.30048-1-Priya.Hosur@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 09:41:35 -0500
X-Gm-Features: AclHuK_wR_67rQVybsI5sNHnFEE9N4KV3nTg3OK3k96MZVvrIhw7TotjgVrfb3w
Message-ID: <CADnq5_O8_jQtrWs3wuAzuo3pmr21za9ZuoOJU8TL_RzY8VZM0Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] drm/amd/pm: restore the forced performance level
 after a reset
To: Priya Hosur <Priya.Hosur@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 Lijo.Lazar@amd.com, Kevin.Wang@amd.com, Christian.Koenig@amd.com, 
 Felix.Kuehling@amd.com, Pratik.Vishwakarma@amd.com, 
 Veerabadhran.Gopalakrishnan@amd.com
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 7:51=E2=80=AFAM Priya Hosur <Priya.Hosur@amd.com> w=
rote:
>
> Hi Alex,
>
> Adding you, as you were missed on the v4 posting. This has Lijo's
> Reviewed-by. Could you please pick it up for amd-staging-drm-next?

I've picked this up, but in the future, you can just apply this
yourself to ASDN.

Alex

>
> v4: https://lore.kernel.org/amd-gfx/cover.1793787406.git.Priya.Hosur@amd.=
com/
>
> Thanks and Regards,
> Priya
