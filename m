Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98F4CEB2E0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 17:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8339A10E215;
	Wed,  2 Oct 2024 17:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cs3QzD3K";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA7510E215
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 17:32:42 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-7e6b38088f6so332794a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727890362; x=1728495162; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ee5j8mlXmSw8VKzeDcbkx3r3SO9nXDOMw/QODhZQ9Qc=;
 b=Cs3QzD3KsQTMhTUY9kBy//LUJ4kZ2AuDBjLhBMT8xDB/Gh+T0EfRaxS/vSZd1j5GIF
 OeshBgMXoucqxxEBqZcLY7AXMCg+7GhCKKkZElGZW3gEWTS1inla/GwlhcQ0YOMezr+a
 PULdaOtZj7f7uijppgk+ky6OhazVMKTtajCa15yYMk1tuRC+k/0c2CWtIqInBocl9IWf
 Y+LuFfbsAIxL5LbFxJ2Z6jhhU4B47QqmzLDqRR4cFNYkKlUr30nKrOwAX3Wlqy4rMYzT
 AB7MZAom8LXM+9UORaqkKTWq2tZ7rrcs04vKOiIqSGxLbo7jEiJGDyPBIy0fQWNX/fKl
 GWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727890362; x=1728495162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ee5j8mlXmSw8VKzeDcbkx3r3SO9nXDOMw/QODhZQ9Qc=;
 b=VeO1anjHfGW5b8JUYuo6+f0gfHfg0T3fAH1mm5kRZotMhkJ/45YyET+xnbpbizRwtX
 ySyFNpq99GwRqND/ILbKMLkdceM3+6OjYPhTA2xVq2shvvH7JloB9GQptuaM1udT8q/a
 XcANMOr5dWtS3fRMF2S/ROteHa8MruyXrU4TQaitnlqXB03K+6jGNfswamI7Rr4AX6wj
 S3LWpzoApYAmX59XRpiPBtFITbhWwfnr+plkfmCdFFdj4Kck4hoiZmQjZgOO8Ud6Pc9W
 DlzTpPjV+2zYhwgznm/sLs96jrvIGQAhk1+s6W0pBSJJLGNlpCWazmKi8mrlc6hLPjDz
 /5IQ==
X-Gm-Message-State: AOJu0YzaNP9p+jbVm1hVN6qJpCbvyJEC9yqMfYCbPg6au6W8gg3oNR+i
 ANCKiDn2Tvy4MA1bzpfKZu6M/5z3oZqYc3bZ/qcqvQeAkoICRqk0J4dJI49MOJwOV5ELY3Z7Ejy
 AxjCVzdpNBmEY/oGE3bfKfqgtB9o=
X-Google-Smtp-Source: AGHT+IEA+h97bZUnTCyMUWVKKqXy225bNBYm65IRTfiF6Kw20fVc6StwSSKKcFC/q2CGoOfhc4SnwWX3lBt5QO9D+LA=
X-Received: by 2002:a17:90a:fe0d:b0:2e0:8b1c:f3b2 with SMTP id
 98e67ed59e1d1-2e1848d7e8bmr1982719a91.4.1727890361961; Wed, 02 Oct 2024
 10:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-11-boyuan.zhang@amd.com>
In-Reply-To: <20241002043627.102414-11-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 13:32:30 -0400
Message-ID: <CADnq5_ODBr=ZFtZmgRym5FjEazp5BiFVK8U=fmairLKHef9zVw@mail.gmail.com>
Subject: Re: [PATCH 10/18] drm/amdgpu: add ip block with instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
Content-Type: multipart/mixed; boundary="0000000000003c7114062381d3b1"
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

--0000000000003c7114062381d3b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:39=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Add instance number to ip block to track which instance the ip block
> belongs to.
>
> Also, add a new function to allow ip block to save the instance number
> along with other ip block driver information.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

