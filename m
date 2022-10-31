Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC30FECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 14:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DE710E2D4;
	Mon, 31 Oct 2022 14:29:32 +0000 (UTC)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DD010E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 14:21:33 +0000 (UTC)
Received: by mail-il1-x133.google.com with SMTP id g13so6290650ile.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Lhc4EkblHbbPD+96+0PH89wXhgm+3piSxAQSO0JjnxM=;
 b=tjGLldjIWv4CZmbKOjBjCVL2P6AtW9jdRflT4ONyaR2BLdWwfrOP8rW+Y42DhyBOu+
 NdSErUwhGEUrHYcP/1B0UKOFpMpVV6M8vH4j8U5WvONlQFetEG8KZ61AawGLHyOl98h+
 4Mf9MRc+CjFaJNoebRZhOuFAxdEK7uTaO8XiSmNiTYkLLVq2OvpuesUogdvUVtA5dsqN
 DNISFnyaBth3hyNkWjBfWYdYrAlS6EsRRi5hAJATU05UJxw4nhKytKESe+E3FSiQYy3r
 8Yh0Bvpj3FS0+F2xZAXe2Xqiwbkcb0QM+7d2hPKZCecFy/xlHdGga24Q2bsYO02XtMya
 HBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lhc4EkblHbbPD+96+0PH89wXhgm+3piSxAQSO0JjnxM=;
 b=LC5sBgnC52TjhTGFF9mWdJLaMmDvWD7DHS4jugdHjm6ul4Px6lirWTwF2na9VEjPws
 M0XBml5QG0M4CtJEFOdRyYGeI7WzGtSVTyFIfiBtFcNvMUOu2Swu5A1pqXIL7rKZHM/4
 Vm8Jx8NkXDEv1p6RCgcVPDp7tuxhumizYlnI77PuyAyKhX/CVm3YVCLpd6mP9susOysL
 JpqyMbGC+pXazPfr4uVItbp4ZsgMCmOWE6oRdQj6IWj9sfxBIxVzn1gEnmz8IPcz8LfL
 QKOGzGyUx85LTNKgjGTRTrNIn2dtrLP664Len4WVfqC8V1O773eYJknPGtKYMJnqjnBO
 BcMQ==
X-Gm-Message-State: ACrzQf0fFfzCuqpLPn6DB1lJUqtQSRum/LnJ45PopfZFktL0sM90ctlA
 yGWbO1E5bcRokiVskhOJpZzoB4eEBeYtAgeO37OmAA==
X-Google-Smtp-Source: AMsMyM58rQ+3W7cjTjvM8lThVWn9iA3CBttiqPa81bN4d9JXmcuY3Zl83chUpyB15+SM2jaUUuvYqMwX0McAWR3Jg7E=
X-Received: by 2002:a05:6e02:b4d:b0:300:b1ee:c17e with SMTP id
 f13-20020a056e020b4d00b00300b1eec17emr1778319ilu.101.1667226092159; Mon, 31
 Oct 2022 07:21:32 -0700 (PDT)
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Mon, 31 Oct 2022 15:20:56 +0100
Message-ID: <CAG48ez3a_35R48khgW8D1MxokEqmYP3mBsUwhMq5Vfi5BiyYCQ@mail.gmail.com>
Subject: [BUG] AMDKFD: criu_checkpoint() error path treats userspace pointer
 as kernel pointer
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 31 Oct 2022 14:29:26 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

be072b06c73970 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
added an error path in criu_checkpoint() that (unless I'm completely
misreading this) treats the userspace-supplied args->bos (which was
previously used as a userspace pointer when passed to
criu_checkpoint_bos()) as a kernel pointer:

  ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
      (uint8_t __user *)args->priv_data, &priv_offset);
  if (ret)
    goto exit_unlock;
  [...]
close_bo_fds:
  if (ret) {
    /* If IOCTL returns err, user assumes all FDs opened in
criu_dump_bos are closed */
    uint32_t i;
    struct kfd_criu_bo_bucket *bo_buckets = (struct kfd_criu_bo_bucket
*) args->bos;

    for (i = 0; i < num_bos; i++) {
      if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
        close_fd(bo_buckets[i].dmabuf_fd);
    }
  }

This seems very wrong, and also like it's guaranteed to blow up as
soon as it runs on a machine with SMAP, which makes me think that this
codepath was probably never exercised?

(Also note that just changing this to copy_from_user() instead would
still be wrong, because malicious/bogus userspace could change the FD
number to the KFD device's FD, and the VFS assumes that an FD can't be
closed while it's being accessed in a single-threaded process.)
