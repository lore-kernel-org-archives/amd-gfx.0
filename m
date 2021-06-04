Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01423C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 11:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC3D613FF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 11:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC3D613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC716E0C6;
	Fri,  4 Jun 2021 11:14:17 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AEFE6E0C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 11:14:16 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id r11so10637932edt.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Jun 2021 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=mtLbr8eQvZcYmlXv0308uDT3c1EMabCnLOnxJ6ocGds=;
 b=EiR35mQ/qQnFB6UetQWzhqMM8MbXkiWEfUF8oUu/fFylxCaGIA6ELa5IQYhPd7AVYF
 vWwW2AuDPS/9s3/vgaCcPxjivvUID6cMZjZ2FmqgcOqKL5EHmUlq/fuTWYz96bL3887c
 n6VywZuuCJLgeHg0Dw2iKf6160LVI+20Je1kXEcEArxwbuyhs9UW4bzNoryobX90k5td
 iXmijYovYD1ZYp+oY9G4/Q1b9QFbyYjQp4EKvWnU4pBsnKb98/AiTxOmvKGBc09n2rL4
 kLwCxv7vr4/lXnYDqKk2eIKXB767Q4k26QjsHO4fwP26Q7mt5bBx28fq+mh+DwstxC5w
 Fl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mtLbr8eQvZcYmlXv0308uDT3c1EMabCnLOnxJ6ocGds=;
 b=j4EmhTthtUaCr78aC0HnlsHzGindGQAAxxRuahlZpDkmJ61kENw71LVV+MoHMMpj8U
 iJ6hwOGJGRijIGQND7LlSt2wTnKsTpQPTqCUgTpLML6ZL8oTeSGbmIAkml/C3i2RumKu
 vgl+Le0h0NGV7vdduzskKU7Vt9MD5wmQyyuoLT63ugN/bfZOAUoKbeyVzAi1biLKD9N1
 1GEdnjK/AO13ez/CUMbnxlFSWjfJUvSFXUP2gZAPfKcZej0vqoRuXF848GSwiTAfoQkL
 MpdQjweyzENOk7J8EY507tTqVRUadULzEEe7R0vSqfuNlh+x4cUIcaoC5MmV+zP+odyV
 tSVA==
X-Gm-Message-State: AOAM531VVfTgYbWWse+FHgWtWYtS72IQoS8xp86B80LgmzDVJCnETGC3
 sXZGSI8hwl51VIkrOc/QUFR4tjaEces=
X-Google-Smtp-Source: ABdhPJwAh9hXBR1Gf+UsLam9zQvu9F6kbg/9eTGPnblIvpP7xN8++6e+ODRW2AuiWwfntY5pbt12WQ==
X-Received: by 2002:aa7:da8c:: with SMTP id q12mr215912eds.368.1622805255069; 
 Fri, 04 Jun 2021 04:14:15 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7b4b:873a:17b5:b581?
 ([2a02:908:1252:fb60:7b4b:873a:17b5:b581])
 by smtp.gmail.com with ESMTPSA id b25sm3100553edv.9.2021.06.04.04.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 04:14:14 -0700 (PDT)
Subject: Re: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
To: "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, 
 "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <DM6PR12MB5534D815A3DBF82EBE78C576F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
 <PH0PR12MB54171568B27151FC487210928F3B9@PH0PR12MB5417.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <befc7f07-613a-d1bd-434a-516035552a79@gmail.com>
Date: Fri, 4 Jun 2021 13:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54171568B27151FC487210928F3B9@PH0PR12MB5417.namprd12.prod.outlook.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I was just about to question the same thing.

It looks really good to me to have that cleaned up, but if this breaks 
with older versions of the hypervisor then it is a bit questionable change.

Regards,
Christian.

Am 04.06.21 um 03:13 schrieb Deng, Emily:
> Do we need to consider backward compatibility?
>
>
> Best wishes
> Emily Deng
>
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu,
>> Shaoyun
>> Sent: Thursday, June 3, 2021 11:10 PM
>> To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
>> Subject: RE: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
>> location
>>
>> [AMD Official Use Only]
>>
>> Looks ok to me .
>>
>> Reviewed-By : Shaoyun.liu <shaoyunl@amd.com>
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang
>> Luo
>> Sent: Thursday, June 3, 2021 10:13 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
>> Subject: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
>> location
>>
>> host driver programmed fb location registers for vf, no need to check anymore.
>>
>> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 +----
>> 1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index ceb3968d8326..1c2d9fde9021 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1292,10 +1292,7 @@ static int gmc_v9_0_late_init(void *handle)  static
>> void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>> 					struct amdgpu_gmc *mc)
>> {
>> -	u64 base = 0;
>> -
>> -	if (!amdgpu_sriov_vf(adev))
>> -		base = adev->mmhub.funcs->get_fb_location(adev);
>> +	u64 base = adev->mmhub.funcs->get_fb_location(adev);
>>
>> 	/* add the xgmi offset of the physical node */
>> 	base += adev->gmc.xgmi.physical_node_id * adev-
>>> gmc.xgmi.node_segment_size;
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>> edesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7Cd41e78b1a3af4f08ff
>> d108d926a1a2d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>> 7583297946242271%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Nsz
>> ZyRZHCxj%2FIJ1hYoSrkv3LpTmF9FbchpNMtQ2GE5M%3D&amp;reserved=0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>> edesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7Cd41e78b1a3af4f08ff
>> d108d926a1a2d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>> 7583297946242271%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Nsz
>> ZyRZHCxj%2FIJ1hYoSrkv3LpTmF9FbchpNMtQ2GE5M%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
