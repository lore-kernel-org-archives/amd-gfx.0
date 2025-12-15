Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E996D5C0D6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 08:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE4D10E74B;
	Tue, 16 Dec 2025 08:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A8wy/Awq";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D579810E450
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 11:39:23 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso8844505ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 03:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765798763; x=1766403563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrKHAwDmwEWPzZzAT0wzFml+5He+R0bXqVhPFRZE9SA=;
 b=A8wy/AwqO2f5IN8Jl4yjIPN9G1Xg1LaeecXMpvGW2SAl4DCpO811rpsWoZ6o43M6QV
 uhX9GR9+vSgrTX/2MJF0hIgpwMX4jvRHwQE7JOkjVLJ1o8TWDk8mNaoMk2Ji0L50DalY
 fEktwz+I1iAXaJNUJL0qqv8eNmvmdLhB6nmXUU36puQJJkuEvlydh2B6NT4a/7/8amMc
 o/MC7GSR/6L5hevToSYLzzP6WrlUvspbZGJvznwAkDB+MxBMEv1KKnHOQ1mFSfvQ0DKr
 Ptu5qHqkNatbVVXs4ZBNyneaDHovX3wuykRKHQKg9hJgbOs91Wg6I0Ltyeq8UbYD7Jpl
 Gfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765798763; x=1766403563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TrKHAwDmwEWPzZzAT0wzFml+5He+R0bXqVhPFRZE9SA=;
 b=p+qfv4dK/dXJtQ1Vvr4Q0AH+hVqY2Y/iPgzysKzFqR9Rl7nuahzK24rG+7SdPTA/NK
 i6ASpkWnYcyx12K1C02Cver3JoJa21qoInhKwieJRfbzLMsLpvmsmYaZOxYAsruSh8SY
 nNcqa9P1G1httDCAgt6TNL+bNKqMKO7RuUEL3FnYYuOY+C08A68NF/CtIa9E9Ac3aYd4
 XQ5H+uWBOeAqAvme/dG+cTxEIutK202izBTl0QJJylXWWOIjBz14JsvIDgIU6Ekmc7IX
 jWVJLpXUEf0BkgxZqEopHDEezt7IVsK1KsjZj6o4mkhzkkYTMah7Gp8CU2A6wNs7IX2M
 huIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIsXoqyD2bTnlDpareV9BcnIhST/gJzIJKi4KpJvgUrI35rSy+KAtepK20PvVtvFzusO5qMtYp@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3nslWLF122wm5xv8G1lb+R/9RBoHmVA0RHMNI9/KfcArEkJJM
 GRw73pORc9LwZRpT+DKqlEJrlDpcGE9TzN3/lwx4alJ15G/0wdyKJElU
X-Gm-Gg: AY/fxX4nKCrY7I/q/2poRdVzP19mhDwsfr6ZHVX4c7m+IH292dHMntGgqk8iMSzbu1N
 0CCDsRWd+7vaSzibIAA+mT/k0MzgTgbUyUZb65b7zmBQ/Au1Wvxcyp5DWE9Oo6DXWIs4zv4H0cU
 2/MTLB+D36NvbFONSLtrh5Z2W4eJ1k6Ls42ibPxug/1uQzhngAwM49lJUrc3x1cNhlhPIDwkZ7U
 McFKOtZG2ASc+wrEnKdIwnbfEgwY+ZFeHrnAwf0WDlT9xnKzHIr6VHATUvd/gKUyjYSIxu90Xgv
 3KbHPMV0H4ILWkQOpAnOCYUGKWZmRxIxLdKu3KMV3pOqRzuHiS8tPMNGD7VPDc5KL7qhARvXWrQ
 ujMegIAT9UBSLDp+TkPiiT+IRa7kUlxUOwYYChxR+mTYeGoxo9lIb+gJasX3TWXJtgTPiHQzvlX
 S+7V31p44OxaA=
X-Google-Smtp-Source: AGHT+IGEKo7pUOqZ/Msgj5pboeIPXCGG8SyTdVwEqd2zfEZHqjnoFfxwhdJcfbexnC7zJuC88ktUrA==
X-Received: by 2002:a17:903:1988:b0:2a0:d0ae:454d with SMTP id
 d9443c01a7336-2a0d0ae4b49mr35282785ad.22.1765798763267; 
 Mon, 15 Dec 2025 03:39:23 -0800 (PST)
Received: from archie.me ([210.87.74.117]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0f58d7c27sm27523715ad.24.2025.12.15.03.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id 357B044588D8; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
 Linux Media <linux-media@vger.kernel.org>, linaro-mm-sig@lists.linaro.org,
 kasan-dev@googlegroups.com,
 Linux Virtualization <virtualization@lists.linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Network Bridge <bridge@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, George Shen <george.shen@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Cruise Hung <Cruise.Hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, David Hildenbrand <david@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>,
 "Nysal Jan K.A." <nysal@linux.ibm.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Alexey Skidanov <alexey.skidanov@intel.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Vitaly Wool <vitaly.wool@konsulko.se>, Harry Yoo <harry.yoo@oracle.com>,
 Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>,
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Lyude Paul <lyude@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Roopa Prabhu <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>,
 Shaomin Deng <dengshaomin@cdjrlc.com>,
 Charles Han <hanchunchao@inspur.com>, Jilin Yuan <yuanjilin@cdjrlc.com>,
 Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 George Anthony Vernon <contact@gvernon.com>
Subject: [PATCH 11/14] drm/gem/shmem: Describe @shmem and @size parameters
Date: Mon, 15 Dec 2025 18:38:59 +0700
Message-ID: <20251215113903.46555-12-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=bagasdotme@gmail.com;
 h=from:subject; bh=NBybN5/snlW67CYY0LDf5z9mjlB8/ZE5MQWmfMjzEtk=;
 b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4OX/nxidPxCa7t5fuOD8HMfrQSuP1hub/O7ZcKpR
 3k2jWdLOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRtAcM/yunTjs9ydWYJypu
 wYcH6cfFNi1X5dYSuyPxxuv3me1JcpKMDBs+vU9uutHzrUbncPwy+73MjZlbOwIfHrr54bGU4uz
 aOwwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp;
 fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 08:07:42 +0000
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

Sphinx reports kernel-doc warnings:

WARNING: ./drivers/gpu/drm/drm_gem_shmem_helper.c:104 function parameter 'shmem' not described in 'drm_gem_shmem_init'
WARNING: ./drivers/gpu/drm/drm_gem_shmem_helper.c:104 function parameter 'size' not described in 'drm_gem_shmem_init'

Describe the parameters.

Fixes: e3f4bdaf2c5bfe ("drm/gem/shmem: Extract drm_gem_shmem_init() from drm_gem_shmem_create()")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 93b9cff89080f9..7f73900abcbb9d 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -96,7 +96,8 @@ static int __drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_obj
 /**
  * drm_gem_shmem_init - Initialize an allocated object.
  * @dev: DRM device
- * @obj: The allocated shmem GEM object.
+ * @shmem: The allocated shmem GEM object.
+ * @size: shmem GEM object size
  *
  * Returns:
  * 0 on success, or a negative error code on failure.
-- 
An old man doll... just what I always wanted! - Clara

