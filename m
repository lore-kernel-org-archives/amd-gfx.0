Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FFBD46C1D
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Jan 2026 03:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671DD10E1D7;
	Sat, 31 Jan 2026 03:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WOeYPAN4";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0C010E1D7
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Jan 2026 03:01:11 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-89473dca8aaso30754296d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 19:01:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769828470; cv=none;
 d=google.com; s=arc-20240605;
 b=DThvl+XVsWs+puVLGLh0lqueNwHhG4OwajKV8GMUPIfdNFTF3XmOPiWfSbCLHFxora
 YH94Cu4fVVVnd7z2Fd4b0lhzpmjlpIgJ/XeXcgI6v/pu9gz9kBkYfCegnmM1lJp1fUJJ
 JVpaWA2Q+i9r/8Iv0c0fpVsIcNemeRW1HuenEDfB/6lKxWUfOBcd8BGgCUL9zgWY2fln
 CjQJqQBvHDMU/KiB9XOdn9sRoRFsTqrbgH3uZ3tIDrC/LSY2TM/T0eXG3RsCpmkPqTrW
 3ClvfBeY5FrwX+1DKI5gPOyHAA+U6FMq0XLnlvXKHYQwdJL+fTjFjHm5fGtMw0SfHEtz
 4Eng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0dP1zizuvb+YCTfhetz0ht1UJLaJiSW38KjUpELCixc=;
 fh=F1nwix1dg1gKHwUF8PqWrGdFwJFoR4nCy7PAUhr9QH8=;
 b=kAhusnC8WExoNrKRwxeYotaqTr7z/eeIGGP2nCyIK0u726j83bIOKJkZDBumbinJDw
 HY/f7ZvOOdD7iv23Vc69FrVqZk6MLV0EyFp/oIPU5VAP7uwyKdsJJQdW/Tp9t8GNK1G2
 2nsz4NZdChFC4ApyEdZZDIkxHZPy/iIwKbVgl1vQEAb5kTg64mTv9Ndtn854Qud5/ojr
 spBMA1aXn8p8f4WhZOpACxImUMztu5yYy7a/WDwW7irekMkLiLPYWDcyaziHnG6o5cPi
 I/R6vwXYW8ZDr6Mb8RlDOSynR4vHrAS0uheExMBH7untvn4U0mCCXsnv4c6pNr3Hlney
 5NUQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769828470; x=1770433270; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0dP1zizuvb+YCTfhetz0ht1UJLaJiSW38KjUpELCixc=;
 b=WOeYPAN4YP5WeM3wWxdkGE6XdrMugWpXBW6j+zzOaz0BMj1EqTPyR3Rc2vo57O2xSq
 UxUFGG5ecB+xKaQZ25Xry2WuyhvMIDnC3aC1QEysqvbs4bQbCZ3RzKg71kDNCyvDmC5L
 D0u9YFRVx5XpKZMlvq4AmQH9wNfAWIfD+GWxt4Cq8f2PYy8CGqZWXwyBI6NW9puMh4ex
 njYDHfJ8U7Xz7K2hSrCgIRA+k2LULUyQ2te1Kvy9AasHqFBM90jUn/Fr6TqpqBj1F5ij
 rR0xrN7CXHg+sjxwchU2FaGQinkjc+lrwfAyukP7n8ANBFlEkppXZEND0eVF7yDBhyf8
 zkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769828470; x=1770433270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dP1zizuvb+YCTfhetz0ht1UJLaJiSW38KjUpELCixc=;
 b=lMs2CIXDswG1McTaFBQSozIS0434iUyGdENEI5Wo6SzQvPV9v27Fokni0ZshzRvVEj
 0i0sIsN6hpx0NMNNd/+Yixs3ueQQrWg6ukh3JEJKcuga1lUCGD2Ixjrs0Su6OhAK7o3P
 6bCGgP3gQkfRbFpkLzzd6hKnOhUPODkI34MajyyoYk4bDacF5WimwPq9IgIV7EpFVWBr
 lsfI4iuyq1y7Agjq6PcktBfNxKhfcV+jI0grLVehWGKVBmVqrcKpEaZHLt/Eym3alAew
 DvqtDqMMaIAYf4NuQjk6gvG7P8Lr62bboggZPkLQfPJuHw5RYBE1WU4nGqwtsH2MzWO+
 iakw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0ampVVmMHRS4BCKqcPU6FDibQDPJv7uQ6LvpV+rNBzHS2aqw5qmNlARI6dHwCbIlyei53ROba@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWS3zuEfh9BtSsFgIlAv2h//vDJNTssYRr7lxiayCp28ZSbaV0
 5FLXJXn7C+n/7Yo9NNXC1OeNntkSSQ2jiNbEHcdh7Y+WliFb0pHYPUB1j1WygxDkUDyhdkCJZgH
 SpBwPSh1SwaWgyCLoNqhz1MFX8M+kCzo=
X-Gm-Gg: AZuq6aIvvSaK21blknaF75V/uFzHqIRvzAdyoHxC9e4EWLYsubpLjCAkZ6IR8OpNILM
 vNM6PRHDZrD1Fe7E/OBnTp4kTnUFq7egjJ22ucdxJO9GlyxeeQV57rTGdVDZK5TCTmWg8peOCtd
 EBSaDS9UWKIPhV6ttdLq9cEG0dFlR5IBJ85f1uNnDVuVm3UKiipUgzgO1OJWRViNwQOaz/FrOne
 JL7PlyH1T08B2ArVdb85StlEopItFhhS7+3GyfglbUOk1Yg65HutzWlIli+8eVMtb3I0G4i1Sq0
 cPGyaWyXNw36aGdENoTntz39Z9VTLhJE8r6EFpmLUH47L2+HtXCLIMc=
