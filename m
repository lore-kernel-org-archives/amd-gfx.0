Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB80C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 05:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9319D10F3B9;
	Thu, 21 Apr 2022 05:31:31 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A412D10F3B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 05:31:30 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-e5ca5c580fso4356482fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=voMHy23gW1h3blc95jnuSihEdJXRzJQNQ3NZistRslE=;
 b=GJ2hvRMwraM6b2g/3LFxOpeH/8yVo/lEcUpTII/jSZES+rZSG6WRVaXewLX+oaySql
 OMHm3pimEC4JCiE60YnMrNM5atRemzYP7zi0unmhlfxzzsfBQA6B1pg68IduCvRAKRfc
 FJDkaS390tloDEvzTMZ0ADYUawzvQSNZOoi3ATZo12BCZsshs//kpBz2Tr4YLZ/Q70I3
 fdtxYlPO619RNVXdkiGu1gA3jSFQQ6zDYkkxnwNzdOA6XHfDdE6DEa0krYanuiJ/UPhr
 a0BnNYEQRJX+slkAsCj+qsK06ktF5+UjJSUvHw6mxbEEWVlSQavG1q6lYG62SnQ4BRx/
 bmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=voMHy23gW1h3blc95jnuSihEdJXRzJQNQ3NZistRslE=;
 b=KVMi0zw6ZZfTQ7pOHhmTn6fdhCPCFpKAX8EKnyv4UaWoz5w71Z4YwDRuNIB5lbTgNR
 QKOAr+XWuCPweB6EuGi/+96gGF+TP5wiCzkkdcgkBC3mbAu07HT6I4XcT89eVOq3WalJ
 cK4ylscb/wpRStPq2Xd4sZ4FNg7XY5g/c83oLGsBYEytkBqYO2Lz+iH5iFaeh17HbDHz
 t2zrNgXC5SuXYKep9WI6PpR561ExhFZ5UVTx0454XgCf+8d6biDK8M1Q58tX6SQWPdDD
 dxB9Jmq+z6lTvnPTj2NFXgAYoWun4ha45didob46S8wJmYBzBLiK1+GA6hyCs5gJefAY
 e3Kg==
X-Gm-Message-State: AOAM5320s2DYXvFF95npL11Q6lnjD8uCrhrFUFhYbhwY/Pal8j4seAwx
 Jn1uKzMX4kYXTIkITo0PFfnxOwuTqTunUNIQf0KIKEpp
X-Google-Smtp-Source: ABdhPJz0LlVgNv5oUUGUiMQsDNnuYgAvytPlaAFD3mEbU0s9EVUyB56uNuOClW10CXyp29xjj+iXZDu15tDZDvBz/IU=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr3247610oap.253.1650519089897; Wed, 20
 Apr 2022 22:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220420214715.2644898-1-shiwei.wong@amd.com>
In-Reply-To: <20220420214715.2644898-1-shiwei.wong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Apr 2022 01:31:18 -0400
Message-ID: <CADnq5_ORQYj6ro4u9P4j7+NHVCMmn-iJ_FNzcNsiVHCro0J8KQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed v2
To: Alice Wong <shiwei.wong@amd.com>
Content-Type: multipart/mixed; boundary="0000000000000c78db05dd236cc1"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000000c78db05dd236cc1
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 20, 2022 at 5:48 PM Alice Wong <shiwei.wong@amd.com> wrote:
>
> If at any point psp_hw_init failed, psp_hw_fini would not be called
> during unload due to ip_blocks[PSP].status.hw not being set to true.
> This could cause a memory leak when the driver unloads.
> As a rule of thumb, each IP block should cleanup themselves when
> their hw_init fails. Only previously intialized blocks should
> be cleaned up by the common framework.
>
> v1: Call IP blocks' respective hw_fini when hw_init failed from
>     the common framework
> v2: Call psp_hw_fini when psp_hw_init failed.
>
> Signed-off-by: Alice Wong <shiwei.wong@amd.com>

