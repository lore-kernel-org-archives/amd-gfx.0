Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C68C71159
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 17:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A6810E102;
	Mon, 16 Jun 2025 17:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YLSgzyCM";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D24810E102
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 17:05:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C653F5C5B3C;
 Mon, 16 Jun 2025 17:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF39AC4CEEA;
 Mon, 16 Jun 2025 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750093532;
 bh=8poxrPn6RtSfmT8J4YXFs4lsTaXXXGvfDK0dw5BmMAQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YLSgzyCMvjauZ5iNxqgTfoXuEGRIauYHEvas+SbpGc0MXZx81mWcuELXhAKvcF0Q5
 JGSn96VYBEis004hvS3NA71pW/ukSkKcsJjIyDjqte+gL1tS2Hb4wLSwaT/Hr87nPS
 q+CtM3vA2UL9+RynNe7xCI8+FGDSpt9gJnwBdL7draLwl7kOJSgTuotzvBcperyP+a
 fPvqWd1/bTBsor35K6MUHFQhApYRTU0g/mBD8QubNCrUmGFUGM4sEPiy2myCjWF0o2
 w/LxujiS1wosRyKjqKeFgSXW2ZW6upuuMyIr/wJcFJSMEYYawkJYYkIVxFYmTml3dF
 dVs3pz0CW6Uiw==
Message-ID: <4749ad1c-8af9-4230-b925-c5074e28f898@kernel.org>
Date: Mon, 16 Jun 2025 12:05:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Adjust output for discovery error handling
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20250613214101.4117000-1-superm1@kernel.org>
 <f1525ee7-9f1d-48ae-81af-f97fb3a00351@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <f1525ee7-9f1d-48ae-81af-f97fb3a00351@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/13/25 10:27 PM, Lazar, Lijo wrote:
> 
> 
> On 6/14/2025 3:11 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> commit 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
>> available") added support for reading an amdgpu IP discovery bin file
>> for some specific products. If it's not found then it will fallback to
>> hardcoded values. However if it's not found there is also a lot of noise
>> about missing files and errors.
>>
>> Adjust the error handling to decrease most messages to DEBUG and to show
>> at most one message to a user about the missing file at INFO level.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4312
>> Fixes: 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file available")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
>>   1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index a0e9bf9b27108..8e4526a8c2600 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -321,10 +321,9 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
>>   	const struct firmware *fw;
>>   	int r;
>>   
>> -	r = request_firmware(&fw, fw_name, adev->dev);
>> +	r = firmware_request_nowarn(&fw, fw_name, adev->dev);
>>   	if (r) {
>> -		dev_err(adev->dev, "can't load firmware \"%s\"\n",
>> -			fw_name);
>> +		drm_info(&adev->ddev, "Optional firmware \"%s\" was not found\n", fw_name);
>>   		return r;
>>   	}
>>   
>> @@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>>   	/* Read from file if it is the preferred option */
>>   	fw_name = amdgpu_discovery_get_fw_name(adev);
>>   	if (fw_name != NULL) {
>> -		dev_info(adev->dev, "use ip discovery information from file");
>> +		drm_dbg(&adev->ddev, "use ip discovery information from file");
>>   		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
>> -
>> -		if (r) {
>> -			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
>> -			r = -EINVAL;
>> +		if (r)
>>   			goto out;
>> -		}
>> -
>>   	} else {
>> +		drm_dbg(&adev->ddev, "use ip discovery information from memory");
>>   		r = amdgpu_discovery_read_binary_from_mem(
>>   			adev, adev->mman.discovery_bin);
>>   		if (r)
>> @@ -1339,7 +1334,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>   
>>   	r = amdgpu_discovery_init(adev);
>>   	if (r) {
>> -		DRM_ERROR("amdgpu_discovery_init failed\n");
>> +		drm_warn(&adev->ddev, "%s failed: %d\n", __func__, r);
> 
> This indeed is an error. Rest of the changes are fine.

How about pushing this down into amdgpu_discovery_set_ip_blocks()?
I was thinking we can put it in the default case only so that the 
fallback path doesn't make a lot of noise for vega/raven/arcturus/aldebaran.

Something like this:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3877b43d9f863..d5bd105de1b31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1333,10 +1333,8 @@ static int amdgpu_discovery_reg_base_init(struct 
amdgpu_device *adev)
         int r;

         r = amdgpu_discovery_init(adev);
-       if (r) {
-               DRM_ERROR("amdgpu_discovery_init failed\n");
+       if (r)
                 return r;
-       }

         wafl_ver = 0;
         adev->gfx.xcc_mask = 0;
@@ -2574,8 +2572,10 @@ int amdgpu_discovery_set_ip_blocks(struct 
amdgpu_device *adev)
                 break;
         default:
                 r = amdgpu_discovery_reg_base_init(adev);
-               if (r)
-                       return -EINVAL;
+               if (r) {
+                       drm_err(&adev->ddev, "discovery failed: %d\n", ret);
+                       return r;
+               }

                 amdgpu_discovery_harvest_ip(adev);
                 amdgpu_discovery_get_gfx_info(adev);



> 
> Thanks,
> Lijo
> 
>>   		return r;
>>   	}
>>   
> 

