Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ECBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 06:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EED56109E
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 06:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4EED56109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4ADB6E0DC;
	Thu, 23 Sep 2021 06:43:07 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2020B6E0DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 06:43:06 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id q11so13951675wrr.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 23:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=L5+q/Ej6utGM+Pqb519nEoUJTxbfWHSTd674/w0Zb2A=;
 b=JFifrZguU4MYSt1qOWEviWjqvqWgoQeUOPBg/MVI4EKdavmDsbXxMrIFbFBjpmXJBY
 jmSKLvu64WmvSuwKNZDKwx4cR72jauBS2RcRustMYQrrKiEbJElZ/elOvZh6D59MCmiN
 FT1xNpMXsyYlU1HAKCpwJMkQz2fe++jZipmwW11wCMx4MnSw/d9m5L5+dzaUVOLYxRfQ
 Y34dIvN3T+ZM3w0lm8F6pF1Cw24HUmFsp10hCwXqmDQdPRYVy/0TMJup0574aeRTw5SF
 zpRYZgRwcK0dXExGGz/r7WDwUgQ94jd1/bW7/UklktvMP6AoJoEo+7GtiP/JxLi8cD3Z
 If5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=L5+q/Ej6utGM+Pqb519nEoUJTxbfWHSTd674/w0Zb2A=;
 b=q2uUIiwuDAAFRX265ouybFqvHA6iEPUQwTaPVtYbgxupHUPO/odFwdkhEcDJ62qhLX
 1lZz6YMZxDZxE0VkRVUmm60ct/v9vWsZKrCYZVKixAFgtdSDD6lDBmUWrgv8Sv/+b8/G
 3ociRhPAVo0perCXH5/JDg1shBJ3VCHRzXUA7HPKf+mqt6Uzlspe+m/McgxgywSvcHmM
 TYlC9S8FpHnSkQMiUI2Jf9Yw0ZFsq7s7q6QFTE6RZbKDRycePquugkflh2U2r+I7liQI
 CNVDZxXt1V6g3Y8d8lxXPUU5XVG6B0CotAEWpErQkTlidGMGquEwjsfn6T/XUET3YJ1m
 /HzQ==
X-Gm-Message-State: AOAM531mFtgMjQrZVd1CKuJEjH1a0WTRKQuWsBaDf8TEnCQryxdJdCMm
 NE3y8O61syKVWyg30sBVwba4azWVr8c=
X-Google-Smtp-Source: ABdhPJyOoP7QIRgQDeiOCVxejzayFmHmBooEvgBteojxSBzwy14TZglETq6R1R5iDRARIw6a91FRew==
X-Received: by 2002:a1c:7f89:: with SMTP id a131mr13833361wmd.31.1632379383809; 
 Wed, 22 Sep 2021 23:43:03 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id b16sm4389540wrp.82.2021.09.22.23.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Sep 2021 23:43:02 -0700 (PDT)
Subject: Re: [PATCH 00/66] Move to IP driven device enumeration
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <54e06b10-1921-5791-75a8-38a0041ef569@gmail.com>
 <CADnq5_PT8G9gUurtn5OZzi8JhAPUaWaRPf0Xmzb+8Nib5FQJtg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3eb3d8b9-7087-19dd-2762-c9afde6b1a6b@gmail.com>
Date: Thu, 23 Sep 2021 08:43:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_PT8G9gUurtn5OZzi8JhAPUaWaRPf0Xmzb+8Nib5FQJtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.09.21 um 22:25 schrieb Alex Deucher:
> On Wed, Sep 22, 2021 at 3:54 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> [SNIP]
>> Comment for patch #32:
>>
>> Maybe adjust the commit subject, otherwise somebody could think it's a
>> revert the the previous patch.
> I was thinking I could just apply 31 independently of what happens to
> this patch set.  I meant to split it out as a separate bug fix patch,
> but it got lost in the other patches.

Good point. I suggest to just push it to amd-staging-drm-next ASAP and 
not consider it part of this set any more.

>> Comment on patch #51, #52 and #61:
>>
>> That looks just a little bit questionable. Could we clean that up or
>> would that be to much churn for little gain?
> What did you have in mind?  As I mentioned in the reply to Lijo, the
> IP discovery table uses a mix of separate HWIDs and multiple instances
> of the same HWID to handle instancing.

Patch #52 adds something like: "adev->ip_versions[hw_ip + 
ip->number_instance] =..."

While patch #61 then cleans that up towards: 
"adev->ip_versions[hw_ip][ip->number_instance] =..."

It would be nice to have some clean concept which handles all of the 
hw_ip oddies gracefully in the first place. And then add what you wrote 
to Lijo as comment somewhere as well.

Not a must have, but I think it would make things a bit cleaner and more 
review- and maintain-able.

>> Comment on patch #63:
>>
>>>                case IP_VERSION(7, 2, 0):
>>> -                     amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
>>> +                     if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev)))
>>> +                             amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
>> Checking the IP version and then the chip type looks questionable. I
>> have an idea where this comes from, but please confirm with a comment.
> It's just because SR-IOV is only enabled on certain asics and that is
> the way the old code looked.  I guess I could drop the asic_type
> checks.  We'd never end up in with amdgpu_sriov_vf() returning true on
> a asic without SR-IOV support in the first place.

Yeah, either that our just add something like "SRIOV is only enabled on 
certain asics" as comment.

Christian.

>
> Alex
>

