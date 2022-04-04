Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189A3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 17:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9586410E593;
	Mon,  4 Apr 2022 17:06:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F29D10E1E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649087036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwNp5wKi4sCpy/JwyVCVYtgRdExp7ZcRrflxIJ6FsDA=;
 b=Bz1+aDBqBy+aL0xq/nPkTd9n6TmgYi2qzdUFy2/SmP0SjBK4D07mJGIdf3SyvACvIyLnNg
 WhX6bUAa09byNdHKenZ5yw0iZE0GhDtoNk3NIMtGJi5YIxEUhqPTVOr+fi2W1TivIJbGjy
 SnlQKTjXf97YCt5fJJAAuMkkAWoIFKQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-VRj7v4WAOd2c4kOXg6uueg-1; Mon, 04 Apr 2022 11:43:55 -0400
X-MC-Unique: VRj7v4WAOd2c4kOXg6uueg-1
Received: by mail-qt1-f197.google.com with SMTP id
 f3-20020ac84983000000b002e22396acfbso6525375qtq.18
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Apr 2022 08:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mwNp5wKi4sCpy/JwyVCVYtgRdExp7ZcRrflxIJ6FsDA=;
 b=SlXTsVQIajSMe+/oFfPLrPLkjQPa9CCPbs/IMANzXNCEhQo6DlHo/BRRU9K1ShV+dS
 5e4XzUGeINtxiVOhBTyelcITsOYNIRorZ6w8rni3ECQN+25zcCmhISe2o5UrfsKZBwv8
 wFe9jPtEsabYS3Jr5VNnGtQZpHIQVEONjKT17bP9OgFhbxzC2Cyy4HmcUdj7O3qVc9IL
 fS3Se9w6cvhgySCw05siSg8vJtIaCZ6KWwOonbKCcQ0yfCK8tTUSbPLogsr0lRkzv6YF
 u4u1IbksuaMavuoPiPRauXXp4HnLuGHBhn34UKaWyECKgrfsgZaGpQiDX8j92jVCDF/q
 KSjg==
X-Gm-Message-State: AOAM530hn2skm7DtvN+aI4imB5ba74lAY+elxjxHnHaYTMbxodtI+Wv8
 HkYZ0i6Ke5RU3ZKy9dvraL3S9+PryHDqfnYBEr7g14Ej3iKlOa9+bOtQyVh9YUUxAorSDegK7dn
 jhPKH+KCfjsllFfhL/TkLKNVj+g==
X-Received: by 2002:a37:6504:0:b0:67e:3194:db63 with SMTP id
 z4-20020a376504000000b0067e3194db63mr289791qkb.127.1649087034512; 
 Mon, 04 Apr 2022 08:43:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybZ7GEppWMSjwP+Dw95nhG/D+6y4DJjms9Bgretl3gqv1QkhXx47I5wVPODts8wMYZWebucw==
X-Received: by 2002:a37:6504:0:b0:67e:3194:db63 with SMTP id
 z4-20020a376504000000b0067e3194db63mr289769qkb.127.1649087034272; 
 Mon, 04 Apr 2022 08:43:54 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com.
 [24.205.208.113]) by smtp.gmail.com with ESMTPSA id
 az17-20020a05620a171100b00680af0db559sm6776261qkb.127.2022.04.04.08.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Apr 2022 08:43:53 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/display: cleanup extern usage in function
 definition
To: Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, wenjing.liu@amd.com, waynelin@amd.com, Anson.Jacob@amd.com,
 Yu-ting.Shen@amd.com, keescook@chromium.org, nicholas.kazlauskas@amd.com
References: <20220403142137.2234322-1-trix@redhat.com>
 <513a5993-2cc5-54fa-2d6c-f4162d76ab0e@amd.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <462e2f2a-0cc8-2e2e-93b6-504cc12aa768@redhat.com>
Date: Mon, 4 Apr 2022 08:43:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <513a5993-2cc5-54fa-2d6c-f4162d76ab0e@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailman-Approved-At: Mon, 04 Apr 2022 17:06:22 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 4/4/22 8:22 AM, Harry Wentland wrote:
>
> On 2022-04-03 10:21, Tom Rix wrote:
>> Smatch reports this issue
>> hdcp1_execution.c:500:29: warning: function
>>    'mod_hdcp_hdcp1_dp_execution' with external linkage
>>    has definition
>>
> Which branch are you using?

linux-next from 4/1

Tom

>
> I don't see the 'extern' on
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
>
> Harry
>
>
>> The storage-class-specifier extern is not needed in a
>> definition, so remove it.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
>> index 6ec918af3bff..1ddb4f5eac8e 100644
>> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
>> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
>> @@ -497,9 +497,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_execution(struct mod_hdcp *hdcp,
>>   	return status;
>>   }
>>   
>> -extern enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
>> -		struct mod_hdcp_event_context *event_ctx,
>> -		struct mod_hdcp_transition_input_hdcp1 *input)
>> +enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
>> +						 struct mod_hdcp_event_context *event_ctx,
>> +						 struct mod_hdcp_transition_input_hdcp1 *input)
>>   {
>>   	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
>>   

