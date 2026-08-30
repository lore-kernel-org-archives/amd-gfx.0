Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BD2C624CC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 07:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540BE10E6B6;
	Mon, 31 Aug 2026 07:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rawbw.com header.i=@rawbw.com header.b="Vd6X3REn";
	dkim-atps=neutral
X-Greylist: delayed 2098 seconds by postgrey-1.36 at gabe;
 Sun, 30 Aug 2026 08:29:00 UTC
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0AA8110E111
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Aug 2026 08:29:00 +0000 (UTC)
Received: from [192.168.5.3] ([24.6.215.85]) (authenticated bits=0)
 by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 67U7s0ge097815
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Aug 2026 00:54:01 -0700 (PDT)
 (envelope-from yuri@rawbw.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rawbw.com; s=apr2026;
 t=1788076441; bh=GKOuYkAiFgOPJcuq9pbFucejivoIvuqI8l7z6M4+88w=;
 h=Date:To:From:Subject;
 b=Vd6X3REnIvqcSBRN0iR59TttFVMy/zx+NqnHIG9gJ0cERGvJtiNjmWWP46f3dMWS0
 0PudtJwDBql7yHM+1PhMI5xSMb0vCv0oR+dO4nCYQAlubS6WyMsQmG/156sqsxUxEI
 3vrYDSWcsShHcNEhuHXeA5XjTETr8Eeea6bDdniE=
X-Authentication-Warning: shell1.rawbw.com: Host [24.6.215.85] claimed to be
 [192.168.5.3]
Message-ID: <24915fec-468c-48f6-85cc-da7b008b937f@rawbw.com>
Date: Sun, 30 Aug 2026 00:53:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: Yuri <yuri@rawbw.com>
Subject: error messages "[drm] Fence fallback timer expired on ring gfx_0.0.0"
 are printed after which Xorg becomes unusable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:04:50 +0000
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

On FreeBSD 15 the amdgpu kernel module built from sources from 
https://github.com/ROCm/amdgpu prints fence fallback messages after 
which Xorg becomes extremely slow.

More details are in this GitHub issue: 
https://github.com/ROCm/amdgpu/issues/229

Googling reveals that a lot of linux users also have the same problem.


Is there a fix for this bug?



Thank you,

Yuri


