Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA712C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 06:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6EC10E524;
	Thu,  1 Jun 2023 06:25:10 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EFF10E524
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 06:25:08 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f50470d77cso463857e87.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 23:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685600705; x=1688192705;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0T5C6b2bG2pl43un59M4C0SPu7l/URYgh/G1JRCtbs=;
 b=mWOM1Sa26DlkjUJzoVMpkeodtOGZqGqYtPAOLcswa1vzqeOP9ZrB9VKlqny4frJ/6q
 JuGuqc+RhA+3eZduEpvwZF+/IPiVeT99NaOR4Q5MWYYPM0omE3Rtjj1skJnDP3ukrwlb
 a/gCI7nTXl9coFK3s27Xe7+W/MNNN0NC9ZEZpHjqN5asYKvTnOGASH+PoDU+IlYTwKzw
 q2P3x8nYYnM0d0jreVw+WIyJdzC09ay4r/T3o01JD/mEx27HDxm/iVfTBUCmeKv17GoB
 tm6MLLb9L6ZJSfsp/lsv3SDbfWmImB4NynAVstF3EdinsyvcwBYw4cSLXD9c0mwqFP1M
 Nx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685600705; x=1688192705;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o0T5C6b2bG2pl43un59M4C0SPu7l/URYgh/G1JRCtbs=;
 b=NFzjM8JLvQXoRF5+KyOjnbZi254WCPmyIIk+fp7jZbPU4T1PEQ2msWzo8lupj9neF+
 lGAFJHguYDRec4P8EUWJoR4i2bIG5MrMvRnDRw+RXdH1zG1Jgq4kFSPPgIGMqv0bNGfc
 /pSaQfSxM5K50CCGi9WR4X8cFxEtbk/fHO+PmvX7vO23aYmkh3X3Kash8B1P1mVpKY3j
 wYETKDBtEdPKI3toxfjuCQ0ZvksA058OdqBlpOuAUqFAh3mY3X2QW8Aaj299z8o93r1z
 ooBbXsETjLxHv0VYIDpYNwIEzoz1vYDy1UFS6YP8U1BfvDLKiBOp91dpRRLfE41v0V6X
 g1VA==
X-Gm-Message-State: AC+VfDzvIYqUu/DhEH1KJ+zlBCAfHWc2f0zLykAkXP5jkPrxwXKRQpvk
 gLLMQZIvVsna7Q2i45ZhZSc=
X-Google-Smtp-Source: ACHHUZ5wVc2xceu56ci1tX6ZHkEC8r9PjUqdJYRw2KvepJTm+Djf3eeamBQXaAeoKsrC/Y3+2g2GoA==
X-Received: by 2002:a05:6512:218d:b0:4f2:6387:e1fe with SMTP id
 b13-20020a056512218d00b004f26387e1femr626742lft.7.1685600705181; 
 Wed, 31 May 2023 23:25:05 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1543:da00:92db:2067:4b66:9b88?
 ([2a00:e180:1543:da00:92db:2067:4b66:9b88])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a170906410400b00965a4350411sm10078622ejk.9.2023.05.31.23.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 23:25:04 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------6kVBy01B0HeRCmuQKbhzA6bC"
Message-ID: <d42c6f18-1e0c-e4b2-08c7-873c44e141b6@gmail.com>
Date: Thu, 1 Jun 2023 08:25:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: change reserved vram info print
Content-Language: en-US
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230525085026.1316196-1-YiPeng.Chai@amd.com>
 <de91def0-4de8-307f-dc89-b5c744506452@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <de91def0-4de8-307f-dc89-b5c744506452@amd.com>
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
Cc: Tao.Zhou1@amd.com, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------6kVBy01B0HeRCmuQKbhzA6bC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

If you haven't already pushed it Reviewed-by: Christian König 
<christian.koenig@amd.com> as well.

You might want to add a CC: stable... tag so that it gets backported.

Regards,
Christian.

