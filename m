Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC055C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 09:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746F9610E7
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 09:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746F9610E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A156E85F;
	Mon, 31 May 2021 09:58:07 +0000 (UTC)
X-Greylist: delayed 318 seconds by postgrey-1.36 at gabe;
 Mon, 31 May 2021 09:58:05 UTC
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776AE6E85F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 09:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id ACC6441E6A;
 Mon, 31 May 2021 11:52:45 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="E/NSMa3V";
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
 by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amy-XXfWsRai; Mon, 31 May 2021 11:52:44 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1DFDF408E6;
 Mon, 31 May 2021 11:52:43 +0200 (CEST)
Received: from [192.168.0.209] (h-155-4-205-35.A357.priv.bahnhof.se
 [155.4.205.35])
 by mail1.shipmail.org (Postfix) with ESMTPSA id 83CD73600E5;
 Mon, 31 May 2021 11:52:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1622454763; bh=q/4ZD7MDRylI6Acwu4ws5IlaRpCtmBWG6Etxz1X5qIU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=E/NSMa3VFN26PteuArjhhSgN2plZExrXm0z3QTWj6KkqmLdf7uT5ApVGGfwJRda8S
 nZlWl3BI8Xv19AjROOfuowJId2gzbgaosIF1xnVVRlZguDVHTxzjQoq3qs+L3GqLQy
 7bSqH0CT+grdkdmtAA0KTX3Y/sOeopfBqvK+fND8=
Subject: Re: [PATCH 1/2] drm/ttm: cleanup and add TTM_PL_FLAG_TEMPORARY
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210527013051.4302-1-Lang.Yu@amd.com>
 <DM6PR12MB4250B79297F587313D7645EBFB3F9@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <14d7f047-cf6d-c84a-14ff-3f1d833a770b@shipmail.org>
Date: Mon, 31 May 2021 11:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4250B79297F587313D7645EBFB3F9@DM6PR12MB4250.namprd12.prod.outlook.com>
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Lang,

On 5/31/21 10:19 AM, Yu, Lang wrote:
> [Public]
>
>> Hi,
>> On 5/27/21 3:30 AM, Lang Yu wrote:
>>> Make TTM_PL_FLAG_* start from zero and add
>>> TTM_PL_FLAG_TEMPORARY flag for temporary
>>> GTT allocation use.
>> GTT is a driver private acronym, right? And it doesn't look like
>> TTM_PL_FLAG_TEMPORARY will be used in core TTM, so should we instead set
>> aside a mask in the PL flag for driver-private use?
> Hi Thomas,
>
> Thanks for your comments and advice, GTT means Graphics Translation Table here, seems
> a general acronym. TTM_PL_FLAG_TEMPORARY may also be used by other drives.
> I have made other patches for this. Please help review.
>
> Regards,
> Lang
>
My point was really that the flag naming and documentation should 
reflect what core ttm is doing with that flag. If there is no specific 
core TTM usage, IMO we should move it to a driver specific flag to avoid 
future confusion. In particular a writer of a generic TTM resource 
manager should be able to know without looking at an old commit message 
what the placement flag is intended for.

So here we add a flag where core TTM forces a bo move on validate and 
that's it. And that appears to be how it's used when an amdgpu bo is 
evicted to GTT, (btw should it be accounted in this situation?)

The other use is to force the amdgpu driver to temporarily accept it 
into GTT when there is a lack of space, and IMHO that's a driver 
specific use and we should allocate a mask for driver specific flags for 
that.

So shouldn't this be two flags, really?

TTM_PL_FLAG_FORCE_MOVE

and

AMDGPU_PL_FLAG_TEMPORARY

Thanks,

/Thomas

>> Thomas
>> -----Original Message-----
>> From: Yu, Lang <Lang.Yu@amd.com>
>> Sent: Thursday, May 27, 2021 9:31 AM
>> To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
>> Yu, Lang <Lang.Yu@amd.com>
>> Subject: [PATCH 1/2] drm/ttm: cleanup and add TTM_PL_FLAG_TEMPORARY
>>
>> Make TTM_PL_FLAG_* start from zero and add TTM_PL_FLAG_TEMPORARY flag
>> for temporary GTT allocation use.
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>> include/drm/ttm/ttm_placement.h | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/drm/ttm/ttm_placement.h
>> b/include/drm/ttm/ttm_placement.h index aa6ba4d0cf78..9f5cfc7c2d5a 100644
>> --- a/include/drm/ttm/ttm_placement.h
>> +++ b/include/drm/ttm/ttm_placement.h
>> @@ -47,8 +47,9 @@
>>   * top of the memory area, instead of the bottom.
>>   */
>>
>> -#define TTM_PL_FLAG_CONTIGUOUS  (1 << 19)
>> -#define TTM_PL_FLAG_TOPDOWN     (1 << 22)
>> +#define TTM_PL_FLAG_CONTIGUOUS  (1 << 0)
>> +#define TTM_PL_FLAG_TOPDOWN     (1 << 1)
>> +#define TTM_PL_FLAG_TEMPORARY   (1 << 2)
>>
>> /**
>>   * struct ttm_place
>> --
>> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
