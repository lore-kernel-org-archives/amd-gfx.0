Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA69C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 06:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A363C61040
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 06:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A363C61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44976EAA2;
	Wed, 28 Apr 2021 06:47:54 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E656EAB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 06:47:44 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id u17so93056375ejk.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=Bvp3GJBhivWdX1nSqgCDoz3DWFUnU1rkDIgu+cmUcFU=;
 b=tMQTHTyqCUlB+I9TRbrI/tOlOLabzjsQbLUoGpt7Dkn/xZAIJ1FeSR3Ph8Z12k5J3L
 3KApvvETl1Ty+fPads58E1Pmn4DuFgn3td2g6hP4eb+NjgrewTmri1t7LGkU+4IixgGW
 ZwHmZbc9aUMbYTeJJTmrwffnJltqWR05t05VgMS+phjByfFlXKKVqC3wFqBD/nTFHxHu
 vcgvqyIpRazlO9bsew0V0Dmb6pRRFt+IXEargUCwVmXOu4oshsqATsNTSJyTpDwNh+fQ
 ApzBlhYv8hckEEjRxCU2Mqx9q538BzhKR6buApAODX/r+/EiNcV/0LiYjK2Gy2EzErXW
 Nw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=Bvp3GJBhivWdX1nSqgCDoz3DWFUnU1rkDIgu+cmUcFU=;
 b=laauBzTRZqmYC/hS9VL64AtWMpveVhTKO0/21o2n2sPWlo8iePu/Uth+5ZOmaPHDAD
 t837yFVJoUi0cx2FjOICr5REq2jfAsrd/Zc7F8Z3Ki+YjJRGTFIOL80sgf6gm/lhvc08
 AkemAkCP+7576Z/vNeP9u9GPSftbMYHsC20eWeESFTS9Yy8n8evS5NYmlhnHqRgHCjKJ
 VEH3wbYNbkP08ePIBX75GjNUcbH8LTfHOWHHbllovx4MvY7OEEpdqQQpboL7m8V9jIHW
 tJTEJAA2mZy0a+7hjq735HGZhZ7VlBDIEnGF/FnuWlNpNBjAdhoj//M6UQzohsgOQQiL
 iQHQ==
X-Gm-Message-State: AOAM532CeTT5qfKFDyN2w7MWHGvG1SmXMs7GBBx/SvBUUy18/QFusjBG
 WxuZpUQstlZJIN5jRPzddlg=
X-Google-Smtp-Source: ABdhPJymCelSK48EdTe7DrMWtjNQEgjEsveIOmoaRJGP/akRynXCjTHJ4tl/wRJVPjG3Mqp9jmZA8w==
X-Received: by 2002:a17:906:14c1:: with SMTP id
 y1mr20582149ejc.481.1619592463150; 
 Tue, 27 Apr 2021 23:47:43 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:5565:6656:893b:2618?
 ([2a02:908:1252:fb60:5565:6656:893b:2618])
 by smtp.gmail.com with ESMTPSA id r17sm4110270edt.70.2021.04.27.23.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Apr 2021 23:47:42 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs
 initialization
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zeng, Oak" <Oak.Zeng@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20210427143756.8628-1-Dennis.Li@amd.com>
 <BN9PR12MB53682204CA3E3B9AC63FD72FFC419@BN9PR12MB5368.namprd12.prod.outlook.com>
 <b12f3f8b-c92f-ee57-4c07-2554db1f3598@gmail.com>
 <BN9PR12MB5368223AE794B23DAC720011FC419@BN9PR12MB5368.namprd12.prod.outlook.com>
 <ee2a8831-227d-e50b-992c-d10d7056b7c1@amd.com>
 <705C14FD-7880-4653-8C81-058FF2BB9496@amd.com>
 <MN2PR12MB44886BBB9DF0A00A85B58962F7419@MN2PR12MB4488.namprd12.prod.outlook.com>
 <B347578F-A26F-4801-A451-9A457E113034@amd.com>
 <MN2PR12MB4488EB63FD9E79897959201FF7419@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c17b0578-052f-9e53-a5ba-2e70c4bc26a5@gmail.com>
Date: Wed, 28 Apr 2021 08:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB4488EB63FD9E79897959201FF7419@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
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
Content-Type: multipart/mixed; boundary="===============1754178432=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1754178432==
Content-Type: multipart/alternative;
 boundary="------------EFBFFAC420D69CA6AA4F70F1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EFBFFAC420D69CA6AA4F70F1
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Mhm, I fear we at least need to comment the binary or otherwise we have 
a source code license violation here.

The only alternative is to have it as a firmware binary externally.

Christian.

