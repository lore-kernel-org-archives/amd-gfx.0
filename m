Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5577CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34EE310EB72;
	Tue, 16 Jun 2026 12:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oflebbe.de header.i=@oflebbe.de header.b="LVcSxBCk";
	dkim=permerror (0-bit key) header.d=oflebbe.de header.i=@oflebbe.de header.b="p1i8YMIB";
	dkim-atps=neutral
X-Greylist: delayed 359 seconds by postgrey-1.36 at gabe;
 Tue, 16 Jun 2026 09:43:03 UTC
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8EF10E99E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781602622; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=DERqs9D9ccf6uLWy/fyisoea/+5+tWoM8slYYOTo9jjtPHhBvRbc3e3EYL+tvh1CBw
 3/BIqg1DV9vQAhH8soPDzwYlmQt5Il9Ta773OkhgREhVv5ocgq2BPmE8CHIxG/+UkkCG
 NShKWxCYATg66FG9IdgJsmDhWsHHWJO652znFidzEs9oQvauHgAyoMIRrjlZRXe0jGnU
 Juwjw472JcAq9mp/M1wIOEEmgpaPLBA1GNYsXpZnbKZIMxQMWlCxen6x+tXs2XQe5811
 xGJLkDMcKAt7eTrOKc0vxOMza7zX4DHSAMz5Ru01HDDbcE6xIZkY1kZad3u6eVNsXlcL
 dwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781602622;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Cc:To:Subject:From:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=8GBfxWYLCo0gflMvIxRMycwkRuM4XTcnpEBx8LI7pmk=;
 b=Ctu1z1ACTvBt2gyDin8CiXkl9NKk1N1118lzbHt2eTFWACAXX4QmXfjHy8kocZRei2
 nxQhqPJnzmHLbo0XzBzwT9chsY58VgxqrMgP7vkpQkCvZMUOdkrossmm3m9d2LOYI9Qs
 XE6NQemX4SO5CgJhfgG8WoaAx61Ok3BZP8NG3hk9mucCakmQDfxSMJuDZdRxJS7txKPd
 jfMyyqoNNgK7Hl+7qIojnBm9OzKla7KW9MFR0rftfEdyI8N1OIT74ND9Omh/2NMwoK7J
 XqLlHVbedohMzObsZRpIfsYfzXTPNYN9F6esMbfmGBtl5xx1NTexAS8WLqfgpT/XTG6T
 092Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781602622;
 s=strato-dkim-0002; d=oflebbe.de;
 h=In-Reply-To:References:Cc:To:Subject:From:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=8GBfxWYLCo0gflMvIxRMycwkRuM4XTcnpEBx8LI7pmk=;
 b=LVcSxBCk++wT/h809wD+jwIMvfhHO/B3KuMaHcXN/aUWnJDvHBsea89ee9pI5FLsG1
 bIly+Ha7tWnv56KeEBloQVIw9O8h6thSiFG/Io62/omSdlKl6o7W5LeUrO9gTIYRPvQF
 nnVFj9HdIlaIRxnX294YsmXJFgClD9Eu1q7vaHEN0Ym8cmkNCLoaO5z40Ewgp382gO9z
 ZM3SvXI+ka8/GX48+WZN06sprnSIrRoWhn+h/xmkWCqzc8efetKkfenWB+eiezA+orWW
 E0WhcKlKrZ4d1yUAIDHbVCC11b02S5jTOLgjqJOJGbiCQNR71jd65RP+re4+kIFtZBdL
 JbXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781602622;
 s=strato-dkim-0003; d=oflebbe.de;
 h=In-Reply-To:References:Cc:To:Subject:From:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=8GBfxWYLCo0gflMvIxRMycwkRuM4XTcnpEBx8LI7pmk=;
 b=p1i8YMIBE+XVBVgulkoU1jmng5FFAs50SfwB9B3OMkp3ri7YJeHV+Zb2dtybDEIzXd
 3uc+GNGiKQC1f88tFeCA==
X-RZG-AUTH: ":I2okekakfv3mKNs8YSFayssNXg+upC3+tYLZLO1stc+1hkqAuvcOy6wvdE5WbzifFxif/QVyZs25ArOB3Qml3cp6q04="
Received: from [IPV6:2003:df:7703:a900:8ccc:d9dd:c1b9:4f33]
 by smtp.strato.de (RZmta 55.0.1 AUTH) with ESMTPSA id gce03325G9b2cCT
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 16 Jun 2026 11:37:02 +0200 (CEST)
Message-ID: <6bd010df-cb3e-4ef4-8439-dbc0ac54749e@oflebbe.de>
Date: Tue, 16 Jun 2026 11:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Olaf Flebbe <of@oflebbe.de>
Subject: Re: list_del corruption in amdgpu (Was: Bug#1139599:
 linux-base-7.0.10+deb14-amd64: amdgpu (ttm?) two Oops, locking the computer)
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: 1139599@bugs.debian.org, amd-gfx@lists.freedesktop.org
References: <178107486943.12919.15197186152368989316.reportbug@frame>
 <ajEQr3IXQ8byLFvC@monoceros>
Content-Language: de-DE, en-US
In-Reply-To: <ajEQr3IXQ8byLFvC@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 12:49:33 +0000
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


On 6/16/26 11:12, Uwe Kleine-König wrote:
> Control: forwarded -1https://lore.kernel.org/amd-gfx/ajEQr3IXQ8byLFvC@monoceros
>
> Hello,
>
> a Debian user reported an issue while using the amdgpu user. The full
> details are available athttps://bugs.debian.org/1139599. The relvant (I
> hope) parts are also in this mail, but you can find more logs there if
> you want to take a look.
>
> On Wed, Jun 10, 2026 at 09:01:09AM +0200, Olaf Flebbe wrote:
>>     * What led up to the situation?
>>             Heavy use of LM-Studio with local GPU accellerated models.
>>             HW: AMD Ryzen™ 7 7840U w/ Radeon™ 780M Graphics × 16 (Framework 13 Laptop)
>>
>>     * What exactly did you do (or not do) that was effective (or
>>       ineffective)?
>>
>>     Normal use (use gnome-calc for instance) while LM-Studio was active.
>>
>>     * What was the outcome of this action?
>>          Moved the mouse: Computer totally locked, hat to power off.
>>
>>     * What outcome did you expect instead?
>>          Mouse movement :)
>>
>>     Happend two times with Kernel reports both mentioning "ttm something" and "amdgpu_bo_move"
> @Olaf: If you still have both issues in your logs, providing both might
> help to identify the issue. Also it would be great to know, how reliably
> you can reproduce the issue, in case we have to resort to bisecting or
> testing a fix. Is this a regression, i.e. did the same workflow work
> fine before, with an older kernel version? If so, which one?

I found 5 of these Oopses starting in June 9 with  kernel 7.0.10-1.

Found out that some of these oopses happened while waking up for 
hibernation or running LLM's.
(some hangs when waking up did not leave traces in the logs)

It happens  almost every 2 days.

Hibernation worked great before (factoring out  the issues with the 
parport module race when booting).


Best

Olaf

