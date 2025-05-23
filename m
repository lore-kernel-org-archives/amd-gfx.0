Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E2CC54ED0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 14:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9511210E80A;
	Fri, 23 May 2025 14:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hmY8w17i";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD95F10E7FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 14:13:07 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-231ba912ba1so9608895ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748009587; x=1748614387; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhJUQaEyXvf9KZ9DoTPWZeu/H0IQtf1hRM7X1G9puKs=;
 b=hmY8w17ig2hWeXsIUmIkJ5Vp/mKIY3WCdateDMLn7NfrlpAl9BN+4ZSVDkZjDsZBa3
 CS0IoPxAMnpRpS8zkaUQd7xiP4iS8rCELccvu9U8H+WP3F1oAlsKjyUMjkKfIjs2Aj6v
 vvSpJni5FC2J2j4b/PsUQ04B9lirPbYC2Ajy29KnErE2ZFPF7wa8rJKnToXSBuemoFHS
 STWqkrW/h9qkjRHhNC+lICQ4w5SMyp7GT3yXXRMjaEA1WE2KUSopT/amwc16wdf6iZU6
 3WYPVBI2H8caVK6o59k9PXd6U4l5B1/+gvRoMGhmLnk50XvMXKtokMCA6nps0TqMaPM0
 YbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748009587; x=1748614387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhJUQaEyXvf9KZ9DoTPWZeu/H0IQtf1hRM7X1G9puKs=;
 b=f6mqlaZ/NAA4hNBpKYa0zFhpfdtUzNriDQmAAoY/i5afEZgJ5+RL2g1crmM5h7dz21
 S+y8bK0kCQ70KzwKXy6pPeSYcrGVxCFmo0x6Iw9J8omgqGrDAGjoXMAPPFD7xqMxZd7k
 yJkteKY5haa8HIeUH2JPQ+pLQThiF/X4OW6nSvTynv5kUiA3sKgH57TsVVaAmTVBgQVW
 c2wWTfbO7zEnxSU5xPTq6M7AMpUi5BYHSuofV4Gvr8Edn9r7MRHXpG2O6VT8HEglJ4Q0
 y1XfFPQKeyO6D0CUQqNn5hKv5eD6oK6IA6whaLXRrFFafDOssRwkK1AnBrUAzLgaeHRz
 g3fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLqhfxtIi9d1faQZwbRHPRuHHFjq7GRJcluEQr/kvwLitImO6m7COJWC9l69aypSSNxOzuu2Wx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzbPvIjytcMFezeKvV7ALlTRN1zCNVDq/UP0KoK11UE1SUDBJP
 mnmOYw/ND+wc3GlDsQw+tYa+B8FmoOz5SnoPc2nJqZT8TW1H911QFyd/vbF7byizqKUq3I8j0iY
 0MjC4Y2Ppq3d8HIGblDppXCCLny1HwRHqTQ==
X-Gm-Gg: ASbGncu/vvNGxUqjZtWbt7gLPMOg8eODcqTSR1WAPp0kf7QmEjsZbw4aAOEWCNq8hDB
 9m0+aQQtdx67edZIho1iQU80sWUgLDD5jyEqkvVxD8yktH/Ku72OHVGbtVcdF0SRrOOALSshAJu
 tzrAVUekfie+4C1tXwp1UiRXGivtNkiTU/fA==
X-Google-Smtp-Source: AGHT+IGvLmpfmYH8vUf3UWUJL5mwGUCpILKblQOenr9b6AWKzX32x6Bj4RMgvgEB/keWvXSJnmCf/LdhqqqUr7q7nLc=
X-Received: by 2002:a17:902:e746:b0:22f:b902:fa87 with SMTP id
 d9443c01a7336-233f36ebf69mr17110735ad.10.1748009587092; Fri, 23 May 2025
 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <CADnq5_MYYR4c8_QW0jo=Gd7w3dnkCFXpgDZAxnSEuhmRpwqZyw@mail.gmail.com>
 <c859107d-c09c-404c-8021-75ad3df7d54f@amd.com>
 <CADnq5_OWWUjaKXnwugo1-mpYOp9pdpk0pjgD8_sb5QNJOCMZSA@mail.gmail.com>
 <5899d56f-44ee-4ed0-af91-55889296e249@amd.com>
In-Reply-To: <5899d56f-44ee-4ed0-af91-55889296e249@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 May 2025 10:12:55 -0400
X-Gm-Features: AX0GCFsAq1R2bfVC9pikgkGZZiQ4kagtIpvjanUUGRtPCKkf2p5hb4OxyYk4r10
Message-ID: <CADnq5_NmSnoVKOyE9PJBaunLsc+eDQ4weU314yZn+p6QTgCx9Q@mail.gmail.com>
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

On Fri, May 23, 2025 at 10:03=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/23/25 15:58, Alex Deucher wrote:
> > I think that's probably the best option.  I was thinking we could
> > mirror the ring frames for each gang and after a reset, we submit the
> > unprocessed frames again.  That way we can still do a ring test to
> > make sure the ring is functional after the reset and then submit the
> > unprocessed work.
>
> Keep in mind that we can't allocate any memory during submission or in a =
reset.

Yeah, I was thinking we'd just have a static mirror allocated upfront.

>
> I think we should just tell the newly mapped kernel ring to start to from=
 the known good RPTR and process to whatever the current WPTR is. Only afte=
r that an IB test should be inserted.

I considered that, but we don't know if the reset worked or not
without some sort of test.  I guess we could put an IB test at the
end, but it may take a while if there is a lot of content to process.
I guess that's not really fundamentally different from how vmid reset
is supposed to work anyway.  We should be able to set the requested
wptr/rptr in the MQD when we map the ring after the reset.

>
> We could also modify the conditional code used for MCBP to skip processin=
g for a specific VMID by applying a mask instead of always checking for 0 a=
nd 1.

How would that work?  I haven't paged that into my head in a while.

Alex

>
> Christian.
