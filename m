Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C707FCCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 14:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E8110E81A;
	Wed, 15 Oct 2025 14:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ALYUblAO";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DB110E81A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 14:52:21 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-269ba651d06so10258935ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760539941; x=1761144741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJc/QN2ixZQ7vrcUbCNjM9j1c7KBgVGoNcbexVEkrF0=;
 b=ALYUblAO2ydyu4C5x6NXxXqT0CamyX63KNqYdhNn6PVu/BtId4vmzAQUE/FmPxUo/3
 T9hfN4SiG+bA32jWtvBVW/vcVOHyKaEqsaZunoBAZtaIwINYCmmk6GEvaxCY2eTZuhNg
 6w1wYhAKalgmN281hW3IqPdXxj7tBIC+LW/Xa33In+ctqKd8AVg55xmhMDjLx+Uf51ba
 JIYpgWzvXV5s9lmH1SX3uYHmuqLY24/4UnVx5k4vUsiKNTUYkU08flg5aw7+S1GsNvKp
 VIEfhodkHuvDbooHaHf8bRgOxvpkmxWfghTxMZ7cQOKW0S0LAAHks1Bw+Rv0mrYdPRX9
 KQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760539941; x=1761144741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJc/QN2ixZQ7vrcUbCNjM9j1c7KBgVGoNcbexVEkrF0=;
 b=lr3yWPrLFWflhr7WRWwTDyRAG5q2UzUi32/HpX4fZZCWpSE/3MDE0lPkYfGuZQAQwA
 i4kW8cGgkO3cjvGAs+AS2f1qhONsvzxElSHm79WRXDbLbcRRznZo2ZIlgdbeaCXsewLg
 m2UCRv1tzydRrIWUhvhF+sFbUWyZxI5k8RbHVH31oL6lbuoZ2Tbay2UCpRu+tAJp05Y2
 p2FtRV/jkJNR9LCor1NnFd82so3c3X2GGd/9GzVpZxvcJw7YjouMPRLIz88r30r0EmvO
 QEWXg43cgwe0zj77AILU8jIxdeGoDL1R/iZiYeCwy14BXKwFLO/dq1mpMxlx81PUQyoG
 eeGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsYc+1SjQ5b46JiiTsc57lUIoxDhd541BfMfUAr6IXbrJaPSKWTDlaGQ0s4pRwyiH3w04s4kNz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxR6ifPUxCOF6EO7wfMUfiOIfHJXnrsGr44GhTVQlPrvZ9KX7Gh
 Iz5l6fgGVVxehd0FpK8rc8JyprD2pryv+//aJKs5G+00RxodFabwMm2x4nnxe1V2A/ThS3XJOW/
 lqsTq9uguaxXlt4KAtcsb/eCnL8RXy2g=
X-Gm-Gg: ASbGnctUdIcHwr7KxnrNQd18PsGoijlb+o05a+v2TmfGb1sssY6e8M159lXBqBQp2Wp
 /3Mt4w7oiwuJo24joqPg+djVeQ4NuVAzghYIc7gBphcke1P/nKfKGm0aTlb02avOlPIyue6Ad/3
 BrLUa77ouXOfJEU2PRxGoUk5hO1VCSodZVoCB5l7s1fWCnKYaYdtmUeQFMCAIvzjUDkaufFxshs
 wg9/r0unSragRkWqYluA7ysOQ==
X-Google-Smtp-Source: AGHT+IHRA/49Zvs6ty7WxQHwT3tpm4T+ocMmiMVxtyoCTY17GKsVFADR2NV8Gg/gO4Kq/o77fSKRPNpSeFTlfDkbioQ=
X-Received: by 2002:a17:902:d491:b0:253:a668:b638 with SMTP id
 d9443c01a7336-290273c598bmr218849555ad.2.1760539940599; Wed, 15 Oct 2025
 07:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
 <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
 <d462f951-1b9d-4390-800f-9af09a7282d5@amd.com>
 <a1465fe4-f17b-4a72-935d-df0105a45e6a@amd.com>
 <6cc92ce5-908a-4b90-93d9-c648a48af49a@amd.com>
