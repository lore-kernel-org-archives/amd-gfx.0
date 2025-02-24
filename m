Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56361C021BB
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA56E10E3B9;
	Mon, 24 Feb 2025 13:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XZDl5PHB";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1323B10E3BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 13:53:57 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2fc0ab102e2so1162796a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 05:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740405236; x=1741010036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WngEBLIkrKbDBmo74gwMPwDVLq3l767HIGGCBJwirck=;
 b=XZDl5PHBmHmVsoiuSP39htel82uyKIuoK/+8cS6M/zsDZNKBsOqduhUGGe+fRFnzao
 lRcHaapU6/obx/dCFr3DCmVJwe3oRpBoNEF0x++gXxx5WZWD6kYBuZvSOdZtMB1ZRvro
 LDRMNwvv0wKGvZeGHOju3E9OEgjjIGt4BUPqeO+YQcSrLGrTNTFhllTS/ga1vR5OsawR
 U2hI3fp1R59APuWmxUH9XLasE1b+lF2qEoZT5Qd6D1SzcFGKfs0tchM70z7w9pdT6j9h
 iOnysawa3bjvm8l02NYF/Ybs3lu6BjqaXzNKLiUH/z9YoaQxcHeGAxnWVGEH2gzvFCZn
 eG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740405236; x=1741010036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WngEBLIkrKbDBmo74gwMPwDVLq3l767HIGGCBJwirck=;
 b=VAAGuppXUC6aT4an2GvxnUaDB1CGlA8lBp6TGPjXphMHkA8kaKjVyfnV4cnrYvp+HK
 uaL4gWlFHFE8n4W6rPTbkQDE9z/nd4C/1zxR5K2F9BJl3S9Q1TfBeWEq0WQJvs0xi/X3
 YBhsYsiE5Q7mC2xRm4OaUUFE1kkgwy/plRaiMSdmXrE212bbBgr03BdYe9tH4Skb9aZZ
 4/J5PZo0RChh+epaU7yP9SXAEIlBLm1nOm0gQriCEd07e0gpN9Yv/xR1lGkIeMY3065s
 FMPVVb5UcV+L1JyBtO1QUOZeFoeDtHiMY6KcCuhDQKjPJUe3K1Md6Gz1KxtbemqZ5PVy
 vqDg==
X-Gm-Message-State: AOJu0YwRLXUM/isqoO1gRiX2wiZzJ+ny6ZY2YwSGlzW7UbrZKm3pBnMg
 lJAnqynmJLFGydSwn1ZUrMAMoWQ0TLJiENxAgNFXRa2bUqXmCiPk2wfUaAeqTK6KJ20l6S7cXs4
 MEw3r9vcr53L3xcgWvvJVHkwNy7M=
X-Gm-Gg: ASbGncsv41lCnqziaARNKWoHr98G9h8KodScw+s9aDsxYgyL7QCmPvKWSnCQcTNLvKZ
 g33sqaIiSkXRw6k6/EKGQGAHMkRcchDnvpKsdbBvfvwN+fd80+QRcECbKD6m3SVZOYD3XKiqNOW
 3nAet2grk=
X-Google-Smtp-Source: AGHT+IFsbSGXrutGtwPBUxfBTgxn1l7buf9MLLeiSmdUb8BYDXz96a+LdWSbxjCPSrJR9DCH6O1LVwNEPRyaO4XyXSc=
X-Received: by 2002:a17:90b:38ca:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2fce769881emr9115513a91.1.1740405236518; Mon, 24 Feb 2025
 05:53:56 -0800 (PST)
MIME-Version: 1.0
References: <9b208693-0836-4818-b2f9-6d6eceaaa357@gmail.com>
In-Reply-To: <9b208693-0836-4818-b2f9-6d6eceaaa357@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Feb 2025 08:53:44 -0500
X-Gm-Features: AWEUYZnKdLIOHxxci0ox6E2o8nnoqozXp7glib5MnYpO3dgWCJKUfGw3UqTXFcI
Message-ID: <CADnq5_PcSsKia=_+WrHioxBpuanxPc-NLdnJFkuu5FXOJOtjZw@mail.gmail.com>
Subject: Re: [amdgpu] Kernel OOPS
To: Jaap Aart <jaap.aarts1@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Feb 24, 2025 at 8:44=E2=80=AFAM Jaap Aart <jaap.aarts1@gmail.com> w=
rote:
>
> Hello all!
>
> Before I spam this list with an unrelated bug report, would this be the
> best place to report linux amdgpu kernel bugs/page faults?
> I found this list on a very old reddit thread, don't want to end up
> mailing the wrong place.

This is the driver development mailing list.  Please file issues here:
https://gitlab.freedesktop.org/drm/amd/-/issues

Alex
