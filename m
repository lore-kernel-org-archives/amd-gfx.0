Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9AFE7DEF0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 14:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C1210E4F3;
	Mon,  2 Feb 2026 14:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iZS4+0mz";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BEB10E4F3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 14:59:05 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1233bc11279so76989c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 06:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770044345; cv=none;
 d=google.com; s=arc-20240605;
 b=Gx8Avoh0MFXg9kwPDyWzVdq75J3YkRwYS2mMrOBRt22o788klMSbtJgdRVvI5J2zae
 8BgrlfP9X22VN7yOUZOnRBX2hcEhnMZ1NYzIbqh+okdVQAFHHat8AdA1x6WrIg5r/Sp2
 mRlJtTUtuZWS4xV75fOQI7bQrEDBcayViS6vx7MK4Fqrlpu2V/JopZkqE9ZEj2lr38Ag
 2+zQELgr2Ch7PuNvXI+nsFHAeurj5RRa9ed+aWcXDOgmzRk2N6UdSBXFbJoOd9FIMzBQ
 nker/pQTNv41qw2tV2x+apwQj/zRYfF9TCLHWVt87PS0guBNoZYShYXzoFksTksOopJp
 bfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gQRJkFAtvrDSoBzFZ5RqTeD1ft2EJueQQY8Q0SMaqVE=;
 fh=YySwN6y4VYk19/XRCuEAnka8gzDNTDo6XTlLCSFZb8s=;
 b=B1+lO8xVFetlcotVo4M8H5LDDIpp8dpcsojM2MNRAcb4HOKSlLpXusmU2SZ4k0YGEo
 RFWebhrHmuwFH99mLLiYYbzZiDq31aEWCp+61urXiJLojWnx6P1UybAFVyg5dHf/nCL1
 NjZD3uADivSu0NzmdOrYYHrm5a123qXlJoL1YUuZ+MrxJB+SC6Yww4oYrf0zsjUbfVb3
 Wcxj3EWomAVdGqU9Y5AsvkW5SZV3/KweZM71aNqEXy6Gtg2U+KhG4ZRXA1dcGbcQG3SI
 FZbzGBRatztU1+KgKD+QuYrRFXbZpkisVrCniou5iNYqLvI2gdEhuRLUaS5ltmcHC1IV
 iP9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770044345; x=1770649145; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQRJkFAtvrDSoBzFZ5RqTeD1ft2EJueQQY8Q0SMaqVE=;
 b=iZS4+0mz14OVpIjVjJcLdGouLHVHhmlQVHvxcEac+p3KiTxRBgn6KpGEgiKxcBgVGR
 r5beabjAJuSSDP0kqrX1Rdr48/lRMpsA3MjF7WNM6rqebTGCb8SvpCZDrrejeEmwUXx1
 tdJajOnJg50bgp2nvBNwCDmiPk93nJNZQ64qyKmHht9tt4El37O/uQHktxE1NGKz2W/5
 EZzSpysKgKxJ8BLTeyahNDnasOmZfT8kP4C7dRuxok1RETGnlBvT/WpzCuw16zcOkydY
 elL2zUSZwNMTxy5kh9uRKDW+C+4460HCDD/9TOVq0jbKHNWjfI8DlPvhAueF4TE36gn3
 rzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770044345; x=1770649145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gQRJkFAtvrDSoBzFZ5RqTeD1ft2EJueQQY8Q0SMaqVE=;
 b=iqPVEj+1Cm3hyFyf8AOf5brK3RT1+Lm33aUjKhuyHBsZWWt00/wggGQoEcVdl7120f
 maY3vZ2Yu+2XElMXRMWQuu/4paGa60hTXjogJi+Fo43UVTAUgMtgP4bnmePoC5GblpBT
 1QO311DDZm41zENDrsMJ0umfu9GLcqunXvAIJwkXBSxSDYvwDeljQogHbBLgRR6kLlkg
 ETRcCxK5EfuAkno2Ph9ibsCPeBZWdVSRGNajGRmHabrAuA3oSnAutVSb0Qen1b6nSb8a
 X/1U/dByXE+6PQkzVsIjxtdKQ6sIPhdAbFoptq7Nh21r61picRC8pVV3doVxAg7wiHY1
 b+ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1aY+apHxrNBQ1sEyP/LZGTEh7SErFAIkogrmwW/NWhIWD5fJYgbnkgyKjQ4u/4UWKTfuIpa3z@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8Jb55UpUT5naKykYbrOX8XNJQWnF5Sefb3IbccFlrbfn9HNrQ
 KIYgUiCBi7XIHj/+Z/VZs4iw7VfcFVEajeIiezqXwlnjDN/5y728yIZkPLtcT/FZQA6gecNv+z2
 mDWT5AjkzxJK6bQDPYjpBgsfSin5m0Ds=
