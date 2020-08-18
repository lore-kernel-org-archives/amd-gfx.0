Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA20C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 08:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E99206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 08:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="17vXr/5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E99206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C26899F0;
	Tue, 18 Aug 2020 08:18:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D778D899F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 08:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADHGcXwTQd1aSHsWatjqClJEl/QJ+DTMbzD5ZgRSrW4nqQtdxhl64beLXsH1fePhHpt7KEN74t0nzSfVg4POCSh0JoulR+/p/oTHzEW5VTgP+b0J93ZNrBpbxVqHm0WHFDYcGxdIpegGFkXUwsV4EKfB5N5vrOcAE/nbHUCtxUjQxwNBXYu/Nc9pwVmswNDnwabYg7iMH8eV5ApB9S7FPiRuNgKR8Ro3B5mZ7yPqOjcGawAKsJ3huWXBjWzRVrkUpCSAIowGqN2aE6qiMmXoQ9lxEMxlpxfIAKvn/C1c5/F3jivDXq4wkUugf5gQFLtr5cVUEfKvKx1I0WjtNF4T/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/VgvMsefszsO0mNgpeedV7P0neXFhG/YF9XfeukO6E=;
 b=VMDBelEl2l+kJ/PSNQcqRPcsQANK9H5+Thw3uXFDFjmgfH9pBfM+syza6qjoKqHJvON4KHFKbawqDxMfcNoFgt9MmUNpMggyyc+o2obvCmNBr8ngLy29Lh/hArfya8ZHWDTK7nBgdqkcNlRgU62gkn8ltEEiu/WdRbqbQEYa2XD+ZNDZPa9UV3Vr1slozI/6ccr4hza3ELe0mCSD0lUjlsxjJNfBzDjm4gxaXD4Q4nHCjV8bo7uFHih1ShmRzjNdOucVtZ028pOlapbt0EeIe3xs0ru+Wr6Li5lD/Xu+uZah3JNjTXbC5r7qDrvuXrcgm0GNcabZIh4YCJArfNYoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/VgvMsefszsO0mNgpeedV7P0neXFhG/YF9XfeukO6E=;
 b=17vXr/5exL/FD7qSvFCs7sxLXEJsMO6oatFzclWK7q/yJ+AtaCHB69pYbKfMwqM6fOqBdIN0u2LaT6bGCO8S9kv87XAquUdc0bdtAnj9nunOze86mitR56NvpAN2ulFhfTg4yfvvLBIV87WOyuBfJvoigXwxAuw3jECG0JuUbBc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3354.namprd12.prod.outlook.com (2603:10b6:5:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 08:18:28 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 08:18:28 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix repeatly flr issue
To: "Deng, Emily" <Emily.Deng@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200812091943.438905-1-Emily.Deng@amd.com>
 <71d5893c-453f-7c3e-7a20-e1234920dbba@amd.com>
 <BY5PR12MB411548B0210D9C173431A7A78F5C0@BY5PR12MB4115.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <25565c81-f902-7e1a-7282-e9ef4e34e6ba@amd.com>
Date: Tue, 18 Aug 2020 10:22:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BY5PR12MB411548B0210D9C173431A7A78F5C0@BY5PR12MB4115.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69]
 (2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69) by
 AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Tue, 18 Aug 2020 08:18:27 +0000
