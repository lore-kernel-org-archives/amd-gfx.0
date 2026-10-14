Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A0ECC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 10:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3758D10E1CE;
	Wed, 14 Oct 2026 10:14:23 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9217B10E4D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 10:14:16 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so33647735e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791972855; x=1792577655; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lzKagMLIVwwP3008dfpthjNFDgkHppRssPgEepbu2+s=;
 b=fIHewOyM1uWduwL8RkU4uE5Xk0ks1eh9oAxZo8jfXxetaortAo3b/9uEWodft+LoGB
 U6cTfRFn8eDVlO4RnLtQldCkprEKTURybjJXRkBjmTtO31u17X26wUCWzHXQqHYhk/No
 /NPhEcH2LzyG8y4VPLx4TTfnu5RIw5wx7OH7DbRPgHA7uh/C96qfhM1nFKoJ2urit+62
 qYR6UlCQLqT9Sp5vbR6chsQehOI35onCA5sKAXHhUOn/K7rKrtr8J5hhCSA+6bdQhAZo
 2ZZiK5zAf6ET/5BIgZJql5k/2weJMWEtFCRkrTo6c59sXIkJ7AaldCsgn0aV0bak/46I
 DGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791972855; x=1792577655;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lzKagMLIVwwP3008dfpthjNFDgkHppRssPgEepbu2+s=;
 b=rH7LQO44JJjh2ePQ+cu0SES7fRd9QQdYw2UT0liIbLPQa6M5wKcD1a2xSb7aO1617M
 0Ha0l4p268LeNl4dqZm5I9jjh2I9cD3dsVfLRFLTzdPpqceaUIEArCU85ItwOMZNmgJF
 +fIFwEAsNtSFPBBl8WaZtaLa6a4tLmmYqzQ8rlrlwD71Assw8+g6Rq2ReXKmqyKN27+w
 I3JQduxj8DI6sSxwVYVhWnJd37UVNjCeAGO6CgJAxxp79QSV1zbfoJqIuiviCaXeQok7
 fn2fg2kmSTf01Abj7j7m1E/lZaGwsYfUHlLINUubd5Oq1dfoJLnEguIzVLLMyWDxyzam
 o4iw==
X-Gm-Message-State: AFq9FYLd8/w3q5NGoWvy+fuG8ndOh5gFDm0JbfTOTCBAGy8KwnfgVVDa
 5L6VQAfIXQQjZCNkqBvCEn+rQQs7oodI+/1CoiOy/D10BDnkapAPRTeHB/4GDT5h
X-Gm-Gg: AYBFou3bK7agLNbJcsCfMqh5609swj8P3fADh9CCD4SYA2kdoeeunvsMS51nRpfZkOd
 KWvFCQXun/6aRXcr7jQtY9ZPIj3RB0INIe48H8NeyTZKHdBKgLOfLXFMBtOyYujHTYcMuPVfRli
 zqdCKYsJbc+a6ib1ZXUTkP7HzfkzVMJYt5By87oaVfljSN4Elsad05l7HGdnCe1nHeSWWlqGP7a
 ewWFhJKzSNcFxUgIWKAnZL0WcsSWpSd26TwZLlTmP0ns/icnLrtTe2asSA03xt5N78hPBSvsrNY
 R8MqA7laPlGZGfpXO7YAX3+CAVDFqoCGmTmVX1izREEvGAfUkOVeVdaW376V9LODHfAadk+f3k+
 g+E8jW505VYbKhoWoC5bX0L3b/wLcNk+sNCsjn8P6TISfbd/giFLfLohFT3XO+CF4wXYPg+LrQ6
 UCHZD78ORjRbYo+2VO322qrS4RiwjVF4YxAgjq3KYXEjrdbKeCYRY9WpJUUkqhjex5xDm4+oITL
 RlmpYYDZi2MSKVVR3S3TtkJIijxaLec1nr38RKOYQn4qjm9eNQFeUaU9lSYwyqwqq381xAuZ6rs
 I2Gz9GGtrZQNo9KMi1JAjSc374vbkKCFkteWbeWploGj07a0q/3ABt0S0M2hFJ6u8Hv3xSg66c/
 mGpCpgojXITSXWgw0aSaCVAS+QVc5d5M4cMsXuCev9ng/kekuDMwtn3uMWR+W6zPFlu/fAxrgqL
 psI/+P
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id
 5b1f17b1804b1-4a18e4b8966mr281631005e9.26.1791972854710; 
 Wed, 14 Oct 2026 03:14:14 -0700 (PDT)
Received: from localhost.localdomain ([37.167.102.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2d352e7sm54936165e9.0.2026.10.14.03.14.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 03:14:13 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com,
	felix.kuehling@amd.com
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
Date: Wed, 14 Oct 2026 12:12:57 +0200
Message-ID: <20261014101257.74329-1-olivier.kaloudoff@gmail.com>
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
