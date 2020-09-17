Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61578C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 14:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1C620708
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 14:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quXV/oyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1C620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9036EC3C;
	Thu, 17 Sep 2020 14:47:10 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A2D76EC3C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 14:47:09 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id k15so2373780wrn.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7pWxolr3pIXAXd/aWI84OJKmdEFw1IDEG2WdYqMJqMA=;
 b=quXV/oyOfnABsvp9BLhY8mTy7JK21Zjw5q2VtfEA0vDaNHoleYaCDUP3f1XcmUjawN
 3T2E7odi534RVMe0tdVVrx8zmrgJAKbxWzANRmoeG+fy5km7RLKiEuDsKklkXjt6nl+a
 N90LyM5OPLsiMYNGF0EnqzBMvTFQBELyYRwypw1VaomZNTC5guRQFmesUsUC7eG7RffM
 7nmhsND6Eve18qTRRC+GXYg/A6ijmNUxXz8tizWq0hQ7SFTDfqLsI9IJC02mMGe50K7r
 Jykn/LzNgzfWIudofCMmT8CYvJqUvA89ftZMw+yIR0wFo6Lla4CzCuKPN3yB9IrDi52h
 f2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7pWxolr3pIXAXd/aWI84OJKmdEFw1IDEG2WdYqMJqMA=;
 b=gQ49aQtJdsu3tdsLhosMVe6f9ra1bI62dwBA3f7k5Re8WGPvl24xMl6gb8+mcSR+bl
 YvG280Dwx4DazIHaoxHDvmik1m9jINc6/8diU0YkYHfl4w6xkPfg9XMemgeOmeYK6hK8
 LRxX/4FSvY1Gztyt5U7eWz3D5VTRBKxEfPxPZJ/DPBZ3VvOXJDUxnYSKRbMIKIGtCpYi
 uiv29ZUVbncFj/bLOm0bTS/InXLIGlGxKrJ3qhwq72wtAKulE8tRYyzLWTnvF7IHomlC
 TlPqWzAsRC8tp+0mifh39xyaPSoqFskw1fsN2Rkb+8WJhNqkgQmy57GaqwqHNGx1eHJK
 3Ypg==
X-Gm-Message-State: AOAM532RzBNk6bEYWkO7GHYh938DNBPsZuTdji5+gb/Y4o2iA3IyCI+F
 t+RzGy5+HWThX0L7J6ykYw2sio/WugnsIJJ8FRrsTvV/laE=
X-Google-Smtp-Source: ABdhPJxXDkN43Oio1Yb/iGgYO7z7LVNngd+1EeJq4U50Rd0vHvoCyY2T4NnNCvfuQWCH1o/HNnvg692SJHv9a5JCBiA=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr32267184wro.362.1600354027937; 
 Thu, 17 Sep 2020 07:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
 <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
 <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
 <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
 <DM5PR12MB1884C1E88327D7E903BC851CFB3E0@DM5PR12MB1884.namprd12.prod.outlook.com>
 <DM6PR12MB2762F8ED3915C76E3915A688EE3E0@DM6PR12MB2762.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2762F8ED3915C76E3915A688EE3E0@DM6PR12MB2762.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Sep 2020 10:46:56 -0400
Message-ID: <CADnq5_MbFKvVc=qUWQd5Fy9O36PZMYJ0dSu6aQx8Mdohuv14kw@mail.gmail.com>
Subject: Re: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
To: "Zhang, Jinlong" <Jinlong.Zhang@amd.com>
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 17, 2020 at 10:39 AM Zhang, Jinlong <Jinlong.Zhang@amd.com> wrote:
>
> HI Christian
> While #include <linux/delay.h>, it prompt ..\..\..\..\..\dc\dce\dce_aux.c(31): fatal error C1083: Cannot open include file: 'linux/delay.h': No such file or directory
> Could you help to check how to include the header of void usleep_range(unsigned long min, unsigned long max);

