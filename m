Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3C1CD1292
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 10:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE4C11B37E;
	Thu,  4 Apr 2024 10:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F7zOCAhq";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 142A210FDF7;
 Wed,  3 Apr 2024 16:42:29 +0000 (UTC)
Received: from [100.64.216.231] (unknown [20.29.225.195])
 by linux.microsoft.com (Postfix) with ESMTPSA id 769C820E8CB1;
 Wed,  3 Apr 2024 09:42:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 769C820E8CB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1712162549;
 bh=vqt9SWYA+DonVFY3bwxfhND2wn3sK4WmMeoT1wrpVFg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=F7zOCAhqFjnPTo0KQRYeE5uaIvqcIJyPOzLq2iBWdr4/iS1BFOtgydlTfhGdni/uY
 iQe+halaQkCqhosXfjF16IdtmPqtyPh6IScEcHIn0jn1nl91AmmtdwdUuMD5wYIr47
 D+BmC3oQaJFSpLyY4kMKD5trvQTBtQmMygvY8AiA=
Message-ID: <8f475409-d56d-45b4-8310-4c2122a43eb7@linux.microsoft.com>
Date: Wed, 3 Apr 2024 09:42:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 02/14] drm/amdgpu, drm/radeon: Make I2C terminology more
 inclusive
To: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Candice Li <candice.li@amd.com>, Ran Sun <sunran001@208suo.com>,
 Alexander Richards <electrodeyt@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Ruan Jinjie <ruanjinjie@huawei.com>,
 Alan Liu <haoping.liu@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Samson Tam <samson.tam@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 Sohaib Nadeem <sohaib.nadeem@amd.com>, Lewis Huang <lewis.huang@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Jun Lei <jun.lei@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad kamal <asad.kamal@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, Darren Powell <darren.powell@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>
References: <20240329170038.3863998-1-eahariha@linux.microsoft.com>
 <20240329170038.3863998-3-eahariha@linux.microsoft.com>
 <Zgb3VYsgLjhJ2HKs@ashyti-mobl2.lan>
 <ceeaafe1-49d5-4602-8251-eed63a1be2b6@linux.microsoft.com>
 <Zgb8gieDzZtZmg2q@ashyti-mobl2.lan> <Zg1NW0jqwFn4lvEP@intel.com>
 <87sf02d1zf.fsf@intel.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <87sf02d1zf.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Apr 2024 10:31:24 +0000
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

On 4/3/2024 6:12 AM, Jani Nikula wrote:
> On Wed, 03 Apr 2024, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
>> On Fri, Mar 29, 2024 at 06:38:10PM +0100, Andi Shyti wrote:
>>> Hi,
>>>
>>> On Fri, Mar 29, 2024 at 10:28:14AM -0700, Easwar Hariharan wrote:
>>>> On 3/29/2024 10:16 AM, Andi Shyti wrote:
>>>>> Hi Easwar,
>>>>>
>>>>> On Fri, Mar 29, 2024 at 05:00:26PM +0000, Easwar Hariharan wrote:
>>>>>> I2C v7, SMBus 3.2, and I3C specifications have replaced "master/slave"
>>>>>
>>>>> I don't understand why we forget that i3c is 1.1.1 :-)
>>>>
>>>> That's because it's a copy-paste error from Wolfram's cover letter. :) I'll update
>>>> next go-around.
>>>
>>> not a binding comment, though. Just for completeness, because we
>>> are giving the version to the i2c and smbus, but not i3c.
>>>
>>>>>> with more appropriate terms. Inspired by and following on to Wolfram's
>>>>>> series to fix drivers/i2c/[1], fix the terminology for users of
>>>>>> I2C_ALGOBIT bitbanging interface, now that the approved verbiage exists
>>>>>> in the specification.
>>>>>
>>>>> The specification talks about:
>>>>>
>>>>>  - master -> controller
>>>>>  - slave -> target (and not client)
>>>>>
>>>>> But both you and Wolfram have used client. I'd like to reach
>>>>> some more consistency here.
>>>>
>>>> I had the impression that remote targets (i.e external to the device) were to be called clients,
>>>> e.g. the QSFP FRUs in drivers/infiniband, and internal ones targets.
>>>> I chose the terminology according to that understanding, but now I can't find where I got that
>>>> information.
>>>
>>> The word "client" does not even appear in the documentation (only
>>> one instance in the i3c document), so that the change is not
>>> related to the document as stated in the commit log. Unless, of
>>> course, I am missing something.
>>>
>>> I'm OK with choosing a "customized" naming, but we need to reach
>>> an agreement.
>>>
>>> I raised the same question to Wolfram.
>>
>> I don't know where that discussion happened, but my opinion
>> is NAK to "client". Life is already confusing enough with
>> these renames, so let's not make it even more confusing by
>> inventing new names nowhere to be found in the spec.
>>
>> And let's especially not invent names that don't even fit
>> the purpose. "Client" makes me think of "client/server" or
>> some real world analogy. Neither of which seem to have any
>> resemblence to how the term would be used for i2c.
> 
> Agreed.
> 
> I2C 7.0, I3C 1.1.1, and SMBus 3.2 have all switched to controller/target
> terminology. The SMBus spec has additionally converted generic host
> references to controller.
> 
> At least for i915 where I have some say in the matter, controller/target
> it shall be.
> 
> 
> BR,
> Jani.
> 
> 

Will do in v1. Thanks for the review, Jani and Ville.

Thanks,
Easwar
