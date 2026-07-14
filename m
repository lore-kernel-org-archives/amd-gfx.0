Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA84FC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 00:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E76810E9F7;
	Tue, 14 Jul 2026 00:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s0PUCY4w";
	dkim-atps=neutral
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2532910E9F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 00:23:06 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-92eafc94c9cso262094085a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783988585; x=1784593385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Koso+bSPPHaqPvmr39rQPkbp0UVDUHxcqL3tZvHC0nY=;
 b=s0PUCY4wpHb65bteF3MPAa1cB53m2hHStaj5Yenlth3Aqe1nM4Bl4nPtjNlvAqKPQD
 bbGFrY9OyTsYLa2wrLE+/hbZidV+Eh29q03vjrwY+zj7HoGbaWPzCPVw5JWeahiI4nVP
 PQqbtMXkroCrciPCsq/ZNzWzGuBZHehZRJGKcNaIl/Zh17O2qHiHWnyLiHdYzdeHauKN
 zJma6ZM9eX1zTWregR8POSoHtSTEJz/xJfe/5RQ/QyOIlvFf0Ldz45bTd5py1rsRbWLh
 kRqzZfZZ4kcM3AIU6vwsK3edaXMTRmxQnanf4M1YDhGjynvHubT8w9/77IddOvFjWhER
 vwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783988585; x=1784593385;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Koso+bSPPHaqPvmr39rQPkbp0UVDUHxcqL3tZvHC0nY=;
 b=XBi2kRVphEF8t12BIrKRv6tn+X/3ikDvbw/5IHrGEBpDnUUamcKK76APoE2UEzMyhi
 kdyOMPblHKwWcWWbBM8PAUlTzbkg9t4QtH4MnFifNwyL7t6DDRLzzKSDcTPxvTZS1Z6c
 24AT+8DeJLnuIDIv/6CdrkHas7SoFicMqrDi2lZwPPWZS5KEnDJxDY1THfbwBWdB/9bl
 gQpUVfzNtU2QhlNbAH0iPgkQL2MBOZq88C3XSjVszYe9U0t5TuE2RK3OxGBzZNJR0O3g
 TfV0wQ+m6MOtnpdAZfzbfbiNpKGRnrJ1DQBtCluamMqW10VZzoePqZZcCFwNRcwlDqv0
 2UoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq25DXK/YAEbGFOf5JxlOzSC87iyoP89rADmaJRdrTtcqi0qA2sg8/a9rfQYwXMnKgeMxqU7G0l@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzy3XY2roSrxQfmNUSvMeBoo/8OjYhwqI/E/jKSsMa5d0wE0KTy
 CW6ieNsrtYKDP0OHWxKwL9VBagxn9SvVzitiCfWTlb/9TvW4aGE7NYvb
X-Gm-Gg: AfdE7cnHYNzuz/clqFeAY0bxw0iyepy3GOS/IdH0Hybm2jwsSRYfGtl+rqRLluaHxgm
 Ife46Tz6Ll7LNG0OvfF94UxSghlSyuNEFudvSFjd5mXMqNEA54XncQlRzML2svFXjFzKacmZa1P
 FigC5aVGgVYroGs90sSYMkB8jKPY75V47qXpjyC6o1Ojp2ppYbuBBz/2sQuAE+AGNEK17a7ZXEn
 cQipnbhqa5mtW2hifvazaBpLPhadVwRr9St9wcOHKULDGMvxq3HMLqTkGiINfi/0im2t622WaKU
 OSyW/7ZJIqfoJzN4P2nd9A5z5TnSvkRfVKfDkMLzGDW7GVlFE8ywqPnGtyIszWepDsVAn7yfl0P
 m6eSQ32mLZD4PYPc6FUb79Gy4uM0SAPSvE4plhk4iuwxjZ8TAZHClkUwcJ03L5FtZbDEOlXn42n
 3wybkE7rEY7sKe1ANC8a/Y
X-Received: by 2002:a05:620a:6909:b0:92e:6a43:4768 with SMTP id
 af79cd13be357-9308683c3f6mr29539685a.11.1783988584699; 
 Mon, 13 Jul 2026 17:23:04 -0700 (PDT)
