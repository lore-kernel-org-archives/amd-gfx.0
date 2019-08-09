From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v19 04/15] mm: untag user pointers passed to memory
 syscalls
Date: Fri, 9 Aug 2019 17:03:01 +0100
Message-ID: <20190809160301.GB23083@arrakis.emea.arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <aaf0c0969d46b2feb9017f3e1b3ef3970b633d91.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aaf0c0969d46b2feb9017f3e1b3ef3970b633d91.1563904656.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Yishai Hadas <yishaih@mellanox.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 23, 2019 at 07:58:41PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pass
> tagged user pointers (with the top byte set to something else other than
> 0x00) as syscall arguments.
> 
> This patch allows tagged pointers to be passed to the following memory
> syscalls: get_mempolicy, madvise, mbind, mincore, mlock, mlock2, mprotect,
> mremap, msync, munlock, move_pages.
> 
> The mmap and mremap syscalls do not currently accept tagged addresses.
> Architectures may interpret the tag as a background colour for the
> corresponding vma.
> 
> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/madvise.c   | 2 ++
>  mm/mempolicy.c | 3 +++
>  mm/migrate.c   | 2 +-
>  mm/mincore.c   | 2 ++
>  mm/mlock.c     | 4 ++++
>  mm/mprotect.c  | 2 ++
>  mm/mremap.c    | 7 +++++++
>  mm/msync.c     | 2 ++
>  8 files changed, 23 insertions(+), 1 deletion(-)

More back and forth discussions on how to specify the exceptions here.
I'm proposing just dropping the exceptions and folding in the diff
below.

Andrew, if you prefer a standalone patch instead, please let me know:

------------------8<----------------------------
>From 9a5286acaa638c6a917d96986bf28dad35e24a0c Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 9 Aug 2019 14:21:33 +0100
Subject: [PATCH] fixup! mm: untag user pointers passed to memory syscalls

mmap, mremap, munmap, brk added to the list of syscalls that accept
tagged pointers.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/mmap.c   | 5 +++++
 mm/mremap.c | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..b766b633b7ae 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -201,6 +201,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded = false;
 	LIST_HEAD(uf);
 
+	brk = untagged_addr(brk);
+
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
@@ -1573,6 +1575,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 	struct file *file = NULL;
 	unsigned long retval;
 
+	addr = untagged_addr(addr);
+
 	if (!(flags & MAP_ANONYMOUS)) {
 		audit_mmap_fd(fd, flags);
 		file = fget(fd);
@@ -2874,6 +2878,7 @@ EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
+	addr = untagged_addr(addr);
 	profile_munmap(addr);
 	return __vm_munmap(addr, len, true);
 }
diff --git a/mm/mremap.c b/mm/mremap.c
index 64c9a3b8be0a..1fc8a29fbe3f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -606,12 +606,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
-	/*
-	 * Architectures may interpret the tag passed to mmap as a background
-	 * colour for the corresponding vma. For mremap we don't allow tagged
-	 * new_addr to preserve similar behaviour to mmap.
-	 */
 	addr = untagged_addr(addr);
+	new_addr = untagged_addr(new_addr);
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		return ret;
