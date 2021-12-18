Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B2AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 09:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89DB112D6D;
	Mon, 20 Dec 2021 09:02:05 +0000 (UTC)
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE73E10E3D3
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Dec 2021 04:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1639800111; x=1671336111;
 h=mime-version:references:in-reply-to:from:date:message-id:
 subject:to:cc; bh=/VVCqZDQO03dzWiJK64rx87Z42N8S970ztCyWoWKxH0=;
 b=rGVJbuGO89WDPYV8nGxcS2HIHA3G6LRkwUViyggMjjDlPsiaTWchjFMG
 Uj2806nu9NRpxpJzJJvR5jkUl964V1ldRpZO+jBrCs738W3l9SsBbJzut
 j3fQI+cD6h1AqKlmBB5146awIveblKzMutCBLwS5hU/tcn8HqF98sWLCI
 yyPNsA3nAFP5GJM93HWQ1fMPZlh4OVczkDccq3Z00wswapqmCusAtPbx9
 K0Ee6bnMSeC7CX65GYxMCqsD6tr9AUB2EdaQpWWocrjQAD1Y1Ga4LUNmZ
 q9fTJLe39fpODG3FUVs2ciMfpIvUny2+S2+DHk7XPi2v9dJ8r8tg0cT/J A==;
IronPort-SDR: 3AqWR84rSZ3ixHaw0BcwnjnGvrYuyjyCHNSmYrfVQXVAVDZarPc+KuQZs1+9wmQ+npaq112quH
 lPjRnleWyJIOFwuuza008Jtdm9FmbnavSUhbDpfuEGywM7Z1CwLrwzNWIhDp38fLQn1XHLkCZw
 TTlZTg/A8K9u1/vKiajbBnyUiHgJHkLeqMsL41q4BDbvNAlKEUKmEJfVHQYkVlTrDCj/MBcthm
 p9PItMj3HBA2C33ZMM5W/D73/50S3opqmhxiBnAqBotrSDgyiQfNIedakDTGjAMP4QHCpoPsid
 30hairaCps2gpNiH1vH80CJ+
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; d="scan'208";a="95155945"
Received: from mail-yb1-f200.google.com ([209.85.219.200])
 by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Dec 2021 20:01:50 -0800
Received: by mail-yb1-f200.google.com with SMTP id
 q15-20020a252a0f000000b006092c637e21so8767244ybq.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 20:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucr.edu; s=rmail;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8lxy7tam3G965VJ+yVFHi/Lwb6UbeZwM4+7surRJM9Y=;
 b=njHTQAfUCl+25gpnFfB2B2YAaly9Uab9QzuXaxwgaSIcyEY/GJitKzSJMTAn22UAmO
 C7tZ7ebJpzcZUl8AdOcZpu7TrgqqYWdlnEVHpLLfNbL0Jzfmued1MoicQpLyZ2YMPGk8
 RuS2dAgysaUVDknPGc/035cQzjaDpuyGCJo40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8lxy7tam3G965VJ+yVFHi/Lwb6UbeZwM4+7surRJM9Y=;
 b=sY3L2Zjt5zHelXWGOYPwhUZDBERyObWqvGrh1kbI/HNgIk2vJYkt992nDGfmwWwt31
 CY75BUp8ANFwAo32vktFx6NPJ/Xah7pHG8ne6wll3+g0UUjbdGqQjseJ4TlqaOZFYF0O
 Srxbnfdq8WDVThsLOmE0YeMugO64brA8yhY/tZMNpmX+W1KxAZgFOp8ljUN5lqTFGfHC
 FydHrcUAf3/VIUHXPtSJTrRFXFVIkqcyyPzCsjE6jElGHCBzjiv66r2qIwu+vhw6ZdfE
 sseIBT4U8aN2bj1XC7b05+RjymS2HNY0l+f41IlKoq9uKP8x8RucaHWAcqiJK+3HORjj
 N9Ow==
X-Gm-Message-State: AOAM530Mik7bok8w1+xfD2Alis2eR80lZs5YIZ4fKKiRAhyCptkh+DTl
 CVaJJcBJz6WqqIQbcW/uaCLOpnGl3GyyHvQnhRNcCnUWz0sBto5cXDynP4Haf5lCRCARj2x4Qru
 DZJ64h9EvItkg9HvSaOGoGLxL0c7LUDM0MwiCFiwNgyY=
