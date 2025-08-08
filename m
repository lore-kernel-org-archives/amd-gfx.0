Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B28BC87FCA
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Aug 2025 14:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822B610E267;
	Sun, 10 Aug 2025 14:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="rXEUVnZX";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="L7bf7ZgV";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B4810E040
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1754681719; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=Em/tOlRn3neXSiKx7JzypFHPBdcqWvW5f9uTuGubZ/1teKbaT/vbaXYlOMoN0sW+Y+
 M+f1U9bWI/LuKdoU5lEKEPAKRxWEIZgb5dImjZrq7zD+PqhJOT+Z+5VestjThe5Vg0qj
 VtEm9Qra2SI7e0rQcVvPbLD3MaLOA8t+IIRswpl3soC1sIUBZvUHUdsWhn+W8+PVff/I
 O12QnDWq0M6DP/g2433wBo4iP+D3aFfuRB6ijJZBlthjvtr2mnm+L6ZTELgGqLRR8YhQ
 CW+3U+ijWcgSDIujZ9nZt8yBbVVhnxQ7cojQfkm9UI2sEF4SBgasdcQ5Qxa+GHF2YO1y
 D/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1754681719;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=FuB74Lz56YvahQ6QzPBql1iyXkEpCYCdoAlKAXgnLOE=;
 b=VG8JehbC+uTxOziuiB/ljATZvMI+noI+rDdNR5utjJbCYjLMVvo1UBz9zyquSJjmyR
 4v0s1zuqyS9Yf8gZQlezRYFDS1UZqEAXLyav+2mf8u8a+9HZ6c535oiFKr7CxQOFg+xn
 n0w7QYkAoN8tQIGnzh7JQHT1cEhvtzU7/4wGHg/+qgZV96x+oZ9Smw9BUHhM1nmYjC65
 nSKz9Nz2fQKXw4+KoX+1gegSQG3nNc0Vurftdxotp+2tRignLThhdT2ECxoKdPAt83Lk
 1g03S3pkVvD7+GlLz+WHQ4XlNN1Jfj79QUTKfGXsiE9OK/Sp6UpxMryCeuWJgCFFPMtg
 9TlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754681719;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=FuB74Lz56YvahQ6QzPBql1iyXkEpCYCdoAlKAXgnLOE=;
 b=rXEUVnZX/kxdUDYH7yZpwwLDFOHfiuEEwRpC84qb2VSbcKnf/AIywf02drxTxJNn72
 9esMpnuc4x1Ka9FdyBDEZFBEqnXsk0hUQ42O12aExFt+zaAcURNdLrHV/5NxHsFjHNOu
 63fjqEXUNHP+IwYwfVymOT+FCf4gJAUB9ux3b8NeQInE0c+F1RqKsbzMQ5MtsqwBglqQ
 58ohMHaUuQtGzMJ3Sq4tC88U6nz1Z4fJe53HgJyyjUaZcBuamyS5Zup1gP5zxn9JplTr
 6QQAquMKjNsioL9xI+DVYmdAjENWDVOZEsngv+s61gxUDPS0AotwVn+Rnp0MdfXtTWuG
 Gp4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754681719;
 s=strato-dkim-0003; d=xenosoft.de;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=FuB74Lz56YvahQ6QzPBql1iyXkEpCYCdoAlKAXgnLOE=;
 b=L7bf7ZgVWXTi25wucNloXI3n+pbKcP3W0izDmhoQG5CVLjlSkbeqO85wWuf+PPvvXh
 wS4vYy7TtRMOxn8Q6nDg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6P1rfO5KiO55fErqkemEbq79cbXtVWCxg7cN+9zD89Zv+intOJE/PA=="
Received: from [IPV6:2001:16b8:5014:2500:4e12:bd2f:a193:bf30]
 by smtp.strato.de (RZmta 52.1.2 AUTH) with ESMTPSA id e6066c178JZH7lV
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 8 Aug 2025 21:35:17 +0200 (CEST)
Message-ID: <0ea5105b-f96f-4330-a82b-c0c1f35f7b38@xenosoft.de>
Date: Fri, 8 Aug 2025 21:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: radeon_fbdev_river_fbdev: failed to initialize framebuffer and
 setup emulation
To: Damien Stewart <hypexed@yahoo.com.au>, Alex Deucher <alexdeucher@gmail.com>
Cc: ville.syrjala@linux.intel.com, Jeff Johnson <quic_jjohnson@quicinc.com>,
 mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>
References: <CADnq5_PUi_2+kDYX8R_eanNF4iYN79MdXJ_PLcQbZKi6e4S8tg@mail.gmail.com>
 <87F47F04-EBAC-48D6-AD0A-4BBE39DF43CE@xenosoft.de>
 <1115cce7-cfdc-4c5b-b017-69cd32425650@xenosoft.de>
 <6ba8d730-52f9-421f-8d8a-887545f0ceac@xenosoft.de>
 <2cc83897-427d-47f4-b6a3-8db9682972cd@xenosoft.de>
 <CADnq5_OpJdbc4YKtV-9+5JyeKyqd4+irhT6OtFq_K9KJF24VSQ@mail.gmail.com>
 <48b61c14-f83d-4e4a-b5d3-857099058eda@xenosoft.de>
 <4bab7915-9739-4aea-be67-5ea122de1f5c@yahoo.com.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <4bab7915-9739-4aea-be67-5ea122de1f5c@yahoo.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 10 Aug 2025 14:43:41 +0000
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

On 08 August 2025 at 06:01 pm, Damien Stewart wrote:
> On 5/8/25 2:05 am, Christian Zigotzky wrote:
>>
>> @Hypex
>> Could you please attach your full dmesg output? 
> 
> Hi. Sorry just found this. Do you still need a dmesg? I collected a few 
> and can provide one for any broken version.
> 
> 

Hi Damien,

Never mind. There is a patch [1]. The issue is solved. (Thanks to Alex)

Cheers,
Christian

[1] 
https://github.com/chzigotzky/kernels/blob/main/patches/v2-3-3-drm-radeon-Pass-along-the-format-info-from-.fb_create-to-drm_helper_mode_fill_fb_struct.diff
