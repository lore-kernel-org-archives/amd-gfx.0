Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EA8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 18:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DD610E116;
	Thu, 24 Feb 2022 18:49:20 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4793910EC94
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 18:49:19 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id a6so4170751oid.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fD5CNXXJ6IV6QwGcr0DQoNMC+yJt6vtql/PF9eNeh+0=;
 b=mMhnakQZvz7VVZ9F8t1G9w6qKwbZGsD1CcFifbirQOcYsuOyoRDHfIoMyhQgJ4Gcb5
 9VzK8mSmrxIOZd5oCb4QH4VQAYXNUcfibuTGeoq7zfQvcApdXrxLfnrWHo1fnKkio8BS
 n950IUFcA1BjAZYz4HpY/JQ33NuOMe7yeyLxkD7cfVj3C2E3R2aGTn+kvIrBxa1q+d29
 qRhm13f+gma3S2ywpPELpNYM9eACw3MwbbipsHz4dhK9tVymp1lg5WgeHl60yhldDnK8
 lLL3D/WIRqMW546Af5qLDD7xRzuBtVlT5nWdqxHFDhMYNz+5DYc/olUCIsdn40tL3ZRQ
 WgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fD5CNXXJ6IV6QwGcr0DQoNMC+yJt6vtql/PF9eNeh+0=;
 b=l06yWmXSoTSIXtMazTbmmbLwezxu9UzdFyf8cBFVYeQajo8b/e5GupQe0iwEAD+3u6
 hmqIg22RF6Jkw0KB3ZfGfuZms+78QwsxDoSap+AX0N3Treg4B4QNJPGDobkWOoo9cXtd
 qnKKVIzulZwFRcD8NYU9Yp+Uz/TtBN2Kv1LHJxGin8CbZLYD4hvnfhq5RuRFo292aeP3
 4BU7grnLeX3gAnXotsLCWrAj8j25mOTdujlhSP1RKjA3LHT2nP9J2g6gG8IxGNJDjz0U
 8aMBaXpPM58VMmyOeHlj7cOsaCZ5T7GUhFB79cf6dnEV3A3ipbWHXKhk3wsl4Qj7fXrx
 +/gg==
X-Gm-Message-State: AOAM531sd5F8YS5xmsZOvViaIVlrcMSxHVbCFhcNucY2ukiSKnuiiEgO
 +m6pQzrK1S5a2vPI2APdI4mi/PfyOq73ghuOyx4=
X-Google-Smtp-Source: ABdhPJynaIqBoeZRKa7RW946OMfCOXJ9C/ngjdPAUQf7axFLwuQnpUW7DL/M+PQf9njH254cfEegOhnWt7oxpF8VdvU=
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id
 lk13-20020a0568703e0d00b000d3fe6d57c3mr1844372oab.225.1645728558591; Thu, 24
 Feb 2022 10:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20220224182426.1399145-1-sunpeng.li@amd.com>
In-Reply-To: <20220224182426.1399145-1-sunpeng.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Feb 2022 13:49:07 -0500
Message-ID: <CADnq5_NrgVNoYFQLCKN4Og5F9zwbwGo0_71cz_gFMRC2x_NWvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DC definition of PMFW Pstate table
 for DCN316
To: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Feb 24, 2022 at 1:24 PM <sunpeng.li@amd.com> wrote:
>
> From: Leo Li <sunpeng.li@amd.com>
>
> [Why]
>
> During DC init, we read power management tables from PMFW. This info is
> exchanged in the form of a binary blob inside gpu memory. In order to
> parse the binary blob, the correct struct needs to be used.
>
> [How]
>
> Fix dcn316's definition of the DfPstateTable_t struct to align with PMFW
>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>  .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c    | 11 ++++++++++-
>  .../drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h    |  9 +++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> index 02a59adff90d..c940635b7a74 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> @@ -530,7 +530,16 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
>                 bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
>                 bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
>                 bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
> -               bw_params->clk_table.entries[i].wck_ratio = 1;
> +               switch (clock_table->DfPstateTable[j].WckRatio) {
> +               case WCK_RATIO_1_2:
> +                       bw_params->clk_table.entries[i].wck_ratio = 2;
> +                       break;
> +               case WCK_RATIO_1_4:
> +                       bw_params->clk_table.entries[i].wck_ratio = 4;
> +                       break;
> +               default:
> +                       bw_params->clk_table.entries[i].wck_ratio = 1;
> +               }
>                 temp = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
>                 if (temp)
>                         bw_params->clk_table.entries[i].dcfclk_mhz = temp;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
> index 4c6b202fe622..658b36d0e107 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
> @@ -57,10 +57,19 @@ typedef enum {
>    WM_COUNT,
>  } WM_CLOCK_e;
>
> +typedef enum{
> +  WCK_RATIO_1_1 = 0,  // DDR5, Wck:ck is always 1:1;
> +  WCK_RATIO_1_2,
> +  WCK_RATIO_1_4,
> +  WCK_RATIO_MAX
> +} WCK_RATIO_e;
> +
>  typedef struct {
>    uint32_t FClk;
>    uint32_t MemClk;
>    uint32_t Voltage;
> +  uint8_t  WckRatio;
> +  uint8_t  Spare[3];
>  } DfPstateTable_t;
>
>  //Freq in MHz
> --
> 2.35.1
>
