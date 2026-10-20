Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A884606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gZp752xD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4B010F425;
	Tue, 20 Oct 2026 09:19:22 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1E610E8E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 00:38:20 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5ead5ff47caso699091e0c.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 17:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792456699; x=1793061499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XMKmW9KiLu9MpTcxC0EPWZi3BOGh5s9tgI8VjLeefU4=;
 b=gZp752xDXVwj4pBa9a3cTIFg4MzmgQpC7y0BKJCOa4quCcnILcO2z0ThpfeqEbyElh
 7EkwSy3KFRjnHn4yV2UQffOLmNiISBAxtMTYgIr/OkqaSTvgYI0GFoM6NHQmCKLQN/+8
 qu57VnQ3CoXHQp7zBp7ww8X7t6WifvafNLeds63VzB8qGH3qcLWOaBgKrsqjtgF94350
 Z9R9ayI1nuNJn2pO0kvaE0pxRpuxl7LpKSK566fM+m/+D+wpFnzmFLaU8+jP9RIPn1/D
 CjLwp7dvMZqfHkKsEDswPUXKvKemyZl1KLLz5WDYhR6zUnGvt9ZbfG3YqBubU6pmQyn0
 Y0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792456699; x=1793061499;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XMKmW9KiLu9MpTcxC0EPWZi3BOGh5s9tgI8VjLeefU4=;
 b=I4LTCxjy7eeu9hUuUWaPAFdXUNnDYN+4LnrptiCPqDfKfLuq3cnNuzR+4aKY2EajED
 0UV07avSI8q1nE7OH8hwlbFTN0I+TyC36FiteTTHUOvjU942wzLH8FUzXC6PPpk3DXid
 qKvcfr9E+0sNNbeKyLzWdFJGMyB6Mv+iQPuO+EQ29zF2y2uQDFiRpcFLOoEoBvt8VGwE
 awpj0jfdBlfB5PruWoMbPcQeEKAEILDze1hRnjJC97mLyGDZ1UHCRMHlhWt1XnLaywui
 zGfM7OCMb26wkaAfM5HirN17kRSwn3IuxE8Vhe1GvE8tyjFdUluao02b6Mmp9AiP82zG
 4YSA==
X-Gm-Message-State: AFq9FYIOMYe9s7pB+vqY7ZRpLfHusYx3F58zPOjqtYCXuaiMd/ntjGHz
 zFUrXWAOhOrd4COOMgIaCJefC8tmWHbcvsf/z0eG758FWwQFwheWTMNtKqIjUDTk86U=
X-Gm-Gg: AYBFou3GPThS+BiVnz/oHKMJ5XE7jIFgKp0sKV/MDLcfraFn7gScMRXIf+dP3+Ue6cS
 O5izyGnEFB0HnDmMxnOC+y2HsIAD2iUY16n1nyUGOxkTeC5u8PJX9kAocmvpvQqcVCKZhlDmP8G
 hYS7oawPtdGxXxzRAfKC00b5T+jzUPSudD9JCP/NmOVsdLj0zCg+9zkSRdMqDsl6YQGPNZcVbnX
 xyePCLC5i53f6pzuS4EJ5xJbdquice5XYzWvsGS/UQOQbd7dF4FthCb2evlLMRNfmTsA1gBR9qi
 JaV/NOhLeMxhtkrpVoZ9FdWmNJpQSYFfqPIeIk5Vt1RaDhY7ixJ94AazNf9A/o0Q7SepztIAok8
 cja9+mCHcoUBtdWzVa3E2N+kT8lH7do9ZRwUmwlsRrD6Uyg7n4ClYretC3+q9UtEEcd25Yhz0Ym
 +NZpQonpQSiBH0l2pjKzhpjPt3GFBUJ2jmf7+WnE7PkNo7eFHV7HP+iMJjUMw+v2p5RVzTULId5
 HeYd2jqQR2mU5QcPolJJ56vONQmpC9b5u1qCPFO3Yds8Zeykb+EQQRrXDSD0ThbUA==
X-Received: by 2002:a05:6122:4f8a:b0:5ea:b100:6f58 with SMTP id
 71dfb90a1353d-5eab10070edmr2376920e0c.6.1792456699346; 
 Mon, 19 Oct 2026 17:38:19 -0700 (PDT)
Received: from welcome-bison.incus ([177.142.16.70])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5eacd020162sm3777821e0c.10.2026.10.19.17.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 17:38:18 -0700 (PDT)
From: Bruno <bmilreu@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Aric Cyr <Aric.Cyr@amd.com>, Roman Li <Roman.Li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Chenyu Chen <Chen-Yu.Chen@amd.com>, Josip Pavic <josip.pavic@amd.com>
Subject: Re: [PATCH 03/17] drm/amd/display: only reprogram DRR when v_total
 values change
Date: Tue, 20 Oct 2026 00:37:44 +0000
Message-ID: <20261020003800.4031-1-bmilreu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002193240.3441018-4-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
 <20261002193240.3441018-4-Roman.Li@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 09:19:18 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aric,

I've been looking into an issue on my RX 7900 XTX where
`dm_handle_vmin_vmax_update` runs every refresh, even with the desktop idle
and VRR disabled on a FreeSync-capable monitor.

This started happening at idle after “Restore 5s vbl offdelay for NV3x+
DGPUs”. Reverting that commit stopped the idle activity, though I was
already seeing similar worker activity on older kernels while moving the
mouse, browsing, or playing video.

Your patch looks like it should help here too. If I'm reading it correctly,
though, the driver would still allocate and queue the work and take
`dc_lock` every refresh, even when the timings haven't changed. Would it
be worth looking at skipping those duplicate submissions as a follow-up?
I realize that would need to account for deferred updates and cases where
the hardware needs to be programmed again.

My report has more details:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5418

Thanks,
Bruno
