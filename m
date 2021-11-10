Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC5AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 04:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97F861175
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 04:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A97F861175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195CC6FD3A;
	Wed, 10 Nov 2021 04:17:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B9C6FD3A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 04:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb1F2BlwhO2JzPsIVp7bh2jzY246cMBbASm4r/7RSX47PPbr1qenoHXyNCzJ1pioJqejLgqxN3UyuAVMwnJBpSTa6pw0skCBw5D7UEXglxQ4G47VUjBuopHgjo0oJnAp2Xd1G5jGFSFc8zTbSjHDIQashryjEDy0KidHFXifP9CMIukgU1DGu4bdCLGfJrZKPWReuaHPUTq48WvoM79VDx7sL/VdSH5C5XqWBCxde8BcPm0suTFp0T4mtvqS42tCyBu8oreiwVKTEgILhxzN4WYSS2JrDSXg0BL0OjmWBUkoHn1k2gWWXr5XpT9C3m0TNJAWiR9bRqHBsEt2kqjI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZU1Uy1EWWdt3fTfzIZXnNNdpmrL3GgTFfK1dFJBT5Y=;
 b=Slaqyf7B/6cD7yz5081zCxQNl4Wrn/2k4PD0Jhe82FeHZHI6ls3YwbWZ7gmmg7eCVcbDiut3MroxOfytLoagF90njNcVb/81Mi1mFJ7WA7NbI27DhwN7BXfUga3sPOvLFw762nMtknE9HJpOo28QjIBqof0WIJMM5GrfrG4YTVe/uRcpWwhCzJundZxzcj+Ec++kc3B9EqCfEPfW/eePXf7NR27vI8TDobFM77VZSTz7CfSXlR37SrItXD+BS7LSsOblZWiMX7SC1hpm9Qea3K2FvpOrgHYMiP6QL9o4FFM6ht7KR89nTG3NPlZEA2HBiLvFJoI6zQAauaAiM7trMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZU1Uy1EWWdt3fTfzIZXnNNdpmrL3GgTFfK1dFJBT5Y=;
 b=ciJQYW7mHFTQ7EOIGwQAuQuulM+B6QOImdCnziAbsgWRb91CMCweAvDzpvj48/gdrtGjjH6YSVcSrrhp3JhV3iDcwtuRs8Q7pdDQSfen5/9karF+tK6KYDmXwkLeJGATM38Ecfntuyu65qx7P4PyOIzdyAxwkuo0ECZtuOB5H3E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 10 Nov
 2021 04:17:02 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 04:17:02 +0000
