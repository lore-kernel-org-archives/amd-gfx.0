Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FCFCA0FF6
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 07:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F44D10E73E;
	Wed, 27 Aug 2025 07:56:59 +0000 (UTC)
X-Greylist: delayed 322 seconds by postgrey-1.36 at gabe;
 Tue, 26 Aug 2025 17:16:22 UTC
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87B410E080
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 17:16:22 +0000 (UTC)
Received: from [192.168.4.18] (unknown [62.77.71.229])
 by mx.gpxsee.org (Postfix) with ESMTPSA id E0A525450F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 19:10:53 +0200 (CEST)
Message-ID: <c285c72e-08de-46f9-b30a-a938c722d3ad@gpxsee.org>
Date: Tue, 26 Aug 2025 19:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
Subject: radeon module hangs boot on HD 7450 and Linux 6.17-RC1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 27 Aug 2025 07:56:57 +0000
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
While working on our mgb4 driver with the "next" v4l2 git 
(https://git.linuxtv.org/media.git/log/) branch my machine with a Radeon 
HD 7450 hangs during boot and the monitor looses signal. If I disable 
the radeon module, the machine boots fine (to some kind of VGA 
fallback), so I suspect the bug is in the radeon module. With the Arch 
distribution kernel - 6.16.3 - the machine boots fine.

The media.git "next" branch identifies as 6.17-RC1, so it may not be the 
latest radeon code available. If the issue has been fixed since than 
sorry for my spam, otherwise please provide some info how I can help you 
to debug the issue.

M.
