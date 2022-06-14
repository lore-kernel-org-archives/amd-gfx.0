Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC59C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 08:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CE610E194;
	Tue, 14 Jun 2022 08:57:42 +0000 (UTC)
X-Greylist: delayed 80189 seconds by postgrey-1.36 at gabe;
 Tue, 14 Jun 2022 08:57:40 UTC
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB2910FD84
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 08:57:40 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4LMj4d0XhQz9sJ5;
 Tue, 14 Jun 2022 10:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1655197057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/w3eF2+OyXMGvpy7mMEZiYifp7eVf8vZ1o6oDlz9S0=;
 b=KzyyefveN8snKfzul4WBUq3AK4Aq0WKCagxPJspy2lDjzhJ/NHdp5g9DQ2znUAy49gmWIl
 Zaumud/ZZXpATQMky6CKbm/gdiAJOhoV/HzbDA7Sd46+DMhi8QvE8m/CqbPs/G9ec5VV6o
 /ZAkRfGR7EVXdzLqUj0stV41GWRdTHVgLPZuWvfUoQj3wu6CW/yvWTJA/HnGy7NNrCiZDT
 mt5vvHL0rWXqquohqcJnJZ5VSmlBWFnFHrErnqGLifwMiYh4NL5SwTlXBoaGR9bQEDitDJ
 yUUFEcta/ZeagCCJamGhajS+1ASFXSGHl7n7orU4PITQbkiKLa4GU/J2Wje/yg==
Message-ID: <a5ec7ade-9386-d9cc-5f08-4a306b435379@mailbox.org>
Date: Tue, 14 Jun 2022 10:57:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Content-Language: en-CA
To: Harry Wentland <harry.wentland@amd.com>,
 "Vanzylldejong, Harry" <Harry.Vanzylldejong@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
 <20220610205245.174802-21-hamza.mahfooz@amd.com>
 <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
 <MW4PR12MB5668A72B83B72BD7EDB29BFB96AB9@MW4PR12MB5668.namprd12.prod.outlook.com>
 <DM6PR12MB425067D163386CE813BBF02FF4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <CADnq5_O0yYM6vG+R9wf7-v4uNmKqvBXWy_-kKewiBQfN6SmY+A@mail.gmail.com>
 <DM6PR12MB425031A66132DF5CEF04B0B1F4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <467bf0af-5967-63bd-97ad-4b3fd105fb9b@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <467bf0af-5967-63bd-97ad-4b3fd105fb9b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8976df32c01031f96a5
X-MBO-RS-META: gfpm3zipqxp57hxyfo83snig6mjhcbef
X-Rspamd-Queue-Id: 4LMj4d0XhQz9sJ5
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Clark,
 Felipe" <Felipe.Clark@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-13 19:55, Harry Wentland wrote:
> This seems to be a case of a Windows-centric commit description that doesn't
> completely make sense for Linux.
> 
> The code-change doesn't currently affect any behavior on Linux. It just lays
> the groundwork in DC to allow an implementation to do a memory-clock switching
> decision based around VRR support.
> 
> In short, this won't be a problem for us at this point.

Thanks for the clarification.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
