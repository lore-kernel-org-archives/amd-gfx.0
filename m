Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2792FCD98EE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 08:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58FA10EEC8;
	Wed, 17 Jun 2026 08:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Vs+ZWAF5";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C36010EEC8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 08:56:39 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ggHll4jHxz9tDY;
 Wed, 17 Jun 2026 10:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781686595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+iPxfC5TMMNi1lfsggmVCGZmma3jL5bx6yHG+lPg8A=;
 b=Vs+ZWAF5wiWq2YV0EUiHkvhvN8AJ9PjDn1sYRiPUU2m1P0FOPChyE94vW0/Pg2EBA71T6X
 38ND77wRa+NedDxHKkWQ9d7n0HCMzztjI/VCNyoo8LJrwFOCgsJas4DOKR4B0Srahu39gq
 nnEqldZLltEzPDb1TZsHHiEeILReKwXH28EOF0wqvCW8Lb51MUNjstanKXiHmIW3emNE/4
 iTQoPSFjhZRLjMHulbbM1+U0FHZf8rCfw8yNthD6eZ6tSC4432nxN8mR5i+AeIzRKMxRcJ
 yQ7+0twyeCQ+DD/zWd4TZhUXOFFmvKwBkYKrvzrk4AWTjDLfPaXycTuCyHWUJQ==
Message-ID: <75732f3e-8ffd-4cac-b205-8f6cf705daab@mailbox.org>
Date: Wed, 17 Jun 2026 10:56:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
To: sunpeng.li@amd.com
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-3-sunpeng.li@amd.com>
 <a74f1233-d63f-4bcb-a379-3c9a6332cfb4@mailbox.org>
Content-Language: en-CA
In-Reply-To: <a74f1233-d63f-4bcb-a379-3c9a6332cfb4@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8huag9ouc4kdkionuhr7y8aczfmx86o8
X-MBO-RS-ID: df22362913b26cb4cec
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

On 6/17/26 10:07, Michel Dänzer wrote:
> On 6/16/26 22:18, sunpeng.li@amd.com wrote:
>>
>> * Add a flip_programmed completion. Arm it (reinit_completion) under
>>   event_lock together with prepare_flip_isr(), and signal it
>>   (complete_all) right after update_planes_and_stream_adapter() programs
>>   the flip. It starts in the "completed" state at crtc init.
> 
> Is the completion really necessary? Wouldn't moving the acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED assignment after the flip programming suffice?

Or even just moving the unlocking of event_lock after the flip programming.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
