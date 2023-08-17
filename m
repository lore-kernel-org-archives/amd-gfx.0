Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B50C30654
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 15:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E007510E4E4;
	Thu, 17 Aug 2023 15:30:29 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C561910E4E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 15:30:27 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202308171730225475; Thu, 17 Aug 2023 17:30:22 +0200
Message-ID: <6fcef7e5-4df9-2ea5-f93f-1836ecc8796e@daenzer.net>
Date: Thu, 17 Aug 2023 17:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-CA
To: Harry Wentland <harry.wentland@amd.com>, Simon Ser <contact@emersion.fr>, 
 amd-gfx@lists.freedesktop.org
References: <20230817105251.103228-1-contact@emersion.fr>
 <20230817105251.103228-4-contact@emersion.fr>
 <13e88b5a-9db5-4a21-97ae-3bdc910456dd@amd.com>
 <9311891d-bc3e-407b-aab4-4bad1679f5e8@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH v3 3/4] amd/display: add cursor rotation check
In-Reply-To: <9311891d-bc3e-407b-aab4-4bad1679f5e8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1C.64DE3D10.004F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/17/23 15:46, Harry Wentland wrote:
> On 2023-08-17 09:44, Harry Wentland wrote:
>> On 2023-08-17 06:53, Simon Ser wrote:
>>> The commit 1347385fe187 ("drm/amd/display: don't expose rotation
>>> prop for cursor plane") removed the rotation property for the
>>> cursor plane, assuming the cursor would always be displayed without
>>> any rotation. However the rotation is inherited from the underlying
>>> plane.
>>>
>>> As a result, if the primary plane is rotated, then the cursor plane
>>> will incorrectly be rotated as well even though it doesn't have a
>>> rotation property.
>>>
>>> To fix this, check that the underlying plane isn't rotated.
>>>
>>
>> HW cursor works with a rotated screen on KDE on AMD HW. This
>> looks like it will break that.
>>
> 
> Sorry, scrap that. KDE seems to do a SW rotation with HW cursor.

Hmm, it does work correctly though (with Navi 14) with 180° rotation in gnome-shell, which uses plane rotation for the primary plane and pre-rotated contents for the cursor plane.

This patch results in drmModeAtomicCommit failing and the monitor losing signal instead.


Simon, how did you determine that the HW cursor contents get rotated according to the underlying planes?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

