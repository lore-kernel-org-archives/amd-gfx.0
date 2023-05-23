Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000CCC77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 14:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F60910E0BA;
	Tue, 23 May 2023 14:02:49 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A2110E0BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 14:02:46 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6af7593ed5fso1094833a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684850564; x=1687442564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnVkTFNhh/4epOPAyS89EhWDABLaRCDNblah5EYE7V4=;
 b=NbuKUufbSf5ffEiWN66zk1hgl7ip59fF0nL2J0+2PRT0uG+0KrzLnYpgnUy6WK8QDK
 xRLfN4ajEerlad1KYPMKenHnVivgrzmIIIhv5BXVsPYvlF2s90d6c0/LIVv8EDaAD3N+
 6ZQYx1TWziMbyW19PEXNuJ37EgZWypm3vLFTIXARWkKKNuWLm0RFDP5Zx88iPhCv15UH
 qqdaPumm5lmqsH+N8oSUYZQmt+SNsMgnIaJGitlxEtv06Wv/9xZFGfgCarIaNUY/Zkl1
 wKMU3Vzf+l71G7HEcfr6XrlkPYxD+LOa1DFeXvj5N0nTSyEatnmWh+oxm94RjESGStIE
 CTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850564; x=1687442564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnVkTFNhh/4epOPAyS89EhWDABLaRCDNblah5EYE7V4=;
 b=JPw0cF+OpdB1NXMgtVd8hOOv8B5IAc39cNZrxWe7Wvj71FbZYb5S2biquBcc02IGVP
 0ozdpm9VP/CE2+Djxnh43YaMs4djua4WBEwpdAv3j9s0RmfinoR5ZgiWrjVa/zaP65/T
 36rqQpIltsHLULAoY+2ZUcItexn5QzowvhZvX4vrhYFr6tOjG681TzLsINHQuRcS0f5C
 4sXz2rzhnJPmXwu+hm3npNcMwjx7fSqiBCNClS0I2h9lsdEhUye/S+cSVMH3n7PDC03K
 3JbUmtA/J5xsYLJQ3uL6udigU5uDB5kbSXxM6BllF+jLe34yDHAyR4ezagq1hdRRn1ss
 5Feg==
X-Gm-Message-State: AC+VfDzeD9dWTCyVcRw6yL4TOSUj190BKLjGfqMDLcUuR6JCQGdajXqk
 TtUqXTgdyIn2xLFIHllwodHoPxUiBziIUdNNjqo=
X-Google-Smtp-Source: ACHHUZ4JjEpDGOK+rFBUUxfs8Yj5NZ99gphZlukK7yyMdYPJg9S/fAzUTsWxnlAdxNaPnkjj2aRHTapYf7uLQUIm2wY=
X-Received: by 2002:a05:6870:8545:b0:187:e288:9279 with SMTP id
 w5-20020a056870854500b00187e2889279mr6680056oaj.19.1684850563960; Tue, 23 May
 2023 07:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
 <ZGxfEklioAu6orvo@infradead.org>
In-Reply-To: <ZGxfEklioAu6orvo@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 May 2023 10:02:32 -0400
Message-ID: <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add the accelerator pcie class
To: Christoph Hellwig <hch@infradead.org>
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
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 23, 2023 at 5:25=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, May 23, 2023 at 12:02:32PM +0800, Shiwu Zhang wrote:
> > +     { PCI_DEVICE(0x1002, PCI_ANY_ID),
> > +       .class =3D PCI_CLASS_ACCELERATOR_PROCESSING << 8,
> > +       .class_mask =3D 0xffffff,
> > +       .driver_data =3D CHIP_IP_DISCOVERY },
>
> Probing for every single device of a given class for a single vendor
> to a driver is just fundamentaly wrong.  Please list the actual IDs
> that the driver can handle.

How so?  The driver handles all devices of that class.  We already do
that for PCI_CLASS_DISPLAY_VGA and PCI_CLASS_DISPLAY_OTHER.  Other
drivers do similar things.  The hda audio driver does the same thing
for PCI_CLASS_MULTIMEDIA_HD_AUDIO for example.

Alex
