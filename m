Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4055CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 20:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F9110E8A6;
	Wed,  8 Oct 2025 20:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jh3i8uH5";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2662F10E8A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 20:16:22 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-280fc0e9f50so319155ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759954582; x=1760559382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+JGTIzAGjfqIxcQ0QZezVF3Mx1Rs8qvuJLSPZS6qDs=;
 b=jh3i8uH56+D5+eou0JrUtRmGPYP/r0l2MV22CBo7wwFH24qzgCU7kVQ2TtTvbaiAYM
 ViHV5O2OjTnI/kmpe9z+MT1xRHhd+VCZpLP2Nk3wlDvtvxw8rFHibKJwMIi7nQnqyAOt
 i9PtATPuExJ+fYYab+tla0apoLAa+3fdS4D4xR7axUWWMT3Ln5hsX+wI7aGhP6jddLt2
 /EOmdfX+TNz+2IgrYGTAIt8hatHL1xPUJylaUkicj9iXvDe9Xli488/yCNAgxBlvuaY5
 DWy7TxPMGLV5gM12CKSEgGodkPN7uqb15bviSmEVv2fcPMYPCC6ilTpZVbdz50a8BeOZ
 p8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759954582; x=1760559382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+JGTIzAGjfqIxcQ0QZezVF3Mx1Rs8qvuJLSPZS6qDs=;
 b=JHiy+ucFOros6cZXIJxpQneRVTT3KL+NaSxcRo+FROmCpkmQHHZ7pn2IV0DsPAtz30
 k4/usb0RpeQX4hEdQFo3eFkyz8/dHTruylZuFVyAI60bqV1X9/8W5cGKrb+VFStBhWUA
 +BD8+Y0GimLa92IB1C7jRGFgd1CUqL4dVKk1S2N//ouxg1tS0j+rkE54u5XV9SSmLGud
 TMIw32QqUXHUokWEFgS+T8oDMvl3Xk5t0fo9dlNS2F3fErlTK5ZBQ3Rd58XQTxswiCn6
 ubdSBzwFqKOksMrnt6spCCc7d37HgPRM1DtUjom8onm+BmZzQh9olG0NHIsc2voX6EXC
 iZSA==
X-Gm-Message-State: AOJu0Yxy48JCKAsKLfVFMNzb4M81C1Ppz7LUS+pJ3/FsV//XL5FuuAXx
 b2jAcUi6LxNINP/RoZgRDoaiiD6aaAOEZ9+G6XbuoMNiqZCpfW/1ZxIAM1vYV7eRzK9ORLv0+UU
 91F4l+sMMS8KNyySzVomMhfudqAs8uC4=
X-Gm-Gg: ASbGnctmlLY/21gdBT5gWKXORLMtdkx7YMdzu6itIIxxwmbVPDec2Gsr2gUz8+/m7oP
 bcJ/blTRWsva0XWX7ZkxcuBBrvqdwlSbFRYheCKNZGQJpUhjDkqCiO0UNUru3U0RsyU0hBwb579
 sU9uDxePYyUm6sUbGikcTaPU0xy2nSXFXc1WzR4bffyiWV76tZplrOUNuhXRnp3bWdh8gCrnq7J
 1dDL7MzAtcyHWZdOb6YPw2MUiFk3DcJk5fCyoxzsQ==
X-Google-Smtp-Source: AGHT+IE4saMn+2MInRy4HQ7nVCCQpXiTcryzVsz63EQ1FweB6NZ9pYGTjldp+CihkP6MGi7btQzwHaxSrKikAmT2TLg=
X-Received: by 2002:a17:902:ea08:b0:28d:1904:6e77 with SMTP id
 d9443c01a7336-2902726698dmr34355585ad.3.1759954581565; Wed, 08 Oct 2025
 13:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251008164408.850834-1-jonathan.kim@amd.com>
 <CADnq5_M_Rk9KX_5Vw+3pxPfrReKqhtF5rn+1P2LidFSJ5y7Wzw@mail.gmail.com>
 <CY8PR12MB74354BE47029963B8FEDCD4385E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CADnq5_PLCEEVbk4ufSnQyqzmW32iBccpk5EXf7kPwdp5=Lpo-Q@mail.gmail.com>
 <CY8PR12MB74358D5E7438A3FF6F7C873185E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB74358D5E7438A3FF6F7C873185E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 16:16:10 -0400
