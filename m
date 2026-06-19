Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133E8CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 17:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B8410E0C8;
	Fri, 19 Jun 2026 17:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a/4v1NTU";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFF510E0C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 17:01:34 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30bb87c90deso296491eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 10:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781888493; cv=none;
 d=google.com; s=arc-20240605;
 b=bTqJbPdWNXSEWGgR6XYK4VTTwB0159WL6xvB3XfSd0keWhKWNcZC5Z7HosH64ZJ6RJ
 yQaTApkPdtMsBweUzvFY4Z+enf0nsXRwAF0FaAMO7TsCB7paLlbtSbA6ZMCCba6rvjuo
 ZTOH7rB/T/LFjah7IYf5hc5JkGDfFy5WD3veJdbU39Bggggaxh3BAsWvGXFbjdO5c1J/
 612Mn3lLV1s/1/Hst4AoFg4SU21AN3ZcL/XGsmMx6loMXTtMAPMsTC59zp6uctuA07/h
 L9vaeHJphP7UNPGGRNRDCwaSyUhAU68tylXDBJJjhU915RTwzOWBFy2JNIn6vx/QAbXj
 1Tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BbuNu4apCCfeOch3ILkDIdwU8lySKZKEHX+tyJ+F7HA=;
 fh=i/Vmil9oF264iK2FdD0YPJGpsSdWGOxRy2NTQotl41Y=;
 b=hvTMQnLbwZYjINQfngA+H0m39yY/2vOWtgD23kAG6LEdgQQ7d7jmCAfzjjXkKsmSo3
 iJkCbarOc72lbOe4+xzb/Qd2HMHQ448U8gAyvdlvX2WkNqRQdc9bhy+PrB5WhSPofXAX
 hzSL49Kdzt6MQaps/Dfa9V1iEfWg+0NDW0lzPlkaiGjjK40BvKeqMD4udoL8t2z/aEsa
 KOoKPcvYO5kaqP3rXScMdT9FKWTWj2IE1FdLpyN2+ACkHKXmsRc3f+FowjjXbsPudOQL
 9Cs2HRzHe1IN9hf2ntkcbyVcWPtK3GZgna5SY7+RiMtAcRzXQ/sV7LYpNIKatIYw7JVv
 0mwg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781888493; x=1782493293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbuNu4apCCfeOch3ILkDIdwU8lySKZKEHX+tyJ+F7HA=;
 b=a/4v1NTUNSxXTROkTCnhoafBFwt2X6qzeKVYHFZFoQWSBQyphpFGyX8nyd2ipyiCuP
 Q/GFUHL11MZdcQVkeJUBJG4NWEdU3yyn/Ig6Y37I3cCgxxejRAiDaQBWkpGeY39eM9NE
 y91Vf4lAZ0Cdf8ScrJz97Y7ddMemSD4yiwh7WoCRhrWZZlTI7SybcPX1E8R7PbYBjTBB
 ZyOCQ1cM12ywLXvO3cd68KPT+LxzWI4JgOvbUU23RLWkhAg2TAtt3M2vcBXGa2GqM21o
 TN07Pnl1lfQDXC2WtjL7++F8PDpjcxIU30TQdS+PX/L3Kvh1Kdwc1fZK5+3rA+tz2ju1
 Gt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781888493; x=1782493293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BbuNu4apCCfeOch3ILkDIdwU8lySKZKEHX+tyJ+F7HA=;
 b=QavS9kSPFzJdXqJO9OUk/uVImCDj6J35tI4YpS2nxt5MvR7VhNN07547YiAWCtxu6U
 or5p3QOvFWhXhznb9OqTzD5TZLFlN6xAeDrcgoIXUfA8dWXUJfPWb/2PQKNBsEkcRJYq
 lofaGj1cSkt5kzu/NW2xtRcOzrmlFPIjh7MRP/tkSyzxKQHlfLSzd7KdkTttXm0ytlL9
 XNH/L6+6DYofTAJYWkHzhDbPpfsVGP+9F64NfxGyuHbL8IkJA4Dtkwj16l20K36Zk+Ew
 sw/j8nSQGPJp6fGVZI/D5tzQVEBEL0x205HRkHttwybXwjQjfPJZTI+EWX6lqJSNXNqT
 PEug==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hJnQ1w8GT2CXPctNSOy2y6TyLm7PqJKLcEo6pwW4Fo5D+cC26KXp+y98u8d8lgvytxVo83d7H@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7fTvlsoMwuvd2LEGRZ4pktSUXijR0Qs6Gsyp3PAFMt1oBgP0e
 h0z0JD5ZGUdX4qB/ODfGFG4+64XmxYnJtT2SF7xxuAGCcX4wM/rc+dpfZZ1fZ8ZCPiVa2LttXFh
 JCaXT5G16lUD9Jq2meZZ5Hj+tqCQQBLpqTA==
