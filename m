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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA59C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE83616EA
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE83616EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F65B6E061;
	Tue, 11 May 2021 07:51:12 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B496E061
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 07:51:10 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id t4so28439144ejo.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=kEexEROmUeY2hvSY9T+vd0LfQT6mRhTBvk5FMSoPzTo=;
 b=DJ0SoJCyxODhrUliHAejqIJdOR/Iq/KWEgtRyrRfwF1Y3bMV/BvJWcTmRK/krVBlXH
 i05xccAmqmaGDIYrWcyX0Fx1X/xVABhvcUgFYxPPvl3s8ZS8AtCW3+MgWPxgq+XashaX
 fP2g4xLC8sRgoJcZf3WW7YVu/CRnzG0hJIQ/kQ01D5h69zfBWn390IkUiIKprx7XT2Sq
 y/10yFdhNq1EZ73KMmdLyolawi/kkpp/BdiFNLB4YELB9Unc1HIwCJg22eKZdkhtF9SF
 zdBcBzLyibdc8+j0WddWe7geJ3HmlcJRF2vkR9Cq/aeEv4ZK89dWJX6HbP8ZEuswyrAm
 Icyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=kEexEROmUeY2hvSY9T+vd0LfQT6mRhTBvk5FMSoPzTo=;
 b=tyRqc6UuEfZ1xXbiW+kyO1i9YwMR4mcG87trcb7LMVrkEPS8TRlx5BoP5j6yoJD8p1
 IwuD/Tgml07Lp4ZTSSDLEMzGwYRB0dasVADveVS6qZqlg7hHtCA4dzp/at1fdi43FHol
 njjdBlfGSxKB+597ESO+0as+Xk9rSe8soc9k7tWpufLfPp2szehgg6fTEaZsZgy9KvLg
 kiE5UxapQkNAN817GCOmPDvRAVGcretbppB/UAU7nHqZwfCO+BW6B9QLajLMomAzuX2n
 6OwmUWfcW4IXwdtffHs4kuUPyDoajEOWVdLYFbUwlm4UDn/oV63uV6k+ERKiLnkISMvT
 ocog==
X-Gm-Message-State: AOAM533VkUJVRh5GLDIjtafhWIGy7YGb0DezuaLGBMU7bEXIcX4EVUkl
 Ww4JU/z38L4CpZBIb9Rt+it8qoKKpY8=
X-Google-Smtp-Source: ABdhPJyTi3CNYhWz+VNcJVH8nVu+QWqY+BERtAvvN9VXmd0/M+nENVZOyc1cLybkeN/dezsHM9REZw==
X-Received: by 2002:a17:906:d0c5:: with SMTP id
 bq5mr30625046ejb.340.1620719469652; 
 Tue, 11 May 2021 00:51:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e?
 ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
 by smtp.gmail.com with ESMTPSA id x18sm11406673eju.45.2021.05.11.00.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 00:51:09 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
To: "Nieto, David M" <David.Nieto@amd.com>,
 "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <88e868eb-347b-611b-8d88-ba8d9d61c23b@gmail.com>
Date: Tue, 11 May 2021 09:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
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
Content-Type: multipart/mixed; boundary="===============0650776844=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0650776844==
Content-Type: multipart/alternative;
 boundary="------------ABB641F1C20CC45E39A4AE46"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------ABB641F1C20CC45E39A4AE46
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Marek and other userspace folks need to decide that.

Basic question here is if Mesa is already accessing sysfs nodes for 
OpenGL or RADV. If that is the case then we should probably expose the 
information there as well.

If that isn't the case (which I think it is) then we should implement it 
as IOCTL.

Regards,
Christian.

