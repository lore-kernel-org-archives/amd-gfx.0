Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A35EEEB562
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 18:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CEF10E0E6;
	Fri,  8 Sep 2023 18:43:35 +0000 (UTC)
Received: from iam.tj (soggy.cloud [IPv6:2a01:7e00:e000:151::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8C010E91B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 17:18:37 +0000 (UTC)
Received: from [IPV6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1] (unknown
 [IPv6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by iam.tj (Postfix) with ESMTPSA id 3190D347B9;
 Fri,  8 Sep 2023 18:18:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iam.tj; s=2019;
 t=1694193514; bh=0zFphaG/uT9ZcEWeFJMGeGh0q9S3EPRZ5TNKHUdu/T4=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=qTmBb7zUdbZnufjwLwXZZDo9kFuW4DceLiS1OIoBmJUX8JH9BR0x9JIDlevEDE3iK
 5hT1ec3jr5cg+CJVjd5aNXmsntqGxOXUWDs4d9dIl96skeU+IHYE5DhoWQI7hjYIpp
 ZjirdOsvu22VVt7UKC8yMen7vxBEV4GXXDogKOznoM/keNahcHLRivqWdL7JZmSfMP
 QuHaPkqdDiRunBhyukVqWmqAdNA3T6fbHnNDn9f3kQ5tgcfNjDN7NDreALP+kiKRc0
 Ok9b8fYpWU9yn0Lo56w8Z9BtW7A8TW2GZu5UL3LPvt/PZM+L21AN3bCYiMkfKm7oBZ
 ICbkyn61TqkJg==
Message-ID: <f39d5cdf-74ba-1ffe-ea1b-9160b42e1155@iam.tj>
Date: Fri, 8 Sep 2023 18:18:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: 6.5.0-rc7: RIP: 0010:radeon_gem_va_ioctl+0x3dc/0x4f0 [radeon]
Content-Language: en-GB
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <590a06b6-9f59-2b4e-dd79-091091ccb3b6@iam.tj>
 <BL1PR12MB51443B6E9400D1BE6A1791B8F71CA@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Tj <linux@iam.tj>
In-Reply-To: <BL1PR12MB51443B6E9400D1BE6A1791B8F71CA@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 08 Sep 2023 18:43:34 +0000
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

On 23/08/2023 14:56, Deucher, Alexander wrote:

>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tj
>> Sent: Wednesday, August 23, 2023 4:54 AM
>> To: amd-gfx@lists.freedesktop.org
>> Subject: 6.5.0-rc7: RIP: 0010:radeon_gem_va_ioctl+0x3dc/0x4f0 [radeon]
>>
>> Recently, and I think especially since 6.5.0-rc5 (but possibly earlier), on resume
>> from S3 suspend the host sees:
>>
> 
> If this is a regression can you bisect?  There are very few changes for the radeon driver these days.
> 
> Alex
Typical - as soon as it was reported it stopped occurring!

It would have been difficult to bisect though because I have no idea which version worked - if any. I could only mention the versions I'd noticed it in and as I build and test most versions some don't get suspend/resume cycles and some I'm testing other things and don't check the logs for everything.
