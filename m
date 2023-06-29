Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25243EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 13:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF97C10E3CB;
	Thu, 29 Jun 2023 13:11:43 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165F310E3CA;
 Thu, 29 Jun 2023 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5gBm7015A4hdAPyt1XTpmFIFSaE1k9BcyQR+lyfqJ8o=; b=WcF7a7PvHPSSH8RkVJssqlUU+s
 ImScZlAnduZcKAwEtiUvHyTPNF9vZBW26pH3ld6VExtPVXcKZMyDvFSXjvRVLv6F46fkbIwtmGJSW
 3J/hGWgetzDJjykSs/LPhPzQQ9d9hSg6lyJXfm6mYTJLoTQN0EEcduJ10WsEXRVuZ+a4Sgp6KX73m
 sxLLQffRdpKecaMLzKCKuuFm0WePnUOmZMTNN2UR2dq00AskhaueObNPhKW3YM2R08xCBCm6YUs8l
 xzTOWIrZ97X1ZdRqiHZuyxWgh9XNpjmDihWhIQPXF7VqBwr6gC9Dg03Fq31r8nL6P6B5DIAbQy1It
 Eo/BZCEQ==;
Received: from [187.74.70.209] (helo=[192.168.1.111])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1qErQX-005nTk-1p; Thu, 29 Jun 2023 15:11:13 +0200
Message-ID: <02789f9b-ff16-b419-097f-b97b56afad57@igalia.com>
Date: Thu, 29 Jun 2023 10:11:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Content-Language: en-US
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <1dbeb507-3f18-1b5d-37be-fcfd60a1c0d4@gmail.com>
 <b3f72b45-c607-7cd3-2bdb-21567f901469@igalia.com>
In-Reply-To: <b3f72b45-c607-7cd3-2bdb-21567f901469@igalia.com>
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, kernel-dev@igalia.com,
 =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Simon Ser <contact@emersion.fr>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Pekka Paalanen <ppaalanen@gmail.com>,
 =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Rob Clark <robdclark@gmail.com>, alexander.deucher@amd.com,
 Daniel Stone <daniel@fooishbar.org>, Dave Airlie <airlied@gmail.com>,
 christian.koenig@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Em 27/06/2023 18:17, André Almeida escreveu:
> Em 27/06/2023 14:47, Christian König escreveu:
>> Am 27.06.23 um 15:23 schrieb André Almeida:
>>> Create a section that specifies how to deal with DRM device resets for
>>> kernel and userspace drivers.
>>>
>>> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>> ---
>>>
>>> v4: 
>>> https://lore.kernel.org/lkml/20230626183347.55118-1-andrealmeid@igalia.com/
>>>
>>> Changes:
>>>   - Grammar fixes (Randy)
>>>
>>>   Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 68 insertions(+)
>>>
>>> diff --git a/Documentation/gpu/drm-uapi.rst 
>>> b/Documentation/gpu/drm-uapi.rst
>>> index 65fb3036a580..3cbffa25ed93 100644
>>> --- a/Documentation/gpu/drm-uapi.rst
>>> +++ b/Documentation/gpu/drm-uapi.rst
>>> @@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a 
>>> third handler for
>>>   mmapped regular files. Threads cause additional pain with signal
>>>   handling as well.
>>> +Device reset
>>> +============
>>> +
>>> +The GPU stack is really complex and is prone to errors, from 
>>> hardware bugs,
>>> +faulty applications and everything in between the many layers. Some 
>>> errors
>>> +require resetting the device in order to make the device usable 
>>> again. This
>>> +sections describes the expectations for DRM and usermode drivers when a
>>> +device resets and how to propagate the reset status.
>>> +
>>> +Kernel Mode Driver
>>> +------------------
>>> +
>>> +The KMD is responsible for checking if the device needs a reset, and 
>>> to perform
>>> +it as needed. Usually a hang is detected when a job gets stuck 
>>> executing. KMD
>>> +should keep track of resets, because userspace can query any time 
>>> about the
>>> +reset stats for an specific context.
>>
>> Maybe drop the part "for a specific context". Essentially the reset 
>> query could use global counters instead and we won't need the context 
>> any more here.
>>
> 
> Right, I wrote like this to reflect how it's currently implemented.
> 
> If follow correctly what you meant, KMD could always notify the global 
> count for UMD, and we would move to the UMD the responsibility to manage 
> the reset counters, right? This would also simplify my 
> DRM_IOCTL_GET_RESET proposal. I'll apply your suggestion to the next doc 
> version.
> 

Actually, if we drop the context identifier we would lose the ability to 
track which is the guilty context. Vulkan API doesn't seem to care about 
this, but OpenGL does.

>> Apart from that this sounds good to me, feel free to add my rb.
>>
>> Regards,
>> Christian.
>>
>>
