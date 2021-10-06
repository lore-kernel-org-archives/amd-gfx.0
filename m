Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011A4C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35BE6109F
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B35BE6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2916ECA1;
	Wed,  6 Oct 2021 14:08:27 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B8E6ECA1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:08:25 +0000 (UTC)
Date: Wed, 06 Oct 2021 14:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1633529303;
 bh=W7+v/Q7HiNgBHED8N9sHTCgJ5UEnKCJfMEeHCyPLzZg=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=H0hf9Gsu6l/unhArVwfIYFJTYuq9/tYop4jqNERl8NjqfhJTq1UW91kdVfq0pXZBj
 aioeKoAPf8OuM8oa+GE8t45xWf+yb7r2zDKYDAeHo/F+89RxkTsXoQSrNgHW/nI479
 nrNZMGW8rezVEDeMrBTaoYyGjxdCupCRWOsnLHmdCMtVid0eaMaZNR+P9tCcpv79rK
 mmOAC7oF/dy5BufFkV7fX8MtFai6lbLz4P2kWyRmd4T1g9+IQ1t1DXit6N7N1g9gwr
 k+Xs13SmB42uT9tNicpJpiBtJmMBG2T09qJpbtCMKILIQ7nHfj0cLIY6+cVFJr3QAD
 zvj6sktfaVyZw==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: Re: [PATCH v3 2/2] amd/display: only require overlay plane to cover
 whole CRTC on ChromeOS
Message-ID: <iSzX378wuJOms7J-eRLYJNN1phBcu732mWieyfGNfDnq-pF5oUIlEATuRcV-p3NObZw9UuYkwNOjjCPcp8WB8-T9teWs4STJgU7tUcpLBVM=@emersion.fr>
In-Reply-To: <20f3da02-7b70-1681-1621-7c389f23829f@amd.com>
References: <20210929190603.48890-1-contact@emersion.fr>
 <20210929190603.48890-2-contact@emersion.fr>
 <20f3da02-7b70-1681-1621-7c389f23829f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> current->comm is "DrmThread" on my ChromeOS system.

Oops! I forgot that current->comm could be overwritten by user-space. Sent =
v4
which should address this by checking the executable name too.
