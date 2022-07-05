Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F78C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 21:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB333112426;
	Tue,  5 Jul 2022 21:20:55 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53026112426
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 21:20:55 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LcwZZ73jlz9sq8;
 Tue,  5 Jul 2022 21:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1657056055; bh=OG8V2dW+XxpZ8YZLDDgqUwyXNpX7We7G4XqK23oWv7c=;
 h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
 b=H/Rk4uWwgqVBB5kLryfSfmpDdCCz0JOi5kQLbpeldJ1m/RqPBWv47P0mMETwljED+
 T7kP06YpQA0wLSGQtZ5HP0cTVEfWuXEScoIgeA6/q24qad1U/0NB0PLpUoCsWxvlz6
 lfDanp49FeAqzNw008PVxdqOr5ecRcbTisBRF6g4=
X-Riseup-User-ID: 7B11962366C062FCB633D4503112AFD8CD423CA6A22A14E2061299F7F7BA261E
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LcwZY5Hjcz5vw3;
 Tue,  5 Jul 2022 21:20:53 +0000 (UTC)
Message-ID: <980d8e21-4bbf-a7f5-e93c-ec0e326b871a@riseup.net>
Date: Tue, 5 Jul 2022 18:20:49 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Content-Language: en-US
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20220629170419.364255-1-Ramesh.Errabolu@amd.com>
 <cff8f7f0-bcda-b804-0737-411c71ec9b77@riseup.net>
 <SN1PR12MB25751134F0CE41B60779DE26E3819@SN1PR12MB2575.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <SN1PR12MB25751134F0CE41B60779DE26E3819@SN1PR12MB2575.namprd12.prod.outlook.com>
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
Cc: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 7/5/22 15:43, Errabolu, Ramesh wrote:
> [AMD Official Use Only - General]
> 
> Maira,
> 
> Thanks for taking time to review. I understand the request to tag the patch as version 2. However I don't follow your comments on "Fixes" block. Looking at the git log of the branch I see many "Fixes" block that precede the "Signed-off-by" statement.
> 

Hi Ramesh,

The canonical patch format is basically, as described by [1]:

<commit message>
...
Signed-off-by: Author <author@mail>
---
V2 -> V3: Removed redundant helper function
V1 -> V2: Cleaned up coding style and addressed review comments

path/to/file | 5+++--
...

So, on your case, we have the commit message describing the warning
reported by Smatch and the error log, then we got the tags. The tags
should be in chronological order, so your tags should be:

Fixes: 40d6aa758b13 ("drm/amdkfd: Extend KFD device topology to surface
peer-to-peer links")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

See that this canonical format reflects the chronological history of the
patch insofar as possible. After the ---, you describe the changes
between v1 and v2 in a small changelog.

The documentation linked in [1] explains this in details. So, some
examples are exposed in [2], [3] and [4].

[1] https://docs.kernel.org/process/submitting-patches.html
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1db88c5343712e411a2dd45375f27c477e33dc07
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34ad61514c4c3657df21a058f9961c3bb2f84ff2
[4]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3f2a14b8906df913cb04a706367b012db94a6e8

Best Regards,
- Maíra Canal

> Could you provide an example.
> 
> Regards,
> Ramesh
> 
> -----Original Message-----
> From: Maíra Canal <mairacanal@riseup.net> 
> Sent: Wednesday, June 29, 2022 6:25 PM
> To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; amd-gfx@lists.freedesktop.org; dan.carpenter@oracle.com
> Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
> 
> [CAUTION: External Email]
> 
> Hi Ramesh,
> 
> On 6/29/22 14:04, Ramesh Errabolu wrote:
>> The patch fixes couple of warnings, as reported by Smatch a static 
>> analyzer.
>>
>> Fixes: 40d6aa758b13 ("drm/amdkfd: Extend KFD device topology to 
>> surface peer-to-peer links")>
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_create_indirect_link_prop() warn: iterator used outside loop: 'cpu_link'
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1462 
>> kfd_create_indirect_link_prop() error: we previously assumed 'cpu_dev' 
>> could be null (see line 1420)
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1516 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'
>>
> 
> Usually, the Fixes tag would go here, after the commit message.
> 
>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
> 
> As this is a v2 PATCH, it would be nice to have a small changelog here, describing what has changed between the v1 and v2 versions of the patch.
> Also, you can mark the patch as v2 with git send-email by adding the flag -v2. More on the canonical patch format can be seen in [1].
> 
> [1]
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.kernel.org%2Fprocess%2Fsubmitting-patches.html%23the-canonical-patch-format&amp;data=05%7C01%7CRamesh.Errabolu%40amd.com%7Cc54753a9471843cc9d1f08da5a26898d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637921418813227961%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=PAc5A8z2EvJAOUiY378K9XyVBCKewQNsSNCr9pB3Ias%3D&amp;reserved=0
> 
> Best Regards,
> - Maíra Canal
> 
>>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 34 
>> +++++++++++------------
>>  1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 25990bec600d..ca4825e555b7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -1417,15 +1417,15 @@ static int 
>> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>
>>               /* find CPU <-->  CPU links */
>>               cpu_dev = kfd_topology_device_by_proximity_domain(i);
>> -             if (cpu_dev) {
>> -                     list_for_each_entry(cpu_link,
>> -                                     &cpu_dev->io_link_props, list) {
>> -                             if (cpu_link->node_to == gpu_link->node_to)
>> -                                     break;
>> -                     }
>> -             }
>> +             if (!cpu_dev)
>> +                     continue;
>> +
>> +             list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
>> +                     if (cpu_link->node_to == gpu_link->node_to)
>> +                             break;
>>
>> -             if (cpu_link->node_to != gpu_link->node_to)
>> +             /* Ensures we didn't exit from list search with no hits */
>> +             if (list_entry_is_head(cpu_link, 
>> + &cpu_dev->io_link_props, list))
>>                       return -ENOMEM;
>>
>>               /* CPU <--> CPU <--> GPU, GPU node*/ @@ -1510,16 
>> +1510,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>>               cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
>>               if (cpu_dev) {
>>                       list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
>> -                             if (iolink3->node_to == iolink2->node_to)
>> +                             if (iolink3->node_to == iolink2->node_to) {
>> +                                     props->weight += iolink3->weight;
>> +                                     props->min_latency += iolink3->min_latency;
>> +                                     props->max_latency += iolink3->max_latency;
>> +                                     props->min_bandwidth = min(props->min_bandwidth,
>> +                                                                     iolink3->min_bandwidth);
>> +                                     props->max_bandwidth = min(props->max_bandwidth,
>> +                                                                     
>> + iolink3->max_bandwidth);
>>                                       break;
>> -
>> -                     props->weight += iolink3->weight;
>> -                     props->min_latency += iolink3->min_latency;
>> -                     props->max_latency += iolink3->max_latency;
>> -                     props->min_bandwidth = min(props->min_bandwidth,
>> -                                                     iolink3->min_bandwidth);
>> -                     props->max_bandwidth = min(props->max_bandwidth,
>> -                                                     iolink3->max_bandwidth);
>> +                             }
>>               } else {
>>                       WARN(1, "CPU node not found");
>>               }
