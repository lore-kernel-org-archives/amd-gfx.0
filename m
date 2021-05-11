Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA5AC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 14:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE60E61155
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 14:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE60E61155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958456EA44;
	Tue, 11 May 2021 14:07:47 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9FC6EA44
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 14:07:47 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id c22so23020114edn.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=zUJ6yE6ygdDPHSMfeuNBl/3AQieYn03TkTI2omxlHHM=;
 b=r9mH7MWNMRrMQqHpZksKaEwHLuKpTSHXvx6Hpb8QoP/GXQS24moqFzXHQ6+rkuUs2F
 9SS4RmL7hdhVcq6X9sGZ/MQ0oGsmw4pwvsiZ8CbxETdhJJEtyli7ru1GY8+0H+60Er0p
 tdM/E0RkNcTgd+GLwVd6kbx+A8v2szJHSwYkC4lSrSUnYdRqekgD+PfT6sxFMS8BcPDY
 VoGLEO1Nlv3IlVmrQ85+mRe0nuJ4Tbquy+C16muSZvRcroCQK2opQ55vV3TsjVdmPmSr
 8+zqbfur6jfr6h9h5pHKBoxO18XE9LuuVLJrLTTcr5glB/FZlccXB8ZXIJC5fKxprzA9
 puvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=zUJ6yE6ygdDPHSMfeuNBl/3AQieYn03TkTI2omxlHHM=;
 b=YjaEGygT2djOUj47fZTHrwSCeKMBXBASmR4UJXhHDAcIJVUl6LlUZdrl98vBYljfX8
 ZCB/x97V9Yg+usAXNvP/2ZwphxQTZfj+djw+XH0lFCXNH+Ry7uNJn7EkKYw7oDDyDMce
 VftSvHsLxCROEzGGdgF04Aj3vvSBDyK1PRHU4xGTfHMmJ+WhBFri+doZofF7hVv9wf84
 CgEnxH1DKHtBuhVh/GD50+dos3+kHHzRvjwF7LBWIxFVEiGrLzFhSfCD2BCHV+bZdD2s
 MUqJU4xwQ5mwrTtFUzAsNajdYNEhisBfWesbMcPtPUaDAu68H/uFkHDl6ivmjQHu8v+n
 86UQ==
X-Gm-Message-State: AOAM533wDQVlVTAJN8DQrIgddBnbz3T834ECsqVCfHOjQ8JIZcf6Awg4
 zqyRW7MoWsnG5CS/rMHnHEg=
X-Google-Smtp-Source: ABdhPJwW4UgJqbJbzx7CbiBN2FDPxIM9aSMfVrrhjXHdzVthCCAp+hHH3s60yx81ZjmTZGrvIK7tKg==
X-Received: by 2002:a05:6402:51c9:: with SMTP id
 r9mr32555480edd.94.1620742065694; 
 Tue, 11 May 2021 07:07:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:5935:8b67:3cdd:7cc1?
 ([2a02:908:1252:fb60:5935:8b67:3cdd:7cc1])
 by smtp.gmail.com with ESMTPSA id k26sm11757220eje.67.2021.05.11.07.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 07:07:45 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
 <88e868eb-347b-611b-8d88-ba8d9d61c23b@gmail.com>
 <CAAxE2A73V5PLVgrcd+_KYYbK=n+POZajdVYMcMdj8A38KvTerA@mail.gmail.com>
 <MN2PR12MB4488E0D428871797E08DEE2BF7539@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <454dbf38-3337-de8b-6a29-30f417475121@gmail.com>
Date: Tue, 11 May 2021 16:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB4488E0D428871797E08DEE2BF7539@MN2PR12MB4488.namprd12.prod.outlook.com>
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
Cc: Kees Cook <keescook@chromium.org>, "Gu,
 JiaWei \(Will\)" <JiaWei.Gu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Nieto,
 David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============1580216111=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1580216111==
Content-Type: multipart/alternative;
 boundary="------------4C193A0472876E4D7FD1A496"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4C193A0472876E4D7FD1A496
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, but umr is making strong use of sysfs as well.

The only justification of this interface would be if we want to use it 
in Mesa.

