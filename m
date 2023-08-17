Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB11FC2FC22
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 19:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D045A10E01F;
	Thu, 17 Aug 2023 19:41:27 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165C510E0B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 19:33:38 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4ff8f2630e3so122923e87.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692300816; x=1692905616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PTeIB9pYid3fqigxOWDYDIY+mY1GdyvBJZisg+HzkYA=;
 b=fbU/9t3RDvtxuksYoldZXzqJDboq8G8kNUyAl3ZwtPtbJWICLy6BJ+DuaIUMT7npJN
 Gjx7Y9oAQNiKfZF9BCKesyPWepm0nwn8mYIiv7BYKTrKwFQWFQ43ruoadZpw4phnGhSZ
 bSY1KyR16CE2ftaOs5+J+PHffdf6F/rx9bNFuGOSYwbWdIzquGljtoeGckrhQn8pSEcf
 PP69YFAXpke+YGIy1mp4d2ZZqXgcqMFnTQ8PQx50TS1gkqZRXoFUbTn8Q03RpWYjqkmw
 KeK6BcX/+HjjSKPKYa70Oi01T9fQuJ8vW3c3XY1joLKo4xxM4k1rCNECfhfcTm9f9m3I
 k11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692300816; x=1692905616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PTeIB9pYid3fqigxOWDYDIY+mY1GdyvBJZisg+HzkYA=;
 b=A+kDtK+3sVdxsVtUiTcfk+O9kHzT5EtnYK/sOv2RdPCKFKwn1SVSqvdXR61YEndG2z
 PU/b2YKKrFLvLFRWvN6JRTBf9HjLePMNhUqO6dpjyIvvYV1crZcQtRS/V5r/RHpPbA+1
 Ql4wNS00uSsjvwcpUFIn66R+uW/xIoQF+Rk8Qt9Bio28ELZTSQIbH0H1uHh/+my0BM5t
 eeHWK4I44dHZBTJM/ayciyDXMZGpJ7BSIHVwpqskiE+xmK4AXDkKDNLKaqm0jS8mNEyw
 XZkLvAM/5h/6+fFQB4XrkLcQ3HW6DUxHB4zT2GYYg091csWVPFZpjlGW73WHQanFRxFD
 Qgzg==
X-Gm-Message-State: AOJu0Ywshlsv4MLVqHWcZkuDMS3jT3FRAUna7Wre/u+IUhD2IV8VyJcm
 O/P/Rs3CE4P8R2ETOOoOtt5FGw==
X-Google-Smtp-Source: AGHT+IEUSC1pYvaO/o6myhvtL0cu5cdObE4VqE+nWLXGFFDln+T9PAqaBXRKiRW6sApggcbGUe+tDQ==
X-Received: by 2002:ac2:4ec3:0:b0:4fc:6e21:ff50 with SMTP id
 p3-20020ac24ec3000000b004fc6e21ff50mr160888lfr.55.1692300816221; 
 Thu, 17 Aug 2023 12:33:36 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a056402001000b0052565298bedsm138330edu.34.2023.08.17.12.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 12:33:35 -0700 (PDT)
Message-ID: <d9f9c272-ce9b-4599-bb11-1c026087ead3@linaro.org>
Date: Thu, 17 Aug 2023 22:33:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
To: Simon Ser <contact@emersion.fr>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-4-dmitry.baryshkov@linaro.org>
 <20230802185547.GC32500@pendragon.ideasonboard.com>
 <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org>
 <20230802191351.GA1407@pendragon.ideasonboard.com>
 <DE2B4523-D16C-4AFC-8352-212B23548DD5@linaro.org>
 <b6oOVz2YMIG4hJDWhq9lTh6R2HYcrpRwHENhplig9KSQMD8dIjTgC5KdH1Ij3URgV2HESp67Ax7QUsByGjMLouvbs-5q7PiPRdLkgJz6Fwk=@emersion.fr>
 <ADjuOeqA6575DKutMPaR9mW9rLhm-wjLc4ruoUkNwImf-GB90FdwDB7v7y6LFdzVG3BC4R52A0RUtStK4_smmGYTUs3UPDOX4T4Zl2YHkxE=@emersion.fr>
 <20230803204459.GD27752@pendragon.ideasonboard.com>
 <TR8IBdXbd0C4U8Z4zf9ZLEH66QMutWs0QAAkPnMlKiOvgEZCk6AfEIPcIfRC555XWs8eSzeCCCW9R-3NwxZg6hDhPvPseAgAULAdUQ6epDA=@emersion.fr>
