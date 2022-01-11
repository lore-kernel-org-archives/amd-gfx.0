Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413B3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 11:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFD710ECF1;
	Tue, 11 Jan 2022 11:00:43 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050::465:202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD3F10ECF1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 11:00:42 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:2:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4JY75h4YqtzQjwq;
 Tue, 11 Jan 2022 12:00:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1641898838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/dKDvOg4KUY8qPYHfKynCydh1EVjvwgL1FE0FLMPuY=;
 b=cC8AQDHjlWy4/lqn/EK2msE0w75pHnXOMvPHGz/87cGpBqFouoShiP9uPrpELkX2uGTvBt
 Ya5G52QGFnC6XLX1zdJPSKhDr0NXbrez+m3BSk/KpDJP2q893CXSb8h99fnSimEiEAe9RV
 N/MupruTR8+ww6n0Ni29AnmjpL9U3D0vDkurd/RCCJg+out57AnE3Tav8OOAv009p8Skmg
 R+zrQNedKY1fEYmKYtcHPbyDGp8MwMZ0HiX0ENVTDkKopxZCPoImPiy6v1/K5ZD5kYngfW
 38yCRhlzrb0F7AHhUnBquBxXBAO1q5JGTh6M5Hr3be5RWNu6L4N7XNa9uP0+/Q==
Message-ID: <bead9711-fe1f-730c-0daf-7e5f4fb533a4@mailbox.org>
Date: Tue, 11 Jan 2022 12:00:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Treat warning as an error
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
References: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
 <20220110233906.1178021-2-Rodrigo.Siqueira@amd.com>
 <3bfd4b1f-effb-e16f-8282-628fe2e6089b@mailbox.org>
In-Reply-To: <3bfd4b1f-effb-e16f-8282-628fe2e6089b@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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
Cc: nicholas.choi@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-01-11 11:41, Michel Dänzer wrote:
> On 2022-01-11 00:39, Rodrigo Siqueira wrote:
>> We have one internal CI that builds our kernel with the -Werror flag; as
>> a result, when we try to sync our branch with amd-staging-drm-next we
>> get some failures due to warnings. This commit tries to alleviate this
>> problem by forcing a warning to be treated as an error.
>>
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 7fedbb725e17..158f427c2f2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -27,6 +27,8 @@ FULL_AMD_PATH=$(srctree)/$(src)/..
>>  DISPLAY_FOLDER_NAME=display
>>  FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>>  
>> +subdir-ccflags-y += -Werror
> 
> The problem with this is that different compilers, or even different versions of the same compiler, can generate different warnings for the same code. So this will definitely result in some people hitting compile failures for no reason other than using a different compiler (version) than the code had been tested with.

A corollary of this is that your internal CI might still hit compile failures due to warnings, if its compiler (version) is sufficiently different from those used by the critical path of maintainers for merging amdgpu changes.

Since that CI cannot prevent merging of changes with warnings, it cannot enable -Werror without risking this.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
