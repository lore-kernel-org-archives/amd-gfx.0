Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D02CCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38F7112458;
	Thu, 15 Oct 2026 19:30:45 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F297A112466
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:38 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so50571905e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092637; x=1792697437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=61HIykTeBNZRs0ZQrV5P7uqZizEcAhNI1NhW/yShyu4=;
 b=U9wtpG2Tkjs8uztCEzBeqjm9zRG9+QkFokdriHq81nTD+OdRFkA+LnyeQ804W599N7
 /+tpk8VOtCTfGchIG3yiMcJJ8Lx1yTo1ijZOK4D7O/qJzoltqzbzjeNXuyx4MVDHl3TD
 ++JnWECY2Cax8occb9g2NmZMwAO5tXf6CVEVQzNxylL+GCa7AVWjm1FYzJVZoW6gLo8t
 0aJd3xFnFdD2kdvnp6kBGeqh/UrYEXYZhDvpggF7Oq4s0hxwA/wExbPFuUtx/MkKe3+e
 cnACVR2uMoEIb0o7ZZZ3MPEyDxwqYlmqMbaDEuwBpU30a36SvBbyIVjgV5MwGrjpWtPv
 8EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092637; x=1792697437;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=61HIykTeBNZRs0ZQrV5P7uqZizEcAhNI1NhW/yShyu4=;
 b=hsUL2G1jMXuUu2OHl7gnQF7+MM+eQWPPwqUrAzgvFIQir/469phWylzlf8S1JgmunJ
 h7srmMUwUvosAjHPgzPUvsZXbaW1VQHkXScZPqbgBdt+PMD8W2nx/2XZcUuky3kQtdAQ
 frBgbW1bl1i8d5DrE+v7vt/9QlKj4Zj2d5Ofh/upG8apP6gff9k6qkvJ6NwpQERj5fnR
 N1ZMpwTRllqVPFd86LdRkxPRt0UyZnyViMSlondXCCpi5FREZFGCNHANtryWruanlRP/
 7vTf01k3bg6k/71rFMxBCNzhiHMwssz8Yde7VSnIpZDFTePNAIerNNcIiSVBtuOHwuLB
 t3og==
X-Gm-Message-State: AFq9FYIUmNQUKrwgYu4ddapWLvbs5oLq/bwyWP9gbnu9DT00M3uGFds8
 WWAzYjjTYr8pV5zU6lcJ2pvCTzV2jGzSlYd63ihecoWILveWO0xR7t6iTyfw4xUb
X-Gm-Gg: AYBFou2Q6WYtgeWFUQp0EdiTf4jO+ujiSZlVWBnPlESSP6X/Yxnqkj0zNNMDtOAqFTm
 DPrSvjrNDpB3mR+PngfdofRnAPjkxUcUtMzzdjjXqSZpeQf6V7M30hDbo0gkIyFlD/wB+SH39TD
 EnAjIQwsQBNvwV3nvwGylNOccrDOctJSbdHNcsJKQUcZ3HhI+alv0CV5qaQinLugyMeuWHIRnea
 BKNKikQSnkWXKhZF6Tzy43nfQA8WB3EtNmUcu5vm5ZcBwDZd8viWZXeeRlgg8HK3TcVRIwOp6QA
 cHAXUhBh+tb2Y4MFb2ikQl+UTgT9z3HS7DkzSyY7NvH++i3fZZuPiQsXQGoAH/NArduSUMjM/1R
 MLtoDBsEAnAKKd1AVQRdr7vfYRqglUV/KE+uwYmxs2nhUtY/Sb+EZabnkTmtxl2oQXEbC8Ajk+A
 vlm7FsI9BKlypxFqSrRNKAgcisxb3LMNwFKAQhTw2nKqbP1xQmn7vPKHNf8RWb98aqBBmWcjUo/
 HUr/pCNDRMdgQMYS6sEserNbg+bi9Wz5CorlY7k0P4fSf/ULlbVe5abbZnJ8ZPNx7+e72kVJtYE
 +Jws7+AQ0h9SAaAhXAmz11FSioT3vIFXEchnlyem1B8SoPlhKoeQ9JAZkOs/59L1kabpo4fBbfv
 TpTaRq9yclfsmdxygehvUgCqvurvBlN4OD4ukAi0cR0WhOHOOsliLKTeTrccpDlnRq/BxZ3LbHQ
 usw+Ql+hWmoCiFROc=
X-Received: by 2002:a05:600c:5249:b0:4a0:1b14:e846 with SMTP id
 5b1f17b1804b1-4a18e446905mr396799325e9.4.1792092637022; 
 Thu, 15 Oct 2026 12:30:37 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ce7a73sm530915e9.10.2026.10.15.12.30.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:36 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com,
 tvrtko.ursulin@igalia.com, phasta@kernel.org, christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu: guard VCE/UVD sched entity teardown on failed
 probe
Date: Thu, 15 Oct 2026 21:30:35 +0200
Message-ID: <20261015193035.86451-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CADnq5_M67FA+T4g3qhxyGTp7UrhCmHaPaC=0tirx647hb5gFYw@mail.gmail.com>
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

Hi Alex,

> Shouldn't this already be handled by commit 1decbf6bb0b4 ("drm/sched:
> Fix entities with 0 rqs.")?  That commit adds a entity->rq NULL check
> in drm_sched_entity_flush() and other places as well.

It was — until June. Commit 2df5efb45425 ("drm/sched: Remove redundant
entity->rq initialization and checks") removed exactly that check from
drm_sched_entity_flush() (and the matching ones in
drm_sched_entity_kill() and drm_sched_job_init()), on the grounds that
"entity->rq can now never be NULL". That holds only for entities that
completed drm_sched_entity_init() — the failed-probe path here calls
drm_sched_entity_destroy() on a never-initialized entity, because
amdgpu_device is zeroed and VCE/UVD entity init only runs in the
scheduler-init phase, after the sw_init phase that failed.

Verified on the crashing build (7.3.0-rc5, gpu-sched.ko): there is no
rq test emitted; flush+0x34 is `mov (%rax),%r15` with rax = entity->rq
== NULL — the `sched = entity->rq->sched` deref:

    +0x19:  mov 0x18(%rdi),%rax    ; rax = entity->rq
    +0x34:  mov (%rax),%r15        ; fault: *rq

So this is a regression introduced by 2df5efb45425 in the 7.3 window —
the same failed-probe teardown was silently safe before it. v2 of the
patch retargets Fixes: accordingly and Cc's Tvrtko and Philipp.

Regards,
  Olivier
