Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F485E7719A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 08:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FAC10E5BC;
	Mon,  6 Jan 2025 08:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=panix.com header.i=@panix.com header.b="XDL/7ttT";
	dkim-atps=neutral
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B8B10E577
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 04:56:49 +0000 (UTC)
Received: from mail.panix.com (mailbackend.panix.com [166.84.1.89])
 by mailbackend.panix.com (Postfix) with ESMTPA id 4YRMNJ0xCcz4608;
 Sun,  5 Jan 2025 23:56:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1736139408; bh=uc7tqqF6YIVC0BpiNeb4gNwFWkk7DvylEEbXIu3HrHE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XDL/7ttTX9QJ4wj/BobiaCwW1cjGwASHb5vp/lrVSQJ3OivqPq84rWobxoAaEHaG6
 +y26i/Jm4d9YqVQonJL5GQfRNZJON7nkV66jFA/57wn3cXu2Ngwz4+7ZId9fX+QVPW
 vA5yG5u4yxs+B6SXeehG6Z8GE9blhoB2Hr98HNzg=
MIME-Version: 1.0
Date: Sun, 05 Jan 2025 23:56:48 -0500
From: Pierre Asselin <pa@panix.com>
To: me@svmhdvn.name, alexdeucher@gmail.com
Cc: Xinhui.Pan@amd.com, stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Subject: Re: [REGRESSION] amdgpu: thinkpad e495 backlight brightness resets
 after suspend
In-Reply-To: <4YRLq93qSpz1ZSy@panix2.panix.com>
References: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
 <CADnq5_M-aPD6tNppQ3_6dC8dgt7zeLXZPE5CdCjQEuEDxS=mWA@mail.gmail.com>
 <4YRLq93qSpz1ZSy@panix2.panix.com>
Message-ID: <20d7e3ef9645b4440adfdbd83b0f33a1@panix.com>
X-Sender: pa@panix.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 06 Jan 2025 08:41:41 +0000
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

On 2025-01-05 23:31, Pierre Asselin wrote:
> Alex Deucher <alexdeucher@gmail.com> wrote:
>> Please file a ticket here:
>> https://gitlab.freedesktop.org/drm/amd/-/issues
>> and attach your full dmesg output and we'll take a look.

See https://gitlab.freedesktop.org/drm/amd/-/issues/3879 .

Sorry for the stray email earlier.
--PA
