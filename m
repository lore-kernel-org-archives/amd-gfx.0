Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AA0CC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47E410E3AA;
	Thu, 15 Oct 2026 19:30:12 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956D910E291
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:06 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so50566315e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092605; x=1792697405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lzKagMLIVwwP3008dfpthjNFDgkHppRssPgEepbu2+s=;
 b=p/4w8gHC9Luh1mpAUnM5Jtj7slRAccI3hHu/UsRH3ZsplYR+ws1MtRM+fcu81/aeUI
 uYX2eqUEfMoQR5FO/tn/Z/gMPrR+uG3crm+Ewsq+hwW/YwU7ttEiOCKOFsbNAMiZpz/S
 xb82bYsRWbzNw53pHNCEBhAelSmfO1UczTCaWg/lTA2Ew8eKP1sym51hoEcSMnVdnrJe
 J9ceLQzOkAuFQLfoRbQNsaeAo6uBhl11rq31yT3s/BPWjPTTfK0PrGxgVrc2lb19D+vc
 2F98wtZLev4VKTqpNd5w6j+m5dNYMGRl4OTQCEjB2hv3Ne5pAP9jVuebYBM6+PWGk4VE
 qekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092605; x=1792697405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lzKagMLIVwwP3008dfpthjNFDgkHppRssPgEepbu2+s=;
 b=MZlGNzWgiDMormJlDjXZa6aVQft+vYEQZiYMpMe2ZizlQ40sCIpG0tw/uUAAnytNbB
 wr7PTG/5of958e2AuyetUk33cPNkXUGNrB5tb1E5UrBB4kfg7T4aZ/HoAX/yQ7zb+iGM
 fLPGmVY2rbfiUoZPTYtCQgv04B0EtvIRmfJSfpGD8hmQSU88dUw3xIH/00HeuAFJFnbQ
 utrKYPgvfxowvehbvRvSBEiWenNWhUbrozhSiHVQhyI9UgukJRH8CMDT2XyuC05AuJmG
 zWohMnnhh//bQT+ir4jmlqiV45G/KCnZoWPcoEC9UFGbkaM+gm3GQnAhiLmyKzvB7RO3
 mscA==
X-Gm-Message-State: AFq9FYLp3wA5yb2pKHcgMElJDrw4s1iXM5NwL0acI8tBR1AhFlPKPHP0
 V+nV6MAKoFRL0oZqXQw+7l98/kroBi6muzU1f8fo+7M6AKI7hMVJdPDlJt4dug==
X-Gm-Gg: AYBFou2AWQOjxcwi4beqfLEGCmCeeJJ9IgrdQD7chKh82kdTmS5mIlAjYcyXeuRgPmG
 QRT/vH03nmiKyFrDas14frQYq2rf92G+14VpTaV9ft2aqLz1uHuf2CJwXK7s4aAduqLBNV/xhRE
 luxE/8iMrtMt+xSjoFVsczyG+S+EPGO9HHmtDcRml3fnQjWOeNxWuPaL1oCgPhHUzZR1c59yzC1
 di/O5qaf+R8I6DfxLe9p4q14bVRc92/OKCOY63jrntT8fHJ+47QaEcBOmqQ4Sjf3Ie+rIRfuRs1
 Ahv4tUjVBlpycX4sIX0uZRlbGTfMSzDJdJ3icn/tqqMSo/BdIDyXVsrOx5Lvgvg7TcSwSk33Pvm
 k7GjBf7dmB8iivSRCtTnnVwFo8l9JjDP2KNu+zuQg2y4J1j9m7lWQsOsiSq0HDJqNX6m7ZmXWHh
 1b+5G0FZi3kKs7M58Fbk0qgraS4lIfhg/+vaqWgR6xwAFD8YI9j1eu0GPbQEneS7L6fOO83g5sg
 +kWa92Sa7v7fiO3zagIJVGt62E1H3R1LZheEu/qEu02OvSUhR5lWlCXe5fxc1bjpYpnDlMyAIYL
 BlFtL5/83ytipEKLzPCor+DdokVwQHo3SgWCBvd6pZCHcjejP8IprClpz9mZ6y9T+oBdQKSvnXc
 ILQtdbVDlJKvPkkUYja3mW5PfN8Qj8Xwv66abEbruQcUw/81dNh/qoV1Ltazo69JHey6RhDxBAf
 usEnMNFZkPCmrQTj3b
X-Received: by 2002:a05:600c:1908:b0:49f:ce73:5e94 with SMTP id
 5b1f17b1804b1-4a18e4dd018mr395769455e9.34.1792092604661; 
 Thu, 15 Oct 2026 12:30:04 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a9ea3bsm956705e9.0.2026.10.15.12.30.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:04 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com,
	felix.kuehling@amd.com
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
Date: Thu, 15 Oct 2026 21:30:02 +0200
Message-ID: <20261015193002.86034-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <5028b598-b039-46b3-b4a5-9563ab0a252e@amd.com>
References: 
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

Hi Christian,

> Yeah and you need to fix the fence orphaning and *NOT* the wait!

Agreed — found the exact orphan site. drm_sched_entity_push_job()
pushes the job onto entity->job_queue first, then
drm_sched_rq_add_entity() sees entity->stopped (under entity->lock)
and returns NULL: the scheduler is never woken, the job strands on
the spsc queue, and its fence never signals. In our repro the dying
process's fault path submits the migration job on its own killed
entity — it's the process-kill race, not a device-unplug race at
all, which is why drm_dev_enter() doesn't cover it.

This is the same failure Tong Liu reported in August 2025 (task
hang after job submission during process kill); that fix was
rejected for checking entity->stopped without the lock. The clean
fix is not to pre-check but to handle the NULL return while still
under entity->lock: drain the queue / schedule the kill-jobs work
so each stranded job's finished fence completes with -ESRCH.

> Blocking for all fences is correct shutdown order.

Agreed. v7 drops the timeout entirely — unbounded wait restored.
With fences guaranteed to signal, the copy_done error path becomes
genuinely reachable via the fence's error status, so the error
propagation and migrate->dst rollback Felix asked for stay — now
on a real error path instead of a timeout.

v7 is now implemented and tested on this machine (7.3.0-rc5 +
p1/p2 teardown+restore-stop, sched orphan fix, KFD fence-error
rework). Hot-unplug test: svmhog2 mid-migration + a second KFD
process, then Thunderbolt deauthorize. With only the sched fix
the host still wedges — the kill-jobs drain prevents the orphan,
but the unplug path additionally needs the KFD teardown ordering
(processes torn down before device early-fini) and the restore
worker stopping on -ENODEV. With the full stack: fences complete
with error instead of orphaning, both KFD processes get SIGBUS
and reap cleanly, device tears down, host stays alive, and
re-authorizing gives a clean re-enumeration. So your direction
was right — the wait was never the bug — but the orphan fix is
necessary rather than sufficient for unplug.

One question on layering: the push-to-killed-entity fix belongs to
drm/sched, which is dri-devel/drm-misc territory — do you want it
as a standalone patch there, or kept in this series? I can also
guard the KFD submit side so it doesn't push to a stopped entity
in the first place, but the sched-side drain is the airtight fix
since entity kill can always race a locked pre-check.

Regards,
  Olivier
