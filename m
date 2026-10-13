Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E83CC6B2D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C194A10FD4C;
	Wed, 14 Oct 2026 12:47:43 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D2610E988
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 18:53:28 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so1930139f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791917607; x=1792522407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6uHSuilvp2mAkwJzE4SLZGzkee7OXiQde3++1N2OoRk=;
 b=CQqOEx4mytQ1oPhQX4G2ijs6YuCguChHV3A67fleL/sktK9HWC2nlzHoDb3K/NMTcc
 B70lhMn8JoBvaTZkragctjV7o+mhafQSGt8rtXeBZbUFOYw1Uh52QC6JhShw7JQO+M9p
 IzqNHOjIVahfTba1sdXXIt0NHqY7TA8NPYdLIH183xOZ5Lt+aCic21V/oFKqGo1HmBbV
 7OYoS/IQa1PBrpqpn+mVwIKcTPFKatgf4jh3lx1O8ofoicIIjX04mM25XeM5j7iYB4qB
 C434KfTi8KlC+JoWE33LBS5RLZOcksYloT5RY7gT0ubv/ibYrokNA/W0MLc7ULFzLSBg
 uadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917607; x=1792522407;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6uHSuilvp2mAkwJzE4SLZGzkee7OXiQde3++1N2OoRk=;
 b=UB+0RZOkS9qK+Sykd7HwzhAUE8FjGlsD2Z70cHXeAA5n6iw7Se5e+TswlvtZDGVACG
 QWdypoWAnRfL1khSE0R5qv5drYjUZrTfUY1Vu0E1naKrd6T/Ae2kJcTz8CfBUn0t56Cu
 75wctQwFZgz2JjJGlN1mg7wE/kG6KVoJa1XlfKnMYU+MXCekbh7IjPLfsiKZs8SyBUTg
 4Hymnn4amwXAHdHMGzIPtceqTqiZnfXQs2rfIV9ZBGrd0IGjNrLUqcM8bCnD07o8HaRj
 eVBOEpjGHRLFTiWbTULiwBCHXsisEM4+CnBmwdNAz+YwIMSLqR+WtXLJaOGD8pChrRNw
 oc/Q==
X-Gm-Message-State: AFq9FYJo8g6u65vDbniylq40gU1nyiqA8+9Cy4TFOD6MavZqwL0hBWFT
 iMtU2nid1mPsEQNDnCNyENjM81siHFV3B2tTdSZh3Q/Y3y6WHhUhIiGSRrMSVw==
X-Gm-Gg: AYBFou11wYiubs7HGfGtWRkUAh3QmouHPGdO9OwOgs3q2AYClqRxEg1iNLMabLosC30
 WPv7GwxsLceNHU6BptTUNyWYbU9+3fi6ioGt2MDVmAGYuPJp0VoFoi+ntXlATgQtB85pAVwVg2c
 RR5bKF3fFqrStjxsXYtuUUb7eY0ebcm06y0IC9w5bMO0YlLj5tLgvZD7Dpu0CdZwTXXwjk6yH/n
 +xKfYXOtPvjcdgNt74Zvb181ed9GU6oAajXefq6ZZ4/NkRakk+R8kwkJh4S8yQiGtMFA2BNBg8a
 nZPivl7e3muJQkouvEacDPmC0azng0mTn4/sHrKzMJwaRSM5l57HQ7yiQk/w64iNd07U7CUePtw
 LMkVznpL2KgwqwnkjvhF1FTW+5CSjq7OH8X+xMB0MZPSQAKFiia5NSzzh+S5lrfAhp86+dSoTPT
 k0+41+UV8m+kfeDOR1kRcbd1ZupS7pnkFLrCtSYIBDZ1od1YzpLmW4ZpOzdfz9Si4ZlFyD0/zYe
 SrwOl0jqJYb646TsmfdJiNeixhQGMzSgZ/sfvh6+P0qASuH4kSuvispsmOBjTpXxxl9W2p9R603
 CU0mg3eDJI6d/ZZs0aCykH/F+n9xXF+PiC8I9Zppp9dSfS+vW9b6vN6p87XiAoHIuuSkYk6kDDu
 wrw2YlwzXd1Hxl3z00qq3q4NZZC/UehhrGZfpV6W3bPabW2crO/VxIuHE3rSQdjn6Zovos0S145
 XrRkA/50Q/iEeZZQ==
X-Received: by 2002:a05:6000:491c:b0:488:844f:6034 with SMTP id
 ffacd0b85a97d-48dbad474bamr25740711f8f.48.1791917606884; 
 Tue, 13 Oct 2026 11:53:26 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de77b35b5sm983016f8f.21.2026.10.13.11.53.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 11:53:26 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
Date: Tue, 13 Oct 2026 20:53:24 +0200
Message-ID: <20261013185325.33682-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <62280d57-3f63-4979-9e4c-f0eca7208b19@amd.com>
References: <62280d57-3f63-4979-9e4c-f0eca7208b19@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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