X-Gm-Features: AS18NWCHPzoc50kee-CLb4PQtRhUy00gSujEPtGGWhy4NlxUV8S3mXdTG9qyFsc
Message-ID: <CADnq5_OwEwRhf17gqkpEwoPd_znuuLR3KL+5JqZo8JBxqYAAWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
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

On Wed, Oct 8, 2025 at 4:12=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@amd.com>=
 wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, October 8, 2025 1:46 PM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status=
 check
> >
> > On Wed, Oct 8, 2025 at 1:27=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@amd.=
com>
> > wrote:
> > >
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Wednesday, October 8, 2025 1:12 PM
> > > > To: Kim, Jonathan <Jonathan.Kim@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.co=
m>
> > > > Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission st=
atus
> > check
> > > >
> > > > On Wed, Oct 8, 2025 at 12:51=E2=80=AFPM Jonathan Kim <jonathan.kim@=
amd.com>
> > > > wrote:
> > > > >
> > > > > The driver currently only checks that the MES packet submission f=
ence
> > > > > did not timeout but does not actually check if the fence return s=
tatus
> > > > > matches the expected completion value it passed to MES prior to
> > > > > submission.
> > > > >
> > > > > For example, this can result in REMOVE_QUEUE requests returning s=
uccess
> > > > > to the driver when the queue actually failed to preempt.
> > > > >
> > > > > Fix this by having the driver actually compare the completion sta=
tus
> > > > > value to the expected success value.
> > > >
> > > > This should be correct as is:
> > > >
> > > > *status_ptr =3D 0;
> > >
> > > That's not what I'm observing at the moment.
> > > amdgpu_fence_wait_polling can still return fine where status_ptr !=3D=
 0 nor 1.
> > > From what I've been told, only 0x1 =3D=3D success (the completion fen=
ce value
> > passed to MES).
> > > Shaoyun can probably elaborate or correct me if I'm wrong.
> > > It's pretty easy for me to put the HW in a bad state (dangling queues=
 post
> > remove) without the driver knowing in its current state.
> >
> > 1 is just what the driver puts as the fence value to write:
> > api_status->api_completion_fence_value =3D 1;
> > and the memory location is initialized to 0:
> > *status_ptr =3D 0;
> > The firmware should either write 1 or nothing, writing a random value
> > in there looks like memory corruption or a firmware bug.  If it
> > doesn't write the fence, the driver can assume the operation failed.
> > If it writes random values, then we have no idea what's going on.
>
> FW writes high 32 bits to status_ptr for debug codes if low bits is 0.
> So we should probably only check the 32 lower bits then.

Thanks for clearing this up.  Please check if mes_v11 needs a similar fix.

Alex

>
> Jon
>
> >
> > Alex
> >
> > >
> > > Jon
> > >
> > > > ...
> > > > api_status->api_completion_fence_value =3D 1;
> > > > ...
> > > > if (r < 1 || !*status_ptr) {
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > > > index aff06f06aeee..58f61170cf85 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > > > @@ -228,8 +228,7 @@ static int
> > > > mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> > > > >                         pipe, x_pkt->header.opcode);
> > > > >
> > > > >         r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> > > > > -       if (r < 1 || !*status_ptr) {
> > > > > -
> > > > > +       if (r < 1 || *status_ptr !=3D api_status->api_completion_=
fence_value) {
> > > > >                 if (misc_op_str)
> > > > >                         dev_err(adev->dev, "MES(%d) failed to res=
pond to msg=3D%s
> > > > (%s)\n",
> > > > >                                 pipe, op_str, misc_op_str);
> > > > > --
> > > > > 2.34.1
> > > > >
