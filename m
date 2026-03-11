Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFB3FED2DD
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 07:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114C610E98A;
	Thu, 12 Mar 2026 07:48:18 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com
 [216.40.44.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD48D10E205;
 Wed, 11 Mar 2026 14:03:44 +0000 (UTC)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay02.hostedemail.com (Postfix) with ESMTP id 4324D139CEA;
 Wed, 11 Mar 2026 14:03:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by
 omf20.hostedemail.com (Postfix) with ESMTPA id 0CF3220025; 
 Wed, 11 Mar 2026 14:03:20 +0000 (UTC)
Date: Wed, 11 Mar 2026 10:03:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311141332.b611237d36b61b2409e66cb3@kernel.org>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
 <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CF3220025
X-Stat-Signature: ff8ct3tumfmuryqygkfkcm78w16u4scc
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+skqrXXDxm4il2tsYmj25H0/GTzSRdMUI=
X-HE-Tag: 1773237800-364001
X-HE-Meta: U2FsdGVkX1+aU4mY7bFvO8lRauP/vgjT20dobHa0QHVROVhTP6xZNvlHFy+HnthX7C3DUw86Ksayk8kipkioUde1pGRJffeDzlmGTmiRQAtxOhSsM3gHnZJQZGdgNXBABYZdeE7OsMEvCI5Ff4ZQbbyu3yXHRyZXg5AHof/AO0vcusmeqjpCWWhtLLOcuZIY7+tOVjT7VktVnLaFPp1jjRLc3JQ2sJ4jp/SiL4aHgDK/k//b9d34oAYT+AlJT32Fm0BFv3eObF3U3OAnj7CnGXu0MyQ+0edSgYKqKIiOybnUsF1fYSODF4X+zk3bqwV4HOqJnRMkZevrGktYEsiiqb8/qNY0d6MZ
X-Mailman-Approved-At: Thu, 12 Mar 2026 07:48:09 +0000
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

On Wed, 11 Mar 2026 14:13:32 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> 
> node = rhashtable_walk_next(&iter);
> while (!IS_ERR_OR_NULL(node)) {
> 	fprobe_remove_node_in_module(mod, node, &alist);
> 	node = rhashtable_walk_next(&iter);
> }

But now you need to have a duplicate code in order to acquire "node"

I think the patch just makes the code worse.

-- Steve
