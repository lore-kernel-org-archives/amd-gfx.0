Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3122CD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 14:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756A610E812;
	Wed, 27 May 2026 14:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SNLxNghW";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2EA10E812
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 14:53:28 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f24905306dso1252739eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 07:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779893608; cv=none;
 d=google.com; s=arc-20240605;
 b=f0Y922rxVDGTuTSmVVXRL+7uFSO4jM8wTRmPPQGuoJyw9jMIc3YcUwDsnyzqS74RhU
 i/HCgMCrJzr6QD6O+sJsNiXuUGLyJ+mVIwWJeZlZ4f8mndIPvbwSNMLn1snrPF94nCFj
 9zn8RFvqn0KFs0lcRdyCVHi6+aDXss4wsM9bb6yjc6IAZZnMY3f0Rwark3+zocm7BMIJ
 LdZciOd9yoj0o+TwnVQCyQJMJ4muTp0dPFqW/zhWC7p9SfQApWspexyY6wAMgzMOYRSu
 Jiy2eEnUfV4JcYyDgLBhcddGUd6n2pu38uPpfVSxI+jiyMHME9gXc2pRoceQfgZ/wwFN
 xMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XROd06mogEZ8MfUVOoAot6h7W7ooA7c3mzHnmbPJulI=;
 fh=gZ/QuQ1El2NU1RRI5pc/CAX4Mv4g4Ez7PWwEsOz7Ag0=;
 b=VQwFnHQoEK4TpPLeAWupJ4vFpBsNh3P6Hoc5/drm0QIlwe/ge2CShHVPcL8VRsIHTM
 Y/aYE+ebPX5ZwOeN2H9qRTtSEdf1DgoRLzYNNEBsb4XVQhDSPxC3fk4+ldz0Iz3u3vmC
 G3KIf/0SToMdnnd86UmcyPfeON8WtSc9UYQVbCaH/FO4sMrMDRoH1nOOgzZD8+gBZvsD
 6gvbarts7ej1WR49YzsqxFTaxedMa200H6tRxs+kjkGoBk9O8M+QEp5/jHJQA9Rw+aM9
 Or+CeZmwEq9rIxxq+8wQJPd8b+WYalUp7oXVxOt7AQYaRv88XIUSjTDo+eeLzTV0gL3s
 GSyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779893608; x=1780498408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XROd06mogEZ8MfUVOoAot6h7W7ooA7c3mzHnmbPJulI=;
 b=SNLxNghWTDl+wRkO5PJVHArknSCRzvh9EUdBoDwiDG4lUgEKXcIyQOGa+GsnSVyf5L
 jNF/c7BcogEjqU41hiEASDluPcsEQJ8s1bzlW999TAXVac5+h/1ViRVKMBXhCnnnDN8m
 jeNBUll3S+weGG57sGonEZOhd5KVAPwC8BoVVEu2VqEsXIrnKTsJCm2NvRtWr2REE4P6
 R7q4corbNKycPa/U8xxCWZHsZk89x3wEPZq4fxMS49woVNZORKqqSJRoOThupO5/XgXp
 GwNsnEQ0DT6RVvluFe3Hbt7+hRohBs/0bG9dW5DspsTmmQO3yWAMOmoMuGOkJUtmGYo2
 TqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779893608; x=1780498408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XROd06mogEZ8MfUVOoAot6h7W7ooA7c3mzHnmbPJulI=;
 b=CvONqNkRmuoXJp8+TAbNJ9YVk37c4M75HSFsNY264nZICpjQBOxgtw6IQu352hsZyp
 a99Bn01J2qoiX5FLZ+e2JOCZZlP61/nuAwXtMqmn26mv41mveioTF1C5zyTDNjcxE+b/
 ByK51pWvdcv9PPuqpy3DCGPJZRp7qg3dgdLmtl2tSgR/lV3TCbyTmPqBanEg9rtyz6ym
 gAd6UUtmMAvOuM7iPjUn8YhoZ8nPjgO+Jx9V1QNPIx0pQIEDIQxnC9CXfCMJkFd/TQ7w
 WUSgigqrggH1CGBNNDZa1f3GG+0nYHdyPAUvlETfvnmCKegR5m3Zfvpy8pkuzvVi3YuL
 lB6Q==