Am 27.04.21 um 22:21 schrieb Deucher, Alexander:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> I mean, we wrote it in binary since they were so small.  I don't 
> remember how the newer ones for vega20 and Arcturus we generated.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Zeng, Oak <Oak.Zeng@amd.com>
> *Sent:* Tuesday, April 27, 2021 4:08 PM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>; Christian König 
> <ckoenig.leichtzumerken@gmail.com>; Li, Dennis <Dennis.Li@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Kuehling, Felix <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs 
> initialization
>
> Yes in that case, we can check in the hand writing assembly codes.
>
> Regards,
>
> Oak
>
> *From: *"Deucher, Alexander" <Alexander.Deucher@amd.com>
> *Date: *Tuesday, April 27, 2021 at 4:06 PM
> *To: *Oak Zeng <Oak.Zeng@amd.com>, "Koenig, Christian" 
> <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
> Christian König <ckoenig.leichtzumerken@gmail.com>, "Li, Dennis" 
> <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org" 
> <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" 
> <Felix.Kuehling@amd.com>
> *Subject: *Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs 
> initialization
>
> [AMD Official Use Only - Internal Distribution Only]
>
> That would probably be helpful.  TBH, I think we hand wrote the 
> original one for CZ so there was no original higher level source code.
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*Zeng, Oak <Oak.Zeng@amd.com>
> *Sent:* Tuesday, April 27, 2021 3:34 PM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>; Christian König 
> <ckoenig.leichtzumerken@gmail.com>; Li, Dennis <Dennis.Li@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs 
> initialization
>
> Hi Dennis,
>
> Should we check in the compute shader source codes? I only saw the 
> shader binaries. This will be helpful if people want to modify those 
> shaders/fix issues. The source code can be in a comment section above 
> the binary.
>
> Regards,
> Oak
>
>
>
> On 2021-04-27, 11:31 AM, "amd-gfx on behalf of Christian König" 
> <amd-gfx-bounces@lists.freedesktop.org on behalf of 
> christian.koenig@amd.com> wrote:
>
>     Ok in this case looks good to me.
>
>     Christian.
>
>     Am 27.04.21 um 17:26 schrieb Zhang, Hawking:
>     > [AMD Public Use]
>     >
>     > This need to be done during reset as well.
>     >
>     > Regards,
>     > Hawking
>     >
>     > -----Original Message-----
>     > From: Christian König <ckoenig.leichtzumerken@gmail.com>
>     > Sent: Tuesday, April 27, 2021 23:17
>     > To: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis 
> <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; 
> Koenig, Christian <Christian.Koenig@amd.com>
>     > Subject: Re: [PATCH] drm/amdgpu: fix no full coverage issue for 
> gprs initialization
>     >
>     > This is only done during bootup, isn't it?
>     >
>     > Wouldn't it be better to use the normal IB pool instead of the 
> direct one? Or do we also need to do this during GPU reset?
>     >
>     > Regards,
>     > Christian.
>     >
>     > Am 27.04.21 um 16:55 schrieb Zhang, Hawking:
>     >> [AMD Public Use]
>     >>
>     >> Please split the following into another patch when you commit 
> the one.
>     >> Other than that, the patch is
>     >>
>     >> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>     >>
>     >> Regards,
>     >> Hawking
>     >>
>     >> @@ -479,8 +710,6 @@ void 
> gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
>     >>                            die_id);
>     >>                   break;
>     >>           }
>     >> -
>     >> -        return;
>     >>    }
>     >>
>     >> -----Original Message-----
>     >> From: Dennis Li <Dennis.Li@amd.com>
>     >> Sent: Tuesday, April 27, 2021 22:38
>     >> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>     >> <Alexander.Deucher@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>;
>     >> Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian
>     >> <Christian.Koenig@amd.com>
>     >> Cc: Li, Dennis <Dennis.Li@amd.com>
>     >> Subject: [PATCH] drm/amdgpu: fix no full coverage issue for gprs
>     >> initialization
>     >>
>     >> The number of waves is changed to 8, so it is impossible to use 
> old solution to cover all sgprs.
>     >>
>     >> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>     >>
>     >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>     >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>     >> index a2fe2dac32c1..2e6789a7dc46 100644
>     >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>     >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>     >> @@ -328,7 +328,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device
>     >> *adev)
>     >>
>     >>           for (i = 0; i < AMDGPU_IB_POOL_MAX; i++) {
>     >>                   if (i == AMDGPU_IB_POOL_DIRECT)
>     >> -                        size = PAGE_SIZE * 2;
>     >> +                        size = PAGE_SIZE * 6;
>     >>                   else
>     >>                           size = AMDGPU_IB_POOL_SIZE;
>     >>
>     >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
>     >> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
>     >> index d17e57dea178..77948c033c45 100644
>     >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
>     >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
>     >> @@ -32,6 +32,11 @@
>     >>    #include "amdgpu_ras.h"
>     >>    #include "amdgpu_gfx.h"
>     >>
>     >> +#define SE_ID_MAX 8
>     >> +#define CU_ID_MAX 16
>     >> +#define SIMD_ID_MAX 4
>     >> +#define WAVE_ID_MAX 10
>     >> +
>     >>    enum gfx_v9_4_2_utc_type {
>     >>           VML2_MEM,
>     >>           VML2_WALKER_MEM,
>     >> @@ -81,100 +86,100 @@ static const struct soc15_reg_golden
>     >> golden_settings_gc_9_4_2_alde[] = {  };
>     >>
>     >>    static const u32 vgpr_init_compute_shader_aldebaran[] = {
>     >> -        0xb8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 
> 0x92088405, 0x81070807,
>     >> -        0x81070407, 0x8e078207, 0xbe88008f, 0xc0410200, 
> 0x00000007, 0xd3d94000,
>     >> -        0x18000080, 0xd3d94001, 0x18000080, 0xd3d94002, 
> 0x18000080, 0xd3d94003,
>     >> -        0x18000080, 0xd3d94004, 0x18000080, 0xd3d94005, 
> 0x18000080, 0xd3d94006,
>     >> -        0x18000080, 0xd3d94007, 0x18000080, 0xd3d94008, 
> 0x18000080, 0xd3d94009,
>     >> -        0x18000080, 0xd3d9400a, 0x18000080, 0xd3d9400b, 
> 0x18000080, 0xd3d9400c,
>     >> -        0x18000080, 0xd3d9400d, 0x18000080, 0xd3d9400e, 
> 0x18000080, 0xd3d9400f,
>     >> -        0x18000080, 0xd3d94010, 0x18000080, 0xd3d94011, 
> 0x18000080, 0xd3d94012,
>     >> -        0x18000080, 0xd3d94013, 0x18000080, 0xd3d94014, 
> 0x18000080, 0xd3d94015,
>     >> -        0x18000080, 0xd3d94016, 0x18000080, 0xd3d94017, 
> 0x18000080, 0xd3d94018,
>     >> -        0x18000080, 0xd3d94019, 0x18000080, 0xd3d9401a, 
> 0x18000080, 0xd3d9401b,
>     >> -        0x18000080, 0xd3d9401c, 0x18000080, 0xd3d9401d, 
> 0x18000080, 0xd3d9401e,
>     >> -        0x18000080, 0xd3d9401f, 0x18000080, 0xd3d94020, 
> 0x18000080, 0xd3d94021,
>     >> -        0x18000080, 0xd3d94022, 0x18000080, 0xd3d94023, 
> 0x18000080, 0xd3d94024,
>     >> -        0x18000080, 0xd3d94025, 0x18000080, 0xd3d94026, 
> 0x18000080, 0xd3d94027,
>     >> -        0x18000080, 0xd3d94028, 0x18000080, 0xd3d94029, 
> 0x18000080, 0xd3d9402a,
>     >> -        0x18000080, 0xd3d9402b, 0x18000080, 0xd3d9402c, 
> 0x18000080, 0xd3d9402d,
>     >> -        0x18000080, 0xd3d9402e, 0x18000080, 0xd3d9402f, 
> 0x18000080, 0xd3d94030,
>     >> -        0x18000080, 0xd3d94031, 0x18000080, 0xd3d94032, 
> 0x18000080, 0xd3d94033,
>     >> -        0x18000080, 0xd3d94034, 0x18000080, 0xd3d94035, 
> 0x18000080, 0xd3d94036,
>     >> -        0x18000080, 0xd3d94037, 0x18000080, 0xd3d94038, 
> 0x18000080, 0xd3d94039,
>     >> -        0x18000080, 0xd3d9403a, 0x18000080, 0xd3d9403b, 
> 0x18000080, 0xd3d9403c,
>     >> -        0x18000080, 0xd3d9403d, 0x18000080, 0xd3d9403e, 
> 0x18000080, 0xd3d9403f,
>     >> -        0x18000080, 0xd3d94040, 0x18000080, 0xd3d94041, 
> 0x18000080, 0xd3d94042,
>     >> -        0x18000080, 0xd3d94043, 0x18000080, 0xd3d94044, 
> 0x18000080, 0xd3d94045,
>     >> -        0x18000080, 0xd3d94046, 0x18000080, 0xd3d94047, 
> 0x18000080, 0xd3d94048,
>     >> -        0x18000080, 0xd3d94049, 0x18000080, 0xd3d9404a, 
> 0x18000080, 0xd3d9404b,
>     >> -        0x18000080, 0xd3d9404c, 0x18000080, 0xd3d9404d, 
> 0x18000080, 0xd3d9404e,
>     >> -        0x18000080, 0xd3d9404f, 0x18000080, 0xd3d94050, 
> 0x18000080, 0xd3d94051,
>     >> -        0x18000080, 0xd3d94052, 0x18000080, 0xd3d94053, 
> 0x18000080, 0xd3d94054,
>     >> -        0x18000080, 0xd3d94055, 0x18000080, 0xd3d94056, 
> 0x18000080, 0xd3d94057,
>     >> -        0x18000080, 0xd3d94058, 0x18000080, 0xd3d94059, 
> 0x18000080, 0xd3d9405a,
>     >> -        0x18000080, 0xd3d9405b, 0x18000080, 0xd3d9405c, 
> 0x18000080, 0xd3d9405d,
>     >> -        0x18000080, 0xd3d9405e, 0x18000080, 0xd3d9405f, 
> 0x18000080, 0xd3d94060,
>     >> -        0x18000080, 0xd3d94061, 0x18000080, 0xd3d94062, 
> 0x18000080, 0xd3d94063,
>     >> -        0x18000080, 0xd3d94064, 0x18000080, 0xd3d94065, 
> 0x18000080, 0xd3d94066,
>     >> -        0x18000080, 0xd3d94067, 0x18000080, 0xd3d94068, 
> 0x18000080, 0xd3d94069,
>     >> -        0x18000080, 0xd3d9406a, 0x18000080, 0xd3d9406b, 
> 0x18000080, 0xd3d9406c,
>     >> -        0x18000080, 0xd3d9406d, 0x18000080, 0xd3d9406e, 
> 0x18000080, 0xd3d9406f,
>     >> -        0x18000080, 0xd3d94070, 0x18000080, 0xd3d94071, 
> 0x18000080, 0xd3d94072,
>     >> -        0x18000080, 0xd3d94073, 0x18000080, 0xd3d94074, 
> 0x18000080, 0xd3d94075,
>     >> -        0x18000080, 0xd3d94076, 0x18000080, 0xd3d94077, 
> 0x18000080, 0xd3d94078,
>     >> -        0x18000080, 0xd3d94079, 0x18000080, 0xd3d9407a, 
> 0x18000080, 0xd3d9407b,
>     >> -        0x18000080, 0xd3d9407c, 0x18000080, 0xd3d9407d, 
> 0x18000080, 0xd3d9407e,
>     >> -        0x18000080, 0xd3d9407f, 0x18000080, 0xd3d94080, 
> 0x18000080, 0xd3d94081,
>     >> -        0x18000080, 0xd3d94082, 0x18000080, 0xd3d94083, 
> 0x18000080, 0xd3d94084,
>     >> -        0x18000080, 0xd3d94085, 0x18000080, 0xd3d94086, 
> 0x18000080, 0xd3d94087,
>     >> -        0x18000080, 0xd3d94088, 0x18000080, 0xd3d94089, 
> 0x18000080, 0xd3d9408a,
>     >> -        0x18000080, 0xd3d9408b, 0x18000080, 0xd3d9408c, 
> 0x18000080, 0xd3d9408d,
>     >> -        0x18000080, 0xd3d9408e, 0x18000080, 0xd3d9408f, 
> 0x18000080, 0xd3d94090,
>     >> -        0x18000080, 0xd3d94091, 0x18000080, 0xd3d94092, 
> 0x18000080, 0xd3d94093,
>     >> -        0x18000080, 0xd3d94094, 0x18000080, 0xd3d94095, 
> 0x18000080, 0xd3d94096,
>     >> -        0x18000080, 0xd3d94097, 0x18000080, 0xd3d94098, 
> 0x18000080, 0xd3d94099,
>     >> -        0x18000080, 0xd3d9409a, 0x18000080, 0xd3d9409b, 
> 0x18000080, 0xd3d9409c,
>     >> -        0x18000080, 0xd3d9409d, 0x18000080, 0xd3d9409e, 
> 0x18000080, 0xd3d9409f,
>     >> -        0x18000080, 0xd3d940a0, 0x18000080, 0xd3d940a1, 
> 0x18000080, 0xd3d940a2,
>     >> -        0x18000080, 0xd3d940a3, 0x18000080, 0xd3d940a4, 
> 0x18000080, 0xd3d940a5,
>     >> -        0x18000080, 0xd3d940a6, 0x18000080, 0xd3d940a7, 
> 0x18000080, 0xd3d940a8,
>     >> -        0x18000080, 0xd3d940a9, 0x18000080, 0xd3d940aa, 
> 0x18000080, 0xd3d940ab,
>     >> -        0x18000080, 0xd3d940ac, 0x18000080, 0xd3d940ad, 
> 0x18000080, 0xd3d940ae,
>     >> -        0x18000080, 0xd3d940af, 0x18000080, 0xd3d940b0, 
> 0x18000080, 0xd3d940b1,
>     >> -        0x18000080, 0xd3d940b2, 0x18000080, 0xd3d940b3, 
> 0x18000080, 0xd3d940b4,
>     >> -        0x18000080, 0xd3d940b5, 0x18000080, 0xd3d940b6, 
> 0x18000080, 0xd3d940b7,
>     >> -        0x18000080, 0xd3d940b8, 0x18000080, 0xd3d940b9, 
> 0x18000080, 0xd3d940ba,
>     >> -        0x18000080, 0xd3d940bb, 0x18000080, 0xd3d940bc, 
> 0x18000080, 0xd3d940bd,
>     >> -        0x18000080, 0xd3d940be, 0x18000080, 0xd3d940bf, 
> 0x18000080, 0xd3d940c0,
>     >> -        0x18000080, 0xd3d940c1, 0x18000080, 0xd3d940c2, 
> 0x18000080, 0xd3d940c3,
>     >> -        0x18000080, 0xd3d940c4, 0x18000080, 0xd3d940c5, 
> 0x18000080, 0xd3d940c6,
>     >> -        0x18000080, 0xd3d940c7, 0x18000080, 0xd3d940c8, 
> 0x18000080, 0xd3d940c9,
>     >> -        0x18000080, 0xd3d940ca, 0x18000080, 0xd3d940cb, 
> 0x18000080, 0xd3d940cc,
>     >> -        0x18000080, 0xd3d940cd, 0x18000080, 0xd3d940ce, 
> 0x18000080, 0xd3d940cf,
>     >> -        0x18000080, 0xd3d940d0, 0x18000080, 0xd3d940d1, 
> 0x18000080, 0xd3d940d2,
>     >> -        0x18000080, 0xd3d940d3, 0x18000080, 0xd3d940d4, 
> 0x18000080, 0xd3d940d5,
>     >> -        0x18000080, 0xd3d940d6, 0x18000080, 0xd3d940d7, 
> 0x18000080, 0xd3d940d8,
>     >> -        0x18000080, 0xd3d940d9, 0x18000080, 0xd3d940da, 
> 0x18000080, 0xd3d940db,
>     >> -        0x18000080, 0xd3d940dc, 0x18000080, 0xd3d940dd, 
> 0x18000080, 0xd3d940de,
>     >> -        0x18000080, 0xd3d940df, 0x18000080, 0xd3d940e0, 
> 0x18000080, 0xd3d940e1,
>     >> -        0x18000080, 0xd3d940e2, 0x18000080, 0xd3d940e3, 
> 0x18000080, 0xd3d940e4,
>     >> -        0x18000080, 0xd3d940e5, 0x18000080, 0xd3d940e6, 
> 0x18000080, 0xd3d940e7,
>     >> -        0x18000080, 0xd3d940e8, 0x18000080, 0xd3d940e9, 
> 0x18000080, 0xd3d940ea,
>     >> -        0x18000080, 0xd3d940eb, 0x18000080, 0xd3d940ec, 
> 0x18000080, 0xd3d940ed,
>     >> -        0x18000080, 0xd3d940ee, 0x18000080, 0xd3d940ef, 
> 0x18000080, 0xd3d940f0,
>     >> -        0x18000080, 0xd3d940f1, 0x18000080, 0xd3d940f2, 
> 0x18000080, 0xd3d940f3,
>     >> -        0x18000080, 0xd3d940f4, 0x18000080, 0xd3d940f5, 
> 0x18000080, 0xd3d940f6,
>     >> -        0x18000080, 0xd3d940f7, 0x18000080, 0xd3d940f8, 
> 0x18000080, 0xd3d940f9,
>     >> -        0x18000080, 0xd3d940fa, 0x18000080, 0xd3d940fb, 
> 0x18000080, 0xd3d940fc,
>     >> -        0x18000080, 0xd3d940fd, 0x18000080, 0xd3d940fe, 
> 0x18000080, 0xd3d940ff,
>     >> -        0x18000080, 0xb07c0000, 0xbe8a00ff, 0x000000f8, 
> 0xbf11080a, 0x7e000280,
>     >> -        0x7e020280, 0x7e040280, 0x7e060280, 0x7e080280, 
> 0x7e0a0280, 0x7e0c0280,
>     >> -        0x7e0e0280, 0x808a880a, 0xbe80320a, 0xbf84fff5, 
> 0xbf9c0000, 0xd28c0001,
>     >> -        0x0001007f, 0xd28d0001, 0x0002027e, 0x10020288, 
> 0xb88b0904, 0xb78b4000,
>     >> -        0xd1196a01, 0x00001701, 0xbe8a0087, 0xbefc00c1, 
> 0xd89c4000, 0x00020201,
>     >> -        0xd89cc080, 0x00040401, 0x320202ff, 0x00000800, 
> 0x808a810a, 0xbf84fff8,
>     >> -        0xbf810000,
>     >> +        0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 
> 0x9208ff06, 0x00000280,
>     >> +        0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 
> 0x81080308, 0x8e078208,
>     >> +        0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 
> 0xd3d94000, 0x18000080,
>     >> +        0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080, 
> 0xd3d94003, 0x18000080,
>     >> +        0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080, 
> 0xd3d94006, 0x18000080,
>     >> +        0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080, 
> 0xd3d94009, 0x18000080,
>     >> +        0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080, 
> 0xd3d9400c, 0x18000080,
>     >> +        0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080, 
> 0xd3d9400f, 0x18000080,
>     >> +        0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080, 
> 0xd3d94012, 0x18000080,
>     >> +        0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080, 
> 0xd3d94015, 0x18000080,
>     >> +        0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080, 
> 0xd3d94018, 0x18000080,
>     >> +        0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080, 
> 0xd3d9401b, 0x18000080,
>     >> +        0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080, 
> 0xd3d9401e, 0x18000080,
>     >> +        0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080, 
> 0xd3d94021, 0x18000080,
>     >> +        0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080, 
> 0xd3d94024, 0x18000080,
>     >> +        0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080, 
> 0xd3d94027, 0x18000080,
>     >> +        0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080, 
> 0xd3d9402a, 0x18000080,
>     >> +        0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080, 
> 0xd3d9402d, 0x18000080,
>     >> +        0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080, 
> 0xd3d94030, 0x18000080,
>     >> +        0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080, 
> 0xd3d94033, 0x18000080,
>     >> +        0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080, 
> 0xd3d94036, 0x18000080,
>     >> +        0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080, 
> 0xd3d94039, 0x18000080,
>     >> +        0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080, 
> 0xd3d9403c, 0x18000080,
>     >> +        0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080, 
> 0xd3d9403f, 0x18000080,
>     >> +        0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080, 
> 0xd3d94042, 0x18000080,
>     >> +        0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080, 
> 0xd3d94045, 0x18000080,
>     >> +        0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080, 
> 0xd3d94048, 0x18000080,
>     >> +        0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080, 
> 0xd3d9404b, 0x18000080,
>     >> +        0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080, 
> 0xd3d9404e, 0x18000080,
>     >> +        0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080, 
> 0xd3d94051, 0x18000080,
>     >> +        0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080, 
> 0xd3d94054, 0x18000080,
>     >> +        0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080, 
> 0xd3d94057, 0x18000080,
>     >> +        0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080, 
> 0xd3d9405a, 0x18000080,
>     >> +        0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080, 
> 0xd3d9405d, 0x18000080,
>     >> +        0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080, 
> 0xd3d94060, 0x18000080,
>     >> +        0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080, 
> 0xd3d94063, 0x18000080,
>     >> +        0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080, 
> 0xd3d94066, 0x18000080,
>     >> +        0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080, 
> 0xd3d94069, 0x18000080,
>     >> +        0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080, 
> 0xd3d9406c, 0x18000080,
>     >> +        0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080, 
> 0xd3d9406f, 0x18000080,
>     >> +        0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080, 
> 0xd3d94072, 0x18000080,
>     >> +        0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080, 
> 0xd3d94075, 0x18000080,
>     >> +        0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080, 
> 0xd3d94078, 0x18000080,
>     >> +        0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080, 
> 0xd3d9407b, 0x18000080,
>     >> +        0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080, 
> 0xd3d9407e, 0x18000080,
>     >> +        0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080, 
> 0xd3d94081, 0x18000080,
>     >> +        0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080, 
> 0xd3d94084, 0x18000080,
>     >> +        0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080, 
> 0xd3d94087, 0x18000080,
>     >> +        0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080, 
> 0xd3d9408a, 0x18000080,
>     >> +        0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080, 
> 0xd3d9408d, 0x18000080,
>     >> +        0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080, 
> 0xd3d94090, 0x18000080,
>     >> +        0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080, 
> 0xd3d94093, 0x18000080,
>     >> +        0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080, 
> 0xd3d94096, 0x18000080,
>     >> +        0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080, 
> 0xd3d94099, 0x18000080,
>     >> +        0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080, 
> 0xd3d9409c, 0x18000080,
>     >> +        0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080, 
> 0xd3d9409f, 0x18000080,
>     >> +        0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080, 
> 0xd3d940a2, 0x18000080,
>     >> +        0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080, 
> 0xd3d940a5, 0x18000080,
>     >> +        0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080, 
> 0xd3d940a8, 0x18000080,
>     >> +        0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080, 
> 0xd3d940ab, 0x18000080,
>     >> +        0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080, 
> 0xd3d940ae, 0x18000080,
>     >> +        0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080, 
> 0xd3d940b1, 0x18000080,
>     >> +        0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080, 
> 0xd3d940b4, 0x18000080,
>     >> +        0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080, 
> 0xd3d940b7, 0x18000080,
>     >> +        0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080, 
> 0xd3d940ba, 0x18000080,
>     >> +        0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080, 
> 0xd3d940bd, 0x18000080,
>     >> +        0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080, 
> 0xd3d940c0, 0x18000080,
>     >> +        0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080, 
> 0xd3d940c3, 0x18000080,
>     >> +        0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080, 
> 0xd3d940c6, 0x18000080,
>     >> +        0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080, 
> 0xd3d940c9, 0x18000080,
>     >> +        0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080, 
> 0xd3d940cc, 0x18000080,
>     >> +        0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080, 
> 0xd3d940cf, 0x18000080,
>     >> +        0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080, 
> 0xd3d940d2, 0x18000080,
>     >> +        0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080, 
> 0xd3d940d5, 0x18000080,
>     >> +        0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080, 
> 0xd3d940d8, 0x18000080,
>     >> +        0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080, 
> 0xd3d940db, 0x18000080,
>     >> +        0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080, 
> 0xd3d940de, 0x18000080,
>     >> +        0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080, 
> 0xd3d940e1, 0x18000080,
>     >> +        0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080, 
> 0xd3d940e4, 0x18000080,
>     >> +        0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080, 
> 0xd3d940e7, 0x18000080,
>     >> +        0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080, 
> 0xd3d940ea, 0x18000080,
>     >> +        0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080, 
> 0xd3d940ed, 0x18000080,
>     >> +        0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080, 
> 0xd3d940f0, 0x18000080,
>     >> +        0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080, 
> 0xd3d940f3, 0x18000080,
>     >> +        0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080, 
> 0xd3d940f6, 0x18000080,
>     >> +        0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080, 
> 0xd3d940f9, 0x18000080,
>     >> +        0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080, 
> 0xd3d940fc, 0x18000080,
>     >> +        0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080, 
> 0xd3d940ff, 0x18000080,
>     >> +        0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a, 
> 0x7e000280, 0x7e020280,
>     >> +        0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280, 
> 0x7e0c0280, 0x7e0e0280,
>     >> +        0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000, 
> 0xd28c0001, 0x0001007f,
>     >> +        0xd28d0001, 0x0002027e, 0x10020288, 0xbe8b0004, 
> 0xb78b4000, 0xd1196a01,
>     >> +        0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000, 
> 0x00020201, 0xd89cc080,
>     >> +        0x00040401, 0x320202ff, 0x00000800, 0x808a810a, 
> 0xbf84fff8,
>     >> +0xbf810000,
>     >>    };
>     >>
>     >>    const struct soc15_reg_entry vgpr_init_regs_aldebaran[] = { 
> @@ -183,7 +188,7 @@ const struct soc15_reg_entry 
> vgpr_init_regs_aldebaran[] = {
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 4 },
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xbf },
>     >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 
> 0x400004 },  /* 64KB LDS */
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 
> 0x400006 },  /* 64KB
>     >> +LDS */
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F 
> }, /*  63 - accum-offset = 256 */
>     >>           { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
>     >>           { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff }, @@ -195,262 +200,488 
> @@ const struct soc15_reg_entry vgpr_init_regs_aldebaran[] = {
>     >>           { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE7),
>     >> 0xffffffff },  };
>     >>
>     >> -static const u32 sgpr_init_compute_shader_aldebaran[] = {
>     >> -        0xb8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 
> 0x92088405, 0x81070807,
>     >> -        0x81070407, 0x8e078207, 0xbefc0006, 0xbf800000, 
> 0xbf900001, 0xbe88008f,
>     >> -        0xc0410200, 0x00000007, 0xb07c0000, 0xbe8000ff, 
> 0x0000005f, 0xbee50080,
>     >> -        0xbe812c65, 0xbe822c65, 0xbe832c65, 0xbe842c65, 
> 0xbe852c65, 0xb77c0005,
>     >> -        0x80808500, 0xbf84fff8, 0xbe800080, 0xbf810000,
>     >> +static const u32 sgpr112_init_compute_shader_aldebaran[] = {
>     >> +        0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 
> 0x9208ff06, 0x00000280,
>     >> +        0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 
> 0x81080308, 0x8e078208,
>     >> +        0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 
> 0xbf8e003f, 0xc0030200,
>     >> +        0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 
> 0xbf84fff9, 0x81028102,
>     >> +        0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 
> 0xbe880080, 0xbe890080,
>     >> +        0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 
> 0xbe8e0080, 0xbe8f0080,
>     >> +        0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 
> 0xbe940080, 0xbe950080,
>     >> +        0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 
> 0xbe9a0080, 0xbe9b0080,
>     >> +        0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 
> 0xbea00080, 0xbea10080,
>     >> +        0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 
> 0xbea60080, 0xbea70080,
>     >> +        0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 
> 0xbeac0080, 0xbead0080,
>     >> +        0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 
> 0xbeb20080, 0xbeb30080,
>     >> +        0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 
> 0xbeb80080, 0xbeb90080,
>     >> +        0xbeba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 
> 0xbebe0080, 0xbebf0080,
>     >> +        0xbec00080, 0xbec10080, 0xbec20080, 0xbec30080, 
> 0xbec40080, 0xbec50080,
>     >> +        0xbec60080, 0xbec70080, 0xbec80080, 0xbec90080, 
> 0xbeca0080, 0xbecb0080,
>     >> +        0xbecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 
> 0xbed00080, 0xbed10080,
>     >> +        0xbed20080, 0xbed30080, 0xbed40080, 0xbed50080, 
> 0xbed60080, 0xbed70080,
>     >> +        0xbed80080, 0xbed90080, 0xbeda0080, 0xbedb0080, 
> 0xbedc0080, 0xbedd0080,
>     >> +        0xbede0080, 0xbedf0080, 0xbee00080, 0xbee10080, 
> 0xbee20080, 0xbee30080,
>     >> +        0xbee40080, 0xbee50080, 0xbf810000
>     >>    };
>     >>
>     >> -static const struct soc15_reg_entry 
> sgpr1_init_regs_aldebaran[] = {
>     >> +const struct soc15_reg_entry sgpr112_init_regs_aldebaran[] = {
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 
> 0x0000000 },
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 
> 0x40 },
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 
> }, /* (80 GPRS): SGPRS[9:6] VGPRS[5:0] */
>     >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, 
> /* USER_SGPR[5:1]*/
>     >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F 
> }, /*  63 - accum-offset = 256 */
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x000000ff },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x000000ff },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x000000ff },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x000000ff },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x000000ff },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x000000ff },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x000000ff },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x000000ff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x2c0 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE7),
>     >> +0xffffffff }, };
>     >> +
>     >> +static const u32 sgpr96_init_compute_shader_aldebaran[] = {
>     >> +        0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 
> 0x9208ff06, 0x00000280,
>     >> +        0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 
> 0x81080308, 0x8e078208,
>     >> +        0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 
> 0xbf8e003f, 0xc0030200,
>     >> +        0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 
> 0xbf84fff9, 0x81028102,
>     >> +        0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 
> 0xbe880080, 0xbe890080,
>     >> +        0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 
> 0xbe8e0080, 0xbe8f0080,
>     >> +        0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 
> 0xbe940080, 0xbe950080,
>     >> +        0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 
> 0xbe9a0080, 0xbe9b0080,
>     >> +        0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 
> 0xbea00080, 0xbea10080,
>     >> +        0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 
> 0xbea60080, 0xbea70080,
>     >> +        0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 
> 0xbeac0080, 0xbead0080,
>     >> +        0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 
> 0xbeb20080, 0xbeb30080,
>     >> +        0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 
> 0xbeb80080, 0xbeb90080,
>     >> +        0xbeba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 
> 0xbebe0080, 0xbebf0080,
>     >> +        0xbec00080, 0xbec10080, 0xbec20080, 0xbec30080, 
> 0xbec40080, 0xbec50080,
>     >> +        0xbec60080, 0xbec70080, 0xbec80080, 0xbec90080, 
> 0xbeca0080, 0xbecb0080,
>     >> +        0xbecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 
> 0xbed00080, 0xbed10080,
>     >> +        0xbed20080, 0xbed30080, 0xbed40080, 0xbed50080, 
> 0xbed60080, 0xbed70080,
>     >> +        0xbed80080, 0xbed90080, 0xbf810000,
>     >>    };
>     >>
>     >> -static const struct soc15_reg_entry 
> sgpr2_init_regs_aldebaran[] = {
>     >> +const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = {
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 
> 0x0000000 },
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 
> 0x40 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 0xc },
>     >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 
> }, /* (80 GPRS) */
>     >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, 
> /* USER_SGPR[5:1]*/
>     >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F 
> }, /*  63 - accum-offset = 256 */
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x0000ff00 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x0000ff00 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x0000ff00 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x0000ff00 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x0000ff00 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x0000ff00 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x0000ff00 },
>     >> -        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x0000ff00 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE7),
>     >> +0xffffffff },
>     >>    };
>     >>
>     >> -static int gfx_v9_4_2_check_gprs_init_coverage(struct 
> amdgpu_device *adev,
>     >> - uint32_t *wb)
>     >> -{
>     >> -        uint32_t se_id, cu_id, simd_id;
>     >> -        uint32_t simd_cnt = 0;
>     >> -        uint32_t se_offset, cu_offset, data;
>     >> -
>     >> -        for (se_id = 0; se_id < 
> adev->gfx.config.max_shader_engines; se_id++) {
>     >> -                se_offset = se_id * 16 * 4;
>     >> -                for (cu_id = 0; cu_id < 16; cu_id++) {
>     >> -                        cu_offset = cu_id * 4;
>     >> -                        for (simd_id = 0; simd_id < 4; 
> simd_id++) {
>     >> -                                data = wb[se_offset + 
> cu_offset + simd_id];
>     >> -                                if (data == 0xF)
>     >> -                                        simd_cnt++;
>     >> -                        }
>     >> -                }
>     >> -        }
>     >> -
>     >> -        if (adev->gfx.cu_info.number * 4 == simd_cnt)
>     >> -                return 0;
>     >> -
>     >> -        dev_warn(adev->dev, "SIMD Count: %d, %d\n",
>     >> - adev->gfx.cu_info.number * 4, simd_cnt);
>     >> -
>     >> -        for (se_id = 0; se_id < 
> adev->gfx.config.max_shader_engines; se_id++) {
>     >> -                se_offset = se_id * 16 * 4;
>     >> -                for (cu_id = 0; cu_id < 16; cu_id++) {
>     >> -                        cu_offset = cu_id * 4;
>     >> -                        for (simd_id = 0; simd_id < 4; 
> simd_id++) {
>     >> -                                data = wb[se_offset + 
> cu_offset + simd_id];
>     >> -                                if (data != 0xF)
>     >> - dev_warn(adev->dev, "SE[%d]CU[%d]SIMD[%d]: isn't inited\n",
>     >> - se_id, cu_id, simd_id);
>     >> -                        }
>     >> -                }
>     >> -        }
>     >> +static const u32 sgpr64_init_compute_shader_aldebaran[] = {
>     >> +        0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 
> 0x9208ff06, 0x00000280,
>     >> +        0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 
> 0x81080308, 0x8e078208,
>     >> +        0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 
> 0xbefc0080, 0xbe880080,
>     >> +        0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 
> 0xbe8d0080, 0xbe8e0080,
>     >> +        0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080, 
> 0xbe930080, 0xbe940080,
>     >> +        0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080, 
> 0xbe990080, 0xbe9a0080,
>     >> +        0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 
> 0xbe9f0080, 0xbea00080,
>     >> +        0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080, 
> 0xbea50080, 0xbea60080,
>     >> +        0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080, 
> 0xbeab0080, 0xbeac0080,
>     >> +        0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080, 
> 0xbeb10080, 0xbeb20080,
>     >> +        0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080, 
> 0xbeb70080, 0xbeb80080,
>     >> +        0xbeb90080, 0xbf810000,
>     >> +};
>     >>
>     >> -        return -EFAULT;
>     >> -}
>     >> +const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 
> 0x0000000 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 0x10 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x1c0 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
>     >> +        { SOC15_REG_ENTRY(GC, 0, 
> regCOMPUTE_STATIC_THREAD_MGMT_SE7),
>     >> +0xffffffff }, };
>     >>
>     >>    static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
>     >> -                                 const uint32_t *shader_ptr, 
> uint32_t shader_size,
>     >> -                                 const struct soc15_reg_entry 
> *init_regs, uint32_t regs_size,
>     >> - uint32_t compute_dim_x, u64 wb_gpu_addr)
>     >> + struct amdgpu_ring *ring,
>     >> + struct amdgpu_ib *ib,
>     >> +                                 const u32 *shader_ptr, u32 
> shader_size,
>     >> +                                 const struct soc15_reg_entry 
> *init_regs, u32 regs_size,
>     >> +                                 u32 compute_dim_x, u64 
> wb_gpu_addr, u32 pattern,
>     >> + struct dma_fence **fence_ptr)
>     >>    {
>     >> -        struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
>     >> -        struct amdgpu_ib ib;
>     >> -        struct dma_fence *f = NULL;
>     >>           int r, i;
>     >>           uint32_t total_size, shader_offset;
>     >>           u64 gpu_addr;
>     >>
>     >> -        total_size = (regs_size * 3 + 4 + 4 + 5 + 2) * 4;
>     >> +        total_size = (regs_size * 3 + 4 + 5 + 5) * 4;
>     >>           total_size = ALIGN(total_size, 256);
>     >>           shader_offset = total_size;
>     >>           total_size += ALIGN(shader_size, 256);
>     >>
>     >>           /* allocate an indirect buffer to put the commands in */
>     >> -        memset(&ib, 0, sizeof(ib));
>     >> +        memset(ib, 0, sizeof(*ib));
>     >>           r = amdgpu_ib_get(adev, NULL, total_size,
>     >> - AMDGPU_IB_POOL_DIRECT, &ib);
>     >> + AMDGPU_IB_POOL_DIRECT, ib);
>     >>           if (r) {
>     >> -                DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
>     >> +                dev_err(adev->dev, "failed to get ib (%d).\n", r);
>     >>                   return r;
>     >>           }
>     >>
>     >>           /* load the compute shaders */
>     >>           for (i = 0; i < shader_size/sizeof(u32); i++)
>     >> -                ib.ptr[i + (shader_offset / 4)] = shader_ptr[i];
>     >> +                ib->ptr[i + (shader_offset / 4)] = shader_ptr[i];
>     >>
>     >>           /* init the ib length to 0 */
>     >> -        ib.length_dw = 0;
>     >> +        ib->length_dw = 0;
>     >>
>     >>           /* write the register state for the compute dispatch */
>     >>           for (i = 0; i < regs_size; i++) {
>     >> -                ib.ptr[ib.length_dw++] = 
> PACKET3(PACKET3_SET_SH_REG, 1);
>     >> -                ib.ptr[ib.length_dw++] = 
> SOC15_REG_ENTRY_OFFSET(init_regs[i])
>     >> + ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
>     >> + ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(init_regs[i])
> >> - PACKET3_SET_SH_REG_START;
>     >> -                ib.ptr[ib.length_dw++] = init_regs[i].reg_value;
>     >> + ib->ptr[ib->length_dw++] = init_regs[i].reg_value;
>     >>           }
>     >>
>     >>           /* write the shader start address: mmCOMPUTE_PGM_LO, 
> mmCOMPUTE_PGM_HI */
>     >> -        gpu_addr = (ib.gpu_addr + (u64)shader_offset) >> 8;
>     >> -        ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
>     >> -        ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, 
> regCOMPUTE_PGM_LO)
>     >> +        gpu_addr = (ib->gpu_addr + (u64)shader_offset) >> 8;
>     >> +        ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
>     >> +        ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0,
>     >> +regCOMPUTE_PGM_LO)
> >> - PACKET3_SET_SH_REG_START;
>     >> -        ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
>     >> -        ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
>     >> +        ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
>     >> +        ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
>     >>
>     >>           /* write the wb buffer address */
>     >> -        ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
>     >> -        ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, 
> regCOMPUTE_USER_DATA_0)
>     >> +        ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 3);
>     >> +        ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0,
>     >> +regCOMPUTE_USER_DATA_0)
> >> - PACKET3_SET_SH_REG_START;
>     >> -        ib.ptr[ib.length_dw++] = lower_32_bits(wb_gpu_addr);
>     >> -        ib.ptr[ib.length_dw++] = upper_32_bits(wb_gpu_addr);
>     >> +        ib->ptr[ib->length_dw++] = lower_32_bits(wb_gpu_addr);
>     >> +        ib->ptr[ib->length_dw++] = upper_32_bits(wb_gpu_addr);
>     >> +        ib->ptr[ib->length_dw++] = pattern;
>     >>
>     >>           /* write dispatch packet */
>     >> -        ib.ptr[ib.length_dw++] = 
> PACKET3(PACKET3_DISPATCH_DIRECT, 3);
>     >> -        ib.ptr[ib.length_dw++] = compute_dim_x; /* x */
>     >> -        ib.ptr[ib.length_dw++] = 1; /* y */
>     >> -        ib.ptr[ib.length_dw++] = 1; /* z */
>     >> -        ib.ptr[ib.length_dw++] =
>     >> +        ib->ptr[ib->length_dw++] = 
> PACKET3(PACKET3_DISPATCH_DIRECT, 3);
>     >> +        ib->ptr[ib->length_dw++] = compute_dim_x; /* x */
>     >> +        ib->ptr[ib->length_dw++] = 1; /* y */
>     >> +        ib->ptr[ib->length_dw++] = 1; /* z */
>     >> +        ib->ptr[ib->length_dw++] =
>     >>                   REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, 
> COMPUTE_SHADER_EN,
>     >> 1);
>     >>
>     >> -        /* write CS partial flush packet */
>     >> -        ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
>     >> -        ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
>     >> -
>     >>           /* shedule the ib on the ring */
>     >> -        r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
>     >> +        r = amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
>     >>           if (r) {
>     >> -                DRM_ERROR("amdgpu: ib submit failed (%d).\n", r);
>     >> -                goto fail;
>     >> +                dev_err(adev->dev, "ib submit failed (%d).\n", r);
>     >> +                amdgpu_ib_free(adev, ib, NULL);
>     >>           }
>     >> +        return r;
>     >> +}
>     >>
>     >> -        /* wait for the GPU to finish processing the IB */
>     >> -        r = dma_fence_wait(f, false);
>     >> -        if (r) {
>     >> -                DRM_ERROR("amdgpu: fence wait failed (%d).\n", r);
>     >> -                goto fail;
>     >> +static void gfx_v9_4_2_log_wave_assignment(struct amdgpu_device
>     >> +*adev, uint32_t *wb_ptr) {
>     >> +        uint32_t se, cu, simd, wave;
>     >> +        uint32_t offset = 0;
>     >> +        char *str;
>     >> +        int size;
>     >> +
>     >> +        str = kmalloc(256, GFP_KERNEL);
>     >> +        if (!str)
>     >> +                return;
>     >> +
>     >> +        dev_dbg(adev->dev, "wave assignment:\n");
>     >> +
>     >> +        for (se = 0; se < adev->gfx.config.max_shader_engines; 
> se++) {
>     >> +                for (cu = 0; cu < CU_ID_MAX; cu++) {
>     >> +                        memset(str, 0, 256);
>     >> +                        size = sprintf(str, "SE[%02d]CU[%02d]: 
> ", se, cu);
>     >> +                        for (simd = 0; simd < SIMD_ID_MAX; 
> simd++) {
>     >> +                                size += sprintf(str + size, "[");
>     >> +                                for (wave = 0; wave < 
> WAVE_ID_MAX; wave++) {
>     >> +                                        size += sprintf(str + 
> size, "%x", wb_ptr[offset]);
>     >> +                                        offset++;
>     >> +                                }
>     >> +                                size += sprintf(str + size, 
> "]  ");
>     >> +                        }
>     >> + dev_dbg(adev->dev, "%s\n", str);
>     >> +                }
>     >>           }
>     >> -fail:
>     >> -        amdgpu_ib_free(adev, &ib, NULL);
>     >> -        dma_fence_put(f);
>     >>
>     >> -        return r;
>     >> +        kfree(str);
>     >>    }
>     >>
>     >> -int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>     >> +static int gfx_v9_4_2_wait_for_waves_assigned(struct 
> amdgpu_device *adev,
>     >> + uint32_t *wb_ptr, uint32_t mask,
>     >> + uint32_t pattern, uint32_t num_wave, bool wait)
>     >>    {
>     >> -        struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
>     >> -        int r;
>     >> -        int compute_dim_x = adev->gfx.config.max_shader_engines *
>     >> - adev->gfx.config.max_cu_per_sh *
>     >> - adev->gfx.config.max_sh_per_se;
>     >> -        int sgpr_work_group_size = 5;
>     >> -        /* CU_ID: 0~15, SIMD_ID: 0~3 */
>     >> -        int wb_size = adev->gfx.config.max_shader_engines * 16 
> * 4;
>     >> -        struct amdgpu_ib ib;
>     >> +        uint32_t se, cu, simd, wave;
>     >> +        uint32_t loop = 0;
>     >> +        uint32_t wave_cnt;
>     >> +        uint32_t offset;
>     >>
>     >> -        /* only support when RAS is enabled */
>     >> -        if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
>     >> -                return 0;
>     >> +        do {
>     >> +                wave_cnt = 0;
>     >> +                offset = 0;
>     >> +
>     >> +                for (se = 0; se < 
> adev->gfx.config.max_shader_engines; se++)
>     >> +                        for (cu = 0; cu < CU_ID_MAX; cu++)
>     >> +                                for (simd = 0; simd < 
> SIMD_ID_MAX; simd++)
>     >> +                                        for (wave = 0; wave < 
> WAVE_ID_MAX; wave++) {
>     >> +                                                if (((1 << 
> wave) & mask) &&
>     >> + (wb_ptr[offset] == pattern))
>     >> + wave_cnt++;
>     >> +
>     >> + offset++;
>     >> +                                        }
>     >> +
>     >> +                if (wave_cnt == num_wave)
>     >> +                        return 0;
>     >> +
>     >> +                mdelay(1);
>     >> +        } while (++loop < 2000 && wait);
>     >> +
>     >> +        dev_err(adev->dev, "actual wave num: %d, expected wave 
> num: %d\n",
>     >> +                wave_cnt, num_wave);
>     >> +
>     >> + gfx_v9_4_2_log_wave_assignment(adev, wb_ptr);
>     >> +
>     >> +        return -EBADSLT;
>     >> +}
>     >> +
>     >> +static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev) {
>     >> +        int r;
>     >> +        int wb_size = adev->gfx.config.max_shader_engines *
>     >> +                         CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
>     >> +        struct amdgpu_ib wb_ib;
>     >> +        struct amdgpu_ib disp_ibs[3];
>     >> +        struct dma_fence *fences[3];
>     >> +        u32 pattern[3] = { 0x1, 0x5, 0xa };
>     >>
>     >>           /* bail if the compute ring is not ready */
>     >> -        if (!ring->sched.ready)
>     >> +        if (!adev->gfx.compute_ring[0].sched.ready ||
>     >> + !adev->gfx.compute_ring[1].sched.ready)
>     >>                   return 0;
>     >>
>     >> -        /* allocate an indirect buffer to put the commands in */
>     >> -        memset(&ib, 0, sizeof(ib));
>     >> -        r = amdgpu_ib_get(adev, NULL, wb_size * sizeof(uint32_t),
>     >> - AMDGPU_IB_POOL_DIRECT, &ib);
>     >> +        /* allocate the write-back buffer from IB */
>     >> +        memset(&wb_ib, 0, sizeof(wb_ib));
>     >> +        r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * 
> sizeof(uint32_t),
>     >> + AMDGPU_IB_POOL_DIRECT, &wb_ib);
>     >>           if (r) {
>     >> -                DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
>     >> +                dev_err(adev->dev, "failed to get ib (%d) for 
> wb\n", r);
>     >>                   return r;
>     >>           }
>     >> +        memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
>     >> +
>     >> +        r = gfx_v9_4_2_run_shader(adev,
>     >> + &adev->gfx.compute_ring[0],
>     >> + &disp_ibs[0],
>     >> + sgpr112_init_compute_shader_aldebaran,
>     >> + sizeof(sgpr112_init_compute_shader_aldebaran),
>     >> + sgpr112_init_regs_aldebaran,
>     >> + ARRAY_SIZE(sgpr112_init_regs_aldebaran),
>     >> + adev->gfx.cu_info.number,
>     >> + wb_ib.gpu_addr, pattern[0], &fences[0]);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "failed to clear first 224 
> sgprs\n");
>     >> +                goto pro_end;
>     >> +        }
>     >>
>     >> -        memset(ib.ptr, 0, wb_size * sizeof(uint32_t));
>     >> -        r = gfx_v9_4_2_run_shader(adev, 
> vgpr_init_compute_shader_aldebaran,
>     >> - sizeof(vgpr_init_compute_shader_aldebaran),
>     >> - vgpr_init_regs_aldebaran,
>     >> - ARRAY_SIZE(vgpr_init_regs_aldebaran),
>     >> - compute_dim_x * 2, ib.gpu_addr);
>     >> +        r = gfx_v9_4_2_wait_for_waves_assigned(adev,
>     >> + &wb_ib.ptr[1], 0b11,
>     >> +                        pattern[0],
>     >> + adev->gfx.cu_info.number * SIMD_ID_MAX * 2,
>     >> +                        true);
>     >>           if (r) {
>     >> -                dev_err(adev->dev, "Init VGPRS: failed to run 
> shader\n");
>     >> -                goto failed;
>     >> +                dev_err(adev->dev, "wave coverage failed when 
> clear first 224 sgprs\n");
>     >> +                wb_ib.ptr[0] = 0xdeadbeaf; /* stop waves */
>     >> +                goto disp0_failed;
>     >>           }
>     >>
>     >> -        r = gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);
>     >> +        r = gfx_v9_4_2_run_shader(adev,
>     >> + &adev->gfx.compute_ring[1],
>     >> + &disp_ibs[1],
>     >> + sgpr96_init_compute_shader_aldebaran,
>     >> + sizeof(sgpr96_init_compute_shader_aldebaran),
>     >> + sgpr96_init_regs_aldebaran,
>     >> + ARRAY_SIZE(sgpr96_init_regs_aldebaran),
>     >> + adev->gfx.cu_info.number * 2,
>     >> + wb_ib.gpu_addr, pattern[1], &fences[1]);
>     >>           if (r) {
>     >> -                dev_err(adev->dev, "Init VGPRS: failed to 
> cover all SIMDs\n");
>     >> -                goto failed;
>     >> -        } else {
>     >> -                dev_info(adev->dev, "Init VGPRS Successfully\n");
>     >> +                dev_err(adev->dev, "failed to clear next 576 
> sgprs\n");
>     >> +                goto disp0_failed;
>     >> +        }
>     >> +
>     >> +        r = gfx_v9_4_2_wait_for_waves_assigned(adev,
>     >> + &wb_ib.ptr[1], 0b11111100,
>     >> +                        pattern[1], adev->gfx.cu_info.number * 
> SIMD_ID_MAX * 6,
>     >> +                        true);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "wave coverage failed when 
> clear first 576 sgprs\n");
>     >> +                wb_ib.ptr[0] = 0xdeadbeaf; /* stop waves */
>     >> +                goto disp1_failed;
>     >>           }
>     >>
>     >> -        memset(ib.ptr, 0, wb_size * sizeof(uint32_t));
>     >> -        r = gfx_v9_4_2_run_shader(adev, 
> sgpr_init_compute_shader_aldebaran,
>     >> - sizeof(sgpr_init_compute_shader_aldebaran),
>     >> - sgpr1_init_regs_aldebaran,
>     >> - ARRAY_SIZE(sgpr1_init_regs_aldebaran),
>     >> - compute_dim_x / 2 * sgpr_work_group_size,
>     >> - ib.gpu_addr);
>     >> +        wb_ib.ptr[0] = 0xdeadbeaf; /* stop waves */
>     >> +
>     >> +        /* wait for the GPU to finish processing the IB */
>     >> +        r = dma_fence_wait(fences[0], false);
>     >>           if (r) {
>     >> -                dev_err(adev->dev, "Init SGPRS Part1: failed 
> to run shader\n");
>     >> -                goto failed;
>     >> +                dev_err(adev->dev, "timeout to clear first 224 
> sgprs\n");
>     >> +                goto disp1_failed;
>     >>           }
>     >>
>     >> -        r = gfx_v9_4_2_run_shader(adev, 
> sgpr_init_compute_shader_aldebaran,
>     >> - sizeof(sgpr_init_compute_shader_aldebaran),
>     >> - sgpr2_init_regs_aldebaran,
>     >> - ARRAY_SIZE(sgpr2_init_regs_aldebaran),
>     >> - compute_dim_x / 2 * sgpr_work_group_size,
>     >> - ib.gpu_addr);
>     >> +        r = dma_fence_wait(fences[1], false);
>     >>           if (r) {
>     >> -                dev_err(adev->dev, "Init SGPRS Part2: failed 
> to run shader\n");
>     >> -                goto failed;
>     >> +                dev_err(adev->dev, "timeout to clear first 576 
> sgprs\n");
>     >> +                goto disp1_failed;
>     >>           }
>     >>
>     >> -        r = gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);
>     >> +        memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
>     >> +        r = gfx_v9_4_2_run_shader(adev,
>     >> + &adev->gfx.compute_ring[0],
>     >> + &disp_ibs[2],
>     >> + sgpr64_init_compute_shader_aldebaran,
>     >> + sizeof(sgpr64_init_compute_shader_aldebaran),
>     >> + sgpr64_init_regs_aldebaran,
>     >> + ARRAY_SIZE(sgpr64_init_regs_aldebaran),
>     >> + adev->gfx.cu_info.number,
>     >> + wb_ib.gpu_addr, pattern[2], &fences[2]);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "failed to clear first 256 
> sgprs\n");
>     >> +                goto disp1_failed;
>     >> +        }
>     >> +
>     >> +        r = dma_fence_wait(fences[2], false);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "timeout to clear first 256 
> sgprs\n");
>     >> +                goto disp2_failed;
>     >> +        }
>     >> +
>     >> +        r = gfx_v9_4_2_wait_for_waves_assigned(adev,
>     >> + &wb_ib.ptr[1], 0b1111,
>     >> +                        pattern[2],
>     >> + adev->gfx.cu_info.number * SIMD_ID_MAX * 4,
>     >> +                        false);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "wave coverage failed when 
> clear first 256 sgprs\n");
>     >> +                goto disp2_failed;
>     >> +        }
>     >> +
>     >> +disp2_failed:
>     >> +        amdgpu_ib_free(adev, &disp_ibs[2], NULL);
>     >> +        dma_fence_put(fences[2]);
>     >> +disp1_failed:
>     >> +        amdgpu_ib_free(adev, &disp_ibs[1], NULL);
>     >> +        dma_fence_put(fences[1]);
>     >> +disp0_failed:
>     >> +        amdgpu_ib_free(adev, &disp_ibs[0], NULL);
>     >> +        dma_fence_put(fences[0]);
>     >> +pro_end:
>     >> +        amdgpu_ib_free(adev, &wb_ib, NULL);
>     >> +
>     >>           if (r)
>     >> -                dev_err(adev->dev,
>     >> -                        "Init SGPRS: failed to cover all 
> SIMDs\n");
>     >> +                dev_info(adev->dev, "Init SGPRS Failed\n");
>     >>           else
>     >> dev_info(adev->dev, "Init SGPRS Successfully\n");
>     >>
>     >> -failed:
>     >> -        amdgpu_ib_free(adev, &ib, NULL);
>     >>           return r;
>     >>    }
>     >>
>     >> +static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev) {
>     >> +        int r;
>     >> +        /* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
>     >> +        int wb_size = adev->gfx.config.max_shader_engines *
>     >> +                         CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
>     >> +        struct amdgpu_ib wb_ib;
>     >> +        struct amdgpu_ib disp_ib;
>     >> +        struct dma_fence *fence;
>     >> +        u32 pattern = 0xa;
>     >> +
>     >> +        /* bail if the compute ring is not ready */
>     >> +        if (!adev->gfx.compute_ring[0].sched.ready)
>     >> +                return 0;
>     >> +
>     >> +        /* allocate the write-back buffer from IB */
>     >> +        memset(&wb_ib, 0, sizeof(wb_ib));
>     >> +        r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * 
> sizeof(uint32_t),
>     >> + AMDGPU_IB_POOL_DIRECT, &wb_ib);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "failed to get ib (%d) for 
> wb.\n", r);
>     >> +                return r;
>     >> +        }
>     >> +        memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
>     >> +
>     >> +        r = gfx_v9_4_2_run_shader(adev,
>     >> + &adev->gfx.compute_ring[0],
>     >> +                        &disp_ib,
>     >> + vgpr_init_compute_shader_aldebaran,
>     >> + sizeof(vgpr_init_compute_shader_aldebaran),
>     >> + vgpr_init_regs_aldebaran,
>     >> + ARRAY_SIZE(vgpr_init_regs_aldebaran),
>     >> + adev->gfx.cu_info.number,
>     >> + wb_ib.gpu_addr, pattern, &fence);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "failed to clear vgprs\n");
>     >> +                goto pro_end;
>     >> +        }
>     >> +
>     >> +        /* wait for the GPU to finish processing the IB */
>     >> +        r = dma_fence_wait(fence, false);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "timeout to clear vgprs\n");
>     >> +                goto disp_failed;
>     >> +        }
>     >> +
>     >> +        r = gfx_v9_4_2_wait_for_waves_assigned(adev,
>     >> + &wb_ib.ptr[1], 0b1,
>     >> +                        pattern,
>     >> + adev->gfx.cu_info.number * SIMD_ID_MAX,
>     >> +                        false);
>     >> +        if (r) {
>     >> +                dev_err(adev->dev, "failed to cover all simds 
> when clearing vgprs\n");
>     >> +                goto disp_failed;
>     >> +        }
>     >> +
>     >> +disp_failed:
>     >> +        amdgpu_ib_free(adev, &disp_ib, NULL);
>     >> +        dma_fence_put(fence);
>     >> +pro_end:
>     >> +        amdgpu_ib_free(adev, &wb_ib, NULL);
>     >> +
>     >> +        if (r)
>     >> +                dev_info(adev->dev, "Init VGPRS Failed\n");
>     >> +        else
>     >> +                dev_info(adev->dev, "Init VGPRS Successfully\n");
>     >> +
>     >> +        return r;
>     >> +}
>     >> +
>     >> +int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device 
> *adev) {
>     >> +        /* only support when RAS is enabled */
>     >> +        if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
>     >> +                return 0;
>     >> +
>     >> + gfx_v9_4_2_do_sgprs_init(adev);
>     >> +
>     >> + gfx_v9_4_2_do_vgprs_init(adev);
>     >> +
>     >> +        return 0;
>     >> +}
>     >> +
>     >>    static void gfx_v9_4_2_query_sq_timeout_status(struct 
> amdgpu_device
>     >> *adev);  static void gfx_v9_4_2_reset_sq_timeout_status(struct
>     >> amdgpu_device *adev);
>     >>
>     >> @@ -479,8 +710,6 @@ void 
> gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
>     >>                            die_id);
>     >>                   break;
>     >>           }
>     >> -
>     >> -        return;
>     >>    }
>     >>
>     >>    void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device 
> *adev,
>     >> --
>     >> 2.17.1
>     >> _______________________________________________
>     >> amd-gfx mailing list
>     >> amd-gfx@lists.freedesktop.org
>     >> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist>
>     >> 
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CHa
>     >> 
> wking.Zhang%40amd.com%7C615b0281a59c45e99e1d08d9098f7581%7C3dd8961fe48
>     >> 
> 84e608e11a82d994e183d%7C0%7C0%7C637551334037259365%7CUnknown%7CTWFpbGZ
>     >> 
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>     >> 
> D%7C1000&amp;sdata=9lyDS%2Bf7Cr6gWK7Jw6o2LEXbmqHuYDYutOPWge2sAkM%3D&am
>     >> p;reserved=0
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Coak.zeng%40amd.com%7C34d3cfb6c4ee4969da4e08d909917e2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551342771006509%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8lNVazYDVOl3ASEqHC%2BxLoWBX%2FKh36SpxWtBnHqfVsY%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Coak.zeng%40amd.com%7C34d3cfb6c4ee4969da4e08d909917e2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551342771006509%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8lNVazYDVOl3ASEqHC%2BxLoWBX%2FKh36SpxWtBnHqfVsY%3D&amp;reserved=0>
>


