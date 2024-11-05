Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DC6D29FBB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 08:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A6B410E682;
	Wed,  6 Nov 2024 08:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="NVjPzRJ3";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B982D10E5CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 15:33:09 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 0B128339482
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 15:33:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1730820788; bh=psYStCboaD6sVOcvG7VhgIgJJzLSCZV/tC1mXCRY/Ak=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NVjPzRJ3fVQzH4hhhZLXZpZa3anx4UlHQkH8jVwCKMEXuqpXnt6YjyaJb0xB9DIXL
 HmeLUvJ8KoPlQsTJ8JmJqnkq7vQeG7qTP3WJOY8WxN+EwBuhiZsu53pmYX0GYeGU1B
 0Hlh8zq6aBxsO07ikWjbCgGJmscUxG0ICN7ZU7tDbe3XrwEgYAiASBGNT/U3TXeXN3
 /MbzMxkdZ/NKV8jggr48UX1/Xiafrqptpil14VgBNsSVJnO+azxpZ4HTRxR+SgNKm/
 ygGHLBjZi6YBAw1HkDKuvlSjNzttJ2L1vttxv9PD6GxIsm5ZtTskFhHukKOlKUBXJy
 IS3Fynu2FRb4g==
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-a9a628b68a7so864850566b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2024 07:33:08 -0800 (PST)
X-Gm-Message-State: AOJu0YwluiL2OsWB8eMlDMXldjBmUtNKUklk61g+CUf/EqI46beaepAi
 jr4z1IHtKIAFexOX/Jpo9UaCKaf4PYm6ybP9SbcpMBe6x5uzcAIKghPiRlXBQlJrMWJDNea5dPm
 +1Ac9kouW+Mrk9YcBybQ8Sqzdg4Q=
X-Google-Smtp-Source: AGHT+IH44y8UigUlHg/nJvDwJ1opIABD70aW4JXw4cM3T5wWWz3bxQrkmWKzSqt4lUM3HJBU8hgGhE48+FQTqZLWZwA=
X-Received: by 2002:a17:907:1c85:b0:a9a:1f38:e736 with SMTP id
 a640c23a62f3a-a9e654fb423mr1637908966b.31.1730820787592; Tue, 05 Nov 2024
 07:33:07 -0800 (PST)
MIME-Version: 1.0
References: <49676545.2155587.1730128258922.ref@mail.yahoo.com>
 <49676545.2155587.1730128258922@mail.yahoo.com>
 <1193254694.2164272.1730128713802@mail.yahoo.com>
 <CAFZQkGzsS=QVycX_vkOa4SSaZ_+VLa_MCm-gtbnXgXwfq0ruDw@mail.gmail.com>
 <587512969.4692493.1730819727679@mail.yahoo.com>
In-Reply-To: <587512969.4692493.1730819727679@mail.yahoo.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Tue, 5 Nov 2024 16:32:56 +0100
X-Gmail-Original-Message-ID: <CAFZQkGxsh6+_zCcED2e_O2qZCYcHiFRFTQ6xUj8_wJ4BhX05rA@mail.gmail.com>
Message-ID: <CAFZQkGxsh6+_zCcED2e_O2qZCYcHiFRFTQ6xUj8_wJ4BhX05rA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu add "pixel_encoding"
To: "Matias N. Goldberg" <dark_sylinc@yahoo.com.ar>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "harry.wentland@amd.com" <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 06 Nov 2024 08:24:50 +0000
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

Am Di., 5. Nov. 2024 um 16:16 Uhr schrieb Matias N. Goldberg
<dark_sylinc@yahoo.com.ar>:
>
> > That's not a problem, incompatible options can just be rejected in atom=
ic tests.
>
> I was thinking from a user perspective. It'd be easier for user-space con=
fig apps to present only the valid options, rather than offering all possib=
le combinations only to reject them after the user selected an invalid conf=
ig (or perform hundreds of atomic tests every time we need to show a config=
 dialog).
No, it's way easier to deal with 3 separate properties and have the
very simple logic (for which no atomic tests have to be made) in the
UI to prevent the user from setting obviously invalid combinations.
Having to split up an enum with tens or hundreds of values into
options the user can understand and that we can properly use is a lot
more effort.

> > opRGB is not supported by any screen I've ever looked at, so it doesn't=
 surprise me that you'd get glitches.
>
> I don't know if it was just a fallback, but my screen *does* work when us=
ing opRGB with rgb encoding (it glitches when using yuv encoding).
That's most likely not because of the value of "opRGB", but just what
it does with all unsupported colorspace values.
