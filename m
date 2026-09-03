Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90610C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 16:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B9210E07A;
	Thu,  3 Sep 2026 16:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="DC+bwtac";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E6310E2CC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 16:44:02 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d01663d816so190165ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 09:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453842; cv=none;
 d=google.com; s=arc-20260327;
 b=WiRn9S8UAi6m8uPbzjobqZ8f8lQVpG/TCrlNnLDcLvRc3PiYjo5qZ/keaGHIhZGyS5
 dQUJb5lnBwkCI1GJRzCgneFFNVGN2BZzKG7+EeppJbQfJ2drdJBV654Eby26Do2gUs7z
 UPKzssj4RE1waotJ3zzpNhzGl6rnczyeJLPxwUM3ode26FGlbKARJkPaM4cjB0rxZtWP
 XcFzIbg1+tICz7yna9xL1HAGH4shQxb1lhGD3S0L27wJ3KMVSBkz9kO1Yss7jrmre7KE
 JoL5ZfSrybaw9X0myrQKrrBa973iqZbMEGHb3JMBtB4VgzXm70UamM/NfoH6dxLRYX+z
 RK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yXvf0AeS7HHK1WbUNCGtVoEYnWuibX1ahJk5lCwo170=;
 fh=hFXCuDhbV4DTqP/BM/1jv2XoGRiWc14NW351t2VjAeo=;
 b=fRwEIOO8rwe6dp5yIEJ8qEX72UXXQIzHms3gqtCDW9aOUOz573fNVLc6vIhDDL/5MC
 YacrqjKpggk4KG6Soy9f5Rp7nq8bkyftzUa4Ir6fQhOXRDqErTN7dzOz/bmUQF9GvaKl
 V1WL0nGlI1LT64k/r1ujeaSo7O0aNqR5QYPYFbqtlwvdsaDa90f3jeltI1C9wCuLjNl4
 m2P5h2pp9L+WrIq9jRS7ngtgndxm4wACpOKD48Mtp+s4sezysZ6FaA1Iz5qIsmKmrgUv
 jOWVzPKFQyttg4N7D3XNvHs6xo4L4fBHcM5MoZVm9YeXbjf03HHAkSFzXXhpmye6zo53
 rz8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1788453842; x=1789058642;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yXvf0AeS7HHK1WbUNCGtVoEYnWuibX1ahJk5lCwo170=;
 b=DC+bwtacnjhx641ckrMaDZ6e9znJ8RGQo1PVvBADIHXy9X+eLcEc7XyWqy8wN5qNul
 LbZ/JEBwOvs6giWyO/DfOouOuxwnBvDpNTNyeZq61R2qGfA6z7X1TFgplJErTHDf/Qq/
 pPIXTRB/YGT23kjYaY98zCPvF+EFzAmZA1sM1gi0xZDGm8+Q8N6y6yfxadClc0eXqhbF
 /A+ZWDA7e3gvPl3rg8y3Pzrf2li4v/2YZi1hpX6exLHyAutVVyrYRxhzA0ajS6ueiEXN
 A55l1TgMoQG7r+oqfT0Al0ekjXqp+shHoDSPizwylWCx+DUJMwvTB9eBB5iGkwS+1DLw
 TWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788453842; x=1789058642;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yXvf0AeS7HHK1WbUNCGtVoEYnWuibX1ahJk5lCwo170=;
 b=OvlPZb+BtPuJ04Ss5ulajCaijO/L5WyQG5lYtABGtdvx12tTxMivG0h1j36tmXp3aC
 EqSMCuePRB8cABw5It0IjM5dRaLA+YXBXH3bUsXM7f6Di47DG5XBOgzYVsPgghDSa+k9
 8uMc/aOIn2b/daKgm2RfzVNiW1j5c8cJTaW0T8PQMKF9veLDtOGTsL9u888vjlDxJWwd
 6X+jZ4GC8rDo5G6sVyf1gUXwTz+X0DF5NJ/ILfTpD2xKMpbnJVY4Dn3QngirtccARz0J
 w85uGgS3WlI/YlSD0vJCXYEghBc7WHuy0zHon4eAzED1n7vLKg8HaSy/rEFzhTgvy81N
 s7tQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPM22Fq/yO8gMYml1QjHm7QlZ1TLeHH+cqX4U6hZgzNOqOv3LgPPqn6mhyOEzQkpP0BMbYV7vP@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltM51tbgj+O9RcaWLV5BWuJkn63CeCuUNyQP3yGMFPvUU5hnz1
 X167D386GOqsFHDBMXwDrxGoQ+fY9vfe4Y7K7AZEKhGhZUtWZU3hV1+zysBdBS3EfsutCSOcu0K
 nrSSIsrFp9SrVtNlkUisQv6NKwY/6eHTNyEhgeoFx4A==