X-Gm-Gg: AfdE7cmRCU/MaOtWuIudvz315mtDUo0+ltfGWnbboEdZxEOGdsXGAltY7YF+sMVLNrK
 2TfTP5qDX1YY1AuIkG2RHDZFlIwWMIrxulovqjyMph/GA4IcGQFV3o4mIYiwM7LIaIUeliBFCO0
 doORLiYPfAHBHjkb+gPwXwezjVkmeb4FuoHk20gvYcEzF4/4MZ9UhPP+ABXxqIR0WSNtVmeMa9i
 eMfd99HGu6TIyvlzvqZg0SxJ0hXq/NrBTCPVBV+ELYhYYxVlwgFotsqdOgFQ4xH+IxOj7QdB+dw
 em3nIBVv6cpdQ03fljFuwoME45V+hr3LFg5r9jUjs0f2BsIlVTO0gAnG5UQ=
X-Received: by 2002:a05:7023:c084:b0:136:b71d:a90b with SMTP id
 a92af1059eb24-139a1f2c904mr796629c88.0.1781888493176; Fri, 19 Jun 2026
 10:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260424125003.52366-1-tvrtko.ursulin@igalia.com>
 <8693b119-f870-43eb-ac8d-f4c69419693e@igalia.com>
 <CADnq5_Pga5tgYgnf3gbnL10uCf9pRvv87=U1TYprgPR_c9NFeg@mail.gmail.com>
 <55a72da8-e81c-43e7-bb9c-6f0e070cbae8@igalia.com>
In-Reply-To: <55a72da8-e81c-43e7-bb9c-6f0e070cbae8@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jun 2026 13:01:21 -0400
X-Gm-Features: AVVi8CeHSqF9FRWjL6d_Z6VxozBYy97UnPd8Dqh1L4AYjBr-DjwBt80nQc9NAdo
Message-ID: <CADnq5_MsR8eR0M0x9i6PGPUn9M9kdVUwgnvQjY==E4zZm9f1dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Choose SOC15 RLC register read write
 functions at init time
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Fri, Jun 19, 2026 at 12:57=E2=80=AFPM Tvrtko Ursulin <tursulin@igalia.co=
m> wrote:
>
>
> On 16/06/2026 16:01, Alex Deucher wrote:
> > On Tue, Jun 9, 2026 at 11:06=E2=80=AFAM Tvrtko Ursulin
> > <tvrtko.ursulin@igalia.com> wrote:
> >>
> >> + Alex - wondering you you are interested in this type of a thing or I
> >> should drop it? Unless I am missing something (could be, it was long
> >> time ago when I first wrote it), it is a nice .text saving of pointles=
s
> >> conditionals.
> > Yes, sorry for the delay.  This just fell off my radar.  I've applied
> > the series.
>
> Thank you!
>
> Were you just brave by pulling all three of my series, or they actually
> passed internal CI this time? :)
>
> Anyway, I am around to fix any fallout, if there will be, and if reverts
> will not be a more suitable course of action.

Yes, they all passed CI :)

Alex