Am 01.06.23 um 08:13 schrieb Arunpravin Paneer Selvam:
>
> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
>
> On 5/25/2023 2:20 PM, YiPeng Chai wrote
>> The link object of mgr->reserved_pages is the blocks
>> variable in struct amdgpu_vram_reservation, not the
>> link variable in struct drm_buddy_block.
>>
>> Signed-off-by: YiPeng Chai<YiPeng.Chai@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 89d35d194f2c..c7085a747b03 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -839,7 +839,7 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>>   {
>>   	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>>   	struct drm_buddy *mm = &mgr->mm;
>> -	struct drm_buddy_block *block;
>> +	struct amdgpu_vram_reservation *rsv;
>>   
>>   	drm_printf(printer, "  vis usage:%llu\n",
>>   		   amdgpu_vram_mgr_vis_usage(mgr));
>> @@ -851,8 +851,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>>   	drm_buddy_print(mm, printer);
>>   
>>   	drm_printf(printer, "reserved:\n");
>> -	list_for_each_entry(block, &mgr->reserved_pages, link)
>> -		drm_buddy_block_print(mm, block, printer);
>> +	list_for_each_entry(rsv, &mgr->reserved_pages, blocks)
>> +		drm_printf(printer, "%#018llx-%#018llx: %llu\n",
>> +			rsv->start, rsv->start + rsv->size, rsv->size);
>>   	mutex_unlock(&mgr->lock);
>>   }
>>   
>

--------------6kVBy01B0HeRCmuQKbhzA6bC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    If you haven't already pushed it Reviewed-by: Christian König
    <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> as well.<br>
    <br>
    You might want to add a CC: stable... tag so that it gets
    backported.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 01.06.23 um 08:13 schrieb Arunpravin
      Paneer Selvam:<br>
    </div>
    <blockquote type="cite"
      cite="mid:de91def0-4de8-307f-dc89-b5c744506452@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Reviewed-by:
        Arunpravin Paneer Selvam &lt;<a
          href="mailto:Arunpravin.PaneerSelvam@amd.com"
          class="moz-txt-link-freetext" moz-do-not-send="true">Arunpravin.PaneerSelvam@amd.com</a>&gt;</p>
      <br>
      <div class="moz-cite-prefix">On 5/25/2023 2:20 PM, YiPeng Chai
        wrote<br>
      </div>
      <blockquote type="cite"
        cite="mid:20230525085026.1316196-1-YiPeng.Chai@amd.com">
        <pre class="moz-quote-pre" wrap="">The link object of mgr-&gt;reserved_pages is the blocks
variable in struct amdgpu_vram_reservation, not the
link variable in struct drm_buddy_block.

Signed-off-by: YiPeng Chai <a class="moz-txt-link-rfc2396E" href="mailto:YiPeng.Chai@amd.com" moz-do-not-send="true">&lt;YiPeng.Chai@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 89d35d194f2c..c7085a747b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -839,7 +839,7 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct drm_buddy *mm = &amp;mgr-&gt;mm;
-	struct drm_buddy_block *block;
+	struct amdgpu_vram_reservation *rsv;
 
 	drm_printf(printer, "  vis usage:%llu\n",
 		   amdgpu_vram_mgr_vis_usage(mgr));
@@ -851,8 +851,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	drm_buddy_print(mm, printer);
 
 	drm_printf(printer, "reserved:\n");
-	list_for_each_entry(block, &amp;mgr-&gt;reserved_pages, link)
-		drm_buddy_block_print(mm, block, printer);
+	list_for_each_entry(rsv, &amp;mgr-&gt;reserved_pages, blocks)
+		drm_printf(printer, "%#018llx-%#018llx: %llu\n",
+			rsv-&gt;start, rsv-&gt;start + rsv-&gt;size, rsv-&gt;size);
 	mutex_unlock(&amp;mgr-&gt;lock);
 }
 
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------6kVBy01B0HeRCmuQKbhzA6bC--