Am 10.05.21 um 22:19 schrieb Nieto, David M:
>
> One of the primary usecases is to add this information to the renderer 
> string, I am not sure if there are other cases of UMD drivers 
> accessing sysfs nodes, but I think if we think permissions, if a 
> client is authenticated and opens the render device then it can use 
> the IOCTL, it is unclear to me we can make a such an assumption for 
> sysfs nodes…
>
> I think there is value in having both tbh.
>
> Regards,
>
> David
>
> *From: *Christian König <ckoenig.leichtzumerken@gmail.com>
> *Date: *Monday, May 10, 2021 at 6:48 AM
> *To: *"Nieto, David M" <David.Nieto@amd.com>, "Gu, JiaWei (Will)" 
> <JiaWei.Gu@amd.com>
> *Cc: *Alex Deucher <alexdeucher@gmail.com>, "Deng, Emily" 
> <Emily.Deng@amd.com>, Kees Cook <keescook@chromium.org>, amd-gfx list 
> <amd-gfx@lists.freedesktop.org>
> *Subject: *Re: [PATCH] drm/amdgpu: Align serial size in 
> drm_amdgpu_info_vbios
>
> Well we could add both as sysfs file(s).
>
> Question here is rather what is the primary use case of this and if 
> the application has the necessary access permissions to the sysfs files?
>
> Regards,
> Christian.
>
> Am 10.05.21 um 15:42 schrieb Nieto, David M:
>
>     Then the application would need to issue the ioctl and then open a
>     sysfs file to get all the information it needs. It makes little
>     sense from a programming perspective to add an incomplete
>     interface in my opinion
>
>     ------------------------------------------------------------------------
>
>     *From:*Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>     <mailto:JiaWei.Gu@amd.com>
>     *Sent:* Monday, May 10, 2021 12:13:07 AM
>     *To:* Nieto, David M <David.Nieto@amd.com>
>     <mailto:David.Nieto@amd.com>
>     *Cc:* Alex Deucher <alexdeucher@gmail.com>
>     <mailto:alexdeucher@gmail.com>; amd-gfx list
>     <amd-gfx@lists.freedesktop.org>
>     <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>     <keescook@chromium.org> <mailto:keescook@chromium.org>; Deng,
>     Emily <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>     *Subject:* RE: [PATCH] drm/amdgpu: Align serial size in
>     drm_amdgpu_info_vbios
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     Hi David,
>
>     What I meant is to ONLY delete the serial[16] from
>     drm_amdgpu_info_vbios, not the whole struct.
>
>     struct drm_amdgpu_info_vbios {
>             __u8 name[64];
>             __u32 dbdf;
>             __u8 vbios_pn[64];
>             __u32 version;
>             __u8 date[32];
>             __u8 serial[16]; // jiawei: shall we delete this
>             __u32 dev_id;
>             __u32 rev_id;
>             __u32 sub_dev_id;
>             __u32 sub_ved_id;
>     };
>
>     serial[16] in drm_amdgpu_info_vbios  copied from adev->serial, but
>     there's already a sysfs named serial_number, which exposes it already.
>
>     static ssize_t amdgpu_device_get_serial_number(struct device *dev,
>                     struct device_attribute *attr, char *buf)
>     {
>             struct drm_device *ddev = dev_get_drvdata(dev);
>             struct amdgpu_device *adev = ddev->dev_private;
>
>             return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
>     }
>
>     Thanks,
>     Jiawei
>
>
>     -----Original Message-----
>     From: Nieto, David M <David.Nieto@amd.com>
>     <mailto:David.Nieto@amd.com>
>     Sent: Monday, May 10, 2021 2:53 PM
>     To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com> <mailto:JiaWei.Gu@amd.com>
>     Cc: Alex Deucher <alexdeucher@gmail.com>
>     <mailto:alexdeucher@gmail.com>; amd-gfx list
>     <amd-gfx@lists.freedesktop.org>
>     <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>     <keescook@chromium.org> <mailto:keescook@chromium.org>; Deng,
>     Emily <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>     Subject: Re: [PATCH] drm/amdgpu: Align serial size in
>     drm_amdgpu_info_vbios
>
>     No, this structure contains all the details of the vbios: date,
>     serial number, name, etc.
>
>     The sysfs node only contains the vbios name string
>
>     > On May 9, 2021, at 23:33, Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>     <mailto:JiaWei.Gu@amd.com> wrote:
>     >
>     > [AMD Official Use Only - Internal Distribution Only]
>     >
>     > With a second thought,
>     > __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant,
>     sysfs serial_number already exposes it.
>     >
>     > Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex
>     > Deucher @Nieto, David M
>     >
>     > Best regards,
>     > Jiawei
>     >
>     > -----Original Message-----
>     > From: Alex Deucher <alexdeucher@gmail.com>
>     <mailto:alexdeucher@gmail.com>
>     > Sent: Sunday, May 9, 2021 11:59 PM
>     > To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com> <mailto:JiaWei.Gu@amd.com>
>     > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>     <mailto:amd-gfx@lists.freedesktop.org>; Kees Cook
>     > <keescook@chromium.org> <mailto:keescook@chromium.org>
>     > Subject: Re: [PATCH] drm/amdgpu: Align serial size in
>     > drm_amdgpu_info_vbios
>     >
>     >> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <Jiawei.Gu@amd.com>
>     <mailto:Jiawei.Gu@amd.com> wrote:
>     >>
>     >> 20 should be serial char size now instead of 16.
>     >>
>     >> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
>     <mailto:Jiawei.Gu@amd.com>
>     >
>     > Please make sure this keeps proper 64 bit alignment in the
>     structure.
>     >
>     > Alex
>     >
>     >
>     >> ---
>     >> include/uapi/drm/amdgpu_drm.h | 2 +-
>     >> 1 file changed, 1 insertion(+), 1 deletion(-)
>     >>
>     >> diff --git a/include/uapi/drm/amdgpu_drm.h
>     >> b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da
>     >> 100644
>     >> --- a/include/uapi/drm/amdgpu_drm.h
>     >> +++ b/include/uapi/drm/amdgpu_drm.h
>     >> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
>     >>        __u8 vbios_pn[64];
>     >>        __u32 version;
>     >>        __u8 date[32];
>     >> -       __u8 serial[16];
>     >> +       __u8 serial[20];
>     >>        __u32 dev_id;
>     >>        __u32 rev_id;
>     >>        __u32 sub_dev_id;
>     >> --
>     >> 2.17.1
>     >>
>     >> _______________________________________________
>     >> amd-gfx mailing list
>     >> amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     >>
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis>
>     >> t
>     >>
>     s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJ
>     >> i
>     >>
>     awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e
>     >> 6
>     >>
>     08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
>     >> d
>     >>
>     8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>     >> C
>     >>
>     1000&amp;sdata=kAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;res
>     >> e
>     >> rved=0
>
>
>
>     _______________________________________________
>
>     amd-gfx mailing list
>
>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7CDavid.Nieto%40amd.com%7C3c0071a8a2a74127027408d913ba53e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637562513264718308%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=g11aunC78b48N19Q%2FFXJBK%2B2Z0PZBWdqp%2FzhsPiqQ8Q%3D&reserved=0>
>
>
>