Content-Language: en-GB
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <TR8IBdXbd0C4U8Z4zf9ZLEH66QMutWs0QAAkPnMlKiOvgEZCk6AfEIPcIfRC555XWs8eSzeCCCW9R-3NwxZg6hDhPvPseAgAULAdUQ6epDA=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Aug 2023 19:41:25 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Andrzej Hajda <andrzej.hajda@intel.com>, Janne Grunau <j@jannau.net>,
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Andy Gross <agross@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Leo Li <sunpeng.li@amd.com>,
 intel-gfx@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simon, Laurent,

On 03/08/2023 23:46, Simon Ser wrote:
> On Thursday, August 3rd, 2023 at 22:44, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> 
>> On Thu, Aug 03, 2023 at 03:31:16PM +0000, Simon Ser wrote:
>>
>>> On Thursday, August 3rd, 2023 at 17:22, Simon Ser contact@emersion.fr wrote:
>>>
>>>> The KMS docs describe "subconnector" to be defined as "downstream port" for DP.
>>>> Can USB-C (or USB) be seen as a DP downstream port?
>>>
>>> To expand on this a bit: I'm wondering if we're mixing apples and
>>> oranges here. The current values of "subconnector" typically describe
>>> the lower-level protocol tunneled inside DP. For instance, VGA can be
>>> tunneled inside the DP cable when using DP → VGA adapter.
>>
>> Doesn't this contradict the example use case you gave in your previous
>> e-mail, with wlroots stating "DP-3 via DVI-D" ? I understand that as DP
>> carried over a DVI-D physical connector, did I get it wrong ?
> 
> No, this is DVI carried over DP. DP cannot be carried over VGA/DVI/HDMI,
> but VGA/DVI/HDMI can be carried over DP.

Please excuse me for the long delay, I was on vacation.

Several notes on the subconnector topic.

For TV and DVI-I we are really identifying a connector (or a part of the 
connector pins) present on the device.

So, we can have e.g. following combinations (type / subtype):

DVI-I / DVI-D (digital part of DVI connector)
DVI-I / DVI-A (analog part of DVI connector)

TV / S-Video (full S-Video connector)
TV / Composite (either a separate Composite connector, or shared with 
S-Video)
etc.

For DP unfortunately we have mixed everything together.
The physical connector present on the device can be DP / miniDP or USB-C 
(or micro-USB for SlimPort).

The physical protocol can be DP or DVI / HDMI (but only for dual-mode DP 
ports). Over USB-C link the DP can be transferred using DP or USB signal 
levels.

And last, but not least, we have the dongle / display connector type, 
which can be VGA (for active DP -> VGA converters), HDMI, DVI, DP, etc.

If we were designing this from the scratch, I'd say that we should 
encode physical connector type to DRM connector type and the dongle type 
to subconnector. However AMD and Intel drivers have already reused 
DisplayPort connector type for USB-C connections. Subconnector type 
represents (if known) the type of downstream / dongle port. I'm not 
going to judge whether this was correct or not. We have to live with 
this and behave in a similar way.

We have been looking for a way to document that the corresponding DP 
port is represented by the USB connector on the device.

Consequently, I believe the best way to document it, would be to use 
DisplayPort / USB, when there is no dongle connected, switching to 
DisplayPort / HDMI, DisplayPort / VGA, DisplayPort / DisplayPort, etc. 
when the actual dongle / display is connected and then switching back to 
the DisplayPort / USB when it gets disconnected.

If this sounds good to all parties, I'll post v2, adding this 
explanation to the cover letter.

-- 
With best wishes
Dmitry

