Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8415C87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B7810E078;
	Mon,  4 Aug 2025 08:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=daenzer.net header.i=@daenzer.net header.b="KOSSPBPp";
	dkim-atps=neutral
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E07210E078
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:04:03 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; t=1754294640; x=1754899440; s=webland;
 d=daenzer.net; c=relaxed/relaxed; v=1;
 bh=KehkOffdbgcwubwwS956qJDBYYjb4hEiB8835z+ZSpk=;
 h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
 b=KOSSPBPpu65PoRzSeXJN7MNW3u48C+Q1GZtgOAaTDRPZp+y5UupRGbd9RYDvQk9Y08Uhe9cGBrIfJKSa/5jfXc73YwzdhRKooY4aSVVhFR/QZWRYTrt+ksvv/jShtfg/2lKx5vA8rPxZUqw3N2jFyBR4t5RjhBM1kOCa0Tkc18TNRUezkt04qhVhaou/umLVgX4jPBvIaJgeo59wB/N2oN3F2KnrDYWKw9z13kqc7ERdntiYJ2RIJEKvRu5tU49O8wsd3o+xhwIA5xjaQGBDV0EfMt0N+HmRwTRdmawuj/InVc+SZj9CpwEDMq3Uo8+vPs+WQCovogT5Mo7Yz4Ffeg==
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202508041003592997; Mon, 04 Aug 2025 10:03:59 +0200
Message-ID: <3f54ad00-4d07-4027-9afe-380a34419784@daenzer.net>
Date: Mon, 4 Aug 2025 10:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add primary plane to commits for correct
 VRR handling
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Xaver Hugl <xaver.hugl@kde.org>
Cc: amd-gfx@lists.freedesktop.org
References: <20250730080902.6849-1-michel@daenzer.net>
 <5620e30c-d953-4cd3-993d-0aea878574a1@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Language: en-CA
Autocrypt: addr=michel@daenzer.net; keydata=
 xsDiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPM0jTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD7CXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkLOwE0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpcJGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAnjICalDn2zB1
 fXqoOkGsTwElvKa5AJ9FhyKJpysFRcejfdZwrwl9xb4oOg==
In-Reply-To: <5620e30c-d953-4cd3-993d-0aea878574a1@amd.com>
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

On 31.07.25 19:27, Harry Wentland wrote:
> On 2025-07-30 04:09, Michel Dänzer wrote:
>> From: Michel Dänzer <mdaenzer@redhat.com>
>>
>> amdgpu_dm_commit_planes calls update_freesync_state_on_stream only for
>> the primary plane. If a commit affects a CRTC but not its primary plane,
>> it would previously not trigger a refresh cycle or affect LFC, violating
>> current UAPI semantics.
>>
>> Fixes e.g. atomic commits affecting only the cursor plane being limited
>> to the minimum refresh rate.
>>
>> Don't do this for the legacy cursor ioctls though, it would break the
>> UAPI semantics for those.
>>
>> Suggested-by: Xaver Hugl <xaver.hugl@kde.org>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3034
>> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Thanks Harry.


It occurred to me that Cc: stable might be appropriate for this fix, what do you think?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