--------------EFBFFAC420D69CA6AA4F70F1
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Mhm, I fear we at least need to comment the binary or otherwise we
    have a source code license violation here.<br>
    <br>
    The only alternative is to have it as a firmware binary externally.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 27.04.21 um 22:21 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB4488EB63FD9E79897959201FF7419@MN2PR12MB4488.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;"
        align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          I mean, we wrote it in binary since they were so small.  I
          don't remember how the newer ones for vega20 and Arcturus we
          generated.<br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Zeng, Oak <a class="moz-txt-link-rfc2396E" href="mailto:Oak.Zeng@amd.com">&lt;Oak.Zeng@amd.com&gt;</a><br>
            <b>Sent:</b> Tuesday, April 27, 2021 4:08 PM<br>
            <b>To:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Zhang, Hawking
            <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>; Li, Dennis
            <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Kuehling, Felix
            <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: fix no full coverage
            issue for gprs initialization</font>
          <div> </div>
        </div>
        <style>@font-face
	{font-family:"Cambria Math"}@font-face
	{font-family:DengXian}@font-face
	{font-family:Calibri}@font-face
	{}@font-face
	{}p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}span.x_EmailStyle19
	{font-family:"Calibri",sans-serif;
	color:windowtext}.x_MsoChpDefault
	{font-size:10.0pt}div.x_WordSection1
	{}</style>
        <div link="blue" vlink="purple" style="word-wrap:break-word"
          lang="EN-CA">
          <div class="x_WordSection1">
            <p class="x_MsoNormal">Yes in that case, we can check in the
              hand writing assembly codes.</p>
            <p class="x_MsoNormal"> </p>
            <div>
              <div>
                <div>
                  <p class="x_MsoNormal">Regards,</p>
                  <p class="x_MsoNormal">Oak </p>
                </div>
              </div>
            </div>
            <p class="x_MsoNormal"> </p>
            <p class="x_MsoNormal"> </p>
            <div style="border:none; border-top:solid #B5C4DF 1.0pt;
              padding:3.0pt 0cm 0cm 0cm">
              <p class="x_MsoNormal" style="margin-left:36.0pt"><b><span
                    style="font-size:12.0pt; color:black">From:
                  </span></b><span style="font-size:12.0pt; color:black">"Deucher,
                  Alexander" <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                  <b>Date: </b>Tuesday, April 27, 2021 at 4:06 PM<br>
                  <b>To: </b>Oak Zeng <a class="moz-txt-link-rfc2396E" href="mailto:Oak.Zeng@amd.com">&lt;Oak.Zeng@amd.com&gt;</a>,
                  "Koenig, Christian" <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>,
                  "Zhang, Hawking" <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>,
                  Christian König
                  <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>, "Li, Dennis"
                  <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>,
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">"amd-gfx@lists.freedesktop.org"</a>
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>, "Kuehling,
                  Felix" <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
                  <b>Subject: </b>Re: [PATCH] drm/amdgpu: fix no full
                  coverage issue for gprs initialization</span></p>
            </div>
            <div>
              <p class="x_MsoNormal" style="margin-left:36.0pt"> </p>
            </div>
            <p style="margin-right:5.0pt; margin-bottom:5.0pt;
              margin-left:41.0pt"><span
                style="font-family:&quot;Arial&quot;,sans-serif;
                color:#0078D7">[AMD Official Use Only - Internal
                Distribution Only]</span></p>
            <p class="x_MsoNormal" style="margin-left:36.0pt"> </p>
            <div>
              <div>
                <p class="x_MsoNormal" style="margin-left:36.0pt"><span
                    style="font-size:12.0pt; color:black">That would
                    probably be helpful.  TBH, I think we hand wrote the
                    original one for CZ so there was no original higher
                    level source code.</span></p>
              </div>
              <div>
                <p class="x_MsoNormal" style="margin-left:36.0pt"><span
                    style="font-size:12.0pt; color:black"> </span></p>
              </div>
              <div>
                <p class="x_MsoNormal" style="margin-left:36.0pt"><span
                    style="font-size:12.0pt; color:black">Alex</span></p>
              </div>
              <div>
                <p class="x_MsoNormal" style="margin-left:36.0pt"><span
                    style="font-size:12.0pt; color:black"> </span></p>
              </div>
              <div class="x_MsoNormal" style="margin-left:36.0pt;
                text-align:center" align="center">
                <hr width="100%" size="0" align="center">
              </div>
              <div id="x_divRplyFwdMsg">
                <p class="x_MsoNormal" style="margin-left:36.0pt"><b><span
                      style="color:black">From:</span></b><span
                    style="color:black"> Zeng, Oak
                    <a class="moz-txt-link-rfc2396E" href="mailto:Oak.Zeng@amd.com">&lt;Oak.Zeng@amd.com&gt;</a><br>
                    <b>Sent:</b> Tuesday, April 27, 2021 3:34 PM<br>
                    <b>To:</b> Koenig, Christian
                    <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Zhang, Hawking
                    <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Christian König
                    <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>; Li, Dennis
                    <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
                    <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deucher,
                    Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
                    Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: fix no full
                    coverage issue for gprs initialization</span>
                </p>
                <div>
                  <p class="x_MsoNormal" style="margin-left:36.0pt"> </p>
                </div>
              </div>
              <div>
                <div>
                  <p class="x_MsoNormal" style="margin-right:0cm;
                    margin-bottom:12.0pt; margin-left:36.0pt">
                    Hi Dennis,<br>
                    <br>
                    Should we check in the compute shader source codes?
                    I only saw the shader binaries. This will be helpful
                    if people want to modify those shaders/fix issues.
                    The source code can be in a comment section above
                    the binary.<br>
                    <br>
                    Regards,<br>
                    Oak <br>
                    <br>
                     <br>
                    <br>
                    On 2021-04-27, 11:31 AM, "amd-gfx on behalf of
                    Christian König"
                    <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.orgonbehalfofchristian.koenig@amd.com">&lt;amd-gfx-bounces@lists.freedesktop.org on behalf
                    of christian.koenig@amd.com&gt;</a> wrote:<br>
                    <br>
                        Ok in this case looks good to me.<br>
                    <br>
                        Christian.<br>
                    <br>
                        Am 27.04.21 um 17:26 schrieb Zhang, Hawking:<br>
                        &gt; [AMD Public Use]<br>
                        &gt;<br>
                        &gt; This need to be done during reset as well.<br>
                        &gt;<br>
                        &gt; Regards,<br>
                        &gt; Hawking<br>
                        &gt;<br>
                        &gt; -----Original Message-----<br>
                        &gt; From: Christian König
                    <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                        &gt; Sent: Tuesday, April 27, 2021 23:17<br>
                        &gt; To: Zhang, Hawking
                    <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Li, Dennis
                    <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
                    <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
                    <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Koenig, Christian
                    <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
                        &gt; Subject: Re: [PATCH] drm/amdgpu: fix no
                    full coverage issue for gprs initialization<br>
                        &gt;<br>
                        &gt; This is only done during bootup, isn't it?<br>
                        &gt;<br>
                        &gt; Wouldn't it be better to use the normal IB
                    pool instead of the direct one? Or do we also need
                    to do this during GPU reset?<br>
                        &gt;<br>
                        &gt; Regards,<br>
                        &gt; Christian.<br>
                        &gt;<br>
                        &gt; Am 27.04.21 um 16:55 schrieb Zhang,
                    Hawking:<br>
                        &gt;&gt; [AMD Public Use]<br>
                        &gt;&gt;<br>
                        &gt;&gt; Please split the following into another
                    patch when you commit the one.<br>
                        &gt;&gt; Other than that, the patch is<br>
                        &gt;&gt;<br>
                        &gt;&gt; Reviewed-by: Hawking Zhang
                    <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                        &gt;&gt;<br>
                        &gt;&gt; Regards,<br>
                        &gt;&gt; Hawking<br>
                        &gt;&gt;<br>
                        &gt;&gt; @@ -479,8 +710,6 @@ void
                    gfx_v9_4_2_init_golden_registers(struct
                    amdgpu_device *adev,<br>
                        &gt;&gt;                            die_id);<br>
                        &gt;&gt;                   break;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt; -<br>
                        &gt;&gt; -        return;<br>
                        &gt;&gt;    }<br>
                        &gt;&gt;<br>
                        &gt;&gt; -----Original Message-----<br>
                        &gt;&gt; From: Dennis Li
                    <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a><br>
                        &gt;&gt; Sent: Tuesday, April 27, 2021 22:38<br>
                        &gt;&gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>;
                    Deucher, Alexander<br>
                        &gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
                    Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>;<br>
                        &gt;&gt; Zhang, Hawking
                    <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Koenig, Christian<br>
                        &gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
                        &gt;&gt; Cc: Li, Dennis
                    <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a><br>
                        &gt;&gt; Subject: [PATCH] drm/amdgpu: fix no
                    full coverage issue for gprs<br>
                        &gt;&gt; initialization<br>
                        &gt;&gt;<br>
                        &gt;&gt; The number of waves is changed to 8, so
                    it is impossible to use old solution to cover all
                    sgprs.<br>
                        &gt;&gt;<br>
                        &gt;&gt; Signed-off-by: Dennis Li
                    <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a><br>
                        &gt;&gt;<br>
                        &gt;&gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                        &gt;&gt;
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                        &gt;&gt; index a2fe2dac32c1..2e6789a7dc46 100644<br>
                        &gt;&gt; ---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                        &gt;&gt; +++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
                        &gt;&gt; @@ -328,7 +328,7 @@ int
                    amdgpu_ib_pool_init(struct amdgpu_device<br>
                        &gt;&gt; *adev)<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           for (i = 0; i &lt;
                    AMDGPU_IB_POOL_MAX; i++) {<br>
                        &gt;&gt;                   if (i ==
                    AMDGPU_IB_POOL_DIRECT)<br>
                        &gt;&gt; -                        size =
                    PAGE_SIZE * 2;<br>
                        &gt;&gt; +                        size =
                    PAGE_SIZE * 6;<br>
                        &gt;&gt;                   else<br>
                        &gt;&gt;                           size =
                    AMDGPU_IB_POOL_SIZE;<br>
                        &gt;&gt;    <br>
                        &gt;&gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<br>
                        &gt;&gt;
                    b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<br>
                        &gt;&gt; index d17e57dea178..77948c033c45 100644<br>
                        &gt;&gt; ---
                    a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<br>
                        &gt;&gt; +++
                    b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<br>
                        &gt;&gt; @@ -32,6 +32,11 @@<br>
                        &gt;&gt;    #include "amdgpu_ras.h"<br>
                        &gt;&gt;    #include "amdgpu_gfx.h"<br>
                        &gt;&gt;    <br>
                        &gt;&gt; +#define SE_ID_MAX 8<br>
                        &gt;&gt; +#define CU_ID_MAX 16<br>
                        &gt;&gt; +#define SIMD_ID_MAX 4<br>
                        &gt;&gt; +#define WAVE_ID_MAX 10<br>
                        &gt;&gt; +<br>
                        &gt;&gt;    enum gfx_v9_4_2_utc_type {<br>
                        &gt;&gt;           VML2_MEM,<br>
                        &gt;&gt;           VML2_WALKER_MEM,<br>
                        &gt;&gt; @@ -81,100 +86,100 @@ static const
                    struct soc15_reg_golden<br>
                        &gt;&gt; golden_settings_gc_9_4_2_alde[] = {  };<br>
                        &gt;&gt;    <br>
                        &gt;&gt;    static const u32
                    vgpr_init_compute_shader_aldebaran[] = {<br>
                        &gt;&gt; -        0xb8840904, 0xb8851a04,
                    0xb8861344, 0x9207c006, 0x92088405, 0x81070807,<br>
                        &gt;&gt; -        0x81070407, 0x8e078207,
                    0xbe88008f, 0xc0410200, 0x00000007, 0xd3d94000,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94001,
                    0x18000080, 0xd3d94002, 0x18000080, 0xd3d94003,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94004,
                    0x18000080, 0xd3d94005, 0x18000080, 0xd3d94006,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94007,
                    0x18000080, 0xd3d94008, 0x18000080, 0xd3d94009,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9400a,
                    0x18000080, 0xd3d9400b, 0x18000080, 0xd3d9400c,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9400d,
                    0x18000080, 0xd3d9400e, 0x18000080, 0xd3d9400f,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94010,
                    0x18000080, 0xd3d94011, 0x18000080, 0xd3d94012,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94013,
                    0x18000080, 0xd3d94014, 0x18000080, 0xd3d94015,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94016,
                    0x18000080, 0xd3d94017, 0x18000080, 0xd3d94018,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94019,
                    0x18000080, 0xd3d9401a, 0x18000080, 0xd3d9401b,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9401c,
                    0x18000080, 0xd3d9401d, 0x18000080, 0xd3d9401e,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9401f,
                    0x18000080, 0xd3d94020, 0x18000080, 0xd3d94021,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94022,
                    0x18000080, 0xd3d94023, 0x18000080, 0xd3d94024,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94025,
                    0x18000080, 0xd3d94026, 0x18000080, 0xd3d94027,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94028,
                    0x18000080, 0xd3d94029, 0x18000080, 0xd3d9402a,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9402b,
                    0x18000080, 0xd3d9402c, 0x18000080, 0xd3d9402d,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9402e,
                    0x18000080, 0xd3d9402f, 0x18000080, 0xd3d94030,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94031,
                    0x18000080, 0xd3d94032, 0x18000080, 0xd3d94033,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94034,
                    0x18000080, 0xd3d94035, 0x18000080, 0xd3d94036,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94037,
                    0x18000080, 0xd3d94038, 0x18000080, 0xd3d94039,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9403a,
                    0x18000080, 0xd3d9403b, 0x18000080, 0xd3d9403c,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9403d,
                    0x18000080, 0xd3d9403e, 0x18000080, 0xd3d9403f,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94040,
                    0x18000080, 0xd3d94041, 0x18000080, 0xd3d94042,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94043,
                    0x18000080, 0xd3d94044, 0x18000080, 0xd3d94045,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94046,
                    0x18000080, 0xd3d94047, 0x18000080, 0xd3d94048,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94049,
                    0x18000080, 0xd3d9404a, 0x18000080, 0xd3d9404b,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9404c,
                    0x18000080, 0xd3d9404d, 0x18000080, 0xd3d9404e,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9404f,
                    0x18000080, 0xd3d94050, 0x18000080, 0xd3d94051,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94052,
                    0x18000080, 0xd3d94053, 0x18000080, 0xd3d94054,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94055,
                    0x18000080, 0xd3d94056, 0x18000080, 0xd3d94057,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94058,
                    0x18000080, 0xd3d94059, 0x18000080, 0xd3d9405a,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9405b,
                    0x18000080, 0xd3d9405c, 0x18000080, 0xd3d9405d,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9405e,
                    0x18000080, 0xd3d9405f, 0x18000080, 0xd3d94060,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94061,
                    0x18000080, 0xd3d94062, 0x18000080, 0xd3d94063,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94064,
                    0x18000080, 0xd3d94065, 0x18000080, 0xd3d94066,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94067,
                    0x18000080, 0xd3d94068, 0x18000080, 0xd3d94069,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9406a,
                    0x18000080, 0xd3d9406b, 0x18000080, 0xd3d9406c,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9406d,
                    0x18000080, 0xd3d9406e, 0x18000080, 0xd3d9406f,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94070,
                    0x18000080, 0xd3d94071, 0x18000080, 0xd3d94072,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94073,
                    0x18000080, 0xd3d94074, 0x18000080, 0xd3d94075,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94076,
                    0x18000080, 0xd3d94077, 0x18000080, 0xd3d94078,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94079,
                    0x18000080, 0xd3d9407a, 0x18000080, 0xd3d9407b,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9407c,
                    0x18000080, 0xd3d9407d, 0x18000080, 0xd3d9407e,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9407f,
                    0x18000080, 0xd3d94080, 0x18000080, 0xd3d94081,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94082,
                    0x18000080, 0xd3d94083, 0x18000080, 0xd3d94084,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94085,
                    0x18000080, 0xd3d94086, 0x18000080, 0xd3d94087,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94088,
                    0x18000080, 0xd3d94089, 0x18000080, 0xd3d9408a,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9408b,
                    0x18000080, 0xd3d9408c, 0x18000080, 0xd3d9408d,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9408e,
                    0x18000080, 0xd3d9408f, 0x18000080, 0xd3d94090,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94091,
                    0x18000080, 0xd3d94092, 0x18000080, 0xd3d94093,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94094,
                    0x18000080, 0xd3d94095, 0x18000080, 0xd3d94096,<br>
                        &gt;&gt; -        0x18000080, 0xd3d94097,
                    0x18000080, 0xd3d94098, 0x18000080, 0xd3d94099,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9409a,
                    0x18000080, 0xd3d9409b, 0x18000080, 0xd3d9409c,<br>
                        &gt;&gt; -        0x18000080, 0xd3d9409d,
                    0x18000080, 0xd3d9409e, 0x18000080, 0xd3d9409f,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940a0,
                    0x18000080, 0xd3d940a1, 0x18000080, 0xd3d940a2,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940a3,
                    0x18000080, 0xd3d940a4, 0x18000080, 0xd3d940a5,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940a6,
                    0x18000080, 0xd3d940a7, 0x18000080, 0xd3d940a8,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940a9,
                    0x18000080, 0xd3d940aa, 0x18000080, 0xd3d940ab,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940ac,
                    0x18000080, 0xd3d940ad, 0x18000080, 0xd3d940ae,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940af,
                    0x18000080, 0xd3d940b0, 0x18000080, 0xd3d940b1,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940b2,
                    0x18000080, 0xd3d940b3, 0x18000080, 0xd3d940b4,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940b5,
                    0x18000080, 0xd3d940b6, 0x18000080, 0xd3d940b7,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940b8,
                    0x18000080, 0xd3d940b9, 0x18000080, 0xd3d940ba,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940bb,
                    0x18000080, 0xd3d940bc, 0x18000080, 0xd3d940bd,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940be,
                    0x18000080, 0xd3d940bf, 0x18000080, 0xd3d940c0,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940c1,
                    0x18000080, 0xd3d940c2, 0x18000080, 0xd3d940c3,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940c4,
                    0x18000080, 0xd3d940c5, 0x18000080, 0xd3d940c6,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940c7,
                    0x18000080, 0xd3d940c8, 0x18000080, 0xd3d940c9,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940ca,
                    0x18000080, 0xd3d940cb, 0x18000080, 0xd3d940cc,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940cd,
                    0x18000080, 0xd3d940ce, 0x18000080, 0xd3d940cf,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940d0,
                    0x18000080, 0xd3d940d1, 0x18000080, 0xd3d940d2,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940d3,
                    0x18000080, 0xd3d940d4, 0x18000080, 0xd3d940d5,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940d6,
                    0x18000080, 0xd3d940d7, 0x18000080, 0xd3d940d8,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940d9,
                    0x18000080, 0xd3d940da, 0x18000080, 0xd3d940db,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940dc,
                    0x18000080, 0xd3d940dd, 0x18000080, 0xd3d940de,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940df,
                    0x18000080, 0xd3d940e0, 0x18000080, 0xd3d940e1,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940e2,
                    0x18000080, 0xd3d940e3, 0x18000080, 0xd3d940e4,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940e5,
                    0x18000080, 0xd3d940e6, 0x18000080, 0xd3d940e7,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940e8,
                    0x18000080, 0xd3d940e9, 0x18000080, 0xd3d940ea,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940eb,
                    0x18000080, 0xd3d940ec, 0x18000080, 0xd3d940ed,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940ee,
                    0x18000080, 0xd3d940ef, 0x18000080, 0xd3d940f0,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940f1,
                    0x18000080, 0xd3d940f2, 0x18000080, 0xd3d940f3,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940f4,
                    0x18000080, 0xd3d940f5, 0x18000080, 0xd3d940f6,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940f7,
                    0x18000080, 0xd3d940f8, 0x18000080, 0xd3d940f9,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940fa,
                    0x18000080, 0xd3d940fb, 0x18000080, 0xd3d940fc,<br>
                        &gt;&gt; -        0x18000080, 0xd3d940fd,
                    0x18000080, 0xd3d940fe, 0x18000080, 0xd3d940ff,<br>
                        &gt;&gt; -        0x18000080, 0xb07c0000,
                    0xbe8a00ff, 0x000000f8, 0xbf11080a, 0x7e000280,<br>
                        &gt;&gt; -        0x7e020280, 0x7e040280,
                    0x7e060280, 0x7e080280, 0x7e0a0280, 0x7e0c0280,<br>
                        &gt;&gt; -        0x7e0e0280, 0x808a880a,
                    0xbe80320a, 0xbf84fff5, 0xbf9c0000, 0xd28c0001,<br>
                        &gt;&gt; -        0x0001007f, 0xd28d0001,
                    0x0002027e, 0x10020288, 0xb88b0904, 0xb78b4000,<br>
                        &gt;&gt; -        0xd1196a01, 0x00001701,
                    0xbe8a0087, 0xbefc00c1, 0xd89c4000, 0x00020201,<br>
                        &gt;&gt; -        0xd89cc080, 0x00040401,
                    0x320202ff, 0x00000800, 0x808a810a, 0xbf84fff8,<br>
                        &gt;&gt; -        0xbf810000,<br>
                        &gt;&gt; +        0xb8840904, 0xb8851a04,
                    0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,<br>
                        &gt;&gt; +        0x9209a805, 0x920a8a04,
                    0x81080908, 0x81080a08, 0x81080308, 0x8e078208,<br>
                        &gt;&gt; +        0x81078407, 0xc0410080,
                    0x00000007, 0xbf8c0000, 0xd3d94000, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94001, 0x18000080,
                    0xd3d94002, 0x18000080, 0xd3d94003, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94004, 0x18000080,
                    0xd3d94005, 0x18000080, 0xd3d94006, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94007, 0x18000080,
                    0xd3d94008, 0x18000080, 0xd3d94009, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9400a, 0x18000080,
                    0xd3d9400b, 0x18000080, 0xd3d9400c, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9400d, 0x18000080,
                    0xd3d9400e, 0x18000080, 0xd3d9400f, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94010, 0x18000080,
                    0xd3d94011, 0x18000080, 0xd3d94012, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94013, 0x18000080,
                    0xd3d94014, 0x18000080, 0xd3d94015, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94016, 0x18000080,
                    0xd3d94017, 0x18000080, 0xd3d94018, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94019, 0x18000080,
                    0xd3d9401a, 0x18000080, 0xd3d9401b, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9401c, 0x18000080,
                    0xd3d9401d, 0x18000080, 0xd3d9401e, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9401f, 0x18000080,
                    0xd3d94020, 0x18000080, 0xd3d94021, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94022, 0x18000080,
                    0xd3d94023, 0x18000080, 0xd3d94024, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94025, 0x18000080,
                    0xd3d94026, 0x18000080, 0xd3d94027, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94028, 0x18000080,
                    0xd3d94029, 0x18000080, 0xd3d9402a, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9402b, 0x18000080,
                    0xd3d9402c, 0x18000080, 0xd3d9402d, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9402e, 0x18000080,
                    0xd3d9402f, 0x18000080, 0xd3d94030, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94031, 0x18000080,
                    0xd3d94032, 0x18000080, 0xd3d94033, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94034, 0x18000080,
                    0xd3d94035, 0x18000080, 0xd3d94036, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94037, 0x18000080,
                    0xd3d94038, 0x18000080, 0xd3d94039, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9403a, 0x18000080,
                    0xd3d9403b, 0x18000080, 0xd3d9403c, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9403d, 0x18000080,
                    0xd3d9403e, 0x18000080, 0xd3d9403f, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94040, 0x18000080,
                    0xd3d94041, 0x18000080, 0xd3d94042, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94043, 0x18000080,
                    0xd3d94044, 0x18000080, 0xd3d94045, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94046, 0x18000080,
                    0xd3d94047, 0x18000080, 0xd3d94048, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94049, 0x18000080,
                    0xd3d9404a, 0x18000080, 0xd3d9404b, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9404c, 0x18000080,
                    0xd3d9404d, 0x18000080, 0xd3d9404e, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9404f, 0x18000080,
                    0xd3d94050, 0x18000080, 0xd3d94051, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94052, 0x18000080,
                    0xd3d94053, 0x18000080, 0xd3d94054, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94055, 0x18000080,
                    0xd3d94056, 0x18000080, 0xd3d94057, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94058, 0x18000080,
                    0xd3d94059, 0x18000080, 0xd3d9405a, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9405b, 0x18000080,
                    0xd3d9405c, 0x18000080, 0xd3d9405d, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9405e, 0x18000080,
                    0xd3d9405f, 0x18000080, 0xd3d94060, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94061, 0x18000080,
                    0xd3d94062, 0x18000080, 0xd3d94063, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94064, 0x18000080,
                    0xd3d94065, 0x18000080, 0xd3d94066, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94067, 0x18000080,
                    0xd3d94068, 0x18000080, 0xd3d94069, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9406a, 0x18000080,
                    0xd3d9406b, 0x18000080, 0xd3d9406c, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9406d, 0x18000080,
                    0xd3d9406e, 0x18000080, 0xd3d9406f, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94070, 0x18000080,
                    0xd3d94071, 0x18000080, 0xd3d94072, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94073, 0x18000080,
                    0xd3d94074, 0x18000080, 0xd3d94075, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94076, 0x18000080,
                    0xd3d94077, 0x18000080, 0xd3d94078, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94079, 0x18000080,
                    0xd3d9407a, 0x18000080, 0xd3d9407b, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9407c, 0x18000080,
                    0xd3d9407d, 0x18000080, 0xd3d9407e, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9407f, 0x18000080,
                    0xd3d94080, 0x18000080, 0xd3d94081, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94082, 0x18000080,
                    0xd3d94083, 0x18000080, 0xd3d94084, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94085, 0x18000080,
                    0xd3d94086, 0x18000080, 0xd3d94087, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94088, 0x18000080,
                    0xd3d94089, 0x18000080, 0xd3d9408a, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9408b, 0x18000080,
                    0xd3d9408c, 0x18000080, 0xd3d9408d, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9408e, 0x18000080,
                    0xd3d9408f, 0x18000080, 0xd3d94090, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94091, 0x18000080,
                    0xd3d94092, 0x18000080, 0xd3d94093, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94094, 0x18000080,
                    0xd3d94095, 0x18000080, 0xd3d94096, 0x18000080,<br>
                        &gt;&gt; +        0xd3d94097, 0x18000080,
                    0xd3d94098, 0x18000080, 0xd3d94099, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9409a, 0x18000080,
                    0xd3d9409b, 0x18000080, 0xd3d9409c, 0x18000080,<br>
                        &gt;&gt; +        0xd3d9409d, 0x18000080,
                    0xd3d9409e, 0x18000080, 0xd3d9409f, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940a0, 0x18000080,
                    0xd3d940a1, 0x18000080, 0xd3d940a2, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940a3, 0x18000080,
                    0xd3d940a4, 0x18000080, 0xd3d940a5, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940a6, 0x18000080,
                    0xd3d940a7, 0x18000080, 0xd3d940a8, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940a9, 0x18000080,
                    0xd3d940aa, 0x18000080, 0xd3d940ab, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940ac, 0x18000080,
                    0xd3d940ad, 0x18000080, 0xd3d940ae, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940af, 0x18000080,
                    0xd3d940b0, 0x18000080, 0xd3d940b1, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940b2, 0x18000080,
                    0xd3d940b3, 0x18000080, 0xd3d940b4, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940b5, 0x18000080,
                    0xd3d940b6, 0x18000080, 0xd3d940b7, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940b8, 0x18000080,
                    0xd3d940b9, 0x18000080, 0xd3d940ba, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940bb, 0x18000080,
                    0xd3d940bc, 0x18000080, 0xd3d940bd, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940be, 0x18000080,
                    0xd3d940bf, 0x18000080, 0xd3d940c0, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940c1, 0x18000080,
                    0xd3d940c2, 0x18000080, 0xd3d940c3, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940c4, 0x18000080,
                    0xd3d940c5, 0x18000080, 0xd3d940c6, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940c7, 0x18000080,
                    0xd3d940c8, 0x18000080, 0xd3d940c9, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940ca, 0x18000080,
                    0xd3d940cb, 0x18000080, 0xd3d940cc, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940cd, 0x18000080,
                    0xd3d940ce, 0x18000080, 0xd3d940cf, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940d0, 0x18000080,
                    0xd3d940d1, 0x18000080, 0xd3d940d2, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940d3, 0x18000080,
                    0xd3d940d4, 0x18000080, 0xd3d940d5, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940d6, 0x18000080,
                    0xd3d940d7, 0x18000080, 0xd3d940d8, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940d9, 0x18000080,
                    0xd3d940da, 0x18000080, 0xd3d940db, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940dc, 0x18000080,
                    0xd3d940dd, 0x18000080, 0xd3d940de, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940df, 0x18000080,
                    0xd3d940e0, 0x18000080, 0xd3d940e1, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940e2, 0x18000080,
                    0xd3d940e3, 0x18000080, 0xd3d940e4, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940e5, 0x18000080,
                    0xd3d940e6, 0x18000080, 0xd3d940e7, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940e8, 0x18000080,
                    0xd3d940e9, 0x18000080, 0xd3d940ea, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940eb, 0x18000080,
                    0xd3d940ec, 0x18000080, 0xd3d940ed, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940ee, 0x18000080,
                    0xd3d940ef, 0x18000080, 0xd3d940f0, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940f1, 0x18000080,
                    0xd3d940f2, 0x18000080, 0xd3d940f3, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940f4, 0x18000080,
                    0xd3d940f5, 0x18000080, 0xd3d940f6, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940f7, 0x18000080,
                    0xd3d940f8, 0x18000080, 0xd3d940f9, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940fa, 0x18000080,
                    0xd3d940fb, 0x18000080, 0xd3d940fc, 0x18000080,<br>
                        &gt;&gt; +        0xd3d940fd, 0x18000080,
                    0xd3d940fe, 0x18000080, 0xd3d940ff, 0x18000080,<br>
                        &gt;&gt; +        0xb07c0000, 0xbe8a00ff,
                    0x000000f8, 0xbf11080a, 0x7e000280, 0x7e020280,<br>
                        &gt;&gt; +        0x7e040280, 0x7e060280,
                    0x7e080280, 0x7e0a0280, 0x7e0c0280, 0x7e0e0280,<br>
                        &gt;&gt; +        0x808a880a, 0xbe80320a,
                    0xbf84fff5, 0xbf9c0000, 0xd28c0001, 0x0001007f,<br>
                        &gt;&gt; +        0xd28d0001, 0x0002027e,
                    0x10020288, 0xbe8b0004, 0xb78b4000, 0xd1196a01,<br>
                        &gt;&gt; +        0x00001701, 0xbe8a0087,
                    0xbefc00c1, 0xd89c4000, 0x00020201, 0xd89cc080,<br>
                        &gt;&gt; +        0x00040401, 0x320202ff,
                    0x00000800, 0x808a810a, 0xbf84fff8,<br>
                        &gt;&gt; +0xbf810000,<br>
                        &gt;&gt;    };<br>
                        &gt;&gt;    <br>
                        &gt;&gt;    const struct soc15_reg_entry
                    vgpr_init_regs_aldebaran[] = { @@ -183,7 +188,7 @@
                    const struct soc15_reg_entry
                    vgpr_init_regs_aldebaran[] = {<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Y), 4 },<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Z), 1 },<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC1), 0xbf },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC2), 0x400004 },  /* 64KB LDS */<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC2), 0x400006 },  /* 64KB<br>
                        &gt;&gt; +LDS */<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset
                    = 256 */<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff }, @@
                    -195,262 +200,488 @@ const struct soc15_reg_entry
                    vgpr_init_regs_aldebaran[] = {<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE7),<br>
                        &gt;&gt; 0xffffffff },  };<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -static const u32
                    sgpr_init_compute_shader_aldebaran[] = {<br>
                        &gt;&gt; -        0xb8840904, 0xb8851a04,
                    0xb8861344, 0x9207c006, 0x92088405, 0x81070807,<br>
                        &gt;&gt; -        0x81070407, 0x8e078207,
                    0xbefc0006, 0xbf800000, 0xbf900001, 0xbe88008f,<br>
                        &gt;&gt; -        0xc0410200, 0x00000007,
                    0xb07c0000, 0xbe8000ff, 0x0000005f, 0xbee50080,<br>
                        &gt;&gt; -        0xbe812c65, 0xbe822c65,
                    0xbe832c65, 0xbe842c65, 0xbe852c65, 0xb77c0005,<br>
                        &gt;&gt; -        0x80808500, 0xbf84fff8,
                    0xbe800080, 0xbf810000,<br>
                        &gt;&gt; +static const u32
                    sgpr112_init_compute_shader_aldebaran[] = {<br>
                        &gt;&gt; +        0xb8840904, 0xb8851a04,
                    0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,<br>
                        &gt;&gt; +        0x9209a805, 0x920a8a04,
                    0x81080908, 0x81080a08, 0x81080308, 0x8e078208,<br>
                        &gt;&gt; +        0x81078407, 0xc0410080,
                    0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,<br>
                        &gt;&gt; +        0x00000000, 0xbf8c0000,
                    0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,<br>
                        &gt;&gt; +        0xc0410080, 0x00000007,
                    0xbf8c0000, 0xbefc0080, 0xbe880080, 0xbe890080,<br>
                        &gt;&gt; +        0xbe8a0080, 0xbe8b0080,
                    0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080,<br>
                        &gt;&gt; +        0xbe900080, 0xbe910080,
                    0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080,<br>
                        &gt;&gt; +        0xbe960080, 0xbe970080,
                    0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080,<br>
                        &gt;&gt; +        0xbe9c0080, 0xbe9d0080,
                    0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080,<br>
                        &gt;&gt; +        0xbea20080, 0xbea30080,
                    0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080,<br>
                        &gt;&gt; +        0xbea80080, 0xbea90080,
                    0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080,<br>
                        &gt;&gt; +        0xbeae0080, 0xbeaf0080,
                    0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080,<br>
                        &gt;&gt; +        0xbeb40080, 0xbeb50080,
                    0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080,<br>
                        &gt;&gt; +        0xbeba0080, 0xbebb0080,
                    0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080,<br>
                        &gt;&gt; +        0xbec00080, 0xbec10080,
                    0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080,<br>
                        &gt;&gt; +        0xbec60080, 0xbec70080,
                    0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080,<br>
                        &gt;&gt; +        0xbecc0080, 0xbecd0080,
                    0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080,<br>
                        &gt;&gt; +        0xbed20080, 0xbed30080,
                    0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080,<br>
                        &gt;&gt; +        0xbed80080, 0xbed90080,
                    0xbeda0080, 0xbedb0080, 0xbedc0080, 0xbedd0080,<br>
                        &gt;&gt; +        0xbede0080, 0xbedf0080,
                    0xbee00080, 0xbee10080, 0xbee20080, 0xbee30080,<br>
                        &gt;&gt; +        0xbee40080, 0xbee50080,
                    0xbf810000<br>
                        &gt;&gt;    };<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -static const struct soc15_reg_entry
                    sgpr1_init_regs_aldebaran[] = {<br>
                        &gt;&gt; +const struct soc15_reg_entry
                    sgpr112_init_regs_aldebaran[] = {<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_X), 0x40 },<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Y), 8 },<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Z), 1 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC1), 0x240 }, /* (80 GPRS):
                    SGPRS[9:6] VGPRS[5:0] */<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC2), 0x4 }, /* USER_SGPR[5:1]*/<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset
                    = 256 */<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x000000ff },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x000000ff },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x000000ff },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x000000ff },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x000000ff },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x000000ff },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x000000ff },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x000000ff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC1), 0x2c0 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC2), 0x6 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC3), 0x0 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE7),<br>
                        &gt;&gt; +0xffffffff }, };<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +static const u32
                    sgpr96_init_compute_shader_aldebaran[] = {<br>
                        &gt;&gt; +        0xb8840904, 0xb8851a04,
                    0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,<br>
                        &gt;&gt; +        0x9209a805, 0x920a8a04,
                    0x81080908, 0x81080a08, 0x81080308, 0x8e078208,<br>
                        &gt;&gt; +        0x81078407, 0xc0410080,
                    0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,<br>
                        &gt;&gt; +        0x00000000, 0xbf8c0000,
                    0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,<br>
                        &gt;&gt; +        0xc0410080, 0x00000007,
                    0xbf8c0000, 0xbefc0080, 0xbe880080, 0xbe890080,<br>
                        &gt;&gt; +        0xbe8a0080, 0xbe8b0080,
                    0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080,<br>
                        &gt;&gt; +        0xbe900080, 0xbe910080,
                    0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080,<br>
                        &gt;&gt; +        0xbe960080, 0xbe970080,
                    0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080,<br>
                        &gt;&gt; +        0xbe9c0080, 0xbe9d0080,
                    0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080,<br>
                        &gt;&gt; +        0xbea20080, 0xbea30080,
                    0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080,<br>
                        &gt;&gt; +        0xbea80080, 0xbea90080,
                    0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080,<br>
                        &gt;&gt; +        0xbeae0080, 0xbeaf0080,
                    0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080,<br>
                        &gt;&gt; +        0xbeb40080, 0xbeb50080,
                    0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080,<br>
                        &gt;&gt; +        0xbeba0080, 0xbebb0080,
                    0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080,<br>
                        &gt;&gt; +        0xbec00080, 0xbec10080,
                    0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080,<br>
                        &gt;&gt; +        0xbec60080, 0xbec70080,
                    0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080,<br>
                        &gt;&gt; +        0xbecc0080, 0xbecd0080,
                    0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080,<br>
                        &gt;&gt; +        0xbed20080, 0xbed30080,
                    0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080,<br>
                        &gt;&gt; +        0xbed80080, 0xbed90080,
                    0xbf810000,<br>
                        &gt;&gt;    };<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -static const struct soc15_reg_entry
                    sgpr2_init_regs_aldebaran[] = {<br>
                        &gt;&gt; +const struct soc15_reg_entry
                    sgpr96_init_regs_aldebaran[] = {<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_X), 0x40 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Y), 8 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Y), 0xc },<br>
                        &gt;&gt;           { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Z), 1 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC1), 0x240 }, /* (80 GPRS) */<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC2), 0x4 }, /* USER_SGPR[5:1]*/<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset
                    = 256 */<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x0000ff00 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x0000ff00 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x0000ff00 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x0000ff00 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x0000ff00 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x0000ff00 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x0000ff00 },<br>
                        &gt;&gt; -        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x0000ff00 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC1), 0x240 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC2), 0x6 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC3), 0x0 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE7),<br>
                        &gt;&gt; +0xffffffff },<br>
                        &gt;&gt;    };<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -static int
                    gfx_v9_4_2_check_gprs_init_coverage(struct
                    amdgpu_device *adev,<br>
                        &gt;&gt;
                    -                                              
                    uint32_t *wb)<br>
                        &gt;&gt; -{<br>
                        &gt;&gt; -        uint32_t se_id, cu_id,
                    simd_id;<br>
                        &gt;&gt; -        uint32_t simd_cnt = 0;<br>
                        &gt;&gt; -        uint32_t se_offset, cu_offset,
                    data;<br>
                        &gt;&gt; -<br>
                        &gt;&gt; -        for (se_id = 0; se_id &lt;
                    adev-&gt;gfx.config.max_shader_engines; se_id++) {<br>
                        &gt;&gt; -                se_offset = se_id * 16
                    * 4;<br>
                        &gt;&gt; -                for (cu_id = 0; cu_id
                    &lt; 16; cu_id++) {<br>
                        &gt;&gt; -                        cu_offset =
                    cu_id * 4;<br>
                        &gt;&gt; -                        for (simd_id =
                    0; simd_id &lt; 4; simd_id++) {<br>
                        &gt;&gt; -                                data =
                    wb[se_offset + cu_offset + simd_id];<br>
                        &gt;&gt; -                                if
                    (data == 0xF)<br>
                        &gt;&gt;
                    -                                        simd_cnt++;<br>
                        &gt;&gt; -                        }<br>
                        &gt;&gt; -                }<br>
                        &gt;&gt; -        }<br>
                        &gt;&gt; -<br>
                        &gt;&gt; -        if
                    (adev-&gt;gfx.cu_info.number * 4 == simd_cnt)<br>
                        &gt;&gt; -                return 0;<br>
                        &gt;&gt; -<br>
                        &gt;&gt; -        dev_warn(adev-&gt;dev, "SIMD
                    Count: %d, %d\n",<br>
                        &gt;&gt; -                
                    adev-&gt;gfx.cu_info.number * 4, simd_cnt);<br>
                        &gt;&gt; -<br>
                        &gt;&gt; -        for (se_id = 0; se_id &lt;
                    adev-&gt;gfx.config.max_shader_engines; se_id++) {<br>
                        &gt;&gt; -                se_offset = se_id * 16
                    * 4;<br>
                        &gt;&gt; -                for (cu_id = 0; cu_id
                    &lt; 16; cu_id++) {<br>
                        &gt;&gt; -                        cu_offset =
                    cu_id * 4;<br>
                        &gt;&gt; -                        for (simd_id =
                    0; simd_id &lt; 4; simd_id++) {<br>
                        &gt;&gt; -                                data =
                    wb[se_offset + cu_offset + simd_id];<br>
                        &gt;&gt; -                                if
                    (data != 0xF)<br>
                        &gt;&gt;
                    -                                       
                    dev_warn(adev-&gt;dev, "SE[%d]CU[%d]SIMD[%d]: isn't
                    inited\n",<br>
                        &gt;&gt;
                    -                                               
                    se_id, cu_id, simd_id);<br>
                        &gt;&gt; -                        }<br>
                        &gt;&gt; -                }<br>
                        &gt;&gt; -        }<br>
                        &gt;&gt; +static const u32
                    sgpr64_init_compute_shader_aldebaran[] = {<br>
                        &gt;&gt; +        0xb8840904, 0xb8851a04,
                    0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,<br>
                        &gt;&gt; +        0x9209a805, 0x920a8a04,
                    0x81080908, 0x81080a08, 0x81080308, 0x8e078208,<br>
                        &gt;&gt; +        0x81078407, 0xc0410080,
                    0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080,<br>
                        &gt;&gt; +        0xbe890080, 0xbe8a0080,
                    0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080,<br>
                        &gt;&gt; +        0xbe8f0080, 0xbe900080,
                    0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080,<br>
                        &gt;&gt; +        0xbe950080, 0xbe960080,
                    0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080,<br>
                        &gt;&gt; +        0xbe9b0080, 0xbe9c0080,
                    0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080,<br>
                        &gt;&gt; +        0xbea10080, 0xbea20080,
                    0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080,<br>
                        &gt;&gt; +        0xbea70080, 0xbea80080,
                    0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080,<br>
                        &gt;&gt; +        0xbead0080, 0xbeae0080,
                    0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080,<br>
                        &gt;&gt; +        0xbeb30080, 0xbeb40080,
                    0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080,<br>
                        &gt;&gt; +        0xbeb90080, 0xbf810000,<br>
                        &gt;&gt; +};<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        return -EFAULT;<br>
                        &gt;&gt; -}<br>
                        &gt;&gt; +const struct soc15_reg_entry
                    sgpr64_init_regs_aldebaran[] = {<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_X), 0x40 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Y), 0x10 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_NUM_THREAD_Z), 1 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC1), 0x1c0 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC2), 0x6 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_PGM_RSRC3), 0x0 },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },<br>
                        &gt;&gt; +        { SOC15_REG_ENTRY(GC, 0,
                    regCOMPUTE_STATIC_THREAD_MGMT_SE7),<br>
                        &gt;&gt; +0xffffffff }, };<br>
                        &gt;&gt;    <br>
                        &gt;&gt;    static int
                    gfx_v9_4_2_run_shader(struct amdgpu_device *adev,<br>
                        &gt;&gt; -                                 const
                    uint32_t *shader_ptr, uint32_t shader_size,<br>
                        &gt;&gt; -                                 const
                    struct soc15_reg_entry *init_regs, uint32_t
                    regs_size,<br>
                        &gt;&gt; -                                
                    uint32_t compute_dim_x, u64 wb_gpu_addr)<br>
                        &gt;&gt; +                                
                    struct amdgpu_ring *ring,<br>
                        &gt;&gt; +                                
                    struct amdgpu_ib *ib,<br>
                        &gt;&gt; +                                 const
                    u32 *shader_ptr, u32 shader_size,<br>
                        &gt;&gt; +                                 const
                    struct soc15_reg_entry *init_regs, u32 regs_size,<br>
                        &gt;&gt; +                                 u32
                    compute_dim_x, u64 wb_gpu_addr, u32 pattern,<br>
                        &gt;&gt; +                                
                    struct dma_fence **fence_ptr)<br>
                        &gt;&gt;    {<br>
                        &gt;&gt; -        struct amdgpu_ring *ring =
                    &amp;adev-&gt;gfx.compute_ring[0];<br>
                        &gt;&gt; -        struct amdgpu_ib ib;<br>
                        &gt;&gt; -        struct dma_fence *f = NULL;<br>
                        &gt;&gt;           int r, i;<br>
                        &gt;&gt;           uint32_t total_size,
                    shader_offset;<br>
                        &gt;&gt;           u64 gpu_addr;<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        total_size = (regs_size * 3 +
                    4 + 4 + 5 + 2) * 4;<br>
                        &gt;&gt; +        total_size = (regs_size * 3 +
                    4 + 5 + 5) * 4;<br>
                        &gt;&gt;           total_size =
                    ALIGN(total_size, 256);<br>
                        &gt;&gt;           shader_offset = total_size;<br>
                        &gt;&gt;           total_size +=
                    ALIGN(shader_size, 256);<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           /* allocate an indirect
                    buffer to put the commands in */<br>
                        &gt;&gt; -        memset(&amp;ib, 0,
                    sizeof(ib));<br>
                        &gt;&gt; +        memset(ib, 0, sizeof(*ib));<br>
                        &gt;&gt;           r = amdgpu_ib_get(adev, NULL,
                    total_size,<br>
                        &gt;&gt;
                    -                                       
                    AMDGPU_IB_POOL_DIRECT, &amp;ib);<br>
                        &gt;&gt;
                    +                                       
                    AMDGPU_IB_POOL_DIRECT, ib);<br>
                        &gt;&gt;           if (r) {<br>
                        &gt;&gt; -                DRM_ERROR("amdgpu:
                    failed to get ib (%d).\n", r);<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "failed to get ib (%d).\n", r);<br>
                        &gt;&gt;                   return r;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           /* load the compute shaders
                    */<br>
                        &gt;&gt;           for (i = 0; i &lt;
                    shader_size/sizeof(u32); i++)<br>
                        &gt;&gt; -                ib.ptr[i +
                    (shader_offset / 4)] = shader_ptr[i];<br>
                        &gt;&gt; +                ib-&gt;ptr[i +
                    (shader_offset / 4)] = shader_ptr[i];<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           /* init the ib length to 0 */<br>
                        &gt;&gt; -        ib.length_dw = 0;<br>
                        &gt;&gt; +        ib-&gt;length_dw = 0;<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           /* write the register state
                    for the compute dispatch */<br>
                        &gt;&gt;           for (i = 0; i &lt; regs_size;
                    i++) {<br>
                        &gt;&gt; -                ib.ptr[ib.length_dw++]
                    = PACKET3(PACKET3_SET_SH_REG, 1);<br>
                        &gt;&gt; -                ib.ptr[ib.length_dw++]
                    = SOC15_REG_ENTRY_OFFSET(init_regs[i])<br>
                        &gt;&gt; +               
                    ib-&gt;ptr[ib-&gt;length_dw++] =
                    PACKET3(PACKET3_SET_SH_REG, 1);<br>
                        &gt;&gt; +               
                    ib-&gt;ptr[ib-&gt;length_dw++] =
                    SOC15_REG_ENTRY_OFFSET(init_regs[i])<br>
                       
&gt;&gt;                                                                  
                    - PACKET3_SET_SH_REG_START;<br>
                        &gt;&gt; -                ib.ptr[ib.length_dw++]
                    = init_regs[i].reg_value;<br>
                        &gt;&gt; +               
                    ib-&gt;ptr[ib-&gt;length_dw++] =
                    init_regs[i].reg_value;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           /* write the shader start
                    address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */<br>
                        &gt;&gt; -        gpu_addr = (ib.gpu_addr +
                    (u64)shader_offset) &gt;&gt; 8;<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    PACKET3(PACKET3_SET_SH_REG, 2);<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    SOC15_REG_OFFSET(GC, 0, regCOMPUTE_PGM_LO)<br>
                        &gt;&gt; +        gpu_addr = (ib-&gt;gpu_addr +
                    (u64)shader_offset) &gt;&gt; 8;<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = PACKET3(PACKET3_SET_SH_REG, 2);<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = SOC15_REG_OFFSET(GC, 0,<br>
                        &gt;&gt; +regCOMPUTE_PGM_LO)<br>
                       
                    &gt;&gt;                                                          
                    - PACKET3_SET_SH_REG_START;<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    lower_32_bits(gpu_addr);<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    upper_32_bits(gpu_addr);<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = lower_32_bits(gpu_addr);<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = upper_32_bits(gpu_addr);<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           /* write the wb buffer
                    address */<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    PACKET3(PACKET3_SET_SH_REG, 2);<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    SOC15_REG_OFFSET(GC, 0, regCOMPUTE_USER_DATA_0)<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = PACKET3(PACKET3_SET_SH_REG, 3);<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = SOC15_REG_OFFSET(GC, 0,<br>
                        &gt;&gt; +regCOMPUTE_USER_DATA_0)<br>
                       
                    &gt;&gt;                                                          
                    - PACKET3_SET_SH_REG_START;<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    lower_32_bits(wb_gpu_addr);<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    upper_32_bits(wb_gpu_addr);<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = lower_32_bits(wb_gpu_addr);<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = upper_32_bits(wb_gpu_addr);<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = pattern;<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           /* write dispatch packet */<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    PACKET3(PACKET3_DISPATCH_DIRECT, 3);<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    compute_dim_x; /* x */<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] = 1; /*
                    y */<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] = 1; /*
                    z */<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = PACKET3(PACKET3_DISPATCH_DIRECT, 3);<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = compute_dim_x; /* x */<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = 1; /* y */<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    = 1; /* z */<br>
                        &gt;&gt; +        ib-&gt;ptr[ib-&gt;length_dw++]
                    =<br>
                        &gt;&gt;                   REG_SET_FIELD(0,
                    COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN,<br>
                        &gt;&gt; 1);<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        /* write CS partial flush
                    packet */<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    PACKET3(PACKET3_EVENT_WRITE, 0);<br>
                        &gt;&gt; -        ib.ptr[ib.length_dw++] =
                    EVENT_TYPE(7) | EVENT_INDEX(4);<br>
                        &gt;&gt; -<br>
                        &gt;&gt;           /* shedule the ib on the ring
                    */<br>
                        &gt;&gt; -        r = amdgpu_ib_schedule(ring,
                    1, &amp;ib, NULL, &amp;f);<br>
                        &gt;&gt; +        r = amdgpu_ib_schedule(ring,
                    1, ib, NULL, fence_ptr);<br>
                        &gt;&gt;           if (r) {<br>
                        &gt;&gt; -                DRM_ERROR("amdgpu: ib
                    submit failed (%d).\n", r);<br>
                        &gt;&gt; -                goto fail;<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "ib submit failed (%d).\n", r);<br>
                        &gt;&gt; +                amdgpu_ib_free(adev,
                    ib, NULL);<br>
                        &gt;&gt;           }<br>
                        &gt;&gt; +        return r;<br>
                        &gt;&gt; +}<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        /* wait for the GPU to finish
                    processing the IB */<br>
                        &gt;&gt; -        r = dma_fence_wait(f, false);<br>
                        &gt;&gt; -        if (r) {<br>
                        &gt;&gt; -                DRM_ERROR("amdgpu:
                    fence wait failed (%d).\n", r);<br>
                        &gt;&gt; -                goto fail;<br>
                        &gt;&gt; +static void
                    gfx_v9_4_2_log_wave_assignment(struct amdgpu_device<br>
                        &gt;&gt; +*adev, uint32_t *wb_ptr) {<br>
                        &gt;&gt; +        uint32_t se, cu, simd, wave;<br>
                        &gt;&gt; +        uint32_t offset = 0;<br>
                        &gt;&gt; +        char *str;<br>
                        &gt;&gt; +        int size;<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        str = kmalloc(256,
                    GFP_KERNEL);<br>
                        &gt;&gt; +        if (!str)<br>
                        &gt;&gt; +                return;<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        dev_dbg(adev-&gt;dev, "wave
                    assignment:\n");<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        for (se = 0; se &lt;
                    adev-&gt;gfx.config.max_shader_engines; se++) {<br>
                        &gt;&gt; +                for (cu = 0; cu &lt;
                    CU_ID_MAX; cu++) {<br>
                        &gt;&gt; +                        memset(str, 0,
                    256);<br>
                        &gt;&gt; +                        size =
                    sprintf(str, "SE[%02d]CU[%02d]: ", se, cu);<br>
                        &gt;&gt; +                        for (simd = 0;
                    simd &lt; SIMD_ID_MAX; simd++) {<br>
                        &gt;&gt; +                                size
                    += sprintf(str + size, "[");<br>
                        &gt;&gt; +                                for
                    (wave = 0; wave &lt; WAVE_ID_MAX; wave++) {<br>
                        &gt;&gt;
                    +                                        size +=
                    sprintf(str + size, "%x", wb_ptr[offset]);<br>
                        &gt;&gt;
                    +                                        offset++;<br>
                        &gt;&gt; +                                }<br>
                        &gt;&gt; +                                size
                    += sprintf(str + size, "]  ");<br>
                        &gt;&gt; +                        }<br>
                        &gt;&gt; +                       
                    dev_dbg(adev-&gt;dev, "%s\n", str);<br>
                        &gt;&gt; +                }<br>
                        &gt;&gt;           }<br>
                        &gt;&gt; -fail:<br>
                        &gt;&gt; -        amdgpu_ib_free(adev, &amp;ib,
                    NULL);<br>
                        &gt;&gt; -        dma_fence_put(f);<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        return r;<br>
                        &gt;&gt; +        kfree(str);<br>
                        &gt;&gt;    }<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -int
                    gfx_v9_4_2_do_edc_gpr_workarounds(struct
                    amdgpu_device *adev)<br>
                        &gt;&gt; +static int
                    gfx_v9_4_2_wait_for_waves_assigned(struct
                    amdgpu_device *adev,<br>
                        &gt;&gt;
                    +                                             
                    uint32_t *wb_ptr, uint32_t mask,<br>
                        &gt;&gt;
                    +                                             
                    uint32_t pattern, uint32_t num_wave, bool wait)<br>
                        &gt;&gt;    {<br>
                        &gt;&gt; -        struct amdgpu_ring *ring =
                    &amp;adev-&gt;gfx.compute_ring[0];<br>
                        &gt;&gt; -        int r;<br>
                        &gt;&gt; -        int compute_dim_x =
                    adev-&gt;gfx.config.max_shader_engines *<br>
                        &gt;&gt; -                           
                    adev-&gt;gfx.config.max_cu_per_sh *<br>
                        &gt;&gt; -                           
                    adev-&gt;gfx.config.max_sh_per_se;<br>
                        &gt;&gt; -        int sgpr_work_group_size = 5;<br>
                        &gt;&gt; -        /* CU_ID: 0~15, SIMD_ID: 0~3
                    */<br>
                        &gt;&gt; -        int wb_size =
                    adev-&gt;gfx.config.max_shader_engines * 16 * 4;<br>
                        &gt;&gt; -        struct amdgpu_ib ib;<br>
                        &gt;&gt; +        uint32_t se, cu, simd, wave;<br>
                        &gt;&gt; +        uint32_t loop = 0;<br>
                        &gt;&gt; +        uint32_t wave_cnt;<br>
                        &gt;&gt; +        uint32_t offset;<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        /* only support when RAS is
                    enabled */<br>
                        &gt;&gt; -        if
                    (!amdgpu_ras_is_supported(adev,
                    AMDGPU_RAS_BLOCK__GFX))<br>
                        &gt;&gt; -                return 0;<br>
                        &gt;&gt; +        do {<br>
                        &gt;&gt; +                wave_cnt = 0;<br>
                        &gt;&gt; +                offset = 0;<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +                for (se = 0; se &lt;
                    adev-&gt;gfx.config.max_shader_engines; se++)<br>
                        &gt;&gt; +                        for (cu = 0;
                    cu &lt; CU_ID_MAX; cu++)<br>
                        &gt;&gt; +                                for
                    (simd = 0; simd &lt; SIMD_ID_MAX; simd++)<br>
                        &gt;&gt;
                    +                                        for (wave =
                    0; wave &lt; WAVE_ID_MAX; wave++) {<br>
                        &gt;&gt;
                    +                                                if
                    (((1 &lt;&lt; wave) &amp; mask) &amp;&amp;<br>
                        &gt;&gt;
                    +                                                   
                    (wb_ptr[offset] == pattern))<br>
                        &gt;&gt;
                    +                                                       
                    wave_cnt++;<br>
                        &gt;&gt; +<br>
                        &gt;&gt;
                    +                                               
                    offset++;<br>
                        &gt;&gt;
                    +                                        }<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +                if (wave_cnt ==
                    num_wave)<br>
                        &gt;&gt; +                        return 0;<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +                mdelay(1);<br>
                        &gt;&gt; +        } while (++loop &lt; 2000
                    &amp;&amp; wait);<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        dev_err(adev-&gt;dev, "actual
                    wave num: %d, expected wave num: %d\n",<br>
                        &gt;&gt; +                wave_cnt, num_wave);<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +       
                    gfx_v9_4_2_log_wave_assignment(adev, wb_ptr);<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        return -EBADSLT;<br>
                        &gt;&gt; +}<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +static int
                    gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
                    {<br>
                        &gt;&gt; +        int r;<br>
                        &gt;&gt; +        int wb_size =
                    adev-&gt;gfx.config.max_shader_engines *<br>
                        &gt;&gt; +                         CU_ID_MAX *
                    SIMD_ID_MAX * WAVE_ID_MAX;<br>
                        &gt;&gt; +        struct amdgpu_ib wb_ib;<br>
                        &gt;&gt; +        struct amdgpu_ib disp_ibs[3];<br>
                        &gt;&gt; +        struct dma_fence *fences[3];<br>
                        &gt;&gt; +        u32 pattern[3] = { 0x1, 0x5,
                    0xa };<br>
                        &gt;&gt;    <br>
                        &gt;&gt;           /* bail if the compute ring
                    is not ready */<br>
                        &gt;&gt; -        if (!ring-&gt;sched.ready)<br>
                        &gt;&gt; +        if
                    (!adev-&gt;gfx.compute_ring[0].sched.ready ||<br>
                        &gt;&gt; +                
                    !adev-&gt;gfx.compute_ring[1].sched.ready)<br>
                        &gt;&gt;                   return 0;<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        /* allocate an indirect buffer
                    to put the commands in */<br>
                        &gt;&gt; -        memset(&amp;ib, 0,
                    sizeof(ib));<br>
                        &gt;&gt; -        r = amdgpu_ib_get(adev, NULL,
                    wb_size * sizeof(uint32_t),<br>
                        &gt;&gt; -                         
                    AMDGPU_IB_POOL_DIRECT, &amp;ib);<br>
                        &gt;&gt; +        /* allocate the write-back
                    buffer from IB */<br>
                        &gt;&gt; +        memset(&amp;wb_ib, 0,
                    sizeof(wb_ib));<br>
                        &gt;&gt; +        r = amdgpu_ib_get(adev, NULL,
                    (1 + wb_size) * sizeof(uint32_t),<br>
                        &gt;&gt; +                         
                    AMDGPU_IB_POOL_DIRECT, &amp;wb_ib);<br>
                        &gt;&gt;           if (r) {<br>
                        &gt;&gt; -                DRM_ERROR("amdgpu:
                    failed to get ib (%d).\n", r);<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "failed to get ib (%d) for wb\n", r);<br>
                        &gt;&gt;                   return r;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt; +        memset(wb_ib.ptr, 0, (1 +
                    wb_size) * sizeof(uint32_t));<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        r =
                    gfx_v9_4_2_run_shader(adev,<br>
                        &gt;&gt; +                       
                    &amp;adev-&gt;gfx.compute_ring[0],<br>
                        &gt;&gt; +                       
                    &amp;disp_ibs[0],<br>
                        &gt;&gt; +                       
                    sgpr112_init_compute_shader_aldebaran,<br>
                        &gt;&gt; +                       
                    sizeof(sgpr112_init_compute_shader_aldebaran),<br>
                        &gt;&gt; +                       
                    sgpr112_init_regs_aldebaran,<br>
                        &gt;&gt; +                       
                    ARRAY_SIZE(sgpr112_init_regs_aldebaran),<br>
                        &gt;&gt; +                       
                    adev-&gt;gfx.cu_info.number,<br>
                        &gt;&gt; +                       
                    wb_ib.gpu_addr, pattern[0], &amp;fences[0]);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "failed to clear first 224 sgprs\n");<br>
                        &gt;&gt; +                goto pro_end;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        memset(ib.ptr, 0, wb_size *
                    sizeof(uint32_t));<br>
                        &gt;&gt; -        r =
                    gfx_v9_4_2_run_shader(adev,
                    vgpr_init_compute_shader_aldebaran,<br>
                        &gt;&gt; -                                 
                    sizeof(vgpr_init_compute_shader_aldebaran),<br>
                        &gt;&gt; -                                 
                    vgpr_init_regs_aldebaran,<br>
                        &gt;&gt; -                                 
                    ARRAY_SIZE(vgpr_init_regs_aldebaran),<br>
                        &gt;&gt; -                                 
                    compute_dim_x * 2, ib.gpu_addr);<br>
                        &gt;&gt; +        r =
                    gfx_v9_4_2_wait_for_waves_assigned(adev,<br>
                        &gt;&gt; +                       
                    &amp;wb_ib.ptr[1], 0b11,<br>
                        &gt;&gt; +                        pattern[0],<br>
                        &gt;&gt; +                       
                    adev-&gt;gfx.cu_info.number * SIMD_ID_MAX * 2,<br>
                        &gt;&gt; +                        true);<br>
                        &gt;&gt;           if (r) {<br>
                        &gt;&gt; -                dev_err(adev-&gt;dev,
                    "Init VGPRS: failed to run shader\n");<br>
                        &gt;&gt; -                goto failed;<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "wave coverage failed when clear first 224
                    sgprs\n");<br>
                        &gt;&gt; +                wb_ib.ptr[0] =
                    0xdeadbeaf; /* stop waves */<br>
                        &gt;&gt; +                goto disp0_failed;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        r =
                    gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);<br>
                        &gt;&gt; +        r =
                    gfx_v9_4_2_run_shader(adev,<br>
                        &gt;&gt; +                       
                    &amp;adev-&gt;gfx.compute_ring[1],<br>
                        &gt;&gt; +                       
                    &amp;disp_ibs[1],<br>
                        &gt;&gt; +                       
                    sgpr96_init_compute_shader_aldebaran,<br>
                        &gt;&gt; +                       
                    sizeof(sgpr96_init_compute_shader_aldebaran),<br>
                        &gt;&gt; +                       
                    sgpr96_init_regs_aldebaran,<br>
                        &gt;&gt; +                       
                    ARRAY_SIZE(sgpr96_init_regs_aldebaran),<br>
                        &gt;&gt; +                       
                    adev-&gt;gfx.cu_info.number * 2,<br>
                        &gt;&gt; +                       
                    wb_ib.gpu_addr, pattern[1], &amp;fences[1]);<br>
                        &gt;&gt;           if (r) {<br>
                        &gt;&gt; -                dev_err(adev-&gt;dev,
                    "Init VGPRS: failed to cover all SIMDs\n");<br>
                        &gt;&gt; -                goto failed;<br>
                        &gt;&gt; -        } else {<br>
                        &gt;&gt; -                dev_info(adev-&gt;dev,
                    "Init VGPRS Successfully\n");<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "failed to clear next 576 sgprs\n");<br>
                        &gt;&gt; +                goto disp0_failed;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        r =
                    gfx_v9_4_2_wait_for_waves_assigned(adev,<br>
                        &gt;&gt; +                       
                    &amp;wb_ib.ptr[1], 0b11111100,<br>
                        &gt;&gt; +                        pattern[1],
                    adev-&gt;gfx.cu_info.number * SIMD_ID_MAX * 6,<br>
                        &gt;&gt; +                        true);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "wave coverage failed when clear first 576
                    sgprs\n");<br>
                        &gt;&gt; +                wb_ib.ptr[0] =
                    0xdeadbeaf; /* stop waves */<br>
                        &gt;&gt; +                goto disp1_failed;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        memset(ib.ptr, 0, wb_size *
                    sizeof(uint32_t));<br>
                        &gt;&gt; -        r =
                    gfx_v9_4_2_run_shader(adev,
                    sgpr_init_compute_shader_aldebaran,<br>
                        &gt;&gt; -                                 
                    sizeof(sgpr_init_compute_shader_aldebaran),<br>
                        &gt;&gt; -                                 
                    sgpr1_init_regs_aldebaran,<br>
                        &gt;&gt; -                                 
                    ARRAY_SIZE(sgpr1_init_regs_aldebaran),<br>
                        &gt;&gt; -                                 
                    compute_dim_x / 2 * sgpr_work_group_size,<br>
                        &gt;&gt; -                                 
                    ib.gpu_addr);<br>
                        &gt;&gt; +        wb_ib.ptr[0] = 0xdeadbeaf; /*
                    stop waves */<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        /* wait for the GPU to finish
                    processing the IB */<br>
                        &gt;&gt; +        r = dma_fence_wait(fences[0],
                    false);<br>
                        &gt;&gt;           if (r) {<br>
                        &gt;&gt; -                dev_err(adev-&gt;dev,
                    "Init SGPRS Part1: failed to run shader\n");<br>
                        &gt;&gt; -                goto failed;<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "timeout to clear first 224 sgprs\n");<br>
                        &gt;&gt; +                goto disp1_failed;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        r =
                    gfx_v9_4_2_run_shader(adev,
                    sgpr_init_compute_shader_aldebaran,<br>
                        &gt;&gt; -                                 
                    sizeof(sgpr_init_compute_shader_aldebaran),<br>
                        &gt;&gt; -                                 
                    sgpr2_init_regs_aldebaran,<br>
                        &gt;&gt; -                                 
                    ARRAY_SIZE(sgpr2_init_regs_aldebaran),<br>
                        &gt;&gt; -                                 
                    compute_dim_x / 2 * sgpr_work_group_size,<br>
                        &gt;&gt; -                                 
                    ib.gpu_addr);<br>
                        &gt;&gt; +        r = dma_fence_wait(fences[1],
                    false);<br>
                        &gt;&gt;           if (r) {<br>
                        &gt;&gt; -                dev_err(adev-&gt;dev,
                    "Init SGPRS Part2: failed to run shader\n");<br>
                        &gt;&gt; -                goto failed;<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "timeout to clear first 576 sgprs\n");<br>
                        &gt;&gt; +                goto disp1_failed;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -        r =
                    gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);<br>
                        &gt;&gt; +        memset(wb_ib.ptr, 0, (1 +
                    wb_size) * sizeof(uint32_t));<br>
                        &gt;&gt; +        r =
                    gfx_v9_4_2_run_shader(adev,<br>
                        &gt;&gt; +                       
                    &amp;adev-&gt;gfx.compute_ring[0],<br>
                        &gt;&gt; +                       
                    &amp;disp_ibs[2],<br>
                        &gt;&gt; +                       
                    sgpr64_init_compute_shader_aldebaran,<br>
                        &gt;&gt; +                       
                    sizeof(sgpr64_init_compute_shader_aldebaran),<br>
                        &gt;&gt; +                       
                    sgpr64_init_regs_aldebaran,<br>
                        &gt;&gt; +                       
                    ARRAY_SIZE(sgpr64_init_regs_aldebaran),<br>
                        &gt;&gt; +                       
                    adev-&gt;gfx.cu_info.number,<br>
                        &gt;&gt; +                       
                    wb_ib.gpu_addr, pattern[2], &amp;fences[2]);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "failed to clear first 256 sgprs\n");<br>
                        &gt;&gt; +                goto disp1_failed;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        r = dma_fence_wait(fences[2],
                    false);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "timeout to clear first 256 sgprs\n");<br>
                        &gt;&gt; +                goto disp2_failed;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        r =
                    gfx_v9_4_2_wait_for_waves_assigned(adev,<br>
                        &gt;&gt; +                       
                    &amp;wb_ib.ptr[1], 0b1111,<br>
                        &gt;&gt; +                        pattern[2],<br>
                        &gt;&gt; +                       
                    adev-&gt;gfx.cu_info.number * SIMD_ID_MAX * 4,<br>
                        &gt;&gt; +                        false);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "wave coverage failed when clear first 256
                    sgprs\n");<br>
                        &gt;&gt; +                goto disp2_failed;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +disp2_failed:<br>
                        &gt;&gt; +        amdgpu_ib_free(adev,
                    &amp;disp_ibs[2], NULL);<br>
                        &gt;&gt; +        dma_fence_put(fences[2]);<br>
                        &gt;&gt; +disp1_failed:<br>
                        &gt;&gt; +        amdgpu_ib_free(adev,
                    &amp;disp_ibs[1], NULL);<br>
                        &gt;&gt; +        dma_fence_put(fences[1]);<br>
                        &gt;&gt; +disp0_failed:<br>
                        &gt;&gt; +        amdgpu_ib_free(adev,
                    &amp;disp_ibs[0], NULL);<br>
                        &gt;&gt; +        dma_fence_put(fences[0]);<br>
                        &gt;&gt; +pro_end:<br>
                        &gt;&gt; +        amdgpu_ib_free(adev,
                    &amp;wb_ib, NULL);<br>
                        &gt;&gt; +<br>
                        &gt;&gt;           if (r)<br>
                        &gt;&gt; -                dev_err(adev-&gt;dev,<br>
                        &gt;&gt; -                        "Init SGPRS:
                    failed to cover all SIMDs\n");<br>
                        &gt;&gt; +                dev_info(adev-&gt;dev,
                    "Init SGPRS Failed\n");<br>
                        &gt;&gt;           else<br>
                        &gt;&gt;                  
                    dev_info(adev-&gt;dev, "Init SGPRS Successfully\n");<br>
                        &gt;&gt;    <br>
                        &gt;&gt; -failed:<br>
                        &gt;&gt; -        amdgpu_ib_free(adev, &amp;ib,
                    NULL);<br>
                        &gt;&gt;           return r;<br>
                        &gt;&gt;    }<br>
                        &gt;&gt;    <br>
                        &gt;&gt; +static int
                    gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
                    {<br>
                        &gt;&gt; +        int r;<br>
                        &gt;&gt; +        /* CU_ID: 0~15, SIMD_ID: 0~3,
                    WAVE_ID: 0 ~ 9 */<br>
                        &gt;&gt; +        int wb_size =
                    adev-&gt;gfx.config.max_shader_engines *<br>
                        &gt;&gt; +                         CU_ID_MAX *
                    SIMD_ID_MAX * WAVE_ID_MAX;<br>
                        &gt;&gt; +        struct amdgpu_ib wb_ib;<br>
                        &gt;&gt; +        struct amdgpu_ib disp_ib;<br>
                        &gt;&gt; +        struct dma_fence *fence;<br>
                        &gt;&gt; +        u32 pattern = 0xa;<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        /* bail if the compute ring is
                    not ready */<br>
                        &gt;&gt; +        if
                    (!adev-&gt;gfx.compute_ring[0].sched.ready)<br>
                        &gt;&gt; +                return 0;<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        /* allocate the write-back
                    buffer from IB */<br>
                        &gt;&gt; +        memset(&amp;wb_ib, 0,
                    sizeof(wb_ib));<br>
                        &gt;&gt; +        r = amdgpu_ib_get(adev, NULL,
                    (1 + wb_size) * sizeof(uint32_t),<br>
                        &gt;&gt; +                         
                    AMDGPU_IB_POOL_DIRECT, &amp;wb_ib);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "failed to get ib (%d) for wb.\n", r);<br>
                        &gt;&gt; +                return r;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt; +        memset(wb_ib.ptr, 0, (1 +
                    wb_size) * sizeof(uint32_t));<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        r =
                    gfx_v9_4_2_run_shader(adev,<br>
                        &gt;&gt; +                       
                    &amp;adev-&gt;gfx.compute_ring[0],<br>
                        &gt;&gt; +                        &amp;disp_ib,<br>
                        &gt;&gt; +                       
                    vgpr_init_compute_shader_aldebaran,<br>
                        &gt;&gt; +                       
                    sizeof(vgpr_init_compute_shader_aldebaran),<br>
                        &gt;&gt; +                       
                    vgpr_init_regs_aldebaran,<br>
                        &gt;&gt; +                       
                    ARRAY_SIZE(vgpr_init_regs_aldebaran),<br>
                        &gt;&gt; +                       
                    adev-&gt;gfx.cu_info.number,<br>
                        &gt;&gt; +                       
                    wb_ib.gpu_addr, pattern, &amp;fence);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "failed to clear vgprs\n");<br>
                        &gt;&gt; +                goto pro_end;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        /* wait for the GPU to finish
                    processing the IB */<br>
                        &gt;&gt; +        r = dma_fence_wait(fence,
                    false);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "timeout to clear vgprs\n");<br>
                        &gt;&gt; +                goto disp_failed;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        r =
                    gfx_v9_4_2_wait_for_waves_assigned(adev,<br>
                        &gt;&gt; +                       
                    &amp;wb_ib.ptr[1], 0b1,<br>
                        &gt;&gt; +                        pattern,<br>
                        &gt;&gt; +                       
                    adev-&gt;gfx.cu_info.number * SIMD_ID_MAX,<br>
                        &gt;&gt; +                        false);<br>
                        &gt;&gt; +        if (r) {<br>
                        &gt;&gt; +                dev_err(adev-&gt;dev,
                    "failed to cover all simds when clearing vgprs\n");<br>
                        &gt;&gt; +                goto disp_failed;<br>
                        &gt;&gt; +        }<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +disp_failed:<br>
                        &gt;&gt; +        amdgpu_ib_free(adev,
                    &amp;disp_ib, NULL);<br>
                        &gt;&gt; +        dma_fence_put(fence);<br>
                        &gt;&gt; +pro_end:<br>
                        &gt;&gt; +        amdgpu_ib_free(adev,
                    &amp;wb_ib, NULL);<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        if (r)<br>
                        &gt;&gt; +                dev_info(adev-&gt;dev,
                    "Init VGPRS Failed\n");<br>
                        &gt;&gt; +        else<br>
                        &gt;&gt; +                dev_info(adev-&gt;dev,
                    "Init VGPRS Successfully\n");<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        return r;<br>
                        &gt;&gt; +}<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +int
                    gfx_v9_4_2_do_edc_gpr_workarounds(struct
                    amdgpu_device *adev) {<br>
                        &gt;&gt; +        /* only support when RAS is
                    enabled */<br>
                        &gt;&gt; +        if
                    (!amdgpu_ras_is_supported(adev,
                    AMDGPU_RAS_BLOCK__GFX))<br>
                        &gt;&gt; +                return 0;<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +       
                    gfx_v9_4_2_do_sgprs_init(adev);<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +       
                    gfx_v9_4_2_do_vgprs_init(adev);<br>
                        &gt;&gt; +<br>
                        &gt;&gt; +        return 0;<br>
                        &gt;&gt; +}<br>
                        &gt;&gt; +<br>
                        &gt;&gt;    static void
                    gfx_v9_4_2_query_sq_timeout_status(struct
                    amdgpu_device<br>
                        &gt;&gt; *adev);  static void
                    gfx_v9_4_2_reset_sq_timeout_status(struct<br>
                        &gt;&gt; amdgpu_device *adev);<br>
                        &gt;&gt;    <br>
                        &gt;&gt; @@ -479,8 +710,6 @@ void
                    gfx_v9_4_2_init_golden_registers(struct
                    amdgpu_device *adev,<br>
                        &gt;&gt;                            die_id);<br>
                        &gt;&gt;                   break;<br>
                        &gt;&gt;           }<br>
                        &gt;&gt; -<br>
                        &gt;&gt; -        return;<br>
                        &gt;&gt;    }<br>
                        &gt;&gt;    <br>
                        &gt;&gt;    void
                    gfx_v9_4_2_debug_trap_config_init(struct
                    amdgpu_device *adev,<br>
                        &gt;&gt; --<br>
                        &gt;&gt; 2.17.1<br>
                        &gt;&gt;
                    _______________________________________________<br>
                        &gt;&gt; amd-gfx mailing list<br>
                        &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                        &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist"
                      moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist</a><br>
                        &gt;&gt;
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CHa<br>
                        &gt;&gt;
                    wking.Zhang%40amd.com%7C615b0281a59c45e99e1d08d9098f7581%7C3dd8961fe48<br>
                        &gt;&gt;
                    84e608e11a82d994e183d%7C0%7C0%7C637551334037259365%7CUnknown%7CTWFpbGZ<br>
                        &gt;&gt;
                    sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3<br>
                        &gt;&gt;
D%7C1000&amp;amp;sdata=9lyDS%2Bf7Cr6gWK7Jw6o2LEXbmqHuYDYutOPWge2sAkM%3D&amp;am<br>
                        &gt;&gt; p;reserved=0<br>
                    <br>
                        _______________________________________________<br>
                        amd-gfx mailing list<br>
                        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                        <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Coak.zeng%40amd.com%7C34d3cfb6c4ee4969da4e08d909917e2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551342771006509%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=8lNVazYDVOl3ASEqHC%2BxLoWBX%2FKh36SpxWtBnHqfVsY%3D&amp;amp;reserved=0"
                      moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Coak.zeng%40amd.com%7C34d3cfb6c4ee4969da4e08d909917e2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551342771006509%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=8lNVazYDVOl3ASEqHC%2BxLoWBX%2FKh36SpxWtBnHqfVsY%3D&amp;amp;reserved=0</a></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------EFBFFAC420D69CA6AA4F70F1--

--===============1754178432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1754178432==--
