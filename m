Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2B3CCA47E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 15:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB05B10E18C;
	Mon, 27 Jun 2022 15:58:55 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F4110E18C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 15:58:54 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id g26so20114884ejb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n7Y+utFcHj4nn8y83unIYQJ68AbgwpU2Fnuy7ZvY/hs=;
 b=J7uRnDLF43aBbItrU1bjAJYg3hl4H6sjdSWuH8BSjpiqQ4fkToH+J2R9NwRYDhsvhe
 Hflx9F3WmDnEompnsYHZ2FZhYEWN72umlAXh7fPpXY3XUGBta3EHpLt0w6CVBBr2Bcpk
 lAPMmS1Z6ZrCKdeieU7/PpcyemSeiBnwT7DYljWKIisMGF74c0BvPrd62ebTxQyZmnS5
 pvHMXfG670HpPwHRr87hDiBp4z5IJCdmgQhIVZLHkjjwIPucUio+H1Ui4C+p2Nh9o/Ka
 NIqMXRVbd6+5nMAdIifkqxgjYayLh9uZIcS1sNdEyUwH9l/Jeb3PY8zgKVrwxksxTZea
 AJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n7Y+utFcHj4nn8y83unIYQJ68AbgwpU2Fnuy7ZvY/hs=;
 b=JdCSFeiEuv9zJdyzlPKczZzlKEH98OveBwXAyc0zrCosqEDC4PDu+PGUXTQXe6WeN0
 PJ6LoCWjXPLu9kHDUy2DDGDPTjdwgX4fyKLCUyTRKYhz158mNCKecWMiDNn82BgKyGhI
 jJA/vohwWrK6TM6aFQb1+FBUuP/E3jIisfQU0cYRd4hfzvPvPYBGLzBoKurRvhDtSRj3
 pp9m1KRuTZsUWMgWdzdv1JxQVcTNrC7dvHPT6SDcHPzAqzdo7yCU3KrBJDKbzCzGbrx7
 vDaUvKWEVDlY6rBP52LU64LAyg64AoCMgSa4OS/B5eMI2N9IGUNWHlYPzdeLUHAl0P9z
 ypKA==
X-Gm-Message-State: AJIora/mKE09sDsG1jd1T5SWnf2Rl+h3N5mx9PhTS4+zLzsCn1virxyP
 DCkzJ1Mtv9L8OmGQNJh29BajvgHsZtxK569PZkC4ALJC
X-Google-Smtp-Source: AGRyM1toWzAex2ooKc5uhWX+qD0ykbUSrcBIt0wSOLDbRGcFDGJk87g/dKsAK0+1Wz1ulzqgiTnCGNMkQyKsdHaQ8F4=
X-Received: by 2002:a17:906:c041:b0:718:c984:d9ee with SMTP id
 bm1-20020a170906c04100b00718c984d9eemr13501555ejb.722.1656345533312; Mon, 27
 Jun 2022 08:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
 <CADnq5_NNs+OEaQXR_L-0wKY+a8dmt_8vgimLWKrfRzAFCNGBjw@mail.gmail.com>
 <1b1412cb-70d5-481b-fdf5-be8500e84503@amd.com>
In-Reply-To: <1b1412cb-70d5-481b-fdf5-be8500e84503@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jun 2022 11:58:41 -0400
Message-ID: <CADnq5_OXDRwNHnKoVNC6yEMrrs3-tc5=056sLw9MXdouDSfUew@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdkfd: add new flags for svm
To: Eric Huang <jinhuieric.huang@amd.com>
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 27, 2022 at 11:36 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
>
> http://gerrit-git.amd.com/c/compute/ec/libhsakmt/+/697296

Got an external link?

Alex

>
> Regards,
> Eric
>
> On 2022-06-27 11:33, Alex Deucher wrote:
> > On Fri, Jun 24, 2022 at 12:03 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
> >> It is to add new options for always keeping gpu mapping
> >> and custom of coarse grain allocation intead of fine
> >> grain as default.
> >>
> >> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> > Can you provide a link to the proposed userspace for this?
> >
> > Alex
> >
> >> ---
> >>   include/uapi/linux/kfd_ioctl.h | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> >> index fd49dde4d5f4..9dbf215675a0 100644
> >> --- a/include/uapi/linux/kfd_ioctl.h
> >> +++ b/include/uapi/linux/kfd_ioctl.h
> >> @@ -1076,6 +1076,10 @@ struct kfd_ioctl_cross_memory_copy_args {
> >>   #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
> >>   /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
> >>   #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
> >> +/* Keep GPU memory mapping always valid as if XNACK is disable */
> >> +#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
> >> +/* Allow set custom flags instead of defaults */
> >> +#define KFD_IOCTL_SVM_FLAG_CUSTOM      0x80000000
> >>
> >>   /**
> >>    * kfd_ioctl_svm_op - SVM ioctl operations
> >> --
> >> 2.25.1
> >>
>
