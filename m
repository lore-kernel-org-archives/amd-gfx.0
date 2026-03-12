Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129CA103E302
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4172910EB3F;
	Fri, 13 Mar 2026 08:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=wbinvd.org header.i=@wbinvd.org header.b="eQ+2Oj82";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5760310EA5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 16:15:35 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so438156eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wbinvd.org; s=wbinvd; t=1773332134; x=1773936934; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wYTHfLNKxvy35JvH8B5/QuRK+srFMTLyCSw6VerOpmQ=;
 b=eQ+2Oj82pvx5Ky7KNDUV8ZEzz3wcITT3WyY8oogT73E63LbXrPtibaRdz+4MYdAYhT
 V2RO5gAvCnDPRQHft+P6DFCRDIOddfPUYDcT8eDaGEpl9+76tdsYwx0iUZmoqnCBqW57
 d+3HtPrK4TVTvoJgER2te0TxnT0iSutYXagJ5fYMSQsmCMrvqyEEdz/dJBRU/3Vk3ZRI
 Xbh9osMVeSBmkPSv4YXSP/b3EM92XN/yWJUhlgIiVd10ckAIMe4s4S/iKpjFdsy6yeML
 xfSYo9oNBETpuwNJCvd+XXpXBfVEZKdEcsboGEJY1WLDjQ/6/j9OrL0u6DTzesM22gYF
 UpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773332134; x=1773936934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYTHfLNKxvy35JvH8B5/QuRK+srFMTLyCSw6VerOpmQ=;
 b=HN1UqVyjGEfTSnzz3PYb+Z0SQ9KXynokVg3zmgvTGh8EU+4lwIyWY6umyv7wXhhHP+
 ePFMFufMXUv5sAUoPH/lEKsF3OqQHLwxemrwFq8rjSofkUvIincnpJA09JkAVRs1t0VY
 A98PqeVVjIMPzdeZ6P5HSVwIBYe61MiDzDx8t59OPCFFKXIBMGIJE7LNbjrNT3LmZzMV
 qF/0uKhnkQvtaMfn9QQjooBTe9bjrO3WginGrZ5wpw1a3jfc9e2Mb5mkBQrtovAHhna/
 4B8puJogI2suL2k5nbjwikAYd3l71o+aFo0j4p1Y9BWgw39D2Yw9lr7OSlI3q8321W3U
 XV1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmzgT0gogNcj9TGNK5gephQOa8b/ivTBjcXbw9KOKwCtZradv9LTwHkAzQHWXA/i+sm6dGq1ix@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJG4B7YI+yZGpYwZ5ETEMyfCM0/OF7hgnTV8ZM9NEdi8buwuvX
 jWk1tIT8mync08H2lpw32RXYCR6nxQgzveJgeOcp66ty8Zp0EvGDJDjORymnP8LexXc=
X-Gm-Gg: ATEYQzzLZ4ahJ81YtcO9dvNglXb24yrgYwXgjDO1gKVp2y13rRlxoqqKwHk8HJq2gmE
 8l8oXaCFqwork1t9WwvOtFe9I1FTB6zZEsDkQvJbcjzmRJ3cRDhl/b3ZymJ/pDLxsVYy/reuFD5
 +3LG/PXO7XHDcS59mylWtNUH+g0aXzVCBt97CNBosBACwDWg7VnOfHr1FaU8GhD1myqlYRR+T5+
 hj5t5McxnZNAt0aVVJYhBk4Lxr6Mv+txO1En6t/s9LDJKi1dkVNEAIu5HKY1KFTZEVrykih5244
 sx2KnZqQ+qN/woojt4hoVh7z4UwoN2tw8NdC+7aVkwkMZ+O9IazSx5hBVXN472NhgIdwaeVNGmI
 /s4BgsCfngthxFv1IQL6ZfztfIV6YmDABwx5zZfn7jgXfhag6YDH2RzgiEc3nkJMrQ3xtHCTS22
 QhGEHRCgdxpH5cb4ola0gRihEt3g==
X-Received: by 2002:a05:7300:ec17:b0:2ba:7783:d1cd with SMTP id
 5a478bee46e88-2bea5475343mr137153eec.12.1773332134317; 
 Thu, 12 Mar 2026 09:15:34 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:53d0:dd05:1bb3:9034])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be8aa7413esm6963232eec.24.2026.03.12.09.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:15:33 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:15:30 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Charlene Liu <charlene.liu@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, Alex Hung <alex.hung@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [REGRESSION][PATCH] drm/amd/display: Fix uninitialized variable
 which breaks full LTO
Message-ID: <abLmonL-8QubcCpA@mozart.vkv.me>
References: <ef7266eb7802ce6d68ebd9356477e9671f0c94e0.1773116305.git.calvin@wbinvd.org>
 <20260312080245.GA3988095@ax162>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312080245.GA3988095@ax162>
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:55:38 +0000
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

