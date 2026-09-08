Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803B8C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 21:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1912810E53E;
	Tue,  8 Sep 2026 21:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eVnXVU42";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C4410E492
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 21:41:25 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2566so953831a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 14:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788903685; cv=none;
 d=google.com; s=arc-20260327;
 b=bQFMthxsotBnpS7rvpDJawR0QDv+yG24mh8Z8grAr3NkUyi+mfEQAD/9WD/r2OFD58
 U4ZZbAEb0IPfK2c6PZilcBHexJEYYJREMy/J9y/snfE4twxFcEZTd7NjBJDX9Sj/2W5M
 uPAwMcppykmbuDbiwMBtUEpegE+azzyHnXPQk+Athx0TIHfg6Ay9CTSLBsCEVrTWbtp7
 CNvV7xX1KMzLXYE6JkJHBHBdegrX+ZK885MEADXDc9gYhxtU7zMgFQDtW5aYdOYDuWOx
 uly+s2xbnhps6uQftNC29QN8rBk0r/FpWO/Ya79NLSwgiXeW+Tv/eZ6n9GRyALGuRGtG
 68GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8rQkd5Au7Y+YHu9zGBjXy6N5KCdPe9r93Bw6y8CKr6U=;
 fh=YSrN6xC5oxTPVWwOqXqlCZw/or+dsah/PxOYrr02mLA=;
 b=H3vrXxCS3vUfkLXQiih2bgxJTWyuMIaqkehY27e3x8FR5nHmp96DjrVQSdlWDMmU0p
 HtKFUdBkAhOlDb9tEf2iC0Lvf7qYzDWyh5mgiXg/uGwOdmJbotUAiqmdsXXlA9TU0uL0
 WvXEZgYPvjACyd6GAyHHdWwEBpJePPADgCvnnEqkCcKmWCJHx90ckJgH9ODaX8wYd/Hp
 fED3QJyetuLG6ZdyNN5VLJLavOF7FwqxtoK84SKtcfaY7P+Dl5HRHbAybu7vff1j7cGs
 bbw94Uw85E46kYn0vlECcEMIUxb0i5aGqqD0QraLU/GQS0DAZ2OUcuA0C6L+GREWw6wX
 KZ+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788903685; x=1789508485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8rQkd5Au7Y+YHu9zGBjXy6N5KCdPe9r93Bw6y8CKr6U=;
 b=eVnXVU42YD6Q/TdK52pBkpcReBFPM9KInHfs2N3PN45u4dObc6KTyMnXBE0z6ggFDd
 hOt45gzcYlqXbLGDynndTyD6ZoEukt2YNcaaTid2T7f92Tj7Hp2y8iev3Kmnt6f8XGNl
 WGaZ2SOpRJAzUdTcDB5oNUi4bi/MxHaYhfi2VPK/t0toQGPQvZImgOiSWN2m1cSDxpQ8
 aFbndUXLiiljt3PVBk0AWlbUc1yEUurypXnf2BdtgvBANlyVHShlt35T9/sYSlJsjX9+
 SKwJSdmNZHRJ8wHC8Mazm+b/yzjJm4TC2ZhoUk70xpRuofzY7mHXdcyUDLrdo1Vtnxo4
 TyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788903685; x=1789508485;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8rQkd5Au7Y+YHu9zGBjXy6N5KCdPe9r93Bw6y8CKr6U=;
 b=Jn4rnq9XqJlCY8C4RlY1PiyZkzdl0E830rX7KA6SfqKMIDv+ziGuK+KJ7Z8gZxyE1u
 Uhax+7mCSfZ8fuY2x/dDIRp+RfTpHbMJk3Oo2H9cY1+yduhM3g5Sa3ZMZKUCaoNF7gqq
 gT/aljNrzq/UCK/EseJyRtA33D0xjqZFwDb5i1V8jLPHRcWUkRTZ8F+nglJ9gVA/yEw1
 /9zUdkMPrQLrvXIKXgGNGIF/YHwCoY4sdbmR1gS0eY4plxe8e8jvbqIlKy0IE1Ux2kSr
 Cy++ga/9SnJ8QH/EK+gtETumr/voavqsiCLZbkJO7v6VuNqR7g9mTryRzFeRWPi9YNiS
 GJKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9luUoGgNwz/CCiXxuI7fgYymNVUFwYj+13b8cy1GDv1OoqmfBl3+23AatPmRSLbN4eySavIQ9@lists.freedesktop.org
X-Gm-Message-State: AFuF++mNwzygvu0tu3CM+EheSc5LEJNC7zOFFr2LTk4336o4Al/pWewb
 CF4WI7cZdNOv6mfaQCgkwUFkB4tX4jntyGpO+ArOzM5vHmBp+0uOKVOu94gmw4rSxKOH2QphNIK
 vdydxtJ2L0iae8nZD/vg5/b8uyroD7k8=
