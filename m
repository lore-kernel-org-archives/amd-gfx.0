Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541F6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 18:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E48112D3D;
	Mon, 16 May 2022 18:10:48 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0527C112D3D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 18:10:47 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id i19so30192757eja.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=pcAARQ0o07oozueHFn+0QORa6/v6liEyQ17NLtdz8yE=;
 b=ozz/P94TENEIVOu4I+2PK/6ljQF5oC7RzPw/3Jdtyq/8h5szvn9MJZydY/GdAxPqaN
 46vbNLTmEsZgmRdTa19MsqRL4t+ndoVm6s1dtlFQLCcppi9+J10NBCsPgZfCj/v13ip3
 Yhu74LH4ttJxljSprU5HOdHIRDuN7NGPa4ieTIAE9uxh8w5hoqDDX+Ys0x4Zr0O/zV4a
 U8MsUR6JDpSMxKe8lKxNdQEtWGW5K0SFrMThqxdlhvMMjZmx6kMNakPcEC0mgdQYTMzM
 1dmAm1IpDV1p7WQ9TmSjFjEDCXtfBXieBKVrwRK1JVgkNLtRgmty+ZH6N9Q+kwUKA3WU
 0RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=pcAARQ0o07oozueHFn+0QORa6/v6liEyQ17NLtdz8yE=;
 b=Q9WX+7pwnxykiFNaDDeaGheJWrozmYgSZkoQ2wOy3AiWrilvMf24mqEZvC2INWvAGc
 1q5cM99WXqJsVMym2ctZ5Nhjyh4oRtWO04x/ZVtGgzdvJvc88SE/teHYWMPORXJBZl/+
 /baS2nZFz4nxP4lXaXZKmjfP4f46Mw2qMVms6MVZf3VRECVN2iDN/iMHEqAHlqdW5Y2q
 IzdlqZTgmA/gixkCqJmn24cJPMfGWmZSWC8awyYKU08cIONCTBdY0M1rR+OquMby7fjh
 hirbXbavjif8zB0f59C9vVI6vbzQPECjd1Aj8ZWyrPYVSPg6zeK5fbsUTwzTB1HIBoR6
 sWkg==
X-Gm-Message-State: AOAM532xeLDk9q0IH75BCFTSlo9xgHEB0a5UHOlfrSUB7o0p/ZKSgY0i
 KMU8jn1p9PcMedBsGrtcBrc=
X-Google-Smtp-Source: ABdhPJzLb4ef5IY1YAW9vTtbNNPqhKKvvRnfX4/uxVu4Hs9i8OwQQ7yuYM0EHhwOncBiUZxsvVp1sQ==
X-Received: by 2002:a17:907:2ce2:b0:6f4:4c44:b66f with SMTP id
 hz2-20020a1709072ce200b006f44c44b66fmr16126959ejc.371.1652724645434; 
 Mon, 16 May 2022 11:10:45 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8998:dca1:c111:9def?
 ([2a02:908:1256:79a0:8998:dca1:c111:9def])
 by smtp.gmail.com with ESMTPSA id
 q18-20020aa7d452000000b00427afbbf5e8sm5564440edr.11.2022.05.16.11.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 11:10:45 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------hKgzCBoyVEW5c337shreSICd"
Message-ID: <28edd55e-2e11-20b9-0ee9-3fd3f3a92409@gmail.com>
Date: Mon, 16 May 2022 20:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: VCN_INFO_TABLE_MAX_NUM_INSTANCES vs AMDGPU_MAX_VCN_INSTANCES
Content-Language: en-US
To: =?UTF-8?Q?Ernst_Sj=c3=b6strand?= <ernstp@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <CAD=4a=VSEST+6oiPRrMNNd1ByQm0e+pG=vCLb--bTXDZT0LnoQ@mail.gmail.com>
 <CADnq5_Ng2sfX5h0OxOu1VU7qGxXbaAfJemFT59ouYgH6SJsiGA@mail.gmail.com>
 <CAD=4a=UT+P33BnKufwGvqYx50qR9SvzEXsPsVJ7Bf2iegMczbw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAD=4a=UT+P33BnKufwGvqYx50qR9SvzEXsPsVJ7Bf2iegMczbw@mail.gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------hKgzCBoyVEW5c337shreSICd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.05.22 um 19:49 schrieb Ernst Sjöstrand:
