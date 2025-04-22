Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9327DC369D3
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 07:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D5A10E653;
	Wed, 23 Apr 2025 07:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j9oAGDrV";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33CC510E5D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 15:59:07 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso3360674f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745337546; x=1745942346; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hAheUb7/AxYlrzvi7p9cQwyJGov/uzXYHxHoxFstwc=;
 b=j9oAGDrVnis9UH4RSE59tCliQxQZAQLHihxP6AbKsTbDirb+/Jb1aaxcLqS1cplgTl
 BkCg+2Zpe3Dyf2GJA1P4BYjDXMFCA2idKdVju0HSZKwSUd+ugM8ERkjWDByOAaqHDsR8
 rsx9pLQKPpMwyOfLm+RsN6Kx3OzZukDIaTFNE8A0tz0/BhwFgMabGYlWF4CD2IEmJmS2
 t05ItE8dOWYf0Qchxx+U0f0l+z7grXvq89yNlcN2oeLJuib4cx3LfnOQncVvzZf1s6Bp
 nBiFUb8tj3GQPc7r8GgxbsjFM5I7ItfPvNDdAfiZFsc7eaxF6I5Qhw632eQLXaAmDQIF
 GjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745337546; x=1745942346;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1hAheUb7/AxYlrzvi7p9cQwyJGov/uzXYHxHoxFstwc=;
 b=eYtRNUz9SeFYAkHQ7FlCpgrKqYqIfputLztVNYTWT+zH+BJxFfRqf25T+9v6ecuugi
 jVlBPKuHk5QXr3RlzS9pvTFkV8oA7icnTKtko6wLK3InoaMeyA1ruPYQ0ynY98rAcN9C
 jr2aAlOCeCM0Hp4QQ8TingPnH9mI2+rvAFcba6tHLGiWInCFEvyNy1Rw/WELCrFGkYZN
 MLrQyKfHoWmpL6dKpqiXmwF+oY3xAQq8Dw8g2T9CoIus+L0y/H4MDSBO37QExtj6xfU7
 j7MT5oGIbO+51MrXsuemiEdmf3BqijeX5kws4VA8UO01TI50ADzB/xOeJ6Urr9oS7TE0
 nSJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM4KFE2zr9YS/rB6RC7akLz3pFRP1Wt5b8ejEBDo1PU8hTP0r8TJtjmcOeugtN6HeEIYyP7/Mh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzpv/L4RlIprgr4blY55wr0SdhciiBFTnY9Vy7kua0SeGAFQGSD
 +GssgmCGPlR8+RAvmE1iFU4EJaME23grIzzMQH4DoAxhA5imMZ1JHCVjrhIe7bU=
X-Gm-Gg: ASbGncvHvMAgX0TG5uCxBINTKwgfQP09SaNihQc83pXkyLeljS6B094Z4PGoVbNrP46
 XcimYD6Os6eQgaQFhgDEnnSQpQPN1FStmw5Uop1+9ZCvSU3fQNV2bItumWPvKCv6DT4+f9++lc8
 o32tsGiKnwQiHLn/gA/3JjG0wSvpZDQ5jp8neEs+f6Wh2wNM0u/MUjLgkDSBfoabzGjUpk0eZlz
 SqVomu1kK9EN+0Nig6BXQETmqocdRJDqCBpdsusKD2lQ6Xe4QZxsj9r32AcdTxaXyJAA8SOeC+W
 Pc/miqhySdpypaR6J2J9Ve8hmwickHKwjl6gUk5LTbIxTw==
X-Google-Smtp-Source: AGHT+IFeH0S2vE5n+XA/l4vfJhnhOuJ0R4qy6RCQGw7qpnpnlen7t2GaUFL3M60QTyETclUPXi4vdg==
X-Received: by 2002:a5d:6d87:0:b0:39c:1257:c96e with SMTP id
 ffacd0b85a97d-39efbb02224mr11882093f8f.58.1745337545702; 
 Tue, 22 Apr 2025 08:59:05 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5d74a1sm176570345e9.37.2025.04.22.08.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:59:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 16:59:04 +0100
Message-Id: <D9DAIUZXIWH3.1L7CV6GEX4C9M@linaro.org>
Cc: "Fugang Duan" <fugang.duan@cixtech.com>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "david.belanger@amd.com"
 <david.belanger@amd.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, "Peter Chen" <peter.chen@cixtech.com>,
 "cix-kernel-upstream" <cix-kernel-upstream@cixtech.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?q?Re:_=E5=9B=9E=E5=A4=8D:_[REGRESSION]_amdgpu:_async_system_error?=
 =?utf-8?q?_exception_from_hdp=5Fv5=5F0=5Fflush=5Fhdp()?=
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Alex Deucher" <alexdeucher@gmail.com>
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
 <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
 <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
In-Reply-To: <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
X-Mailman-Approved-At: Wed, 23 Apr 2025 07:38:20 +0000
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

On Tue Apr 22, 2025 at 2:00 PM BST, Alex Deucher wrote:
> On Mon, Apr 21, 2025 at 10:21=E2=80=AFPM Alexey Klimov <alexey.klimov@lin=
aro.org> wrote:
>>
>> On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
>> > On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixte=
ch.com> wrote:
>> >>
>> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=
=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 22:49
>> >> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org=
>
>> >> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.klimov=
@linaro.org> wrote:
>> >> >>
>> >> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
>> >> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro=
.org> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
>> >> >=E6=97=A5 2:28
>> >> >> >>#regzbot introduced: v6.12..v6.13
>> >> >> >>The only change related to hdp_v5_0_flush_hdp() was
>> >> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing =
HDP
>> >> >> >>
>> >> >> >>Reverting that commit ^^ did help and resolved that problem. Bef=
ore

[..]

>> > OK.  that patch won't change anything then.  Can you try this patch in=
stead?
>>
>> Config I am using is basically defconfig wrt memory parameters, yeah, i =
use 4k.
>>
>> So I tested that patch, thank you, and some other different configuratio=
ns --
>> nothing helped. Exactly the same behaviour with the same backtrace.
>
> Did you test the first (4k check) or the second (don't remap on ARM) patc=
h?

The second one. I think you mentioned that first one won't help for 4k page=
s.


>> So it seems that it is firmware problem after all?
>
> There is no GPU firmware involved in this operation.  It's just a
> posted write.  E.g., we write to a register to flush the HDP write
> queue and then read the register back to make sure the write posted.
> If the second patch didn't help, then perhaps there is some issue with
> MMIO access on your platform?

I didn't mean GPU firmware at all. I only had uefi/EL3 firmwares in mind.

Completely out of the blue, based on nothing, do you think that
adding delay/some mem barrier between write and read might help?
I wonder if host data path code should be executed during common desktop
usage as a common user then why it doesn't break later. But yeah, I also
think this is this motherboard problem. Thank you.

Thanks,
Alexey

