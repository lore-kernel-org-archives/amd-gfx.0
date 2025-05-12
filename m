Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E2DC3ABD9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 08:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165CB10E542;
	Tue, 13 May 2025 08:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FzO9mzHc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F3BC10E192;
 Mon, 12 May 2025 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kj0xD8FPYRcjZw2mQNJ4IqSPTRwkMeeQixKqAC0S9kk=; b=FzO9mzHc2pYWwR3HJIdsbAr7wo
 cJsZXLJWlMd82Z4n7H+UBE733uHKnv9t/O9hdsqGoY/8jgwvyWata8IchIoiMIklT1Bpb4WbSMSQK
 TpfYKZ2JUnm2aImBdwzkiLVAQ2hc7NHz0jbXXmBozwe4aiQxEogkjd0NCQaGNi0CGeQVPckBP8WJr
 jfDtuQ91m6EbErL83pk6E833LWDzkJ3qkPvbHA+Au18zvMVnr85MbyK+Xed8jVtDyQ1Wm3VX8mwio
 pPhlMcMdw9NDZk0757/B7llu8F1lYaCWnsVc+H3U5EHJ5lhcoJkpPaiI49vRnEM4Y6m7KjMwXc14b
 M0iMsWIA==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1uETJb-0076X9-K9; Mon, 12 May 2025 15:40:52 +0200
Message-ID: <bd1bfb32-1da3-4680-94f8-44e8008a80f9@igalia.com>
Date: Mon, 12 May 2025 10:40:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm: Create an app info option for wedge events
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 siqueira@igalia.com, airlied@gmail.com, simona@ffwll.ch,
 Raag Jadav <raag.jadav@intel.com>, rodrigo.vivi@intel.com,
 jani.nikula@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20250511224745.834446-1-andrealmeid@igalia.com>
 <20250511224745.834446-2-andrealmeid@igalia.com>
 <x3ep3offdy5on6hckumvpsvnlfnmjdfqjlcyv7hojitzsn5u3k@opnou6grp7ad>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <x3ep3offdy5on6hckumvpsvnlfnmjdfqjlcyv7hojitzsn5u3k@opnou6grp7ad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 May 2025 08:15:53 +0000
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

Hi Krzysztof,

Thanks for the feedback.

Em 12/05/2025 03:08, Krzysztof Karas escreveu:
> Hi André,
> 
> [...]
> 
>> @@ -582,6 +584,14 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
>>   	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
>>   		 "but recovered through reset" : "needs recovery");
>>   
>> +	if (info) {
>> +		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
>> +		snprintf(comm_string, sizeof(comm_string), "APP=%s", info->comm);
>> +	} else {
>> +		snprintf(pid_string, sizeof(pid_string), "%s", "PID=-1");
>> +		snprintf(comm_string, sizeof(comm_string), "%s", "APP=none");
> 
> I think using PID=-1 and APP=none might be misleading, because
> something did cause the wedge if we landed here. You could use
> "PID=unknown" and "APP=unknown" or ensure these arrays are
> zeroed and fill them only if "info" is available:
> 
> -     char *envp[] = { event_string, NULL };
> +     char pid_string[15] = {}, comm_string[TASK_COMM_LEN] = {};
> +     char *envp[] = { event_string, pid_string, comm_string, NULL };
> 
> [...]
> 
> +     if (info) {
> +             snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
> +             snprintf(comm_string, sizeof(comm_string), "APP=%s", info->comm);
> +     }
> 
> Then, when printing the logs later you could check if they have
> a value and only use them if they do (or handle that however
> you would see fit :) ).
> 

That works for me, I will address this in my v3.
Thanks!

> Best Regards,
> Krzysztof

