Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D7DCD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B8810E68E;
	Mon, 18 May 2026 07:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="Ncpz0TzB";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5667410E68E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1779087608; bh=eY8OO5UtythPRJ5c2J2GPU2rkJITTH1atpR+z4s0pvc=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=Ncpz0TzBluYP362qqpocteqBqNPywoJchgSn8OyE+QG2irRAOFZISXdOC0xDzKxVK
 a8l8+360/fMJISU58EA+33V09gPyS5UgE7+HQ8+8Y5CapTgeFAuCNifgpTOCfHV/rK
 gvfqUeJHvlIjUUvQ7KRwuVisvuMGL7WvgKZh6Y8i06icqkMvXNS+vMyQFjRw0+MWIi
 A/4GBbpgwVj3gG3B35SW+xlwb6ghSUNs0o7R4KF33wiQWSOpfU5IfZJMAC2ZbNOVRR
 KoWJTwhS+cP6RfEgmULgt8A4unAHD65juRjKg1nAjuw0ZE1+X35Acfatqk1DJHiFYe
 W9Fo2C7JN1k2g==
Message-ID: <d3e8f87c-b239-484f-a734-72017d60425d@m1k.cloud>
Date: Mon, 18 May 2026 09:00:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Use vline2 interrupt on DCN instead of
 vstartup
To: Shengyu Qu <wiagn233@outlook.com>, sunpeng.li@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com, mario.limonciello@amd.com
References: <20260504183649.165131-1-sunpeng.li@amd.com>
 <TY4PR01MB14432FD1DC8B9B826B6CE9474983B2@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <TY4PR01MB14432444AD2D53FEC2AA85D2698032@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <TY4PR01MB14432444AD2D53FEC2AA85D2698032@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/18/26 08:34, Shengyu Qu wrote:
> Hi,
> 
> Still no issues after longer testing:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/2950#note_3477114
> 
> Also what's your test result, Michele?
> 
> Best regards,
> Shengyu
> 
no issues for me too, patch seems to work.

Michele