X-Gm-Message-State: AOJu0Yx1KEDpJ7Zvi/lLEL+ymSEK780Rc3mHRlTQAp1xm+v7A5xMBW3V
 x5ea6J3gWDc7ka6DcJztATtz7qIOuaHGLeTJvlDVhIr0RFw+6CW+kFzZU075weaammeAZmdk1GJ
 9b5iCKTpMdr6lq4qR8Xm1YflleH3Ba50=
X-Gm-Gg: Acq92OE/3PxFQ+05UUgNMSYT8p1sQwnRZSrsd8ucIhUiW5aIMs7898CC1OcEkASdnIK
 vI/4z5kWBI8d5ujQ1SHvR21r/DgkpTGZNMVy547FpM5K9nj95/4kyN6zboYv0dM2FMFlm49c53A
 5NAdiucLcS3M7ao6BbfPLJNVsQEqJ9pVbre1FP3uj2i5nJPYI6Em48gdyYCJtpuVzWDxK2ZSYlt
 szlmAKsZUqUqNrvUnljI+mvkJ5XB+M5cb3kgwimRSPgdfS+vnFTwZj1umltL4h6+oT2rbBWNVO8
 kdFuiaaugfZG4s0Yz2K/AQAT7fLqS/opZpPvvPl0FOxIGO+7sFFH37PabBCFg43lJJX4J/fpjF0
 pseqx
X-Received: by 2002:a05:7301:198f:b0:2f0:ddce:8468 with SMTP id
 5a478bee46e88-30449193017mr4751603eec.8.1779893607521; Wed, 27 May 2026
 07:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260527141014.567441-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260527141014.567441-1-Yongqiang.Sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 May 2026 10:53:16 -0400
X-Gm-Features: AVHnY4IkFYeVcXAgRn7sxwaplIdsqUOwkYNh_-IuySsVuanhhbk2km8MbjoiGaA
Message-ID: <CADnq5_N3U1QogF0hkZi6NhcUhrqMpgNzVsDfe7R2xFD9E3VH8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix SMI event cross-process information leak
To: Yongqiang Sun <Yongqiang.Sun@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, May 27, 2026 at 10:29=E2=80=AFAM Yongqiang Sun <Yongqiang.Sun@amd.c=
om> wrote:
>
> kfd_smi_ev_enabled() skips the suser privilege check when pid=3D0.
> PROCESS_START, PROCESS_END, and VMFAULT events are emitted with
> pid=3D0 while carrying another process's PID and command name, so any
> /dev/kfd user in the render group can monitor all GPU workloads.
>
> Pass the target process PID into kfd_smi_event_add() for these events
> so the existing per-client filter restricts delivery to the owning
> process or CAP_SYS_ADMIN subscribers.
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_smi_events.c
> index d2bc169e84b0..82f9165225fd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -254,8 +254,10 @@ void kfd_smi_event_update_vmfault(struct kfd_node *d=
ev, uint16_t pasid)
>         if (task_info) {
>                 /* Report VM faults from user applications, not retry fro=
m kernel */
>                 if (task_info->task.pid)
> -                       kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, =
KFD_EVENT_FMT_VMFAULT(
> -                                         task_info->task.pid, task_info-=
>task.comm));
> +                       kfd_smi_event_add(task_info->task.pid, dev,
> +                                         KFD_SMI_EVENT_VMFAULT,
> +                                         KFD_EVENT_FMT_VMFAULT(task_info=
->task.pid,
> +                                                               task_info=
->task.comm));
>                 amdgpu_vm_put_task_info(task_info);
>         }
>  }
> @@ -356,7 +358,7 @@ void kfd_smi_event_process(struct kfd_process_device =
*pdd, bool start)
>         task_info =3D amdgpu_vm_get_task_info_vm(avm);
>
>         if (task_info) {
> -               kfd_smi_event_add(0, pdd->dev,
> +               kfd_smi_event_add(task_info->task.pid, pdd->dev,
>                                   start ? KFD_SMI_EVENT_PROCESS_START :
>                                   KFD_SMI_EVENT_PROCESS_END,
>                                   KFD_EVENT_FMT_PROCESS(task_info->task.p=
id,
> --
> 2.43.0
>
