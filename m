Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B63C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A9A610CA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A9A610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D2789FD3;
	Mon, 10 May 2021 13:48:46 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DD86E47B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 13:48:44 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id s7so14094910edq.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=wnMU+0NDJEevBlNLsCfj5PV8okY3LN9lqIT7mS5hy9U=;
 b=lzXymEzwm5qLrfZR95u4H/BX42wokaUYVJlYvD1oTa6ULZyG4rnadaVfuX4u/iBvBr
 ZoYbcR4XZCw3vBQbOMRJGmv3uXP6NGI86n0b1wwnUj/LSLbkKJMFhiNApwlkXFlmip0a
 Eimbq6WwH7uMFpCQqMkjeX8HBzDXY3EOlhsgNdBpjZrL5q3z+p1c8JfY4LoFTwxF3g1e
 q0OIec6ydFaxobLNzlPQ6St2J5ExJztmElT9l9l4esKUlM460ZhBtMGcEY9DTFB79cv2
 tokx2+NlxyWAjQJ8jYwiAVgEXJ4HcQW/nxao1mukLENcTPtSRoWB80goHNbeGiRWm+k/
 dM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=wnMU+0NDJEevBlNLsCfj5PV8okY3LN9lqIT7mS5hy9U=;
 b=ePtTYe7sLEf31rIwkYWsVzL8HTTtZ8iiQufQZ6jBH8Y/VDbPpZCw9lmRfdd+UV7ljc
 vGykLeAmC9EZQaN3Wqcp/7oc+ouJ+v8Yg2x5reDXHa2ZmjBZUusnnyfXUTx53uCn4ObX
 jVXjkHENxVI2qeK+8vjHTetY2Rlx7Pm72aJ2mjh+8tO8yHdHdpQTvW9C+EYXOLCmmyZo
 ETEb1unN+aHGA3XR7WEMOguU0NaCRptl4SC0inaFbZYk3aVnXiWCwLHyG3P2QINgFGGn
 IMT4Ri79CgpBCm1+KTBRRhY/cKjBBNPoeSNm0hjLJTimFS1VmH2XBghMxArTBPwvqobU
 RgFQ==
X-Gm-Message-State: AOAM533C96Pvy31+UKKHHCPSIUwd1nA0OwSQSaAaga+31s2mRqWrmAFj
 xEyn/wB1ikX1FTe/+4mNTr/6rGE7SP4=
X-Google-Smtp-Source: ABdhPJwaXJ3Vpt92Hz46NvLf0k+0CnAtyvUY1YAGLx3S/ks0oH3mddMW4mbADmTsvrjy01qm1xaB6A==
X-Received: by 2002:aa7:d806:: with SMTP id v6mr29892151edq.309.1620654523105; 
 Mon, 10 May 2021 06:48:43 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7903:34fa:e13f:17ac?
 ([2a02:908:1252:fb60:7903:34fa:e13f:17ac])
 by smtp.gmail.com with ESMTPSA id z22sm12877766edm.57.2021.05.10.06.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 06:48:42 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
To: "Nieto, David M" <David.Nieto@amd.com>,
 "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
Date: Mon, 10 May 2021 15:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 Kees Cook <keescook@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0256640219=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0256640219==
Content-Type: multipart/alternative;
 boundary="------------AEDF236F3082C3A1D5776393"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------AEDF236F3082C3A1D5776393
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Well we could add both as sysfs file(s).

Question here is rather what is the primary use case of this and if the 
application has the necessary access permissions to the sysfs files?

Regards,
Christian.

