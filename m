Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD1C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734166199F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734166199F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1692D6E073;
	Mon, 17 May 2021 14:24:19 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE53E6E073
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:24:16 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so5695835otg.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l+6ryiKHsnOZrkZjGxnuHvx4Cycm+dsFfU/WqN/dQEA=;
 b=Uet526pQze3XnO0rRbziFJ3zcyE3qzeH/2SETys95c8ydaMVd1Z33RVPtTgRL8RYTa
 aWK/VShL+pZfiHzzN0YQcEnQwysDq1I3j5+ECCu0CeDnqsf1jBPc9+6DVRN0zFFYO6qx
 k2OohVl7hjh4ov5bLPq3yx5yAMWfUTuQ5JlGIcX8OnwYZUkRNnvPrRvnpCsvjF+CsT0q
 uPbkyAMJP8PgONcBq4+49zuzAg/GrcjXfg560jnylrspaKymIluntFGyirljPRcgFN9O
 tqVtP4WyTpGMsRCLYmZQzelmjjYpJJxZnVb29TIre6q9fkIft4DIVUaL+YZCf30zbFpj
 0jmA==
X-Gm-Message-State: AOAM533oDD5jCKa1pVNzhJipwlD6X1FNi68Y4ACEDIdJZAiBe+qfUna+
 FhI5K0uaa59VClvu/NB9EIeg5qXevZH/Mh2fuXeedw+Z
X-Google-Smtp-Source: ABdhPJzxG5TWpGfsd01iDYNp7QK+JpVulbNbYKyCwUqf7AhUIBtBMSdVYtxBNvtsdVuzQ18H4nEY9TmFKY51v58O8lE=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr52530163otc.206.1621261456311; 
 Mon, 17 May 2021 07:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210505132032.601097-1-alexander.deucher@amd.com>
In-Reply-To: <20210505132032.601097-1-alexander.deucher@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 May 2021 16:24:05 +0200
Message-ID: <CAJZ5v0i5QDQbxYtkrqrQzPpc08Gvr1Jngb4ZC8VOPhphPs5pcQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Add missing LPS0 functions for AMD
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
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Prike Liang <Prike.Liang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Marcin Bachry <hegel666@gmail.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 5, 2021 at 3:21 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> These are supposedly not required for AMD platforms,
> but at least some HP laptops seem to require it to
> properly turn off the keyboard backlight.
>
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> ---
>
> Resend with updated subject.
>
>  drivers/acpi/x86/s2idle.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2b69536cdccb..2d7ddb8a8cb6 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
>
>  /* AMD */
>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
> +#define ACPI_LPS0_ENTRY_AMD         2
> +#define ACPI_LPS0_EXIT_AMD          3
>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
>  #define ACPI_LPS0_SCREEN_ON_AMD     5
>
> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
>
>         if (acpi_s2idle_vendor_amd()) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>         } else {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
>                 return;
>
>         if (acpi_s2idle_vendor_amd()) {
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>         } else {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> --

Applied as 5.14 material, thanks!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
