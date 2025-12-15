Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78957D5C0D0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 08:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C7910E0B4;
	Tue, 16 Dec 2025 08:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ic2VjzIW";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8047A10E448
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 11:39:19 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7b9215e55e6so2341273b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 03:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765798759; x=1766403559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhdWc9MI61x0CV5VCAtcSDjXy8TDKlNky9k0yGxBSF0=;
 b=ic2VjzIW/FTBXOIH1lJT6tIDxcEEQDRXGaxWso2juF/FjidQ/ILhx421ptxAiMQgUR
 e84bY12Bj+yNZ7P1muIkMXfx1ZbaxXfFTVaVF4bFrLCzCAAGPIUnHzDuYzY+I3W0eu3v
 alvlHuRso0r5UlOcvh2NaSz0aak7Mv09LsME+7927yuQxWhV5XSCYkBGc8KlRtzx4PbX
 wjoUni74uH7+gAhjb13XzhntMNxiG+FJ0MoAuEACUNHmuUmJzYUQFpfPfRlu51tpBxOo
 4vq4B4AL5ElUUsP7UIlysBKRDcFXaT2BHLeOpdwmN+7lEUc+FTzD0yFPBjacd+5pKCU3
 Qhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765798759; x=1766403559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XhdWc9MI61x0CV5VCAtcSDjXy8TDKlNky9k0yGxBSF0=;
 b=qO9FtH5clVPJHrPoGA/4WSihaFq6xMaOE3haSV4c1+Ai3nkQXb4C2LzX95HtYtcXX9
 C3SSjZ/y0uFr7b292TFSjWofeA7oOPKffJzvcwcCFq1Rv6vDuyKdSNcDdEUAaNRQMFpf
 UJobBnTnnalipdJCmkbALI0BrlC0gXxFvAQUdf9eNWoix4dMeLTpybZQjVywppqUw3xm
 1FJiANIyC4UEpB68Pf+Hb9UQHAzOcKMVN/4ywXRdpqaZrW/RoKEnGZrFwL6QUpfA85fP
 fyZZZfmskMvf+kYNOZlA23qb/6xk50zNDbTFir373TZmJxRfCJVoIANwel2m0R9T87jP
 7Y2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW44IDi87Ch5XxH9LwYjo7FSY/vIwKb0KXT0yN51OvH73D5nTtxSIwfCy13j1ahGXa/C683X6vo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZduK29sAfh4jIJgfX8Z+H02Jup53HiBqzKWxTs/LnCl3im/1E
 2oEKP6kMJyJ8syXB86N6P3NuWBPlGyAAAGH/CrmBDzexytteVusAgqYg
X-Gm-Gg: AY/fxX4K4LdCza9ktFRzweTlMXEcvr/lT7HK4Aaa//qjb0oSTWXdXNTVDuFnnQ4TDlX
 kDAfhuCQX2vAUMPdBOg5FHYEHCmss3DT/PF51VZa1SImaPXRALXGNao0fNWDIb2RRfRuPxoAyf8
 dDqpT+fMqXb/Aj/cXaI+s49ER1rX7iqiJjhAIGbnSHJ9ssLkhNNOjX528ud/UKZ06LXWGTZAlpv
 VkCAIRi4fTA3wiel4Y9JbnIjSK6m3EZ9kyfY2vLJAizmTjZO7NJrWwSPxRq2X7uQuCXB2BJKcML
 b67/ZHm/5VvRJ53cp3golY86Vq3ROocrYSouJp7ZgllOFGyb/uTy1kvB/9czXhzPzZLxImQwRpb
 0RNl4taYaEnZSKQvP+Mm/TkirtF4RbzMiz2aTVbHcTPm5XgokrAf0SPO4InLWFk8RciKXkmBky4
 bfTBQ4pGu4KH8=
X-Google-Smtp-Source: AGHT+IEml9qI+VrrnmRfetIj/W3ZZs/y3fpGJeeY3YNSfL1Lp+Ud1G2wHo5sReKCb7zM9fF8T1soPQ==
X-Received: by 2002:a05:6a00:4211:b0:7e8:4587:e8c8 with SMTP id
 d2e1a72fcca58-7f669c8ea65mr9926386b3a.59.1765798758916; 
 Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: from archie.me ([210.87.74.117]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c566c7cfsm12487742b3a.67.2025.12.15.03.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id BCD48444B396; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 07/14] fs: Describe @isnew parameter in ilookup5_nowait()
Date: Mon, 15 Dec 2025 18:38:55 +0700
Message-ID: <20251215113903.46555-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=bagasdotme@gmail.com;
 h=from:subject; bh=ZF9oIk+6VfTU18bKiromuOjnT5V3QoMoKRjEOTmh6aM=;
 b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4NPZboGqi8J0lGIEPx09J91+O5zYvcmVc9uCnNeq
 KyqY9/YUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIloczEyXFE5FS25V7U4nF3s
 wsyajN23tv7S0jlgc8jW4LrtPJ7fvYwMd203HZvEp7U3/4W850Q53mn2BsnZf49w2jwWklnFefM
 GBwA=
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

Sphinx reports kernel-doc warning:

WARNING: ./fs/inode.c:1607 function parameter 'isnew' not described in 'ilookup5_nowait'

Describe the parameter.

Fixes: a27628f4363435 ("fs: rework I_NEW handling to operate without fences")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index 521383223d8a45..2f4beda7bb8841 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1593,6 +1593,7 @@ EXPORT_SYMBOL(igrab);
  * @hashval:	hash value (usually inode number) to search for
  * @test:	callback used for comparisons between inodes
  * @data:	opaque data pointer to pass to @test
+ * @isnew:	whether the inode is new or not
  *
  * Search for the inode specified by @hashval and @data in the inode cache.
  * If the inode is in the cache, the inode is returned with an incremented
-- 
An old man doll... just what I always wanted! - Clara

