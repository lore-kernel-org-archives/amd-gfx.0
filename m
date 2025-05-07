Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C108C3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 07:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB3B10E75F;
	Wed,  7 May 2025 07:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="Ez1Arzbw";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3273210E730
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 00:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=zZKq2VYLVrTR55LFDRvI18F3cQXBDBw2Zts2GwPpQLo=; b=Ez1ArzbwxwNsZkGE
 nE8fA0pstdG60mn+8VJXztq9joAJPqc63XHZQWfOjMdghK/bAMqOWX+Qx3twvJSzshE1noVKjK0+0
 l+kPmjkwr4tv6bvG6PuiuT9DA/2oNX1qexbqQuMDusYPUcH35GmfzyZSh6nt+A+Uz0wrHD7e35UYd
 NCtZjYlN15M066FbeqSr+lg0E1ZS6iz0Xe7WYv6fAXyIpTkRLDVXCwD2WQVaPs6nkaEk0wCGoFbmZ
 MjaqTagqx6Ci1p2IhyxCeDQ0lrQs9SFEZzMr+unQL0Iyq441uOTO2wJHgW9yFolNMMIbWJbdr+HBw
 AtnMvf2JhXAsRADzCg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uCShm-0021Pz-2M;
 Wed, 07 May 2025 00:32:10 +0000
Date: Wed, 7 May 2025 00:32:10 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: alexander.deucher@amd.com, kenneth.feng@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: questions about smu_mode2_reset_is_support and
 smu_v13_0_init_display_count
Message-ID: <aBqqCmYICO_C0nLT@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:27:05 up 9 days,  8:40,  1 user,  load average: 0.03, 0.04, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Mailman-Approved-At: Wed, 07 May 2025 07:41:51 +0000
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

Hi,
  I noticed two functions that are unused but I wasn't sure what to
do with them:

smu_v13_0_init_display_count() isn't called/wired up, where as the
v11 version is wired up:

 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
     3574:	.init_display_count = smu_v11_0_init_display_count,

so is v13 really unused or should it be wired up in a similar way?

secondly, smu_mode2_reset_is_support() is uncalled, but it's
the only caller through the mode2_reset_is_support() function
pointer; so if smu_mode2_reset_is_support() was deleted, does
it then make sense to clean up all of
  sienna_cichlid_is_mode2_reset_supported,
  aldebaran_is_mode2_reset_supported,
  smu_v13_0_6_is_mode2_reset_supported

which that function pointer is sett to.

Thanks in advance,

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
