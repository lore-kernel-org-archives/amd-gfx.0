Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED50DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 16:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613F010E5AF;
	Tue, 22 Feb 2022 16:22:41 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D685210E5AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 16:22:40 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a8so44646675ejc.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 08:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=q+My118MVhW0Ye9CMLkqYiEKe4aBqZcoI39IWD/unS0=;
 b=pvMkvfXmaWSL7HS+xyy70n9lAtmMhkhp+Jv4oA1m2QpPzXv/iYiXcfNPEOBK3UHrdu
 AcFAf9Vu4GROep7TFHJdx0oIKb9yS3mbcQsEfvwTPdXC85jYtebb5Y3eE8g7PblKZtff
 vhsXPa+P6Laor3KIqmlDIXP4ZnNQnvPlObzz5Bha+8gSbykpJ0/LmaNIoasnEnx6vIxV
 dNbRfINs+qEt6FR58bm02ESK81QDBF+5CXjTcYhbO6kp/+buXU/Id6CONuiqGTI/czfW
 OIYIrQANVyDwdZZu4dTZnNEntLm31ytjfg9GKeSaTBT+ZN8ZYK6IntvkT4/27q46dNQ3
 rnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=q+My118MVhW0Ye9CMLkqYiEKe4aBqZcoI39IWD/unS0=;
 b=XA+RwFDlnPXLeRUynnvfuwx8dtF56UUmtAMozEhMVeZD2AVOzJfftDEUx+im3CSzX+
 2GA2+dhbpMHDiD/f6wIumYk2kjKEMceJfJ1jRH4dKya6R9/AepeA/pJhh03S+AU+z+f4
 yDFy1tLyc5Jrmr1lamjBEP3X6m4CeIdBPHe5aPQ0Vme7gseI77B4IFgxEGVFAeWTrBwf
 k5dJyruM6QTpnns0Hfso1WNRNiO0u9NCvhoZgiVAPZlfuJmTRR0Va+dLvOvVrFolf983
 BB/eSduxc0+Ph7VdbF0rOCSO5mY3iiIKjGzXu9gSYGPS9zRimnH2uqni2YlwuJFPoyLh
 /4Ww==
X-Gm-Message-State: AOAM532ccj2WR4E1Rl9VbJwhkeEeuix/prh3SZK2JBl30kPuwXEro9UU
 7UOnSygvE6tG+7UlNcRzUYM=
X-Google-Smtp-Source: ABdhPJxiZ/YD4QrnfvYntsavdPaFU6LgVRlEu7GPEQWh6CYDpnyjl3dRdGyKtloVvE5gVvg7045uuQ==
X-Received: by 2002:a17:906:b04:b0:6bd:bf71:ed08 with SMTP id
 u4-20020a1709060b0400b006bdbf71ed08mr20337601ejg.585.1645546959316; 
 Tue, 22 Feb 2022 08:22:39 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:21b6:6d72:8af6:ec7c?
 ([2a02:908:1252:fb60:21b6:6d72:8af6:ec7c])
 by smtp.gmail.com with ESMTPSA id m17sm6385797ejq.22.2022.02.22.08.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 08:22:38 -0800 (PST)
Message-ID: <cce740f9-3209-045c-ceb6-0089621362e5@gmail.com>
Date: Tue, 22 Feb 2022 17:22:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] PCI: Apply quirk_amd_harvest_no_ats to all navi10 and 14
 asics
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20220222160801.841643-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220222160801.841643-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 22.02.22 um 17:08 schrieb Alex Deucher:
> There are enough vbios escapes without the proper workaround
> that some users still hit this.  MS never productized ATS on
> windows so OEM platforms that were windows only didn't always
> validate ATS.
>
> The advantages of ATS are not worth it compared to the potential
> instabilities on harvested boards.  Just disable ATS on all navi10
> and 14 boards.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1760
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/pci/quirks.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..ea2de1616510 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5341,11 +5341,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>    */
>   static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>   {
> -	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
> -	    (pdev->device == 0x7340 && pdev->revision != 0xc5) ||
> -	    (pdev->device == 0x7341 && pdev->revision != 0x00))
> -		return;
> -
>   	if (pdev->device == 0x15d8) {
>   		if (pdev->revision == 0xcf &&
>   		    pdev->subsystem_vendor == 0xea50 &&
> @@ -5367,10 +5362,19 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
>   /* AMD Iceland dGPU */
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
>   /* AMD Navi10 dGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
>   /* AMD Navi14 dGPU */
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
>   /* AMD Raven platform iGPU */
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
>   #endif /* CONFIG_PCI_ATS */

