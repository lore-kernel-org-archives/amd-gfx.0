Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C673C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 12:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B4010E546;
	Wed, 28 Sep 2022 12:41:21 +0000 (UTC)
Received: from abi149hd127.arn1.oracleemaildelivery.com
 (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A3310E38D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=xVfTte0TU0Tcn0VAkTnwLLU/ps8Np9562fwTrRsRgrk=;
 b=Vy7H8oWIl2kIi0jrdnys7xLAF8doYhsDJ9wHHqZDfsxP5GbQjADYXUmrdn4cpsXvDEQnKLJMVeug
 bz+GS2ZGprQtQuFoROP1VEUBt8QWxKfF1oolbh5vfcyCeCatXruRKN7aehRFEmhRiAwCnIbMSRXH
 cru9rAhItLRr5RESGiNC37BhvyIEv85jtiesrxAz4jUozisxiarTanFwJ4V53qaUHtRbGWsRqoA+
 PelrLyeqAIL31McT7ak5+211YosKN26f2ptp9F8j0+PjvcFp6nLJmsUDbEgUniK0bTCIL2AL9eT1
 xY2zCVFNZVjMLDt2x8U01exiCYuwXEcS7TpJlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=xVfTte0TU0Tcn0VAkTnwLLU/ps8Np9562fwTrRsRgrk=;
 b=fO4CtGhuhNYArk7RzgID8UWFHMnKzZ77lSKgp6l27XBPylRJ4x9klIHRkxEQzNDVL/sL8NhuP8uL
 kgMFQUQEIpoLnZQ/7fpCBS7d1fojOkbB8sdnbT6ZyAerpoaaZ3Zz8C+1e2xs3MorCzuzXX63mGrB
 s22uJvyR9l1Hon0dVW0KjfPKuDYJNe/z82jZXGyxCZXLYyFj923YqSfMwOh3NAfxLwJ4yiKVMgoN
 O75F2b0euSL6K+/euhdMbfdrur124K6lmQwzROJi37JnP3sIfX16GpsmcsWJMAAAG8g43TCmnCeZ
 WWQvEPrNO+v/WPgMH7lUdvjOJFBWciofRmUjxQ==
Received: by omta-ad1-fd2-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20220914 64bit (built Sep 14
 2022)) with ESMTPS id
 <0RIW00N1GXPO9LA0@omta-ad1-fd2-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for amd-gfx@lists.freedesktop.org; Wed, 28 Sep 2022 09:15:24 +0000 (GMT)
Message-id: <ca3b5557-26ec-9b07-6538-7db49b83fb2d@augustwikerfors.se>
Date: Wed, 28 Sep 2022 11:15:21 +0200
MIME-version: 1.0
Subject: Re: [PATCH] drm/amd/display: Prevent OTG shutdown during PSR SU
Content-language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220927231339.187788-1-sunpeng.li@amd.com>
From: August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20220927231339.187788-1-sunpeng.li@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAH+dbp7tNOscJiWiJdIpc+jwB9qJ/94Te3M3a/LCyF+wYxMUgx38a/xmLX5tHr1
 Skdq2HFt3GyaxV2uWZbprzc1tAG7PPQmhSuD4z731vcsi2UZ5ul4gIrTFWzF2Tiw
 6GM6ZTj3/RAdcL7ffncBk2O+lf2vJxyvKQevjeck3DukbmeHet7Q1G9b1LQexdNA
 zyJXpV1+VV8T9gFA1uKKaPF+zuIaXzg+ik3hFvhiEjJ+tds6redzZxdzR6y8Obfy
 0IerfyMWgKTVw/nhAiUMtR0G1GuOi+zHRdmmI37B1rIiMaJT+yi/7g4WotHGrGb9
 LZ78JXm9UG0ruBv3IF/aU4PyGBqIEBKh9PzUQDITbJaCKldnVEd3XR16GSFAmtyl
 D6PVNdvPU5C+y2N9ZgN3FDfw5dQ1YZq/Ybz7Vg4g1SZr26vhqUn2U6khkqSocbBb TEYS3/k=
X-Mailman-Approved-At: Wed, 28 Sep 2022 12:41:17 +0000
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 regressions@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Leo,

On 2022-09-28 01:13, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Enabling Z10 optimizations allows DMUB to disable the OTG during PSR
> link-off. This theoretically saves power by putting more of the display
> hardware to sleep. However, we observe that with PSR SU, it causes
> visual artifacts, higher power usage, and potential system hang.
> 
> This is partly due to an odd behavior with the VStartup interrupt used
> to signal DRM vblank events. If the OTG is toggled on/off during a PSR
> link on/off cycle, the vstartup interrupt fires twice in quick
> succession. This generates incorrectly timed vblank events.
> Additionally, it can cause cursor updates to generate visual artifacts.
> 
> Note that this is not observed with PSR1 since PSR is fully disabled
> when there are vblank event requestors. Cursor updates are also
> artifact-free, likely because there are no selectively-updated (SU)
> frames that can generate artifacts.
> 
> [How]
> 
> A potential solution is to disable z10 idle optimizations only when fast
> updates (flips & cursor updates) are committed. A mechanism to do so
> would require some thoughtful design. Let's just disable idle
> optimizations for PSR2 for now.
I can confirm that this patch fixes the issues I had. Thanks!

> Fixes: 7cc191ee7621 ("drm/amd/display: Implement MPO PSR SU")
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
You can add:
Tested-by: August Wikerfors <git@augustwikerfors.se>

Regards,
August Wikerfors
