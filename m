Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B89D5C0D0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 08:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8500710E742;
	Tue, 16 Dec 2025 08:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EPh/oprn";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD9410E51C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vIugujDFg05cEDjSFPsNuy7/nXwlnSCGQEq9oeQZt8U=;
 b=EPh/oprnsVUrz2G+idS1ZC2AM/rwA1+1CYkP4vO+y+Y9/Ks+UhZD8GQD8uiF7UNWRmm+Q8
 lYIJDilFvfrR2WTE+Al8Yo+CZTbbsG+JMUiIqor8rbyfp6JC2rk0SbDtLjgj40Qo1Qhd62
 7HXSH1GHpkG+G8IPBcGjz75EAvWohL4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-NVO5OUzsPwW8svP7iWM8qQ-1; Mon, 15 Dec 2025 15:41:59 -0500
X-MC-Unique: NVO5OUzsPwW8svP7iWM8qQ-1
X-Mimecast-MFC-AGG-ID: NVO5OUzsPwW8svP7iWM8qQ_1765831318
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso27721105e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 12:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831318; x=1766436118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIugujDFg05cEDjSFPsNuy7/nXwlnSCGQEq9oeQZt8U=;
 b=IovqTjofkybka2ChRSb6Fu+UThSQW3ZyqROIOzB5JoOHUIOfUkN8/JTsC3skKSSKUr
 F0bXg/t8oyQjg5fCdx7+Xn+X31P/iSwQInABjM7FGRtlRwMDPCB9pr0ZtiJ97kozdWt/
 Kq8tQrhlGnTQEDX7XPbRCPb/0EkEIoKbCrTd1EayKvQAF76QwnqdSwIpO6EcuKvoo2oG
 Tg+nvDFEQA/bJZbL0SkJOX/RrysVNjCgv5xajaA2PxXCJWDPx4EtQKH38o1eDfqUE3bl
 Kg+dtqyvG/5tEvZ4P29n23LrbnfvsktN4nn6HANK/9lefi0EWvmOHLgrpjkY7H65pY20
 d0rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXif8P60Fwah1kWUesR8S7+N4sGe4NSp6kelqDoEfrgSvZc9iyMw6p5PLsJqrdTtnNFD1GDgm7A@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz95I7zyKNVFnE1QpB+y9kDXzXYAL0t0nETtiemy4PXHTZiUf4K
 4LlTvJ0ImGQr31WIlmJVRpCXrmhdKv1PY5ey5RyEZwxXDCqUAC3pbKlNXdlcEmrDjnjwaiOc5Pt
 Xz0qIX5CtAhwEIEMjt2q+aXHBARTLRpIiFCoNOTR5PgwZN2/2fGPeuWRyqV8Ku4q0MfY=
X-Gm-Gg: AY/fxX5HN5UgjaoQAvz8AAb7sGJ8mL5+nhz9/viVurA7TfBf4W41f96C+GLyhNdO/m/
 biFz9VyJtyIFcphDRNrKNuvPIDtP0xyc7xx0OLI9QXoejS7X4QDg8rBbkFqVxzyPOuEW6DorwqX
 5Kx3ype40VWeTZXjGlOxYHmSioubFCHxINiqgGuLTSY9Hq/p4/j+6WqE/4dOObzAt55T+XKW8Iy
 rwpB8oylHzy/BPPqmcN+7qwmar5ZHXW4i9V/1ECCPBqpql41sriUmo3ag+heYYgd3FkBU5mLNlu
 sFjUgtSwPkGXGd36K946/Zbu0mg62jJLKabYPzgI0qZUmlEptLu/PXkVwlHET0uIrXnmwJ0zoCW
 C/+oGI9QYY7OH5xvhQUOhu4KAJbgFxVsxOA==
X-Received: by 2002:a05:600c:6290:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47a8f8cdfd1mr164694675e9.16.1765831318222; 
 Mon, 15 Dec 2025 12:41:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpvKxyv9KrTZN+I+gLKkWZxXPblkRG4VaB9KOKEG2SIjVVbTsH1HJ4pcy9Q9bDzIs00zZydQ==
X-Received: by 2002:a05:600c:6290:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47a8f8cdfd1mr164694005e9.16.1765831317597; 
 Mon, 15 Dec 2025 12:41:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f6f26ebsm211656485e9.14.2025.12.15.12.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:41:56 -0800 (PST)
Date: Mon, 15 Dec 2025 15:41:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
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
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Subject: Re: [PATCH 06/14] virtio: Describe @map and @vmap members in
 virtio_device struct
Message-ID: <20251215154141-mutt-send-email-mst@kernel.org>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-7-bagasdotme@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20251215113903.46555-7-bagasdotme@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FJWQGWSnBIUHaekAspVa6oxg-hiU_s1_7iZAiLeIg64_1765831318
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Mon, Dec 15, 2025 at 06:38:54PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warnings:
> 
> WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
> WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'
> 
> Describe these members.
> 
> Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 132a474e59140a..68ead8fda9c921 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -150,11 +150,13 @@ struct virtio_admin_cmd {
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.
>   * @vringh_config: configuration ops for host vrings.
> + * @map: configuration ops for device's mapping buffer
>   * @vqs: the list of virtqueues for this device.
>   * @features: the 64 lower features supported by both driver and device.
>   * @features_array: the full features space supported by both driver and
>   *		    device.
>   * @priv: private pointer for the driver's use.
> + * @vmap: device virtual map
>   * @debugfs_dir: debugfs directory entry.
>   * @debugfs_filter_features: features to be filtered set by debugfs.
>   */
> -- 
> An old man doll... just what I always wanted! - Clara

