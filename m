Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35A7C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5E594DA2;
	Tue, 12 Jul 2022 14:56:56 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99E094DA3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4GG2gQ7c04a+3GMYtJ3Qa/imUMIIJK3RIh4n62rM23g=; b=coEVQAmT/0F8U0TwYV7UPLraxi
 lAYfV2Np2T62S7uIqKNFfhlFM9I20P2b52gjI9QQhTr/qlA4adkWvZ45afRA7eI/m+KMg+HYQ1VFa
 Rspl4q5bZSfa85acsKBdm5Cx286/JGccn6BgdTt3Y1d3c3bxAGG0Iag3sQ7YnOOjckfzFxWNWkDM8
 nrGjVVaFrdLp+Tfpg58QuIt79/f8yZy9pL3/FswPvx1Sr7Dqxs+zjXSlkevOu6mIle6Z2ZC/XZ8Eb
 LSs95Fc7gIIbHJYzmF3NMsI2cwkn9t8v3bf71HaaPdoLZXROpT1NTmrg/Fsz7vnikxLSws0eVWmEO
 B2PVExDA==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oBHJd-00DfoP-AD; Tue, 12 Jul 2022 16:56:45 +0200
Message-ID: <3e7b3827-3862-3ce9-e46e-f1a7a52423b2@igalia.com>
Date: Tue, 12 Jul 2022 11:56:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: make some dc_dmub_srv functions static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220708155036.1092134-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220708155036.1092134-1-alexander.deucher@amd.com>
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
Cc: kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 12:50 de 08/07/22, Alex Deucher escreveu:
> Not used outside of dc_dmub_srv.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>
