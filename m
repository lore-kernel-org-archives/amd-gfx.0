Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FE1C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 18:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0087D10EBC6;
	Thu, 29 Sep 2022 18:09:33 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA5410EBC6
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 18:08:13 +0000 (UTC)
Received: from [192.168.2.145] (unknown [109.252.125.248])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 91AED66022BC;
 Thu, 29 Sep 2022 19:08:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1664474892;
 bh=La925Rq/jfc9c7zpU8iYUFXdhRighVTGvM5IX3GTXsE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WPPRbDo7w5fYOlIik4mrD/VDrJV0yvx69Q30aOYDHDX3G58366FnX3Q0sK/bT50Ng
 Pm9e10Fs4J/ZZ0Jz54fWIPJAlxhRdNt9fKB8JZYtfQZE9y8dDqF7CqcT5FyMOV9ZNF
 QJUrSjb9boQAbWgktdFJFjKRQUm/M79cZ4sI5ripLjLVT1qHX0n6/H1QlFO3W6asSe
 l8LUMTG4JJIh/WXdmgdaHp8WZNhjhWLip9dnYtDkO5og5hXu/SuPMPna0Y8mWnclmR
 jfat3GuZZMmbju6e9Our1IUMA/xKilLd25e05JZsBkcU7RucUYp9rPwO8O/OfKd8OU
 Er/L+r9YMQHFg==
Message-ID: <52f11d68-0d22-4972-6a3b-c078c815e189@collabora.com>
Date: Thu, 29 Sep 2022 21:08:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-10-Hawking.Zhang@amd.com>
 <BL1PR12MB514443C746109B972824368BF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BN9PR12MB5257828CD0C0CE680B14D27CFC509@BN9PR12MB5257.namprd12.prod.outlook.com>
 <8a383215-4a8a-243c-6cef-6e7fc12af001@collabora.com>
 <BL1PR12MB5144E1AA8FE0EDCCCA8B12ACF7549@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2da3a6aa-8f3e-a640-d351-c923c8c924e5@collabora.com>
 <b5fcab24-5c6c-d585-261b-2b202283eba0@collabora.com>
 <CADnq5_MMD-7rF0K9abMrj-y-DWbMZOuvYT6U5bSV3=w3yd43Qw@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CADnq5_MMD-7rF0K9abMrj-y-DWbMZOuvYT6U5bSV3=w3yd43Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 29 Sep 2022 18:09:30 +0000
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 9/28/22 22:32, Alex Deucher wrote:
> On Wed, Sep 28, 2022 at 3:24 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 9/28/22 20:47, Dmitry Osipenko wrote:
>>> On 9/28/22 20:44, Deucher, Alexander wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>> This should be fixed in a backwards compatible way with this patch:
>>>> https://patchwork.freedesktop.org/patch/504869/
>>>
>>> Good to know that it's already addressed, thank you very much for the
>>> quick reply.
>>
>> Unfortunately, that patch doesn't help beige goby. Please fix.
> 
> https://patchwork.freedesktop.org/patch/505248/

That helped, thank you.

-- 
Best regards,
Dmitry

