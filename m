Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A3C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 10:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A841C60FF0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 10:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A841C60FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 534E26E08E;
	Wed,  7 Jul 2021 10:46:40 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF4D6E08E;
 Wed,  7 Jul 2021 10:46:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8815C61CAA;
 Wed,  7 Jul 2021 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625654797;
 bh=x/6yJbDlJx88gXff2NPaDoOf2VTEmW/FiSuagMfWqrE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DeSb7RTenYR1UxkiWCo6aig5ZaRjJCOaklGoahkm78lFkC7RH6QMYEC6DGriMJnFZ
 MjTG84pV43p9AGNw5QcyjNi5ISj4L6msunpox/EgkIsIFrK10P6LQO/zkhAtyvKwsB
 rNdDnEKkMhFito12aHrPihmkN9G4u5/sc1TLRPy6xuiaiFCtakU67dptaeszT//Ope
 Q8x3sbojAks+WaQHC4pSb28iGhVWeISBoa5xXgLZqOmkss+XIW1/I9m6G8STIUpA3R
 /gZUWs9Lqmpxl+JxTf77MmGgyQFuZXRTrSXTz+0RGcslFjui0OEJvBQ/XscTjNaWyR
 yxszLHWpW3qtg==
Date: Wed, 7 Jul 2021 06:46:36 -0400
From: Sasha Levin <sashal@kernel.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH AUTOSEL 5.13 113/189] drm/amdgpu/gfx9: fix the doorbell
 missing when in CGPG issue.
Message-ID: <YOWGDHa3fdUPsdRS@sashalap>
References: <20210706111409.2058071-1-sashal@kernel.org>
 <20210706111409.2058071-113-sashal@kernel.org>
 <CADnq5_ObmVRjwUB5Lw0bLZLL-+=CqvGkJZ+2DY5ZDh+uN-oo0g@mail.gmail.com>
 <affee955-54bc-11c3-8ccd-5678f7aee687@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <affee955-54bc-11c3-8ccd-5678f7aee687@amd.com>
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "for 3.8" <stable@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 06, 2021 at 07:09:37PM -0400, Felix Kuehling wrote:
>Am 2021-07-06 um 5:44 p.m. schrieb Alex Deucher:
>> On Tue, Jul 6, 2021 at 7:16 AM Sasha Levin <sashal@kernel.org> wrote:
>>> From: Yifan Zhang <yifan1.zhang@amd.com>
>>>
>>> [ Upstream commit 631003101c516ea29a74aee59666708857b9a805 ]
>>>
>>> If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
>>> Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.
>>>
>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> This should be dropped.  It was already reverted.
>
>Patch 146 of this series is the corresponding revert.

I'll drop both, thanks!

-- 
Thanks,
Sasha
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
