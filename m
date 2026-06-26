Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B38CDE008
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 10:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4764110F560;
	Fri, 26 Jun 2026 10:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="nUlhdiN2";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0981010F565
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 10:57:35 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so5795575e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1782471453; x=1783076253; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sAseHEuLitU2XuzH9XcC23JCBmfXywpYjauwlpSls6I=;
 b=nUlhdiN20IwFVbaIIzgd8chiXPiL3BhMZnNrwJR4u0ocXLHRStqffQvtvrLWSZEjwO
 QKVOebBZfMfHUjsSO8TQjYzeJoIlG45gTrmzzff6XL5txjEo8d7g86iEPeRMxA4txYgt
 ZHlmCYK5wjAOQ+7k45ka5MYh/Zg+DeNQ3fi8Syj1r1ctFrBFPXEz2/A36Blpk8KkCpSU
 oR6hjC7lPIvV8NE6gfjn/KhZIFoyB+LjoXTSNj8uB58ecofr3aEQuj5XMNyZDY7Psqyx
 PCZKGc893aIEhPz8ht0sAAG36j6Mmq9r0iN1qgt3hJzVTUHRXkJSjGqxbB7HM41RCaRV
 25cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782471453; x=1783076253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sAseHEuLitU2XuzH9XcC23JCBmfXywpYjauwlpSls6I=;
 b=WXcoLm64wpbiSLadfAwltxMEWxMpBvRptUdYfPDsI7+T0pEO6rnk3RcDSzOvbtVFB9
 zI/CR3bIuyRCJDudX4X6WGOixfYTdI3vMt2P/YMXLFFjPKt91xpd0+kXACKK2x8gAYl2
 cIFQyRdH5TB1oIceVozVzJdP+ubO9yhbz9vUFhxbQIQaA3yP96M6/EWEdLBqOBoGHrmr
 LJ9LypJT55vj63hK4b12ig/aHXZha1XJtRW8EednkmUeTrh9CtxMXgAhfDHECBGT9YUW
 B+pGo3WcLNi0TZwnWPuZrhCLRiQnOCWS1aK1aPlF/1OjOd0sulrSDoSAIlGsz1vOM9Ay
 0KHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TIbICLxFxaBjFVZvQVmLFU/p0+x1azSqJJMXltkF+fT+9KbVWnO/wytK4LPZ4W9+t2Lt3Bcax@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtQNErgwtfQG+hc0oJu53mYvYa7fkhGEDnkR0cNGogn2LoYrqa
 wgTJT5Xsvu0rSNOBBxTUShfsNDwViTCC7dMQN5mnkGkVCYPEYUEkMSUpsXFFEy8zVvg=
X-Gm-Gg: AfdE7ckW52tve/9NC8EVcUFyuf8MM5DK1hmQVhz0Jxi7D8B4HaubWf7SWkCpGOCPZVB
 iMYQuzgMZOYw7HPVtiXeluGTKK4o05cKFvrBMfKLh1f639YOh781GxKfBxjAYkAPAKqK0mZaxUJ
 ++XZNr86BVs0Bmvjxa72e1jNKOrxOtxIKWWwiqZDASDvUOGvlT+JCtW3wkvheGconcxmqF6BVI1
 B64OjJr5FWCcQNhpb4cOztcifYQ9IJ4aTXju9kK/LFeFpscQFJPjZHR6y17bsuocpQqxp6jwNQy
 pD7MkEDnsmj/l63fL7ur8Du5oyEdgemqBP3Ye5ZxHxp4vCa6ZFRquGCoMH5CDPAJnU/BEN1UwoJ
 i1I/TXTmY38K18FumwRWoGuDCvnBsjHmwJv/2ioFPw5I1cSbPvS55Os3I8N+QlcSl29UEJYwJVg
 OQsYWV6wfRSN+8i7KABD+muuCxjHP8vMAQ0A==
X-Received: by 2002:a05:600c:8a1a:10b0:492:488c:f627 with SMTP id
 5b1f17b1804b1-49266872ce4mr69640085e9.11.1782471452665; 
 Fri, 26 Jun 2026 03:57:32 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268f700c0sm75417365e9.0.2026.06.26.03.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 03:57:32 -0700 (PDT)
Message-ID: <5021eae6-40f8-4079-9b5d-f511537aa460@ursulin.net>
Date: Fri, 26 Jun 2026 11:57:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: add generic drvparam[] alias for
 ttm_place::fpfn/lpfn
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260626063658.10237-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260626063658.10237-1-Arunpravin.PaneerSelvam@amd.com>
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


On 26/06/2026 07:36, Arunpravin Paneer Selvam wrote:
> The fpfn/lpfn fields in struct ttm_place are named after page frame
> numbers, but they are really just placement parameters interpreted by
> the backend resource manager. Wrap them in a union with a generic
> drvparam[2] array so backends can access the same storage without the
> PFN-specific naming.
> 
> drvparam[0]/drvparam[1] alias fpfn/lpfn, so existing users and the
> VRAM range manager are unchanged. This decouples the API from
> PFN/range-specific semantics so that these fields can be used more
> flexibly in the future (e.g. mask-based or segment-aware placement
> constraints). No functional change.
> 
> v2: Use a union exposing a generic drvparam[2] array instead of
>      renaming fpfn/lpfn to param1/param2, keeping existing users
>      unchanged (Tvrtko Ursulin)
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Assisted-by: Claude:claude-opus-4-8
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   include/drm/ttm/ttm_placement.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
> index ab2639e42c54..7db2073f3236 100644
> --- a/include/drm/ttm/ttm_placement.h
> +++ b/include/drm/ttm/ttm_placement.h
> @@ -75,14 +75,22 @@
>    *
>    * @fpfn:	first valid page frame number to put the object
>    * @lpfn:	last valid page frame number to put the object
> + * @drvparam:	generic driver/backend placement parameters; the
> + *		interpretation is defined by the backend resource manager.
> + *		drvparam[0] and drvparam[1] alias @fpfn and @lpfn.
>    * @mem_type:	One of TTM_PL_* where the resource should be allocated from.
>    * @flags:	memory domain and caching flags for the object
>    *
>    * Structure indicating a possible place to put an object.
>    */
>   struct ttm_place {
> -	uint64_t	fpfn;
> -	uint64_t	lpfn;
> +	union {
> +		struct {
> +			uint64_t	fpfn;
> +			uint64_t	lpfn;
> +		};
> +		uint64_t	drvparam[2];
> +	};
>   	uint32_t	mem_type;
>   	uint32_t	flags;
>   };
> 
> base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7

LGTM but then again I suggested it (hint hint) so I may be biased :)

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

