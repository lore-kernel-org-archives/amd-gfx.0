Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047B0C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 07:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0AA10E583;
	Thu, 18 Jul 2024 07:09:26 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55FA910E583
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 07:09:24 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so3308585e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 00:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721286563; x=1721891363;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4e7NYMkCAtW2f9ny6ENs4O5vNHbdWtMLtoREFsZq8M=;
 b=X2asbYoMW9GcDcOQCAEG3pDq2zuX/YC1pQ7s2hkRN0hSOH+UwwRxOjF6U1GGsHIZu7
 kXX1sRvE1vIK16opa5sKGJLuIIv+oXrzJBAZJfs3gpWaiXfxEkPORUFMfCwBSFi5MXPw
 HQ4B4BeOrvn8G2jDLE2Zbe3BpBv2QN7APfhGG/8bKgTp/fRH3MLXPxeplBXq3DIguUX9
 SuVit4f00g4Rl7My7SM6gL/02wcIYGg6SamRFObJvWB8qCr60vQdlcVg/qqoZObXuPKe
 0lrhPyr2RoEqiwr5so89PtcrZ0K1k2cL1ROZMdukwJShSuAu1j0QnfjCuJEHuSclQo8x
 hqzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaEQvAiQ56yy/9qJbbZoC30PgJO2MqXruCeGXOQTDqLMiexJRz+Te+m5/lPUVWjAK+JuD/1dfAN45IrXzblMWrEYetf0nPn4YdCnM5hg==
X-Gm-Message-State: AOJu0Yyb1MXsS1RBEl6KbPA06p0Id8PTygV/74/+C1gm1oV+ZxgCi9SM
 g3DxaVCnjRm3LAPnUIOiTENIx3YGRoJcVcaYASBH3swa0srN/n3Wt1BSVQ==
X-Google-Smtp-Source: AGHT+IEf6mB52B970g2HFvaXfUDQz54oG/QDK6K1bt24ruP5R+ppb0DUa+ycLOdfDyqRcqIkYsJOQw==
X-Received: by 2002:a05:600c:4f82:b0:426:61b4:a2eb with SMTP id
 5b1f17b1804b1-427c2cc0eb3mr28549975e9.19.1721286562434; 
 Thu, 18 Jul 2024 00:09:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c7841ef7sm23606065e9.35.2024.07.18.00.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 00:09:21 -0700 (PDT)
Message-ID: <87138377-d5b0-4c28-96bd-35a0ffd5f204@kernel.org>
Date: Thu, 18 Jul 2024 09:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/43] drm/amd/display: FEC overhead should be checked
 once for mst slot nums
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Daniel Wheeler <daniel.wheeler@amd.com>, Harry.Wentland@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, solomon.chiu@amd.com, agustin.gutierrez@amd.com,
 hamza.mahfooz@amd.com, Hersen Wu <hersenxs.wu@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
 <20240328195047.2843715-9-Roman.Li@amd.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240328195047.2843715-9-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 28. 03. 24, 20:50, Roman.Li@amd.com wrote:
> From: Hersen Wu <hersenxs.wu@amd.com>
> 
> [Why] Mst slot nums equals to pbn / pbn_div.
> 
> Today, pbn_div refers to dm_mst_get_pbn_divider ->
> dc_link_bandwidth_kbps. In dp_link_bandwidth_kbps,
> which includes effect of FEC overhead already. As
> result, we should not include effect of FEC overhead
> again while calculating pbn by kpbs_to_peak_pbn
> (stream_kbps).
> 
> [How] Include FEC overhead within dp_link_bandwidth_kbps.
> Remove FEC overhead from kbps_to_peak_pbn.

Hi, this 6.10 commit (8b2cb32cf0c613) causes my secondary monitor not to 
come up at all.

Reverting this on top of 6.10 makes it work again.

Reported as (more details):
https://gitlab.freedesktop.org/drm/amd/-/issues/3495
https://bugzilla.suse.com/show_bug.cgi?id=1228093

> Reviewed-by: Wayne Lin <wayne.lin@amd.com>
> Acked-by: Roman Li <roman.li@amd.com>
> Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> ---
>   .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 37 +++++--------------
>   .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  3 --
>   2 files changed, 10 insertions(+), 30 deletions(-)

thanks,
-- 
js
suse labs

