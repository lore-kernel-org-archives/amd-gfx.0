Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E35DCCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 19:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4332E10E189;
	Wed, 22 Oct 2025 19:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LZQtwzEN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A5A10E185;
 Wed, 22 Oct 2025 19:51:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C220643943;
 Wed, 22 Oct 2025 19:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF08C4CEF7;
 Wed, 22 Oct 2025 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761162709;
 bh=kF8M1ukm9xGapZ/jKqRQMIpbqRUBVSKbENvZsAKmZgc=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=LZQtwzEN3EqAb1gjJE8BKiTqz0ipovvjYNpt/r2pSOYirwE/mwjX8gqJ51Ej5rO0P
 DUmJFvHNPMVVhNj/cvfDPZH0pA1rNLKOK5XnS/Oy0z779amgCpPFaXgDz9uuZdOt+4
 DwKiTUUI8Zvz8j8oC2IQZREJXBuGiPOQYnXF0iobDFW1epTJL1Qz+jbSvGjqscA33R
 Q5jO12lDeEXWCZnrMwhtGjiiRUTqeRSdTgP3LJ6yuZXpKKy9QNybIeDiUPTKDmFiSR
 fE28XhoBraxZciC2yy/Jq0l936ubYQNTxtVbxPlgf0f8x+7HBWTBYy03n7PbvkLvTd
 8F4Gz6oNvwztw==
Message-ID: <84f5971a-9a0c-4cc3-89a3-1eb1855aa862@kernel.org>
Date: Wed, 22 Oct 2025 14:51:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] drm/amd: Re-introduce property to control adaptive
 backlight modulation
To: Xaver Hugl <xaver.hugl@kde.org>
References: <20250718192045.2091650-1-superm1@kernel.org>
 <20250718192045.2091650-2-superm1@kernel.org>
 <CAFZQkGwvu-aLC4j5+=oohT8qcF8y4gBCDfkKYy7V9t8HY9q-Fg@mail.gmail.com>
Content-Language: en-US
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Simon Ser <contact@emersion.fr>, Harry Wentland <Harry.Wentland@amd.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Leo Li <sunpeng.li@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAFZQkGwvu-aLC4j5+=oohT8qcF8y4gBCDfkKYy7V9t8HY9q-Fg@mail.gmail.com>
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

On 7/18/25 7:23 PM, Xaver Hugl wrote:
> Looks like a reasonable approach to me. Thanks for following up on it!
> 
> I'll look into a KWin implementation soon.
> 
> - Xaver
> 

Xaver,

Is this still on your TODO list?