And I agree with Marek that looks redundant with the device structure to 
me as well.

Christian.

Am 11.05.21 um 16:04 schrieb Deucher, Alexander:
>
> [AMD Public Use]
>
>
> It's being used by umr and some other smi tools to provide vbios 
> information for debugging.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Marek Olšák <maraeo@gmail.com>
> *Sent:* Tuesday, May 11, 2021 4:18 AM
> *To:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Cc:* Kees Cook <keescook@chromium.org>; Gu, JiaWei (Will) 
> <JiaWei.Gu@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; 
> Deng, Emily <Emily.Deng@amd.com>; Alex Deucher 
> <alexdeucher@gmail.com>; Nieto, David M <David.Nieto@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Align serial size in 
> drm_amdgpu_info_vbios
> Mesa doesn't use sysfs.
>
> Note that this is a uapi, meaning that once it's in the kernel, it 
> can't be changed like that.
>
> What's the use case for this new interface? Isn't it partially 
> redundant with the current device info structure, which seems to have 
> the equivalent of dev_id and rev_id?
>
> Marek
>
> On Tue, May 11, 2021 at 3:51 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Marek and other userspace folks need to decide that.
>
>     Basic question here is if Mesa is already accessing sysfs nodes
>     for OpenGL or RADV. If that is the case then we should probably
>     expose the information there as well.
>
>     If that isn't the case (which I think it is) then we should
>     implement it as IOCTL.
>
>     Regards,
>     Christian.
>
>     Am 10.05.21 um 22:19 schrieb Nieto, David M:
>>
>>     One of the primary usecases is to add this information to the
>>     renderer string, I am not sure if there are other cases of UMD
>>     drivers accessing sysfs nodes, but I think if we think
>>     permissions, if a client is authenticated and opens the render
>>     device then it can use the IOCTL, it is unclear to me we can make
>>     a such an assumption for sysfs nodes…
>>
>>     I think there is value in having both tbh.
>>
>>     Regards,
>>
>>     David
>>
>>     *From: *Christian König <ckoenig.leichtzumerken@gmail.com>
>>     <mailto:ckoenig.leichtzumerken@gmail.com>
>>     *Date: *Monday, May 10, 2021 at 6:48 AM
>>     *To: *"Nieto, David M" <David.Nieto@amd.com>
>>     <mailto:David.Nieto@amd.com>, "Gu, JiaWei (Will)"
>>     <JiaWei.Gu@amd.com> <mailto:JiaWei.Gu@amd.com>
>>     *Cc: *Alex Deucher <alexdeucher@gmail.com>
>>     <mailto:alexdeucher@gmail.com>, "Deng, Emily"
>>     <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>, Kees Cook
>>     <keescook@chromium.org> <mailto:keescook@chromium.org>, amd-gfx
>>     list <amd-gfx@lists.freedesktop.org>
>>     <mailto:amd-gfx@lists.freedesktop.org>
>>     *Subject: *Re: [PATCH] drm/amdgpu: Align serial size in
>>     drm_amdgpu_info_vbios
>>
>>     Well we could add both as sysfs file(s).
>>
>>     Question here is rather what is the primary use case of this and
>>     if the application has the necessary access permissions to the
>>     sysfs files?
>>
>>     Regards,
>>     Christian.
>>
>>     Am 10.05.21 um 15:42 schrieb Nieto, David M:
>>
>>         Then the application would need to issue the ioctl and then
>>         open a sysfs file to get all the information it needs. It
>>         makes little sense from a programming perspective to add an
>>         incomplete interface in my opinion
>>
>>         ------------------------------------------------------------------------
>>
>>         *From:*Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>>         <mailto:JiaWei.Gu@amd.com>
>>         *Sent:* Monday, May 10, 2021 12:13:07 AM
>>         *To:* Nieto, David M <David.Nieto@amd.com>
>>         <mailto:David.Nieto@amd.com>
>>         *Cc:* Alex Deucher <alexdeucher@gmail.com>
>>         <mailto:alexdeucher@gmail.com>; amd-gfx list
>>         <amd-gfx@lists.freedesktop.org>
>>         <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>>         <keescook@chromium.org> <mailto:keescook@chromium.org>; Deng,
>>         Emily <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>>         *Subject:* RE: [PATCH] drm/amdgpu: Align serial size in
>>         drm_amdgpu_info_vbios
>>
>>         [AMD Official Use Only - Internal Distribution Only]
>>
>>         Hi David,
>>
>>         What I meant is to ONLY delete the serial[16] from
>>         drm_amdgpu_info_vbios, not the whole struct.
>>
>>         struct drm_amdgpu_info_vbios {
>>                 __u8 name[64];
>>                 __u32 dbdf;
>>                 __u8 vbios_pn[64];
>>                 __u32 version;
>>                 __u8 date[32];
>>                 __u8 serial[16]; // jiawei: shall we delete this
>>                 __u32 dev_id;
>>                 __u32 rev_id;
>>                 __u32 sub_dev_id;
>>                 __u32 sub_ved_id;
>>         };
>>
>>         serial[16] in drm_amdgpu_info_vbios  copied from
>>         adev->serial, but there's already a sysfs named
>>         serial_number, which exposes it already.
>>
>>         static ssize_t amdgpu_device_get_serial_number(struct device
>>         *dev,
>>                         struct device_attribute *attr, char *buf)
>>         {
>>                 struct drm_device *ddev = dev_get_drvdata(dev);
>>                 struct amdgpu_device *adev = ddev->dev_private;
>>
>>                 return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
>>         }
>>
>>         Thanks,
>>         Jiawei
>>
>>
>>         -----Original Message-----
>>         From: Nieto, David M <David.Nieto@amd.com>
>>         <mailto:David.Nieto@amd.com>
>>         Sent: Monday, May 10, 2021 2:53 PM
>>         To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>>         <mailto:JiaWei.Gu@amd.com>
>>         Cc: Alex Deucher <alexdeucher@gmail.com>
>>         <mailto:alexdeucher@gmail.com>; amd-gfx list
>>         <amd-gfx@lists.freedesktop.org>
>>         <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>>         <keescook@chromium.org> <mailto:keescook@chromium.org>; Deng,
>>         Emily <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>>         Subject: Re: [PATCH] drm/amdgpu: Align serial size in
>>         drm_amdgpu_info_vbios
>>
>>         No, this structure contains all the details of the vbios:
>>         date, serial number, name, etc.
>>
>>         The sysfs node only contains the vbios name string
>>
>>         > On May 9, 2021, at 23:33, Gu, JiaWei (Will)
>>         <JiaWei.Gu@amd.com> <mailto:JiaWei.Gu@amd.com> wrote:
>>         >
>>         > [AMD Official Use Only - Internal Distribution Only]
>>         >
>>         > With a second thought,
>>         > __u8 serial[16] in drm_amdgpu_info_vbios is a bit
>>         redundant, sysfs serial_number already exposes it.
>>         >
>>         > Is it fine to abandon it from drm_amdgpu_info_vbios struct?
>>         @Alex
>>         > Deucher @Nieto, David M
>>         >
>>         > Best regards,
>>         > Jiawei
>>         >
>>         > -----Original Message-----
>>         > From: Alex Deucher <alexdeucher@gmail.com>
>>         <mailto:alexdeucher@gmail.com>
>>         > Sent: Sunday, May 9, 2021 11:59 PM
>>         > To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>>         <mailto:JiaWei.Gu@amd.com>
>>         > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>>         <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>>         > <keescook@chromium.org> <mailto:keescook@chromium.org>
>>         > Subject: Re: [PATCH] drm/amdgpu: Align serial size in
>>         > drm_amdgpu_info_vbios
>>         >
>>         >> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu
>>         <Jiawei.Gu@amd.com> <mailto:Jiawei.Gu@amd.com> wrote:
>>         >>
>>         >> 20 should be serial char size now instead of 16.
>>         >>
>>         >> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
>>         <mailto:Jiawei.Gu@amd.com>
>>         >
>>         > Please make sure this keeps proper 64 bit alignment in the
>>         structure.
>>         >
>>         > Alex
>>         >
>>         >
>>         >> ---
>>         >> include/uapi/drm/amdgpu_drm.h | 2 +-
>>         >> 1 file changed, 1 insertion(+), 1 deletion(-)
>>         >>
>>         >> diff --git a/include/uapi/drm/amdgpu_drm.h
>>         >> b/include/uapi/drm/amdgpu_drm.h index
>>         2b487a8d2727..1c20721f90da
>>         >> 100644
>>         >> --- a/include/uapi/drm/amdgpu_drm.h
>>         >> +++ b/include/uapi/drm/amdgpu_drm.h
>>         >> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
>>         >>        __u8 vbios_pn[64];
>>         >>        __u32 version;
>>         >>        __u8 date[32];
>>         >> -       __u8 serial[16];
>>         >> +       __u8 serial[20];
>>         >>        __u32 dev_id;
>>         >>        __u32 rev_id;
>>         >>        __u32 sub_dev_id;
>>         >> --
>>         >> 2.17.1
>>         >>
>>         >> _______________________________________________
>>         >> amd-gfx mailing list
>>         >> amd-gfx@lists.freedesktop.org
>>         <mailto:amd-gfx@lists.freedesktop.org>
>>         >>
>>         https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>>         <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis>
>>         >> t
>>         >> s.freedesktop.org
>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fs.freedesktop.org%2F&data=04%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729003008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=5c730zpnFFOm3EgabDFoiYlsl2tsaxImaTlVfap%2BfHQ%3D&reserved=0>%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJ
>>         >> i
>>         >> awei.Gu%40amd.com
>>         <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2F40amd.com%2F&data=04%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729003008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=FzFHfe095%2FDzOYR%2BZ3tAzlF2wDRYsD5kOt%2Bf37nNVP4%3D&reserved=0>%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e
>>         >> 6
>>         >>
>>         08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
>>         >> d
>>         >>
>>         8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>>         >> C
>>         >>
>>         1000&amp;sdata=kAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;res
>>         >> e
>>         >> rved=0
>>
>>
>>
>>         _______________________________________________
>>
>>         amd-gfx mailing list
>>
>>         amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>
>>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729012969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=GA4tfIXNrbU98WUMQl%2Bkd28DyNgqjlZcIAryQtVIn%2Bw%3D&reserved=0>
>>
>>
>>
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729012969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=GA4tfIXNrbU98WUMQl%2Bkd28DyNgqjlZcIAryQtVIn%2Bw%3D&reserved=0>
>


