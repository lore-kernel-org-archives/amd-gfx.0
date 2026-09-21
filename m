Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64284C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 21:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F66810E350;
	Mon, 21 Sep 2026 21:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o+zHp8SG";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E036710E350
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 21:57:48 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39e6298aa19so475933a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790027868; cv=none;
 d=google.com; s=arc-20260327;
 b=c1BaGqKDoOlEz+tPxJJyp1/f1rPbZZrHGo63BwdizFpRxcVJCiCVxVIM9CnHjk4mWS
 cVk13oLiaDk+3iDvUlDStv2BcKJ8AtEKRQb+r+492A3exay3ir9J9xCZcMrJDVozq7/B
 BZmO1/TZgZ2NV8/nT+ynS7edjy7eIzG9YRj14hT9llwsIhWNdXfKGWCVTpDhuLbl3LuT
 aZ0OwU7MXXpWqWCdYBIKgEiBZUCMG30wLKZwiITa8hh44F1u552Dtg/4cDSH04NsCmKL
 dn3Sg9ESt30tAkrQzIgBA7WBUU1G9wEnDsGivqUUUF1Jc8PhoSPN9u/wuyrbspSRxuEg
 e8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
 fh=NfPGyTtF3MRN9GiqgR2C6V4NqHvjt+5ZqCYXc1inzpM=;
 b=NLSrYuMKGNuI0HdfPr+9sxMpFfabnMlvH0+hQXzuwoz4XI8b5U88mmBgZgTj+orQKf
 q4zaW7xGYOsGVADl+iC5pmnOC5aM7DLeiRy+vnU0uq9xhtozLKR6JWONLkUkZj9pufsW
 ZsSM39sZWR63cky7SbpHtLIdu9SBPmyyegK73IbNJw0zBhZylZEcLR4K02loLCGVWn27
 K+J3Rnxg8mw1w93sX/ttca6wi4MiHcdbkjIUVDzVkOQnynTKPU8K17sx+0l1Qh9euMup
 snGlM8nW+TP8x7C+0jEpkymKjtpJHM6aRoig9ebs0LAkjpsGEVEpexthXftpzvr4lzcX
 0Fxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027868; x=1790632668; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
 b=o+zHp8SGO/9CpnbPr60yU/XVajbmSQxnDu4B/0h9pSoie8jzsE41KlwlPC+DvnfyEs
 8p1hQqnqtl6J5yJSK2y11lbW/ZFobIoUVykcUnQu0pYiwRs/TVGrFnpInbdIQlFoT1OY
 +NQ+2hEcc7FcXZSrJqLPYxlvT6v0bZPkapHa6iQLjms0ZNeUCTkJ1UWXNpkjckd+UFcH
 b+nukEcpx4EZLgH1IHYa+krpwhyOTuTXSmOkr1lBxLxwv2Y6nmk0bcStUqEOW/eEJGtC
 tYtgVxyVTpAmW0CLemrerZ/Eas6b+oTzWDWeVuPA9xPDA0MtVz1HNKvmYcgLdoS/NVuX
 9YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027868; x=1790632668;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
 b=cVs6IT+KaT2qO2m9euczkK5X2dV5xtECCUwbkkZJY0PS/EWF4iFdrzCSAhZpdcUmG2
 7JYwiz0TcF34+Wg8e8NIec2cr4ZI8zuUQuhLBOMr/40QPuvZKbVvhSC72EYy2UbKOCyl
 JMFTA1kcVpmg7kdikj3XZr9CCBroV92TGsBfiRqBIQNIS8OzXBc9Ix/RwOoexFHH5WDY
 CXQdnEM16jauIpshLzbR8FdsIcOZTmAMWW//tw9YZDzosO1Wn3n60YyKYvDzQbPQBjmQ
 vP7b+VR2pYoLWHjAvCOHxXCpLlNUPGjjyZ3Dwby+A8LStt2YjB8FuH1tH3ueDu9jKnez
 DndQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByjwGB9Brf+acGUtEUrermJ9xXlnJZF/woDxqTrQnLjIQCad93qXKKzfj4bgMVnWH4rBXG6hZD3@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpLR2tgu4GAc2VCYANXKLMMG95Rn+bY79guMrrsEDCUMKPRQ/i
 Gq0FKGBq3IVoVYLj783ofd4vI8suJFWsF6c7xHaQtIDqRBUrcVoo+msLqUhWQNv+oP4lc6y67/X
 KZQkUV/8Hr1hVn3cYuPC98RD1xV1JaV4=
