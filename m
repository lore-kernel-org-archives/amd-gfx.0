Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DD3D68BCA
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 15:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E08A10E87F;
	Fri, 15 Nov 2024 15:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RDjlbE/D";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60E110E87F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 15:11:15 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7245f6ee486so146712b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 07:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731683475; x=1732288275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=og8VSaTuk+HFjhVLLZpTLyR/9tW7nESoCuWuJKly3m4=;
 b=RDjlbE/DwBAzpS9bkEZCr8wMb2167eJko2F5I+i29QGow7NCOoF4EmsvFyNtUvLhOD
 eCjsxBaam0D2mqGasgnua67gQHk6iOCyYB0zDq2Us5S3H6mD8AlLjgX8XnixSMOCSZfc
 A85kct1b+DOo/EHACmDWzwGgPfFLy1y3hQiCGHA2VXTbK7OBymdNXUul1xJu0FqoyMg3
 FxXzLbXiJeClo+lsQL1Uc18fKP1NUdybK2Fg6wSHJksSRJlNQYvZFKM0fhaURP2S4bx/
 MhifjZtfUFv0gh7Mr8df+wFu3dU8ZU4XyCRx2AtDPm+me26qLFzgVaBRm3AUGVdxz93X
 SXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731683475; x=1732288275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=og8VSaTuk+HFjhVLLZpTLyR/9tW7nESoCuWuJKly3m4=;
 b=o6vZqdR8m5ud5MjyWeDgYJZVFWW8nxrDkt0mRkabA+7y7NfBu5y4l4yrrzLFp+I6s6
 7HQxMiTpELvTvcwkuEY6xXw00WlG/WwCNTPJDlr4neEZzSiEgikMGtL0A12r/pJh4m2C
 oVF9sUzlpRyaPqucjPPyy5uWUgSCKNJKHSfMk2yS8TEXhXEa9VH2ct/MarxagKPMDUxK
 Ju/19ljvlCDoCSyx7C9JMTOrb5XpJH7b5S1mKKh7aZq9PHSz6WHKkc0IjH7+9YP2g4Al
 zzDbYhVvolJevhOsmqULYerPc8VUxxtIznhXMZKKEo0bfYYacyqSDNnIRTCl9m/IT8RL
 l1Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUto0Kt7RrMoMBCMBoQ/a30npi5z3pvrYC9urG8a1J+ndHfK13GJbMldipSkGyltGRlqfY6ZLqh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx9nrmmNSh5YjTYir5J9bE+hDVdCZg3am9QuwH5h9L5DJ/n6LE
 xR7CLuU7NW3a3fqaL4ouNpx5OVDS5kuDpy8dEJYBvaAAD9vSIgGH//ElARpyvYfEGwxcmTQiklj
 EhBF9U0Q5OXnBKfQ5uUqtwQ3BPhU=
X-Gm-Gg: ASbGnctL7k15UYmcCUERLU/Qo1Dx31lkCeP8KvwBZpEqzTT+m9KG0oBQAVioqZVpIT0
 vT+GLyE5wj4MQkFaV2WImU5ZejF3aPHU=
X-Google-Smtp-Source: AGHT+IGenQ7ovVfMuOJg46hBf7u/+fZ5bHgmTn7xfnAB6OhFyqtfx+MH9acFflA1kCbGcI+C1BkpfjFK7gSim8m2DP0=
X-Received: by 2002:a05:6a00:a1c:b0:71e:5e9a:2db with SMTP id
 d2e1a72fcca58-72476cc7142mr1649544b3a.6.1731683475326; Fri, 15 Nov 2024
 07:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20241113214453.17081-1-alexander.deucher@amd.com>
 <20241113214453.17081-16-alexander.deucher@amd.com>
 <042c36ba-3a94-4d72-b2f1-5145d8fc623f@gmail.com>
In-Reply-To: <042c36ba-3a94-4d72-b2f1-5145d8fc623f@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Nov 2024 10:11:03 -0500
Message-ID: <CADnq5_N7-R7qgFLbMVk1bCNCtD0WDz2uTMzR6Wmum0HvdEdq=w@mail.gmail.com>
Subject: Re: [PATCH 15/15] drm/amdgpu/vcn: update work handler for per
 instance powergating
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Nov 15, 2024 at 7:27=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 13.11.24 um 22:44 schrieb Alex Deucher:
> > Only gate/ungate the relevant instances.
>
> That won't work, that is the whole problem why we started this series in
> the first place.

Why won't it work?  From my perspective, it was not that it wouldn't
work, but that it did not align well with the original abstraction.  I
assumed it would be easier and cleaner to split the instances as one
instance per IP block, but in doing that we also end up with a lot of
messy corner cases we had missed.  To solve them we end up with sort
of a hybrid where we have a mix of per IP block logic and global IP
specific logic.  Whis is kind of what we have now, but requires a lot
of churn and chances for regressions.

I think we could still go this route, but we need to take a different
path to get there.  We need to keep the multiple instances per IP
block in tact up until the last minute.  So, in the case of VCN, I
think it should work like this, building on this patch set:
1. Keep the current multiple instances per IP block.
2. Split the core vcn helper code in amdgpu_vcn.c to be per instance.
Carefully split the state in adev->vcn so that all of the instance
specific logic is stored in the vcn_instance structures.
3. Figure out how to move the IP specific harvesting logic out of the
IP specific code.  Maybe this means adding a new IP block callback
get_harvest_info.  This could then get called early to mark whether an
instance is harvested or not.
4. Figure out how to handle VCN specific sysfs files.  Presumably they
should be per instance.
5. Figure out how to deal with some of the interrupt corner cases
where on client id and src id, but the instance comes from the IV
cookie.
6. Figure out how best to deal with shared firmwares used by multiple
instances.  Worst case, we can just duplicate the firmware per
instance.  Some VCN IP versions have different firmware per instance,
some use the same firmware per instance.
7. Update all of the IP_VERSION checks to check the appropriate IP
version for each instance.  Currently we always check instance 0 and
make sure all of the instances are properly populated in that table.
There are cases today where only instance 0 of the IP version
information is populated even though there are multiple instances of
the IP.
8. Store the number of instances for each IP type in some common place
in adev.  Update the IP discovery code and IP specific instance
handling to update the core number of instances.
9. Add an ip priv pointer to ip_block structure.
10. Use the core number of instances for each IP type in
amdgpu_discovery_set_mm_ip_blocks() to add the IP blocks, one per
instance.  Hang the vcn_instance structures off of the ip block
structure priv pointer. Drop the VCN set powergating instance
calbacks.

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.c
> > index 3383e4146c6a..24e9a3126763 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -418,8 +418,8 @@ static void amdgpu_vcn_idle_work_handler(struct wor=
k_struct *work)
> >       fences +=3D fence[i];
> >
> >       if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> > -             amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCN,
> > -                                                    AMD_PG_STATE_GATE)=
;
> > +             amdgpu_device_ip_set_powergating_state_inst(adev, AMD_IP_=
BLOCK_TYPE_VCN,
> > +                                                         AMD_PG_STATE_=
GATE, i);
> >               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> >                                                   false);
> >               if (r)
> > @@ -444,8 +444,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
> >       }
> >
> >       mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
> > -     amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VC=
N,
> > -                                            AMD_PG_STATE_UNGATE);
> > +     amdgpu_device_ip_set_powergating_state_inst(adev, AMD_IP_BLOCK_TY=
PE_VCN,
> > +                                                 AMD_PG_STATE_UNGATE, =
ring->me);
> >
> >       /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>
