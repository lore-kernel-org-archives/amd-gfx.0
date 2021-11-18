Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665ADC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2585361A3A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2585361A3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90A36E8FA;
	Thu, 18 Nov 2021 16:18:25 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC416E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 16:18:24 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id bk14so15348654oib.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 08:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U/KYs4EJjTt8LRXppmZHeI/bUY4h1ORa+JX6cGa8lyU=;
 b=ltLNhH+sSY6AQZqSrUi6T+ZuM5l6IrgAfO8fqGFkg7MpV4S/79Zd5HoQux+WLodm64
 pW4O6gPxTqH9D+lRv1sPzBvtls/mmqsAaua3lacPKuwMOpAh51aFfGkUMa6BkFSncVrw
 EAMjG6AXc5cA2oxerrI5kvTrtbNRIQB5DbXzO2tWhnKQHH1t9v15GDiZtEsbkNj/+51W
 zUJIl6CCm9xF4olh8HxCgy6q3XIuvstxf/K4XsSwOr5I4ZKasj0vYhdPBriei/HOEozg
 8GjDLENaRGGuMnGtcK6TTZt1TaC+cJL3uzrfKFOVBIayWXsEilVuWRyf5M62TMPKWdx8
 mM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U/KYs4EJjTt8LRXppmZHeI/bUY4h1ORa+JX6cGa8lyU=;
 b=J1mnhTEMtvpKNkFsgiTvGIUzOHMHDbov+7bOsa+896TTS6csiwWn80U6/joM8xJJXG
 ESbueRTLhKQOznImnsFW7cUMErUBqCQQQ5EaLPGO+7ozn76UJrtmnXqllj2bpQ+W/lho
 +US0tRoyKqLdJM6RexcmSL5jmWBeNAQODugix1H/kPHjCJgQlojx3BlkmKVWWYntoPjh
 6xsKGpQHNdiS2ipCx9NDHLKR81pxiQUSUVtmgfMPl56t4D6maR9h9STBk//kbOiHi9QF
 GgAWsU9yoEwwpSwlZPHS8kBX0mX1ZHywmxyx92rB3pVDEXVClGGsm7dfAb5l3ABLPTy6
 pAGw==
X-Gm-Message-State: AOAM532gagJpc2N9LU1qRWFE+D/UsZFL23QmfqveE51skuWn0yO+/U+g
 p9nEyfUjfey0rv4Jxp81R0hw0r6bNU2N45hH5eY=
X-Google-Smtp-Source: ABdhPJxhPTKEEE9IlvF8b3O/S26TRPmD6SnltL1XFoiwbNR/vwrhczRq3QHFzQKPTzmm+nxokVBn3rKQDmjWT2XWkkQ=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr8770437oib.120.1637252303903; 
 Thu, 18 Nov 2021 08:18:23 -0800 (PST)
MIME-Version: 1.0
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
 <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
 <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
 <CADnq5_MGQ802Z-gdgfQXK_Eo2RXeE0qZ7AQUQLusez4Y3ysT5w@mail.gmail.com>
 <14cd6274-c967-ba7d-71d7-ccf332c30494@amd.com>
 <DM6PR12MB3930D33025C01706AE0F258F979B9@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3930D33025C01706AE0F258F979B9@DM6PR12MB3930.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Nov 2021 11:18:12 -0500
Message-ID: <CADnq5_MbghaKafhQ0cQZPoL4FNHap=53kCDGP4X99rxe7Du-eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 18, 2021 at 10:01 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [Public]
>
>
> BTW, I'm not sure if 'reset always' on resume is a good idea  for GPUs in a hive (assuming those systems also get suspended and get hiccups). At this point the hive isn't reinitialized.

Yeah, we should probably not reset if we are part of a hive.

Alex


>
> Thanks,
> Lijo
