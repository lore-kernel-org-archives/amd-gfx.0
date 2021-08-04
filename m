Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88084C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E86B60E52
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E86B60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B236EA27;
	Wed,  4 Aug 2021 09:04:37 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863996EA27
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 09:04:33 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id n12so1397242wrr.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Aug 2021 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=gdx9QOaebaMTuT5ytSkuNnsPPYbkJ8hTDKrcQM0WsZc=;
 b=IOLU/pzV5ix9Cshx9fbNDMQ3h+7d0zpIo6jmDGQlsiti3jRiXqo/lS/2OjtQyiLRlu
 N93JvFKKeQ3Q3vBUFdteNrjEXJgQqADi9g9xihgA03hsRRobYZ8bmx1FBhbdUYJbtAuA
 xSWhRchW/Kj5pesusS4q0lcPWn8a3pXaA8JP2pZOsd7xSOvBfa8emNEbH5iNJn+XQifq
 Pul73pizUuitgRIHSbspRRQgOmAHfHDQJkV2ygcJhJ2ZvAuEuLAWPyY4pUjmu2FcDkw4
 ShqgCw3dEP40/15diEqB1WDV8yitjbGzQoCzp3nkBWW2FBt0xQ4rI3frwug2kS1vI36x
 v7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gdx9QOaebaMTuT5ytSkuNnsPPYbkJ8hTDKrcQM0WsZc=;
 b=s2HbKUk5VE5rS1SfuH4AMPzNlZX5itXyeCHiz3WXRgem8rwI54X+c0rQqqQdWz/N2b
 U6qU8AQXMM0ktlj5iUK6RyLY2/jnJUBz/hPSf0xi9aPxNYtapKzGAeFACgUYHdi82UpE
 v6xVZTe7aCYfOAvcpLPjeHohPoxStwye+WifMyVxEh/TfsxnGHLT70qeQgYAIRs8+V9p
 lcbRQGOnQF5NTvFYqllpcnCVz28tbrfAxhSRvlrfAIRa6Rkng7r3JRM1AKlYtV0dcFYC
 pUa9V0oJfPWqIwiA7fwfWhR5APtXsfz1HJrFKbAWjM9w5AgETm44sxUSBbBFPmKMzPbL
 GJ+g==
X-Gm-Message-State: AOAM531xS5SI3RP4yhYZ1mvhwGUoy1CL991PZvkxp0rT0j054dVnTVlA
 3y/lxsghtZQvjlZoGvBwfb2f1LT5/Ow=
X-Google-Smtp-Source: ABdhPJw6IRXdTyOuWxR35VOHahj5hj9SPExyxvAR2hTLBJ8KMp5nPhtkFXfzR+Nc0/Fb4zrEULMnCw==
X-Received: by 2002:adf:d1c7:: with SMTP id b7mr27884811wrd.108.1628067872229; 
 Wed, 04 Aug 2021 02:04:32 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:fc63:9f41:3d77:1613?
 ([2a02:908:1252:fb60:fc63:9f41:3d77:1613])
 by smtp.gmail.com with ESMTPSA id w13sm2092216wru.72.2021.08.04.02.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 02:04:31 -0700 (PDT)
Subject: Re: [PATCH v2] drm/amdgpu: fix fdinfo race with process exit
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210730021321.7953-1-Philip.Yang@amd.com>
 <00330732-4232-3d3e-e271-47df226514ad@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c24b471f-6b4b-8301-b7d6-bba69f6467ab@gmail.com>
Date: Wed, 4 Aug 2021 11:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <00330732-4232-3d3e-e271-47df226514ad@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sorry I'm on vacation and can't reply immediately.

This is the wrong approach. The fdinfo should have grabbed a reference 
to the fd it prints the info for.

So we should never race here. Can you double check how this happens?

Thanks,
Christian.

Am 03.08.21 um 16:06 schrieb philip yang:
>
> ping?
>
> On 2021-07-29 10:13 p.m., Philip Yang wrote:
>> Get process vm root BO ref in case process is exiting and root BO is
>> freed, to avoid NULL pointer dereference backtrace:
>>
>> BUG: unable to handle kernel NULL pointer dereference at
>> 0000000000000000
>> Call Trace:
>> amdgpu_show_fdinfo+0xfe/0x2a0 [amdgpu]
>> seq_show+0x12c/0x180
>> seq_read+0x153/0x410
>> vfs_read+0x91/0x140[ 3427.206183]  ksys_read+0x4f/0xb0
>> do_syscall_64+0x5b/0x1a0
>> entry_SYSCALL_64_after_hwframe+0x65/0xca
>>
>> v2: rebase to staging
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> index d94c5419ec25..5a6857c44bb6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>> @@ -59,6 +59,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>>   	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
>>   	struct drm_file *file = f->private_data;
>>   	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
>> +	struct amdgpu_bo *root;
>>   	int ret;
>>   
>>   	ret = amdgpu_file_to_fpriv(f, &fpriv);
>> @@ -69,13 +70,19 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>>   	dev = PCI_SLOT(adev->pdev->devfn);
>>   	fn = PCI_FUNC(adev->pdev->devfn);
>>   
>> -	ret = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
>> +	root = amdgpu_bo_ref(fpriv->vm.root.bo);
>> +	if (!root)
>> +		return;
>> +
>> +	ret = amdgpu_bo_reserve(root, false);
>>   	if (ret) {
>>   		DRM_ERROR("Fail to reserve bo\n");
>>   		return;
>>   	}
>>   	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);
>> -	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>> +	amdgpu_bo_unreserve(root);
>> +	amdgpu_bo_unref(&root);
>> +
>>   	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
>>   			dev, fn, fpriv->vm.pasid);
>>   	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);

