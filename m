Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEF0CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 20:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2366B10E011;
	Mon, 17 Nov 2025 20:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mCWCN6vu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13BF10E011
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 20:16:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 642FE40C23;
 Mon, 17 Nov 2025 20:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044B8C2BC87;
 Mon, 17 Nov 2025 20:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763410581;
 bh=Ephs7TEMiR02AlA3aBeK2i5yivYkmLUNO9OVys6Up+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mCWCN6vudi7mcc4NtiUc3/UKmuMkSBQ8aSdvROti+EXF2KZpYE/8FIhDnrPh8zdCo
 PAl9KzsCbYvD8ldr85vE+igPXnmQZp5PGEZsHCfwelGHY4U8K+NiIC8Yg8edsNuJ81
 am/yAnHv/6yXU4bU2a8cvgy4ndisHinTWQElW4vrkxIogi8tWMBpKOr6qJXG4xpRJ8
 JmdaedlvhBoovWGJqLOvYuFELe9E3uzxrqFG4RhGSmWr5NFa4uxK9yshJI1K9rC0/1
 Up3dld3dd+5s5/mhA1x7OkpLaz0YbMqqhqEqHpcgN6tbxFIdGwBQ1Fsx65DtAx1rAy
 de/MbXYjEiKAg==
Date: Mon, 17 Nov 2025 12:16:19 -0800
From: Kees Cook <kees@kernel.org>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com,
 Alex.Hung@amd.com, Wenjing.Liu@amd.com, Chris.Park@amd.com,
 Yu.Wang4@amd.com
Subject: Re: [PATCH 1/4] drm/amd/display: Fix warning for analog stream
 encoders
Message-ID: <202511171214.FAFD75DD0@keescook>
References: <20251113163348.137315-1-timur.kristof@gmail.com>
 <20251113163348.137315-2-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113163348.137315-2-timur.kristof@gmail.com>
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

On Thu, Nov 13, 2025 at 05:33:45PM +0100, Timur Kristóf wrote:
> Fixes the following warning that some users are reporting
> with some kernel configurations:
> 
> "positional initialization of field in 'struct' declared
> with 'designated_init' attribute"

Yes, seen with CONFIG_RANDSTRUCT=y

Thanks for the fix!

> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>


Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