X-Gm-Gg: AYBFou2uKRzJ8dyOlvmxIm6i8o5w43s8m08HhqIQ9yqoRBr7vDi7vbqdEyad/Ikgfa8
 7zrw5L7ZUzjj+6D1JTWjjEbzh9AdxWlNN3Vr03myPLYzOIx1rQQcAr2NUr35GaNPscgxZmNayoW
 QBYT97YcCO3xKsgPe/V/J5YKpj/w7wRqs3f/wadXPoAC70X0LWzzubrWX/a/361+wc72qCaz5EE
 ZbdwNUCIzvDQ1O92ZeqSECCiv+o19+YXbwhAIq7YVBwPwlabm/xBZXlbVGUAKc5Mmp/iKLZqhb6
 YjB+SlVXGfBnMn9any3AtUPDCKvsgUEsULMim9kRka/zGcjfqzzFoLc=
X-Received: by 2002:a17:903:22c8:b0:2d7:5ebe:a588 with SMTP id
 d9443c01a7336-2db126d6e31mr3116575ad.13.1788453842239; Thu, 03 Sep 2026
 09:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
 <CHXPR12MB9992200C6E9ABE2BF4CB8EB53EE5DC2@CHXPR12MB999220.namprd12.prod.outlook.com>
 <CAPj87rPsEUKEtOMzpvwnAJ1AHG=TyhLVu75kByPLwqbJ5yK1sw@mail.gmail.com>
 <CHXPR12MB999220E41E57B2B63AE08AAFABE5DA2@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB999220E41E57B2B63AE08AAFABE5DA2@CHXPR12MB999220.namprd12.prod.outlook.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 3 Sep 2026 17:43:50 +0100
X-Gm-Features: AcwNN1W2hsX-YARDywex-CoUx_eIKtoYa8nwDrda2bO7bDfKoVieE3xEJy5PT2s
Message-ID: <CAPj87rPFGmudizy+rRv9F+i0h-L03GwzFVxpxe54uzCgq14Exg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: Derek Foreman <derek.foreman@collabora.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jerry, Harry,

On Fri, 14 Aug 2026 at 16:41, Zuo, Jerry <Jerry.Zuo@amd.com> wrote:
\> > I really think the burden of proof for implicit semantics in KMS
should be the
> > other way around: do we unavoidably need this, or is there (currently) no
> > other option at all?
> >
> > I don't think ALLM falls into this basket at all. It's nice to have for gaming (and
> > mandatory for gaming VRR mode), but there are plenty of different scenarios
> > where having it on or off is a legitimate choice. For instance, should desktops
> > imply ALLM because they aren't going to smooth your text into oblivion, or
> > should they not because you're probably not going to read text on a 49"
> > display? Should all games imply ALLM because you need the response time,
> > or are you maybe playing Myst on your TV?
> >
> > I understand the attraction behind 'we can just stuff this in the kernel and it
> > will dtrt', but hey, that's what people thought about Broadcast RGB at the
> > time. Or colour model/subsampling selection on the wire. Or or or ...
>
> Yes I agreed. content_type -> ALLM doesn't clear that bar, and I'll drop it.
>
> I'll submit another v4 based on below soon:
> 1. Keep only the case we have no choice about: set ALLM_Mode=1 when
>     Gaming-VRR is active (VRR_EN=1) and the sink advertises ALLM, per spec 7.6.6.
>     This stays in the driver.
> 2. Remove the content_type == Game heuristic from both the modeset and the
>      freesync paths. No implicit ALLM derived from content type.
> 3. No new implicit semantics, and no DRM-helper "default" either. If a
>     concrete need for explicit ALLM control shows up, it should be a proper
>     (ideally generic) property with a real userspace user driving it, not
>     something the kernel infers.

Here's a Weston MR which provides the same user-facing API. There is
per-output configuration for ALLM being always enabled, always
disabled, or enabled only when a game is present on screen:
https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2189

Would you be able to re-send this series with a binary ALLM mode and
linking to this Weston MR?

Cheers,
Daniel
