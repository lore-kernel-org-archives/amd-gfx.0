Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30534C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E142072B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBM5vjAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E142072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37D46ED9A;
	Thu, 16 Jan 2020 15:31:50 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9411E6ED9A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 15:31:49 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p17so4286967wma.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 07:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=V16nzMsl3tEUCFvwwGVK0VqRscol1pFpNuu0Leq/dpk=;
 b=mBM5vjARS9Hu+XxQpg6qQE//uHuq4mwodz1sEPM4qOMtfgPcUKbA2O/6aCvLNxx0yB
 sVQeRjloUCfxvTokhcgD30HBWMQ/vD5Z6baGZw5czfcKfu+T+ngDLvmh8qgOLCnyzEnN
 QjCih6tvfUvvJdVoQa4rGuamPtuc5StWbm9fOYRGR1B4Ea6cBqQlQueUt1OFF8EkvgGz
 EGQQqaFAI8hkoL2CoFDJxz/eqOR19llyw4estFNQWSna2X+7SHhagH7i8jNLvT/PSCxL
 0nYPMol4n1WSXsVsw504Nd/dJOxPuUf7j9Gbulwqow2bzEdJ5NUvkz5WsGmuVTEIn8BW
 9A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=V16nzMsl3tEUCFvwwGVK0VqRscol1pFpNuu0Leq/dpk=;
 b=bjhIQCS0UOrIuvmAQeIT0MfZrcuF0XZw0Phty54wX3mC8dkpRCzSriVMPnxuTk4b/2
 Yn18cwmIg3tGeZuIqvSDRubV3rb8EEIxie51ScD/6EAd7qx3eGWhwPgYTbLtPc8L1UhD
 JOpas4Vhl6jOC/SIoN/RNWOYl5OoaylE60sOtQfQWq/zp5HzpSpTc2Mvh1NWbMcL+B9W
 kMfuH6lMjsjXbCtsQA9L4INawoQk0XZOVjUXLut0JL9IIXo48XxcfDGIcnsFLN+W9G+1
 GXJifPGmyXj8bvYdotzlN3sE2LUulJ898Pua8VbX3nf2uGLl6l5e5XeC+ehArluj1GYw
 vj3g==
X-Gm-Message-State: APjAAAVlqhObEKXqbssKQLfHB699Fyx0cI3g30UfmiBDfYOZPWhs/Mtn
 UtsEX/Z0+l79GU5NTcF0k2fRBua3
X-Google-Smtp-Source: APXvYqwgA7YaK7g3XHoY+hODm4pczTbbtAa5BbKbTPgUf7rKn7ZjKt6sHfYiFDFMLE6GqpLL+wS3Mg==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr6945534wmf.56.1579188707984; 
 Thu, 16 Jan 2020 07:31:47 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id w19sm506287wmc.22.2020.01.16.07.31.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Jan 2020 07:31:47 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1 boards
To: Alex Deucher <alexdeucher@gmail.com>, "Li, Dennis" <Dennis.Li@amd.com>
References: <20200115173139.1392429-1-alexander.deucher@amd.com>
 <MN2PR12MB31672D3E94DEB4EBB91359CFED360@MN2PR12MB3167.namprd12.prod.outlook.com>
 <CADnq5_Oes7UDa9oUnGY_vejccrO6yz+n_a5C1Uk-xsEb4U_ZuA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b7c779e5-6af2-858c-a1ef-6931328d1be8@gmail.com>
Date: Thu, 16 Jan 2020 16:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Oes7UDa9oUnGY_vejccrO6yz+n_a5C1Uk-xsEb4U_ZuA@mail.gmail.com>
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
Reply-To: christian.koenig@amd.com
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.01.20 um 16:26 schrieb Alex Deucher:
> On Wed, Jan 15, 2020 at 8:51 PM Li, Dennis <Dennis.Li@amd.com> wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Hi, Alex,
>>        it is better to refine the patch as a common function, not only used for raven.
> I originally had the name as gfx_v9_0_check_disable_gfxoff(), but I
> changed it to be raven specific because if we call this independent of
> the other conditions in the CHIP_RAVEN case, we may end up disabling
> gfxoff in cases where we don't want to (e.g., if a raven1 refresh uses
> the same DID/SSID/RIDs as a non-kicker for example, and one works and
> the other doesn't).  I guess we can revisit if we have to add cases
> for other asics.  If you feel strongly I can change the name.

Maybe we should have a general feature to match an array of DID/SSID/RIDs?

Maybe having that in amdgpu_device.c or even the PCI subsystem would 
make a lot of sense for this.

Christian.

>
> Alex
>
>> Best Regards
>> Dennis Li
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
>> Sent: Thursday, January 16, 2020 1:32 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1 boards
>>
>> Switch to a blacklist so we can disable specific boards that are problematic.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 42 ++++++++++++++++++++++++---
>>   1 file changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index e3d466bd5c4e..b48b07bcd0fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -1031,6 +1031,37 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
>>          }
>>   }
>>
>> +struct amdgpu_gfxoff_quirk {
>> +       u16 chip_vendor;
>> +       u16 chip_device;
>> +       u16 subsys_vendor;
>> +       u16 subsys_device;
>> +       u8 revision;
>> +};
>> +
>> +static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
>> +       /* https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D204689&amp;data=02%7C01%7CDennis.Li%40amd.com%7C33990b7157714a2f943a08d799e0cda3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147063123345220&amp;sdata=2mT3Eug%2FEDKGGbI1bqymp2tnMqLX4x%2B2BAWnLUnq5m0%3D&amp;reserved=0 */
>> +       { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
>> +       { 0, 0, 0, 0, 0 },
>> +};
>> +
>> +static bool gfx_v9_0_raven_check_disable_gfxoff(struct pci_dev *pdev) {
>> +       const struct amdgpu_gfxoff_quirk *p = amdgpu_gfxoff_quirk_list;
>> +
>> +       while (p && p->chip_device != 0) {
>> +               if (pdev->vendor == p->chip_vendor &&
>> +                   pdev->device == p->chip_device &&
>> +                   pdev->subsystem_vendor == p->subsys_vendor &&
>> +                   pdev->subsystem_device == p->subsys_device &&
>> +                   pdev->revision == p->revision) {
>> +                       return true;
>> +               }
>> +               ++p;
>> +       }
>> +       return false;
>> +}
>> +
>>   static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)  {
>>          switch (adev->asic_type) {
>> @@ -1039,10 +1070,13 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>>          case CHIP_VEGA20:
>>                  break;
>>          case CHIP_RAVEN:
>> -               if (!(adev->rev_id >= 0x8 ||
>> -                     adev->pdev->device == 0x15d8) &&
>> -                   (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
>> -                    !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
>> +               if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
>> +                   ((adev->gfx.rlc_fw_version != 106 &&
>> +                     adev->gfx.rlc_fw_version < 531) ||
>> +                    (adev->gfx.rlc_fw_version == 53815) ||
>> +                    (adev->gfx.rlc_feature_version < 1) ||
>> +                    !adev->gfx.rlc.is_rlc_v2_1) &&
>> +                   !gfx_v9_0_raven_check_disable_gfxoff(adev->pdev))
>>                          adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>>
>>                  if (adev->pm.pp_feature & PP_GFXOFF_MASK)
>> --
>> 2.24.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7C33990b7157714a2f943a08d799e0cda3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147063123345220&amp;sdata=ON7UTCOhoCaW%2Bwp0KiMCjOQHt6QohngaFxx9hgfKS7o%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
