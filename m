Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AFCC6FA86
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 07:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CAD910E62E;
	Tue, 13 Sep 2022 07:26:06 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB9010E620
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 07:26:03 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id l14so25403457eja.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=jG3YgquVUdv0Biqm4Q3yGRD6dMYiifQ3NcNd0zxwoY4=;
 b=mMqOjyaQWYY+waTAoxCdSqiL0I2vXJvNrU0mRKdJYWyNHA1DGSSYVKDXq3PiVkdrFD
 g5JMjjTBW2nbRvB+bwFpp/a31w4IZ+UY+Qv1VEJ2xz1s1z5sOjuLVT6ZxiRz0SkXLznY
 5vOIf5Gjtaobmq/1ULOKMPc0y7Ic1Lbh/k9fQL4f/CL5GG34fEWvsnuUuB5tygPpNMzO
 E4RaSNg7aQp748judRVb1i+M4vFLVsvGqP6EBhwZy9xBf87l9obZkvs/M6wKurO4aR2j
 9ilMXmAtSg489WuIVtVTDL3DS5Ek/SydHMIEFUD6T9VdBsXuM+6HX2iHY74jQEMbYQpj
 hLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=jG3YgquVUdv0Biqm4Q3yGRD6dMYiifQ3NcNd0zxwoY4=;
 b=A1Mjp8MUoWCy4bduCJnVoNvaIPw79w9FPEQzcEMKxsJ97tshJFRiX1d+8k0YyoXzLK
 insgzyMzpwIzX/Oafhw94jFJzCEYWmmCuy+57Q7iTCh9eJoDHpHeOztCm/9NsHrUAw1P
 rzsK24isryAPNkBEvdGYcKJ8yqUTQgrrfXJOy+pU96wuzfj2Kxy7m0eyE+Z8tKqydiwH
 dKbKFBqjjO5bm9oiQIhwfAKDMr8VWAeSZyNWbV8WgVV6kXce5Un/rsfdVoYaslJNeguT
 Q2zL2M6wwInDb/Uwograb2wRDu5ihWvTBZDCpifDgTwDWp4gvk26sTiHl2a6ErKxcg0c
 8wCA==
X-Gm-Message-State: ACgBeo3JjD6D+e6ryWPbf9B6JLP++ADcFxqI4pA/lDoLrS90Jd/QYG60
 NWwUeF4jC9Uu9QHj67q5K2wtn7m1svw=
X-Google-Smtp-Source: AA6agR6lu0e7PpEOocqftoYLP/ET75PUauzf/FMM2m+3N16j8Cj6CnVwSE5mMiKmd9jCpUj+haAxAg==
X-Received: by 2002:a17:907:9729:b0:77c:3742:137a with SMTP id
 jg41-20020a170907972900b0077c3742137amr7783128ejc.630.1663053961702; 
 Tue, 13 Sep 2022 00:26:01 -0700 (PDT)
Received: from [192.168.178.21] (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056402170700b0044e7f40c48esm7279908edu.62.2022.09.13.00.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Sep 2022 00:26:01 -0700 (PDT)
Message-ID: <8b6c51f4-9e1a-2e02-2c93-00b80bccdc07@gmail.com>
Date: Tue, 13 Sep 2022 09:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <75db4358-feda-0a0e-415a-ad5edfd4bb89@amd.com>
 <a2482795-4be3-1055-e81b-aa0c8d985e4e@gmail.com>
 <88534536-4707-32da-5af7-04668b8cb4a8@amd.com>
 <7dbb161a-ab79-f694-9eb2-b932ff419fa7@gmail.com>
 <42b819a4-f6aa-074a-1c81-134e00a60841@amd.com>
 <7fdb53b5-cb21-358d-f582-756803d87aa1@gmail.com>
 <53807f46-1f71-8699-a4ea-3a65afe386ec@amd.com>
 <DS7PR12MB63330F119F240F3F62551174F4479@DS7PR12MB6333.namprd12.prod.outlook.com>
 <75d18161-e535-e35e-2fe5-693846e98b79@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <75d18161-e535-e35e-2fe5-693846e98b79@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.09.22 um 04:00 schrieb Andrey Grodzovsky:
>
> [SNIP]
>
> You are right for scheduler mediated submissions (executing through 
> drm_sched_backend_ops.run_job hook) , I am talking about direct 
> submissions without gpu scheduler (using amdgpu_job_submit_direct)
>
> Andrey

Direct submission is only used while initially testing the hardware, 
during a GPU reset/recovery or for handling page faults with the SDMA.

In other words when we know that we have exclusive access to the hardware.

Christian.
