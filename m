Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA26CC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 21:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C3510E5E2;
	Tue, 13 May 2025 21:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="neFPy5bQ";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D112710E5E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 21:01:25 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-23179999d4aso2159415ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747170085; x=1747774885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hm0/+LDbfdY+EE7SvcN7wIXWmGzGRTd2cvznFQ+E+lc=;
 b=neFPy5bQPSANxi/gx2MzKMDxoErr5+wd5j2v+0oxdnhoxzjUMnzoLjwHFDcyZGjAA+
 is6kH+pW/7WX2OLRI7XdKEmO1YEmyzmA/ez64h5Fbuosp8FE0FlRwPvL5eb/UDnlgF1G
 O4MJ3kdzq5aF0/L5CHYskRZ4KZB2WdD8WYrnF7Cif2ljGWg8ivEOKnHOEyrron+j7A+v
 M5fNAhLOd3PoKijEqhjd0SAamCc0Sx0jE8swSaU+SBkbDrKQwkvs8F6TgqrD6rMR0w5u
 nDcDaPKgqs0YVLnN1zmM/1WMofhT509VqKvqMZAqoUFKcFJkYTcnUH7M0QJ0gSBhd3+z
 152Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747170085; x=1747774885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hm0/+LDbfdY+EE7SvcN7wIXWmGzGRTd2cvznFQ+E+lc=;
 b=QcV3+n1Tut6gRNS9H+v6zXN5wS5LTyhlPuWuS0KNHi1h33mE0MsVkZJCmszd9k2xrO
 ZIsNSDTBkWa1vA0IfBNJFa0cN9vxpV92C3OcMTL8ZALyPW2KekdjmU6gHFGt0DTkdscu
 r8opDL73W+pfS3GAzkUT1JPK36HryWg2F8KIYwApNbzAF9VRifBRsh5awsEU1l84keU/
 Ywl/rWT1Y2bs/BfdX9sP2U1oll4ZOR6Th91FUZtpqswnd4r5LadB8uRwCfjvtGCLLDZC
 mwzOKp4BMEThcLmKjpH24It4vy6M46cNhEfE/17dA7dBJlWmBArxeMM5oa9Ss/8K5YrS
 yWWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCrGtN3meZAwRy5sbnAhIhmhuauvVeo1UBpnP9aH7aB102D44+N53wxBDouYy9TFfcMwT9LooH@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2d4cF+mXgx8zgX6mS/SslCn93EAW4L9BIzbUi+zMAZBpvO0zo
 3lTLXiO+WauY5lWua7UeZiddIsDugYk28+dpgUoyAXlHcTCBCr/l9V04cwRDw8L/gT6ZgiFPwwQ
 MoEDtMn9EXL/qo6C6EnGBcYcrsFI=
X-Gm-Gg: ASbGnctSxPtGdcpZgjFujwRUsf963mOAL2oLqdxbTBi2ytlOU0usuSgeINaswHA07Dj
 y8+UcMnw+kmyL10TEvZnZ1TZBkibQbjCpATOYZWXYVPjMKQY5+kNJiv513T6vpDnfmyp2Ug946K
 06UFjqPEjFmueab5vrlq7bZlRmgu7ojc+A
X-Google-Smtp-Source: AGHT+IFMHzAGxkv50zxWQVQqHfnUHuTddRSbvNdTXalT2ij70hJpnICOgJOdn6CW4/W8WGf2/pd3S3fsAxDRnv8sxEY=
X-Received: by 2002:a17:902:d547:b0:22e:62c3:8c5d with SMTP id
 d9443c01a7336-231981497e1mr5303465ad.8.1747170085089; Tue, 13 May 2025
 14:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250513182307.642953-1-David.Wu3@amd.com>
 <20250513182307.642953-2-David.Wu3@amd.com>
 <CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com>
 <732058a7-c995-4ca4-bd8e-04df669122ba@amd.com>
 <CADnq5_M2-3T8thYY-BtDOt_w+rxHFgyuPNCVnwyTY35kwKGsFw@mail.gmail.com>
 <e1e19625-faa1-409e-98f6-67c0cd240f61@amd.com>
In-Reply-To: <e1e19625-faa1-409e-98f6-67c0cd240f61@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 17:01:13 -0400
X-Gm-Features: AX0GCFsWsZZGGQWZYg_EZiZpszD566W6hibNby1VxiqfbKHYzcKegeo5PGVMfHA
Message-ID: <CADnq5_OnS8WR6OFNJmcH-eSVVq4YGuYrCCcXRT7h9P+P4ui_iQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] drm/amdgpu: read back register after written for
 VCN v4.0.0 and v5.0.0
