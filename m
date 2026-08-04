Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17210C55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D2610E6B3;
	Tue,  4 Aug 2026 09:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KWo7pzkN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3819410E6B3
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=TzLyLzVW6JT0+vR1/iWrVF7qUFt0djmv0Q7NUtWD6qQ=; b=KWo7pzkND/nVDYsAgHz7CJpI6f
 uDIyTLvixi//wUz4FWbk/kgX31IEy0XDy+jdM7Va0oUyQEYmxoojJhfqUjPcJriugjCbmCodxuh0Z
 aCmH8d3YewCZNc89NgaI2LewOlno9C1ns6l+wBMCP4MA5IaUgDwo9CbxxjpJklbR1+KaXBXUhnn8r
 LA31JPBn3YeDw13lA0GUxx+NG9fbKQgXBHQDDizTPUAu/OO8nE25Jk1cs90LAatmXMZhXxJ2UcVWA
 vvw6ILx8UfR7A/D5v359rDmT6SlBdexPoHI8qRLw2Vqfo3wDbtfbi5GS17tpPxwNtmbcaNoxs1YCu
 ZKqKfOWQ==;
Received: from [31.4.134.245] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wrB9v-00Djzy-Gd; Tue, 04 Aug 2026 11:10:03 +0200
Message-ID: <12426722-4220-40c3-bce3-69068569e6b1@igalia.com>
Date: Tue, 4 Aug 2026 11:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH v3 3/5] drm/amd/display: use a separate helper to
 translate degamma curves
To: Alex Hung <alex.hung@amd.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 Xaver Hugl <xaver.hugl@kde.org>, robert.mader@posteo.de,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260623160112.1636801-1-mwen@igalia.com>
 <20260623160112.1636801-4-mwen@igalia.com>
 <6a705b70-dc0d-42de-a18d-cbc1a4698f71@amd.com>
 <690771f2-d540-4e8f-a450-6a1f00b8df9a@igalia.com>
 <68c132d8-bcae-4e61-ace3-2b9242aeb8c7@amd.com>
Content-Language: en-US
In-Reply-To: <68c132d8-bcae-4e61-ace3-2b9242aeb8c7@amd.com>
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



On 01/08/2026 03:41, Alex Hung wrote:
> I tested above on
>  - DCN35 - issue fiexed
>  - DCN401 - no issue and no regression.
>
> Does it pass DCN321 that you mentioned abouve?

Yes, with this change the kms_colorop passes on DCN321 and so far I 
don't see any visual regression on games.

I also checked that DCN2+ uses different CM helpers for degamma and 
gamma as well - but with 12 segments, which is the original distribution 
of _translate_curve_to_degamma_hw_format.
Just to say that the proposed approach isn't new.

>
> DCN301 doesn't use cm3_helper_translate_curve_to_degamma_hw_format() 
> so it wasn't affected.

Oh my, I wasn't expecting that! Banding was affecting both DCN301 and 
DCN321.
It was my fault, I overlooked DCN301, I'll extend the fix when we agree 
in the proper fix after Harry's review.

Thanks for the feedback,

Melissa

>
> The changes look good to me, but let's ask @Wentland, Harry for review 
> too. 