Received: from [192.168.1.100] ([32.219.251.147])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-92ee5b4a082sm1217193785a.7.2026.07.13.17.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 17:23:03 -0700 (PDT)
Message-ID: <1690367e-5e83-4121-bf3c-96f15f7060c8@gmail.com>
Date: Mon, 13 Jul 2026 20:23:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix pp_entries_max() bios check
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com, hawking.zhang@amd.com, le.ma@amd.com,
 shiwu.zhang@amd.com, alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260713042902.2220454-1-asad.kamal@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <20260713042902.2220454-1-asad.kamal@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/13/26 12:29 AM, Asad Kamal wrote:
> Commit 3cfe43363050 ("drm/amd/pm: Use uploaded size for legacy custom
> PPTable") changed pp_dpm_set_pp_table() to kmemdup the uploaded buffer
> directly and set soft_pp_table_size to the uploaded size.  As a result
> soft_pp_table now points to an allocation completely outside adev->bios,
> making the unconditional pp_end > bios_end check in pp_entries_max()
> always true for custom PP tables — silently returning 0 and breaking
> PP table overrides via sysfs.
> 

When I hit this issue, the pp_end > bios_end check didn't always return
true.  The order of pp_table overrides mattered for triggering the
failure on a system with multiple cards.

I also wouldn't call this failure path silent.  Callers of
pp_entries_max() print appropriate warnings, painting a nice picture of
what's happening during the resulting cascade:

$ sudo cp custom_pp_table.bin /sys/class/drm/cardN/device/pp_table
Killed

[   71.320109] kernel: amdgpu: amdgpu: MM dependency table: clamping ucNumEntries 8 -> 0
[   71.320137] kernel: amdgpu: amdgpu: Polaris SCLK dependency table: clamping ucNumEntries 8 -> 0
[   71.320149] kernel: amdgpu: amdgpu: MCLK dependency table: clamping ucNumEntries 4 -> 0
[   71.320166] kernel: amdgpu: Number of Pcie Entries exceed the number of SCLK Dpm Levels! Disregarding the excess entries...
[   71.320179] kernel: amdgpu: SCLK DPM index for VRHot cannot exceed the total sclk level count!
[   71.320190] kernel: amdgpu: amdgpu: VddcLookup table: clamping ucNumEntries 15 -> 0
[   71.320200] kernel: amdgpu: amdgpu: VddcLookup table: clamping ucNumEntries 8 -> 0
[   71.320211] kernel: amdgpu: [powerplay] Lookup table is empty
[   71.320222] kernel: amdgpu: [powerplay] Lookup table is empty
...
[   71.678679] kernel: note: cp[2243] exited with irqs disabled

> Fix this by conditioning the BIOS containment check on
> hardcode_pp_table being NULL.  hardcode_pp_table is zero-initialised
> (kzalloc) and only set when a custom table is uploaded via sysfs, so:
> 
>   - hardcode_pp_table == NULL: VBIOS path — enforce pp_end <= bios_end
>     to reject a malicious VBIOS inflating usStructureSize past the BIOS
>     image.
> 
>   - hardcode_pp_table != NULL: custom upload path — skip the bios_end
>     check, soft_pp_table_size is the kernel-supplied upload size and is
>     already trusted.
> 
> Fixes: e30b3e3ab51a ("drm/amdgpu/pm: add pp_entries_max() helper")
> Reported-by: John Olender <john.olender@gmail.com>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Tested-by: John Olender <john.olender@gmail.com>

Thanks,
John

> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> index 7ebc1344023f..a23e01921842 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -833,14 +833,17 @@ static inline uint32_t pp_entries_max(const struct pp_hwmgr *hwmgr,
>  				      const void *sub_table,
>  				      size_t hdr_size, size_t rec_size)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> -	const char *bios_end = (const char *)adev->bios + adev->bios_size;
> -	const char *pp_end   = (const char *)hwmgr->soft_pp_table
> -			       + hwmgr->soft_pp_table_size;
> +	const char *pp_start = (const char *)hwmgr->soft_pp_table;
> +	const char *pp_end   = pp_start + hwmgr->soft_pp_table_size;
>  	const char *entries  = (const char *)sub_table + hdr_size;
>  
> -	if (pp_end > bios_end)
> -		return 0;
> +	if (!hwmgr->hardcode_pp_table) {
> +		struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
> +		const char *bios_end = (const char *)adev->bios + adev->bios_size;
> +
> +		if (pp_end > bios_end)
> +			return 0;
> +	}
>  	if (!rec_size || entries >= pp_end)
>  		return 0;
>  	return (uint32_t)((pp_end - entries) / rec_size);

