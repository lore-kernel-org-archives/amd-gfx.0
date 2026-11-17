Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C6606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGnsVI4D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0532810E2E0;
	Tue, 17 Nov 2026 15:12:11 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B820910E2E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:12:04 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4c1ff2eabc0so415503b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928324; cv=none;
 d=google.com; s=arc-20260327;
 b=EP36p/lvSu2zJBafeIUee0T56ehL+Da5vjqE7LpfSsCkJ2tSOQm5A9q5uqXnSZhlit
 E2+Q0vittOVd8duY9Q9Ob6Ayk7k/p82LuoJZQKRXybxfAJ9Ld8/sm3AcW5msTw0ehkxn
 MQOkTIUQRrcYksqBW1zQSOOKMt0XZMXx81x/VGoMmQi0zRTgVMAlX6YzjCgWK+f/qaRB
 Tt1GK9aVMXwcIeF2BenQVYQL3TASXIHe7PfkXTNrwjf8lXFNLkObzNgYklLnnmSsJ3Gk
 maJd6/j0xZ4Ms+AXyvYeNsPiQNQvdcvAMLpeJD4lTsOsoJckWjkjPs+88R5RxEbjlnMT
 ji6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=igHwufmANhRzyJGk3ymjYyeDDNg8/anM+jLtdyhGFzw=;
 fh=eAZKnxkpQ9wnRZsj284nNlvJXFF/1NPCBMK5abEqgfs=;
 b=CElC/GtCArYs0pq6RPOslfDrm2BuI3AYes8tXr2cHwFZJN5Pw4hVG3LEJZCG9bgfXv
 5Fuwr3N7nP2mKQiZxnk1xw7NyU7BEh3lvUIh+jCQpfN/tnHznAYkWl7BzaV/UmQ+NNRS
 RAuB9G2fYnEsBXiswe0usIoJxIEH3YL/yX51Yyt3ux/Z0uo+eKJ/2R+Wot3nTi9E/LN7
 6d/DW5U0BnXOsot3tRA86SMsERiOdSIYGbxRESLFQh13tPHUeZkVSaKs56zpMaRPbj/J
 TcCBAaecCGab5aAjC7IJVpufDBHjwL0pIc4a3vfBZqMqByx4mNHgHOxC7YBkAgnbm6ts
 BeAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928324; x=1795533124; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=igHwufmANhRzyJGk3ymjYyeDDNg8/anM+jLtdyhGFzw=;
 b=sGnsVI4DCoGLmu5gWQ+4AvMg+rhlNl8fJxu3pLsuCYR5z0WyoLVh41Owfe0Sp9uI5d
 YntrIF3G167BOzuyTowBYjC3Rdf5g0KcsQmQRaA7WWCZlj3nFBSGh7bLxGagkwMw4n+X
 tt/GCxOfN1aUJ+Y9ptIrO1uooKlLxRdNMhupR6ZsxmCYYdM17h1p+3BJ3tKo8iO1FkOH
 /XSvCTh6BkDBxD5BJWSXweI6+YzfjVbRVHVDmJHqTK5sYJjgoQ0aBqUPunl5YRMQooTl
 PmkOrKsL5BZQtG6UvFNbVmD1I5wGH9oASL4UqwsAyGNUnFC/p2XIWMFe5VHc5w9+Ncnd
 ym4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928324; x=1795533124;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=igHwufmANhRzyJGk3ymjYyeDDNg8/anM+jLtdyhGFzw=;
 b=QCi/6N+vrRZdUIq+keVu5P4y4le6VLwb0W+9khHc2Pk41JUFQ7mC74WTsmYZBUtky/
 1fd3+ADmKE7J7VqZP7ASMPDDw16vezssxLLBU/K6/wdcn/8UpoMiT4gSoQIfXlgBxlpG
 aN6ItW0g4nfA7Ge6cy3PRKu23QNmHD82WYDnnJL6ijA78/iDHCp6uqZCjMSK5UXfe2z2
 dFSfIUJDxwxkRxgls0An1EoKT+pJeQDlOsABYOLTt8ha3FJsdieq7LvumI0Uof2h1xsh
 3sYYmK+BggAO/r35LQtfOrr9FFt3UiiZ6yLvEgzIy/u70CJ6puBNoXEyBQJipczPRybd
 Y8FA==
