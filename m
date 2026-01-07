Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D55D185F1
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F2510E724;
	Thu,  8 Jan 2026 13:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Psy66J16";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E288510E086
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 20:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767817956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=01UmXmyvT8OScJdoEXdlI/lzlLOJUWcDgELiuatsWmA=;
 b=Psy66J16oNg7iJH+OAvc/X/J05XNFaX+ZurhU1QzqfU2SAisx8LbuDNekXmezOUdbGNOqp
 vBLY9i5iSc+jodui/H1aBtmlk7cnULakT9E1FM2qTfp9zPzPWG3Wxw+7cRrjoObWI5+h9i
 2f5Y642TuQycj9rNrmd1VR6C9Bbqi+s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-MK3M_cvVOUSMroMKk8-w0w-1; Wed,
 07 Jan 2026 15:32:32 -0500
X-MC-Unique: MK3M_cvVOUSMroMKk8-w0w-1
X-Mimecast-MFC-AGG-ID: MK3M_cvVOUSMroMKk8-w0w_1767817950
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EC6D18005B3; Wed,  7 Jan 2026 20:32:30 +0000 (UTC)
Received: from debian4.vm (unknown [10.44.33.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP
 id 3CF4930002D1; Wed,  7 Jan 2026 20:32:26 +0000 (UTC)
Received: by debian4.vm (sSMTP sendmail emulation);
 Wed, 07 Jan 2026 21:32:24 +0100
Message-ID: <20260107203224.969740802@debian4.vm>
User-Agent: quilt/0.68
Date: Wed, 07 Jan 2026 21:31:14 +0100
From: Mikulas Patocka <mpatocka@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Mikulas Patocka <mpatocka@redhat.com>,
 stable@vger.kernel.org
Subject: [PATCH v4 1/2] mm_take_all_locks: change -EINTR to -ERESTARTSYS
References: <20260107203113.690118053@debian4.vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mailman-Approved-At: Thu, 08 Jan 2026 13:37:29 +0000
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

If a process receives a signal while it executes some kernel code that
calls mm_take_all_locks, we get -EINTR error. The -EINTR is propagated up
the call stack to userspace and userspace may fail if it gets this
error.

This commit changes -EINTR to -ERESTARTSYS, so that if the signal handler
was installed with the SA_RESTART flag, the operation is automatically
restarted.

For example, this problem happens when using OpenCL on AMDGPU. If some
signal races with clGetDeviceIDs, clGetDeviceIDs returns an error
CL_DEVICE_NOT_FOUND (and strace shows that open("/dev/kfd") failed with
EINTR).

This problem can be reproduced with the following program.

To run this program, you need AMD graphics card and the package
"rocm-opencl" installed. You must not have the package "mesa-opencl-icd"
installed, because it redirects the default OpenCL implementation to
itself.

include <stdio.h>
include <stdlib.h>
include <unistd.h>
include <string.h>
include <signal.h>
include <sys/time.h>

define CL_TARGET_OPENCL_VERSION	300
include <CL/opencl.h>

static void fn(void)
{
	while (1) {
		int32_t err;
		cl_device_id device;
		err = clGetDeviceIDs(NULL, CL_DEVICE_TYPE_GPU, 1, &device, NULL);
		if (err != CL_SUCCESS) {
			fprintf(stderr, "clGetDeviceIDs failed: %d\n", err);
			exit(1);
		}
		write(2, "-", 1);
	}
}

static void alrm(int sig)
{
	write(2, ".", 1);
}

int main(void)
{
	struct itimerval it;
	struct sigaction sa;
	memset(&sa, 0, sizeof sa);
	sa.sa_handler = alrm;
	sa.sa_flags = SA_RESTART;
	sigaction(SIGALRM, &sa, NULL);
	it.it_interval.tv_sec = 0;
	it.it_interval.tv_usec = 50;
	it.it_value.tv_sec = 0;
	it.it_value.tv_usec = 50;
	setitimer(ITIMER_REAL, &it, NULL);
	fn();
	return 1;
}

I'm submitting this patch for the stable kernels, because the AMD ROCm
stack fails if it receives EINTR from open (it seems to restart EINTR
from ioctl correctly). The process may receive signals at unpredictable
times, so the OpenCL implementation may fail at unpredictable times.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-November/133141.html
Link: https://yhbt.net/lore/linux-mm/6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com/T/#u
Cc: stable@vger.kernel.org
Fixes: 7906d00cd1f6 ("mmu-notifiers: add mm_take_all_locks() operation")
---
 mm/vma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: mm/mm/vma.c
===================================================================
--- mm.orig/mm/vma.c	2026-01-07 20:11:21.000000000 +0100
+++ mm/mm/vma.c	2026-01-07 20:11:21.000000000 +0100
@@ -2202,7 +2202,7 @@ int mm_take_all_locks(struct mm_struct *
 
 out_unlock:
 	mm_drop_all_locks(mm);
-	return -EINTR;
+	return -ERESTARTSYS;
 }
 
 static void vm_unlock_anon_vma(struct anon_vma *anon_vma)

