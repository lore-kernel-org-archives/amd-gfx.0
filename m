Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32F2C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AD2206E2
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1BXpFVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AD2206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D636F48F;
	Fri, 21 Feb 2020 15:43:46 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA03A6F48F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 15:43:44 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b17so2405803wmb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=RUx1lDa7qUvhN0WCHi9C5XcxQ2jbtMeIRhNZvPPTGlA=;
 b=I1BXpFVEB4wI2sMnRL2alRTygbn5Q8CL/Stbw67IOhhMFoaMvBeMo8T7UxVj/AP0zq
 N5pRO5/307bm2e5gH4PbWYvnt0wtviU4TPs2Z+xs4EF646iAP/HhQHfgjctdHr9S9oln
 ot6T7YXbChDD0gWopelawSYabQwA2ddCssNw3zvBbVWwp5ZmtPDzUR/6RHotaXPagWQO
 yhvkkI+4SJkykw/F2EJF0hBcpHmndCS2I+Gya74964vg8vBY3rMmgOZXdY4CmsiWWQtT
 GLk5rB2Fz62gyqunQsd0fXSuGROqTUgNQeGKslOaNczOOln4zC8ztnoi9GPWqQaav6TN
 sViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=RUx1lDa7qUvhN0WCHi9C5XcxQ2jbtMeIRhNZvPPTGlA=;
 b=AnNjvQD4FvfKtB9LLmxmuu4Hvk+/U+5sZY84Yo1aM3nbMAfBrcSlH44gcwKxZTpAFr
 VUkU9dfCdIhVYx0O2CpvL0iV0LDI1uwL9K83Rsc3yCvHdzztw9s01TWjsZSyfj2tB4vw
 +uBmi0r5Hitc5jPrVB0xnB3kBE96QEeyMOBokEY9WcHa9jyjqOaIHYDWnR+joS9S1zpv
 6GCDEsDZlW+rOpnqRj5VkE/k8a32Y3sDs1A1esUJUnUbPzFhow8YhVXbk2FKfosXsSy1
 LKnnptA8kYyASeSfWtHCYgm/mOH26Bgo9O4OFa86FfahxD/UrNxAXA45d4UdzB4qdYaA
 nrBg==
X-Gm-Message-State: APjAAAXrZg7VPXJZRXHTQQ1Vlzdk3Tsz/0amLg7go1k4S8BfvzdtaXno
 ZCqpSZs8y1y/tOStBeu3lSlqWRh7
X-Google-Smtp-Source: APXvYqwWLs3zaOg49V9I79nJtMppRAG4JCjKxZ7mdgGb2JALyfXdGxL0WXqwAFj3+eJ7jWS9A3OYFA==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr4437480wmc.119.1582299821219; 
 Fri, 21 Feb 2020 07:43:41 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y8sm4071017wma.10.2020.02.21.07.43.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Feb 2020 07:43:40 -0800 (PST)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogZGlzYWJs?=
 =?UTF-8?Q?e_GFXOFF_around_debugfs_access_to_MMIO?=
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
 <20200221143359.GF28698@jenkins-Celadon-RN>
 <DM6PR12MB393101FB6C3250020720509A84120@DM6PR12MB3931.namprd12.prod.outlook.com>
 <20200221152321.GH28698@jenkins-Celadon-RN>
 <2e56e194-dceb-8315-987e-5825ad02a143@gmail.com>
 <CH2PR12MB391225487BEB1F7F94F305EBF7120@CH2PR12MB3912.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4baecca5-199b-414c-5865-410456bc2876@gmail.com>
Date: Fri, 21 Feb 2020 16:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CH2PR12MB391225487BEB1F7F94F305EBF7120@CH2PR12MB3912.namprd12.prod.outlook.com>
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0128758219=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0128758219==
Content-Type: multipart/alternative;
 boundary="------------988A51FD2D356E857DFC318B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------988A51FD2D356E857DFC318B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Do we have a way to disable GFXOFF on the fly?

If not maybe it would be a good idea to add a separate debugfs file to 
do this.

Christian.

