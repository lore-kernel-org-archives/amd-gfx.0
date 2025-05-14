Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73AAC3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 18:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D6D10E11F;
	Wed, 14 May 2025 18:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OT4KBBjK";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F0810E11F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 18:06:01 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2317f90a931so145765ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747245961; x=1747850761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pq5j22lbXyS51cYspoXmzIDOaI4qkYOIL9P4rrtgphI=;
 b=OT4KBBjKIYuq0i8Ao3yMrkdH95WJU2NUttNrQJypmKDH/0C+1oSTIO7iJmbi6oEysZ
 kdB8lvl39KjFC89S0Ya14pt3yUufAHbHypYtoi4G9choVjSVEtDNn5C5v/ff1GLM2ocx
 Bckf+YfyakCk9+0zU1pQP3nmj3wHRPN5qYWHvEMgnFBOKEsQlXAmmjPKHsu6vlxnM+An
 vLyvo1gbJMW2ZkDocfX00I14WYhyBDMXXB9ldgG13kRk9PZLhgYdguG1v9HFbyo8z+Na
 ncoM2ipAMT7P0gcH4PR+6drgDJ8ZLuUqoQ5PtyMvsJb1U5xgJ2/+F/xsKkcyCxhZTlB3
 Xxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747245961; x=1747850761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pq5j22lbXyS51cYspoXmzIDOaI4qkYOIL9P4rrtgphI=;
 b=pLWH7pjg9XrVPr6wVttGBzb8ApqkwoxAJyM1gPEUk4CRregXROLCXf4ymEgktwu/X9
 7dzGgcd2htZNgbzdI5J1XMLs1z4wrn7fH87YNvUVWLRJnp0P4SsWrw2SXIXYnNb6I2D7
 5vGwD5pOhR/xBZj5IZV+xs9BDiNteRXswzJnSc3t1mWetMXauG1+jgJ6UtdwiBWfrWAE
 zU/Pt9CWXoM6kL358LfIf6oZ7CKB3aMc7yfdG5NkyUwy2icMroExz3iZmNjbl0G/V1xn
 rDPfYjbMdO3cUbVz8aQQaFYRj6URnWsNai2bPPxZQts3MPdqrH8cdBfXySkAnJlHJ6xF
 aGng==
X-Gm-Message-State: AOJu0YzXWVid7oKVJKQ+FWe4FATf6SgKra3Dva1BpOCP9bUwV/Ng6OP8
 pOLNu/xLdnVlaLav8FwzK//AD00uNrWmvuCTZtjtchQeWF+b5SlfPMJuJymkXsQ1DGUH+82NMXo
 hfIEn7Mx50ftBX381XO9Ng4arZieq3Q==
X-Gm-Gg: ASbGncuTAKlisLiDuR6R/gMRuEWs5lCp/y5DaSL/LOe8QwqRwzTq/YMG1U6AH/XmAkS
 9p+ORDI241KzGEeOoAKpxsbGzWQAF0CD+0bxN2DeKxKYcSSpqvxp/hwQeAxyzBuaTcKVk20DMJ0
 K+JEbgzK++odXnm9DbNj2T2is26yfdDjCP
X-Google-Smtp-Source: AGHT+IHmEEcAjSshJ0t21HL8QECbKXW5XNAsPoDEceCs8pDNdTaajN+Kn8wV43DDPrTvbkDw/4RmDnqg1TBQz6A+h3s=
X-Received: by 2002:a17:903:1252:b0:22e:72fe:5f8c with SMTP id
 d9443c01a7336-231981453admr21006445ad.13.1747245961434; Wed, 14 May 2025
 11:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250514172251.726484-1-David.Wu3@amd.com>
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 May 2025 14:05:50 -0400
X-Gm-Features: AX0GCFtnt8wIbX1fT8hBFAEPrBr1I3YNlkzzkWBxEIzEZuNbAtVoUHMx31mrQU0
Message-ID: <CADnq5_PLdQ7YppO-FREhHHS0EHUe0-GtLKXcejr=BLs1x3Vv_g@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] drm/amdgpu: read back register after written
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Christian.Koenig@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
 ruijing.dong@amd.com
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

On Wed, May 14, 2025 at 1:33=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> Similar to the changes made for VCN v4.0.5, the addition of register
> read-back support in other VCN versions is intended to prevent potential
> race conditions, even though such issues have not been observed yet.
> This change ensures consistency across different VCN variants and helps
> avoid similar issues. The overhead introduced is negligible.
>

Just for some background this is standard PCI MMIO behavior.  If you
want to guarantee that the writes hit the hardware, you need to do a
read to post the writes.  You only need to do it for cases where you
care about the writes posting before the next operation.

Alex
