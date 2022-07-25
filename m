Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA2DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 19:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04334C1C09;
	Mon, 25 Jul 2022 19:38:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2375C1C09
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 19:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=97xO8MpFS+EQbJKonkUxT/N6K6HBArw170AmLWWPjwQ=; b=PbDXy7RLKJIT+yYEk0vo/vPBfx
 VIEC1crm13lenFzk1uslKvnoQPdmuL0mvBd+8wnwVeTZL6SLii3SvvQtuMrRSY/zx/KOk0qiLuzXy
 UN/47P2Vz8FptS1H9n64bL43VIokll0nDffsg35UnhvHFVTNEFwDSlL1+UhjfazOtJqwXwrv48A6q
 0W+AyNv2davaJL0OP0Z6gVi/8GuCWKpFrDBCjrE8TDXTqxVirS+uASdl9/jYz8g6U2WhIv1l4X7i0
 GBR1badPzVN2iFiVgr1CBMeTcE2Iwq4Ck2D6vNmnnDziTUwZ1pEaVJwJmDDBUb3Det99iItNBedL6
 Khmzd42Q==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oG3uC-006KCz-F9; Mon, 25 Jul 2022 21:38:16 +0200
Message-ID: <7c866655-7736-6911-eec4-9beb46435207@igalia.com>
Date: Mon, 25 Jul 2022 16:38:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix the incomplete product number
Content-Language: en-US
To: Roy Sun <Roy.Sun@amd.com>
References: <20220722045646.106225-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220722045646.106225-1-Roy.Sun@amd.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 01:56 de 22/07/22, Roy Sun escreveu:
> The comments say that the product number is a 16-digit HEX string so the
> buffer needs to be at least 17 characters to hold the NUL terminator. Expand
> the buffer size to 20 to avoid the alignment issues.
> 
> The comment:Product number should only be 16 characters. Any
> more,and something could be wrong. Cap it at 16 to be safe
> 
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>

Next time, please make your subject as [PATCH v2] and add a changelog to
make review easier.
