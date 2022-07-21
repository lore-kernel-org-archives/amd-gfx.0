Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D188C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 13:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0530E90D25;
	Thu, 21 Jul 2022 13:35:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768FC90D25
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8YFbTHxQthzOWNFDNujZ6xnF8BTNw3UEG0+j6FNXCWU=; b=snffF4nd3H4L5E8gMhriYYOREh
 Q71a9ezaDjUGUnhsZtzY8/6EqCqPZAZsLJWRRmW7bzR5EDMe31n5bfVa3A1mAYMihCLdi3uzzSvoT
 gDwXOgQkCwpnWcPbfySE+BwUB1JiP4NsH1DwT+Y0bS4ofjHH4Pjt8av2BZdtp8OzwOzdnHQy4Irkk
 HezfoOlKUFq7nOib9NARIY0vbDtnb/opPPQ68oZ4mdh3M5Du4xmxfyQ0uhMdZ9aqlBZXy7gGq8G32
 bB8tHDbluUYKSYw4HdZ1tfnvSiTr+uFH+1fM+5+Cpp9aA+MlL17DzfbllssIbqpxhgJy8IEgOmet8
 sAxzouGA==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oEWKh-001UuF-57; Thu, 21 Jul 2022 15:35:15 +0200
Message-ID: <14e11a4b-7300-a54d-6794-1eeb7ab8a079@igalia.com>
Date: Thu, 21 Jul 2022 10:34:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] drm/amd/display: Remove duplicated
 CalculateWriteBackDISPCLK
Content-Language: en-US
To: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
References: <20220720182228.259119-1-mairacanal@riseup.net>
 <20220720182228.259119-2-mairacanal@riseup.net>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220720182228.259119-2-mairacanal@riseup.net>
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, magalilemes00@gmail.com,
 Leo Li <sunpeng.li@amd.com>, tales.aparecida@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, mwen@igalia.com,
 David Airlie <airlied@linux.ie>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 15:22 de 20/07/22, Maíra Canal escreveu:
> The functions dml30_CalculateWriteBackDISPCLK and
> dml31_CalculateWriteBackDISPCLK are identical. Therefor, to avoid
> code duplication, dml31_CalculateWriteBackDISPCLK is removed and
> replaced by dml30_CalculateWriteBackDISPCLK.
> 

The message should be in imperative mood:

"to avoid code duplication, dml31_CalculateWriteBackDISPCLK is removed
and replaced by dml30_CalculateWriteBackDISPCLK." -> "to avoid code
duplication, replace dml31_CalculateWriteBackDISPCLK by
dml30_CalculateWriteBackDISPCLK"

> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
