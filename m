Return-Path: <SRS0=T/f1=KK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F64EC433ED
	for <amd-gfx@archiver.kernel.org>; Sat, 15 May 2021 13:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF95D613C5
	for <amd-gfx@archiver.kernel.org>; Sat, 15 May 2021 13:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF95D613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320636E2D8;
	Sat, 15 May 2021 13:22:08 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B05D6E2D8
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 May 2021 13:22:06 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id l1so2545804ejb.6
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 May 2021 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=hH8VG+TnKy4s/G5M1Aa1FY53LZfSD9hu2a/tsKD9vyc=;
 b=VfNQ7bFpSD3SSyDULUnCOo0bKEe2Pw4D2ASrl6B35SbNvG/tEuHLGKpK9TPceHoahY
 FVoDxy5u/Nxphr1uPRMjIWNi3wJ4o1Wiry9xhA743AXn6cFsT+nok+q6JloJw5kw7Xph
 G5WUTXozszsyn3xcm0+oabtnoeMSyXiKBcJQR2fJQoUM43q65hVOmj2kN9RL7H1CKE60
 s/IOv7cEcy9Te85H5WjWGxLmlLlsHwcEDn2qtI6Fb6dLdZnf5hMf0uoiq4R64PjeX2ch
 oAOtSbbGeMU8XCUdVbxkqfkT/EQB/bP0HqgPsWy3NRHLD8uUKsVGfT4UzdvH6r/RHvr8
 RIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=hH8VG+TnKy4s/G5M1Aa1FY53LZfSD9hu2a/tsKD9vyc=;
 b=kggzkBdCrrqKe3EDTp9L+uB0eRmMy7CGZ7KY5w2j2vZK1Y90hKr1lefh+Uj94j6Aq6
 WMnQ4PiHbpvH40L14LqOTNxH7XQfYQQHcVyiEIY34TmtfjUBBsuWAuEPoQvQoeFzmzhj
 dDg0tXRmbc4S+nizvGe6/sooh1n7BoQebCfOYu7UBQvjJlgslZVBQptXZZSdks2l/6R/
 BPzdtohtq7qrhTxas3fmVrV1xEGoNmx0cik6OWOLcc/3f0FBXDxR2P6KHI9RzYD4AtGW
 yQOnk9OnQ+mZrhNq8YuKit0iXo9f2mCrH+xdrQ7MZ3/ZquvOnwQ2KJm3Nk1aN7XpDgOp
 H0ZA==
X-Gm-Message-State: AOAM5337QjEHPB6eSsA+JTECxb/zlfC+Cg5sCYghlsLv1h4I+u4th1ol
 2uH5efveTepAwYUzpMlyT9E=
X-Google-Smtp-Source: ABdhPJzSlka2lrmKH2L8+xKYNFfZ4k5JTlzJgAwuPExUGDoxbPGU5YyLcTHyrvhFp00Iivfq8UB74Q==
X-Received: by 2002:a17:906:b794:: with SMTP id
 dt20mr19476901ejb.59.1621084925253; 
 Sat, 15 May 2021 06:22:05 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:481a:a145:b36d:b6ba?
 ([2a02:908:1252:fb60:481a:a145:b36d:b6ba])
 by smtp.gmail.com with ESMTPSA id h9sm6656550edt.18.2021.05.15.06.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 May 2021 06:22:04 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 "Nieto, David M" <David.Nieto@amd.com>
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
 <454dbf38-3337-de8b-6a29-30f417475121@gmail.com>
 <BYAPR12MB2840E586673207558B7FC136F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
 <CAAxE2A4ASdVxA3s+Z6T00oBP+m6DDRo5CNeRxujL7_PJ=x6XBQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <89b16224-c106-df15-4282-e9361106cbd2@gmail.com>
Date: Sat, 15 May 2021 15:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAxE2A4ASdVxA3s+Z6T00oBP+m6DDRo5CNeRxujL7_PJ=x6XBQ@mail.gmail.com>
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
 Emily" <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/mixed; boundary="===============0417618222=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0417618222==
Content-Type: multipart/alternative;
 boundary="------------5A1D62EA03B9473EF1E93608"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5A1D62EA03B9473EF1E93608
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The uAPI isn't merged upstream yet, so can still be changed.

But I agree that this should be squashed into the original patch while 
upstreaming.

When this is just for umr as open source client then the question is 
still on the stable if this really need to be an IOCTL?

Christian.

