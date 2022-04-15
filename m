Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639BEC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Apr 2022 15:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52C210EA14;
	Sat, 16 Apr 2022 15:35:26 +0000 (UTC)
X-Greylist: delayed 901 seconds by postgrey-1.36 at gabe;
 Fri, 15 Apr 2022 18:25:09 UTC
Received: from a3i311.smtp2go.com (a3i311.smtp2go.com [203.31.37.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250BC10E2D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 18:25:08 +0000 (UTC)
Received: from [10.100.33.96] (helo=mail.blazebox.homeip.net)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <paulb@blazebox.homeip.net>)
 id 1nfQOQ-IbZpeH-LN; Fri, 15 Apr 2022 18:10:03 +0000
Received: from blazebox.homeip.net (localhost [127.0.0.1])
 by mail.blazebox.homeip.net (Postfix) with ESMTP id 36A7764424B;
 Fri, 15 Apr 2022 14:10:01 -0400 (EDT)
X-Virus-Scanned: amavisd-new at blazebox.homeip.net
Received: from mail.blazebox.homeip.net ([127.0.0.1])
 by blazebox.homeip.net (mail.blazebox.homeip.net [127.0.0.1]) (amavisd-new,
 port 10024)
 with LMTP id oxyMeLGq-6Zs; Fri, 15 Apr 2022 14:09:56 -0400 (EDT)
Received: from [IPV6:2001:470:1f07:a3a:e6aa:8e9e:c988:15a] (unknown
 [IPv6:2001:470:1f07:a3a:e6aa:8e9e:c988:15a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (Client did not present a certificate)
 by mail.blazebox.homeip.net (Postfix) with ESMTPSA id 8798264423F;
 Fri, 15 Apr 2022 14:09:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blazebox.homeip.net;
 s=mail; t=1650046196;
 bh=dte0E0NR1rKJK6btdB2DvZkx0TnGunSkaIFxgdWnO60=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=v6JWpZQuuqsAZLn7owP8MszGihUtCp3Pem8UOjYmlZ4GOhS3+01mNEE92yxcz87gP
 m2HV3yU221p6NxwurNKOnstH0VuSnRy05503cP2EPcUsmyTxHEVamCYn+sV6lo7wLy
 V1eCrmnFpMoQmRcziR6Mc73PNsH5GgwznUySSpiP+2qxyD6BphTvpHpMlLv9QDodCe
 iJYGUJsu2ityF0JJdfFXzaESJe6JXJLPhtlUuJoIO9dgc67vgP6s9JmqFJQKkYvgvf
 s99CpQeIZlr6CPUYWqnY/Z71wQTqlFqTaIOIVEGnwyPDbK8KU9nU1Ye56obFFtn1vZ
 L1BdSbxW9/v5Q==
Message-ID: <964e1f7a-0078-5bc5-ab59-733435211c96@blazebox.homeip.net>
Date: Fri, 15 Apr 2022 14:09:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Unable to boot 5.18-rc kernel on amdgpu legacy (si) hardware.
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <5eef642a-d7d2-9f59-7f63-b6e89c52bdba@blazebox.homeip.net>
 <CADnq5_NOc4Q=3ZO8MUxGFyNfFU7mgrHFwEd+5O+9zQoYYUmepw@mail.gmail.com>
From: Paul Blazejowski <paulb@blazebox.homeip.net>
In-Reply-To: <CADnq5_NOc4Q=3ZO8MUxGFyNfFU7mgrHFwEd+5O+9zQoYYUmepw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 316702m:316702a3jAEqy:316702sYfOBEEuB4
X-smtpcorp-track: 1nfQOQmPZp-HLN.WLT6bWHkYP7oL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1650046207; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=dte0E0NR1rKJK6btdB2DvZkx0TnGunSkaIFxgdWnO60=;
 b=2irl1X6Za+I+Y4DKrA26olTzZ3BAPl12eq9YsudOCdzsMqq/EmhM+R+0bb3P65MmFrE92
 iqhKACEKY/fTbz0CLPhkljNRnPvH5uGThR1JZhrrcs+8z/wT1afPARNeggHuk5+aKQE9l4l
 vuCQfE6rrQIah6QTh6Q+F80mXg0baAgEJOZy6R+bGihTaHrfk2xRhp+i2CxhqWowU9Bg1Fc
 Vd4qhKBDOg+xe9kNEYIv7TXEmQd16PeI/fbTqdtJOtvkCE6Y4TQeCYrTb/NYBpoRSnWvemb
 I9xXUCRw4OPxYe2kcCharat1M+v7Su3GCeG2FCIAe+qm2iKG3RhmLpkUzHuA==
X-Mailman-Approved-At: Sat, 16 Apr 2022 15:35:25 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

-------- Original Message --------
Subject: Re: Unable to boot 5.18-rc kernel on amdgpu legacy (si) hardware.
From: Alex Deucher <alexdeucher@gmail.com>
To: Paul Blazejowski <paulb@blazebox.homeip.net>
Date: 4/15/2022, 12:15:40 PM

> On Fri, Apr 15, 2022 at 12:00 PM Paul Blazejowski
> <paulb@blazebox.homeip.net> wrote:
>>
>> Hello,
>>
>> I am unable to boot 5.18-rc1(2) kernel with my rather old (si) XFX card,
>> which works fine under 5.17.3 and previous kernels.
>>
>> The card is identified as:
>>
>> 1:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
>> Cape Verde PRO [Radeon HD 7750/8740 / R7 250E]
>>
>> Running on a Asus M5A99FX PRO R2.0 mainboard.
>>
>> The boot process stops at "fb0: EFI VGA frame buffer device" step and
>> the hdmi connected monitor just shuts off, there's not oops or any other
>> debug output captured by serial console.
>>
>> I was able to bisect the kernel tracing this to a bad commit:
>>
>> git bisect bad 3712e7a494596b26861f4dc9b81676d1d0272eaf
>> # first bad commit: [3712e7a494596b26861f4dc9b81676d1d0272eaf]
>> drm/amd/pm: unified lock protections in amdgpu_dpm.c
>>
>> And reverting this commit on 5.18-rc2 kernel makes my system bootable again.
>>
>> Please let me know if there's anything else i could provide to help fix
>> this issue. I have access to serial console if needed.
> 
> Fixed with this patch:
> https://patchwork.freedesktop.org/patch/481477/

Alex,

Great!

Just tested and indeed the patch fixed the issue!

> 
> Alex

Thank you for providing the link to a patch ...

Paul

> 
>>
>> Thank you.
