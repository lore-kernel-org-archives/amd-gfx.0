Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0E8C197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 21:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B6A10E091;
	Thu, 16 Nov 2023 21:29:32 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B2B10E6E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 20:44:38 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B54720503;
 Thu, 16 Nov 2023 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700167476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMX+fx+B3awsx9LK57Q356CUnsmqE89MzeAz79QApc8=;
 b=2MyGFZAK7yfKs9tWb6Go8koPqQdlFdJvrJ1PE2YT/dBxgMcn2HIXF5BXQAb845d4tOrIV9
 j42YEEr5ozOZ7IAGcsrjf8QMpMgo0Y9u2BXF/GuXk4y3+uk/3ZL0p0xCm29umEGbIsU/jY
 qZ2ezCPX7aSQY8XBbStAuYRp+p85vMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700167476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMX+fx+B3awsx9LK57Q356CUnsmqE89MzeAz79QApc8=;
 b=7mDQrNhKnqM5Jr1Aby1wDDdz9LW7RGjA96bArnN9TqXlTo1VJynowdAnyqPQpJW5fVAyqO
 8xLVI+EW1CwzHDAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78B0F139C4;
 Thu, 16 Nov 2023 20:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aL+vHDR/VmWkewAAMHmgww
 (envelope-from <vbabka@suse.cz>); Thu, 16 Nov 2023 20:44:36 +0000
Message-ID: <4eabb20c-e6e4-12c6-6345-5cc6c8838e8c@suse.cz>
Date: Thu, 16 Nov 2023 21:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: page fault GCVM_L2_PROTECTION_FAULT_STATUS on 7900xtx Linux
 6.7-rc1 with Mesa 23.3.0-rc3
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231114045156.qymbztbq5x57crsd@praveen.org.uk>
 <fdca133c-c151-47f4-578d-2f4a423c57b5@suse.cz>
 <CADnq5_NgUQqo+dKr6D4wv2k6GRkysH9hoQJiWRzNtq8vNgbp8w@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CADnq5_NgUQqo+dKr6D4wv2k6GRkysH9hoQJiWRzNtq8vNgbp8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.01)[45.69%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.973]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Mailman-Approved-At: Thu, 16 Nov 2023 21:29:30 +0000
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
Cc: Abhinav Praveen <abhinav@praveen.org.uk>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/16/23 20:34, Alex Deucher wrote:
> On Thu, Nov 16, 2023 at 11:42 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 11/14/23 05:51, Abhinav Praveen wrote:
>> > Hi,
>> >
>> > When I start X/i3 on a 7900xtx with Linux 6.7-rc1 and Mesa 23.3_rc3, my
>> > log is filled with errors like:
>>
>> I have same kind of errors filling my dmesg with 6.7-rc1 with Radeon RX 7600
>> using KDE on Wayland. I don't notice any other issues than the dmesg itself.
>> Also attaching dmesg.
> 
> I think this series should fix it:
> https://patchwork.freedesktop.org/series/126220/

Seems it did fix it for me, thanks.
Didn't try the other patch you were suggesting which didn't work for Mario
in https://lore.kernel.org/all/12f135d1-3924-4053-8c22-3e68ffdfc08b@amd.com/

> Alex

