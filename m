Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76595C61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 18:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F320510E03B;
	Thu, 23 Nov 2023 18:59:03 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2689710E03B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 18:59:03 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6c4eaa5202aso1132914b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700765942; x=1701370742; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bby3KLeMk5TDQVTOfioQ2jxl/n/q6ZM6pevoqUJQOKo=;
 b=h3Zp2nbm7VT7GBpgDEJJqIN+4DkJnLZZjHpVNYA2KErorwB6ItqO4cbwQ8hPdNCSOa
 eQfX5C1nEXlItlYi4vzLp2imjjoPxLJA7zQE7+GxYh2cn+C1A8JcEU9k6ZaxfA+aR/LT
 9sCGj7vXvPbTiRdVsClgF3eunLj1Dn4qe7NJAsGmp3WMsYLGVvJtR7a9wDt9XrBTW491
 EDWFM3QXcOwa8waRbrss+2SSG0dBvmYzMyT/1huWZBGSlykDpW17vIsv0KP+KR7ZYnfP
 EVWblzHCKUJ8Lz8rCoehmZyRWquUtaERS7L+ZvuADSud3gry/LMyErq3U8hwCuABZcNu
 x4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700765942; x=1701370742;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bby3KLeMk5TDQVTOfioQ2jxl/n/q6ZM6pevoqUJQOKo=;
 b=TpZeD3tzAMKJXh9X5nuW5WIhXFrKOcdShRbfEMjeXp/I52ns4qp0qtfClhtqs7fOQb
 eBV/QaUTvtY2+UwBT3fpgT8N3xOeSJLXN/55UfZa5/9i5g69I+jD8Ax1o5gNIaFCEq16
 //9AsQKkp7VWhSWBtGFku2syCE5+m+ePlYHfsvQM2RiufuZ4lYjrVfLevjvtsWZ1Trct
 cdB0Id3UFXFbb9SkoC87BngSwfyzN93T8lbpTkWSRGyrIO9CddsoAtpT52XTRFpuR41E
 rfKm243DWTvUNq6qPX/d1iz/3mhJCxr37nCbEDNWmtj+yB7o7qkQnhteOrHeqwhtJet5
 wPww==
X-Gm-Message-State: AOJu0YxkOTZqVeQbHMhORIGXNPJUjUDpbqL7F913GAG7Iq/3hadSUFuD
 4xxkkeILMogKe12xD+E2djtkEVEeARfg3jeT+ee/db8pgY1OgA==
X-Google-Smtp-Source: AGHT+IGgxXpoVGpzIOIl8PIY4xPATQ+o5lGSMn4oCWamMO7Sr4fDPh6xZIpVUdwkXh8pPTwekamIbIsvvsGBeclbVBs=
X-Received: by 2002:a05:6a21:1c8e:b0:188:444e:2b6c with SMTP id
 sf14-20020a056a211c8e00b00188444e2b6cmr451942pzb.49.1700765942178; Thu, 23
 Nov 2023 10:59:02 -0800 (PST)
MIME-Version: 1.0
From: Tom St Denis <tstdenis82@gmail.com>
Date: Thu, 23 Nov 2023 13:58:51 -0500
Message-ID: <CAAzXoRJNZv402557yQMq_5PSR+=nyzWNyCOqzHi=J8a6xSB=eg@mail.gmail.com>
Subject: Remote UMR branch pushed out
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000d469e0060ad66daa"
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

--000000000000d469e0060ad66daa
Content-Type: text/plain; charset="UTF-8"

Hello all,

I've pushed out the Remote UMR branch for people to take a look at before I
merge it into main in a couple of weeks.

https://gitlab.freedesktop.org/tomstdenis/umr/-/commit/712acea483cbbacb35cb1a431dea501f041065ff

This feature allows running the privileged side of umr elsewhere
(potentially on another host even) while preserving the common interface
people are used to.

Feel free to try it out.

Tom

--000000000000d469e0060ad66daa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all,<div><br></div><div>I&#39;ve pushed out the Remo=
te UMR branch for people to take a look at before I merge it into main in a=
 couple of weeks.</div><div><br></div><div><a href=3D"https://gitlab.freede=
sktop.org/tomstdenis/umr/-/commit/712acea483cbbacb35cb1a431dea501f041065ff"=
>https://gitlab.freedesktop.org/tomstdenis/umr/-/commit/712acea483cbbacb35c=
b1a431dea501f041065ff</a><br></div><div><br></div><div>This feature allows =
running the privileged side of umr elsewhere (potentially on another host e=
ven) while preserving=C2=A0the common interface people are used to.</div><d=
iv><br></div><div>Feel free to try it out.</div><div><br></div><div>Tom</di=
v></div>

--000000000000d469e0060ad66daa--
