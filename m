Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C756CC5DF87
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 12:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB8010F010;
	Thu, 20 Aug 2026 12:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qxZoSBI5";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2622B10EDC4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 10:12:52 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so420856f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787134370; x=1787739170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lwgHvf3IynxhCrFNp6I8hyWkHBVRhkHbA3ZcfkLbFcg=;
 b=qxZoSBI5Bc0mghC7Dyshtl3oGnnRftJPhBgBzc6PiQCaOUAxUXb8lFFe6QT6hX4FSp
 +S00p9GmfdOB7fzBsKQVtEzXG1X2ZGq0H70/b9CKiWdHpE2sEtzwg+cye+OqpV72irft
 GEQc55FyMj/pAmQzJgdKUxp1efNnfKtZ3c8Io0X8u9vDRod8xR+vRnRQqG9j1ZCLUzga
 lcicOZsJi6Nxo+uHMDnLNRYMRFX2pWqPrVP62Asp8HnsblspeQsGgD026N9zd5PLf9ld
 O3C9IxuWvSnTpeG7HJdTai9cZgxUdROcSE+nBseLGEZrMdRTVlpN1PdnRWLk6luNKi9Z
 ctbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787134370; x=1787739170;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lwgHvf3IynxhCrFNp6I8hyWkHBVRhkHbA3ZcfkLbFcg=;
 b=dx3KycCDxtJB3zxY743i9eIHKOeXeUzKeQy818Gdd7l+zy1fwIQVtC72VMRuImwwrU
 gAYPipUaNk7yXe3urLk5H0zF7DMMr+hKPR5w9tIXgj2K7e+b0DQ/HyckPN0WFIENiIYt
 PrGK6zYb8xefCPnWyv8ZjJUDI1CZhXxOfydz/zZ3q6+tBwqjld8xT/BANdwfloww1bVo
 +LvIZbdjaJVCReCXfLO6Mg8UcAq+iuzG1GqawS2PT5mE4p0adGrpoNghmAcn8DcbXnLb
 177eTmI2mL48vAFASk+SNUEojOKBN6ATgTVV63IvIkv/CBot7PW7jp1Swgc2xZ/UgH77
 O1Cw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhTI4wF/a0rUo/yHuAjKYwB8xprqM+u3tiRjqvfhYyXnFVh3vfwaM/ap5JMwPvdlZyQm7FbtD9@lists.freedesktop.org
X-Gm-Message-State: AFuF++kTU06j+tKdMrsD5jOoy73pTduXCJNrRYA5YrGHZ5spWJLs0Oks
 kH6u9wpt2Cn6pQTAkLzp17No11YAcaaHly3gIEDUgp+90ZmnPXY4/Lxu
X-Gm-Gg: AR+sD10JDnrRZdQrtBzsodbhFWcJnTqcVXaBnpG/2UJQvVvycKJ6jvxL5OHzgKkThG6
 RZdGziep7Xl9ZsDPDiSrLIJKCr5d5jB3M47xeLhGE/j6D3yjcnhtHPFpAHvTh1y81NQkVh2BmR6
 5VHwjc62PzRNJj6VQMklMtyKFYIgmwtv4ji3b2Lrf885d7ZyvWa2ovhkxpiDVth9O7YexJabdYY
 il6z7OLsrgsHTQazPyyf8ZzzRzeWYOkzuUAWYGVV9db7O9xtO+uZHUqrajCkaV9PjnhGivg/0Iz
 FOnaG9WvFGLy00C5qV3XgGT6pAhuWQvRXERhinQJ+d+2memPTqcX8fkaOCV77N/ahGf6MkAPFbd
 zEd6CXabX2N8nti3gg7Kkac16hJutzI8Bkd52eWcrk2jhpxg/OmDWtV433WGSPlitqrJiUZcHS3
 ECJsMXD/aHIltAgmVBdfYMVQ669RIM4Nj8TWchKq9JFe4X2ajF+2H1hxxyPDMKJIoO+y6IQM5vY
 Hh/RvI1HKQ9m6+XM5QLIwzXvQ==
X-Received: by 2002:a05:6000:4b10:b0:47f:97f6:d39a with SMTP id
 ffacd0b85a97d-482b1fece9emr5929426f8f.17.1787134370291; 
 Wed, 19 Aug 2026 03:12:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33a8sm4965975f8f.28.2026.08.19.03.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 03:12:49 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:12:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Amin <amin.gattout@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
Message-ID: <20260819111248.29286a7c@pumpkin>
In-Reply-To: <CADnq5_NhH0WC_r7SVPyXOG4r36O++sUGis2Ej-A9J4MNJu7GoA@mail.gmail.com>
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
 <20260818152113.31b72e30@pumpkin>
 <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
 <CAHfa7xV-pPN0nAdd4q=bDYS59snoMf563OwS96_LLg4eb3yqQQ@mail.gmail.com>
 <CADnq5_NhH0WC_r7SVPyXOG4r36O++sUGis2Ej-A9J4MNJu7GoA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:33:59 +0000
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

On Tue, 18 Aug 2026 13:56:06 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Tue, Aug 18, 2026 at 1:51=E2=80=AFPM Amin <amin.gattout@gmail.com> wro=
te:
> >
> > You raise a fair point about the compile-time truncation check.
> > My reasoning follows the kernel's own deprecation guidance, which
> > explicitly lists strcpy() as deprecated and names strscpy() as the
> > safe replacement:
> >
> > https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy =
=20
>=20
> RIght.  My thinking was that strscpy() would be preferred to avoid
> static checkers from complaining about strcpy().

Personally I think the guidance (and checkpatch) should be changed.
It is pretty easy to change the header files to only allow safe
strcpy().
If nothing else that reduces pointless churn that just makes more
work for the maintainers.

There are plenty of strcpy() and strlcat() calls that are 'not obviously
correctly bounded' (and probably some strscpy() ones as well) which are
better targets for patches than the ones that are trivially valid.

David=20

>=20
> Alex
