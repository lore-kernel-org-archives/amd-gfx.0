Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E3C34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 21:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791FC2064C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 21:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F55zS8oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791FC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4315E6E416;
	Tue, 18 Feb 2020 21:40:37 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E336E416
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 21:40:36 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z7so25739488wrl.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ebbpgA9plPYMM+3rxLp4VVFzdzvn+M8vdD04KghA4dY=;
 b=F55zS8oheANJUvkLsUTlAApnGzWzOcCOnXbTiUTK4g1xlEWZ99HmoEEIbGjlB7V2K6
 f+LBvcvlWpXpUygodtqikp9A41tvC9c8pF83cT9No71yvtVSiXspLoJd8doDZbP+Nvzp
 0VPGrGajOoH5nh3w7cX/vzQ/JiGENwQMFRyt9UtwkOSHAwMvwYtcaTpVYpMTHVYcmeiR
 qs8S7X0ufTVgu3Feo4PKSBEMN5D7PQ112Nk/E2gpC4TuWbLCKsECvjF2oJDnAsxmMGlY
 sDIqkqDtG6eiPEOAyE/g4Mxchq85oHdiHY/kUqUegIfC2j5+BAKIHQa6IZ4gzuMjv0et
 o9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ebbpgA9plPYMM+3rxLp4VVFzdzvn+M8vdD04KghA4dY=;
 b=eCCH9MpfltsevLR8acKw8g0fCznlYAkr7bR5VJhq1OlMRisiLnohHHwSx/4gXM1b7t
 6tW/PqqcgOHYTgOQqityQZMTNvaHwdbkmJrMCI+tqn2g3DFLbgxkq+T5s0bYe6osp1Vl
 yMw0mYFrtVPu0wr5pfWDf7FPEP9a/X3cEmxiLdNs/KBhWZFRPwsecrT3k9sAPw3PYDpV
 qIAflRsp5mdYx0ghY8p6m3ZpiHwt6pmQ6hnioTXbyDgCgo3P/5bMPHhRkLtHVWJbtE4z
 bFDCnACLl6wQEIRRejvAaPtpKVEes6xWoqC65noU6zGcSy/+kjifdQVZQoGbeoASNe0L
 IWPg==
X-Gm-Message-State: APjAAAXaGyl+kfEYnTQg9sl1syKRWnCBYyfqhCvXiBw6Eu3jEzEodkBv
 UhEVX3MQLAYqSkmtmHbIs1C41KLpITMko1MVjr5uXw==
X-Google-Smtp-Source: APXvYqyIVMlhLZvGXeaOeBP1QoY3Q4qkKCYEjeQtUZsO5JrPuoCzqtr62dwBd3lLWO0DmOV9TKE8t8Cze2FmFS6wRqQ=
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr3243841wrs.111.1582062034590; 
 Tue, 18 Feb 2020 13:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20200215001714.605727-1-luben.tuikov@amd.com>
 <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
 <34764f7b-363d-c9a3-5e02-191c359d8f9f@amd.com>
In-Reply-To: <34764f7b-363d-c9a3-5e02-191c359d8f9f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Feb 2020 16:40:23 -0500
Message-ID: <CADnq5_Py1gbpZtb4oDQ2njydiriRMmN_yD4i74bU5+qaKAXjaw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 18, 2020 at 4:36 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-02-17 9:44 a.m., Alex Deucher wrote:
> > On Fri, Feb 14, 2020 at 7:17 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
> >>
> >> Add a AMDGPU_GEM_CREATE_MASK and use it to check
> >> for valid/invalid GEM create flags coming in from
> >> userspace.
> >>
> >> Fix a bug in checking whether TMZ is supported at
> >> GEM create time.
> >>
> >> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 ++---------
> >>  include/uapi/drm/amdgpu_drm.h           |  2 ++
> >>  2 files changed, 4 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> index b51a060c637d..74bb79e64fa3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> @@ -221,21 +221,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >>         int r;
> >>
> >>         /* reject invalid gem flags */
> >> -       if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> >> -                     AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> >> -                     AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> >> -                     AMDGPU_GEM_CREATE_VRAM_CLEARED |
> >> -                     AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
> >> -                     AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> >> -                     AMDGPU_GEM_CREATE_ENCRYPTED))
> >> -
> >
> > I'd rather keep the list explicit so no one ends up forgetting to
> > update the mask the next time new flags are added.
> >
> > Alex
>
> What about the bugfix below?
>
> Why did no one comment on it?
>
> >
> >> +       if (flags & ~AMDGPU_GEM_CREATE_MASK)
> >>                 return -EINVAL;
> >>
> >>         /* reject invalid gem domains */
> >>         if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
> >>                 return -EINVAL;
> >>
> >> -       if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> >> +       if (!amdgpu_is_tmz(adev) && flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
>
> This one right here?
>
> What's going on?

Yes, this bug fix is correct, but the other change in this patch is
not.  I should have suggested that you split out just the bug fix.  I
thought you were going to resend just the fix after the feedback on
the other portion, but I guess I should have been more explicit.

Alex


>
> Regards,
> Luben
>
> >>                 DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
> >>                 return -EINVAL;
> >>         }
> >> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> >> index eaf94a421901..c8463cdf4448 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -141,6 +141,8 @@ extern "C" {
> >>   */
> >>  #define AMDGPU_GEM_CREATE_ENCRYPTED            (1 << 10)
> >>
> >> +#define AMDGPU_GEM_CREATE_MASK                  ((1 << 11)-1)
> >> +
> >>  struct drm_amdgpu_gem_create_in  {
> >>         /** the requested memory size */
> >>         __u64 bo_size;
> >> --
> >> 2.25.0.232.gd8437c57fa
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C622cd0e399a041e8ad4908d7b3b7e97d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637175474785178580&amp;sdata=CLlIUaQVOhMibxBtkHtbBZQ9d%2FjNBSRtZ8Db%2FYN2Hj8%3D&amp;reserved=0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
