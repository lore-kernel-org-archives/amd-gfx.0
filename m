Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99524C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 12:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CBE61130
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 12:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CBE61130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EB06E0BA;
	Thu,  1 Apr 2021 12:32:25 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BDE6E02A;
 Thu,  1 Apr 2021 12:32:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 8740CC800B5;
 Thu,  1 Apr 2021 14:32:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id lvO4sv4hQovF; Thu,  1 Apr 2021 14:32:14 +0200 (CEST)
Received: from [IPv6:2003:e3:7f0c:2000:d739:3a07:1878:3326]
 (p200300E37F0C2000d7393a0718783326.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f0c:2000:d739:3a07:1878:3326])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPSA id 3867FC800A7;
 Thu,  1 Apr 2021 14:32:14 +0200 (CEST)
Subject: Re: [PATCH] drm/amd/display: Try YCbCr420 color when YCbCr444 fails
To: Alex Deucher <alexdeucher@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20210317151348.11331-1-wse@tuxedocomputers.com>
 <CADnq5_OpJ-2jR4D8xwH93PZKoMWXx8C2yGTkqt7KRrVgph-KvA@mail.gmail.com>
 <53b26416-31d0-6efd-04e9-2a9f34e525b7@amd.com>
 <CADnq5_NwuTv5pWiOk_bYdemm+aPi_SNZTYzMLO3ewma-Bkwhkg@mail.gmail.com>
From: Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <b9d15c48-5175-3ca4-c9cf-142c95a3fbee@tuxedocomputers.com>
Date: Thu, 1 Apr 2021 14:32:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_NwuTv5pWiOk_bYdemm+aPi_SNZTYzMLO3ewma-Bkwhkg@mail.gmail.com>
Content-Language: en-US
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.21 um 17:28 schrieb Alex Deucher:
> Applied.  Thanks!
>
> Alex
Nice to hear that ^^

One quick question: Here do I find the amd-gfx dev branch?

Kind regards,

Werner Sembach
>
> On Fri, Mar 26, 2021 at 10:59 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>>
>> On 2021-03-24 4:23 p.m., Alex Deucher wrote:
>>> On Wed, Mar 17, 2021 at 11:25 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
>>>> When encoder validation of a display mode fails, retry with less bandwidth
>>>> heavy YCbCr420 color mode, if available. This enables some HDMI 1.4 setups
>>>> to support 4k60Hz output, which previously failed silently.
>>>>
>>>> On some setups, while the monitor and the gpu support display modes with
>>>> pixel clocks of up to 600MHz, the link encoder might not. This prevents
>>>> YCbCr444 and RGB encoding for 4k60Hz, but YCbCr420 encoding might still be
>>>> possible. However, which color mode is used is decided before the link
>>>> encoder capabilities are checked. This patch fixes the problem by retrying
>>>> to find a display mode with YCbCr420 enforced and using it, if it is
>>>> valid.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: <stable@vger.kernel.org>
>>>
>>> This seems reasonable to me.  Harry, Leo, Any objections?
>>>
>> Looks good to me.
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>
>> Harry
>>
>>> Alex
>>>
>>>> ---
>>>>
>>>>  From c9398160caf4ff20e63b8ba3a4366d6ef95c4ac3 Mon Sep 17 00:00:00 2001
>>>> From: Werner Sembach <wse@tuxedocomputers.com>
>>>> Date: Wed, 17 Mar 2021 12:52:22 +0100
>>>> Subject: [PATCH] Retry forcing YCbCr420 color on failed encoder validation
>>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 961abf1cf040..2d16389b5f1e 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -5727,6 +5727,15 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>>>>
>>>>          } while (stream == NULL && requested_bpc >= 6);
>>>>
>>>> +       if (dc_result == DC_FAIL_ENC_VALIDATE && !aconnector->force_yuv420_output) {
>>>> +               DRM_DEBUG_KMS("Retry forcing YCbCr420 encoding\n");
>>>> +
>>>> +               aconnector->force_yuv420_output = true;
>>>> +               stream = create_validate_stream_for_sink(aconnector, drm_mode,
>>>> +                                               dm_state, old_stream);
>>>> +               aconnector->force_yuv420_output = false;
>>>> +       }
>>>> +
>>>>          return stream;
>>>>   }
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
