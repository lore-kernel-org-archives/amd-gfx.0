Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33A4C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 15:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071B710E63F;
	Thu, 17 Nov 2022 15:53:39 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202A410E638
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:In-Reply-To:Subject
 :References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KbZS7QazYDRitVj+2PFFQLu2ryKlizleO99uyU/Pu1I=; b=KlTmvs+VtaNsBYSdx4yV9+T8jk
 5fnoNpDHbkAG7a9jD+4ONqr8hzQ8UaXSBgpn/PszE3PHY4EPNseaQJJ1Ji0s22t7YdgAmZtHNv0bq
 3T6armnqF8Q7rAUiICcNz/5gQfqXCnRbImZcXw364BWJ2jsFGgj3L2n1XXeeTd20Z7ntUzPh1laj/
 Fzo6z+FQ6LDb3ZARKJXMTrGwP1d3C0ABuJO7+C+AfWRvhQZAch9fQ8KIj+4RbkiIGk1hwbUlBlZJ8
 XzzL3uU3RKOd4LxNub97KJbHJHfdKgP3h4RHoA2xgr/9sHR4VeC2Qa/NowsADkdi073TFGSptY1lA
 Acj6uR9g==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ovh43-002fqJ-N2; Thu, 17 Nov 2022 16:44:32 +0100
Message-ID: <9b212a8e-b36e-fb2d-52f7-f99290872c8f@igalia.com>
Date: Thu, 17 Nov 2022 12:44:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
To: ckoenig.leichtzumerken@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
References: <20221116160111.3226-2-christian.koenig@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: stop freeing PSP buffers during suspend
Content-Language: en-US
In-Reply-To: <20221116160111.3226-2-christian.koenig@amd.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 17 Nov 2022 15:53:32 +0000
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
Cc: alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian, thanks for the fix! It worked fine on Steam Deck running
the game Cuphead, feel free to add my:

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>