--------------4C193A0472876E4D7FD1A496
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Yeah, but umr is making strong use of sysfs as well.<br>
    <br>
    The only justification of this interface would be if we want to use
    it in Mesa.<br>
    <br>
    And I agree with Marek that looks redundant with the device
    structure to me as well.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 11.05.21 um 16:04 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB4488E0D428871797E08DEE2BF7539@MN2PR12MB4488.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;"
        align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          It's being used by umr and some other smi tools to provide
          vbios information for debugging.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Marek Olšák <a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a><br>
            <b>Sent:</b> Tuesday, May 11, 2021 4:18 AM<br>
            <b>To:</b> Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Cc:</b> Kees Cook <a class="moz-txt-link-rfc2396E" href="mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a>; Gu,
            JiaWei (Will) <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a>; amd-gfx list
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deng, Emily
            <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>; Alex Deucher
            <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>; Nieto, David M
            <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in
            drm_amdgpu_info_vbios</font>
          <div> </div>
        </div>
        <div>
          <div dir="ltr">
            <div>Mesa doesn't use sysfs.</div>
            <div><br>
            </div>
            <div>Note that this is a uapi, meaning that once it's in the
              kernel, it can't be changed like that.<br>
            </div>
            <div><br>
            </div>
            <div>What's the use case for this new interface? Isn't it
              partially redundant with the current device info
              structure, which seems to have the equivalent of dev_id
              and rev_id?<br>
            </div>
            <div><br>
            </div>
            <div>Marek<br>
            </div>
          </div>
          <br>
          <div class="x_gmail_quote">
            <div dir="ltr" class="x_gmail_attr">On Tue, May 11, 2021 at
              3:51 AM Christian König &lt;<a
                href="mailto:ckoenig.leichtzumerken@gmail.com"
                target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="x_gmail_quote" style="margin:0px 0px 0px
              0.8ex; border-left:1px solid rgb(204,204,204);
              padding-left:1ex">
              <div>Marek and other userspace folks need to decide that.<br>
                <br>
                Basic question here is if Mesa is already accessing
                sysfs nodes for OpenGL or RADV. If that is the case then
                we should probably expose the information there as well.<br>
                <br>
                If that isn't the case (which I think it is) then we
                should implement it as IOCTL.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                <div>Am 10.05.21 um 22:19 schrieb Nieto, David M:<br>
                </div>
                <blockquote type="cite">
                  <div>
                    <p class="x_MsoNormal">One of the primary usecases
                      is to add this information to the renderer string,
                      I am not sure if there are other cases of UMD
                      drivers accessing sysfs nodes, but I think if we
                      think permissions, if a client is authenticated
                      and opens the render device then it can use the
                      IOCTL, it is unclear to me we can make a such an
                      assumption for sysfs nodes…</p>
                    <p class="x_MsoNormal"> </p>
                    <p class="x_MsoNormal">I think there is value in
                      having both tbh.</p>
                    <p class="x_MsoNormal"> </p>
                    <p class="x_MsoNormal">Regards,</p>
                    <p class="x_MsoNormal">David</p>
                    <p class="x_MsoNormal"> </p>
                    <div style="border-color:rgb(181,196,223)
                      currentcolor currentcolor; border-style:solid none
                      none; border-width:1pt medium medium; padding:3pt
                      0in 0in">
                      <p class="x_MsoNormal"><b><span
                            style="font-size:12pt; color:black">From: </span>
                        </b><span style="font-size:12pt; color:black">Christian
                          König <a
                            href="mailto:ckoenig.leichtzumerken@gmail.com"
                            target="_blank" moz-do-not-send="true">
                            &lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                          <b>Date: </b>Monday, May 10, 2021 at 6:48 AM<br>
                          <b>To: </b>"Nieto, David M" <a
                            href="mailto:David.Nieto@amd.com"
                            target="_blank" moz-do-not-send="true">
                            &lt;David.Nieto@amd.com&gt;</a>, "Gu, JiaWei
                          (Will)" <a href="mailto:JiaWei.Gu@amd.com"
                            target="_blank" moz-do-not-send="true">
                            &lt;JiaWei.Gu@amd.com&gt;</a><br>
                          <b>Cc: </b>Alex Deucher <a
                            href="mailto:alexdeucher@gmail.com"
                            target="_blank" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a>,
                          "Deng, Emily"
                          <a href="mailto:Emily.Deng@amd.com"
                            target="_blank" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>,
                          Kees Cook
                          <a href="mailto:keescook@chromium.org"
                            target="_blank" moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a>,
                          amd-gfx list
                          <a href="mailto:amd-gfx@lists.freedesktop.org"
                            target="_blank" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                          <b>Subject: </b>Re: [PATCH] drm/amdgpu: Align
                          serial size in drm_amdgpu_info_vbios</span></p>
                    </div>
                    <div>
                      <p class="x_MsoNormal"> </p>
                    </div>
                    <p class="x_MsoNormal" style="margin-bottom:12pt">Well
                      we could add both as sysfs file(s).<br>
                      <br>
                      Question here is rather what is the primary use
                      case of this and if the application has the
                      necessary access permissions to the sysfs files?<br>
                      <br>
                      Regards,<br>
                      Christian.</p>
                    <div>
                      <p class="x_MsoNormal">Am 10.05.21 um 15:42
                        schrieb Nieto, David M:</p>
                    </div>
                    <blockquote style="margin-top:5pt;
                      margin-bottom:5pt">
                      <div>
                        <div>
                          <div>
                            <p class="x_MsoNormal"
                              style="background:white none repeat scroll
                              0% 0%"><span style="color:black">Then the
                                application would need to issue the
                                ioctl and then open a sysfs file to get
                                all the information it needs. It makes
                                little sense from a programming
                                perspective to add an incomplete
                                interface in my opinion </span></p>
                          </div>
                        </div>
                        <div>
                          <p class="x_MsoNormal"> </p>
                        </div>
                      </div>
                      <div class="x_MsoNormal" style="text-align:center"
                        align="center">
                        <hr width="100%" size="0" align="center">
                      </div>
                      <div
