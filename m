Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26151C43602
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 13:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C2310E97B;
	Mon,  6 Jul 2026 13:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.b="acYn9BoT";
	dkim-atps=neutral
X-Greylist: delayed 595 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 12:50:52 UTC
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8577B89FA5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 12:50:52 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4gv3qn4Zzxz9x7y;
 Mon,  6 Jul 2026 14:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783341653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3udRbydwVE61lXU936pG6FZ28P5TZrDPN5TpKML3yw=;
 b=acYn9BoTPhyAqnZtzAh0t0CcMotsndj5f3fmsJGN69hGU54/ePBrkAz/1C0P6KursiexkK
 sprzfQXiTfvNMVtfusTE7A/FTfcjZ55eDGWS+/+sOgA3duG+RfoJIrN7RotBXXaGO/EX6L
 WkMm9e15l0BHZvToNRtnO3dHXwzzgSMxTY90Otbd5ZJW2sjN/BxyQ2EW5nneNmh2g02vel
 aT0SG8eiQ7PJgFNAOz+mS+sBUtnEN6UEPaAp+wDVecsLAAiAIFYUsEuqRvjMoDBIWwRdZA
 FW8V6qRUoRxl8RKBlJAL8GyJKz/wgMx9UsAJiv6w5YYq3ml/YMXWDiSGPehNJA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
Message-ID: <4e7f73d5-5407-4ed4-8b91-483b97ad70f0@mandelbit.com>
Date: Mon, 6 Jul 2026 14:40:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 23/24] drm/amd/display: fix compressed buffer config
 routine waiting time
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
 <20260604145428.809959-24-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <20260604145428.809959-24-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4gv3qn4Zzxz9x7y
X-Mailman-Approved-At: Mon, 06 Jul 2026 13:09:56 +0000
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

Hi all,

On 04/06/2026 16:52, Aurabindo Pillai wrote:
> From: Antonio Quartulli <antonio@mandelbit.com>
> 
> Replace the four open-coded REG_WAIT calls with calls to
> dcn31_wait_for_det_apply() so the compressed buffer (compbuf) sizing
> path waits long enough for the DET size update to take effect, and the
> wait timing stays consistent across the driver.
> 
> No functional change beyond the corrected timeout.
> 
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>

Sorry to bother, but I was just wondering if this patch/series got 
dropped or if it's simply in the pipe for more review/merge?

Am I right it should pop-up in https://gitlab.freedesktop.org/drm/kernel 
before going to Linus?

Thanks a lot!
Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