X-Originating-IP: [2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 416da6b9-06f4-4af2-8e06-08d8434f4944
X-MS-TrafficTypeDiagnostic: DM6PR12MB3354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB335477479BD674C8EB2CF5688B5C0@DM6PR12MB3354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+cUZzNNo010VxvIlR8kTTfyiiKEC7JgwU5XJ0FmTs+4B/fYIuPetGca/mWTD72bU5BXsd8vcAMs54f94I4P0UW/spQqJMd38Ajj10Em0uJ64CXaPOPbmPqZJYMAGW3QFtI5BCZso6tadRqQ57nQhw66GlYpniS3B96jw8LLXhwE+jj9s5V5vI/xil3zF2QwdcHKjaD4qHGyKtUd7edCVFGszEiulL8e/gNqtbVnn2FrnrcfDdcjXZB6lvou7gDTL4iaK65vusypcfzJS1qPwpTp2Y4VXKISUu0yL8O+XjrgOMBTFvjiNA5XM7d2ggxi0hh98SUy4ZB3ByhrJsheC6MljAGh13C4XUXV4Sbku4ZubV79s2/1KdXXC+dTqkHZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(478600001)(316002)(6486002)(8936002)(6666004)(5660300002)(31686004)(66556008)(66476007)(66946007)(8676002)(2906002)(52116002)(83380400001)(53546011)(36756003)(16526019)(186003)(110136005)(31696002)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ygU/kqZyUHCDuCyH2ynNXr6QFTjsBq0mdd0KX2j2KBOenIFkq54G5dNdCX7P4J4//KB2TSDxSma10fNWiw5yM4Rnlhig6cs6BPF+iWqLPPqpn157IJpa5dG8opzVkya18vLdl5Nod89SpeyQOlk3ERnRRsuxEb3mxKNCu6GzejyltzJPJKtSnO396bKEFAmeoPNx/0uBYhsVW6nEPQm4t45yvxtDGSGIGzyd/m8PZTwtJyEw1JgryCPDhIt/RamTw7+44F3/3A7Xub0+l48Kf1E1nkcNFYejqHynjBNLGf9bdt7AmeUdLradx1ddXCpBMzV3tHZ1/2W076R2lupwwp0pxSpIfPkvR5y36LvcYW5eusWtP25NhsPG/20mZ7kGdeBpf77k2rcxXpf11ChFL2iZ0m197N8+RqZmV4+IUbd9jtf5wgealfB8xe+4rkbh76DUsUpOeITOpbTvWzhmodXuaC+IFuyhSML/7hAclcg+sCGt9m3h464oly8E+Z7ZSL2CNqctQ8y3ifXD4FV6VVzxFlQvoBw6gjnzVmivofMTyecHCCPx/pXhcjX/tmd7I6/H25kox5Ch3AymkibtYIj5tPz7semXS8ywhXwUwl195VsnIwRM+EvPQt1xlXSUnzhz8kN1xvdnswQyzGI0TlnViujQn7WUmX1FdcUOuCQh3TZXIzRYgEAk2nUZsf2JM58N8eB48Y8SFR3boPk9Bw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416da6b9-06f4-4af2-8e06-08d8434f4944
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 08:18:28.4901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jozuZPrXFg3EzEW98CNdGPDrgwIelaRhhwTaRk5C+Xj8AhvHO5LVwLpB/+B5iOBgCpuhsDvuC7hRwiW2PuQ8zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3354
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/18/20 4:48 AM, Deng, Emily wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
>> -----Original Message-----
>> From: Das, Nirmoy <Nirmoy.Das@amd.com>
>> Sent: Wednesday, August 12, 2020 8:18 PM
>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: Fix repeatly flr issue
>>
>>
>> On 8/12/20 11:19 AM, Emily.Deng wrote:
>>> From: jqdeng <Emily.Deng@amd.com>
>>>
>>> Only for no job running test case need to do recover in flr
>>> notification.
>>> For having job in mirror list, then let guest driver to hit job
>>> timeout, and then do recover.
>>>
>>> Signed-off-by: jqdeng <Emily.Deng@amd.com>
>>> Change-Id: Ic6234fce46fa1655ba81c4149235eeac75e75868
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 20 +++++++++++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 22 ++++++++++++++++++++-
>> -
>>>    2 files changed, 39 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> index fe31cbeccfe9..12fe5164aaf3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> @@ -238,6 +238,9 @@ static void xgpu_ai_mailbox_flr_work(struct
>> work_struct *work)
>>>    struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt,
>> flr_work);
>>>    struct amdgpu_device *adev = container_of(virt, struct
>> amdgpu_device, virt);
>>>    int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>> +int i;
>>> +bool need_do_recover = true;
>>
>> We should find a better name for "need_do_recover", may be
>> "need_to_recover" ?
> Thanks, will modify later.
>>
>>> +struct drm_sched_job *job;
>>>
>>>    /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>>>     * otherwise the mailbox msg will be ruined/reseted by
>>> @@ -258,10 +261,25 @@ static void xgpu_ai_mailbox_flr_work(struct
>> work_struct *work)
>>>    flr_done:
>>>    up_read(&adev->reset_sem);
>>> +for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>> +struct amdgpu_ring *ring = adev->rings[i];
>>> +
>>> +if (!ring || !ring->sched.thread)
>>> +continue;
>>> +
>>> +spin_lock(&ring->sched.job_list_lock);
>>> +job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
>>> +struct drm_sched_job, node);
>>> +spin_unlock(&ring->sched.job_list_lock);
>>> +if (job) {
>>> +need_do_recover = false;
>>> +break;
>>> +}
>>> +}
>>
>> This 1st job retrieval logic can move to a function as there are two
>> instance of it.
>> Sorry, I didn't get your point.


