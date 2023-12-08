Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7E9C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D474510EA43;
	Fri,  8 Dec 2023 08:37:18 +0000 (UTC)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D11910E990
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:04:45 +0000 (UTC)
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4b2cef60577so452141e0c.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702011884; x=1702616684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YCezDiITLYZlXZkoiENFPkRYgXSgvqAlJqwCHapkHlo=;
 b=cdYAnVD14BYHYe/SVCeTv+SjPXnX7YnIlbygAABMK7jfdvsovBAOR7EhmzWk1yV5S1
 JE+70m4g7rzU+0699JX4m6WHu/yLSN48Ztzk+G0JX9kcCn4YNAUWiSMkFytWdyllOZo+
 +WWxWyDUXhtUfle9pA48o8t24OYKrJPFNXmbUsWiu8QUjNbNeEHAK0veTR+QQmKmvw61
 X6mNpzOg9+dWsmMz6vFlTP0kYtHKrukkR3lBk3UQhMfOGP3uUaTsSyQquksFrS0mc9AC
 JtqyXLwbrSbRm3V/i+bjnshtF+kzFRkIS3pspoaDs6Cxfyg9QdW+TCz3MPXSXlDzPfLQ
 DrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702011884; x=1702616684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YCezDiITLYZlXZkoiENFPkRYgXSgvqAlJqwCHapkHlo=;
 b=Hkwettg3F4HkcFnHcKU3UKBW2E3mcF2T8UZXAPwAXFBC8zIioIzqnn3dfOxyqQd3hL
 T1FRku2MlH41HeoA+ntm+9Zrr+/fk2bx/hsek11/yOEWq2CewelY8VIsSL54htGtdTmK
 ob42fgI4otkSul3nET6/8w9MpuKzhiGETJ+Lj/DBivM99MtnjEDy69ZQ27h3VQG80C6N
 lZa6oLqqIS/p46yd7zvhM3ed8v+3xUHjrYDaR5hw4RhricTbDUHlMV2THZSXnoXuLwh9
 18pif3mOana/+UQn6yj583Bx+XeKGlfYBH/uuwMFEA2Jy/wdG923utWNwE7ZYJnYVepm
 ZVNg==
X-Gm-Message-State: AOJu0YyBUNMJHyXhch56Y/y503UQ+6uicamfExfKiHjozrrINvJAjMQa
 sc6MXf3cbkcB0LpdxJ2mzsKOAA==
X-Google-Smtp-Source: AGHT+IHd3xhGQZwcUIcLtaS/NPIhQH51OI4srkcBz6UdtbLizYUKJjw8nicEQTdHb0F/v/M3ROTE/Q==
X-Received: by 2002:a1f:c843:0:b0:4b2:c555:389 with SMTP id
 y64-20020a1fc843000000b004b2c5550389mr2948641vkf.31.1702011884531; 
 Thu, 07 Dec 2023 21:04:44 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:41c5:bf1:860b:1e95?
 ([2600:1700:2000:b002:41c5:bf1:860b:1e95])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a0cf38e000000b0067a33133420sm494592qvk.110.2023.12.07.21.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 21:04:44 -0800 (PST)
Message-ID: <4f277982-fffb-4fe1-bc02-007633400f31@sifive.com>
Date: Thu, 7 Dec 2023 23:04:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com>
 <20231123-headdress-mold-0dd7a74477f7@wendy>
 <20231130004224.GE2513828@dev-arch.thelio-3990X>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231130004224.GE2513828@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 08 Dec 2023 08:37:01 +0000
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
Cc: llvm@lists.linux.dev, arnd@arndb.de, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Palmer Dabbelt <palmer@dabbelt.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, linux-riscv@lists.infradead.org,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Nathan,

On 2023-11-29 6:42 PM, Nathan Chancellor wrote:
> On Thu, Nov 23, 2023 at 02:23:01PM +0000, Conor Dooley wrote:
>> On Tue, Nov 21, 2023 at 07:05:15PM -0800, Samuel Holland wrote:
>>> RISC-V uses kernel_fpu_begin()/kernel_fpu_end() like several other
>>> architectures. Enabling hardware FP requires overriding the ISA string
>>> for the relevant compilation units.
>>
>> Ah yes, bringing the joy of frame-larger-than warnings to RISC-V:
>> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: warning: stack frame size (2416) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]
> 
> :(
> 
>> Nathan, have you given up on these being sorted out?
> 
> Does your configuration have KASAN (I don't think RISC-V supports
> KCSAN)? It is possible that dml/dcn32 needs something similar to commit
> 6740ec97bcdb ("drm/amd/display: Increase frame warning limit with KASAN
> or KCSAN in dml2")?
> 
> I am not really interested in playing whack-a-mole with these warnings
> like I have done in the past for the reasons I outlined here:
> 
> https://lore.kernel.org/20231019205117.GA839902@dev-arch.thelio-3990X/

I also see one of these with clang 17 even with KASAN disabled:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:37:6:
warning: stack frame size (2208) exceeds limit (2048) in 'dml32_recalculate'
[-Wframe-larger-than]
void dml32_recalculate(struct display_mode_lib *mode_lib)

     ^
1532/2208 (69.38%) spills, 676/2208 (30.62%) variables

So I'm in favor of just raising the limit for these files for clang, like you
suggested in the linked thread.

Regards,
Samuel

