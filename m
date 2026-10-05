Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EEFCA5FFC
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 16:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0234110E2CC;
	Mon,  5 Oct 2026 16:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJhbjZ5j";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E555010E2CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 16:56:33 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b08452cafso1392058f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Oct 2026 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791219392; x=1791824192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SKCBX/zPXZW+h0+n3etEeolFk/I8rwuwSTB1BIxIo+Y=;
 b=ZJhbjZ5joFJoULEw9ExW0zIbVYNluF4ChZq4mxlwQJc7u9dQ7mD3ZlB0KgZx04j8Z9
 5AKxJ+35uSgTvKM88/b1MvitFHmDeF5xEH60H/a7vlmzmhAKQo9r3ecSjAvQU4gHyt92
 yb8P+EkzyycNmLUQP3gXTKkecDT0vEFwA/k6UVaL8n7pQ6nLPKPc74rKet2Ifha1Reok
 tRqSPIeXwP0CQJQAIxqrQaJusZtDNXLpX/JvVazh9pHTxgDHfUEmlHxDw0NbmKDIFzV0
 +PHOBq+m5ZEszbxSjY88g5ea54Hz7ObHvOW46Ea/apxklwk3Kk9WEr5Ug9N7VgigSTsa
 zxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219392; x=1791824192;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SKCBX/zPXZW+h0+n3etEeolFk/I8rwuwSTB1BIxIo+Y=;
 b=n4tL+rDrLSgGfuEVjy1qxNAq9wuwL5KGL8rS4adHBtavhxJ/YJGWpA19JzsfEg6YdZ
 wdtkM7r0+ANqoZlMBFoKuIm0djjNb1hPqtd6a51V085W0Rf5yIRmRdivcO2xwDi/324h
 mWNsA9fdDPUzcu7VRxElLlERcOuPGSPlKV5GsmZtzF50xiw1sCm9QHvjNVaFgvLFt9zY
 skpyS7lcJgGcfB7aM3MXzcm5fUqlUmVkNcBumBaZBI6/TP01+mmFyY5u8wM+GK/q4qsC
 Jn5plJW0CcLxJb0ckrnYlMHvl/wCnfkrBhiNi8SnSEGUm+EuiWBcZWoIJvhdP4mPOYM5
 A23w==
X-Forwarded-Encrypted: i=1;
 AKwUvBycwTXUKyXB6QxvltJxflnBSU6Jr6lfenQruZXrq9SXVVWNkcCXfC5liK43hApRXNpZJ42xpol0@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ5XQ9+NJIBciOU3ARK6BsK2tLFoeybTy+85yJioWtVHpAMr5o2
 z5VxNHn3P8kWyCmRIigRNOb4UP5ZMl3q//pkXTfvoPMWIhD18OccCPvG
X-Gm-Gg: AYBFou2DzCZ+TT983T1AcgvZPGyF3QH/58o9eN7OsmK8XhL+mMdoNDE5SN94/wK+Yjg
 rBOUIEYMQ+vC3J+MljPlWvlTc+fiM4eiBfyVsIK0q+VnWlAfeUeRO7IK0QUsbKOvfEoarf3hssg
 8092O9o+JZvogcP6mu8gv1gitwjEm1Ge1BYLrXCkUKhmkURIKA5p92Ptx9sHGdW8FYK/79DWsu4
 RgmAxhzf84juagyYGet29mHnYJ07t+rGETzmy8EzfmXQu8iXjWBJUN3/GLtJMSNZjHE6Dxaykci
 WVCrMlxLO9gBXXp1lQpHJziiPiITpic7+6Ua+3RSifTzHyGjBS38ir0yPZTs/ac+Qt5aPqiNio9
 J4G5Sb4b65xTZYL8OnC6V35BP1h/+9r0Gq+XfK7yuCS9QfO5JTaMoJcL/gZvpIYuW/XplKTjkKm
 IKImb1s4OqvfWiMZraS+RrQCcRBTE6x8S860l5fOMfQP7AO/iBtKE3pIs20lzl/jd9y6mrjXNLX
 gHeSOKZVMNYDnKltWDa0KCP9zlyES1M95aJ341cDlnletmsMX4mwwyGUXIlR7UCAg24NnnkYbp7
 DGMrnxtEFAk3wYF6XOIJhVl424Dgi2ekH+6kAA4u+CXkLyjbjVbtHEFnf17WaHIwdXzM290BP7J
 EaT6jH47uDYrP3fuGJKlAm7j3QnzxRc/y2wtMndwWyZ9F/zNFILeqM0Soiuoip3LQgfWsmRkaAS
 DXSzqbgRwga95dVVNmvb5AYeG6cQ==
X-Received: by 2002:adf:e002:0:10b0:48c:6504:7125 with SMTP id
 ffacd0b85a97d-48c65047180mr2563159f8f.42.1791219391993; 
 Mon, 05 Oct 2026 09:56:31 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:418f:dfa:759c:a4bd:ccc9:9d41])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622bb172sm10037994f8f.42.2026.10.05.09.56.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Oct 2026 09:56:31 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com,
 felix.kuehling@amd.com, alexander.deucher@amd.com
Subject: Re: [PATCH 2/2] drm/amdkfd: stop userptr restore retries on device
 unplug
Date: Mon,  5 Oct 2026 18:56:30 +0200
Message-ID: <20261005165630.28840-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7de6d58f-6037-45e5-917c-6c62b42e00be@amd.com>
References: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
 <20261003063817.36606-3-olivier.kaloudoff@gmail.com>
 <7de6d58f-6037-45e5-917c-6c62b42e00be@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 10/5/26 09:44, Christian König wrote:
>> +	int ret = 0;
>
> Please don't initialize return values when it isn't necessary.
>
> Initialize it before the goto.

Done, ret is now declared uninitialized and assigned at the two call
sites before each goto.

For completeness: every path reaching the "if (evicted_bos)"
reschedule check has ret assigned -- the two failure gotos carry the
error, and unlock_notifier_out is only reachable after
update_invalid_user_pages() (and validate_invalid_user_pages() when
the list is non-empty) returned 0. So the concurrent-eviction and
WARN paths still reschedule exactly as before.

>> +			pr_warn_once("%s: device unplugged, aborting userptr restore (pid %d, %s)\n",
>
> That warning is most likely unnecessary and maybe even harmful.
>
> That the device is hot removed should just be a perfectly normal
> abortion condition for the worker.

Agreed, dropped entirely. The worker now just skips the reschedule
when ret == -ENODEV, treated as a normal termination condition. This
also correctly suppresses the KFD_SMI_EVENT restore-rescheduled
notification, which would otherwise falsely tell userspace that
another attempt is coming.

v2 follows.

Thanks,
Olivier
