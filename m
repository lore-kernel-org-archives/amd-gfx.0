Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A82C5DF82
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 09:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E096E10EF94;
	Thu, 20 Aug 2026 09:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ptEcjP/n";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D9F10EF94
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=/n6MsS1mvFdLHKqJXuH44GkrGg+yQ2wOemYqPKtigoY=; b=ptEcjP/nGzF/KLiA6X4zMDrMMn
 q/wDPqu5umDSmohzaq/yEHBvref4PnKeJXr10ZtC8jDlHOYhfsNLa7pct4Se48yGYmPm6jedECPWg
 ieJ/cnE6YldKMb096YuXeO/N/8omxkCnoLfrplkbfn7yKsIvIiZbh6Z7BUNRZLrF2TuIjwjBeNR8F
 MgV1d9CKoPrsQa/3s4B7FBPdAJi/9AxUaAJg1kOm5aPDZ7NLr25nxM3HZVLPeSCu1AxIJqqnloi2M
 Hd7rPCtAuc75efXS/t03VZ4mA3zlLjApUiOwJKn1VoHf97Fjz9QNzQLmEVTr37kZvyo582a7R3CdX
 C3u0/8mQ==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=[192.168.1.204]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wwzEl-006WS7-4u; Thu, 20 Aug 2026 11:39:03 +0200
Message-ID: <a1e66c79-f11d-45fd-aaa2-fddc6d8a4c92@igalia.com>
Date: Thu, 20 Aug 2026 11:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/amd/display: follow-up fixes for LUT segmentation
To: Alex Hung <alex.hung@amd.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "'Dr . David Alan Gilbert'" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 robert.mader@posteo.de, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
References: <20260819161106.27702-1-mwen@igalia.com>
 <e77850ac-1471-46cb-ba6f-4cc16d703515@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <e77850ac-1471-46cb-ba6f-4cc16d703515@amd.com>
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



On 19/08/2026 21:07, Alex Hung wrote:
> Thanks Melissa.
>
> I tested kms_colorop on DCN3.5 DCN3.14 without any problems. There are 
> some comments regarding to commit messages which I replied to each patch.
>
> I will send this patchset to next week's promotion test.

Nice! Thanks!

I sent a v2 addressing your comments in the commit message.
https://lore.kernel.org/amd-gfx/20260820093324.10201-1-mwen@igalia.com/

Regarding the duplicated word `segments`, this follows the same pattern 
in similar color helpers and seems correct to me, since they are in 
different sentences.

Melissa

>
> On 8/19/26 10:00, Melissa Wen wrote:
>> Extend halving distribution for all curves/custom-LUT in a
>> encode-to-linear operation, not only PQ/SRGB. This fixes failures in IGT
>> kms_colorop test after [1]. Also use the CM3 degamma helper that
>> translates curves to hw points for DCN30-based family, not only DCN32,
>> since the banding issue is present on both.
>>
>> [1] 
>> https://lore.kernel.org/amd-gfx/20260623160112.1636801-1-mwen@igalia.com/
>>
>> Melissa
>>
>> Melissa Wen (2):
>>    drm/amd/display: use halving distribution for all encode-to-linear
>>      curves
>>    drm/amd/display: use translate_curve_to_degamma_hw_format on DCN30
>>
>>   .../amd/display/dc/dcn30/dcn30_cm_common.c    | 34 ++++++-------------
>>   .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 10 +++---
>>   2 files changed, 14 insertions(+), 30 deletions(-)
>>
>

