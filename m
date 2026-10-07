Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB305CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 18:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B8110E0AE;
	Wed,  7 Oct 2026 18:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AgbJVVn6";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E8F10E0AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 18:11:56 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso46565175e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791396714; x=1792001514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dQEw1o+cX2AO3wMfnB6fJHSQ97wPFTC/Nsk288BUHG8=;
 b=AgbJVVn6Oxp7Bec1cy/62bTm5ESQKV2tE6yXGHuQgUGFaRWBnBBK5A34G75w9wyAuu
 NVbitPn4569fz2iZUiboNhcldwscwqk1yCKRtSKKwYYSPHBwPX8bTrqjkoSubeR6vWAl
 grszjHXL4jvWzGcnswzd8KwCkY8T05EONUKjpPoYC8bMoAKNkp/Yeo9lYD4hFYtNdipL
 uuLggt2OWeL7xmfZ/nyUCKvxO8iZNtJVcy+7zvaxIKtcwXZFJikub1EJe14tutQC9Tp7
 oxYIttmwVGeyqFkXdToFzKOWoSecTQanIP4WgZHSz/l3tRa0cHvM6DQWDppCkSIoCISn
 Lzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396714; x=1792001514;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dQEw1o+cX2AO3wMfnB6fJHSQ97wPFTC/Nsk288BUHG8=;
 b=Apo08Owgd4ydUWCeucfvBu7vl7ayTVXcLgr0Xh4yD68FVFUjdY1DQ8/w59yDeox/le
 YXr4IBBt2/PTmFt73uKrEnN2sZctRov05eIPYxpbN3zzd3/4QCPSPLLRC7yS/GhTQ1S1
 4Szangg5PxS4x537EBf+OJaqxibDmJEgK/Y9YbgwUUSCHhO5foZ/TE6iy8270uAMuszc
 0Qqrtm/ec8NkYv02crGPiihzx6gmjAH8JKp3Vqr2UgIl+qaX7eIsq8BDViLucFkbG2WM
 OYQBnoW+xDBJ3/YnL2f9K63aQEeUl9okLDsXrZEteuWo9ubjy3WD/Y7I96TPK9i/pGnh
 6/PA==
X-Gm-Message-State: AFuF++nbtaVrAukpANcbpbjNAhdGBe7g2fjm2vsF0OJsUxPJoLMk5tNM
 n1ON6Za7x0W/sp2iRcXaXfwAXIau3mc42mVNgEUTTAl23Ruv0cahtkxspuQVtV18
X-Gm-Gg: AYBFou2PckheQKEFr7YX61pFtRs23ntqH/5673zCqKsRr+RxXm05GLfAyvFR5ITE2Z6
 USujBZ+v9MeHzbg03wSuhFDdmjTU8fdyvUjbc2N61rRIDZQZa2sJfgMa2tsUmniyuO75NfO9/dn
 5Et1fv9ICgPnIGVGmRnfZ/wfTSVVNwNkatkP7yN0HeN8NiDa3AUaY2GFshuWEDQ4nVBIbCNbNbq
 TjQiqigXzUX240DRDierWpUmj+yUvsTt8x43TdqJZJYZLKrvs5McNQ3PahL9fOzjS1mMC7xp4kg
 f8iF6NAt1q2hQLG35qiyJoB7OR+QCeC5kMTlRKfC0nv+E12S2Ipp/p9tYncD4syuQauCFCW5bQk
 3PwZjS+o5oEX3FTzNmkmZ1AYtmCBLtuyJ0tra4VtiTrAQD2mnbnexYfYLqPA+Zc19MSyt3QZhAd
 uNuv0+PJzAJmh7UHO3KiFheQHCZGp8zQCwvklLV4tZE8+VfFmC2lqLPY3iK8KCPOOW263PVT1pl
 AYOE8xQ3Qygk6Cpb6vFdvdwOkAhDsckKx58ajmUIAfUBVDbB+6Pm4XzWptSyVJpy4JXCW8K+QSi
 D8B5rp8/5RbNkofF7qM70FhiL2kvQ3iWwZSXr0m3TcjiG4nRAmvD7LUVp7QXPjM4iX8BpVxPnLQ
 K+UW29IMeqxy8kj0eDsazeZFrl62yHJNGuC1JoPYO2uQ4Z9hZ5MnG4v7imxm0VYksRBKYPZjj95
 PYnV6zJ1MAelyl9wtS2vMGhhmLMlw=
X-Received: by 2002:a05:600c:4f4e:b0:4a1:7d9b:d4ae with SMTP id
 5b1f17b1804b1-4a18043ddfdmr58762365e9.5.1791396714500; 
 Wed, 07 Oct 2026 11:11:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413e:676b:9d85:c07d:dc5e:c7c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843cb261sm9070295e9.3.2026.10.07.11.11.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 11:11:54 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v3 3/3] drm/amdkfd: fail fast on unplugged device in SVM
 migration paths
Date: Wed,  7 Oct 2026 20:11:52 +0200
Message-ID: <20261007181152.35399-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <73a76f1e-48ce-4e4f-9812-2fb79a1991c1@amd.com>
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

One correction to my previous mail before it confuses anyone: in the
v4 respin I ended up holding the drm_dev_enter() section across the
whole per-VMA migration loop, including the svm_migrate_copy_done()
fence wait — not just the submit as I described. That also prevents
sched entity teardown from slipping in between submit and wait, which
is the rest of the race window. The AMDGPU_FENCE_JIFFIES_TIMEOUT bound
is then what keeps drm_dev_unplug() from blocking on our exit for more
than ~500ms when the device dies electrically before removal runs.

Verified that shape on the MI50/TB3 repro: drain completes, removal
finishes, no warnings.

Olivier
