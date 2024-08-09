Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD2AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 15:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD9210E973;
	Fri,  9 Aug 2024 15:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gMut3+J9";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649C610E973
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 15:54:50 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2cd2f89825fso1764808a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Aug 2024 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723218890; x=1723823690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yo7HqdHWsW3uYXeX2AxvJS9Dm8+TOA553lzto4PVVJ0=;
 b=gMut3+J9d+r2bpYkW0oYLwPxAuZmzlm4RvJVJkDgkRp7LmsoQtOA8Ic6raxAzmG0q9
 nWGo+5SJhHmv2WtVOnMo7DcLoEz+zkDwC2e5JyImsJ+6NailUOckY/w0QKpF4D6QjIGn
 7NtHwxNScziZbGKvvgQqTDcKdE+KzuTZdwfaicytAnQoI5yd8G5Fs7Svx7UrYrOjocBW
 2Xfi8QxaxB0QHAyDXYad1qk/AQqxCJr4HT20VNR1nuwv5B4jX2PZByPcE48oL9JTojm2
 wcrCAHTasvWLQtjjUAtBe9+hcJDDMtd7M4h/oNu75G4P7swdR4yQL9biJAjK5L/FMu/j
 LYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723218890; x=1723823690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yo7HqdHWsW3uYXeX2AxvJS9Dm8+TOA553lzto4PVVJ0=;
 b=NQmiu+y7ULlFjw1/YJycNyxt+TRkyEfpOYprBZt9b0hWfYvdIR+0BotH/2l4xK+t+s
 ThvI0rjRlcdxIpBv1L8yccCTph99SN30Ypj2ueZUo09bIyhHILGDObeI58o7oYC5Ic9h
 w0VVNQgnG4pHpVhpn/w1RuY2Nlj4LrHhSJzLh0AY0hG7/WvbIL+TOumWndrnVy20PdwL
 OQAj6Qt6w+/+Hfu4tDzJR9JYb01tHhy06ciHMgfFMMjx3OVnJWrMbPw7kQDf00kSa8gl
 Y+NRWDqIUKwayF6oJseDc+CKxO+wcxWxuNlqY9aeomlavcaEF2jWMP/HimGwL+iitAPe
 5Z2w==
X-Gm-Message-State: AOJu0YyagI+CZg0fp3zosfEzRagNTkX+KXisPHLA721ekuyaR9lOCE/J
 ECud9d6OpvX+CSQYEYeOox8lswX5G3R+5WUEa0rUQcPWlihcBwxH8VQ+YRGfy4RF6G8ecOlwFiJ
 9MOkvSmn06YPac1zHOWpMotORS1E=
X-Google-Smtp-Source: AGHT+IGNin+2JdXXrrwO+Rz4PTE4KxegGUuZvjnJocWgEn6zFzXXPiXzrsCQ11ZR+FwXbKZj+2uDEtpJRWJEaWvEEss=
X-Received: by 2002:a17:90b:1d09:b0:2d0:683:aef9 with SMTP id
 98e67ed59e1d1-2d1e7ff6e3fmr2070178a91.21.1723218889722; Fri, 09 Aug 2024
 08:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240802163813.1800438-1-Jonathan.Kim@amd.com>
In-Reply-To: <20240802163813.1800438-1-Jonathan.Kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Aug 2024 11:54:37 -0400
Message-ID: <CADnq5_MbRQ36OD73oWv5o9rGS0X=LkibmdC14m-=VoQMtzeTEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset fail
 for gfx9
To: Jonathan Kim <Jonathan.Kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Aug 2, 2024 at 12:38=E2=80=AFPM Jonathan Kim <Jonathan.Kim@amd.com>=
 wrote:
>
> If queue reset fails, tell the CP to reset the pipe.
> Since queues multiplex context per pipe and we've issues a device wide
> preemption prior to the hang, we can assume the hung pipe only has one
> queue to reset on pipe reset.

Is there a specific CP or PSP firmware version required for this?  If
so, we should check for it before attempting this if it will cause a
problem.

Other than that:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 46 +++++++++++++------
>  1 file changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 32f28c12077b..c63528a4e894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1173,12 +1173,30 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu=
_device *adev,
>         return queue_addr;
>  }
>
> +/* assume queue acquired  */
> +static int kgd_gfx_v9_hqd_dequeue_wait(struct amdgpu_device *adev, uint3=
2_t inst,
> +                                      unsigned int utimeout)
> +{
> +       unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
> +
> +       while (true) {
> +               uint32_t temp =3D RREG32_SOC15(GC, GET_INST(GC, inst), mm=
CP_HQD_ACTIVE);
> +
> +               if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> +                       return 0;
> +
> +               if (time_after(jiffies, end_jiffies))
> +                       return -ETIME;
> +
> +               usleep_range(500, 1000);
> +       }
> +}
> +
>  uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
>                               uint32_t pipe_id, uint32_t queue_id,
>                               uint32_t inst, unsigned int utimeout)
>  {
> -       uint32_t low, high, temp;
> -       unsigned long end_jiffies;
> +       uint32_t low, high, pipe_reset_data =3D 0;
>         uint64_t queue_addr =3D 0;
>
>         kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> @@ -1202,25 +1220,23 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_devic=
e *adev,
>         /* assume previous dequeue request issued will take affect after =
reset */
>         WREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_COMPUTE_QUEUE_RESET, 0=
x1);
>
> -       end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
> -       while (true) {
> -               temp =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_AC=
TIVE);
> +       if (!kgd_gfx_v9_hqd_dequeue_wait(adev, inst, utimeout))
> +               goto unlock_out;
>
> -               if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> -                       break;
> +       pr_debug("Attempting pipe reset on XCC %i pipe id %i\n", inst, pi=
pe_id);
>
> -               if (time_after(jiffies, end_jiffies)) {
> -                       queue_addr =3D 0;
> -                       break;
> -               }
> +       pipe_reset_data =3D REG_SET_FIELD(pipe_reset_data, CP_MEC_CNTL, M=
EC_ME1_PIPE0_RESET, 1);
> +       pipe_reset_data =3D pipe_reset_data << pipe_id;
>
> -               usleep_range(500, 1000);
> -       }
> +       WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_MEC_CNTL, pipe_reset_da=
ta);
> +       WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_MEC_CNTL, 0);
>
> -       pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
> -                inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" : "=
failed!");
> +       if (kgd_gfx_v9_hqd_dequeue_wait(adev, inst, utimeout))
> +               queue_addr =3D 0;
>
>  unlock_out:
> +       pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
> +                inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" : "=
failed!");
>         amdgpu_gfx_rlc_exit_safe_mode(adev, inst);
>         kgd_gfx_v9_release_queue(adev, inst);
>
> --
> 2.34.1
>
