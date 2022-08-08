Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C32C00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 13:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963059BE88;
	Mon,  8 Aug 2022 13:12:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE2695B7F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659957614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QozIPOmJ21AC1K9gbg2cusCUMwW3RBBAjORk9XA/HGM=;
 b=ToUC6tL/upotqjcjMR+cYNVxlYvIksqvVWi1SMsCpFjzLq859IpT6jTqww+ByrPgx9scUe
 fzMiteiBeIjF/crTQY4dOK3kp2nEYbYc3V2P5J8FY3EOOZycgt8J6cj4KnzWId9WI3DgpK
 m7UdjnAQ90JVmRxJezNKOuSPvAxPalA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-dlB8t1EbPpKLzd8EuLtvyw-1; Mon, 08 Aug 2022 07:20:13 -0400
X-MC-Unique: dlB8t1EbPpKLzd8EuLtvyw-1
Received: by mail-ej1-f71.google.com with SMTP id
 oz39-20020a1709077da700b007313bf43f0dso729373ejc.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Aug 2022 04:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=QozIPOmJ21AC1K9gbg2cusCUMwW3RBBAjORk9XA/HGM=;
 b=CwO95heHQ0+7DCkPQ+eeDirlWFCZTOuNhyCCjIV0+/ER44pmdHv6eO6d6MAHmJZlVI
 gZPSwMZlz8+7tB5ybPoyCJ4N/MSXP8JxJbTq75hW5TJZXVefXlPg8AW4T/PIltpY+Rqx
 hrhkMwkezQocpaPC4/JyxD8c4nL68KieCROxzLBhRy+rj53m0XIdbpPSxZp4tkim6Skn
 BTcNT1y9QwoAlXnsoOyRcGY4dY5BSN/UBOzNdTEkxp3+tLStT+kpBbA3DRKIZnJIZZk4
 we0DOJG1bAjVl4olTxn/GfvLJcyGyCbN40z1fnJL6teFFbfMSpHzmVd3J6cq4PGYujr2
 1opQ==
X-Gm-Message-State: ACgBeo3wTBGxJdeehZP1UqfawtpEV8aOfU2Phy/cDQuAbx+f6xkVYFmO
 JxqeQaYHqyzOuXT9DLjYPYsTFU3wVRrBAP++Nlz+O46y2o8QfgCreZZOHY+C9mMypeLoTJgu/oo
 ZzxqMHl+B/NZm6BrSildxZiK16Q==
X-Received: by 2002:a17:906:6086:b0:731:3970:48d0 with SMTP id
 t6-20020a170906608600b00731397048d0mr5964316ejj.16.1659957611948; 
 Mon, 08 Aug 2022 04:20:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4aAYPr/ta1YkZgRSj5RxGdqJXmapOGpE792PxX8NMmElRkfdU+UpORpR9WlpNBqJszOl5p6g==
X-Received: by 2002:a17:906:6086:b0:731:3970:48d0 with SMTP id
 t6-20020a170906608600b00731397048d0mr5964306ejj.16.1659957611761; 
 Mon, 08 Aug 2022 04:20:11 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a1709062ad100b0072b7d76211dsm4819928eje.107.2022.08.08.04.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Aug 2022 04:20:11 -0700 (PDT)
Message-ID: <187d9428-c776-cbae-8054-172b106d9c4c@redhat.com>
Date: Mon, 8 Aug 2022 13:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/amd/display: set panel orientation before
 drm_dev_register
To: Simon Ser <contact@emersion.fr>, Melissa Wen <mwen@igalia.com>
References: <20220803162402.3412968-1-mwen@igalia.com>
 <20220803162952.odxi24tb6krgt42n@mail.igalia.com>
 <xI-NVvuRaXc7nwH0mpaawuQCjch9XHttx_WHUdA449IE17gUq2QxChCzWZTV6v64fItGWakt4KnFAEOwVX4ILsh947KphoLyrwID2g3gcAI=@emersion.fr>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <xI-NVvuRaXc7nwH0mpaawuQCjch9XHttx_WHUdA449IE17gUq2QxChCzWZTV6v64fItGWakt4KnFAEOwVX4ILsh947KphoLyrwID2g3gcAI=@emersion.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 08 Aug 2022 13:12:38 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 nikola.cornij@amd.com, Sean Paul <seanpaul@chromium.org>,
 kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 8/5/22 19:34, Simon Ser wrote:
> Hi,
> 
> Have you seen [1] and [2]? CC'ing Sean and Hans, it seems like there's
> a disagreement regarding probing early vs. setting the initial value to
> UNKNOWN.

At least for the discussions I've been involved in so far
(see the links in the originak email) it was possible to retreive
the panel orientation before calling drm_dev_register() and IIRC some
changes were merged (I've at least reviewed them) to add a new
callback to the panel drivers to get the orientation from the panel
driver before registering the connector fixing the ordering problem
for those cases.

> If a driver doesn't fetch EDIDs before exposing them to user-space,
> then there is an amount of time where the connectors are exposed as
> CONNECTED but their EDID and mode list isn't properly set. But maybe
> that's what the GETCONNECTOR IOCTLs is supposed to do: probe the
> connector, fetch its EDID, return the proper mode list. So maybe
> drivers shouldn't probe early and should let user-space request probes?
> In which case we could create the panel orientation prop with "Normal",
> and update it accordingly when probing.

I guess that if in some cases it really is not possible to get
the orientation before calling drm_dev_register() then this is
an acceptable solution, as long as the orientation gets set
properly before the first GETCONNECTOR IOCTL finishes then
userspace will never know the difference since it needs to do
the GETCONNECTOR to enumerate the connectors properties anyways.

> At any rate, I've tested v2 on the Deck and it works properly.
> 
> Tested-by: Simon Ser <contact@emersion.fr>

I'm not aware of which patch's v2 you are talking about here, link ?

Regards,

Hans





> 
> Thanks,
> 
> Simon
> 
> [1]: https://lore.kernel.org/dri-devel/CAMavQKJUpYP8jo2JDGMYNBGtbPSSO7z9BAComm5JQoty=HPtJg@mail.gmail.com/
> [2]: https://lore.kernel.org/dri-devel/20220530081910.3947168-1-hsinyi@chromium.org/
> 

