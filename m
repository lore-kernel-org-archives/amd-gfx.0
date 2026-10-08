Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97F3CA600C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 15:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62FF710E0E4;
	Thu,  8 Oct 2026 15:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fc1fHt/7";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446FA10E0E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 15:24:10 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-15943c9be84so32208c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 08:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791473049; cv=none;
 d=google.com; s=arc-20260327;
 b=Ohga/ssgNx+BA4NZfOPRqt4MByA5WI23EzFeBvl8GVGUiMK+00bDHUFDroSUc6WY1R
 VnE1/YyB0oHnuzEatt7KPnoFu+6xgvUoTsjG9dns7q6F8TUt75eFZlETL+pnsQU84emH
 4oYvvsrgty4d+LofvEe7KK665VhxPPf4WLhMLu0ySV6IgKm/77zo51HAll/OYOpY6sBO
 LJdR1kpsBD5YxEv2unon+52mO24z5pBN6RgwSqLUWGkIwLT66xanPagw1oxj1ThNS2xT
 v0LW22Og9NYJ85KmZoYGytHB32vQUz7xSjB5RA28YQt6WDCftFgJYRUph3nihI9L5y2m
 yuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DOn4G0mauOyfBO3z8zipD7Sxj1F1xy59lqSxi9KYYhA=;
 fh=UJLL4iJV7xu4Yw6uF7Ayb26UfZBRECz6bgXWERRc3Ws=;
 b=k97YGI1ET0uD335u6JLr8y3+NLtJN47l3Bn6TwTikK3iZOdbBl9KC0BKyIbvS46nFT
 /TPNZSatgSCXD7eQcJI3Qp50mBrh02IeEFCewcw6g0gWUj6NLqSHvQA/xYIk1XW0p2X0
 5R/oe7bBNvtHr4I3VC32logwJow238F7eVydfTuWyj7uolGHfZIevMSHTFo3QbZ1gUQ+
 TE6mVUaCuhhqDAx2Aej/FRxmH53Hlhdt5K9g5FOIa/QMPLufdm9A6LLz7Yifk7y4ruVF
 9Wr2R9f25a1B/1/IfQZdBqUFEjovow3RsXnCPp3NCTrvaZ/QmxdmrbBZ96d3kqg1Egis
 3LmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791473049; x=1792077849; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DOn4G0mauOyfBO3z8zipD7Sxj1F1xy59lqSxi9KYYhA=;
 b=fc1fHt/7w3ikz5nL0udUE5RXAQCVb8xHK0Dql/QzYi763oBTkQLYRtwE1IkuWIv/aY
 z+psI2lCiOrCgy862sUczCT3yhG3npOA0WHX2vg/tDd+Qvc+uKQz7edE5dQMNdHKx9kw
 H1QWJ0sPCvQ3Wp0TowJ1X11VXcmCDw4MT4cyVFN2mIT8/Zzk35ULDXwSkj3zrlZ1keI/
 XJMFPwKjkiXgVQdcuPOFUgpjNw9fMsbcizT3p/R1zBHjiLRYZguqAy+nNgz6e8WTg10n
 Lph2qKEA2BOgAYud6L+0KVdJGCiXEe23P95+OYcqtM2VPACIZ9XFNU1fY/syZsnrGkpb
 tI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791473049; x=1792077849;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DOn4G0mauOyfBO3z8zipD7Sxj1F1xy59lqSxi9KYYhA=;
 b=KbHVEqm/tyuqiNaa/tnx/lVf/HazVC+iyw4r8lPWKsXAOvsIuBiiBLCJ7xQ20HLdcY
 0aD3o4Ap1s6K3AhW+Ls5cFQJbvchdO+5ZumAQEK+HPheZyQKq5fWuPGw0x6qOugAl/+q
 u8S1Ay4f0bEWxiguhG9gOQZayqx6cipkl4SpgS8LlCKVOk/oaGxRNAItZsFLhDzow4qe
 JZk13j8oUO3syfigdG2kTFQKJpHsEtInt2AflvOcH2Zaw4La4bZSWoENfappSWIBOR5o
 kFhOV21pCCz1U2DhVR8l3JPeAr4OiISZQgrdAKYT450BNgErTHxKPWzYBxc91bu+EUAS
 usng==
X-Gm-Message-State: AFuF++lxsaLnpSkOBg6t/y5bgvJQvMXJJFUOqODvcpiSpMg72M5Tc2E4
 j8G0q1wNUAgnU1masTTTN1PTt0km94HThH4+zMw/XRvF9xJbndh1uX89uRdmDr8kL5vk167AGpi
 yYauN9t/7VT0HPZaWkzkyX9yRxC096pcaQDlI
X-Gm-Gg: AYBFou1kdxoRm4g/TKVsfzKKeAXxyjzFLJBnz/lnNlnI31yC3X6G/GyEQfHjDilzjMa
 8C5kUHU0BHYNKT8PUkdr91VjuzZq8gOBAgdkbFBoOdpaaeAl9ix6/Jt/cA2Bw9KYjQKgJ6YTa07
 C2aw0wDUP54V15Megjj7KDqRW+HGKSub0C271F5FvdnyBJGnwQ/Sp/n6gry+ug0C8EVH/TT7viW
 3DdIG9jULBq8XOdnjCb0Ptaog4JRVc7o8ilfa2mMrHki8OeeHpbfPet9SL6e3IJH5Kh5Al/70bM
 yah2n8VgbopeNeuQ0Mct+edG197MzUtYEVvAdicCKdLNVOmWb3Rcsn2F68dnC4zmbzuXU3m2HLC
 xmDI8zfZLgNPqz4XR2ZtVvzS2wmDU+NG9Hhb6ks023dkYJSyR8C4Y+w==
X-Received: by 2002:a05:7022:f507:b0:143:8212:a43 with SMTP id
 a92af1059eb24-165896c95b8mr4176381c88.1.1791473049319; Thu, 08 Oct 2026
 08:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261008054429.1873-1-xffffffffy@gmail.com>
In-Reply-To: <20261008054429.1873-1-xffffffffy@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Oct 2026 11:23:57 -0400
X-Gm-Features: AclHuK_xAnt9siKKuzEpDaeIA3rAwQZQVbWsvcw7cMz26-OA3_iSH095TImXVWM
Message-ID: <CADnq5_MX_=yqK8nLF0C5QaxGXVHrxEYiUiv=joj8ah-bXw3uLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Drop eviction lock before freeing PD/PT BO
To: XF <xffffffffy@gmail.com>, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
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

+ Arun

On Thu, Oct 8, 2026 at 3:43=E2=80=AFAM XF <xffffffffy@gmail.com> wrote:
>
> From: xf <xffffffffy@gmail.com>
>
> Fix circular locking warning with drm_buddy allocator.
>
> Signed-off-by: xf <xffffffffy@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 7d3659ef11e5..2a4f8d365271 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1252,7 +1252,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,
>                 tlb_cb =3D NULL;
>         }
>
> +       amdgpu_vm_end_critical(&params);
>         amdgpu_vm_pt_free_list(adev, &params);
> +       kfree(tlb_cb);
> +       drm_dev_exit(idx);
> +
> +       return 0;
>
>  error_free:
>         kfree(tlb_cb);
> --
> 2.34.1
>