I think the logic can be added to the existing
amdgpu_device_ip_block_add().  Something like the attached patch.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 84a9749dcd7d..d77db73c71f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -386,6 +386,7 @@ struct amdgpu_ip_block {
>         struct amdgpu_ip_block_status status;
>         const struct amdgpu_ip_block_version *version;
>         struct amdgpu_device *adev;
> +       unsigned int instance;
>  };
>
>  int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> @@ -399,6 +400,10 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *=
adev,
>  int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>                                const struct amdgpu_ip_block_version *ip_b=
lock_version);
>
> +int amdgpu_device_ip_block_add_instance(struct amdgpu_device *adev,
> +                              const struct amdgpu_ip_block_version *ip_b=
lock_version,
> +                              unsigned int inst);
> +
>  /*
>   * BIOS.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 263f25ac2d63..4bc109a0d832 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2321,6 +2321,45 @@ int amdgpu_device_ip_block_add(struct amdgpu_devic=
e *adev,
>         return 0;
>  }
>
> +/**
> + * amdgpu_device_ip_block_add_instance
> + *
> + * @adev: amdgpu_device pointer
> + * @ip_block_version: pointer to the IP to add
> + *
> + * Adds the IP block driver information and instance number
> + * to the collection of IPs on the asic.
> + */
> +int amdgpu_device_ip_block_add_instance(struct amdgpu_device *adev,
> +                              const struct amdgpu_ip_block_version *ip_b=
lock_version,
> +                              unsigned int inst)
> +{
> +       if (!ip_block_version)
> +               return -EINVAL;
> +
> +       switch (ip_block_version->type) {
> +       case AMD_IP_BLOCK_TYPE_VCN:
> +               if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
> +                       return 0;
> +               break;
> +       case AMD_IP_BLOCK_TYPE_JPEG:
> +               if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
> +                       return 0;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       DRM_INFO("add ip block number %d <%s>\n", adev->num_ip_blocks,
> +                 ip_block_version->funcs->name);
> +
> +       adev->ip_blocks[adev->num_ip_blocks].adev =3D adev;
> +       adev->ip_blocks[adev->num_ip_blocks].instance =3D inst;
> +       adev->ip_blocks[adev->num_ip_blocks++].version =3D ip_block_versi=
on;
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_device_enable_virtual_display - enable virtual display feature
>   *
> --
> 2.34.1
>

--0000000000003c7114062381d3b1
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-track-instances-of-the-same-IP-block.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-track-instances-of-the-same-IP-block.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1s5asq00>
X-Attachment-Id: f_m1s5asq00

RnJvbSBlZTYzOGZjMDI4NTg0ZjBjOGY1NjdiNjVmZGQ1ZTQ3ZGY0OGFkOTBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMiBPY3QgMjAyNCAxMzozMDozMSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IHRyYWNrIGluc3RhbmNlcyBvZiB0aGUgc2FtZSBJUCBibG9jawoKV2hlbiB3
ZSBhZGQgYSBuZXcgSVAgYmxvY2sgdHJhY2sgdGhlIGluc3RhbmNlcyBvZiB0aGUgYmxvY2sKaWYg
dGhlcmUgYXJlIG11bHRpcGxlIGJsb2NrcyBvZiB0aGUgc2FtZSB0eXBlLgoKU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICB8ICAxICsKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKy0K
IDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggYWJkZGMyMGQ1NzNlLi5mZjc3MDQyNjY0MjIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC0zODUsNiArMzg1LDcgQEAgc3Ry
dWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIHsKIHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgewog
CXN0cnVjdCBhbWRncHVfaXBfYmxvY2tfc3RhdHVzIHN0YXR1czsKIAljb25zdCBzdHJ1Y3QgYW1k
Z3B1X2lwX2Jsb2NrX3ZlcnNpb24gKnZlcnNpb247CisJdW5zaWduZWQgaW50IGluc3RhbmNlOwog
CXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2OwogfTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGY3MjA5NjgzZGQ1Yy4uZDMxNTI1ZDI2NzI3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yMjgzLDYg
KzIyODMsMjcgQEAgaW50IGFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfdmVyc2lvbl9jbXAoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJcmV0dXJuIDE7CiB9CiAKKy8qKgorICogYW1kZ3B1X2Rl
dmljZV9pcF9nZXRfbnVtX2luc3RhbmNlcyAtIGdldCBudW1iZXIgb2YgaW5zdGFuY2VzIG9mIGFu
IElQIGJsb2NrCisgKgorICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgorICogQHR5cGU6
IFR5cGUgb2YgaGFyZHdhcmUgSVAgKFNNVSwgR0ZYLCBVVkQsIGV0Yy4pCisgKgorICogUmV0dXJu
cyB0aGUgY291bnQgb2YgdGhlIGhhcmR3YXJlIElQIGJsb2NrcyBzdHJ1Y3R1cmUgZm9yIHRoYXQg
dHlwZS4KKyAqLworc3RhdGljIHVuc2lnbmVkIGludAorYW1kZ3B1X2RldmljZV9pcF9nZXRfbnVt
X2luc3RhbmNlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJCQkgICBlbnVtIGFtZF9p
cF9ibG9ja190eXBlIHR5cGUpCit7CisJdW5zaWduZWQgaW50IGksIGNvdW50ID0gMDsKKworCWZv
ciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxvY2tzOyBpKyspCisJCWlmIChhZGV2LT5pcF9i
bG9ja3NbaV0udmVyc2lvbi0+dHlwZSA9PSB0eXBlKQorCQkJY291bnQrKzsKKworCXJldHVybiBj
b3VudDsKK30KKwogLyoqCiAgKiBhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZAogICoKQEAgLTIz
MTUsNyArMjMzNiw4IEBAIGludCBhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAkJICBpcF9ibG9ja192ZXJzaW9uLT5mdW5jcy0+bmFtZSk7CiAK
IAlhZGV2LT5pcF9ibG9ja3NbYWRldi0+bnVtX2lwX2Jsb2Nrc10uYWRldiA9IGFkZXY7Ci0KKwlh
ZGV2LT5pcF9ibG9ja3NbYWRldi0+bnVtX2lwX2Jsb2Nrc10uaW5zdGFuY2UgPQorCQlhbWRncHVf
ZGV2aWNlX2lwX2dldF9udW1faW5zdGFuY2VzKGFkZXYsIGlwX2Jsb2NrX3ZlcnNpb24tPnR5cGUp
OwogCWFkZXYtPmlwX2Jsb2Nrc1thZGV2LT5udW1faXBfYmxvY2tzKytdLnZlcnNpb24gPSBpcF9i
bG9ja192ZXJzaW9uOwogCiAJcmV0dXJuIDA7Ci0tIAoyLjQ2LjIKCg==
--0000000000003c7114062381d3b1--
