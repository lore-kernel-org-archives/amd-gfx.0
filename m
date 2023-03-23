Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E935C74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD9C10EB6F;
	Thu, 23 Mar 2023 21:58:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B78D10EB5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
 MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+44FFyep64z6ivRpJ4gdjZRzqWINZuMoJlBx/CC9sw8=; b=CfPNPZuqGfwTBG/4MwWR6Wr4Vl
 10LLELRtkmnDOWVjbkWrrS3GF8ZMyHO4VdwUKqlUhj8w1IcDi3fdIl/6fmd71MTxZD6eMAKcAfpt9
 vckpey3T7pTGrO26lcx+cT+NzFkJnh+gK3m8c5q7cwsY0ov/ShS8/y+tae+6vT5fGFwL52jsiYwvQ
 8RO2uiymIagk01PjPqa7/g3rOGZokiI8IBaxa/oJj2WXfTrWT+dmTO7IBqclPedlSvm05v3q1/EBf
 OXfxnrObm3LlFl7U8lY3bJVkFggFyGLFQ07iREb/BJGGY80+pY/xF+R/9OuCwdO/Wsb4kp57APBmX
 Lwwh2fXA==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pfSir-004ZjJ-O5; Thu, 23 Mar 2023 22:43:50 +0100
Message-ID: <a75662b0-7e5b-16d9-735d-11b00a385a58@igalia.com>
Date: Thu, 23 Mar 2023 18:43:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: wenyou.yang@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [Resend PATCH v1 0/3] send message to pmfw when SMT changes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 23 Mar 2023 21:58:05 +0000
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
Cc: weiyuan2@amd.com, ying.li@amd.com, xinhui pan <Xinhui.Pan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, kunliu13@amd.com,
 Christian Koenig <christian.koenig@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Wenyou Yang, first of all thanks for the improvement!

I'd like to ask you (and all CCed) if it would be possible to explain a
bit the goal / functionality behind these patches.

By reading the commit descriptions and code, I can understand code-wise
what's going on and how this will message the FW on SMT changes. What I
couldn't parse is the purpose of this, or in other words, what does it
gain for us? Also, why only on Vangogh?

Since I don't have the spec I couldn't read and learn myself - apologies
if this is somewhat a silly question. Also, if for some reason you
cannot respond (like a HW "NDA"), it's fine too.

Thanks in advance,


Guilherme
