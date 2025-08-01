Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278B1C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 22:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8615310E156;
	Fri,  1 Aug 2025 22:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sz7YQxVX";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8390110E156
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 22:02:42 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-433f1f9718dso207620b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754085761; x=1754690561; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U0qkj/YHNoQXGHEyfzhgA9Nfmdq6qoiBrSk4EXetAKc=;
 b=Sz7YQxVXv3HxgOeRFPhQe49ZzBtFnlcIiFNaoQ7XCHar9iMxofT076Qjp7Mf9kJEeM
 hXYzZOF6Yi36Z+X7o+0rLNKPnMLuKGdwt1QaXJBPIlwss4cM4OxxicXFI66PVFytzcsn
 UhCfoZOOrJyaGyzAtutZ6Ykbu8mz4Y3kUsgEmCWsy4HtXUIArO7Q7jAChQw48rNCJeCV
 nzgDi2L9SZw/0FngWdK7wwK6aD9FSEB68fWlFb9uDe3ATrW/nDQOCOdnvoDOZzFM6Nqh
 cX3itwGPYGYnY2sjrDIOwHlaLxO0nhS5jbOe7WjEvBqIHywRc/8XDgJr/jRdxGt1tzPq
 OSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754085761; x=1754690561;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U0qkj/YHNoQXGHEyfzhgA9Nfmdq6qoiBrSk4EXetAKc=;
 b=k6h9T5O5H2KomtsxvYZVOq9j5i/Z8BX2DEAWiXD6X+3zwbDQWH/eA8bAzEUT+OFbH3
 3Xdnofmh5C9hlnCw+Vv04azyMkpUDQPjEjXsUm7DoDfIu7hlzI0JbuP5+VWCQjy/BiDy
 3U1gCGO74Q0Q9QClwVonPw/+oi9AP+0nx8XHC7PHada/k8l64d1Xf8vyk3w0bc20JXY5
 sJ/s1CQexKEYFlX97aqolqLRkHUc9e6QlEMczkXlYgFkmOo44WsC/e5mGo3GiBMvxPbY
 4JZ25L7ro1QrWWP8Xao0apHfvsKu9HOem3Z0ESUHsTGbvZtGw3SUsVmfmH5062oP0vuB
 U0Kw==
X-Gm-Message-State: AOJu0YyWNdpSnxWIvNhBWmMFJdhBckIwENiwYeajxzvkFCBQFG+jLeHt
 4oMyP3F/GMdOGWtTCex7Clc/7fnEDaQlxslwqBS8TYE+kXgfLlZzgl4YQuw5Djaue+bSHrNgjXF
 syvHd80Pbz1dsX6eDqLr1Wzc31bwL8p1/Lw==
X-Gm-Gg: ASbGncs0DW2KepGGVgLbvXD3a/osJVFJNfeBX+559v8tw4hMCGW7CB4JfvMiT+V3Ci6
 n91ULwVYiKBV+fKxVhkNx6IrBvaQ4LXJZSlPa75FGG1AN4sh+d3YnhL8VlZyc3YmuXpnaryLiZ4
 t/YiplHwPH6MctRm1EAGFGMkRd5OPcMJhG3khwWt9/ODFb2b+A1NPXu4V4EfMfVS9sA6x++Ga5K
 xr4WzwvrgbdQj/EqIJ+QFtEzTic
X-Google-Smtp-Source: AGHT+IE+z7lGXxgol+TrxzcAqS6ruztwK5FHjwax/ketDSJfifVLU9A95L4hbWfnW8OOTf8qUzsurscZ0yb4vPXWiGQ=
X-Received: by 2002:a05:6808:4f6a:b0:42c:2c22:f360 with SMTP id
 5614622812f47-433f02fe0d5mr864097b6e.25.1754085761462; Fri, 01 Aug 2025
 15:02:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:505:8bc5:b0:1cf4:f4df:c905 with HTTP; Fri, 1 Aug 2025
 15:02:40 -0700 (PDT)
In-Reply-To: <382a6232-c500-4d5e-96d4-0444947130ea@gmail.com>
References: <20250723155813.9101-12-timur.kristof@gmail.com>
 <382a6232-c500-4d5e-96d4-0444947130ea@gmail.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Sat, 2 Aug 2025 00:02:40 +0200
X-Gm-Features: Ac12FXx61lkGQPbCXlVTc8whdfGjVyQO9DQTBfGfzyA8UDYllYe69ggUkKAe-Vo
Message-ID: <CAFF-SiX_FipFpaZyQaFEE5raFN2zz_yQPYUkBq2kRzLP1PHyZg@mail.gmail.com>
Subject: Re: [PATCH 11/20] drm/amd/display: Implement DCE analog link encoders
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000b7b67e063b54ea57"
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

