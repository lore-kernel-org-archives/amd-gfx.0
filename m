Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B2AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 13:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F82112AE0;
	Thu, 21 Jul 2022 13:11:08 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E21B10EDE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YO2obtjnPKVqsDxENWMKAkecDkn+IdUlMI0DRDiC2Ss=; b=IH1fuAKR/P8qZaUYi1hMFEVPSU
 X9GwCyTSDnYW/u/yp32UfspN/QC/OXfNPsMaLRuv+SRZ5CJmgtyH1QDS+K/XlsEtyHJJNwBSDwnmp
 CQChCr5Fh7jPyEEYSvQdjlgwWrOd8X3yVQc0oiVGwgGCntxc06R87f2TADivcXx1MIWB12/QzdxbA
 /8BoIuNWqYBXzxZx/kFLkZ4Ji61Xn1jPoh56Y5SeGw0PSi9QoTmbaKnu2/1qYHQd8yqPEPAHw2R/5
 Tg05B+qw9lk/TTesBVDNOnANHYlP/UOe5eYYfcwgSyGQci+nS/g4mF/t0uzwz3D8GI7XLjAUdtnF0
 PW7MCeJA==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oEVxG-001Tu3-0x; Thu, 21 Jul 2022 15:11:02 +0200
Message-ID: <25175965-26be-f7fd-cad3-bc00885c5dfa@igalia.com>
Date: Thu, 21 Jul 2022 10:10:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/pm: Add get_gfx_off_status interface
Content-Language: en-US
To: shikai.guo@amd.com
References: <20220721085738.2528792-1-shikai.guo@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220721085738.2528792-1-shikai.guo@amd.com>
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
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, evan.quan@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Shikai,

Could you change the commit message to

 drm/amd/pm: Add get_gfx_off_status interface for yellow carp

Otherwise, we are going to have duplicated commit messages for each new
architecture supporting get_gfx_off_status.

Also, giving that this is the second version of your patch, the subject
should be [PATCH v2], and the patch should contain a changelog compared
to the previous patch version.

Às 05:57 de 21/07/22, shikai.guo@amd.com escreveu:
> From: Shikai Guo <Shikai.Guo@amd.com>
> 
> add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.
> 
> Signed-off-by: Shikai Guo <shikai.guo@amd.com>


Thanks,
	André
