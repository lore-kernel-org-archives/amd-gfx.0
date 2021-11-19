Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800E5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 06:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3845661B3D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 06:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3845661B3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7DF6EE7A;
	Fri, 19 Nov 2021 06:01:29 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E69A6EE7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 06:01:29 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id y26so38135491lfa.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 22:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cpacwUyzE+yZQi2HRsigmJjkmcIiIOSGZw3OzHsfooo=;
 b=RldlS2C/ckDa2ilqyd5cvlc3AjbT6JqCEXn82gXQCs6cELL7iYMIp14cSXKt0Pkve1
 jTesFFg+9gJSMX1G5oBdXRmcbNMdvb2tp21b0Cny/h3y4O81NUztrQExa82xCOsaoSYp
 ZUTJhomesLSaZWLLRMRpB+jgTQkwqv7IEDCbLcEBADbtKyUw6915Z5srh7D55OKNossi
 h0dcACKcphWlDBXg6grG4gE7CPxc7kyPmJwHgO8qCxXOWCpyvmhf3cQRglqv5k807Hd9
 x9bareYiM2HG5ucRSP21DZl0qs3ZYj8HICCV5GfknAxsyJYEJmZNSkr1YDswhBvmK47K
 GNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cpacwUyzE+yZQi2HRsigmJjkmcIiIOSGZw3OzHsfooo=;
 b=T3QW1yp8lSPFmpHwIsZmcQB6zi6aikCUscrd76L4ZlYDsHYD+q8Aui6+lG1ee/6pPz
 LFycsmP0FmvtDlgWHnYXj/Ne91wLleP5Slc8yY67yTUbtomAHJIc1SW74rtG75vKWFZY
 pivU++6vmjPZr0NWumjyr6k4JChU4QRha5w9+X5uM3VhSDEf5uMsAxZ5T97l9uN00wNH
 yr2y/5NlHXMABwRwgZJKxRKieF6EhIgh2l1T2QozB6LbKpogAfpWg36ScRT3b4zCK6IW
 /YLWjMYoxWP2U7J7Ogf051jXsQ1RN/MQGEjhj2InITCYg0cFWLemVtPCVLw6nXIcMpdr
 st1w==
X-Gm-Message-State: AOAM532eS2H+rz8w0ZEfuBJFIUyfzX+q80g4897IF1XEpXu7mvQAyHBp
 Oj6QzGNq/GjWcZxE+0hJA9y3ECO2C0kZW1IZM/E=
X-Google-Smtp-Source: ABdhPJwlfHbZdUmS+LrGu/838FzHKha8BHY1wMTXd2lj5AAMagnhC97ToIXsmSKtjIb5cKExksbkS2+JiTQteRHu6FM=
X-Received: by 2002:a2e:b6d4:: with SMTP id m20mr23968361ljo.471.1637301687274; 
 Thu, 18 Nov 2021 22:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20211118202840.1001787-1-Kenny.Ho@amd.com>
 <20211118202840.1001787-5-Kenny.Ho@amd.com>
 <20211119043326.a4pmgitlkljpamgh@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211119043326.a4pmgitlkljpamgh@ast-mbp.dhcp.thefacebook.com>
From: Kenny Ho <y2kenny@gmail.com>
Date: Fri, 19 Nov 2021 01:01:15 -0500
Message-ID: <CAOWid-dFFjrBx1YxRxssP=uAWAjQ75iU2jj_uRkBnx4Vt5YrpA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] bpf,cgroup,perf: extend bpf-cgroup to support
 tracepoint attachment
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Song Liu <songliubraving@fb.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>,
 "open list:CONTROL GROUP \(CGROUP\)" <cgroups@vger.kernel.org>,
 Jiri Olsa <jolsa@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Yonghong Song <yhs@fb.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>,
 Kenny Ho <Kenny.Ho@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 18, 2021 at 11:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 18, 2021 at 03:28:40PM -0500, Kenny Ho wrote:
> > +     for_each_possible_cpu(cpu) {
> > +             /* allocate first, connect the cgroup later */
> > +             events[i] = perf_event_create_kernel_counter(attr, cpu, NULL, NULL, NULL);
>
> This is a very heavy hammer for this task.
> There is really no need for perf_event to be created.
> Did you consider using raw_tp approach instead?

I came across raw_tp but I don't have a good understanding of it yet.
Initially I was hoping perf event/tracepoint is a stepping stone to
raw tp but that doesn't seem to be the case (and unfortunately I
picked the perf event/tracepoint route to dive in first because I saw
cgroup usage.)  Can you confirm if the following statements are true?

- is raw_tp related to writable tracepoint
- are perf_event/tracepoint/kprobe/uprobe and fentry/fexit/raw_tp
considered two separate 'things' (even though both of their purpose is
tracing)?

> It doesn't need this heavy stuff.
> Also I suspect in follow up you'd be adding tracepoints to GPU code?
> Did you consider just leaving few __weak global functions in GPU code
> and let bpf progs attach to them as fentry?
There are already tracepoints in the GPU code.  And I do like fentry
way of doing things more but my head was very much focused on cgroup,
and tracepoint/kprobe path seems to have something for it.  I
suspected this would be a bit too heavy after seeing the scalability
discussion but I wasn't sure so I whip this up quickly to get some
feedback (while learning more about perf/bpf/cgroup.)

> I suspect the true hierarchical nature of bpf-cgroup framework isn't necessary.
> The bpf program itself can filter for given cgroup.
> We have bpf_current_task_under_cgroup() and friends.
Is there a way to access cgroup local storage from a prog that is not
attached to a bpf-cgroup?  Although, I guess I can just store/read
things using a map with the cg id as key.  And with the
bpf_get_current_ancestor_cgroup_id below I can just simulate the
values being propagated if the hierarchy ends up being relevant.  Then
again, is there a way to atomically update multiple elements of a map?
 I am trying to figure out how to support a multi-user multi-app
sharing use case (like user A given quota X and user B given quota Y
with app 1 and 2 each having a quota assigned by A and app 8 and 9
each having quota assigned by B.)  Is there some kind of 'lock'
mechanism for me to keep quota 1,2,X in sync? (Same for 8,9,Y.)

> I suggest to sprinkle __weak empty funcs in GPU and see what
> you can do with it with fentry and bpf_current_task_under_cgroup.
> There is also bpf_get_current_ancestor_cgroup_id().
