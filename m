Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D55F483E5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E153A10E499;
	Mon, 23 Mar 2026 19:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RuuNI+uL";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813B810E499
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:12:44 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-127148c2112so403116c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293164; cv=none;
 d=google.com; s=arc-20240605;
 b=CTP5dqGnJN/uIgKWTfzVDJHxm/1Q92sEfk2clA0b6HrtlnP4maV1DvuQD0V7dWFAZP
 xf3+TXJPfy7IhRok4KgUFtdqrCvURwyiiTIExhHuuLM9h3t2pOm5WzcaHsAnQYvhIJnn
 0tqYpVqEEF9kulrNUDhlT7ah+dVNEQjRXSjJf0UJvYlI7XMw8CLRL4DlTLHVjOaEulv4
 wB3C5gaEnzIae1ey4GW3Z/ecC3jiVzKOOIqgYCx7LfvNaF8nnhk3pdf80pTZPfPXFkox
 9KcJN7xp6KE5t2tWsZDDmeavHGVtpR1r849nQD3R5z8HlmYZzQs/6XrBeJPwhx97TDv/
 qpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SZv4sVfznlVRMM6LAKDKkkDdLYuRrr2Jd3wBBloIc/Q=;
 fh=TjSDHDexhxAlozvahAqSjH/1kZYNEUCZM+OUwnm2QTM=;
 b=BQ9T1SDYTjxMNe5RWoMhaa88k6hiG08UWVcj05Qv5L0SyXO2wuRwPH5qA2OF2QIJOD
 j0KqT1c1ToSFRnC6FL2dzXMgljOnrmHO3NZGx9/mU0Uxu/uCWyovK6CEbcqVVyVfVNbE
 t5v+rCornF5AexXRtO0u5aN1jHzi1m+VAP/tMeqk7l8eAq6vEEo438ypgnLzSv8znhLu
 59v6GOS9zorEf8/Vd+HhBxgj9x6SBUWHQIA4oEjEo8gfhBvOpwwF3hyWM5PuGpgwPaHs
 5vfPWMiO7ZQjbmryWAVb9a1GBackPO/0Jtd7aMFFnF3c4NOrOmc7TYwCXCoNEUysyVtB
 vlXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774293164; x=1774897964; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZv4sVfznlVRMM6LAKDKkkDdLYuRrr2Jd3wBBloIc/Q=;
 b=RuuNI+uLf5sNkhT3R0ZODd3w7Zi31TwRBGS81Gft6HXKCf3tutwD9zr/JaVE5ByxVu
 S7P9V0efZYfc+EOnX/TTZZNB1RmEsibNjEi0NEy/Ur0P+n6BpFVxszQ6TOlqvbM0BEap
 K/dzeX1wSfj9kuMoleHGr20SU3gMKIb1MZUCIv9yhdofF0QZltInVAGpGITFsCIttWgA
 4K8eUHfI9dQ+0ZKSwaZpcLA6MX1MJLx06fsiSTnIu1+CHCpU3smEOI3juZTe1J7QaOmP
 Y+YEKs08zzhIWBgGFZQXF0+rgrFjeLRYabMY3wL4y8vSbI0LPkdymZ91UnxNhqdQ1G8o
 Y4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293164; x=1774897964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SZv4sVfznlVRMM6LAKDKkkDdLYuRrr2Jd3wBBloIc/Q=;
 b=g8RSMPXJxejP2tfWZ+PxJMKKquqlBSL/VIN6MU8b1wfOdEf9YKt+zcOSJw6H4loDqK
 8z+t5eOnsIN5zObnV7y9QYaijIyfRETWTXq8MAakT9MiStkO8m0F43gad0obri/DR1nI
 oAAzHVN7OF9Q07jiGjpd1tfk5RRwiswoWm1v6Q8xqqpXGUViD3pwBQ1pG0zcZPr/1EBi
 lGqNifHAzkeHXEXG3l3u33EV/BcAfaHSTHXzwFIzM6SlGf1zJMQLzBgqKvAcCm/9VtFX
 gZJ0XM56Pnn3fx9sfBK/O1d9LIsodolXUaWhSBio2X8ejRs6zw4hfSUukBF4E6dMG69a
 z4zQ==
X-Gm-Message-State: AOJu0Yx2NlWpgsE+xZXYdEuy4Uv1bCNQWC+Hkx/LWlR0NU/T+5xhiiaZ
 JrMBrBGMBQzazYw9oQQ58Rx+XBpvggJV+TbrOBLwmiPZOM8KVIdXROTxFOjlNlY1Cnhixak/9FP
 H02tR57motOH2qKKRbczn/UB2oSYlxIU=
