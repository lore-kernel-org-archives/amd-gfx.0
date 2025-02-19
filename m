Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C628BC021B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 18:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5E810E873;
	Wed, 19 Feb 2025 18:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lPdPzJqW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AC410E36A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 18:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=akHLByESjhAZIdirUO+hq68gdgMh4KX2vVVmGox+LUA=; b=lPdPzJqWh9ItaRTXq608inXMoI
 /qML2dL16PX7Q9qIr5hMjpVDKmdyHjoKhA+xJMCcR+xvNlDG68IHHS0zmU0Akp5q8CqUTVeIRN/VV
 H2b5KEBjni7cQQpluquYCgn3Wg4Zp4urVz2EepDu0XsL/kSSnkg82+gja6603wcwXuWAIeW97YzkA
 x5HCTUjbiibPBRhwkFVdlQMkjuR8Rs818dHCBkDCGGh8YoZ99dFTv0my7cXFmDuMmOB7WdyO0werJ
 P+5Ulu/dKy4m1X2++XQfh3Z+srGzzXoeC6cMr0OIDcaPzcJZ4idfEC2UERixtw0MxTzAO6WM3GHxS
 ib1cKO/A==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tkp6M-00EwF0-DV; Wed, 19 Feb 2025 19:47:24 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/2] Add myself as a Reviewer of AMD display and update mailmap
Date: Wed, 19 Feb 2025 11:46:18 -0700
Message-ID: <20250219184702.242924-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
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

This patchset changes my status from a Maintainer of the display code to
a reviewer, and it also adds an entry to my name in the mailmap file.

Thanks
Siqueira

Rodrigo Siqueira (2):
  MAINTAINERS: Change my role from Maintainer to Reviewer
  mailmap: Add entry for Rodrigo Siqueira

 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.48.1

