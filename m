Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAAECF319D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 07:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A766B10E6B7;
	Wed,  2 Oct 2024 07:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=jalseth.me header.i=@jalseth.me header.b="QDemoljx";
	dkim-atps=neutral
X-Greylist: delayed 391 seconds by postgrey-1.36 at gabe;
 Wed, 02 Oct 2024 04:21:00 UTC
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C617D10E66B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:21:00 +0000 (UTC)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id 33D6827EABC9;
 Wed,  2 Oct 2024 06:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727842467; 
 s=s1; d=jalseth.me;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=04dtn4ZDwIqsqhEPk6iyeO6ZVVl5bUeLfG9I/mTQhng=;
 b=QDemoljxGg5csc7c5MgSwlj/En1ahPp9MdSWmc6BY9EDIiSd218AxwrKFKUnIs3k
 GuA7+MvjGOlkMrzAMtmVPrVLmDcnvO81ZsJWLfJOvAVuQugerMSExpqHJhmAFQEEEr6
 PBcp+Y5l+Wm1dPjOll3SLM+iXjAj2VMuyR3vf13gDs4qfbm4WAcpg2KtJfu5LTYq3Rc
 MPpoLd44SK7rZQZBi6pBOhKeyj5HC4bJxVd0rbtoleq6IQAccI7AC0V1hqiNYqxExf5
 Xr/rBCCbRzfDWKdWXTEJq0MGjJrPH+vfB0lorTACGLIGZihMrshn8cKPdDfwJJzJbPR
 tQiiMZhQ8g==
Date: Wed, 2 Oct 2024 06:14:27 +0200 (CEST)
From: James Alseth <james@jalseth.me>
To: Christian Koenig <christian.koenig@amd.com>
Cc: Xinhui Pan <xinhui.pan@amd.com>,
 Alexander Deucher <alexander.deucher@amd.com>,
 Amd Gfx <amd-gfx@lists.freedesktop.org>,
 Regressions <regressions@lists.linux.dev>,
 Sigmaepsilon92 <sigmaepsilon92@gmail.com>
Message-ID: <O8AQvEr--B-9@jalseth.me>
Subject: Re: 7840U amdgpu MMVM_L2_PROTECTION_FAULT_STATUS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 02 Oct 2024 07:59:18 +0000
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

Hello,

I have a new laptop with a 7840U and am running into the same problem on kernel 6.10.11 and 6.11.0. My symptoms are slightly different, in that video played through Firefox works for some period before eventually having a GPU crash. This can be anywhere from seconds to 10+ minutes, though I don't think it has ever passed 20min of playback.

Please let me know what info I can provide to help with root cause analysis. 

Regards,
James
