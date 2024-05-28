Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62907C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 04:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5AC10F0A4;
	Tue, 28 May 2024 04:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="VIPCyD2S";
	dkim-atps=neutral
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723BD10F0A4;
 Tue, 28 May 2024 04:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716871751;
 bh=QLmgAJzolqzFH/dtnJctKhD18IPbLfTaeUCOixohl8Y=;
 h=Date:From:To:Cc:Subject:From;
 b=VIPCyD2Sz6TtVjM8Aph7AhKnwC4It4aLGKB0bcePOD4FzZCoqPJg6bC2VnwvLQqAI
 nffg2T64Yv06gckUttdxVq2tYgx6/f8kAvIMMEkItcAkPnrnWPJ3cV81GjO94DBd74
 YZMLDDN00Y1FCphwiN6UBpSQqfiHQXEHjHsE39WXctHv+ANLg6qIbEJyjU3n4KkNHb
 4htW0kTOeGxyziHjp9+DBIx7PyhF3TLn1nHvc01DMyL30+S+pszVDeg/XRfyF5DiPW
 Qn8Yrm2j3xHGfupVDmXO71MhlIKPkqPgDcQmiMSCUHRShdKFlUtRJIROkOWBDgzTqt
 d2vckxQP/CQYw==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id C64563782137;
 Tue, 28 May 2024 04:49:08 +0000 (UTC)
Message-ID: <3542730f-b8d7-404d-a947-b7a5e95d661c@collabora.com>
Date: Tue, 28 May 2024 10:19:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Hawking.Zhang@amd.com,
 lijo.lazar@amd.com, felix.kuehling@amd.com, srinivasan.shanmugam@amd.com,
 Daniel Stone <daniels@collabora.com>,
 Helen Mae Koike Fornazier <helen.koike@collabora.com>
Subject: drm-ci: flaky tests for amdgpu driver testing
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

Hi Maintainers,

There are some flaky tests reported for amdgpu driver testing in drm-ci.

# Board Name: hp-11A-G6-EE-grunt
# IGT Version: 1.28-g0df7b9b97
# Linux Version: 6.9.0-rc7
# Failure Rate: 50
kms_async_flips@async-flip-with-page-flip-events
kms_async_flips@crc
kms_plane@pixel-format-source-clamping

Will add these tests in 
drivers/gpu/drm/ci/xfails/amdgpu-stoney-flakes.txt 
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/gpu/automated_testing.rst#n70)

Please could you have a look at these test results and let us know if 
you need more information. Thank you.

Regards,
Vignesh
