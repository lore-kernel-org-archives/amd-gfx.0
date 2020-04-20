Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF90C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 08:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AA4206D5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 08:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/ihteRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AA4206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED3989D61;
	Mon, 20 Apr 2020 08:02:54 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C74E89C27
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 08:02:53 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id k13so9691944wrw.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=QfpL/J955i+zFeMUowZ7vSByntA/+V/UaIxXRCzG5UE=;
 b=O/ihteRX1xPf89fKxvlJSM7098zhSQkecREpo6OpOzWMeBrHcrFwozcz8vaoRC5+ew
 o5enkO6jTWnpYDi5KDWJgJ1H9bqRazwqblIuwcP9bl81A5ExbrR+H1GuZ3amajKBGVvR
 9D63gluj0RJ0f7e2eK1W5BG/JHM2Voyh9CAHbhgsWkrcaU4d7Gxo/YlCSl/AcLaWdskq
 I+RqiTe1Un6wfSaNyqQnXBAo9jyVbeF+GmCHWDchJdx64IZbvsS9xxDDlq0/3Fl+4sAF
 HxvMwxeCJo+4AFMAjQWF+lkv57QgSdfM2zOYGRh8Wryrc7We7tiEcDOEyuamDKtLuEmO
 zZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=QfpL/J955i+zFeMUowZ7vSByntA/+V/UaIxXRCzG5UE=;
 b=LqN2F19naw+Vekv7U/TSJqOOLRTMv3dtgVskH0he45f+D3+Bs3+CGdKcyAz+8OJvyC
 wKv+6xFJNxehmtRru8gEzPYat2a1sTHZA/QqeDsDo37L13L5nxLNXs0QmIktpThx9QDY
 8VOJMCVFLmcqcJNbjY3RmtL50iCAj3vs6PP8HXK2HRBpL3SMTHIF0L9YzyTdtE1vgFMj
 P3o5o9R5Wa7femj4Xz/Mjr1C0m7mT8+noAmWTzTUC8+1Qp6fGDdmHjwXkqAAsIOgZx7y
 ytNgwZLUxIZ49kuXDj2CO4zWtWM1UT7j7YyG+s9V6BSitHR028BawPN+/GO25ATZGoqN
 W4FQ==
X-Gm-Message-State: AGi0PuZo0IUEDAi1pQptuToQYXPxxTM64GVtXeJIS3BBh98Bloh+YabR
 bouhFEXF5tinkFy7VQikptsPnGc1
X-Google-Smtp-Source: APiQypKnT1XIqsjWzjTHuhIkFwjvJ/udmXGGMDcyEY69f0sfw4ddgezWgv3U/kc6Q47gLHqFAM9qCA==
X-Received: by 2002:a5d:5224:: with SMTP id i4mr17317848wra.1.1587369771301;
 Mon, 20 Apr 2020 01:02:51 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z76sm398275wmc.9.2020.04.20.01.02.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Apr 2020 01:02:50 -0700 (PDT)
Subject: Re: why we need to do infinite RLC_SPM register setting during VM
 flush
To: "Liu, Monk" <Monk.Liu@amd.com>, "He, Jacob" <Jacob.He@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <DM5PR12MB17084F1816AA6ABFC45C91F784D40@DM5PR12MB1708.namprd12.prod.outlook.com>
 <CY4PR12MB128656A17D834BB70EC690719BD40@CY4PR12MB1286.namprd12.prod.outlook.com>
 <DM5PR12MB1708E9E86CD1A92C54A1969284D40@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ebfaebcb-cb98-3133-4578-eab629cc481d@gmail.com>
Date: Mon, 20 Apr 2020 10:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB1708E9E86CD1A92C54A1969284D40@DM5PR12MB1708.namprd12.prod.outlook.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1134250937=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1134250937==
Content-Type: multipart/alternative;
 boundary="------------DDCB3149596D52AD67585E1F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DDCB3149596D52AD67585E1F
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

I would also prefer to update the SPM VMID register using PM4 packets 
instead of the current handling.

Regards,
Christian.