id="x_gmail-m_782079725653541167gmail-m_3184748164637597930gmail-m_-3452308432024396062divRplyFwdMsg">
                        <p class="x_MsoNormal"><b><span
                              style="color:black">From:</span></b><span
                            style="color:black"> Gu, JiaWei (Will)
                            <a href="mailto:JiaWei.Gu@amd.com"
                              target="_blank" moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                            <b>Sent:</b> Monday, May 10, 2021 12:13:07
                            AM<br>
                            <b>To:</b> Nieto, David M <a
                              href="mailto:David.Nieto@amd.com"
                              target="_blank" moz-do-not-send="true">&lt;David.Nieto@amd.com&gt;</a><br>
                            <b>Cc:</b> Alex Deucher <a
                              href="mailto:alexdeucher@gmail.com"
                              target="_blank" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a>;
                            amd-gfx list
                            <a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              target="_blank" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                            Kees Cook
                            <a href="mailto:keescook@chromium.org"
                              target="_blank" moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a>;
                            Deng, Emily
                            <a href="mailto:Emily.Deng@amd.com"
                              target="_blank" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><br>
                            <b>Subject:</b> RE: [PATCH] drm/amdgpu:
                            Align serial size in drm_amdgpu_info_vbios</span>
                        </p>
                        <div>
                          <p class="x_MsoNormal"> </p>
                        </div>
                      </div>
                      <div>
                        <div>
                          <p class="x_MsoNormal">[AMD Official Use Only
                            - Internal Distribution Only]<br>
                            <br>
                            Hi David,<br>
                            <br>
                            What I meant is to ONLY delete the
                            serial[16] from drm_amdgpu_info_vbios, not
                            the whole struct.<br>
                            <br>
                            struct drm_amdgpu_info_vbios {<br>
                                    __u8 name[64];<br>
                                    __u32 dbdf;<br>
                                    __u8 vbios_pn[64];<br>
                                    __u32 version;<br>
                                    __u8 date[32];<br>
                                    __u8 serial[16]; // jiawei: shall we
                            delete this<br>
                                    __u32 dev_id;<br>
                                    __u32 rev_id;<br>
                                    __u32 sub_dev_id;<br>
                                    __u32 sub_ved_id;<br>
                            };<br>
                            <br>
                            serial[16] in drm_amdgpu_info_vbios  copied
                            from adev-&gt;serial, but there's already a
                            sysfs named serial_number, which exposes it
                            already.<br>
                            <br>
                            static ssize_t
                            amdgpu_device_get_serial_number(struct
                            device *dev,<br>
                                            struct device_attribute
                            *attr, char *buf)<br>
                            {<br>
                                    struct drm_device *ddev =
                            dev_get_drvdata(dev);<br>
                                    struct amdgpu_device *adev =
                            ddev-&gt;dev_private;<br>
                            <br>
                                    return snprintf(buf, PAGE_SIZE,
                            "%s\n", adev-&gt;serial);<br>
                            }<br>
                            <br>
                            Thanks,<br>
                            Jiawei<br>
                            <br>
                            <br>
                            -----Original Message-----<br>
                            From: Nieto, David M <a
                              href="mailto:David.Nieto@amd.com"
                              target="_blank" moz-do-not-send="true">&lt;David.Nieto@amd.com&gt;</a>
                            <br>
                            Sent: Monday, May 10, 2021 2:53 PM<br>
                            To: Gu, JiaWei (Will) <a
                              href="mailto:JiaWei.Gu@amd.com"
                              target="_blank" moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                            Cc: Alex Deucher <a
                              href="mailto:alexdeucher@gmail.com"
                              target="_blank" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a>;
                            amd-gfx list
                            <a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              target="_blank" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                            Kees Cook
                            <a href="mailto:keescook@chromium.org"
                              target="_blank" moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a>;
                            Deng, Emily
                            <a href="mailto:Emily.Deng@amd.com"
                              target="_blank" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><br>
                            Subject: Re: [PATCH] drm/amdgpu: Align
                            serial size in drm_amdgpu_info_vbios<br>
                            <br>
                            No, this structure contains all the details
                            of the vbios: date, serial number, name,
                            etc.<br>
                            <br>
                            The sysfs node only contains the vbios name
                            string<br>
                            <br>
                            &gt; On May 9, 2021, at 23:33, Gu, JiaWei
                            (Will) <a href="mailto:JiaWei.Gu@amd.com"
                              target="_blank" moz-do-not-send="true">
                              &lt;JiaWei.Gu@amd.com&gt;</a> wrote:<br>
                            &gt; <br>
                            &gt; [AMD Official Use Only - Internal
                            Distribution Only]<br>
                            &gt; <br>
                            &gt; With a second thought,<br>
                            &gt; __u8 serial[16] in
                            drm_amdgpu_info_vbios is a bit redundant,
                            sysfs serial_number already exposes it.<br>
                            &gt; <br>
                            &gt; Is it fine to abandon it from
                            drm_amdgpu_info_vbios struct? @Alex <br>
                            &gt; Deucher @Nieto, David M<br>
                            &gt; <br>
                            &gt; Best regards,<br>
                            &gt; Jiawei<br>
                            &gt; <br>
                            &gt; -----Original Message-----<br>
                            &gt; From: Alex Deucher <a
                              href="mailto:alexdeucher@gmail.com"
                              target="_blank" moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
                            &gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
                            &gt; To: Gu, JiaWei (Will) <a
                              href="mailto:JiaWei.Gu@amd.com"
                              target="_blank" moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                            &gt; Cc: amd-gfx list <a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              target="_blank" moz-do-not-send="true">
                              &lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                            Kees Cook <br>
                            &gt; <a href="mailto:keescook@chromium.org"
                              target="_blank" moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a><br>
                            &gt; Subject: Re: [PATCH] drm/amdgpu: Align
                            serial size in <br>
                            &gt; drm_amdgpu_info_vbios<br>
                            &gt; <br>
                            &gt;&gt; On Sat, May 8, 2021 at 2:48 AM
                            Jiawei Gu <a
                              href="mailto:Jiawei.Gu@amd.com"
                              target="_blank" moz-do-not-send="true">
                              &lt;Jiawei.Gu@amd.com&gt;</a> wrote:<br>
                            &gt;&gt; <br>
                            &gt;&gt; 20 should be serial char size now
                            instead of 16.<br>
                            &gt;&gt; <br>
                            &gt;&gt; Signed-off-by: Jiawei Gu <a
                              href="mailto:Jiawei.Gu@amd.com"
                              target="_blank" moz-do-not-send="true">&lt;Jiawei.Gu@amd.com&gt;</a><br>
                            &gt; <br>
                            &gt; Please make sure this keeps proper 64
                            bit alignment in the structure.<br>
                            &gt; <br>
                            &gt; Alex<br>
                            &gt; <br>
                            &gt; <br>
                            &gt;&gt; ---<br>
                            &gt;&gt; include/uapi/drm/amdgpu_drm.h | 2
                            +-<br>
                            &gt;&gt; 1 file changed, 1 insertion(+), 1
                            deletion(-)<br>
                            &gt;&gt; <br>
                            &gt;&gt; diff --git
                            a/include/uapi/drm/amdgpu_drm.h <br>
                            &gt;&gt; b/include/uapi/drm/amdgpu_drm.h
                            index 2b487a8d2727..1c20721f90da<br>
                            &gt;&gt; 100644<br>
                            &gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
                            &gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
                            &gt;&gt; @@ -957,7 +957,7 @@ struct
                            drm_amdgpu_info_vbios {<br>
                            &gt;&gt;        __u8 vbios_pn[64];<br>
                            &gt;&gt;        __u32 version;<br>
                            &gt;&gt;        __u8 date[32];<br>
                            &gt;&gt; -       __u8 serial[16];<br>
                            &gt;&gt; +       __u8 serial[20];<br>
                            &gt;&gt;        __u32 dev_id;<br>
                            &gt;&gt;        __u32 rev_id;<br>
                            &gt;&gt;        __u32 sub_dev_id;<br>
                            &gt;&gt; --<br>
                            &gt;&gt; 2.17.1<br>
                            &gt;&gt; <br>
                            &gt;&gt;
                            _______________________________________________<br>
                            &gt;&gt; amd-gfx mailing list<br>
                            &gt;&gt; <a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                            &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis"
                              target="_blank" moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis</a><br>
                            &gt;&gt; t <br>
                            &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fs.freedesktop.org%2F&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729003008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5c730zpnFFOm3EgabDFoiYlsl2tsaxImaTlVfap%2BfHQ%3D&amp;reserved=0"
                              originalsrc="http://s.freedesktop.org/"
shash="btj7NLDddPgpMAMLB3quP6ykf2ispDn5lwhdGkwRIrZZVTyHyNq1ssBpJhnsN4laG44hB4T0TgfxG02TLc3I6IjzSHPptuHwBRq9Sp6n9Q/XMg8Ct49Cm1151nK1BGGldJQWTEAuULIrh/XGNTux7Thy4JSZ7ROPWWOrUswWfPk="
                              target="_blank" moz-do-not-send="true">
                              s.freedesktop.org</a>%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CJ<br>
                            &gt;&gt; i<br>
                            &gt;&gt; awei.Gu%<a
href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2F40amd.com%2F&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729003008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=FzFHfe095%2FDzOYR%2BZ3tAzlF2wDRYsD5kOt%2Bf37nNVP4%3D&amp;reserved=0"
                              originalsrc="http://40amd.com/"
shash="cf/ygK275ZVbFfF5lVmCbvCl/B6PwIUkYnUG9wgvvtwcT2mXzRcsorOK9cwk01GKm9po/lqDU+gc9/3q+tUApaBm9jr04e4tQJONRS9Cx/Fdk4qcFUfsqBF1b9BLLYuiTck/Wc+Ck9ZATqKU0mMol8jES2vgx8WcF8g28sj3Zc0="
                              target="_blank" moz-do-not-send="true">40amd.com</a>%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e<br>
                            &gt;&gt; 6 <br>
                            &gt;&gt;
                            08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3<br>
                            &gt;&gt; d <br>
                            &gt;&gt;
                            8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7<br>
                            &gt;&gt; C <br>
                            &gt;&gt;
1000&amp;amp;sdata=kAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;amp;res<br>
                            &gt;&gt; e<br>
                            &gt;&gt; rved=0</p>
                        </div>
                      </div>
                      <p class="x_MsoNormal"><br>
                        <br>
                      </p>
                      <pre>_______________________________________________</pre>
                      <pre>amd-gfx mailing list</pre>
                      <pre><a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></pre>
                      <pre><a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729012969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=GA4tfIXNrbU98WUMQl%2Bkd28DyNgqjlZcIAryQtVIn%2Bw%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="t9pEoIbGR/QdCWU78obt+C/sor4AByekPVkQZPvb6duz54OJw/r6a/+75rBqHRpRw7idemSamNqzLoxesO+7RfIFrwyePU1Pbpr+go0REFs637qa4YUetwBREc5Ilu6Qsy5QX9jw41+/xFzr9+NOAGQBImNZ7pzucKWWycA5vVs=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
                    </blockquote>
                    <p class="x_MsoNormal"><br>
                      <br>
                    </p>
                  </div>
                </blockquote>
                <br>
              </div>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a href="mailto:amd-gfx@lists.freedesktop.org"
                target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
              <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C3503a51f2fa04376040b08d914558033%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563179729012969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=GA4tfIXNrbU98WUMQl%2Bkd28DyNgqjlZcIAryQtVIn%2Bw%3D&amp;reserved=0"
originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
shash="t9pEoIbGR/QdCWU78obt+C/sor4AByekPVkQZPvb6duz54OJw/r6a/+75rBqHRpRw7idemSamNqzLoxesO+7RfIFrwyePU1Pbpr+go0REFs637qa4YUetwBREc5Ilu6Qsy5QX9jw41+/xFzr9+NOAGQBImNZ7pzucKWWycA5vVs="
                rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------4C193A0472876E4D7FD1A496--

--===============1580216111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1580216111==--
