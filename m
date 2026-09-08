Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAFBC79F9E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 16:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E4010ECF0;
	Tue,  8 Sep 2026 16:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hMuht812";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930B510E12F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 16:04:11 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-9808aa4578eso89267241.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 09:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883450; cv=none;
 d=google.com; s=arc-20260327;
 b=VEWgZUDoMYhEXutD7PfS2ddy3r7lOpoYMIgRuvABa2lNr/ZzPM8U1EhkltvAIDjw3p
 1Se9jYLL2t9hRL9W9/mU40OOtPBW1uHMRPWoQiYcnuWejnI3JR1UhBwgZr20z6AZUmj2
 hIvUH7hIr8YosX8gJxtnPIuQRSHCg8r73dK5mGfBdmK66Nhp6Z7oX876e04lKOoyppyW
 RPpJbJOWlY8SNmG0UIBxXa73xbTJLOhnNFUW+y/WYlj4fa+L2zKKvw7NsyEob9t16Ue0
 QjqyphBizbguxgxxFgf6JIJWLLub7BOYYxdRMcy3ONP2Ud2s5MQ8yAne3ntO99CvhDfj
 xN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nt0kh0XYrPSHGJubgJUC0bfBx9LloKYXdOD5FMiKas0=;
 fh=OEW6b3IlgAhvstiKaV1aT6NvFfIvAjN8q1umh94u710=;
 b=La9SbSF7E5+QDjLfxdgFItGjPDvyq+7DH93QVRcqAp7JuMcNQ7yrU07TsJPqCzFEoQ
 kRPifY2+cPsNudLW450oDdyOzJjeS6upa2FlIxgfLYC9kg5DjBZ+Y5rqCP+14Bz0GJX6
 D9jFdtjnQWGX+bCe9lmk+7UcT5Fpkye6mu9xTiKPJ3AvMeA2qCIZpjv7qEi7SssxyLwv
 +kW3FTEvX75g+I7va0N68Vk48eJEr7IAOmjmPu33wCosNt6gONE4VoThQM+I4Ob5HxrX
 t8tYbo6cACXmwNJ78o5G2c2BDDaLKCpjkT4/oVn9m3EonS2+ql6Qah+7LioLRwRVplsR
 lmGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788883450; x=1789488250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nt0kh0XYrPSHGJubgJUC0bfBx9LloKYXdOD5FMiKas0=;
 b=hMuht812HX7O7V+DELib/fwsrHKBaKblvJ6kfR5hguA41VHLyjq8zZva4+eJVzpZ0n
 yzMom9bKMYZHVS9186oI7Gb6POnDWqRwiMMbwJ0V7NFywDxd8C33DadZzMrB6skBbWfJ
 5yn5tqbu91CXHpk1jDbH2x2MvmOkD/j1zOUV7Ap2w3FoJ+b1kvNqeS+ezhcnZtqop+CS
 C4fdTvburtOcYc1ZbETuuiu1TaT7LwEQg+tOCf1roesaPfth7n9vK8lun93hJDX11mco
 v85qHgVCvVDt3rUBOiT5EGqJZiwxO6jimIghfsMUeHK6RkhTsv53QeSFRh0u2zFabvrB
 AUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788883450; x=1789488250;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nt0kh0XYrPSHGJubgJUC0bfBx9LloKYXdOD5FMiKas0=;
 b=HNP2bUi3uEKprRuPjCXR7x/sZeQHrCkc6Y48W1Df09s4pMpffhLmytIaiPSpZOmc2j
 r7O0Bb5YFr69Vs2QlvxcOUmfmYyKpximDje790dwLfUhK5AVNQlzRs7SpxWB6yPaik1J
 wTx0tEoHpylGxTs3zqtAA1POiAAucU3mBzwc6Z8oGa5u+Qwp1h+Bz81Ibc4KxFAqwq6n
 80oJiZKvnRoc9/zbN/enApnVasaMS4zZrBfhw1Y+C08DsEqfXr6pes+bJ7zM4VVrUNA2
 FDhAoywTHSRTLfKZD+lF8A/poWVkvY6Hv4P/dvNiZdjdZEYMfbKJR+iRfYSj1FnDRLP8
 9AXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydDCQQmnmND+iREr2HIzhxx8EtgqfaybbHJHK731MY/o00Dww/yawkN+6HW1s3nPuK/lTDEe9J@lists.freedesktop.org