I don't think this is a good idea.  The hw programming in hw_fini
makes no sense if the driver never set it up in the first place if
hw_init failed before initializing the hw.  It would be better to just
properly unwind the relevant functions.  Presumably the problem you
are seeing is the failure to free the GPU memory allocated in fw_fini,
depending on where it fails.  We should just allocate the memory in
sw_init; that is what we do in other IPs.  Does the attached patch fix
the issue you are seeing?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57 +++++++++++++------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 5b9e48d44f5b..52b14efa848a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2537,6 +2537,34 @@ static int psp_load_fw(struct amdgpu_device *adev)
>         return ret;
>  }
>
> +static int psp_hw_fini(void *handle)
> +{
> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +       struct psp_context *psp = &adev->psp;
> +
> +       if (psp->ta_fw) {
> +               psp_ras_terminate(psp);
> +               psp_securedisplay_terminate(psp);
> +               psp_rap_terminate(psp);
> +               psp_dtm_terminate(psp);
> +               psp_hdcp_terminate(psp);
> +       }
> +
> +       psp_asd_terminate(psp);
> +
> +       psp_tmr_terminate(psp);
> +       psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> +
> +       amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> +                             &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> +       amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> +                             &psp->fence_buf_mc_addr, &psp->fence_buf);
> +       amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> +                             (void **)&psp->cmd_buf_mem);
> +
> +       return 0;
> +}
> +
>  static int psp_hw_init(void *handle)
>  {
>         int ret;
> @@ -2563,37 +2591,10 @@ static int psp_hw_init(void *handle)
>  failed:
>         adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
>         mutex_unlock(&adev->firmware.mutex);
> +       psp_hw_fini(handle);
>         return -EINVAL;
>  }
>
> -static int psp_hw_fini(void *handle)
> -{
> -       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -       struct psp_context *psp = &adev->psp;
> -
> -       if (psp->ta_fw) {
> -               psp_ras_terminate(psp);
> -               psp_securedisplay_terminate(psp);
> -               psp_rap_terminate(psp);
> -               psp_dtm_terminate(psp);
> -               psp_hdcp_terminate(psp);
> -       }
> -
> -       psp_asd_terminate(psp);
> -
> -       psp_tmr_terminate(psp);
> -       psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> -
> -       amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> -                             &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> -       amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> -                             &psp->fence_buf_mc_addr, &psp->fence_buf);
> -       amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> -                             (void **)&psp->cmd_buf_mem);
> -
> -       return 0;
> -}
> -
>  static int psp_suspend(void *handle)
>  {
>         int ret;
> --
> 2.25.1
>

--0000000000000c78db05dd236cc1
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-psp-move-PSP-memory-alloc-from-hw_init-to.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-psp-move-PSP-memory-alloc-from-hw_init-to.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l28ke24v0>
X-Attachment-Id: f_l28ke24v0

RnJvbSBmOThhMTU3ZDUyZTE5OWM4NTMwZGMwZWZjOTFiYTNiZDViN2NlM2NjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMjEgQXByIDIwMjIgMDE6MjE6NTIgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L3BzcDogbW92ZSBQU1AgbWVtb3J5IGFsbG9jIGZyb20gaHdfaW5pdCB0byBz
d19pbml0CgpNZW1vcnkgYWxsb2NhdGlvbnMgc2hvdWxkIGJlIGRvbmUgaW4gc3dfaW5pdC4gIGh3
X2luaXQgc2hvdWxkCmp1c3QgYmUgaGFyZHdhcmUgcHJvZ3JhbW1pbmcgbmVlZGVkIHRvIGluaXRp
YWxpemUgdGhlIElQIGJsb2NrLgpUaGlzIGlzIGhvdyBtb3N0IG90aGVyIElQIGJsb2NrcyB3b3Jr
LiAgTW92ZSB0aGUgR1BVIG1lbW9yeQphbGxvY2F0aW9ucyBmcm9tIHBzcCBod19pbml0IHRvIHBz
cCBzd19pbml0IGFuZCBtb3ZlIHRoZSBtZW1vcnkKZnJlZSB0byBzd19maW5pLiAgVGhpcyBhbHNv
IGZpeGVzIGEgcG90ZW50aWFsIEdQVSBtZW1vcnkgbGVhawppZiBwc3AgaHdfaW5pdCBmYWlscy4K
ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCA5NSArKysrKysr
KysrKystLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgNDgg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4
IGE2YWNlYzFhNjE1NS4uMjFhYTU1NmE2YmVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jCkBAIC0zNTcsNyArMzU3LDM5IEBAIHN0YXRpYyBpbnQgcHNwX3N3X2luaXQo
dm9pZCAqaGFuZGxlKQogCQl9CiAJfQogCisJcmV0ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwo
YWRldiwgUFNQXzFfTUVHLCBQU1BfMV9NRUcsCisJCQkJICAgICAgYW1kZ3B1X3NyaW92X3ZmKGFk
ZXYpID8KKwkJCQkgICAgICBBTURHUFVfR0VNX0RPTUFJTl9WUkFNIDogQU1ER1BVX0dFTV9ET01B
SU5fR1RULAorCQkJCSAgICAgICZwc3AtPmZ3X3ByaV9ibywKKwkJCQkgICAgICAmcHNwLT5md19w
cmlfbWNfYWRkciwKKwkJCQkgICAgICAmcHNwLT5md19wcmlfYnVmKTsKKwlpZiAocmV0KQorCQly
ZXR1cm4gcmV0OworCisJcmV0ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgUFNQX0ZF
TkNFX0JVRkZFUl9TSVpFLCBQQUdFX1NJWkUsCisJCQkJICAgICAgQU1ER1BVX0dFTV9ET01BSU5f
VlJBTSwKKwkJCQkgICAgICAmcHNwLT5mZW5jZV9idWZfYm8sCisJCQkJICAgICAgJnBzcC0+ZmVu
Y2VfYnVmX21jX2FkZHIsCisJCQkJICAgICAgJnBzcC0+ZmVuY2VfYnVmKTsKKwlpZiAocmV0KQor
CQlnb3RvIGZhaWxlZDE7CisKKwlyZXQgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBQ
U1BfQ01EX0JVRkZFUl9TSVpFLCBQQUdFX1NJWkUsCisJCQkJICAgICAgQU1ER1BVX0dFTV9ET01B
SU5fVlJBTSwKKwkJCQkgICAgICAmcHNwLT5jbWRfYnVmX2JvLCAmcHNwLT5jbWRfYnVmX21jX2Fk
ZHIsCisJCQkJICAgICAgKHZvaWQgKiopJnBzcC0+Y21kX2J1Zl9tZW0pOworCWlmIChyZXQpCisJ
CWdvdG8gZmFpbGVkMjsKKwogCXJldHVybiAwOworCitmYWlsZWQyOgorCWFtZGdwdV9ib19mcmVl
X2tlcm5lbCgmcHNwLT5md19wcmlfYm8sCisJCQkgICAgICAmcHNwLT5md19wcmlfbWNfYWRkciwg
JnBzcC0+ZndfcHJpX2J1Zik7CitmYWlsZWQxOgorCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmcHNw
LT5mZW5jZV9idWZfYm8sCisJCQkgICAgICAmcHNwLT5mZW5jZV9idWZfbWNfYWRkciwgJnBzcC0+
ZmVuY2VfYnVmKTsKKwlyZXR1cm4gcmV0OwogfQogCiBzdGF0aWMgaW50IHBzcF9zd19maW5pKHZv
aWQgKmhhbmRsZSkKQEAgLTM5MSw2ICs0MjMsMTMgQEAgc3RhdGljIGludCBwc3Bfc3dfZmluaSh2
b2lkICpoYW5kbGUpCiAJa2ZyZWUoY21kKTsKIAljbWQgPSBOVUxMOwogCisJYW1kZ3B1X2JvX2Zy
ZWVfa2VybmVsKCZwc3AtPmZ3X3ByaV9ibywKKwkJCSAgICAgICZwc3AtPmZ3X3ByaV9tY19hZGRy
LCAmcHNwLT5md19wcmlfYnVmKTsKKwlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJnBzcC0+ZmVuY2Vf
YnVmX2JvLAorCQkJICAgICAgJnBzcC0+ZmVuY2VfYnVmX21jX2FkZHIsICZwc3AtPmZlbmNlX2J1
Zik7CisJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZwc3AtPmNtZF9idWZfYm8sICZwc3AtPmNtZF9i
dWZfbWNfYWRkciwKKwkJCSAgICAgICh2b2lkICoqKSZwc3AtPmNtZF9idWZfbWVtKTsKKwogCXJl
dHVybiAwOwogfQogCkBAIC0yNDMwLDUxICsyNDY5LDE4IEBAIHN0YXRpYyBpbnQgcHNwX2xvYWRf
Zncoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJc3RydWN0IHBzcF9jb250ZXh0ICpwc3Ag
PSAmYWRldi0+cHNwOwogCiAJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiBhbWRncHVfaW5f
cmVzZXQoYWRldikpIHsKLQkJcHNwX3Jpbmdfc3RvcChwc3AsIFBTUF9SSU5HX1RZUEVfX0tNKTsg
Lyogc2hvdWxkIG5vdCBkZXN0cm95IHJpbmcsIG9ubHkgc3RvcCAqLwotCQlnb3RvIHNraXBfbWVt
YWxsb2M7Ci0JfQotCi0JaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgewotCQlyZXQgPSBhbWRn
cHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBQU1BfMV9NRUcsIFBTUF8xX01FRywKLQkJCQkJCUFN
REdQVV9HRU1fRE9NQUlOX1ZSQU0sCi0JCQkJCQkmcHNwLT5md19wcmlfYm8sCi0JCQkJCQkmcHNw
LT5md19wcmlfbWNfYWRkciwKLQkJCQkJCSZwc3AtPmZ3X3ByaV9idWYpOworCQkvKiBzaG91bGQg
bm90IGRlc3Ryb3kgcmluZywgb25seSBzdG9wICovCisJCXBzcF9yaW5nX3N0b3AocHNwLCBQU1Bf
UklOR19UWVBFX19LTSk7CiAJfSBlbHNlIHsKLQkJcmV0ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJu
ZWwoYWRldiwgUFNQXzFfTUVHLCBQU1BfMV9NRUcsCi0JCQkJCQlBTURHUFVfR0VNX0RPTUFJTl9H
VFQsCi0JCQkJCQkmcHNwLT5md19wcmlfYm8sCi0JCQkJCQkmcHNwLT5md19wcmlfbWNfYWRkciwK
LQkJCQkJCSZwc3AtPmZ3X3ByaV9idWYpOwotCX0KLQotCWlmIChyZXQpCi0JCWdvdG8gZmFpbGVk
OwotCi0JcmV0ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgUFNQX0ZFTkNFX0JVRkZF
Ul9TSVpFLCBQQUdFX1NJWkUsCi0JCQkJCUFNREdQVV9HRU1fRE9NQUlOX1ZSQU0sCi0JCQkJCSZw
c3AtPmZlbmNlX2J1Zl9ibywKLQkJCQkJJnBzcC0+ZmVuY2VfYnVmX21jX2FkZHIsCi0JCQkJCSZw
c3AtPmZlbmNlX2J1Zik7Ci0JaWYgKHJldCkKLQkJZ290byBmYWlsZWQ7Ci0KLQlyZXQgPSBhbWRn
cHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBQU1BfQ01EX0JVRkZFUl9TSVpFLCBQQUdFX1NJWkUs
Ci0JCQkJICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwKLQkJCQkgICAgICAmcHNwLT5jbWRf
YnVmX2JvLCAmcHNwLT5jbWRfYnVmX21jX2FkZHIsCi0JCQkJICAgICAgKHZvaWQgKiopJnBzcC0+
Y21kX2J1Zl9tZW0pOwotCWlmIChyZXQpCi0JCWdvdG8gZmFpbGVkOworCQltZW1zZXQocHNwLT5m
ZW5jZV9idWYsIDAsIFBTUF9GRU5DRV9CVUZGRVJfU0laRSk7CiAKLQltZW1zZXQocHNwLT5mZW5j
ZV9idWYsIDAsIFBTUF9GRU5DRV9CVUZGRVJfU0laRSk7Ci0KLQlyZXQgPSBwc3BfcmluZ19pbml0
KHBzcCwgUFNQX1JJTkdfVFlQRV9fS00pOwotCWlmIChyZXQpIHsKLQkJRFJNX0VSUk9SKCJQU1Ag
cmluZyBpbml0IGZhaWxlZCFcbiIpOwotCQlnb3RvIGZhaWxlZDsKKwkJcmV0ID0gcHNwX3Jpbmdf
aW5pdChwc3AsIFBTUF9SSU5HX1RZUEVfX0tNKTsKKwkJaWYgKHJldCkgeworCQkJRFJNX0VSUk9S
KCJQU1AgcmluZyBpbml0IGZhaWxlZCFcbiIpOworCQkJZ290byBmYWlsZWQ7CisJCX0KIAl9CiAK
LXNraXBfbWVtYWxsb2M6CiAJcmV0ID0gcHNwX2h3X3N0YXJ0KHBzcCk7CiAJaWYgKHJldCkKIAkJ
Z290byBmYWlsZWQ7CkBAIC0yNTkyLDEzICsyNTk4LDYgQEAgc3RhdGljIGludCBwc3BfaHdfZmlu
aSh2b2lkICpoYW5kbGUpCiAJcHNwX3Rtcl90ZXJtaW5hdGUocHNwKTsKIAlwc3BfcmluZ19kZXN0
cm95KHBzcCwgUFNQX1JJTkdfVFlQRV9fS00pOwogCi0JYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZw
c3AtPmZ3X3ByaV9ibywKLQkJCSAgICAgICZwc3AtPmZ3X3ByaV9tY19hZGRyLCAmcHNwLT5md19w
cmlfYnVmKTsKLQlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJnBzcC0+ZmVuY2VfYnVmX2JvLAotCQkJ
ICAgICAgJnBzcC0+ZmVuY2VfYnVmX21jX2FkZHIsICZwc3AtPmZlbmNlX2J1Zik7Ci0JYW1kZ3B1
X2JvX2ZyZWVfa2VybmVsKCZwc3AtPmNtZF9idWZfYm8sICZwc3AtPmNtZF9idWZfbWNfYWRkciwK
LQkJCSAgICAgICh2b2lkICoqKSZwc3AtPmNtZF9idWZfbWVtKTsKLQogCXJldHVybiAwOwogfQog
Ci0tIAoyLjM1LjEKCg==
--0000000000000c78db05dd236cc1--
