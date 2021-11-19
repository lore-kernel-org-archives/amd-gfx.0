Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE76C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 08:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275A861AED
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 08:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 275A861AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F076F8C9;
	Fri, 19 Nov 2021 08:54:43 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A43C6ED20
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 04:33:30 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id b68so8253160pfg.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 20:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wUYPD/dK7AbnmjRt7DrfQALSJEYOeqazWN+/nDCsZLE=;
 b=a2hOSHDbbGGI/Snv4mcOO+vrCftQw4roHy+cd6KGotO6J02ATNiF0hoYAbTTNMwb7W
 KkDkfLCikndxpSP0pUpRx8sf0vpEGC+dZC/Is0QucWsR9vQPLodQivhxlLw5Q/5/7ISm
 xltnpoduAlf2krlb4/olzkA1vuqSR8qWx5pOc/onmJsJDe/RAjMn4aXLgRvWB/YKwYDP
 VYQYSC8U9VQjSyx2GXiOSDQ271JOWJ6wp2G3s0ofgwvl8P5m22gY/Z6QpMmJs5x0VShW
 14wSspIzOnYZIwwrkQ6Q0bFiCQb6qf+1FsIyHIhE7/RyCQelp6KRCpcFFIh466ScHX/a
 gNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wUYPD/dK7AbnmjRt7DrfQALSJEYOeqazWN+/nDCsZLE=;
 b=Wezn4P/OXiqq3Y3/lZaRTBmDB+y5P0CbHHniLPglYD4NTwV4hLZWih/m61sZt8NClJ
 Itv8r6wDQXBMEf6VsasWtWH2O9XrxXAw8srG0E41fp4hPVimfUMBkOyTwbIq6d5MdcaZ
 X1RiZ2EnX9RCZERBRnOnDdJC5YDM/vWqF1tEhc4i+jX58/kR4ZyAe0HiyCZYOl5afTwm
 jNJ3/e7nBHJFFGnJemzGX6O7pM6JqvT/zNwPDPnij6PbhP6EsN/DEuzuQ7sWNBJp8F/Z
 +sTan4G8PSXGpw5vtazpW1yGxKG+hZ1LQAdiKcXuyLdOgi0JVQUycXdXcEjXp1PQUXdf
 DfrA==
X-Gm-Message-State: AOAM533W2C4S5cnLjg8uOKm6+N1YKkmMJymA8zYcJ3OclDTHl1pp1nzB
 Lv304AoYrtxqa6H8RtL0KoE=
X-Google-Smtp-Source: ABdhPJwjdFNtrn4pAEY6hHtGXWt8HOw1WUzDFERb/z8hEPaVAxeBm6/u7oj4sAyn10TnHd2eutqWVw==
X-Received: by 2002:a62:1e81:0:b0:4a3:7a97:d868 with SMTP id
 e123-20020a621e81000000b004a37a97d868mr4167067pfe.52.1637296410204; 
 Thu, 18 Nov 2021 20:33:30 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e33])
 by smtp.gmail.com with ESMTPSA id b4sm1193366pfl.60.2021.11.18.20.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Nov 2021 20:33:29 -0800 (PST)
Date: Thu, 18 Nov 2021 20:33:26 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kenny Ho <Kenny.Ho@amd.com>
Subject: Re: [PATCH RFC 4/4] bpf,cgroup,perf: extend bpf-cgroup to support
 tracepoint attachment
Message-ID: <20211119043326.a4pmgitlkljpamgh@ast-mbp.dhcp.thefacebook.com>
References: <20211118202840.1001787-1-Kenny.Ho@amd.com>
 <20211118202840.1001787-5-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118202840.1001787-5-Kenny.Ho@amd.com>
X-Mailman-Approved-At: Fri, 19 Nov 2021 08:54:42 +0000
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
 Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
 Jiri Olsa <jolsa@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 amd-gfx@lists.freedesktop.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Yonghong Song <yhs@fb.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, KP Singh <kpsingh@kernel.org>,
 y2kenny@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
 Namhyung Kim <namhyung@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 18, 2021 at 03:28:40PM -0500, Kenny Ho wrote:
> @@ -245,6 +256,21 @@ static int compute_effective_progs(struct cgroup *cgrp,
>  	if (!progs)
>  		return -ENOMEM;
>  
> +	if (atype == CGROUP_TRACEPOINT) {
> +		/* TODO: only create event for cgroup that can have process */
> +
> +		attr.config = bpf_attach_subtype;
> +		attr.type = PERF_TYPE_TRACEPOINT;
> +		attr.sample_type = PERF_SAMPLE_RAW;
> +		attr.sample_period = 1;
> +		attr.wakeup_events = 1;
> +
> +		rc = perf_event_create_for_all_cpus(&attr, cgrp,
> +				&cgrp->bpf.per_cg_events);
> +		if (rc)
> +			goto err;
> +	}
...
> +int perf_event_create_for_all_cpus(struct perf_event_attr *attr,
> +				struct cgroup *cgroup,
> +				struct list_head *entries)
> +{
> +	struct perf_event **events;
> +        struct perf_cgroup *perf_cgrp;
> +	int cpu, i = 0;
> +
> +	events = kzalloc(sizeof(struct perf_event *) * num_possible_cpus(),
> +			GFP_KERNEL);
> +
> +	if (!events)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		/* allocate first, connect the cgroup later */
> +		events[i] = perf_event_create_kernel_counter(attr, cpu, NULL, NULL, NULL);

This is a very heavy hammer for this task.
There is really no need for perf_event to be created.
Did you consider using raw_tp approach instead?
It doesn't need this heavy stuff.
Also I suspect in follow up you'd be adding tracepoints to GPU code?
Did you consider just leaving few __weak global functions in GPU code
and let bpf progs attach to them as fentry?
I suspect the true hierarchical nature of bpf-cgroup framework isn't necessary.
The bpf program itself can filter for given cgroup.
We have bpf_current_task_under_cgroup() and friends.
I suggest to sprinkle __weak empty funcs in GPU and see what
you can do with it with fentry and bpf_current_task_under_cgroup.
There is also bpf_get_current_ancestor_cgroup_id().
