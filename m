Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F17C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 17:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580D110E3AA;
	Tue,  9 May 2023 17:04:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F0E10E3AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZAL435+bwIcrf9eliPQy89ghfgZCyX3Nyq/IBZTyePU=; b=e1g5Gb8Z23Q3B+kndP9lGS449a
 rp//RmA6CyJZE446gHVbBxs4E3Ki+IyuIvJCTn5ccwY26VWqiq885qI/IGhHJX+altwZpXtK7hNgg
 NKvU+9hKR0Gj+A8Ti457saAP9ZnB2HvzhjiPiC4nnl0QfYTjSeWuqep5UDTNypAAxGVCNW9+QzBVr
 5OTvYNesIDEstO1RsaL9ukLPlCnn/UKLNXD5sP+Jjz2tc+DAtQuet9cAiM6+SSCFgJL54Bh8dOTN/
 b8g4QKu8rZLEWkPQhOB/H244pkxNgRD7CXO6TFbS/ADSBuwYFgdGjtjAFKNkF/tXXtX6vuRwjkhFV
 93vQz77w==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pwQia-0053Zc-Jb; Tue, 09 May 2023 19:01:40 +0200
Message-ID: <0c6d481c-02ba-cf89-3333-4517255b8042@igalia.com>
Date: Tue, 9 May 2023 14:01:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx11: Adjust gfxoff before powergating on
 gfx11 as well
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230509164947.455753-1-bas@basnieuwenhuizen.nl>
 <20230509164947.455753-2-bas@basnieuwenhuizen.nl>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230509164947.455753-2-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 09 May 2023 17:04:25 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09/05/2023 13:49, Bas Nieuwenhuizen wrote:
> From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> 
> (Bas: speculative change to mirror gfx10/gfx9)
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---

Thanks a lot for both patches Bas! This second one, despite I've
attached it on gitlab, you should also Sign-off since you're the one
sending it to the ML (I guess heh)

BTW, I couldn't test this one since I don't have GFX11 HW, so appreciate
if anyone from AMD (or any community member) could give it a try...

Cheers,


Guilherme
