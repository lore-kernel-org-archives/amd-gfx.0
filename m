Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03988C54FD2
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 13:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5C810EC1D;
	Wed, 29 Jul 2026 13:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="G1GUsFu7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A8510E366
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 18:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=H7KesrSOy2zbVR1p7ltMlJUXDVscXUX/ya7vqI1dzrU=; b=G1GUsFu7SyEWGmR0L4N5pzUZRf
 6usW/kIzfMwdSqvKvUaH5KB8wF8/vxOfj06DM35HtdDDWSeYTgj6vkBwvkDQN1FlzxiVpFc4wdpse
 rkpB13wZNWTkPdWYrEQ9lBHEnaX3jkrC31guyJw7R8WfHOSHMWVR2/P8EzCpcvnNL1dkff6u4tvkP
 gxpxTzu9F4Dvtp0vP0Tuj/sDW8ONy4FFK5nD8LBwpKQK+aaMRAnMItF9Lxqt27yklfP0c6DmWkNmj
 VI7dPmwzIwveNOIFelrmccHH73WMjp6lhaifRMMc3+9dk5l1o2OVABTLmaf19rG9AQ1B7TUsJUz6N
 8wisqAsA==;
Received: from [179.118.190.213] (helo=[192.168.15.100])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1womLm-0076me-5Q; Tue, 28 Jul 2026 20:16:22 +0200
Message-ID: <7ad49dd9-1c05-453e-9bb1-e80542f1a1b8@igalia.com>
Date: Tue, 28 Jul 2026 15:16:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
To: Fares Soliman <Fares.Soliman@amd.com>
Cc: Richardqi.Liang@amd.com, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20260713132624.1173426-1-Fares.Soliman@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260713132624.1173426-1-Fares.Soliman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:16:19 +0000
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

Em 13/07/2026 10:26, Fares Soliman escreveu:
> Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs
> on Van Gogh. Logs are now gathered live rather than starting then
> stopping logging and reading an average value afterwards. This is
> in accordance to changes made in PMFW.
> 
> In regards to messageID 0x52, the old interface uses a start/stop
> parameter, and the new one doesn't. The firmware is checked to
> determine which method to use.
> 
> v2: added firmware guard to new interface, old interface kept as
> fallback
> 
> Signed-off-by: Fares Soliman <Fares.Soliman@amd.com>
Tested-by: André Almeida <andrealmeid@igalia.com> (on Steam Deck)

Thanks!
	André
