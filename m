Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB2FEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2156210E4BD;
	Wed, 21 Jun 2023 15:38:48 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
 by gabe.freedesktop.org (Postfix) with SMTP id 0C0E710E3C2;
 Wed, 21 Jun 2023 06:28:57 +0000 (UTC)
Received: from [172.30.11.106] (unknown [180.167.10.98])
 by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id DEA7D602A0301; 
 Wed, 21 Jun 2023 14:28:45 +0800 (CST)
Message-ID: <af2db7e9-5fd4-2120-8308-99b58f9ad1a6@nfschina.com>
Date: Wed, 21 Jun 2023 14:28:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IFVzZSDigJxfX3BhY2tl?=
 =?UTF-8?B?ZOKAnCBpbnN0ZWFkIG9mICJwcmFnbWEgcGFjaygpIg==?=
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <34ae0f86-c32b-4d5a-be56-0654dba0f908@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 21 Jun 2023 15:38:42 +0000
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
Cc: lkp@intel.com, Jane.Jian@amd.com, David.Francis@amd.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 oe-kbuild-all@lists.linux.dev, Likun.Gao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023/6/21 14:11, Dan Carpenter wrote:
> When there was a #pragma then Sparse just turned off.  The Sparse
> warnings are places where people forgot to put the __user in their casts
> or didn't annotate endianness correctly.  It's not a "bug" to forget
> to annotate endianness or user pointers.  That's how we used to do it
> prior to 2003.  But these days it feels strange and dangerous to see
> these sorts of warnings.
Got it. And it is really strange when I first saw these warnings.
Thanks for your explanation!

Su Hui

>
> Smatch also disabled some uninitialized variable checks.  These are
> mostly false positives where we have a loop:
>
> 	int r;
>
> 	while (something) {
> 		r = frob();
> 	}
>
> 	return r;
>
> Smatch complains that we don't necessarily enter the loop.  I think
> I'm going to disable this type of "enter the loop" warning when you
> don't have the cross function database available.  That will silence
> these for the kbuild bot.
>
> regards,
> dan carpenter
>
