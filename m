Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355F2C47423
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 20:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2BD2074B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 20:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="JmC1J8dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2BD2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67F36E06D;
	Thu,  1 Oct 2020 20:17:07 +0000 (UTC)
Received: from services.gouders.net (services.gouders.net [141.101.32.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8056E063
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 19:59:57 +0000 (UTC)
Received: from lena.gouders.net (ltea-047-066-024-155.pools.arcor-ip.net
 [47.66.24.155]) (authenticated bits=0)
 by services.gouders.net (8.14.8/8.14.8) with ESMTP id 091JtVtT012416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 1 Oct 2020 21:55:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
 t=1601582133; bh=+c1Qskew6XfuK4sFE9wvL98lkeAWXt2+Jq5q/gW488k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JmC1J8dwKII1dewZfDGkgW0nbtA2ZSDvkYbR953c4qSu11FVo6IX7DKUQL4nr74t2
 ZUjifx35Emh1kZsfadniVSE4sS8DI/Tq9sjmfqP96Cm8ks4DcShIoXVV2WakjURJDw
 y5AEp5mkLVZke4CFCX56lmWMaYWSsZgOhae/AxsE=
From: Dirk Gouders <dirk@gouders.net>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 0/1] drm/amdgpu: fix NULL pointer dereference for Renoir
Date: Thu,  1 Oct 2020 21:55:24 +0200
Message-Id: <20201001195525.3477-1-dirk@gouders.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
References: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 01 Oct 2020 20:17:07 +0000
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
Cc: Dirk Gouders <dirk@gouders.net>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Alex Deucher <alexdeucher@gmail.com> writes:

> On Wed, Sep 30, 2020 at 4:46 PM Dirk Gouders <dirk@gouders.net> wrote:
>>
>> Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
>> introduced a NULL pointer dereference when booting with
>> amdgpu.discovery=0.
>>
>> For amdgpu.discovery=0 that commit effectively removed the call of
>> vega10_reg_base_init(adev), so I tested the correctness of the bisect
>> session by restoring that function call for amdgpu_discovery == 0 and with
>> that change, the NULL pointer dereference does not occur:
>>
>
> Can I add your Signed-off-by?

I did not expect the diff to be seen as a proposed patch, not even that it
shows the correct fix.

Anyway, I did my best to create a hopefully acceptable patch with
some modification of the code that avoids "else" and an identical function call
at two places in the code.

I testet that patch with amdgpu.discovery={0,1} and together with the patch for the
first issue you helped me with.  The result is no more call traces.

Thank you for your patient assistance with the two issues.

Dirk


> Thanks,
>
> Alex
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 84d811b6e48b..2e93c5e1e7e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -699,7 +699,8 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
>>                                          "fallback to legacy init method\n");
>>                                 vega10_reg_base_init(adev);
>>                         }
>> -               }
>> +               } else
>> +                       vega10_reg_base_init(adev);
>>                 break;
>>         case CHIP_VEGA20:
>>                 vega20_reg_base_init(adev);
>>
>> Dirk
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Dirk Gouders (1):
  drm/amdgpu: fix NULL pointer dereference for Renoir

 drivers/gpu/drm/amd/amdgpu/soc15.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