X-Gm-Gg: AZuq6aLWWTIg5q+0HdJK13HBLuOuwhqrGcLg28ioYWIDsin8XersDP3J+WJrzI0kWjT
 nyZUOvHmqB56oy++OzlvsMQ8t2n4b5zsOZFc9NsgasgiQOBv3fRzt0dgppk+Oq5nSJB0hqb2LoY
 uN04fbFP/04VD9JuuG9BUTgo98eysgRnaEKtx9BdLsugkVGS1LUhfdrJvRBdTemlJfsce47Ghbd
 vvDbt7NNmynkfuXIbO+WLWnkiESeTofd4JMGsuhRt9rmQAHNpFmpMg4+BTSDu8ka68qLMet
X-Received: by 2002:a05:7022:41e:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-125c100d211mr2769154c88.5.1770044344589; Mon, 02 Feb 2026
 06:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20260129090542.907623-1-zilin@seu.edu.cn>
 <031ae8a1-5608-4993-91c2-c5945bd6f7ad@amd.com>
 <b814cdb3-ce83-4db1-b512-c69cc54bda4c@amd.com>
In-Reply-To: <b814cdb3-ce83-4db1-b512-c69cc54bda4c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 09:58:53 -0500
X-Gm-Features: AZwV_QiDoDYhtJTuOfzTcyXV6ivTEimVGJC73YpNEbATJ1shi2vzRf7wsO4niUk
Message-ID: <CADnq5_N6cop1YXgFX14YJipLkWa+UoZJ6a6Q5o_aq3TZuuTwNw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use kvfree instead of kfree in
 amdgpu_gmc_get_nps_memranges()
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Zilin Guan <zilin@seu.edu.cn>, alexander.deucher@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, Hawking.Zhang@amd.com, Prike.Liang@amd.com, le.ma@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
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

On Thu, Jan 29, 2026 at 5:12=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 29-Jan-26 3:00 PM, Christian K=C3=B6nig wrote:
> > On 1/29/26 10:05, Zilin Guan wrote:
> >> amdgpu_discovery_get_nps_info() internally allocates memory for ranges
> >> using kvcalloc(), which may use vmalloc() for large allocation. Using
> >> kfree() to release vmalloc memory will lead to a memory corruption.
> >>
> >> Use kvfree() to safely handle both kmalloc and vmalloc allocations.
> >>
> >> Compile tested only. Issue found using a prototype static analysis too=
l
> >> and code review.
> >>
> >> Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table"=
)
> >> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> >
> > Good catch!
> >
> > But i think we rather need to question why amdgpu_discovery_get_nps_inf=
o() is using kvcalloc()? I have strong doubts that we need vmalloc() here.
> >
>
> Yes, vmalloc is enough. That change can be made separately or modified
> along with this.
>
> As for this as a standalone change -
>         Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Applied.  Thanks!

Alex

>
> Thanks,
> Lijo
>
>
> > Regards,
> > Christian.
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c
> >> index 7e623f91f2d7..cb0d1ac148e9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >> @@ -1382,7 +1382,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_d=
evice *adev,
> >>      if (!*exp_ranges)
> >>              *exp_ranges =3D range_cnt;
> >>   err:
> >> -    kfree(ranges);
> >> +    kvfree(ranges);
> >>
> >>      return ret;
> >>   }
> >
>
