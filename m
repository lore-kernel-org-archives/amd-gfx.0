Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86047C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E41710E223;
	Thu, 13 Mar 2025 14:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VL2anzFQ";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49A910E223
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:38:19 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-22403c99457so2451005ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741876699; x=1742481499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgTlBJBOq1ilA8AdKr8CHTgF84binOJCdTNVhxY7hjU=;
 b=VL2anzFQB0LwfuJECOlHBij5sAjYk2jdhbiQsR9x43i+TNVIIT2O0+hjeH4t/as6+V
 cLJ0Qk8tx/iO60atGhaqknS7SInBSLKz460ITFnmv3wwNPC1V8T3lGxP8krmiuM7c5GP
 CN/rqT88XfouV2AunoFE93fTjDVc24qJ0Ctbp7axwC9x4RGPfcX/YwgYdeKmxlODPBbA
 hk2LgVep1b2Voi0A+bcZIh8NB0wEvML9IeNXz5B+dNW5xuKbB961Q35tzGaAId+gmzSE
 i/jEz/sybw0SJ0EvbpSl8zEvxUpWrlW6tmN8+afHMb/4cGpF4JC8AGX5ESMsAfI6/G1k
 b+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741876699; x=1742481499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgTlBJBOq1ilA8AdKr8CHTgF84binOJCdTNVhxY7hjU=;
 b=jJCGPCT5vi1bvdEAHc07ByBkBBJocz4PK4InnNQXrUBWyrBIiUA+p9Nae0BVCbKxFQ
 qKKJpOqPlRwnW3rF3tjJ7MAItZjR9GStmjgHTPcEj5pqm4nIHMXtem5EO+e5gcmtsuov
 XRlZtK4lNc3WRksBbB5mNO/tOVJzVh7uw/KWThljT+u+2zaCUQ8PPKF2O+/DbmXlaNP7
 tWnT4/MKiE2SQCKQNlmE8rYI8n7IUXnEvXWmAykA5h/hJMWKp73sCZWNGbPQPFcE0IHj
 5dqLHds6Vh83+urlVZMZNMB4+2LOl0xEuPdIiNUSq/NAQpoWaoYpRFxOkGdOCIqb1zDB
 qc2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqYKzmU5ROSJh3UqQpmQEXnAyQWE9yeSUMMx9loeWyMRgu8XgCj9JTJXJKtdfZLEIvueVmJApg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4nCrn7xg6l+CqNskPruGLUV+lB4qheFKA6Y00eT1LL0sKW1xC
 I1WpdpdTVKPr6mpafWlcTYSc5OO2YRXoiUdK/1jT9vNFJZNM+qsuR9hU6gLcWThVydV11IBCRXU
 FttTxb+D4U1AxqU/urAbxcbdPnsfy3w==
X-Gm-Gg: ASbGnctS8dqB8e3P7NUVUbK70hcuD5OX3JZ/asX6VhPJWKSfT017Hzv+UKBa7qMKC0L
 SKtFLxIg/nMacmxm79f9g2+WuTy1bkrbe5b76M+zJbh8sH/mLjSVI/WotMCm2dSCRctsQ0VENgm
 d2xLveRuKRwMjqRfdCksH5S2o7TQVE57dzHy+K
X-Google-Smtp-Source: AGHT+IGNAjleer1WmD7M6o4/1fHKPau1Yfd7jFpkH/+tTGyDPTEVpmp5n++3da9F0qz7uVFU2JQZ7qO/yRRCdA0QsM4=
X-Received: by 2002:a17:902:d505:b0:21f:356:758f with SMTP id
 d9443c01a7336-2259325da70mr63633975ad.3.1741876698793; Thu, 13 Mar 2025
 07:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
 <0bc3ca8d-8a65-472d-ae63-ef570d08d1ca@amd.com>
 <DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
 <dcf2a1b5-f079-41e1-b310-79db0b927272@amd.com>
 <DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Mar 2025 10:38:06 -0400
X-Gm-Features: AQ5f1JqKDUb5X0v7H6cB0xw1F6q3yC1tmyxiwpcncLBa45mWFYIf-zKa3anOYp0
Message-ID: <CADnq5_OG3g8fasdXoPRN8UZoqy5vsdnO7Hn9KY3ygbT-Re1zUw@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
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