>
> Regards,
>
> Tvrtko
> >> Regards,
> >>
> >> Tvrtko
> >>
> >> On 24/04/2026 13:50, Tvrtko Ursulin wrote:
> >>> Currently on every RLC register read the driver checks for three diff=
erent
> >>> conditions to decide which of the two register read/write functions t=
o
> >>> call.
> >>>
> >>> As these register operations are macros, which is required for regist=
er
> >>> name expansion to work, the result is a significant explosion of gene=
rated
> >>> (redundant) code which the compiler cannot optimise away.
> >>>
> >>> We however know that all of the three conditional are static and can
> >>> therefore move the decision to driver init time. All that we need to =
do is
> >>> define a new vfunc table for the SOC12 RLC read/write functions and j=
ust
> >>> use them directly.
> >>>
> >>> Bloat-o-meter agrees the driver size savings are significant:
> >>>
> >>> add/remove: 11/35 grow/shrink: 82/1117 up/down: 53024/-450922 (-39789=
8)
> >>> ...
> >>> Total: Before=3D10293928, After=3D9896030, chg -3.87%
> >>>
> >>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c    | 39 ++++++++++++++++++=
++++
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 10 ++++++
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  2 ++
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 ++
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 ++
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 ++
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  2 ++
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 ++
> >>>    drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  8 ++---
> >>>    10 files changed, 64 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> >>> index 30ce2e85a506..bd1b0e9ee220 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -3745,6 +3745,7 @@ int amdgpu_device_init(struct amdgpu_device *ad=
ev,
> >>>        mutex_init(&adev->gfx.workload_profile_mutex);
> >>>        mutex_init(&adev->vcn.workload_profile_mutex);
> >>>
> >>> +     amdgpu_early_init_rlc_reg_funcs(adev);
> >>>        amdgpu_device_init_apu_flags(adev);
> >>>
> >>>        r =3D amdgpu_device_check_arguments(adev);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_rlc.c
> >>> index 572a60e1b3cb..002fae3c380e 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> >>> @@ -583,3 +583,42 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_=
device *adev,
> >>>                amdgpu_gfx_rlc_init_microcode_v2_5(adev);
> >>>        return 0;
> >>>    }
> >>> +
> >>> +static const struct amdgpu_rlc_reg_funcs amdgpu_sriov_rlc_reg_funcs =
=3D {
> >>> +     .rreg32 =3D amdgpu_sriov_rreg,
> >>> +     .wreg32 =3D amdgpu_sriov_wreg,
> >>> +};
> >>> +
> >>> +static u32
> >>> +amdgpu_rlc_rreg(struct amdgpu_device *adev, u32 reg, u32 acc_flags, =
u32 hwip,
> >>> +             u32 xcc_id)
> >>> +{
> >>> +     return amdgpu_device_rreg(adev, reg, 0);
> >>> +}
> >>> +
> >>> +static void
> >>> +amdgpu_rlc_wreg(struct amdgpu_device *adev, u32 reg, u32 value, u32 =
acc_flags,
> >>> +             u32 hwip, u32 xcc_id)
> >>> +{
> >>> +     amdgpu_device_wreg(adev, reg, value, 0);
> >>> +}
> >>> +
> >>> +static const struct amdgpu_rlc_reg_funcs amdgpu_rlc_reg_funcs =3D {
> >>> +     .rreg32 =3D amdgpu_rlc_rreg,
> >>> +     .wreg32 =3D amdgpu_rlc_wreg,
> >>> +};
> >>> +
> >>> +void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev)
> >>> +{
> >>> +     adev->gfx.rlc.reg_funcs =3D &amdgpu_rlc_reg_funcs;
> >>> +}
> >>> +
> >>> +void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev)
> >>> +{
> >>> +     if (amdgpu_sriov_vf(adev) &&
> >>> +         adev->gfx.rlc.funcs &&
> >>> +         adev->gfx.rlc.rlcg_reg_access_supported)
> >>> +             adev->gfx.rlc.reg_funcs =3D &amdgpu_sriov_rlc_reg_funcs=
;
> >>> +     else
> >>> +             adev->gfx.rlc.reg_funcs =3D &amdgpu_rlc_reg_funcs;
> >>> +}
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_rlc.h
> >>> index e535534237a1..959d60c90dcd 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> >>> @@ -262,6 +262,11 @@ struct amdgpu_rlc_funcs {
> >>>        bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint3=
2_t reg);
> >>>    };
> >>>
> >>> +struct amdgpu_rlc_reg_funcs {
> >>> +     u32  (*rreg32)(struct amdgpu_device *adev, u32 reg, u32 acc_fla=
gs, u32 hwip, u32 xcc_id);
> >>> +     void (*wreg32)(struct amdgpu_device *adev, u32 reg, u32 val, u3=
2 acc_flags, u32 hwip, u32 xcc_id);
> >>> +};
> >>> +
> >>>    struct amdgpu_rlcg_reg_access_ctrl {
> >>>        uint32_t scratch_reg0;
> >>>        uint32_t scratch_reg1;
> >>> @@ -303,6 +308,7 @@ struct amdgpu_rlc {
> >>>        /* safe mode for updating CG/PG state */
> >>>        bool in_safe_mode[AMDGPU_MAX_RLC_INSTANCES];
> >>>        const struct amdgpu_rlc_funcs *funcs;
> >>> +     const struct amdgpu_rlc_reg_funcs *reg_funcs;
> >>>
> >>>        /* for firmware data */
> >>>        u32 save_and_restore_offset;
> >>> @@ -374,4 +380,8 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *ad=
ev);
> >>>    int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
> >>>                                  uint16_t version_major,
> >>>                                  uint16_t version_minor);
> >>> +
> >>> +void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev);
> >>> +void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev);
> >>> +
> >>>    #endif
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v10_0.c
> >>> index 8b60299b73ef..4bfdd55be7f9 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> @@ -7829,6 +7829,8 @@ static int gfx_v10_0_early_init(struct amdgpu_i=
p_block *ip_block)
> >>>        /* init rlcg reg access ctrl */
> >>>        gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
> >>>
> >>> +     amdgpu_init_rlc_reg_funcs(adev);
> >>> +
> >>>        return gfx_v10_0_init_microcode(adev);
> >>>    }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v11_0.c
> >>> index 8c82e90f871b..8b9a9d944641 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>> @@ -5341,6 +5341,8 @@ static int gfx_v11_0_early_init(struct amdgpu_i=
p_block *ip_block)
> >>>
> >>>        gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
> >>>
> >>> +     amdgpu_init_rlc_reg_funcs(adev);
> >>> +
> >>>        return gfx_v11_0_init_microcode(adev);
> >>>    }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v12_0.c
> >>> index 65c33823a688..a5034e39a8e9 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >>> @@ -3912,6 +3912,8 @@ static int gfx_v12_0_early_init(struct amdgpu_i=
p_block *ip_block)
> >>>
> >>>        gfx_v12_0_init_rlcg_reg_access_ctrl(adev);
> >>>
> >>> +     amdgpu_init_rlc_reg_funcs(adev);
> >>> +
> >>>        return gfx_v12_0_init_microcode(adev);
> >>>    }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v12_1.c
> >>> index 68fd3c04134d..13de1b356e9d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> >>> @@ -2915,6 +2915,8 @@ static int gfx_v12_1_early_init(struct amdgpu_i=
p_block *ip_block)
> >>>
> >>>        gfx_v12_1_init_rlcg_reg_access_ctrl(adev);
> >>>
> >>> +     amdgpu_init_rlc_reg_funcs(adev);
> >>> +
> >>>        return gfx_v12_1_init_microcode(adev);
> >>>    }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_0.c
> >>> index 95be105671ec..100b5ee44fef 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>> @@ -4816,6 +4816,8 @@ static int gfx_v9_0_early_init(struct amdgpu_ip=
_block *ip_block)
> >>>        /* init rlcg reg access ctrl */
> >>>        gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
> >>>
> >>> +     amdgpu_init_rlc_reg_funcs(adev);
> >>> +
> >>>        return gfx_v9_0_init_microcode(adev);
> >>>    }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/dr=
m/amd/amdgpu/gfx_v9_4_3.c
> >>> index ad4d442e7345..2e17fc1157fd 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> >>> @@ -2525,6 +2525,8 @@ static int gfx_v9_4_3_early_init(struct amdgpu_=
ip_block *ip_block)
> >>>        /* init rlcg reg access ctrl */
> >>>        gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
> >>>
> >>> +     amdgpu_init_rlc_reg_funcs(adev);
> >>> +
> >>>        return gfx_v9_4_3_init_microcode(adev);
> >>>    }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/=
drm/amd/amdgpu/soc15_common.h
> >>> index a7b5a95ebebb..a04f61b22379 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> >>> @@ -38,14 +38,10 @@
> >>>        (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)+(of=
fset))
> >>>
> >>>    #define __WREG32_SOC15_RLC__(reg, value, flag, hwip, inst) \
> >>> -     ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc=
.rlcg_reg_access_supported) ? \
> >>> -      amdgpu_sriov_wreg(adev, reg, value, flag, hwip, inst) : \
> >>> -      WREG32(reg, value))
> >>> +     adev->gfx.rlc.reg_funcs->wreg32(adev, reg, value, flag, hwip, i=
nst)
> >>>
> >>>    #define __RREG32_SOC15_RLC__(reg, flag, hwip, inst) \
> >>> -     ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc=
.rlcg_reg_access_supported) ? \
> >>> -      amdgpu_sriov_rreg(adev, reg, flag, hwip, inst) : \
> >>> -      RREG32(reg))
> >>> +     adev->gfx.rlc.reg_funcs->rreg32(adev, reg, flag, hwip, inst)
> >>>
> >>>    #define WREG32_FIELD15(ip, idx, reg, field, val)    \
> >>>         __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg=
##_BASE_IDX] + mm##reg,   \
>