Am 15.05.21 um 08:40 schrieb Marek Olšák:
> 1) Mesa doesn't plan to use this VBIOS query.
>
> 2) The patch is changing uapi, which is forbidden.
>
> Marek
>
> On Tue, May 11, 2021 at 12:35 PM Nieto, David M <David.Nieto@amd.com 
> <mailto:David.Nieto@amd.com>> wrote:
>
>     [AMD Public Use]
>
>
>     The point of having the device ID in the structure is because we
>     are reading it from the VBIOS header, not the asic registers. They
>     should match, but an user may flash a VBIOS for a different devid
>     and they may not match.
>
>     Regarding sysfs vs ioctl I see value in providing it in both ways,
>     Mesa uses IOCTL and other DRM based tools may benefit as well. I
>     recently went through the trouble of having to add sysfs string
>     parsing for some data not available in ioctl, and while not very
>     complicated, it is a programming inconvenience.
>
>     I understand that being uapi, changing it is not easy, but this is
>     information extracted from a VBIOS header, something that has been
>     kept stable for many years.
>
>     David
>     ------------------------------------------------------------------------
>     *From:* Christian König <ckoenig.leichtzumerken@gmail.com
>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>     *Sent:* Tuesday, May 11, 2021 7:07 AM
>     *To:* Deucher, Alexander <Alexander.Deucher@amd.com
>     <mailto:Alexander.Deucher@amd.com>>; Marek Olšák <maraeo@gmail.com
>     <mailto:maraeo@gmail.com>>
>     *Cc:* Kees Cook <keescook@chromium.org
>     <mailto:keescook@chromium.org>>; Gu, JiaWei (Will)
>     <JiaWei.Gu@amd.com <mailto:JiaWei.Gu@amd.com>>; amd-gfx list
>     <amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>>; Deng, Emily
>     <Emily.Deng@amd.com <mailto:Emily.Deng@amd.com>>; Alex Deucher
>     <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>; Nieto,
>     David M <David.Nieto@amd.com <mailto:David.Nieto@amd.com>>
>     *Subject:* Re: [PATCH] drm/amdgpu: Align serial size in
>     drm_amdgpu_info_vbios
>     Yeah, but umr is making strong use of sysfs as well.
>
>     The only justification of this interface would be if we want to
>     use it in Mesa.
>
>     And I agree with Marek that looks redundant with the device
>     structure to me as well.
>
>     Christian.
>
>     Am 11.05.21 um 16:04 schrieb Deucher, Alexander:
>>
>>     [AMD Public Use]
>>
>>
>>     It's being used by umr and some other smi tools to provide vbios
>>     information for debugging.
>>
>>     Alex
>>
>>     ------------------------------------------------------------------------
>>     *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>>     <mailto:amd-gfx-bounces@lists.freedesktop.org> on behalf of Marek
>>     Olšák <maraeo@gmail.com> <mailto:maraeo@gmail.com>
>>     *Sent:* Tuesday, May 11, 2021 4:18 AM
>>     *To:* Christian König <ckoenig.leichtzumerken@gmail.com>
>>     <mailto:ckoenig.leichtzumerken@gmail.com>
>>     *Cc:* Kees Cook <keescook@chromium.org>
>>     <mailto:keescook@chromium.org>; Gu, JiaWei (Will)
>>     <JiaWei.Gu@amd.com> <mailto:JiaWei.Gu@amd.com>; amd-gfx list
>>     <amd-gfx@lists.freedesktop.org>
>>     <mailto:amd-gfx@lists.freedesktop.org>; Deng, Emily
>>     <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>; Alex Deucher
>>     <alexdeucher@gmail.com> <mailto:alexdeucher@gmail.com>; Nieto,
>>     David M <David.Nieto@amd.com> <mailto:David.Nieto@amd.com>
>>     *Subject:* Re: [PATCH] drm/amdgpu: Align serial size in
>>     drm_amdgpu_info_vbios
>>     Mesa doesn't use sysfs.
>>
>>     Note that this is a uapi, meaning that once it's in the kernel,
>>     it can't be changed like that.
>>
>>     What's the use case for this new interface? Isn't it partially
>>     redundant with the current device info structure, which seems to
>>     have the equivalent of dev_id and rev_id?
>>
>>     Marek
>>
>>     On Tue, May 11, 2021 at 3:51 AM Christian König
>>     <ckoenig.leichtzumerken@gmail.com
>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>         Marek and other userspace folks need to decide that.
>>
>>         Basic question here is if Mesa is already accessing sysfs
>>         nodes for OpenGL or RADV. If that is the case then we should
>>         probably expose the information there as well.
>>
>>         If that isn't the case (which I think it is) then we should
>>         implement it as IOCTL.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 10.05.21 um 22:19 schrieb Nieto, David M:
>>>
>>>         One of the primary usecases is to add this information to
>>>         the renderer string, I am not sure if there are other cases
>>>         of UMD drivers accessing sysfs nodes, but I think if we
>>>         think permissions, if a client is authenticated and opens
>>>         the render device then it can use the IOCTL, it is unclear
>>>         to me we can make a such an assumption for sysfs nodes…
>>>
>>>         I think there is value in having both tbh.
>>>
>>>         Regards,
>>>
>>>         David
>>>
>>>         *From: *Christian König <ckoenig.leichtzumerken@gmail.com>
>>>         <mailto:ckoenig.leichtzumerken@gmail.com>
>>>         *Date: *Monday, May 10, 2021 at 6:48 AM
>>>         *To: *"Nieto, David M" <David.Nieto@amd.com>
>>>         <mailto:David.Nieto@amd.com>, "Gu, JiaWei (Will)"
>>>         <JiaWei.Gu@amd.com> <mailto:JiaWei.Gu@amd.com>
>>>         *Cc: *Alex Deucher <alexdeucher@gmail.com>
>>>         <mailto:alexdeucher@gmail.com>, "Deng, Emily"
>>>         <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>, Kees Cook
>>>         <keescook@chromium.org> <mailto:keescook@chromium.org>,
>>>         amd-gfx list <amd-gfx@lists.freedesktop.org>
>>>         <mailto:amd-gfx@lists.freedesktop.org>
>>>         *Subject: *Re: [PATCH] drm/amdgpu: Align serial size in
>>>         drm_amdgpu_info_vbios
>>>
>>>         Well we could add both as sysfs file(s).
>>>
>>>         Question here is rather what is the primary use case of this
>>>         and if the application has the necessary access permissions
>>>         to the sysfs files?
>>>
>>>         Regards,
>>>         Christian.
>>>
>>>         Am 10.05.21 um 15:42 schrieb Nieto, David M:
>>>
>>>             Then the application would need to issue the ioctl and
>>>             then open a sysfs file to get all the information it
>>>             needs. It makes little sense from a programming
>>>             perspective to add an incomplete interface in my opinion
>>>
>>>             ------------------------------------------------------------------------
>>>
>>>             *From:*Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>>>             <mailto:JiaWei.Gu@amd.com>
>>>             *Sent:* Monday, May 10, 2021 12:13:07 AM
>>>             *To:* Nieto, David M <David.Nieto@amd.com>
>>>             <mailto:David.Nieto@amd.com>
>>>             *Cc:* Alex Deucher <alexdeucher@gmail.com>
>>>             <mailto:alexdeucher@gmail.com>; amd-gfx list
>>>             <amd-gfx@lists.freedesktop.org>
>>>             <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>>>             <keescook@chromium.org> <mailto:keescook@chromium.org>;
>>>             Deng, Emily <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>>>             *Subject:* RE: [PATCH] drm/amdgpu: Align serial size in
>>>             drm_amdgpu_info_vbios
>>>
>>>             [AMD Official Use Only - Internal Distribution Only]
>>>
>>>             Hi David,
>>>
>>>             What I meant is to ONLY delete the serial[16] from
>>>             drm_amdgpu_info_vbios, not the whole struct.
>>>
>>>             struct drm_amdgpu_info_vbios {
>>>                     __u8 name[64];
>>>                     __u32 dbdf;
>>>                     __u8 vbios_pn[64];
>>>                     __u32 version;
>>>                     __u8 date[32];
>>>                     __u8 serial[16]; // jiawei: shall we delete this
>>>                     __u32 dev_id;
>>>                     __u32 rev_id;
>>>                     __u32 sub_dev_id;
>>>                     __u32 sub_ved_id;
>>>             };
>>>
>>>             serial[16] in drm_amdgpu_info_vbios  copied from
>>>             adev->serial, but there's already a sysfs named
>>>             serial_number, which exposes it already.
>>>
>>>             static ssize_t amdgpu_device_get_serial_number(struct
>>>             device *dev,
>>>                             struct device_attribute *attr, char *buf)
>>>             {
>>>                     struct drm_device *ddev = dev_get_drvdata(dev);
>>>                     struct amdgpu_device *adev = ddev->dev_private;
>>>
>>>                     return snprintf(buf, PAGE_SIZE, "%s\n",
>>>             adev->serial);
>>>             }
>>>
>>>             Thanks,
>>>             Jiawei
>>>
>>>
>>>             -----Original Message-----
>>>             From: Nieto, David M <David.Nieto@amd.com>
>>>             <mailto:David.Nieto@amd.com>
>>>             Sent: Monday, May 10, 2021 2:53 PM
>>>             To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>>>             <mailto:JiaWei.Gu@amd.com>
>>>             Cc: Alex Deucher <alexdeucher@gmail.com>
>>>             <mailto:alexdeucher@gmail.com>; amd-gfx list
>>>             <amd-gfx@lists.freedesktop.org>
>>>             <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>>>             <keescook@chromium.org> <mailto:keescook@chromium.org>;
>>>             Deng, Emily <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>>>             Subject: Re: [PATCH] drm/amdgpu: Align serial size in
>>>             drm_amdgpu_info_vbios
>>>
>>>             No, this structure contains all the details of the
>>>             vbios: date, serial number, name, etc.
>>>
>>>             The sysfs node only contains the vbios name string
>>>
>>>             > On May 9, 2021, at 23:33, Gu, JiaWei (Will)
>>>             <JiaWei.Gu@amd.com> <mailto:JiaWei.Gu@amd.com> wrote:
>>>             >
>>>             > [AMD Official Use Only - Internal Distribution Only]
>>>             >
>>>             > With a second thought,
>>>             > __u8 serial[16] in drm_amdgpu_info_vbios is a bit
>>>             redundant, sysfs serial_number already exposes it.
>>>             >
>>>             > Is it fine to abandon it from drm_amdgpu_info_vbios
>>>             struct? @Alex
>>>             > Deucher @Nieto, David M
>>>             >
>>>             > Best regards,
>>>             > Jiawei
>>>             >
>>>             > -----Original Message-----
>>>             > From: Alex Deucher <alexdeucher@gmail.com>
>>>             <mailto:alexdeucher@gmail.com>
>>>             > Sent: Sunday, May 9, 2021 11:59 PM
>>>             > To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>>>             <mailto:JiaWei.Gu@amd.com>
>>>             > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>>>             <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>>>             > <keescook@chromium.org> <mailto:keescook@chromium.org>
>>>             > Subject: Re: [PATCH] drm/amdgpu: Align serial size in
>>>             > drm_amdgpu_info_vbios
>>>             >
>>>             >> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu
>>>             <Jiawei.Gu@amd.com> <mailto:Jiawei.Gu@amd.com> wrote:
>>>             >>
>>>             >> 20 should be serial char size now instead of 16.
>>>             >>
>>>             >> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
>>>             <mailto:Jiawei.Gu@amd.com>
>>>             >
>>>             > Please make sure this keeps proper 64 bit alignment in
>>>             the structure.
>>>             >
>>>             > Alex
>>>             >
>>>             >
>>>             >> ---
>>>             >> include/uapi/drm/amdgpu_drm.h | 2 +-
>>>             >> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>             >>
>>>             >> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>             >> b/include/uapi/drm/amdgpu_drm.h index
>>>             2b487a8d2727..1c20721f90da
>>>             >> 100644
>>>             >> --- a/include/uapi/drm/amdgpu_drm.h
>>>             >> +++ b/include/uapi/drm/amdgpu_drm.h
>>>             >> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
>>>             >>        __u8 vbios_pn[64];
>>>             >>        __u32 version;
>>>             >>        __u8 date[32];
>>>             >> -       __u8 serial[16];
>>>             >> +       __u8 serial[20];
>>>             >>        __u32 dev_id;
>>>             >>        __u32 rev_id;
>>>             >>        __u32 sub_dev_id;
>>>             >> --
>>>             >> 2.17.1
>>>             >>
>>>             >> _______________________________________________
>>>             >> amd-gfx mailing list
>>>             >> amd-gfx@lists.freedesktop.org
>>>             <mailto:amd-gfx@lists.freedesktop.org>
>>>             >>
>>>             https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>>>             <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis>
>>>             >> t
>>>             >> s.freedesktop.org
>>>             <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fs.freedesktop.org%2F&data=04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684906500%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=gKeRCQ485gWespGfo1O01tZz8fDy1zPGHIDEvCqyp1I%3D&reserved=0>%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJ
>>>             >> i
>>>             >> awei.Gu%40amd.com
>>>             <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2F40amd.com%2F&data=04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684916541%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=8pM7WTh9%2F23KCF6DuXOc4%2Fi7rDUSxmH647BdpujXgWo%3D&reserved=0>%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e
>>>             >> 6
>>>             >>
>>>             08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
>>>             >> d
>>>             >>
>>>             8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>>>             >> C
>>>             >>
>>>             1000&amp;sdata=kAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;res
>>>             >> e
>>>             >> rved=0
>>>
>>>
>>>
>>>             _______________________________________________
>>>
>>>             amd-gfx mailing list
>>>
>>>             amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>
>>>             https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=Hdhx2ogsQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&reserved=0>
>>>
>>>
>>>
>>
>>         _______________________________________________
>>         amd-gfx mailing list
>>         amd-gfx@lists.freedesktop.org
>>         <mailto:amd-gfx@lists.freedesktop.org>
>>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>         <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=Hdhx2ogsQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&reserved=0>
>>
>