On Thursday 03/12 at 01:02 -0700, Nathan Chancellor wrote:
> Hi Calvin,
> 
> On Mon, Mar 09, 2026 at 09:24:57PM -0700, Calvin Owens wrote:
> > Commit e1b385726f7f ("drm/amd/display: Add additional checks for PSP
> > footer size") introduced a use of an uninitialized stack variable
> > in dm_dmub_sw_init() (region_params.bss_data_size).
> > 
> > Interestingly, this seems to cause no issue on normal kernels. But when
> > full LTO is enabled, it causes the compiler to "optimize" out huge
> > swaths of amdgpu initialization code, and the driver is unusable:
> 
> Yeah, this appears to be a very unfortunate case of "clang encountered known
> undefined behavior and stopped code generation", which we would like to
> avoid but figuring out a proper upstreamable solution is hard. The most
> recent attempt:
> 
>   https://github.com/llvm/llvm-project/pull/146791
> 
> My guess is that LTO allows inlining of
> dmub_srv_get_fw_meta_info_from_raw_fw() into dm_dmub_sw_init(), at which
> point it can see that the result of accessing an uninitialized
> region_params.bss_data_size will be used through
> fw_meta_info_params.fw_bss_data and gives up generating the rest of the
> function.

Thanks for looking Nathan. I'll keep an eye on that and see if it's able
to catch this example. I've tried to come up with a minimal reproducer,
but I haven't had any luck yet (so far I always get the warning), would
that be helpful at all?

I put the full W=2 output for the one file here in case anyone else
wants to look:

   https://github.com/jcalvinowens/lkml-debug/blob/main/amdgpu-lto/gcc-warns.txt
   https://github.com/jcalvinowens/lkml-debug/blob/main/amdgpu-lto/llvm-warns.txt

Somehow 'make drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.o' doesn't
work, I want to look at that later because it was mildly annoying while
digging into this.

> >     amdgpu 0000:03:00.0: [drm] Loading DMUB firmware via PSP: version=0x07002F00
> >     amdgpu 0000:03:00.0: sw_init of IP block <dm> failed 5
> >     amdgpu 0000:03:00.0: amdgpu_device_ip_init failed
> >     amdgpu 0000:03:00.0: Fatal error during GPU init
> > 
> > It surprises me that neither gcc nor clang emit a warning about this: I
> > only found it by bisecting the LTO breakage.
> 
> gcc's -Wmaybe-uninitialized is disabled by default for the kernel but
> even enabling it with KCFLAGS does not show an instance here, which I
> find quite surprising... for clang, it is harder because the warning
> happens early in the frontend where it might not be able to track a
> value that well.

GCC does flag what seems to me to be a real but benign warning about an
ERR_PTR check that doesn't handle NULL in the same file:

    https://lore.kernel.org/lkml/6aaf2cf4bd19363a85f35e649685d7bdae400253.1773157137.git.calvin@wbinvd.org/

I'm also trying to find a minimal reproducer for GCC, no luck yet.

> > Fix by using the old value for region_params.bss_data_size in place of
> > the uninitialized reference, which makes amdgpu work with LTO again.
> > 
> > Fixes: e1b385726f7f ("drm/amd/display: Add additional checks for PSP footer size")
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index b3d6f2cd8ab6..e69e61163ae9 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -2554,7 +2554,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
> >  	fw_meta_info_params.fw_inst_const = adev->dm.dmub_fw->data +
> >  					    le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
> >  					    PSP_HEADER_BYTES_256;
> > -	fw_meta_info_params.fw_bss_data = region_params.bss_data_size ? adev->dm.dmub_fw->data +
> > +	fw_meta_info_params.fw_bss_data = le32_to_cpu(hdr->bss_data_bytes) ? adev->dm.dmub_fw->data +
> 
> Maybe it would be better to use fw_meta_info_params.bss_data_size
> instead of le32_to_cpu(hdr->bss_data_bytes)? Obviously it is the same
> value but it would result in a smaller change. It seems likely that this
> was just a copy and paste failure.

Agreed. That ends up being almost self evidently correct if I force git
to add an extra context line with the assignment, I always forget I can
do that:

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6..0d1c772ef713 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2553,9 +2553,9 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	fw_meta_info_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
 	fw_meta_info_params.fw_inst_const = adev->dm.dmub_fw->data +
 					    le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 					    PSP_HEADER_BYTES_256;
-	fw_meta_info_params.fw_bss_data = region_params.bss_data_size ? adev->dm.dmub_fw->data +
+	fw_meta_info_params.fw_bss_data = fw_meta_info_params.bss_data_size ? adev->dm.dmub_fw->data +
 					  le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 					  le32_to_cpu(hdr->inst_const_bytes) : NULL;
 	fw_meta_info_params.custom_psp_footer_size = 0;
 

I'll send a v2 in a little bit.

Thanks,
Calvin

> >  					  le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
> >  					  le32_to_cpu(hdr->inst_const_bytes) : NULL;
> >  	fw_meta_info_params.custom_psp_footer_size = 0;
> > -- 
> > 2.47.3
> > 
