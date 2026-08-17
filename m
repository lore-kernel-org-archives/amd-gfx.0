Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A6FC5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 14:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D3F10E7FF;
	Mon, 17 Aug 2026 14:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gn8gzwTQ";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDDC10E7FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 14:19:50 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5c3a84d3739so121986e0c.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 07:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976389; cv=none;
 d=google.com; s=arc-20260327;
 b=obdgvmEh8rsBHP+TAt1YabFblVEWaci0kzmfv71AiWc5kF2Mn8LG3OBBqyx1U6F8vH
 JVqSm/jhd5p16Y5Uf/zZZ9US+HRQHoELu/uXZnh2XAURqVDpzFkZfk0BZKzWytU3OaJt
 WrHAS1Rihm9zJh3y8QIzaeSOw/mxncQjiPYchg1Jr0ubI37KbzZmHw5P6CfD7iQMtUUS
 CXI0rNIKWy9WSlUXsu8WP6A+UzYFZxUKAs/Xs30TOqJ6aEjk7OaGnD8JmfCPfnz0YILn
 /ak795BnCz14u30b7gC1hPR6n44gwIAY4CNbyLzEFp/o0uMysr19L5g4wimUy9D6Rrzk
 2HUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c5YpZ1q0pC8kUCkk8k+rMVoaboya53PziE9bHaTWc3s=;
 fh=iUCiXD7bHLkkcVD2lfBQFNBz81Wdi6NoRE9ABjqxMJI=;
 b=EuJSYkJDU5jZqpxawSHhzYVcqbtT9AG3wvX1EGe6VCYBvFOpt/8gz0kLq4z+w5z5Kd
 AvbvhD8wjUtlsG8dqdTl12CTVsNcg8X7N+/2bO8Ml0CYf/PEKEinr1Ajd0rL1vvkRlmp
 YGi+psNQsqJ69Mz8Nuh+orOkmfh/Pb/eLBO7J7D3aLMI3ol40dQcu0YaiIMysq9k0wzM
 2oRgfJTdtkV0qzIXBVRaHitDmnsROlbkl+TVzO7yWZb/coLM1B3rdxFrpzb5EAOkvYfQ
 9l6B+PohEunIJXqfXK+dHnLAIPfl9QSdTsNHPp6OYHIpUM/Y0bNdFXqTM7lMg+mHzoAs
 fZLg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786976389; x=1787581189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c5YpZ1q0pC8kUCkk8k+rMVoaboya53PziE9bHaTWc3s=;
 b=gn8gzwTQEVgVjdgeAlmYPeiDSyOYrFQJGM4w/wXYK4ngEWU/XWCAegwHXYrNPn2HsT
 mjJMD9YEskroMG2lzZ40Dk+frMqR6NSq5GST0IGsUSA5+XxD6h1Osh2XZjy4AnaUvF3t
 adEOSyrPW3jOOKfClcC5NcsnmnsBjiZpNylM5cT/Koc+aeuBIK1PHPB9ZTfwKOK1NqQ3
 Zjcuz7G7srYLhx734EQGnHRD5ouxOXtJaIjcMf8uzDEooSaBz0kM9UXB2HY33hwZYyUj
 zyqWa4onoQvur3uGeOrfVoGvdT68+W5EBXoJSsocnav573B1EOXx64Ldj+64DJdGb86V
 ge4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976389; x=1787581189;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c5YpZ1q0pC8kUCkk8k+rMVoaboya53PziE9bHaTWc3s=;
 b=Fs0yhD+gS5hIsPMVuSCyfEOli0m8wEheg0BaO4MvMU6Krg+XJw2NyOu6u2y5tWaChT
 tl9/VePMGCxfSNvpyDBRM75NN22mKXiviR0yqI6Yklttmiz1TIfmhA5zuMVDJc5ZkP0C
 LpJMoDKEeVPOhpnSjMb0u6eNQ7b2DXY5v6utiB/uAIXcZxFVniRl23BndWYeNzEMcoCr
 DN7CZ1APPyEq3BipHYyTkYhfvakBnW2sHa3/FEKX8gAhCO56pbb/tJJqXPObo5XeF1BZ
 LSOEZ4hF9PSe9PR/1PDv1LzSUq+a6kVQae777yFXRgEVd7mBFBsMvEFyOmT5cYOQYlKD
 qiwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUVPYidV7tlu748WDkGYcop4m12NmYosAQ1MCWHxU4Ixcu3J75Any0pQuahvbn9Ik9+9cEAFdc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhaVtQWqvED2obfvHJOyqpMt71OUeweWHgh6tTCeSK69q1BeXX
 165eMyTtWqR/+xKHpw/8fzdlmUG/Zf8i0Nf4w5bO2L+VT2wquAQ2+Y9xi6SCdiPUG5PGGcuEsgU
 vZfdk+RQpSCDhXvWA7UPffuJCnvCFSvE=
X-Gm-Gg: AR+sD11fWEh0IXlfEpN/s6LZHOLijlgU2tHumjtAzYl+9C93YAotSe5BJPECH6/cPGD
 k7j7bnUXg1oWheE59FXy2bsjOgt9z3+y8GK9ZXbgssqHW+N+pqQ3re2MmauQCAEjidbyHMKr+8B
 X6la0pTAqyKhYIJebLArt/OA7JidF4H7m4M6rYVQhdZdCQgVh0G1pjB+QKnT5FkXM5gLSJeZvMN
 e2VK5illSLJyDS7buzI8JoQpFZaCxP6bPG+RjmXE0xTMnz1wNM2DLGxVDcm1JrxxwGdc1SsJ8gd
 ejTwKoEC0uTiWqfUPmTzAvpW2Mv/qWNZj71brHx/SRk8kRjTdX/7Za/YyjW1JZYmji06Ke9AVHd
 w7eV75F96X44j30svpUrdxl1uvGFzznU=