--------------5A1D62EA03B9473EF1E93608
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    The uAPI isn't merged upstream yet, so can still be changed.<br>
    <br>
    But I agree that this should be squashed into the original patch
    while upstreaming.<br>
    <br>
    When this is just for umr as open source client then the question is
    still on the stable if this really need to be an IOCTL?<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 15.05.21 um 08:40 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A4ASdVxA3s+Z6T00oBP+m6DDRo5CNeRxujL7_PJ=x6XBQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>1) Mesa doesn't plan to use this VBIOS query.</div>
        <div><br>
        </div>
        <div>2) The patch is changing uapi, which is forbidden.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, May 11, 2021 at 12:35
          PM Nieto, David M &lt;<a href="mailto:David.Nieto@amd.com"
            moz-do-not-send="true">David.Nieto@amd.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <p
              style="font-family:Arial;font-size:10pt;color:rgb(49,113,0);margin:15pt"
              align="Left">
              [AMD Public Use]<br>
            </p>
            <br>
            <div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);background-color:rgb(255,255,255)">The
                point of having the device ID in the structure is
                because we are reading it from the VBIOS header, not the
                asic registers. They should match, but an user may flash
                a VBIOS for a different devid and they may not match.</div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);background-color:rgb(255,255,255)"><br>
              </div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);background-color:rgb(255,255,255)">Regarding
                sysfs vs ioctl I see value in providing it in both ways,
                Mesa uses IOCTL and other DRM based tools may benefit as
                well. I recently went through the trouble of having to
                add sysfs string parsing for some data not available in
                ioctl, and while not very complicated, it is a
                programming inconvenience.</div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);background-color:rgb(255,255,255)"><br>
              </div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);background-color:rgb(255,255,255)">I
                understand that being uapi, changing it is not easy, but
                this is information extracted from a VBIOS header,
                something that has been kept stable for many years.</div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);background-color:rgb(255,255,255)"><br>
              </div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);background-color:rgb(255,255,255)">David</div>
              <hr style="display:inline-block;width:98%">
              <div id="gmail-m_8490547758640332650divRplyFwdMsg"
                dir="ltr"><font style="font-size:11pt" face="Calibri,
                  sans-serif" color="#000000"><b>From:</b> Christian
                  König &lt;<a
                    href="mailto:ckoenig.leichtzumerken@gmail.com"
                    target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                  <b>Sent:</b> Tuesday, May 11, 2021 7:07 AM<br>
                  <b>To:</b> Deucher, Alexander &lt;<a
                    href="mailto:Alexander.Deucher@amd.com"
                    target="_blank" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                  Marek Olšák &lt;<a href="mailto:maraeo@gmail.com"
                    target="_blank" moz-do-not-send="true">maraeo@gmail.com</a>&gt;<br>
                  <b>Cc:</b> Kees Cook &lt;<a
                    href="mailto:keescook@chromium.org" target="_blank"
                    moz-do-not-send="true">keescook@chromium.org</a>&gt;;
                  Gu, JiaWei (Will) &lt;<a
                    href="mailto:JiaWei.Gu@amd.com" target="_blank"
                    moz-do-not-send="true">JiaWei.Gu@amd.com</a>&gt;;
                  amd-gfx list &lt;<a
                    href="mailto:amd-gfx@lists.freedesktop.org"
                    target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                  Deng, Emily &lt;<a href="mailto:Emily.Deng@amd.com"
                    target="_blank" moz-do-not-send="true">Emily.Deng@amd.com</a>&gt;;
                  Alex Deucher &lt;<a
                    href="mailto:alexdeucher@gmail.com" target="_blank"
                    moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;;
                  Nieto, David M &lt;<a
                    href="mailto:David.Nieto@amd.com" target="_blank"
                    moz-do-not-send="true">David.Nieto@amd.com</a>&gt;<br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial
                  size in drm_amdgpu_info_vbios</font>
                <div> </div>
              </div>
              <div>Yeah, but umr is making strong use of sysfs as well.<br>
                <br>
                The only justification of this interface would be if we
                want to use it in Mesa.<br>
                <br>
                And I agree with Marek that looks redundant with the
                device structure to me as well.<br>
                <br>
                Christian.<br>
                <br>
                <div>Am 11.05.21 um 16:04 schrieb Deucher, Alexander:<br>
                </div>
                <blockquote type="cite">
                  <p
                    style="font-family:Arial;font-size:10pt;color:rgb(49,113,0);margin:15pt"
                    align="Left">
                    [AMD Public Use]<br>
                  </p>
                  <br>
                  <div>
                    <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">It's
                      being used by umr and some other smi tools to
                      provide vbios information for debugging.</div>
                    <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
                    </div>
                    <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">Alex</div>
                    <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
                    </div>
                    <hr style="display:inline-block;width:98%">
                    <div id="gmail-m_8490547758640332650x_divRplyFwdMsg"
                      dir="ltr"><font style="font-size:11pt"
                        face="Calibri, sans-serif" color="#000000"><b>From:</b>
                        amd-gfx
                        <a
                          href="mailto:amd-gfx-bounces@lists.freedesktop.org"
                          target="_blank" moz-do-not-send="true">
                          &lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                        on behalf of Marek Olšák <a
                          href="mailto:maraeo@gmail.com" target="_blank"
                          moz-do-not-send="true">
                          &lt;maraeo@gmail.com&gt;</a><br>
                        <b>Sent:</b> Tuesday, May 11, 2021 4:18 AM<br>
                        <b>To:</b> Christian König <a
                          href="mailto:ckoenig.leichtzumerken@gmail.com"
                          target="_blank" moz-do-not-send="true">
                          &lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                        <b>Cc:</b> Kees Cook <a
                          href="mailto:keescook@chromium.org"
                          target="_blank" moz-do-not-send="true">
                          &lt;keescook@chromium.org&gt;</a>; Gu, JiaWei
                        (Will) <a href="mailto:JiaWei.Gu@amd.com"
                          target="_blank" moz-do-not-send="true">
                          &lt;JiaWei.Gu@amd.com&gt;</a>; amd-gfx list <a
                          href="mailto:amd-gfx@lists.freedesktop.org"
                          target="_blank" moz-do-not-send="true">
                          &lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                        Deng, Emily <a href="mailto:Emily.Deng@amd.com"
                          target="_blank" moz-do-not-send="true">
                          &lt;Emily.Deng@amd.com&gt;</a>; Alex Deucher <a
                          href="mailto:alexdeucher@gmail.com"
                          target="_blank" moz-do-not-send="true">
                          &lt;alexdeucher@gmail.com&gt;</a>; Nieto,
                        David M <a href="mailto:David.Nieto@amd.com"
                          target="_blank" moz-do-not-send="true">
                          &lt;David.Nieto@amd.com&gt;</a><br>
                        <b>Subject:</b> Re: [PATCH] drm/amdgpu: Align
                        serial size in drm_amdgpu_info_vbios</font>
                      <div> </div>
                    </div>
                    <div>
                      <div dir="ltr">
                        <div>Mesa doesn't use sysfs.</div>
                        <div><br>
                        </div>
                        <div>Note that this is a uapi, meaning that once
                          it's in the kernel, it can't be changed like
                          that.<br>
                        </div>
                        <div><br>
                        </div>
                        <div>What's the use case for this new interface?
                          Isn't it partially redundant with the current
                          device info structure, which seems to have the
                          equivalent of dev_id and rev_id?<br>
                        </div>
                        <div><br>
                        </div>
                        <div>Marek<br>
                        </div>
                      </div>
                      <br>
                      <div>
                        <div dir="ltr">On Tue, May 11, 2021 at 3:51 AM
                          Christian König &lt;<a
                            href="mailto:ckoenig.leichtzumerken@gmail.com"
                            target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">
                          <div>Marek and other userspace folks need to
                            decide that.<br>
                            <br>
                            Basic question here is if Mesa is already
                            accessing sysfs nodes for OpenGL or RADV. If
                            that is the case then we should probably
                            expose the information there as well.<br>
                            <br>
                            If that isn't the case (which I think it is)
                            then we should implement it as IOCTL.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            <div>Am 10.05.21 um 22:19 schrieb Nieto,
                              David M:<br>
                            </div>
                            <blockquote type="cite">
                              <div>
                                <p>One of the primary usecases is to add
                                  this information to the renderer
                                  string, I am not sure if there are
                                  other cases of UMD drivers accessing
                                  sysfs nodes, but I think if we think
                                  permissions, if a client is
                                  authenticated and opens the render
                                  device then it can use the IOCTL, it
                                  is unclear to me we can make a such an
                                  assumption for sysfs nodes…</p>
                                <p> </p>
                                <p>I think there is value in having both
                                  tbh.</p>
                                <p> </p>
                                <p>Regards,</p>
                                <p>David</p>
                                <p> </p>
                                <div
                                  style="border-color:rgb(181,196,223)
                                  currentcolor
                                  currentcolor;border-style:solid none
                                  none;border-width:1pt medium
                                  medium;padding:3pt 0in 0in">
                                  <p><b><span
                                        style="font-size:12pt;color:black">From:
                                      </span>
                                    </b><span
                                      style="font-size:12pt;color:black">Christian
                                      König <a
                                        href="mailto:ckoenig.leichtzumerken@gmail.com"
                                        target="_blank"
                                        moz-do-not-send="true">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                                      <b>Date: </b>Monday, May 10, 2021
                                      at 6:48 AM<br>
                                      <b>To: </b>"Nieto, David M" <a
                                        href="mailto:David.Nieto@amd.com"
                                        target="_blank"
                                        moz-do-not-send="true">
                                        &lt;David.Nieto@amd.com&gt;</a>,
                                      "Gu, JiaWei (Will)" <a
                                        href="mailto:JiaWei.Gu@amd.com"
                                        target="_blank"
                                        moz-do-not-send="true">
                                        &lt;JiaWei.Gu@amd.com&gt;</a><br>
                                      <b>Cc: </b>Alex Deucher <a
                                        href="mailto:alexdeucher@gmail.com"
                                        target="_blank"
                                        moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a>,
                                      "Deng, Emily"
                                      <a
                                        href="mailto:Emily.Deng@amd.com"
                                        target="_blank"
                                        moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>,
                                      Kees Cook
                                      <a
                                        href="mailto:keescook@chromium.org"
                                        target="_blank"
                                        moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a>,
                                      amd-gfx list
                                      <a
                                        href="mailto:amd-gfx@lists.freedesktop.org"
                                        target="_blank"
                                        moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                                      <b>Subject: </b>Re: [PATCH]
                                      drm/amdgpu: Align serial size in
                                      drm_amdgpu_info_vbios</span></p>
                                </div>
                                <div>
                                  <p> </p>
                                </div>
                                <p style="margin-bottom:12pt">Well we
                                  could add both as sysfs file(s).<br>
                                  <br>
                                  Question here is rather what is the
                                  primary use case of this and if the
                                  application has the necessary access
                                  permissions to the sysfs files?<br>
                                  <br>
                                  Regards,<br>
                                  Christian.</p>
                                <div>
                                  <p>Am 10.05.21 um 15:42 schrieb Nieto,
                                    David M:</p>
                                </div>
                                <blockquote
                                  style="margin-top:5pt;margin-bottom:5pt">
                                  <div>
                                    <div>
                                      <div>
                                        <p style="background:white none
                                          repeat scroll 0% 0%">
                                          <span style="color:black">Then
                                            the application would need
                                            to issue the ioctl and then
                                            open a sysfs file to get all
                                            the information it needs. It
                                            makes little sense from a
                                            programming perspective to
                                            add an incomplete interface
                                            in my opinion </span></p>
                                      </div>
                                    </div>
                                    <div>
                                      <p> </p>
                                    </div>
                                  </div>
                                  <div style="text-align:center"
                                    align="center">
                                    <hr width="100%" size="0"
                                      align="center">
                                  </div>
                                  <div
