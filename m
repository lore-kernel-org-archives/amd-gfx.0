Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59318C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 15:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE24010E216;
	Mon, 10 Aug 2026 15:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ixeeF6ot";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8441B10E216
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 15:43:51 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38115bbb83dso126743a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 08:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786376631; cv=none;
 d=google.com; s=arc-20260327;
 b=IOUrwwv+dQV+RoAhe3ZIozXQgW/cDkYB1pUe9+pb1f51anvLmyVQZJz/++9o075myp
 7OmQBn4Np/02scoTil0+X5AKKMf47tgtzsutBPUu1wVoSc3m5dPbNpyKrzoHnb+T9YMI
 TdFsXM064bVM2ccou3b2Pux4DhTYlT6HLa0G0v/Jyma+161LUXAcKq/F4cXXoI9dB5xa
 G6GQ2X+Dd76slr2bsX1acoIKHFl+XDOZSM/GRAKun544bd7LGBdxPob/5DpvlooMI24q
 0N0nZEIRMsaCdr4IzAGSp5QkmHJtVBprR0+oZJ1Q7DtBbrtdMCd34CC+6hpgCLZWEW6b
 UjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TTKkSu33ifqU3fmWmPjN27NmycXph8MFAHBOeTvQvko=;
 fh=UXReYgOH978Q8YRGufbWWMgVMgvD+MB3VBXBHmVssj8=;
 b=mEt46O7g9/N4j2UmUxxtPXi8Sv5sfWIJ1xSA+cu7PPcVyO8tudYFBfHyQj19nUpj2k
 n/puhRz0l22pjKdz2lwpuZmM1zuj5dMAezvANttlm29ohNRHykM7N7/LXTiY5HIfgo4X
 aRGLtXyAC3SytXZszq5Jm3qcbRk0q111VjZBJj3tgsFj7rGdCQvYTBsR7WawxK8gSh+w
 RDRJxKDSOl4e7QbFgkH/pbcw0o99ZkF7VzgYHkPHE4hWtWQW/m/HVTyacsd/377tq7ze
 Ifyj3Uta4fIFYqGa2i2UitO9Qy1gK/ylREkOeUYYAyMWVxKrssRV8EeTPkMs/wYUBUlK
 eihA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786376631; x=1786981431; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TTKkSu33ifqU3fmWmPjN27NmycXph8MFAHBOeTvQvko=;
 b=ixeeF6otJPQN1kVf6fwJNuvPl1sW3VjbH87P3khh88hfJJaLnPp157Vfk3P6ptU3ym
 nATv4JFE6IQJJjDiF8DQyZC+y5UF5JXFnosOg7kpg34RXTjAfelznCyBlZ8o+BtfgbO8
 C6L2iwor8vdGdzcCpVB2RWMuxGr7wyd40YD5hZyEe2yDFDwmK/Z0RVw7BFDd9eI8F0c2
 rFCi7yXjwfWmZyEfaLYdn7jgfDjX4JSaIBfQw+pKurcQxJ+2avBJAfPO+xX4x+uTKA8M
 oN4+Aqt/TjaNS4igD0HfLaraNFNnc3JuIKP0hco/puljItNxhRTk54fzAIzpZf+WjHEg
 k9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786376631; x=1786981431;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TTKkSu33ifqU3fmWmPjN27NmycXph8MFAHBOeTvQvko=;
 b=Ce57BCB/CqW7awRsgORk3HaEVYwiH8G8nwRY2y3o/wAIX21HF5tyTpHFZF89LHJCRz
 edhVNs3HC41HYPyhZ2tXoExrymMJ4QXeIZcN5duIOkuJ8IdnOzQfFS22h1szgN1U04hK
 YvOBbMHc/y2DJK/hm7wH3va7G9UzEDxVYRv8e6fhF1ETNB3ym9zfm10pFIFHEBPq00Zu
 a0jn5adUw8XS0uju2es/DORDPVe1xyEOWlWYqmWhAiU6Gl/4UmzWixQ8U+lCweY6i8iB
 0bKuB3hNHLK0/U7dWAt9yBYozLBvzCB28BiCal9cSe9E+Z0eGeTUPHzcPpxMIteYMe28
 H+MA==
