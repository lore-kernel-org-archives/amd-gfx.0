Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286E61090220
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 13:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E3B10E4A3;
	Thu, 19 Mar 2026 13:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EufdJ6IY";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2719C10E4A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 13:14:54 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-127337e3870so100421c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 06:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773926093; cv=none;
 d=google.com; s=arc-20240605;
 b=Xvn8wh8OlPU8mV6sQoN8lT7/pDpKHU3jGU2d38AqKL7s0wHW1IOfIdPv2jSmUxRDVU
 kHs/WhLNcAVowkksDXZ48qYq89uJ85J5nkj5gw06E+vPAx0g0rrOOSXaV6eeY/9DDWiy
 ASxtqeoaSJLMf0YJ7X4NyHfI/W1xxFr8Rysg4g9sl6rcVaYpw0+6kImvqwwQbuZt5yT/
 kFqFKO7267edNDRpue/3hhte1hOdJdfwBxvWi8MAhbSB17q2n/4umjND2fJBfzsFm8wY
 Nv1qI7K5NKnacj95yMRNgNc2qVL6dPQb6YGGA9H3HqLBuupM7CXFMP2jI7YxqqGKut0E
 w7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zwBJfXI9YWULBybPwP0rbPemFtNVNqX49dx/7bX6WCM=;
 fh=hjkhl6h7l6/eBEkg7zTGi74t0U0EikCmYyItzIVaf50=;
 b=B/vI8pFEAWA2iQQHyDBTjPpztFwIpoST5x6yPDPyRjqLoGQMyoJ0wFbOJ/wf9VA1MZ
 giqbxrd19SvmZHTLckTyLfICMZ7IHyQtt3G9ZdppbCxNAUdBEcfEiMHrOu4QUHDyEn3O
 LfXNaWP+qHkFx9GV82Oy4XhqHSiDBActgGHW7n2Ui5lDAtKcxgDoBEdY/ljqaoNCidmD
 oq3v5gVAuyZguAlTyIykwWlzC5ZshMPquO2SjZHfTuDfYDAz7l5iLt9pHz6egyZn0mJr
 zqI+HopBSTH7u8FsGRuJ1ae4d10eAW+prOaQ6pzvXeL+JdI3zXSEyNizWGBnvB4JOX8F
 XbqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773926093; x=1774530893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwBJfXI9YWULBybPwP0rbPemFtNVNqX49dx/7bX6WCM=;
 b=EufdJ6IYXjaQZrbWQ+0catXTkPV6ZXF2NPfHpuTAVhA2tKs8Xib2D4g0Rd73LW45KL
 RcuOhO73sC2Y5akRah0MGM4rKMURgjylmZLGWdbuVUbMztd9F49BKYBFpJm4JmRjW9aO
 v7WpBt3MWhMgFAtAHgO9OGJjXZDAHuQ8V+CpV1A9c9MHOMyDSfyTQ3Pcxtno8iD05MH2
 FJZK5FgyGwyGJSdsbop94xyUoI+1t8epapSa/6pm5zLtDL/j6Lz1G+E9wMqAGCcoz2lP
 sq3AHXOnn5VZ2r+BnAKSNM1Ix3bq+B/SMFX1x/vq2FkDn/rrMUAcp3Uaa+S28UCbKoJe
 NX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773926093; x=1774530893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zwBJfXI9YWULBybPwP0rbPemFtNVNqX49dx/7bX6WCM=;
 b=JYC5G7lsl7zYfpEQv3lS0UsugDRB7vT9oRixZK409aXSk9bKAZDLnm6a6qjlqxpUt1
 CyZ/0Jom+I92wF1svCPRMHooyJ/z+5Gn/WgpbWbwie7h7wBSJgCFG9zvhw8/FeJnWK5d
 9g3vgy3fqT972EB9TJmQ6IersB/s5lWTREaRtXP9ZpBRVuI+8ohl1w6bEd+YeFHs08Qi
 2VWao3yT/BT8r1abtNRKnwti2yQZsxoHydEQGEXjQXGlJQfE6cXJvvCqQtjITn6C3S+V
 S50PjyMeDUX733tB/T4qtf4YbRLfuTLRHg7bUM0XZkLlNzY2NgFEXhi0T51nFX7Y8K0y
 +aEA==
X-Gm-Message-State: AOJu0YzXnd1+nrfMIsD1i5JCBv816MPhtKLp905+Bc/AZewtzY+6G+mX
 AtdN/7yGAEH+43JCAwfxaNbYKY+1n/tjAaoIfgc1fv74ndUMW0wBUmRqwUBsKH61PPKLNB0hBFt
 feugYZT3qqrCKBOYCdCse6L+l8BOSRBG//w==
X-Gm-Gg: ATEYQzybCfYxHMdCHT1XGAX/kor08p7xTyWyOeDhJZe3caGOJ6l6IuMGVuRXneDmKfL
 s7mmDbqspE0D1cDHztqIZ0VcpDkMQl02Uco/n3Ln9jBY6lwLuxl4ug82Zevrr6zSMjsleF6J4bj
 OKdZBhy+JxWb3XADttEAnt+Zj8dSeGTa0r8hd4DXRl2mEikRxXz3+yPj7EBJRKUgiTevmabO1NW
 yePqg0SitM1+te+j75Lsj+JFZKiKICo/xqQP+rPbz2koC5Vslq16rDhU3UPRp3C+JuTMHX96cta
 q9UTSjfFDODaqP0jPMfytzR8eV+n4w0gU0+kMZz/SiqX/hpYKNVicJzv7SBasLFH+poy3A==
X-Received: by 2002:a05:7022:e2a:b0:127:3480:7ca5 with SMTP id
 a92af1059eb24-1299ba66068mr2011932c88.2.1773926093278; Thu, 19 Mar 2026
 06:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260319104529.3254-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260319104529.3254-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Mar 2026 09:14:41 -0400
X-Gm-Features: AaiRm52cV7C1YpV_roqayiPAeOhwnndwpFOM-wPvDNPEdVTByAg3W_DMIPIfgAw
Message-ID: <CADnq5_NVd=EoRnKjV=qAQas6JfpSxMmZVmjkC0-wFJt1p9UQ8Q@mail.gmail.com>
Subject: Re: [PATCH v] drm/amd/pm: Enable VCN reset for pgm=4 with appropriate
 FW version
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
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

On Thu, Mar 19, 2026 at 6:54=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Extend the VCN reset capability to include pgm=3D4 variants when the
> firmware version meets the required threshold (>=3D 0x04557100). This
> follows the existing pattern for pgm=3D0 and pgm=3D7, ensuring that VCN
> reset is enabled only on configurations where it is supported by the
> firmware.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 5b9580034641..deb8f827abcc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -461,6 +461,7 @@ static void smu_v13_0_6_init_caps(struct smu_context =
*smu)
>                 smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
>
>         if ((pgm =3D=3D 0 && fw_ver >=3D 0x00558200) ||
> +           (pgm =3D=3D 4 && fw_ver >=3D 0x04557100) ||
>             (pgm =3D=3D 7 && fw_ver >=3D 0x07551400))
>                 smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>  }
> --
> 2.49.0
>