Am 10.05.21 um 15:42 schrieb Nieto, David M:
> Then the application would need to issue the ioctl and then open a 
> sysfs file to get all the information it needs. It makes little sense 
> from a programming perspective to add an incomplete interface in my 
> opinion
>
> ------------------------------------------------------------------------
> *From:* Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> *Sent:* Monday, May 10, 2021 12:13:07 AM
> *To:* Nieto, David M <David.Nieto@amd.com>
> *Cc:* Alex Deucher <alexdeucher@gmail.com>; amd-gfx list 
> <amd-gfx@lists.freedesktop.org>; Kees Cook <keescook@chromium.org>; 
> Deng, Emily <Emily.Deng@amd.com>
> *Subject:* RE: [PATCH] drm/amdgpu: Align serial size in 
> drm_amdgpu_info_vbios
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi David,
>
> What I meant is to ONLY delete the serial[16] from 
> drm_amdgpu_info_vbios, not the whole struct.
>
> struct drm_amdgpu_info_vbios {
>         __u8 name[64];
>         __u32 dbdf;
>         __u8 vbios_pn[64];
>         __u32 version;
>         __u8 date[32];
>         __u8 serial[16]; // jiawei: shall we delete this
>         __u32 dev_id;
>         __u32 rev_id;
>         __u32 sub_dev_id;
>         __u32 sub_ved_id;
> };
>
> serial[16] in drm_amdgpu_info_vbios  copied from adev->serial, but 
> there's already a sysfs named serial_number, which exposes it already.
>
> static ssize_t amdgpu_device_get_serial_number(struct device *dev,
>                 struct device_attribute *attr, char *buf)
> {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>
>         return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
> }
>
> Thanks,
> Jiawei
>
>
> -----Original Message-----
> From: Nieto, David M <David.Nieto@amd.com>
> Sent: Monday, May 10, 2021 2:53 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list 
> <amd-gfx@lists.freedesktop.org>; Kees Cook <keescook@chromium.org>; 
> Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Align serial size in 
> drm_amdgpu_info_vbios
>
> No, this structure contains all the details of the vbios: date, serial 
> number, name, etc.
>
> The sysfs node only contains the vbios name string
>
> > On May 9, 2021, at 23:33, Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
> >
> > ﻿[AMD Official Use Only - Internal Distribution Only]
> >
> > With a second thought,
> > __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs 
> serial_number already exposes it.
> >
> > Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex
> > Deucher @Nieto, David M
> >
> > Best regards,
> > Jiawei
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Sunday, May 9, 2021 11:59 PM
> > To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kees Cook
> > <keescook@chromium.org>
> > Subject: Re: [PATCH] drm/amdgpu: Align serial size in
> > drm_amdgpu_info_vbios
> >
> >> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <Jiawei.Gu@amd.com> wrote:
> >>
> >> 20 should be serial char size now instead of 16.
> >>
> >> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> >
> > Please make sure this keeps proper 64 bit alignment in the structure.
> >
> > Alex
> >
> >
> >> ---
> >> include/uapi/drm/amdgpu_drm.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/drm/amdgpu_drm.h
> >> b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da
> >> 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
> >>        __u8 vbios_pn[64];
> >>        __u32 version;
> >>        __u8 date[32];
> >> -       __u8 serial[16];
> >> +       __u8 serial[20];
> >>        __u32 dev_id;
> >>        __u32 rev_id;
> >>        __u32 sub_dev_id;
> >> --
> >> 2.17.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis>
> >> t
> >> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJ
> >> i
> >> awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e
> >> 6
> >> 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
> >> d
> >> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> >> C
> >> 1000&amp;sdata=kAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;res
> >> e
> >> rved=0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------AEDF236F3082C3A1D5776393
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Well we could add both as sysfs file(s).<br>
    <br>
    Question here is rather what is the primary use case of this and if
    the application has the necessary access permissions to the sysfs
    files?<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 10.05.21 um 15:42 schrieb Nieto,
      David M:<br>
    </div>
    <blockquote type="cite"