Am 20.04.20 um 09:50 schrieb Liu, Monk:
>
> I just try to explain what I want to do here, no real patch formalized 
> yet
>
> _____________________________________
>
> Monk Liu|GPU Virtualization Team |AMD
>
> sig-cloud-gpu
>
> *From:* He, Jacob <Jacob.He@amd.com>
> *Sent:* Monday, April 20, 2020 3:45 PM
> *To:* Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org
> *Subject:* Re: why we need to do infinite RLC_SPM register setting 
> during VM flush
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Do you miss a file which adds spm_updatedto vm structure?
>
> ------------------------------------------------------------------------
>
> *From:*Liu, Monk <Monk.Liu@amd.com <mailto:Monk.Liu@amd.com>>
> *Sent:* Monday, April 20, 2020 3:32 PM
> *To:* He, Jacob <Jacob.He@amd.com <mailto:Jacob.He@amd.com>>; Koenig, 
> Christian <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>
> *Cc:* amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* why we need to do infinite RLC_SPM register setting during 
> VM flush
>
> Hi Jaco & Christian
>
> As titled , check below patch:
>
> commit 10790a09ea584cc832353a5c2a481012e5e31a13
>
> Author: Jacob He <jacob.he@amd.com <mailto:jacob.he@amd.com>>
>
> Date:   Fri Feb 28 20:24:41 2020 +0800
>
>     drm/amdgpu: Update SPM_VMID with the job's vmid when application 
> reserves the vmid
>
>     SPM access the video memory according to SPM_VMID. It should be 
> updated
>
>     with the job's vmid right before the job is scheduled. SPM_VMID is a
>
>     global resource
>
>     Change-Id: Id3881908960398f87e7c95026a54ff83ff826700
>
>     Signed-off-by: Jacob He <jacob.he@amd.com <mailto:jacob.he@amd.com>>
>
>     Reviewed-by: Christian König <christian.koenig@amd.com 
> <mailto:christian.koenig@amd.com>>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
> index 6e6fc8c..ba2236a 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
> @@ -1056,8 +1056,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
> struct amdgpu_job *job,
>
>         struct dma_fence *fence = NULL;
>
>         bool pasid_mapping_needed = false;
>
>         unsigned patch_offset = 0;
>
> +       bool update_spm_vmid_needed = (job->vm && 
> (job->vm->reserved_vmid[vmhub] != NULL));
>
>         int r;
>
> +       if (update_spm_vmid_needed && 
> adev->gfx.rlc.funcs->update_spm_vmid)
>
> + adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>
> +
>
>         if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>
>                 gds_switch_needed = true;
>
>                 vm_flush_needed = true;
>
> this update_spm_vmid() looks an completely overkill to me, we only 
> need to do it once for its VM …
>
> in SRIOV the register reading/writing for update_spm_vmid() is now 
> carried by KIQ thus there is too much burden on KIQ for such 
> unnecessary jobs …
>
> I want to change it to only do it once per VM, like:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
> index 6e6fc8c..ba2236a 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
> @@ -1056,8 +1056,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
> struct amdgpu_job *job,
>
>         struct dma_fence *fence = NULL;
>
>        bool pasid_mapping_needed = false;
>
>         unsigned patch_offset = 0;
>
> +       bool update_spm_vmid_needed = (job->vm && 
> (job->vm->reserved_vmid[vmhub] != NULL));
>
>         int r;
>
> +       if (update_spm_vmid_needed && 
> adev->gfx.rlc.funcs->update_spm_vmid &&  !vm->spm_updated) {
>
> + adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>
> +               vm->spm_updated = true;
>
> +       }
>
>         if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>
>                 gds_switch_needed = true;
>
>                 vm_flush_needed = true;
>
> what do you think ?
>
> P.S.: the best way is to let GFX ring itself to do the 
> update_spm_vmid() instead of let CPU doing it, e.g.: we put more PM4 
> command in VM-FLUSH packets ….
>
> But I prefer the simple way first like I demonstrated above
>
> _____________________________________
>
> Monk Liu|GPU Virtualization Team |AMD
>
> sig-cloud-gpu
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------DDCB3149596D52AD67585E1F
Content-Type: multipart/related;
 boundary="------------4A76C546A249D634B2B86D9A"


--------------4A76C546A249D634B2B86D9A
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">I would also prefer to update the SPM
      VMID register using PM4 packets instead of the current handling.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 20.04.20 um 09:50 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB1708E9E86CD1A92C54A1969284D40@DM5PR12MB1708.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.xmsohyperlink
	{mso-style-name:x_msohyperlink;
	color:#0563C1;
	text-decoration:underline;}
span.xmsohyperlinkfollowed
	{mso-style-name:x_msohyperlinkfollowed;
	color:#954F72;
	text-decoration:underline;}