X-Gm-Message-State: AOJu0YzYkxaoi57Bphu6IgbKj41kM1gAUjc2CzJRqa81qc7jrfZJD7dG
 V3UobxGuvwKS2SFc6Fsi/YcJqkhs7hgU+y36jBcgSE5vLJ03l6Fs/Tx1zqHWpuoxaLnjpJNNbqe
 cYAKiUjc8EmIqsLIimEfbwl6/sCiWtd8=
X-Gm-Gg: AR+sD11gvzbl8HhYuz4neqJWY/Zjqz5dnsbvJOsK//xkxT7uC6KGFkKrQO1c5BAmznh
 GAJOpmD4/plh1ZkhaO3hdtyFYQ+sJCd4wsxecxlOBzObQO/qLVCnsDuc9cA1ZofG6edxZ+lH+4/
 uPFqjT9g59kMLbJmg+P1Vxh4yn39RBK3awnTT6qU4XPaWnCOLklIIE9lFqNOtHjcTyPrUeK7eMo
 OxdoeMcpgkfzcWayGTDKW+1TR5+nwOsIJyZ5mYmd28NNrbmwD7F3Uh3ZLamrKOvwyVVnnV5Q0L8
 HV5fc7iKU2DUOOBOz4y7iSYR54gyIbPaXOwOh6K97Mbc7OYWe0WFI4D+AKdS52TYVlPMAK9OHQc
 0e6qkgUpUPkWAxseiPHg9ZBf72cHYFFI=
X-Received: by 2002:a17:90b:3a81:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-3903c6e93e6mr30104516a91.2.1786376630986; Mon, 10 Aug 2026
 08:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260807194132.3214839-1-David.Wu3@amd.com>
In-Reply-To: <20260807194132.3214839-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 11:43:39 -0400
X-Gm-Features: AUfX_mwJ8BQCPL8xJGEQX7a4RUAVxH-42pDVQAJqTOPrAH1a0oyWzN3cYI0OvpU
Message-ID: <CADnq5_OwHSEdJwNtzJFNM7GzTn2xosYgN4R0D_EOWDG75QpJaQ@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/vcn: vcn dec_msg integer overflow fix
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, leo.liu@amd.com
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

On Fri, Aug 7, 2026 at 4:20=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@amd=
.com> wrote:
>
> if supplied msg[2] in the header is too large (around
> 0x40000000 and above), 4 times of this unsigned 32 bit value
> will overflow and the test could pass.
>
> Widen it with uint64_t instead. Also drop the redundant
> first check and make the check clear that 6 dwords of
> header plus 4 dwords of each msg cannot exceed the overall
> packet size in dwords.

Maybe cleaner to use check_mul_overflow() and just return an error in that =
case?

Alex

>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 81bba3ec2a93..06dcf736b15a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1965,7 +1965,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser=
 *p, struct amdgpu_job *job,
>         num_buffers =3D msg[2];
>
>         /* Verify that all indices fit within the claimed length. Each in=
dex is 4 DWORDs */
> -       if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +       if ((uint64_t)6 + (uint64_t)num_buffers * 4 > len_dw) {
>                 DRM_ERROR("VCN message has too many buffers!\n");
>                 r =3D -EINVAL;
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 0cce78b205a8..7950a020f4e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1881,7 +1881,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser=
 *p, struct amdgpu_job *job,
>         num_buffers =3D msg[2];
>
>         /* Verify that all indices fit within the claimed length. Each in=
dex is 4 DWORDs */
> -       if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +       if ((uint64_t)6 + (uint64_t)num_buffers * 4 > len_dw) {
>                 DRM_ERROR("VCN message has too many buffers!\n");
>                 r =3D -EINVAL;
>                 goto out;
> --
> 2.43.0
>
