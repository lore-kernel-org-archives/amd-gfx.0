Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DDC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 21:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8672A20857
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 21:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGwKA8kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8672A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E33B6EB15;
	Fri, 17 Apr 2020 21:24:10 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8FA6EB15
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 21:24:08 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id f13so4602125wrm.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z9skO7g/PmQUyeT0G+pKV3aytp1S6KVZDbYbHGcVm3c=;
 b=MGwKA8kEJZiflofDoGh/DV5r8e8q4BWeXQPb9Vbt7idAb9l9N5Bb5spMsMk1rGKuzV
 gIHDaFiW9VLDtT7rTLB65GIcORGC8zUinO7iYWtjFkCKonzE3aBi0IKhsBCjuanfiDHR
 Fp13j+LAJ5k64X8MEGQGMMekh5QgvyFVXXAGK+3BFNzOWrCDrVjdJ5ItJYRHm8VnhL6t
 gXW6lsM+kZTJMCdth6+9bg0arUHnYOYKeiQD4bQib6HtsHm/PbjqaxwZ1RZfUzuqrx/Q
 nM4uSmEzkFqByrpNeR44KTFR25hLza5GPQpgfrwLvPQIJUCdTGAW7DrWGS1oiNkCTFpD
 JFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z9skO7g/PmQUyeT0G+pKV3aytp1S6KVZDbYbHGcVm3c=;
 b=T5Y+AE0Q9lBAGCT7sf92DkfrUU7IKyURZJYpm6ZP53pg7b8p1zYOvDs2xNjGZ8gPka
 RPkVhuwfD37lCmQMvPxG1mDXcP5IGWbW4DghZb2qvGEZ+GDA1FEYbvDSXPlmHgRxxWsm
 TeEl5q2rIag2d+M1XGn97srjKWvrdy+WpOkmtaqUQ/XGUa0fxF2NJMLmtKUEImZYDDEd
 DZbDU2ZY9rNo7HwQQ0seWBsNKTFLg81CMJBDBRhJj0Llln9yemvGQHNr0bzA1Kwi4m3Z
 BVyMVXmgME7Zmd4xSCaYJbrEWqLgh7vopV5zuietzktIpn8gWrKO0WnuXpT3jnxfvnJf
 DCIg==
X-Gm-Message-State: AGi0PuZ0yxMGaQVW784JJUB4tCPu8uVSKm2WiYhvaZYHYBbNM9TVG4hG
 zKfKjQBRmU60SnTmsw5cDQWfgJFTAmeqXNkn0nA=
X-Google-Smtp-Source: APiQypLzmxTMadtiQcdpa3yG2GCZ/Q8EGLTluaJuU3xrVUdVRuIqqqqKCxmqSSp3iqJURjI33R++8ilzTUCVkBpxebs=
X-Received: by 2002:adf:f844:: with SMTP id d4mr5791885wrq.362.1587158647577; 
 Fri, 17 Apr 2020 14:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200417204446.13999-1-Yong.Zhao@amd.com>
In-Reply-To: <20200417204446.13999-1-Yong.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2020 17:23:56 -0400
Message-ID: <CADnq5_NKsiZamr+_0bi968gPa0ti69dG2+Pj0R32w4rmVtbeKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdkfd: Adjust three dmesg printings during
 initialization
To: Yong Zhao <Yong.Zhao@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches 1, 2 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Apr 17, 2020 at 4:45 PM Yong Zhao <Yong.Zhao@amd.com> wrote:
>
> Delete two printings which are not very useful, and change one from
> pr_info() to pr_debug().
>
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index de9f68d5c312..1009a3b8dcc2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -502,7 +502,7 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
>         num_nodes = crat_table->num_domains;
>         image_len = crat_table->length;
>
> -       pr_info("Parsing CRAT table with %d nodes\n", num_nodes);
> +       pr_debug("Parsing CRAT table with %d nodes\n", num_nodes);
>
>         for (node_id = 0; node_id < num_nodes; node_id++) {
>                 top_dev = kfd_create_topology_device(device_list);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 5db42814dd51..46dcf74ee2e0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -787,7 +787,6 @@ static int kfd_topology_update_sysfs(void)
>  {
>         int ret;
>
> -       pr_info("Creating topology SYSFS entries\n");
>         if (!sys_props.kobj_topology) {
>                 sys_props.kobj_topology =
>                                 kfd_alloc_struct(sys_props.kobj_topology);
> @@ -1048,7 +1047,6 @@ int kfd_topology_init(void)
>                 sys_props.generation_count++;
>                 kfd_update_system_properties();
>                 kfd_debug_print_topology();
> -               pr_info("Finished initializing topology\n");
>         } else
>                 pr_err("Failed to update topology in sysfs ret=%d\n", ret);
>
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
