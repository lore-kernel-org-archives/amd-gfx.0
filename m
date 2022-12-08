Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5A9C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 14:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0237510E4AB;
	Thu,  8 Dec 2022 14:18:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDE310E485
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670492629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOPQI6SqAzpqn+J3Vr+5gc53ySVAptDT9STnmKemzW0=;
 b=O5Iw/ygZ5AKTvEzlDjxkeOijrRjISDspgnWO8ipipfI4ddO0HKhP7fafpUViGYDlqRvQWN
 37ZFKmfbfCl5HlPCw1IYi4l+2yNwFhCJYREM0i/8z0gt9y7Asee1IRrPeq+hyIstk/eBS2
 6sAD4hsHRQ1MMtlosVZ3oSOWwRLaLrA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-IimyAm3nMpi00mFE4qbRew-1; Thu, 08 Dec 2022 04:43:40 -0500
X-MC-Unique: IimyAm3nMpi00mFE4qbRew-1
Received: by mail-ej1-f70.google.com with SMTP id
 hs18-20020a1709073e9200b007c0f9ac75f9so744616ejc.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Dec 2022 01:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QOPQI6SqAzpqn+J3Vr+5gc53ySVAptDT9STnmKemzW0=;
 b=blBdilPXxlP2GNeYDPrVAYaCpmqtoueIlZ6rUGy43+37Sms2dhlEXH3srKaWvyMx8H
 f/pzhK2qPlMasReCGuwJCwtbAlGOYaKkoicTztUia9dKpE2IEKb4YXCQvSOy/57HFrxp
 CxaRQooRU8olQI20qkgBXS8vX5CY20RhDGoNlpPK4sVO7dtqId84K11I27lE/QvQ+Hi2
 NU2Nc6SiHSOgSUkXYSSs6hDWWAGSF5HNlSslFyCR5yeCy2jseimLcC0hzNHaXk9eocb+
 NaR5OMWJwNKF+nNZCHNDSsrkRm8dDvO0qDhMCVD22Wk3p+0/GGlnOvrtMEUpkEgX9OBo
 v60A==
X-Gm-Message-State: ANoB5pkavfyUiAhAZbkzigXU5MQXY/neXYgoAlutEWPUW1VuqUm2jBh0
 7ghEU/64htyyI3GkpLvEPAbmaVWPKXwOGZxmURxoyQw182DhikcE1uP2cPAqnBQOY9chnIUUJK5
 yZ30Q9fZodSLvDjiCHu3J2AompQ==
X-Received: by 2002:a17:906:1b55:b0:7c1:ac7:a57a with SMTP id
 p21-20020a1709061b5500b007c10ac7a57amr8300470ejg.348.1670492619262; 
 Thu, 08 Dec 2022 01:43:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4FrjbczRcOqiRlM1zZZtfZnuQsP7UqvdZhR4of4qPYEXKCvwbkjsrL4FnThrnCzOaLy30oBw==
X-Received: by 2002:a17:906:1b55:b0:7c1:ac7:a57a with SMTP id
 p21-20020a1709061b5500b007c10ac7a57amr8300464ejg.348.1670492619059; 
 Thu, 08 Dec 2022 01:43:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 7-20020a170906318700b007c0aefd9339sm8521375ejy.175.2022.12.08.01.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 01:43:38 -0800 (PST)
Message-ID: <56fa6d12-1996-7ab3-9ad7-790a3b23e1c8@redhat.com>
Date: Thu, 8 Dec 2022 10:43:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/3] Adjust ACPI video detection fallback path
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Alexander Deucher <Alexander.Deucher@amd.com>
References: <20221208010910.7621-1-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221208010910.7621-1-mario.limonciello@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 08 Dec 2022 14:18:36 +0000
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
Cc: linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Daniel Dadap <ddadap@nvidia.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 12/8/22 02:09, Mario Limonciello wrote:
> In kernel 6.1 the backlight registration code was overhauled so that
> at most one backlight device got registered. As part of this change
> there was code added to still allow making an acpi_video0 device if the
> BIOS contained backlight control methods but no native or vendor drivers
> registered.
> 
> Even after the overhaul this fallback logic is failing on the BIOS from
> a number of motherboard manufacturers supporting Ryzen APUs.
> What happens is the amdgpu driver finishes registration and as expected
> doesn't create a backlight control device since no eDP panels are connected
> to a desktop.
> 
> Then 8 seconds later the ACPI video detection code creates an
> acpi_video0 device that is non-operational. GNOME then creates a
> backlight slider.
> 
> To avoid this situation from happening make two sets of changes:
> 
> Prevent desktop problems w/ fallback logic
> ------------------------------------------
> 1) Add support for the video detect code to let native drivers cancel the
> fallback logic if they didn't find a panel.
> 
> This is done this way so that if another driver decides that the ACPI
> mechanism is still needed it can instead directly call the registration
> function.
> 
> 2) Add code to amdgpu to notify the ACPI video detection code that no panel
> was detected on an APU.
> 
> Disable fallback logic by default
> ---------------------------------
> This fallback logic was introduced to prevent regressions in the backlight
> overhaul.  As it has been deemed unnecessary by Hans explicitly disable the
> timeout.  If this turns out to be mistake and this part is reverted, the
> other patches for preventing desktop problems will avoid regressions on
> desktops.

Thanks, the entire v2 series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans




> Mario Limonciello (3):
>   ACPI: video: Allow GPU drivers to report no panels
>   drm/amd/display: Report to ACPI video if no panels were found
>   ACPI: video: Don't enable fallback path for creating ACPI backlight by
>     default
> 
>  drivers/acpi/acpi_video.c                       | 17 ++++++++++++-----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  4 ++++
>  include/acpi/video.h                            |  1 +
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 

