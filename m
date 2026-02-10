Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBF5EA8128
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 15:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8361B10E5AF;
	Tue, 10 Feb 2026 15:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efUpWhmr";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0799D10E5AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 15:16:31 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2b867142b07so181657eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 07:16:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770736590; cv=none;
 d=google.com; s=arc-20240605;
 b=aSF1y7SwfPJQg0Vwqofp6XX+8FUz6hIFPL1jdna+hGzV00JtnwyC+fDVuabyFKNLnt
 w/tLEutg9Ogg3uc8ckTfNbW86E5PG5J+nFtrpvlK7rv1OvY3H54NsQSFodo8jXW3Qr8d
 CkdjjK2ljCk+exzpqWsLVvJIeGjgRW2giR5RjCPa0/jJSbnX0DNE6gJ/JDkGtqzoIvNE
 OLUJRSxJC4eQtwkYoV6y15ztgtGPPjIy36OejiYWuoFsQWJaTCYHDak1IpMGOZfTFL4I
 E7aPPNyzCx/aouWtrkpjks2surZlr6psY6Pd8GcNXEBLf1ku4bUgR/OYkdKwRvUh96uw
 umEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ab6xZ3HL0nBQbG5L8JdmPVjm5AkPtkl0W+OBgSKhjW4=;
 fh=hxQk/uZpkXs5H9xvSBgSM9HoyHLdZh6wDCcQc548gy4=;
 b=GJT8rsNwBREUCa5Th8yd5f5bzIdYEKcE7gJQSiX+VpLkSl9sczJ6easa0bc7OT4GEB
 3eO7sKbyb1zg2aYRPQx5stIoa4hchLitzku9S4MmuGOyF0gIUCEBDlhRa4m0deyz0zMU
 RU9bVJ0sfKxci45pizX+dg/MLwcsCfzbvuK0N70lZEIsB0PTqwVKliY/YqRM86AimD4p
 l3/bKxUFzwbTHTXdcxuCuEvR04Hmvg3T7Z9f2Smwnk/SioDxWn2JKsHV9MQDo8Ta40iq
 JrA64Q2OyYpKz8/XBMkef9lP9mNxRgBwvajY3abH4uNqGRXPkDxmLt6HmboxPhzlfsgZ
 zDqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736590; x=1771341390; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab6xZ3HL0nBQbG5L8JdmPVjm5AkPtkl0W+OBgSKhjW4=;
 b=efUpWhmrktlx4EI27BdJN5/61KrSUNgznR8k1njE6yRKNQBBjElBwO4/TfQzxbZeDe
 gAYxBfvfn6vmQPKr8eV9Vis3Yz3y5nv/wLY2JB0Q1wekV4mIlewdFYLStJQ4PdtVOESx
 8qiTyOH9mw/Xpi5sa1RnbmBcnVxHnckPWQ6PN6UtS7FR6bO5xNGAS/MIdc+YMxZvoKXa
 /9Zz3tCTsoDrpib9+b3Q4Y9rhyD1ARuOS+6mEUe9MadDQQWO6IetGlpg6OJN7nC/6A51
 TQ3AKABsJxF3AWp2QEOWFBmwc37Yc3VS3Bvf3NbkaoI2Giue6XZ64RVRKt/EHToFdhU+
 eaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736590; x=1771341390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ab6xZ3HL0nBQbG5L8JdmPVjm5AkPtkl0W+OBgSKhjW4=;
 b=SRwe9Uu2HTg0AKsiOEhVzIru7bbytIHr3Ste+7k6u6Qpz4tJw6fT/6Mzbp1RiW7R2E
 8PwRW0EcLc3m0yPFKKlVfvrZ6JdASlyAnW02iseBaGy5Dn0+5KmKDTPeI90s3UHdskSi
 5ldZnfleHK0rvwMSq6YaUdiGV2EYgls1pyfuptBwwZh8tXIHOlS4DViyj5yODxr/oG50
 fK5cp1TwntWktMWz+gZ40shcaYEcVqY2/H0Rn0IfCwEI3vED55GXwqGOIH4wDQQJ4ooS
 BZDhd3m1VIFeCz+4gLUQGQ9j5B6qYZv7oKKOzIIbvn1a+PL0lI8i4EMkTKat5SvqAuTq
 k4DQ==
X-Gm-Message-State: AOJu0YwX9asCAEoULWdwjWoyFX0ZDx/bsmogIGA0v3DF+jpdV2raAvxO
 JQhtKVlnaA2yClSK5qLg9azA3zHbkkMNe1oy2qqMDYBKlCHYx7iXFxsv8JfOl2oi7rc9DzHGoQn
 hHgw2CjNpr92xcLC6mOLkNteu28qIS/w=
X-Gm-Gg: AZuq6aIPbdGTfGg8JcrbKThNt1kFGnmrRJxGPn5arnDm46wBdgQ9+rMZO1nHDRudtrX
 4sxX2FYMhkt6ULDaZGB+1JGaZlTwkFFgfBVr1DMIQ/8s85VKlBVD+jgxPqIvhuB0YRZQ3pPdmHx
 dNUzx1POXqO+qN7mVO3E84ZXPzhD+2Lkv7F/XnW5FjSSOzDe+wxMfWeT0xPYoTB5+FdgP8Kml6X
 VjEWWcxgB9oVi0DlH77CRCazhIVCyRsA7V2XM/9XPgPzgcvx+H7OoW4dsc3qrSJxQX5SOW/NO8g
 +GqxCTVTUdGvgSM2gcs=
X-Received: by 2002:a05:7022:91e:b0:127:1186:8139 with SMTP id
 a92af1059eb24-127249571fbmr454361c88.7.1770736590023; Tue, 10 Feb 2026
 07:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20260210144531.817154-1-siwei.he@amd.com>
In-Reply-To: <20260210144531.817154-1-siwei.he@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Feb 2026 10:16:17 -0500
X-Gm-Features: AZwV_QhosvlnfLOryhCkBYLWVwx5Pze6EsRzp3U-EkADVKi7-I0y_9dRq6ss1Mg
Message-ID: <CADnq5_OQ4pGSP8zdr5pE=gkFz2NiteTMu41OpuLt2NuDJb7NyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix APU to use GTT, not VRAM for MQD
To: Siwei He <siwei.he@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 harish.kasiviswanathan@amd.com
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

On Tue, Feb 10, 2026 at 10:02=E2=80=AFAM Siwei He <siwei.he@amd.com> wrote:
>
> Fixes: d4a814f400d4 ("drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM")

Move the fixes below the patch description.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Add a check in mqd_on_vram. If the device prefers GTT, it returns false
>
> Signed-off-by: Siwei He <siwei.he@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index d4659a438be5..a987e732e31a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -111,6 +111,9 @@ static void set_priority(struct v9_mqd *m, struct que=
ue_properties *q)
>
>  static bool mqd_on_vram(struct amdgpu_device *adev)
>  {
> +       if (adev->apu_prefer_gtt)
> +               return false;
> +
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(9, 4, 3):
>         case IP_VERSION(9, 5, 0):
> --
> 2.43.0
>
