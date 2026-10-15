Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E23FCCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE88112463;
	Thu, 15 Oct 2026 19:30:27 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB75112457
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:21 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48de6a62a4cso2717185f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092619; x=1792697419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6uHSuilvp2mAkwJzE4SLZGzkee7OXiQde3++1N2OoRk=;
 b=mQWfa6vYEuLVaFyxc1v2Mu6hmdGAdgvHipxh38tZhv7JE23Ri16Algk5R0ViZcyGPz
 vBeE3WxbfhXMP1tafeWDiFvjVP5v0jZYUUaFujPGdLnQ5B1azQ+tNCnNTeKc/9J/yC42
 7fl/mwrg6Hd3mWnbjPmEDo0jsg98kVaD27y6PbaRNHAspuoJ5JV7RYVRNpdmbP3uk4Bw
 eij9BC/lkpnCHFmXMeVVYearFuw7H2kCMjrUzxxNMxIDgQ5sOMPVx+PTT122smra604s
 JQwjCB4/bU553CTc88qxjIa8hIRTnKw5SqH6Ls3YOXUMzjpXsdswoEaCgSd0Ct6VqzVH
 4qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092619; x=1792697419;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6uHSuilvp2mAkwJzE4SLZGzkee7OXiQde3++1N2OoRk=;
 b=ULeqbQa95T8FGReUwbdemqmnlgulJFY7DSzV0XuYeYPrvmOeNKMFZfuSs1OOCsRfse
 sKg4oXgzhdfdIzOu0SXcWvqWQ6cR568wMn+evy/yOAkZjT+1K+1AEIssmJnMq8/8bvui
 IqHvizAKDGBQrK0zXwroNTqrLpv2Lq46KJ9wxEMiOweoMcyYIhyib0uGnkFilOEMJQlP
 hKqTpYBW2FS7hNEYqTyP7FAJtNhcQ2jwsVsZQC0mOrl3qCZiNf10eHbZSAn30vnDfl83
 n1IMqF074/NoL/knvLzk4Lzc7eNBZ7PSMSIUzKkUHHHRkEw/OuJ1PnJw7awYjWom6u6h
 NtLg==
X-Gm-Message-State: AFq9FYJbLcT2je+J0p9XxE+n1mIft4e8AJ5TxXu1QgFG/DmoO51RvPKz
 YHq5pjRaQhj3p+sv+brCoSc0Yai/4fiTkMcdyDdIR1Ldtvnki1BKy/ZMAGDMFg==
X-Gm-Gg: AYBFou2QfJCL8eu4HEhFZ9oj3Y/DHBZDHzE+avDKY7rRzZx0S69MIEvg88QHjbPFRUz
 ZC6+8b1UL+dPURETtADbrvAjanpSP2G3kUCRwSV9fMrNaLcNhBkE/tjIu5ltVP6//YdMngrbYoy
 j5BrZCyLhqhRIh0INFU87dd1TtJnuJqjPjAGDIb2Pn8K5nUCX0FrKY0+4ozH5FnzH7xxEJ5/pMG
 hEEeA93ADJYL5NUj9Y8JKdOb88kJiS/tLE2OVfyN3Wj/CCo7xJrUTT8rwzJSCaai+ZoHSbmEUKQ
 jMBtrzw5ttRfBo4MEHUBA31lIGw/AVYEJOJMBQnNCU71mmfD2ZACvBLWWWB8RlYo+4VJvwMu2ey
 rO+zE2KJ1OoND1xrklIkm+0P0yHiq0BQYzyJyJbhi9H8vaG4lvl0JsZ7dPDm7plGP8ea3hxYaw3
 OW6T3Yx5uSN9+6GgJ+s1rWZ74ELgCHBRWfYXtKCpr5NCQo/Ijqe2pk2awyz9CLKSvO91YJo+XrM
 Aqf/4un1NJSB6PV8KAZDKRnqoNFnpjaoYsT9v7/3GFniaE1DYJk0YtLLcKFan35mC20+cEWDkrg
 77/EQG7yYV1RaLGkVI+bFSmvgP4qGMIvPMzcQBHtYHy0gJyOe+SqBuSV77RsVdrAmey7zVzw77/
 zoDRAj6SKwttVKubrA94g88jcXFpJBeRFz4WXPl1JsDrhnr5EvTOWtoZU9eN31r9ItWQJ2TWWnn
 HUyj1PDtRUJP5SZxOO
X-Received: by 2002:a05:6000:4687:b0:487:36b:1816 with SMTP id
 ffacd0b85a97d-48dba7877f0mr27540162f8f.7.1792092619436; 
 Thu, 15 Oct 2026 12:30:19 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e28bcsm75303f8f.23.2026.10.15.12.30.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:19 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
Date: Thu, 15 Oct 2026 21:30:17 +0200
Message-ID: <20261015193018.86178-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <62280d57-3f63-4979-9e4c-f0eca7208b19@amd.com>
References: <62280d57-3f63-4979-9e4c-f0eca7208b19@amd.com>
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

> Fences *must* always signal especially when the device is hot removed.

Agreed in principle — but the observed failure is precisely the
counter-case. During teardown the dying process's fault path submits
an SDMA job to an already-killed drm_sched entity:

  drm_sched_rq_add_entity: Trying to push to a killed entity

The job never reaches a ring, nothing is left to signal its fence,
and the uninterruptible wait in svm_migrate_copy_done() never
returns. That orphaned fence is what kept the task in D state for
good in the repro.

> a non interruptible wait with AMDGPU_FENCE_JIFFIES_TIMEOUT can
> never fail.

The ret < 0 branch is indeed dead code — dropped it in v6, thanks.

The bound itself is needed for a subtler reason: the wait now runs
inside a drm_dev_enter() critical section, and drm_dev_unplug()
blocks until all such sections exit. An unbounded wait inside the
section would deadlock the unplug path against any fence that fails
to signal, for whatever reason. This is also the shape Felix asked
for — guard HW access with dev_enter/exit and keep no unbounded
fence waits inside those sections.

If you'd rather guarantee the invariant at the source — i.e. error
out fences orphaned by jobs pushed to an already-killed entity in
drm_sched — happy to look at that too, but it is a much wider change
than the KFD-side guard.

Regards,
Olivier
