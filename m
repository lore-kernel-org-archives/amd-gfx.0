Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90E4C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 19:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C3110E766;
	Tue, 21 Mar 2023 19:51:58 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FDC10E766
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 19:51:56 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-17aeb49429eso17050226fac.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679428316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1Fd+VzjoaAuqwz3j7jKBOuHXkThuMJzHWGEYXDg5hw=;
 b=N5tKs7V5iUoVZRL66qfFJi99dC/kWYERPmPGz/CBYyrn5YUP1rv5Tj5yBYaq6KpwkX
 qzxXXFVdjkFV6UMPSikW6yX5wAo4jrGYw0/+WhfaQqZVTX6Ad/XaU8yeEXBBImtS16nQ
 jKBdusfc5VK4ukgZoreX7rMWh1apcgknhDook36sv1Ab7WJL7ZY0P0iPER08lb9HWC8T
 CVL1CrKf0x0sjtRsPx4bCXUuQn+WbvIIl4010wHai5tNF92oA4yQI4rBT6ASzZ3gmk9F
 4/LDNwcD6zWxZn5PqMDAXJtpsR6DMYyQSr2OarbmwxBc2QARdjGPAVLSBMGwpmDZuZ++
 C6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679428316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1Fd+VzjoaAuqwz3j7jKBOuHXkThuMJzHWGEYXDg5hw=;
 b=silNlG6j73xWUsH/F6J444uluBe9KSMEvqyQvrMdMJn8VsoR9B+XrNGMmPa8PsbWux
 WszbKSBxm9zzDKINNNjsp0KSXyD4C+1PLZHsGZGFe9a0iv082R7ubr3X68V0L8s0XH7a
 ZZTReWS5DDN2MZ6Ulfb4+yjXB1i7cY/As4LjC3zCMvmuZfUbX7hby9SMFF0wDaWjhzee
 Smr8ScCbHuZ3IZyiibvgmqt0Hkvw2xChkFOqRDKmg/mHxIhS7j53NNKV9yfFzrPlpdnU
 vcy+U7SGuBEpHdnTPjB9Wcl0tdyCnquN1i6W7YZ7suK54RKu1aSjtkuMh4wvFJUaC58D
 qpUA==
X-Gm-Message-State: AO0yUKWI3Ab7z9dD4L93r5uzp+y9BYBBqqYg3hsnXYlhX9NrEWDg/Q/Q
 cifBsiSIWZnUJcjWlkHdxcLBY4nP0o9XaIjnq4M=
X-Google-Smtp-Source: AK7set9qVMEB0eiXhkW3yxM8xHkR1DAeOLlb1S4to00jRWoZwXAgr5kkLwOM9fEtbg/L3zX7wOtPT9X/V26x5LX/Rlk=
X-Received: by 2002:a05:6871:4905:b0:177:9150:e7ba with SMTP id
 tw5-20020a056871490500b001779150e7bamr57971oab.3.1679428316043; Tue, 21 Mar
 2023 12:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-8-alexander.deucher@amd.com>
 <CAAxE2A4oPbDtZfCg=PQhT8Et_KN2Wrs0Dz7jiLv-raeH2u9AEQ@mail.gmail.com>
In-Reply-To: <CAAxE2A4oPbDtZfCg=PQhT8Et_KN2Wrs0Dz7jiLv-raeH2u9AEQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Mar 2023 15:51:44 -0400
Message-ID: <CADnq5_N+KZrpaPL8=N+70r6dtwZywC5WmEO00a_1jEBTCmA5zg@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 20, 2023 at 8:30=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
>
> On Mon, Mar 20, 2023 at 1:38=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
>>
>> Add UAPI to query the GFX shadow buffer requirements
>> for preemption on GFX11.  UMDs need to specify the shadow
>> areas for preemption.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm=
.h
>> index 3d9474af6566..19a806145371 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>         #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
>>         /* Subquery id: Encode */
>>         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
>> +#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE         0x22
>>
>>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
>> @@ -1203,6 +1204,15 @@ struct drm_amdgpu_info_video_caps {
>>         struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_V=
IDEO_CAPS_CODEC_IDX_COUNT];
>>  };
>>
>> +struct drm_amdgpu_info_cp_gfx_shadow_size {
>> +       __u32 shadow_size;
>> +       __u32 shadow_alignment;
>> +       __u32 csa_size;
>> +       __u32 csa_alignment;
>> +       __u32 gds_size;
>> +       __u32 gds_alignment;
>
>
> Can you document the fields? What is CSA? Also, why is GDS there when the=
 hw deprecated it and replaced it with GDS registers?

Will add documentation.  For reference:
CSA (Context Save Area) - used as a scratch area for FW for saving
various things
Shadow - stores the pipeline state
GDS backup - stores the GDS state used by the pipeline.  I'm not sure
if this is registers or the old GDS memory.  Presumably the former.

Alex

>
> Thanks,
> Marek
