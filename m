Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9A2C4452E
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CFC10E787;
	Mon, 20 Jul 2026 07:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cBenB01J";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C76410E07D
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jul 2026 18:00:38 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cab973140bso115378375ad.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jul 2026 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784484037; x=1785088837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gQVLUSh0YdJH3i5yQlMay6TXyEhugldDrvm9uMupsBE=;
 b=cBenB01JzHdJTigxhO00qvy6kzT2/rXV3L68oTRp3VJW3CMxGCKaHYYC5MrZVZXY4N
 XGH3Cye+3nQ93noxvsQBT6acLzk/92fWoX+dMEObuG6bBpmI/zQ5cPoN0N7+dRSFQ5yt
 glX17T7W4Wc0UwXvkzFkp+tcxVM1a5dQWqPoTGcp/Im8M7eIdH6cUZ5eCt29xqUfBSxo
 qZwaqBbDcIvqwOVv3bmY/wQ35Dg+zC4ISuQMRSTQ4xd0AFHz3W9ABbj5gRKuoSlTwYSt
 4AT/EAlAxw76ntWsijoIa3O43YkSAXjWAAwTU1jRrwOuR9Rq+GVzoA+0mD02S8at703L
 9NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484037; x=1785088837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gQVLUSh0YdJH3i5yQlMay6TXyEhugldDrvm9uMupsBE=;
 b=DvEx4z+P8mM4WaUPYwq9sFC5jg45zRbdHirRa4ejKkMvrnVbh5sD4LxhAFC1/PHMnl
 exPWPtGxoKUkyy9k31i3rsC0TO0ZuR99k0PFrKmnuO3S98Ow+t8tThGA/ILcOKeJZIJo
 Zd5TwfpWdLYj+prNyhQeV9d7T9UgL0OEL7USFN1N3/jSF8yQzEtC/0DRynXOGhovqi/R
 u3xMsGHeHXA7AnrRLerJMLSTCpYQ1doquTPwlK2QF8Eoq9JpyhyjfyOa0EzQELoW8RwQ
 6gyH3t3GHvmIAhl45kyFDnj7Sa38QicIv6/eoUEYS0FcHd1BssLm2TU2Lv43dUmLbRca
 g6zg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrr3fnNVr9znjRxlBiL87ELm3RfGb2vU5wQJm4gqyY+ZhLyfQ5bppSvTaH8WdHVxyscOpJKyIDQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEk4DgGuwomzLXTf88qwVRYoF8XHYfiM1wwHyJXEPEzW1u1X9q
 co9VLwQGMh1jsxgQon6X8Z+Va6Ot2D/M9uUYkeffJytfxniXHZLUgyqU
X-Gm-Gg: AfdE7cnrTN3EcuHLrDMd0liqFdjIPG5+simG1pQYfjKxbaAj9LDIQ1kMQWdfffAlt0o
 AAGonEYKGIjVENt82N2oQhLTaWTZpKZqUFzO3HgagbwzlnY5+Z7+7N3kNDhNRkoeJu/XFfidkxM
 ur+yh69GvGDYxd7HX1lCQviWCSAdh6C+w91IYXtqUYhOBrUWtmtc6KcDQuNGBT9OwHlv42LhcAi
 p6/s7EeCLuxStBgWR3elEkN7IXtCzuCPqIhIlm6gnvyZCJT46MkbuQ5m0MGn7MjnAXJY6qCkSBi
 sQoEvCvvnGVRz830s4qSl/xwZFFuerMm83M2KYPulOubrMlFV2d/NrHuEeI2LxyA9ZOntKzwG8m
 kXy8BBlGZ2tJZ78DUwQqdvTfGNYX7x2ONRdAL3WwcsvoNb4L2oTMPHnnALAOD9q3tyw==
X-Received: by 2002:a17:902:fc44:b0:2cc:b480:28ba with SMTP id
 d9443c01a7336-2cf34a25ab6mr120497085ad.44.1784484037543; 
 Sun, 19 Jul 2026 11:00:37 -0700 (PDT)
Received: from ap.. ([182.213.254.91]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34769bd6sm43511065ad.74.2026.07.19.11.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:00:36 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Alexei Starovoitov <ast@kernel.org>, amd-gfx@lists.freedesktop.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>,
 Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, dri-devel@lists.freedesktop.org,
 Eduard Zingerman <eddyz87@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Hoyeon Lee <hoyeon.rhee@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Michael Chan <michael.chan@broadcom.com>,
 Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Sumit Semwal <sumit.semwal@linaro.org>, Taehee Yoo <ap420073@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: [RFC PATCH net-next 05/13] bpf: offload: allow PERCPU_ARRAY maps for
 offloaded programs
Date: Sun, 19 Jul 2026 17:58:49 +0000
Message-ID: <20260719175857.4071636-6-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719175857.4071636-1-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:21 +0000
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

The knod BPF offload keeps hot per-CPU statistics in a PERCPU_ARRAY
map that is mirrored into accelerator memory and aggregated back on the
host.  Permit this map type on the offload path.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
(cherry picked from commit c447c9012940d48c1ec20a8ebac8d779e7d5a6fa)
---
 kernel/bpf/offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f5569588c..36e747a12cbe 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -510,7 +510,8 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 	if (!capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 	if (attr->map_type != BPF_MAP_TYPE_ARRAY &&
-	    attr->map_type != BPF_MAP_TYPE_HASH)
+	    attr->map_type != BPF_MAP_TYPE_HASH &&
+	    attr->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
 		return ERR_PTR(-EINVAL);
 
 	offmap = bpf_map_area_alloc(sizeof(*offmap), NUMA_NO_NODE);
-- 
2.43.0

