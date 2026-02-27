Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B93FD5312
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 08:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7C610EA69;
	Fri, 27 Feb 2026 08:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="wFa8NRUp";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4822810EA69
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 08:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1772182735; bh=S+Ma0S7CWv5JSDVI0O/U/wKK7fJ+BduzE80lcKE/0T8=;
 h=Subject:From:To:Cc:References:In-Reply-To;
 b=wFa8NRUpVaETHHn7ZZPMGExRlBP68K0xGBN0VMlSXOIEj2Zgq4w1hUMRs0R1GODhK
 GF+7QOkXAso5NfkRaq04ymTFLNi37K3GfB6xU8hdj65ebD2AgWQVkistoNN6HSyrd9
 DPsrActjyyWR4BGtbaFE44RQ7YPvhc8FXmBnq6NcHJS3GnAJ4qe0UMT0m7Fn8RvrDy
 ftGK2SCcnnHi9GQDaqlw1agXpbe2+tNZDo3Q0Z/w94QKhpHuRYGb1saw57v19paiV0
 SRKcdg2a9GJnt6i0GkBnTI5ZW384d/q1jaQc2uL0sGY6hdH7eZXgA4b6ttZGueMS1V
 H4tH+KiCN83xQ==
Message-ID: <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
Date: Fri, 27 Feb 2026 09:58:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
From: Michele Palazzi <sysdadmin@m1k.cloud>
To: Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, siqueira@igalia.com
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
Content-Language: en-US
In-Reply-To: <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
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

On 2/27/26 09:53, Michele Palazzi wrote:
> On 2/23/26 16:27, Leo Li wrote:
>>
>> Really nice debuging work, thanks for catching this!
>>
>> Ideally, the cursor event should be delivered when hardware latches 
>> onto the new
>> cursor info and starts scanning it out. The latching event fires an 
>> interrupt
>> that should be handled by dm_crtc_high_irq().
>>
>> dm_pflip_high_irq() handles an interrupt specifically for when 
>> hardware latches
>> onto a new fb address; I don't think it actually fires when there's a
>> cursor-only update. I think if we really want to do it right, we can have
>> another "acrtc_attach->cursor_event" just for cusror-only updates, and 
>> deliver
>> the event in crtc_high_irq().
>>
>> In any case, I don't foresee any major issues with delivering the 
>> event early.
>> And since it fixes an ongoing issue:
>>
>> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>>
>> Thanks!
>> Leo
> 
> Thanks for the review. Further testing confirms that both this patch and 
> increasing the dGPU vblank offdelay (from 2 frames to ~50 frames) 
> independently eliminate the flip timeouts in my testing. Both work by 
> reducing the frequency of vblank disable/re-enable cycles, basically 
> either could be an interim fix.
> 
> Your deferred vblank enable/disable series https://lore.kernel.org/amd- 
> gfx/20260224212639.390768-1-sunpeng.li@amd.com/T/#t looks like it could 
> be the proper solution going forward instead (haven't tested it).
> 

fixed siqueira@igalia.com cc