Subject: Re: [PATCH 4/5] drm/amdkfd: restore pages race with process
 termination
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <20211109230432.3947-4-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <d27056e0-c563-ced9-326d-b1b35237e77c@amd.com>
Date: Tue, 9 Nov 2021 23:16:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109230432.3947-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0489.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::14) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 LO2P265CA0489.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 04:17:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22e0e599-c0fd-4a22-4f68-08d9a400f25d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-Microsoft-Antispam-PRVS: <BL1PR12MB517304B3181C2F641968C87792939@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVCByKXEZvsuMdLzmOgHWRhm9UiLbSbcwwUPtVGthGSZzdY5z4ltYy0DOoS0yuAx9bCt3Ib4S7z61Ua8h+YMFHwxVxkVCpN2ouLUimpG3XcJ7Lk4wNQ2Y/QeHu2pZpzAf/XTPX6H/8uHATZu6BR4PNeEaTrqGFduRYmKlsDLDc7Gr9YhVMR0KyH8A5V2pHeviR2r4QOfhlDMl83Jp6nW8gJ9ZGndro+CS0yMalvEapMLz4b3y6eAs0Axba1hbpSb4BZdwzROYY+POjTn6LjW0KQSVHCLwP7fj1QZ79sBFVsuLkIfZVdMGdbsoJ6t1Wfqwx6XDiYlBtkPb99WX/8wWSymNcDH38dex7w5VPVKBXc3tUeZMkxVU0+/yCOZ+fM3G2At3saBeoEGB0JAdHU9lM02IRlSr1rBFag/rLS9vQovGFUU+1A5x6vFhcW9jfDq2FM4AT1on81FkNQcOs3RwVRfzUllVugABpz7Z5Jbe74kbY8wOnvvcC0kCiDrTPAJspUeinVWhPey5A0ANduAsu/QrehZLw+2DQq7x6fq4IDmJEPZSvdLz+RSrVwgKVVrNw1OxI8UDsFhiE5NhYp3/G3vZqeQXVaKCvzcliKeD9pqWri9HjyQc1iuXK+CIjN3vmTTzB1mYZZLBwdQaVSaPfOjAKmkpU4VaAzvgRBHzTBhXtaveTDRmoH1yb64ZMZiQM5GMFGHBSC+0+7Skv5ti4BtQoNTmq/KpnroCXcsELiuaczNKLVah4uyReBb8bYq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(26005)(8676002)(16576012)(66946007)(2616005)(316002)(66476007)(66556008)(956004)(38100700002)(83380400001)(8936002)(186003)(86362001)(5660300002)(6666004)(6486002)(31686004)(508600001)(53546011)(36756003)(44832011)(36916002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZiVFMyamRMQnRiWEZweXdabGhUdlVLS3NLZU01VnpzaXpJRUVhQVd6Skxq?=
 =?utf-8?B?YmpJMHVCVkdPTHJKWlRRNkNvZjVCaENFNnU4TzUya21Bb0QrWmNjMk9NS01x?=
 =?utf-8?B?d3luV1ByU2JOSVl5WDlsdTZRb3U5V0tKR3BEd3JmTktzSHo3RmNYcjZkL0Ez?=
 =?utf-8?B?dk5wc3VNOEUwVG5udHJHM0lGZlR0NTRlK0ZqYTdSbWo0Q1Z6eDA3QlA5Tk4w?=
 =?utf-8?B?My91YVdGaW50QThWZEU4dUFHTDV6bGgrU2NDSG55UVZTcE1GTnd2bE8rcTdS?=
 =?utf-8?B?c09URTVUeE1LVFMzdkM2bDRNQmlSV2toRG5EZmViaEVwdDRSQUNFSDlhZGMv?=
 =?utf-8?B?azd5RlBCZjRvRXhzOVI0M3VUbld5WkRJdURwa2ZvaStDWm1NcWg4eVdINVRW?=
 =?utf-8?B?ZzZsa2Vjb1pONHhvdmhsd25TeWFxb3ZuVk00cVQ2MTlkNGxrdGp0SVVneU85?=
 =?utf-8?B?cS9QOXQ5MVVBRUlYRWp3TjU0a3ZRdDFsLys5YnV0RlQ4SGhyTDg4OU5wZEdl?=
 =?utf-8?B?SXFrZ0FjTytjenN4NXROcklzNTh5dWJkbFZQeXFRUHRZTWEyTGxyb2tFdUFQ?=
 =?utf-8?B?c01QV05KNGtJNEJRUVBQYmVZNWZwUVBvSlhYTTlvZExGYUNLcVNxNldSWkdV?=
 =?utf-8?B?dFZ2TEFBa1NUUmsweTV4alc4L0pFVi83VFpQTHNBbkdZN2E3VHZiWnlzYmJR?=
 =?utf-8?B?SHcyZThDS2tGMjQ0UmV2YVpaZjNqVk9GR1FNdHZnbTg2RVRZZkxZQ0llcGpP?=
 =?utf-8?B?VzNiVFNIaUtlUjIwaDk4aURycGNEY1phbSt5dXhEcWdVemREcnZVeThRN1Zm?=
 =?utf-8?B?ZzZzb0ZYOERCS0gwdGlJdEVhYzA4TTFKamFpZCtkWUNpS3pXamxEeGxCZFdM?=
 =?utf-8?B?YkRQclFpNUlxcmNKbDFrUUk5dzdONlp1Ulp4V2lYUGg3WFQzVjBSYjBqYk9s?=
 =?utf-8?B?bG9CMUtSend3aGYvaWo1Q3JTUlN1MWZHS1k1cy9LOEtMdkJFZS9SS1M4cktw?=
 =?utf-8?B?Z29CamdOd0pzOGovY3VSWFJDMzU4MERpQVJQUkc4cnAwMi9ZNHVpZEJnOTRv?=
 =?utf-8?B?cmdTRDFZS1VGcnU0LzJHQVJHWE9GdHlvN3RlbU5KYlNzYmRvdUczMFRocUpa?=
 =?utf-8?B?bXNjQUxaL256RVIzU1hJUjZua1lPZWo2NzFGVlZDa0p3U3NjZE91WTdDTUxX?=
 =?utf-8?B?YURnZkZBUnpVZGZmWEtpQTlpNmFzUllvbks4S2NFVjJnbzMrNjRMeUZCVUQ0?=
 =?utf-8?B?RjcvaGpJbkhLMkxlZkdkOFUwaHAzcEpCYXQwd0Jid3hSUkplOTFZMzVGam9q?=
 =?utf-8?B?aTBPcG5uZHkvMTFVNXpPKzA0QVlqeEhFSlVoczhIWlZqWDB0SjRPOHFEdWdh?=
 =?utf-8?B?SGtHb2o3ODZJOXdSbWw0aFFZSVJpNHI5N1czNUx2QUFXeWRnTVFCK29SbHhy?=
 =?utf-8?B?SW5icUF0QWtEWnR3OCtjVmtsT0trUnNwUnlaTmpCZUJxZUpXTnc5RTVVcXZD?=
 =?utf-8?B?WkZ6NTZiNWZubmFkaUdxakFld0RyWWRNV2lLYmRJTWVYMFYxNGZZU1FEOVls?=
 =?utf-8?B?N2U2N2E0MTZ1RExNdUF4cXlPQ0E1SzVpbkR1czF0ZnhtUU5PeFNWV280bTNL?=
 =?utf-8?B?VUV3eEx2Q2NRWlVSL3ZxdzhEN0N4ZVlRQ3o2SVZ4TUlFdnJENWwzQlVzTU5p?=
 =?utf-8?B?WWs2V3YxcjBqbldQQ1dNUHIyTTV2cWxzVVhpYnRLL0drMml0RlNZeVdxS2wr?=
 =?utf-8?B?K2dzdWlmRlFobVRTM0tvL1lua1JQNHllNEJGZldJRlRCZDJYb2ZuQkhGbjVn?=
 =?utf-8?B?S3BxM0hVWis4L0p2OGdvUFRqVXAyYVlyZytlNnRyTEVLODNkKzBPcVBORDhv?=
 =?utf-8?B?Z3NZakExZDFCVGg5TFN1RitGU2huSVEyZEpDa3RPait6cGFrcEtjREloLzl5?=
 =?utf-8?B?aUxaMm90dlJjS0J5dWp5czhSeithcS92aEFrMThkVDJTNGxxWG5zUlNRZi83?=
 =?utf-8?B?SFZKT0pnODFESHppY1g3bU51N1RqNHpXbUlDK3JJV0NJTUU2MU1uZTVjSlJB?=
 =?utf-8?B?Y1FDZWhkMGpoOERPYXZrb2Yxd2kyK2ZyQTdxMlRuYWVOQUdxVWlyWGhpV25W?=
 =?utf-8?B?NEIwMDJDaUUwbTRUby9jTjh0elNxeXlNakIzRDRiN3ovRlZWWktRUkZRczdl?=
 =?utf-8?Q?hlyuoJR5OrORKr1IJT5nwks=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e0e599-c0fd-4a22-4f68-08d9a400f25d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 04:17:02.3658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM11/aznPVnJ3Evfe7BE1HOJ4eZQIOPe7lQ5gsnQtYEUYzmFBwLHDGKODTr1jjhUXOgmhpGqw5aoqdIANA6yEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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

On 2021-11-09 6:04 p.m., Philip Yang wrote:
> restore pages work can not find kfd process or mm struct if process is
> destroyed before drain retry fault work schedule to run, this is not
> failure, return 0 to avoid dump GPU vm fault kernel log.
I wonder if this could also be solved by draining page fault interrupts 
in kfd_process_notifier_release before we remove the process from the 
hash table. Because that function runs while holding the mmap lock, we'd 
need to detect the draining condition for the process in the page fault 
handler before it tries to take the mmap lock. Maybe that's even a 
helpful optimization that speeds up interrupt draining by just ignoring 
all retry faults during that time.

That would also allow draining faults in svm_range_unmap_from_cpu 
instead of the delayed worker. And I believe that would also elegantly 
fix the vma removal race.

Regards,
   Felix


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 8f77d5746b2c..2083a10b35c2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2596,7 +2596,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	p = kfd_lookup_process_by_pasid(pasid);
>   	if (!p) {
>   		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
> -		return -ESRCH;
> +		return 0;
>   	}
>   	if (!p->xnack_enabled) {
>   		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
> @@ -2610,7 +2610,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mm = get_task_mm(p->lead_thread);
>   	if (!mm) {
>   		pr_debug("svms 0x%p failed to get mm\n", svms);
> -		r = -ESRCH;
> +		r = 0;
>   		goto out;
>   	}
>   