X-Received: by 2002:a25:d188:: with SMTP id i130mr9136798ybg.475.1639800109228; 
 Fri, 17 Dec 2021 20:01:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyb7TYo+RtQKFAc8gUdrgaAtdVg+syE3D6jWsnLVF1eU8K2KyI+1hocLp5CTYT5pHGjaTzbwOyyPUBHKF3R56s=
X-Received: by 2002:a25:d188:: with SMTP id i130mr9136784ybg.475.1639800109031; 
 Fri, 17 Dec 2021 20:01:49 -0800 (PST)
MIME-Version: 1.0
References: <CABvMjLSXpg00KKkqXH35C7Op0xC3mPaOAhj_xbAOEXL_4Ys_aw@mail.gmail.com>
 <52f808a3-7e2d-7ae2-ca62-400137a0b92f@amd.com>
In-Reply-To: <52f808a3-7e2d-7ae2-ca62-400137a0b92f@amd.com>
From: Yizhuo Zhai <yzhai003@ucr.edu>
Date: Fri, 17 Dec 2021 20:01:38 -0800
Message-ID: <CABvMjLRUy40yq76S3qggCmKNKvQ3+njNX5XqgsuGzgp4S=XoEg@mail.gmail.com>
Subject: Re: Potential Bug in drm/amd/display/dc_link
To: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 20 Dec 2021 09:02:04 +0000
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Harry:
Thanks for your feedback, I will submit the patch for variable
"old_downspread" in the function enable_stream_features().
And I double checked the code in the mainline and found that the buggy
function wait_for_training_aux_rd_interval() has been removed, and the
corresponding bug has been fixed in v5.1-rc1 by a memset. Sorry for
the confusion.

On Thu, Dec 9, 2021 at 2:30 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
> On 2021-12-09 03:02, Yizhuo Zhai wrote:
> > Hi All:
> > I just found a bug in the cramfs using the static analysis tool, but
> > not sure if this could happen in reality, could you please advise me
> > here? Thanks for your attention : ) And please ignore the last one
> > with HTML format if you did not filter it out.
> >
> > In function enable_stream_features(), the variable
> > "old_downspread.raw" could be uninitialized if core_link_read_dpcd
> > fails(), however, it is used in the later if statement, and further,
> > core_link_write_dpcd() may write random value, which is potentially
> > unsafe. But this function does not return the error code to the up
> > caller and I got stuck in drafting the patch, could you please advise
> > me here?
> >
>
> Thanks for highlighting this.
>
> Unfortunately we frequently ignore DPCD error codes.
>
> In this case I would do a memset as shown below.
>
> > The related code:
> > static void enable_stream_features(struct pipe_ctx *pipe_ctx)
> > {
> >      union down_spread_ctrl old_downspread;
>
>         memset(&old_downspread, 0, sizeof(old_downspread));
>
> >     core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
> >                          &old_downspread.raw, sizeof(old_downspread);
> >
> >         //old_downspread.raw used here
> >         if (new_downspread.raw != old_downspread.raw) {
> >                core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
> >                          &new_downspread.raw, sizeof(new_downspread));
> >         }
> > }
> > enum dc_status core_link_read_dpcd(
> >     struct dc_link *link,
> >     uint32_t address,
> >     uint8_t *data,
> >     uint32_t size)
> > {
> >         //data could be uninitialized if the helpers fails and log
> > some error info
> >         if (!dm_helpers_dp_read_dpcd(link->ctx,
> >                link,address, data, size))
> >                       return DC_ERROR_UNEXPECTED;
> >         return DC_OK;
> > }
> >
> > The same issue in function wait_for_training_aux_rd_interval() in
> > drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>
> I don't see this. Do you mean this one?
>
> > void dp_wait_for_training_aux_rd_interval(
> >       struct dc_link *link,
> >       uint32_t wait_in_micro_secs)
> > {
> > #if defined(CONFIG_DRM_AMD_DC_DCN)
> >       if (wait_in_micro_secs > 16000)
> >               msleep(wait_in_micro_secs/1000);
> >       else
> >               udelay(wait_in_micro_secs);
> > #else
> >       udelay(wait_in_micro_secs);
> > #endif
> >
> >       DC_LOG_HW_LINK_TRAINING("%s:\n wait = %d\n",
> >               __func__,
> >               wait_in_micro_secs);
> > }
>
> Thanks,
> Harry
>
> >
>
>
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