X-Received: by 2002:a05:6214:260b:b0:880:51f0:5b93 with SMTP id
 6a1803df08f44-894e9fe6cbemr81159006d6.18.1769828470148; Fri, 30 Jan 2026
 19:01:10 -0800 (PST)
MIME-Version: 1.0
References: <97af2d85-a905-44d4-951f-e56a40f4312e@nvidia.com>
 <20260130015901.GA301119@joelbox2>
 <c064fbdc-9202-437d-80ff-6134d2a33778@nvidia.com>
 <70d88203-2fe1-4bde-b254-51e8107744eb@nvidia.com>
In-Reply-To: <70d88203-2fe1-4bde-b254-51e8107744eb@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 31 Jan 2026 13:00:58 +1000
X-Gm-Features: AZwV_QikuSqbC3QYogib7-81aPfnOToX57Ol8yNxSKEx4_hXbDFs8a3hQtETIYo
Message-ID: <CAPM=9twm1x9rH==uoGQLYa8b4feQMz=Ne14WPuhCPy9_H1u5Tw@mail.gmail.com>
Subject: Re: [PATCH RFC v6 05/26] nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Zhi Wang <zhiw@nvidia.com>, linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rui Huang <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Edwin Peer <epeer@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, 
 Andy Ritger <aritger@nvidia.com>, Alexey Ivanov <alexeyi@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
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

On Sat, 31 Jan 2026 at 07:14, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>
>
>
> On 1/29/2026 10:38 PM, John Hubbard wrote:
> > On 1/29/26 5:59 PM, Joel Fernandes wrote:
> >> On 1/29/26 8:12 PM, John Hubbard wrote:
> >>> On 1/29/26 4:26 PM, Joel Fernandes wrote:
> >>>> Based on the below discussion and research, I came up with some deadlock
> >>>> scenarios that we need to handle in the v6 series of these patches.
> >>>> [...]
> >>>> memory allocations under locks that we need in the dma-fence signaling
> >>>> critical path (when doing the virtual memory map/unmap)
> >>>
> >>> unmap? Are you seeing any allocations happening during unmap? I don't
> >>> immediately see any, but that sounds surprising.
> >>
> >> Not allocations but we are acquiring locks during unmap. My understanding
> >> is (at least some) unmaps have to also be done in the dma fence signaling
> >> critical path (the run stage), but Danilo/you can correct me if I am wrong
> >> on that. We cannot avoid all locking but those same locks cannot be held in
> >> any other paths which do a memory allocation (as mentioned in one of the
> >> deadlock scenarios), that is probably the main thing to check for unmap.
> >>
> >
> > Right, OK we are on the same page now: no allocations happening on unmap,
> > but it can still deadlock, because the driver is typically going to
> > use a single lock to protect calls both map and unmap-related calls
> > to the buddy allocator.
>
> Yes exactly!
>
> >
> > For the deadlock above, I think a good way to break that deadlock is
> > to not allow taking that lock in a fence signaling calling path.
> >
> > So during an unmap, instead of "lock, unmap/free, unlock" it should
> > move the item to a deferred-free list, which is processed separately.
> > Of course, this is a little complex, because the allocation and reclaim
> > has to be aware of such lists if they get large.
> Yes, also avoiding GFP_KERNEL allocations while holding any of these mm locks
> (whichever we take during map). The GPU buddy actually does GFP_KERNEL
> allocations internally which is problematic.
>
> Some solutions / next steps:
>
> 1. allocating (VRAM and system memory) outside mm locks just before acquiring them.
>
> 2. pre-allocating both VRAM and system memory needed, before the DMA fence
> critical paths (The issue is also to figure out how much memory to pre-allocate
> for the page table pages based on the VM_BIND request. I think we can analyze
> the page tables in the submit stage to make an estimate).
>
> 3. Unfortunately, I am using gpu-buddy when allocating a VA range in the Vmm
> (called virt_buddy), which itself does GFP_KERNEL memory allocations in the
> allocate path. I am not sure what do yet about this. ISTR the maple tree also
> has similar issues.
>
> 4. Using non-reclaimable memory allocations where pre-allocation or
> pre-allocated memory pools is not possible (I'd like to avoid this #4 so we
> don't fail allocations when memory is scarce).
>
> Will work on these issues for the v7. Thanks,

The way this works on nouveau at least (and I haven't yet read the
nova code in depth).

Is we have 4 stages of vmm page table mgmt.

ref - locked with a ref lock - can allocate/free memory - just makes
sure the page tables exist and are reference counted
map - locked with a map lock - cannot allocate memory - fill in the
PTEs in the page table
unmap - locked with a map lock - cannot allocate memory - removes
entries in PTEs
unref - locked with a ref lock - can allocate/free memory - just drops
references and frees (not sure if it ever merges).

So maps and unmaps can be in fence signalling paths, but unrefs are
done in free job from a workqueue.

Dave.
>
> --
> Joel Fernandes
>
