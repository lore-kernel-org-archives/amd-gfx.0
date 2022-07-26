Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C53FC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 13:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F8812BAF4;
	Tue, 26 Jul 2022 13:41:46 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB0D90F65
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G2PjKSmYw6VU5sS8KfiHzS3QXzzCKefBtt3yyOaZZOE=; b=HAsHwsquEuhfhFAWAnGQkrsrrr
 ZHP6viGfkYdF6mjOIOF3lSzFa/CogkQMsk+o/E9w6wEjdHj0rNaxL28cVwswVizTpgupPVO6T4xsk
 U11Nw4LRP0JihgWv3zTLwpO1EN2go42hUEnaHLEnHWB3MfH+2gOCGAhaWLkkBuEdLY0Cz9MeyjWnu
 1469mMFE/keY2O9L0qHv4tWDQ0vs0KKE6GAUU+Oc40nNYlRIHRxgnFNZ+GhZCn3ECAyBYkhLHBbqA
 49tjtqVf16kPSG+asns+8E/BDV1Ls8lkrzV0LpqjcG4yALjL1YF1OQ7gdTpqc3cFjSI0ycBkM31iz
 uUE/ngPg==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oGKoe-007KXx-U1; Tue, 26 Jul 2022 15:41:40 +0200
Message-ID: <d33dfebe-b95b-2bc8-b109-da1558613610@igalia.com>
Date: Tue, 26 Jul 2022 10:41:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amd/pm: Add get_gfx_off_status interface for
 yellow carp
Content-Language: en-US
To: shikai.guo@amd.com
References: <20220726062905.3323207-1-shikai.guo@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220726062905.3323207-1-shikai.guo@amd.com>
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
 aaron.liu@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 03:29 de 26/07/22, shikai.guo@amd.com escreveu:
> From: Shikai Guo <Shikai.Guo@amd.com>
> 
> add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.
> 
> Signed-off-by: Shikai Guo <shikai.guo@amd.com>
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>
