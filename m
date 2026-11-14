Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A7606A327
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HulUfZPZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255A110E8C0;
	Sat, 14 Nov 2026 19:10:57 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D2710E130
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 14:11:19 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8b6a88e4341so742494b3a.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794665479; x=1795270279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X1aNKxDcC9Su/sKRcb+fwZwTfaJYdtOu8vWxOSG4H9Q=;
 b=HulUfZPZsvftiequU6wUy5YucBfCNgLqI8NEN5N9XmBvZd9XuShRMa6DIyo6hHSJvu
 tpWb9tz+dDgv3QgEcD7f4x82+gh5VBWWlHxEVJNwvDnGIy9LAVqQ5f/qQEqdgme2RBWZ
 yAOucwUVRWM4zwkd9dtjoMRpHMFuhgp8Z5ezeSJ1+KtZS2pgXHNTmc43GQ5rYZS7OE3W
 qih+eVefxNJLpDHOKW3egD7EPCBKlkYCa1KFhh8f6x1/BJZuOlIh53DKAuM1uU13BUwV
 2AkzcnSMXEhYuZkpcSkUvOroOQA34jruzfPAdnOr7IeT5OPkMPPIPbS5xfhFdlXZLLZt
 H1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794665479; x=1795270279;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X1aNKxDcC9Su/sKRcb+fwZwTfaJYdtOu8vWxOSG4H9Q=;
 b=kTYgUVvh5+x9NW/25mx/vNQpYOCanxYdKjzkpo1Na1Zm6fc968uNVhicApJYhjKthx
 8XXQXT8JZMeqLSRqkcUw6zGcZbXgxAo+sH7Dl6aV5rKVmPCTaZRx2F49rvYHN2NQLz4P
 U7GQ93v6yYDXUouxrFso0VXiGt1r+WkxsCCBGcmqmMUn4AH1ctE717Gdx7jtMB9KuqVO
 KLme5LhBkzAngXUwMPS7wcyRtDk8h74Nf2y7la2z1uWGz0P58RS7gc1mC6Q9mDQJdsDv
 BtYomjwJgoBV9RMrDmNgEntkR77cD0bB/nGVBFQHz3lXuVcsE5JP6rLdxpJ+pA87Xxkz
 s52A==
X-Forwarded-Encrypted: i=1;
 AL+hErGgoQZ0nTtd5CF0op0spOGemagxR75GC+r/B14QU/Ti//ANzHkmbtcCp+RfTC3Sd3focW5rgnpD@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9m6rhEVzmJz7ZS6fFz9Wm2JHelLA0DWlGiuj0BI/2QWoehRNWm
 441wsTa2EWk4Fs1KjlTQkzIW1aKBrTQPC3V02TfoDParX4DN1VLmFCeq
X-Gm-Gg: AYBFou0Niad9N1qz/6AUcyDm5fc7z5XZ2Ml7hJFaCzcST6Ox2hRTjYY+ey9FvM0LH58
 Ma1AMhnMoUTieYFfilTjr9kBrfyhEFVTkkxgkQVugM/FV+cODu/uyZY6usZ8sTcXA4AzAWJAKLP
 dVdkKpNQ2ruJ17yIZ99wio5Gv3NTr/93g95fFUXhzc4VryGlS/e5ooG25HphyNrC9ksGaaJfm6Y
 Jue5J1y/JaFeqSBYgMa1Why+X4HzPgYzsAFIbezccjC27M9YTONyalmNTi/asfgNR1fEjHS/ZKj
 vV7DR4N6xQv8IvmzANWw2EMOhm5DF6pWePUSx+HphqBlAMDLK0muQ7OdlvU5I28TTSjxxE1ETZg
 8e+2fn2Kl9fE9SRJgiPsUbf4cZNryW5puKzUvJlA5eCdm2uBpVVvXFongWu002y4lNFSGItot3g
 HSrFixGcVJbWQ6pgwmzCZlntJxZIFgefKpl478UUaJrvFxxKQ07KGDr+uimpWj7eo4z4WGC1e01
 X/bVMp/kYCXP+5PlnmYwKxPcFtfTX5qOkSbM4bznucmC02FpTEzZ4oZQlhkp8cZsjElxnzoqwzs
 dW4Hiya+wjvznfxfjW8fhYiENs3xoISkE2jVdc+kxd93sJGi0j2WgxoHH+FU/RKJYJQ=
X-Received: by 2002:a05:6a21:118e:b0:3eb:b103:6ec0 with SMTP id
 adf61e73a8af0-3f7a72ba2e9mr5274932637.14.1794665479089; 
 Sat, 14 Nov 2026 06:11:19 -0800 (PST)
Received: from [192.168.35.40] ([218.50.238.131])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc18b4e68sm2442814a12.25.2026.11.14.06.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 06:11:17 -0800 (PST)
Message-ID: <2d8dbfaf-46d3-4d05-b052-5e8a8670931e@gmail.com>
Date: Sat, 14 Nov 2026 23:11:05 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] devfreq: Use trace_call__##name() at guarded
 tracepoint call sites
Content-Language: ko
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>, Aaron Conole <aconole@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alexei Starovoitov
 <ast@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Chanwoo Choi <cw00.choi@samsung.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Danilo Krummrich <dakr@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eelco Chaudron
 <echaudro@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Ilya Maximets
 <i.maximets@ovn.org>, Ingo Molnar <mingo@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Oded Gabbay <ogabbay@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 tipc-discussion@lists.sourceforge.net,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 Xin Long <lucien.xin@gmail.com>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org, dev@openvswitch.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org
References: <20261027153658.703730257@kernel.org>
 <20261027154413.039021489@kernel.org>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20261027154413.039021489@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 19:10:55 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/2026 12:37 AM, Steven Rostedt wrote:
> From: Vineeth Pillai <vineeth@bitbyteword.org>
> 
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Original v2 series:
> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/
> 
> Parts of the original v2 series have already been merged in mainline.
> This patch is being reposted as a follow-up cleanup for the remaining
> unmerged pieces.
> 
> Link: https://patch.msgid.link/20260515135920.2238808-1-vineeth@bitbyteword.org
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 82dd9a43dc62..9f71d9dc4a70 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -370,7 +370,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  	 * change order of between devfreq device and passive devfreq device.
>  	 */
>  	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> -		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
> +		trace_call__devfreq_frequency(devfreq, new_freq, cur_freq);
>  
>  	freqs.new = new_freq;
>  	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);

Applied it.

Thanks,
Chanwoo Choi
