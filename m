Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43B6E9A03B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 15:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4164110E023;
	Thu, 19 Feb 2026 15:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="YTnJ6TvB";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7E010E023
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1771516570; bh=jE2A3dsw917KNDecUWJNPvfTdN/5jI1GVsVEIfU1miY=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=YTnJ6TvBxdXOqm9RxJSD2PRUBL6bxB4YpCA/3sFRX+/R/+v9+8onazFfVWY0MXbM+
 UK9mJS5tkPgFaIlQO5gWDrte4R4b2dpcxB37QGNmhWPYi1y8kjfUhshoRGRTPQqnbD
 CsLdvsTLZsYf7C9QCu5N4Zi5he+1KgLjkeyqnmX8z6tC75OicWKTN4O+2dd5Rxc9XE
 1di3WofuHsCQQyWjXlxun9ytXqe+IXVlJMQNLEnwiNjKCbsEdRSlEshryq0F2ysKLB
 +HFNRoe55x+99rv5yxaDa/pw0eD5kDpJLDrffzaiHdI0pjtNb9YPuH6Wzag++MWI9C
 jvH3iUWzjYUHg==
Message-ID: <6b91ca71-40fe-4be3-b007-cda351580d39@m1k.cloud>
Date: Thu, 19 Feb 2026 16:56:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20260218003104.1256473-1-sysdadmin@m1k.cloud>
 <02cb98e2-5666-45ca-be15-93c93f517238@mailbox.org>
 <44af0f28-8731-4c54-8bf6-0e844eb14b14@m1k.cloud>
 <d2d820a1-0320-4047-8837-2fed0186f4cf@mailbox.org>
 <001df5d5-4602-47f6-9d04-5c94f83d40d0@m1k.cloud>
 <43954b65-db3c-4f6b-837f-e025ac84788f@mailbox.org>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <43954b65-db3c-4f6b-837f-e025ac84788f@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 2/19/26 14:59, Michel Dänzer wrote:
> Can't the issue be solved by fixing the pflip_status handling in the vblank handler?
> I guess that might also hit the second race condition:
> 
>> - If vblank is disabled by the off-delay timer before the handler
>>    runs, the PENDING cursor event is never delivered and the commit hangs.
> 
> That sounds like the drm_crtc_vblank_get/put handling might be incorrect in amdgpu_dm.
> 
> In a nutshell, the vblank interrupt is kept enabled as long as there have been more
> drm_crtc_vblank_get calls than _put ones for the CRTC. I.e. amdgpu_dm needs to call the former under circumstances where it needs the interrupt to be on, and the latter only once it's no longer needed for those circumstances (in this case when sending the event).


The get/put pairing seems correct, the issue is that cursor and pflip 
share the same acrtc->event slot, so the pflip_status check in the 
vblank handler can race. Adding a dedicated cursor_event field, separate 
from event used by pflip, could maybe solve the whole thing?
