Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CCAC54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 18:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B86710E045;
	Thu, 22 Sep 2022 18:42:20 +0000 (UTC)
Received: from ach1ajh118.fra1.oracleemaildelivery.com
 (ach1ajh118.fra1.oracleemaildelivery.com [138.1.108.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2E210E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-fra1-20220101;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=hMbKnsDfGuZbST3+iKB8T0JJtGf8/ETxt5BDAqjyo60=;
 b=FXYyBWbm2KZCo8oOR6GuTWocRwSDPxtgpRP3wQRSqj6UH+CXUwKn0LPuF2CjH6USA/+MeqV2Zizx
 U9+pMzLzqaBxzwRzc5PmPqH4b5JhbGqXUcy84I1TWA1vWhcxn8b0pe+VznEEvUnUbr905lfohyQU
 TGxfHCndMPqz/H3Gqd8jApa+GyiKXfPUkJGmMs5j8/VxPpv1BhZl+4y1T32SO3zZq+4gvAT3K04n
 whg9no5siCSdLWdNbGvppr8zaT79aUwy4m2fSSkdUo7+qJNI5hTN2FhWB14/Qo/ZrKGM3uH/Szt7
 F6egfWPLW9vM1jUqSU5YsH8zxqZy2iDcCYmWxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-fra-20191115;
 d=fra1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=hMbKnsDfGuZbST3+iKB8T0JJtGf8/ETxt5BDAqjyo60=;
 b=BijYoPiyAwNXbWmqegRJ5wx3OmVxM/8mrX1eSiLCvhaApKTQ48zk2zMv2xGmKxOdcWYwjDqzceE6
 Iyf9H8ZbRBUDNy45K/bWsEW3wNARcd4A+mmDDGfxlnu3ETqOQ6cYNgpIZqqA979ivBnRNuXdqpra
 eS5hCt4iVi3xmbd0Nrmy0lCc+6aTjmAq+B0W7R6qZ2vOcoZXi71BQ2q2qssF58Jt7FPkhdzTKnRV
 X22K4t17tzudeZ3zo928Kb3vr5MsLsgiGh6QqAWMWq72jLPDxEvAtNTenqsTEFxdlaNuDri6zNOC
 WmOtSybNYUJ5v0XgtmaAcOOiBIjzP7s1Uy1BIA==
Received: by omta-ad3-fd1-302-eu-frankfurt-1.omtaad3.vcndpfra.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20220826 64bit (built Aug 26
 2022)) with ESMTPS id
 <0RIM001FVIMZ70E0@omta-ad3-fd1-302-eu-frankfurt-1.omtaad3.vcndpfra.oraclevcn.com>
 for amd-gfx@lists.freedesktop.org; Thu, 22 Sep 2022 18:13:47 +0000 (GMT)
Message-id: <33cf5071-3157-a3c2-3252-3a8ab926c60d@augustwikerfors.se>
Date: Thu, 22 Sep 2022 20:13:39 +0200
MIME-version: 1.0
From: August Wikerfors <git@augustwikerfors.se>
Subject: Re: [REGRESSION] Graphical issues on Lenovo Yoga 7 14ARB7 laptop since
 v6.0-rc1 (bisected)
To: Alex Deucher <alexdeucher@gmail.com>
References: <c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se>
 <eee82fb8-0fc5-98cb-e630-f86891574f21@leemhuis.info>
 <CADnq5_PRP3ekHPLhdXALxt9GL3aHHZQUw5TNAwm4t+ggimUq7g@mail.gmail.com>
Content-language: en-US
In-reply-to: <CADnq5_PRP3ekHPLhdXALxt9GL3aHHZQUw5TNAwm4t+ggimUq7g@mail.gmail.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAHbDiOyw7PQ+YvQ6Tk2wL3boCy4Gse2rKd/OctvMwiREQdSmCjJhUzxDqPn50D4
 b2YL7+qFbADcEhF5v3aoKRWdW4C9GDLg1v1GIOEwYB3d1GkFFb8HifL2cGQsLRYm
 rIvmjpE2oDiEvpUhXqkWFd3LANo+s7vemDjoj6mvWZigPJY0cWnvonz3y7oiAzz3
 jHj6b9vMWowumUqy9l2IlL732Obo6dAg5tPs7Ttg0icRtL+1vbZag0BI++I7ANit
 5vvXX2BntyiNRNVZMXtkRvHu8PKICknnccqdgV+L9jMiFlHWmJBVngMkz8LlLRpg
 cuasLCWjDHHocVFs7jmSnyMjBSpBc9GVKcpq/8yiPI+kkdSCFZWgMS+Ui0Ss5upK
 LVjSWuQZOdAA6w76GxKJPMm2ta+dzeGAbOSRIgx+bKnhbP0PSsJXzlJnflpaZ47P SnraHIP2ow==
X-Mailman-Approved-At: Thu, 22 Sep 2022 18:42:18 +0000
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
Cc: regressions@lists.linux.dev, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Thorsten Leemhuis <regressions@leemhuis.info>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On 2022-09-22 15:59, Alex Deucher wrote:
> On Thu, Sep 22, 2022 at 8:54 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>> to make this easily accessible to everyone.
>>
>> @amdgpu developers, what up here? August afaics didn't even get a single
>> reply for his report that even identifies the change that's causing the
>> problem. We're already late in the development cycle, so it would be
>> good if someone could take a closer look into this before it's too late
>> for 6.0.
> 
> Been a busy week.  Haven't had a chance to look into this yet.  Does
> the issue still happen with this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66f99628eb24409cb8feb5061f78283c8b65f820
Yes, the issue still happens with that patch, and also with the current 
git master (dc164f4fb00a0abebdfff132f8bc7291a28f5401).

Regards,
August Wikerfors
