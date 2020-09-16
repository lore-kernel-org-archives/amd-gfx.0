Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89325C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 22:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3726720708
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 22:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqAyQs4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3726720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99696E0D6;
	Wed, 16 Sep 2020 22:18:32 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A77506E0D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 22:18:31 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id o5so8372714wrn.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T/dIEKiDyHvLMD8N+CHiZ4X8JOYTPeAu/fU0ekhRvyc=;
 b=TqAyQs4HbrrHCBxNO8Joj9GTFvpg6ZB050S9ntYcDtA6xiE0I/Gb4TI47CnSRtRLG9
 /7g73IfRHV9G0KvtRsGpxIOTqkR4xAZJxDMkGBahVRpGGA+VwnkuA68zWmZOOogdqaXM
 nrKivnDn00+iUvDgM7SK16wmF2M4h6wv4bm3nQoHIkm/uukIMuVAdJyBilo2aLeBGsNW
 rP5qOd7mt3e/fWOQZOUKdSi8BKhooyIuPO0LplpLPhsxZZn5y2Cu2VOa8yxAJ89QziPB
 yMtsS5JgtwB7LArfvaJ8xc2yaZUpRbKV30ylmBT07b3ENQ6+jeC5Gb6vz4yX4Q/YbD2q
 A6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T/dIEKiDyHvLMD8N+CHiZ4X8JOYTPeAu/fU0ekhRvyc=;
 b=OX2Rw73CwEuUMdzJivRpmT/9ch+GbbL2VkX+9SZJ0Ep+liYxWQ+Pf9PNOWP5bAgolX
 BetMRZk1bPt3gUHAnSC2bn1+HmrC0qlnT5M1J1UXOoBObxQLj1FATuXoDOj33mnA0fER
 8w1qhDQMUH1HxtQon2RVPRbAzSH6MLeT/wUErw9Se69TCUiboSviz5B0EQMKBxjFDbEk
 9Wvj/OepNoBv/Nqg3AIIXd1bbtyyQ6X0lSF9eBtC9Coe2RbS1vkJn+Cgyc0d/hJBs5dR
 f8vwUocsSG/wpaR5q3tkfbJQXKb3Vgt6flYugZf/zeXN79R3KfBdB0U75izRztuADjhF
 55dQ==
X-Gm-Message-State: AOAM530NtGb6WSIwVow5OVAmXpeJ7AgE/TotagnBGJp8ApyMkXz0PKuz
 c/P2uhGNn/UVnmX154cY6+mTTwe7CERbToGtDM4=
X-Google-Smtp-Source: ABdhPJx3OC2xbEmXDaf+vHD+K8HYyh/BqtZpbGiu6BJF2sbEccU4/eLk3HmTn+gqNp8nt+DVljUV2gq9C2l0ToTO6jM=
X-Received: by 2002:adf:f290:: with SMTP id k16mr30759820wro.124.1600294710299; 
 Wed, 16 Sep 2020 15:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
 <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2020 18:18:19 -0400
Message-ID: <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
Subject: Re: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
To: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
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
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jinlong" <Jinlong.Zhang@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 16, 2020 at 6:16 PM Zhuo, Qingqing <Qingqing.Zhuo@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> On Wed, Sep 16, 2020 at 3:42 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
> >
> > From: jinlong zhang <jinlong.zhang@amd.com>
> >
> > [why]
> > while read edid return defer, then it enter to msleep, but it actually
> > took more time during msleep, this will cause remaining edid read
> > fail.
> >
> > [how]
> > Replacing msleep with udelay, it will not take any extra time, edid return pass finally.
>
> How long of a delay are we talking about here?  Some platforms don't support long udelays and someone will send a patch to change this to msleep.
>
> Alex
>
> ---------------------
>
> Hi Alex,
>
> It's between 0-5ms for generic cases, though there exist some dongle workaround cases where we will do 70ms. Would this be a concern?

I think ARM has a limit of 2ms for udelay.

Alex

>
> Thank you,
> Lillian
>
>
> >
> > Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
> > Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> > Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > index 743042d5905a..cdcad82765e0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > @@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
> >                                         if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
> >                                                 (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
> >                                                 if (payload->defer_delay > 0)
> > -                                                       msleep(payload->defer_delay);
> > +
> > + udelay(payload->defer_delay * 1000);
> >                                         }
> >                                 }
> >                                 break;
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cqi
> > ngqing.zhuo%40amd.com%7C36c3bee68c28448769fa08d85a884619%7C3dd8961fe48
> > 84e608e11a82d994e183d%7C0%7C0%7C637358888627498307&amp;sdata=mynpHpiup
> > J%2FU2o5gZNW%2Bft%2Fg2beFY86%2BzMRWoTZCghQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
