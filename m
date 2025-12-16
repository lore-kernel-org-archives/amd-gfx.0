Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E849BD5E150
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 13:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A0510E255;
	Tue, 16 Dec 2025 13:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="DMDWbhLl";
	dkim-atps=neutral
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8088A10E1EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=hcOZHU4AjsImOlEkkB2FropA9abtiHcxsWirl15m64U=; t=1765883667;
 x=1766315667; b=DMDWbhLlHZE+dHnkHOZmWKZ10fsaOp43v4VFNIyUJP2fqYSAGO0Dgfxa1VKuS
 KJINp4I24VqbeXIkFsuqKaCSuXgcLBMdNqIemJwcVRy6qrJ61csw2t6njaULp1NK9h2DoL0BEZ6BE
 3p8lTd9ZqtpELQe6eIEIERD5ruowHDN4rlK2Dr++InkKbTf59IoswAJCusQ4OnvZZ8+AOjQxI+GLz
 EFH2D69L2JP32BKp8kmLYdXZ7URN3rt5nkAE+LRI9ld3bVm/D2FKNouY4MmWMx6K4I4Pi7NRzwCz9
 K0hOl3C2ba/+xKMwkk2B5mc5I5fxkCpgw1xbx3Alwew8LiJNTw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 id 1vVT0a-00C6Gm-1W; Tue, 16 Dec 2025 12:14:24 +0100
Message-ID: <c7bec14b-ee8b-448f-a7ad-a741ff974ea9@leemhuis.info>
Date: Tue, 16 Dec 2025 12:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.61 lts] [amdgpu]: regression: broken multi-monitor USB4
 dock on Ryzen 7840U
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
References: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
 <ea735f1a-04c3-42dc-9e4c-4dc26659834f@oracle.com>
 <b1b8fc3b-6e80-403b-a1a0-726cc935fd2e@student.kit.edu>
 <bfb82a48-ebe3-4dc0-97e2-7cbf9d1e84ed@oracle.com>
 <7817ae7c-72d3-470d-b043-51bcfbee31b1@student.kit.edu>
 <d5664e24-71a1-4d46-96ad-979b15f97df9@student.kit.edu>
 <ee6e0b89-c3d0-4579-9c26-a9a980775e55@leemhuis.info>
 <24e5cb3b-73dd-43d3-9d35-b29d1d18340a@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 ivan.lipski@amd.com, Jerry.Zuo@amd.com, bugs@lists.linux.dev,
 regressions@lists.linux.dev, daniel.wheeler@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 aurabindo.pillai@amd.com
In-Reply-To: <24e5cb3b-73dd-43d3-9d35-b29d1d18340a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1765883667;
 71ede340; 
X-HE-SMSGID: 1vVT0a-00C6Gm-1W
X-Mailman-Approved-At: Tue, 16 Dec 2025 13:47:12 +0000
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

Greg, Sasha, could you please pick up 72e24456a54fe0 ("Revert
"drm/amd/display: Fix pbn to kbps Conversion"") [v6.19-rc1] for 6.12.y
and 6.17.y (if there is another 6.17.y version), as it fixes a a
regression there? See below for details.

Note, the mentioned patch contains "Cc:stable@vger.kernel.org # 6.17+",
but needs to go to 6.12.y, too: the culprit was backported there and
causes problems there, too.

Ciao, Thorsten

On 12/12/25 14:49, Mario Limonciello wrote:
> On 12/12/25 7:19 AM, Thorsten Leemhuis wrote:
>> On 12/9/25 16:50, Péter Bohner wrote:
>>> note: reverting ded77c1209169bd40996caf5c5dfe1a228a587ab fixes the issue
>>> on the latest 6.12.y (6.12.61) tag.
>>
>> That is 1788ef30725da5 ("drm/amd/display: Fix pbn to kbps Conversion")
>> [v6.18-rc7, v6.17.10, v6.12.60 (ded77c1209169b)] – and Mario (now among
>> the recipients) submitted a patch to revert in in mainline:
>>
>> [PATCH] Revert "drm/amd/display: Fix pbn to kbps Conversion"
>> https://lore.kernel.org/all/20251209171810.2514240-1-
>> mario.limonciello@amd.com/
>>
>> But it has "Cc: stable@vger.kernel.org # 6.17+", so that revert won't
>> make it to 6.12.y; I wonder if that is just an accident or if there is
>> some good reason for that.
>>
>> Ciao, Thorsten
> 
> It is just I didn't realize that it backported to 6.12.y.
> 
> So after this lands can you manually apply it there too?
> 
> 

