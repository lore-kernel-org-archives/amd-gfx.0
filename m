Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780E3C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 22:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F2910E196;
	Wed,  5 Feb 2025 22:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="FaqWcget";
	dkim-atps=neutral
X-Greylist: delayed 322 seconds by postgrey-1.36 at gabe;
 Wed, 05 Feb 2025 13:52:26 UTC
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4280110E7B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 13:52:26 +0000 (UTC)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4Yp1kJ2nYZzDrZm
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1738763224; bh=aBO6Njr6XZ088D0Xbb0fuqY185sWHCn6XheyHmgdlpY=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=FaqWcgetG3ajvaVVqAzeO8qFReT+aFyyZ26R6oC+EV+NUZ9a8ELMFqaxLL+C68nYA
 oKbuyyHDUmpqjO87f6MC0wl+/rbCm7M7H22QIgLjB7SPj2zff5oNOFrthgX+UVsAHc
 6msy0onSuiTvvhGxkTTN2qQdHKAjgYf0uupZdzy4=
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4Yp1kJ0MJSz9wD4;
 Wed,  5 Feb 2025 13:47:04 +0000 (UTC)
X-Riseup-User-ID: 01296C7F1F1C441121542775E33A159A5D9FEEA9392CBFEAE65F32C9893A90AE
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Yp1kG4xZBzFt5G;
 Wed,  5 Feb 2025 13:47:02 +0000 (UTC)
Message-ID: <a8219316-dc08-478f-905b-1e6eb356409f@riseup.net>
Date: Wed, 5 Feb 2025 10:47:00 -0300
MIME-Version: 1.0
Subject: Re: Rework and fix queue reset for gfx7-gfx10
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 timur.kristof@gmail.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20250204143113.6320-1-christian.koenig@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20250204143113.6320-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:38:15 +0000
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

Hi Christian,

Em 04/02/2025 11:31, Christian König escreveu:
> Hi guys,
> 
> I finally found time to work on queue reset a bit more and also gave it
> some more testing.
> 

How are you testing this series?
