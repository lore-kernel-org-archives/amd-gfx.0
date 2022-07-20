Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3CDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 17:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6564B902DF;
	Wed, 20 Jul 2022 17:23:39 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B86D904A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Cc:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=W/Yu100lZmwCk1AoXTZry92Dzw8k2Yelaok3lPKUyOY=; b=EcC02f+sxMAUSQFpMryJihNKIz
 Ntt2Sm+i16R65LPLYVXN0VY9XbpuvGIKawH5EbcORYN/0dEZtYZYcyMxT8Q3CxdlZ78i6ixQMsX6d
 ZAJnCbDD78hmsgzagvW4mS1uBCcRgvTdp1lHL803uhiziRxVEBHJBHEF6P8pLTrps/9hhFF8AwvuE
 /fhL3BXNIpAFKp44A2uhtxXzsRwgURWSOLih/OODlJiynPVCORrpDLjXV4oBX6Zlci0zN2793M/SA
 /jRiq/jrEzTOI0Y37wKNA8gosjxsPmgTTgFJC6vfDKCgYL5b2bpdqP7mNg2+gFUFZEx9xFTJopd53
 7oBenU/Q==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oEDQ8-000Yqo-94; Wed, 20 Jul 2022 19:23:36 +0200
Message-ID: <5268b500-23fb-d716-4b73-22a7ed403258@igalia.com>
Date: Wed, 20 Jul 2022 14:23:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix the incomplete product number
Content-Language: en-US
To: Roy Sun <Roy.Sun@amd.com>
References: <20220720082659.49637-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220720082659.49637-1-Roy.Sun@amd.com>
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

Às 05:26 de 20/07/22, Roy Sun escreveu:
> The comments say that the product number is a 16-digit HEX string so the
> buffer needs to be at least 17 characters to hold the NUL terminator.
> 
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>

...but I would appreciate a more detailed commit message with the points
I raised in the review
