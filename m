Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5671DCD343F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D5A10F228;
	Thu, 21 May 2026 07:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tB5FZKeN";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B47F10F236
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 07:09:56 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gLfg45Sgcz9tpJ;
 Thu, 21 May 2026 09:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779347392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/zMEZ6/GXxSl+3k6vtiwDmLcvBcMDoINgY5t6obceA=;
 b=tB5FZKeNvY7BRG7HjpP9yYg8LHWSeBBdGTPnuKsJ/RQJcMDPp915CMWYbGdGmp+4zpfc7w
 hTjNRoAYpgOpjMoOdoHWFZDNEninuXf/4LEi9WwaxML+lzq95Hosrrb8oVs3SUEdW8MYrP
 XG4V8E4EboRHENmj2y4CTrysW4M0BQ977VhCdD25sIKm0sfFnz4UhSezI5Qt5l7F0jn3us
 tZ7PX5nzr9LPwrI+i+DMvjhVOWRv1BEb9LEuiw3Z5XUm+QvDEs31J5Zf8IqMtBPL7xtXaN
 ds7G8W05meeMPWK7WDIF+F2aRxLUnfwGKBDERqZrNB9I/m/bUH05FKLpHhlgww==
Message-ID: <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
Date: Thu, 21 May 2026 09:09:50 +0200
MIME-Version: 1.0
Subject: Re: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
To: Pei-Hsin Yang <peihsiny@valvesoftware.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
 <16231b1742004f848af243ce398281ec@valvesoftware.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <16231b1742004f848af243ce398281ec@valvesoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1a77141502dec633624
X-MBO-RS-META: nyoi1m8fntatxmar8kdri8wduwn9a1qr
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

On 5/20/26 17:54, Pei-Hsin Yang wrote:
> 
>> Tested with 3 HDMI sinks with different FreeSync/HDMI VRR capabilities.  I saw one case that a FreeSync sink (Dell S2721HS) with E6h VCP code supported was detected as FreeSync capable at beginning but identified as not FreeSync capable later – after do_mccs is changed from true to false.
> 
>>> And that doesn't happen without my patch applied?
> 
> There are other issues without your patch applied.   One issue is that if a FreeSync capable sink with MCCS VCP Code = 0 (mostly are TVs), it will be detected as not FreeSync supported and VRR will be disabled.

That sounds similar to https://gitlab.freedesktop.org/drm/amd/-/work_items/5286 .


I was wondering if the specific issue you described above with Dell S2721HS is reproducible without my patch though, in which case it might be a separate regression (and wouldn't speak against merging my patch).


>>> TBH I don't really want to be fixing the regression I hit, I'd prefer the AMD display team to handle it.
> 
> Yes, agreed.  As FreeSync MCCS support has immediate impacts to Valve's Steam devices, I will work with AMD display team to handle it.   HDMI 2.1 VRR and VTEM packet sending support need to be included as well.

Note that some kind of short-term solution is needed for the regression(s) in 7.1-rc.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
