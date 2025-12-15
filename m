Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A01CD5C0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 08:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947D410E071;
	Tue, 16 Dec 2025 08:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PvFX5UxY";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA5310E439
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 11:39:10 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-34c565c3673so620696a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 03:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765798750; x=1766403550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SOExJIUd6SMMpu9ecZcijfoRnX+3TKAUcxRzAMDO5OU=;
 b=PvFX5UxYrUAsvwyO16wvO8TFlqyf8JMX2HUVLd9L6+gMP6I1XFnajT6TZe98ehWwEb
 tfA56lhJm+sdi61f4lYgZpG5t2jBxTriRyuvVDTKVPcXJ5DNfQcjni/zsqLn5Vh2RpEn
 QiPoX2zcStPLORllPTf+okTtV4Pw+rgIVRE+BMwG5sg5Kn5sr++deF9N2STXGC4fg2Yh
 HmOsO93+Kb93YlyCjjXzVkvRQQqsUqhMnlU+19ELtZ5z3bcxsDLsmbDpv0aitrirp6Uj
 xKA0bAWpiDZKudK4onohlFwiln6lmSSZK9AENC3lP17CEPpNK4+DOIZ3nNbl+48ZUj9g
 xZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765798750; x=1766403550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SOExJIUd6SMMpu9ecZcijfoRnX+3TKAUcxRzAMDO5OU=;
 b=IOPcDbeEWRMY2gADJwdeWrSLpzs0YkiP5w6/zexmVvJy7tBs5winmpS1UeaHPIJ9Ik
 04z9pVrkBbW7m6Uyqe1THEKLwdUkpUiidETtaFBTU/06+Z2sNckF6TBMqk/Cu0RpFnmp
 YBPXMDg3PPXL453Ua19YIQAHFCDqrIVHkCFinys131ucP5ROblE+ssa2eXbT73uWicuX
 /z2oHrMvO1TeD6fZHWI9rC7Z3qUHvOhBJd4wr3RxPKon/rn+65mIl/PO+rVWc0RHxtbR
 e6A/kgqRJ7/2wDwCisGyZ/zBlu9Bz6+JC+5VhcMxxSb7iTjvMy76pLOKQOfPLrCNo7kG
 Hvxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVez/CbpFTO2fnkrAlSegsyOvBdHafEQjIPlOH5hJb9SmkoZ4tDlLSgZmDWD7qmwW4MHmAlOR4E@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFKdAdRqZMSAV5ZQCFueZXYB/0IRms2ADvP/hgaDqXYHEGDdvu
 lcnqROEikApff1TcDE33habDVfza2LOtunj1G7Ttchxom8ULPa85zIe/
X-Gm-Gg: AY/fxX6qXSm2EpJsfG8SCTWDWYqSl1V1lRx0aWubdxMuE4C4ia8lIln/FuAAwPLvicP
 l12Sy0e3jUsozUqf1sCx5fzIyPmfwYwSRF7598Z+90XKx8rFWsTFG57M8yPUVhC/NpYlrA3XRWf
 IM4AFcwtlk2rhBGSW40XGI/4xR3AjiIZeFpGybjxAyTbyXll3cj2YvLsVXZQXHclEx648lrU/Ml
 hOHeXXkOFDBNsdzyUh6k1mU0X6I4ay0/G96/FQPi7l7Q+X/VJ90ryilqxku66Gh8ume3ahd70FF
 QOOT9neWGGkHmkiP6/yjYubKhLSCOUyTRXAFkGDcbd94dBnzzqu9JQvNyOpcDnLnrGvz05jRfFe
 MjasGKQPDXKL3ZBvK4kLvdMDX4/tW0esUl5MDa+egvKS9YP2IL9u1yBaiRydjhsVSKp4IuhlHnB
 EuF9OiNB5GxNvuJu5c7dfkYA==
X-Google-Smtp-Source: AGHT+IEi7Much+ynnSaGi+9pLWL2hRrocApHWp5vBqFK1ft2pjcvnQtgIu8VXEyupMREgh2/mG55NA==
X-Received: by 2002:a17:90b:2e03:b0:341:1a50:2ea9 with SMTP id
 98e67ed59e1d1-34a926d9c70mr13163422a91.16.1765798749780; 
 Mon, 15 Dec 2025 03:39:09 -0800 (PST)
Received: from archie.me ([210.87.74.117]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34abe294a00sm9273005a91.12.2025.12.15.03.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 03:39:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id EAE05444B390; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
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
Subject: [PATCH 01/14] genalloc: Describe @start_addr parameter in
 genpool_algo_t
Date: Mon, 15 Dec 2025 18:38:49 +0700
Message-ID: <20251215113903.46555-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=bagasdotme@gmail.com;
 h=from:subject; bh=yvRLY8BHqBHKchvPjcPm3zDNVddYxArgXi7Qv6PDXBI=;
 b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4MeLjlRVOvo/zL51uM7fT8nbubcy37qLGeos8/kb
 VKe75YIdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiGosZ/mm4fru/UqLr5XIZ
 H96Qry1BDLd3LedR2Gkharj+Q1jej2pGhm7zlf21hfvmpVcxGBvN2yCmrfs71+wCw2eFqbVucQl
 NvAA=
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

WARNING: ./include/linux/genalloc.h:52 function parameter 'start_addr' not described in 'genpool_algo_t'

Describe @start_addr to fix it.

Fixes: 52fbf1134d4792 ("lib/genalloc.c: fix allocation of aligned buffer from non-aligned chunk")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/genalloc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 0bd581003cd5df..0ee23ddd0acd3a 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -44,6 +44,7 @@ struct gen_pool;
  * @nr: The number of zeroed bits we're looking for
  * @data: optional additional data used by the callback
  * @pool: the pool being allocated from
+ * @start_addr: chunk start address
  */
 typedef unsigned long (*genpool_algo_t)(unsigned long *map,
 			unsigned long size,
-- 
An old man doll... just what I always wanted! - Clara

