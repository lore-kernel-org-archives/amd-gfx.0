Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A801061B3C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 12:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C69810EB42;
	Tue, 31 Mar 2026 12:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6R/F94M";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C73810EB42
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 12:37:38 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so225153c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 05:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774960657; cv=none;
 d=google.com; s=arc-20240605;
 b=bMjwwbnBWDXK0XPJG3z5po81esMFaXE40lBglxKHYHIGN5dNTvLWE+TsSn7IYuN3Ek
 70RAcXpO6oAL+CO0InVA7kl/9qUjxkHpX74r9NbcutPM3wpedhr2Y4ebdxZp2a0HmIJU
 VJDQSXkjma41nVc9Ku9UK/cUnanCKf3pBItwCydgqdsl7EQ9c9FxOdoy+PaCf88Frm69
 UU+zsBzdu1nwbZqka1f5jjnWEWkhR+z3L8NXbBeKV4Vy5f8a+nTYVcHjGngUsH5nNuDI
 tQF7kPDOldzxaKg/qSCbO8vTTGKBIXbaLzoMg8WPeYp7zBNuHtz2q5zAk/MaSW7y+8MW
 /D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4C+Ul1GqSNalNB48YgTTF7tXu4Vu4jEdzLR3XqrukB4=;
 fh=UXReYgOH978Q8YRGufbWWMgVMgvD+MB3VBXBHmVssj8=;
 b=X3kMZaS+X0+4wJM/ljsI5jzK0s1+V/Y9FHV0RKKB5N4SRqY8rY8d0eNUSHA4DKuMi9
 pi5CFRFHGWYBOXFAdaqpjhFniGu6cCGRTFBAzAdfOzBy+Qs+8+p9Nf29rvqwwqUltvvl
 Q7Isx9fqUW0VEbRPfwxFU4q2zb9i62SMa2CFO1t90BjLWHRH/pL+X1QmihoCDcw2FHbp
 psozu8DNMvtpPnmt7ZQvF/KQ2+zigIXo7PugpUTjMD2eEy+YI5FgRHqcESGTHoJyzMRf
 PHQsJsREmYz71peHSiuhwKbQL4XLPKzD93mKMNxcc//SaCFs296BFlWDw4TSJScY1mad
 bUqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774960657; x=1775565457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4C+Ul1GqSNalNB48YgTTF7tXu4Vu4jEdzLR3XqrukB4=;
 b=W6R/F94MpyudPlfMNIOclxnfEfnjOM8PVntvNMmV2GFY+Q0Wg6NxiHs+XcyhQ1quvY
 JLFPw0KE6Ig9Oo4gfDDup3YQHuZ9LfMb8LuiAY66iVBWEs4Ma0ReG7Vgb8ZRAfzZdYdT
 zA6ilPyzVq6wmJaxsrQhYrMNObPjs4VqAk4g4GVcE0PhccFyGQlFPEwwem5IKc+0pS4r
 0/Bgq4gn8p3Yb3BCke2Qo+EjI23WUg0BLgwhRe16J9isVwaX7ZKb9wsakZ46GP5sR0QY
 ml4WE3Pz50Va9WhX9SROTCz6Z9uwqusm2z4AGpxeEg0/CQeg9Z9OG07xFK1cETGZwyWf
 wXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774960657; x=1775565457;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4C+Ul1GqSNalNB48YgTTF7tXu4Vu4jEdzLR3XqrukB4=;
 b=cfb+PwpX4ee0gIH34130Qse5B/KewcLlTWu91LVxZormDfAEZysJjXj7D8Z7Wf6s9+
 Kj5gB/8yMpM4BdFT3MNnOqOJe1hzfoEkiLbUn/VZGmujmkMQjV1EDviTMgCS7c2dVdAk
 Kty9a5+JxHQMRj9z4ZwwpYrcwpX5PDTiSbhT4tBP00ledeveF7hqIaXepS5GE3+Tatl7
 lSuyBX58UZSIFKX9LXyCzkA6K6hdxhGAglXRM5NlNeVKGd5IBUfok2bM3qfctZThi08T
 Rhzy4YQappXmT32dt+At4pPg130Es1Tweks1iSuit2QkUKL5byRNXjqTH7wQ0jHpZnbM
 xPbA==
X-Gm-Message-State: AOJu0YwDLgFIzcEhitzqSDiFz68wwqvRHGjevyYgk4eGUnFYhAkvtpS9
 WQMPP1UgiomOBVlyYzK+CTkhCbVcUtvQ5Ra6yIYa9Z8tAcikw33j88rcwXc6xjnUfCqJFc8fzjy
 WZtHSNO0/O1CVjz7p8f0Ym4L+9qls1rs=
