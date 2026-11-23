Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE0606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JRLZIvFx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB7110E807;
	Mon, 23 Nov 2026 15:56:53 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F25B10E807
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 15:56:47 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-716f259f52eso153062eaf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 07:56:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795449406; cv=none;
 d=google.com; s=arc-20260327;
 b=mCDeNtBlfa/HSuDYwbJ1x1DsfhnWBiUif3hd6u+soLdZFsIpw/n37YjBs9Y8DUTzdO
 LDC5ktyg2zyGQ3v7UP1iE4bwe7GQHzO9q9aDjCpENmH7iJnMFygat1Jjjja4gSG0LOsc
 gog3tPbpew3R7mtp4+zSCoL5rWK567eCw/xFjk+/yZAz05ss79QwUWujctyzSDwSTYvs
 oDTiEco+mzmCd9KQsoZewfrWaxjJVuvQFmeUe9hs9e1hCNIaRXD683bLpuk1tsICVQAh
 AQ+CBCP4Z2SF6B6yGANMu60EuJkCWjtBm3rCn1Liw6dPPuorW0BArc/vuWdBXOxEYj2v
 MYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pjc8deyObBxLCPa5L0oFhozqeUe19BHaOQG0r1a261I=;
 fh=Twh1MsBIZYGoiD8qWrvkzWUSwxxq2oHaPrxgcZrqkE0=;
 b=A7taxX6ZPJTWNw1JNCpVMEQ8LDf9Q10msNn0gwmdQMkt/DWZlu5utOCvmxeMMF5GPk
 SZJYgPmJbZI6SNTJKub/pF7f3bybFm8gY1dWNaqsCLUm/u8pZnF4N4mVfXigTdxezPSa
 /Vb+AbCuXihf6S8JN27Us7EKhpogwWKjDULCskk2vltkl8X0UWJtMwmikV6YD1y1b+qu
 8iXxoL1wT0iLincaw+FUlV1ndAdFj8ezPNSRhdXBFR7/GvEZhhEsCbjFOeOIUoFwchRJ
 jWua7TcRD15CiJ5Mh7UvT2JlI1jzI2eYrshGtjXIms3R27mOBcJHJmgnUTyRqX7BqMee
 Yo5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795449406; x=1796054206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pjc8deyObBxLCPa5L0oFhozqeUe19BHaOQG0r1a261I=;
 b=JRLZIvFx5ZDDNMa8T4y0nTBravZvJS777lJkUdWiS+mMvVgNxTfRWb+4nuJQUR6wcd
 D7WZ7H3ZU90QCv/+nCsaGx+uVt6voR/OIDPAJKZxZPiEA8IV3iSqo1Mz1MXr4o0I4b7i
 vkXCjL71Ku8YVUmpH6IT3nXRpFQM9Ei7kVb7REQbQ0tgqx3Flq2fZum/N57+JPJVlPW4
 exfByiABnj5kk+8wLLxxTVjmoZNS8w/UppJGzRopAMkzJAVNOJM9u4r//TEDar9upT6T
 a6eTFlsIcbNzU1c2QAXj+ePB9JWNP5um7G7I3KKR+jLvPfS5xq08YdIamSVmTpnZIOAd
 UCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795449406; x=1796054206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjc8deyObBxLCPa5L0oFhozqeUe19BHaOQG0r1a261I=;
 b=m5ktXVajUcEei5EPEs80ygm/St3Q7hei8x5KkH9/9+MQvCDs0B6ZNgNjeXs1SEJVN4
 HboOv7jdiUmyZPXYLTXFquTkWD829uj1yuxijp7WCLJA9nPT7mhArQePLTW8/EkIvHs+
 JXSF40YtP3tcpGx+NaFCzPEDNdmITkB8hvD/Du/uod9na4/srNneWmWGx+1gdLKiw1co
 rdr0sxynQs3i9Lri1RnttaA39h8cqCaPOL9Wyu4yZGoBz49BKtNL1Sb43LqBZs01e3Yf
 FHLGHIHNbcVJxWwhihlZy2PrQrdLIvrvtrDx9rpGDsAO+6GrEccVZGgdrOlKHpw/sbYU
 s7FQ==
