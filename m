Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB36EC0218B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 21:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3841010E1E1;
	Fri, 24 Jan 2025 21:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cB9avhJl";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A955610E1BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 21:40:49 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ef7733a1dcso571168a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737754849; x=1738359649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/g1lXgWFBKpO4nLAMCIxxyp5XD7kYIrX5tFTZkmtVD8=;
 b=cB9avhJlJ3CM3TY7LvGfCRJa4n1KpN+czUNyeS9XSJszJYyWMmvhkgsKtSobPtLhHA
 bThEZ39UR6DZdJY9EVmYifDkjrkO+RTeZ5b6SlisUjQdB1bXLkMi3pb2Ajlt17efLs0t
 Adzk1EYO1Mb4TOfAyRq7D0r7Z0N+qaqcdb0b6nFWr13iCmdIxoldC72xG9PORL7rHj/D
 zk2j6IVW8j5s8aPKpnihYN3ue3qnokCM0wegvnKMXQaPYocpVFTP7EH1nqBHfILQcTtP
 1ewPBXV4U9i2ojECivG8WN4ttTxmsK6MpfFbPuP/KGLeW1Zj8UnE94uiaWipJBSttybE
 1Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737754849; x=1738359649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/g1lXgWFBKpO4nLAMCIxxyp5XD7kYIrX5tFTZkmtVD8=;
 b=SkEzB1dG0ebHYl2Dl8IleFdfPeHkqz1EcSzErihGga3zicZFhM52oFcvFfbyhH02lN
 J/LzUMXtiohRximg/Kk4DtvPXXr/wnqBZEnHN6NBsGP6dMkkRm+XzyIS36MYIO4LCXDO
 WKUC8O3THKHzosp/+oWwkbeEU2+Dt0cRzc0BqMRtO2SmsnYqMdnPiOKFHE/XYiPV5xdH
 AcQ34a+9PfFbjtQIdvXzaC+JyIEj420WgZQNiAFjBoIlw1zV9vRvyrDAWjwFZhRbFWwQ
 H33LrxG8pYn5oQkbSCdWpbycPX8B8hNFGTIVPiTHchJidl1COR2hXbTe8RNjVAJPxUbm
 kLhg==
X-Gm-Message-State: AOJu0Yy4TX8YGKCwvwYIngpF+cQfF43t8A1w+vRnyKs88e9NzJ+9Q5BB
 P70QrcsfmpQiUCMSQvco6fKSV3LDyw51F7e4yjOOEMZCp/+Cu3biQBbmiCtzgrkj63hODUxTHlo
 18jVoa4cuNrBa8idXf78WZZ2l0ZoNMjC6
X-Gm-Gg: ASbGncvnF0GWijFLhmpI3N24SHDnLx8ISBNdWgBJES8Uzq7njt8ahm5CbtJmef0F8j5
 0itMukSdRr7eNjxjV1cLCCT8XNtCHCD/I0Wy1IgARCGVnGoORzjEcNkmSoTxdNQsPn2LIDAzc
X-Google-Smtp-Source: AGHT+IGK+pGBR7rUZGT/BySv959hx42ohkYv6gjDo5fLJTO1eH4b5qpXlGUsA6FIdiDSX19xNQPj5n7eJjpVeJRwMso=
X-Received: by 2002:a17:90b:4d0f:b0:2f4:447b:f095 with SMTP id
 98e67ed59e1d1-2f782d3813emr17002181a91.4.1737754849024; Fri, 24 Jan 2025
 13:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de> <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
 <20250115213511.2feaa331@zbook>
 <CADnq5_MbeTRb642qwb0Q7JbL=2UsnK6RnLm6NWTeVLZOEuyn4A@mail.gmail.com>
 <20250116172916.0dba9ff6@ryz.dorfdsl.de>
 <CADnq5_NU-stpay1uFHXD9fVemg4snyE-eZZ4rfyg2Mc3x2OLyg@mail.gmail.com>
 <20250116173734.256704ca@ryz.dorfdsl.de>
 <CADnq5_O_WcZJ7yoDKEJpktSqffbP8RENhChmkD8Es7NHRYhCAg@mail.gmail.com>
 <20250124110225.6a0a87ad@ryz.dorfdsl.de>
In-Reply-To: <20250124110225.6a0a87ad@ryz.dorfdsl.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Jan 2025 16:40:37 -0500
X-Gm-Features: AWEUYZm-12H1AFtbcGAj2O7gCRUzZ-87616j2YeRzKuFS2fjwsnk6wfS0PjZp2g
Message-ID: <CADnq5_PwhCK0DfUrEgmdpoFmcBcS-FobGf8p20fSDHOrPTFrNg@mail.gmail.com>
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
To: Marco Moock <mm@dorfdsl.de>
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

On Fri, Jan 24, 2025 at 9:17=E2=80=AFAM Marco Moock <mm@dorfdsl.de> wrote:
>
> Am 20.01.2025 um 11:35:07 Uhr schrieb Alex Deucher:
>
> > On Thu, Jan 16, 2025 at 11:57=E2=80=AFAM Marco Moock <mm@dorfdsl.de> wr=
ote:
> > >
> > > Am 16.01.2025 um 11:32:42 Uhr schrieb Alex Deucher:
> > >
> > > > I'd like to see the driver messages leading up to that.
> > >
> > > I've now attached the entire dmesg without the firewall stuff.
> >
> > Does the attached test patch help?
>
> I've now compiled a kernel with the patch.
> It doesn't change the freeze problem.

Thanks,

Does setting amdgpu.ppfeaturemask=3D0xfff73fff on the kernel command
line in grub help?

Alex

>
> As the file is too big for the list, I've uploaded it here.
> https://dorfdsl.de/dmesg-neu.txt
