Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647A3C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 18:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B525F23118
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 18:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B525F23118
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=computerix.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39F2896EC;
	Thu, 17 Dec 2020 18:57:55 +0000 (UTC)
Received: from www74.your-server.de (www74.your-server.de [213.133.104.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4DE6E1CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 18:14:25 +0000 (UTC)
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www74.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <klaus.kusche@computerix.info>)
 id 1kpxnD-00073q-Ae; Thu, 17 Dec 2020 19:14:23 +0100
Received: from [95.91.111.52] (helo=[192.168.178.21])
 by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <klaus.kusche@computerix.info>)
 id 1kpxnD-00074W-5u; Thu, 17 Dec 2020 19:14:23 +0100
Subject: Re: [bug report]: Black screen in 5.10
To: Alex Deucher <alexdeucher@gmail.com>
References: <30c555d1-e019-3668-c35b-021003e2a6e2@computerix.info>
 <20191021114731.GZ2819@lahna.fi.intel.com>
 <f5d7c7da-c7f3-df87-75b9-48db12f640fb@computerix.info>
 <20191021130541.GG2819@lahna.fi.intel.com>
 <cebaf35c-a5f5-94b1-7ccc-0e9636c95bc3@computerix.info>
 <20191021162022.GV2819@lahna.fi.intel.com>
 <313ae966-aae5-92a9-4eeb-02fec9cc43d4@computerix.info>
 <1bd561bb-593b-0576-93b8-eb70f37dcf79@computerix.info>
 <CADnq5_NYLyazVT5pEVyVHA6ZMoPA=4QrCw7MTAYx-rj7JTOPyg@mail.gmail.com>
From: Klaus Kusche <klaus.kusche@computerix.info>
Message-ID: <4a478649-5fa1-b29e-40e3-b2843460a1c9@computerix.info>
Date: Thu, 17 Dec 2020 19:14:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NYLyazVT5pEVyVHA6ZMoPA=4QrCw7MTAYx-rj7JTOPyg@mail.gmail.com>
Content-Language: en-US
X-Authenticated-Sender: klaus.kusche@computerix.info
X-Virus-Scanned: Clear (ClamAV 0.102.4/26020/Thu Dec 17 15:34:34 2020)
X-Mailman-Approved-At: Thu, 17 Dec 2020 18:57:55 +0000
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Hello,

On 17/12/2020 16:17, Alex Deucher wrote:
> On Thu, Dec 17, 2020 at 10:15 AM Klaus Kusche
> <klaus.kusche@computerix.info> wrote:
>> With kernel 5.10.x, both the internal notebook display and any external screen
>> become black (or go to the "off" state?) when the kernel boots
>> (one or two seconds after the VGA text console is shown),
>> and the system no longer reacts.
>>
>> 5.9.x is fine.
>>
>> This seems to happen as soon as the amdgpu kernel driver loads/initializes,
>> even in pure text mode (VGA console or framebuffer), without starting X.
>>
>> Dell Precision notebook with
>> AMD Radeon (TM) Pro WX 3200 Series (POLARIS12, DRM 3.39.0, 5.9.15-gentoo, LLVM 11.0.0) (0x6981)
>>
>> Tried all combinations of DC/non-DC, FB/non-FB kernel configurations
>> (even happens when configuring Amdgpu without framebuffer!).
> 
> I think this may be the same issue as:
> https://patchwork.freedesktop.org/patch/408230/
> Does the patch there help?  It's already on it's way upstream.
The patch fixes it. 5.10.1 works fine for me now.

Will 5.10.2 contain the patch or shall I skip 5.10.2 ?

-- 
Prof. Dr. Klaus Kusche
Private address: Rosenberg 41, 07546 Gera, Germany
+49 365 20413058 klaus.kusche@computerix.info https://www.computerix.info
Office address: DHGE Gera, Weg der Freundschaft 4, 07546 Gera, Germany
+49 365 4341 306 klaus.kusche@dhge.de https://www.dhge.de
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
