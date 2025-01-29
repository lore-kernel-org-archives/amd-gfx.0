Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF70CC0218F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 18:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62BBF10E0DF;
	Wed, 29 Jan 2025 18:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YVmoIaoC";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0132010E0DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 18:36:52 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f440e152fdso1645146a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 10:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738175812; x=1738780612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNpMOryMh75+DMbC39vcn+v1/+DAPdh2XM9NDgrFUU8=;
 b=YVmoIaoCZLY4FwTXAJOkohgrGTXkoW0kao45QzyjLTMcRHy3Qh3BkzcxaRmI28NVE7
 6tvlE4S4kFtNBwvgHa/7QkVe6FjgSD9Z4WO77oQeEsB7t35vM5oOPMcdQTrTHO4iweNb
 b3W46Ty74OLRGS5yJ5ar6PqO0hF9n5NCY5dcW3GCAnrv27Ddvv7OY1G5esDxPS5lyF+m
 SlAAH46wjkgHdJC2vL/IaaN1llGgHYOdMmNn1GVDuacZRZK4c//lqTUlQ+/bAnWUJWHd
 GyXkcXphUdBzFZr5M4EyiHXBwvJHLf5YA2BNaVj0VumX7XdTw4EIL4oVaXmBVszCR3zy
 AiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738175812; x=1738780612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNpMOryMh75+DMbC39vcn+v1/+DAPdh2XM9NDgrFUU8=;
 b=AI7IpOFtGERmD4BmKn0SMnUcivQz3LLyHNawNLeouhoDH5WOUCDdUIy6XjNt+42lNj
 3BDDjv7OVqbkfa4dsAHKpd0Wne13mxuXORjxpsPuKd3pndEYOU5xtiHZiS7vEcffnaqC
 izB8qxYMtGQq3QAXvmi1YkLfmXAuckZ5bSyVZz/AZfU+Y1m9Qk+svjyNnfhyxZW7Yh04
 9GY6L6qe67edNyUaDvV5EeOVfZlY92pFOG09U5Zk9OHx8VJZ5xMWOsDEWbs6R20JBpll
 bT/jgixuGeRp/l+iiykOUOzMOYiq1dNmbv//JVUpmujMOxI1Cxz7s2V6gqkIW+GZCKmw
 3HgQ==
X-Gm-Message-State: AOJu0YyQY3j5fe3yz/VnCy+MkNMBr6AoQzNa+hRCKaiOlp5o8ve+DFqM
 BEkFdcGdndJBnXwPlIa8LXiPACmdGCW6vWFkiGkFnR1CbjBx1wRsqqjF+j3/CND60h8SAqBIaz1
 ReDxlW67zTPbSXFtHxTNa6YgQdzUYlA==
X-Gm-Gg: ASbGnctV20bXT6iwEQ9G+wuTc6To7F0yeYTlsU8Siog9Ad5+B0SU2FrAIQzg6jHYf3u
 NlSJwF9yeyzZPkaxUyZRFJDBsMQP5Br2v7Dv/Fwo6BayddiOy3bIll+rN3TcaifRPnpmtasUX
X-Google-Smtp-Source: AGHT+IG2VlpxuW0jct5dCCPZ98ELr2gVK8XMDEtDKLSSi/yDKSxNS2K1dRxIp9SJL4E1eOiW9CKZbBb8ocPsQOw3YqQ=
X-Received: by 2002:a17:90b:2dca:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2f83aba7fd1mr2385392a91.1.1738175812342; Wed, 29 Jan 2025
 10:36:52 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A42f1uH_1esfXn-BsPEzbMeuev4TAFfG9DYDc01xS=g8Q@mail.gmail.com>
 <CAAxE2A60-sJkNLrh0bVVpi35h1PZREbeb+9cpZBjmcBgfW2wrw@mail.gmail.com>
 <CAAxE2A6oBwCvVaPe_oxMRmFFdvZkUM-oHHJhc+tConM=5niqZg@mail.gmail.com>
In-Reply-To: <CAAxE2A6oBwCvVaPe_oxMRmFFdvZkUM-oHHJhc+tConM=5niqZg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jan 2025 13:36:39 -0500
X-Gm-Features: AWEUYZldyBVrg9LaCdPxXAfdeMchDB_79ArK_aOV1L7CHHRy9PakXIKQ5jHq-KE
Message-ID: <CADnq5_P_5vcxoxnDLDfthS7wgewXuNMhbfwXCvcV46-z8a_y-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add a BO metadata flag to disable write
 compression for Vulkan
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jan 29, 2025 at 1:32=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> Ping. This is urgent.
>
> Marek
>
> On Mon, Jan 27, 2025 at 10:52=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gm=
ail.com> wrote:
>>
>> Updated patch attached.
>>
>> Vulkan can't support DCC and Z/S compression on GFX12 without this.
>>
>> Marek
>>
>> On Fri, Jan 24, 2025 at 10:15=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@g=
mail.com> wrote:
>>>
>>> Required by Vulkan because it can allocate whole VRAM as 1 BO and parts
>>> of it bypass compression and read raw data.
>>>
>>> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
