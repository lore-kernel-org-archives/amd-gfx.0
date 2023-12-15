Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AE0C46CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 14:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4A110EA2A;
	Fri, 15 Dec 2023 14:15:15 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4340010E9C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 11:22:19 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1rE6Gn-0005AR-Qc; Fri, 15 Dec 2023 12:22:17 +0100
Message-ID: <dbf9779d-9c6b-45bf-be52-1b8d6238643d@leemhuis.info>
Date: Fri, 15 Dec 2023 12:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Thinkpad X13 AMD: Problems with external monitor wake up
 after suspend
Content-Language: en-US, de-DE
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
References: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1702639340;
 fb771ef9; 
X-HE-SMSGID: 1rE6Gn-0005AR-Qc
X-Mailman-Approved-At: Fri, 15 Dec 2023 14:15:12 +0000
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 01.12.23 01:30, Bagas Sanjaya wrote:
> 
>> Since kernel version 6.1.57 I have problems with external monitor wakeup after suspend on Thinkpad X13 AMD Gen2 Notebook.
>>
>> Notebook is in docking station with closed lid. Suspend & Resume. The external monitor gets no signal. After randomly typing Ctrl+Alt+Fn for switchung consoles, the monitor at some point gets signal and is usable again.

#regzbot resolve: firmware update for the dock fixed it
#regzbot ignore-activity

Side note: yes, that is not ideal, but it afaics is an acceptable
outcome in this case

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
