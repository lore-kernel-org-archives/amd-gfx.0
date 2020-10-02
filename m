Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58469C4363D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 14:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122C2206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 14:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122C2206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6276E95A;
	Fri,  2 Oct 2020 14:17:30 +0000 (UTC)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4406E95A
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 14:17:28 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id m13so1467534otl.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2020 07:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2xfW2r+5F5TUfquNrBpvFl+fZupXfBEeJ3aS3h1+V9U=;
 b=bgWrPmukmZEyBIcCufqa3fSIdWgxbHksCKBqHZfc6pG2QHAZ8Tm3K8zfLZrRudmv3d
 BqMEeaVA0DHkU+nhRU+Y116tLDonJ6JipySYU8PU7dSVnP+50g2iFw5liiyk5erHVhen
 24pYpRW8rZEPI+dE7b4asFRb1pWSr/omoMczUaaSv5ykUuhzBgsGm8nEY61YTg0g6te/
 pjZWuoGarq82JJ3ei8R0AFKsXCoJHo4sqsiPpwvnSEceldMmJrBQSuA10xaHMo8fP2dm
 tu9M64fYClGFfq62R2DL53ilMFsf9lG5bTIrRyNCJrPgTo0r5nlpdfT+LE5Lj1ItFpdP
 MkvQ==
X-Gm-Message-State: AOAM533Fsajqz0+CLfuK8clkykM8y+SMhAkuD3l1/D+SByaQLxdLWahe
 5Auz5tHXeFSyoyOv8TVtM0kFjzvN/ChM22peUDo=
X-Google-Smtp-Source: ABdhPJzXm554JtWA/ocFLcb2CIIiiUOnto9zamZpCzFCyUU6KYxt5wXGwLT9IKo1P4fJiendlJDRKnxDcdkSXViCSjg=
X-Received: by 2002:a9d:718a:: with SMTP id o10mr1888736otj.262.1601648247890; 
 Fri, 02 Oct 2020 07:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
In-Reply-To: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Oct 2020 16:17:15 +0200
Message-ID: <CAJZ5v0h5dHp6C8rx-B-hS=6hJOvTHuY1K4590qkNzCAkoivK4g@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power managed
 by ACPI
To: Lukas Wunner <lukas@wunner.de>
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
Cc: Aaron Zakhrov <aaron.zakhrov@gmail.com>,
 Michal Rostecki <mrostecki@suse.com>, Linux PCI <linux-pci@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Shai Coleman <git@shaicoleman.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Arthur Borsboom <arthurborsboom@gmail.com>, matoro <matoro@airmail.cc>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 2, 2020 at 7:17 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> Recent laptops with dual AMD GPUs fail to suspend the discrete GPU, thus
> causing lockups on system sleep and high power consumption at runtime.
> The discrete GPU would normally be suspended to D3cold by turning off
> ACPI _PR3 Power Resources of the Root Port above the GPU.
>
> However on affected systems, the Root Port is hotplug-capable and
> pci_bridge_d3_possible() only allows hotplug ports to go to D3 if they
> belong to a Thunderbolt device or if the Root Port possesses a
> "HotPlugSupportInD3" ACPI property.  Neither is the case on affected
> laptops.  The reason for whitelisting only specific, known to work
> hotplug ports for D3 is that there have been reports of SkyLake Xeon-SP
> systems raising Hardware Error NMIs upon suspending their hotplug ports:
> https://lore.kernel.org/linux-pci/20170503180426.GA4058@otc-nc-03/
>
> But if a hotplug port is power manageable by ACPI (as can be detected
> through presence of Power Resources and corresponding _PS0 and _PS3
> methods) then it ought to be safe to suspend it to D3.  To this end,
> amend acpi_pci_bridge_d3() to whitelist such ports for D3.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1222
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1252
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1304
> Reported-and-tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Reported-and-tested-by: matoro <matoro@airmail.cc>
> Reported-by: Aaron Zakhrov <aaron.zakhrov@gmail.com>
> Reported-by: Michal Rostecki <mrostecki@suse.com>
> Reported-by: Shai Coleman <git@shaicoleman.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci-acpi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d5869a0..d9aa551 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -944,6 +944,16 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         if (!dev->is_hotplug_bridge)
>                 return false;
>
> +       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> +       adev = ACPI_COMPANION(&dev->dev);
> +       if (!adev && !pci_dev_is_added(dev)) {
> +               adev = acpi_pci_find_companion(&dev->dev);
> +               ACPI_COMPANION_SET(&dev->dev, adev);
> +       }
> +
> +       if (adev && acpi_device_power_manageable(adev))
> +               return true;
> +
>         /*
>          * Look for a special _DSD property for the root port and if it
>          * is set we know the hierarchy behind it supports D3 just fine.
> --

I'm going to apply this patch for 5.10 unless Bjorn would rather route
it through the PCI tree.

Thanks!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
