Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F95F588C6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4314310E5BE;
	Mon, 20 Apr 2026 13:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Jibs7OLh";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB5610E3D2
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2026 13:14:16 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-651b0eb2564so2193169d50.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2026 06:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776604455; cv=none;
 d=google.com; s=arc-20240605;
 b=cl8T2wDBrao0XChL0f8EuuUQhAbyqnhwRdNN+/Hd3O5f1LX1ZCE6Q6DVA8dl0I3gTu
 3oGoNsdpM/JSyZ5Ht2O0EIxFXokKxmhhTAM70bevw6RW7r4TF6V3lgUM5mHDZs9YidIu
 EdY4XHfJVQFCT62z+m2rgyaeHWzSFdEwp9+I2UenJyL+Kal5nyUeHhcRyoXZSHZPrlU7
 tV6b8YG5AD9rMRuRY8PSWZwTIbX8WFGX36+YFpXcuM+OiiBs3AbxYAnwQh2h7sZTiisG
 UGLzSYuRt4OY1Ah1P2ps2AX6NQabV1AUUmJaqHDvR8lUh8lJtEb0/4hjr36RUkmNm+UK
 BM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
 fh=ZBXmyU2xEo1wJFaJB+Aye2lyItiPvz6ehHPc/PJAr9M=;
 b=Q71UQM3nYBZN48wqppASyHW/PLl+j94Qsy1F3cJErdrfkQwK70znaLD518V3GPzY26
 SGbNuwp1iuVHjgP41q8qjhYGt7L+OotNrTmRamYkogwgxsJcd8ZkJLq0qBvLfTs/SvwM
 E0D58XV4RaJqLl0g/qgIVOBqgzyZUNOA84abJTvY0g6pBDY0gSYlMeBHavZCv58j/Skh
 ZD7+ZEEVjkUVeaPBuJsGfAiniP504c3/LUTZVOpZFr9QwJjXUqkW21SSBny7bF8lUPxr
 5yM/2lpu6FKs1mKA0uMJjVz+CKWnBwBaP/bnRhT496RSh3/TI2CWWEPiTT/tcE00tO4N
 tOuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1776604455; x=1777209255;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
 b=Jibs7OLhFfebc5PhEudnPbNm04xNAqNr9P6GkMSa9H76ARlC7dVOSWEmVP5CnCT9kp
 EEzVxnXSqvSRLcADNbfWdOLBYymJLhhc4UIJYUTu8p4/gPcKEDLnZLFzPtdPPwY/+lMX
 XldLFiRcoe6B2X81h3SHFAnGwwFU2upd0v9Dk8vW1VreBe2zw5mzgA+/y8BwgmFsqTuM
 uOvAED39WhBjHDUpGAHlBHNI3XTvfe1N20wuzZ5sJR6Wq8nKx4+E8Ap2DaHOVp20DQpG
 nYwHAoTRaIItSA6GqHssMR9DV+CkJAqI8auSyK9fw/qesIzBF8fCa/ya+NEF5xtccISb
 OIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776604455; x=1777209255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
 b=FZMY6R+DVvS31hg++6pmKsRWDHksTxs5xsgOCTWFn89OJbiddo6UqCaqIDxv7r8TKb
 WY6UgfrzEr169HYR5YHWbZ3DzOJohGW7/lSFLuEJl1XNzt/Ml4jnmgiuqbxENknrkFWy
 YUjv5DlCj8IpKQvujVVNTCDGUMIsIVMZaiepOIEN6D/GkfVDsdu5H4ONxM/QeidJMVTW
 eFSjhn7qwFbDklIdfk4kYf4Tu9+Gz/Vq5FmTeciymm1fQC5CyIa7CF7WBP2iu4XGF7bs
 YVYxmzJiaNhKAfDBnCsYm/46jyZVq6quqbNVOvZlRxKgWL5LA5H1pXDhDIlLV9Fm58Lv
 fGbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GaD9zTdH27NyYyMlvtlpdkcaQJ7r3rF8sw2WcSv6EwClqDE6WSrqGpF6oI0asFK8Jj7Tmgtb/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxztS1P06xx6PH1XVybtNDYSuDzrZHpViO44lrwfEw4jlr4/lqz
 iOo1LPEeyV/UN9FjusvWD/FWC/HD0Jq5TGfOyQuq9ShmZAe376I2AbinjaKOlSJN0HbFUKr9Q4p
 4X5kTEiQ41pDzgFoYPdwsZYTKckM8PVASGqIIEYKxOg==
X-Gm-Gg: AeBDiev5lgvtgikU0d9TYm0+PCUCaHO7Etfb/WOfkuHPsomHuLHoAvUn66eCpli0JVK
 UrsI1TdqM4dGDjLLgfQNBGkfAsb4kTDKI2yi84zNEGMek1Xq6E3SjStITTkpP3Qoo8OivlTYKG4
 gZYYc3B8eASN1O4OqWXQy0G3kWpOxbZnCQFxM5wXqzKXafYOBLOs4hLBdTG5c4KUDNGwGw4xqMi
 oQHTxDZ6PAjBBQGM75lk0sIJhJPoIavgLRSU+w3I2Yth+lB3ZzYUkCKIwTQ4+8IDeKuAJtA6u1Q
 wSC59p18vOzAn28XNOtug2XgnYoR
X-Received: by 2002:a05:690e:4811:b0:651:bcc9:50cd with SMTP id
 956f58d0204a3-653107ccddamr6102177d50.5.1776604455299; Sun, 19 Apr 2026
 06:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
 <20260418190456.631df6f3@fedora>
In-Reply-To: <20260418190456.631df6f3@fedora>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Sun, 19 Apr 2026 09:14:04 -0400
X-Gm-Features: AQROBzCejbUFLEO14GEr24qqxXnlBQ97NPzS668jjkdcYvI-3kvv1xuemSCQk44
Message-ID: <CAO7JXPh+__EWsW8fsKi4T+w0jdPxZEfCLQno_ukJk2=d2s0WKA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] tracepoint: Avoid double static_branch
 evaluation at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 dev@openvswitch.org, Jiri Pirko <jiri@resnulli.us>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Koby Elbaz <koby.elbaz@intel.com>, dri-devel@lists.freedesktop.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>,
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
 Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Apr 2026 13:02:49 +0000
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

On Sat, Apr 18, 2026 at 7:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 23 Mar 2026 12:00:19 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> >   if (trace_foo_enabled() && cond)
> >       trace_call__foo(args);   /* calls __do_trace_foo() directly */
>
> Hi Vineeth,
>
> Could you rebase this series on top of 7.1-rc1 when it comes out?
> Several of these patches were accepted already. Obviously drop those.
> They were the patches that added the feature, and any where the
> maintainer acked the patch.
>
> Now that the feature has been accepted, if you post the patch series
> again after 7.1-rc1 with all the patches that haven't been accepted
> yet, then the maintainers can simply take them directly. As the feature
> is now accepted, there's no dependency on it, and they don't need to go
> through the tracing tree.
>
Sure, will do. Thanks for merging this feature.

Thanks,
Vineeth
