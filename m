Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F71BCD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8083D10EF5B;
	Wed, 20 May 2026 08:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbrjWaJo";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBFFB10EF5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:07:21 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso3730900a34.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 01:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779264441; cv=none;
 d=google.com; s=arc-20240605;
 b=TD5AiVlW0uVwfcNGLXgtVQVnhXnvhBhOrKcTAjkNfBe50594wqLrYhzUZX083m2l6x
 fR1hSd7r2D5mavsb1c4qJ0QRe8k/hzuJi+hOJzs7ezXyi3pw7M8L3rfTs2uQyKjeochF
 ufFobEPKvQfJwIPL32IZL0WzTDW9XJgrcof1dVMaTqegG0vimb/CLvS/qqVNApx9B3lU
 4932IN875qqfDbr96kyYirYhseZKp6eJSWWuvKn6n8c6+o2a9t4ZtaSd5EDxXWbk/lpi
 qCK3WYCzvXIqv0i/9DvWTYnSTzo6BVbFfx/9D05KcHCki8bpoSGAzlrtWHVGw0ifPbRl
 RZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ytey4qORX2TbyVZpIBqgx3oRXsMx32wxQcpaf7l+9+M=;
 fh=+urH/NxaHrZ0nJKUSKaXuM0RD60R7CoVJjq6NvNMi0Y=;
 b=Fq6mvY/8ea+ZgdMQcNucYhyTK9vwQ7zPtw5CLriixS96LgqWC8qAoyfTK+iLfoBJqz
 k023TcJpn1jKkHVO8DVeIqPhO6os9TJ6Cj2jtMIgYXeD+X6n99MvUumUxFPXZsbsFwCc
 QZazqdZi90xS2kv0QBvGrq7FMZnJpThvcbAUGQx2eyPFVI2+Zwx75SNmJLF29P5qjX/d
 GObE72rPahx9Qy7AD/R2T1i8r4gYeze1v7QEk8xHSgTKlUmtoFhchoSUPebqf2hK9cXy
 7dpnr9keMn0EKuKfgYQAO0Hdz3sCPHtxXc6FRro2kDtzZu8CsgMAlX050xhyXrce4+Xo
 3oRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779264441; x=1779869241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ytey4qORX2TbyVZpIBqgx3oRXsMx32wxQcpaf7l+9+M=;
 b=jbrjWaJoxGzpQfQHkJGH8PnjwM4tP6vqjfT67A4BuASLJ1NzASjXg5hxosvQ1y3lAP
 75oPDXESBc5gEEBD2Oa2YDVjl/bv/1R9JI32F0/BXlm83gFB24Y6rGAsb5Ux9E+c/voC
 SRaU/9rZ6TntxwB0xL39DOrJHAUUMJqVA+nCUddE8zHRG+PvbV6TjrZe6LyYiDiRCr3J
 UNT8OwVZyPD9U3k3LfadOg/Ook96PWeh98lSMqnqy+47dmfTBx7MU+HtMYnzcBlrkT7T
 f1my/qY5FXD5NRgzOS2jNtED5YbIRIcwx/zZOAKRmNip9JNp/ShHQMgn8rhMjPieyPnA
 9TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779264441; x=1779869241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ytey4qORX2TbyVZpIBqgx3oRXsMx32wxQcpaf7l+9+M=;
 b=OodD7RIVu2FVabOA71WmEflzPLFRUMhQseeBF8HbDyrs+c12IuOiTL+0QzxJALR2gf
 Dygn64M231mZ/TUKDpVq5/spCHPiVPnYzuVqxFvGtd30fV2kwJzTu/GQKzPTJcDgSP7R
 ibaJlkD00ACwWQhi7NScpI3q4a5fELLI4EtETfYK49hu9ikeg05vVePsqf06XPgR8Hxi
 BLdMf2JBy8rtBdqm8HqlsENdX9urvWmTsYEYaoBDmP71if6G7lZ8IDXygShVI/J5u6Ak
 reB+H45iKX29co4cS/GvTc3FGE0A9moKjXnYgcS1yu49pkCwuZb5pFXX4BcWFT19TK0z
 DMDA==
X-Gm-Message-State: AOJu0YzWCO+0gRo7Sb5chXAQiVWxHAeSbFvyMZqbYt6zHI0r5ZfXHI/f
 hUJfai14HbZi4igPyVeiSGEzAAvmah5RooprYrWzn653WpKgEiXvluCFT9Dqhb8LiWs+NvomodB
 QRsNV14B/dto2fViqGsxc2IRuznft4w0=
X-Gm-Gg: Acq92OGvPgdR3q8JRRRSsX+Pa5wPzlsry+4XZ14FnNHjoNbgSuUTgFuFhnXOdfGz4ST
 mGI6SVhibUMJ0X1rV/gZx1iJQPTTBkDA/ScmXhmsHd+Z4NYHVYHwL5JXaKkhWnaJ1lJCWWE42zd
 /XPx3CwjYC869So+x0tPY0Yo4rbrqLFZNz2b51kxzeoAIQTGI3A+g1dDnL7MIPwgL5eVVhmDvKl
 hGW/2hrnEjh5WCkpag6Y1zQe+a4HFXzJYHy1mnd1ndmyLEFuUep5IbYoI12ADZkCzQT3E0KGwjY
 ZvqtHDSNjg==
X-Received: by 2002:a05:6830:928:b0:7dc:e08d:d9ec with SMTP id
 46e09a7af769-7e4f2b24e30mr16828017a34.15.1779264440957; Wed, 20 May 2026
 01:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
 <20260519161541.19994-1-mikhail.v.gavrilov@gmail.com>
 <45bbcc75-f852-46c2-bcff-8cacb9413376@amd.com>
In-Reply-To: <45bbcc75-f852-46c2-bcff-8cacb9413376@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 20 May 2026 13:07:09 +0500
X-Gm-Features: AVHnY4LjCbKcTkLs9-x5er23_LG6HLKFdPJe4uy4QSmttSvQ2RTUpYxe2TP8aBU
Message-ID: <CABXGCsPRY+jk_ArYMOXqNTw31W95FBgNzqFq0_pvi3paYR=KDQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
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

On Wed, May 20, 2026 at 12:08=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> That whole infrastructure is superflous. You just need to modify amdgpu_v=
m_lock_by_pasid() to take a drm_exec object to lock the root BO.
>

Christian, modifying amdgpu_vm_lock_by_pasid() to take a drm_exec turns
out to also require converting its other caller, amdgpu_vm_handle_fault(),
to drm_exec =E2=80=94 most of the diff is that conversion, not the helper i=
tself.

I can:
 (a) convert both in a 2-patch series (handle_fault becomes
     drm_exec_init + drm_exec_until_all_locked + drm_exec_fini, ~30 lines),
     or
 (b) keep the loop inside amdgpu_vm_lock_by_pasid() so handle_fault stays
     a one-liner =E2=80=94 but then the devcoredump caller can't add the IB=
 BOs
     to the same ticket, which is the whole point.

(a) seems unavoidable if we want one helper. Is that what you had in mind,
or did you intend something lighter =E2=80=94 e.g. a separate
amdgpu_vm_lock_by_pasid_exec() leaving handle_fault untouched?

--=20
Best Regards,
Mike Gavrilov.
