Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0100CC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 08:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A09A10E160;
	Mon, 21 Nov 2022 08:26:01 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55AA10E136
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Nov 2022 17:25:40 +0000 (UTC)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1owo4V-0000vZ-Ly; Sun, 20 Nov 2022 18:25:35 +0100
Message-ID: <acb1c70c-0155-4d8b-205e-42514b95ebc8@leemhuis.info>
Date: Sun, 20 Nov 2022 18:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [6.1][regression] after commit
 dd80d9c8eecac8c516da5b240d01a35660ba6cb6 some games (Cyberpunk 2077, Forza
 Horizon 4/5) hang at start #forregzbot
Content-Language: en-US, de-DE
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsOeQ7VYm98jRVaYp6KaNsFVsAnSb33ZT8JvZxcTcEGW0w@mail.gmail.com>
 <a67598e8-c826-2740-03bb-33d37c8c8e4b@amd.com>
 <CABXGCsNvFvJz4=N=JKYSGVcd=dKfQ3Nv_zOssMb0Z6oK79xZ7g@mail.gmail.com>
 <a537212d-4b42-4ba4-7707-1e397234c8b7@amd.com>
 <CABXGCsMCfACsJRDPqZDYQGMpaA_6LKhQ0XqAmDN04GSMeetXnA@mail.gmail.com>
 <ca6c98eb-fdb0-5fee-3925-5b697e3e6b50@gmail.com>
 <CABXGCsPJFvNXfbdR=_sb4gLdd2E30aRN9usSiZc2XYmZNSKBcQ@mail.gmail.com>
 <dc802bd0-ed77-d268-25e2-1cf162202912@gmail.com>
 <c5c4f572-4720-04ff-3c70-30bba9c37202@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c5c4f572-4720-04ff-3c70-30bba9c37202@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1668965141;
 dea48303; 
X-HE-SMSGID: 1owo4V-0000vZ-Ly
X-Mailman-Approved-At: Mon, 21 Nov 2022 08:25:53 +0000
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

On 14.11.22 14:22, Christian König wrote:
> 
> I've found and fixed a few problems around the userptr handling which
> might explain what you see here.
> 
> A series of four patches starting with "drm/amdgpu: always register an
> MMU notifier for userptr" is under review now.

#regzbot monitor:
https://lore.kernel.org/all/20221115133853.7950-1-christian.koenig@amd.com/
#regzbot fixed-by: fec8fdb54e8f


