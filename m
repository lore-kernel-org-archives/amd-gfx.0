Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57E3C02199
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Feb 2025 14:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7D310E15A;
	Sun,  9 Feb 2025 14:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJf5mUqx";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC8D10EB5D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 15:49:37 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so413570966b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2025 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738943376; x=1739548176; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBi4AotdPfbUdi7Kn9UmoCaZKTdKVqatWpE/DlNcYyg=;
 b=NJf5mUqxEhH5jTbT++CVQ/gXDS1E4s+lLhFkc+SpxxiaeiWCMaP8UxF+vfu7b4XE6Y
 3CQqoVcpXpgK96i0NgKD95JO61eDR+pPSSYC59z1TJVMlDVLkeKA84q8D56BRAsmPxwu
 sSR8QbBMMYSy7eL22dwy6/y91bF4Z/xD/QVtIo/KePbaOlN9j0I+fC+lgCPgGS+ZMPZE
 N9jdaWOQedjSS4+bNRZ9fHKsCAFSYJEX9m3KnUpPUqLL5wudQeef1ZZjiKAlR0SCxuyA
 BWKXgmmcWwpHY3XsZYEy0X5zJfLJPO42d+2fFi+29b+1LhkF3gwROk2eHwUqthDkuopm
 9UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943376; x=1739548176;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mBi4AotdPfbUdi7Kn9UmoCaZKTdKVqatWpE/DlNcYyg=;
 b=rJE8Fq6NULi4LGhfZ2WDGVmt96xzlCny/xScDULbHds0gvWUIx/wD5Mx56CFBze4Tw
 wd9s5hl4ApsFZJxDcoXwP8XnhtIDCd+4mmn2Zdcn+QUTyMcB6LAQ30MhRW9Ekdx0oLLc
 ncQXQ6Nt8nBoHGMdv8c7ChrXU+sQpuUG//4iCPVg3NyQPtWlxoaS0d33pc+eMUPo0qv1
 DIe4MhR7OBHYaEXvLy1r3+OssqNmPMGiGXMzaMqg2pWnnHmlz5P0J8zMqQ4e/BnWWYZD
 1VmyaH8xBYK7ARmIHgg9DIkQnJauY2lV2iQRqFsh6mPC8igp/yJ4oSffBkIAyyaBNjLH
 g1iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaHcxcqFqC4rWegoKDFZLH28IdLTK9BCLQyBQJ22sckBAR+33OTvgwemHPSX9etOHVWomZ4HwT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCRyYZlVQE7f322S7vpL/7YCZfiP6cXxknZjfQjiWQ0EGLxSZa
 ALVdbvQcvm99KxaqrdpPDq00/9dK4hYJcCIK9fIsS/R1cjuevwK4
X-Gm-Gg: ASbGncsjue+Q4/w74h1KdlndnU5RTo6F3Ttv+7VXQdpb8ksBLUV1GJKUkqDy0DM3icq
 qfBBP8QPOlahrvGwc4UYgNApl9/O+wa/nQo0ETO1IV34fqLIjUFFvfxO3NlYD+OmY+2/3sz9/aW
 QODS13FZX7bO+q0v1rRTv49ZKFMuFsF+rJFZkdiPczhe/NjFMa94ZtgftJ7iqwNUJyXy7z9rhEa
 r9h4GBR9otpnIjcGYZaGt4abhUDDz1mNfFHh/+pHZtw/N0F5hN6J5M/DUeWgQdjLWLdDISMvRl1
 x2HNROMoLJ4KH+iXtOFmqMXB5jcZLeUpPyqyLg1czFKwhjBAQXMBwyFCkpcx
X-Google-Smtp-Source: AGHT+IHa/FA0G3vLZldLIISvXwAelJNO+Ezes6js+jQX40q++wjFJWOfdGOqPrv96eEfk/zxh0cngA==
X-Received: by 2002:a17:907:1c9c:b0:aa6:88c6:9449 with SMTP id
 a640c23a62f3a-ab789ade75fmr391378066b.19.1738943375888; 
 Fri, 07 Feb 2025 07:49:35 -0800 (PST)
Received: from [192.168.0.94] (catv-80-99-56-108.catv.fixed.one.hu.
 [80.99.56.108]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7736464c8sm286819566b.166.2025.02.07.07.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:49:35 -0800 (PST)
Message-ID: <056dd07634c8610f99a8006d484c6ac0e6ee8faf.camel@gmail.com>
Subject: Re: Rework and fix queue reset for gfx7-gfx10
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@riseup.net>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Date: Fri, 07 Feb 2025 16:49:34 +0100
In-Reply-To: <a8219316-dc08-478f-905b-1e6eb356409f@riseup.net>
References: <20250204143113.6320-1-christian.koenig@amd.com>
 <a8219316-dc08-478f-905b-1e6eb356409f@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 09 Feb 2025 14:43:40 +0000
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

Hi Andr=C3=A9,

Sorry for the late reply - we've been discussing all of this on a
different, long email thread.

Alex & Christian - do you think it's OK to include Andr=C3=A9 on that
thread?

Andr=C3=A9 - in a nutshell, I was using a Mesa patch that intentionally
breaks NGG culling:
https://gitlab.freedesktop.org/Venemo/mesa/-/commit/83bb8d88248cdbe7a7df653=
2efba0e8f81c9654a
which shows that neither the enforce_isolation series, nor the VMID
reset series can actually recover from hangs.

Best regards,
Timur

On Wed, 2025-02-05 at 10:47 -0300, Andr=C3=A9 Almeida wrote:
> Hi Christian,
>=20
> Em 04/02/2025 11:31, Christian K=C3=B6nig escreveu:
> > Hi guys,
> >=20
> > I finally found time to work on queue reset a bit more and also
> > gave it
> > some more testing.
> >=20
>=20
> How are you testing this series?

