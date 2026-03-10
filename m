Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6BAFD0657
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 08:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C602210E839;
	Wed, 11 Mar 2026 08:09:31 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com
 [216.40.44.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05B910E712;
 Tue, 10 Mar 2026 14:08:10 +0000 (UTC)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay01.hostedemail.com (Postfix) with ESMTP id 0CEFF1C171;
 Tue, 10 Mar 2026 14:08:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by
 omf14.hostedemail.com (Postfix) with ESMTPA id 847E92D; 
 Tue, 10 Mar 2026 14:07:40 +0000 (UTC)
Date: Tue, 10 Mar 2026 10:07:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
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
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <20260310100750.303af303@gandalf.local.home>
In-Reply-To: <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 847E92D
X-Stat-Signature: 7qtdkkf3por5hcs9du9pir5nqq8uht35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Z3Tx1sMlUDFHS8YYPfSOpiqPw8cg/LfU=
X-HE-Tag: 1773151660-993833
X-HE-Meta: U2FsdGVkX1+JWrMXdInzvBx9l2WUqahyoYUezPLaF3HICGuHpiLcos2NJHmqwFPLfM8ZBXZ6/fmTg/vlHLcqcaFGukyEZOsOE3kBaCKhhIkGksjLucUHfFRW8KX39dTkHeOQhZTWX/A0f9Y+1fWRMEQzHGhaJF2wpPshgb4yUxNCAKdeI6QYyukTSlQGbTY7Uxizi79ndrJuznFkrJ0f1Gh3JC2I5gazyCY5QhqLMJ9a9ShPFpKdZ7NDaPeyx31oXfa0p+bWWHR1R5JbGDYWhbllAgJDuEbxQsOff6UlFUV0L3hTo0f3pFVAKw4ZSe/3wUeKTGah6IcaIcnei7ziR9eK5k/ow6hfmOBOZGq2CLBxHUplOJMJzaQEF/IeU48U6bUZ8WiPpl/JDxwK03ucqBa/7oG+YB+etWyAxh+TKdi7NbCLCb6PbeExJ2cO76n2AdjJCB03SaDGNN90kGsLmA==
X-Mailman-Approved-At: Wed, 11 Mar 2026 08:09:27 +0000
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

On Tue, 10 Mar 2026 12:48:41 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.

Why?

> 
> Change generated with coccinelle.
> 
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Masami Hiramatsu <mhiramat@kernel.org>
> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  kernel/trace/fprobe.c                | 2 +-
>  kernel/trace/kprobe_event_gen_test.c | 2 +-
>  kernel/trace/trace_events_hist.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index dcadf1d23b8a31f571392d0c49cbd22df1716b4f..a94ce810d83b90f55d1178a9bd29c78fd068df4c 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -607,7 +607,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	do {
>  		rhashtable_walk_start(&iter);
>  
> -		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> +		while (!IS_ERR_OR_NULL((node = rhashtable_walk_next(&iter))))

Ug, No!

That looks so much worse than the original.

-- Steve

>  			fprobe_remove_node_in_module(mod, node, &alist);
>  
>  		rhashtable_walk_stop(&iter);
> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> index 5a4b722b50451bfdee42769a6d3be39c055690d1..a1735ca273f0b756aa1fcfcdab30ddad9bc51c5f 100644
> --- a/kernel/trace/kprobe_event_gen_test.c
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -75,7 +75,7 @@ static struct trace_event_file *gen_kretprobe_test;
>  
>  static bool trace_event_file_is_valid(struct trace_event_file *input)
>  {
> -	return input && !IS_ERR(input);
> +	return !IS_ERR_OR_NULL(input);
>  }
>  
>  /*
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad555898693e92ee397a1c9493c7c167..59df215e1dfd9349eca1c0823ed709ec7285f766 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3973,7 +3973,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
>  	 */
>  	field_var = create_target_field_var(hist_data, system, event, var);
>  
> -	if (field_var && !IS_ERR(field_var)) {
> +	if (!IS_ERR_OR_NULL(field_var)) {
>  		save_field_var(hist_data, field_var);
>  		hist_field = field_var->var;
>  	} else {
> 

