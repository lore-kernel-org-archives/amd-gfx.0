Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBD3C28B2F
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 16:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE0C10E05E;
	Sun,  9 Mar 2025 16:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VMDy5p1a";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21B310E05E
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 16:47:34 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so861834a91.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Mar 2025 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741538854; x=1742143654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0sCHblpocVvo8OZfMNYeGvMjld+YXIbdWNe7fULp3A=;
 b=VMDy5p1afAqf24cxoPMz6w+j/XQuufmwctlCBoO5gqmxjPS21XzFVq/6WsjoxmD2YG
 LqpMugqJtb700jiE0W3XJzlbi/bdRNGdn4hKA7AXQHdjolTeU/85rRfz5+ogk5GXuzrZ
 qvH38bnsMpacaQGicDM5d+8UFlOvV1BpJDatHvABDoAb3aYAFxt6xMeoOoMyALqNDhEM
 0p3ofJ0aKUWXjS6i/D52646i4nMCab3mPcturdfLeeTIbtL7hm7rEVsu8jWsv2TvuFT+
 rnwdzmUlkMeqqWlF8LP7xsESgx0i0ZAwrOe9vB0mjLYVeFOTH1EoSauq2CX/81mZR+2c
 +iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741538854; x=1742143654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0sCHblpocVvo8OZfMNYeGvMjld+YXIbdWNe7fULp3A=;
 b=fPaAV2gtxcMx3tlnlyMWouqvGGgyIN8Y3qwBgaujYaF+lFrEV6wBWx7Kr0UPwv1yig
 JuYSbCdV4O03wzq5RqZNmPnFMlm5OSgD5YJHZs6h8wAoI7cMz1XcZGeTUfO0yb7ulmh/
 IfsEMePXhZZkFZTFNoaKpjqUwmGyLPj0ifA+j5kgHWxMsu0qNn7eIaMNXl3dpWYg043r
 iNVjeKmAWZ8uAQ/AvmulAIlSTaWMeGXZh63Nnl1PWhLpFRmip30jZUoOUdlBlNcsczzU
 4yoGyW9oeOH/tje5iIj0kgnE4Up0clI/8bFRnWtW7VUOBKezxO4eMy2Ro8M8P+aSc5V7
 WkRg==
X-Gm-Message-State: AOJu0YzAJNXygE7f73TYJP8mwROzpEUmeOH28fA18C4qpB6rluALe6Tk
 kmDMse2FmzM4cIKNnDE3BCe+uGqTWzw0mVWEeGljGty2vR+R2mX0soFmfTKYE5z4Ap1kzL9g98o
 p8plNrAFFr/yvsUkAS6TGcRsllXE=
X-Gm-Gg: ASbGncuReJfsjByP97jFjy3ejPGvA8kQuuNTXrdl4UuZUPG+dnycaRHI23oyYO2eqKM
 88pkHlwsyiE8TXnFjc5Z3yLoHasmSrJE2RikQAgEU7QxPdSzEpqXxBXsRqA8lQprrFquCjRzfYw
 SD1v9foSFK8yO1YGxKBESvhXKQ5Q==
X-Google-Smtp-Source: AGHT+IFcrKD886nAD6O40EBQtyFf4IvRQ9ZmwWzv1t39iY2ARQVpgf/VVQPM0J3TAvU+dNkwLg8I1ffhNRfjpdoKSq0=
X-Received: by 2002:a17:902:cec5:b0:215:435d:b41a with SMTP id
 d9443c01a7336-22541ea9eb1mr35267485ad.1.1741538854211; Sun, 09 Mar 2025
 09:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPEhTTEfGK031+RiifE2RYMphms4dNMiXEJ49KkL3azq10UvDw@mail.gmail.com>
In-Reply-To: <CAPEhTTEfGK031+RiifE2RYMphms4dNMiXEJ49KkL3azq10UvDw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 9 Mar 2025 12:47:22 -0400
X-Gm-Features: AQ5f1Jr1GvF-FjdCRy6QCxp01JraQ1eeLyBOygmrfIXrBtzCmCeoC6b3bjcpWh0
Message-ID: <CADnq5_P35qyN1Po4Ofaop3K6rGxP71evXiPBDPaRbKjGQSg6ag@mail.gmail.com>
Subject: Re: SI DMA: clarification on naming convention
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
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

On Sat, Mar 8, 2025 at 3:39=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Hi,
>
> While working on cleaning up sid.h, si_enums.h and some other SI
> related files, I've been scratching my head about why SI DMA files and
> variables were named "DMA" compared to CIK and over where "SDMA" is
> used.
>
> While I understand that a new system DMA was introduced with CIK,
> isn't SI DMA also a "system DMA"? Could we use the same naming
> convention and talk about sDMA, name defines values, shifts and masks?
> Could si_dma.c/.h be renamed to si_sdma.c/.h? Was the naming
> difference introduced to CIK so different that the naming covention
> needed to be modified?

The SDMA IP was first added on CIK.  SI used the older paging DMA IP
that first appeared on r6xx parts.  While they are conceptually
similar (general purpose DMA copy/fill engines), the underlying
hardware and firmware was much different.  I'm not sure what the
advantage would be to renaming it at this point other than code churn.

Alex