X-Gm-Message-State: AFuF++lrDCA3zjEaLbHaF9DgzPWNnKms09MkObDr8ymyAgQfiGSyYIkQ
 kHFs8q0LVSOY+gMLlLGdGTRlMd+G23bD9hLiVw3ovgbZqTZE72ZRirCJblQmDAzNt9G4jbBnWCD
 sYwrUIkRZWv3c82svZP6kTHITsxdyxXE=
X-Gm-Gg: AYBFou0kH1YUenRhXJ/zIKrmr9T1AvAeHxnBeGevPaQb0WG9aifyJLQ/OZcaClXFMf8
 mTjoIkcn0kZHIhcFTCJuY/wpngK2Ulqd27Rrzh+bxRmtju9lpGNK4Bdrxarfp0MjvLgTRSvQ68j
 5aeWJVGUfGAiyg6Fn6gR/Cp1k6kwdDl5IST5hXkFW5UWtVzosNBN7NKgKylGCAqYEeX7ZoYcA09
 WwVaKPcxe43qwiNXVlmSiCcnHrxfuUWye31XZgVanjH1KefA3DgZN9pMW3jdXOiVAevBQUSXDLA
 QP41atDM80XZWRbNVZoRq4EhxytTX0O+bS07Lb0BygyaqI7l7C5RfBfvwz6Xibb+Igg7X15Ns8x
 5ULkIYre05KR3Ybe4e+PlEuIivkgqe9I=
X-Received: by 2002:a05:6122:a5c7:10b0:5c1:24b6:a1e0 with SMTP id
 71dfb90a1353d-5c7fbaf3b05mr2679642e0c.3.1788883450339; Tue, 08 Sep 2026
 09:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
 <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
 <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
 <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
In-Reply-To: <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 12:03:57 -0400
X-Gm-Features: AcwNN1UGWQ08V1C6NZZQaio8lehal8RQn4GKIdJFwvOdWZL0ItwTZuEEeLAGaiw
Message-ID: <CADnq5_PjN8X9V0PQ=no39NCAGM9Hp1JezOuKNpHqwo1=WfsPQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
To: Klara Modin <klarasmodin@gmail.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Mukul Joshi <mukul.joshi@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Mon, Sep 7, 2026 at 3:25=E2=80=AFAM Klara Modin <klarasmodin@gmail.com> =
wrote:
>
> On 2026-09-05 11:31:41 +0200, Manuel Ebner wrote:
> > On Sat, 2026-09-05 at 07:36 +0200, Thorsten Leemhuis wrote:
> > > On 8/31/26 20:33, Alex Deucher wrote:
> > > > From: Mukul Joshi <mukul.joshi@amd.com>
> > > > ...
> > > ...
> > >
> > > > > error[E0063]: missing field `handle_free` in initializer of `drm_=
gem_object_funcs`
> > > > >    --> rust/kernel/drm/gem/mod.rs:265:58
> > > > >     |
> > > > > 265 |     const OBJECT_FUNCS: bindings::drm_gem_object_funcs =3D =
bindings::drm_gem_object_funcs {
> > > > >     |                                                          ^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
> > > > >
> > > > > error: aborting due to 1 previous error
> > > > >
> > > > > For more information about this error, try `rustc --explain E0063=
`.
> > > > > make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
> > > > > make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-nex=
t-20260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:=
1442: prepare] Error 2
> > > > > make: *** [Makefile:256: __sub-make] Error 2
> > > """
> > > Full log:
> > > https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/ne=
xt/fedora-43-aarch64/10951622-next-next-all/builder-live.log.gz
> > >
> > > Reverting this change and 2/3 from this set fixed the problem for me.
>
> That leaves only the documentation without the feature so might as well
> drop 3/3 too in that case?
>
> Otherwise, the following also fixes it for me:
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index e1ebad77ebe2..847e0ee38863 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, C=
tx> {
>          vm_ops: core::ptr::null_mut(),
>          evict: None,
>          rss: None,
> +        handle_free: None,
>      };
>
>      /// Returns the `Device` that owns this GEM object.
>

Can you send this as a proper patch?

Thanks,

Alex

> >
> > Verified.
> >
> > Thanks
> >  Manuel
> > >
> > > Ciao, Thorsten
> > > > ...
>
> Regards,
> Klara Modin