I think as long as the locking is correct, the src shouldn't matter.
You just need to stop the kernel queues (and save state) and evict the
user queues (since HWS is responsible for saving the MQDs of the
non-guilty user queues).  If KFD detected the hang (e.g., queue
eviction fails when called for memory pressure, etc.), we just need to
make sure that it's ok for the sdma reset routine to call evict queues
again even if it was already called (presumably it should exit early
since the queues are already evicted).  If KGD initiates the reset, it
will call into KFD to evict queues.  We just need to make sure the
evict queues function we call just evicts the queues and doesn't also
try and reset.

Alex

On Wed, Mar 12, 2025 at 5:24=E2=80=AFAM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
>
>
>
>
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, March 12, 2025 4:39 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonath=
an.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by=
 removing dynamic callbacks
>
>
>
> Am 12.03.25 um 09:15 schrieb Zhang, Jesse(Jie):
>
> [SNIP9
>
> -
>
> +     gfx_ring->funcs->stop_queue(adev, instance_id);
>
>
>
> Yeah that starts to look good. Question here is who is calling amdgpu_sdm=
a_reset_engine()?
>
>
>
> If this call comes from engine specific code we might not need the start/=
stop_queue callbacks all together.
>
>
>
>     Kfd and sdma v4/v5/v5_2 will call amdgpu_sdma_reset_engine, and start=
/stop_queue callbacks are only implemented in sdmav4/sdmav5/sdma5_2.
>
>
> Why would the KFD call this as well? Because it detects an issue with a S=
DMA user queue  If yes I would rather suggest that the KFD calls the reset =
function of the paging queue.
>
> Since this reset function is specific to the SDMA HW generation anyway yo=
u don't need those extra functions to abstract starting and stopping of the=
 queue for each HW generation.
>
> kfd can't call reset function directly, unless we add a parameter src  to=
 distinguish kfd and kgd in reset function, like this:
>
> int (*reset)(struct amdgpu_ring *ring, unsigned int vmid, int src );
>
> As Alex said in another thread,
>
> We need to distinguish  kfd and kgd  in reset.
>
> If kfd triggers a reset, kgd must save healthy jobs and recover jobs afte=
r reset.
>
> If kgd triggers a reset, kgd must abandon bad jobs after reset.(and perha=
ps kfd needs to save its healthy jobs for recovery).
>
>
>
> If we can add a parameter, I am ok for that solution too.
>
>
>
> Additionally:
>
> For sdma6/7, when a queue reset fails, we may need to fall back to an eng=
ine reset for a attempt.
>
>
>
> Thanks
>
> Jesse
>
>
> Regards,
> Christian.
>
>
>
>
>
>
> Thanks
>
> Jesse
>
>
>
> Regards,
>
> Christian.
>
>
>
>       /* Perform the SDMA reset for the specified instance */
>
>       ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>
>       if (ret) {
>
> @@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *a=
dev, uint32_t instance_id, b
>
>               goto exit;
>
>       }
>
>
>
> -     /* Invoke all registered post_reset callbacks */
>
> -     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>
> -             if (funcs->post_reset) {
>
> -                     ret =3D funcs->post_reset(adev, instance_id);
>
> -                     if (ret) {
>
> -                             dev_err(adev->dev,
>
> -                             "afterReset callback failed for instance %u=
: %d\n",
>
> -                                     instance_id, ret);
>
> -                             goto exit;
>
> -                     }
>
> -             }
>
> -     }
>
> +     gfx_ring->funcs->start_queue(adev, instance_id);
>
>
>
>  exit:
>
>       /* Restart the scheduler's work queue for the GFX and page rings
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>
> index fd34dc138081..c1f7ccff9c4e 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>
> @@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_r=
ing_funcs =3D {
>
>       .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
>
>       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_he=
lper,
>
>       .reset =3D sdma_v4_4_2_reset_queue,
>
> +     .stop_queue =3D sdma_v4_4_2_stop_queue,
>
> +     .start_queue =3D sdma_v4_4_2_restore_queue,
>
>       .is_guilty =3D sdma_v4_4_2_ring_is_guilty,  };
>
>
>
>
>
>