X-Gm-Gg: AYBFou0mxUWSSEnHDCp9uGim2mqpONmpHgz47iQzBIUyQ5qzoRk236nFVIgg2ATUr53
 bf9FWryP7VOyqyk3chJTZjH3JHvPyrJ35fiZKEt+JAGsiE2sEFwVjF0ggnIYiGJH68quoZ+qgo9
 mlhvWXJaPKsSxu2ajHtcvoibv1cPxjJTLVRT6+MQlTinRRFj7K5MPY/roBI2y/kEwyxude2OGTW
 FoKiiPb3JqADes6/oCvyt18pbB32XXReuQP4hMBcdY7/vBcruuSVlV80oOYwrfqsQvTtZTjUemV
 FvUTFJAnjxDPNy1MWYZnOnl8X0hRWWOcNlxEPzkZPFVLvwuai5/2u+uHOcHCCkDidLoK6nKPVV1
 1AIau5Wyr9HkdM2hev89MBIAaZx7mdxHE3M3lCa7SCw==
X-Received: by 2002:a17:90b:50c6:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e599ff59cmr21734363a91.5.1790027868375; Mon, 21 Sep 2026
 14:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260919165511.3687822-1-lgs201920130244@gmail.com>
 <b483d12d-f34a-4740-929b-28423d9c9b17@amd.com>
In-Reply-To: <b483d12d-f34a-4740-929b-28423d9c9b17@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:57:35 -0400
X-Gm-Features: AcwNN1UohLrK7gSjDi2UGC9O6aoP5YtKGJPc1vCQfKTwGIeZ-NrCeJY0S5T4r_c
Message-ID: <CADnq5_MSwTURavbU8ryixhPdsUfgBf64brJpALhkCeLq12BhXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix IP instance memory leak on kobject add
 failure
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, 
 Tim Huang <tim.huang@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Mon, Sep 21, 2026 at 1:16=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 19-Sep-26 10:25 PM, Guangshuo Li wrote:
> > amdgpu_discovery_sysfs_ips() allocates ip_hw_instance with
> > kzalloc_flex() and initializes its embedded kobject before calling
> > kobject_add().
> >
> > If kobject_add() fails, the return value is ignored and execution
> > continues without dropping the initial kobject reference. The failed
> > kobject is not retained in the kset list, so the normal sysfs teardown
> > path cannot find it. As a result, ip_hw_instance_release() is never
> > called and the ip_hw_instance allocation is leaked.
> >
> > Call kobject_put() when kobject_add() fails so the initial reference is
> > dropped and ip_hw_instance_release() can free the allocation. Keep the
> > existing best-effort sysfs behavior by continuing with the remaining IP
> > entries after the failed registration.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index a404d8aa13ee..4b1ad1c0a10b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -1314,6 +1314,8 @@ static int amdgpu_discovery_sysfs_ips(struct amdg=
pu_device *adev,
> >                       ip_hw_instance->kobj.kset =3D &ip_hw_id->hw_id_ks=
et;
> >                       res =3D kobject_add(&ip_hw_instance->kobj, NULL,
> >                                         "%d", ip_hw_instance->num_insta=
nce);
> > +                     if (res)
> > +                             kobject_put(&ip_hw_instance->kobj);
>
> Adding a message that this instance got skipped also will help.
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> >   next_ip:
> >                       if (reg_base_64)
> >                               ip_offset +=3D struct_size(ip, base_addre=
ss_64,
>
