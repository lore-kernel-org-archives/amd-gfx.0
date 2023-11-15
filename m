Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BA5C47071
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 09:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8756B10E254;
	Thu, 16 Nov 2023 09:11:25 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D47C10E0F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 17:05:17 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 961301F8BA;
 Wed, 15 Nov 2023 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700067915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbBhfGs1oQpGYEHzKE2qc79fVVoXCHeY/cL4VQ+Ooy8=;
 b=jOeM+UUunzinIA1d26bIv/FEvvSO+49v/57ENpMO2HqO7LaXs4IvmviqQGgFo5R3GgJ9t8
 JGaUdmXG0wU/tqp4w9UvQG4fYWHP43aSeBm5mPrENiNdHZ6/QPrMYQYJL7pMAoUNLZKUXx
 vd3Lpj7AzNA5tleza08Sb3Rf8cnV9aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700067915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbBhfGs1oQpGYEHzKE2qc79fVVoXCHeY/cL4VQ+Ooy8=;
 b=uWLbdnH0i1VM8lAdTBF5MMUXzzLw5TYiBPxXpj90FBtyJDTD1boKuN4rxtG9alcaCLhDPN
 wx8fxAAOQ0g5SbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8961013592;
 Wed, 15 Nov 2023 17:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zJf0IEv6VGVkPgAAMHmgww
 (envelope-from <vbabka@suse.cz>); Wed, 15 Nov 2023 17:05:15 +0000
Message-ID: <590788a0-1a88-c29c-de30-d1493319205f@suse.cz>
Date: Wed, 15 Nov 2023 18:05:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: page fault GCVM_L2_PROTECTION_FAULT_STATUS on 7900xtx Linux
 6.7-rc1 with Mesa 23.3.0-rc3
To: amd-gfx@lists.freedesktop.org, Abhinav Praveen <abhinav@praveen.org.uk>
References: <20231114045156.qymbztbq5x57crsd@praveen.org.uk>
Content-Language: en-US
In-Reply-To: <20231114045156.qymbztbq5x57crsd@praveen.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.13 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.03)[95.26%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Mailman-Approved-At: Thu, 16 Nov 2023 09:11:19 +0000
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

On 11/14/23 05:51, Abhinav Praveen wrote:
> Hi,
> 
> When I start X/i3 on a 7900xtx with Linux 6.7-rc1 and Mesa 23.3_rc3, my
> log is filled with errors like:

I have same kind of errors filling my dmesg with 6.7-rc1 with Radeon RX 7600
using KDE on Wayland. I don't notice any other issues than the dmesg itself.


