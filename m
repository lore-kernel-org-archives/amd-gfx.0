Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3108CA600E
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 20:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F6F10E93B;
	Thu,  8 Oct 2026 20:21:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvtx8vO/";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7DC10E93B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 20:21:51 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-8198a3a54d7so1054521a34.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791490910; x=1792095710; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZAEiWS1VLm9b/lpX7haGH6Eqf/4mSJWPRfq8ClPpCdI=;
 b=lvtx8vO/5gDE+mKwbkeZeXslsXprRUvnyo7vyFY0NpiFFjVz8zb6gvElBxOVFkKbjn
 jt6sit8305oEq5zz6p5iWohNiXWXa1qnCuXpjnmYy8V60hTk6XWi8QL3GCrKjAHM04p4
 qIhPtug0KMTBPNwbH0UenxxCWkGsPQqGFPy1rtqyYHUh/q/HRh7HHBWKFC7MlzmGmlqF
 KvSuMxtdLrgMWQappG8AuyThsG+Re64Y/1eo7CEfpQiWMs7rm4QRPesxHoAcTTuYPn0w
 qQ68n5tTWy+ExYsYfNn4Wlb5gCtWMVmpt5ZYfuXOjLfTCYQPA8/mL7/D7Q/+MRgJjYkl
 lD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791490910; x=1792095710;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZAEiWS1VLm9b/lpX7haGH6Eqf/4mSJWPRfq8ClPpCdI=;
 b=VUi498B6ntPMcuNWUyNMIC7vqxj9/BnR+VdSyoMBy4+OnYZVKPsIl0vYQirdJvV9Vf
 ah9izbGNGi99vhdnBxTv+WVE7OsTjAwZ0ogg6nzQzynKC/SoFEAen6aGJtp59U6SGdL/
 xXl6zzB9p/SvDX3wn6XQPJVu7rqDcCMEqY+wiC90mtWbkRGYgJHTGvYdPBeYprTIiNYU
 jJvR7qdcIy9uAf9ln9lOxlnyjq2n8P0gYWNhyf4Qvjnljo5sfCSltXj/HMkd2a1hZXRF
 6PS6Mmwb5lysPa0HxAUuvFkeI/v78hNuOJr7A16/2SDtiQu3YVp6RvuNOxr7BksOLZ4i
 WhUg==
X-Gm-Message-State: AFuF++n5W8pIYOYfoNNNERLG5/QoBj1zrPO8EjD4fCuJsNDp0f/pk/6G
 I7NIIGenTbiU9LwsUUfrX0ecUgQ0FOA0MQGRPzyMAi/sSUKAGq7OIt7r6jn9uOh8
X-Gm-Gg: AYBFou1ZAghNv81x1g/aZFeqcbpv5s7FzGi9tl1KnZnRLcBLSe1SYpbxKSP/Strrsiv
 mG7e9pP/fhR8Y2R2i2UpcZXvSYUT0+qRbMvmck64IVpPuR635lWpEtXvvy9FuZP1bI6ViXH1uBC
 02qoLY/lSO6CVGFjbJAV/7TCvkBX6uA8hnuAjuUGu9ZDUx5mEycIFXbWClqh71OvkYkvklY93zK
 Y+nlGUv7jNEDKyhsembd4g/g0aztc3av9J5yYLr56GIWNfQGwt0amcq6q+APfppHPAzI1fTz53s
 9iECyD4mggY/XirYuapqpuPiw4hRnW9kU2ksi+MytDJcT3Kfcnh6Y7Upt5n4xeA2J2kDiFkld9O
 gt0hRBGLsWKYpapdLyBCQGX22g43v4tdJvroFnMGqnPwjuG7KioMr0yhk8G/1nBBa3mNNyyEqHK
 PDky9pGN6krMZW9K3Js23YhaIi6/K1tw+Gq1ZcSWLjmx72vd+EaxZrCPf9BRnja5rpxRVAwyjj1
 aZkxadbSIHc
X-Received: by 2002:a05:6808:2e4d:b0:4d6:9133:cfee with SMTP id
 5614622812f47-50b6a26971fmr188780b6e.51.1791490910046; 
 Thu, 08 Oct 2026 13:21:50 -0700 (PDT)
Received: from timur-max.localnet ([189.139.17.135])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50b39ea3e47sm348570b6e.0.2026.10.08.13.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 13:21:49 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, David Rosca <david.rosca@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] drm/amdgpu/uvd3.1: Fix checking whether UVD firmware
 keyselect was already set