In-Reply-To: <6cc92ce5-908a-4b90-93d9-c648a48af49a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Oct 2025 10:52:08 -0400
X-Gm-Features: AS18NWA_wc7aY53kMBFoE09iOEYTh9QXjPlWdzcg1GuEZ4ExW5gTpU8glHVHeO0
Message-ID: <CADnq5_P_zwJveQ98HJUK5HetJVxWE-+FHYiU-MpVRSB-odV9kQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Oct 15, 2025 at 10:31=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 10/15/25 9:19 AM, Harry Wentland wrote:
> >
> >
> > On 2025-10-14 17:38, Mario Limonciello wrote:
> >>
> >>
> >> On 10/14/2025 4:27 PM, Alex Deucher wrote:
> >>> On Tue, Oct 14, 2025 at 3:46=E2=80=AFPM Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> [Why]
> >>>> If userspace hasn't frozen user processes (like systemd does with
> >>>> user.slice) then an aborted hibernate could give control back to
> >>>> userspace before display hardware is resumed.  IoW an atomic commit =
could
> >>>> be done while the hardware is in D3, which could hang a system.
> >>>
> >>> Is there any way to prevent this altogether?
> >>
> >> The obvious way is that userspace should be freezing user processes. T=
hat's what systemd does.
> >>
> >>> This seems like a recipe
> >>> for trouble for any driver.
> >>
> >> If we want to uplevel this kind of check I think we would need some he=
lper to report hardware status into drm and drm would have to call that.
> >>
> >> Most distros use systemd, and this only happened in an aborted hiberna=
te.  I guess I'd like to see how much this warning actually comes up before=
 deciding if all that plumbing is worth it.
> >
> > I was briefly thinking about a generic solution as well and don't
> > think it's worth it at this point. This is mostly about internal
> > driver/HW state.
> >
> > Harry
>
> FWIW IGT testing seems to have thrown up some problems with this which
> didn't show up in my unit testing.
>
> [  471.261018]  ? drm_atomic_helper_resume+0x2b/0x150 [drm_kms_helper]
> [  471.261031]  ? dm_resume+0x459/0x8f0 [amdgpu]
> [  471.261396]  ? amdgpu_ip_block_resume+0x27/0x70 [amdgpu]
> [  471.261635]  ? dpm_run_callback+0x9c/0x200
> [  471.261640]  ? device_resume+0x1b4/0x2b0
> [  471.261645]  drm_atomic_check_only+0x5d9/0x9e0 [drm]
> [  471.261672]  drm_atomic_commit+0x6d/0xe0 [drm]
> [  471.261697]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
> [  471.261729]  drm_atomic_helper_commit_duplicated_state+0xcd/0xe0
> [drm_kms_helper]
> [  471.261739]  drm_atomic_helper_resume+0x93/0x150 [drm_kms_helper]
> [  471.261751]  dm_resume+0x459/0x8f0 [amdgpu]
> [  471.262119]  ? preempt_count_add+0x7b/0xc0
> [  471.262125]  amdgpu_ip_block_resume+0x27/0x70 [amdgpu]
> [  471.262363]  amdgpu_device_ip_resume_phase3+0x54/0x80 [amdgpu]
> [  471.262598]  amdgpu_device_resume+0x188/0x3b0 [amdgpu]
> [  471.262842]  amdgpu_pmops_resume+0x4c/0x90 [amdgpu]
> [  471.263078]  pci_pm_resume+0x6b/0x100
>
> The issue appears to me to be that ip_block->status.hw isn't set again
> until the end of amdgpu_ip_block_resume().
>
> I am tempted to move it before the call to
> ip_block->version->funcs->resume().
>
> Thoughts?

Then it won't actually reflect the hw state.

Alex


Alex

>
> >
> >>>
> >>> Alex
> >>>
> >>>>
> >>>> [How]
> >>>> Add a check whether the IP block hardware is ready to the atomic che=
ck
> >>>> handler and return a failure. Userspace shouldn't do an atomic commi=
t if
> >>>> the atomic check fails.
> >>>>
> >>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>> Cc: Harry Wentland <harry.wentland@amd.com>
> >>>> v2:
> >>>>    * Return -EBUSY instead (Harry)
> >>>> ---
> >>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
> >>>>    1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> index 6446ec6c21d4..f5cd9982af99 100644
> >>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> @@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct dr=
m_device *dev,
> >>>>
> >>>>           trace_amdgpu_dm_atomic_check_begin(state);
> >>>>
> >>>> +       if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BL=
OCK_TYPE_DCE)))) {
> >>>> +               ret =3D -EBUSY;
> >>>> +               goto fail;
> >>>> +       }
> >>>> +
> >>>>           ret =3D drm_atomic_helper_check_modeset(dev, state);
> >>>>           if (ret) {
> >>>>                   drm_dbg_atomic(dev, "drm_atomic_helper_check_modes=
et() failed\n");
> >>>> --
> >>>> 2.49.0
> >>>>
> >>
> >
>
