Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27C8C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D0610E3C0;
	Fri, 11 Apr 2025 08:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="B0uNcOGH";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="ANPJ7TcJ";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E15110E3C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1744359717;
 bh=Z5J+t2FGPucngfj9gCnWUdp
 2R/qsOVxPgoDRouWvBxg=; b=B0uNcOGH5rqKarZf40K9Q96OZ2ZxLasCQBjThrNFvttPb1O9Iy
 B8rkK92vtR1u819jbL20Ify3Th02W/ONooJwz8SHZhCrTG4tZzp05E2hOd1flW3SREYaL/DWdIr
 g2Ig3Q9b5HE3FzuPxyWYwLP0muh3Hq2hQJHbNNODAQPHAYniA/ZeD+Y+5wx5Sww5jpQsZL39JU9
 gaLh7+r5rpDDCOV+0Gp9u9A9laFovtVAqrgExCvS3hF1+oUgrSAmYi/jSk/UnsnWYLKrnI/0rtd
 4If54H2VPs/K/a4ecr8sxxCESUc7IApqNO/alDSJP53CI4D024n6ZB4bUGnDE+oIUVA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1744359717; bh=Z5J+t2FGPucngfj9gCnWUdp
 2R/qsOVxPgoDRouWvBxg=; b=ANPJ7TcJ97OkT5Ci8C4eOWEk2+5on7JuCkmVAra054gOaxX5cH
 PnHUbqTwbmVbogURthMzdTgbsWyxdb8CsWBg==;
Message-ID: <76aee474-2b68-48e4-9445-5a46e72d08a5@damsy.net>
Date: Fri, 11 Apr 2025 10:21:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v2] drm/amdgpu: Add fw minimum version check for
 usermode queue
To: "Yadav, Arvind" <arvyadav@amd.com>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian.Koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com,
 shashank.sharma@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250410145750.51421-1-Arvind.Yadav@amd.com>
 <204b9b11-9045-d180-927e-ba1cb015b368@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <204b9b11-9045-d180-927e-ba1cb015b368@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

Le 11/04/2025 à 06:54, Yadav, Arvind a écrit :
> Alex,
> This is v2 of 2/2 patch. Please review this.
> 
> ~arvind
> 
> On 4/10/2025 8:27 PM, Arvind Yadav wrote:
>> This patch is load usermode queue based on FW support for gfx12.
>> CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC = 3050, MES = 123]
>>
>> v2: Addressed review comments from Alex
>>     - Just check the firmware versions directly.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 3d87e445270e..3165fdfeca6a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -1418,7 +1418,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>       case IP_VERSION(12, 0, 1):
>>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>           /* add firmware version checks here */

This comment could be removed now that you implemented the version checks (the same remark applies 
to patch 1/2).

Regards,
Pierre-eric

>> -        if (0) {
>> +        if (adev->gfx.me_fw_version  >= 2780 &&
>> +            adev->gfx.pfp_fw_version >= 2840 &&
>> +            adev->gfx.mec_fw_version >= 3050 &&
>> +            adev->mes.fw_version[0] >= 123) {
>>               adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>>               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>>           }
