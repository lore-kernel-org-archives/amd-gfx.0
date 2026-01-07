Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1EFCFD63C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 13:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D7110E5CE;
	Wed,  7 Jan 2026 13:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NAUz4MvY";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8187110E58E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 10:52:29 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso6468255e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Jan 2026 02:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767783148; x=1768387948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyoXk4IsbX+mXFn0g5XNn3/4pH8CU481xkRQwI6wE0c=;
 b=NAUz4MvYIwXPAn+m41bZmfDR8NRHkY4bkq6zUV8cydNhquwx/H1QYTNzmrfypIftIa
 kJlPLeZTQWAFMS393lV64GThLJAhbAxaSNqkQv+GXn8M3T1zEYGtpFROAutDp4zhE1nm
 4EPYnxu40ZQY//zFPoqG9HYimgPoITc69NMieQ5YQbhBkcsucVBgaxUqfWCuqktVgJkm
 y+KcTq/l5LIxtKxm0E5hUq9IoA0LZUEz57wujelpmvs+A7WMUeVr3HNhGgzwF2g+lWtX
 Q/hVUH+ByPsKtVEhO518sdzKGp8Bk8/B8t67opodUMGUAZ3LY4hTMKs8CyN/wNHFpNGy
 bXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767783148; x=1768387948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nyoXk4IsbX+mXFn0g5XNn3/4pH8CU481xkRQwI6wE0c=;
 b=tmm52H1/jUdoYcnzt4ZbWT0EnsoRbOZ5RcKD3gfONEP57QRZro3Jonsf3Znk05tIP4
 ojcELomJDx/BX3wJysthGXWDnFvt9Qfc018p+Ygq/l7k5xxyK0g2JICZr3P0nXHIAOnA
 i7mLp9Y8XrswkVlgkgAJWSi3Q8ekJ7pMRgGpAOUDsspNEp2xOFCLAym6I/OBs7p+gYx2
 2xdPLB37ICdKrLaYjlAGcdoefyIAlsrId2PbFnoe4K1xR6KZnbaFLJOkncyt0YtllUQO
 wezK/n+wFOzMnEl6V0X41i9/QO4a7TBEaZdf/4CvORrZj53GaNogzHjScjGhsgtlL6uq
 USrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPBCwhqx9GSAtyuuYZCi+1oNKgu+9QfQ16CkT8bLq6WE+1gPMQJY9wQzDdyWe4mxOQCLTG4Uhz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvqflbL0qWHZnift8EkWZfjJsXJuZsDJjayJCdyYdhYThfoZCh
 yZeNV2ScScfWrDTRVcGtUV7KpiYwQ4WN3lqDtP6QvidprQF1cPq8rEDO
X-Gm-Gg: AY/fxX4qo8SeG3vksrQa8vFcqjxpEdCKHWbO3WHrXzqM21FMp9JTbJ4HS/WjmoPEiAO
 qv4GjI1unVFRwwgSVgEKzIh8RhtYrymVB7uCslW7xrgJ7qOQSdAhT6eJIALcyYMQ9Ne1PUqGxkZ
 Yunh/sR777Mro/TyUGyHpcF1FtfW0PoColKA+ww7d3DFRuqRGYjX1pu7CogVVZRJ7YQb/oi91SC
 RreoOARjDvM2gH5N4A+pWQrFpuK8A3q1uYLyZjTrCotZXb1ZCq423Bv/zkNm359rCf4uLvyznhw
 CZIbuIJ72S2uMsFG9ZT0thPq+nslKoKw9Vru20QzxfKdEDV49/vdgz5UFzH2HmdSEXsytz/Uxv7
 qcq0LmRMGATBgbGnIdl7rRIR0D01E5ty8qQYHP1wsNSPBZxZI0oMVFCNgqvQBR/0qEPV8gb8/V1
 u1XkpNdPZDS+zwdQdweA9z5OsUOFLbvLN8kBMwqU8=
X-Google-Smtp-Source: AGHT+IHL3EPa8T4LtY57ZbvaqYVDxgPMDQ9C9RQwVhu2bQ8L+PoqikKxi5xWl3SgLYwSuxkLp8jnCQ==
X-Received: by 2002:a05:600c:4685:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-47d848787d4mr23001555e9.16.1767783147643; 
 Wed, 07 Jan 2026 02:52:27 -0800 (PST)
Received: from ionutnechita-arz2022.local
 ([2a02:2f0e:ca09:7000:33fc:5cce:3767:6b22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184e1sm90953325e9.4.2026.01.07.02.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 02:52:27 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: alexdeucher@gmail.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 ionut_n2001@yahoo.com, linux-kernel@vger.kernel.org,
 sunlightlinux@gmail.com, superm1@kernel.org
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
Date: Wed,  7 Jan 2026 12:52:25 +0200
Message-ID: <20260107105225.37703-1-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CADnq5_OXJnREtCUhyq4JWjKmih=k7hnc4w_y8mNd3J1g437V8Q@mail.gmail.com>
References: <CADnq5_OXJnREtCUhyq4JWjKmih=k7hnc4w_y8mNd3J1g437V8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 13:52:00 +0000
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

Hi Alex,

Thank you for the detailed review and for pointing out the ordering issue.

You're absolutely right - I misunderstood the call sequence. Setting
resume_gpu_stable to false in amdgpu_device_resume() happens after
gfx_v9_0_cp_resume(), which defeats the purpose and permanently
disables the KIQ path.

However, I'm still experiencing the TLB flush failures after hibernation
resume on AMD Cezanne (Renoir):

  amdgpu: TLB flush failed for PASID xxxxx
  amdgpu: failed to write reg 28b4 wait reg 28c6
  amdgpu: failed to write reg 1a6f4 wait reg 1a706

If kiq sched.ready is being handled correctly as you described, what
else could cause these failures during resume? Are there any known
issues with KIQ-based TLB invalidation after hibernation on GFX9?

Should I investigate:
- Timing issues with KIQ command submission during early resume?
- Power/clock gating states affecting KIQ functionality?
- Missing synchronization after KIQ initialization?

Any guidance on the correct direction to investigate would be appreciated.

Thanks,
Ionut
