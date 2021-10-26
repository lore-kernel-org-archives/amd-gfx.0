Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A71AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 15:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8C261090
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 15:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F8C261090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B4B6E448;
	Tue, 26 Oct 2021 15:51:04 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3030E6E448
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 15:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 329C620201B;
 Tue, 26 Oct 2021 17:51:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Xxap2HTWadk2; Tue, 26 Oct 2021 17:51:01 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 828B520201A;
 Tue, 26 Oct 2021 17:51:01 +0200 (CEST)
Received: from [127.0.0.1] by thor with esmtp (Exim 4.95)
 (envelope-from <michel@daenzer.net>) id 1mfOj6-000fKu-TI;
 Tue, 26 Oct 2021 17:51:00 +0200
Message-ID: <0087f1c6-733e-4c31-63c5-c39da51138c1@daenzer.net>
Date: Tue, 26 Oct 2021 17:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-CA
To: Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, contact@emersion.fr,
 nicholas.kazlauskas@amd.com
References: <20211026110740.152936-1-stylon.wang@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amd/display: Fix error handling on waiting for
 completion
In-Reply-To: <20211026110740.152936-1-stylon.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-10-26 13:07, Stylon Wang wrote:
> [Why]
> In GNOME Settings->Display the switching from mirror mode to single display
> occasionally causes wait_for_completion_interruptible_timeout() to return
> -ERESTARTSYS and fails atomic check.
> 
> [How]
> Replace the call with wait_for_completion_timeout() since the waiting for
> hw_done and flip_done completion doesn't need to worry about interruption
> from signal.
> 
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4cd64529b180..b8f4ff323de1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9844,10 +9844,10 @@ static int do_aquire_global_lock(struct drm_device *dev,
>  		 * Make sure all pending HW programming completed and
>  		 * page flips done
>  		 */
> -		ret = wait_for_completion_interruptible_timeout(&commit->hw_done, 10*HZ);
> +		ret = wait_for_completion_timeout(&commit->hw_done, 10*HZ);
>  
>  		if (ret > 0)
> -			ret = wait_for_completion_interruptible_timeout(
> +			ret = wait_for_completion_timeout(
>  					&commit->flip_done, 10*HZ);
>  
>  		if (ret == 0)
> 

The *_interruptible_* variant is needed so that the display manager process can be killed while it's waiting here, which could take up to 10 seconds (per the timeout).

What's the problem with -ERESTARTSYS? Either the ioctl should be restarted automatically, or if it bounces back to user space, that needs to be able to retry the ioctl while it returns -1 and errno == EINTR. drmIoctl handles this transparently.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
