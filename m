Return-Path: <SRS0=J5eG=D2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4174FC388F8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 12:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C512721D81
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ntIAxdfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C512721D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA296E956;
	Mon, 19 Oct 2020 12:38:49 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8891E6E44B
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2020 21:01:33 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id ce10so8469077ejc.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2020 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QU5tUnKrk3cCgEOM6DUuSpHohPcIoidzngrqxPrVqlg=;
 b=ntIAxdfj5B3UZZJPAO3W3zqpuYJdxZe6wmMN+Cg5+tfh5QjsxLbXR5o2amfdJQ2J48
 +r9G2vZiMs4S/e6t6kNU+/1RisTXP2Yspklt8lksB4PhSQjsUISEYusYJeN2p0XCHoqr
 5tX/QI+fZe3GQZJaviemAIYQlGxoIFC7s6aX8R5MJQLi2SOYJ/keQbrc62HNUeJ8pCOI
 7WYztP0OE4axPIRoGDfVK4aq4k9dPY6fZ69Y4fL3/a70qb0GrKtNhloBSbp9yIhwtpgg
 UECkhdkcAFyI2jUc3qFZfU7NKoc+E1dZJHZxhONiRQFFV//aVnbaYjp+hfJUaNjfh3TU
 ik3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QU5tUnKrk3cCgEOM6DUuSpHohPcIoidzngrqxPrVqlg=;
 b=I4XOMjgEOs6YiguBmOsbB+e8DvHerpIqPleDIZRclAHId+MFKzTpFm4tCN7Uqpm2tQ
 PIpV9Y27KTgB/jZ171HE4jyIUhzHqYIX/jaLmCz+4JA+OuHJqSYXLaiU3MZ9jSb2jeCy
 N4qBTZ+CnrFU8bwAm7FiwDSPTDaNkVW+eD5EAlwc00NRIEdQ3yEdM9BzQFytyDdt/ove
 OhxJ7b/MN+EDbQ8fCJYDHXnYyxg3zqJw2mvYKXeDTAY7CyteyyU/snhAxaXTjZEDoupx
 kdrc2SNaF6ldPNzpqIv7S6zkmGxiG0zPuuKvkuvrYyPhphthWgQD2nPuTnY8+d/COP56
 d3Hg==
X-Gm-Message-State: AOAM532sSVuZAUfDcPDrsMYijClcVNL2U486SDqX0NmKldAtV79swBpV
 QDWQgI1f76EoJ8nOrgVJEem4Vx5XqFs49W4JVngCzQ==
X-Google-Smtp-Source: ABdhPJzde2s6j/g/ekBLPPrgSH2EJqfd3KSDRuhe3Mnzr9w98lVRa6HniOngGCyhNuV4q/eDk1HFvyy/v8IqyEanGTA=
X-Received: by 2002:a17:906:1a19:: with SMTP id
 i25mr9957370ejf.323.1602968492144; 
 Sat, 17 Oct 2020 14:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201017160928.12698-1-trix@redhat.com>
In-Reply-To: <20201017160928.12698-1-trix@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 17 Oct 2020 14:01:22 -0700
Message-ID: <CAPcyv4jkSFxMXgMABX7sDbwmq8zJO=rLX2ww3Y9Tc0VAANY8xQ@mail.gmail.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To: trix@redhat.com
X-Mailman-Approved-At: Mon, 19 Oct 2020 12:38:47 +0000
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
Cc: alsa-devel@alsa-project.org,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
 storagedev@microchip.com,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org,
 "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
 linux-mtd@lists.infradead.org, ath10k@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, usb-storage@lists.one-eyed-alien.net,
 linux-watchdog@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, intel-wired-lan@lists.osuosl.org,
 industrypack-devel@lists.sourceforge.net,
 Linux PCI <linux-pci@vger.kernel.org>, spice-devel@lists.freedesktop.org,
 MPT-FusionLinux.pdl@broadcom.com,
 "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 linux-serial@vger.kernel.org, linux-nfc@lists.01.org,
 Linux-pm mailing list <linux-pm@vger.kernel.org>, linux-can@vger.kernel.org,
 linux-block@vger.kernel.org, linux-gpio@vger.kernel.org,
 xen-devel <xen-devel@lists.xenproject.org>, linux-amlogic@lists.infradead.org,
 openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-edac@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>,
 Linux Wireless List <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 linux-crypto <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com,
 bpf@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Oct 17, 2020 at 9:10 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> This is a upcoming change to clean up a new warning treewide.
> I am wondering if the change could be one mega patch (see below) or
> normal patch per file about 100 patches or somewhere half way by collecting
> early acks.
>
> clang has a number of useful, new warnings see
> https://clang.llvm.org/docs/DiagnosticsReference.html
>
> This change cleans up -Wunreachable-code-break
> https://clang.llvm.org/docs/DiagnosticsReference.html#wunreachable-code-break
> for 266 of 485 warnings in this week's linux-next, allyesconfig on x86_64.
>
> The method of fixing was to look for warnings where the preceding statement
> was a simple statement and by inspection made the subsequent break unneeded.
> In order of frequency these look like
>
> return and break
>
>         switch (c->x86_vendor) {
>         case X86_VENDOR_INTEL:
>                 intel_p5_mcheck_init(c);
>                 return 1;
> -               break;
>
> goto and break
>
>         default:
>                 operation = 0; /* make gcc happy */
>                 goto fail_response;
> -               break;
>
> break and break
>                 case COLOR_SPACE_SRGB:
>                         /* by pass */
>                         REG_SET(OUTPUT_CSC_CONTROL, 0,
>                                 OUTPUT_CSC_GRPH_MODE, 0);
>                         break;
> -                       break;
>
> The exception to the simple statement, is a switch case with a block
> and the end of block is a return
>
>                         struct obj_buffer *buff = r->ptr;
>                         return scnprintf(str, PRIV_STR_SIZE,
>                                         "size=%u\naddr=0x%X\n", buff->size,
>                                         buff->addr);
>                 }
> -               break;
>
> Not considered obvious and excluded, breaks after
> multi level switches
> complicated if-else if-else blocks
> panic() or similar calls
>
> And there is an odd addition of a 'fallthrough' in drivers/tty/nozomi.c
[..]
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 5a7c80053c62..2f250874b1a4 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -200,11 +200,10 @@ ssize_t nd_namespace_store(struct device *dev,
>                 }
>                 break;
>         default:
>                 len = -EBUSY;
>                 goto out_attach;
> -               break;
>         }

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
