Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC23606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rW1s1wJq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E994C10E5CA;
	Thu, 19 Nov 2026 20:10:14 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60D110E5CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 20:10:08 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-8437d47592bso17938a34.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 12:10:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795119008; cv=none;
 d=google.com; s=arc-20260327;
 b=Y3uBgaIytHFZMybb2yrCPmYGbBeDrPsBQ0RYXD9KO7QWhxykZg7Yy6oF9ez5SeQvR0
 9CENIKt9WkcnRHB8cgAC1vehFgtKHC6AYMCfu4Y5ysvsDcdJ0Lrw694+41IGcJzFOuBY
 wpoCLP+Od6j1ZWKc+KP1heWn1LR+ODu1LfFb7jUXl8jYY0I4k1UW0DqjqE7CJ2MnTvhN
 ewj1HNJ02sNczE+mqPUsOlCzjn7y6LY8VMyt4xOYPhS/lf36s/ShH3FLMD1VGtKNTrqW
 kNFRcDj3Rh9QobRBpyiEvjhXVJse8la5qaJAtWoyif46TlPHrQCXSrBwj6VTORMXfwYf
 i+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QF7Ym8HltwH/EryL+lHedJXLoRmFZy+TQyk7QyouYW0=;
 fh=PTCjY1/g7LZXEEGRSWtnDXRJF/kBo5AWtSejAX9bAJM=;
 b=V4YiYYhg+F4vevcsK3WSqff/BjFMbyP/6gJUgjW7QkmGTfAwyhteDOQEJdOyh7LD4S
 960QL0QrPHIE8TMGkSu2DOyx/H5xkswYI3cSSmKXexAGS31si/5QhszakYS5DyHkPX61
 PHOtJN367ueSFbD0DbUNmln5tgPZDE0WlTIqr4Pa0vJfhVY4DVNYXPeLSVjADzSKIfR0
 Gle5f0KaR47Fd235uVbyCOv9RaCykF7Pda3Vhz++WAuJ4XJ2GOa2VB2loFheRWbVNlt9
 1ybANYqPZ7UTwBcKeq+ZrCOZmsQwjCMV2XKnGpiGaqrybjv4qskGaFG0lMH1EcZztCsN
 HsJA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795119008; x=1795723808; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QF7Ym8HltwH/EryL+lHedJXLoRmFZy+TQyk7QyouYW0=;
 b=rW1s1wJqovrz40jps/3lqPhRs7xDmXkhhT8GIFu5UrEooqlv1HzNz3Jtaqx1SHBCXE
 9aqzOlYY1nbCCS/h6F/lBag0krhySUHXysE+LoqxlY8oJiZ21nOs/gdZ79EtzHbaCRbl
 l+bsanhIg7/t9wYn8IkMrIWCFbpdUuEbdT/0Hu0Vvy1SyCRml/sWVqKrdFjWnhDJf8Vz
 fw+Lb1/6xLBSzHBIJLLYnswhJbPS4zeyPey0FCVEIlJrv4lZMUPrwI/ThUoeJAw4nb0M
 0MkbAS5PQfvSEZhO9kvag36y0kYBE6whGZuZbmjl5Wt8sUntG5yslMklqGl/ldQe/zB7
 yhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119008; x=1795723808;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QF7Ym8HltwH/EryL+lHedJXLoRmFZy+TQyk7QyouYW0=;
 b=nWQlzKaMf2nKFq/rFoo+FMx7eCXtwYLRKMsxDzgzSBsrpONT5KEWhEdmNreCMfW3iB
 fftoTE2ZjTZEst9tt29lVhOUg39/Et4xB91LYqfYbAuXzJK/6yzheoURXe5VAty29lys
 2t+Rmu6cZxh2VlpkhxjKhI1kMw2xj41ZSeM78N/pNQ+S9bLot8UenWclZfLo4pOT2Y9H
 wsy8lEK1gKRwqUdb8lqvKlMeWVBoJ735GipaUf2wY4zgCjYhGJso8wtgKfEsQMA0ZPh2
 kZ2DD7FnxQ0y8PFjO+3S/ZqbIxJlAe6l/JDy05/ij3zlGJCpa5vXTxwklfaZ58uK8HeR
 8FKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE8OTHCE7tLvJhyuDh01t0QBUCVCqQRCTXv9wuBJg7fD7eYns3Lp5nMAJEL/bsJ6jWW9yip09+N@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+snDHWt5tzKsB7tMGirgr27TE+CbYNh8I2YCItTPIcV0pDGGSH
 GKTvJiP0m64IcVm41MpS4Rp6yvUYA6QgNl4WBFfkhNcurEBR5aqsxRgMcXOzY6KcAGe6mRhRfNn
 my2Ek1eOxg57I20Nib0SNwANUR3eLlmA=
