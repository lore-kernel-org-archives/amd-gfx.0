Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CFAC282DD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 00:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6906120838
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 00:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7alot6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6906120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C83F6E1E2;
	Sat, 11 Jan 2020 00:17:33 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FAD6E1E2
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 00:17:32 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c14so3429193wrn.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 16:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SOhHMjy7jdpfI1DMYloTLgZVUnGgeKv/Vqgziyk6eXM=;
 b=d7alot6oEoRhlxOjMLBtLjjjYjrqNTDRYLUbcpREvaRnqXf+FREesB72vDqa5U/nJf
 MRHzajAz9C4Bmd6J0+NlRHeYsqRDDz3VPfsLH7WxelGR7Hk+CkZlACaWeLCaD4LXuTAj
 3Jwp9dwTiNqj3b+Jltdu2wCznan+Qfk+xxeg8qD8dpB9IRg5nXdK/r4V8cxIpPoQaxkv
 X0miuWjfHUi29kAKpPayo1J/mx/ltWPVjr8pdLBouwFeLHkPY32hayi7r0DKEuS0OGvg
 NYuW7c4a5CaYEeKM+N5cIuBKSDC35xHWQmY0ZOyJJHfysXO+FQ54O0FlbKySV6UCcCAz
 qDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SOhHMjy7jdpfI1DMYloTLgZVUnGgeKv/Vqgziyk6eXM=;
 b=g69VX0msc0qjjvMtkSjDpvpMhbJmZQ6A+XTm6P4qvbEeHdZ3tt/AiXFQbOVCQ+vtLT
 Lr8DQVRgIipz/8INiGUkFrtoQPhE3+qwOnGv/2blbVHFD/7RO42H6s2OKjTj8cfLEUxN
 hA0bIcuobETeN+HOv2CeJdBBRubCjk9oCOl1+p9MGF7e21wPsH2Pmc/p+cvjBKlXMDF6
 4uzp+4oZ/0Pp0LkJy8Jxr3czGxMUtXwDj4ucW4nPxPUOyjhlT2A5LuqaClnWj72gelcF
 yXrVALOZSweTythgeulYe+CtRVDnfMtdJf8U/hDQ5hXWtMF+/NyaOv51dJJEENuqnWhi
 IP9w==
X-Gm-Message-State: APjAAAWwjoGJVcyO4syyMZhw22y33/pv6w/5jS5AzCNhQcl7gRL24gfR
 6wxkdRc58Ikz8myZ6sXfrN4iMctuGsq2glKNugs=
X-Google-Smtp-Source: APXvYqw+qKybwrfVajfQDahIQSXrj+ZLJMSfvl8jxphCdSH2XtSjuAr8/dm/HDmXOdEKzHEFntFAa6/pJPj2HQ91x8k=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr5891985wru.154.1578701850516; 
 Fri, 10 Jan 2020 16:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20200110071616.84891-1-chenzhou10@huawei.com>
 <b86d050a-634e-c99d-1302-29fd6257df1c@amd.com>
In-Reply-To: <b86d050a-634e-c99d-1302-29fd6257df1c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jan 2020 19:17:16 -0500
Message-ID: <CADnq5_OXHwj=acC7SWg9_gBpennTU7Rqa5VKrafJAJYYFnaWzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unnecessary conversion to bool
To: Harry Wentland <hwentlan@amd.com>
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
Cc: Chen Zhou <chenzhou10@huawei.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  thanks!

On Fri, Jan 10, 2020 at 4:41 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2020-01-10 2:16 a.m., Chen Zhou wrote:
> > The conversion to bool is not needed, remove it.
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index 504055f..a004e8e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -2792,7 +2792,7 @@ static bool retrieve_link_cap(struct dc_link *link)
> >                       dpcd_data[DP_TRAINING_AUX_RD_INTERVAL];
> >
> >               link->dpcd_caps.ext_receiver_cap_field_present =
> > -                             aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1 ? true:false;
> > +                             aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1;
> >
> >               if (aux_rd_interval.bits.EXT_RECEIVER_CAP_FIELD_PRESENT == 1) {
> >                       uint8_t ext_cap_data[16];
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
