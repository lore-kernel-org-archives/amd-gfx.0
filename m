Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13374E8B391
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4063210E702;
	Wed,  4 Feb 2026 03:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OIH1AelR";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFCC10E185
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:55:18 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8947e6ffd20so85801046d6.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 19:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770177317; cv=none;
 d=google.com; s=arc-20240605;
 b=E6ApcFjOo30SmJNgEK+yMkEYCwuHXAg5CXENgo3wgWfdTewP31HVm5X6e8pGyKz1i5
 ooLaSF+hSTtWep8LuXRlIsJkPuXvAfwHu9SMVDofFpTNN8XFheS167g3GsxrXxK+xI9y
 bHLyIN3BQS1oPqBDA6GsQX9KDd1e6TEfcPhIo251AFrVduwacmw50YbFTHTPDmYUtPxu
 Mr/LbJGk/8FeG7DnPHRmZPCKBp9LzkM3d0mr4ezz7A2GEVyJxUwjtpTzq/2sY0qUrAnH
 9JcdjJ4IZ/VaOkY1YzQnA2thykXlU5spgIa48zwukCvgdUG8EpYxq+egrGxfdhQOvGjF
 rOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tf5RbUuZBD7vAitiDxd/SxMvRKm2h5sg9P3f0WhMpEo=;
 fh=QMkGTyJqR/pM8fkRy17QyDlIBcBhMw/QBtNYlaq6H2k=;
 b=EmRMm2X3SEk61KW7zQy43YqY6EjafpA6DDIGp9DNixCE0nx8mdnag+8vT8PQ98kRDu
 8BKHPot0YssVlPG0pAZ2/zpD6g6NwHlANteZsxH9J5wz/gxtTBqT74ZanwEUEOAE3KjZ
 jk4WFxb97TNrBxiLp6sgNLIq+wOsnJTpO+lPoYsoiZ3POfMhOYmKMqpgwuIvqG4gueQR
 m3ujOb8TG4QQ/yV1CiTZABIfqG6MsVHmlY+pZGOZZIaysMtT4zasGLzx8MtGC/8rxiAs
 P+seCvnQJoGryuyLSXGI+AmQ1pG4yNFqsCaoqzbNRAMsYDCyN6KDMjkegAdF7dkJCDA1
 a49A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770177317; x=1770782117; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tf5RbUuZBD7vAitiDxd/SxMvRKm2h5sg9P3f0WhMpEo=;
 b=OIH1AelRQuRLHF7yx4qnUmdl80k60rIk8cRXkjhEB9UqkppRYIyIpUAQDyIEugTGAA
 cmFOEXpK0EbcSNZ/yR3SMn2yqpKyIFywjwS/HLlf1TkwDRqImJ7wpXH85PZ16hyxv5yT
 2rdHw09P6I2MlWXjUALYkazq0EsflJEgZ2HFBq4ocNHfhFeMx8bY8LVfOgwG49fEYvue
 2Zxwsu9aUV4qgXxjloEqK8JOfhTP9ly7vzqu8HTOEtbRlzFEQ5VyMbL5jG9HcSsfE7Jk
 Syey57zYMCgxDz4FnPnwc0B6QjMqVe9icUrkRTMx4LimnyaqL56cRxqFXL06ug/uP+jt
 iXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770177317; x=1770782117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tf5RbUuZBD7vAitiDxd/SxMvRKm2h5sg9P3f0WhMpEo=;
 b=u3fHxChC9sBfSuzwxR7e8q7MVTdTluU6CoJJFdTopQMck7XChLg8MgrfMKHF5OrpTs
 46jpJ/+4IrW2Kt6tljTooStllBrARS86Ycb6tQqipIuC/rQhaJTxBCqQW8Hh/PMhsejz
 bktqLMsa92QLcaWGTasqu9MPRJYRXpaHb6vuMYd07o8h3+0kIgby2jcpE23dy0KGtk3i
 nfq+Nokje7aEep5AaCs8rjXMpCAag6t8EcUIu7UaAkY8DUnEhLqph5Fl3X94ojQ+yVM4
 wXOIhvSjOQAsHZ04i/GuidmdbrFUHQAr9QGxed1MFMAY6fPA9jcjaR+ACTGx44QuckOc
 mMqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Quv3tYEyWjqHshcKX0vm7WfDJBU4or1SzYScQxR9+s4+ZGcffBCiox0SF6vkzeZ4buLcNc5e@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynGv6EiF9iOxBd7Ipezskw1UrN+0aCpZ8NlnSuNIinnRDGtXoE
 lOzYaKmaywY7PJg9szLxKavYIu8Lw1+8MBf80xPP7sq6AqUa4lcFpgoaZ3S8wOnyOqZ/j04wQlY
 yhwOQgY0cv2iqAZBavUcXbxS5YW/bEfA=
X-Gm-Gg: AZuq6aIwxKPX3ouNiQWb4O/GmZEpgr/0lrIDxn5oq/8kGXucXndZ/YXRUoCYXSalyvo
 YnGjlTHJgzr2dCTAUR8HtUKON00seg85NEUkR+nY2fvXlSPWioOn08BKMkw0o2/qNu/K9w+sP9E
 Q6QoFuZRTfrB7U5j3jtt7Ug2CCn/pFDXoPM5sXcGmNTb/4+NhYbaK6rQMD8XknKcR+zqgpACMsw
 UTM5wTZ3NaCNwJNVwXWaoEPa64sRvmdVT2XbG4hXGj0lUToDL9us2tl4giZbwP71MQoGwI+MNyD
 y6KSwpnTzDXmNjtwNAhceXTkUNLMWLetLIUwWpBsMAPpQDK2b5I+n4E=
