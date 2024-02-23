Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C464C54E49
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 09:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D7610EF9F;
	Mon, 26 Feb 2024 09:04:45 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C5310E2AD;
 Fri, 23 Feb 2024 20:43:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CAB6DCE2E6D;
 Fri, 23 Feb 2024 20:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE0C43390;
 Fri, 23 Feb 2024 20:43:39 +0000 (UTC)
Date: Fri, 23 Feb 2024 15:45:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
 <freedreno@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
 <linux-rdma@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
 <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
 <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>,
 <linux-usb@vger.kernel.org>, <linux-bcachefs@vger.kernel.org>,
 <linux-nfs@vger.kernel.org>, <ocfs2-devel@lists.linux.dev>,
 <linux-cifs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
 <linux-edac@vger.kernel.org>, <selinux@vger.kernel.org>,
 <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-hwmon@vger.kernel.org>,
 <io-uring@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-wpan@vger.kernel.org>, <dev@openvswitch.org>,
 <linux-s390@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
 Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [FYI][PATCH] tracing/treewide: Remove second parameter of
 __assign_str()
Message-ID: <20240223154532.76475d82@gandalf.local.home>
In-Reply-To: <20240223134653.524a5c9e@gandalf.local.home>
References: <20240223125634.2888c973@gandalf.local.home>
 <0aed6cf2-17ae-45aa-b7ff-03da932ea4e0@quicinc.com>
 <20240223134653.524a5c9e@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 26 Feb 2024 09:04:42 +0000
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

On Fri, 23 Feb 2024 13:46:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Now one thing I could do is to not remove the parameter, but just add:
> 
> 	WARN_ON_ONCE((src) != __data_offsets->item##_ptr_);
> 
> in the __assign_str() macro to make sure that it's still the same that is
> assigned. But I'm not sure how useful that is, and still causes burden to
> have it. I never really liked the passing of the string in two places to
> begin with.

Hmm, maybe I'll just add this patch for 6.9 and then in 6.10 do the
parameter removal.

-- Steve

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 0c0f50bcdc56..7372e2c2a0c4 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -35,6 +35,7 @@ #define __assign_str(dst, src)
 	do {								\
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
+		WARN_ON_ONCE((src) != __data_offsets.dst##_ptr_); 	\
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] = '\0';				\
