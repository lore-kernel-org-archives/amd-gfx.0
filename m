Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62D6C2BD05
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jun 2024 12:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA42810E036;
	Sun, 23 Jun 2024 12:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=froggi.es header.i=joshua@froggi.es header.b="I1/ER+qc";
	dkim-atps=neutral
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com
 [136.143.188.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB2D10E036
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jun 2024 12:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1719145334; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TycgWGrnDjmBpjXI059H8ANy7eiXHsnM9wg9Z56tOJi6nm7tqv1T3Xg3gvU1Kb8cyHVDXUOxuzAq2aE1y8loiptX1/HMSVGIdah3+oSYB9D/WnMNYNJO6EfnRnYFMr4Epure4lMVtaGHereB8CyhJtesPcaBYJJG3yVZIM+VHCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1719145334;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=2iz22W98Xf7qQHU1yGe+D0vTLbRR5dbcG3fkE93PJ1A=; 
 b=EGIATRHH9wE58bh71/cUZSADKutv3AN5J3f/+7WtNJoJv4JJJ+ufGiQ9mq5cmMHbEAcGaudCh39geDZzMJHzgzbLl7RAuDVUiUwxdpk29SMmmJL3BNVe5A/MMYlEvS7ifJmX5vFVYmjxFM5liQO6jbbxCBsXUkBXuvEHlyrDZRE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=froggi.es;
 spf=pass  smtp.mailfrom=joshua@froggi.es;
 dmarc=pass header.from=<joshua@froggi.es>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1719145334; 
 s=mail; d=froggi.es; i=joshua@froggi.es;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=2iz22W98Xf7qQHU1yGe+D0vTLbRR5dbcG3fkE93PJ1A=;
 b=I1/ER+qcZtepT8Ubj1fY60HfOBKFkj3WKmhyhSJapSuraIOgdqPsPrGmWYAh3R9k
 cuQEQqD1xyL0YkCG1oZOxLi2KEBPqyjCvSkGI9vBcGV1v01Wr4Ivrk4pjjoJXVR7CJK
 zZfdAIpaVnaHgblpz3qvvuEzMTT8P/EqKR0gtKZQ=
Received: by mx.zohomail.com with SMTPS id 1719145332120369.4833477858342;
 Sun, 23 Jun 2024 05:22:12 -0700 (PDT)
Message-ID: <a0a3169e-77f6-43e9-bb87-f25c73bf4af9@froggi.es>
Date: Sun, 23 Jun 2024 13:22:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix a possible null pointer dereference
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org, Ma Ke <make24@iscas.ac.cn>,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, srinivasan.shanmugam@amd.com,
 aurabindo.pillai@amd.com, make24@iscas.ac.cn, guchun.chen@amd.com,
 chenjiahao16@huawei.com
References: <20240622082219.1876200-1-make24@iscas.ac.cn>
 <C5F9411A-0396-4B7F-B6D8-38F2C067283E@froggi.es>
Content-Language: en-US
In-Reply-To: <C5F9411A-0396-4B7F-B6D8-38F2C067283E@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Maybe that wasn't you or whatever, but your last patch that did this got 
some CVE assigned to it that didn't really make any sense, given this is 
just a null deref that'd end up as an oops?

It can only happen if the kzalloc in drm_mode_create fails.

I imagine that the `continue` is not the best cause of action anyway, 
it's probably not worth adding some broken connector with a bunch of 
missing modes.
It's just going to make things appear more broken and be unexpected to 
userspace.

Maybe this is some new thing that we do now I am out of the loop on...

- Joshie 🐸✨

On 6/23/24 10:20 AM, Joshua Ashton wrote:
> Are you planning on submitting a bogus CVE for this patch too?
> 
> - Joshie 🐸✨
> 
> On June 22, 2024 9:22:19 AM GMT+01:00, Ma Ke <make24@iscas.ac.cn> wrote:
>> In amdgpu_connector_add_common_modes(), the return value of drm_cvt_mode()
>> is assigned to mode, which will lead to a NULL pointer dereference on
>> failure of drm_cvt_mode(). Add a check to avoid npd.
>>
>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
>> index 9caba10315a8..6cf946adb6fe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
>> @@ -458,6 +458,8 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
>> 			continue;
>>
>> 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
>> +		if (!mode)
>> +			continue;
>> 		drm_mode_probed_add(connector, mode);
>> 	}
>> }