Am 21.02.20 um 16:39 schrieb Deucher, Alexander:
>
> [AMD Public Use]
>
>
> If we are trying to debug a reproducible hang, probably best to just 
> to disable gfxoff before messing with it to remove that as a factor.  
> Otherwise, the method included in this patch is the proper way to 
> disable/enable GFXOFF dynamically.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Friday, February 21, 2020 10:27 AM
> *To:* Huang, Ray <Ray.Huang@amd.com>; Liu, Monk <Monk.Liu@amd.com>
> *Cc:* StDenis, Tom <Tom.StDenis@amd.com>; Alex Deucher 
> <alexdeucher@gmail.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: 回复: [PATCH] drm/amd/amdgpu: disable GFXOFF around 
> debugfs access to MMIO
> Am 21.02.20 um 16:23 schrieb Huang Rui:
> > On Fri, Feb 21, 2020 at 11:18:07PM +0800, Liu, Monk wrote:
> >> Better not use KIQ, because when you use debugfs to read register 
> you usually hit a hang, and by that case KIQ probably already die
> > If CP is busy, the gfx should be in "on" state at that time, we 
> needn't use KIQ.
>
> Yeah, but how do you detect that? Do we have a way to wake up the CP
> without asking power management to do so?
>
> Cause the register debug interface is meant to be used when the ASIC is
> completed locked up. Sending messages to the SMU is not really going to
> work in that situation.
>
> Regards,
> Christian.
>
> >
> > Thanks,
> > Ray
> >
> >> -----邮件原件-----
> >> 发件人: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> 代表 Huang Rui
> >> 发送时间: 2020年2月21日 22:34
> >> 收件人: StDenis, Tom <Tom.StDenis@amd.com>
> >> 抄送: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list 
> <amd-gfx@lists.freedesktop.org>
> >> 主题: Re: [PATCH] drm/amd/amdgpu: disable GFXOFF around debugfs 
> access to MMIO
> >>
> >> On Wed, Feb 19, 2020 at 10:09:46AM -0500, Tom St Denis wrote:
> >>> I got some messages after a while:
> >>>
> >>> [  741.788564] Failed to send Message 8.
> >>> [  746.671509] Failed to send Message 8.
> >>> [  748.749673] Failed to send Message 2b.
> >>> [  759.245414] Failed to send Message 7.
> >>> [  763.216902] Failed to send Message 2a.
> >>>
> >>> Are there any additional locks that should be held?  Because some
> >>> commands like --top or --waves can do a lot of distinct read
> >>> operations (causing a lot of enable/disable calls).
> >>>
> >>> I'm going to sit on this a bit since I don't think the patch is ready
> >>> for pushing out.
> >>>
> >> How about use RREG32_KIQ and WREG32_KIQ?
> >>
> >> Thanks,
> >> Ray
> >>
> >>> Tom
> >>>
> >>> On 2020-02-19 10:07 a.m., Alex Deucher wrote:
> >>>> On Wed, Feb 19, 2020 at 10:04 AM Tom St Denis 
> <tom.stdenis@amd.com> wrote:
> >>>>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> >>>> Please add a patch description.  With that fixed:
> >>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>
> >>>>> ---
> >>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
> >>>>>    1 file changed, 3 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >>>>> index 7379910790c9..66f763300c96 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >>>>> @@ -169,6 +169,7 @@ static int 
> amdgpu_debugfs_process_reg_op(bool read, struct file *f,
> >>>>>           if (pm_pg_lock)
> >>>>> mutex_lock(&adev->pm.mutex);
> >>>>>
> >>>>> +       amdgpu_gfx_off_ctrl(adev, false);
> >>>>>           while (size) {
> >>>>>                   uint32_t value;
> >>>>>
> >>>>> @@ -192,6 +193,8 @@ static int 
> amdgpu_debugfs_process_reg_op(bool read, struct file *f,
> >>>>>           }
> >>>>>
> >>>>>    end:
> >>>>> +       amdgpu_gfx_off_ctrl(adev, true);
> >>>>> +
> >>>>>           if (use_bank) {
> >>>>> amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> >>>>> mutex_unlock(&adev->grbm_idx_mutex);
> >>>>> --
> >>>>> 2.24.1
> >>>>>
> >>>>> _______________________________________________
> >>>>> amd-gfx mailing list
> >>>>> amd-gfx@lists.freedesktop.org
> >>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> >>>>> lists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7
> >>>>> C01%7Cmonk.liu%40amd.com%7Cba45efb26c0240ed036f08d7b6db20aa%7C3dd8
> >>>>> 961fe4884e608e11a82d994e183d%7C0%7C0%7C637178924605524378&amp;sdat
> >>>>> a=%2FyHkvYU5T%2F4iFxRexsg%2BIdm7sDzyXbjzNpHUGCO7h4k%3D&amp;reserve
> >>>>> d=0
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> >>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmo
> >>> nk.liu%40amd.com%7Cba45efb26c0240ed036f08d7b6db20aa%7C3dd8961fe4884e60
> >>> 8e11a82d994e183d%7C0%7C0%7C637178924605524378&amp;sdata=%2FyHkvYU5T%2F
> >>> 4iFxRexsg%2BIdm7sDzyXbjzNpHUGCO7h4k%3D&amp;reserved=0
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;reserved=0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;reserved=0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;reserved=0


--------------988A51FD2D356E857DFC318B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Do we have a way to disable GFXOFF on
      the fly?<br>
      <br>
      If not maybe it would be a good idea to add a separate debugfs
      file to do this.<br>
      <br>
      Christian.<br>
      <br>
      Am 21.02.20 um 16:39 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:CH2PR12MB391225487BEB1F7F94F305EBF7120@CH2PR12MB3912.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p
        style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;"
        align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          If we are trying to debug a reproducible hang, probably best
          to just to disable gfxoff before messing with it to remove
          that as a factor.  Otherwise, the method included in this
          patch is the proper way to disable/enable GFXOFF dynamically.</div>
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
            behalf of Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Friday, February 21, 2020 10:27 AM<br>
            <b>To:</b> Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>; Liu, Monk
            <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a><br>
            <b>Cc:</b> StDenis, Tom <a class="moz-txt-link-rfc2396E" href="mailto:Tom.StDenis@amd.com">&lt;Tom.StDenis@amd.com&gt;</a>; Alex
            Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>; amd-gfx list
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Subject:</b> Re: 回复: [PATCH] drm/amd/amdgpu: disable
            GFXOFF around debugfs access to MMIO</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">Am 21.02.20 um 16:23 schrieb Huang
                Rui:<br>
                &gt; On Fri, Feb 21, 2020 at 11:18:07PM +0800, Liu, Monk
                wrote:<br>
                &gt;&gt; Better not use KIQ, because when you use
                debugfs to read register you usually hit a hang, and by
                that case KIQ probably already die<br>
                &gt; If CP is busy, the gfx should be in "on" state at
                that time, we needn't use KIQ.<br>
                <br>
                Yeah, but how do you detect that? Do we have a way to
                wake up the CP <br>
                without asking power management to do so?<br>
                <br>
                Cause the register debug interface is meant to be used
                when the ASIC is <br>
                completed locked up. Sending messages to the SMU is not
                really going to <br>
                work in that situation.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                &gt;<br>
                &gt; Thanks,<br>
                &gt; Ray<br>
                &gt;<br>
                &gt;&gt; -----邮件原件-----<br>
                &gt;&gt; 发件人: amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> 代表 Huang
                Rui<br>
                &gt;&gt; 发送时间: 2020年2月21日 22:34<br>
                &gt;&gt; 收件人: StDenis, Tom <a class="moz-txt-link-rfc2396E" href="mailto:Tom.StDenis@amd.com">&lt;Tom.StDenis@amd.com&gt;</a><br>
                &gt;&gt; 抄送: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>;
                amd-gfx list <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                &gt;&gt; 主题: Re: [PATCH] drm/amd/amdgpu: disable GFXOFF
                around debugfs access to MMIO<br>
                &gt;&gt;<br>
                &gt;&gt; On Wed, Feb 19, 2020 at 10:09:46AM -0500, Tom
                St Denis wrote:<br>
                &gt;&gt;&gt; I got some messages after a while:<br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; [  741.788564] Failed to send Message 8.<br>
                &gt;&gt;&gt; [  746.671509] Failed to send Message 8.<br>
                &gt;&gt;&gt; [  748.749673] Failed to send Message 2b.<br>
                &gt;&gt;&gt; [  759.245414] Failed to send Message 7.<br>
                &gt;&gt;&gt; [  763.216902] Failed to send Message 2a.<br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; Are there any additional locks that should
                be held?  Because some<br>
                &gt;&gt;&gt; commands like --top or --waves can do a lot
                of distinct read<br>
                &gt;&gt;&gt; operations (causing a lot of enable/disable
                calls).<br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; I'm going to sit on this a bit since I
                don't think the patch is ready<br>
                &gt;&gt;&gt; for pushing out.<br>
                &gt;&gt;&gt;<br>
                &gt;&gt; How about use RREG32_KIQ and WREG32_KIQ?<br>
                &gt;&gt;<br>
                &gt;&gt; Thanks,<br>
                &gt;&gt; Ray<br>
                &gt;&gt;<br>
                &gt;&gt;&gt; Tom<br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; On 2020-02-19 10:07 a.m., Alex Deucher
                wrote:<br>
                &gt;&gt;&gt;&gt; On Wed, Feb 19, 2020 at 10:04 AM Tom St
                Denis <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis@amd.com">&lt;tom.stdenis@amd.com&gt;</a> wrote:<br>
                &gt;&gt;&gt;&gt;&gt; Signed-off-by: Tom St Denis
                <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis@amd.com">&lt;tom.stdenis@amd.com&gt;</a><br>
                &gt;&gt;&gt;&gt; Please add a patch description.  With
                that fixed:<br>
                &gt;&gt;&gt;&gt; Reviewed-by: Alex Deucher
                <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
                &gt;&gt;&gt;&gt;<br>
                &gt;&gt;&gt;&gt;&gt; ---<br>
                &gt;&gt;&gt;&gt;&gt;   
                drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++<br>
                &gt;&gt;&gt;&gt;&gt;    1 file changed, 3 insertions(+)<br>
                &gt;&gt;&gt;&gt;&gt;<br>
                &gt;&gt;&gt;&gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                &gt;&gt;&gt;&gt;&gt;
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                &gt;&gt;&gt;&gt;&gt; index 7379910790c9..66f763300c96
                100644<br>
                &gt;&gt;&gt;&gt;&gt; ---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                &gt;&gt;&gt;&gt;&gt; +++
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                &gt;&gt;&gt;&gt;&gt; @@ -169,6 +169,7 @@ static int 
                amdgpu_debugfs_process_reg_op(bool read, struct file *f,<br>
                &gt;&gt;&gt;&gt;&gt;           if (pm_pg_lock)<br>
                &gt;&gt;&gt;&gt;&gt;                  
                mutex_lock(&amp;adev-&gt;pm.mutex);<br>
                &gt;&gt;&gt;&gt;&gt;<br>
                &gt;&gt;&gt;&gt;&gt; +       amdgpu_gfx_off_ctrl(adev,
                false);<br>
                &gt;&gt;&gt;&gt;&gt;           while (size) {<br>
                &gt;&gt;&gt;&gt;&gt;                   uint32_t value;<br>
                &gt;&gt;&gt;&gt;&gt;<br>
                &gt;&gt;&gt;&gt;&gt; @@ -192,6 +193,8 @@ static int 
                amdgpu_debugfs_process_reg_op(bool read, struct file *f,<br>
                &gt;&gt;&gt;&gt;&gt;           }<br>
                &gt;&gt;&gt;&gt;&gt;<br>
                &gt;&gt;&gt;&gt;&gt;    end:<br>
                &gt;&gt;&gt;&gt;&gt; +       amdgpu_gfx_off_ctrl(adev,
                true);<br>
                &gt;&gt;&gt;&gt;&gt; +<br>
                &gt;&gt;&gt;&gt;&gt;           if (use_bank) {<br>
                &gt;&gt;&gt;&gt;&gt;                  
                amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,
                0xffffffff);<br>
                &gt;&gt;&gt;&gt;&gt;                  
                mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
                &gt;&gt;&gt;&gt;&gt; --<br>
                &gt;&gt;&gt;&gt;&gt; 2.24.1<br>
                &gt;&gt;&gt;&gt;&gt;<br>
                &gt;&gt;&gt;&gt;&gt;
                _______________________________________________<br>
                &gt;&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
                &gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt;&gt;&gt;&gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F"
                  moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F</a><br>
                &gt;&gt;&gt;&gt;&gt;
                lists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7<br>
                &gt;&gt;&gt;&gt;&gt;
                C01%7Cmonk.liu%40amd.com%7Cba45efb26c0240ed036f08d7b6db20aa%7C3dd8<br>
                &gt;&gt;&gt;&gt;&gt;
                961fe4884e608e11a82d994e183d%7C0%7C0%7C637178924605524378&amp;amp;sdat<br>
                &gt;&gt;&gt;&gt;&gt;
                a=%2FyHkvYU5T%2F4iFxRexsg%2BIdm7sDzyXbjzNpHUGCO7h4k%3D&amp;amp;reserve<br>
                &gt;&gt;&gt;&gt;&gt; d=0<br>
                &gt;&gt;&gt;
                _______________________________________________<br>
                &gt;&gt;&gt; amd-gfx mailing list<br>
                &gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt;&gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist"
                  moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist</a><br>
                &gt;&gt;&gt;
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cmo<br>
                &gt;&gt;&gt;
                nk.liu%40amd.com%7Cba45efb26c0240ed036f08d7b6db20aa%7C3dd8961fe4884e60<br>
                &gt;&gt;&gt;
8e11a82d994e183d%7C0%7C0%7C637178924605524378&amp;amp;sdata=%2FyHkvYU5T%2F<br>
                &gt;&gt;&gt;
                4iFxRexsg%2BIdm7sDzyXbjzNpHUGCO7h4k%3D&amp;amp;reserved=0<br>
                &gt;&gt; _______________________________________________<br>
                &gt;&gt; amd-gfx mailing list<br>
                &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;amp;reserved=0"
                  moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;amp;reserved=0</a><br>
                &gt; _______________________________________________<br>
                &gt; amd-gfx mailing list<br>
                &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;amp;reserved=0"
                  moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;amp;reserved=0</a><br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;amp;reserved=0"
                  moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7Cf3762304925b4019bfed08d7b6e287e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178957179179431&amp;amp;sdata=bY7V%2BKOF3gYu4ITGCKgAiRvXUvxPcwsz2zsEJDns3jI%3D&amp;amp;reserved=0</a><br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------988A51FD2D356E857DFC318B--

--===============0128758219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0128758219==--
