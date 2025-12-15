Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2729D5C0D7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 08:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DFD10E729;
	Tue, 16 Dec 2025 08:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hvo80IuC";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC4510E450
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 11:48:42 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso12880395ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 03:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765799322; x=1766404122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HauKBmXABfepG7VVzo5pWgXSZcUBePm/ZvLfsSGC9U=;
 b=Hvo80IuCefFqNj8AvI2N2VCTtVBP0VsXi4Imom8FWzx0QGfWTMvcvlYW097jyFnV+4
 3abwktGvRaO86umuU/EkCaYbQsIAwnT/gckZw8/SGJ1YjMJ2bwLXtLzcZIgDsMr6HowV
 ZwXFRYzi3KN06jyapTpO89Jsxv8ReOKa0ybhhearHRcBlFfru2PXXtW8+GQE55ToPPBK
 L9nfU0/5/aQ4ie7Acq1a6KB6QCoB2vSoYzURia6xJhUzboHNEERcLCgXvfJQwrXZf2cU
 tFNyu7uHYl+OKJEtKt1D+WdQH7ceduyseNhU1niettpXcJ68m1pX7mjWcyNyywO4kgLo
 HYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765799322; x=1766404122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HauKBmXABfepG7VVzo5pWgXSZcUBePm/ZvLfsSGC9U=;
 b=sxNNXRyQzbVnQlIIJ9Hf7crGg9vFwamL3FlD1xmzNwAvE+fw2fo1sSuXuVKzd9srGf
 pGD2uHVBnlOF/tmFN3F9xtpz05ndI2tqn4QG+8+nLtmTRBpMzRD7OKMvyDXweSV5s1AV
 b3a2s61KZBD6SkFcpirMbkM462nY2A1GlUpcjh4tnPFpe9M6VFiy+9N8GeSRuz5gNhQB
 FZZEsiZ/h/0zxN6rZXlsHy+GBb+TmW7jA6C6wCMdXk54mdgNuWoZY/68ryjh6VoDx0l9
 +NPV1E5X7kFqHczhlz27PpiNQFl6B3yeOw3t3d9oc51ZCZz8ND1SzKsUAWt9bExFAnbU
 3skA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/WClzOGZr42QpFni4EAS6kNSOd5Zf8b1BGwdckioZxZ33F222xIzBhSiJcCiPc/1oaHmudTSO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNy51GRMNkwnDkk5GAGcTqw1DoK2dXWNzIB6b4ocjPUy2THLLV
 xiYnnXfOvVr+DahoxmDC2/8WGImJD+Gh9QLli87FXL32JizZREwNpix3
X-Gm-Gg: AY/fxX5KSY7v2VkHXYs7NFtyukm9tGgoRwUBV7DKdGbt1TaZnA1UuqjxDE41nZ8BdpM
 SZusgoo33+jUeGymX+EI1GhT8kEJ/Cc1axdaKqc4sKTwALy2BQLRWXJ/gNV6jg/TP+MDG9OM+Fj
 w67XOfPR4VHVCWO3V+sMUXecTwpaWQK2IJ0K6f11w4fWf3EQYz/h9eSi2NRvkVPEDL4Z0TAkL+2
 OW+9vJWSyYjLm4xguChLImD6DdyaqvHqlGhCYgoGHc1xfK2frte6G4cFghcSRUReMRZ6YYk2agu
 0dBYJa4dw9ySi/MeQhnFgVxI6anAvgbIgqoV+TT81Ub5tO/0EVkHiyzHAU+M0buAqNdckSXGDxe
 CizZmYAqeIny4JAS9Vb5KReXlxt4p3X5Z67q3n5dDwRqkx+aLMfXrhN1XTLLPENSv0ifvFHHOtN
 k/QlrSxOtS8XM=
X-Google-Smtp-Source: AGHT+IHfPz2x7Vw5nYSquN5rdr59IqpuimzSW/oHADfYTkii49T/33BfFck+CRU3WD2YFqFgGY1MBw==
X-Received: by 2002:a17:902:ccc8:b0:2a0:823f:4da6 with SMTP id
 d9443c01a7336-2a0823f4e6bmr66287715ad.50.1765799322057; 
 Mon, 15 Dec 2025 03:48:42 -0800 (PST)
Received: from archie.me ([210.87.74.117]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29f271bc8a0sm97458185ad.92.2025.12.15.03.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 03:48:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id 1E64B44588D7; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 10/14] drm/amdgpu: Describe @AMD_IP_BLOCK_TYPE_RAS in
 amd_ip_block_type enum
Date: Mon, 15 Dec 2025 18:38:58 +0700
Message-ID: <20251215113903.46555-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=bagasdotme@gmail.com;
 h=from:subject; bh=UEs/C9BYSnit6YUYNsXI/TPVZ8wlbVWtOoMfZCt2Czk=;
 b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4P/rZd71fJeeea2Y6ze7l+/BUWfvZxbPVvJ7FLhc
 b8Ca2nfjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkQCXDH065v1Nu7J+SJNXm
 fKBEpbzzpEZrbklCWe8WSUFLrulTkhn+J33s75ffwvJ3fu98iUql0+pnUqJKXmg5a8ursxTsZFv
 IBQA=
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

WARNING: ./drivers/gpu/drm/amd/include/amd_shared.h:113 Enum value 'AMD_IP_BLOCK_TYPE_RAS' not described in enum 'amd_ip_block_type'

Describe the value to fix it.

Fixes: 7169e706c82d7b ("drm/amdgpu: Add ras module ip block to amdgpu discovery")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 17945094a13834..d8ed3799649172 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -89,6 +89,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
 * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Scheduler for Multimedia
 * @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
+* @AMD_IP_BLOCK_TYPE_RAS: RAS
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {
-- 
An old man doll... just what I always wanted! - Clara

