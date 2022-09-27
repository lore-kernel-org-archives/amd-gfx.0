Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38117C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 17:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FC210E065;
	Tue, 27 Sep 2022 17:13:43 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660E710E065
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 17:13:39 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4McR6R6stwz9sSL;
 Tue, 27 Sep 2022 19:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1664298815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgjL0vFBlBgqR+aqOwwSJ1UADNt+GMlq85bSVnPPESY=;
 b=cMWx5Tmvzr6apX9IPOadz6/9jYsSUKcJ79lZPV5MqUt5QG57YdptzNXMWGyYRMparKeae8
 9cpu+KJieefiM65ONk8jzyZZRaI4mjVd8v3rPNP5M2W/wKj3Nhz2QT9mQZiWXQ17wr7WHA
 Lu+klZvUBOX+q04FQaZH21/QDLh7jYi96gepO2TJ7/24r4KvXD+/Elmd3TqeRu420iAxde
 do/WojlMOFdeRNeCNCp1gqfweRtX8k2aqe6evjEKaauBvHT/6EHIQZFDzlxVlBvzf6soJk
 +5dQPNP2lDdH5m96mwEVSxP7W5d4rSYvJyUcNLt7MdoXBIKAxvWLsC6vE964Gw==
Message-ID: <1ac72ae5-9f8b-22f8-a5c6-3f33fad3a47e@mailbox.org>
Date: Tue, 27 Sep 2022 19:13:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/5] GPU workload hints for better performance
Content-Language: en-CA
To: "Sharma, Shashank" <shashank.sharma@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <1b549873-106d-1e93-7f77-4a3966828b9c@mailbox.org>
 <181b4f95-7a46-c8a3-0ffd-0d338f3cb193@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <181b4f95-7a46-c8a3-0ffd-0d338f3cb193@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ahti4eqszjfopecuu16my7tukjosxa3q
X-MBO-RS-ID: 556084ef8d5bbc3f859
X-Rspamd-Queue-Id: 4McR6R6stwz9sSL
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-27 18:59, Sharma, Shashank wrote:
> Hey Michel,
> Thanks for the review coments.
> 
> On 9/27/2022 6:24 PM, Michel Dänzer wrote:
>> On 2022-09-26 23:40, Shashank Sharma wrote:
>>> AMDGPU SOCs supports dynamic workload based power profiles, which can
>>> provide fine-tuned performance for a particular type of workload.
>>> This patch series adds an interface to set/reset these power profiles
>>> based on the workload type hints. A user can set a hint of workload
>>> type being submistted to GPU, and the driver can dynamically switch
>>> the power profiles which is best suited to this kind of workload.
>>>
>>> Currently supported workload profiles are:
>>> "None", "3D", "Video", "VR", "Compute"
>>>
>>> V2: This version addresses the review comment from Christian about
>>> chaning the design to set workload mode in a more dynamic method
>>> than during the context creation.
>>>
>>> V3: Addressed review comment from Christian, Removed the get_workload()
>>>      calls from UAPI, keeping only the set_workload() call.
>>>
>>> Shashank Sharma (5):
>>>    drm/amdgpu: add UAPI for workload hints to ctx ioctl
>>>    drm/amdgpu: add new functions to set GPU power profile
>>>    drm/amdgpu: set GPU workload via ctx IOCTL
>>>    drm/amdgpu: switch GPU workload profile
>>>    drm/amdgpu: switch workload context to/from compute
>>
>> Where are the corresponding Mesa changes?
>>
>>
> This series here was to get the feedback on the kernel side design first. As you can see from the patch history, we have already changed the design once and this is V2. So I thought it would be a good idea to get the feedback on kernel UAPI, before starting sending patches to mesa.

In general, it's not possible to review UAPI without the corresponding user-space code. I don't think this is an exception.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

