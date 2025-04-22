Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C1AC369D7
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 07:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B256110E410;
	Wed, 23 Apr 2025 07:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=tnxip.de header.i=@tnxip.de header.b="udVglPLk";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="5N0swRhc";
	dkim=pass (1024-bit key; secure) header.d=tnxip.de header.i=@tnxip.de header.b="vHLhOeVo";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="9cRJuF/S";
	dkim-atps=neutral
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388CA10E32E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 17:14:06 +0000 (UTC)
Received: from gw.tnxip.de (unknown
 [IPv6:fdc7:1cc3:ec03:1:53ff:b0bd:adc1:f59b])
 by mail.tnxip.de (Postfix) with ESMTPS id A66A9208AD;
 Tue, 22 Apr 2025 19:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps; 
 t=1745342040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmhjuH+w65IlrJW3d0eREmPSmX6+6SCmrTB2F4r0QYo=;
 b=udVglPLkUgWKgPY7gK+DmQTNUQw/5Jui1p+WyRenHmv8Kup/5fIexGHgdfdd5lk/ax5nl5
 19edY2nwkr52qMu9UrRWpfF57OMPuTDIQOUpL7aqyxvoqqt1EuQXivswZkC1V9P+KmQkvK
 fdoIHKrMiPREivDm7xceI2Ub/k60tiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
 s=mail-vps-ed; t=1745342040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmhjuH+w65IlrJW3d0eREmPSmX6+6SCmrTB2F4r0QYo=;
 b=5N0swRhcGR17xI9DMMaCjNVyOPxvD0sOEl/nnuB7D49XRw0gYPN2QWlaXyQOgSL7HyqloQ
 4igYFQCJcJ0aWYDQ==
Received: from [IPV6:2a04:4540:8c0e:8d00:d82a:67de:9a1a:30a4] (unknown
 [IPv6:2a04:4540:8c0e:8d00:d82a:67de:9a1a:30a4])
 by gw.tnxip.de (Postfix) with ESMTPSA id 637FD7800000000000716;
 Tue, 22 Apr 2025 19:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
 t=1745342039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmhjuH+w65IlrJW3d0eREmPSmX6+6SCmrTB2F4r0QYo=;
 b=vHLhOeVoFLRncLODnvVKKp1yvofyTdtb6OJA3tEi5WI3LgrqzLAaiA9vnbKQVV3GHUWJPk
 uyTMhUqS8hisrhM1Ut8cqzWzxBDLxGm5/T5VF2TRUGr+eqx/RQRH0sze1EYLNENdjBPxKD
 pkao3iXy/fu4kZ4MacgvXgwT0wtJBIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
 s=mail-gw-ed; t=1745342039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmhjuH+w65IlrJW3d0eREmPSmX6+6SCmrTB2F4r0QYo=;
 b=9cRJuF/SPs1C6t2K2d9DjhUaWJUjEuqMXtOj1Vgpt/JoTCcx2upcAEE1mX7IsBMonHq0hH
 ZJzt3Y51NbeA3NBg==
Message-ID: <16cafbef-2acc-4c45-9d9d-ee88e0ebe6fb@tnxip.de>
Date: Tue, 22 Apr 2025 19:13:55 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: possible bug with RDNA4 and AMS
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: amd-gfx@lists.freedesktop.org
References: <63d93ed2-1ace-430f-980d-27199ffc5b3e@tnxip.de>
 <ef362484-b1a1-4175-a519-8335409f1146@mailbox.org>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <ef362484-b1a1-4175-a519-8335409f1146@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Apr 2025 07:38:20 +0000
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

On 22/04/2025 17:28, Michel Dänzer wrote:
> On 2025-04-20 21:38, Malte Schröder wrote:
>> Hi,
>>
>> finally found this list, I hope it's the right place for this. I
>> recently swapped my trusty RX 6900 XT with a shiny new RX 9070 XT (aka
>> RDNA2 to 4). Now, when I start kwin_wayland my desktop is a flickering
>> mess. As a workaround I can set KWIN_DRM_NO_AMS, it is working with
>> this. Afaik this disables the use of atomic mode setting. So I guess
>> there is a bug in either amdgpu kernel side, libdrm or mesa.
> FWIW, if it's a user-space issue, it's most likely in kwin. Mesa doesn't use KMS directly in this scenario, and libdrm is just a thin wrapper around KMS ioctls.
>
I only encountered this issue after upgrading my GPU. My config has been
running fine with the Navi21 GPU.


Anyways, I found there is already an open ticket:

https://gitlab.freedesktop.org/drm/amd/-/issues/4057

I also was hitting https://gitlab.freedesktop.org/drm/amd/-/issues/4144.


Strange that I didn't manage to find these. My search engine foo must
have been weak...


Regards

Malte

