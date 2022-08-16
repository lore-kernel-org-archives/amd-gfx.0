Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA48C2BB41
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 09:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B63018ADEE;
	Tue, 16 Aug 2022 09:12:33 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E60D11259E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 09:12:23 +0000 (UTC)
Received: from thor ([85.2.99.24])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202208161112188637; Tue, 16 Aug 2022 11:12:18 +0200
Received: from [127.0.0.1] by thor with esmtp (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1oNscS-000eIe-22;
 Tue, 16 Aug 2022 11:12:16 +0200
Message-ID: <a8515153-3159-4a4f-4701-b940068850b2@daenzer.net>
Date: Tue, 16 Aug 2022 11:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
References: <20220816084410.6048-1-michel@daenzer.net>
Subject: Re: [PATCH] Revert "drm/amd/amdgpu: add pipe1 hardware support"
In-Reply-To: <20220816084410.6048-1-michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1D.62FB5F75.0012,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-08-16 10:44, Michel Dänzer wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> This reverts commit 4c7631800e6bf0eced08dd7b4f793fcd972f597d.
> 
> Triggered GFX hangs with GNOME Wayland on Navi 21.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2117

Don't get me wrong, I'm really looking forward to this functionality, as it's required for reaping the full benefit of https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1880 . But it has to actually work. :)


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