X-Gm-Message-State: APuU4Z8K+wnI0wUPhaZgXKJV0yfrOKpX9wfkkzBWGbr2CEKRyAUycPG3
 Jj3L+NTpCLd9HzEBrmKxcu7/6kkoB1go252cqijufTeNaG6ybkJ77rQjZWB9/sYeX1V20v3BGCU
 AugwGZtx3fvUZBocY1fmvMye8k2sIfSHlww==
X-Gm-Gg: AYBFou1EHip92oBhs1ClajVzZ2huIhnySQus8KSa47UAatCAvcMPTr3fqVzzUMouP4H
 Bqb5pvnacn12lWqP0jMX21dz/+EfF90wBFzBbxN8ah9Zj6PWmuVYGcSMjnorLfp3psygqDSw/+Q
 R7GJbXUqetNmcv63i+pulndpe2xxPtIJok5S6W5WxMePaZT0TbB3XZ3KtmIQAiMazJFayjenPAS
 BUNad7JoLlF+VTv1RZw14CTkNKPAvKSiMFI2TRnuWxyIWgoWujfY6X6pOHt5YenIynK+3g2Kw6W
 j6s1Dhn6emQOFm6nHpIfIT7VQPlCY+ZWO5+NDzQBbBZ187FZA9qrieiGGxXkaMUOD60A4Ep8aRk
 J/7qinHBKniesAYSyGUX8l6/R6tQshF199I4OcXX34NsXXfWwyzABkOEETO6d3P9HU0hXXjcrff
 rCVGa0WpvNaFuoM/YIkGDvem6cs59pg1fJ9p6ZGwOKL0/3EaT/pKwJQReP4X0=
X-Received: by 2002:a05:6808:4f5e:b0:4f3:6ac0:27d7 with SMTP id
 5614622812f47-56e6015d9c3mr19761602b6e.1.1794928323825; Tue, 17 Nov 2026
 07:12:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105000441.3850131-1-alexander.deucher@amd.com>
 <20261105000441.3850131-4-alexander.deucher@amd.com>
In-Reply-To: <20261105000441.3850131-4-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:11:51 -0500
X-Gm-Features: AclHuK9Wfd88V3WIAmzLcw5Y1y-yrhvZkTI-yJjs-gnPYRC3hxLAjpTc0y-kF2A
Message-ID: <CADnq5_OdFTn1rSkMHm4uzWQrah4b8a_+sB+iKZ0YKW9xDseyyw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: use SMN C2PMSG registers for PSP ring
 control on VF
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, frank.min@amd.com, Hawking.Zhang@amd.com, 
 Tong Liu01 <Tong.Liu01@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 7:11=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Tong Liu01 <Tong.Liu01@amd.com>