X-Gm-Gg: ATEYQzw6ZmroZoZKk1EwzdyAeWrMliz69vg3d7lHDpqIJ2TQrKM+CLqgE9CCJBfd+nT
 y9u505l8icJEtZwziF7FiMcV6MB9bF6ZuU1CkobbXzTanfaMKru0INH/8k5PbtSkg0vkZgw+D4B
 a9+glz0QAzqusd2RBFcBX1XljKQLrMMv2FXWg/mtw/C/4Ks+opLJa48miNEu2dDgjC9ynkmTkkR
 HTkyfyGUHrTXU/udFSLsDozy0atcfAUh6QSbK+erMuzP7kspg5eHrwQA8T7np4k1ouDukG69i8S
 9eN3qKhrzVd1YD+Oyxh7D4tptuZH3zZUhP7Uwbv7q0YGkIPdpRQJSA/LrxBcCJzHxD+i0W82fwJ
 Q6I15
X-Received: by 2002:a05:7022:503:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-12a726d9462mr3653119c88.6.1774293163730; Mon, 23 Mar 2026
 12:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-8-Amber.Lin@amd.com>
In-Reply-To: <20260320200208.1188307-8-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:12:31 -0400
X-Gm-Features: AaiRm50ESiAv5gbQ3Hvc03h3At2pOSAnDc0ZV023atvbOjAbQpsnnxj3cvvwdZw
Message-ID: <CADnq5_Nv-1p-HH6gcWijR6z6xhoQH4+MLkYhyhy9W14nQ4hY+A@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/amdkfd: Add detect+reset hangs to GC 12.1
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com
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

On Fri, Mar 20, 2026 at 4:09=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> Add detect_and_reset_hung_queues to user mode compute queues on GC 12.1.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 35 +++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index 7aea3a50e712..ac9e26b8bb52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -46,6 +46,8 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *=
adev, uint32_t xcc_id);
>  static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id);
>
>  #define MES_EOP_SIZE   2048
> +#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] =3D db offset [4:7] h=
qd info */
> +#define MES12_HUNG_HQD_INFO_OFFSET      4
>
>  #define regCP_HQD_IB_CONTROL_MES_12_1_DEFAULT 0x100000
>  #define XCC_MID_MASK 0x41000000
> @@ -229,7 +231,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>                         xcc_id, pipe, x_pkt->header.opcode);
>
>         r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> -       if (r < 1 || !*status_ptr) {
> +       if (r < 1 || !lower_32_bits(*status_ptr)) {
>                 if (misc_op_str)
>                         dev_err(adev->dev,
>                                 "MES(%d, %d) failed to respond to msg=3D%=
s (%s)\n",
> @@ -858,6 +860,33 @@ static int mes_v12_1_reset_legacy_queue(struct amdgp=
u_mes *mes,
>  }
>  #endif
>
> +static int mes_v12_1_detect_and_reset_hung_queues(struct amdgpu_mes *mes=
,
> +                                                 struct mes_detect_and_r=
eset_queue_input *input)
> +{
> +       union MESAPI__RESET mes_reset_queue_pkt;
> +
> +       memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
> +
> +       mes_reset_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_reset_queue_pkt.header.opcode =3D MES_SCH_API_RESET;
> +       mes_reset_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_reset_queue_pkt.queue_type =3D
> +               convert_to_mes_queue_type(input->queue_type);
> +       mes_reset_queue_pkt.doorbell_offset_addr =3D
> +               mes->hung_queue_db_array_gpu_addr[0];
> +
> +       if (input->detect_only)
> +               mes_reset_queue_pkt.hang_detect_only =3D 1;
> +       else
> +               mes_reset_queue_pkt.hang_detect_then_reset =3D 1;
> +
> +       return mes_v12_1_submit_pkt_and_poll_completion(mes,
> +                       input->xcc_id, AMDGPU_MES_SCHED_PIPE,
> +                       &mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt)=
,
> +                       offsetof(union MESAPI__RESET, api_status));
> +}
> +
>  static int mes_v12_inv_tlb_convert_hub_id(uint8_t id)
>  {
>         /*
> @@ -915,6 +944,7 @@ static const struct amdgpu_mes_funcs mes_v12_1_funcs =
=3D {
>         .resume_gang =3D mes_v12_1_resume_gang,
>         .misc_op =3D mes_v12_1_misc_op,
>         .reset_hw_queue =3D mes_v12_1_reset_hw_queue,
> +       .detect_and_reset_hung_queues =3D mes_v12_1_detect_and_reset_hung=
_queues,
>         .invalidate_tlbs_pasid =3D mes_v12_1_inv_tlbs_pasid,
>  };
>
> @@ -1931,6 +1961,9 @@ static int mes_v12_1_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int pipe, r;
>
> +       adev->mes.hung_queue_db_array_size =3D MES12_HUNG_DB_OFFSET_ARRAY=
_SIZE;
> +       adev->mes.hung_queue_hqd_info_offset =3D MES12_HUNG_HQD_INFO_OFFS=
ET;
> +
>         for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>                 r =3D amdgpu_mes_init_microcode(adev, pipe);
>                 if (r)
> --
> 2.43.0
>
