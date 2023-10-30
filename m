Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFAAC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 06:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F94310E20A;
	Mon, 30 Oct 2023 06:43:07 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD4A10E20A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 06:43:05 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507a0907896so5857053e87.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Oct 2023 23:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698648184; x=1699252984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eRH5vb++q4XGUBCTraXY3/Q/AZhSHutRW2P2MREhK7M=;
 b=HSuSqVH3xW0ips+PrqYYdD5QufySwmVzoa8ouSFS1ATLXD6o8GVhUGVn0ZUJk5oL9B
 zle+DeFr4/mUKXioPq76/8vy9q0i3d13NP5/07LmPUQKbR6JKWWebDZXx1qUHfiErLMU
 imNy+I9JVAOrGxWwVcP9+kHHnvHJuu1zGDd6EoAVaO9uEIZjDW+VU/3hWS7HI0DUoqJU
 YunX8TMBVGrrQ8u/2XmJ0tfErEiQmZKXu7WwB3uqDw3++k5OOhn+T44znRoRQuHiNZiY
 7duo1WWOVsOiilaaMwxv3i9XaQQn8VXAdkW+gVkofzl3EzIgiL6bQwxsQeGMYIzr7RoU
 DBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698648184; x=1699252984;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eRH5vb++q4XGUBCTraXY3/Q/AZhSHutRW2P2MREhK7M=;
 b=GoWlK7o+WOfABfcQJUWw/ECOTMP7maWpsyCKuCPDprBKMFIzZ6LA11zQtbLmWzRhUA
 7SQ2PXAy1b6nrBrThkydqj4yOusmueIXMKAZEG8+cBLLvxyfaxgXBIDSdRipeAHoUy+n
 DsaNVEddnvkC1OZq4Tcvdc+CiOO9hYS01sReTfwE11dE2EfeLL4++SpgM3ndU4jOiaCX
 HlpMhkBAvwzEXTAz3mv0uawyOJt3N5R/za9uhJ+1cIidL5PtttRRp2J3Z6ZGONKyXLJc
 MFMzr/WYryxRXLT0a7VL4/W2tnMHIbud39Pj73lQ31uYIGZpeADEYeOjD3CrYtKUVT5z
 uf4A==
X-Gm-Message-State: AOJu0YxOmSpwbvBQ1oDo83nS8mr4sdp7g5bdvTndhiJBoBK8dlXzJcYF
 oCBHRr4TBbPQq+18WPQlnBA=
X-Google-Smtp-Source: AGHT+IG8exV4a8jz2DD8C9Ri92Jbuqvx+dQv3kyttA9JWkztNRhNS4aldQA5Ia+op3h/GjlHQ5DAYA==
X-Received: by 2002:a19:381e:0:b0:503:5d8:da33 with SMTP id
 f30-20020a19381e000000b0050305d8da33mr5650443lfa.20.1698648183314; 
 Sun, 29 Oct 2023 23:43:03 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c314a00b003fe1fe56202sm8357063wmo.33.2023.10.29.23.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 23:43:02 -0700 (PDT)
