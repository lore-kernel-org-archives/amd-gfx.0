Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1884FCD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A525D10F1AB;
	Thu, 28 May 2026 13:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cOIGESMw";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C58C10F1AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:35:33 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1324053d600so443020c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975333; cv=none;
 d=google.com; s=arc-20240605;
 b=U0Xd+Ay+3zVvd6zZONat7oROoB413W8wMj6+cwkxbsHiOkKjffY8+3RKOc4c+g9EcY
 uL+GIFqalbjLui8hLzbk+tsa05jRG1Qn97K17XpnKRHxxFIJYYqWFIOGbL+6XhlgcIAI
 oAvkWjW3n52TtEaiBfSXv71JMzAk2XA3iI2/B14+QqDWWpQbP0zSqjt0Ni2yf6r1ADde
 isejT4yUBLRGB8f7VWWSFl4sFd1G0+Ad2C5gNCCanqQ21ra/x6ztI2To+1xtLxms+mgB
 Da18J+CHvvUNCBky7FIJplaPoKF7baz1ByHeWnQObYXuYMDEM53lARG54oy5fqEAUGOe
 uLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bQNxhe7U68idcLUFXiGskD61FP62ssl7PT69MfruFI0=;
 fh=Q2wUn3tQk4lf8adQxYOyMGXt8UiUFTlU3EGNPSNB8UI=;
 b=CvqP3BSaXYDY73g+UqkTZQ/5OjSaclipjoplxa/RkAOff/QNRjXZ/kNHimoyKz+yiT
 /+tEPJZ9OCL9QvLAHsSdIAm+Zvcr/G4Xizgiqp2rVdgO07qqW12A3U39FCh2dNsqeQId
 XWHaSlc7NIcf8n5XaMLMbBJhPRPMvA8UXB1P0V8fXPeS8UxVv5Oy6HZ/NX971vqKIrNu
 A+3+3eXofYYtSwo4ifLbwbrcyCXYYczm/sRL7A0eVXjtuOIOhoWH8qL83QWrzkI7HRqv
 +NVWEf3RuvM4ezDKbL97Ef+lAMoRmKvlaedSr5nXihl6/Z/Zj3FEObK0xwh24oQApDqP
 b1AA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779975333; x=1780580133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQNxhe7U68idcLUFXiGskD61FP62ssl7PT69MfruFI0=;
 b=cOIGESMwXmRfUueISZGV7QudDKj+p614nwZ1VsLOJkRsd6hAWHlbIaVIfNqcoPSbD7
 SQJUSXKBdWicC5+zlzGT4tgAC7C4AZFGmjQgShozPsjyIeGbG6oCT7mSPeeZrEGggJ2K
 EC8WuptxORv4xNqam9OEpTSiqKjHxP7JIhvdR6oeXLM7tszwZftvhVr4TQMmWbVh0Ase
 LMzqhl23WGRzzV33jBDkkQbEl5Jb0TXvYWz8rvy3ChHBSXdsmI9i9u0GkZx0FXnaUxEh
 s7wkm7phyKX8fmfb4Vuek5yGxlSqu+3B0sYV1kO1n96+J3KCEjU5WFWKtVmhySP5MaOA
 EZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975333; x=1780580133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bQNxhe7U68idcLUFXiGskD61FP62ssl7PT69MfruFI0=;
 b=K+qMaXSMrmCh1hUjvRjVovuOeo+IiSlondYNPC8WU7yXoVGTILFiuVspI6VJ7DhRBw
 jEMQwgU0EDC5W3NrCzk5s6AYdtan5+y4Qql+03UXdZc1XVfzudu0MSQ2EK+pN9pEvYfR
 qllC4qPUBf88RDmQ5VC8+o81Ex1WydQTWKVdrRUk8THSMj1irlEdT1C0vw4KKmlwoQyM
 DwLL6vJ+4dbMPGlOOwQ67fdbIGQ3hPIF9thXR1ht8qvP7gQ1XkjNBfj7+wJxGVdAWWSE
 UeQDMVThsV0YgBe9c8IRry/iDFQaJVSef8PjOqeEalA42yCBugV86UYySksx0p+vbTBD
 SOiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RlYHEnkFoE5MmHFPTdVRseoj69g610gI9k6Fh93WSJdoq1ggdHLJ22PBiT77KzdiHY7U3PC9O@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeO94DDC3T3QqW4MAfYiJmcW8e2D/zd9KxGjwJGY9DO9fNMGmc
 hTQe8JELg41XolkrtHRDK3yb5cJNt/y0aMcmPUcpl4R04zDJdXpYTOXtsV4i8DCJh64JjJI1vVN
 ILdw7OrXZ4G7JlMu9fMGwRUhtIOA2lHI=
X-Gm-Gg: Acq92OHaelRDnMdkFvG5i5C6rbzHoPa7AQAWS+FFvX0A931wsQtXsJTXTky3Q6iXcHj
 8TbGi1IlULJlh2vNZoSBan8jhT4pqpa0pn11L1bltqsnjQQlQgLKDGhreGI/VBkW6jZ0HtHLdWn
 rhlvhT0VgSv+Nkr+8Fqa6e1KPc1EB7ECyargrJACL5VnP9T+I43E82czuGa4+AQHhQVVRg3udt/
 7aRd8JdqTpuPKuavvNRYAZZoDAMLvwABzEZeq613IqYn2ILN3ooPHZGhZ3waSML74ErZ6c+GHu5
 ddfxWGOmPvwhTFNUa5T2rHcAzr2OLoB1B3zyQCzGpWgBsrBcTfmcVWbxqEq+YgedHEdg2mLHhyM
 i+PdQ
X-Received: by 2002:a05:701b:4285:10b0:12c:897a:5219 with SMTP id
 a92af1059eb24-1365fd80cd6mr3443485c88.5.1779975332551; Thu, 28 May 2026
 06:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
 <20260528064206.12358-5-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260528064206.12358-5-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 09:35:20 -0400
X-Gm-Features: AVHnY4KJzSU51WzJ31KTk0-57LLYOuQHDJrFdzXiwMJhKSdr3X8m0Zhyo9SibE4
Message-ID: <CADnq5_M8jyUQc0vR4opsfDrfWhdf3vBVc9tu7RDNP7UM1EcE7w@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/amdgpu: add support for HDP IP version 6.4.0
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, May 28, 2026 at 2:49=E2=80=AFAM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> This initializes HDP IP version 6.4.0.
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 968cac5bcd5b..1af18c820d4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3242,6 +3242,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>         case IP_VERSION(6, 0, 1):
>         case IP_VERSION(6, 1, 0):
>         case IP_VERSION(6, 1, 1):
> +       case IP_VERSION(6, 4, 0):
>                 adev->hdp.funcs =3D &hdp_v6_0_funcs;
>                 break;
>         case IP_VERSION(7, 0, 0):
> --
> 2.43.0
>
