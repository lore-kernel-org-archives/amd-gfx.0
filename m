Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F524C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 15:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711D32072D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oENxH/IX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711D32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2248C6E378;
	Tue, 25 Aug 2020 15:53:40 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50ED56E378
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 15:53:38 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id q14so2103973wrn.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ngF6uQU7ixuw1XTRo+qAFuLlBMgKSvdUAuJUoOBqwdY=;
 b=oENxH/IXbCa/MPNT8mGgy1BtL89X9h94SDCQwQl6tUx0iUKzrqpfP45kt0ebBHNq7b
 OySqEWJUENyZqq8yEOyjca0OPruEEFawqb+hMxLlfAICzl1ISqM1YKh1HFrExLSpXOEl
 iPo5/2xoKKqeOl8hQe+whRwZBmV+uGbpIbG02POnN/W6MgYohaVTV3XKwT4Ri6/jo+1T
 gUb+J+y55v4CXi1X8pOQUzousxQ1BfJWC8Cek4kDiZZmBeoyGu5ZA/Sei0UZCr+o9Rnf
 7UtpSL6E5lC2p0QBcjf+9k6GZKZXG0/JRARQTNC/sw3Pp2b5ZQ4a74aVvPwxq2wr8tMG
 SQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ngF6uQU7ixuw1XTRo+qAFuLlBMgKSvdUAuJUoOBqwdY=;
 b=PZyPeoyHZfpJepUxXdo+2UkMGw/nvOzSEc4FepA2OLiq4bcBoNEVEaVg8OSkkGz5Xj
 Rob07CcvH33aycEFo023tz9iRbPU9MH4yyjjMUZMpNLvypCmzbV50nTZNDlv2Ox1+STw
 fIws+44EFQwg9EibThw+BrQ/qXAYwI0q31CCWhB4H9iTtKpOiXIGsxzeAyPFfIKLjtPy
 N/7c9nReFhMGlqd3+rqhC1omSjvNZRMSoDJTv8veOSJT2M4Th51n1u02lk0/ZDm7s3Tb
 64nOUejMswX1WC+ddMFd88Y3mnWyOGL5HxORaJlSr0W7l9DvIO7Q1mFWDhxutjwym0/w
 WYtw==
X-Gm-Message-State: AOAM530kXwV/SSkjZtsrQCVzNGzKrgKTU19iYBC5UoB8btyzs8mjpzBT
 JMe5pimYBp78xV9lgdWwUfO4klgXsdGGHA1nKXk=
X-Google-Smtp-Source: ABdhPJwcSV0L9bNnZQyxrgFaK3WFC/84MX5EFoIJAAr/QfLV3IcsmFfcULizfNldA9Qq0O10yVKdLzISnQftAl9vzaE=
X-Received: by 2002:a5d:6085:: with SMTP id w5mr11115815wrt.362.1598370816918; 
 Tue, 25 Aug 2020 08:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200825111843.GA285523@mwanda>
In-Reply-To: <20200825111843.GA285523@mwanda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Aug 2020 11:53:25 -0400
Message-ID: <CADnq5_O0f7NdR92PSKFS0zrN4oFb_WJXX1E_HQ9uHzM-4NL2OQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/si: Fix buffer overflow in
 si_get_register_value()
