Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C16C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jan 2022 19:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFB489EA3;
	Mon,  3 Jan 2022 19:52:20 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9A689EA3
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jan 2022 19:52:18 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4JSRGp3DvczF4kL;
 Mon,  3 Jan 2022 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1641239538; bh=EfrkGhdQlkHeuAMxA07G7DaywJutN3mdA8VtDmqNn4k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Kxnv+AnDEGxi/Kgbbr2lh24UjMIZAbSuAPgkZYMNvz8MzJKiE3Lc57VFVBMQoQgoN
 sR1AChTcxy1rUQgnmz3l9mFrMQ6jNqNuNRBIvUd6bEk83ykgAAPxoVQ5RYeaAHkLbZ
 k+isGFhJpGiwpAFvT8TbaQj37dvg+BkASzsb3i2c=
X-Riseup-User-ID: 21C8187EBDC80E7B76BF5EE3C931DC2151EDB3DC15F1A6697255CAEF1503A386
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4JSRGn68ptz1yT2;
 Mon,  3 Jan 2022 11:52:17 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 03 Jan 2022 11:52:17 -0800
From: Isabella Basso <isabbasso@riseup.net>
To: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: move calcs folder into DML
In-Reply-To: <BY5PR12MB42117515E3411EFF7F6602B6FB7E9@BY5PR12MB4211.namprd12.prod.outlook.com>
References: <20211220232047.1327228-1-isabbasso@riseup.net>
 <8cd2132a5242a15f48628dc993110fc2@riseup.net>
 <BY5PR12MB42117515E3411EFF7F6602B6FB7E9@BY5PR12MB4211.namprd12.prod.outlook.com>
Message-ID: <9b6f3b8e65326fde5b1166559d578030@riseup.net>
Organization: =?UTF-8?Q?Universidade_de_S=C3=A3o_Paulo_-_USP?=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, mwen@igalia.com, ~lkcamp/patches@lists.sr.ht,
 daniel@ffwll.ch, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello, Jasdeep,

On 2021-12-23 17:44, Dhillon, Jasdeep wrote:
> [AMD Official Use Only]
> 
>  Hi Isabbasso,  
> 
>  The patch fails to compile when there is No DCN because the calc
> object files fail to generate since dml depends on the
> CONFIG_DRM_AMD_DC_DCN being enabled (Makefile inside dc folder): 
> 
>  ifdef CONFIG_DRM_AMD_DC_DCN 
> DC_LIBS += dcn20 
> DC_LIBS += dsc 
> DC_LIBS += dcn10 dml 
> DC_LIBS += dcn21 
> DC_LIBS += dcn30 
> DC_LIBS += dcn301 
> DC_LIBS += dcn302 
> DC_LIBS += dcn303 endif
> 
>  A few changes need to be made to the patch, which are: 
> 
>  -The Makefile in dc needs the line: DC_LIBS+= dml/calcs 
>  -the Makefile in the calcs folder that the patch deletes can be
> placed inside of dc/dml/calcs instead of adding it to the Makefiles in
> dc/dml  
> 

Siqueira had warned me of this issue just before you emailed me, so I'd
already
prepared a v3 with no calcs Makefile but actually using the dml one for
everything, as it's pretty much set up for working with or without the
DRM_AMD_DC_DCN config turned on. Would this be alright, or would you
rather
have it as you suggested?

From what I tested locally both work pretty much the same. I think my
solution
is a little harder to test but ends up being a little more compact,
which might
translate into being more maintainable (maybe?).

Please let me know what you think :).
Cheers,
--
Isabella Basso

