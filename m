Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8CCC54ED0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 14:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E048210E7FD;
	Fri, 23 May 2025 14:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RrXkIX1D";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0F410E7FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 14:39:18 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-231f39b1b7aso4749555ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748011158; x=1748615958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxAFN6x+HLph1fTPJr4Xi21PDtKZMrgIqKMz5KtUuKc=;
 b=RrXkIX1D5YBMEyX5FTFItyKbDY5EE7nK4W460jNJBZ4GTLxFTf7uAMjQ7kqNkfUu8d
 Hs6/yMklANNED2+4j87GJmw9KDZ+VkIfJ5BRA0tS3qdADiL2eCLEQ7OuVDS4k8keWhuo
 aYmqbLejzDZbJCnOIzePowp+HL+UuJAzZcGgeCocQjCdtgwK/jShc6sg7KmgDqKOKVzd
 mwL6wo9JFPLUlgVg+2ZgQULKWpTyoIMyDhBnrDJ3fYPnhglVSwlHiTXTMUrSDGJV9KsV
 +cLlyiVdHwtbt5hYhjlYV5zdWTzVNHq7NAb545SG1ikIU1DIbCecHZrrLdBOcSwxQ4SK
 LA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748011158; x=1748615958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxAFN6x+HLph1fTPJr4Xi21PDtKZMrgIqKMz5KtUuKc=;
 b=nWo+rio+EGy2pu5/lo+mydXceQu8vnxrfK4sRwOPKklRa0HXcCAk6WrHthAWbugcZb
 w6E+S/dVOGxqgkUikD6GWDkEUC5roRkRULryPIPqxuLMO9VWhzaaPtjs/pv1/UEPi9fS
 F1RHJDHSoeUj4v6Fu1VQwpJ19NSvQvIlBTH8ORefMCz2neDFVIBuzbL7CVOzKY4vToMo
 Eg+k6JM0v9hInmfmwpgzbRJfI1Bokxl4ywqNatGEJzjIF765sF90bmqCzJ274j6derPq
 sMlunopbY289WiZQJ5CQzH+WdTV6Q2RaCIVe0RaCk3qRTqWxIQtahsAPFRFQuMobtDtf
 WUpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQwBjEZOnoUZ4Ml4fZGwIA5biQ+PnZQSKttIiTUMiMbdizSCbZ8xfwyxkE+G7cGCvmAs9lZM3c@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGwxfXgHOpUKr0NFkWnZzNXJ5PaVjiVs+HdFtoCvZ+bcjRE9ZY
 jVXfD4iVewMVvevEXZTIHjVJtuHBf3uIvmDgPHcQy7OubudRQHcNec85XrMkpi5l2I2jUPmvM6X
 LRKyE0G6KUZK7TisWAiTJAGu/6SZbntM/IA==
X-Gm-Gg: ASbGncuEkutgzEcDoYi8c+Jrc49Gl3YV6Guz9dog6xDT+tt5XCcad94HPRbpBneayyV
 brO3sbhaq1hVW4SKkdPIWgEle5LJLPlPI407i/Xg1NNMw97IJWNnn8iBUr12tLbWbF/fqk7KSdg
 kepGKEzBoBjSYkNFuFZ7jJcQTOZ+msb+gpAw==
X-Google-Smtp-Source: AGHT+IF41Zc60gwKUVygWfbx1wldvd8FZVFjacjR4TxD0fSPFBXK1KQGRMf2PKvchI//m06GJ1JyXOyqWWiM6l320ZU=
X-Received: by 2002:a17:903:1aec:b0:216:30f9:93c5 with SMTP id
 d9443c01a7336-233f3667693mr15292835ad.6.1748011157553; Fri, 23 May 2025
 07:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <CADnq5_MYYR4c8_QW0jo=Gd7w3dnkCFXpgDZAxnSEuhmRpwqZyw@mail.gmail.com>
 <c859107d-c09c-404c-8021-75ad3df7d54f@amd.com>
 <CADnq5_OWWUjaKXnwugo1-mpYOp9pdpk0pjgD8_sb5QNJOCMZSA@mail.gmail.com>
 <5899d56f-44ee-4ed0-af91-55889296e249@amd.com>
 <CADnq5_NmSnoVKOyE9PJBaunLsc+eDQ4weU314yZn+p6QTgCx9Q@mail.gmail.com>
In-Reply-To: <CADnq5_NmSnoVKOyE9PJBaunLsc+eDQ4weU314yZn+p6QTgCx9Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 May 2025 10:39:04 -0400
X-Gm-Features: AX0GCFu-QcbZK0ZgYX52AkyjLnz48EM_b6PHfo9wH9Bnx0NCLuS23suNyfcTVMc
Message-ID: <CADnq5_Os3Brzd7HVM0yc3r0+UysmCL=h77dtG_jhqw28nbwd3A@mail.gmail.com>
Subject: Re: [PATCH V2 00/10] Reset improvements for GC10+
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, May 23, 2025 at 10:12=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Fri, May 23, 2025 at 10:03=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 5/23/25 15:58, Alex Deucher wrote:
> > > I think that's probably the best option.  I was thinking we could
> > > mirror the ring frames for each gang and after a reset, we submit the
> > > unprocessed frames again.  That way we can still do a ring test to
> > > make sure the ring is functional after the reset and then submit the
> > > unprocessed work.
> >
> > Keep in mind that we can't allocate any memory during submission or in =
a reset.
>
> Yeah, I was thinking we'd just have a static mirror allocated upfront.
>
> >
> > I think we should just tell the newly mapped kernel ring to start to fr=
om the known good RPTR and process to whatever the current WPTR is. Only af=
ter that an IB test should be inserted.
>
> I considered that, but we don't know if the reset worked or not
> without some sort of test.  I guess we could put an IB test at the
> end, but it may take a while if there is a lot of content to process.
> I guess that's not really fundamentally different from how vmid reset
> is supposed to work anyway.  We should be able to set the requested
> wptr/rptr in the MQD when we map the ring after the reset.

I think I've got something workable.  What's the best way to keep
track of the last known good RPTR?

Alex

>
> >
> > We could also modify the conditional code used for MCBP to skip process=
ing for a specific VMID by applying a mask instead of always checking for 0=
 and 1.
>
> How would that work?  I haven't paged that into my head in a while.
>
> Alex
>
> >
> > Christian.