X-Gm-Gg: AYBFou0VgUrJEeGnBF/VCqL40Gzo355LLhHluZ2A+fzQa/hoYo5u+peRti+rSc2U82K
 bPxdZ/Eyt5VssEPnqVffH5gGQcvH3uM0HbDsTSm/LI58nhcxIxPCi4GcFzyXPpSimIu/5AQoFEN
 g3xKDw7bczVqb8FE1B5XgdO3IqxTViAvW4Kdnq+OEH9uVq/MRK4kzsfguzMlJHlrVvuUowJ/TUC
 qayFDwVgpQk8b+0K4D00ztIaM+Fi8J6MHZE9q5LkPwFokJEFE00DR6d9cAhpu0GBKq7lutqLUqj
 OmRbJsWFv46CGTZIOXGtXZTmxZDq5RIva2MXqwi2xMcINfNishnpJKGTJlS2s1v+yQvcmvtNv85
 VrApAT0HvHBLIju8TgpR5CcIZGw+7ogk=
X-Received: by 2002:a17:90b:3a48:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-39b3d5e53d5mr20820843a91.2.1788903685198; Tue, 08 Sep 2026
 14:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-amdgpu-ras-wifpts-v1-1-7f3b4528f12c@kernel.org>
In-Reply-To: <20260903-amdgpu-ras-wifpts-v1-1-7f3b4528f12c@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 17:41:12 -0400
X-Gm-Features: AcwNN1XCfKRR9Pp_3osr-NXErQWimzUuIEmAIhBaOCMAWbp5aPXAHcWmLCqHV_s
Message-ID: <CADnq5_NZKS0Ng_8sy=AS=Jby_6dCwVKMziyvRgK8XHVYEQRD1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/ras: Adjust second parameter of
 mp1_v13_0_eeprom_send_msg()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Thu, Sep 3, 2026 at 3:40=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> When building with -Wincompatible-function-pointer-types-strict, a
> warning designed to catch kernel control flow integrity (kCFI) issues at
> build time, there is an instance around mp1_v13_0_eeprom_send_msg():
>
>   drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/amdgpu_ras_mp1_v13_0.c:157:25=
: error: incompatible function pointer types initializing 'int (*)(struct r=
as_core_context *, u32, uint32_t, uint32_t *)' (aka 'int (*)(struct ras_cor=
e_context *, unsigned int, unsigned int, unsigned int *)') with an expressi=
on of type 'int (struct ras_core_context *, enum ras_fw_eeprom_cmd, uint32_=
t, uint32_t *)' (aka 'int (struct ras_core_context *, enum ras_fw_eeprom_cm=
d, unsigned int, unsigned int *)') [-Werror,-Wincompatible-function-pointer=
-types-strict]
>     157 |         .mp1_send_eeprom_msg =3D mp1_v13_0_eeprom_send_msg,
>         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> While 'u32' and 'enum ras_fw_eeprom_cmd' are ABI compatible, hence no
> regular warning from -Wincompatible-function-pointer-types, the mismatch
> will trigger a kCFI violation when mp1_v13_0_eeprom_send_msg() is called
> indirectly.
>
> Update the second parameter of mp1_v13_0_eeprom_send_msg()' to be
> 'u32 msg_id' to match the prototype in 'struct ras_mp1_sys_func' (which
> was recently changed to support mp1_v15_0), clearing up the warning and
> kCFI violation.
>
> Fixes: 11a948c7817b ("drm/amd/ras: Support retrieving bad page info from =
mp1_v15_0")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/dri=
vers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> index 7aa818a433f6..548594373d0b 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
> @@ -105,14 +105,14 @@ static int mp1_v13_0_dump_valid_bank(struct ras_cor=
e_context *ras_core,
>  }
>
>  static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
> -                               enum ras_fw_eeprom_cmd index, uint32_t pa=
ram, uint32_t *read_arg)
> +                               u32 msg_id, uint32_t param, uint32_t *rea=
d_arg)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
>         int ret =3D 0;
>
>         if (down_read_trylock(&adev->reset_domain->sem)) {
>                 ret =3D mp1_v13_send_smu_msg(adev,
> -                       pmfw_eeprom_msgs[index], param, read_arg);
> +                       pmfw_eeprom_msgs[msg_id], param, read_arg);
>                 up_read(&adev->reset_domain->sem);
>         } else {
>                 ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
>
> ---
> base-commit: 8fad652e7235dbf3bebfab1460610b0b0e75b199
> change-id: 20260902-amdgpu-ras-wifpts-c8628642e565
>
> Best regards,
> --
> Cheers,
> Nathan
>
