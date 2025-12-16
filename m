Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF202D5C0D6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 08:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579AF10E74A;
	Tue, 16 Dec 2025 08:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Olj0+mxi";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB0B10E5FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 00:19:23 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2a137692691so3667415ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765844363; x=1766449163; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sk1yhdZDsbmHyAUXRbfG+BCb5AaoOf6d28kSsthudBo=;
 b=Olj0+mxiG6PCVrya2B0U7Sr1HlkDRfEwPwtspvFM9cfQBMJTv6939vLA+gMs/GYanG
 /1psIUkyBTwC5MnJ5lXfntaDQXJFXCzYLZHGmvd/Wi3jZ7uRN5RlWEfEI1ySo+Cr7BSz
 SORpxGMvnO/DMAwKwGABXWQvaX2m7QGI4tX7fMyuTk8h/x1MUmUut/e8t+Z91Fx8hOBg
 pmUuRbJqLicEEeMqFaLr7wakXMLFGJu6rtaFdkW0KQFNK1Oqqci88HAOk93cvDStNamE
 mnUx3tgokrjuawYnbrO6Q/Ea0ngGZHOd9iztwrg1mCNyKXUbY7FycsAQVfuzA1pl/lTp
 tEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765844363; x=1766449163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sk1yhdZDsbmHyAUXRbfG+BCb5AaoOf6d28kSsthudBo=;
 b=Jki6ONxNm3i9tDxaXuC0M4utfsb2WGUHUIJoZE0B5ZgTpqCksl2WAmEEC5YBQkboWB
 jlC4QYTofV4fzsIBUPzEnIlEi5EU2uuKkhdZ7u+sxfHteJxUIDiu4/gyppnEZHWxj1em
 xVBO8iKgmfmAjTtub/71AoEdEOE8ahyfzq81IMaskOhdr+JCEf1gCzWeEo2mY7qkafC+
 HxFDh1QMHjgrdyy7nr4w6sn+MKE6MZOav7tRyqWot5Mavs/tsT4N1WXIxIoTAZvhFVu4
 YyHDb5+AplNDzATH/4DxxnJcJ8mCktvFuramdgrVLjBATBPO8FXvotSuikls2KWhnISX
 tIYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6uD5mojRkxD0Z4ZwW8lnhKIe1mdxFO2Fs9g8qkLoTKcNMcmrCzbaBc5fSr6Vdt9ZDT5jnt42G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmTtzzDh3WQzujEFh8+knquRSKzM5RrlhqupWjlK4KmnJQNeUP
 C5Y6ZhO8bp5UTPgYp1rSoi0rTkQR2CoMrXRcBnMopsrB3jQMO2CebIOo
X-Gm-Gg: AY/fxX5xfKNPA+rGT5YqIoyQBkwPtLx5v3n/kxXWHAOab4MMG9M/mLbzGsFeSj3JSLr
 0F19rUV6gQKvDvzIZ6N2tKGFwSG4b6bSofNd01GuQTN5xDRU75Ie2nxAnGg1jkMbLoKrBUV0rCk
 QVGUVSofllW2fuVuyOETnDUJzUsNMOk5KTCWEEhLqzbfMl1QOrxLLqKQ2EWuOZphUM/88IL1OS5
 dldug2dpNo0UzcWjKs48Wixs1A4OUuvSJmpb1fGgF/xBA14jFw5dXTJN+FJq+4ulkzQmEe6aA3T
 kLqHRSP1o9Vay7UKXNKQMG/g2hn7X0nx02xP9iiI2qXaOHPa4gn1ibSnSVltTht9HT1gNr/VnZ0
 0oBATl9SGNDYOOLA4xvqvnpAZUkDwhN7C5yG0ZQQIU2lNtqntzKy4IlxtbjVYhFV95hSOnVK8ey
 GsNpfJfdjQvh3QoD107XNDDT3IPW3Ah0+X7mcGKZ4KgKU=
X-Google-Smtp-Source: AGHT+IHmrytMydYNAgs0qRZg7qEjrXkSVHGK3fUWY6ADeu6KzKqLiLcf4Z3v4UGHQ57LoQ8XnYjK1w==
X-Received: by 2002:a05:7301:f84:b0:2a4:3593:6466 with SMTP id
 5a478bee46e88-2ac300f729dmr7381219eec.22.1765844362545; 
 Mon, 15 Dec 2025 16:19:22 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11f2e30491dsm51066947c88.16.2025.12.15.16.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 16:19:21 -0800 (PST)
Date: Mon, 15 Dec 2025 16:19:16 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
 Linux Media <linux-media@vger.kernel.org>,
 linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
 Linux Virtualization <virtualization@lists.linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Network Bridge <bridge@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>,
 George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Cruise Hung <Cruise.Hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 David Hildenbrand <david@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>,
 "Nysal Jan K.A." <nysal@linux.ibm.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Alexey Skidanov <alexey.skidanov@intel.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Vitaly Wool <vitaly.wool@konsulko.se>,
 Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
 NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Lyude Paul <lyude@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Roopa Prabhu <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>,
 Shaomin Deng <dengshaomin@cdjrlc.com>,
 Charles Han <hanchunchao@inspur.com>, Jilin Yuan <yuanjilin@cdjrlc.com>,
 Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 04/14] mm: vmalloc: Fix up vrealloc_node_align()
 kernel-doc macro name
Message-ID: <aUClhBdwQb83vN0o@fedora>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-5-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215113903.46555-5-bagasdotme@gmail.com>
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

On Mon, Dec 15, 2025 at 06:38:52PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./mm/vmalloc.c:4284 expecting prototype for vrealloc_node_align_noprof(). Prototype was for vrealloc_node_align() instead
> 
> Fix the macro name in vrealloc_node_align_noprof() kernel-doc comment.
> 
> Fixes: 4c5d3365882dbb ("mm/vmalloc: allow to set node and align in vrealloc")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

LGTM.
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