X-Received: by 2002:a05:6122:11a9:b0:5c5:90ae:a8b8 with SMTP id
 71dfb90a1353d-5c591c781b3mr1329519e0c.1.1786976389365; Mon, 17 Aug 2026
 07:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
 <SA0PR12MB7091D3AE34006DC6797EECD197DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <DS5PPF78FC67EBA848622BC6037F917872992DA2@DS5PPF78FC67EBA.namprd12.prod.outlook.com>
 <SA0PR12MB7091F549BC02FFD7312367AF97DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <IA0PR12MB8895E3ADC3692524015EDC2AF3D82@IA0PR12MB8895.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB8895E3ADC3692524015EDC2AF3D82@IA0PR12MB8895.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 10:19:37 -0400
X-Gm-Features: AcwNN1X7wPKX9xOBxpVlRFZJtPqLV-Gq6fiKpC4heiF4_zCwsOb_dEYwEU1YeTU
Message-ID: <CADnq5_Pj0gOHMupA+X9x6F-71TQJDeDiJQ6kdFgrLdzLh-z70Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
To: "Hosur, Priya" <Priya.Hosur@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, 
 "Gopalakrishnan, Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Sun, Aug 16, 2026 at 1:25=E2=80=AFPM Hosur, Priya <Priya.Hosur@amd.com> =
wrote:
>
> AMD General
>
>
> Hi Felix, Lijo,
>
>
>
> Thanks for the clarification. I understand now - TLB flush is only needed=
 after batch queue unmapping (eviction/suspension), not after each individu=
al queue unmap.
>
>
>
> Alex - based on Felix's feedback, the userq unmap path doesn't need the s=
ame fix since it's per-queue unmap rather than batch unmap.
>

I think it's still needed when we evict all KGD userqs for a process
(technically per GPU VM instance).  E.g., the eviction fence case.

Alex

>
>
> I'll drop patch 2/2 (userq fix) and send v4 with only the KFD fix.
>
>
>
> Thanks and Regards,
> Priya Hosur
>
>
>
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, August 14, 2026 10:56 PM
> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Hosur, Priya <Priya.Hosur@a=
md.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Liu, Shaoyun <Shaoyun.Li=
u@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Koenig, Christi=
an <Christian.Koenig@amd.com>
> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Vee=
rabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queu=
e unmap
>
>
>
> AMD General
>
>
>
> Thanks for the details. Didn't realise that it is one by one removal. I t=
hought it was something like unmap-all for a PAS id.
>
>
>
> Thanks,
>
> Lijo
>
> ________________________________
>
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, 14 August 2026 22:17:50
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Hosur, Priya <Priya.Hosur@amd.com>;=
 amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; =
Liu, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@a=
md.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Vee=
rabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queu=
e unmap
>
>
>
> AMD General
>
>
>
> We don't need to flush TLBs after every queue unmap. We only need to do i=
t if there is an expectation that memory access is quiesced after unmapping=
. In the case of KFD, we are doing it when we're unmapping all queues, e.g.=
 in MMU notifiers, evictions or when the debugger needs to stop the queues =
and look at memory contents. We only need one TLB flush after unmapping man=
y queues.
>
>
>
> Therefore, MES should flush TLBs after every queue unmap. OTOH, MES must =
flush TLBs by itself when it switches VMIDs. This is not under driver contr=
ol.
>
>
>
> I don't know what the requirements are for quiescing memory access after =
unmapping amdgpu user mode queues.
>
>
>
> Regards,
>
>   Felix
>
> ________________________________
>
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, August 14, 2026 12:29
> To: Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Khatri, Sunil <Sunil.Khatri@amd.com>; Kuehling, Felix <Felix.Kuehling@am=
d.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limon=
ciello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Vee=
rabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priy=
a.Hosur@amd.com>
> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queu=
e unmap
>
>
>
> AMD General
>
>
>
> Hi,
>
>
>
> Shouldn't this be a FW fix?
>
>
>
> Thanks,
>
> Lijo
>
> ________________________________
>
> From: Priya Hosur <Priya.Hosur@amd.com>
> Sent: Friday, 14 August 2026 21:48:40
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.c=
om>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Shaoyun <Shaoyun.Liu@am=
d.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Limonciello, Mario <Mario.Limonci=
ello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Vee=
rabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priy=
a.Hosur@amd.com>
> Subject: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue un=
map
>
>
>
> Similar to the KFD fix, MES does not perform heavy-weight TLB
> invalidation after unmapping user queues. Add
> amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in
> amdgpu_userq_unmap_helper() to ensure in-flight memory accesses
> complete before memory is freed or migrated.
>
> Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 6d3ed55e9ab4..9fcf15d69b7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_u=
sermode_queue *queue)
>                  } else {
>                          trace_amdgpu_userq_state_changed(queue, AMDGPU_U=
SERQ_STATE_UNMAPPED);
>                          queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> +                       /*
> +                        * Heavy-weight TLB flush after MES unmaps queue =
to ensure
> +                        * in-flight memory accesses complete before memo=
ry is freed/migrated.
> +                        * MES does not do this automatically unlike HWS.
> +                        */
> +                       amdgpu_gmc_flush_gpu_tlb_pasid(adev, queue->vm->p=
asid, 2, true, 0);
>                  }
>          }
>
> --
> 2.43.0
