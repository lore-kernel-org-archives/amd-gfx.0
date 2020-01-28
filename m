Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D75C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B507D206F0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWbpUCO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B507D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8366B6F3D0;
	Tue, 28 Jan 2020 20:06:59 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1866F3D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 20:06:58 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id q10so17548742wrm.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 12:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ltSpWV1yssv6hNb4e+9KU4xxjjZatpnzWIhkoY4+P54=;
 b=fWbpUCO5642UKWQLnw/wNljkI/PsGkc1843RFikhPqJwTMaa+SY1Sgp7CNPVPz0NWf
 UXH9m/+TjAWxIBSLVi+txbHZuF6OjRko56wn3nK9imLfYGn9qtr9m2EwGI7B5c+9SAzM
 TXEyOfMSCrucr7hXvtRIWMTzRF0c/SIAOIVg4UwBRHUrYKbdji5w4Oga+i+tD0+bO62T
 F4IzenJQmSMYDgt9Kyc9SHjravh4PkhMqKhQPZhVcLD/yjdMSPjxMe5HKOEbbmzBnUVC
 05VcQt8IXoxxWDM8+6fifSXdGwutwB3DcVHyw1aH4IbcXU9t51c7YN4Rk+43W1m+Xmv2
 IkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ltSpWV1yssv6hNb4e+9KU4xxjjZatpnzWIhkoY4+P54=;
 b=YFcoGHTy5frz9T054fvUrG2B8S46Zf4LrSvxeYP1dBVjiuSGqu2to/IPINUVJHjQEV
 MrB6++Z5aSWvr7SARbSodbGb2GuqELEWa2jXnRae8V/rdFpd6mHwNXl/rDDf1DIxp1xS
 iFPr0NGFgSN5RUmqmdjt66cK1n6lUhwbjLuRhqz0irulKehFow1P7mClZazVWFPFbrhL
 apSxQn97kyjWjqhIxeXqrSSYKpH/eCjVQepG1aAV/b4SnahJmtGjukggdODa+RCpdyes
 MDGWqGelr+gKkmh2K0fDG90eaS+vKYvTZcuRJCR6OvNU/g0ccYcQWDXecHOFvXjLshLW
 Nycw==
X-Gm-Message-State: APjAAAW/Ke/S+1AckEFnxInSQL4Mu5GGPf8jhcmxieVNA/yx+vvmOryV
 oq0UJthx3+uy+T9N4XngZ1McV3wjeWlI1nx568g=
X-Google-Smtp-Source: APXvYqxFwLGfSzaSKLL1z9B6WyQOepLDMG/fi/yI5TB8ZCm1pwLZicByAOtuUbPRIc2he300qs9CAtAEBbx2FQpSacc=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr29905248wrp.111.1580242017155; 
 Tue, 28 Jan 2020 12:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20200125184845.4233-1-alexander.deucher@amd.com>
 <20200125184845.4233-3-alexander.deucher@amd.com>
 <f51f32b5-9a08-bb30-66e9-52bddb8f469c@gmail.com>
 <CADnq5_NUjjtf_kSut0doWRoRUOqi-OrN=M8=3=sf3JoYiCuuwA@mail.gmail.com>
 <f63fecc3-fd56-55cb-4bcf-178ead1628d6@gmail.com>
In-Reply-To: <f63fecc3-fd56-55cb-4bcf-178ead1628d6@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2020 15:06:45 -0500
Message-ID: <CADnq5_NwWFZaO2cMxqqvv4btkiU9PUwFHzBG6RqXD74bdjaV0g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/navi10: add OD support for restoring
 default table
To: Matt Coffin <mcoffin13@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 28, 2020 at 1:49 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
>
>
> On 1/28/20 10:26 AM, Alex Deucher wrote:
> > On Tue, Jan 28, 2020 at 11:44 AM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> > I just copied that vega20 did.  You may be right.  I haven't paged the
> > recent SMU interface stuff into my head in a while.  If so, we should
> > also fix the vega20_ppt.c code.
>
> The vega20_ppt code was correct, until we implemented the ability for
> the user to write to that overdrive table, which will land in 5.5.
>
> Not entirely sure about the canonical way to distribute changes to
> someone else's series, but I can take a crack at fixing this.
>

Thanks.  Just go ahead and send patches.

Alex


> >>
> >> On 1/25/20 11:48 AM, Alex Deucher wrote:
> >>> Was missing before.
> >>>
> >>> Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> >>> index d2d45181ae23..f60762f9b143 100644
> >>> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> >>> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> >>> @@ -2062,6 +2062,14 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
> >>>               if (ret)
> >>>                       return ret;
> >>>               od_table->UclkFmax = input[1];
> >>> +             break;
> >>> +     case PP_OD_RESTORE_DEFAULT_TABLE:
> >>> +             ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
> >>> +             if (ret) {
> >>> +                     pr_err("Failed to export over drive table!\n");
> >>> +                     return ret;
> >>> +             }
> >>> +
> >>>               break;
> >>>       case PP_OD_COMMIT_DPM_TABLE:
> >>>               navi10_dump_od_table(od_table);
> >>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
