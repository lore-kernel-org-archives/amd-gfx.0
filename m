Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B761CD37B9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 07:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BB310E4BF;
	Mon, 11 May 2026 07:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="GQQscsFi";
	dkim-atps=neutral
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4881C10E04C
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2026 00:37:00 +0000 (UTC)
Message-ID: <f4f50339-e1ad-4082-a669-8a0dd78720dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778287018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5iJBLZZZkoJSzb0I/MaSOhYRrwlcgvj54y4s369O8F4=;
 b=GQQscsFi/HkgF5RC/yNtWNyMcTvXK4Fx/zXg9FCKGN5TP4sKRubBbgx3N4xnsefvN1pJr2
 ABP954vydhfsCWg/kHA1rcYzkcGREv9bQOqXwhUa2yTMRddf5GxLvDfg+WpyLviDr1beYQ
 d+w96f8zF0M2CPCOIvePXAcMPPtHVPQ=
Date: Fri, 8 May 2026 17:36:53 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Ray Wu <ray.wu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Leo Li <sunpeng.li@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Regression in backlight control after 20f5481aaf17 ("drm/amd/display:
 Add power module on Linux")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 11 May 2026 07:30:27 +0000
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

Hello,

On my Legion Go S, which has an IPS LCD screen, the brightness slider in Steam becomes very unbalanced on amd-staging-drm-next, with the bottom 45% of the slider no longer appearing to be any different than the minimum value. After bisecting, I landed on 20f5481aaf17 ("drm/amd/display: Add power module on Linux") as the first bad commit.

I uploaded a dmesg from a good kernel vs a bad kernel below.

Last good kernel: https://gist.github.com/matte-schwartz/e98e4d3e1d8d3c4c042e2a76450b48b1
First bad kernel: https://gist.github.com/matte-schwartz/5ef4f6967a17bc534e81f79e5cf71e02

Let me know if there are any additional details I can provide to help with debugging this further.

Thanks,
Matt
