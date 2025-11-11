Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB77BCCFA1E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 10:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F17010E6E0;
	Wed, 12 Nov 2025 10:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="cq+Ia/is";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3EE10E5A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 14:30:38 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-37a5bc6b491so33800541fa.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1762871437; x=1763476237;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aB3Kna1Ydum3rSWq2Q4kNhk8LAGVHiOY3JIzqpUlVwM=;
 b=cq+Ia/isfSweLbL+EuP2lt1xt8MBJ1Gj1IsNedkiBvqixyd6P7fNI759FjVT/33H+X
 9yCvmb99MpBdFDmva8bGLW65Gxi+jCDllNWYPbUYAcWdIrxQH0mp6ANL5b49ZbID+fmv
 ZMcbkKGD6+0WoZQSHAjzhNyesmrtJaGKSA/ODLGqdqN0P655OIZRrtCQ67PQA1nF1VDs
 E/0+4X9BV6z4ofUgjE8TnUMpxHcqz/p9aQObUWgBQdZdWZVqDbLEYhwoBBHoc5Tb4e4H
 oSHtLQ2LGsmAvyLZtl6kRbzuqmMqkp3/xZq2pmzR4woSC1fN7QWGo3+FQiKheVvBAIb7
 jQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762871437; x=1763476237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aB3Kna1Ydum3rSWq2Q4kNhk8LAGVHiOY3JIzqpUlVwM=;
 b=OOqbYKcqISfk7GIIxPueq5/XE+7MO6jcbcJJ0lKnAQJSRHAEbGUcPYcvIpa1u4Eb9y
 hfee7d4w/OudCvsmdwBvZ9vWvlFnepd9uAFHBhX175RymS5Y3V0R2lR/YkGggRBuKmZb
 q7sXPkMIpllzJaCYXBjhbYTK414pw5d2vZ3/qRi9gZx2ZPjhAZ/yHjeMbqacE8Zg1HTy
 yIgpccehGEeFurXJhkkpzOSo0tfHCw8AKLZB+p+8ZLDz2+PmVZXgiaxSHNTsQNi8hYGi
 xO7D5ZWRCFavuo3qLm5Benj//09ZttenCqMoH/zmoYtj8De4OWCD3W6Xtkh8/LUM/zL8
 8uNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5GfKyE8CKGp1F443E6FrTkV4r3i0XTFuomt05LXo1V+rX/aHlFcp99UpMPbKaPOC5M+0mSAhe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqwKupuNdbXW63ysTCZiaTtjAkis089YmfZViCsYpApaYvbs/0
 J9KCHcTCXjxE8D26uqCFnKGuTp0Qc7+Z3DUckHBtsK6q0intKzMFPWgCLqP/GDLi0icVN9AaAxc
 wAIPCNf8piQTnkar8ANLUOYSMhdDgL0YgJeDGmd2fVw==
X-Gm-Gg: ASbGnctrVuQ/Ai7t1QCOzt1eOP5JYGWJICIF1KS8aHQSiSKBWx84oa/lDffFvXvlTcX
 NzOgRUwOAAuHr8hnaQRmskFUBMz4bQhCZzzIxQKuCwgPd/sLQEwYyEY+pS5THTypobVa2XpyH9T
 UHX851BpdvphRRJiXEywcGgX8cXMYMwbIdkOgjICrzIhcFCpxNWodDFeEPVdFjf1dK73Li29+RR
 f1ueBfkCHbu27sbXzmF4MEthJOA3RU6MbUeEdYvwZtieNu4JT1nKX5YuP7piD0v4D/TqA==
X-Google-Smtp-Source: AGHT+IHIkpA6rhiYIBJPGXbu43mtrXsVXRAjUn5Tnc/nVn4XCQWhRjYlEu/X5WxF0zlqRt3mYY1fmThRtTARr/9+XVU=
X-Received: by 2002:a05:6512:10d2:b0:594:2db8:312b with SMTP id
 2adb3069b0e04-5945f1465c4mr3726443e87.7.1762871436263; Tue, 11 Nov 2025
 06:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20251110184727.666591-1-andriy.shevchenko@linux.intel.com>
 <20251110184727.666591-13-andriy.shevchenko@linux.intel.com>
 <pvjnjwm25ogu7khrpg5ttxylwnxazwxxb4jpvxhw7ysvqzkkpa@ucekjrrppaqm>
In-Reply-To: <pvjnjwm25ogu7khrpg5ttxylwnxazwxxb4jpvxhw7ysvqzkkpa@ucekjrrppaqm>
From: Corey Minyard <corey@minyard.net>
Date: Tue, 11 Nov 2025 06:30:24 -0800
X-Gm-Features: AWmQ_bmtZ_NzCjBDc-E_88i-zoQ3qkiy8-YjkQobPCCDd_5SvJDnh5UOEsI6sqU
Message-ID: <CAB9gMfrr5ReWD6EzGLpwnubnkRJg-VX0vpnPn-kuXsaYGFEAMg@mail.gmail.com>
Subject: Re: [PATCH v1 12/23] ipmi: Switch to use %ptSp
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Matthew Brost <matthew.brost@intel.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Calvin Owens <calvin@wbinvd.org>, Sagi Maimon <maimon.sagi@gmail.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Karan Tilak Kumar <kartilak@cisco.com>,
 Casey Schaufler <casey@schaufler-ca.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, 
 Max Kellermann <max.kellermann@ionos.com>, Takashi Iwai <tiwai@suse.de>,
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev, 
 ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Gustavo Padovan <gustavo@padovan.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>, 
 Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Satish Kharat <satishkh@cisco.com>, 
 Sesidhar Baddela <sebaddel@cisco.com>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xiubo Li <xiubli@redhat.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: multipart/alternative; boundary="000000000000be4f5a0643527dff"
X-Mailman-Approved-At: Wed, 12 Nov 2025 10:07:05 +0000
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

--000000000000be4f5a0643527dff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No, it's not really important, and it's better to use a standardized
output.  Thanks for pointing this out, though.

-corey

On Tue, Nov 11, 2025 at 12:08=E2=80=AFAM Sergey Senozhatsky <
senozhatsky@chromium.org> wrote:

> On (25/11/10 19:40), Andy Shevchenko wrote:
> [..]
> > +     dev_dbg(smi_info->io.dev, "**%s: %ptSp\n", msg, &t);
>
> Strictly speaking, this is not exactly equivalent to %lld.%9.9ld
> or %lld.%6.6ld but I don't know if that's of any importance.
>
>

--000000000000be4f5a0643527dff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No, it&#39;s not really important, and it&#39;s better to =
use a standardized output.=C2=A0 Thanks for pointing this out, though.<div>=
<br></div><div>-corey</div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 11, 2025 at 12=
:08=E2=80=AFAM Sergey Senozhatsky &lt;<a href=3D"mailto:senozhatsky@chromiu=
m.org">senozhatsky@chromium.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On (25/11/10 19:40), Andy Shevchenko wrote=
:<br>
[..]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_dbg(smi_info-&gt;<a href=3D"http://io.dev" re=
l=3D"noreferrer" target=3D"_blank">io.dev</a>, &quot;**%s: %ptSp\n&quot;, m=
sg, &amp;t);<br>
<br>
Strictly speaking, this is not exactly equivalent to %lld.%9.9ld<br>
or %lld.%6.6ld but I don&#39;t know if that&#39;s of any importance.<br>
<br>
</blockquote></div>

--000000000000be4f5a0643527dff--
