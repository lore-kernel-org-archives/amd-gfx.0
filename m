Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92899C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 08:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3413664E13
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 08:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3413664E13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5E789D87;
	Mon, 15 Mar 2021 08:04:27 +0000 (UTC)
X-Greylist: delayed 6890 seconds by postgrey-1.36 at gabe;
 Mon, 15 Mar 2021 04:18:20 UTC
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F8B89BBD;
 Mon, 15 Mar 2021 04:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=UftIN6fE1u0QhqqkA/YhCC1AeNi+dCOkMNl2dhD5GNg=; b=aQapfMbog4owcKpXxlZ7YGkg+K
 0Msw/DBt2m2T0TVBUnrA4OIk/ys0sVnZFehXPuJNhk4pE7PqfEPKE4ftpwvApZQvF+8GkieJecFHE
 bMr5OZVz0ygqjN4hxg/90EmPfD6/e6f68L4/zDbPy1tTPWI4ZfiuC0OlH10qGiOHg5KrzrAVmikQc
 FdRjA0l0KYwuzud+PC91htKGs0AWjV+VUK0CzakYtk3aZT7nSSL7hp+KHV3wPY+gvZ7imFcsgVDC4
 Trs5ZWZn+ONibXi9nE5vFhtA++JJUXr/eJZSwLYscHYYScdfILQVvTiEZ8rTfDyzJzz2hZZY/lXun
 vmN7bq/g==;
Received: from [2601:1c0:6280:3f0::9757]
 by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lLegK-001Fuv-Ii; Mon, 15 Mar 2021 04:18:17 +0000
Subject: Re: [PATCH V2] drm: amd: pm: Mundane typo fixes in the file
 amdgpu_pm.c
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 evan.quan@amd.com, nirmoy.das@amd.com, kevin1.wang@amd.com,
 ray.huang@amd.com, Xiaojian.Du@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210315032136.3669883-1-unixbhaskar@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <64472479-0f70-3875-d09a-29417cd8b48e@infradead.org>
Date: Sun, 14 Mar 2021 21:18:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315032136.3669883-1-unixbhaskar@gmail.com>
Content-Language: en-US
X-Mailman-Approved-At: Mon, 15 Mar 2021 08:04:21 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/14/21 8:21 PM, Bhaskar Chowdhury wrote:
> 
> s/"an minimum"/"a minimum"/
> s/"an maxmum"/"a maximum"/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Changes from V1:
>   Randy's suggestion to adjust the subject line text
>   And missed out a spell too,which now included
> 
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5fa65f191a37..308249ae1a22 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3315,9 +3315,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>   *
>   * - pwm1_max: pulse width modulation fan control maximum level (255)
>   *
> - * - fan1_min: an minimum value Unit: revolution/min (RPM)
> + * - fan1_min: a minimum value Unit: revolution/min (RPM)
>   *
> - * - fan1_max: an maxmum value Unit: revolution/max (RPM)
> + * - fan1_max: a maximum value Unit: revolution/max (RPM)
>   *
>   * - fan1_input: fan speed in RPM
>   *
> --


-- 
~Randy

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