X-Received: by 2002:a05:6214:1d29:b0:894:7eb9:ead2 with SMTP id
 6a1803df08f44-895221a66d7mr25922916d6.32.1770177317310; Tue, 03 Feb 2026
 19:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20260120204303.3229303-1-joelagnelf@nvidia.com>
 <20260120204303.3229303-4-joelagnelf@nvidia.com>
In-Reply-To: <20260120204303.3229303-4-joelagnelf@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 4 Feb 2026 13:55:06 +1000
X-Gm-Features: AZwV_QgqNJTzw-ZqXx5fJP-IeYh6sbx0Oiz2PE2A1U4oPqZRrSE9m3Umv0I5kN4
Message-ID: <CAPM=9tyL_Cq3+qWc4A41p7eqnNDLS1APUEeUbaQyJ46YDkipVw@mail.gmail.com>
Subject: Re: [PATCH RFC v6 03/26] rust: gpu: Add GPU buddy allocator bindings
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>, 
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Alexey Ivanov <alexeyi@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 joel@joelfernandes.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

> +///
> +/// These flags control the allocation behavior of the buddy allocator.
> +#[derive(Clone, Copy, Default, PartialEq, Eq)]
> +pub struct BuddyFlags(usize);
> +
> +impl BuddyFlags {
> +    /// Range-based allocation from start to end addresses.
> +    pub const RANGE_ALLOCATION: usize = bindings::GPU_BUDDY_RANGE_ALLOCATION;
> +
> +    /// Allocate from top of address space downward.
> +    pub const TOPDOWN_ALLOCATION: usize = bindings::GPU_BUDDY_TOPDOWN_ALLOCATION;
> +
> +    /// Allocate physically contiguous blocks.
> +    pub const CONTIGUOUS_ALLOCATION: usize = bindings::GPU_BUDDY_CONTIGUOUS_ALLOCATION;
> +
> +    /// Request allocation from the cleared (zeroed) memory. The zero'ing is not
> +    /// done by the allocator, but by the caller before freeing old blocks.
> +    pub const CLEAR_ALLOCATION: usize = bindings::GPU_BUDDY_CLEAR_ALLOCATION;
> +
> +    /// Disable trimming of partially used blocks.
> +    pub const TRIM_DISABLE: usize = bindings::GPU_BUDDY_TRIM_DISABLE;
> +
> +    /// Mark blocks as cleared (zeroed) when freeing. When set during free,
> +    /// indicates that the caller has already zeroed the memory.
> +    pub const CLEARED: usize = bindings::GPU_BUDDY_CLEARED;
> +
> +    /// Create [`BuddyFlags`] from a raw value with validation.
> +    ///
> +    /// Use `|` operator to combine flags if needed, before calling this method.
> +    pub fn try_new(flags: usize) -> Result<Self> {
> +        // Flags must not exceed u32::MAX to satisfy the GPU buddy allocator C API.
> +        if flags > u32::MAX as usize {
> +            return Err(EINVAL);
> +        }
> +
> +        // `TOPDOWN_ALLOCATION` only works without `RANGE_ALLOCATION`. When both are
> +        // set, `TOPDOWN_ALLOCATION` is silently ignored by the allocator. Reject this.
> +        if (flags & Self::RANGE_ALLOCATION) != 0 && (flags & Self::TOPDOWN_ALLOCATION) != 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(Self(flags))
> +    }
> +
> +    /// Get raw value of the flags.
> +    pub(crate) fn as_raw(self) -> usize {
> +        self.0
> +    }
> +}
> +
> +/// Parameters for creating a GPU buddy allocator.
> +#[derive(Clone, Copy)]
> +pub struct GpuBuddyParams {
> +    /// Base offset in bytes where the managed memory region starts.
> +    /// Allocations will be offset by this value.
> +    pub base_offset_bytes: u64,
> +    /// Total physical memory size managed by the allocator in bytes.
> +    pub physical_memory_size_bytes: u64,
> +    /// Minimum allocation unit / chunk size in bytes, must be >= 4KB.
> +    pub chunk_size_bytes: u64,
> +}
> +
> +/// Parameters for allocating blocks from a GPU buddy allocator.
> +#[derive(Clone, Copy)]
> +pub struct GpuBuddyAllocParams {
> +    /// Start of allocation range in bytes. Use 0 for beginning.
> +    pub start_range_address: u64,
> +    /// End of allocation range in bytes. Use 0 for entire range.
> +    pub end_range_address: u64,
> +    /// Total size to allocate in bytes.
> +    pub size_bytes: u64,
> +    /// Minimum block size for fragmented allocations in bytes.
> +    pub min_block_size_bytes: u64,
> +    /// Buddy allocator behavior flags.
> +    pub buddy_flags: BuddyFlags,
> +}
> +

(not a full review)

Any reason these two need Clone, Copy? I'm not seeing a use case for
that, maybe we should pass them as non-mutable references, but I don't
think there is any point in passing them by value ever.

Dave.
