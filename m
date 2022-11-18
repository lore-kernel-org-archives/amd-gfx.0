Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35521C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 20:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B903F10E7C7;
	Fri, 18 Nov 2022 20:12:51 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF4210E7C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 20:12:50 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id b124so6529107oia.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dEwXcfV+IM5e3f2vpVaga+CjFFdG1DHalyNIM+YmWHc=;
 b=cNmVAiZTaVhgGoLp7W7WDDKMjSHeMWBtvXl3All51hSRKhAwOusEB5aZiy5xJTb1jC
 KT6ZYoS/Zsydlly4hmzDTt4WlcsYYPDDYeEvNkmstUy56XBkr7s0UCQHySUi+EXc1Xxn
 Jvlbe01/HFLKCip+JQHxfKtKDCg9zgPiUmMcOYXnpmuYQvKrDirGlnk4wqqsAcn5JvDd
 ye7c4nLtD2uWJLXyuAhcMWzzUS7HRh9WZIscCOyf/85daBVM2VdYXOnmN40SbglsvR6N
 TIclL5B1ELwCDyifsQ9CsaXWYZFYltFi2p2hZ2ueGP+5Qpi7mAdNJgUeqb4ghzNhTP5a
 6zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEwXcfV+IM5e3f2vpVaga+CjFFdG1DHalyNIM+YmWHc=;
 b=2PDObOJh5FRBOFOLRxq0XDtVKRhJRg1gn7U81+0XL0mXV5V2KBt2r5242/g2oOhWBi
 zU8r8XbF1m9vpL/TMbEpkVWoshjufTOJBxhr2Rkjb+Oh96dSA8UpJZRunLihceVRrLqr
 W+tufU7jzQ4v257EHfw+JiOFSMMBm2TCH2cf7LbXfGJslwwxjLdhZeXN4kh8Y6N8xsSh
 Qn4m3vqk9zjpC3SH5xJ+ZXJ1zh4dGK4j14vFYxByiEtROl2Z9hr4pnccCmKrEVtr98mh
 97lqHlI/6MGzMFjQDExD2Bci9ttLuTpzfiQrATvDv1sTA+h5b7i1fQA0MUrd2CPfalk5
 geZA==
X-Gm-Message-State: ANoB5pkHVSMoeo9vW6poZzynG11jleR3pIEcJj33p1VGwKxRPXmAkXCU
 BZTzUHTSaHY09RD6wNNOMiDCdsJkaBZH5vRWMlqBMp9bbvk=
X-Google-Smtp-Source: AA0mqf6rtbp1zr7w+fAJYnThBXRzkLp9vFEF0vuaTEcyF4+JiKRFmk8a613GGy7S5ehkELflqDVaO8kbOQuBJzswJ+s=
X-Received: by 2002:a05:6808:9b8:b0:34f:97ea:14d with SMTP id
 e24-20020a05680809b800b0034f97ea014dmr4400017oig.96.1668802369810; Fri, 18
 Nov 2022 12:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
 <20221118125935.4013669-23-Brian.Chang@amd.com>
In-Reply-To: <20221118125935.4013669-23-Brian.Chang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Nov 2022 15:12:38 -0500
Message-ID: <CADnq5_NuC1imDa9kRdr2fKY3HFdC7huMNhnW4_SB0FNs=JEyqA@mail.gmail.com>
Subject: Re: [PATCH 22/22] SWDEV-1 - dc: 3.2.213
To: brichang <Brian.Chang@amd.com>
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please fix the subject.  E.g., drm/amd/display: dc: 3.2.213
or something like that.

On Fri, Nov 18, 2022 at 12:02 PM brichang <Brian.Chang@amd.com> wrote:
>
> From: Aric Cyr <Aric.Cyr@amd.com>
>
> Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
>
> This version brings along following fixes:
> -Add configuration 2 for ABM 2.3/2.4.
> -Add margin for HUBP for SubVp + DRR.
> -Fix no display after resume from WB/CB.
> -Limit HW cursor size to be less than 64 x 64 bytes when the stream is >= 4K.
> -Lower watermarks for enter/enter+exit latency.
> -Update support types for DCN314 to include z8 only and z8_z10 only state.
> -Add new value for soc bounding box and dummy pstate.
> -Override fclk chang latency when calculating prefetch schedule for subvp with low uclk.
> -Add check for DET fetch latency for dcn32.
> -Add check if PSR enabled when entering MALL.
> -Use base MALL allocation size calculations off vewport height.
> -Add YCBCR2020 to CSC matrix.
> -Implement DP-Tx portion to interact with DPIA.
> -Add debug option for increasing phantom lines.
> -Fix phantom plane/stream retain after fail validation.
> -Fix display corruption with VSR enable.
> -Set valid divider value for virtual and FRL/DP2.
> -Add new num clk levels struct for max mclk index.
> -Fix check for phantom BPP.
> -Fix rotated cursor offset calculation.
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index e827cee94e5e..feb7a7f2734e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -47,7 +47,7 @@ struct aux_payload;
>  struct set_config_cmd_payload;
>  struct dmub_notification;
>
> -#define DC_VER "3.2.212"
> +#define DC_VER "3.2.213"
>
>  #define MAX_SURFACES 3
>  #define MAX_PLANES 6
> --
> 2.25.1
>