xgpu_ai_mailbox_flr_work() and xgpu_nv_mailbox_flr_work() are using same logic under
"flr_done:"  label trying to retrieve 1st job entry to determine if we should do recover or not.

We could move that logic into a function like:


bool function_name ()
{
	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
		struct amdgpu_ring *ring = adev->rings[i];

		if (!ring || !ring->sched.thread)
			continue;

		spin_lock(&ring->sched.job_list_lock);
		job = list_first_entry_or_null(&ring->sched.ring_mirror_list, struct drm_sched_job, node);
		spin_unlock(&ring->sched.job_list_lock);
		if (job)
			return true;
			
	}

	return false;
}

and use that in xgpu_ai_mailbox_flr_work() and 
xgpu_nv_mailbox_flr_work() instead of

having two copy of that logic.



Nirmoy

>>
>>>    /* Trigger recovery for world switch failure if no TDR */
>>>    if (amdgpu_device_should_recover_gpu(adev)
>>> -&& adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)
>>> +&& (need_do_recover || adev->sdma_timeout ==
>> MAX_SCHEDULE_TIMEOUT))
>>>    amdgpu_device_gpu_recover(adev, NULL);
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>> index 6f55172e8337..fc92c494df0b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>> @@ -259,6 +259,9 @@ static void xgpu_nv_mailbox_flr_work(struct
>> work_struct *work)
>>>    struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt,
>> flr_work);
>>>    struct amdgpu_device *adev = container_of(virt, struct
>> amdgpu_device, virt);
>>>    int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>> +int i;
>>> +bool need_do_recover = true;
>>> +struct drm_sched_job *job;
>>>
>>>    /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>>>     * otherwise the mailbox msg will be ruined/reseted by
>>> @@ -279,10 +282,25 @@ static void xgpu_nv_mailbox_flr_work(struct
>> work_struct *work)
>>>    flr_done:
>>>    up_read(&adev->reset_sem);
>>> +for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>> +struct amdgpu_ring *ring = adev->rings[i];
>>> +
>>> +if (!ring || !ring->sched.thread)
>>> +continue;
>>> +
>>> +spin_lock(&ring->sched.job_list_lock);
>>> +job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
>>> +struct drm_sched_job, node);
>>> +spin_unlock(&ring->sched.job_list_lock);
>>> +if (job) {
>>> +need_do_recover = false;
>>> +break;
>>> +}
>>> +}
>>>
>>>    /* Trigger recovery for world switch failure if no TDR */
>>> -if (amdgpu_device_should_recover_gpu(adev)
>>> -&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>>> +if (amdgpu_device_should_recover_gpu(adev) && (need_do_recover
>> ||
>>> +adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>    adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>    adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>    adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
