Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728DC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E0520650
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6o/1vaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E0520650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F5E6EAB2;
	Thu, 12 Mar 2020 14:26:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5E36E207;
 Thu, 12 Mar 2020 14:26:05 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id v11so7730433wrm.9;
 Thu, 12 Mar 2020 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mran/SsFtCnhLMe88te8B5pjViLrFrhLBnL1J+NQyAQ=;
 b=n6o/1vazmKVd0JhI9n5ImHQjrTOPjoCP1UqJo1Oc61DcJUs9+3uf4dSbLtcev9basP
 CzN2bRt1m+tQu/pgVIjzqk8eGppzEomULwwr9lkYzK3790AbN9p8QXkk0GdzrU05FcW4
 OjIBe7J+jRR8eA81WIT+q/GEcz+rVVLeq+Hj2a2S1hwjTzFWmgzXYCFpFCABsxyxfN7V
 T5fbBXRg3X0+51IYEn0LMWLCDtnkmnVMPBjAmfZJTXiDOhAiETX8UErhfHXVBD0skffY
 1Ln9CWLeabdkpqs+HyDvz2lFtBlmABXZhekAJ8xeFZ/s3adfJba6DZV/IrFrnfpTy3He
 xumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mran/SsFtCnhLMe88te8B5pjViLrFrhLBnL1J+NQyAQ=;
 b=TfxujPcrdfJUaYchDpUkkbDzZHmtQ4u8arWEMq9oYm08rrlTLo8Z3RYgNus49i9wpc
 8UOFtmWz3OuqU+uz2rRO90qXMVXDBFHaEyLdP+acjk2ggf78erYuZYx87VEcNrPtwxHm
 isHr5mCdVBaqLzdbMDy5WyD/vj8W2o+awik+ZjB/d5B4404GHwgbvBHSoFzEzK5ntZe9
 CJhM0ORkiNaQrIXoxtyI3KXO3ecdQkToZGV6Md1VHdlYpxxNNUhXJkxfYcOrIoUvnbk+
 cSZ21JyPYXtVEOz2q/li6pf4GbuYsfyhsQW1FjSk+WnyLe2VypgcISI2CdNXFYn7B30T
 Im4w==
X-Gm-Message-State: ANhLgQ0tC1mmDlx/0e5ntqHlvhnkrgW4fNyzVJehpX+jRseOk+O1LVW+
 2utkBReAV05GlTFeKMRyZsqKJbrHbsIg37GwMvk=
X-Google-Smtp-Source: ADFU+vuPb4lfUTKhpuKO6jLNj/1rsc2hVZhSeBBJVuHW3b9CdxlrbDf2pG80FVmy9+xL9+RFg6RpLt4xGyZ5+pCMLDk=
X-Received: by 2002:adf:c5c8:: with SMTP id v8mr6984934wrg.111.1584023164466; 
 Thu, 12 Mar 2020 07:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200131045739.ault4d6yk2lqlbed@kili.mountain>
In-Reply-To: <20200131045739.ault4d6yk2lqlbed@kili.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Mar 2020 10:25:52 -0400
Message-ID: <CADnq5_POLvoLi=1TprgH7jFn3TAJw37_P+1-VngxWtYTi1xmoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Possible divide by zero in set_speed()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Derek Lai <Derek.Lai@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jan 30, 2020 at 11:58 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> If "speed" is zero then we use it as a divisor to find "prescale".  It's
> better to move the check for zero to the very start of the function.
>
> Fixes: 9eeec26a1339 ("drm/amd/display: Refine i2c frequency calculating sequence")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> index 066188ba7949..24adec407972 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> @@ -267,6 +267,9 @@ static void set_speed(
>         uint32_t xtal_ref_div = 0;
>         uint32_t prescale = 0;
>
> +       if (speed == 0)
> +               return;
> +
>         REG_GET(MICROSECOND_TIME_BASE_DIV, XTAL_REF_DIV, &xtal_ref_div);
>
>         if (xtal_ref_div == 0)
> @@ -274,17 +277,15 @@ static void set_speed(
>
>         prescale = ((dce_i2c_hw->reference_frequency * 2) / xtal_ref_div) / speed;
>
> -       if (speed) {
> -               if (dce_i2c_hw->masks->DC_I2C_DDC1_START_STOP_TIMING_CNTL)
> -                       REG_UPDATE_N(SPEED, 3,
> -                                    FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE), prescale,
> -                                    FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD), 2,
> -                                    FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_START_STOP_TIMING_CNTL), speed > 50 ? 2:1);
> -               else
> -                       REG_UPDATE_N(SPEED, 2,
> -                                    FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE), prescale,
> -                                    FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD), 2);
> -       }
> +       if (dce_i2c_hw->masks->DC_I2C_DDC1_START_STOP_TIMING_CNTL)
> +               REG_UPDATE_N(SPEED, 3,
> +                            FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE), prescale,
> +                            FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD), 2,
> +                            FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_START_STOP_TIMING_CNTL), speed > 50 ? 2:1);
> +       else
> +               REG_UPDATE_N(SPEED, 2,
> +                            FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE), prescale,
> +                            FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD), 2);
>  }
>
>  static bool setup_engine(
> --
> 2.11.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
