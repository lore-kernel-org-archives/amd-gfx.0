Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218FCC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9427D10E901;
	Thu,  8 May 2025 13:02:12 +0000 (UTC)
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A9E10E869
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=DGwF+sCKYFLJFj1kpcCuagfnDB0QbComp1z6c97B6lw=; b=iAgW+CoAIahiifH2
 JRHnkhoeyW/ONugmr8AXNsfFwoPNNORbCWPNWWbM88FWdzOCcRDx1X6tzXOx6lesKi9pC76nGZwrP
 u6zbIi5pTJeJ5XZMiiptCNd7G3HCxGosqDqm1FXIypLUPznKXu/9oHvwf3z5bYD4zYhrdCMSMaTo3
 WcN+RHwMy9byrdZWrIP8cBF658fGkEX04O/qrlw5NPpsKsjQSbhVg+q2gVeJie7INE/SQpHoJo+2v
 IoiAiaclLWDGRD0rtHPo+L3p+3356ll1Jc6ihoHyVvi25ZrsoQp7Pcf1m4zqGelc1UaB2BrCnPREW
 mC49A8pHn7zePtgBTw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uCiTO-002EZk-33;
 Wed, 07 May 2025 17:22:22 +0000
Date: Wed, 7 May 2025 17:22:22 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: questions about smu_mode2_reset_is_support and
 smu_v13_0_init_display_count
Message-ID: <aBuWzlWN5uJqsV90@gallifrey>
References: <aBqqCmYICO_C0nLT@gallifrey>
 <DM4PR12MB5165D85BD85BC8FC8BF7A3B48E88A@DM4PR12MB5165.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5165D85BD85BC8FC8BF7A3B48E88A@DM4PR12MB5165.namprd12.prod.outlook.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 17:21:56 up 10 days, 1:35, 1 user, load average: 0.15, 0.07, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Mailman-Approved-At: Thu, 08 May 2025 13:02:11 +0000
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

* Feng, Kenneth (Kenneth.Feng@amd.com) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hello Dave,

Hi Kenneth,
  Thanks for the reply.

> smu_v13_0_init_display_count() is obsolete on smu13 series. It will be removed.
> Secondly, with cod evolving, all of below can be removed as well.
>   sienna_cichlid_is_mode2_reset_supported,
>   aldebaran_is_mode2_reset_supported,
>   smu_v13_0_6_is_mode2_reset_supported

Great, I've sent a series to delete all those, see 20250507170145.102508-1-linux@treblig.org

Dave

> Thanks.
> 
> 
> 
> -----Original Message-----
> From: Dr. David Alan Gilbert <linux@treblig.org>
> Sent: Wednesday, May 7, 2025 8:32 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: questions about smu_mode2_reset_is_support and smu_v13_0_init_display_count
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi,
>   I noticed two functions that are unused but I wasn't sure what to do with them:
> 
> smu_v13_0_init_display_count() isn't called/wired up, where as the
> v11 version is wired up:
> 
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>      3574:      .init_display_count = smu_v11_0_init_display_count,
> 
> so is v13 really unused or should it be wired up in a similar way?
> 
> secondly, smu_mode2_reset_is_support() is uncalled, but it's the only caller through the mode2_reset_is_support() function pointer; so if smu_mode2_reset_is_support() was deleted, does it then make sense to clean up all of
>   sienna_cichlid_is_mode2_reset_supported,
>   aldebaran_is_mode2_reset_supported,
>   smu_v13_0_6_is_mode2_reset_supported
> 
> which that function pointer is sett to.
> 
> Thanks in advance,
> 
> Dave
> 
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