> Den mån 16 maj 2022 kl 17:13 skrev Alex Deucher <alexdeucher@gmail.com>:
>
>     On Sun, May 15, 2022 at 11:46 AM Ernst Sjöstrand
>     <ernstp@gmail.com> wrote:
>     >
>     > smatch found this problem on amd-staging-drm-next:
>     >
>     > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443
>     amdgpu_discovery_get_vcn_info() error: buffer overflow
>     'adev->vcn.vcn_codec_disable_mask' 2 <= 3
>     >
>     > This is caused by:
>     > #define AMDGPU_MAX_VCN_INSTANCES 2
>     > #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
>     >
>     > Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and
>     use AMDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?
>
>     We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4 (although it
>     would waste some memory in the places it is used at this point).
>     VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware structure so we
>     can't change that without breaking the firmware structure.
>
>     Alex
>
>
> It would be nice to get rid of this pattern and make sure it doesn't 
> happen again when the VCN info table is raised to 5.
> It's very similar to the HWIP_MAX_INSTANCE issue.

No, as Alex explained that distinction is intentional.

The firmware definition is 4 for future extensions, that doesn't mean 
that this is currently used.

There is currently simply no need to set AMDGPU_MAX_VCN_INSTANCES to 
more than 2.

Regards,
Christian.

>
> //E
>

--------------hKgzCBoyVEW5c337shreSICd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 16.05.22 um 19:49 schrieb Ernst Sjöstrand:<br>
    <blockquote type="cite"
cite="mid:CAD=4a=UT+P33BnKufwGvqYx50qR9SvzEXsPsVJ7Bf2iegMczbw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">Den mån 16 maj 2022 kl 17:13
            skrev Alex Deucher &lt;<a
              href="mailto:alexdeucher@gmail.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">alexdeucher@gmail.com</a>&gt;:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">On Sun, May 15, 2022 at
            11:46 AM Ernst Sjöstrand &lt;<a
              href="mailto:ernstp@gmail.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">ernstp@gmail.com</a>&gt;
            wrote:<br>
            &gt;<br>
            &gt; smatch found this problem on amd-staging-drm-next:<br>
            &gt;<br>
            &gt; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443
            amdgpu_discovery_get_vcn_info() error: buffer overflow
            'adev-&gt;vcn.vcn_codec_disable_mask' 2 &lt;= 3<br>
            &gt;<br>
            &gt; This is caused by:<br>
            &gt; #define AMDGPU_MAX_VCN_INSTANCES 2<br>
            &gt; #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4<br>
            &gt;<br>
            &gt; Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES
            completely and use AMDGPU_MAX_VCN_INSTANCES everywhere
            instead (and bump it to 4)?<br>
            <br>
            We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4
            (although it<br>
            would waste some memory in the places it is used at this
            point).<br>
            VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware
            structure so we<br>
            can't change that without breaking the firmware structure.<br>
            <br>
            Alex<br>
          </blockquote>
          <div><br>
          </div>
          <div style="font-family:arial,helvetica,sans-serif"
            class="gmail_default">It would be nice to get rid of this
            pattern and make sure it doesn't happen again when the VCN
            info table is raised to 5.</div>
          <div style="font-family:arial,helvetica,sans-serif"
            class="gmail_default">It's very similar to the
            HWIP_MAX_INSTANCE issue.</div>
        </div>
      </div>
    </blockquote>
    <br>
    No, as Alex explained that distinction is intentional.<br>
    <br>
    The firmware definition is 4 for future extensions, that doesn't
    mean that this is currently used.<br>
    <br>
    There is currently simply no need to set AMDGPU_MAX_VCN_INSTANCES to
    more than 2.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAD=4a=UT+P33BnKufwGvqYx50qR9SvzEXsPsVJ7Bf2iegMczbw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div style="font-family:arial,helvetica,sans-serif"
            class="gmail_default"><br>
          </div>
          <div style="font-family:arial,helvetica,sans-serif"
            class="gmail_default">//E<br>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------hKgzCBoyVEW5c337shreSICd--