>
> Use SMN C2PMSG registers for PSP ring control instead of CRU0. This
> allows VF mailbox access through BAR-mapped registers rather than
> indirect SMN access only.
>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c       | 18 +++++++++---------
>  .../amd/include/asic_reg/mp/mp_15_0_3_offset.h |  6 ++++++
>  .../include/asic_reg/mp/mp_15_0_3_sh_mask.h    |  9 +++++++++
>  3 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/psp_v15_0_3.c
> index b5202aee40354..ff3a25e270c3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
> @@ -220,11 +220,11 @@ static int psp_v15_0_3_ring_stop(struct psp_context=
 *psp,
>
>         if (amdgpu_sriov_vf(adev)) {
>                 /* Write the ring destroy command*/
> -               WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101, GFX=
_CTRL_CMD_ID_DESTROY_GPCOM_RING);
> +               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101, GFX_CTRL_CM=
D_ID_DESTROY_GPCOM_RING);
>                 /* there might be handshake issue with hardware which nee=
ds delay */
>                 mdelay(20);
>                 /* Wait for response flag (bit 31) */
> -               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_PCRU0_MPASP_C2PMSG_101),
> +               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_SMN_C2PMSG_101),
>                                    MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK=
, 0);
>         } else {
>                 /* Write the ring destroy command*/
> @@ -257,19 +257,19 @@ static int psp_v15_0_3_ring_create(struct psp_conte=
xt *psp,
>
>                 /* Write low address of the ring to C2PMSG_102 */
>                 psp_ring_reg =3D lower_32_bits(ring->ring_mem_mc_addr);
> -               WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_102, psp=
_ring_reg);
> +               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, psp_ring_re=
g);
>                 /* Write high address of the ring to C2PMSG_103 */
>                 psp_ring_reg =3D upper_32_bits(ring->ring_mem_mc_addr);
> -               WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_103, psp=
_ring_reg);
> +               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_103, psp_ring_re=
g);
>
>                 /* Write the ring initialization command to C2PMSG_101 */
> -               WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101, GFX=
_CTRL_CMD_ID_INIT_GPCOM_RING);
> +               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101, GFX_CTRL_CM=
D_ID_INIT_GPCOM_RING);
>
>                 /* there might be handshake issue with hardware which nee=
ds delay */
>                 mdelay(20);
>
>                 /* Wait for response flag (bit 31) in C2PMSG_101 */
> -               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_PCRU0_MPASP_C2PMSG_101),
> +               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPA=
SP_SMN_C2PMSG_101),
>                                    MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK=
, 0);
>
>         } else {
> @@ -347,7 +347,7 @@ static uint32_t psp_v15_0_3_ring_get_wptr(struct psp_=
context *psp)
>         struct amdgpu_device *adev =3D psp->adev;
>
>         if (amdgpu_sriov_vf(adev))
> -               data =3D RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG=
_102);
> +               data =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
>         else
>                 data =3D RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG=
_67);
>
> @@ -359,8 +359,8 @@ static void psp_v15_0_3_ring_set_wptr(struct psp_cont=
ext *psp, uint32_t value)
>         struct amdgpu_device *adev =3D psp->adev;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_102, val=
ue);
> -               WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_101,
> +               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, value);
> +               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
>                              GFX_CTRL_CMD_ID_CONSUME_CMD);
>         } else
>                 WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67, valu=
e);
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h
> index af10df3395dc3..84ac41f653e6f 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h
> @@ -1088,6 +1088,12 @@
>
>  // addressBlock: mp_SmuMpASP_SmnDec
>  // base address: 0x0
> +#define regMPASP_SMN_C2PMSG_101                                         =
                                0x00a5
> +#define regMPASP_SMN_C2PMSG_101_BASE_IDX                                =
                                0
> +#define regMPASP_SMN_C2PMSG_102                                         =
                                0x00a6
> +#define regMPASP_SMN_C2PMSG_102_BASE_IDX                                =
                                0
> +#define regMPASP_SMN_C2PMSG_103                                         =
                                0x00a7
> +#define regMPASP_SMN_C2PMSG_103_BASE_IDX                                =
                                0
>  #define regMPASP_SMN_IH_CREDIT                                          =
                                0x0140
>  #define regMPASP_SMN_IH_CREDIT_BASE_IDX                                 =
                                0
>  #define regMPASP_SMN_IH_SW_INT                                          =
                                0x0141
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h
> index b76207930514c..95fc3e89ce6f9 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h
> @@ -1618,6 +1618,15 @@
>
>
>  // addressBlock: mp_SmuMpASP_SmnDec
> +//MPASP_SMN_C2PMSG_101
> +#define MPASP_SMN_C2PMSG_101__CONTENT__SHIFT                            =
                                      0x0
> +#define MPASP_SMN_C2PMSG_101__CONTENT_MASK                              =
                                      0xFFFFFFFFL
> +//MPASP_SMN_C2PMSG_102
> +#define MPASP_SMN_C2PMSG_102__CONTENT__SHIFT                            =
                                      0x0
> +#define MPASP_SMN_C2PMSG_102__CONTENT_MASK                              =
                                      0xFFFFFFFFL
> +//MPASP_SMN_C2PMSG_103
> +#define MPASP_SMN_C2PMSG_103__CONTENT__SHIFT                            =
                                      0x0
> +#define MPASP_SMN_C2PMSG_103__CONTENT_MASK                              =
                                      0xFFFFFFFFL
>  //MPASP_SMN_IH_CREDIT
>  #define MPASP_SMN_IH_CREDIT__CREDIT_VALUE__SHIFT                        =
                                      0x0
>  #define MPASP_SMN_IH_CREDIT__CLIENT_ID__SHIFT                           =
                                      0x10
> --
> 2.56.0
>
