Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C7EC25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 13:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8548410E0D4;
	Tue,  4 Jun 2024 13:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nfDOUyXe";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7235010E0D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 13:04:54 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-70249faa853so1004239b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jun 2024 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717506294; x=1718111094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qNe7dxZaWs8J5l3i0Ec6J8pKP88QI1wimwyhmctMNg=;
 b=nfDOUyXek4oNTkp5BLweTyRAoJPe4ghsxIWOAx2HXSMbQyfFkWqacA3AulNttjwVyo
 O4t0EfwHwfcmUpVkeRceJk3uOQWYi86GTwVelV1TUlUxENhaPU8hZhrPaEHmfyPq1idn
 /kVC+9lluZuNSMNJfkoPfjUPiwBLy/9GlzMOtRb/9Bkai+qAQP4TfvLmzi2/Z+WKJ2lu
 TSskNSxc6SnYrGIYGBOmn7pqmiyaRhoIoq8sVL2x7Im4MFVs0a4xe5jdt71w6Cpmyif3
 3iTrdeF52qdeAV8EPwK5LvyxrOoVzUMTuV1nmLkx2gUEng7sivXqOghLOELvqqbY1Xsv
 e98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717506294; x=1718111094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qNe7dxZaWs8J5l3i0Ec6J8pKP88QI1wimwyhmctMNg=;
 b=bEM681iFB+Q7JVZbk3B7q50nl51Bv/qjJq6QvU8wD6T1hj+ZuKandzJaLXdR/gQr8K
 q8yaqgNnQcgmNAQ5ZbxqEMXgnNLOFrwnLEgcGCuvexqdqNgwnZSpkNY+CyKIrKoq9Unr
 NTAhON5ZxqmnHqYa9Yt9+VnQ3Yp0m6j4kIpwpskkK6Ct1dSZXGLltfnk1k3KAddmFzEl
 qewhesVPyP9rjAJynAcT/BguB91y8h1nR4FeyDAMDH7fwyyOXe+JN+yq6WOZ2PvD6q+4
 apVknt0xS1ExeqfuyLGYV0awvJ7IWJUh6KwN/CyaseYAdnBKsmL5zLzqXZjc3/imf6KA
 QIPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW01QnYnrIuhDCSdjGyevLAWcjXQ6KIOwhrdku95hL77MFT+Y3Q+jRNiGcvYFhvfASpJ8cfrDCEgQfAvrbs5/8pZJnIxGNL/FlApuYTjQ==
X-Gm-Message-State: AOJu0YyEdArFu97fS+JTQWRLMWtOcR5W2K9D9rmNKcmV4JDWCZNSkQ/R
 y5E5xMfuC5ElNaAt/mXxAGsKE6pNBvwiscEPrJDT8Zir2CIqYg9F+F8KSikL5aIDHzjr/kFmdj3
 JvJWFcS7GlRlbTUkX63ZOIS1SxjE=
X-Google-Smtp-Source: AGHT+IFAKNX+gaGlcqmbmuhuQFN5+M35ILszxeo5eqZek762Jbw+YsLKZnRirs1SiRvTGysKXlb1jBAvL5bRlw5yhRs=
X-Received: by 2002:a05:6a20:1584:b0:1af:baf9:feee with SMTP id
 adf61e73a8af0-1b26f117a55mr11347085637.26.1717506293541; Tue, 04 Jun 2024
 06:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240522062916.705147-1-li.ma@amd.com>
 <nycvar.YFH.7.76.2406040955400.16865@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2406040955400.16865@cbobk.fhfr.pm>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Jun 2024 09:04:41 -0400
Message-ID: <CADnq5_Pe=O4Wg2y3Kz8J7jJLrDaopTOnARQKz6k9Mw-1G-1KBA@mail.gmail.com>
Subject: Re: [PATCH 1/6] HID: amd_sfh: Increase sensor command timeout
To: Jiri Kosina <jkosina@suse.com>
Cc: Li Ma <li.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, 
 yifan1.zhang@amd.com, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
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

On Tue, Jun 4, 2024 at 8:57=E2=80=AFAM Jiri Kosina <jkosina@suse.com> wrote=
:
>
> On Wed, 22 May 2024, Li Ma wrote:
>
> > From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >
> > During the initialization sensors may take some time to respond. Hence,
> > increase the sensor command timeouts in order to obtain status response=
s
> > within a maximum timeout.
> > (Li: backport for s0ix issue, these patches have landed on 6.9)
> > Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> > Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> > Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> > Signed-off-by: Jiri Kosina <jkosina@suse.com>
> > (cherry picked from commit 333861f4cca6d2c959ca2876587c42767853dccc)
>
> All these patches seem to already have been merged, why am I receiving
> them again with some strange metadata?

They were sent to amd-gfx as well since they are required for full
functionality of the entire platform (including the iGPU).  Sorry for
the confusion.

Alex
