Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028F8C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBBE610F7
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBBE610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10AC6E49F;
	Wed,  5 May 2021 13:11:56 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4BD6E49A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 13:11:55 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id k25so2123568oic.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 May 2021 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OWL3R/wvp79X5sMQgGYKT2VaRT3usJagJyJ8LLwCBRc=;
 b=YEKNUVNGjcNZcPeTxKUu3L9ieWS5OYMjeFVM/Iv4aZH+waVxukEYe9obPkcrt+hNKc
 4CbnLMBhTNyKjtzDfocKAdW3Qk5EIsae4ZsdPtpgnkEiG3PhtVKyJAkbRDpRTaKKNbeE
 2GXz/9RSTXrZk2xlEc1dk4nVGK6QGEBj2Avy4ZpTVpcR0ovtQFoTwMjSDRKyo0KGQ1Vy
 6mGiz2/wyIaqGmiaMIYQ736kd2vs+CAwROqzO1t1Y4zCHl6An6thJxp0x0QxGUs8teb6
 LJmHbMH0RmdssEhJV7jOuh0Q7AuI+ijpFAOy+2QxRCOsIuReJcNGj0zASGKBh6SRz3GP
 1aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OWL3R/wvp79X5sMQgGYKT2VaRT3usJagJyJ8LLwCBRc=;
 b=sjVMeuOgWSbAViyAjLTWWwLpM1do5nIo8sygOpexQOZKoaTs8VnZ7fG1+Z03+fsqFO
 gTu6E8wj+jIIeJVCUNz5nLA6y16/TFB+ISbBx71kwRhu6mXXFj2QQz65da5c09Tnbg6T
 uRITnGcKcnYYdbnyBPR0bVitEWSQYcW8n36ZCHJjjhyy/g9SRM4ac3sah727s+EDSh2d
 NAaM10aCx+ZOMW0wdXRNOKkufm4YHWf3C3tTgtlIhj5OxqzEeThClRTJED8mKx5FlHwo
 zxS0q3Kpac58oO2BL4f+cFOhZYmae5FU9s40LX+mEBNd2MsRI9nVb87iJqpWkIU1qWx7
 G7mA==
X-Gm-Message-State: AOAM530hBGB0Ze6oWTgCioldCCwTbHZtFuYth6gkGINUWNGIpeWJPPTO
 mbJ5SFZYw9FI2WyueN3Xn+JCzm9DOG+0F00BEEA=
X-Google-Smtp-Source: ABdhPJztzUDmHalSN8/7tcMO2/PyPxSYfsnh3OwAMTzs8F6HtjLhgkdAVxMxilL+vymgNpAZ4siQxjJSV8DOxu+hD1c=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr21052843oig.120.1620220314538; 
 Wed, 05 May 2021 06:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210504221140.593002-1-alexander.deucher@amd.com>
 <BYAPR12MB2693F7109BC8E7EF9F672A16E25A9@BYAPR12MB2693.namprd12.prod.outlook.com>
 <22c1b9a9-8167-5e4f-6ff7-278c386cc423@redhat.com>
In-Reply-To: <22c1b9a9-8167-5e4f-6ff7-278c386cc423@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 May 2021 09:11:43 -0400
Message-ID: <CADnq5_POX7j1_BDh24uQ=gFfJU43TQW49Q32LUoisqg3hW8t+A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add missing LPS0 functions for AMD
To: Hans de Goede <hdegoede@redhat.com>
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
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Marcin Bachry <hegel666@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 5, 2021 at 9:10 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 5/5/21 12:33 AM, Limonciello, Mario wrote:
> > [AMD Public Use]
> >
> >> Subject: [PATCH] platform/x86: Add missing LPS0 functions for AMD
> >
> > Rafael might be willing to fix it up on commit, but if you end up needing to re-spin
> > I think technically this subsystem prefix to match other stuff committed to this file
> > should be:
> >
> > "ACPI: PM: s2idle:"
>
> Ack, please get the subject next right time. I was about the put this in a folder
> with patches to apply to the pdx86 kernel tree once 5.13-rc1 is out, but this
> should not go upstream through the pdx86 tree at all.

Do you want me to resend with the corrected subject?  What tree does
this need to go through?

Alex

>
> Regards,
>
> Hans
>
>
>
> >
> >>
> >> These are supposedly not required for AMD platforms,
> >> but at least some HP laptops seem to require it to
> >> properly turn off the keyboard backlight.
> >>
> >> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> >>
> >> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Marcin Bachry <hegel666@gmail.com>
> >> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>
> >> Dropping patch 2/2 for now.  This patch fixes several
> >> systems and doesn't appear to cause any issues.
> >>
> >>  drivers/acpi/x86/s2idle.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> >> index 2b69536cdccb..2d7ddb8a8cb6 100644
> >> --- a/drivers/acpi/x86/s2idle.c
> >> +++ b/drivers/acpi/x86/s2idle.c
> >> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
> >>
> >>  /* AMD */
> >>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-
> >> 932122d37721"
> >> +#define ACPI_LPS0_ENTRY_AMD         2
> >> +#define ACPI_LPS0_EXIT_AMD          3
> >>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
> >>  #define ACPI_LPS0_SCREEN_ON_AMD     5
> >>
> >> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
> >>
> >>      if (acpi_s2idle_vendor_amd()) {
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> >> +            acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
> >>      } else {
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> >> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
> >>              return;
> >>
> >>      if (acpi_s2idle_vendor_amd()) {
> >> +            acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
> >>      } else {
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> >> --
> >> 2.30.2
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