cite="mid:BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div>
        <div>
          <div dir="ltr" style="color: rgb(0, 0, 0); background-color:
            rgb(255, 255, 255);">
            Then the application would need to issue the ioctl and then
            open a sysfs file to get all the information it needs. It
            makes little sense from a programming perspective to add an
            incomplete interface in my opinion </div>
        </div>
        <div><br>
        </div>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b> Gu,
          JiaWei (Will) <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a><br>
          <b>Sent:</b> Monday, May 10, 2021 12:13:07 AM<br>
          <b>To:</b> Nieto, David M <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a><br>
          <b>Cc:</b> Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx
          list <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook
          <a class="moz-txt-link-rfc2396E" href="mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a>; Deng, Emily
          <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
          <b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial size in
          drm_amdgpu_info_vbios</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">[AMD Official Use Only - Internal
              Distribution Only]<br>
              <br>
              Hi David,<br>
              <br>
              What I meant is to ONLY delete the serial[16] from
              drm_amdgpu_info_vbios, not the whole struct.<br>
              <br>
              struct drm_amdgpu_info_vbios {<br>
                      __u8 name[64];<br>
                      __u32 dbdf;<br>
                      __u8 vbios_pn[64];<br>
                      __u32 version;<br>
                      __u8 date[32];<br>
                      __u8 serial[16]; // jiawei: shall we delete this<br>
                      __u32 dev_id;<br>
                      __u32 rev_id;<br>
                      __u32 sub_dev_id;<br>
                      __u32 sub_ved_id;<br>
              };<br>
              <br>
              serial[16] in drm_amdgpu_info_vbios  copied from
              adev-&gt;serial, but there's already a sysfs named
              serial_number, which exposes it already.<br>
              <br>
              static ssize_t amdgpu_device_get_serial_number(struct
              device *dev,<br>
                              struct device_attribute *attr, char *buf)<br>
              {<br>
                      struct drm_device *ddev = dev_get_drvdata(dev);<br>
                      struct amdgpu_device *adev = ddev-&gt;dev_private;<br>
              <br>
                      return snprintf(buf, PAGE_SIZE, "%s\n",
              adev-&gt;serial);<br>
              }<br>
              <br>
              Thanks,<br>
              Jiawei<br>
              <br>
              <br>
              -----Original Message-----<br>
              From: Nieto, David M <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a> <br>
              Sent: Monday, May 10, 2021 2:53 PM<br>
              To: Gu, JiaWei (Will) <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a><br>
              Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx
              list <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook
              <a class="moz-txt-link-rfc2396E" href="mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a>; Deng, Emily
              <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
              Subject: Re: [PATCH] drm/amdgpu: Align serial size in
              drm_amdgpu_info_vbios<br>
              <br>
              No, this structure contains all the details of the vbios:
              date, serial number, name, etc.<br>
              <br>
              The sysfs node only contains the vbios name string<br>
              <br>
              &gt; On May 9, 2021, at 23:33, Gu, JiaWei (Will)
              <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a> wrote:<br>
              &gt; <br>
              &gt; ﻿[AMD Official Use Only - Internal Distribution Only]<br>
              &gt; <br>
              &gt; With a second thought,<br>
              &gt; __u8 serial[16] in drm_amdgpu_info_vbios is a bit
              redundant, sysfs serial_number already exposes it.<br>
              &gt; <br>
              &gt; Is it fine to abandon it from drm_amdgpu_info_vbios
              struct? @Alex <br>
              &gt; Deucher @Nieto, David M<br>
              &gt; <br>
              &gt; Best regards,<br>
              &gt; Jiawei<br>
              &gt; <br>
              &gt; -----Original Message-----<br>
              &gt; From: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a><br>
              &gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
              &gt; To: Gu, JiaWei (Will) <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a><br>
              &gt; Cc: amd-gfx list
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook <br>
              &gt; <a class="moz-txt-link-rfc2396E" href="mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a><br>
              &gt; Subject: Re: [PATCH] drm/amdgpu: Align serial size in
              <br>
              &gt; drm_amdgpu_info_vbios<br>
              &gt; <br>
              &gt;&gt; On Sat, May 8, 2021 at 2:48 AM Jiawei Gu
              <a class="moz-txt-link-rfc2396E" href="mailto:Jiawei.Gu@amd.com">&lt;Jiawei.Gu@amd.com&gt;</a> wrote:<br>
              &gt;&gt; <br>
              &gt;&gt; 20 should be serial char size now instead of 16.<br>
              &gt;&gt; <br>
              &gt;&gt; Signed-off-by: Jiawei Gu
              <a class="moz-txt-link-rfc2396E" href="mailto:Jiawei.Gu@amd.com">&lt;Jiawei.Gu@amd.com&gt;</a><br>
              &gt; <br>
              &gt; Please make sure this keeps proper 64 bit alignment
              in the structure.<br>
              &gt; <br>
              &gt; Alex<br>
              &gt; <br>
              &gt; <br>
              &gt;&gt; ---<br>
              &gt;&gt; include/uapi/drm/amdgpu_drm.h | 2 +-<br>
              &gt;&gt; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
              &gt;&gt; <br>
              &gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h <br>
              &gt;&gt; b/include/uapi/drm/amdgpu_drm.h index
              2b487a8d2727..1c20721f90da<br>
              &gt;&gt; 100644<br>
              &gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
              &gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
              &gt;&gt; @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios
              {<br>
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
              &gt;&gt; _______________________________________________<br>
              &gt;&gt; amd-gfx mailing list<br>
              &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis"
                moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis</a><br>
              &gt;&gt; t <br>
              &gt;&gt;
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CJ<br>
              &gt;&gt; i<br>
              &gt;&gt;
              awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e<br>
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
              &gt;&gt; rved=0<br>
            </div>
          </span></font></div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------AEDF236F3082C3A1D5776393--

--===============0256640219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0256640219==--