That should do it.  DC code has #include <linux/delay.h> in a bunch of
other files.

Alex

>
> -----Original Message-----
> From: Zhuo, Qingqing <Qingqing.Zhuo@amd.com>
> Sent: Thursday, September 17, 2020 9:02 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Jinlong <Jinlong.Zhang@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> Subject: RE: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while read edid return defer.
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Am 17.09.20 um 00:18 schrieb Alex Deucher:
> >> On Wed, Sep 16, 2020 at 6:16 PM Zhuo, Qingqing <Qingqing.Zhuo@amd.com> wrote:
> >>> [AMD Official Use Only - Internal Distribution Only]
> >>>
> >>>On Wed, Sep 16, 2020 at 3:42 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
> >>>> From: jinlong zhang <jinlong.zhang@amd.com>
> >>>>
> >>> >[why]
> >>>>while read edid return defer, then it enter to msleep, but it
> >>>>actually took more time during msleep, this will cause remaining
> >>>>edid read fail.
> >>>>
> >>>> [how]
> >>>> Replacing msleep with udelay, it will not take any extra time, edid return pass finally.
> >>> How long of a delay are we talking about here?  Some platforms don't support long udelays and someone will send a patch to change this to msleep.
> >>>
> >>> Alex
> >>>
> >>> ---------------------
> >>>
> >>> Hi Alex,
> >>>
> >>> It's between 0-5ms for generic cases, though there exist some dongle workaround cases where we will do 70ms. Would this be a concern?
> >> I think ARM has a limit of 2ms for udelay.
>
> > Yeah, there is even a define somewhere for this.
>
> > If you need a delay which is longer than this but still more precise than msleep() then there is the high precision timer sleep as alternative.
>
> > I've forgotten the function name to use here, but there was a LWN article about this a few years ago. You just need to google a bit.
>
> Hi Alex and Christian,
>
> Thanks a lot for the input! Given what's been discussed, I will drop this patch for now.
>
> Regards,
> Lillian
>
> >
> > Regards,
> > Christian.
> >>
> >> Alex
> >>
> >>> Thank you,
> >>> Lillian
> >>>
> >>>
> >>>> Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
> >>>> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> >>>> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> >>>> ---
> >>>> drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
> >>>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> >>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> >>>> index 743042d5905a..cdcad82765e0 100644
> >>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> >>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> >>>> @@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
> >>>>                                          if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
> >>>>                                                  (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
> >>>>                                                  if (payload->defer_delay > 0)
> >>>> -                                                       msleep(payload->defer_delay);
> >>>> +
> >>>> + udelay(payload->defer_delay * 1000);
> >>>>                                          }
> >>>>                                  }
> >>>>                                  break;
> >>>> --
> >>>> 2.17.1
> >>>>
> >>>> _______________________________________________
> >>>> amd-gfx mailing list
> >>>> amd-gfx@lists.freedesktop.org
> >>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> >>>> i
> >>>> st
> >>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7
> >>>> C
> >>>> qi
> >>>> ngqing.zhuo%40amd.com%7C36c3bee68c28448769fa08d85a884619%7C3dd8961f
> >>>> e
> >>>> 48
> >>>> 84e608e11a82d994e183d%7C0%7C0%7C637358888627498307&amp;sdata=mynpHp
> >>>> i
> >>>> up
> >>>> J%2FU2o5gZNW%2Bft%2Fg2beFY86%2BzMRWoTZCghQ%3D&amp;reserved=0
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
> >> t
> >> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CQ
> >> i
> >> ngqing.Zhuo%40amd.com%7Cd4acd0d5e65c49a7270f08d85ae37036%7C3dd8961fe4
> >> 8
> >> 84e608e11a82d994e183d%7C0%7C0%7C637359280197936127&amp;sdata=ahcoCqG9
> >> 1
> >> EDMNlHNSk4Eimh1azMtRWSX%2BKyHCdpFq1Q%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
