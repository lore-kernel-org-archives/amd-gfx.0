Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EE8CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D41810E6D5;
	Tue, 26 May 2026 14:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="goi+OwdK";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4422510E6CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:57:20 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-3044f23f716so332951eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807439; cv=none;
 d=google.com; s=arc-20240605;
 b=VzbUU6sCFG939mmk1ycDH0/535hDLXq3558fXFxxFtEBdGDzzDPsVxKwI/qpcDTOBL
 5Y5YjQpdTxYTepz4Q2ecbpEyiYXFrL/DXsnH3n6tNbZZ8j3/mwQjf3fMB0FfC/dLAlfb
 ige10q0/O1C33BNfh6/Tgr6XS2e4t/14FJPlP+WRbQLovA/NrqYut/4D/iHjIdPqC5ZJ
 mbpHkQkRlVcYb8Lqy3HAUbK/X72tM5vAQqEBtVYBUtdv+xlvHGfzBpP7tsUtr5hmdips
 K02llFbn6ThBHUFpTntui3ONaasx/m7kxRdZYHmfX1/v+v6X1dbGNxnj7NCxSASwJo5V
 UDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9QLnmoKI9oPdbxDZU99IejVUtEw0fJGwS+lq3TvOKec=;
 fh=EnL5a7rR2AZofeEBM9jmzXk4MfqLCVflSdQLx4rJ5Bc=;
 b=ElM+synLo2tVYFno0EUttjekr95HZO2BHi7htBl+jMXkQRdXZfsBK0bHuJd/VacELd
 28auzMuERzqp1eH1wUCfwqoszpIdKosE8ButodttNHEjsbN7jzRyHXS1bp1yNSd0WRAR
 R3RlRp+ib6ieuU6GON/FebSQWhP/+H0bJezfeqoNwbmnCRf5S1G/sqwfypS+6fNaux/i
 r0Mg1+ubmXSPapakw0OLqQ3gHukWq11IgdVMXgGNa2swp7ytm6SrlxMlCf56h9ccfyCZ
 Ub1eBpdTETuooPQY9NOmiE+rBFKFG4utwQnUu384tK1xCcO7iMwyabdXdG6eurI2hsq6
 uKoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779807439; x=1780412239; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QLnmoKI9oPdbxDZU99IejVUtEw0fJGwS+lq3TvOKec=;
 b=goi+OwdK+J1w4FQuvL+H2wdNcFT6iLXsiGWl3nDg10eYewS6nFcnytYs/uWVZAwT53
 zPltkVWM88phvhjgpZdlsPc32DC3Kln6aksgdg5uGVRDFgXy4tk+hrHGDbdz4R6cnDDf
 6vZf7HMiU4Wft1DcoGAdFzXicxQO6fKNPtqhjkrDGeEjL7nN/8NF52iR18G/+MTFLEZB
 +LgjVjoIj4+cSEWKWGuR0SITG9rf1rESnwSAN6XEl/p4o6jzv2Ika9rNcq98g0vKbWUY
 dUMduTQyNKIGx30qOrhNJS4Um/HSME+ddh2A7kjmhidSwpp7yAmDUhgSdWikPy4z08yE
 SriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807439; x=1780412239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9QLnmoKI9oPdbxDZU99IejVUtEw0fJGwS+lq3TvOKec=;
 b=j16PumAd6HFcXDACXZqcnEzFhT3rk2MtxJSoMfkTn2OT9W8wSS/mjPOFTQSzELo9hY
 fxBaQbQBnbsw6KWp+dn7piD/W9O7fwpwq/618Y1/IKgvGwP2XwJTwhf/eqAznxVNOZNx
 ZnIgrdBicUT54apV4Jzy9nbD38JDqKZ10Gy/C5HWtgikDVGmUziNNVrM3DngBoY92NMj
 X8DWZKm0/+PSBTDpMdeLqsklnDxYzTryKUfDda9LPyJcjCUM6VoozA8Q3SFvP/3yczl1
 H64WbDYzpfVg5RQSjEOtM5j/ypgZYZGs5kIYt2vWuZVROgt6pJXGa3/aU3UohpCHsfTT
 kLtg==
X-Gm-Message-State: AOJu0YxFffMbAH9vJSq3mcZE1rq8nKtAalZ2TpyHAU4sHcoZ/ztShzqY
 YVYYTdxz7yLzqSFas1BT1Pl4DAQl85zQ9/dl1qa88H45dNu774oy3aO/YfpYhv9chntNYBpCs5I
 gsWAoNKwZk2MwlBP00YfCAyUQn9SNOBM=
X-Gm-Gg: Acq92OF8p8B9F0mM9Pb/8c/+4M17ATpVIHY+JkcmncveOyUq4jb57K/zn7KcgBBxlSo
 KVXNmuJHf/ZDvzLZ7hHURfdn9pCONeZeJLU0Ax+RsSi1k64bVHRgHThTcBk8f6a34QOGLZjldgQ
 wZk+D1slCTUSdA44OSw6QifIS+esH2O0BWZHaD0UTMi9BM7UEE/cqat+fh3eSrOJPnnlGeLem7R
 UkWcPSzF3Vw1+csFUD6sI9APnq+tXX6rcpaM5iV2KtcdMRfl3PQV5AxOoHP5yn8ZF3rnH41c4HC
 7iViffH+lghdncx0yD4HunpOkVRZl/S/s9GuP+Wr+Ho6UabwtS0x/EpYC55O2w+EXPHVag==
X-Received: by 2002:a05:7022:1b06:b0:12d:b4e2:f566 with SMTP id
 a92af1059eb24-1365fa3c9ddmr3044242c88.4.1779807439475; Tue, 26 May 2026
 07:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260525112204.12604-1-timur.kristof@gmail.com>
In-Reply-To: <20260525112204.12604-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:57:08 -0400
X-Gm-Features: AVHnY4JrIrH97_m6AqVtR_vMUubKpgWch2u2tV9Oijhc7XOirW7s0BKvQY8jfso
Message-ID: <CADnq5_PJNnBeADEJStb9ypvZSxU7SdviJEDf9DW0H+YBf7PT8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on
 all SI
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>
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

Applied.  Thanks!

On Mon, May 25, 2026 at 7:39=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> It seems that Pitcairn has the same issues as Tahiti
> with regards to the TLB size. This commit fixes a
> VCE1 FW validation timeout on suspend/resume on Pitcairn.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_gtt_mgr.c
> index 02f85802f579..cd0fd77578d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -203,7 +203,7 @@ int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mg=
r *mgr,
>         int r;
>
>         /* Align to TLB L2 cache entry size to work around "V bit HW bug"=
 */
> -       if (adev->asic_type =3D=3D CHIP_TAHITI) {
> +       if (adev->family =3D=3D AMDGPU_FAMILY_SI) {
>                 alignment =3D 32 * 1024 / AMDGPU_GPU_PAGE_SIZE;
>                 num_pages =3D ALIGN(num_pages, alignment);
>         }
> --
> 2.54.0
>