>  Could you revise your patch based on these changes.  
> 
>  Regards,  
>  Jasdeep 
> 
> -------------------------
> 
> From: isabbasso@riseup.net <isabbasso@riseup.net>
> Sent: December 20, 2021 6:23 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>;
> Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
> Pan, Xinhui <Xinhui.Pan@amd.com>; Zhuo, Qingqing (Lillian)
> <Qingqing.Zhuo@amd.com>; Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com>;
> mwen@igalia.com <mwen@igalia.com>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
> ~lkcamp/patches@lists.sr.ht <~lkcamp/patches@lists.sr.ht>
> Subject: Re: [PATCH v2] drm/amd/display: move calcs folder into DML 
> 
> On 2021-12-20 20:20, Isabella Basso wrote:
>> The calcs folder has FPU code on it, which should be isolated inside
> the
>> DML folder as per
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&amp;data=04%7C01%7Cjasdeep.dhillon%40amd.com%7C01959e019f6e45e25a6208d9c40fc233%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637756394247493762%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=bB4zotGMArbsTzZNDr0u2uw3VBD4jxNornJMol9YJlA%3D&amp;reserved=0
> [1].
>>
>> This commit aims single-handedly to correct the location of such FPU
>> code and does not refactor any functions.
>>
>> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
>> ---
>>  drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
>>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 68
> -------------------
>>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 13 +++-
>>  .../amd/display/dc/{ => dml}/calcs/bw_fixed.c |  0
>>  .../display/dc/{ => dml}/calcs/calcs_logger.h |  0
>>  .../display/dc/{ => dml}/calcs/custom_float.c |  0
>>  .../display/dc/{ => dml}/calcs/dce_calcs.c    |  0
>>  .../dc/{ => dml}/calcs/dcn_calc_auto.c        |  0
>>  .../dc/{ => dml}/calcs/dcn_calc_auto.h        |  0
>>  .../dc/{ => dml}/calcs/dcn_calc_math.c        |  0
>>  .../display/dc/{ => dml}/calcs/dcn_calcs.c    |  0
>>  11 files changed, 13 insertions(+), 70 deletions(-)
>>  delete mode 100644 drivers/gpu/drm/amd/display/dc/calcs/Makefile
>>  rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/bw_fixed.c
> (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =>
> dml}/calcs/calcs_logger.h (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =>
> dml}/calcs/custom_float.c (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dce_calcs.c
> (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =>
> dml}/calcs/dcn_calc_auto.c (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =>
> dml}/calcs/dcn_calc_auto.h (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ =>
> dml}/calcs/dcn_calc_math.c (100%)
>>  rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calcs.c
> (100%)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile
>> b/drivers/gpu/drm/amd/display/dc/Makefile
>> index b1f0d6260226..1872adc96a00 100644
>> --- a/drivers/gpu/drm/amd/display/dc/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
>> @@ -23,7 +23,7 @@
>>  # Makefile for Display Core (dc) component.
>>  #
>>
>> -DC_LIBS = basics bios calcs clk_mgr dce gpio irq virtual
>> +DC_LIBS = basics bios clk_mgr dce gpio irq virtual
>>
>>  ifdef CONFIG_DRM_AMD_DC_DCN
>>  DC_LIBS += dcn20
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> deleted file mode 100644
>> index f3c00f479e1c..000000000000
>> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> +++ /dev/null
>> @@ -1,68 +0,0 @@
>> -#
>> -# Copyright 2017 Advanced Micro Devices, Inc.
>> -# Copyright 2019 Raptor Engineering, LLC
>> -#
>> -# Permission is hereby granted, free of charge, to any person
> obtaining a
>> -# copy of this software and associated documentation files (the
> "Software"),
>> -# to deal in the Software without restriction, including without
> limitation
>> -# the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
>> -# and/or sell copies of the Software, and to permit persons to whom
> the
>> -# Software is furnished to do so, subject to the following
> conditions:
>> -#
>> -# The above copyright notice and this permission notice shall be
> included in
>> -# all copies or substantial portions of the Software.
>> -#
>> -# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
>> -# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
>> -# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
>> -# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
>> -# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
>> -# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE OR
>> -# OTHER DEALINGS IN THE SOFTWARE.
>> -#
>> -#
>> -# Makefile for the 'calcs' sub-component of DAL.
>> -# It calculates Bandwidth and Watermarks values for HW programming
>> -#
>> -
>> -ifdef CONFIG_X86
>> -calcs_ccflags := -mhard-float -msse
>> -endif
>> -
>> -ifdef CONFIG_PPC64
>> -calcs_ccflags := -mhard-float -maltivec
>> -endif
>> -
>> -ifdef CONFIG_CC_IS_GCC
>> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>> -IS_OLD_GCC = 1
>> -endif
>> -endif
>> -
>> -ifdef CONFIG_X86
>> -ifdef IS_OLD_GCC
>> -# Stack alignment mismatch, proceed with caution.
>> -# GCC < 7.1 cannot compile code using `double` and
> -mpreferred-stack-boundary=3
>> -# (8B stack alignment).
>> -calcs_ccflags += -mpreferred-stack-boundary=4
>> -else
>> -calcs_ccflags += -msse2
>> -endif
>> -endif
>> -
>> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_ccflags)
>> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_ccflags)
>> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_ccflags)
>> -Wno-tautological-compare
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o :=
> $(calcs_rcflags)
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o :=
> $(calcs_rcflags)
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o :=
> $(calcs_rcflags)
>> -
>> -BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
>> -
>> -ifdef CONFIG_DRM_AMD_DC_DCN
>> -BW_CALCS += dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
>> -endif
>> -
>> -AMD_DAL_BW_CALCS = $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CALCS))
>> -
>> -AMD_DISPLAY_FILES += $(AMD_DAL_BW_CALCS)
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> index eee6672bd32d..82f26da6778e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -73,6 +73,11 @@
>> CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=
>> $(dml_ccflags)
>>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
>>  CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
>>  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
>> +
>> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
>> -Wno-tautological-compare
>> +
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
> $(dml_rcflags)
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o :=
>> $(dml_rcflags)
>> @@ -94,7 +99,11 @@
>> CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=
> $(dml_ccflags)
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o :=
> $(dml_rcflags)
>>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=
> $(dml_rcflags)
>>
>> -DML = display_mode_lib.o display_rq_dlg_helpers.o
> dml1_display_rq_dlg_calc.o \
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=
> $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=
> $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=
> $(dml_rcflags)
>> +
>> +DML = display_mode_lib.o display_rq_dlg_helpers.o
> dml1_display_rq_dlg_calc.o
>>
>>  ifdef CONFIG_DRM_AMD_DC_DCN
>>  DML += dcn20/dcn20_fpu.o
>> @@ -105,6 +114,8 @@ DML += dcn30/display_mode_vba_30.o
>> dcn30/display_rq_dlg_calc_30.o
>>  DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
>>  DML += dcn301/dcn301_fpu.o
>>  DML += dsc/rc_calc_fpu.o
>> +DML += calcs/dce_calcs.o calcs/bw_fixed.o calcs/custom_float.o
>> +DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o
> calcs/dcn_calc_auto.o
>>  endif
>>
>>  AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
>> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
>> similarity index 100%
>> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
>> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> 
> Hi all,
> 
> This isn't a v2, but actually a v1, I apologize for the mistake.
> 
> --
> Isabella Basso
>  
> 
> Links:
> ------
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&amp;amp;data=04%7C01%7Cjasdeep.dhillon%40amd.com%7C01959e019f6e45e25a6208d9c40fc233%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637756394247493762%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=bB4zotGMArbsTzZNDr0u2uw3VBD4jxNornJMol9YJlA%3D&amp;amp;reserved=0

-- 
Isabella Basso