span.xemailstyle17
	{mso-style-name:x_emailstyle17;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">I just try to explain what I want to do
          here, no real patch formalized yet
          <o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <p class="MsoNormal">_____________________________________<o:p></o:p></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;color:black;background:white">Monk
              Liu|GPU Virtualization Team |</span><span
              style="font-size:12.0pt;color:#C82613;border:none
              windowtext 1.0pt;padding:0in;background:white">AMD<o:p></o:p></span></p>
          <p class="MsoNormal"><img style="width:.8333in;height:.8333in"
              id="Picture_x0020_1"
              src="cid:part1.C3FD06B1.31D84B93@gmail.com"
              alt="sig-cloud-gpu" class="" width="80" height="80"><o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> He, Jacob
              <a class="moz-txt-link-rfc2396E" href="mailto:Jacob.He@amd.com">&lt;Jacob.He@amd.com&gt;</a> <br>
              <b>Sent:</b> Monday, April 20, 2020 3:45 PM<br>
              <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Koenig,
              Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
              <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              <b>Subject:</b> Re: why we need to do infinite RLC_SPM
              register setting during VM flush<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p style="margin:15.0pt"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
            Official Use Only - Internal Distribution Only]<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div>
            <p class="MsoNormal"><span
                style="font-size:12.0pt;color:black">Do you miss a file
                which adds </span><span
                style="color:#201F1E;background:white">spm_updated</span><span
                style="font-size:12.0pt;color:black"> to vm structure?<o:p></o:p></span></p>
          </div>
          <div class="MsoNormal" style="text-align:center"
            align="center">
            <hr width="98%" size="2" align="center">
          </div>
          <div id="divRplyFwdMsg">
            <p class="MsoNormal"><b><span style="color:black">From:</span></b><span
                style="color:black"> Liu, Monk &lt;<a
                  href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">Monk.Liu@amd.com</a>&gt;<br>
                <b>Sent:</b> Monday, April 20, 2020 3:32 PM<br>
                <b>To:</b> He, Jacob &lt;<a
                  href="mailto:Jacob.He@amd.com" moz-do-not-send="true">Jacob.He@amd.com</a>&gt;;
                Koenig, Christian &lt;<a
                  href="mailto:Christian.Koenig@amd.com"
                  moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;<br>
                <b>Cc:</b> <a
                  href="mailto:amd-gfx@lists.freedesktop.org"
                  moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                &lt;<a href="mailto:amd-gfx@lists.freedesktop.org"
                  moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                <b>Subject:</b> why we need to do infinite RLC_SPM
                register setting during VM flush</span>
              <o:p></o:p></p>
            <div>
              <p class="MsoNormal"> <o:p></o:p></p>
            </div>
          </div>
          <div>
            <div>
              <p class="xmsonormal">Hi Jaco &amp; Christian<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">As titled , check below patch:<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">commit
                10790a09ea584cc832353a5c2a481012e5e31a13<o:p></o:p></p>
              <p class="xmsonormal">Author: Jacob He &lt;<a
                  href="mailto:jacob.he@amd.com" moz-do-not-send="true">jacob.he@amd.com</a>&gt;<o:p></o:p></p>
              <p class="xmsonormal">Date:   Fri Feb 28 20:24:41 2020
                +0800<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">    drm/amdgpu: Update SPM_VMID with
                the job's vmid when application reserves the vmid<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">    SPM access the video memory
                according to SPM_VMID. It should be updated<o:p></o:p></p>
              <p class="xmsonormal">    with the job's vmid right before
                the job is scheduled. SPM_VMID is a<o:p></o:p></p>
              <p class="xmsonormal">    global resource<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">    Change-Id:
                Id3881908960398f87e7c95026a54ff83ff826700<o:p></o:p></p>
              <p class="xmsonormal">    Signed-off-by: Jacob He &lt;<a
                  href="mailto:jacob.he@amd.com" moz-do-not-send="true">jacob.he@amd.com</a>&gt;<o:p></o:p></p>
              <p class="xmsonormal">    Reviewed-by: Christian König
                &lt;<a href="mailto:christian.koenig@amd.com"
                  moz-do-not-send="true">christian.koenig@amd.com</a>&gt;<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></p>
              <p class="xmsonormal">index 6e6fc8c..ba2236a 100644<o:p></o:p></p>
              <p class="xmsonormal">---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></p>
              <p class="xmsonormal">+++
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></p>
              <p class="xmsonormal">@@ -1056,8 +1056,12 @@ int
                amdgpu_vm_flush(struct amdgpu_ring *ring, struct
                amdgpu_job *job,<o:p></o:p></p>
              <p class="xmsonormal">        struct dma_fence *fence =
                NULL;<o:p></o:p></p>
              <p class="xmsonormal">        bool pasid_mapping_needed =
                false;<o:p></o:p></p>
              <p class="xmsonormal">        unsigned patch_offset = 0;<o:p></o:p></p>
              <p class="xmsonormal">+       bool update_spm_vmid_needed
                = (job-&gt;vm &amp;&amp;
                (job-&gt;vm-&gt;reserved_vmid[vmhub] != NULL));<o:p></o:p></p>
              <p class="xmsonormal">        int r;<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">+       if (update_spm_vmid_needed
                &amp;&amp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)<o:p></o:p></p>
              <p class="xmsonormal">+              
                adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev,
                job-&gt;vmid);<o:p></o:p></p>
              <p class="xmsonormal">+<o:p></o:p></p>
              <p class="xmsonormal">        if
                (amdgpu_vmid_had_gpu_reset(adev, id)) {<o:p></o:p></p>
              <p class="xmsonormal">                gds_switch_needed =
                true;<o:p></o:p></p>
              <p class="xmsonormal">                vm_flush_needed =
                true;<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">this update_spm_vmid() looks an
                completely overkill to me, we only need to do it once
                for its VM …<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">in SRIOV the register
                reading/writing for update_spm_vmid() is now carried by
                KIQ thus there is too much burden on KIQ for such
                unnecessary jobs …<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">I want to change it to only do it
                once per VM, like:<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></p>
              <p class="xmsonormal">index 6e6fc8c..ba2236a 100644<o:p></o:p></p>
              <p class="xmsonormal">---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></p>
              <p class="xmsonormal">+++
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></p>
              <p class="xmsonormal">@@ -1056,8 +1056,12 @@ int
                amdgpu_vm_flush(struct amdgpu_ring *ring, struct
                amdgpu_job *job,<o:p></o:p></p>
              <p class="xmsonormal">        struct dma_fence *fence =
                NULL;<o:p></o:p></p>
              <p class="xmsonormal">       bool pasid_mapping_needed =
                false;<o:p></o:p></p>
              <p class="xmsonormal">        unsigned patch_offset = 0;<o:p></o:p></p>
              <p class="xmsonormal">+       bool update_spm_vmid_needed
                = (job-&gt;vm &amp;&amp;
                (job-&gt;vm-&gt;reserved_vmid[vmhub] != NULL));<o:p></o:p></p>
              <p class="xmsonormal">        int r;<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">+       if (update_spm_vmid_needed
                &amp;&amp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid
                &amp;&amp;  !vm-&gt;spm_updated) {<o:p></o:p></p>
              <p class="xmsonormal">+              
                adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev,
                job-&gt;vmid);
                <o:p></o:p></p>
              <p class="xmsonormal">+               vm-&gt;spm_updated =
                true;<o:p></o:p></p>
              <p class="xmsonormal">+       }<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">        if
                (amdgpu_vmid_had_gpu_reset(adev, id)) {<o:p></o:p></p>
              <p class="xmsonormal">                gds_switch_needed =
                true;<o:p></o:p></p>
              <p class="xmsonormal">                vm_flush_needed =
                true;<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">what do you think ?<o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
              <p class="xmsonormal">P.S.: the best way is to let GFX
                ring itself to do the update_spm_vmid() instead of let
                CPU doing it, e.g.: we put more PM4 command in VM-FLUSH
                packets ….
                <o:p></o:p></p>
              <p class="xmsonormal">But I prefer the simple way first
                like I demonstrated above
                <o:p></o:p></p>
              <p class="xmsonormal">_____________________________________<o:p></o:p></p>
              <p class="xmsonormal"><span
                  style="font-size:12.0pt;color:black;background:white">Monk
                  Liu|GPU Virtualization Team |</span><span
                  style="font-size:12.0pt;color:#C82613;border:none
                  windowtext 1.0pt;padding:0in;background:white">AMD</span><o:p></o:p></p>
              <p class="xmsonormal"><img
                  style="width:.8333in;height:.8333in"
                  id="x_Picture_x0020_1"
                  src="cid:part1.C3FD06B1.31D84B93@gmail.com"
                  alt="sig-cloud-gpu" class="" width="80" height="80"
                  border="0"><o:p></o:p></p>
              <p class="xmsonormal"> <o:p></o:p></p>
            </div>
          </div>
        </div>
      </div>
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

--------------4A76C546A249D634B2B86D9A
Content-Type: image/png;
 name="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <part1.C3FD06B1.31D84B93@gmail.com>
Content-Disposition: inline;
 filename="image001.png"

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
--------------4A76C546A249D634B2B86D9A--

--------------DDCB3149596D52AD67585E1F--

--===============1134250937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1134250937==--
