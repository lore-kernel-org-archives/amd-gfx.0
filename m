Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC191C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 15:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730EF6E170;
	Tue, 23 Nov 2021 15:51:51 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791EE6E048
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 06:02:38 +0000 (UTC)
Received: from [192.168.1.18] ([86.243.171.122]) by smtp.orange.fr with ESMTPA
 id pOswmPY11soWhpOswmyxXs; Tue, 23 Nov 2021 07:02:35 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 23 Nov 2021 07:02:35 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH 2/2] drm/amdkfd: Slighly optimize 'init_doorbell_bitmap()'
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
References: <2343a4e6547a8436419308744ba8c433088922a5.1637516393.git.christophe.jaillet@wanadoo.fr>
 <3e54737649cf94daabaa5b51db9f4c21d43124fe.1637516393.git.christophe.jaillet@wanadoo.fr>
 <283c0b53-ff4e-85f8-4738-2d477365f458@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <306b774e-6ee7-c976-a303-f566f7ba626c@wanadoo.fr>
Date: Tue, 23 Nov 2021 07:02:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <283c0b53-ff4e-85f8-4738-2d477365f458@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Nov 2021 15:51:50 +0000
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
Cc: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Le 22/11/2021 à 22:44, Felix Kuehling a écrit :
> Am 2021-11-21 um 12:41 p.m. schrieb Christophe JAILLET:
>> The 'doorbell_bitmap' bitmap has just been allocated. So we can use the
>> non-atomic '__set_bit()' function to save a few cycles as no concurrent
>> access can happen.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thank you for the patches. I think the same sort of change (at least the
> allocation/freeing part) could be applied to the queue_slot_bitmap in
> kfd_process_queue_manager.c. Would you like to submit another revision
> of this patch series that handles that as well?

I'll send a v2 which will fix the missing ',' spotted by the kernel test 
robot and include kfd_process_queue_manager.c.

All my patches are compile tested (otherwise it is said bellow the ---). 
Looks like I missed this one :(.

CJ

> 
> Either way, this series is
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> 
>> ---
>> bitmap_set() could certainly also be use, but range checking would be
>> tricky.
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 172ee8763523..2e9d341062c4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1447,9 +1447,9 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
>>   
>>   	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
>>   		if (i >= range_start && i <= range_end) {
>> -			set_bit(i, qpd->doorbell_bitmap);
>> -			set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
>> -				qpd->doorbell_bitmap);
>> +			__set_bit(i, qpd->doorbell_bitmap);
>> +			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
>> +				  qpd->doorbell_bitmap);
>>   		}
>>   	}
>>   
> 