To: David Wu <davidwu2@amd.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com, alexander.deucher@amd.com, leo.liu@amd.com, 
 sonny.jiang@amd.com, ruijing.dong@amd.com, 
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

On Tue, May 13, 2025 at 4:33=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
>
> On 2025-05-13 15:29, Alex Deucher wrote:
> > On Tue, May 13, 2025 at 3:01=E2=80=AFPM David Wu <davidwu2@amd.com> wro=
te:
> >>
> >> On 2025-05-13 14:40, Alex Deucher wrote:
> >>
> >> On Tue, May 13, 2025 at 2:23=E2=80=AFPM David (Ming Qiang) Wu <David.W=
u3@amd.com> wrote:
> >>
> >> V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start =
as
> >>      there are read-back calls already. New comments for better unders=
tanding.
> >>
> >> Similar to the previous changes made for VCN v4.0.5, the addition of
> >> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
> >> prevent potential race conditions, even though such issues have not
> >> been observed yet. This change ensures consistency across different
> >> VCN variants and helps avoid similar issues on newer or closely
> >> related GPUs. The overhead introduced by this read-back is negligible.
> >>
> >> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> Maybe split this into two patches, one for vcn 4 and one for vcn 5.
> >> That will make it easier to backport to stable.  What about other
> >> VCNs?
> >>
> >> will split.
> >>
> >> This applies to those VCNs where regVCN_RB1_DB_CRTL is used for settin=
g doorbell index, which
> >>
> >> means VCN 4 and up - all of them are covered (similar code is already =
there for those not in this patch).
> > Sure that prevents the doorbell from getting missed, but what about
> > other registers setup in the VCN start() functions?  What if some of
> > those are still pending when the doorbell is rung for other VCNs?
> I think adding a read-back is needed if there is any concern about race
> condition.
> If we only concern about start() it should be easy to add. The question
> is how we will know there is
> a race condition. Adding read back everywhere when missing after write
> is not a solution I think.
> For any VCN functions we need to check carefully
> (eg. vcn_v4_0_unified_ring_set_wptr()) in case it adds too much
> overhead and actually not needed (at least haven't seen the issue).
> Any suggestion as to where we should add or at the moment for _start()?
> I can work on it for sure or leave it for
> future improvement.

I think _start() makes the most sense because it will only be called
when we power on the VCN instance.  As long as work keeps coming in,
it will stay on.  The race is theoretically possible on any VCN
instance.  E.g., when the first VCN job comes in, VCN gets powered on,
and then we call _start() to program what we need.  After that, we
ring the doorbell to kick off the job.  The programming sequence in
_start() could still be in flight on the PCIe bus when the doorbell
gets rung.  Which is apparently exactly what happens when we hit this
issue on VCN 4.x and 5.x.  On VCN the doorbell gets ignored because it
races with the doorbell id register, but on other VCNs, the doorbell
getting missed may not happen, but it could be something else that
races, e.g., ring size.

Alex

>
> David
>
> >
> > Alex
> >
> >> David
> >>
> >> Alex
> >>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
> >>   2 files changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/vcn_v4_0.c
> >> index 8fff470bce873..070a2a8cdf6f4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> >> @@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgp=
u_vcn_inst *vinst, bool indirect)
> >>                          ring->doorbell_index << VCN_RB1_DB_CTRL__OFFS=
ET__SHIFT |
> >>                          VCN_RB1_DB_CTRL__EN_MASK);
> >>
> >> +       /* Keeping one read-back to ensure all register writes are don=
e, otherwise
> >> +        * it may introduce race conditions */
> >> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
> >> +
> >>          return 0;
> >>   }
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm=
/amd/amdgpu/vcn_v5_0_0.c
> >> index 27dcc6f37a730..77c27a317e4c8 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> >> @@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgp=
u_vcn_inst *vinst,
> >>                  ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIF=
T |
> >>                  VCN_RB1_DB_CTRL__EN_MASK);
> >>
> >> +       /* Keeping one read-back to ensure all register writes are don=
e, otherwise
> >> +        * it may introduce race conditions */
> >> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
> >> +
> >>          return 0;
> >>   }
> >>
> >> --
> >> 2.34.1
> >>
