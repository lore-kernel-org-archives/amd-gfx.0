Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CE9C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 12:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F9C64DFB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 12:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F9C64DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7626E8EF;
	Thu, 18 Mar 2021 12:59:27 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5962F6E8EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 12:59:26 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 f73-20020a9d03cf0000b02901b4d889bce0so5057504otf.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=flnuCJmkCbO9vOMN2hjdShCNNxwnOUuZwk9FVjH8m5M=;
 b=nsCy+deLyfGBS05VFAcKMVJGt+ggWZQNP08bL30rKRnqojA4mWbnnYircD5kWPGN1/
 M1su3GmvT1MbKGyYhHuVLnWlN+SraMOf7n/+5vTCl9cxdaPMPjpUQNNPK96GL6lGs03M
 MPTF38fzuCA8bYfHMQx8tpzDJBv1CLshOsi8wrMZLqxUxkfTp0eZrcwtSyLImQJNQlxB
 I+v60bnfMXjMKjCMidY89MuUXvLEa4Ywa9R7exRARKnsgqDStVEx0yxSmyLn7ONSIw8n
 Tnyv7S+fAgSipfsfmT9gExhE20S4PuimaBw9FateM3W3IVJ4l/RklaSa4zS9/CFt/7vj
 /jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=flnuCJmkCbO9vOMN2hjdShCNNxwnOUuZwk9FVjH8m5M=;
 b=a12/w9OIwaatZtm/AGqIEltLWdrERePjNivXRwXcEYDCw7084vbnnAg0+/C3w/outH
 5jyjX2nH4z7YyZ2DkfVGSv6+9AyOhsq47ChUpUpeXcodhz+y8P9dfT0SQu+kG5J1LcN/
 dyZplWViSvGORzAPst5dxwaTZMd4OuJVelv5cFcTb4/E7y7VlytPoup/LGfW4VpuuBr1
 ptO09nqGuOopjcGd25FEwaJP0KyxlkqINeR0PGE9w3/cM6PfjAvIKDhgEjrj3qwcxuyO
 XcYVDc5TqxHAUumIKdXlDh9+2ktO/N2RtdBf7TWhfUfAE6NUNidvJI8aJhamPDUE7s5/
 dXiQ==
X-Gm-Message-State: AOAM531SlUxydx35dcHQqOrukWvqjn8tYO8nHVIbrZQzTpr42sO8kGGu
 4/25IYAc6uQjfzQG0AFFp9ij+V+QKublcu8uypA=
X-Google-Smtp-Source: ABdhPJzp8F1vZtgbbElh/gnLKMk1rDljrrW0Y8LxFpIyWOr+bHZbmT3SJBW/my52EO8RdOVU84aU6CE4WmsIyOxdyiU=
X-Received: by 2002:a05:6830:408f:: with SMTP id
 x15mr7664234ott.132.1616072365558; 
 Thu, 18 Mar 2021 05:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210317143842.786380-1-alexander.deucher@amd.com>
 <20210317143842.786380-2-alexander.deucher@amd.com>
In-Reply-To: <20210317143842.786380-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Mar 2021 08:59:14 -0400
Message-ID: <CADnq5_MHC4nNwCuMYN_esMh15uaYuODS1d-u_+wLOM4-9yaGgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 V2] platform/x86: force LPS0 functions for AMD
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Shyam-sundar.S-k@amd.com, Hans de Goede <hdegoede@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marcin Bachry <hegel666@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Prike Liang <Prike.Liang@amd.com>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Let's hold off on these patches for the time being.  At least one of
them seems to cause problems on another laptop.

Thanks,

Alex

On Wed, Mar 17, 2021 at 10:39 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD are supposedly not
> required for AMD platforms, and on some platforms they are
> not even listed in the function mask but at least some HP
> laptops seem to require it to properly support s0ix.
>
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> ---
>
> V2: rework the patch to just fix up the specific problematic
>     case by setting the function flags that are missing.
>
>  drivers/acpi/x86/s2idle.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2d7ddb8a8cb6..482e6b23b21a 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -368,6 +368,13 @@ static int lps0_device_attach(struct acpi_device *adev,
>
>         ACPI_FREE(out_obj);
>
> +       /*
> +        * Some HP laptops require ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD for proper
> +        * S0ix, but don't set the function mask correctly.  Fix that up here.
> +        */
> +       if (acpi_s2idle_vendor_amd())
> +               lps0_dsm_func_mask |= (1 << ACPI_LPS0_ENTRY_AMD) | (1 << ACPI_LPS0_EXIT_AMD);
> +
>         acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
>                           lps0_dsm_func_mask);
>
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
