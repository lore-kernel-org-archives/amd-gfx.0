Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9BDCD11DB
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 08:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44EB10EDC2;
	Tue, 26 Mar 2024 08:18:39 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
 by gabe.freedesktop.org (Postfix) with SMTP id B90C810ECDA;
 Tue, 26 Mar 2024 05:41:30 +0000 (UTC)
Received: from [172.30.11.106] (unknown [180.167.10.98])
 by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id B8C3C6075D669; 
 Tue, 26 Mar 2024 13:41:25 +0800 (CST)
Message-ID: <0e719692-a166-1f56-4226-e71f7503aa94@nfschina.com>
Date: Tue, 26 Mar 2024 13:41:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdkfd: return negative error code in svm_ioctl()
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Felix.Kuehling@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: Philip.Yang@amd.com, alex.sierra@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <b4af9fda-8685-d486-95aa-ca46c11a2cc5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Mar 2024 08:18:33 +0000
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

On 2024/3/25 22:09, Philip Yang wrote:
>
>
> On 2024-03-25 02:31, Su Hui wrote:
>
> Good catch, ioctl should return -errno. I will apply it to drm-next.
>
> Reviewed-by: Philip Yang<philip.yang@amd.com>
>
>> ---
>> Ps: When I try to compile this file, there is a error :
>> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:28:10: fatal error: amdgpu_sync.h:
>> No such file or directory.
>>
>> Maybe there are some steps I missed or this place need to be corrected?
>
> Don't know how you compile the driver, amdgpu_sync.h is located under 
> amdgpu folder, amdkfd/Makefile is included from amdgpu/Makefile, which 
> set ccflag-y -I correctly.
>
Got it,  I should using 'make 
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.o'
rather than 'make drivers/gpu/drm/amd/amdkfd/kfd_migrate.o'.

Thanks a lot!

Regards,
Su Hui
