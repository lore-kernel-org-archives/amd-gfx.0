Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146F7C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 13:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FCF10E305;
	Mon, 10 Apr 2023 13:01:00 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C284A10E0AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 09:28:06 +0000 (UTC)
Received: from ramsan.of.borg ([84.195.187.55])
 by michel.telenet-ops.be with bizsmtp
 id ixU22900W1C8whw06xU2r7; Mon, 10 Apr 2023 11:28:03 +0200
Received: from geert (helo=localhost)
 by ramsan.of.borg with local-esmtp (Exim 4.95)
 (envelope-from <geert@linux-m68k.org>) id 1plnog-00GSzz-R6;
 Mon, 10 Apr 2023 11:28:02 +0200
Date: Mon, 10 Apr 2023 11:28:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.3-rc6
Message-ID: <3aa83a95-a755-416d-d8fd-8363bbd0edf6@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Mailman-Approved-At: Mon, 10 Apr 2023 13:00:58 +0000
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
Cc: linux-wireless@vger.kernel.org, linux-um@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-sh@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

(resend with the right subject)

On Mon, 10 Apr 2023, Geert Uytterhoeven wrote:
> On Mon, 10 Apr 2023, Geert Uytterhoeven wrote:
>> JFYI, when comparing v6.3-rc6[1] to v6.3-rc5[3], the summaries are:
>>  - build errors: +2/-0
>
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: 
> 'struct cpuinfo_um' has no member named 'apicid': 2157:48 => 2157:48, 2157:41
>
> um-x86_64/um-allmodconfig
> um-x86_64-gcc12/um-all{yes,mod}config
>
> seen before
>
>  + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 
> 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]: 
> => 6163:45
>
> v6.3-rc6/sh4-gcc11/sh-allmodconfig
>
> seen before
>
>> [1] 
>> http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09a9639e56c01c7a00d6c0ca63f4c7c41abe075d/ 
>> (all 152 configs)
>> [3] 
>> http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e364e56293bb98cae1b55fd835f5991c4e96e7d/ 
>> (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
