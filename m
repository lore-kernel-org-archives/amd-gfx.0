Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274A3F3380F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 08:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F3710E589;
	Tue, 17 Mar 2026 08:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="DlEq/05P";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C0A110E3A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=rAMD9NUGsDWfV3M+fYKX8kA7EoKc4rzM4qI+LQYHKL4=; b=DlEq/05P/MoO3YG7
 6F/+K1V4UqSserW+sWWD49MqTqocDUfHnMbG6rBpnx4ch2uq+wOckl9nJO18I5Io1jOxmdeQl1RRa
 F3L79kfP7Wyd+7oSZoqNjSoTMbNG5bnuElpD+9KQ1LluqATMHRErl9XdKkld67B6Kj8u1SVZgf2Ml
 j0nUVO12AyzbCPFzC6vKFp9dorFMesmHi7+Mw9UeOCoH+D7iX+7vqV2W0JLCIzIQ9/i0ArPmHejcf
 jKDCKvDGtX5xDzd9RRVZK3Zow4MEY5+l1bwFmXJ1l2UH0xTIZkUTd3U8/GP1+nDOOmdgH2EObzeul
 Z6sF/iAmIsABrm4gNg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1w28m1-00000000gnP-2kGt;
 Mon, 16 Mar 2026 14:18:25 +0000
Date: Mon, 16 Mar 2026 14:18:25 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Subject: Re: oops/null pointer in 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
Message-ID: <abgRMTeW0UQDZkM5@gallifrey>
References: <abdVX_LJiNvkm4tW@gallifrey>
 <41627fc7-a0d8-44bf-982d-334f548d9f88@amd.com>
 <abf48cuwzRBczbeA@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <abf48cuwzRBczbeA@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 14:18:02 up 3 days, 15:31, 2 users, load average: 0.05, 0.05, 0.01
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:18:20 +0000
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

Raised as:
https://gitlab.freedesktop.org/drm/amd/-/issues/5081

Thanks,

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