Date: Thu, 08 Oct 2026 14:21:48 -0600
Message-ID: <qL_HOE9OSUS1vue796-bIQ@gmail.com>
In-Reply-To: <deb0ff06-fcb5-4d0d-9cdd-ade4e5b83f2a@amd.com>
References: <20261006211607.75407-1-timur.kristof@gmail.com>
 <deb0ff06-fcb5-4d0d-9cdd-ade4e5b83f2a@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. okt=C3=B3ber 7., szerda 7:50:29 k=C3=B6z=C3=A9ps=C5=91 =C3=A1llamo=
kbeli z=C3=B3naid=C5=91 Mario=20
Limonciello wrote:
> On 10/6/26 16:16, Timur Krist=C3=B3f wrote:
> > The PASS_MASK is for a different register not for UVD_FW_START.
> > It was a mistake to check this flag. It should be enough to check
> > that the register is non-zero.
> >=20
> > Fixes: 13e4cf116dbf ("drm/amdgpu/uvd3.1: Don't validate the firmware wh=
en
> > already validated") Signed-off-by: Timur Krist=C3=B3f
> > <timur.kristof@gmail.com>
>=20
> Can you have a look at the Sashiko feedback:
>=20
> https://sashiko.dev/#/patchset/20261006211607.75407-1-timur.kristof%40gma=
il.
> com

Hi Mario,

This patch simply fixes a typo in my previous patch that I referenced in th=
e=20
=46ixes tag above. The PASS_MASK field doesn't belong to the UVD_FW_START=20
register, it was simply a mistake on my part.

All in all, I'm not sure what to do with this feedback, as the patch is jus=
t=20
fixing a typo and doesn't introduce any of the issues that the bot is=20
complaining about. In general, it might be a good idea to do something when=
=20
the firmware validation fails (though it's out of scope for this patch). Fo=
r=20
example we could ignore the UVD block and move forward without it. We=20
discussed this briefly some time ago with Alex, and the conclusion was the =
we=20
prefer not to support "degraded" functionality in amdgpu. We could try to=20
reset the GPU and try the firmware validation again, but then there is no=20
reason to assume it has any chance of success if it had already failed befo=
re.

I'll try to respond to some points from the bot's feedback below:

> Does this check falsely succeed if a previous validation attempt
> timed out or failed?

According to my current understanding, the FW validator always fails on the=
=20
second attempt (even if the first attempt was successful).
If firmware validation fails or times out, then the driver simply fails to=
=20
initialize and won't retry again AFAIK. The purpose of checking the registe=
r=20
is to prevent trying to validate again because the second attempt always=20
fails, which can leave the GPU in a bad state after a suspend/resume cycle =
(on=20
systems where suspend doesn't completely power off the GPU).

> If uvd_v3_1_fw_validate() times out or fails after writing
> to mmUVD_FW_START, the register remains non-zero.

Yes. If uvd_v3_1_fw_validate() fails, then amdgpu just fails to initialize =
(or=20
fails to resume from suspend) and will never recover. This is how it always=
=20
was and my patch doesn't change that.

> Upon initialization failure, amdgpu_device_ip_fini()
> skips hw_fini for the UVD block. [...]

As far as I see amdgpu_device_ip_fini() doesn't call hw_fini() at all for a=
ny=20
block, so this argument doesn't make sense to me.

> Furthermore, for SI ASICs (the only users of UVD 3.1),
> si_need_reset_on_init() unconditionally returns false,
> meaning the ASIC is not automatically reset on a subsequent driver reload.
> [...]
> Consequently, upon driver reload, this check will see the leftover non-ze=
ro
> value and immediately return 0. The driver will then incorrectly assume
> validation succeeded and use the uninitialized UVD block, which can lead =
to
> ring test failures or GPU hangs.

This is true, though isn't changed or affected in any way by this patch.

> If validation fails later in this function, does this leak the
> UVD DPM clocks? [...]
> As a result, the UVD clocks enabled before calling uvd_v3_1_fw_validate()
> are never disabled on failure.

Again, if uvd_v3_1_fw_validate() fails then the driver just fails to=20
initialize and the GPU isn't recovered. This isn't changed or affected in a=
ny=20
way by this patch (or the previous one). So it doesn't matter what we do wi=
th=20
the clocks.






