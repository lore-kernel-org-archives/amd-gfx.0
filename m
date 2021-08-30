Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100D1C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 12:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD56460F35
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 12:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD56460F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6982689C28;
	Mon, 30 Aug 2021 12:49:14 +0000 (UTC)
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
 by gabe.freedesktop.org (Postfix) with ESMTP id A00D289C13;
 Mon, 30 Aug 2021 12:44:47 +0000 (UTC)
Received: from BC-Mail-Ex20.internal.baidu.com (unknown [172.31.51.14])
 by Forcepoint Email with ESMTPS id 5C67E7A2F02511BA12F8;
 Mon, 30 Aug 2021 20:44:45 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex20.internal.baidu.com (172.31.51.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Mon, 30 Aug 2021 20:44:45 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 30
 Aug 2021 20:44:44 +0800
Date: Mon, 30 Aug 2021 20:44:44 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/radeon: Make use of the helper macro
 SET_RUNTIME_PM_OPS()
Message-ID: <20210830124444.GA173@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210828085052.756-1-caihuoqing@baidu.com>
 <CADnq5_Oxs=BF+0v0-ZYQGVoBt-eE8zNXRcG4wWEP=1Wc=imPOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADnq5_Oxs=BF+0v0-ZYQGVoBt-eE8zNXRcG4wWEP=1Wc=imPOw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Mailman-Approved-At: Mon, 30 Aug 2021 12:49:13 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 30 Aug 21 08:21:52, Alex Deucher wrote:
> On Sat, Aug 28, 2021 at 4:51 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
> >
> > Use the helper macro SET_RUNTIME_PM_OPS() instead of the verbose
> > operators ".runtime_suspend/.runtime_resume/.runtime_idle", because
> > the SET_RUNTIME_PM_OPS() is a nice helper macro that could be brought
> > in to make code a little clearer, a little more concise.
> 
> I don't personally think it really helps readability.  Just seems to
> be code churn.
> 
> Alex
>
agree, just code churn, the macro seems to do it.

Cai
> 
> >
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> >  drivers/gpu/drm/radeon/radeon_drv.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> > index b74cebca1f89..c2eb725e87f6 100644
> > --- a/drivers/gpu/drm/radeon/radeon_drv.c
> > +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> > @@ -529,15 +529,14 @@ static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigne
> >  #endif
> >
> >  static const struct dev_pm_ops radeon_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(radeon_pmops_runtime_suspend,
> > +                          radeon_pmops_runtime_resume, radeon_pmops_runtime_idle)
> >         .suspend = radeon_pmops_suspend,
> >         .resume = radeon_pmops_resume,
> >         .freeze = radeon_pmops_freeze,
> >         .thaw = radeon_pmops_thaw,
> >         .poweroff = radeon_pmops_freeze,
> >         .restore = radeon_pmops_resume,
> > -       .runtime_suspend = radeon_pmops_runtime_suspend,
> > -       .runtime_resume = radeon_pmops_runtime_resume,
> > -       .runtime_idle = radeon_pmops_runtime_idle,
> >  };
> >
> >  static const struct file_operations radeon_driver_kms_fops = {
> > --
> > 2.25.1
> >
