Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64922C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 05:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0876D89D44;
	Mon, 28 Mar 2022 05:49:23 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE17B89C68
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 05:49:21 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8DE7861EA1923;
 Mon, 28 Mar 2022 07:49:19 +0200 (CEST)
Message-ID: <37f37f4d-1af9-31fe-a5de-ddf27cd7b30b@molgen.mpg.de>
Date: Mon, 28 Mar 2022 07:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/13] drm/amd/display: HDCP SEND AKI INIT error
Content-Language: en-US
To: Alex Hung <Alex.Hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-2-alex.hung@amd.com>
 <7efe6fd0-9dd2-fa80-54f7-2186b4d64721@molgen.mpg.de>
 <BYAPR12MB3048EBCE33104856A122B89BF71A9@BYAPR12MB3048.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <BYAPR12MB3048EBCE33104856A122B89BF71A9@BYAPR12MB3048.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex,


Am 25.03.22 um 21:43 schrieb Hung, Alex:

> Thanks for your feedback.

Thank you for your reply. For the future, it’d be great if you could use
interleaved style [1], when replying, or when it’s a new topic, do not 
cite the previous message.

> I fixed many errors and typos you highlighted in this series. In
> cases where modification requires re-testing we or anyone can have
> follow-up patches in the future.

Thank you. Did you resubmit them in *[PATCH 00/16] DC Patches March 25, 
2022*? Unfortunately, they are not tagged as v2 and the emails do not 
contain an information what was changed between v1 and v2. Can you 
please send them again with the correct tags, and information included?


Kind regards,

Paul


[1]: https://en.wikipedia.org/wiki/Posting_style