X-Gm-Gg: ATEYQzwh5zpF1s/MK4DPL/mjr2SC87Sxn28YpN76jKAwPESqg9HFaq3Lq9NNk4ykWy5
 HV5/aEW+KY5NmhP4SqKq8CSpz/iyMorsFCUwmri+6BlRtyergXvLaYESnILb9hW5W4FvciKFybJ
 RX2/wDTwm6O2xSmU1k35/PTqTrdmIUhkA8EzaycnmwZuWLyXiidzC0Vmos1jEIzS0HSVmB6+gPx
 Borj+dOxqvcs7ifBW8PqVtSXmbaRDyhOt6N28vl1z8NT0xlefp5ZKpV/Dr7k/w/4Y9X66KvyN6n
 OqMbuwZdc7wl4iu3eBZEVMG3WRzfvooASDFo7NozWOjZ7LikaTqxcB1lUo7vxzEv8kBgBQ==
X-Received: by 2002:a05:7022:eacd:b0:122:8d:39d8 with SMTP id
 a92af1059eb24-12ab28fa252mr4008495c88.6.1774960657194; Tue, 31 Mar 2026
 05:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260330222414.219436-1-David.Wu3@amd.com>
In-Reply-To: <20260330222414.219436-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 08:37:25 -0400
X-Gm-Features: AQROBzB_d4G58mD7MA8yr8-juQsMW-81aHNZ_k0Ykufq8LeAResar2oBlq29Or8
Message-ID: <CADnq5_MOaa72pyhwKBPQgp4F+Ld9HjpGgxgTLKX5cdjzRWvk7Q@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0 and
 5_0_2
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

On Mon, Mar 30, 2026 at 7:34=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> PCTL0__MMHUB_DEEPSLEEP_IB is 0x69004 on MMHUB 4,1,0 and
> and 0x60804 on MMHUB 4,2,0. 0x62a04 is on MMHUB 1,8,0/1.
>
> If deepsleep is working then the MMHUB clock will run slower
> while idle but speed up once anything happens, so some operations
> might take a little longer to get started.
>
> Based on the logic above and tested on RX9070.
> 1 with 0x69004 set 0x80004000 at start, 0x4000 at end
> 2 with 0x69004 set 0x4000 always at start and end
> 3 with 0x62a04 in case 1
>
> results:
>  - case 1 shows the best startup performance. speed=3D9.8x
>  - case 2 shows the worst startup performance. speed=3D7.5x
>  - case 3 is a little bit better than case 2 at startup. speed=3D7.7x
> This clearly indicates the case 1 is correct.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 28 ++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_3.c
> index 4b4aa9553624..03883b3b5670 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -739,7 +739,19 @@ void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu=
_ring *ring)
>         if (!amdgpu_sriov_vf(ring->adev)) {
>                 amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_=
INTERNAL_OFFSET,
>                         0, 0, PACKETJ_TYPE0));
> -               amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEE=
P_IB */
> +
> +               /* PCTL0__MMHUB_DEEPSLEEP_IB could be different on differ=
ent mmhub version */
> +               switch (amdgpu_ip_version(ring->adev, MMHUB_HWIP, 0)) {
> +               case IP_VERSION(4, 1, 0):
> +                       amdgpu_ring_write(ring, 0x69004);
> +                       break;
> +               case IP_VERSION(4, 2, 0):
> +                       amdgpu_ring_write(ring, 0x60804);
> +                       break;
> +               default:
> +                       amdgpu_ring_write(ring, 0x62a04);
> +                       break;
> +               }
>
>                 amdgpu_ring_write(ring,
>                                   PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADD=
R, 0,
> @@ -760,7 +772,19 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_r=
ing *ring)
>         if (!amdgpu_sriov_vf(ring->adev)) {
>                 amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_=
INTERNAL_OFFSET,
>                         0, 0, PACKETJ_TYPE0));
> -               amdgpu_ring_write(ring, 0x62a04);
> +
> +               /* PCTL0__MMHUB_DEEPSLEEP_IB could be different on differ=
ent mmhub version */
> +               switch (amdgpu_ip_version(ring->adev, MMHUB_HWIP, 0)) {
> +               case IP_VERSION(4, 1, 0):
> +                       amdgpu_ring_write(ring, 0x69004);
> +                       break;
> +               case IP_VERSION(4, 2, 0):
> +                       amdgpu_ring_write(ring, 0x60804);
> +                       break;
> +               default:
> +                       amdgpu_ring_write(ring, 0x62a04);
> +                       break;
> +               }
>
>                 amdgpu_ring_write(ring,
>                                   PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADD=
R, 0,
> --
> 2.43.0
>
