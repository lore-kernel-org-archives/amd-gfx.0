Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382E2CFC274
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E052B10E52F;
	Tue, 15 Oct 2024 08:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="iSO2W6VF";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZQsNhQxD";
	dkim-atps=neutral
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F7210E296
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 03:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1728964576; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=S7OIMgRlV4Xrj3QADGuxnIDb8HtFVUbFmdB/VIOcNrVRiSXwgDhytFtulj9m/xsAso
 BAimUAvmje81PgA4Yk+CiyYZejz1rv4SZyQOnkb9K3b9L2tDwex7CLnY2cGtKTGbSGyN
 XzwlyCaOtaJWPdLHx+PkHVhONnn3I9+eZFS55iEylZHiqynAxW3JmZ7yVk/iwYZvtwk4
 1o0U4337eTDUUgOka90P+nlPP4IvT1RODN1jPZc0ac+iANaNUa7j+4Mrb951hy8HtjaP
 BlmbMOBrppVBqyrfYMGjg+ITWiHSd7VzNiu7EIVMgQFR+m/e29CYEFQOeEcO26xvy+J9
 DfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728964576;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=xSYQ6qR2YyPxkEpPkVlGgPT6KdWxjUxQdAsacrNmW3s=;
 b=RYSxsU6Ws0WBXPfKCtrJ3wXIXkgEAaqe4yimAtI5mFBqwOizOejuNsopR2p0Kh06dA
 f03uqM8NBYXZenIV8OxK7Nzx9fphI3UYa8zatilpF21TinrmC6ki8j1BggXbgQY39NkT
 W0DXxzDgVRh+z/vkO+p4RmLNmWUEsGKFBAYZOomIw3BaBibCO7XERr3zOpzLi0t0F2mG
 9Q2PXzcFK5kuh8o79iCLFpbGY+z0eCCIXp8i0dTVZWwRW0EP2Yhx/8mXeZYykkH9hC7M
 hfL3rMmY7lfIxpmZtczF56ME2kgkvGXg7m5cGF5DQBwNl17kgqDEOuUaXXUCqGyEY9om
 +8og==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728964576;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=xSYQ6qR2YyPxkEpPkVlGgPT6KdWxjUxQdAsacrNmW3s=;
 b=iSO2W6VF/s/oTpKAYTUeEasemUzmR9ZDOvAuiXmgT24fawC5uHTAM4R68LFmuxrGSV
 GA+RbLdr68DT5WPqdb3F9vm+O34fMnSC5jppeDMLp2umU0bhNn5aL63Q2DjbblGmclUS
 rPCukvy0Ak442VYYQPr8J+dBf0sGdhv//Y6z+DmuPfls8VeyiKFMMmzMvJGsFCT+u1fo
 c56I0R84ICE2IfpP1wX9896ZRW8T/6ZwrpYgFzM+FQZL4dXpCZpY9C+giBgsd3Ti0fVI
 UM+xsC17rtnjRT+5KYQfdphnCN4wSm83oz5mrrIEnys4cNmgjVTIj19YhXb0ox8EYZ1v
 rweQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728964576;
 s=strato-dkim-0003; d=xenosoft.de;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=xSYQ6qR2YyPxkEpPkVlGgPT6KdWxjUxQdAsacrNmW3s=;
 b=ZQsNhQxDyQiOr7k3pN6/jusi3ECKbo1AGT5Wd1p6UI5ZyqVkQO5+hYO9h+f3PXc46r
 ShJLL/1V+qCbBbRQ+oCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7Vpiws33FXnUI/9PuhTYBjMOp1+IsL3lZfXddq5k="
Received: from [IPV6:2a01:599:104:61f9:6491:b2b5:9c5d:4894]
 by smtp.strato.de (RZmta 51.2.11 AUTH)
 with ESMTPSA id ea02d409F3uE0Yy
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 15 Oct 2024 05:56:14 +0200 (CEST)
Message-ID: <1115cce7-cfdc-4c5b-b017-69cd32425650@xenosoft.de>
Date: Tue, 15 Oct 2024 05:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCHES] drm/radeon issues
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Alex Deucher <alexdeucher@gmail.com>, ville.syrjala@linux.intel.com
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, "R.T.Dickinson"
 <rtd@a-eon.com>, mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>, hypexed@yahoo.com.au,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <CADnq5_PUi_2+kDYX8R_eanNF4iYN79MdXJ_PLcQbZKi6e4S8tg@mail.gmail.com>
 <87F47F04-EBAC-48D6-AD0A-4BBE39DF43CE@xenosoft.de>
In-Reply-To: <87F47F04-EBAC-48D6-AD0A-4BBE39DF43CE@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 15 Oct 2024 08:08:24 +0000
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

On 14 October 2024 at 3:11pm, Christian Zigotzky wrote:

 >> On 14 October 2024 at 3:00pm, Alex Deucher <alexdeucher@gmail.com> 
wrote:
 >>
 >> Can whoever wrote this send it out as a proper patch?
 >>
 >> Alex
 >>


 > Patch source: 
https://lists.freedesktop.org/archives/dri-devel/2024-October/473314.html

+ ville.syrjala