Message-ID: <05301519-5598-4c3e-a7ff-4375421572b9@gmail.com>
Date: Mon, 30 Oct 2023 07:43:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fix UBSAN array-index-out-of-bounds for
 Powerplay headers
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231027204148.63090-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231027204148.63090-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 27.10.23 um 22:41 schrieb Alex Deucher:
> For pptable structs that use flexible array sizes, use flexible arrays.
>
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h |  4 ++--
>   .../amd/pm/powerplay/hwmgr/vega10_pptable.h   | 24 +++++++++----------
>   2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> index 9fcad69a9f34..2cf2a7b12623 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> @@ -367,7 +367,7 @@ typedef struct _ATOM_Tonga_VCE_State_Record {
>   typedef struct _ATOM_Tonga_VCE_State_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;
> -	ATOM_Tonga_VCE_State_Record entries[1];
> +	ATOM_Tonga_VCE_State_Record entries[];
>   } ATOM_Tonga_VCE_State_Table;
>   
>   typedef struct _ATOM_Tonga_PowerTune_Table {
> @@ -481,7 +481,7 @@ typedef struct _ATOM_Tonga_Hard_Limit_Record {
>   typedef struct _ATOM_Tonga_Hard_Limit_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;
> -	ATOM_Tonga_Hard_Limit_Record entries[1];
> +	ATOM_Tonga_Hard_Limit_Record entries[];
>   } ATOM_Tonga_Hard_Limit_Table;
>   
>   typedef struct _ATOM_Tonga_GPIO_Table {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> index 8b0590b834cc..de2926df5ed7 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> @@ -129,7 +129,7 @@ typedef struct _ATOM_Vega10_State {
>   typedef struct _ATOM_Vega10_State_Array {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries. */
> -	ATOM_Vega10_State states[1];                             /* Dynamically allocate entries. */
> +	ATOM_Vega10_State states[];                             /* Dynamically allocate entries. */
>   } ATOM_Vega10_State_Array;
>   
>   typedef struct _ATOM_Vega10_CLK_Dependency_Record {
> @@ -169,37 +169,37 @@ typedef struct _ATOM_Vega10_GFXCLK_Dependency_Table {
>   typedef struct _ATOM_Vega10_MCLK_Dependency_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;                                         /* Number of entries. */
> -    ATOM_Vega10_MCLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +    ATOM_Vega10_MCLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_MCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_SOCCLK_Dependency_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;                                         /* Number of entries. */
> -    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_SOCCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_DCEFCLK_Dependency_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;                                         /* Number of entries. */
> -    ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +    ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_DCEFCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_PIXCLK_Dependency_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries. */
> -	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_PIXCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_DISPCLK_Dependency_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries.*/
> -	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_DISPCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_PHYCLK_Dependency_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries. */
> -	ATOM_Vega10_CLK_Dependency_Record entries[1];            /* Dynamically allocate entries. */
> +	ATOM_Vega10_CLK_Dependency_Record entries[];            /* Dynamically allocate entries. */
>   } ATOM_Vega10_PHYCLK_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_MM_Dependency_Record {
> @@ -213,7 +213,7 @@ typedef struct _ATOM_Vega10_MM_Dependency_Record {
>   typedef struct _ATOM_Vega10_MM_Dependency_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                         /* Number of entries */
> -	ATOM_Vega10_MM_Dependency_Record entries[1];             /* Dynamically allocate entries */
> +	ATOM_Vega10_MM_Dependency_Record entries[];             /* Dynamically allocate entries */
>   } ATOM_Vega10_MM_Dependency_Table;
>   
>   typedef struct _ATOM_Vega10_PCIE_Record {
> @@ -225,7 +225,7 @@ typedef struct _ATOM_Vega10_PCIE_Record {
>   typedef struct _ATOM_Vega10_PCIE_Table {
>   	UCHAR  ucRevId;
>   	UCHAR  ucNumEntries;                                        /* Number of entries */
> -	ATOM_Vega10_PCIE_Record entries[1];                      /* Dynamically allocate entries. */
> +	ATOM_Vega10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
>   } ATOM_Vega10_PCIE_Table;
>   
>   typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
> @@ -235,7 +235,7 @@ typedef struct _ATOM_Vega10_Voltage_Lookup_Record {
>   typedef struct _ATOM_Vega10_Voltage_Lookup_Table {
>   	UCHAR ucRevId;
>   	UCHAR ucNumEntries;                                          /* Number of entries */
> -	ATOM_Vega10_Voltage_Lookup_Record entries[1];             /* Dynamically allocate entries */
> +	ATOM_Vega10_Voltage_Lookup_Record entries[];             /* Dynamically allocate entries */
>   } ATOM_Vega10_Voltage_Lookup_Table;
>   
>   typedef struct _ATOM_Vega10_Fan_Table {
> @@ -327,7 +327,7 @@ typedef struct _ATOM_Vega10_VCE_State_Record {
>   typedef struct _ATOM_Vega10_VCE_State_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;
> -    ATOM_Vega10_VCE_State_Record entries[1];
> +    ATOM_Vega10_VCE_State_Record entries[];
>   } ATOM_Vega10_VCE_State_Table;
>   
>   typedef struct _ATOM_Vega10_PowerTune_Table {
> @@ -427,7 +427,7 @@ typedef struct _ATOM_Vega10_Hard_Limit_Record {
>   typedef struct _ATOM_Vega10_Hard_Limit_Table {
>       UCHAR ucRevId;
>       UCHAR ucNumEntries;
> -    ATOM_Vega10_Hard_Limit_Record entries[1];
> +    ATOM_Vega10_Hard_Limit_Record entries[];
>   } ATOM_Vega10_Hard_Limit_Table;
>   
>   typedef struct _Vega10_PPTable_Generic_SubTable_Header {

