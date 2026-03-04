Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF9CEF8FE7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 14:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF08210E15A;
	Wed,  4 Mar 2026 14:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="PSR00nlc";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40BEF10E0FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1772632806; bh=03YYjpepOykGmLVjmCsxlAGzJqZMxQaG7uKpgw/s2Z0=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=PSR00nlcpIic9Tgu2CmhcH/Ia1+v0pUse4R/OS5jCYK5gngoN76125Gwa30Erse1i
 BVOwd6jjnxMPFb9y/0CTgBX1+4W8iRFe6G8YC1O9QXdJ1AGdruj2vKCPjgojDRQZZ0
 ky5xHJVYNY8wQHBF8FNlarx+XmeG+rbWoLYNo8W2IoD8wtPNfAjPSmkf0NpK8r6icn
 DNOZfkrR6K7Yh38v4tPfil+SyATQmwrTkQ8pIkD45sAl0sRqthKq1AI3EbqaA277Fx
 qNi9tmKOlr3RnW2ghfNHdsvK95yIVqrxcv89lvxr8p+PsfT0XyRV52Vx0RFbRDn3Cq
 Hj4+HPVUGPPhg==
Message-ID: <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
Date: Wed, 4 Mar 2026 15:00:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>, Shengyu Qu <wiagn233@outlook.com>,
 amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
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

On 3/3/26 20:07, Leo Li wrote:
> 
> 
> On 2026-03-03 03:17, Shengyu Qu wrote:
>>> Here's a patch that inserts a few trace events.
>>> https://pastebin.com/dpLnVSbu
>>>
>>> Could you try to reproduce the hang again while recording these trace events?
>>> Using trace-cmd (with stack trace enabled '-T'):
>>
>> I think Michele said that the timeout issue would be masked by drm.debug due to overhead?
> 
> I'm hoping that enabling a few tracepoints would have much less overhead than
> enabling drm.debug. Depending on which debug flag, there can be a lot of dmesg
> output.
> 
> If tracepoints ends up masking the race condition, I wonder if there's a way for
> bpftrace to probe the lines where the tracepoints are inserted, and print out
> the event's pointer address. If so, that's a viable alternative.
> 
> - Leo
So far i could not reproduce with your tracing patch applied, i could 
try to use bpftrace instead but it will take some time, i am quite busy 
these days.
