Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47032C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 19:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D9520730
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 19:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tm7U5PG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D9520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4A26E9ED;
	Wed,  5 Feb 2020 19:43:25 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E3A6E9ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 19:43:24 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t23so3800549wmi.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2020 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SO/yJ+CxLWdlzSzvECpxjBgfng5aHRexC/OIl5nXatw=;
 b=tm7U5PG9ZNs1PTr3+vNBvUgYP4V0OtlInjm+sLI/Sr6Ukigb0rL6F+GaQUGq/ks5PS
 GTn/fP42y4UwRlKwUZlF+NE5X7sPsUThZQPxZehITfD2VjPj7Zgw+aL/vWij/LQl1UTl
 JBNt8UqxE1rwRT6R8qsa1qyNymJbiAF8TpD1ygafl6ur8ERSU8aLL8Le4LT2ztiZOQZ5
 dbft7c8yd9oDos1kRI0b6ZYVEK9xZ79UVhXmEYmrJB0SIvFddrsYW9K7W0d51Bmk2AxH
 iIbSCRotAZOl8DupPIpOqOUaIVPf3SHir7phZlNleBFk6opILxXMPznlXwILLEcuaHSH
 IhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SO/yJ+CxLWdlzSzvECpxjBgfng5aHRexC/OIl5nXatw=;
 b=JyJLGSJ+iyvMcX/t8YDkHKp/MZFuhJgclWWmgmI6jGIcZAH+qyvXANX7h91aJ3vlrn
 EgqgP3ZAYT5zDSbGSuxATHc2xDbD0OCnisV2djLiOO17tg7HCwoSfxwLQ3oJ7hcPI90/
 kRqps7DnBDUDE+jS1PZVVZ4j4/4l/j82+/RkYPrq9tYDSUic+6rDtG5OBd/B9DpAWvOP
 bAPN16wQMov4NLoyLVjkoaw7ddYp2wyaswk9WWZKyZVdRzMR9Ntb6WmHQhJwZx+akuOH
 pK/c/WEuqFq+yHiqAlIhg3YhPocWBXxIjhK4Fj12WrGucGeJrYEw8C5HH+owML3n3bhw
 VgVA==
X-Gm-Message-State: APjAAAWUO8cUEeXd6aCgeCn7ejiInUL08nLh3gYGL90ZzXT+2+xqCIBm
 wh+EUgF7Kdv1tbOwMxwj/BODn/bG+zgP+vBynII=
X-Google-Smtp-Source: APXvYqxIxtXoHtTYG5ylAB7gXVxDFgOzGgFWCRiAV4cXnT5LMYKpT5GVtyZfz4DAD2Mcg/SZ2SQEnZ6vugyLxxJn784=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr7326145wmb.73.1580931803092;
 Wed, 05 Feb 2020 11:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20200205183714.6t5c7ewyovwjicm6@kili.mountain>
 <b9a18739-cada-05e8-d894-be8dcba9fb43@amd.com>
In-Reply-To: <b9a18739-cada-05e8-d894-be8dcba9fb43@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Feb 2020 14:43:11 -0500
Message-ID: <CADnq5_PF2ofuZM9NNeDoWHo-atHQd=ExcWNFDg9yCC9R4v9Tuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix some use after free bugs
To: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Zhan Liu <zhan.liu@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 zhengbin <zhengbin13@huawei.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Feb 5, 2020 at 1:44 PM Bhawanpreet Lakha
<Bhawanpreet.lakha@amd.com> wrote:
>
> Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>
> On 2020-02-05 1:38 p.m., Dan Carpenter wrote:
> > These frees need to be re-ordered so that we don't dereference "hdcp_work"
> > right after it's freed.  Also in hdcp_create_workqueue() there is a
> > problem that "hdcp_work" can be NULL if the allocation fails so it would
> > lead to a NULL dereference in the cleanup code.
> >
> > Fixes: 9aeb8a134a0a ("drm/amd/display: Add sysfs interface for set/get srm")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> > index 1768a33b1dc3..f3330df782a4 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> > @@ -380,9 +380,9 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
> >               cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
> >       }
> >
> > -     kfree(hdcp_work);
> >       kfree(hdcp_work->srm);
> >       kfree(hdcp_work->srm_temp);
> > +     kfree(hdcp_work);
> >   }
> >
> >   static void update_config(void *handle, struct cp_psp_stream_config *config)
> > @@ -555,11 +555,12 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
> >   {
> >
> >       int max_caps = dc->caps.max_links;
> > -     struct hdcp_workqueue *hdcp_work = kzalloc(max_caps*sizeof(*hdcp_work), GFP_KERNEL);
> > +     struct hdcp_workqueue *hdcp_work;
> >       int i = 0;
> >
> > +     hdcp_work = kcalloc(max_caps, sizeof(*hdcp_work), GFP_KERNEL);
> >       if (hdcp_work == NULL)
> > -             goto fail_alloc_context;
> > +             return NULL;
> >
> >       hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm), GFP_KERNEL);
> >
> > @@ -602,9 +603,9 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
> >       return hdcp_work;
> >
> >   fail_alloc_context:
> > -     kfree(hdcp_work);
> >       kfree(hdcp_work->srm);
> >       kfree(hdcp_work->srm_temp);
> > +     kfree(hdcp_work);
> >
> >       return NULL;
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
