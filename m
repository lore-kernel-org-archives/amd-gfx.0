Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DFAC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 23:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D99410EB75;
	Mon, 25 Mar 2024 23:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="miVONJQ5";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8943310EB74
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 23:06:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EBD5DCE1810;
 Mon, 25 Mar 2024 23:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81ECC433F1;
 Mon, 25 Mar 2024 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711407987;
 bh=1QyVL22FJBxcb4t1+dh5JP6zFPMFsBApFX/CuykGQcQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=miVONJQ5NXRsG7mtEQGjb5OCHUFlD7yIcjL8Zczot8iH1PlPuzLpzXUWN779YGM8y
 sdRSypBm9jXhiqw1IzSFooBJQq5k1wtRXrJIOTx4xbzUnA1RJeHfwPvxzQkJwqjAA2
 N6YIqez7RTTZpmbSlWcSMzhmaSXkYG9rvLI4m7dYZcw7TieXzKum/7A5nU+P13vC61
 T1cLGk10rXaP0S8Iok04wj1ZA1e/YPTPkHaE8qnOaUkw/8fA7OGzdEbCdysSpVND4U
 Gsl75wBe1MjtRVXYky/7xx56/oe9JwwwMEAsu3NP0isHTJVisTQU7YEP34h3oAU2oc
 dvb52RefFwqtw==
Message-ID: <ea5a0baa-64f3-40f8-a775-433eeb0b430e@kernel.org>
Date: Tue, 26 Mar 2024 08:06:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/28] Remove PCI_IRQ_LEGACY
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325175941.GA1443646@bhelgaas>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240325175941.GA1443646@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/26/24 02:59, Bjorn Helgaas wrote:
> I applied all these to pci/enumeration for v6.10, thanks!
> 
> I added acks and reviewed-by and will update if we receive more, and
> adjusted subject lines to add "... instead of PCI_IRQ_LEGACY" and in
> some cases to match history of the file.

Thanks Bjorn !

-- 
Damien Le Moal
Western Digital Research

