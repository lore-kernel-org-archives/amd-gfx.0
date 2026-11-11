Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FEC606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JM14IQul
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018D410FD1C;
	Wed, 11 Nov 2026 17:20:44 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7909910FD07
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 17:20:37 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-36ca32a0faeso94989eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417637; cv=none;
 d=google.com; s=arc-20260327;
 b=cBG0KaEC7ayn4a/QoJ1DbOxJ5CYYqkckFkbiEejQOOZasHfuMa710IGyD+jWIA7oT+
 RanF+nMA/jTH3410VDTZtsiQajFzZjvUxko2RWiukQQB5gUNISZ6SHNcS821e6ygqFIR
 sqlEg/K4dXI1dJd2M9jM/8CnYsakVXuHJOjtYpYO/j2DOpOzkcTFt8wikmKo4tVdYGNq
 vA47EyymMFyQLEcgkEJXT9o/cb29V1TbZr4MzhxxLwNa78JzPqzz0TU5fzXiXgx6f1jY
 AfpOFdMfOsdfqde81CUlgBagEX+QNgtCRkIlwkb5BkkGxEXCYwX3jfs3acj84T4BF2u1
 BZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pxB40q79An19C6sh7p3I+5Mbwo7e0V/V+8imyCMYB8o=;
 fh=JSyM+ZjgQtP2T/WxrDvR2fEFzaDxP1zgsIexk87G2yk=;
 b=bqzH6a5iXXowmrAWSwZxmoaZAE1dZ9JWvRE61D2aHvswwXkha74p8rOksxWtlgsCXK
 5ufM3+kjzAKJkZuKmqj5auw7CMXkBbTwJ5AohkgZLU5GKR4sXvOE1RgVLDzn/71Txbqd
 vydbRcEb09S0TbvwR9gQjJwHQMGhvxuR75qjZPLJaTEBAsf2Q/3B58vH2If1c7rf8dcJ
 s8SUTpg13Qi/+1gjMUCyra1Ga771mOdRUE1hvfG/cXCvREJXhSVE8R2eFH7yOqfQilEA
 DN3ax2X+ZJF7d+oTOIxX9XYj8CFha9j89qDOyFPn+peuHp9Y91rJ5x2dJSLCKc7vU2mD
 XfyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794417637; x=1795022437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pxB40q79An19C6sh7p3I+5Mbwo7e0V/V+8imyCMYB8o=;
 b=JM14IQulQOEEz5Spj6cxdLOfLouQLxXmmlq0xiej2qfldOVxCI5EGXcYY5Ric/YKFs
 dCEqfzWlMJJKSmUaRu39WNwu0nW+LqkM/0nTBPj9owqpqgsm4FCYEBfkdg6CqOYlEZdW
 iOSHnRwR7JHfjxCp2ZInp326yS50sexirBLW5aWanxnKZ5nXLu6qZBei1t0w5JjfpBmR
 mX71IVclbjCyLcEj+eY5LWQX/+9kYWRyFVhOQDTON6sbNeRZx87RDQutgPzE8qVVQrSV
 RRP3zVmnsGwboPY4BpI/QtaZBNfL7L0p8J2onJXZR6t4xTV6CXR94PllJMiTgug83cIs
 rQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417637; x=1795022437;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pxB40q79An19C6sh7p3I+5Mbwo7e0V/V+8imyCMYB8o=;
 b=eGC9xmMupYi0akt8OEb9SeYOjI9NqVmlBZy9lAIa/7FiFYrwg2hVN2uTS4QZudZlby
 w3XNDGqDIhNF7lSPdNkkIqWDWpXBLR1Zarsw54eOfOf0+tGO2I9MvtelM3mV6BN1732x
 cYejIFfLWbM9h00m80wWujPfR4MzIUxfnPZnFGAPv5KneQ8wFOaVYuYP1FUcgLH8+Vap
 Hro5LB91XHw6k97R97J6i5M5EJZiPih5kd9Q5jtooLash77dG5pbTNloDKu3i5Eex+CD
 teifyEieIm6i6KtcBgvSqv3Xror6TOargMsSCfp9NEQQvGuyqGf5MsxrD4Qyk8dfFj3j
 LAww==
X-Forwarded-Encrypted: i=1;
 AL+hErFFqFYbE/U1wmuyeZM64EOYnB+PBxRe/FTI8XDZrNyGsYDzQBp9HFfUKBoRuo1Yl6WMxxxbEwii@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+sFHJvV41K96CcHHzQdP07uHE5hDHo3TrL06+O09NhzgqsXVRX
 l+/4Gq8fufwGne/c7Yb3mR5MRf1yUPqnY/EIGQmbydUcPV6PkqAmVK2IR10IsKXQyozumKOBaPY
 fZO9r0ksShpZkjhylUKm0DK7O16ij5Yk=
X-Gm-Gg: AYBFou3sgfA8XXGApuhWM2wH4aRJO9uGkH+nyvAl9kgSDLr8RgeMUXAR/J2t2d/cDZE
 mk/w8kZCr4+buEB+xN7+6hnFHLyMWalcsJ4zmVr2WwQ1YGdu4oaCIZUHAbvtS4QOegUwwJGJBZB
 y3HiSc+GV5SXsLKSC5ikAiLBq+3O3LN+1VkANaEYOX5zInkRexJMK9Favf2fBkPhLNdh/m8/Qxv
 gbPXtmTUBeKIUJD31QOgReRXKZhj8+stcUXVZr6SSw89u+qVEev3fyxFoefsoY9iZLr++fNQbse
 OETljqmj2lWUSzTy51cFahE9x9jLIU83QlpUfC+X6ghsHsAu8R7OmGiOCAAGZSoffifTCI7vgPk
 /ty1AwtciZkP1hD9slAaxm6Gdi7uGlJ7Cj8OZWbD+1mzl9Y+ytC+UOmOuxu7s050abRuR2360eZ
 bbsV5JmzlTGzMgrtU46IhQB0ybW3RLiv6JSJMv1vbINFft9eL7BdXaooHCSPM=
X-Received: by 2002:a05:701b:450c:20b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1b3c02cf135mr4365930c88.1.1794417636541; Wed, 11 Nov 2026
 09:20:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110160429.892673-1-colin.i.king@gmail.com>
In-Reply-To: <20261110160429.892673-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:20:24 -0500
X-Gm-Features: AclHuK96pzFNcsCpriytYsF_JfHFuBx3rYaQSacUjjgQ682B45jmkk_N34BB_lU
Message-ID: <CADnq5_OWtqzN9VDK7F6F_FBy9XkDmk_1jAMR6bivEsJABe1rag@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: make the read-only const array
 fw_err_code_msg static
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

Reviewed and applied.  Thanks!

On Tue, Nov 10, 2026 at 11:31=E2=80=AFAM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> Don't populate the read-only const array fw_err_code_msg on the stack
> at run time, instead make it static
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ualink.c
> index d025b4183b29..91c863649972 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -5427,7 +5427,7 @@ static int amdgpu_ualink_metadata_init(struct amdgp=
u_device *adev)
>   */
>  static void amdgpu_ualink_remote_error(struct amdgpu_device *adev, u32 s=
tatus)
>  {
> -       const char *fw_err_code_msg[] =3D {
> +       static const char * const fw_err_code_msg[] =3D {
>                 "Unknown FW error status",
>                 "FIFO overflow",                /* error code 1 */
>                 "Invalid RB command",
> --
> 2.55.0
>
