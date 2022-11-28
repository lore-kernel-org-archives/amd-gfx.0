Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D07C4321E
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Nov 2022 21:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594F710E242;
	Mon, 28 Nov 2022 21:32:52 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D19410E33C;
 Mon, 28 Nov 2022 20:48:20 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so19260089lfb.13;
 Mon, 28 Nov 2022 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BQeZUqb3Pifi3jSv/iRE3ZaOxDgoJu3LTZRbZn5fuMk=;
 b=Fmpi40xXWKIH84DV2LMtmXEYLnm6YD4mUicwXkwZPmeScyC4+lJnPpAtLec5l5i8sS
 alZKOpmJwglt/xROfbgAmEJkF+YCdUKj3iKCOs05ckUpvh/r5HKRmKQMvHIIWA+H2OrJ
 pQ1RpS0HTRDc9nb7zYjJekC5ZSx4TUrvYbKFAq+dIH242sJaDB/uMrsxIcdbfLt3QZRJ
 mja4dhz4sWBwDxo6vBH5E2CwMClYk2Y35+6Piw9G4dyJ6soTuZIw0kZXZcfm5jajbaRp
 ya1lbys5x6MlgOT3I2FEQ8HgmuHeYtMDyAdHCXR3+I9S4ige8hbFkx5rYSmlPLF06MUW
 /9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQeZUqb3Pifi3jSv/iRE3ZaOxDgoJu3LTZRbZn5fuMk=;
 b=1ldac4T9ZHw53+uibEh7gTJNg4+oiZMN+jP3CAbzjla5e/HcjrFsx997XAxae2wHNx
 citZJ5tJGf6/IcztuivCajQPjkBpZTZvDJcT3pKRrXexb3XbvnQEr7EDMTisR68ENYZa
 Labng5lpYE1OJu+7uKzuGiLbbJiGRTLX5Ui0M77908YyeCq6KKCQrt55+WBPUcyBr6jb
 cGWONBTg5PHZpVnsFOujRi8TPF3FGHX11+FRnZcdfPPpALjY1bTOaj+pe0b3mvkXxkHl
 A5RJfVwoSF1SEP0Ehkn4me/Cc+645G5egUcjQ/skwr4Hgpqw0kRYByk4c5pEjETJT/S8
 24Mg==
X-Gm-Message-State: ANoB5pkT3rG3XZjc9sGHIomgDwQQuh7GxuxfmGST18aEQo8yqKJH9ozp
 ChtrELYUpIg37ValxxkeQeCqC28vtg==
X-Google-Smtp-Source: AA0mqf7WI+D5B3ZzNMV/LfhPlUk/0H4nAMyFhy4Y6+SBLqGvCr7TaZoPY2ZWETUaPnOq1dwiYbrOvA==
X-Received: by 2002:ac2:4e88:0:b0:4a6:fa2a:275b with SMTP id
 o8-20020ac24e88000000b004a6fa2a275bmr15341144lfr.87.1669668498691; 
 Mon, 28 Nov 2022 12:48:18 -0800 (PST)
Received: from sqrt.uni.cx (0854358661.static.corbina.ru. [95.31.0.167])
 by smtp.gmail.com with ESMTPSA id
 p20-20020ac24ed4000000b00493014c3d7csm1852232lfr.309.2022.11.28.12.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 12:48:17 -0800 (PST)
Date: Mon, 28 Nov 2022 23:48:20 +0300
From: Mikhail Krylov <sqarert@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Screen corruption using radeon kernel driver
Message-ID: <Y4UelMnRkY7/0G6U@sqrt.uni.cx>
References: <20220423193145.3301ed06@desktop>
 <CADnq5_PXgFBXZ03LXE8qOdimzfKYGhzX1JnycJQcHWcMZdgJug@mail.gmail.com>
 <Y4TGOb3UGmDslyYF@sqrt.uni.cx>
 <CADnq5_NTyvZR16_N0TzMo3f9Mg6EwOuwuBgYzDA=U7tur7Fmnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YO4JAez6wiO1RWwk"
Content-Disposition: inline
In-Reply-To: <CADnq5_NTyvZR16_N0TzMo3f9Mg6EwOuwuBgYzDA=U7tur7Fmnw@mail.gmail.com>
X-Mailman-Approved-At: Mon, 28 Nov 2022 21:32:48 +0000
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--YO4JAez6wiO1RWwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 09:50:50AM -0500, Alex Deucher wrote:

>>> [excessive quoting removed]

>> So, is there any progress on this issue? I do understand it's not a high=
                                                                           =
                    =20
>> priority one, and today I've checked it on 6.0 kernel, and              =
                                                                           =
                    =20
>> unfortunately, it still persists...                                     =
                                                                           =
                    =20
>>                                                                         =
                                                                           =
                    =20
>> I'm considering writing a patch that will allow user to override        =
                                                                           =
                    =20
>> need_dma32/dma_bits setting with a module parameter. I'll have some time=
                                                                           =
                    =20
>> after the New Year for that.                                            =
                                                                           =
                    =20
>>                                                                         =
                                                                           =
                    =20
>> Is it at all possible that such a patch will be merged into kernel? =20
>>
> On Mon, Nov 28, 2022 at 9:31 AM Mikhail Krylov <sqarert@gmail.com> wrote:
> Unless someone familiar with HIMEM can figure out what is going wrong
> we should just revert the patch.
>=20
> Alex


Okay, I was suggesting that mostly because=20

a) it works for me with dma_bits =3D 40 (I understand that's what it is
without the original patch applied);

b) there's a hint of uncertainity on this line=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/gpu/drm/radeon/radeon_device.c#n1359
saying that for AGP dma_bits =3D 32 is the safest option, so apparently the=
re are
setups, unlike mine, where dma_bits =3D 32 is better than 40.

But I'm in no position to argue, just wanted to make myself clear.
I'm okay with rebuilding the kernel for my machine until the original
patch is reverted or any other fix is applied.

--YO4JAez6wiO1RWwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEq9zNqT9shXHTn/gRzNfc0dbmrQAFAmOFHpQACgkQzNfc0dbm
rQBTnAf8CZAOJT2gulKnHGlUzN1KSbnbmb9Ac52KgbW51v3LURPxVo2X1w/SEuZK
CvcVIe00vQbENdpTRuvTfKZA1mMnhBuyqi4tdL/B6nd28LsowUWRztwx0Ef1RK8r
B4Vg21F6yTTJjfgT1zV10Ny2kF+5GyvuKiPxiGTizQGcfOcnFGzjVqa79v5BqEwA
XuHQCcVuKhM5/KHVF8dCJpu543KubhlHKKvdZjaYSyMBAeXllqEG9WgYgvAakO4Q
lfRpiDiEFr2Jquvl8wy6YKCNBI6glK4Nz54RBcpiPrdRHFDXeTzyHupHwxwcqotn
HtL87JSmqaC+f1CBFXlTzVOFe97Rsw==
=QaM7
-----END PGP SIGNATURE-----

--YO4JAez6wiO1RWwk--