To: Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: multipart/mixed; boundary="000000000000c3237905adb5b4d3"
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
Cc: Alex Jivin <alex.jivin@amd.com>, Frederick Lawler <fred@fredlawl.com>,
 David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Sonny Jiang <sonny.jiang@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000c3237905adb5b4d3
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 25, 2020 at 7:21 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The values for "se_num" and "sh_num" come from the user in the ioctl.
> They can be in the 0-255 range but if they're more than
> AMDGPU_GFX_MAX_SE (4) or AMDGPU_GFX_MAX_SH_PER_SE (2) then it results in
> an out of bounds read.
>
> I split this function into to two to make the error handling simpler.
>
> Fixes: dd5dfa61b4ff ("drm/amdgpu: refine si_read_register")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch.  This is more defensive, but It's a much simpler check to
validate these in the caller.  See the attached patch.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/si.c | 157 +++++++++++++++++---------------
>  1 file changed, 85 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index e330884edd19..ccf39a6932ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1051,81 +1051,90 @@ static struct amdgpu_allowed_register_entry si_allowed_read_registers[] = {
>         {PA_SC_RASTER_CONFIG, true},
>  };
>
> -static uint32_t si_get_register_value(struct amdgpu_device *adev,
> -                                     bool indexed, u32 se_num,
> -                                     u32 sh_num, u32 reg_offset)
> -{
> -       if (indexed) {
> -               uint32_t val;
> -               unsigned se_idx = (se_num == 0xffffffff) ? 0 : se_num;
> -               unsigned sh_idx = (sh_num == 0xffffffff) ? 0 : sh_num;
> -
> -               switch (reg_offset) {
> -               case mmCC_RB_BACKEND_DISABLE:
> -                       return adev->gfx.config.rb_config[se_idx][sh_idx].rb_backend_disable;
> -               case mmGC_USER_RB_BACKEND_DISABLE:
> -                       return adev->gfx.config.rb_config[se_idx][sh_idx].user_rb_backend_disable;
> -               case mmPA_SC_RASTER_CONFIG:
> -                       return adev->gfx.config.rb_config[se_idx][sh_idx].raster_config;
> -               }
> +static int si_get_register_value_indexed(struct amdgpu_device *adev,
> +                                         u32 se_num, u32 sh_num,
> +                                         u32 reg_offset, u32 *value)
> +{
> +       unsigned se_idx = (se_num == 0xffffffff) ? 0 : se_num;
> +       unsigned sh_idx = (sh_num == 0xffffffff) ? 0 : sh_num;
>
> -               mutex_lock(&adev->grbm_idx_mutex);
> -               if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -                       amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
> +       if (se_idx >= AMDGPU_GFX_MAX_SE ||
> +           sh_idx >= AMDGPU_GFX_MAX_SH_PER_SE)
> +               return -EINVAL;
>
> -               val = RREG32(reg_offset);
> +       switch (reg_offset) {
> +       case mmCC_RB_BACKEND_DISABLE:
> +               *value = adev->gfx.config.rb_config[se_idx][sh_idx].rb_backend_disable;
> +               return 0;
> +       case mmGC_USER_RB_BACKEND_DISABLE:
> +               *value = adev->gfx.config.rb_config[se_idx][sh_idx].user_rb_backend_disable;
> +               return 0;
> +       case mmPA_SC_RASTER_CONFIG:
> +               *value = adev->gfx.config.rb_config[se_idx][sh_idx].raster_config;
> +               return 0;
> +       }
>
> -               if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -                       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> -               mutex_unlock(&adev->grbm_idx_mutex);
> -               return val;
> -       } else {
> -               unsigned idx;
> -
> -               switch (reg_offset) {
> -               case mmGB_ADDR_CONFIG:
> -                       return adev->gfx.config.gb_addr_config;
> -               case mmMC_ARB_RAMCFG:
> -                       return adev->gfx.config.mc_arb_ramcfg;
> -               case mmGB_TILE_MODE0:
> -               case mmGB_TILE_MODE1:
> -               case mmGB_TILE_MODE2:
> -               case mmGB_TILE_MODE3:
> -               case mmGB_TILE_MODE4:
> -               case mmGB_TILE_MODE5:
> -               case mmGB_TILE_MODE6:
> -               case mmGB_TILE_MODE7:
> -               case mmGB_TILE_MODE8:
> -               case mmGB_TILE_MODE9:
> -               case mmGB_TILE_MODE10:
> -               case mmGB_TILE_MODE11:
> -               case mmGB_TILE_MODE12:
> -               case mmGB_TILE_MODE13:
> -               case mmGB_TILE_MODE14:
> -               case mmGB_TILE_MODE15:
> -               case mmGB_TILE_MODE16:
> -               case mmGB_TILE_MODE17:
> -               case mmGB_TILE_MODE18:
> -               case mmGB_TILE_MODE19:
> -               case mmGB_TILE_MODE20:
> -               case mmGB_TILE_MODE21:
> -               case mmGB_TILE_MODE22:
> -               case mmGB_TILE_MODE23:
> -               case mmGB_TILE_MODE24:
> -               case mmGB_TILE_MODE25:
> -               case mmGB_TILE_MODE26:
> -               case mmGB_TILE_MODE27:
> -               case mmGB_TILE_MODE28:
> -               case mmGB_TILE_MODE29:
> -               case mmGB_TILE_MODE30:
> -               case mmGB_TILE_MODE31:
> -                       idx = (reg_offset - mmGB_TILE_MODE0);
> -                       return adev->gfx.config.tile_mode_array[idx];
> -               default:
> -                       return RREG32(reg_offset);
> -               }
> +       mutex_lock(&adev->grbm_idx_mutex);
> +       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff);
> +
> +       *value = RREG32(reg_offset);
> +
> +       if (se_num != 0xffffffff || sh_num != 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +       mutex_unlock(&adev->grbm_idx_mutex);
> +       return 0;
> +}
> +
> +static uint32_t si_get_register_value(struct amdgpu_device *adev,
> +                                     u32 reg_offset)
> +{
> +       unsigned idx;
> +
> +       switch (reg_offset) {
> +       case mmGB_ADDR_CONFIG:
> +               return adev->gfx.config.gb_addr_config;
> +       case mmMC_ARB_RAMCFG:
> +               return adev->gfx.config.mc_arb_ramcfg;
> +       case mmGB_TILE_MODE0:
> +       case mmGB_TILE_MODE1:
> +       case mmGB_TILE_MODE2:
> +       case mmGB_TILE_MODE3:
> +       case mmGB_TILE_MODE4:
> +       case mmGB_TILE_MODE5:
> +       case mmGB_TILE_MODE6:
> +       case mmGB_TILE_MODE7:
> +       case mmGB_TILE_MODE8:
> +       case mmGB_TILE_MODE9:
> +       case mmGB_TILE_MODE10:
> +       case mmGB_TILE_MODE11:
> +       case mmGB_TILE_MODE12:
> +       case mmGB_TILE_MODE13:
> +       case mmGB_TILE_MODE14:
> +       case mmGB_TILE_MODE15:
> +       case mmGB_TILE_MODE16:
> +       case mmGB_TILE_MODE17:
> +       case mmGB_TILE_MODE18:
> +       case mmGB_TILE_MODE19:
> +       case mmGB_TILE_MODE20:
> +       case mmGB_TILE_MODE21:
> +       case mmGB_TILE_MODE22:
> +       case mmGB_TILE_MODE23:
> +       case mmGB_TILE_MODE24:
> +       case mmGB_TILE_MODE25:
> +       case mmGB_TILE_MODE26:
> +       case mmGB_TILE_MODE27:
> +       case mmGB_TILE_MODE28:
> +       case mmGB_TILE_MODE29:
> +       case mmGB_TILE_MODE30:
> +       case mmGB_TILE_MODE31:
> +               idx = (reg_offset - mmGB_TILE_MODE0);
> +               return adev->gfx.config.tile_mode_array[idx];
> +       default:
> +               return RREG32(reg_offset);
>         }
>  }
> +
>  static int si_read_register(struct amdgpu_device *adev, u32 se_num,
>                              u32 sh_num, u32 reg_offset, u32 *value)
>  {
> @@ -1138,8 +1147,12 @@ static int si_read_register(struct amdgpu_device *adev, u32 se_num,
>                 if (reg_offset != si_allowed_read_registers[i].reg_offset)
>                         continue;
>
> -               *value = si_get_register_value(adev, indexed, se_num, sh_num,
> -                                              reg_offset);
> +               if (indexed)
> +                       return si_get_register_value_indexed(adev,
> +                                                            se_num, sh_num,
> +                                                            reg_offset, value);
> +
> +               *value = si_get_register_value(adev, reg_offset);
>                 return 0;
>         }
>         return -EINVAL;
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000c3237905adb5b4d3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-Fix-buffer-overflow-in-INFO-ioctl.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-Fix-buffer-overflow-in-INFO-ioctl.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kea4oh2s0>
X-Attachment-Id: f_kea4oh2s0

RnJvbSAyZDZjMWFiYWVhYjU0NTYxNDUyYjE0YzVkNzAyZjUxMjM1YWU1YTcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMjUgQXVnIDIwMjAgMTE6NDM6NDUgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBGaXggYnVmZmVyIG92ZXJmbG93IGluIElORk8gaW9jdGwKClRoZSB2YWx1
ZXMgZm9yICJzZV9udW0iIGFuZCAic2hfbnVtIiBjb21lIGZyb20gdGhlIHVzZXIgaW4gdGhlIGlv
Y3RsLgpUaGV5IGNhbiBiZSBpbiB0aGUgMC0yNTUgcmFuZ2UgYnV0IGlmIHRoZXkncmUgbW9yZSB0
aGFuCkFNREdQVV9HRlhfTUFYX1NFICg0KSBvciBBTURHUFVfR0ZYX01BWF9TSF9QRVJfU0UgKDIp
IHRoZW4gaXQgcmVzdWx0cyBpbgphbiBvdXQgb2YgYm91bmRzIHJlYWQuCgpSZXBvcnRlZC1ieTog
RGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgpTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCmluZGV4
IDdhZThiMGVlNDYxMC4uOWY4MGVhZWFmMGFlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfa21zLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ttcy5jCkBAIC02NjksOCArNjY5LDEyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2luZm9f
aW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxl
CiAJCSAqIGluIHRoZSBiaXRmaWVsZHMgKi8KIAkJaWYgKHNlX251bSA9PSBBTURHUFVfSU5GT19N
TVJfU0VfSU5ERVhfTUFTSykKIAkJCXNlX251bSA9IDB4ZmZmZmZmZmY7CisJCWVsc2UgaWYgKHNl
X251bSA+PSBBTURHUFVfR0ZYX01BWF9TRSkKKwkJCXJldHVybiAtRUlOVkFMOwogCQlpZiAoc2hf
bnVtID09IEFNREdQVV9JTkZPX01NUl9TSF9JTkRFWF9NQVNLKQogCQkJc2hfbnVtID0gMHhmZmZm
ZmZmZjsKKwkJZWxzZSBpZiAoc2hfbnVtID49IEFNREdQVV9HRlhfTUFYX1NIX1BFUl9TRSkKKwkJ
CXJldHVybiAtRUlOVkFMOwogCiAJCWlmIChpbmZvLT5yZWFkX21tcl9yZWcuY291bnQgPiAxMjgp
CiAJCQlyZXR1cm4gLUVJTlZBTDsKLS0gCjIuMjUuNAoK
--000000000000c3237905adb5b4d3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000c3237905adb5b4d3--
