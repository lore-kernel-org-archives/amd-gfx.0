Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B182D103E16F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 12:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153EF10E800;
	Wed, 18 Mar 2026 12:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Q+gK1WmE";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42A510E7C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:58:58 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-79a60975dc5so23527397b3.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 03:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773831537; cv=none;
 d=google.com; s=arc-20240605;
 b=i47XOIcRRDmX7LkbYNWKv+OxzYqIoqQO+KYBYwa2YM4hDK0sjRudcIUzod4mhyFe21
 8z6zxnlc9W/h/VOSHzy33IjMlXvufnbFlgg/4bs3/lHqG87hImhOw25oiqa6PPX7RIeU
 3nsWcyt79Ndfwg67qU6BwJTv0SRFpQ/B5nDH8jgERDRc1HeP/AkSNw0+3MwXnOa8nxRn
 62exFHXDm3OVW71XxSFwgqCQR9ADqEEmde6WPKaJJcirAFbuEWxia4UiG9oUChEbLvsF
 qTlvYSAXECDUTLyejSouJGfiXBsZ1HBGPN0lDKd+gwNpVmBbz7YLCPx9MhmrV/bTT6XO
 Iiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
 fh=6nzInEacPxZyBLsjY+24XgXxWsjRztL5XLBNxMl0TxU=;
 b=K1/DTJ3JwJQHKAKtg2GlhTua5sSSJI8NVgsf95t+TgRWJFKM+cfSAJgYTFRdI8ae5b
 X3lXeyaL7jI8OIi32CTBTJwVKpLVLOf2+NAsnpcOzRA8N9XTqZt2d/YDzFYxhwH/Uccu
 dtsmHkE9G81EQwHCeFCjJPY6QdsK3ESYq1JDSVpHQXK1vGjb8N5MQPostcwUfXvwOY7b
 uRdUzbBYNXyIs5bX0Lm8HqbZQvjRhDfdLxXhl77M6zfkPoqvtM0UNpr3YiEo3zYbb5Nm
 aPRVWCBGb2JVAQmuHQnu6jp6e10wIs56B28TZtyKAYYd7ZReBdYR72OShAJcbfTZ1cNX
 2t4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1773831537; x=1774436337;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
 b=Q+gK1WmEqDF4mF72MTu1sD58qmH2l7gDUyNHroy8YKaXRllnW6ZH/bWrqxiIBMOPPt
 mEZOH0d00AT9gulIa2j/pmFLCExv7q+cILjFyKgRPUkF/5sTxWXZmatpY4DHw5pz0aVh
 t25EbnIGVgVQNOljYhqrDNSf9JhZ1hZZPmhjNSHsk031DQq+p6++On3bwtm/Magsdl4n
 URnoHP85UA7vE0VCqJ/abuqek+rX3nyKC7C9GnP119YYtp0qda7MqOjKWoeDAMpzkZge
 zB77cRnOWGuxlqyDCpRQNQ4f0DpPGglirfTnVJJFGlacQtY0gchElop0p2ai3pg05lBQ
 AGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773831537; x=1774436337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
 b=J9gTnEFQstMvOIuK3iqLAiT93fsY6voVwuCH77pxIDCkcCiDWD3pzTQpONN0n/ctDB
 WjDFdtI9RQDwHSIOYS+YH/VU7DUjMkXq3P//IADLfYfNrH1AiVDW1QPcVg9eALQSvRcz
 nly8kJ4jBObUbX/FA07td8xdHBIgbbhutZHg6XhR71Yz7kXG2ch3fryevoi2Cx6pBtw4
 asqOwReNpDYmWCgfQFoKcj4xbNCcYubR0raiv0X+ghQ6pI7g+mA4j2o8Gby6aHs0XGqC
 YQJ4U2mlBm3L6ygplPd91eaQsm68NLsp0ZEnYINj15P90wCE5Vm6ex7eyop0E6vv+mYx
 Borg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl4eydsu4ge6zi6dMnfIEXnTOw6SHZ8riAEzqjW96HFNa+g2DQ6DCJkYYaKK7eyaYlEq29gJVQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywo/v3KoDVlhv++MBkeYpTX9QQadjQxRow9mMS71a7V5HqS2HSO
 FDGQmG1AyQRxYKjBCimHilxZON1sF+IMcNAuvizORV70GT7f91fSeTLeEDZwsQw9F2kktNxXFBz
 otnt5LBopnnWlwPGrDCUSPiOH3s6AiI+IBBZTUfO4UA==
X-Gm-Gg: ATEYQzx/lFUPnPneP+L7qNpTdQnwyIuMN5M1Y7iiN8ooOxB6Y3Xvi69TXBdiEqdJmrL
 aiyytIAKH/3sPt3yqiOLUR9uhUzlFfqptnRmA8lz0yE+QHj2w2Z1hm43jYI5enCOLpmMRZEsks5
 HXpzAkLDcp5hhiG4OSCYGYpP+A40J+7eWOyYLdX6PhDuBGOKO/li5JQCeLmaqkABatSM69WBPbc
 bXMxB2/SXr3rrUlWTm/+/GN2TOJcQv6slX/KhqxxsKstU1RZuTLvPAFP8BrBkimWCWchucuYlc9
 o/m5vr4=
X-Received: by 2002:a05:690c:c50e:b0:79a:3a33:933 with SMTP id
 00721157ae682-79a71ad413dmr29714557b3.31.1773831537485; Wed, 18 Mar 2026
 03:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com>
 <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com>
 <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com>
 <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
 <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
 <20260312130255.6476e560@gandalf.local.home>
 <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
 <20260317120049.6a60fa88@gandalf.local.home>
 <6ca9f884-9566-4a82-9995-4c802a0bf8a0@efficios.com>
In-Reply-To: <6ca9f884-9566-4a82-9995-4c802a0bf8a0@efficios.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 06:58:46 -0400
X-Gm-Features: AaiRm52iP799baA3h48fwfLjW02Pe87nEMlmDoXLIPKYRV2LFYQQkuww_KlSUU0
Message-ID: <CAO7JXPgbERfc_P+aPFB1+nR5ua3mZGbhdkbxCr0TFR4Cr6Khuw@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, 
 Jon Maloy <jmaloy@redhat.com>, Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-sctp@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, dev@openvswitch.org, 
 Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
 dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
 Eddie James <eajames@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 18 Mar 2026 12:46:48 +0000
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

On Tue, Mar 17, 2026 at 12:02=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-03-17 12:00, Steven Rostedt wrote:
> > On Fri, 13 Mar 2026 10:02:32 -0400
> > Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
> >
> >>>
> >>> Perhaps: call_trace_foo() ?
> >>>
> >> call_trace_foo has one collision with the tracepoint
> >> sched_update_nr_running and a function
> >> call_trace_sched_update_nr_running. I had considered this and later
> >> moved to trace_invoke_foo() because of the collision. But I can rename
> >> call_trace_sched_update_nr_running to something else if call_trace_foo
> >> is the general consensus.
> >
> > OK, then lets go with: trace_call__foo()
> >
> > The double underscore should prevent any name collisions.
> >
> > Does anyone have an objections?
> I'm OK with it.
>
Great thanks! I shall send a v2 with s/trace_invoke_foo/trace_call__foo/ so=
on.

Thanks,
Vineeth
