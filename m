Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FF6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 01:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C632C10FFAC;
	Wed, 13 Jul 2022 01:47:45 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E557C10FFAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 01:47:44 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id g1so12294241edb.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 18:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XiDJX/xQsq+KbRjaEn/qiQHGjEPHutoUnkeP8Hgpe5I=;
 b=OJg8SGr2ZkqkoavcFSNI5hDSL2Kv0Lh0GHLk2eo+auE5Y5qQl2G5ATdQ66w0P67qnl
 moJYdL3dm2242LKYN+srzAZXPxgI7+pVQ2i9j4FZsB1d0I3K0ImGjuKhEVajqW1z8zxm
 ZyQ6YZi47EqKCu70sexDLaDmF3YAxb33+wVtQTTvPlq29NLx8fzkslE4dJAct7fO0pJy
 89v0eO9aG11k+cti1ndLwrF65Gbf4WeUHBboCXo/7MZJKqSTCe26DLizRL5VVpgnGHTk
 cKGJSuIYIH5QJePDe43ap6Zv2dsGifGrMZc4Q/b0ioTAq34jrm7PX6L8aR2WeqkaHEdU
 xT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XiDJX/xQsq+KbRjaEn/qiQHGjEPHutoUnkeP8Hgpe5I=;
 b=bWXZnlExZdJoa0wjhkOUNMNTy3iQXV9TR6jY5fO61FEU1WImHpTBwqwFGp8CjHU1TS
 dWTXs+q/Ii+nKKlYSiiVgl2eV2L17qmXHVOwbUG2CHHuX3dr1ZuzItM3S0KtqerDRqzQ
 hDQFRPx0DnR4/8JSfUOZ4xT7k3KLfbUmShGgtXB8QsnMEWxtoBTNPOnUZmgBrIzmnZJL
 CaGKozi2O2iMuhd9N/rC9Btr3OSJ/WTRlACryYJMNvFZ+TXBvBguXT02Ef177aKI7I+U
 Os61DJMLpkDzaNnX6nCTwQY83Bq4ZqwELm6XJrlhFJoKBDrdAA4v9trThDL01peN6dxt
 xqoQ==
X-Gm-Message-State: AJIora/RgGjGWdkijWFGqSc/c0WVXDAt9P5YiGrlpOBZR9yFm3FkcrKO
 3OBiII+1i51DOUykhm9Qv86f2OwPIGmhoTkKMnoOu6OQ
X-Google-Smtp-Source: AGRyM1tOmEGSDJyFyGxm9qRrzPD4uiHG6ISyfv/hAliNSY2tlM37YmQ78Qf1dH6WR+c81mDgXKxeQ6kQM0BFmo1l/y4=
X-Received: by 2002:aa7:cd64:0:b0:43a:4d43:7077 with SMTP id
 ca4-20020aa7cd64000000b0043a4d437077mr1493859edb.302.1657676863506; Tue, 12
 Jul 2022 18:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220711184153.135021-1-jinhuieric.huang@amd.com>
 <BL1PR12MB5144B5BB5BA660DCE16E8B86F7869@BL1PR12MB5144.namprd12.prod.outlook.com>
 <fbaa55f0-b6ae-6dbf-7951-bdb1239017ee@amd.com>
In-Reply-To: <fbaa55f0-b6ae-6dbf-7951-bdb1239017ee@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jul 2022 21:47:31 -0400
Message-ID: <CADnq5_ODdDwRO3G0M+33fONhoHnvj_Ypx8RBmZiXFCYafkSe7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: bump KFD version for unified ctx save/restore
 memory
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 JinhuiEric" <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 12, 2022 at 6:57 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Eric sent out the corresponding user mode patches to the mailing list as
> well. It looks a bit weird, because it looks like they're part of the
> same patch series. But patch 2 and 3 are actually user mode patches. The
> interesting one is patch 3.
>
>
> Do we still need a link to a user mode patch in this case?

Yeah, it's hard to include it in the patch when you send it out if
it's part of the patch set.  It's just nice to have it included when
you commit it so that when I send the PR, I don't need to dig around
to find the link to the user of the new UAPI.

Alex

>
>
> Regards,
>    Felix
>
>
> On 2022-07-12 09:57, Deucher, Alexander wrote:
> >
> > [AMD Official Use Only - General]
> >
> >
> > Can you please include a link to the proposed userspace in the commit
> > message when you commit this?
> >
> > Alex
> > ------------------------------------------------------------------------
> > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > Eric Huang <jinhuieric.huang@amd.com>
> > *Sent:* Monday, July 11, 2022 2:41 PM
> > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > *Cc:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>
> > *Subject:* [PATCH] drm/amdkfd: bump KFD version for unified ctx
> > save/restore memory
> > To expose unified memory for ctx save/resotre area feature
> > availablity to libhsakmt.
> >
> > Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> > ---
> >  include/uapi/linux/kfd_ioctl.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/kfd_ioctl.h
> > b/include/uapi/linux/kfd_ioctl.h
> > index 7a423855a86e..afd8ff29c74f 100644
> > --- a/include/uapi/linux/kfd_ioctl.h
> > +++ b/include/uapi/linux/kfd_ioctl.h
> > @@ -36,9 +36,10 @@
> >   * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
> >   * - 1.9 - Add available memory ioctl
> >   * - 1.10 - Add SMI profiler event log
> > + * - 1.11 - Add unified memory for ctx save/restore area
> >   */
> >  #define KFD_IOCTL_MAJOR_VERSION 1
> > -#define KFD_IOCTL_MINOR_VERSION 10
> > +#define KFD_IOCTL_MINOR_VERSION 11
> >
> >  struct kfd_ioctl_get_version_args {
> >          __u32 major_version;    /* from KFD */
> > --
> > 2.25.1
> >
