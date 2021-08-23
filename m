Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FFAC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 14:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFE561372
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 14:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECFE561372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8457889DFE;
	Mon, 23 Aug 2021 14:24:44 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CF289F97
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 14:23:21 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id w6so10233886plg.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:user-agent:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=WtsUEsqMTxeu0ASY9ZGldGWSKXK/Bt2mBtS4t1K1jok=;
 b=Twno2VV6Mfpk9mFt1zef4nXG4k9+uk+hiqK3q7qn6xzeS8fqb9Sd0RsRYk+AW49Sup
 kwtvnA0rQxXUqxgPFcN5FFmZ1DHdc6mRIoougB08bPum5ctx5mGdYBLMBllI20ZQwywX
 GsosFTC7bkpcR7C+TuJ+4VIi+eYChTNMCf2uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
 :references:message-id:mime-version:content-transfer-encoding;
 bh=WtsUEsqMTxeu0ASY9ZGldGWSKXK/Bt2mBtS4t1K1jok=;
 b=aFrIt8ED46G5eQGSvGDJxnkd/PG/DgOBzC6NeG5z6mhoFzHourPySaM/q9wDTidBC+
 F0KL1j4xrhvDapkOfwRgMEwwS4RAC06xvfuBoCm0hHQaA6H2rawae6tB6uobmWGlo9lv
 nPacYaI+Zob5bYcdGTJtBdVGjSSQ98+a8MOMocei1hp7stEjkRaygqPecSfTk4Mg6Gtm
 QG3axdOCx+2oaxL/tj41YnDbm4Iznu5bD9y2Mltz/rv4OXTm+7UsXTG/TuBOfphSSCUs
 Bo2eQvLtyBpBhC4aBnk20vUD76+WOF6vxlc/2jW61scskOe/LuNrCpcPC/68z7erFPYQ
 2N8Q==
X-Gm-Message-State: AOAM530YE5Wzh2zS3a56Cci+0scB1+wOieWVEcI1wkLWDuuAC5lshIUn
 8Yx+BRmeFYQflBwe8QPT1GTQdA==
X-Google-Smtp-Source: ABdhPJyi22ur2sPI/DYF4luwUXxBY5gmZaV71bLC6h6PGLbA+cDZDfqrOe18jGG3kcfwjHp+QTWrPQ==
X-Received: by 2002:a17:90b:4b84:: with SMTP id
 lr4mr20672140pjb.32.1629728601332; 
 Mon, 23 Aug 2021 07:23:21 -0700 (PDT)
Received: from [127.0.0.1] ([67.219.225.50])
 by smtp.gmail.com with ESMTPSA id 10sm16158814pjc.41.2021.08.23.07.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 07:23:20 -0700 (PDT)
Date: Mon, 23 Aug 2021 07:23:14 -0700
From: Kees Cook <keescook@chromium.org>
To: =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
CC: "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Jiawei Gu <Jiawei.Gu@amd.com>, Evan Quan <evan.quan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Dennis Li <Dennis.Li@amd.com>, 
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 David M Nieto <David.Nieto@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Lee Jones <lee.jones@linaro.org>, John Clements <John.Clements@amd.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_drm/amd/pm=3A_And_destina?=
 =?US-ASCII?Q?tion_bounds_checking_to_struct_copy?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4922d89d-1293-7b32-d684-c731c246e6c1@amd.com>
References: <20210819201441.3545027-1-keescook@chromium.org>
 <4922d89d-1293-7b32-d684-c731c246e6c1@amd.com>
Message-ID: <FB2A077F-78CB-4D84-A8F2-C63C57923496@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Aug 2021 14:24:43 +0000
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



On August 22, 2021 11:28:54 PM PDT, "Christian K=C3=B6nig" <christian=2Eko=
enig@amd=2Ecom> wrote:
>
>
>Am 19=2E08=2E21 um 22:14 schrieb Kees Cook:
>> [=2E=2E=2E]
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh b/drivers/gpu/drm/am=
d/amdgpu/amdgpu=2Eh
>> index 96e895d6be35=2E=2E4605934a4fb7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh
>> @@ -1446,4 +1446,29 @@ static inline int amdgpu_in_reset(struct amdgpu_=
device *adev)
>>   {
>>   	return atomic_read(&adev->in_gpu_reset);
>>   }
>> +
>> +/**
>> + * memcpy_trailing - Copy the end of one structure into the middle of =
another
>> + *
>> + * @dst: Pointer to destination struct
>> + * @first_dst_member: The member name in @dst where the overwrite begi=
ns
>> + * @last_dst_member: The member name in @dst where the overwrite ends =
after
>> + * @src: Pointer to the source struct
>> + * @first_src_member: The member name in @src where the copy begins
>> + *
>> + */
>> +#define memcpy_trailing(dst, first_dst_member, last_dst_member,		   \
>> +		        src, first_src_member)				   \
>
>Please don't add a function like this into amdgpu=2Eh, especially when it=
=20
>is only used by the SMU code=2E

Sure, I'm happy to move it=2E It wasn't clear to me which headers were con=
sidered "immutable"=2E Which header should I put this in?

>And please give it an amdgpu_ prefix so that we are not confusing it=20
>with a core function=2E

Sure, I will include that=2E

>Apart from that looks good to me=2E

Thanks!

-Kees
