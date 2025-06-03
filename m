Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF78C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 17:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED64710E05D;
	Tue,  3 Jun 2025 17:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DHVESgtF";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F8B10E05D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 17:52:46 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d09a032914so472555585a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748973165; x=1749577965; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I4b74SmBCvnV6GkfWbzxsNNbikUXl9O4bIFqfNjLmcc=;
 b=DHVESgtF+Z8wt3efQficDypOg7ZCx32nZvCXrTC32oVU7i/B6LJm83nz28yAgWj9sV
 jVeKIFA2vk96pa0ow0WZ4VQo5hXLt+R18260FA/PiWC10chQjM3Oam95F7nKgwEbSdnS
 0MpxA9HMeiWNi41qFnAsiWCvTWUs3IPIQD/X3VgamZSzjmCAtWFRRQTZSL25GadIn6UX
 SUEPGlkKiXc0S3FWylCndA61Oene45hy1dECBQ9sYLooDH9eLVybRjkQwGmdi8BPCJoO
 6OLoPCGZY1H0wkTXCxpOnS/ruTG+wnBNFzEVNuR33Vi74QndvgX5hTIPoqVEQpMOmYWu
 ZKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748973165; x=1749577965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I4b74SmBCvnV6GkfWbzxsNNbikUXl9O4bIFqfNjLmcc=;
 b=gW1S0ETYssyLJjaxEPc6lR2oZUMgL6dIHZn1vHYL4RDLFOLetAmb8KCBIV4eQAqcUA
 EBs6vFbeoFb8nSTkZA9omgAVf71dVKiWruPM7WCRihN0Up76RnKU8Zi/VbzKTFPSDlRJ
 9eNyy4nuCcc80aspxiYgscZeL5fvp1pSeO46qiplx4HdIYnp/68AdaL7j3BjKoaxg/TZ
 BE6Kp7FwYzpmDXbrWHioRqJquqAfeW3vi3jolGcYGM4872LXdGjjK/b3ZQg+3PBJAxvh
 Wpfs/ftdBxG6pWp8EW7w7Qw12Xh1VoYbjOM5IIF6Vgw157SnV6FPW1YlLhLAMtDOdTAk
 5tlA==
X-Gm-Message-State: AOJu0YxFIkVw3+WctmikswHqJN6sW+M8x8iVFl0whcxVvZwLEePk0853
 WYk0FGW1WytCicFtPa06bafazxoa5VIwdM0Drxr80dXe8Js7dhjuyL6g
X-Gm-Gg: ASbGnct/5wAVWZyK0BAczZZelTi59skZetMQTSv8n0Uci9JDyaBbVKN0qwzeaUqXwxJ
 0mjbmQzW0ijXJgjt+zhnY21SnaeNfFDEe3CffMOfhG9cb5Plpe+rGp7HWByyZlZA9/KVwOo7KWZ
 G5f5l0NmX6Skv7vkLfDhYyRwEzTqGR6g7TMdvpsm+ql6dC/gD1ognK2ILbKUQ218gGREKIBTgX/
 BSFa7bSbm9CtnyiY/jR+27ES9liKX531uZoq5YqPudGcHEe3NAOzevoDi0e8Kdng9+MAWNVsoDr
 c++cI69IKgsgV2PpMkWeqsrCcKSPmylkCucQSgTHTgAkMRpQ37/MiLx9wOIQdy48cvqS+P4=
X-Google-Smtp-Source: AGHT+IHTl7idk0Vtu+9I1CWNIDoKCxgzHo1CDXTsNEn7jddJODEhbdmGio4vejhD1hkbl7W4dptQ2A==
X-Received: by 2002:a05:620a:4385:b0:7ca:f349:4265 with SMTP id
 af79cd13be357-7d0a1f982aamr2643957385a.4.1748973164941; 
 Tue, 03 Jun 2025 10:52:44 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 d75a77b69052e-4a43588c8dcsm77639601cf.23.2025.06.03.10.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 10:52:44 -0700 (PDT)
Message-ID: <35c5b699-d685-4b01-bbd1-931f6a4929b2@gmail.com>
Date: Tue, 3 Jun 2025 13:52:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
 <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
 <2d3fba88-ed8e-4c3b-8fb4-56633ab0aa08@gmail.com>
 <ced428cb-798e-463e-bdc6-4c01f9562c58@gmail.com>
 <5eab610e-26d0-4dd3-b46d-e61fa44364c2@gmail.com>
 <32880a04-c459-43bc-bad3-424d3b7306fc@amd.com>
 <4b919d57-1f90-48e8-9c7b-5a1814c4a07b@gmail.com>
 <a28a0a4d-614e-4ba6-a8d5-8ab06335f410@gmail.com>
 <db7f6c9b-5ff4-4bdd-a843-d5a39f1a0d84@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <db7f6c9b-5ff4-4bdd-a843-d5a39f1a0d84@amd.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/3/25 12:26 PM, Christian König wrote:
> 
> 
> On 6/3/25 16:34, John Olender wrote:
>>>> Oh, that's a very interesting find. Could you try to turn around the way the patch works?
>>>>
>>>> E.g. instead of forcing the UVD FW into the first segment, change amdgpu_uvd_force_into_uvd_segment() so that the BOs are forced into the same segment as the UVD firmware.
>>>>
>>
>> I started implementing this and I realized two main problems with this
>> approach.
>>
>> First, there's currently no guarantee the UVD FW does not cross a 256MB
>> boundary.
> 
> There actually is a guarantee for that.
> 
> FW BOs are always allocated contiguously, and the allocation backend makes sure that for example an 16MiB (rounded up) FW is always aligned to a 16MiB boundary.
> 
> So FW memory never crosses a segment boundary larger than it's rounded up size. Without that tons of things in our driver would fall apart, not just UVD :)

Aha, thanks!

> 
>   Checking for this and providing a fallback is going to make
>> this patch... not really any less complex than the original.
>>
>> Second, most of time this is just going to end up selecting the first
>> segment anyway.  I'll go more into this below.
> 
> That's fine with me. I'm just concerned about that 1% of people where it potentially worked before and we are now breaking it.
> 
>>
>>>> That would resolve my concern that this could overload the first segment. The feedback and message BO are usually rather small (4 or 128k IIRC), but the firmware is a couple of megabytes in size.
>>>>
>>>> When we have other FW and VGA emulation buffers in the first segment as well then that could result into clashing that segment to much.
>>>>

Okay this makes much more sense.  I read this as general concern and put
the brakes on, especially after missing the above.

I'll resume work on the simplified patch.

Thanks again,
John