--000000000000b7b67e063b54ea57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025. augusztus 1., p=C3=A9ntek d=C3=A1tummal Alexandre Demers <
alexandre.f.demers@gmail.com> ezt =C3=ADrta:
>> We support two kinds of analog connections:
>>
>> 1. VGA, which only supports analog signals:
>> For VGA, we need to create a link encoder that only works with the
>> DAC without perturbing any digital transmitter functionality.
>> This is achieved by the new dce110_analog_link_encoder_construct.
>>
>> 2. DVI-I, which allows both digital and analog signals:
>> The DC code base only allows 1 encoder per connector, and the
>> preferred engine type is still going to be digital. So, for DVI-I
>> to work, we need to make sure the pre-existing link encoder can
>> also work with analog signals.
>>
>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof at gmail.com>
>> ---
>> .../drm/amd/display/dc/dce/dce_link_encoder.c | 100 ++++++++++++++++++
>> .../drm/amd/display/dc/dce/dce_link_encoder.h | 21 ++--
>
> I have the same comment about the use of "dce110_" prefix under
general/global DCE code that I left on the previous patch.
>
> For consistency with the current code, I understand why this prefix is
used, but I'd gladly clean this up once the patches have landed in if there
is a common agreement.
>
> Alexandre

Hi Alexandre,

With regards to the coding style. I already replied to your other thread
about it, let's have that conversation there.

With regards to the link encoders specifically. Due to DVI-I, we need
dce110_link_encoder to handle analog signals in addition to digital, so the
question about this part is, is there any need to have a separate
dce110_analog_link_encoder? When I wrote the patch I felt yes, but now I
feel maybe we should just let dce110_link_encoder handle VGA as well.

What do you think about that?

Thanks,
Timur

--000000000000b7b67e063b54ea57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>2025. augusztus 1., p=C3=A9ntek d=C3=A1tummal Alexandre Demers &lt;=
<a href=3D"mailto:alexandre.f.demers@gmail.com">alexandre.f.demers@gmail.co=
m</a>&gt; ezt =C3=ADrta:<br>&gt;&gt; We support two kinds of analog connect=
ions:<br>&gt;&gt;<br>&gt;&gt; 1. VGA, which only supports analog signals:<b=
r>&gt;&gt; For VGA, we need to create a link encoder that only works with t=
he<br>&gt;&gt; DAC without perturbing any digital transmitter functionality=
.<br>&gt;&gt; This is achieved by the new dce110_analog_link_encoder_constr=
uct.<br>&gt;&gt;<br>&gt;&gt; 2. DVI-I, which allows both digital and analog=
 signals:<br>&gt;&gt; The DC code base only allows 1 encoder per connector,=
 and the<br>&gt;&gt; preferred engine type is still going to be digital. So=
, for DVI-I<br>&gt;&gt; to work, we need to make sure the pre-existing link=
 encoder can<br>&gt;&gt; also work with analog signals.<br>&gt;&gt;<br>&gt;=
&gt; Signed-off-by: Timur Krist=C3=B3f &lt;timur.kristof at <a href=3D"http=
://gmail.com">gmail.com</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt; .../drm/amd/dis=
play/dc/dce/dce_link_encoder.c | 100 ++++++++++++++++++<br>&gt;&gt; .../drm=
/amd/display/dc/dce/dce_link_encoder.h | 21 ++--<br>&gt;<br>&gt; I have the=
 same comment about the use of &quot;dce110_&quot; prefix under general/glo=
bal DCE code that I left on the previous patch.<br>&gt;<br>&gt; For consist=
ency with the current code, I understand why this prefix is used, but I&#39=
;d gladly clean this up once the patches have landed in if there is a commo=
n agreement.<br>&gt;<br>&gt; Alexandre<br><br>Hi Alexandre,<br><br>With reg=
ards to the coding style. I already replied to your other thread about it, =
let&#39;s have that conversation there.<br><br>With regards to the link enc=
oders specifically. Due to DVI-I, we need dce110_link_encoder to handle ana=
log signals in addition to digital, so the question about this part is, is =
there any need to have a separate dce110_analog_link_encoder? When I wrote =
the patch I felt yes, but now I feel maybe we should just let dce110_link_e=
ncoder handle VGA as well.<br><br>What do you think about that?<br><br>Than=
ks,<br>Timur<br><br><br><br>

--000000000000b7b67e063b54ea57--
