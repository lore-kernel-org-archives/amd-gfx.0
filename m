Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32066C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B046C2074B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2/j/8Yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B046C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5056E89D1D;
	Tue, 29 Sep 2020 14:37:47 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1729489D1D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 14:37:46 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id v12so5068355wmh.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WfIZQqZ7lVtSqaFo900/JKH6z/cuezzFwNfJWyXKq6A=;
 b=a2/j/8YfKeee9oMTmnbIEQIKZZ4MxuMp+wZRnJDBF133UbYhU3IYPkc9rGovsgSAdt
 vOfXmY+8t0A1CIJrhnqt1kAEeyjrM1sGSU2etOZp678qW0yBt+oabZpHbo+OkJjKgTmg
 oj/BPDnDw1YLK8ZTHQ72rOiSMov/+fxrxXijk5RZLdAoRYE78aAi6f7lFYvlzudBGAgX
 zPpAZozwRaGXnYjs6WAijOv7PciJn0YWceKuJnmUgjhbb4gRV/4FDzCfnUPCWohJGeUb
 AZGjClXWIyyywrw0iyp3t3u2TsUZZVwbYmt0+LmIlgONTfC0BtmgAkn8uUdJowo7pVch
 qz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WfIZQqZ7lVtSqaFo900/JKH6z/cuezzFwNfJWyXKq6A=;
 b=QA8V6ehyyLP6d2LZ+MLBBmOJv6JChKxP0lkfEUAnHYtvCplJVV7l8YIT8AoNsaJl2F
 UNdM6eLNFjEinkyzp5ouBzSFVOSH8Lekxe91/wvNZt35ImRkuEyrZqVNT1mB9GAdfBzH
 B6IV+oLacevI+S+qgimzlsjahV7AAmAuTXQXtlGfsUVaS9Gzd+ccslcS9wEEmkKXdz+a
 rUWWFl7EGSbwoJWpk6qJ5HehVthnjcgqSTMwth6HhlA0WFA67FRt88lSQBW0FTaK2+sc
 kDsd1HskHmoFI/550kTQjDhJxWEgeJUnnwN1dPAx+SDcQnNKDSz3lEWO55Qm95jaHZhu
 NOvw==
X-Gm-Message-State: AOAM531h33Ejf3NuUyRumiZinfFEHeo5jvBc5PiGxQpDlmsCo+cX7nkg
 cVIFE7Omfg7+cq7bbjJG5d/qQqIgVQqgtdBlv4hy4cWnJVQ=
X-Google-Smtp-Source: ABdhPJwC6G+oAsW7HoSZ1dPEk8ngVUOm5cs+Ogmaa7fnfhEy/ZoX+Cd01UHwwcC/LF39tFGx28EjtYubQTQegHXYq8o=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr4913357wme.39.1601390264733; 
 Tue, 29 Sep 2020 07:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-7-alexander.deucher@amd.com>
 <560c8f7b-84f0-02dc-599a-fc9ee5496ac8@amd.com>
In-Reply-To: <560c8f7b-84f0-02dc-599a-fc9ee5496ac8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 10:37:33 -0400
Message-ID: <CADnq5_M_d+_OR3r_7EB+fEvs0oQApcYhwh=QkwUxeV1Vcsv6Zg@mail.gmail.com>
Subject: Re: [PATCH 07/45] drm/amdgpu: skip sdma1 in nv_allowed_read_registers
 list for van gogh (v2)
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 28, 2020 at 4:52 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-09-25 4:09 p.m., Alex Deucher wrote:
> > From: Huang Rui <ray.huang@amd.com>
> >
> > Van gogh only has one sdma.
> >
> > v2: use num_instances rather than APU flag
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> > index 2077f897d6eb..8616d397da00 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -289,7 +289,8 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
> >       *value = 0;
> >       for (i = 0; i < ARRAY_SIZE(nv_allowed_read_registers); i++) {
> >               en = &nv_allowed_read_registers[i];
> > -             if (reg_offset !=
> > +             if ((i == 7 && (adev->sdma.num_instances == 1)) || /* some asics don't have SDMA1 */
> > +                 reg_offset !=
>
> What is the significance here of the number 7?
>

7th register in the list (SOC15_REG_ENTRY(SDMA1, 0,
mmSDMA1_STATUS_REG) is not present on chips with one SDMA instance.

Alex

> Ah, notice here "sdma.num_instances" as opposed to "sdma.max_instances",
> how it makes sense, right?
>
> Regards,
> Luben
>
> >                   (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
> >                       continue;
> >
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
