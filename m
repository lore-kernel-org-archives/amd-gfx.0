Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40537CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C0410EB9A;
	Tue, 16 Jun 2026 12:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqCq3RDP";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC71510EB9A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:54:29 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-137eb8e3491so129484c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 05:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781614469; cv=none;
 d=google.com; s=arc-20240605;
 b=ilXs8WpO+gepuCLnO1TaYS9WqBP9EXt6Y/O94zAD/iCvEJi24TI/tKsahNEnehVr3n
 hJ4B+y7kIynkk1RkKIqe+CHqiCA1Xkzv2nB3pP4/EuxHv588/cCJJuZTzLAyYiCmjI9Y
 8gjHDZs1n7gW8EmrS4dFhVhQ3cOud8wYiEFG/mNfTWGyRRfe/unNSrpGb8+I/tdXYVMm
 vsc65UDo1SxZ8bJFyLHvey8/fRDdBa1YeFc0tp70bxrkQL+WkubExHZKfk0yc3aE4jdI
 1TYVJ8koSy7H1qhOHmBALHellAv8/g4htwROZOBJx88mqDbqOgL1Y7m67pCbySooU5wp
 n+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yo0WnyuqmiFSvykDDuqcbCDH0tTc6VAhPy4VfYojCVk=;
 fh=hu6edWbrNIbeIZ0Tkzb9Dvke4+sCsh4tKagiLtEFVz0=;
 b=VGRzF1lYIveU3eVVoCap6Mk+tRfS6ffieP0WfXFcD3gJtkfIpVF2Chnw4ybFsV05Ma
 ufSGtp4tET6ijVpVmTsJBTFXBb2CK7Z/6hjKb/1T7/YGE7WNfjvA+SEpf+Vrd1GsYHAr
 RAvQp44b97qKqz59YGDz7OWsL65Y0EUjuhIc544TlLtasyNkgQjIeRvEkThAKfs47M5r
 gShAZNoJXkaOhmduI4hcRSf4ZnbDeUIWCgm39YeCnN0fZaA5vBO0v2PfT/hprdqFUdQW
 8kPESge0saF0RKrPSxJweV2vaXmelGi87bi/2wTMdc/zBfYbjtHPMnOQv7hvNS1FFqGz
 r3iA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781614469; x=1782219269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yo0WnyuqmiFSvykDDuqcbCDH0tTc6VAhPy4VfYojCVk=;
 b=MqCq3RDPPR1azs9O+EE+mVseqCA7ZBLchJXHeO275WTX8kvlhiKq1tbZ5cTMCNCEA+
 mC4GDb7B6yrpKtENNRUUVPMbTJSlvwPhJbI+tY0Nom6g7c8feovUY+e9lPIcac2p4BB1
 CwGy52Rw8bLrA2Ziz03M++Qwgu13UzW1O+29rZH9JWR6bVSbDMzVJwMx//zsVw/tgEHJ
 YUAIU0FbtqKmxKF8Ine/eBERkiE/nXTBTly9wzeFei6GU9eTncKna5ycs+KgVG+/9PvH
 Flmk5VcqXEbIxBWyaLZgJazO1/0K9BP9QVr4tGKEERcMV3XVEZ3VdBKnoQotXBHqZMoI
 iPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614469; x=1782219269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yo0WnyuqmiFSvykDDuqcbCDH0tTc6VAhPy4VfYojCVk=;
 b=sP/an7JhLtr8NbWOoD2qKtHSjkuynGTJIfldDh/mFPCvOixBo2mBa3FLux4GVtXqmh
 25g4sDWY+kMRSgLN/IWXiRJCoTAH9rx2rQBYMsmKhraIbPoL9QcCeqfVR2CbRgAUtd6B
 Cpb+K/51QUjQLNO8KOMVYSL2jAf0bqKtm4SKaxBXdB3whH5CYhehi7/5v+AcC4vSQuY9
 65ET2/9rPamw0KxHzJwnjxya40wNHUz1+Gv7N4dWJ40fCgI+VI5rQusuUbcEeBlaI0bu
 NrqAY8mcQrKSVwiZXtLYIic12UGZByv+FdWGXJPButGzarW/7mumyHtKVHtSiZLf6UOv
 n10w==
X-Gm-Message-State: AOJu0YwjEzPDvV8T7ViwVQ4dnO+lSHj8oWEHROP7p+T+aCBZW27IC41E
 YjKYANyEuwKBbnVhz+ZLEga8FvBVeciI2QHCG3W2MMtw7Bu7lud/H9V1+HFOG6ZZj7mEqjLv3AU
 xWkca7eRhNtF58qLZm50USPu1l9nuWwA=
X-Gm-Gg: Acq92OFUTUj3UyP7H7AFINUm1z6SKRakxxyTKp708OtpopCcCCNJtd5OdDgciHmZHkb
 Zm9p0SfHqC+Hpn8qbqr9Y8s61DXoipgzz8qlw5gxSQx3Q5OE5viwlkmgKh6AhsCPAszpw197vRm
 q1pCfTCNKe+ahmdUDBx4irGrqihuXnkv9z7amuhN6WxjeFAMOCD1Ow4lHTVOm7tKpzoulvEPEwv
 ttf3ue9oWz2mgOeheet/FqYQpMkdaAu9/FDzVQAZq9fjOPelvg8uaOC+vexMif/3Dfh3nRtE5Rx
 ZzBcnecVrvwvqcacQ0lZ4Q0rgKZOnWNRGDo/quJFQBiJi+EHQtltF4fywI0JFet3K27vPg==
X-Received: by 2002:a05:7023:a4b:20b0:136:bbe5:395e with SMTP id
 a92af1059eb24-1384bbb1e89mr2751952c88.5.1781614468992; Tue, 16 Jun 2026
 05:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260616052934.354425-1-lijo.lazar@amd.com>
In-Reply-To: <20260616052934.354425-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 08:54:16 -0400
X-Gm-Features: AVVi8CcYTjtumqvkS9eBJRUGBUvtn7roeAJ406LoD_p7EajuL91UxoIEY_JEPNY
Message-ID: <CADnq5_NCQFX1xTWwpFqC7BSAcrikisR+tOqFnYRXOa0aU-Y7zA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bounds check xcp_id in release_sched
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, candice.li@amd.com
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

On Tue, Jun 16, 2026 at 2:09=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Avoid out-of-bounds xcp[] access, e.g. when xcp_id is
> AMDGPU_XCP_NO_PARTITION.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.c
> index 389f69c7d5c3..14cef0264c17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -475,7 +475,8 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *a=
dev,
>         sched =3D entity->entity.rq->sched;
>         if (drm_sched_wqueue_ready(sched)) {
>                 ring =3D to_amdgpu_ring(entity->entity.rq->sched);
> -               atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cnt);
> +               if (ring->xcp_id < MAX_XCP)
> +                       atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_=
cnt);
>         }
>  }
>
> --
> 2.49.0
>