id="gmail-m_8490547758640332650x_x_gmail-m_782079725653541167gmail-m_3184748164637597930gmail-m_-3452308432024396062divRplyFwdMsg">
                                    <p><b><span style="color:black">From:</span></b><span
                                        style="color:black"> Gu, JiaWei
                                        (Will)
                                        <a
                                          href="mailto:JiaWei.Gu@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                                        <b>Sent:</b> Monday, May 10,
                                        2021 12:13:07 AM<br>
                                        <b>To:</b> Nieto, David M <a
                                          href="mailto:David.Nieto@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;David.Nieto@amd.com&gt;</a><br>
                                        <b>Cc:</b> Alex Deucher <a
                                          href="mailto:alexdeucher@gmail.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a>;
                                        amd-gfx list
                                        <a
                                          href="mailto:amd-gfx@lists.freedesktop.org"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                                        Kees Cook
                                        <a
                                          href="mailto:keescook@chromium.org"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a>;
                                        Deng, Emily
                                        <a
                                          href="mailto:Emily.Deng@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><br>
                                        <b>Subject:</b> RE: [PATCH]
                                        drm/amdgpu: Align serial size in
                                        drm_amdgpu_info_vbios</span>
                                    </p>
                                    <div>
                                      <p> </p>
                                    </div>
                                  </div>
                                  <div>
                                    <div>
                                      <p>[AMD Official Use Only -
                                        Internal Distribution Only]<br>
                                        <br>
                                        Hi David,<br>
                                        <br>
                                        What I meant is to ONLY delete
                                        the serial[16] from
                                        drm_amdgpu_info_vbios, not the
                                        whole struct.<br>
                                        <br>
                                        struct drm_amdgpu_info_vbios {<br>
                                                __u8 name[64];<br>
                                                __u32 dbdf;<br>
                                                __u8 vbios_pn[64];<br>
                                                __u32 version;<br>
                                                __u8 date[32];<br>
                                                __u8 serial[16]; //
                                        jiawei: shall we delete this<br>
                                                __u32 dev_id;<br>
                                                __u32 rev_id;<br>
                                                __u32 sub_dev_id;<br>
                                                __u32 sub_ved_id;<br>
                                        };<br>
                                        <br>
                                        serial[16] in
                                        drm_amdgpu_info_vbios  copied
                                        from adev-&gt;serial, but
                                        there's already a sysfs named
                                        serial_number, which exposes it
                                        already.<br>
                                        <br>
                                        static ssize_t
                                        amdgpu_device_get_serial_number(struct
                                        device *dev,<br>
                                                        struct
                                        device_attribute *attr, char
                                        *buf)<br>
                                        {<br>
                                                struct drm_device *ddev
                                        = dev_get_drvdata(dev);<br>
                                                struct amdgpu_device
                                        *adev = ddev-&gt;dev_private;<br>
                                        <br>
                                                return snprintf(buf,
                                        PAGE_SIZE, "%s\n",
                                        adev-&gt;serial);<br>
                                        }<br>
                                        <br>
                                        Thanks,<br>
                                        Jiawei<br>
                                        <br>
                                        <br>
                                        -----Original Message-----<br>
                                        From: Nieto, David M <a
                                          href="mailto:David.Nieto@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;David.Nieto@amd.com&gt;</a>
                                        <br>
                                        Sent: Monday, May 10, 2021 2:53
                                        PM<br>
                                        To: Gu, JiaWei (Will) <a
                                          href="mailto:JiaWei.Gu@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                                        Cc: Alex Deucher <a
                                          href="mailto:alexdeucher@gmail.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a>;
                                        amd-gfx list
                                        <a
                                          href="mailto:amd-gfx@lists.freedesktop.org"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                                        Kees Cook
                                        <a
                                          href="mailto:keescook@chromium.org"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a>;
                                        Deng, Emily
                                        <a
                                          href="mailto:Emily.Deng@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><br>
                                        Subject: Re: [PATCH] drm/amdgpu:
                                        Align serial size in
                                        drm_amdgpu_info_vbios<br>
                                        <br>
                                        No, this structure contains all
                                        the details of the vbios: date,
                                        serial number, name, etc.<br>
                                        <br>
                                        The sysfs node only contains the
                                        vbios name string<br>
                                        <br>
                                        &gt; On May 9, 2021, at 23:33,
                                        Gu, JiaWei (Will) <a
                                          href="mailto:JiaWei.Gu@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">
                                          &lt;JiaWei.Gu@amd.com&gt;</a>
                                        wrote:<br>
                                        &gt; <br>
                                        &gt; [AMD Official Use Only -
                                        Internal Distribution Only]<br>
                                        &gt; <br>
                                        &gt; With a second thought,<br>
                                        &gt; __u8 serial[16] in
                                        drm_amdgpu_info_vbios is a bit
                                        redundant, sysfs serial_number
                                        already exposes it.<br>
                                        &gt; <br>
                                        &gt; Is it fine to abandon it
                                        from drm_amdgpu_info_vbios
                                        struct? @Alex <br>
                                        &gt; Deucher @Nieto, David M<br>
                                        &gt; <br>
                                        &gt; Best regards,<br>
                                        &gt; Jiawei<br>
                                        &gt; <br>
                                        &gt; -----Original Message-----<br>
                                        &gt; From: Alex Deucher <a
                                          href="mailto:alexdeucher@gmail.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
                                        &gt; Sent: Sunday, May 9, 2021
                                        11:59 PM<br>
                                        &gt; To: Gu, JiaWei (Will) <a
                                          href="mailto:JiaWei.Gu@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                                        &gt; Cc: amd-gfx list <a
                                          href="mailto:amd-gfx@lists.freedesktop.org"
                                          target="_blank"
                                          moz-do-not-send="true">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook <br>
                                        &gt; <a
                                          href="mailto:keescook@chromium.org"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a><br>
                                        &gt; Subject: Re: [PATCH]
                                        drm/amdgpu: Align serial size in
                                        <br>
                                        &gt; drm_amdgpu_info_vbios<br>
                                        &gt; <br>
                                        &gt;&gt; On Sat, May 8, 2021 at
                                        2:48 AM Jiawei Gu <a
                                          href="mailto:Jiawei.Gu@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">
                                          &lt;Jiawei.Gu@amd.com&gt;</a>
                                        wrote:<br>
                                        &gt;&gt; <br>
                                        &gt;&gt; 20 should be serial
                                        char size now instead of 16.<br>
                                        &gt;&gt; <br>
                                        &gt;&gt; Signed-off-by: Jiawei
                                        Gu <a
                                          href="mailto:Jiawei.Gu@amd.com"
                                          target="_blank"
                                          moz-do-not-send="true">&lt;Jiawei.Gu@amd.com&gt;</a><br>
                                        &gt; <br>
                                        &gt; Please make sure this keeps
                                        proper 64 bit alignment in the
                                        structure.<br>
                                        &gt; <br>
                                        &gt; Alex<br>
                                        &gt; <br>
                                        &gt; <br>
                                        &gt;&gt; ---<br>
                                        &gt;&gt;
                                        include/uapi/drm/amdgpu_drm.h |
                                        2 +-<br>
                                        &gt;&gt; 1 file changed, 1
                                        insertion(+), 1 deletion(-)<br>
                                        &gt;&gt; <br>
                                        &gt;&gt; diff --git
                                        a/include/uapi/drm/amdgpu_drm.h
                                        <br>
                                        &gt;&gt;
                                        b/include/uapi/drm/amdgpu_drm.h
                                        index 2b487a8d2727..1c20721f90da<br>
                                        &gt;&gt; 100644<br>
                                        &gt;&gt; ---
                                        a/include/uapi/drm/amdgpu_drm.h<br>
                                        &gt;&gt; +++
                                        b/include/uapi/drm/amdgpu_drm.h<br>
                                        &gt;&gt; @@ -957,7 +957,7 @@
                                        struct drm_amdgpu_info_vbios {<br>
                                        &gt;&gt;        __u8
                                        vbios_pn[64];<br>
                                        &gt;&gt;        __u32 version;<br>
                                        &gt;&gt;        __u8 date[32];<br>
                                        &gt;&gt; -       __u8
                                        serial[16];<br>
                                        &gt;&gt; +       __u8
                                        serial[20];<br>
                                        &gt;&gt;        __u32 dev_id;<br>
                                        &gt;&gt;        __u32 rev_id;<br>
                                        &gt;&gt;        __u32
                                        sub_dev_id;<br>
                                        &gt;&gt; --<br>
                                        &gt;&gt; 2.17.1<br>
                                        &gt;&gt; <br>
                                        &gt;&gt;
                                        _______________________________________________<br>
                                        &gt;&gt; amd-gfx mailing list<br>
                                        &gt;&gt; <a
                                          href="mailto:amd-gfx@lists.freedesktop.org"
                                          target="_blank"
                                          moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                        &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis"
                                          target="_blank"
                                          moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis</a><br>
                                        &gt;&gt; t <br>
                                        &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fs.freedesktop.org%2F&amp;data=04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684906500%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gKeRCQ485gWespGfo1O01tZz8fDy1zPGHIDEvCqyp1I%3D&amp;reserved=0"
                                          target="_blank"
                                          moz-do-not-send="true">
                                          s.freedesktop.org</a>%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CJ<br>
                                        &gt;&gt; i<br>
                                        &gt;&gt; awei.Gu%<a
href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2F40amd.com%2F&amp;data=04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684916541%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8pM7WTh9%2F23KCF6DuXOc4%2Fi7rDUSxmH647BdpujXgWo%3D&amp;reserved=0"
                                          target="_blank"
                                          moz-do-not-send="true">40amd.com</a>%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e<br>
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
                                  <p><br>
                                    <br>
                                  </p>
                                  <pre>_______________________________________________</pre>
                                  <pre>amd-gfx mailing list</pre>
                                  <pre><a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a></pre>
                                  <pre><a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hdhx2ogsQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&amp;reserved=0" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
                                </blockquote>
                                <p><br>
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
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CDavid.Nieto%40amd.com%7Cf24b10fbdd964acea32008d914862738%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563388684926488%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hdhx2ogsQt2C3OIKNC%2BaswtNkiIWbV6Ot8a%2B3YFqa7w%3D&amp;reserved=0"
                            rel="noreferrer" target="_blank"
                            moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                        </blockquote>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <br>
              </div>
            </div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------5A1D62EA03B9473EF1E93608--

--===============0417618222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0417618222==--
