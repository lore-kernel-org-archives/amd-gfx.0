Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C1C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 16:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE0110FD1B;
	Mon, 27 Jun 2022 16:42:00 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F4D10FD1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 16:41:59 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id sb34so20310857ejc.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=K1f6b/sUnTXoSVT/PZW3qdM4bAg2asrLMkKIUbfS4t8=;
 b=nCnY8vJ9zeYp7ZWiKhCfuZ00Hj9RXC5xrJxMcrKg7/FZfw2hf/BiXpfjqBzuKf4/eQ
 AiWWZuQ6pP09ee9H1064JD6ZP/QW2+rsiMU7lJZE/NqUb+MH549ivV97YcP4Vu3UEmPs
 EchAAgSY1kY6lUnvhv6MpItph8KIuk29EFk7jAU8Zvjt6nTIDT40L4QzpfMNsPwVgR6A
 DtahxgaufAKVFLdkPtDUut6MMvUKqIfbyjI5ztRSkbDquQ2Udpe2zge6JehDoYzLbDnX
 hKgSkiws9N2GKWthVSum9PuKJoxE19bomePBQwN11LX5fezFoBOm5/5ePSJKrs+LyGaZ
 Mz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K1f6b/sUnTXoSVT/PZW3qdM4bAg2asrLMkKIUbfS4t8=;
 b=hYw2uHq6pY+w1NtKQRsjvJh/k0xzduKnDgEhjaU72/5lZPJ1B72VOB8+xApiaH2zKz
 1P3DNYgqA9nljfsnrAsa5JETzP5eOqmPLh/n8Vol8powilL5frUE4ifcR7DGhjBb5v0+
 wvnsUpk95TWqFHeNB1HjMj2oZmVvP4add/LCUAHuEFWkL9LACdz3NSNoMI/WJX/0kNuZ
 TR9swHnyrj3hNSYQzptT6EGYkV8vNhBLItMw01MPODAC8oSaDhdDTqI90AjNZDYfSy0y
 86A3B7eaPPh7hJnhIpOaNSEJmEKqOH4RlRyHzlggbmudLmiVEc02eqR3gF8J8J+jpAdN
 d/Xw==
X-Gm-Message-State: AJIora+6S/zqeDhgt7pDany1il8PW08eFhOQxC5cW3du3OLEtKL46cTn
 Dsl6Marp6WPpJ0aPX48PviWEjDNpQexCzWQILLnvZXFJ
X-Google-Smtp-Source: AGRyM1sdOSA/0YjqQr5RjSwEw/AOGnH+NuIPSTg271OKbEYq/kr+73lbbfZ0IuD+5poOZN1VbfVGHmOxHqjJaN4e7ao=
X-Received: by 2002:a17:906:c041:b0:718:c984:d9ee with SMTP id
 bm1-20020a170906c04100b00718c984d9eemr13691797ejb.722.1656348118161; Mon, 27
 Jun 2022 09:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
 <CADnq5_NNs+OEaQXR_L-0wKY+a8dmt_8vgimLWKrfRzAFCNGBjw@mail.gmail.com>
 <1b1412cb-70d5-481b-fdf5-be8500e84503@amd.com>
 <CADnq5_OXDRwNHnKoVNC6yEMrrs3-tc5=056sLw9MXdouDSfUew@mail.gmail.com>
 <29951690-b675-ec23-9aa0-e3344f41d3f4@amd.com>
In-Reply-To: <29951690-b675-ec23-9aa0-e3344f41d3f4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jun 2022 12:41:45 -0400
Message-ID: <CADnq5_PxRnGaxki58BE+vofY2L0AhuTuhQWOqv8ex2qvjn719A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdkfd: add new flags for svm
To: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 27, 2022 at 12:01 PM Eric Huang <jinhuieric.huang@amd.com> wrot=
e:
>
> No. There is only internal link for now, because it is under review.
> Once it is submitted, external link should be in gerritgit for libhsakmt.

We need to have that available at the same time so that the kernel
side can be properly reviewed here.

Alex

>
> Regards,
> Eric
>
> On 2022-06-27 11:58, Alex Deucher wrote:
> > On Mon, Jun 27, 2022 at 11:36 AM Eric Huang <jinhuieric.huang@amd.com> =
wrote:
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fger=
rit-git.amd.com%2Fc%2Fcompute%2Fec%2Flibhsakmt%2F%2B%2F697296&amp;data=3D05=
%7C01%7Cjinhuieric.huang%40amd.com%7C61498029cd6743a4519108da5855f02e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637919423397667222%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000%7C%7C%7C&amp;sdata=3DwPlHRSmOyzO%2B2vbwN9IK4qR5dhk%2BaOw2rt3JEdjizRU=
%3D&amp;reserved=3D0
> > Got an external link?
> >
> > Alex
> >
> >> Regards,
> >> Eric
> >>
> >> On 2022-06-27 11:33, Alex Deucher wrote:
> >>> On Fri, Jun 24, 2022 at 12:03 PM Eric Huang <jinhuieric.huang@amd.com=
> wrote:
> >>>> It is to add new options for always keeping gpu mapping
> >>>> and custom of coarse grain allocation intead of fine
> >>>> grain as default.
> >>>>
> >>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> >>> Can you provide a link to the proposed userspace for this?
> >>>
> >>> Alex
> >>>
> >>>> ---
> >>>>    include/uapi/linux/kfd_ioctl.h | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd=
_ioctl.h
> >>>> index fd49dde4d5f4..9dbf215675a0 100644
> >>>> --- a/include/uapi/linux/kfd_ioctl.h
> >>>> +++ b/include/uapi/linux/kfd_ioctl.h
> >>>> @@ -1076,6 +1076,10 @@ struct kfd_ioctl_cross_memory_copy_args {
> >>>>    #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
> >>>>    /* GPUs mostly read, may allow similar optimizations as RO, but w=
rites fault */
> >>>>    #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
> >>>> +/* Keep GPU memory mapping always valid as if XNACK is disable */
> >>>> +#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
> >>>> +/* Allow set custom flags instead of defaults */
> >>>> +#define KFD_IOCTL_SVM_FLAG_CUSTOM      0x80000000
> >>>>
> >>>>    /**
> >>>>     * kfd_ioctl_svm_op - SVM ioctl operations
> >>>> --
> >>>> 2.25.1
> >>>>
>