X-Gm-Message-State: APuU4Z+kxgIFsjtDjIxknPx1FMAVMILkxVyehEI1jJFBSj8CMv9/uR3v
 Va+nneg3KQIsk2rWwWdi91+AmP8hDMTvmGESNgym18KwktobFPrpec2rrEAu7/shBkYnHhJ/6xK
 kwYlHvciKrLEgKWZKSfST28RQVm1sdR1hJw==
X-Gm-Gg: AZFdTZc1XRANtG2bYtFbgC/QUM73FK8KWf+66fJ4Cf2WN56eKamdG2mjhcRzx2IdbRG
 4euHaGGPQxWOoYHc6JgOZvNlT4MPEj7yDs0KZgDxd0ccdDGxvoKQE0/tjLsXQ0BojqZkWWmqTkX
 YjcawJ+bzIqz55hptmp0UqHHkyCHr2VhH4yGIeYWy2dPyCVeJgfFt0BWU/ejDTTwuteH3zPFlR4
 5/0MgbYXsmta0nZHewjyy7gErL5+MP1v+eyFtW5sYvtDSsnGEi7msRbFLeAWAaQK0FJgfrp4Gb4
 FDMcbQt23gHQ3YoVOBpPF+TOejmlGXTvT2SXMXel2w1CPUMYq35BgVdKfDNbPxTIF7j494EZYD3
 7TtpB1S/pfnI3nq5FxVi7S95d+l8YY3D8w8Kpn50Tn6GLnEczCScGYUX850Qcw55tJgobF9vF1x
 bnbwAXGrNhaCThSfmzKDY2JCWFk7PDjc+qbRBKaebqoBzXVHPtRa/dhkH1Tf0=
X-Received: by 2002:a05:6820:a781:20b0:71a:ed80:f0 with SMTP id
 006d021491bc7-71b393836f1mr10039115eaf.2.1795449406296; Mon, 23 Nov 2026
 07:56:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121030250.1674303-1-takano32@gmail.com>
In-Reply-To: <20261121030250.1674303-1-takano32@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Nov 2026 10:56:34 -0500
X-Gm-Features: Aa3M54oXP51OS3sSNkcVOZ1PcWIzjST9HtGcC70qmiIvedZGUxdnp7X_Hgql6bI
Message-ID: <CADnq5_Mhgk-bMxU9dB1gf5zfn56szS0eLC17dj5gWzY1yWdrnw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Document parse_psp_v1_bin_descriptor
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Candice Li <candice.li@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

reviewed and applied.

Thanks!

On Sun, Nov 22, 2026 at 12:31=E2=80=AFPM TAKANO Mitsuhiro <takano32@gmail.c=
om> wrote:
>
> The kernel-doc comment of parse_psp_v1_bin_descriptor says what the
> function does but names neither of its two parameters and does not
> describe its return value, so kernel-doc reports:
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:4440 function parameter 'desc' =
not described in 'parse_psp_v1_bin_descriptor'
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:4440 function parameter 'hdr' n=
ot described in 'parse_psp_v1_bin_descriptor'
>
> Describe both parameters and the return value.  kernel-doc prints each of
> these warnings twice, so the file goes from four warning lines to none, a=
nd
> from six to none with -Wall.
>
> Written with Hermes Agent, an LLM assistant; the author reviewed it and r=
an
> kernel-doc on the file with and without the change.
>
> Fixes: 581ada8f9bf3 ("drm/amdgpu: factor PSP v1.0 firmware bin descriptor=
 parsing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608210800.S15sl61g-lkp@i=
ntel.com/
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 82a2684dbd2e..3fd93cb1e634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4435,6 +4435,9 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>  /**
>   * parse_psp_v1_bin_descriptor - Populate struct psp_bin_desc from a
>   * v1.0 PSP firmware header (standalone images such as ASD or TOC).
> + * @desc: the descriptor to populate
> + * @hdr: the firmware header to read
> + * Return: 0 on success, -EINVAL if either argument is NULL.
>   */
>  static int parse_psp_v1_bin_descriptor(struct psp_bin_desc *desc,
>                                         const struct psp_firmware_header_=
v1_0 *hdr)
>
> base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
> --
> 2.53.0
>
