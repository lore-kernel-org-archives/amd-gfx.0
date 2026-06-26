Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF1CC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 19:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5A810F710;
	Fri, 26 Jun 2026 19:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dkekvm9P";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D1D10F70E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 19:56:11 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-137eb8e3491so97781c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 12:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782503771; cv=none;
 d=google.com; s=arc-20260327;
 b=miGBGGycYJUzNK0sufTJ3iDPwHk6LCFH3S0G36ErQCDs+imeD/Hdw78ZdvGK2Huoj3
 NXetZWnEAYeFBbNKJ9kX9yrchr3RuMd2c5ouVYn4orRyJC/LBUk9zhwdT2VI0+TDRsOJ
 ojBF2/kU5fcfC/gaDsOryvZ8Jh9QSAVDpu78t+DrzN+M9WddfuwE01OhHFClnswRTQh2
 3uFL/RzGYTgczY2inK4KoQNkuCmdRsleyIGA6Qte0QhWBH8qRiZAn0hjSZRn9IKafDAv
 869Va+en9KmWln/yXFn70E85ZbQn0XMF0mM/w0ts9f9dUfk1/s3c4zV/htO1ju4z58nE
 v/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sJ0bRQFmrXV02nza/52ulNaFUUJXNDnENX/m22gz2KM=;
 fh=advj4YxN8NmzRI1C4RdCPL3MlBHBQPZW0GAWMPKaSnc=;
 b=XnDvux4In5w4hBS1nCSBgamSQvKkXvhMtrPP0hZ70rJZeOtSpbgprckwRQc45Qdsxf
 8UB5UwK2+gNOPPGcT/J4kNVuoJFjbCJz9XpIGDTh2m8B3BtDCVA7lN1RuIK88ziCKZd9
 9dqR+fPlJFU/HR7vKd73H3LvGadqtfF73PbKHh9vd1S3jPFin57UA5sWRAVIfTjJKCDm
 Syd791MlXcyDYuJr4Mu/dx1iOuX3r41K0T6TGrPmEj7ceoX85bpZgldk0w+H9JzAhAmG
 4LbyHcRR8qI274HB5Dl3IJeN75CajfmTgtutZkJPusVxWmcJ9ygCmr4FsvhkalAbEtj3
 ObXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782503771; x=1783108571; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sJ0bRQFmrXV02nza/52ulNaFUUJXNDnENX/m22gz2KM=;
 b=Dkekvm9P1QlEc/AMEGheLkzFh9xCA5BYgnPFKxPYAHsPI/LKZStag1lpiR7TqxMrNO
 KqkeeaYe7lh+2l0P0/SDfH5QyRijOos7G1OuTZxuhOiZPjyqgrq7gl5CRC3ujFYVTEKH
 /H6Us0PwaSCBZrlpJ9l8p3uvKy/+GaZJ343FFgqCFtHF086TvZlJcP8yRVKEQG9/nq3g
 jadpox9mM1Pc3zoaN5dydmMUHlYiY3jtaXQuk9poyQeBxGGpYHCDmi7ts9F0lDLHZ5Xh
 B6WuxU2WjTUyvLxHPZOh/u2w1+Ywyf+dLp3mVxmR43sDzb+EeKT6z0tkpTiUIQZ9oJ2g
 dEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782503771; x=1783108571;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sJ0bRQFmrXV02nza/52ulNaFUUJXNDnENX/m22gz2KM=;
 b=UJ4HfE+KYtNmj0IAjU6DGrMnnMc1yFeGAt6XLVTHyABRScLWTWn4sXCNpsA98jDsud
 tl7y/RdsMc2bbrprwW7UGB5tbxbxovlSI7zN/hl7f6HqPbBMpw0xMaeH9VAzLyjPxdUA
 usIjfqvxCJsoWdfxzDupATvHBKQDRQnLb61FWDcCet7TIkonYpPnS3KYmasA67oHwCjW
 1kJWK8S77YouuhJz74ypnZ5197lfN3X/xCHLZzH2HsmdW94Z1XyzMN66bkZ5R9rgXmcU
 DE7mepCByKwaR8vNs8vyAFNXuDsESZ2Z+jlryN+eixjgYc8RC3Vqef3ObnMqpRLEuwDW
 a1mQ==
X-Gm-Message-State: AOJu0YzZTSLl2QjQSGN9udTfoEVEUGzISKdmFi2gkzB+4zT6fr1sh2bf
 XsQe6R2qTJ4hauODLeBu1RPnOFk1CEyUTSow/mM39KuvqHBQWRFVMzx6xcPTfCZcCw/YuJL639c
 hRPph2MtjeeaHeFNRNpRVKjvkJxV7VjGBTg==
