Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394B9C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CDA2388B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CDA2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C261A6E47B;
	Fri, 15 Jan 2021 15:08:47 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F60189F08;
 Fri, 15 Jan 2021 09:37:55 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1l0LYH-0007Sv-Je; Fri, 15 Jan 2021 09:37:53 +0000
Subject: Re: [PATCH][next] drm/amdgpu: Add missing BOOTUP_DEFAULT to
 profile_name[]
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20210111114638.16530-1-colin.king@canonical.com>
 <20210112100706.GF5083@kadam>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <51efd2a7-f2cf-dc28-4b86-5e89d13564ca@canonical.com>
Date: Fri, 15 Jan 2021 09:37:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112100706.GF5083@kadam>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 15 Jan 2021 15:08:45 +0000
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/01/2021 10:07, Dan Carpenter wrote:
> On Mon, Jan 11, 2021 at 11:46:38AM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> A recent change added a new BOOTUP_DEFAULT power profile mode
>> to the PP_SMC_POWER_PROFILE enum but omitted updating the
>> corresponding profile_name array.  Fix this by adding in the
>> missing BOOTUP_DEFAULT to profile_name[].
>>
> 
> Still not enough to prevent the array overflow.  It needs POWERSAVE as
> well.

Thanks for checking, but there is a 1-to-1 relation ship now:

enum PP_SMC_POWER_PROFILE {
        PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT = 0x0,
        PP_SMC_POWER_PROFILE_FULLSCREEN3D = 0x1,
        PP_SMC_POWER_PROFILE_POWERSAVING  = 0x2,
        PP_SMC_POWER_PROFILE_VIDEO        = 0x3,
        PP_SMC_POWER_PROFILE_VR           = 0x4,
        PP_SMC_POWER_PROFILE_COMPUTE      = 0x5,
        PP_SMC_POWER_PROFILE_CUSTOM       = 0x6,
        PP_SMC_POWER_PROFILE_COUNT,
};

vs

        static const char *profile_name[] = {
                                        "BOOTUP_DEFAULT",
                                        "3D_FULL_SCREEN",
                                        "POWER_SAVING",
                                        "VIDEO",
                                        "VR",
                                        "COMPUTE",
                                        "CUSTOM"};


unless I'm missing something because I've not had enough coffee.

Colin

> 
> regards,
> dan carpenter
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