X-Gm-Gg: AYBFou1tASgYHGqnTBxGbsbGdX3WzPN28hVB9OPaSWDS+gq44aDSown7gaQNIGMLxSE
 GgYt2E+Wrz+1TF/TjtZOBYL3ti+AeZed2BWUevsxC/NmCtgLU2nDDoJb7uSnDFD4JsU5Z2GtVVw
 sKk72POb+lm69nYzv98zNtlW1RlpKZcToWBOxdY/Y3kT4Y/n46IBvbi84xucG1v9YqJ9oD8gR6v
 VYT5gshaiVfze4VURspB+FqozLLTp8mwGn8yGO2zZN1QjAXALKhLHYzVQGj8MMBRejA90dpkqZi
 tI2MbyNifIRdVPQ46sSoyn+9i3EbNMC3ns/t0hMr/bLor905UstCrm+YRyzZtch0kz5intuJMyZ
 mwzKyuj0Gk+fmz9RydUn9iM+ivE2qD/dD2k8D+Yz+2X9nIsPPuaqVkaN7trehbFoPG4gE9+Rv/s
 v0MARE5OWOOsIyR6AY49H/E8vabBJYggHDtSIUfnEBf49kBG6ZQQOLC2zpdRE=
X-Received: by 2002:a05:6808:f0d:b0:572:221b:221b with SMTP id
 5614622812f47-57a0ac2f919mr1693672b6e.5.1795119007693; Thu, 19 Nov 2026
 12:10:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
 <20261119-vfct-regression-v8-v8-1-12463194e457@amd.com>
In-Reply-To: <20261119-vfct-regression-v8-v8-1-12463194e457@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 15:09:55 -0500
X-Gm-Features: AclHuK__78tAY_AkLxZQOytNoMhYChQRQsMLPxlHF7wI-_ZkmCSTiv8HLMQmS3M
Message-ID: <CADnq5_Mfn3XCzLxyot_=vybMDLam+VoDFMgwWujnEkrTh4XLSA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Cache bridge firmware secondary bus number
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, linux-pci@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 2:46=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Drivers such as amdgpu and radeon need the bus number firmware assigned
> to a device to match it against firmware tables like VFCT. The PCI core
> may renumber buses (e.g. with pci=3Drealloc), after which the runtime
> number no longer reflects what firmware programmed.
>
> Record the bridge's secondary bus number in its struct pci_dev when
> pci_read_bridge_windows() reads the bus number register. This happens
> once, when the bridge is first enumerated and before any renumbering,
> so the value is what firmware left at FW/OS handoff. Devices behind the
> bridge can then retrieve their firmware bus number via their upstream
> bridge.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/pci/probe.c | 1 +
>  include/linux/pci.h | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f4..89a7c52ac3e5b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -513,6 +513,7 @@ static void pci_read_bridge_windows(struct pci_dev *b=
ridge)
>         res.flags =3D IORESOURCE_BUS;
>         res.start =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
>         res.end =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +       bridge->fw_sec_busnr =3D res.start;
>         pci_info(bridge, "PCI bridge to %pR%s\n", &res,
>                  bridge->transparent ? " (subtractive decode)" : "");
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96c..4c1b1e557a607 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>         struct pci_slot *slot;          /* Physical slot this device is i=
n */
>
>         unsigned int    devfn;          /* Encoded device & function inde=
x */
> +       /* Bridge secondary bus number at FW/OS handoff */
> +       unsigned char   fw_sec_busnr;
>         unsigned short  vendor;
>         unsigned short  device;
>         unsigned short  subsystem_vendor;
>
> --
> 2.43.0
>
