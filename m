Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B477CC33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 23:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856A9207FD
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 23:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUJR+4Gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856A9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579B489BC2;
	Mon,  6 Jan 2020 23:05:17 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55FED89B68;
 Mon,  6 Jan 2020 23:05:16 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id g17so51759241wro.2;
 Mon, 06 Jan 2020 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YFPtgmu7am1f4EYBfi4KkzbAOi/FXMPKhu8S1KpGb/4=;
 b=aUJR+4GbxeThYylY61qSlLQa/j+gyCDHOWZzYTVFfkL0RK++xm94Psbe64jO0Cm3ZY
 MJbKj2jOr3eNOfv3KewqjyvRvtLA4H3Tr/n1d0pCI/Z3goBsKkLZfM+tLHQO7a6iXmy5
 CMzw4bBchTzItKgZxoZmjvnfNubjGupSEospQES7nFYGosxM69MnuPxtl+fQWxAP5+X/
 D8Ver0mwlHhyCya8SsAWss6btFwNRwUmY97Xzwq7ooasO6w0sJ2IT3Pf2XzdcfoRvaWF
 /HostWtyE+6n9RSu7mCIMcemhqU2QJaFV7o2RlCOgfMN5IwVkWrQerOBcH74z4l/h7dw
 GfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YFPtgmu7am1f4EYBfi4KkzbAOi/FXMPKhu8S1KpGb/4=;
 b=Kn9eTWNWcOu5dPIwEsW4GdxUcjZWyYnXQl3pt6ronBu6nz6tQuRx1lKKR3SUZWOZZg
 VkovQtZqHG1UBb9NYlvkAXNQFLc1TEzXOu6qPLSRfftXNo/ZeXqQ9kPuhly2ixl5xi6r
 uTWa3/Ad4YCVmmUR2VomdAeQ1E2URFyPwgCg74tMGcYsZHxEBTS3zTSEtqRzhmUQFHJQ
 +/3JY7Qflui4O2a2gQwurZc1i37J883O7MU8RIzp7/6Xzxc7cDDtCGljKMmqLdZNZVFJ
 VeWYo7q2SPnETDhcBbCk6YS5PwCSXAyRbPCNN7REjfcdLBlnliYSD/kF95vXzVj+mZdL
 9jWg==
X-Gm-Message-State: APjAAAWO2vdeESM7eRMlX0nxKw3tx+mV8Y3nHxwT1HYYzcRZX7dUQ6xu
 ukJciiWOKhzjrLlQYchu5T1dR67c5I0WJhtaBLM=
X-Google-Smtp-Source: APXvYqwATAYO1fo/4+rjXeWQuxn8GwzWJd2sBicOKRI8Nw8ohzmJbJdlRJizBiyOxLYpN0dNPXoC1OZ2ZvQDLTyP6yI=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr105033883wru.40.1578351915043; 
 Mon, 06 Jan 2020 15:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20200103191852.15357-1-wambui.karugax@gmail.com>
In-Reply-To: <20200103191852.15357-1-wambui.karugax@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jan 2020 18:05:03 -0500
Message-ID: <CADnq5_MSd5YkfnmoJnv0ydYmW45U+Vwvtnrw5wmFpR59GtQRLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: use list_for_each_entry for list iteration.
To: Wambui Karuga <wambui.karugax@gmail.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 3, 2020 at 2:34 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> list_for_each() can be replaced by the more concise
> list_for_each_entry() here for iteration over the lists.
> This change was reported by coccinelle.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 64445c4cc4c2..cbcf504f73a5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -111,17 +111,12 @@ static void init_handler_common_data(struct amdgpu_dm_irq_handler_data *hcd,
>   */
>  static void dm_irq_work_func(struct work_struct *work)
>  {
> -       struct list_head *entry;
>         struct irq_list_head *irq_list_head =
>                 container_of(work, struct irq_list_head, work);
>         struct list_head *handler_list = &irq_list_head->head;
>         struct amdgpu_dm_irq_handler_data *handler_data;
>
> -       list_for_each(entry, handler_list) {
> -               handler_data = list_entry(entry,
> -                                         struct amdgpu_dm_irq_handler_data,
> -                                         list);
> -
> +       list_for_each_entry(handler_data, handler_list, list) {
>                 DRM_DEBUG_KMS("DM_IRQ: work_func: for dal_src=%d\n",
>                                 handler_data->irq_source);
>
> @@ -528,19 +523,13 @@ static void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
>                                          enum dc_irq_source irq_source)
>  {
>         struct amdgpu_dm_irq_handler_data *handler_data;
> -       struct list_head *entry;
>         unsigned long irq_table_flags;
>
>         DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
>
> -       list_for_each(
> -               entry,
> -               &adev->dm.irq_handler_list_high_tab[irq_source]) {
> -
> -               handler_data = list_entry(entry,
> -                                         struct amdgpu_dm_irq_handler_data,
> -                                         list);
> -
> +       list_for_each_entry(handler_data,
> +                           &adev->dm.irq_handler_list_high_tab[irq_source],
> +                           list) {
>                 /* Call a subcomponent which registered for immediate
>                  * interrupt notification */
>                 handler_data->handler(handler_data->handler_arg);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