X-Gm-Gg: AfdE7cltJq9Jo4PIdvYjQwyE5S0io8Z7d1WOxxN8Pm8//w1BIfq1Qv6jqcpEvA8w8sY
 h1Xv1oDrijx+iwgn2VqCxeMKq6eHT7Wkj36aiAtzz/CoWb0nn4a8Q3A8zrYA8qSDuPnq+aDg6NK
 fSxpEeHQL0B271l/vzr7ySRWxBl9AzR+KjPo4Um2tSHxdRgAiu/g5ANf7Ki6j8Yj5ZNGa15jCVt
 7ZYdv5sdn256XWRNtEx0XfECjrVHcwqdbL1Ew/jovrIe0FcnFgo4scd+K+kNm8HvwrhO1nQDyb6
 aTCQcEWtKlbtMGYo++hDvZWnCqOrYp9EelFivvPlfCdZD5q2sRYhaJZrvIE=
X-Received: by 2002:a05:7022:7a6:b0:139:a686:462a with SMTP id
 a92af1059eb24-139dbaa5c02mr2919350c88.4.1782503770772; Fri, 26 Jun 2026
 12:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260625141641.1826100-1-David.Francis@amd.com>
In-Reply-To: <20260625141641.1826100-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jun 2026 15:55:59 -0400
X-Gm-Features: AVVi8Ce471z52d_Xn6Q8rVIurCstLfulzS3LldLe06qy7Lm1Tsobs7LaAFgc3A0
Message-ID: <CADnq5_MFEEyitCw0XcR-c69cLB-9b-8Ma-Qbid_4C8wC=7QOHg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use kvmalloc_array to allocate arrays
To: David Francis <David.Francis@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jun 25, 2026 at 10:24=E2=80=AFAM David Francis <David.Francis@amd.c=
om> wrote:
>
> There were a few instances in kfd_chardev.c of kvzalloc being
> used to allocate memory for an array.
>
> Switch those to kvmalloc_array, which
> - is the standard way of doing this
> - does a check for the mul overflowing

I think kvcalloc() would be preferable as otherwise you lose the 0 init.

Alex

>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index ab9e53dc8deb..dbfb574f4fed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1917,13 +1917,13 @@ static int criu_checkpoint_devices(struct kfd_pro=
cess *p,
>         struct kfd_criu_device_bucket *device_buckets =3D NULL;
>         int ret =3D 0, i;
>
> -       device_buckets =3D kvzalloc(num_devices * sizeof(*device_buckets)=
, GFP_KERNEL);
> +       device_buckets =3D kvmalloc_array(num_devices, sizeof(*device_buc=
kets), GFP_KERNEL);
>         if (!device_buckets) {
>                 ret =3D -ENOMEM;
>                 goto exit;
>         }
>
> -       device_priv =3D kvzalloc(num_devices * sizeof(*device_priv), GFP_=
KERNEL);
> +       device_priv =3D kvmalloc_array(num_devices, sizeof(*device_priv),=
 GFP_KERNEL);
>         if (!device_priv) {
>                 ret =3D -ENOMEM;
>                 goto exit;
> @@ -2043,17 +2043,17 @@ static int criu_checkpoint_bos(struct kfd_process=
 *p,
>         int ret =3D 0, pdd_index, bo_index =3D 0, id;
>         void *mem;
>
> -       bo_buckets =3D kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL=
);
> +       bo_buckets =3D kvmalloc_array(num_bos, sizeof(*bo_buckets), GFP_K=
ERNEL);
>         if (!bo_buckets)
>                 return -ENOMEM;
>
> -       bo_privs =3D kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
> +       bo_privs =3D kvmalloc_array(num_bos, sizeof(*bo_privs), GFP_KERNE=
L);
>         if (!bo_privs) {
>                 ret =3D -ENOMEM;
>                 goto exit;
>         }
>
> -       files =3D kvzalloc(num_bos * sizeof(struct file *), GFP_KERNEL);
> +       files =3D kvmalloc_array(num_bos, sizeof(struct file *), GFP_KERN=
EL);
>         if (!files) {
>                 ret =3D -ENOMEM;
>                 goto exit;
> @@ -2584,7 +2584,7 @@ static int criu_restore_bos(struct kfd_process *p,
>         if (!bo_buckets)
>                 return -ENOMEM;
>
> -       files =3D kvzalloc(args->num_bos * sizeof(struct file *), GFP_KER=
NEL);
> +       files =3D kvmalloc_array(args->num_bos, sizeof(struct file *), GF=
P_KERNEL);
>         if (!files) {
>                 ret =3D -ENOMEM;
>                 goto exit;
> --
> 2.34.1
>