--------------ABB641F1C20CC45E39A4AE46
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Marek and other userspace folks need to decide that.<br>
    <br>
    Basic question here is if Mesa is already accessing sysfs nodes for
    OpenGL or RADV. If that is the case then we should probably expose
    the information there as well.<br>
    <br>
    If that isn't the case (which I think it is) then we should
    implement it as IOCTL.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 10.05.21 um 22:19 schrieb Nieto,
      David M:<br>
    </div>
    <blockquote type="cite"
      cite="mid:447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">One of the primary usecases is to add this
          information to the renderer string, I am not sure if there are
          other cases of UMD drivers accessing sysfs nodes, but I think
          if we think permissions, if a client is authenticated and
          opens the render device then it can use the IOCTL, it is
          unclear to me we can make a such an assumption for sysfs
          nodes…<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">I think there is value in having both tbh.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Regards,<o:p></o:p></p>
        <p class="MsoNormal">David<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div style="border:none;border-top:solid #B5C4DF
          1.0pt;padding:3.0pt 0in 0in 0in">
          <p class="MsoNormal"><b><span
                style="font-size:12.0pt;color:black">From: </span></b><span
              style="font-size:12.0pt;color:black">Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
              <b>Date: </b>Monday, May 10, 2021 at 6:48 AM<br>
              <b>To: </b>"Nieto, David M" <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a>,
              "Gu, JiaWei (Will)" <a class="moz-txt-link-rfc2396E" href="mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a><br>
              <b>Cc: </b>Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>,
              "Deng, Emily" <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>, Kees Cook
              <a class="moz-txt-link-rfc2396E" href="mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a>, amd-gfx list
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject: </b>Re: [PATCH] drm/amdgpu: Align serial size
              in drm_amdgpu_info_vbios<o:p></o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><o:p> </o:p></p>
        </div>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Well we could
          add both as sysfs file(s).<br>
          <br>
          Question here is rather what is the primary use case of this
          and if the application has the necessary access permissions to
          the sysfs files?<br>
          <br>
          Regards,<br>
          Christian.<o:p></o:p></p>
        <div>
          <p class="MsoNormal">Am 10.05.21 um 15:42 schrieb Nieto, David
            M:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <div>
            <div>
              <div>
                <p class="MsoNormal" style="background:white"><span
                    style="color:black">Then the application would need
                    to issue the ioctl and then open a sysfs file to get
                    all the information it needs. It makes little sense
                    from a programming perspective to add an incomplete
                    interface in my opinion <o:p></o:p></span></p>
              </div>
            </div>
            <div>
              <p class="MsoNormal"><o:p> </o:p></p>
            </div>
          </div>
          <div class="MsoNormal" style="text-align:center"
            align="center">
            <hr width="100%" size="0" align="center">
          </div>
          <div id="divRplyFwdMsg">
            <p class="MsoNormal"><b><span style="color:black">From:</span></b><span
                style="color:black"> Gu, JiaWei (Will)
                <a href="mailto:JiaWei.Gu@amd.com"
                  moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                <b>Sent:</b> Monday, May 10, 2021 12:13:07 AM<br>
                <b>To:</b> Nieto, David M <a
                  href="mailto:David.Nieto@amd.com"
                  moz-do-not-send="true">&lt;David.Nieto@amd.com&gt;</a><br>
                <b>Cc:</b> Alex Deucher <a
                  href="mailto:alexdeucher@gmail.com"
                  moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a>;
                amd-gfx list
                <a href="mailto:amd-gfx@lists.freedesktop.org"
                  moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                Kees Cook
                <a href="mailto:keescook@chromium.org"
                  moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a>;
                Deng, Emily <a href="mailto:Emily.Deng@amd.com"
                  moz-do-not-send="true">
                  &lt;Emily.Deng@amd.com&gt;</a><br>
                <b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial
                size in drm_amdgpu_info_vbios</span>
              <o:p></o:p></p>
            <div>
              <p class="MsoNormal"> <o:p></o:p></p>
            </div>
          </div>
          <div>
            <div>
              <p class="MsoNormal">[AMD Official Use Only - Internal
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
                                struct device_attribute *attr, char
                *buf)<br>
                {<br>
                        struct drm_device *ddev = dev_get_drvdata(dev);<br>
                        struct amdgpu_device *adev =
                ddev-&gt;dev_private;<br>
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
                From: Nieto, David M <a
                  href="mailto:David.Nieto@amd.com"
                  moz-do-not-send="true">&lt;David.Nieto@amd.com&gt;</a>
                <br>
                Sent: Monday, May 10, 2021 2:53 PM<br>
                To: Gu, JiaWei (Will) <a
                  href="mailto:JiaWei.Gu@amd.com" moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                Cc: Alex Deucher <a href="mailto:alexdeucher@gmail.com"
                  moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a>;
                amd-gfx list
                <a href="mailto:amd-gfx@lists.freedesktop.org"
                  moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                Kees Cook
                <a href="mailto:keescook@chromium.org"
                  moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a>;
                Deng, Emily <a href="mailto:Emily.Deng@amd.com"
                  moz-do-not-send="true">
                  &lt;Emily.Deng@amd.com&gt;</a><br>
                Subject: Re: [PATCH] drm/amdgpu: Align serial size in
                drm_amdgpu_info_vbios<br>
                <br>
                No, this structure contains all the details of the
                vbios: date, serial number, name, etc.<br>
                <br>
                The sysfs node only contains the vbios name string<br>
                <br>
                &gt; On May 9, 2021, at 23:33, Gu, JiaWei (Will) <a
                  href="mailto:JiaWei.Gu@amd.com" moz-do-not-send="true">
                  &lt;JiaWei.Gu@amd.com&gt;</a> wrote:<br>
                &gt; <br>
                &gt; [AMD Official Use Only - Internal Distribution
                Only]<br>
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
                &gt; From: Alex Deucher <a
                  href="mailto:alexdeucher@gmail.com"
                  moz-do-not-send="true">&lt;alexdeucher@gmail.com&gt;</a><br>
                &gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
                &gt; To: Gu, JiaWei (Will) <a
                  href="mailto:JiaWei.Gu@amd.com" moz-do-not-send="true">&lt;JiaWei.Gu@amd.com&gt;</a><br>
                &gt; Cc: amd-gfx list <a
                  href="mailto:amd-gfx@lists.freedesktop.org"
                  moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                Kees Cook
                <br>
                &gt; <a href="mailto:keescook@chromium.org"
                  moz-do-not-send="true">&lt;keescook@chromium.org&gt;</a><br>
                &gt; Subject: Re: [PATCH] drm/amdgpu: Align serial size
                in <br>
                &gt; drm_amdgpu_info_vbios<br>
                &gt; <br>
                &gt;&gt; On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <a
                  href="mailto:Jiawei.Gu@amd.com" moz-do-not-send="true">&lt;Jiawei.Gu@amd.com&gt;</a>
                wrote:<br>
                &gt;&gt; <br>
                &gt;&gt; 20 should be serial char size now instead of
                16.<br>
                &gt;&gt; <br>
                &gt;&gt; Signed-off-by: Jiawei Gu <a
                  href="mailto:Jiawei.Gu@amd.com" moz-do-not-send="true">&lt;Jiawei.Gu@amd.com&gt;</a><br>
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
                &gt;&gt; _______________________________________________<br>
                &gt;&gt; amd-gfx mailing list<br>
                &gt;&gt; <a href="mailto:amd-gfx@lists.freedesktop.org"
                  moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
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
                &gt;&gt; rved=0<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"><br>
            <br>
            <o:p></o:p></p>
          <pre>_______________________________________________<o:p></o:p></pre>
          <pre>amd-gfx mailing list<o:p></o:p></pre>
          <pre><a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
          <pre><a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CDavid.Nieto%40amd.com%7C3c0071a8a2a74127027408d913ba53e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637562513264718308%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=g11aunC78b48N19Q%2FFXJBK%2B2Z0PZBWdqp%2FzhsPiqQ8Q%3D&amp;reserved=0" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></pre>
        </blockquote>
        <p class="MsoNormal"><br>
          <br>
          <o:p></o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------ABB641F1C20CC45E39A4AE46--

--===============0650776844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0650776844==--
